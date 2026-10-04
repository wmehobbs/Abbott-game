"""Pack textures, title stills, icon, and procedural audio for Abbott."""
from __future__ import annotations

import os
import shutil
import struct
import math
import wave
from pathlib import Path

import numpy as np
from PIL import Image, ImageEnhance, ImageFilter, ImageDraw, ImageOps

ROOT = Path(r"E:\Workspace\Madison")
IMG = Path(
    r"C:\Users\ErnieHobbs\.grok\sessions"
    r"\E%3A%5CWorkspace%5CMadison\01a08d56-f427-7fd2-8d8c-debb276979b3\images"
)
PHOTOS = ROOT / "photos_jpg"
GAME = ROOT / "game"
TEX = GAME / "assets" / "textures"
PHOTO_OUT = GAME / "assets" / "photos"
UI = GAME / "assets" / "ui"
AUD = GAME / "assets" / "audio"
FONT = GAME / "assets" / "fonts"

for p in (TEX, PHOTO_OUT, UI, AUD, FONT):
    p.mkdir(parents=True, exist_ok=True)


def save_jpg(im: Image.Image, path: Path, quality: int = 92) -> None:
    im.convert("RGB").save(path, quality=quality, optimize=True)


def save_png(im: Image.Image, path: Path) -> None:
    im.save(path, optimize=True)


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
        out[i, :] = out[i, :] * t + out[h - b + i, :] * (1 - t)
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


def copy_processed(src: Path, dst_stem: str, seamless: bool = False, flatten: bool = False) -> None:
    im = Image.open(src).convert("RGB")
    if flatten:
        im = flatten_lighting(im)
    if seamless:
        im = make_seamless(im)
    albedo = TEX / f"{dst_stem}_albedo.jpg"
    save_jpg(im, albedo)
    save_jpg(to_normal(im), TEX / f"{dst_stem}_normal.jpg")
    to_roughness(im).save(TEX / f"{dst_stem}_rough.jpg")
    print("tex", dst_stem, im.size)


def key_gray_to_alpha(im: Image.Image, thresh: int = 28) -> Image.Image:
    arr = np.asarray(im.convert("RGB"), dtype=np.int16)
    # gray studio backdrop
    mx = arr.max(axis=2)
    mn = arr.min(axis=2)
    mean = arr.mean(axis=2)
    grayish = (mx - mn) < 18
    mid = (mean > 90) & (mean < 175) & grayish
    alpha = np.where(mid, 0, 255).astype(np.uint8)
    # keep edges
    rgba = np.dstack([arr.astype(np.uint8), alpha])
    return Image.fromarray(rgba, "RGBA")


def make_pole_textures() -> None:
    w, h = 1024, 128
    white = Image.new("RGB", (w, h), (236, 232, 220))
    draw = ImageDraw.Draw(white)
    for x in range(0, w, 8):
        shade = 220 + (x * 7) % 16
        draw.line([(x, 0), (x, h)], fill=(shade, shade - 4, shade - 12))
    save_jpg(white, TEX / "pole_white_albedo.jpg")
    save_jpg(to_normal(white, 0.6), TEX / "pole_white_normal.jpg")

    striped = white.copy()
    d = ImageDraw.Draw(striped)
    for x0 in (180, 460, 740):
        d.rectangle([x0, 0, x0 + 90, h], fill=(18, 32, 64))
    save_jpg(striped, TEX / "pole_navy_albedo.jpg")

    red = white.copy()
    d = ImageDraw.Draw(red)
    for x0 in (160, 430, 700):
        d.rectangle([x0, 0, x0 + 85, h], fill=(140, 28, 28))
    save_jpg(red, TEX / "pole_red_albedo.jpg")


def make_title_and_icon() -> None:
    src = Image.open(PHOTOS / "IMG_3408.jpg").convert("RGB")
    # Full portrait for cover-style title. Slight grade, keep HIS pixels.
    graded = ImageEnhance.Contrast(src).enhance(1.08)
    graded = ImageEnhance.Color(graded).enhance(1.06)
    graded = ImageEnhance.Brightness(graded).enhance(0.97)
    w, h = graded.size
    graded.resize((1440, int(1440 * h / w)), Image.Resampling.LANCZOS).save(
        PHOTO_OUT / "abbott_title.jpg", quality=94, optimize=True
    )
    # Face-centered square icon
    cw = int(min(w, h) * 0.72)
    x0 = int(w * 0.22)
    y0 = int(h * 0.10)
    icon = graded.crop((x0, y0, x0 + cw, y0 + cw)).resize((512, 512), Image.Resampling.LANCZOS)
    icon.save(UI / "icon.png")
    icon.resize((256, 256)).save(UI / "icon_256.png")
    # Cinematic wide as optional overlay (generated from the photo)
    cine = IMG / "11.jpg"
    if cine.exists():
        shutil.copy2(cine, PHOTO_OUT / "abbott_cinematic.jpg")
    print("title + icon")


def write_wav(path: Path, samples: np.ndarray, sr: int = 44100) -> None:
    samples = np.clip(samples, -1.0, 1.0)
    pcm = (samples * 32767.0).astype(np.int16)
    with wave.open(str(path), "w") as wf:
        wf.setnchannels(1)
        wf.setsampwidth(2)
        wf.setframerate(sr)
        wf.writeframes(pcm.tobytes())


def env_noise(n: int, rng: np.random.Generator) -> np.ndarray:
    x = rng.standard_normal(n).astype(np.float64)
    # cheap brown-ish
    k = np.fft.rfftfreq(n)
    spec = np.fft.rfft(x)
    spec /= np.maximum(k * n, 1.0) ** 0.85
    y = np.fft.irfft(spec, n)
    y /= np.max(np.abs(y)) + 1e-8
    return y


def hoof_hit(sr: int, rng: np.random.Generator, heavy: float) -> np.ndarray:
    n = int(sr * 0.22)
    t = np.arange(n) / sr
    thud = np.sin(2 * np.pi * (90 + heavy * 40) * t) * np.exp(-t * (18 - heavy * 6))
    grit = rng.standard_normal(n) * np.exp(-t * 40) * (0.35 + 0.25 * heavy)
    # very light lowpass on grit
    kernel = np.ones(12) / 12
    grit = np.convolve(grit, kernel, mode="same")
    sig = thud * 0.7 + grit
    sig /= np.max(np.abs(sig)) + 1e-8
    return sig * (0.55 + 0.35 * heavy)


def make_audio() -> None:
    sr = 44100
    rng = np.random.default_rng(14)

    def loop_hoofs(count: int, spacing: float, heavy: float, name: str) -> None:
        n = int(sr * (spacing * count + 0.3))
        buf = np.zeros(n)
        for i in range(count):
            hit = hoof_hit(sr, rng, heavy)
            a = int(i * spacing * sr)
            b = min(n, a + len(hit))
            buf[a:b] += hit[: b - a]
        buf /= np.max(np.abs(buf)) + 1e-8
        write_wav(AUD / name, buf * 0.85)

    loop_hoofs(8, 0.42, 0.25, "hoof_walk.wav")
    loop_hoofs(10, 0.28, 0.45, "hoof_trot.wav")
    loop_hoofs(12, 0.20, 0.7, "hoof_canter.wav")

    # rail knock
    n = int(sr * 0.7)
    t = np.arange(n) / sr
    rail = np.zeros(n)
    for f, d, a in ((180, 9, 0.6), (420, 14, 0.35), (880, 22, 0.18), (210, 7, 0.4)):
        rail += a * np.sin(2 * np.pi * f * t) * np.exp(-t * d)
    rail += 0.25 * rng.standard_normal(n) * np.exp(-t * 18)
    rail /= np.max(np.abs(rail)) + 1e-8
    write_wav(AUD / "rail.wav", rail * 0.9)

    # jump whoosh
    n = int(sr * 0.45)
    t = np.arange(n) / sr
    whoosh = rng.standard_normal(n) * (t / t.max()) * np.exp(-t * 4)
    whoosh = np.convolve(whoosh, np.ones(40) / 40, mode="same")
    whoosh /= np.max(np.abs(whoosh)) + 1e-8
    write_wav(AUD / "jump.wav", whoosh * 0.5)

    # land
    land = hoof_hit(sr, rng, 1.0)
    n2 = int(sr * 0.35)
    t2 = np.arange(n2) / sr
    land2 = np.sin(2 * np.pi * 70 * t2) * np.exp(-t2 * 10)
    buf = np.zeros(max(len(land), n2))
    buf[: len(land)] += land
    buf[:n2] += land2 * 0.5
    buf /= np.max(np.abs(buf)) + 1e-8
    write_wav(AUD / "land.wav", buf * 0.9)

    # refusal snort-ish
    n = int(sr * 0.4)
    t = np.arange(n) / sr
    snort = rng.standard_normal(n) * np.exp(-t * 8)
    snort += 0.3 * np.sin(2 * np.pi * 240 * t) * np.exp(-t * 10)
    snort /= np.max(np.abs(snort)) + 1e-8
    write_wav(AUD / "refuse.wav", snort * 0.6)

    # ui
    n = int(sr * 0.08)
    t = np.arange(n) / sr
    click = np.sin(2 * np.pi * 880 * t) * np.exp(-t * 50)
    click += 0.3 * np.sin(2 * np.pi * 1320 * t) * np.exp(-t * 60)
    write_wav(AUD / "ui.wav", click * 0.4)

    # outdoor ambience ~12s loop: wind + sparse birds
    dur = 12.0
    n = int(sr * dur)
    t = np.arange(n) / sr
    wind = env_noise(n, rng) * 0.18
    # slow amplitude
    wind *= 0.7 + 0.3 * np.sin(2 * np.pi * t / 7.0)
    birds = np.zeros(n)
    for _ in range(7):
        start = int(rng.uniform(0.4, dur - 1.2) * sr)
        length = int(sr * rng.uniform(0.12, 0.28))
        tt = np.arange(length) / sr
        f0 = rng.uniform(2200, 3800)
        chirp = np.sin(2 * np.pi * (f0 + 400 * tt) * tt) * np.sin(np.pi * tt / tt[-1]) ** 2
        birds[start : start + length] += chirp * rng.uniform(0.04, 0.08)
    amb = wind + birds
    amb /= np.max(np.abs(amb)) + 1e-8
    write_wav(AUD / "ambient_outdoor.wav", amb * 0.55)

    # indoor: quieter enclosed air, distant muffled thuds
    indoor = env_noise(n, rng) * 0.10
    indoor *= 0.8 + 0.2 * np.sin(2 * np.pi * t / 9.0)
    indoor += 0.02 * rng.standard_normal(n) * (0.5 + 0.5 * np.sin(2 * np.pi * t * 0.4))
    indoor /= np.max(np.abs(indoor)) + 1e-8
    write_wav(AUD / "ambient_indoor.wav", indoor * 0.5)
    print("audio")


def main() -> None:
    mapping = {
        "1.jpg": ("sand", True, False),
        "4.jpg": ("grass", True, False),
        "6.jpg": ("coat", True, True),
        "7.jpg": ("mane", True, False),
        "12.jpg": ("leather", True, False),
        "2.jpg": ("wood", False, False),
    }
    for fn, (stem, seamless, flatten) in mapping.items():
        src = IMG / fn
        if src.exists():
            copy_processed(src, stem, seamless=seamless, flatten=flatten)

    # wood: use top half to dodge the mid seam
    wood_src = IMG / "2.jpg"
    if wood_src.exists():
        im = Image.open(wood_src).convert("RGB")
        w, h = im.size
        top = im.crop((0, 0, w, h // 2)).resize((1024, 1024), Image.Resampling.LANCZOS)
        top = make_seamless(top, 36)
        save_jpg(top, TEX / "wood_albedo.jpg")
        save_jpg(to_normal(top), TEX / "wood_normal.jpg")

    # Abbott reference maps
    for src_name, dst in (("18.jpg", "abbott_side.png"), ("10.jpg", "abbott_front.png")):
        p = IMG / src_name
        if p.exists():
            im = Image.open(p).convert("RGB")
            keyed = key_gray_to_alpha(im)
            save_png(keyed, TEX / dst)
            save_jpg(im, TEX / dst.replace(".png", "_rgb.jpg"))

    if (IMG / "16.jpg").exists():
        save_jpg(Image.open(IMG / "16.jpg").convert("RGB"), TEX / "sky.jpg")
    if (IMG / "13.jpg").exists():
        save_jpg(Image.open(IMG / "13.jpg").convert("RGB"), UI / "panel.jpg")
    if (IMG / "5.jpg").exists():
        shutil.copy2(IMG / "5.jpg", TEX / "rider_front.jpg")
    if (IMG / "9.jpg").exists():
        shutil.copy2(IMG / "9.jpg", TEX / "rider_side.jpg")
    if (IMG / "8.jpg").exists():
        shutil.copy2(IMG / "8.jpg", TEX / "rider_back.jpg")
    if (IMG / "3.jpg").exists():
        shutil.copy2(IMG / "3.jpg", TEX / "saddle_ref.jpg")
    if (IMG / "15.jpg").exists():
        shutil.copy2(IMG / "15.jpg", TEX / "flower_box.jpg")
    if (IMG / "17.jpg").exists():
        shutil.copy2(IMG / "17.jpg", TEX / "standard_ref.jpg")
    if (IMG / "14.jpg").exists():
        shutil.copy2(IMG / "14.jpg", TEX / "pole_ref.jpg")

    # real photos for title / face projection
    shutil.copy2(PHOTOS / "IMG_3408.jpg", PHOTO_OUT / "IMG_3408.jpg")
    shutil.copy2(PHOTOS / "IMG_3409.jpg", PHOTO_OUT / "IMG_3409.jpg")
    face = Image.open(PHOTOS / "IMG_3408.jpg").convert("RGB")
    fw, fh = face.size
    face.resize((1024, int(1024 * fh / fw)), Image.Resampling.LANCZOS).save(
        TEX / "abbott_face_photo.jpg", quality=93
    )

    make_pole_textures()
    make_title_and_icon()
    make_audio()

    # simple 9-slice-ish blank panel if generated one has junk
    panel = Image.new("RGB", (1024, 512), (28, 22, 16))
    d = ImageDraw.Draw(panel)
    d.rectangle([8, 8, 1015, 503], outline=(184, 150, 78), width=4)
    d.rectangle([18, 18, 1005, 493], outline=(62, 48, 32), width=2)
    save_jpg(panel, UI / "panel_blank.jpg")
    print("done", GAME)


if __name__ == "__main__":
    main()
