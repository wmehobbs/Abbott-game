"""Crop the UV face island so we can paint Abbott's blaze, then paste back."""
from pathlib import Path
from PIL import Image

ROOT = Path(r"E:\Workspace\Madison")
SRC = ROOT / "game" / "assets" / "meshes" / "rancher" / "horse" / "HorseMain2k00.png"
OUT = ROOT / "game" / "assets" / "meshes" / "abbott_tex"
OUT.mkdir(parents=True, exist_ok=True)

im = Image.open(SRC).convert("RGB")
# Face island sits on the left of the flattened hide.
face = im.crop((0, 640, 560, 1480))
face.save(OUT / "uv_face_crop.png")
print("crop", face.size)
