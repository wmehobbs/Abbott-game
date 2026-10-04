"""Phase 3 proof. Silent fences from the phase-1 logs must say Come again. Others must not."""
import re
from pathlib import Path

ids = [
    "hk_les_001", "hk_les_002", "hk_les_003", "hk_les_004",
    "hk_beg_035", "hk_beg_039", "hk_beg_004", "hk_beg_034", "hk_beg_007", "hk_beg_033",
    "hk_int_001", "hk_int_002", "hk_int_005", "hk_int_006", "hk_int_007", "hk_int_009",
    "hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005",
    "hk_jo_beg_001", "hk_jo_int_001", "hk_jo_adv_001",
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
    after_path = Path(f"dist/day3/{course}.again.log")
    if not after_path.exists():
        bad.append(f"{course} missing again log")
        continue
    after = after_path.read_text(encoding="utf-8", errors="replace")
    silent = set()
    for fence, _a, _l, stride, word, _k in count.findall(before):
        if stride == "-1" or word.strip() == "silent":
            silent.add(fence)
    fence_now = None
    said = set()
    for line in after.splitlines():
        hit = count.search(line)
        if hit:
            fence_now = hit.group(1)
        if line.strip() == "MICHELLE soft | Come again.":
            if fence_now is None:
                bad.append(f"{course} Come again before any fence")
            else:
                said.add(fence_now)
    missing = sorted(silent - said, key=int)
    extra = sorted(said - silent, key=int)
    if missing:
        bad.append(f"{course} silent without Come again: {' '.join(missing)}")
    if extra:
        bad.append(f"{course} Come again on a fence that was not silent: {' '.join(extra)}")
    b = result.search(before)
    a = result.search(after)
    if not b or not a:
        bad.append(f"{course} no result")
        continue
    dt = abs(float(a.group(2)) - float(b.group(2)))
    limit = 0.3
    if dt > limit:
        bad.append(f"{course} time {b.group(2)} -> {a.group(2)} dt={dt:.2f}")
    if a.group(3) == "true":
        bad.append(f"{course} teleported")
    if b.group(4) == "[]" and a.group(4) != "[]":
        bad.append(f"{course} new rail {a.group(4)}")
    if (b.group(1) == "0") != (a.group(1) == "0") and a.group(4) == b.group(4):
        # A clear became a time fault, or the reverse, with no rail change.
        bad.append(f"{course} faults {b.group(1)} -> {a.group(1)}")
    print(f"{course} silent={len(silent)} said={len(said)} t {b.group(2)}->{a.group(2)} faults {b.group(1)}->{a.group(1)}")
print("BAD" if bad else "PASS")
for line in bad:
    print(line)
