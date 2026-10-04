"""Cut Abbott out of the source photos with traced silhouettes, not flood-fill."""
from __future__ import annotations

from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw, ImageFilter

ROOT = Path(r"E:\Workspace\Madison")
SRC = ROOT / "photos_jpg"
OUT = ROOT / "tools" / "abbott_paint"
OUT.mkdir(parents=True, exist_ok=True)


def load(name: str) -> Image.Image:
    return Image.open(SRC / name).convert("RGB")


def poly_mask(size: tuple[int, int], norm_xy: list[tuple[float, float]], feather: int = 6) -> np.ndarray:
    w, h = size
    im = Image.new("L", (w, h), 0)
    pts = [(int(u * (w - 1)), int(v * (h - 1))) for u, v in norm_xy]
    ImageDraw.Draw(im).polygon(pts, fill=255)
    if feather > 0:
        im = im.filter(ImageFilter.GaussianBlur(feather))
    return np.asarray(im, dtype=np.float32) / 255.0


def crop_alpha(rgb: np.ndarray, alpha: np.ndarray, pad: float = 0.02) -> tuple[np.ndarray, np.ndarray]:
    ys, xs = np.where(alpha > 0.08)
    h, w = alpha.shape
    y0 = max(0, int(ys.min() - pad * h))
    y1 = min(h, int(ys.max() + pad * h) + 1)
    x0 = max(0, int(xs.min() - pad * w))
    x1 = min(w, int(xs.max() + pad * w) + 1)
    return rgb[y0:y1, x0:x1], alpha[y0:y1, x0:x1]


def save_rgba(rgb: np.ndarray, alpha: np.ndarray, path: Path) -> None:
    rgba = np.dstack(
        [np.clip(rgb, 0, 255).astype(np.uint8), np.clip(alpha * 255.0, 0, 255).astype(np.uint8)]
    )
    Image.fromarray(rgba, "RGBA").save(path)
    print("wrote", path, rgb.shape, "a", float(alpha.mean()))


def main() -> None:
    face_im = load("IMG_3408.jpg")
    stall_im = load("IMG_3412.jpg")
    body_im = load("IMG_9535.jpg")
    face = np.asarray(face_im, dtype=np.float32)
    stall = np.asarray(stall_im, dtype=np.float32)
    body = np.asarray(body_im, dtype=np.float32)

    # Traced on the 720x960 readbacks of the three photos.
    face_poly = [
        (0.355, 0.035),
        (0.300, 0.095),
        (0.255, 0.200),
        (0.235, 0.320),
        (0.250, 0.450),
        (0.285, 0.600),
        (0.340, 0.760),
        (0.400, 0.900),
        (0.455, 0.955),
        (0.510, 0.968),
        (0.575, 0.940),
        (0.640, 0.860),
        (0.690, 0.720),
        (0.720, 0.560),
        (0.735, 0.430),
        (0.700, 0.300),
        (0.680, 0.190),
        (0.650, 0.090),
        (0.590, 0.035),
        (0.520, 0.055),
        (0.450, 0.055),
    ]
    # Knock out the bright stall window that sits off the right cheek.
    window_poly = [
        (0.655, 0.250),
        (0.780, 0.250),
        (0.780, 0.365),
        (0.655, 0.365),
    ]
    a_face = poly_mask(face_im.size, face_poly, 8)
    a_face *= 1.0 - poly_mask(face_im.size, window_poly, 2)

    stall_head = [
        (0.430, 0.175),
        (0.400, 0.230),
        (0.390, 0.320),
        (0.410, 0.430),
        (0.450, 0.560),
        (0.500, 0.680),
        (0.545, 0.745),
        (0.600, 0.755),
        (0.655, 0.700),
        (0.700, 0.560),
        (0.730, 0.420),
        (0.745, 0.300),
        (0.720, 0.200),
        (0.660, 0.165),
        (0.580, 0.185),
        (0.510, 0.185),
    ]
    stall_neck = [
        (0.055, 0.300),
        (0.055, 0.430),
        (0.380, 0.430),
        (0.380, 0.300),
    ]
    a_stall = np.clip(
        poly_mask(stall_im.size, stall_head, 6) + poly_mask(stall_im.size, stall_neck, 4) * 0.95,
        0,
        1,
    )

    # Tight boxes from the 720×960 readback of IMG_9535.
    bh, bw, _ = body.shape

    def box_rgba(x0, y0, x1, y1, name: str) -> None:
        sl = body[int(y0 * bh) : int(y1 * bh), int(x0 * bw) : int(x1 * bw)]
        Image.fromarray(np.clip(sl, 0, 255).astype(np.uint8), "RGB").save(OUT / name)
        print("wrote", OUT / name, sl.shape, "mean", sl.mean(axis=(0, 1)))

    box_rgba(0.235, 0.275, 0.385, 0.415, "abbott_photo_body_head.png")
    box_rgba(0.600, 0.400, 0.735, 0.530, "abbott_photo_rump.png")
    box_rgba(0.650, 0.490, 0.730, 0.645, "abbott_photo_lefthind.png")
    box_rgba(0.700, 0.355, 0.760, 0.520, "abbott_photo_tail.png")

    face_c, face_a = crop_alpha(face, a_face)
    stall_c, stall_a = crop_alpha(stall, a_stall)
    save_rgba(face_c, face_a, OUT / "abbott_photo_face.png")
    save_rgba(stall_c, stall_a, OUT / "abbott_photo_stall.png")

    rump = body[int(0.405 * bh) : int(0.525 * bh), int(0.605 * bw) : int(0.725 * bw)]
    tile = Image.fromarray(np.clip(rump, 0, 255).astype(np.uint8), "RGB")
    tile = tile.resize((1024, 1024), Image.Resampling.BICUBIC)
    tile.save(OUT / "abbott_coat_swatch.png")
    print("wrote", OUT / "abbott_coat_swatch.png", "mean", np.asarray(tile).mean(axis=(0, 1)))


if __name__ == "__main__":
    main()
