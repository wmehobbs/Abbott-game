"""Compare phase-1 logs to the swallow re-rides."""
import re
from pathlib import Path

ids = [
    "hk_les_001", "hk_les_002", "hk_les_003", "hk_les_004",
    "hk_beg_035", "hk_beg_039", "hk_beg_004", "hk_beg_034", "hk_beg_007", "hk_beg_033",
    "hk_int_001", "hk_int_002", "hk_int_006", "hk_int_007", "hk_int_009",
    "hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005",
]
count = re.compile(
    r"COUNT fence=(\d+) ahead=([0-9.]+) lateral=([0-9.]+) stride=(-?\d+) word=(.*?) kept=(true|false)"
)
result = re.compile(
    r"faults=(\d+) jumped=\d+/\d+ t=([0-9.]+) teleported=(true|false).*rail_fences=(\[[^\]]*\])"
)
bad = []
for course in ids:
    before = Path(f"dist/day3/{course}.log").read_text(encoding="utf-8", errors="replace")
    after_path = Path(f"dist/day3/{course}.after.log")
    if not after_path.exists():
        bad.append(f"{course} MISSING after log")
        continue
    after = after_path.read_text(encoding="utf-8", errors="replace")
    b = result.search(before)
    a = result.search(after)
    if not b or not a:
        bad.append(f"{course} no result line")
        continue
    dt = abs(float(a.group(2)) - float(b.group(2)))
    if dt > 0.3:
        bad.append(f"{course} time {b.group(2)} -> {a.group(2)} dt={dt:.2f}")
    if a.group(3) == "true":
        bad.append(f"{course} teleported")
    if a.group(4) != "[]" and a.group(4) != b.group(4):
        bad.append(f"{course} rail {b.group(4)} -> {a.group(4)}")
    if b.group(4) == "[]" and a.group(4) != "[]":
        bad.append(f"{course} new rail {a.group(4)}")
    dropped = [
        (fence, stride, word)
        for fence, _ahead, _lat, stride, word, kept in count.findall(before)
        if stride in ("1", "2") and kept == "false"
    ]
    after_kept = {
        (fence, stride, word): kept
        for fence, _ahead, _lat, stride, word, kept in count.findall(after)
    }
    for key in dropped:
        if after_kept.get(key) != "true":
            bad.append(f"{course} still dropped fence={key[0]} stride={key[1]} word={key[2]} now={after_kept.get(key)}")
    print(f"{course} t {b.group(2)} -> {a.group(2)} faults {b.group(1)} -> {a.group(1)} rails {b.group(4)} -> {a.group(4)} drops {len(dropped)}")
print("BAD" if bad else "PASS")
for line in bad:
    print(line)
