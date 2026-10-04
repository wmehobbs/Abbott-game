"""Make every line on the live board a line you can actually ride.

Two things go wrong in the generated tracks and both of them are course faults,
not rider faults:

1. Two fences sit on one line at a distance that is not a stride. 6.28 m means
   he lands 3.5 m past the first and the second is already under him; 9.4 m is
   neither a one nor a two. Snap the later fence along the line to the nearest
   real distance (7.45 / 10.80 / 14.70) and label the pair honestly.

2. A third fence stands on somebody else's approach. The rider has to canter
   the last three strides to a fence on its line, and if another standard is
   parked on that line he takes it with him. Move the later-numbered one
   toward the middle of the ring until it is clear.

Kind counts, heights, spreads and fence numbers are never touched, so the class
keeps its job. Writes the export slice and the dev-checkout copy together.
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

# content/pedagogy/related_distances.md — outdoor bands, mid of each band.
BANDS = {1: (7.0, 7.8, 7.45), 2: (10.4, 11.2, 10.80), 3: (14.0, 15.2, 14.70)}
MIN_SEP = 6.6        # two standards this close crowd each other (prove_ship: 6.2)
# The rider's knock plane is 2.35 m half-wide and he has to ride the last three
# strides within ~1.2 m of the line, so a fence whose centre is inside 3.55 m of
# somebody's approach corridor crowds it. The old 2.3 was calibrated against a
# knock model that ignored oxer spread and was ~0.4 m too shallow.
CORRIDOR = 3.9
MAX_SLIDE = 2.8      # how far a fence may move along its line
MAX_SHIFT = 3.6      # how far a fence may move toward the middle
RAIL_X = 9.6         # a fence never sits further out than this


def folder(i: str) -> str:
    if i.startswith("hk_les"):
        return "lesson"
    if i.startswith("hk_beg"):
        return "beginner"
    if i.startswith("hk_int"):
        return "intermediate"
    if i.startswith("hk_adv"):
        return "advanced"
    if "jo_beg" in i:
        return "jump_off/beginner"
    if "jo_int" in i:
        return "jump_off/intermediate"
    return "jump_off/advanced"


def d_of(f: dict) -> tuple[float, float]:
    y = float(f["yaw"])
    return math.sin(y), math.cos(y)


def gap(a: dict, b: dict) -> float:
    return math.hypot(a["pos"][0] - b["pos"][0], a["pos"][2] - b["pos"][2])


def is_line(a: dict, b: dict) -> bool:
    ax, az = a["pos"][0], a["pos"][2]
    bx, bz = b["pos"][0], b["pos"][2]
    dax, daz = d_of(a)
    dbx, dbz = d_of(b)
    if dax * dbx + daz * dbz < 0.90:
        return False
    fwd = (bx - ax) * dax + (bz - az) * daz
    lat = abs((bx - ax) * (-daz) + (bz - az) * dax)
    return fwd > 2.0 and lat < 3.0 and gap(a, b) < 16.0


def nearest_band(g: float) -> int:
    return min(BANDS, key=lambda k: abs(BANDS[k][2] - g))


def fix_lines(course: dict, notes: list[str]) -> None:
    cid = course["id"]
    fs = course["fences"]
    by = {int(f["num"]): f for f in fs}
    for n in range(1, len(fs)):
        a, b = by[n], by[n + 1]
        if not is_line(a, b):
            continue
        g = gap(a, b)
        k = nearest_band(g)
        lo, hi, mid = BANDS[k]
        rel = a.get("related")
        labeled = isinstance(rel, dict) and int(rel.get("to", 0)) == n + 1
        if labeled and lo <= g <= hi:
            continue
        if abs(mid - g) > MAX_SLIDE:
            notes.append("%s %d->%d is %.2f m — %.2f m from a real %d, left alone"
                         % (cid, n, n + 1, g, abs(mid - g), k))
            continue
        dax, daz = d_of(a)
        ax, az = a["pos"][0], a["pos"][2]
        b["pos"][0] = round(ax + dax * mid, 3)
        b["pos"][2] = round(az + daz * mid, 3)
        a["related"] = {"to": n + 1, "strides": k, "distance_m": round(mid, 2)}
        notes.append("%s %d->%d %.2f m -> %.2f m, labeled %d stride%s"
                     % (cid, n, n + 1, g, mid, k, "" if k == 1 else "s"))


def approach_clash(b: dict, o: dict) -> tuple[float, float]:
    """How far out on b's approach o stands, and how far off that line."""
    bx, bz = b["pos"][0], b["pos"][2]
    dbx, dbz = d_of(b)
    along = (o["pos"][0] - bx) * -dbx + (o["pos"][2] - bz) * -dbz
    lat = abs((o["pos"][0] - bx) * (-dbz) + (o["pos"][2] - bz) * dbx)
    return along, lat


def fix_clashes(course: dict, notes: list[str]) -> None:
    cid = course["id"]
    fs = course["fences"]
    for b in fs:
        for o in fs:
            nb, no = int(b["num"]), int(o["num"])
            if nb == no or abs(nb - no) == 1:
                continue
            along, lat = approach_clash(b, o)
            if not (0.9 < along < 11.0 and lat < CORRIDOR):
                continue
            later = o if no > nb else b
            # Move the later one toward the middle, along its own rail axis.
            oldx = float(later["pos"][0])
            step = CORRIDOR + 0.35 - lat
            newx = oldx - math.copysign(min(step, MAX_SHIFT), oldx if abs(oldx) > 0.5 else 1.0)
            if abs(newx) > RAIL_X:
                newx = math.copysign(RAIL_X, newx)
            if abs(newx - oldx) < 0.05:
                continue
            later["pos"][0] = round(newx, 3)
            notes.append("%s #%d x %.2f -> %.2f — it stood %.1f m out on the approach to #%d"
                         % (cid, int(later["num"]), oldx, newx, along, nb))


def fix_crowding(course: dict, notes: list[str]) -> None:
    """Two fences that are not a line have to leave each other room. Sliding a
    fence along its line to make a real stride can push it into a fence from
    the other half of the course; prove_ship calls that at 6.2 m."""
    cid = course["id"]
    fs = course["fences"]
    by = {int(f["num"]): f for f in fs}
    for a in fs:
        for b in fs:
            na, nb = int(a["num"]), int(b["num"])
            if nb <= na:
                continue
            rel = a.get("related")
            if isinstance(rel, dict) and int(rel.get("to", 0)) == nb:
                continue
            g = gap(a, b)
            if g >= MIN_SEP:
                continue
            ax, az = a["pos"][0], a["pos"][2]
            bx, bz = b["pos"][0], b["pos"][2]
            need = min(MIN_SEP + 0.35 - g, MAX_SLIDE)
            # If b is the out of a labeled line its distance is fixed by the
            # band — sliding it would turn the label into a lie. Move the
            # other one sideways instead; a crossing does not care about x.
            pinned = any(
                isinstance(f.get("related"), dict)
                and int(f["related"].get("to", 0)) == nb
                for f in fs
            )
            if pinned:
                sidex = ax + math.copysign(need, ax - bx if abs(ax - bx) > 0.3 else ax)
                if abs(sidex) > RAIL_X:
                    notes.append("%s #%d and #%d are %.2f m apart and neither can move"
                                 % (cid, na, nb, g))
                    continue
                a["pos"][0] = round(sidex, 3)
                notes.append("%s #%d x %.2f -> %.2f — it stood %.2f m from #%d, "
                             "which is pinned by a labeled line"
                             % (cid, na, ax, sidex, g, nb))
                continue
            dbx, dbz = d_of(b)
            # Slide the later fence along its own line, whichever way opens it up.
            sign = 1.0 if ((bx - ax) * dbx + (bz - az) * dbz) >= 0.0 else -1.0
            nx, nz = round(bx + dbx * sign * need, 3), round(bz + dbz * sign * need, 3)
            if abs(nx) > RAIL_X or abs(nz) > 29.5:
                continue
            b["pos"][0], b["pos"][2] = nx, nz
            notes.append("%s #%d slid %.2f m along its own line — it stood %.2f m from #%d"
                         % (cid, nb, need, g, na))


def retag(course: dict) -> None:
    by = {int(f["num"]): f for f in course["fences"]}
    for f in course["fences"]:
        rel = f.get("related")
        if not isinstance(rel, dict):
            continue
        to = int(rel.get("to", 0))
        if to in by:
            rel["distance_m"] = round(gap(f, by[to]), 2)


def run(ids: list[str]) -> None:
    notes: list[str] = []
    for cid in ids:
        rel = folder(cid) + "/%s.json" % cid
        path = GAME / rel
        course = json.loads(path.read_text(encoding="utf-8"))
        before = json.dumps(course, sort_keys=True)
        for _ in range(3):
            fix_lines(course, notes)
            fix_clashes(course, notes)
            fix_crowding(course, notes)
        retag(course)
        if json.dumps(course, sort_keys=True) == before:
            continue
        path.write_text(json.dumps(course, indent=2) + "\n", encoding="utf-8")
        pile = PILE / rel
        if pile.exists():
            shutil.copy2(path, pile)
    for n in notes:
        print(n)


def main() -> None:
    ship = json.loads((GAME / "SHIP.json").read_text(encoding="utf-8"))
    ids = sys.argv[1:]
    if not ids:
        ids = []
        for k in ("lesson", "beginner", "intermediate", "advanced"):
            ids += ship[k]
        ids += list(ship["jump_off"].values())
    run(ids)


if __name__ == "__main__":
    main()
