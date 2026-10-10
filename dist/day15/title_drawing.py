"""The title art: Abbott drawn in sepia ink and watercolour from his stall photo,
fading into paper, framed 16:9 so his whole head shows.

usage: python dist/day15/title_drawing.py [ink_eps 0.40] [tint 0.80] [out name]
The title uses: python dist/day15/title_drawing.py 0.40 0.80 abbott_title_drawn
then save <out>_169.png as game/assets/photos/abbott_title_drawn.jpg (quality 92).
Lower ink_eps = less ink in the shadows; higher tint = more colour."""
import cv2
import numpy as np
import sys

SRC = "E:/Workspace/Madison/game/assets/photos/abbott_title.jpg"
img = cv2.imread(SRC)
H, W = img.shape[:2]
PAPER = np.array((222, 236, 246), np.float32)
EPS = float(sys.argv[1]) if len(sys.argv) > 1 else 0.40
TINT = float(sys.argv[2]) if len(sys.argv) > 2 else 0.80
OUT = sys.argv[3] if len(sys.argv) > 3 else "sketch"

lab = cv2.cvtColor(img, cv2.COLOR_BGR2LAB)
l, a, b = cv2.split(lab)
l = cv2.createCLAHE(clipLimit=2.6, tileGridSize=(8, 8)).apply(l)
l = cv2.LUT(l, np.array([((i / 255.0) ** 0.70) * 255 for i in range(256)], np.uint8))
bright = cv2.cvtColor(cv2.merge([l, a, b]), cv2.COLOR_LAB2BGR)
smooth = cv2.edgePreservingFilter(bright, flags=cv2.RECURS_FILTER, sigma_s=40, sigma_r=0.22)
gray = cv2.cvtColor(smooth, cv2.COLOR_BGR2GRAY).astype(np.float32) / 255.0

# XDoG: edges as pen lines, the darkest tones as soft ink.
s1 = 1.0
g1 = cv2.GaussianBlur(gray, (0, 0), s1)
g2 = cv2.GaussianBlur(gray, (0, 0), s1 * 1.6)
d = 19.0 * g1 - 18.0 * g2
ink = np.where(d >= EPS, 1.0, 1.0 + np.tanh(9.0 * (d - EPS)))
ink = np.clip(ink, 0, 1)
# Tidy specks.
mask = (ink < 0.5).astype(np.uint8)
n, lab_, stats, _ = cv2.connectedComponentsWithStats(mask, 8)
small = np.zeros(n, bool)
small[1:] = stats[1:, cv2.CC_STAT_AREA] < 40
ink[(mask == 1) & small[lab_]] = 1.0
ink = cv2.GaussianBlur(ink, (0, 0), 0.6)

# A light watercolour tint under the ink.
tint = cv2.stylization(bright, sigma_s=90, sigma_r=0.45)
th = cv2.cvtColor(tint, cv2.COLOR_BGR2HSV).astype(np.float32)
th[..., 1] = np.clip(th[..., 1] * 1.35, 0, 255)
tint = cv2.cvtColor(th.astype(np.uint8), cv2.COLOR_HSV2BGR).astype(np.float32)
tint = PAPER * (1 - TINT) + tint * TINT

# Vignette with the photo's own edges faded, lines included.
yy, xx = np.mgrid[0:H, 0:W].astype(np.float32)
r = np.sqrt(((xx - W * 0.47) / (W * 0.50)) ** 2 + ((yy - H * 0.50) / (H * 0.62)) ** 2)
m = np.clip(1.0 - (r - 0.60) / 0.40, 0.0, 1.0)
m = m * m * (3 - 2 * m)
edge = np.clip(xx / (W * 0.20), 0, 1) * np.clip((W - xx) / (W * 0.20), 0, 1)
m *= edge * edge * (3 - 2 * edge)
rng = np.random.default_rng(7)
nz = cv2.resize(cv2.GaussianBlur(rng.normal(0, 1, (H // 8, W // 8)).astype(np.float32), (0, 0), 2.0), (W, H))
m = np.clip(m + nz * 0.35 * m * (1 - m), 0, 1)

colour = tint * m[..., None] + PAPER * (1 - m[..., None])
lines = 1.0 - (1.0 - ink) * m
INK = np.array((34, 44, 62), np.float32)  # sepia, BGR
art = colour * lines[..., None] + INK * (1.0 - lines[..., None])
grain = cv2.GaussianBlur(rng.normal(0, 1, (H, W)).astype(np.float32), (0, 0), 0.8)
art = np.clip(art + grain[..., None] * 3.0, 0, 255).astype(np.uint8)

OW, OH = 2560, 1440
scale = OH * 1.04 / H
hw, hh = int(W * scale), int(H * scale)
head = cv2.resize(art, (hw, hh), interpolation=cv2.INTER_AREA)
canvas = np.empty((OH, OW, 3), np.float32)
canvas[:] = PAPER
canvas += cv2.resize(grain, (OW, OH))[..., None] * 3.0
x0 = int(OW * 0.56 - hw / 2)
y0 = int((OH - hh) * 0.5)
canvas[0:OH, x0: x0 + hw] = head[-y0: -y0 + OH, :]
cv2.imwrite(OUT + "_169.png", np.clip(canvas, 0, 255).astype(np.uint8))
print("done", OUT)
