"""Inspect downloaded GLB/ZIP candidates: size, glTF stats, zip contents."""
from __future__ import annotations

import json
import struct
import zipfile
from pathlib import Path

RAW = Path(__file__).resolve().parents[2] / "content" / "meshes" / "raw"
OUT = RAW.parent / "_inspect.json"


def glb_info(path: Path) -> dict:
    data = path.read_bytes()
    if data[:4] != b"glTF":
        return {"error": "not glb", "magic": data[:8].hex()}
    version, length = struct.unpack_from("<II", data, 4)
    off = 12
    json_blob = None
    while off + 8 <= len(data):
        clen, ctype = struct.unpack_from("<I4s", data, off)
        chunk = data[off + 8 : off + 8 + clen]
        off += 8 + clen
        if ctype == b"JSON":
            json_blob = json.loads(chunk.decode("utf-8"))
            break
    if not json_blob:
        return {"error": "no json chunk", "version": version, "length": length}
    meshes = json_blob.get("meshes") or []
    nodes = json_blob.get("nodes") or []
    skins = json_blob.get("skins") or []
    anims = json_blob.get("animations") or []
    acc = json_blob.get("accessors") or []
    prims = 0
    for m in meshes:
        prims += len(m.get("primitives") or [])
    # rough vertex count from POSITION accessors
    verts = 0
    for a in acc:
        if a.get("type") == "VEC3" and (a.get("count") or 0) > verts:
            # not accurate total; sum POSITION
            pass
    pos_counts = []
    for m in meshes:
        for p in m.get("primitives") or []:
            attrs = p.get("attributes") or {}
            if "POSITION" in attrs:
                ai = attrs["POSITION"]
                if 0 <= ai < len(acc):
                    pos_counts.append(int(acc[ai].get("count") or 0))
    mins, maxs = [], []
    for a in acc:
        if a.get("type") == "VEC3" and a.get("min") and a.get("max"):
            mins.append(a["min"])
            maxs.append(a["max"])
    bbox = None
    if mins and maxs:
        lo = [min(m[i] for m in mins) for i in range(3)]
        hi = [max(m[i] for m in maxs) for i in range(3)]
        bbox = {"min": lo, "max": hi, "size": [hi[i] - lo[i] for i in range(3)]}
    return {
        "version": version,
        "bytes": length,
        "meshes": len(meshes),
        "primitives": prims,
        "nodes": len(nodes),
        "skins": len(skins),
        "animations": [a.get("name") for a in anims][:24],
        "anim_count": len(anims),
        "position_verts": sum(pos_counts),
        "bbox": bbox,
        "node_names": [n.get("name") for n in nodes if n.get("name")][:30],
        "mesh_names": [m.get("name") for m in meshes if m.get("name")][:20],
    }


def main() -> None:
    report = {}
    for folder in sorted(RAW.iterdir()):
        if not folder.is_dir():
            continue
        rec = {"files": []}
        for p in folder.iterdir():
            if p.suffix.lower() in {".glb", ".gltf"}:
                rec["glb"] = glb_info(p)
                rec["files"].append(p.name)
            elif p.suffix.lower() == ".zip":
                rec["files"].append(p.name)
                rec["zip"] = zipfile.ZipFile(p).namelist()[:40]
                rec["zip_n"] = len(zipfile.ZipFile(p).namelist())
                # extract small inspect list
                zdir = folder / "unzipped"
                if not zdir.exists():
                    zipfile.ZipFile(p).extractall(zdir)
                    print("unzipped", p)
        src = folder / "source.json"
        if src.exists():
            rec["source"] = json.loads(src.read_text(encoding="utf-8"))
        report[folder.name] = rec
        print(folder.name, json.dumps({k: rec.get(k) for k in ("glb", "zip_n")}, default=str)[:400])
    OUT.write_text(json.dumps(report, indent=2), encoding="utf-8")
    print("wrote", OUT)


if __name__ == "__main__":
    main()
