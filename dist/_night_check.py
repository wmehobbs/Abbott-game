"""After the 4 m floor: lies go quiet, real circles still speak, times hold."""
import json
import re
from pathlib import Path

board = json.loads(Path("dist/day3/board.json").read_text(encoding="utf-8"))
# Clear rounds live under rounds, not the style block. Fall back to a scan.
times = {}
rails = {}

def take(node):
    if isinstance(node, dict):
        if node.get("style") in ("clear", "A_clear") and "id" in node and "time_sec" in node:
            cid = node["id"]
            if cid not in times:
                times[cid] = float(node["time_sec"])
                rails[cid] = node.get("rail_fences") or []
        for value in node.values():
            take(value)
    elif isinstance(node, list):
        for value in node:
            take(value)

take(board)
measure = Path("dist/NIGHT_MEASURE.md").read_text(encoding="utf-8")
row_re = re.compile(
    r"\| (hk_\S+) \| (\d+) \| ([0-9.]+) \| ([0-9.]+) \| (yes|no) \| (yes|no) \|"
)
lie_fences = {}
circle_fences = {}
for cid, fence, _ahead, lateral, circled, lie in row_re.findall(measure):
    if " " in cid:
        continue
    if lie == "yes":
        lie_fences.setdefault(cid, set()).add(fence)
    if circled == "yes" and float(lateral) >= 4.0:
        circle_fences.setdefault(cid, set()).add(fence)
# A fence that also has a real circle is not a pure lie.
pure_lies = {
    cid: fences - circle_fences.get(cid, set())
    for cid, fences in lie_fences.items()
}

count_re = re.compile(r"COUNT fence=(\d+) ahead=([0-9.]+) lateral=([0-9.]+)")
result_re = re.compile(
    r"faults=(\d+) jumped=\d+/\d+ t=([0-9.]+) teleported=(true|false).*rail_fences=(\[[^\]]*\])"
)
ids = [
    "hk_les_001", "hk_les_002", "hk_les_003", "hk_les_004",
    "hk_beg_035", "hk_beg_039", "hk_beg_004", "hk_beg_034", "hk_beg_007", "hk_beg_033",
    "hk_int_001", "hk_int_002", "hk_int_005", "hk_int_006", "hk_int_007", "hk_int_009",
    "hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005",
    "hk_jo_beg_001", "hk_jo_int_001", "hk_jo_adv_001",
]
bad = []
for cid in ids:
    path = Path(f"dist/night/{cid}.clear.log")
    if not path.exists():
        bad.append(f"{cid} missing")
        continue
    lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
    fence = None
    said = set()
    low = []
    for line in lines:
        hit = count_re.search(line)
        if hit:
            fence = hit.group(1)
            lat = float(hit.group(3))
        if line.strip() == "MICHELLE soft | Come again.":
            said.add(fence)
            if fence and lat < 4.0:
                low.append(f"{cid} fence {fence} lat {lat}")
    for fence in sorted(pure_lies.get(cid, ()), key=int):
        if fence in said:
            bad.append(f"{cid} still speaks on lie fence {fence}")
    for fence in sorted(circle_fences.get(cid, ()), key=int):
        if fence not in said:
            bad.append(f"{cid} silent on circle fence {fence}")
    if cid == "hk_beg_033" and "2" in said:
        bad.append("hk_beg_033 fence 2 said Come again")
    if cid == "hk_adv_001" and ("7" not in said or "9" not in said):
        bad.append(f"hk_adv_001 missing 7 or 9, said {sorted(said)}")
    res = result_re.search("\n".join(lines))
    if not res:
        bad.append(f"{cid} no result")
        continue
    faults, t, tele, rail = res.groups()
    old = times.get(cid)
    if old is None:
        bad.append(f"{cid} no board time")
    else:
        dt = abs(float(t) - old)
        limit = 0.3 if cid in ("hk_adv_001", "hk_adv_003") else 0.3
        if dt > limit:
            bad.append(f"{cid} time {old} -> {t} dt={dt:.2f}")
    if tele == "true":
        bad.append(f"{cid} teleported")
    if rail != "[]":
        bad.append(f"{cid} rail {rail}")
    if cid not in ("hk_adv_001", "hk_adv_003") and faults != "0":
        bad.append(f"{cid} faults {faults}")
    print(f"{cid} said={sorted(said, key=int)} t={t} faults={faults}")
    bad.extend(low)
print("BAD" if bad else "PASS")
for line in bad:
    print(line)
