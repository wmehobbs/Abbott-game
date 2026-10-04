"""Read-only approach geometry for the two clock courses. Does not write."""
import json
import math
import sys
from pathlib import Path

sys.path.insert(0, str(Path("tools/content_factory").resolve()))
import place_fence as pf  # noqa: E402

COURSES = [
    "game/content/courses/advanced/hk_adv_001.json",
    "game/content/courses/advanced/hk_adv_003.json",
]


def yaw_delta(a: float, b: float) -> float:
    return (b - a + math.pi) % (2 * math.pi) - math.pi


for path in COURSES:
    course = json.loads(Path(path).read_text(encoding="utf-8"))
    fences = course["fences"]
    by = {int(f["num"]): f for f in fences}
    pinned = set()
    for f in fences:
        rel = f.get("related")
        if isinstance(rel, dict) and int(rel.get("to") or 0):
            pinned.add(int(f["num"]))
            pinned.add(int(rel["to"]))
    print("==", course["id"], "eligible", pf.eligible(course), "pinned", sorted(pinned))
    prev = None
    for f in fences:
        n = int(f["num"])
        rel = f.get("related")
        rel_s = ""
        if isinstance(rel, dict) and rel.get("to"):
            dist = float(rel.get("distance_m") or 0)
            strides = int(rel.get("strides") or 0)
            per = dist / strides if strides else 0
            rel_s = " related->%s strides=%s dist=%.2f m/stride=%.2f" % (
                rel.get("to"), strides, dist, per
            )
        line = "#%d %s h=%.3f sp=%.2f pos=(%.2f,%.2f) yaw=%+.3f%s" % (
            n, f["kind"], float(f["h"]), float(f["sp"]),
            f["pos"][0], f["pos"][2], float(f["yaw"]), rel_s,
        )
        if prev is not None:
            run, off = pf.leg(
                prev["pos"][0], prev["pos"][2], float(prev["yaw"]),
                f["pos"][0], f["pos"][2], float(f["yaw"]), False,
            )
            gap = math.hypot(f["pos"][0] - prev["pos"][0], f["pos"][2] - prev["pos"][2])
            straight, _ = pf.is_line(
                prev["pos"][0], prev["pos"][2], float(prev["yaw"]),
                f["pos"][0], f["pos"][2], float(f["yaw"]),
            )
            turn = math.degrees(yaw_delta(float(prev["yaw"]), float(f["yaw"])))
            band = pf.in_band(gap)
            print(
                "  from #%d run=%+.1f off=%.1f need=%.1f gap=%.2f straight=%s band=%s turn=%+.0f pinned=%s"
                % (
                    int(prev["num"]), run, off, pf.need(off), gap,
                    straight, band, turn, n in pinned,
                )
            )
        print(line)
        prev = f
    print()
