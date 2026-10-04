"""Convert raw CC0 harvest into Godot-ready 1024 jpg plates.

Output:
  game/assets/textures/harvest/<slug>_albedo.jpg
  game/assets/textures/harvest/<slug>_normal.jpg  (harvested or derived)
  game/assets/textures/harvest/<slug>_rough.jpg   (harvested or derived)
  game/assets/ATTRIBUTION_HARVEST.md
  tools/content_factory/HARVEST_CATALOG.json

Does not overwrite game/assets/textures/* existing files.
"""
from __future__ import annotations

import json
import sys
from datetime import date
from pathlib import Path

import numpy as np
from PIL import Image, ImageFilter

ROOT = Path(__file__).resolve().parents[2]
RAW = Path(__file__).resolve().parent / "raw_harvest"
OUT = ROOT / "game" / "assets" / "textures" / "harvest"
ATTR = ROOT / "game" / "assets" / "ATTRIBUTION_HARVEST.md"
CATALOG = Path(__file__).resolve().parent / "HARVEST_CATALOG.json"
SIZE = 1024
TODAY = date.today().isoformat()


def flatten_lighting(im: Image.Image, blur: float = 40.0) -> Image.Image:
    arr = np.asarray(im.convert("RGB"), dtype=np.float32) / 255.0
    blur_im = np.asarray(
        im.convert("RGB").filter(ImageFilter.GaussianBlur(blur)), dtype=np.float32
    ) / 255.0
    blur_im = np.clip(blur_im, 0.08, 1.0)
    mean = float(arr.mean())
    out = arr / blur_im * mean * 1.35
    out = np.clip(out, 0.0, 1.0)
    return Image.fromarray((out * 255).astype(np.uint8), "RGB")


def make_seamless(im: Image.Image, blend: int = 48) -> Image.Image:
    arr = np.asarray(im.convert("RGB"), dtype=np.float32)
    h, w, _ = arr.shape
    b = min(blend, w // 4, h // 4)
    out = arr.copy()
    for i in range(b):
        t = (i + 1) / (b + 1)
        out[:, i] = out[:, i] * t + out[:, w - b + i] * (1 - t)
        out[i, :] = out[i, :] * t + out[h - b + i] * (1 - t)
    out[:, :b] = (out[:, :b] + out[:, w - b :]) * 0.5
    out[:b, :] = (out[:b, :] + out[h - b :, :]) * 0.5
    out[:, w - b :] = out[:, :b]
    out[h - b :, :] = out[:b, :]
    return Image.fromarray(np.clip(out, 0, 255).astype(np.uint8), "RGB")


def to_normal(im: Image.Image, strength: float = 1.6) -> Image.Image:
    g = np.asarray(im.convert("L"), dtype=np.float32) / 255.0
    dy, dx = np.gradient(g)
    dx *= strength
    dy *= strength
    n = np.stack((-dx, -dy, np.ones_like(g)), axis=-1)
    n /= np.linalg.norm(n, axis=-1, keepdims=True) + 1e-8
    n = (n * 0.5 + 0.5) * 255.0
    return Image.fromarray(n.astype(np.uint8), "RGB")


def to_roughness(im: Image.Image, lo: float = 0.45, hi: float = 0.85) -> Image.Image:
    g = np.asarray(im.convert("L"), dtype=np.float32) / 255.0
    r = lo + (1.0 - g) * (hi - lo)
    r = np.clip(r, 0, 1)
    u8 = (r * 255).astype(np.uint8)
    return Image.fromarray(u8, "L")


def save_jpg(im: Image.Image, path: Path, quality: int = 92) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    im.convert("RGB").save(path, quality=quality, optimize=True)


def load_rgb(path: Path) -> Image.Image:
    im = Image.open(path)
    if im.mode == "L":
        im = im.convert("RGB")
    elif im.mode == "RGBA":
        bg = Image.new("RGB", im.size, (128, 128, 128))
        bg.paste(im, mask=im.split()[-1])
        im = bg
    else:
        im = im.convert("RGB")
    return im


def square_1024(im: Image.Image) -> Image.Image:
    im = im.convert("RGB")
    w, h = im.size
    side = min(w, h)
    left = (w - side) // 2
    top = (h - side) // 2
    im = im.crop((left, top, left + side, top + side))
    if side != SIZE:
        im = im.resize((SIZE, SIZE), Image.Resampling.LANCZOS)
    return im


def find_map(folder: Path, kind: str) -> Path | None:
    # Prefer files named by harvest.py
    hits = sorted(folder.glob(f"*_{kind}*.jpg")) + sorted(folder.glob(f"*_{kind}*.png"))
    hits = [p for p in hits if p.is_file()]
    if hits:
        # prefer nor_gl-style already in the name; harvest.py already chose gl
        return hits[0]
    return None


def convert_one(folder: Path) -> dict | None:
    src = folder / "source.json"
    if not src.exists():
        return None
    meta = json.loads(src.read_text(encoding="utf-8"))
    slug = meta.get("slug") or folder.name
    albedo_name = (meta.get("maps") or {}).get("albedo")
    albedo_path = folder / albedo_name if albedo_name else find_map(folder, "albedo")
    if albedo_path is None or not Path(albedo_path).exists():
        print(f"skip {slug}: no albedo")
        return None
    albedo = square_1024(load_rgb(Path(albedo_path)))
    # Ground/sand/grass benefit from flatten + seamless. Wood/bark/leather too.
    tags = set(meta.get("tags") or [])
    if tags & {"sand", "grass", "sod", "dirt", "duff", "gravel", "apron", "soil"}:
        albedo = flatten_lighting(albedo, blur=36.0)
        albedo = make_seamless(albedo, blend=56)
    elif tags & {"wood", "bark", "leather", "wool"}:
        albedo = make_seamless(albedo, blend=40)

    out_a = OUT / f"{slug}_albedo.jpg"
    save_jpg(albedo, out_a)

    normal_name = (meta.get("maps") or {}).get("normal")
    npath = folder / normal_name if normal_name else find_map(folder, "normal")
    harvested_n = False
    if npath and Path(npath).exists():
        normal = square_1024(load_rgb(Path(npath)))
        if tags & {"sand", "grass", "sod", "dirt", "duff", "gravel", "apron", "soil", "wood", "bark"}:
            normal = make_seamless(normal, blend=40)
        harvested_n = True
    else:
        normal = to_normal(albedo, strength=1.5)
    save_jpg(normal, OUT / f"{slug}_normal.jpg")

    rough_name = (meta.get("maps") or {}).get("rough")
    rpath = folder / rough_name if rough_name else find_map(folder, "rough")
    harvested_r = False
    if rpath and Path(rpath).exists():
        rough = square_1024(load_rgb(Path(rpath))).convert("L")
        harvested_r = True
    else:
        rough = to_roughness(albedo)
    save_jpg(rough.convert("RGB"), OUT / f"{slug}_rough.jpg")

    rel_a = f"game/assets/textures/harvest/{slug}_albedo.jpg"
    plate = {
        "slug": slug,
        "albedo": rel_a.replace("\\", "/"),
        "normal": f"game/assets/textures/harvest/{slug}_normal.jpg",
        "rough": f"game/assets/textures/harvest/{slug}_rough.jpg",
        "source": meta.get("source"),
        "source_id": meta.get("source_id"),
        "page": meta.get("page"),
        "author": meta.get("author"),
        "license": meta.get("license"),
        "license_url": meta.get("license_url"),
        "tags": meta.get("tags") or [],
        "use_for": meta.get("use_for") or "",
        "date_fetched": meta.get("date_fetched") or TODAY,
        "harvested_normal": harvested_n,
        "harvested_rough": harvested_r,
        "size": SIZE,
    }
    print(f"convert {slug} n={'src' if harvested_n else 'derived'} r={'src' if harvested_r else 'derived'}")
    return plate


def write_attribution(plates: list[dict]) -> None:
    lines = [
        "# Harvested texture attribution",
        "",
        "All plates below are CC0 1.0 (public domain dedication) from Poly Haven or ambientCG.",
        "Converted for Abbott / Hidden K. Do not overwrite `game/assets/textures/` originals.",
        "",
        "path | source URL | author | license | what we use it for | date fetched",
        "--- | --- | --- | --- | --- | ---",
    ]
    for p in sorted(plates, key=lambda x: x["slug"]):
        path = p["albedo"]
        url = p.get("page") or ""
        author = (p.get("author") or "").replace("|", "/")
        lic = p.get("license") or "CC0 1.0"
        use = p.get("use_for") or ", ".join(p.get("tags") or [])
        day = p.get("date_fetched") or TODAY
        lines.append(f"{path} | {url} | {author} | {lic} | {use} | {day}")
        # Count normal/rough as the same harvest row family; validator matches albedo rows to files.
        if p.get("harvested_normal"):
            lines.append(
                f"{p['normal']} | {url} | {author} | {lic} | {use} (normal) | {day}"
            )
        if p.get("harvested_rough"):
            lines.append(
                f"{p['rough']} | {url} | {author} | {lic} | {use} (rough) | {day}"
            )
    ATTR.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> int:
    OUT.mkdir(parents=True, exist_ok=True)
    if not RAW.exists():
        print("no raw_harvest; run harvest.py first")
        return 1
    plates: list[dict] = []
    for folder in sorted(RAW.iterdir()):
        if not folder.is_dir():
            continue
        plate = convert_one(folder)
        if plate:
            plates.append(plate)
    CATALOG.write_text(
        json.dumps(
            {
                "count": len(plates),
                "with_harvested_normal_rough": sum(
                    1 for p in plates if p["harvested_normal"] and p["harvested_rough"]
                ),
                "plates": plates,
            },
            indent=2,
        ),
        encoding="utf-8",
    )
    write_attribution(plates)
    n = len(plates)
    nr = sum(1 for p in plates if p["harvested_normal"] and p["harvested_rough"])
    print(f"converted {n} plates, {nr} with harvested normal+rough")
    print(f"attribution {ATTR}")
    print(f"catalog {CATALOG}")
    if n < 40:
        print(f"UNDER QUOTA: {n}/40 plates")
        return 1
    if nr < 25:
        print(f"UNDER QUOTA: {nr}/25 harvested normal+rough (derived still written)")
        # Derived maps still exist on disk so the game can use them; quota wants 25 real pairs.
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
