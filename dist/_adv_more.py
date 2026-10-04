"""Read-only. Can fence 8, or adv_003 fence 9, be moved alone?"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path("tools/content_factory").resolve()))
import place_fence as pf  # noqa: E402


def show(label: str, rows: list) -> None:
    print(label, "n", len(rows))
    for row in rows[:3]:
        print(
            "  score %.2f pos (%.2f, %.2f) yaw %+.3f run %.2f off %.2f"
            % (row[0], row[1], row[2], row[3], row[4], row[5])
        )


show("adv_001 #8", pf.search("hk_adv_001", 8, None, 3))
show("adv_003 #9", pf.search("hk_adv_003", 9, None, 3))
show("adv_003 #5", pf.search("hk_adv_003", 5, None, 1))
