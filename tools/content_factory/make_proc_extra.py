"""Extra procedural plates beyond PROC_NAMES so quota raises stay local."""
from __future__ import annotations

import json
from pathlib import Path

from make_plates import finish, harvest_or, hoof_cuts, lerp, load_sq, mul_color, overlay_noise, rake_lines
from rules import PROC_NAMES

HERE = Path(__file__).resolve().parent
QUOTAS = HERE / "MEGA_QUOTAS.json"
OUT = Path(__file__).resolve().parents[2] / "game" / "assets" / "textures" / "harvest" / "proc"


def need() -> int:
    if QUOTAS.exists():
        return int(json.loads(QUOTAS.read_text(encoding="utf-8")).get("proc_plates", 60))
    return 60


def main() -> int:
    have = len({p.name[: -len("_albedo.jpg")] for p in OUT.glob("*_albedo.jpg")}) if OUT.exists() else 0
    target = need()
    print(f"proc extra have={have} need={target}")
    if have >= target:
        return 0
    sand = load_sq(harvest_or("playground_sand", "sand_01", "sand"))
    dirt = load_sq(harvest_or("raked_dirt", "dirt", "sand"))
    grass = load_sq(harvest_or("grass_path_2", "leafy_grass", "grass"))
    leather = load_sq(harvest_or("brown_leather", "leather"))
    oak = load_sq(harvest_or("oak_wood_planks", "wood"))
    i = 0
    while have < target:
        name = f"proc_extra_{i:03d}"
        dest = OUT / f"{name}_albedo.jpg"
        if dest.exists():
            i += 1
            have = len({p.name[: -len("_albedo.jpg")] for p in OUT.glob("*_albedo.jpg")})
            continue
        src = [sand, dirt, grass, leather, oak][i % 5]
        t = 0.12 + (i % 7) * 0.04
        im = overlay_noise(lerp(src, dirt, t), 11 + i, 0.08)
        if i % 4 == 0:
            im = rake_lines(im, gap=16 + i % 8, width=2)
        if i % 5 == 0:
            im = hoof_cuts(im, seed=9 + i)
        if i % 3 == 0:
            im = mul_color(im, (0.92, 0.88, 0.80))
        finish(im, name, 0.50, 0.90, 1.4)
        have += 1
        i += 1
        if have % 20 == 0:
            print(f"  proc extra {have}/{target}")
    print("proc now", have)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
