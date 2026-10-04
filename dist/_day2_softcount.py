"""Count yesterday's MICHELLE soft lines per fence. Read-only."""
import re
from pathlib import Path

FENCE = re.compile(r"RIDEAI fence (\d+) -> (\d+)")
SOFT = re.compile(r"MICHELLE soft \| (.*)")
ROUND = re.compile(r"RIDECERT round (\S+)")
DONE = re.compile(r"RIDECERT (\S+) style=(\S+)")
STRIDE = ("Two. ", "One. ")

logs = [
    Path("dist/ridecert_hk_beg_033_coaching.log"),
    Path("dist/ridecert_godot.coaching.log"),
]


def stride_hit(text: str) -> bool:
    return text.startswith("Two. ") or text.startswith("One. ")


for path in logs:
    print("==", path)
    course = ""
    style = ""
    pending = []
    # fence number -> list of soft texts seen on the approach to it
    by_fence = {}
    order = []
    for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        m = ROUND.search(line)
        if m:
            course = m.group(1)
            pending = []
            by_fence = {}
            order = []
            continue
        m = SOFT.search(line)
        if m:
            pending.append(m.group(1).strip())
            continue
        m = FENCE.search(line)
        if m:
            dest = int(m.group(2))
            # Lines before "fence A -> B" were spoken on the way to A.
            approached = int(m.group(1))
            if approached not in by_fence:
                order.append(approached)
                by_fence[approached] = []
            by_fence[approached].extend(pending)
            pending = []
            continue
        m = DONE.search(line)
        if m and by_fence:
            cid, style = m.group(1), m.group(2)
            got = 0
            print(f"  {cid} style={style}")
            for n in order:
                texts = by_fence[n]
                hit = any(stride_hit(t) for t in texts)
                if hit:
                    got += 1
                mark = "COUNT" if hit else "no-count"
                print(f"    fence {n} {mark} n={len(texts)} | " + " || ".join(texts))
            print(f"    fences_with_Two_or_One={got}/{len(order)} leftover_after_last={len(pending)}")
            by_fence = {}
            order = []
            pending = []
