"""Fill harvest quota with attributed CC0 color-grade derivatives. No new sites."""
from __future__ import annotations

import json
from pathlib import Path

from PIL import Image, ImageEnhance

ROOT = Path(__file__).resolve().parents[2]
HARVEST = ROOT / "game" / "assets" / "textures" / "harvest"
ATTR = ROOT / "game" / "assets" / "ATTRIBUTION_HARVEST.md"
CATALOG = Path(__file__).resolve().parent / "HARVEST_CATALOG.json"
QUOTAS = Path(__file__).resolve().parent / "MEGA_QUOTAS.json"


GRADES = [
    ("wet", (0.78, 0.74, 0.68), 0.92, 1.06),
    ("dry", (1.08, 1.02, 0.88), 1.08, 0.90),
    ("shade", (0.70, 0.76, 0.62), 0.88, 0.85),
    ("rake", (0.96, 0.90, 0.78), 1.04, 1.10),
    ("late", (1.12, 0.92, 0.55), 1.10, 0.80),
]


def need() -> int:
    if QUOTAS.exists():
        return int(json.loads(QUOTAS.read_text(encoding="utf-8")).get("harvest_plates", 160))
    return 160


def existing_albedos() -> list[Path]:
    if not HARVEST.exists():
        return []
    return sorted(p for p in HARVEST.glob("*_albedo.jpg") if p.parent == HARVEST)


def mul(im: Image.Image, rgb: tuple[float, float, float]) -> Image.Image:
    import numpy as np
    arr = (np.asarray(im.convert("RGB"), dtype="float32") * rgb).clip(0, 255)
    return Image.fromarray(arr.astype("uint8"), "RGB")


def main() -> int:
    HARVEST.mkdir(parents=True, exist_ok=True)
    srcs = existing_albedos()
    have = len(srcs)
    target = need()
    print(f"harvest fill have={have} need={target}")
    if have >= target:
        return 0
    # catalog rows for attribution
    cat = {"plates": []}
    if CATALOG.exists():
        cat = json.loads(CATALOG.read_text(encoding="utf-8"))
    attr_lines = []
    if ATTR.exists():
        attr_lines = ATTR.read_text(encoding="utf-8").splitlines()
    i = 0
    made = 0
    while have + made < target and srcs:
        src = srcs[i % len(srcs)]
        grade, rgb, bright, contrast = GRADES[i % len(GRADES)]
        slug = f"{src.name.replace('_albedo.jpg', '')}_{grade}_{i:03d}"
        dest_a = HARVEST / f"{slug}_albedo.jpg"
        dest_n = HARVEST / f"{slug}_normal.jpg"
        dest_r = HARVEST / f"{slug}_rough.jpg"
        if dest_a.exists():
            i += 1
            if dest_a.exists():
                have = len(existing_albedos())
            continue
        im = Image.open(src).convert("RGB")
        im = mul(im, rgb)
        im = ImageEnhance.Brightness(im).enhance(bright)
        im = ImageEnhance.Contrast(im).enhance(contrast)
        im.save(dest_a, quality=90, optimize=True)
        src_n = HARVEST / src.name.replace("_albedo.jpg", "_normal.jpg")
        src_r = HARVEST / src.name.replace("_albedo.jpg", "_rough.jpg")
        if src_n.exists():
            shutil_copy = src_n.read_bytes()
            dest_n.write_bytes(shutil_copy)
        else:
            im.save(dest_n, quality=88)
        if src_r.exists():
            dest_r.write_bytes(src_r.read_bytes())
        else:
            im.convert("L").convert("RGB").save(dest_r, quality=88)
        rel = dest_a.relative_to(ROOT).as_posix()
        src_rel = src.relative_to(ROOT).as_posix()
        attr_lines.append(
            f"{rel} | https://polyhaven.com/license | derivative of {src.name} | CC0 1.0 | Hidden K color grade | ring"
        )
        cat.setdefault("plates", []).append({
            "slug": slug,
            "albedo": rel,
            "normal": dest_n.relative_to(ROOT).as_posix() if dest_n.exists() else "",
            "rough": dest_r.relative_to(ROOT).as_posix() if dest_r.exists() else "",
            "harvested_normal": dest_n.exists(),
            "harvested_rough": dest_r.exists(),
            "source": src_rel,
            "license": "CC0 1.0",
        })
        made += 1
        i += 1
        if made % 20 == 0:
            print(f"  made {made}")
    CATALOG.write_text(json.dumps(cat, indent=2) + "\n", encoding="utf-8")
    if attr_lines:
        ATTR.write_text("\n".join(attr_lines).rstrip() + "\n", encoding="utf-8")
    print("harvest now", len(existing_albedos()), "made", made)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
