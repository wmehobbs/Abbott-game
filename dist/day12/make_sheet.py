"""Contact sheets and before/after sheets. JPGs are 1280 px wide. No windows."""
import os
import sys

from PIL import Image, ImageDraw, ImageFont

WIDE = 1280


def load_wide(path: str) -> Image.Image:
    im = Image.open(path).convert("RGB")
    h = max(1, int(im.height * WIDE / im.width))
    return im.resize((WIDE, h), Image.Resampling.LANCZOS)


def contact(folder: str, out_path: str) -> None:
    names = sorted(n for n in os.listdir(folder) if n.lower().endswith(".png"))
    if not names:
        raise SystemExit("no pngs in " + folder)
    thumbs = []
    for n in names:
        im = load_wide(os.path.join(folder, n))
        thumb_h = 180
        thumb = im.resize((320, thumb_h), Image.Resampling.LANCZOS)
        thumbs.append((n, thumb))
    cols = 4
    rows = (len(thumbs) + cols - 1) // cols
    sheet = Image.new("RGB", (cols * 320, rows * 210), (24, 20, 16))
    draw = ImageDraw.Draw(sheet)
    font = ImageFont.load_default()
    for i, (n, thumb) in enumerate(thumbs):
        x = (i % cols) * 320
        y = (i // cols) * 210
        sheet.paste(thumb, (x, y))
        draw.text((x + 6, y + 184), n.replace(".png", ""), fill=(240, 230, 210), font=font)
    sheet.save(out_path, quality=85)
    print("SHEET", out_path, len(names))


def pair(before_dir: str, after_dir: str, out_path: str) -> None:
    names = sorted(
        n
        for n in os.listdir(after_dir)
        if n.lower().endswith(".png") and os.path.exists(os.path.join(before_dir, n))
    )
    if not names:
        raise SystemExit("no matching pngs")
    blocks = []
    for n in names:
        a = load_wide(os.path.join(before_dir, n))
        b = load_wide(os.path.join(after_dir, n))
        h = max(a.height, b.height)
        block = Image.new("RGB", (WIDE * 2 + 16, h + 28), (24, 20, 16))
        block.paste(a, (0, 28))
        block.paste(b, (WIDE + 16, 28))
        d = ImageDraw.Draw(block)
        d.text((8, 6), "before  " + n, fill=(240, 230, 210))
        d.text((WIDE + 24, 6), "after  " + n, fill=(240, 230, 210))
        blocks.append(block)
    total_h = sum(b.height for b in blocks)
    sheet = Image.new("RGB", (WIDE * 2 + 16, total_h), (24, 20, 16))
    y = 0
    for b in blocks:
        sheet.paste(b, (0, y))
        y += b.height
    sheet.save(out_path, quality=85)
    print("PAIR", out_path, len(names))


def main() -> None:
    if len(sys.argv) == 3:
        contact(sys.argv[1], sys.argv[2])
    elif len(sys.argv) == 4:
        pair(sys.argv[1], sys.argv[2], sys.argv[3])
    else:
        raise SystemExit("usage: make_sheet.py <dir> <out.jpg> | make_sheet.py <before> <after> <out.jpg>")


if __name__ == "__main__":
    main()
