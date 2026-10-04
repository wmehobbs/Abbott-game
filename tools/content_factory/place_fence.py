"""Put a fence where he can leave from it.

At the top of the Mini Prix ring #7 stands on the right rail facing north at
z ~ 29-30, so the horse lands at z ~ 33 — and #8 sits at x ~ 0, z ~ 31.4 facing
north as well. He is already on its landing side. The run from #7's landing to
#8's takeoff line is *negative*: he has to turn round and come again, and that
is 8-13 s of a class that is only allowed 80.

A fence you land past is not a distance. This searches for somewhere the fence
can actually be jumped from: position and yaw only. Kind, height, spread and
number never move, no related label is invented, and the search is scored with
the rider's own rule out of walk_courses.py —

    run  >=  1.9 * off  +  6.5

for the transition into the fence AND the transition out of it, so opening one
does not close the other.

Hard constraints: the brief's `run >= 8 m` into the fence, ring bounds, the
landing stays on the sand, 6.6 m from every other standard (prove_ship calls
6.2), nobody parked in the approach corridor, and no unlabeled straight line
that fits no band.

Usage:  python tools/content_factory/place_fence.py hk_adv_001 8 [--dry]
"""
from __future__ import annotations

import json
import math
import pathlib
import shutil
import sys

import rules

ROOT = pathlib.Path(__file__).resolve().parents[2]
GAME = ROOT / "game" / "content" / "courses"
PILE = ROOT / "content" / "courses"

LAND = 3.5
RING_X, RING_Z = 13.4, 36.2      # sand the rider will use
PLACE_X, PLACE_Z = 9.6, 29.5     # where a standard may stand
MIN_SEP = 6.6
CORRIDOR = 3.9
MIN_RUN_IN = 8.0                 # the brief: along >= 8 before he is inside 4 m
MIN_RUN_OUT = 5.0                # and he must be able to see his way out of it
MAX_MOVE = 7.0                   # a leash: re-place the fence, do not rebuild
                                 # the course around it
MAX_YAW = math.radians(40.0)     # an angled fence is course building; 70 deg in
                                 # a 30 m ring is a fence facing the wall
BANDS = {1: (7.0, 7.8), 2: (10.4, 11.2), 3: (14.0, 15.2)}
# rules.py, outdoor: a turn of more than 85 degrees off the leave direction is
# illegal inside 12 m unless the pair is a labeled related, and the fence must
# not be approached from behind or the side (dot >= 0.20). prove_ship enforces
# both, so the search enforces them too — a red prove is not a thing to find out
# afterwards.
PROVE_TURN_MAG, PROVE_TURN_DEG, PROVE_MIN_DOT = 12.0, 85.0, 0.20


def folder(i: str) -> str:
    if i.startswith("hk_adv"):
        return "advanced"
    if i.startswith("hk_int"):
        return "intermediate"
    if i.startswith("hk_beg"):
        return "beginner"
    if i.startswith("hk_les"):
        return "lesson"
    raise SystemExit("place_fence is for a numbered class track")


def d_of(y: float) -> tuple[float, float]:
    return math.sin(y), math.cos(y)


def need(off: float) -> float:
    return 1.9 * off + 6.5


def leg(px: float, pz: float, pyaw: float, bx: float, bz: float, byaw: float,
        from_start: bool) -> tuple[float, float]:
    """run and off for landing at the previous fence and riding to this one."""
    pdx, pdz = d_of(pyaw)
    lx = px if from_start else px + pdx * LAND
    lz = pz if from_start else pz + pdz * LAND
    dbx, dbz = d_of(byaw)
    run = (bx - lx) * dbx + (bz - lz) * dbz
    off = abs((lx - bx) * (-dbz) + (lz - bz) * dbx)
    return run, off


def is_line(ax, az, ayaw, bx, bz, byaw) -> tuple[bool, float]:
    dax, daz = d_of(ayaw)
    dbx, dbz = d_of(byaw)
    gap = math.hypot(bx - ax, bz - az)
    if dax * dbx + daz * dbz < 0.90:
        return False, gap
    fwd = (bx - ax) * dax + (bz - az) * daz
    lat = abs((bx - ax) * (-daz) + (bz - az) * dax)
    return (fwd > 2.0 and lat < 3.0 and gap < 16.0), gap


def in_band(gap: float) -> bool:
    return any(lo <= gap <= hi for lo, hi in BANDS.values())


def seg_clear(ax, az, bx, bz, others, skip: set[int]) -> bool:
    """Nothing standing on the straight line between these two points. The
    knock plane is ~2.35 m along the rail and 1.10 + spread/2 through, same
    model the rider uses."""
    abx, abz = bx - ax, bz - az
    lab = math.hypot(abx, abz)
    if lab < 0.3:
        return True
    nx, nz = abx / lab, abz / lab
    for f in others:
        if int(f["num"]) in skip:
            continue
        fx, fz = f["pos"][0], f["pos"][2]
        t = max(0.0, min(lab, (fx - ax) * nx + (fz - az) * nz))
        if t < 0.6:
            continue
        qx, qz = ax + nx * t, az + nz * t
        fdx, fdz = d_of(float(f["yaw"]))
        cx, cz = fx - fdx * (float(f["sp"]) * 0.5), fz - fdz * (float(f["sp"]) * 0.5)
        rail = abs((qx - cx) * (-fdz) + (qz - cz) * fdx)
        thru = abs((qx - cx) * fdx + (qz - cz) * fdz)
        if rail < 2.35 and thru < 1.10 + float(f["sp"]) * 0.5:
            return False
    return True


def prove_pair(ax, az, ayaw, bx, bz, byaw) -> bool:
    """The two rules.py checks that bind a consecutive pair."""
    dx, dz = bx - ax, bz - az
    mag = math.hypot(dx, dz)
    if mag < 0.2:
        return False
    tbx, tbz = d_of(byaw)
    if (dx * tbx + dz * tbz) / mag < PROVE_MIN_DOT:
        return False
    lax, laz = d_of(ayaw)
    lead = max(-1.0, min(1.0, (dx * lax + dz * laz) / mag))
    turn = math.degrees(math.acos(lead))
    return not (mag < PROVE_TURN_MAG and turn > PROVE_TURN_DEG)


def eligible(course: dict) -> list[int]:
    """Fences that are the out of a real rail-to-rail crossing and are free to
    move — not an end of a labeled 1 / 2 / 3."""
    fs = course["fences"]
    by = {int(f["num"]): f for f in fs}
    pinned = set()
    for f in fs:
        rel = f.get("related")
        if isinstance(rel, dict) and int(rel.get("to", 0)):
            pinned.add(int(f["num"]))
            pinned.add(int(rel["to"]))
    out = []
    for n in range(2, len(fs) + 1):
        if n in pinned:
            continue
        a, b = by[n - 1], by[n]
        run, off = leg(a["pos"][0], a["pos"][2], float(a["yaw"]),
                       b["pos"][0], b["pos"][2], float(b["yaw"]), False)
        if off >= 12.0 and run < need(off):
            out.append(n)
    return out


def search(cid: str, num: int, origin: dict | None = None, keep: int = 1) -> list:
    rel_path = folder(cid) + "/%s.json" % cid
    path = GAME / rel_path
    course = json.loads(path.read_text(encoding="utf-8"))
    fs = course["fences"]
    by = {int(f["num"]): f for f in fs}
    me = by[num]
    if isinstance(me.get("related"), dict) or any(
        isinstance(f.get("related"), dict) and int(f["related"].get("to", 0)) == num
        for f in fs
    ):
        return []

    prev = by.get(num - 1)
    nxt = by.get(num + 1)
    if prev is None:
        return []
    px, pz, pyaw = prev["pos"][0], prev["pos"][2], float(prev["yaw"])
    ox, oz, oyaw = me["pos"][0], me["pos"][2], float(me["yaw"])
    # Cap against where the builder put it, not against the last pass. Two
    # passes of 40 degrees is a 74 degree fence, and that faces the wall.
    if origin is not None and num in origin:
        ox, oz, oyaw = origin[num]

    others = [f for f in fs if int(f["num"]) != num]

    found: list = []
    x = -PLACE_X
    while x <= PLACE_X + 1e-9:
        z = -PLACE_Z
        while z <= PLACE_Z + 1e-9:
            # far enough from every other standard, and on the sand after landing
            ok = True
            for f in others:
                if math.hypot(x - f["pos"][0], z - f["pos"][2]) < MIN_SEP:
                    ok = False
                    break
            if ok:
                for k in range(36):
                    yaw = -math.pi + k * (math.pi / 18.0)
                    dbx, dbz = d_of(yaw)
                    lx, lz = x + dbx * LAND, z + dbz * LAND
                    if abs(lx) > RING_X or abs(lz) > RING_Z:
                        continue
                    run_in, off_in = leg(px, pz, pyaw, x, z, yaw, False)
                    if run_in < MIN_RUN_IN:
                        continue
                    # nobody parked on the approach, and this fence not on theirs
                    clash = False
                    for f in others:
                        al = (f["pos"][0] - x) * -dbx + (f["pos"][2] - z) * -dbz
                        lt = abs((f["pos"][0] - x) * (-dbz) + (f["pos"][2] - z) * dbx)
                        if 0.9 < al < 11.0 and lt < CORRIDOR:
                            clash = True
                            break
                        fdx, fdz = d_of(float(f["yaw"]))
                        al2 = (x - f["pos"][0]) * -fdx + (z - f["pos"][2]) * -fdz
                        lt2 = abs((x - f["pos"][0]) * (-fdz) + (z - f["pos"][2]) * fdx)
                        if 0.9 < al2 < 11.0 and lt2 < CORRIDOR:
                            clash = True
                            break
                    if clash:
                        continue
                    # no unlabeled straight line that fits no band, either side
                    ln, gp = is_line(px, pz, pyaw, x, z, yaw)
                    if ln and not in_band(gp):
                        continue
                    if not prove_pair(px, pz, pyaw, x, z, yaw):
                        continue
                    score = max(0.0, need(off_in) - run_in)
                    if nxt is not None:
                        run_o, off_o = leg(x, z, yaw, nxt["pos"][0], nxt["pos"][2],
                                           float(nxt["yaw"]), False)
                        # The way out matters too, but it is the *path* that
                        # railed #6 last time, not the length of the run. Keep
                        # the run merely positive and enough to see the fence;
                        # seg_clear below is what stops him taking a standard
                        # with him on the way out.
                        if run_o < MIN_RUN_OUT:
                            continue
                        # ... and nothing parked on the line from his landing
                        # here to three strides out from the next fence.
                        ndx, ndz = d_of(float(nxt["yaw"]))
                        if not seg_clear(lx, lz,
                                         nxt["pos"][0] - ndx * 9.0,
                                         nxt["pos"][2] - ndz * 9.0,
                                         others, {int(nxt["num"])}):
                            continue
                        ln2, gp2 = is_line(x, z, yaw, nxt["pos"][0], nxt["pos"][2],
                                           float(nxt["yaw"]))
                        if ln2 and not in_band(gp2):
                            continue
                        if not prove_pair(x, z, yaw, nxt["pos"][0], nxt["pos"][2],
                                          float(nxt["yaw"])):
                            continue
                        score += max(0.0, need(off_o) - run_o)
                    # stay near where the builder put it, all else equal
                    moved = math.hypot(x - ox, z - oz)
                    if moved > MAX_MOVE:
                        continue
                    dyaw = abs((yaw - oyaw + math.pi) % (2 * math.pi) - math.pi)
                    if dyaw > MAX_YAW + 1e-6:
                        continue
                    score += 0.16 * moved
                    score += 0.35 * abs((yaw - oyaw + math.pi) % (2 * math.pi) - math.pi)
                    found.append((score, x, z, yaw, run_in, off_in))
            z += 0.5
        x += 0.5

    if not found:
        return []
    found.sort(key=lambda r: r[0])
    # Spread them out: four near-identical spots is one experiment, not four.
    picked: list = []
    for r in found:
        if all(math.hypot(r[1] - q[1], r[2] - q[2]) > 2.5
               or abs((r[3] - q[3] + math.pi) % (2 * math.pi) - math.pi) > 0.35
               for q in picked):
            picked.append(r)
        if len(picked) >= keep:
            break
    return picked


def _rigid(px, pz, pyaw, mx, mz, dyaw, dx, dz):
    """Rotate about the pair midpoint, then translate. Distance between the two
    ends and their relative yaw are preserved by construction — that is the
    whole point: a labeled 1 / 2 / 3 cannot drift out of band."""
    ca, sa = math.cos(dyaw), math.sin(dyaw)
    rx, rz = px - mx, pz - mz
    return (mx + rx * ca - rz * sa + dx,
            mz + rx * sa + rz * ca + dz,
            pyaw + dyaw)


def search_pair(cid: str, na: int, nb: int, keep: int = 4) -> list:
    """Move both ends of a labeled related as one rigid body and score the
    geometry. place_fence.search returns [] for either end because they are
    labeled — the label is exactly why they have to travel together."""
    path = GAME / (folder(cid) + "/%s.json" % cid)
    course = json.loads(path.read_text(encoding="utf-8"))
    fs = course["fences"]
    by = {int(f["num"]): f for f in fs}
    a, b = by[na], by[nb]
    prev = by.get(na - 1)
    nxt = by.get(nb + 1)
    if prev is None:
        return []
    ax0, az0, ay0 = a["pos"][0], a["pos"][2], float(a["yaw"])
    bx0, bz0, by0 = b["pos"][0], b["pos"][2], float(b["yaw"])
    mx, mz = (ax0 + bx0) * 0.5, (az0 + bz0) * 0.5
    px, pz, pyaw = prev["pos"][0], prev["pos"][2], float(prev["yaw"])
    others = [f for f in fs if int(f["num"]) not in (na, nb)]

    found = []
    steps = [i * 0.5 for i in range(-14, 15)]
    yaws = [i * math.pi / 36.0 for i in range(-7, 8)]   # +/- 35 deg in 5 deg
    for dyaw in yaws:
        if abs(dyaw) > MAX_YAW + 1e-6:
            continue
        for dx in steps:
            for dz in steps:
                ax, az, ay = _rigid(ax0, az0, ay0, mx, mz, dyaw, dx, dz)
                bx, bz, byw = _rigid(bx0, bz0, by0, mx, mz, dyaw, dx, dz)
                if math.hypot(ax - ax0, az - az0) > MAX_MOVE:
                    continue
                if math.hypot(bx - bx0, bz - bz0) > MAX_MOVE:
                    continue
                if abs(ax) > PLACE_X or abs(az) > PLACE_Z:
                    continue
                if abs(bx) > PLACE_X or abs(bz) > PLACE_Z:
                    continue
                ok = True
                for (cx, cz, cyaw) in ((ax, az, ay), (bx, bz, byw)):
                    dcx, dcz = d_of(cyaw)
                    lx, lz = cx + dcx * LAND, cz + dcz * LAND
                    if abs(lx) > RING_X or abs(lz) > RING_Z:
                        ok = False
                        break
                    for f in others:
                        if math.hypot(cx - f["pos"][0], cz - f["pos"][2]) < MIN_SEP:
                            ok = False
                            break
                        al = (f["pos"][0] - cx) * -dcx + (f["pos"][2] - cz) * -dcz
                        lt = abs((f["pos"][0] - cx) * (-dcz) + (f["pos"][2] - cz) * dcx)
                        if 0.9 < al < 11.0 and lt < CORRIDOR:
                            ok = False
                            break
                        fdx, fdz = d_of(float(f["yaw"]))
                        al2 = (cx - f["pos"][0]) * -fdx + (cz - f["pos"][2]) * -fdz
                        lt2 = abs((cx - f["pos"][0]) * (-fdz) + (cz - f["pos"][2]) * fdx)
                        if 0.9 < al2 < 11.0 and lt2 < CORRIDOR:
                            ok = False
                            break
                    if not ok:
                        break
                if not ok:
                    continue
                # in to the first element
                run_in, off_in = leg(px, pz, pyaw, ax, az, ay, False)
                if run_in < MIN_RUN_IN:
                    continue
                if not prove_pair(px, pz, pyaw, ax, az, ay):
                    continue
                ln, gp = is_line(px, pz, pyaw, ax, az, ay)
                if ln and not in_band(gp):
                    continue
                # down the line to the out
                if not prove_pair(ax, az, ay, bx, bz, byw):
                    continue
                adx, adz = d_of(ay)
                if not seg_clear(ax + adx * LAND, az + adz * LAND,
                                 bx, bz, others, set()):
                    continue
                # and away from the out
                bdx, bdz = d_of(byw)
                run_o = 99.0
                if nxt is not None:
                    run_o, _off_o = leg(bx, bz, byw, nxt["pos"][0], nxt["pos"][2],
                                        float(nxt["yaw"]), False)
                    if run_o < MIN_RUN_OUT:
                        continue
                    ndx, ndz = d_of(float(nxt["yaw"]))
                    if not seg_clear(bx + bdx * LAND, bz + bdz * LAND,
                                     nxt["pos"][0] - ndx * 9.0,
                                     nxt["pos"][2] - ndz * 9.0, others, {int(nxt["num"])}):
                        continue
                    if not prove_pair(bx, bz, byw, nxt["pos"][0], nxt["pos"][2],
                                      float(nxt["yaw"])):
                        continue
                else:
                    # last fence: he still has to get home to the OUT flags
                    if not seg_clear(bx + bdx * LAND, bz + bdz * LAND,
                                     0.0, float(course.get("finish_z", -36.2)),
                                     others, set()):
                        continue
                score = max(0.0, need(off_in) - run_in)
                score += 0.16 * (math.hypot(ax - ax0, az - az0)
                                 + math.hypot(bx - bx0, bz - bz0))
                score += 0.35 * abs(dyaw)
                found.append((score, ax, az, ay, bx, bz, byw, run_in, off_in))
    if not found:
        return []
    found.sort(key=lambda r: r[0])
    picked = []
    for r in found:
        if all(math.hypot(r[1] - q[1], r[2] - q[2]) > 2.5
               or abs((r[3] - q[3] + math.pi) % (2 * math.pi) - math.pi) > 0.35
               for q in picked):
            picked.append(r)
        if len(picked) >= keep:
            break
    return picked


def find_chains(cid: str) -> list[tuple[int, int, int]]:
    """Labeled triples already in the JSON: A.related.to == B and B.related.to == C.
    A fence that is only one end of a pair is not a chain. Nothing is invented."""
    path = GAME / (folder(cid) + "/%s.json" % cid)
    course = json.loads(path.read_text(encoding="utf-8"))
    by = {int(f["num"]): f for f in course["fences"]}
    out: list[tuple[int, int, int]] = []
    for n in sorted(by):
        rel = by[n].get("related")
        if not isinstance(rel, dict):
            continue
        m = int(rel.get("to", 0))
        mid = by.get(m)
        if mid is None or not isinstance(mid.get("related"), dict):
            continue
        p = int(mid["related"].get("to", 0))
        if p in by:
            out.append((n, m, p))
    return out


def labels_hold(fences: list) -> bool:
    """Every labeled related on the course is inside its stride band, and the
    stored distance_m still matches. Same bands as related_distances.md."""
    by = {int(f["num"]): f for f in fences}
    for f in fences:
        rel = f.get("related")
        if not isinstance(rel, dict):
            continue
        g = by.get(int(rel.get("to", 0)))
        strides = int(rel.get("strides", 0))
        if g is None or strides not in BANDS:
            return False
        gap = math.hypot(f["pos"][0] - g["pos"][0], f["pos"][2] - g["pos"][2])
        lo, hi = BANDS[strides]
        if not (lo <= gap <= hi):
            return False
        if abs(gap - float(rel.get("distance_m", 0.0))) > rules.RELATED_TOL:
            return False
    return True


def search_triple(cid: str, n1: int, n2: int, n3: int, keep: int = 4) -> list:
    """Move all three ends of one labeled chain as one rigid body.

    Same construction as search_pair: one rotation about the body's midpoint
    (here the centroid of the three) and one translation. Both distances and
    both relative yaws are preserved by construction, so a band cannot drift.
    Kind, height, spread, number and labels never move.

    Each end stays within MAX_MOVE of its own shipped position and MAX_YAW of
    its own shipped yaw. Nothing in the constraint set is relaxed.
    """
    path = GAME / (folder(cid) + "/%s.json" % cid)
    course = json.loads(path.read_text(encoding="utf-8"))
    fs = course["fences"]
    by = {int(f["num"]): f for f in fs}
    if (n1, n2, n3) not in find_chains(cid):
        search_triple.last_stats = {"refused": "not a labeled chain"}
        return []
    a, b, c = by[n1], by[n2], by[n3]
    prev = by.get(n1 - 1)
    nxt = by.get(n3 + 1)
    if prev is None:
        search_triple.last_stats = {"refused": "no fence in front of the chain"}
        return []
    ax0, az0, ay0 = a["pos"][0], a["pos"][2], float(a["yaw"])
    bx0, bz0, by0 = b["pos"][0], b["pos"][2], float(b["yaw"])
    cx0, cz0, cy0 = c["pos"][0], c["pos"][2], float(c["yaw"])
    mx, mz = (ax0 + bx0 + cx0) / 3.0, (az0 + bz0 + cz0) / 3.0
    px, pz, pyaw = prev["pos"][0], prev["pos"][2], float(prev["yaw"])
    others = [f for f in fs if int(f["num"]) not in (n1, n2, n3)]
    stride_ab = int(a["related"]["strides"])
    stride_bc = int(b["related"]["strides"])

    def end_ok(cx, cz, cyaw) -> bool:
        if abs(cx) > PLACE_X or abs(cz) > PLACE_Z:
            return False
        # prove_ship: a standard inside 4 m of the start flags is illegal.
        if abs(cz - rules.START_FLAGS_Z) < rules.START_CLEAR_M - 1e-6:
            return False
        dcx, dcz = d_of(cyaw)
        lx, lz = cx + dcx * LAND, cz + dcz * LAND
        if abs(lx) > RING_X or abs(lz) > RING_Z:
            return False
        for f in others:
            if math.hypot(cx - f["pos"][0], cz - f["pos"][2]) < MIN_SEP:
                return False
            al = (f["pos"][0] - cx) * -dcx + (f["pos"][2] - cz) * -dcz
            lt = abs((f["pos"][0] - cx) * (-dcz) + (f["pos"][2] - cz) * dcx)
            if 0.9 < al < 11.0 and lt < CORRIDOR:
                return False
            fdx, fdz = d_of(float(f["yaw"]))
            al2 = (cx - f["pos"][0]) * -fdx + (cz - f["pos"][2]) * -fdz
            lt2 = abs((cx - f["pos"][0]) * (-fdz) + (cz - f["pos"][2]) * fdx)
            if 0.9 < al2 < 11.0 and lt2 < CORRIDOR:
                return False
        return True

    stats = {
        "tried": 0, "leash": 0, "end": 0, "run_in": 0, "prove_in": 0,
        "line_in": 0, "mid": 0, "out_run": 0, "out_clear": 0, "out_prove": 0,
        "out_line": 0, "band": 0, "identity": 0, "ok": 0,
    }
    found = []
    steps = [i * 0.5 for i in range(-14, 15)]
    yaws = [i * math.pi / 36.0 for i in range(-7, 8)]   # +/- 35 deg in 5 deg
    for dyaw in yaws:
        if abs(dyaw) > MAX_YAW + 1e-6:
            continue
        for dx in steps:
            for dz in steps:
                stats["tried"] += 1
                ax, az, ay = _rigid(ax0, az0, ay0, mx, mz, dyaw, dx, dz)
                bx, bz, byw = _rigid(bx0, bz0, by0, mx, mz, dyaw, dx, dz)
                cx, cz, cy = _rigid(cx0, cz0, cy0, mx, mz, dyaw, dx, dz)
                if (math.hypot(ax - ax0, az - az0) > MAX_MOVE
                        or math.hypot(bx - bx0, bz - bz0) > MAX_MOVE
                        or math.hypot(cx - cx0, cz - cz0) > MAX_MOVE):
                    stats["leash"] += 1
                    continue
                if not (end_ok(ax, az, ay) and end_ok(bx, bz, byw) and end_ok(cx, cz, cy)):
                    stats["end"] += 1
                    continue
                run_in, off_in = leg(px, pz, pyaw, ax, az, ay, False)
                if run_in < MIN_RUN_IN:
                    stats["run_in"] += 1
                    continue
                if not prove_pair(px, pz, pyaw, ax, az, ay):
                    stats["prove_in"] += 1
                    continue
                ln, gp = is_line(px, pz, pyaw, ax, az, ay)
                if ln and not in_band(gp):
                    stats["line_in"] += 1
                    continue
                # Down the chain. Geometry between the three is invariant under
                # the rigid move; still checked so a broken label cannot pass.
                if not prove_pair(ax, az, ay, bx, bz, byw):
                    stats["mid"] += 1
                    continue
                if not prove_pair(bx, bz, byw, cx, cz, cy):
                    stats["mid"] += 1
                    continue
                adx, adz = d_of(ay)
                bdx, bdz = d_of(byw)
                if not seg_clear(ax + adx * LAND, az + adz * LAND, bx, bz, others, set()):
                    stats["mid"] += 1
                    continue
                if not seg_clear(bx + bdx * LAND, bz + bdz * LAND, cx, cz, others, set()):
                    stats["mid"] += 1
                    continue
                cdx, cdz = d_of(cy)
                if nxt is not None:
                    run_o, _off_o = leg(cx, cz, cy, nxt["pos"][0], nxt["pos"][2],
                                        float(nxt["yaw"]), False)
                    if run_o < MIN_RUN_OUT:
                        stats["out_run"] += 1
                        continue
                    ndx, ndz = d_of(float(nxt["yaw"]))
                    if not seg_clear(cx + cdx * LAND, cz + cdz * LAND,
                                     nxt["pos"][0] - ndx * 9.0,
                                     nxt["pos"][2] - ndz * 9.0,
                                     others, {int(nxt["num"])}):
                        stats["out_clear"] += 1
                        continue
                    if not prove_pair(cx, cz, cy, nxt["pos"][0], nxt["pos"][2],
                                      float(nxt["yaw"])):
                        stats["out_prove"] += 1
                        continue
                    ln2, gp2 = is_line(cx, cz, cy, nxt["pos"][0], nxt["pos"][2],
                                       float(nxt["yaw"]))
                    if ln2 and not in_band(gp2):
                        stats["out_line"] += 1
                        continue
                else:
                    if not seg_clear(cx + cdx * LAND, cz + cdz * LAND,
                                     0.0, float(course.get("finish_z", -36.2)),
                                     others, set()):
                        stats["out_clear"] += 1
                        continue
                # Rounded positions are what gets written. Both labeled gaps
                # have to stay in band after that rounding, and so does every
                # other label on the course.
                rax, raz = round(ax, 3), round(az, 3)
                rbx, rbz = round(bx, 3), round(bz, 3)
                rcx, rcz = round(cx, 3), round(cz, 3)
                gap_ab = math.hypot(rax - rbx, raz - rbz)
                gap_bc = math.hypot(rbx - rcx, rbz - rcz)
                lo_ab, hi_ab = BANDS[stride_ab]
                lo_bc, hi_bc = BANDS[stride_bc]
                if not (lo_ab <= gap_ab <= hi_ab and lo_bc <= gap_bc <= hi_bc):
                    stats["band"] += 1
                    continue
                trial = []
                for f in fs:
                    g = dict(f)
                    g["pos"] = list(f["pos"])
                    num = int(f["num"])
                    if num == n1:
                        g["pos"][0], g["pos"][2] = rax, raz
                    elif num == n2:
                        g["pos"][0], g["pos"][2] = rbx, rbz
                    elif num == n3:
                        g["pos"][0], g["pos"][2] = rcx, rcz
                    trial.append(g)
                if not labels_hold(trial):
                    stats["band"] += 1
                    continue
                if (math.hypot(rax - ax0, raz - az0) < 0.25
                        and math.hypot(rbx - bx0, rbz - bz0) < 0.25
                        and math.hypot(rcx - cx0, rcz - cz0) < 0.25
                        and abs(dyaw) < 0.02):
                    stats["identity"] += 1
                    continue
                stats["ok"] += 1
                score = max(0.0, need(off_in) - run_in)
                score += 0.16 * (math.hypot(ax - ax0, az - az0)
                                 + math.hypot(bx - bx0, bz - bz0)
                                 + math.hypot(cx - cx0, cz - cz0))
                score += 0.35 * abs(dyaw)
                found.append((score, ax, az, ay, bx, bz, byw, cx, cz, cy,
                              run_in, off_in, gap_ab, gap_bc))
    search_triple.last_stats = stats
    if not found:
        return []
    found.sort(key=lambda r: r[0])
    picked = []
    for r in found:
        if all(math.hypot(r[1] - q[1], r[2] - q[2]) > 2.5
               or abs((r[3] - q[3] + math.pi) % (2 * math.pi) - math.pi) > 0.35
               for q in picked):
            picked.append(r)
        if len(picked) >= keep:
            break
    return picked


search_triple.last_stats = {}


def write_fence(cid: str, num: int, x: float, z: float, yaw: float) -> None:
    rel_path = folder(cid) + "/%s.json" % cid
    path = GAME / rel_path
    course = json.loads(path.read_text(encoding="utf-8"))
    for f in course["fences"]:
        if int(f["num"]) == num:
            f["pos"][0] = round(x, 3)
            f["pos"][2] = round(z, 3)
            f["yaw"] = round(yaw, 5)
    path.write_text(json.dumps(course, indent=2) + chr(10), encoding="utf-8")
    pile = PILE / rel_path
    if pile.exists():
        shutil.copy2(path, pile)


def place(cid: str, num: int, dry: bool, origin: dict | None = None) -> str:
    got = search(cid, num, origin, 1)
    if not got:
        return "%s #%d - no placement satisfies the constraints" % (cid, num)
    _, nx, nz, nyaw, run_in, off_in = got[0]
    if dry:
        return "%s #%d -> (%.2f,%.2f) yaw %+.3f  (dry)" % (cid, num, nx, nz, nyaw)
    write_fence(cid, num, nx, nz, nyaw)
    return ("%s #%d -> (%.2f,%.2f) yaw %+.3f | in: run %+.1f off %.1f"
            % (cid, num, nx, nz, nyaw, run_in, off_in)) + "   (dry)"
    me["pos"][0] = round(nx, 3)
    me["pos"][2] = round(nz, 3)
    me["yaw"] = round(nyaw, 5)
    path.write_text(json.dumps(course, indent=2) + "\n", encoding="utf-8")
    pile = PILE / rel_path
    if pile.exists():
        shutil.copy2(path, pile)
    return msg


def sweep(cid: str, dry: bool) -> None:
    start = json.loads((GAME / (folder(cid) + "/%s.json" % cid)).read_text(encoding="utf-8"))
    origin = {int(f["num"]): (f["pos"][0], f["pos"][2], float(f["yaw"]))
              for f in start["fences"]}
    """Every eligible crossing on one file, round and round until nothing
    moves. One rule set, one loop — not a yaw pass and then a clash pass."""
    for it in range(6):
        course = json.loads((GAME / (folder(cid) + "/%s.json" % cid)).read_text(encoding="utf-8"))
        todo = eligible(course)
        if not todo:
            print("%s sweep settled after %d pass(es)" % (cid, it))
            return
        changed = False
        for n in todo:
            before = json.loads((GAME / (folder(cid) + "/%s.json" % cid)).read_text(encoding="utf-8"))
            msg = place(cid, n, dry, origin)
            print("  " + msg)
            after = json.loads((GAME / (folder(cid) + "/%s.json" % cid)).read_text(encoding="utf-8"))
            if before != after:
                changed = True
        if not changed:
            print("%s sweep settled: %d crossing(s) it cannot open at the leash"
                  % (cid, len(todo)))
            return
    print("%s sweep did NOT settle in 6 passes" % cid)


def main() -> None:
    argv = [a for a in sys.argv[1:] if not a.startswith("--")]
    dry = "--dry" in sys.argv
    if "--chains" in sys.argv:
        for cid in argv:
            print(cid, find_chains(cid))
        return
    if "--triple" in sys.argv:
        if len(argv) != 4:
            print("usage: place_fence.py --triple <id> <a> <b> <c> [--dry]")
            raise SystemExit(2)
        cid, n1, n2, n3 = argv[0], int(argv[1]), int(argv[2]), int(argv[3])
        got = search_triple(cid, n1, n2, n3, 8)
        print("%s %d-%d-%d  stats %s" % (cid, n1, n2, n3, search_triple.last_stats))
        if not got:
            print("  no rigid placement satisfies the constraints")
            return
        for i, (sc, ax, az, ay, bx, bz, byw, cx, cz, cy, run_in, off_in, gap_ab, gap_bc) in enumerate(got, 1):
            print("  cand %d score %.2f  #%d(%6.2f,%6.2f yaw %+.3f) #%d(%6.2f,%6.2f yaw %+.3f) "
                  "#%d(%6.2f,%6.2f yaw %+.3f)  gaps %.3f/%.3f  run_in %+.1f"
                  % (i, sc, n1, ax, az, ay, n2, bx, bz, byw, n3, cx, cz, cy,
                     gap_ab, gap_bc, run_in))
        return
    if "--sweep" in sys.argv:
        for cid in argv:
            sweep(cid, dry)
        return
    if len(argv) < 2 or len(argv) % 2:
        print("usage: place_fence.py <id> <num> [...] [--dry]")
        print("       place_fence.py --sweep <id> [<id> ...]")
        raise SystemExit(2)
    for i in range(0, len(argv), 2):
        print(place(argv[i], int(argv[i + 1]), dry))


if __name__ == "__main__":
    main()
