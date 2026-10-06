"""1280 px wide JPGs plus a mean-brightness line so a black frame is obvious."""
import os
import sys

from PIL import Image, ImageStat

WIDE = 1280


def main() -> None:
    src = sys.argv[1]
    dst = sys.argv[2]
    os.makedirs(dst, exist_ok=True)
    names = sorted(n for n in os.listdir(src) if n.lower().endswith(".png"))
    for n in names:
        im = Image.open(os.path.join(src, n)).convert("RGB")
        h = max(1, int(im.height * WIDE / im.width))
        small = im.resize((WIDE, h), Image.Resampling.LANCZOS)
        out = os.path.join(dst, os.path.splitext(n)[0] + ".jpg")
        small.save(out, quality=80)
        stat = ImageStat.Stat(small)
        mean = sum(stat.mean) / 3.0
        print("%.1f %s" % (mean, n))
    print("JPG", len(names), dst)


if __name__ == "__main__":
    main()
