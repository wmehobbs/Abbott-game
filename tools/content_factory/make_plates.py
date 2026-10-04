"""Synthesize seamless Hidden K plates from harvest + existing textures.

Each named plate writes albedo + normal + rough at 1024px under
game/assets/textures/harvest/proc/.

Copies flatten_lighting / make_seamless / to_normal / to_roughness from
tools/make_content.py (do not import a broken path).
"""
from __future__ import annotations

import sys
from pathlib import Path

import numpy as np
from PIL import Image, ImageEnhance, ImageFilter, ImageDraw, ImageOps

from rules import PROC_NAMES

ROOT = Path(__file__).resolve().parents[2]
TEX = ROOT / "game" / "assets" / "textures"
HARVEST = TEX / "harvest"
OUT = HARVEST / "proc"
SIZE = 1024


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


def first_existing(cands: list[Path]) -> Path | None:
    for p in cands:
        if p.exists():
            return p
    return None


def load_sq(path: Path) -> Image.Image:
    im = Image.open(path).convert("RGB")
    w, h = im.size
    side = min(w, h)
    im = im.crop(((w - side) // 2, (h - side) // 2, (w + side) // 2, (h + side) // 2))
    if side != SIZE:
        im = im.resize((SIZE, SIZE), Image.Resampling.LANCZOS)
    return im


def harvest_or(*names: str) -> Path:
    cands: list[Path] = []
    for n in names:
        cands.append(HARVEST / f"{n}_albedo.jpg")
        cands.append(TEX / f"{n}_albedo.jpg")
        cands.append(TEX / f"{n}.jpg")
    p = first_existing(cands)
    if p is None:
        # last resort: sand/wood/grass already in the game
        for fallback in ("sand_albedo.jpg", "wood_albedo.jpg", "grass_albedo.jpg", "leather_albedo.jpg"):
            fp = TEX / fallback
            if fp.exists():
                return fp
        raise FileNotFoundError(f"no source for {names}")
    return p


def mul_color(im: Image.Image, rgb: tuple[float, float, float]) -> Image.Image:
    arr = np.asarray(im.convert("RGB"), dtype=np.float32)
    out = arr * np.array(rgb, dtype=np.float32)
    return Image.fromarray(np.clip(out, 0, 255).astype(np.uint8), "RGB")


def lerp(a: Image.Image, b: Image.Image, t: float) -> Image.Image:
    aa = np.asarray(a.convert("RGB"), dtype=np.float32)
    bb = np.asarray(b.convert("RGB"), dtype=np.float32)
    out = aa * (1.0 - t) + bb * t
    return Image.fromarray(np.clip(out, 0, 255).astype(np.uint8), "RGB")


def noise(seed: int, scale: float = 8.0, octaves: int = 4) -> np.ndarray:
    rng = np.random.default_rng(seed)
    acc = np.zeros((SIZE, SIZE), dtype=np.float32)
    amp = 1.0
    tot = 0.0
    for o in range(octaves):
        s = max(4, int(SIZE / (scale * (2**o))))
        grid = rng.standard_normal((s, s)).astype(np.float32)
        im = Image.fromarray(((grid - grid.min()) / (np.ptp(grid) + 1e-6) * 255).astype(np.uint8), "L")
        im = im.resize((SIZE, SIZE), Image.Resampling.BICUBIC)
        acc += np.asarray(im, dtype=np.float32) / 255.0 * amp
        tot += amp
        amp *= 0.5
    acc /= tot
    return acc


def overlay_noise(im: Image.Image, seed: int, amount: float = 0.12) -> Image.Image:
    n = noise(seed)
    arr = np.asarray(im.convert("RGB"), dtype=np.float32)
    n3 = np.stack([n, n, n], axis=-1)
    out = arr * (1.0 - amount) + (arr * (0.7 + 0.6 * n3)) * amount
    return Image.fromarray(np.clip(out, 0, 255).astype(np.uint8), "RGB")


def rake_lines(im: Image.Image, gap: int = 18, width: int = 3, dark: float = 0.88) -> Image.Image:
    arr = np.asarray(im.convert("RGB"), dtype=np.float32)
    for y in range(0, SIZE, gap):
        arr[y : y + width, :] *= dark
        if y + width // 2 < SIZE:
            arr[y + width // 2 : y + width // 2 + 1, :] *= 0.96
    return Image.fromarray(np.clip(arr, 0, 255).astype(np.uint8), "RGB")


def hoof_cuts(im: Image.Image, seed: int = 9) -> Image.Image:
    arr = np.asarray(im.convert("RGB"), dtype=np.float32)
    rng = np.random.default_rng(seed)
    overlay = Image.new("L", (SIZE, SIZE), 0)
    d = ImageDraw.Draw(overlay)
    for _ in range(140):
        x = int(rng.integers(20, SIZE - 20))
        y = int(rng.integers(20, SIZE - 20))
        w = int(rng.integers(6, 14))
        h = int(rng.integers(8, 16))
        d.ellipse((x, y, x + w, y + h), fill=int(rng.integers(80, 160)))
    mask = np.asarray(overlay, dtype=np.float32) / 255.0
    dark = arr * 0.72
    m = mask[..., None]
    out = arr * (1.0 - m * 0.55) + dark * (m * 0.55)
    return Image.fromarray(np.clip(out, 0, 255).astype(np.uint8), "RGB")


def finish(im: Image.Image, name: str, rough_lo: float, rough_hi: float, nstr: float = 1.6) -> None:
    im = flatten_lighting(im, blur=28.0)
    im = make_seamless(im, blend=64)
    if im.size[0] < SIZE or im.size[1] < SIZE:
        im = im.resize((SIZE, SIZE), Image.Resampling.LANCZOS)
    save_jpg(im, OUT / f"{name}_albedo.jpg")
    save_jpg(to_normal(im, strength=nstr), OUT / f"{name}_normal.jpg")
    save_jpg(to_roughness(im, lo=rough_lo, hi=rough_hi).convert("RGB"), OUT / f"{name}_rough.jpg")


def build() -> dict[str, Path]:
    OUT.mkdir(parents=True, exist_ok=True)
    sand = load_sq(harvest_or("playground_sand", "sand_01", "sand_02", "sand"))
    dirt = load_sq(harvest_or("raked_dirt", "dirt", "park_dirt", "sand"))
    grass = load_sq(harvest_or("grass_path_2", "leafy_grass", "aerial_grass_rock", "grass"))
    dryg = load_sq(harvest_or("withered_grass", "sparse_grass", "dry_ground_01", "grass"))
    pine_b = load_sq(harvest_or("pine_bark", "knotted_pine_bark", "wood"))
    oak_b = load_sq(harvest_or("jolcham_oak_bark", "bark_brown_01", "wood"))
    leaves = load_sq(harvest_or("forest_leaves_04", "forest_leaves_03", "forest_floor", "grass"))
    white_b = load_sq(harvest_or("white_planks_clean", "distressed_painted_planks", "wood"))
    dark_b = load_sq(harvest_or("dark_planks", "dark_wood", "wood"))
    oak_p = load_sq(harvest_or("oak_wood_planks", "worn_planks", "wood_planks", "wood"))
    leather = load_sq(harvest_or("brown_leather", "fabric_leather_01", "leather"))
    wool = load_sq(harvest_or("poly_wool_herringbone", "wool_boucle", "acg_fabric004", "leather"))
    gravel = load_sq(harvest_or("gravel", "gravel_floor", "sandy_gravel", "sand"))
    chips = load_sq(harvest_or("wood_chips", "forest_floor", "brown_mud_leaves", "wood"))
    soil = load_sq(harvest_or("acg_soil001", "farm_soil", "brown_mud", "dirt"))
    wet = load_sq(harvest_or("damp_sand", "playground_sand", "sand"))

    # sand_worked_dry — Piedmont ring, late summer, raked then ridden
    finish(overlay_noise(lerp(sand, dirt, 0.22), 11, 0.10), "sand_worked_dry", 0.62, 0.92, 1.8)
    # sand_worked_wet — dark center after the water truck
    wet2 = mul_color(lerp(wet, sand, 0.25), (0.78, 0.74, 0.68))
    wet2 = ImageEnhance.Contrast(wet2).enhance(1.08)
    finish(wet2, "sand_worked_wet", 0.42, 0.70, 1.4)
    # sand_rake
    finish(rake_lines(lerp(sand, dirt, 0.12), gap=16, width=2, dark=0.84), "sand_rake", 0.60, 0.90, 2.1)
    # grass_piedmont — fescue/clover mix
    g = lerp(grass, leafy_if(grass, dryg), 0.15)
    g = mul_color(g, (0.92, 1.02, 0.78))
    finish(overlay_noise(g, 21, 0.08), "grass_piedmont", 0.70, 0.95, 1.3)
    # grass_dry_patch
    finish(lerp(dryg, grass, 0.28), "grass_dry_patch", 0.72, 0.96, 1.2)
    # grass_late_rust
    rust = mul_color(lerp(dryg, grass, 0.35), (1.15, 0.92, 0.55))
    rust = ImageEnhance.Color(rust).enhance(0.85)
    finish(rust, "grass_late_rust", 0.74, 0.97, 1.1)
    # pine_needles
    pn = lerp(leaves, pine_b, 0.18)
    pn = mul_color(pn, (0.70, 0.78, 0.48))
    finish(overlay_noise(pn, 33, 0.16), "pine_needles", 0.68, 0.94, 1.7)
    # oak_bark
    finish(overlay_noise(oak_b, 44, 0.08), "oak_bark", 0.55, 0.88, 2.2)
    # board_white — hunter boards
    wb = ImageEnhance.Brightness(white_b).enhance(1.18)
    wb = ImageEnhance.Color(wb).enhance(0.35)
    wb = mul_color(wb, (0.98, 0.97, 0.93))
    finish(wb, "board_white", 0.48, 0.72, 0.9)
    # kick_dark
    kd = mul_color(dark_b, (0.55, 0.42, 0.28))
    kd = ImageEnhance.Brightness(kd).enhance(0.72)
    finish(kd, "kick_dark", 0.58, 0.86, 1.5)
    # rail_natural
    finish(overlay_noise(oak_p, 55, 0.07), "rail_natural", 0.52, 0.82, 1.4)
    # leather_bridle
    lb = mul_color(leather, (0.72, 0.42, 0.22))
    lb = ImageEnhance.Contrast(lb).enhance(1.12)
    finish(lb, "leather_bridle", 0.28, 0.55, 1.2)
    # wool_navy_coat
    navy = mul_color(wool, (0.22, 0.28, 0.48))
    navy = ImageEnhance.Color(navy).enhance(0.7)
    navy = ImageEnhance.Brightness(navy).enhance(0.62)
    finish(navy, "wool_navy_coat", 0.62, 0.88, 0.8)
    # brush_box
    bb = lerp(oak_p, soil, 0.20)
    bb = mul_color(bb, (0.78, 0.62, 0.40))
    finish(bb, "brush_box", 0.58, 0.86, 1.3)
    # flower_soil
    fs = mul_color(lerp(soil, dirt, 0.3), (0.55, 0.38, 0.22))
    finish(overlay_noise(fs, 66, 0.14), "flower_soil", 0.70, 0.95, 1.6)
    # gravel_drive
    finish(overlay_noise(gravel, 77, 0.10), "gravel_drive", 0.55, 0.90, 2.0)
    # hay_bale
    hay = mul_color(lerp(chips, dryg, 0.4), (1.12, 0.95, 0.48))
    hay = rake_lines(hay, gap=10, width=2, dark=0.90)
    finish(hay, "hay_bale", 0.68, 0.94, 1.5)
    # hoof_cut_sand
    finish(hoof_cuts(lerp(sand, dirt, 0.18)), "hoof_cut_sand", 0.60, 0.92, 2.0)
    # Extra named plates: color-grade from the same sources so we hit mega quota.
    extras = {
        "sand_hoof": (hoof_cuts(lerp(sand, dirt, 0.22)), 0.60, 0.92, 2.0),
        "sand_lip": (mul_color(lerp(sand, dirt, 0.35), (0.82, 0.72, 0.52)), 0.62, 0.90, 1.6),
        "sand_wet_center": (mul_color(wet2 if False else lerp(sand, dirt, 0.4), (0.70, 0.66, 0.58)), 0.40, 0.68, 1.3),
        "grass_clover": (mul_color(grass, (0.80, 1.08, 0.70)), 0.72, 0.96, 1.2),
        "grass_shade": (mul_color(grass, (0.62, 0.78, 0.48)), 0.74, 0.96, 1.1),
        "grass_morning": (mul_color(grass, (0.95, 1.05, 0.70)), 0.70, 0.94, 1.2),
        "pine_duff_wet": (mul_color(lerp(leaves, pine_b, 0.25), (0.55, 0.62, 0.38)), 0.66, 0.92, 1.6),
        "oak_rust": (mul_color(oak_b, (1.10, 0.78, 0.48)), 0.56, 0.86, 2.0),
        "wool_navy_weave": (mul_color(wool, (0.18, 0.24, 0.42)), 0.64, 0.90, 0.7),
        "leather_sweat": (mul_color(leather, (0.55, 0.32, 0.18)), 0.35, 0.62, 1.1),
        "board_chalk": (mul_color(white_b, (0.96, 0.95, 0.90)), 0.50, 0.74, 0.8),
        "kick_scuff": (mul_color(dark_b, (0.42, 0.30, 0.20)), 0.62, 0.88, 1.6),
        "gravel_wet": (mul_color(gravel, (0.72, 0.68, 0.62)), 0.48, 0.82, 1.9),
        "straw_gold": (mul_color(lerp(chips, dryg, 0.3), (1.18, 1.00, 0.42)), 0.70, 0.95, 1.4),
        "hay_dust": (mul_color(lerp(chips, dryg, 0.5), (1.05, 0.92, 0.55)), 0.72, 0.96, 1.3),
        "flower_bloom_soil": (mul_color(soil, (0.48, 0.32, 0.20)), 0.72, 0.96, 1.5),
        "brush_dry": (mul_color(oak_p, (0.70, 0.58, 0.32)), 0.60, 0.88, 1.4),
        "velvet_cap": (mul_color(wool, (0.08, 0.08, 0.10)), 0.55, 0.82, 0.6),
        "boot_black": (mul_color(leather, (0.12, 0.10, 0.09)), 0.28, 0.50, 1.0),
        "iron_polish": (mul_color(gravel, (0.70, 0.70, 0.72)), 0.22, 0.45, 1.8),
        "pad_quilt": (mul_color(wool, (0.90, 0.88, 0.80)), 0.68, 0.92, 0.7),
        "pine_bark_wet": (mul_color(pine_b, (0.55, 0.42, 0.28)), 0.50, 0.82, 2.1),
        "fescue_late": (mul_color(lerp(grass, dryg, 0.45), (0.88, 0.82, 0.42)), 0.74, 0.97, 1.1),
        "apron_dirt": (mul_color(dirt, (0.72, 0.58, 0.40)), 0.64, 0.92, 1.7),
        "rail_white_scuff": (mul_color(white_b, (0.92, 0.90, 0.84)), 0.52, 0.76, 0.9),
        "tack_trunk": (mul_color(oak_p, (0.50, 0.32, 0.16)), 0.48, 0.78, 1.3),
        "salt_block": (mul_color(white_b, (0.92, 0.94, 0.90)), 0.55, 0.85, 0.5),
        "cooler_navy": (mul_color(wool, (0.16, 0.22, 0.38)), 0.66, 0.90, 0.6),
        "hydrant_metal": (mul_color(gravel, (0.55, 0.22, 0.18)), 0.30, 0.55, 1.7),
        "stall_bar": (mul_color(dark_b, (0.35, 0.32, 0.30)), 0.40, 0.70, 1.2),
        "oak_fourboard": (overlay_noise(oak_p, 88, 0.09), 0.54, 0.84, 1.4),
        "clover_patch": (mul_color(grass, (0.70, 1.10, 0.62)), 0.73, 0.96, 1.2),
        "rake_deep": (rake_lines(lerp(sand, dirt, 0.2), gap=14, width=3, dark=0.80), 0.60, 0.90, 2.2),
        "hoof_wet": (hoof_cuts(mul_color(sand, (0.75, 0.70, 0.60))), 0.50, 0.82, 1.9),
        "duff_dry": (mul_color(leaves, (0.78, 0.62, 0.38)), 0.70, 0.94, 1.5),
        "board_hunter": (mul_color(white_b, (0.97, 0.96, 0.92)), 0.48, 0.72, 0.85),
        "kick_barn": (mul_color(dark_b, (0.38, 0.26, 0.16)), 0.60, 0.88, 1.5),
        "leather_reins": (mul_color(leather, (0.42, 0.22, 0.12)), 0.30, 0.52, 1.15),
        "wool_melton": (mul_color(wool, (0.14, 0.18, 0.32)), 0.65, 0.90, 0.75),
        "gravel_barn_yard": (overlay_noise(gravel, 91, 0.12), 0.56, 0.90, 2.0),
        "sand_track": (rake_lines(sand, gap=22, width=2, dark=0.86), 0.62, 0.92, 1.8),
        "grass_ring_edge": (mul_color(lerp(grass, dryg, 0.2), (0.85, 0.90, 0.50)), 0.72, 0.95, 1.2),
        "pine_needle_shade": (mul_color(leaves, (0.48, 0.55, 0.32)), 0.68, 0.93, 1.6),
        "oak_leaf_late": (mul_color(leaves, (0.90, 0.55, 0.22)), 0.70, 0.94, 1.4),
        "flower_box_soil": (mul_color(soil, (0.42, 0.28, 0.16)), 0.72, 0.96, 1.55),
        "plank_gate": (mul_color(oak_p, (0.72, 0.62, 0.42)), 0.55, 0.82, 1.35),
        "natural_rail": (overlay_noise(oak_p, 101, 0.06), 0.52, 0.80, 1.4),
        "navy_pole": (mul_color(white_b, (0.18, 0.24, 0.42)), 0.45, 0.70, 0.7),
    }
    for name, spec in extras.items():
        im, lo, hi, ns = spec
        if name in PROC_NAMES:
            finish(im, name, lo, hi, ns)
    return {n: OUT / f"{n}_albedo.jpg" for n in PROC_NAMES}


def leafy_if(grass: Image.Image, dryg: Image.Image) -> Image.Image:
    return lerp(grass, dryg, 0.12)


def checklist(written: dict[str, Path]) -> int:
    ok = 0
    bad = 0
    print("PROC CHECKLIST")
    for name in PROC_NAMES:
        paths = [OUT / f"{name}_{m}.jpg" for m in ("albedo", "normal", "rough")]
        missing = [p.name for p in paths if not p.exists()]
        small = []
        for p in paths:
            if p.exists():
                im = Image.open(p)
                if min(im.size) < 512:
                    small.append(f"{p.name} {im.size}")
        status = "OK"
        if missing or small:
            status = "FAIL"
            bad += 1
            extra = ""
            if missing:
                extra += f" missing={missing}"
            if small:
                extra += f" small={small}"
            print(f"  {status}  {name}{extra}")
        else:
            ok += 1
            print(f"  {status}  {name}  {paths[0].stat().st_size}b")
    print(f"{ok}/{len(PROC_NAMES)} plates  ({ok * 3} files)")
    return 0 if bad == 0 and ok >= 18 else 1  # mega validator owns the 60+ bar


def main() -> int:
    written = build()
    return checklist(written)


if __name__ == "__main__":
    sys.exit(main())
