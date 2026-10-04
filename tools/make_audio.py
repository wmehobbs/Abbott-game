"""Pull CC0 horse/arena recordings, slice hoof one-shots, render rider cues.

Sources (all CC0 / public domain):
  BigSoundBank — Joseph SARDIN / Thorgal field recordings
  Internet Archive Red Library: Animals Horses 1 (USC Cinema, CC0 1.0)
Rider lines: local edge-tts (not Madison's voice).
"""
from __future__ import annotations

import asyncio
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
RIDER = OUT / "rider"
for p in (RAW, OUT, HOOF, HORSE, RIDER):
    p.mkdir(parents=True, exist_ok=True)

SR = 44100
UA = "AbbottGame/1.0 (Hidden K local build; CC0 asset fetch)"


def fetch(url: str, dest: Path) -> bool:
    if dest.exists() and dest.stat().st_size > 2000:
        print("have", dest.name)
        return True
    print("GET", url)
    req = urllib.request.Request(url, headers={"User-Agent": UA})
    try:
        with urllib.request.urlopen(req, timeout=60) as r:
            dest.write_bytes(r.read())
        print("  ->", dest.name, dest.stat().st_size)
        return dest.stat().st_size > 2000
    except Exception as e:
        print("  FAIL", e)
        return False


def to_wav(src: Path, dest: Path, seconds: float | None = None) -> bool:
    cmd = [
        "ffmpeg", "-y", "-i", str(src),
        "-ac", "1", "-ar", str(SR), "-sample_fmt", "s16",
        "-af", "highpass=f=60,lowpass=f=9000,loudnorm=I=-16:TP=-1.5:LRA=11",
    ]
    if seconds:
        cmd += ["-t", f"{seconds:.2f}"]
    cmd.append(str(dest))
    r = subprocess.run(cmd, capture_output=True, text=True)
    if r.returncode != 0:
        # retry without loudnorm (some clips too short)
        cmd = [
            "ffmpeg", "-y", "-i", str(src),
            "-ac", "1", "-ar", str(SR), "-sample_fmt", "s16",
            str(dest),
        ]
        r = subprocess.run(cmd, capture_output=True, text=True)
    if r.returncode != 0:
        print("ffmpeg fail", src.name, r.stderr[-400:])
        return False
    return dest.exists()


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
    print("wrote", path.name, f"{len(x)/SR:.2f}s")


def fade(x: np.ndarray, ms_in: float = 4.0, ms_out: float = 12.0) -> np.ndarray:
    n_in = max(1, int(SR * ms_in / 1000.0))
    n_out = max(1, int(SR * ms_out / 1000.0))
    y = x.copy()
    n_in = min(n_in, len(y) // 3)
    n_out = min(n_out, len(y) // 3)
    y[:n_in] *= np.linspace(0, 1, n_in)
    y[-n_out:] *= np.linspace(1, 0, n_out)
    return y


def sand_crunch(n: int, rng: np.random.Generator) -> np.ndarray:
    """Quiet arena footing under a real hoof — sand, not asphalt."""
    noise = rng.standard_normal(n).astype(np.float32)
    # crude band-limit via moving average
    k = 9
    kernel = np.ones(k, dtype=np.float32) / k
    sand = np.convolve(noise, kernel, mode="same")
    t = np.linspace(0, 1, n, dtype=np.float32)
    env = np.exp(-t * 14.0) * (1.0 - t)
    return sand * env * 0.18


def slice_hits(x: np.ndarray, count: int, pre_ms: float = 12.0, post_ms: float = 160.0) -> list[np.ndarray]:
    win = int(0.012 * SR)
    env = np.convolve(np.abs(x), np.ones(win) / win, mode="same")
    thr = max(0.08, float(np.percentile(env, 82)))
    min_gap = int(0.14 * SR)
    peaks: list[int] = []
    i = win
    while i < len(env) - win:
        if env[i] >= thr and env[i] >= env[i - 1] and env[i] >= env[i + 1]:
            if not peaks or i - peaks[-1] >= min_gap:
                peaks.append(i)
                i += min_gap
                continue
        i += 1
    # strongest first, keep temporal spread
    peaks = sorted(peaks, key=lambda p: env[p], reverse=True)[: max(count * 3, count)]
    peaks = sorted(peaks)
    # pick evenly
    if len(peaks) > count:
        idx = np.linspace(0, len(peaks) - 1, count).astype(int)
        peaks = [peaks[i] for i in idx]
    pre = int(pre_ms * SR / 1000.0)
    post = int(post_ms * SR / 1000.0)
    rng = np.random.default_rng(14)
    out: list[np.ndarray] = []
    for p in peaks:
        a = max(0, p - pre)
        b = min(len(x), p + post)
        hit = fade(x[a:b])
        peak = float(np.max(np.abs(hit)) + 1e-6)
        hit = hit / peak * 0.92
        hit = hit + sand_crunch(len(hit), rng)
        out.append(np.clip(hit, -1.0, 1.0))
    return out


def loop_ambience(parts: list[np.ndarray], seconds: float = 24.0) -> np.ndarray:
    n = int(seconds * SR)
    y = np.zeros(n, dtype=np.float32)
    rng = np.random.default_rng(7)
    for src in parts:
        if src is None or len(src) < SR:
            continue
        # tile
        reps = int(np.ceil(n / len(src))) + 1
        tiled = np.tile(src, reps)[:n]
        # overlap-fade the loop join already in src; scale down
        y += tiled * (0.22 if np.max(np.abs(src)) > 0.01 else 0.0)
    # light air
    air = rng.standard_normal(n).astype(np.float32)
    air = np.convolve(air, np.ones(21) / 21.0, mode="same")
    y += air * 0.012
    peak = float(np.max(np.abs(y)) + 1e-6)
    y = y / peak * 0.28
    # loop-friendly fade at ends
    xf = int(0.4 * SR)
    y[:xf] *= np.linspace(0, 1, xf)
    y[-xf:] *= np.linspace(1, 0, xf)
    # match start/end roughly
    y[-xf:] = y[-xf:] * np.linspace(1, 0, xf) + y[:xf] * np.linspace(0, 1, xf)
    return np.clip(y, -1.0, 1.0)


async def rider_lines() -> None:
    import edge_tts

    voice = "en-US-AriaNeural"
    lines = {
        "walk_on": "Walk on.",
        "trot": "Trot.",
        "canter": "Canter.",
        "whoa": "Whoa.",
        "easy": "Easy.",
        "good_boy": "Good boy.",
        "come_on": "Come on.",
        "steady": "Steady.",
        "and_up": "And up.",
    }
    for name, text in lines.items():
        dest = RIDER / f"{name}.wav"
        mp3 = RAW / f"rider_{name}.mp3"
        if dest.exists() and dest.stat().st_size > 1000:
            continue
        print("tts", name, text)
        comm = edge_tts.Communicate(text, voice, rate="-8%", pitch="-2Hz")
        await comm.save(str(mp3))
        to_wav(mp3, dest)


def main() -> None:
    for num, name in {
        610: "trot_foley",
        611: "gallop_foley",
        286: "breath",
        284: "neigh",
        1218: "nicker",
        1854: "walk_path",
        1852: "trot_grass",
        1850: "canter_grass",
    }.items():
        fetch(f"https://bigsoundbank.com/UPLOAD/mp3/{num:04d}.mp3", RAW / f"bsb_{name}.mp3")

    ia = "https://archive.org/download/Red_Library_Animals_Horses_1/"
    for fn, local in [
        ("R13-04-Horse%20Snort.wav", "ia_snort.wav"),
        ("R13-05-Horse%20Breathing.wav", "ia_breathing.wav"),
        ("R13-33-Horse%20Breath%20and%20Snort.wav", "ia_breath_snort.wav"),
        ("R12-57-Horses%20Snorting.wav", "ia_snorts.wav"),
        ("R13-01-Scared%20Horse.wav", "ia_scared.wav"),
        ("R04-54-Horses%20Walk%20on%20Hard%20Floor%20in%20Reverberant%20Space.wav", "ia_walk_floor.wav"),
        ("R13-11-Horse%20on%20Sand%20or%20Dirt.wav", "ia_sand.wav"),
        ("R13-13-Horse%20Steady%20on%20Dirt.wav", "ia_dirt.wav"),
        ("R13-10-Horse%20Gallop.wav", "ia_gallop.wav"),
        ("R13-09-Horse%20on%20Ground.wav", "ia_ground.wav"),
        ("R13-16-Soft%20Hoof%20Sounds.wav", "ia_soft.wav"),
        ("R13-19-Muffled%20Hooves.wav", "ia_muffled.wav"),
        ("R13-22-Horse%20Runs%20on%20Soft%20Ground.wav", "ia_soft_run.wav"),
        ("R13-26-Horse%20Muffled%20Hooves%20on%20Dirt.wav", "ia_muffled_dirt.wav"),
        ("R13-07-Horse%20on%20Wood.wav", "ia_wood.wav"),
        ("R12-55-Small%20Horse%20Whinnies.wav", "ia_whinny.wav"),
        ("R13-25-Horse%20on%20Pavement%20with%20Birds.wav", "ia_birds_bed.wav"),
        ("R13-32-Horse%20in%20Tall%20Grass.wav", "ia_grass.wav"),
    ]:
        fetch(ia + fn, RAW / local)
    fetch(
        "https://upload.wikimedia.org/wikipedia/commons/4/45/Wiehern.ogg",
        RAW / "wiki_neigh.ogg",
    )

    # Convert everything we got to work wavs
    work: dict[str, Path] = {}
    for src in RAW.glob("*"):
        if src.suffix.lower() not in {".wav", ".mp3", ".ogg", ".flac"}:
            continue
        if src.name.startswith("rider_"):
            continue
        dest = RAW / f"w_{src.stem}.wav"
        if dest.exists() and dest.stat().st_size > 2000:
            work[src.stem] = dest
            continue
        if to_wav(src, dest):
            work[src.stem] = dest

    def load(key_sub: str) -> np.ndarray | None:
        for k, p in work.items():
            if key_sub in k:
                return read_wav(p)
        return None

    def first(*keys: str) -> np.ndarray | None:
        for k in keys:
            v = load(k)
            if v is not None:
                return v
        return None

    walk = first("ia_sand", "ia_dirt", "ia_muffled_dirt", "ia_soft", "walk_path", "ia_walk")
    trot = first("ia_ground", "ia_muffled", "trot_grass", "trot_foley")
    canter = first("ia_gallop", "ia_soft_run", "canter_grass", "gallop_foley")

    hits: list[np.ndarray] = []
    for src, n in ((walk, 6), (trot, 5), (canter, 5)):
        if src is not None:
            hits.extend(slice_hits(src, n))
    if not hits:
        raise SystemExit("no hoof source audio")

    rng = np.random.default_rng(21)
    rng.shuffle(hits)
    for i, h in enumerate(hits[:12], start=1):
        write_wav(HOOF / f"hit_{i:02d}.wav", h)

    def clip_best(src: np.ndarray | None, seconds: float, name: str, dest: Path) -> None:
        if src is None:
            return
        # take the loudest window
        win = int(seconds * SR)
        if len(src) <= win:
            write_wav(dest, fade(src, 8, 30))
            return
        env = np.convolve(np.abs(src), np.ones(int(0.02 * SR)) / (0.02 * SR), mode="same")
        i = int(np.argmax(env))
        a = max(0, i - win // 3)
        b = min(len(src), a + win)
        write_wav(dest, fade(src[a:b], 8, 40))

    clip_best(first("ia_snort", "breath"), 1.2, "snort", HORSE / "snort.wav")
    clip_best(first("ia_breathing", "breath"), 1.6, "blow", HORSE / "blow.wav")
    clip_best(first("nicker", "ia_whinny", "neigh"), 1.4, "nicker", HORSE / "nicker.wav")
    clip_best(first("ia_breath_snort", "ia_snorts"), 0.7, "grunt", HORSE / "grunt.wav")
    clip_best(first("wiki_neigh", "ia_whinny", "neigh", "neigh5"), 2.2, "neigh", HORSE / "neigh.wav")

    # land: heavier canter hit
    if hits:
        land = hits[0] * 1.05
        if len(hits) > 1:
            # stack two for weight
            b = hits[1]
            n = max(len(land), len(b) + int(0.03 * SR))
            acc = np.zeros(n, dtype=np.float32)
            acc[: len(land)] += land
            acc[int(0.03 * SR) : int(0.03 * SR) + len(b)] += b * 0.7
            land = acc
        write_wav(OUT / "land.wav", fade(np.clip(land, -1, 1), 2, 40))

    wood_src = first("ia_wood")
    if wood_src is not None:
        clip_best(wood_src, 0.7, "rail", OUT / "rail.wav")
    else:
        rail_n = int(0.55 * SR)
        t = np.linspace(0, 0.55, rail_n, dtype=np.float32)
        rng2 = np.random.default_rng(9)
        wood = rng2.standard_normal(rail_n).astype(np.float32)
        wood = np.convolve(wood, np.ones(5) / 5, mode="same")
        wood *= np.exp(-t * 8.0)
        thud = 0.5 * np.sin(2 * np.pi * 90 * t) * np.exp(-t * 14)
        write_wav(OUT / "rail.wav", fade(np.clip(wood * 0.7 + thud, -1, 1), 1, 50))

    # refuse: skid sand + snort will play separately; this is the stop
    rng2 = np.random.default_rng(9)
    skid = rng2.standard_normal(int(0.4 * SR)).astype(np.float32)
    skid = np.convolve(skid, np.ones(7) / 7, mode="same")
    ts = np.linspace(0, 1, len(skid), dtype=np.float32)
    skid *= (1 - ts) * 0.55
    write_wav(OUT / "refuse.wav", fade(skid, 4, 40))

    birds = first("ia_birds_bed", "birds", "forest_birds")
    wind = first("wind_light")
    parts = [p for p in (birds, wind) if p is not None]
    if parts:
        amb = loop_ambience(parts, 22.0)
        write_wav(OUT / "ambient_outdoor.wav", amb)
        write_wav(OUT / "ambient_indoor.wav", amb * 0.65)

    asyncio.run(rider_lines())

    attr = OUT / "ATTRIBUTION.txt"
    attr.write_text(
        "\n".join(
            [
                "Audio — Abbott (Hidden K)",
                "",
                "Horse hooves on sand/dirt, gallop, snorts, breathing:",
                "  USC Cinema Red Library 'Animals Horses 1' via Internet Archive, CC0 1.0.",
                "Extra walk/trot/canter field recordings: BigSoundBank, CC0",
                "  (Thorgal / Joseph SARDIN). Horse breath and nicker, same.",
                "Rider cues: synthesized (Aria neural TTS). Not a recording of Madison.",
                "Arena footing layer: original sand grain under the real hoof hits.",
                "",
            ]
        ),
        encoding="utf-8",
    )
    print("done")


if __name__ == "__main__":
    main()
