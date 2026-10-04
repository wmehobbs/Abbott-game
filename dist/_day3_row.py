"""One DAY3_MEASURE row from a copied ridecert log. Reads the file, does not ride."""
import re
import sys
from pathlib import Path

path = Path(sys.argv[1])
text = path.read_text(encoding="utf-8", errors="replace")
ride = re.search(
    r"RIDECERT (\S+) style=\S+ success=\S+ faults=(\d+) jumped=(\d+)/(\d+) t=([0-9.]+) teleported=(true|false)",
    text,
)
if not ride:
    raise SystemExit(f"no RIDECERT result in {path}")
course, faults, jumped, fences, t, tele = ride.groups()
counts = re.findall(
    r"COUNT fence=(\d+) ahead=([0-9.]+) lateral=([0-9.]+) stride=(-?\d+) word=(.*?) kept=(true|false)",
    text,
)
by = {}
dropped = 0
for fence, ahead, lateral, stride, word, kept in counts:
    fence = int(fence)
    stride = int(stride)
    rec = by.setdefault(fence, {"two": False, "bare": False, "silent": False, "ahead": ahead, "lat": lateral})
    if stride < 0 or word.strip() == "silent":
        rec["silent"] = True
        rec["ahead"] = ahead
        rec["lat"] = lateral
        continue
    if kept == "false":
        dropped += 1
    if word.startswith("Two.") or word.startswith("One."):
        rec["two"] = True
    elif word.strip() in {"Wait.", "Early.", "Now.", "Too deep."}:
        rec["bare"] = True
two = sorted(f for f, r in by.items() if r["two"])
bare = sorted(f for f, r in by.items() if r["bare"] and not r["two"])
silent = sorted(f for f, r in by.items() if r["silent"])
def fmt(nums):
    return " ".join(str(n) for n in nums) if nums else "—"
print(
    f"| {course} | {faults} | {t} | {tele} | {jumped}/{fences} | {fmt(two)} | {fmt(bare)} | {fmt(silent)} | {dropped} |"
)
print(f"SILENT_DETAIL {course}")
for fence in silent:
    rec = by[fence]
    print(f"  fence {fence} ahead={rec['ahead']} lateral={rec['lat']}")
