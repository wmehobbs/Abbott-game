"""Sort labeled ship relateds by distance from the measured canter stride."""
import json
import math
from pathlib import Path

ROOT = Path(r"E:\Workspace\Madison")
SHIP = json.loads((ROOT / "game/content/courses/SHIP.json").read_text(encoding="utf-8"))
MEASURED = 3.246


def folder(i: str) -> str:
    if i.startswith("hk_les"):
        return "lesson"
    if i.startswith("hk_beg"):
        return "beginner"
    if i.startswith("hk_int"):
        return "intermediate"
    if i.startswith("hk_adv"):
        return "advanced"
    if i.startswith("hk_jo_beg"):
        return "jump_off/beginner"
    if i.startswith("hk_jo_int"):
        return "jump_off/intermediate"
    if i.startswith("hk_jo_adv"):
        return "jump_off/advanced"
    raise SystemExit(i)


ids = []
for key in ("lesson", "beginner", "intermediate", "advanced"):
    ids.extend(SHIP[key])
for value in SHIP["jump_off"].values():
    ids.append(value)

rows = []
for cid in ids:
    course = json.loads(
        (ROOT / "game/content/courses" / folder(cid) / f"{cid}.json").read_text(encoding="utf-8")
    )
    by = {int(f["num"]): f for f in course["fences"]}
    for f in course["fences"]:
        rel = f.get("related")
        if not isinstance(rel, dict) or not rel.get("to"):
            continue
        g = by[int(rel["to"])]
        ground = math.hypot(f["pos"][0] - g["pos"][0], f["pos"][2] - g["pos"][2])
        strides = int(rel["strides"])
        implied = ground / strides
        rows.append((abs(implied - MEASURED), cid, int(f["num"]), int(rel["to"]), strides, ground, implied))

rows.sort(key=lambda r: -r[0])
print("| course | leg | strides | ground_m | implied_m | from 3.246 |")
print("| --- | --- | ---: | ---: | ---: | ---: |")
for delta, cid, a, b, strides, ground, implied in rows:
    print(
        "| %s | %d->%d | %d | %.2f | %.3f | %+.3f |"
        % (cid, a, b, strides, ground, implied, implied - MEASURED)
    )
print("n", len(rows))
