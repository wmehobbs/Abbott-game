"""One contact sheet for a playthrough folder of pngs.

usage: python dist/day17/contact_sheet.py <round dir> <out png> [title]
"""
import os
import sys
from PIL import Image, ImageDraw, ImageFont


def main() -> None:
    folder = sys.argv[1]
    out = sys.argv[2]
    title = sys.argv[3] if len(sys.argv) > 3 else os.path.basename(folder.rstrip("\\/"))
    names = sorted(n for n in os.listdir(folder) if n.lower().endswith(".png"))
    if not names:
        raise SystemExit("no pngs in " + folder)
    cols = 6
    thumb_w = 320
    label_h = 22
    pad = 8
    font = ImageFont.load_default()
    thumbs = []
    for name in names:
        im = Image.open(os.path.join(folder, name)).convert("RGB")
        h = max(1, int(im.height * thumb_w / im.width))
        im = im.resize((thumb_w, h), Image.Resampling.LANCZOS)
        thumbs.append((name, im))
    rows = (len(thumbs) + cols - 1) // cols
    cell_h = thumbs[0][1].height + label_h
    sheet = Image.new("RGB", (pad + cols * (thumb_w + pad), 36 + pad + rows * (cell_h + pad)), (24, 22, 18))
    draw = ImageDraw.Draw(sheet)
    draw.text((pad, 8), title, fill=(245, 236, 214), font=font)
    for i, (name, im) in enumerate(thumbs):
        c = i % cols
        r = i // cols
        x = pad + c * (thumb_w + pad)
        y = 36 + pad + r * (cell_h + pad)
        sheet.paste(im, (x, y + label_h))
        draw.text((x, y), name, fill=(230, 220, 190), font=font)
    os.makedirs(os.path.dirname(os.path.abspath(out)), exist_ok=True)
    sheet.save(out)
    print("SHEET", out, "frames", len(thumbs))


if __name__ == "__main__":
    main()
