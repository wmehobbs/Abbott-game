"""Read-only placement search. Never calls place() or write_fence()."""
import sys
from pathlib import Path

sys.path.insert(0, str(Path("tools/content_factory").resolve()))
import place_fence as pf  # noqa: E402


def show(label: str, rows: list) -> None:
    print(label, "n", len(rows))
    for row in rows[:3]:
        score, x, z, yaw = row[0], row[1], row[2], row[3]
        rest = row[4:]
        print("  score %.2f pos (%.2f, %.2f) yaw %+.3f rest %s" % (score, x, z, yaw, rest))


show("adv_001 #7", pf.search("hk_adv_001", 7, None, 3))
show("adv_003 #6", pf.search("hk_adv_003", 6, None, 3))
show("adv_003 #10", pf.search("hk_adv_003", 10, None, 3))
show("adv_001 #9 pinned expect empty", pf.search("hk_adv_001", 9, None, 1))
import math

rows = pf.search_pair("hk_adv_001", 9, 10, 12)
print("adv_001 pair 9-10 n", len(rows))
# Fence 11 stays. A legal pair must leave the labeled 10->11 one-stride in band.
f11 = (-4.46, -7.79)
for row in rows:
    score, ax, az, ay, bx, bz, byw, run_in, off_in = row
    gap = math.hypot(bx - f11[0], bz - f11[1])
    print(
        "  score %.2f  #9 (%.2f,%.2f yaw %+.3f) #10 (%.2f,%.2f yaw %+.3f) run %.1f off %.1f  gap10-11 %.2f band %s"
        % (score, ax, az, ay, bx, bz, byw, run_in, off_in, gap, 7.0 <= gap <= 7.8)
    )
