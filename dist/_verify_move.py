"""Refuse a course write unless only the named fence's position and yaw moved."""
import json
import math
import sys
from pathlib import Path

cid = sys.argv[1]
num = int(sys.argv[2])
backup = json.loads(Path(sys.argv[3]).read_text(encoding="utf-8"))
live = json.loads(Path(sys.argv[4]).read_text(encoding="utf-8"))
pile = json.loads(Path(sys.argv[5]).read_text(encoding="utf-8"))

def fence_map(course):
    return {int(f["num"]): f for f in course["fences"]}

bb, ll = fence_map(backup), fence_map(live)
if set(bb) != set(ll):
    raise SystemExit("fence numbers changed")
changed = []
for n in sorted(bb):
    b, f = bb[n], ll[n]
    if n != num:
        if b != f:
            raise SystemExit("fence %d changed and it should not have" % n)
        continue
    for key in b:
        if key in ("pos", "yaw"):
            continue
        if b[key] != f[key]:
            raise SystemExit("fence %d field %s changed" % (n, key))
    if b["pos"] != f["pos"] or b["yaw"] != f["yaw"]:
        changed.append(n)
    dx = float(f["pos"][0]) - float(b["pos"][0])
    dz = float(f["pos"][2]) - float(b["pos"][2])
    moved = math.hypot(dx, dz)
    dyaw = abs((float(f["yaw"]) - float(b["yaw"]) + math.pi) % (2 * math.pi) - math.pi)
    if moved > 7.0 + 1e-6:
        raise SystemExit("leash broken %.3f" % moved)
    if dyaw > math.radians(40.0) + 1e-6:
        raise SystemExit("yaw cap broken %.3f" % dyaw)
    print(
        "fence %d (%.3f,%.3f) yaw %+.5f -> (%.3f,%.3f) yaw %+.5f  moved %.2f m dyaw %.1f deg"
        % (
            n, b["pos"][0], b["pos"][2], b["yaw"],
            f["pos"][0], f["pos"][2], f["yaw"], moved, math.degrees(dyaw),
        )
    )
if changed != [num]:
    raise SystemExit("expected fence %d to move, changed %s" % (num, changed))
meta_b = {k: v for k, v in backup.items() if k != "fences"}
meta_l = {k: v for k, v in live.items() if k != "fences"}
if meta_b != meta_l:
    raise SystemExit("course metadata changed")
if live != pile:
    raise SystemExit("pile copy does not match the game file")
print("OK")
