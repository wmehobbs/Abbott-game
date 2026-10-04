"""Download Pixabay walking-horse SFX (Content License) and slice real hoof hits.

Does not open Godot. Uses files already on disk from Internet Archive if Pixabay blocks.
"""
from __future__ import annotations

import os
import subprocess
import urllib.request
from pathlib import Path

import numpy as np

ROOT = Path(r"E:\Workspace\Madison")
RAW = ROOT / "tools" / "audio_raw"
OUT = ROOT / "game" / "assets" / "audio"
HOOF = OUT / "hoof"
HORSE = OUT / "horse"
for p in (RAW / "pixabay", HOOF, HORSE):
    p.mkdir(parents=True, exist_ok=True)

UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36"
SR = 44100

PAGES = [
    ("https://pixabay.com/sound-effects/nature-horse-walking-123782/", "walk"),
    ("https://pixabay.com/sound-effects/nature-horse-galloping-339737/", "gallop"),
    ("https://pixabay.com/sound-effects/nature-horse-snort-364469/", "snort"),
    ("https://pixabay.com/sound-effects/nature-horses-hooves-step-sound-on-the-ground-239720/", "hooves"),
    ("https://pixabay.com/sound-effects/nature-gentle-horse-whinny-499650/", "whinny"),
    ("https://pixabay.com/sound-effects/nature-horse-neigh-515279/", "neigh"),
    ("https://pixabay.com/sound-effects/horse-walking-sound-1-450265/", "walk1"),
    ("https://pixabay.com/sound-effects/horse-walking-sound-2-450264/", "walk2"),
    ("https://pixabay.com/sound-effects/nature-the-horse-neighed-433882/", "neigh2"),
]


def fetch(url: str, dest: Path) -> bool:
    if dest.exists() and dest.stat().st_size > 2000:
        print("have", dest.name, dest.stat().st_size)
        return True
    print("GET", url)
    req = urllib.request.Request(url, headers={"User-Agent": UA, "Referer": "https://pixabay.com/"})
    try:
        with urllib.request.urlopen(req, timeout=45) as r:
            dest.write_bytes(r.read())
        print("  ->", dest.name, dest.stat().st_size)
        return dest.stat().st_size > 2000
    except Exception as e:
        print("  FAIL", e)
        return False


def to_wav(src: Path, dest: Path) -> bool:
    if dest.exists() and dest.stat().st_size > 2000:
        return True
    cmd = [
        "ffmpeg", "-y", "-i", str(src),
        "-ac", "1", "-ar", str(SR), "-sample_fmt", "s16",
        str(dest),
    ]
    r = subprocess.run(cmd, capture_output=True, text=True)
    return r.returncode == 0 and dest.exists()


def read_wav(path: Path) -> np.ndarray:
    import wave
    with wave.open(str(path), "rb") as w:
        n, sw, rate, frames, _, _ = w.getparams()
        raw = w.readframes(frames)
    x = np.frombuffer(raw, dtype=np.int16).astype(np.float32) / 32768.0
    if n == 2:
        x = x.reshape(-1, 2).mean(axis=1)
    if rate != SR:
        t_old = np.linspace(0, 1, len(x), endpoint=False)
        t_new = np.linspace(0, 1, int(len(x) * SR / rate), endpoint=False)
        x = np.interp(t_new, t_old, x)
    return x


def write_wav(path: Path, x: np.ndarray) -> None:
    import wave
    x = np.clip(x, -1.0, 1.0)
    pcm = (x * 32767.0).astype(np.int16)
    with wave.open(str(path), "wb") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(SR)
        w.writeframes(pcm.tobytes())
    print("wrote", path, f"{len(x)/SR:.2f}s")


def fade(x: np.ndarray, ms_in: float = 3.0, ms_out: float = 40.0) -> np.ndarray:
    n_in = max(1, int(SR * ms_in / 1000.0))
    n_out = max(1, int(SR * ms_out / 1000.0))
    y = x.copy()
    n_in = min(n_in, len(y) // 4)
    n_out = min(n_out, len(y) // 4)
    y[:n_in] *= np.linspace(0, 1, n_in)
    y[-n_out:] *= np.linspace(1, 0, n_out)
    return y


def slice_hits(x: np.ndarray, count: int) -> list[np.ndarray]:
    win = int(0.014 * SR)
    env = np.convolve(np.abs(x), np.ones(win) / win, mode="same")
    thr = max(0.07, float(np.percentile(env, 78)))
    min_gap = int(0.16 * SR)
    peaks: list[int] = []
    i = win
    while i < len(env) - win:
        if env[i] >= thr and env[i] >= env[i - 1] and env[i] >= env[i + 1]:
            if not peaks or i - peaks[-1] >= min_gap:
                peaks.append(i)
                i += min_gap
                continue
        i += 1
    if not peaks:
        return []
    if len(peaks) > count:
        idx = np.linspace(0, len(peaks) - 1, count).astype(int)
        peaks = [peaks[i] for i in idx]
    pre, post = int(0.02 * SR), int(0.28 * SR)
    out = []
    for p in peaks:
        a = max(0, p - pre)
        b = min(len(x), p + post)
        hit = fade(x[a:b])
        peak = float(np.max(np.abs(hit)) + 1e-6)
        out.append(np.clip(hit / peak * 0.90, -1, 1))
    return out


def clip_loudest(x: np.ndarray, seconds: float) -> np.ndarray:
    win = int(seconds * SR)
    if len(x) <= win:
        return fade(x, 8, 40)
    env = np.convolve(np.abs(x), np.ones(int(0.02 * SR)) / (0.02 * SR), mode="same")
    i = int(np.argmax(env))
    a = max(0, i - win // 3)
    b = min(len(x), a + win)
    return fade(x[a:b], 8, 50)


def main() -> None:
    got: list[Path] = []
    for page, name in PAGES:
        html_path = RAW / "pixabay" / f"{name}.html"
        fetch(page, html_path)
        html = html_path.read_text(encoding="utf-8", errors="ignore") if html_path.exists() else ""
        mp3s = []
        for token in html.replace("\\/", "/").split('"'):
            if "cdn.pixabay.com" in token and (".mp3" in token or "download/audio" in token):
                mp3s.append(token.split("?")[0])
        mp3s = list(dict.fromkeys(mp3s))
        print(name, "mp3 candidates", mp3s[:4])
        dest = RAW / "pixabay" / f"{name}.mp3"
        for u in mp3s:
            if fetch(u, dest):
                got.append(dest)
                break

    wavs: dict[str, np.ndarray] = {}
    for src in list((RAW / "pixabay").glob("*.mp3")) + list(RAW.glob("ia_*.wav")) + list(RAW.glob("bsb_*.mp3")):
        wpath = RAW / f"w_{src.stem}.wav"
        if to_wav(src, wpath):
            wavs[src.stem] = read_wav(wpath)

    def first(*keys: str) -> np.ndarray | None:
        for k, v in wavs.items():
            for key in keys:
                if key in k:
                    return v
        return None

    walk = first("walk", "hooves", "ia_sand", "ia_dirt", "ia_muffled")
    gallop = first("gallop", "ia_gallop", "ia_soft_run", "canter")
    hits: list[np.ndarray] = []
    if walk is not None:
        hits.extend(slice_hits(walk, 8))
    if gallop is not None:
        hits.extend(slice_hits(gallop, 6))
    if not hits:
        raise SystemExit("no hoof source")
    for i, h in enumerate(hits[:12], start=1):
        write_wav(HOOF / f"hit_{i:02d}.wav", h)

    sn = first("snort", "ia_snort", "ia_breath")
    if sn is not None:
        write_wav(HORSE / "snort.wav", clip_loudest(sn, 1.1))
    wh = first("whinny", "neigh", "ia_whinny")
    if wh is not None:
        write_wav(HORSE / "nicker.wav", clip_loudest(wh, 1.3))
        write_wav(HORSE / "neigh.wav", clip_loudest(wh, 2.0))
    br = first("ia_breathing", "snort")
    if br is not None:
        write_wav(HORSE / "blow.wav", clip_loudest(br, 1.4))
        write_wav(HORSE / "grunt.wav", clip_loudest(br, 0.6))

    attr = OUT / "ATTRIBUTION.txt"
    attr.write_text(
        "\n".join(
            [
                "Audio — Abbott (Hidden K)",
                "",
                "Walking / galloping / snort / neigh: Pixabay Content License",
                "  (pages linked from pixabay.com/sound-effects/search/walking%20horse/).",
                "Additional hoof and snort: USC Cinema Red Library via Internet Archive, CC0.",
                "Rider cues: synthesized (Aria neural TTS). Not Madison.",
                "",
            ]
        ),
        encoding="utf-8",
    )
    print("done", "sources", list(wavs.keys()))


if __name__ == "__main__":
    main()
