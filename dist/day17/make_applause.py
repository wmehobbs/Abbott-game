"""A short crowd applause, built with numpy. Nothing is downloaded.

Writes game/assets/audio/crowd/applause.wav (44.1 kHz, 16-bit, stereo)
and a spectrogram at dist/day17/review/e_applause_spec.png.
"""
import wave
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw, ImageFont

ROOT = Path(r"E:\Workspace\Madison")
OUT = ROOT / "game" / "assets" / "audio" / "crowd" / "applause.wav"
SPEC = ROOT / "dist" / "day17" / "review" / "e_applause_spec.png"

SR = 44100
DUR = 4.5
PEOPLE = 40
FADE_IN = 0.3
FADE_OUT = 1.5


def _burst(rng: np.random.Generator, lo: float, hi: float) -> np.ndarray:
	# A few dozen milliseconds. Decay first, then keep only the bright band,
	# so the clap stays short and does not rumble.
	n = int(0.05 * SR)
	t = np.arange(n) / SR
	x = rng.standard_normal(n) * np.exp(-t / rng.uniform(0.006, 0.014))
	spec = np.fft.rfft(x)
	freqs = np.fft.rfftfreq(n, 1.0 / SR)
	# Soft edges, so the cut does not ring.
	bw = max(hi - lo, 1.0)
	edge = 0.18 * bw
	weight = np.clip((freqs - (lo - edge)) / edge, 0.0, 1.0)
	weight *= np.clip(((hi + edge) - freqs) / edge, 0.0, 1.0)
	y = np.fft.irfft(spec * weight, n)
	peak = float(np.max(np.abs(y)))
	if peak > 0.0:
		y /= peak
	return y


def build() -> tuple[np.ndarray, np.ndarray]:
	rng = np.random.default_rng(17)
	n = int(SR * DUR)
	left = np.zeros(n, dtype=np.float64)
	right = np.zeros(n, dtype=np.float64)
	for _p in range(PEOPLE):
		rate = float(rng.uniform(3.0, 6.0))
		center = float(rng.uniform(1700.0, 3100.0))
		half = float(rng.uniform(450.0, 900.0))
		lo = max(1000.0, center - half)
		hi = min(4000.0, center + half)
		pan = float(rng.uniform(-0.45, 0.45))
		gain_l = np.sqrt(0.5 * (1.0 - pan))
		gain_r = np.sqrt(0.5 * (1.0 + pan))
		loud = float(rng.uniform(0.65, 1.0))
		when = float(rng.uniform(0.0, 0.2))
		while when < DUR - 0.04:
			burst = _burst(rng, lo, hi) * loud
			start = int(when * SR)
			end = min(n, start + burst.size)
			span = end - start
			left[start:end] += burst[:span] * gain_l
			right[start:end] += burst[:span] * gain_r
			when += (1.0 / rate) * float(rng.uniform(0.8, 1.25))
	env = np.ones(n)
	n_in = int(FADE_IN * SR)
	n_out = int(FADE_OUT * SR)
	env[:n_in] = np.linspace(0.0, 1.0, n_in)
	env[-n_out:] = np.cos(np.linspace(0.0, np.pi * 0.5, n_out))
	left *= env
	right *= env
	peak = max(float(np.max(np.abs(left))), float(np.max(np.abs(right))))
	if peak > 0.0:
		left *= 0.89 / peak
		right *= 0.89 / peak
	return left, right


def _write(left: np.ndarray, right: np.ndarray) -> None:
	OUT.parent.mkdir(parents=True, exist_ok=True)
	pcm = np.stack([left, right], axis=1)
	ints = np.clip(np.round(pcm * 32767.0), -32767, 32767).astype(np.int16)
	with wave.open(str(OUT), "wb") as handle:
		handle.setnchannels(2)
		handle.setsampwidth(2)
		handle.setframerate(SR)
		handle.writeframes(ints.tobytes())


def _report(left: np.ndarray, right: np.ndarray) -> None:
	mono = 0.5 * (left + right)
	n = mono.size
	spec = np.abs(np.fft.rfft(mono)) ** 2
	freqs = np.fft.rfftfreq(n, 1.0 / SR)
	total = float(spec.sum())
	band = float(spec[(freqs >= 1000.0) & (freqs <= 4000.0)].sum())
	peak = max(float(np.max(np.abs(left))), float(np.max(np.abs(right))))
	rms = float(np.sqrt(np.mean(np.stack([left, right]) ** 2)))
	print(
		"duration=%.3fs peak=%.4f rms=%.4f energy_1_4kHz=%.3f"
		% (n / SR, peak, rms, band / total if total else 0.0)
	)
	# One spectrogram, about 40 columns a second, so the fade is visible.
	hop = SR // 40
	win = 1024
	cols = 1 + (n - win) // hop
	rows = win // 2 + 1
	stft = np.zeros((rows, cols))
	window = np.hanning(win)
	for i in range(cols):
		chunk = mono[i * hop : i * hop + win] * window
		stft[:, i] = np.abs(np.fft.rfft(chunk))
	# Keep 0 to 6 kHz so the 1–4 kHz band is the bright part, not the whole picture.
	hi = int(6000.0 / SR * win)
	view = stft[:hi]
	view = np.log10(view + 1e-8)
	view -= view.min()
	view /= max(float(view.max()), 1e-8)
	# Low frequency at the bottom.
	img = (np.clip(view, 0.0, 1.0) * 255).astype(np.uint8)[::-1]
	pict = Image.fromarray(img, mode="L").resize((900, 360), Image.Resampling.NEAREST)
	color = Image.merge("RGB", (pict, pict, pict))
	draw = ImageDraw.Draw(color)
	font = ImageFont.truetype(r"C:\Windows\Fonts\segoeui.ttf", 16)
	# 1 kHz and 4 kHz guides. The picture's top is 6 kHz.
	for hz, label in ((1000, "1 kHz"), (4000, "4 kHz")):
		y = int((1.0 - hz / 6000.0) * pict.size[1])
		draw.line((0, y, pict.size[0], y), fill=(220, 160, 60))
		draw.text((8, y + 2), label, fill=(236, 210, 150), font=font)
	draw.text((8, 6), "Applause, 4.5 s. Bright between the lines.", fill=(240, 236, 226), font=font)
	SPEC.parent.mkdir(parents=True, exist_ok=True)
	color.save(SPEC)
	print("spec", SPEC)


def main() -> None:
	left, right = build()
	_write(left, right)
	_report(left, right)
	print("wav", OUT)


if __name__ == "__main__":
	main()
