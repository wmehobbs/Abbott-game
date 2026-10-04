"""Tight photo crops for the WhiteHorse object-space shader. No UV splat."""
from __future__ import annotations

from pathlib import Path

import numpy as np
from PIL import Image

ROOT = Path(r"E:\Workspace\Madison")
SRC = ROOT / "photos_jpg"
OUT = ROOT / "game" / "assets" / "textures"
OUT.mkdir(parents=True, exist_ok=True)


def load(name: str) -> np.ndarray:
    return np.asarray(Image.open(SRC / name).convert("RGB"), dtype=np.float32) / 255.0


def save(arr: np.ndarray, name: str) -> None:
    path = OUT / name
    Image.fromarray(np.clip(arr * 255.0, 0, 255).astype(np.uint8), "RGB").save(path)
    print("wrote", path, arr.shape, "mean", arr.mean(axis=(0, 1)))


def crop_norm(im: np.ndarray, u0: float, v0: float, u1: float, v1: float) -> np.ndarray:
    h, w = im.shape[:2]
    x0, x1 = int(u0 * w), int(u1 * w)
    y0, y1 = int(v0 * h), int(v1 * h)
    return im[y0:y1, x0:x1]


def chestnut_tile(body: np.ndarray) -> np.ndarray:
    # Sunlit croup on the right of IMG_9535 — no girl, no grass, no sky.
    # Tight on the croup only — skip the fence and trash can on the right.
    rump = crop_norm(body, 0.58, 0.40, 0.70, 0.54)
    r, g, b = rump[:, :, 0], rump[:, :, 1], rump[:, :, 2]
    keep = (r > g + 0.02) & (r > b + 0.06) & (g < 0.42) & (b < 0.30) & (r > 0.14) & (r < 0.62)
    if keep.mean() < 0.15:
        keep = (r > b + 0.04) & (g < 0.48)
    ys, xs = np.where(keep)
    y0, y1 = int(np.percentile(ys, 10)), int(np.percentile(ys, 90))
    x0, x1 = int(np.percentile(xs, 10)), int(np.percentile(xs, 90))
    block = rump[y0:y1, x0:x1]
    target = np.array([0.30, 0.14, 0.08], dtype=np.float32)
    mean = np.maximum(block.mean(axis=(0, 1)), 0.05)
    grain = block / mean
    block = np.clip(target * (0.55 + 0.45 * grain), 0, 1)
    tile = np.zeros((512, 512, 3), dtype=np.float32)
    bh, bw = block.shape[0], block.shape[1]
    yy, xx = np.mgrid[0:512, 0:512]
    tile = block[yy % bh, xx % bw]
    print("CHESTNUT keep", float(keep.mean()), "block", block.shape)
    return tile


def main() -> None:
    face = load("IMG_3408.jpg")
    stall = load("IMG_3412.jpg")
    body = load("IMG_9535.jpg")
    print("src face", face.shape, "stall", stall.shape, "body", body.shape)
    # Ears through pink muzzle, cheeks only — no stall wall, no pole, no bucket.
    save(crop_norm(face, 0.24, 0.02, 0.76, 0.97), "abbott_shader_face.jpg")
    # Head in the stall window, blaze and flaxen.
    save(crop_norm(stall, 0.38, 0.16, 0.76, 0.78), "abbott_shader_stall.jpg")
    save(chestnut_tile(body), "abbott_shader_coat.jpg")


if __name__ == "__main__":
    main()
