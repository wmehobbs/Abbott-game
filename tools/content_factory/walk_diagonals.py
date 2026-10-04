"""Re-walk the Mini Prix diagonals so a crossing is a line, not a correction.

Every fence on the advanced tracks is square to the ring, so the "diagonal" from
the left rail to the right rail is a 15–17 m lateral move with 2–7 m of run. The
rider cannot make that a line: he crosses, arrives across the fence, comes again,
and it costs 8–13 s. Four of those is the whole difference between 100 s and the
80 s the class allows.

The medicine is the one a course builder uses: **angle the fence along the
diagonal**. Point its takeoff direction down the line the horse is actually on —
landing point of the fence before it, to this fence — so the approach is straight.

What this never touches: kind, height, spread, number, or the order. A fence that
comes home still comes home (the yaw change is capped, so it cannot flip into an
away fence). A fence that is either end of a labeled 1 / 2 / 3 is left square —
rotating one end of a line is how a band becomes a lie.

Run `fix_board_lines.py` and then `prove_ship.py` after this; rotating a fence
moves its wings and can crowd a neighbour.

Usage:  python tools/content_factory/walk_diagonals.py hk_adv_001 [...]
        python tools/content_factory/walk_diagonals.py --dry hk_adv_001
"""
from __future__ import annotations

import json
import math
import pathlib
import shutil
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
GAME = ROOT / "game" / "content" / "courses"
PILE = ROOT / "content" / "courses"

LAND = 3.5          # jump_land = 2.55 + spread + charge*0.45
RING_X, RING_Z = 13.4, 36.2
# 40 degrees. An angled fence is ordinary course building; a fence turned 70
# degrees in a 30 m ring faces the wall and lands him at the rail, so the wanted
# angle is capped rather than obeyed. A capped turn still shortens the
# correction — it does not have to make the crossing a perfect line to pay.
MAX_YAW = 0.70
OFF_LINE = 9.0      # only crossings this far off the line are worth re-walking
MAX_SLIDE = 2.0     # how far a fence may slide to sit on its new line
ALLOWED = ("hk_adv_",)


def folder(i: str) -> str:
    return "advanced" if i.startswith("hk_adv") else ""


def d_of(y: float) -> tuple[float, float]:
    return math.sin(y), math.cos(y)


def wrap(a: float) -> float:
    while a > math.pi:
        a -= 2.0 * math.pi
    while a < -math.pi:
        a += 2.0 * math.pi
    return a


def labeled_ends(fs: list[dict]) -> set[int]:
    """Fence numbers that are the in or the out of a labeled related."""
    ends: set[int] = set()
    for f in fs:
        rel = f.get("related")
        if isinstance(rel, dict) and int(rel.get("to", 0)):
            ends.add(int(f["num"]))
            ends.add(int(rel["to"]))
    return ends


def rewalk(cid: str, notes: list[str], dry: bool) -> bool:
    rel_path = folder(cid) + "/%s.json" % cid
    path = GAME / rel_path
    course = json.loads(path.read_text(encoding="utf-8"))
    fs = course["fences"]
    by = {int(f["num"]): f for f in fs}
    pinned = labeled_ends(fs)
    # Cap against where the builder put it, not against last sweep — two
    # sweeps of 40 degrees is an 80 degree fence facing the wall.
    origin = {int(f["num"]): float(f["yaw"]) for f in fs}
    before = json.dumps(course, sort_keys=True)

    # Two sweeps: rotating a fence moves its landing, which changes the next one.
    for _ in range(2):
        px, pz = course["start_pos"][0], course["start_pos"][2]
        pdx, pdz = d_of(float(course["start_yaw"]))
        prev = "start"
        for n in range(1, len(fs) + 1):
            b = by[n]
            bx, bz = b["pos"][0], b["pos"][2]
            lx = px if prev == "start" else px + pdx * LAND
            lz = pz if prev == "start" else pz + pdz * LAND
            dbx, dbz = d_of(float(b["yaw"]))
            off = abs((lx - bx) * (-dbz) + (lz - bz) * dbx)
            along = (bx - lx) * dbx + (bz - lz) * dbz
            if n in pinned or off < OFF_LINE or along > 1.9 * off + 6.5:
                px, pz, pdx, pdz, prev = bx, bz, dbx, dbz, str(n)
                continue
            # Point the fence down the line he is actually on.
            vx, vz = bx - lx, bz - lz
            m = math.hypot(vx, vz)
            if m < 4.0:
                px, pz, pdx, pdz, prev = bx, bz, dbx, dbz, str(n)
                continue
            want = math.atan2(vx / m, vz / m)
            delta = wrap(want - float(b["yaw"]))
            new_yaw = wrap(float(b["yaw"]) + delta)
            total = wrap(new_yaw - origin[n])
            if abs(total) > MAX_YAW:
                new_yaw = wrap(origin[n] + math.copysign(MAX_YAW, total))
                delta = wrap(new_yaw - float(b["yaw"]))
            ndx, ndz = d_of(new_yaw)
            # Slide a little so he meets it with three straight strides, not two.
            run = (bx - lx) * ndx + (bz - lz) * ndz
            slide = 0.0
            if run < 11.0:
                slide = min(11.0 - run, MAX_SLIDE)
            nx, nz = bx + ndx * slide, bz + ndz * slide
            if abs(nx) > 9.6 or abs(nz) > 29.5:
                slide = 0.0
                nx, nz = bx, bz
            if abs(delta) < 0.06 and slide < 0.05:
                px, pz, pdx, pdz, prev = bx, bz, dbx, dbz, str(n)
                continue
            notes.append("%s #%d yaw %.3f -> %.3f (%+.0f deg), slid %.2f m — "
                         "was %.1f m off the line with %.1f m of run"
                         % (cid, n, float(b["yaw"]), new_yaw,
                            math.degrees(delta), slide, off, along))
            b["yaw"] = round(new_yaw, 5)
            b["pos"][0] = round(nx, 3)
            b["pos"][2] = round(nz, 3)
            px, pz, pdx, pdz, prev = nx, nz, ndx, ndz, str(n)

    # Labeled distances never change here, but keep them exact.
    for f in fs:
        rel = f.get("related")
        if isinstance(rel, dict) and int(rel.get("to", 0)) in by:
            o = by[int(rel["to"])]
            rel["distance_m"] = round(
                math.hypot(f["pos"][0] - o["pos"][0], f["pos"][2] - o["pos"][2]), 2)

    if json.dumps(course, sort_keys=True) == before:
        return False
    if dry:
        return True
    path.write_text(json.dumps(course, indent=2) + "\n", encoding="utf-8")
    pile = PILE / rel_path
    if pile.exists():
        shutil.copy2(path, pile)
    return True


def main() -> None:
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    dry = "--dry" in sys.argv
    if not args:
        print("name the ids — this is a re-walk, not a board-wide sweep")
        raise SystemExit(2)
    for cid in args:
        if not cid.startswith(ALLOWED):
            print("refusing %s — this tool is for the advanced re-walk only" % cid)
            raise SystemExit(2)
    notes: list[str] = []
    for cid in args:
        rewalk(cid, notes, dry)
    for n in notes:
        print(n)
    if dry:
        print("(dry run — nothing written)")


if __name__ == "__main__":
    main()
