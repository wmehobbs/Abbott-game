"""Dump Casual.glb structure. One-shot inspector."""
import json
import struct
import pathlib

p = pathlib.Path(__file__).resolve().parents[2] / "content" / "meshes" / "raw" / "quaternius_modular_casual" / "Casual.glb"
data = p.read_bytes()
length = struct.unpack_from("<I", data, 12)[0]
js = json.loads(data[20 : 20 + length])
print("meshes", len(js.get("meshes", [])))
for i, m in enumerate(js.get("meshes", [])):
    prims = m.get("primitives", [])
    mats = [pr.get("material") for pr in prims]
    print(" MESH", i, m.get("name"), "prims", len(prims), "mats", mats)
print("nodes", len(js.get("nodes", [])))
for i, n in enumerate(js.get("nodes", [])):
    bits = []
    if "mesh" in n:
        bits.append("mesh=%s" % n["mesh"])
    if "skin" in n:
        bits.append("skin=%s" % n["skin"])
    if "children" in n:
        bits.append("ch=%s" % n["children"])
    print("  %3d %s %s" % (i, n.get("name", ""), " ".join(bits)))
for s in js.get("skins", []):
    joints = s.get("joints", [])
    names = [js["nodes"][j].get("name") for j in joints]
    print("SKIN joints", len(joints))
    print(" ", " ".join(names))
print("anims", [a.get("name") for a in js.get("animations", [])])
for i, m in enumerate(js.get("materials", [])):
    print("MAT", i, m.get("name"), list(m.keys()))
# rest translations of bones
print("--- bone TRS ---")
for i, n in enumerate(js.get("nodes", [])):
    name = n.get("name", "")
    if any(k in name for k in ("Hip", "Torso", "Head", "Leg", "Foot", "Arm", "Hand", "Neck", "Spine", "Shoulder")):
        print(name, "t", n.get("translation"), "r", n.get("rotation"), "s", n.get("scale"))
