"""Second table: too short, dropped stride 1 or 2, silent fences she jumped."""
import re
from pathlib import Path

ids = [
    "hk_les_001", "hk_les_002", "hk_les_003", "hk_les_004",
    "hk_beg_035", "hk_beg_039", "hk_beg_004", "hk_beg_034", "hk_beg_007", "hk_beg_033",
    "hk_int_001", "hk_int_002", "hk_int_005", "hk_int_006", "hk_int_007", "hk_int_009",
    "hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005",
    "hk_jo_beg_001", "hk_jo_int_001", "hk_jo_adv_001",
]
pat = re.compile(
    r"COUNT fence=(\d+) ahead=([0-9.]+) lateral=([0-9.]+) stride=(-?\d+) word=(.*?) kept=(true|false)"
)
result = re.compile(r"jumped=(\d+)/(\d+)")
short_rows = []
drop_rows = []
silent_rows = []
drop_ids = []
for course in ids:
    text = Path(f"dist/day3/{course}.log").read_text(encoding="utf-8", errors="replace")
    counts = pat.findall(text)
    jumped = result.search(text)
    n_fences = int(jumped.group(2)) if jumped else 0
    by = {}
    for fence, ahead, lateral, stride, word, kept in counts:
        rec = by.setdefault(int(fence), [])
        rec.append((int(stride), word.strip(), kept, ahead, lateral))
    for fence in range(1, n_fences + 1):
        rows = by.get(fence, [])
        strides = [s for s, *_ in rows if s >= 0]
        if rows and strides and 2 not in strides and strides[0] in (0, 1):
            short_rows.append(f"{course} fence {fence} first={strides[0]}")
        drops = [(s, w, a, lat) for s, w, k, a, lat in rows if s in (1, 2) and k == "false"]
        if drops:
            drop_ids.append(course)
            for s, w, a, lat in drops:
                drop_rows.append(f"{course} fence {fence} stride={s} word={w} ahead={a} lateral={lat}")
        for s, w, k, a, lat in rows:
            if s < 0 and fence <= n_fences:
                silent_rows.append(f"{course} fence {fence} ahead={a} lateral={lat}")
                break
out = []
out.append("")
out.append("## Second table, from the phase 1 logs")
out.append("")
out.append(f"Too short: {len(short_rows)}. First COUNT is stride 0 or 1, and that fence has no stride 2. Not a swallow. Not fixed.")
out.append("")
out.append("| course | fence | first stride |")
out.append("| --- | ---: | ---: |")
for line in short_rows:
    course, fence, first = re.match(r"(\S+) fence (\d+) first=(\d+)", line).groups()
    out.append(f"| {course} | {fence} | {first} |")
out.append("")
out.append(f"Dropped: {len(drop_rows)} stride 1 or 2 lines, `kept=false`, on {len(set(drop_ids))} courses. These are the swallow.")
out.append("")
out.append("| course | fence | stride | word | ahead | lateral |")
out.append("| --- | ---: | ---: | --- | ---: | ---: |")
for line in drop_rows:
    course, fence, stride, word, ahead, lateral = re.match(
        r"(\S+) fence (\d+) stride=(\d+) word=(.*) ahead=([0-9.]+) lateral=([0-9.]+)",
        line,
    ).groups()
    out.append(f"| {course} | {fence} | {stride} | {word} | {ahead} | {lateral} |")
out.append("")
out.append(f"Silent: {len(silent_rows)} fences she still jumped. First silent COUNT on that fence.")
out.append("")
out.append("| course | fence | ahead | lateral |")
out.append("| --- | ---: | ---: | ---: |")
for line in silent_rows:
    course, fence, ahead, lateral = re.match(
        r"(\S+) fence (\d+) ahead=([0-9.]+) lateral=([0-9.]+)",
        line,
    ).groups()
    out.append(f"| {course} | {fence} | {ahead} | {lateral} |")
Path("dist/DAY3_MEASURE.md").open("a", encoding="utf-8", newline="\n").write("\n".join(out) + "\n")
print(f"appended short={len(short_rows)} dropped={len(drop_rows)} silent={len(silent_rows)}")
