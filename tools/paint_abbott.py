"""Paint Abbott onto the rancher UV without breaking islands."""
from __future__ import annotations

from pathlib import Path

import numpy as np
from PIL import Image, ImageFilter, ImageChops

ROOT = Path(r"E:\Workspace\Madison")
SRC = ROOT / "game" / "assets" / "meshes" / "rancher" / "horse"
OUT = ROOT / "game" / "assets" / "meshes" / "abbott_tex"
OUT.mkdir(parents=True, exist_ok=True)
HAIR_EDIT = Path(
    r"C:\Users\ErnieHobbs\.grok\sessions"
    r"\E%3A%5CWorkspace%5CMadison\01a0917d-23af-7e61-9e1a-695aed8870e2\images\1.jpg"
)

CHESTNUT = np.array([0.40, 0.19, 0.09], dtype=np.float32)
WHITE = np.array([0.94, 0.90, 0.84], dtype=np.float32)
PINK = np.array([0.86, 0.62, 0.56], dtype=np.float32)
SPOT = np.array([0.36, 0.17, 0.09], dtype=np.float32)
NOSTRIL = np.array([0.10, 0.07, 0.06], dtype=np.float32)


def load(path: Path) -> np.ndarray:
    return np.asarray(Image.open(path).convert("RGB"), dtype=np.float32) / 255.0


def save(arr: np.ndarray, path: Path) -> None:
    Image.fromarray((np.clip(arr, 0, 1) * 255).astype(np.uint8), "RGB").save(path)
    print("wrote", path)


def smooth01(x, a, b):
    t = np.clip((x - a) / (b - a + 1e-8), 0, 1)
    return t * t * (3 - 2 * t)


def dilate(mask: np.ndarray, px: int) -> np.ndarray:
    im = Image.fromarray((np.clip(mask, 0, 1) * 255).astype(np.uint8), "L")
    im = im.filter(ImageFilter.MaxFilter(px * 2 + 1))
    im = im.filter(ImageFilter.GaussianBlur(px * 0.55))
    return np.asarray(im, dtype=np.float32) / 255.0


def paint_coat() -> None:
    src = load(SRC / "HorseMain2k00.png")
    h, w, _ = src.shape
    yy, xx = np.mgrid[0:h, 0:w]
    u = xx / (w - 1.0)
    v = yy / (h - 1.0)
    lum = src.max(axis=2)
    sat = src.max(axis=2) - src.min(axis=2)

    # Face island: left head of the hide. Background of the PNG is beige ~0.75.
    bg = np.linalg.norm(src - np.array([0.76, 0.73, 0.68]), axis=2)
    on_mesh = smooth01(bg, 0.06, 0.14)

    # Original blaze: bright desaturated on the face
    face_box = (u < 0.28) & (v > 0.30) & (v < 0.72)
    orig_blaze = face_box.astype(np.float32) * smooth01(lum, 0.68, 0.80) * smooth01(sat, 0.24, 0.10)
    # Widen the existing blaze only — Abbott's face is a blaze, not a white mask.
    blaze = dilate(orig_blaze, 7) * on_mesh
    # Slight extra width along the centerline near the forehead
    mid = np.exp(-((v - 0.515) ** 2) / (2 * 0.028 ** 2)) * smooth01(u, 0.22, 0.10)
    blaze = np.clip(blaze + orig_blaze + 0.35 * mid * orig_blaze, 0, 1)

    # Spots in the blaze
    def blob(cu, cv, rx, ry):
        return np.exp(-(((u - cu) / rx) ** 2 + ((v - cv) / ry) ** 2))

    spots = np.clip(blob(0.155, 0.505, 0.028, 0.022) + 0.8 * blob(0.08, 0.53, 0.022, 0.018), 0, 1)
    spots *= blaze

    # Pink muzzle: only the left tip of the head
    muzzle = on_mesh * smooth01(u, 0.08, 0.02) * np.exp(-((v - 0.515) ** 2) / (2 * 0.07 ** 2))
    muzzle = np.clip(muzzle, 0, 1)
    nostril = on_mesh * (
        blob(0.035, 0.49, 0.018, 0.016) + blob(0.035, 0.545, 0.018, 0.016)
    )

    # Socks: keep original bright patches on the four hoof tiles
    sock = on_mesh * (1.0 - face_box.astype(np.float32)) * smooth01(lum, 0.75, 0.86) * smooth01(sat, 0.22, 0.08)
    # Hoof tiles are the rotated squares — also the pale lower legs
    sock = np.clip(sock + on_mesh * (1.0 - face_box.astype(np.float32)) * smooth01(lum, 0.72, 0.84) * (
        (v < 0.18) | (v > 0.82) | (u < 0.12) | (u > 0.88)
    ).astype(np.float32) * 0.5, 0, 1)

    # Body: kill white speckle / pale rump
    body = on_mesh * (1.0 - blaze) * (1.0 - sock) * (1.0 - muzzle)
    speckle = body * smooth01(lum, 0.58, 0.72) * smooth01(sat, 0.20, 0.08)

    grain = src / np.maximum(lum[..., None], 0.08)
    warm = src * np.array([1.05, 0.82, 0.68], dtype=np.float32)
    coat = 0.40 * (CHESTNUT * (0.65 + 0.45 * grain)) + 0.60 * warm
    # Darken a touch
    coat *= 0.92
    kill = speckle[..., None]
    coat = coat * (1.0 - kill) + (CHESTNUT * (0.75 + 0.3 * grain)) * kill

    # Small left-withers splash only (near neck, not a hip blanket)
    withers = blob(0.33, 0.355, 0.028, 0.022) * on_mesh * (1.0 - face_box.astype(np.float32))

    out = coat.copy()
    b = blaze[..., None]
    out = out * (1 - b) + WHITE * b
    s = spots[..., None] * 0.9
    out = out * (1 - s) + SPOT * s
    p = muzzle[..., None]
    out = out * (1 - p) + (PINK * (0.7 + 0.3 * grain)) * p
    n = np.clip(nostril, 0, 1)[..., None]
    out = out * (1 - n) + NOSTRIL * n
    k = sock[..., None]
    out = out * (1 - k * 0.9) + WHITE * (k * 0.9)
    wv = withers[..., None] * 0.5
    out = out * (1 - wv) + WHITE * wv

    # Preserve original background (off-mesh)
    out = np.where(on_mesh[..., None] > 0.15, out, src)
    # Fur grain on markings
    out = np.clip(out * (0.90 + 0.10 * grain), 0, 1)
    out = np.where(on_mesh[..., None] > 0.15, out, src)

    save(out, OUT / "abbott_coat.png")
    Image.fromarray((blaze * 255).astype(np.uint8), "L").save(OUT / "debug_blaze.png")
    Image.fromarray((sock * 255).astype(np.uint8), "L").save(OUT / "debug_sock.png")


def paint_hair() -> None:
    orig = Image.open(SRC / "Hair12Main2k.png").convert("RGB")
    if HAIR_EDIT.exists():
        edit = Image.open(HAIR_EDIT).convert("RGB").resize(orig.size, Image.Resampling.LANCZOS)
        # Keep original alpha/silhouette: black stays black
        o = np.asarray(orig, dtype=np.float32) / 255.0
        e = np.asarray(edit, dtype=np.float32) / 255.0
        lum = o.max(axis=2, keepdims=True)
        # Mix: use edited color where there is hair, keep original grain
        hair = np.clip(e * (0.55 + 0.55 * (o / np.maximum(lum, 0.05))), 0, 1)
        hair = np.where(lum > 0.06, hair, o)
        save(hair, OUT / "abbott_hair.png")
    else:
        orig.save(OUT / "abbott_hair.png")
    Image.open(SRC / "eye_texture.png").convert("RGB").save(OUT / "abbott_eye.png")
    print("wrote", OUT / "abbott_eye.png")


if __name__ == "__main__":
    paint_coat()
    paint_hair()
