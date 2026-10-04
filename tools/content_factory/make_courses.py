"""Generate a library of Hidden K hunter tracks. Validates as it writes."""
from __future__ import annotations

import json
import math
import random
import sys
from pathlib import Path

from rules import (
    CLASS_TIME_SCHOOL,
    CLASS_TIME_SHOW,
    COUNTS,
    FINISH_HOME,
    HEIGHT_LABEL,
    HEIGHTS,
    JO_COUNT,
    OXER_SPREAD,
    PI,
    START_POS,
    START_YAW,
    dist_xz,
    path_length_m,
    round_hash_part,
    time_from_path,
    travel_dir,
    validate_course,
)

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "content" / "courses"
INDEX = OUT / "INDEX.json"

# Two-stride default sits in the labeled band.
D1 = 7.4
D2 = 10.8
D3 = 14.6


def clamp(v: float, lo: float, hi: float) -> float:
    return max(lo, min(hi, v))


def fence(
    num: int,
    kind: str,
    h: float,
    sp: float,
    x: float,
    z: float,
    yaw: float,
    name: str,
    related: dict | None = None,
) -> dict:
    x = round(x, 3)
    z = round(z, 3)
    rec = {
        "num": num,
        "kind": kind,
        "h": round(h, 3),
        "sp": round(sp if kind == "oxer" else 0.0, 3),
        "pos": [x, 0.0, z],
        "yaw": round(yaw, 5),
        "name": name,
        "related": related,
    }
    return rec


def related_to(to: int, strides: int, dist: float) -> dict:
    return {"to": to, "strides": strides, "distance_m": round(dist, 2)}


def place_along(x: float, z: float, yaw: float, dist: float) -> tuple[float, float]:
    tx, tz = travel_dir(yaw)
    return x + tx * dist, z + tz * dist


def heights_for(cid: str, n: int, rng: random.Random, jump_off: bool = False) -> list[float]:
    lo, hi = HEIGHTS[cid]
    if jump_off:
        lo = lo + (hi - lo) * 0.15
    span = hi - lo
    out = []
    for i in range(n):
        t = i / max(1, n - 1)
        h = lo + span * (0.12 + 0.78 * t)
        h += rng.uniform(-0.02, 0.02)
        out.append(round(clamp(h, lo, hi), 3))
    # last fence a hair quieter on lesson / beginner
    if cid in ("lesson", "beginner") and n >= 2:
        out[-1] = round(clamp(out[-1] - 0.02, lo, hi), 3)
    return out


def oxer_sp(cid: str, rng: random.Random) -> float:
    mx = OXER_SPREAD[cid]
    if mx <= 0:
        return 0.0
    lo = 0.28 if cid == "beginner" else 0.40
    return round(clamp(rng.uniform(lo, mx * 0.96), 0.20, mx), 3)


def kind_name(kind: str, filler: str) -> str:
    if kind == "flower":
        return "flower box"
    if kind == "oxer":
        return f"{filler} oxer" if filler else "oxer"
    if filler:
        return f"{filler} vertical"
    return "white vertical"


def fillers_for(cid: str, n: int, rng: random.Random) -> list[tuple[str, str]]:
    """Return (kind, filler-name) per fence. Kinds stay in vertical|oxer|flower."""
    pool_v = ["white", "brush", "plank", "natural"]
    out: list[tuple[str, str]] = []
    for i in range(n):
        r = rng.random()
        if cid == "lesson":
            out.append(("vertical", "white" if i == 0 else "plank"))
            continue
        if i == 0:
            out.append(("vertical", "white"))
            continue
        if r < 0.16:
            out.append(("flower", "flower"))
        elif r < (0.38 if cid != "beginner" else 0.28):
            fill = rng.choice(["brush", "plank", "gate"])
            out.append(("oxer", fill))
        else:
            out.append(("vertical", rng.choice(pool_v)))
    # guarantee at least one oxer on intermediate/advanced full tracks
    if cid in ("intermediate", "advanced") and n >= 8:
        if not any(k == "oxer" for k, _ in out):
            out[3] = ("oxer", "brush")
        if cid == "advanced" and sum(1 for k, _ in out if k == "oxer") < 2:
            out[5] = ("oxer", "gate")
    return out


def course_times(course: dict) -> None:
    cid = course["class_id"]
    jo = bool(course.get("jump_off"))
    length = path_length_m(course)
    course["time_allowed_school"] = time_from_path(length, False, cid, jo)
    course["time_allowed_show"] = time_from_path(length, True, cid, jo)
    if cid == "lesson":
        course["time_allowed_school"] = CLASS_TIME_SCHOOL["lesson"]
        course["time_allowed_show"] = CLASS_TIME_SHOW["lesson"]


def pack(
    cid: str,
    ident: str,
    name: str,
    notes: str,
    fences: list[dict],
    jump_off: bool = False,
    finish_z: float | None = None,
    session: list[str] | None = None,
) -> dict:
    if finish_z is None:
        if cid == "lesson" and not jump_off:
            last_z = max(f["pos"][2] for f in fences)
            finish_z = round(min(32.4, last_z + 6.4), 2)
        else:
            finish_z = FINISH_HOME
    if session is None:
        if cid == "lesson" and not jump_off:
            session = ["lesson"]
        elif jump_off:
            session = ["show"]
        else:
            session = ["schooling", "show"]
    rec = {
        "id": ident,
        "class_id": cid,
        "session_kinds": session,
        "name": name,
        "height_label": HEIGHT_LABEL[cid],
        "time_allowed_school": 0.0,
        "time_allowed_show": 0.0,
        "start_pos": list(START_POS),
        "start_yaw": round(START_YAW, 5),
        "finish_z": finish_z,
        "notes": notes,
        "fences": fences,
    }
    if jump_off:
        rec["jump_off"] = True
    course_times(rec)
    return rec


# ---------------------------------------------------------------------------
# Skeletons. Each is a list of (lane, z, yaw, related_strides_or_0)
# lane: 'R' right going up, 'L' left going up, 'C' center going up,
#       'RH' right home, 'LH' left home, 'D' diagonal (x interpolated)
# related_strides: if >0, this fence is IN and the next fence is placed
#   exactly that related distance along this fence's yaw.
# ---------------------------------------------------------------------------


def instantiate(
    skeleton: list[tuple[str, float, float, int]],
    cid: str,
    rng: random.Random,
    jump_off: bool,
    xr: float,
    xl: float,
) -> list[dict]:
    hs = heights_for(cid, len(skeleton), rng, jump_off)
    kinds = fillers_for(cid, len(skeleton), rng)
    sp = oxer_sp(cid, rng)
    fences: list[dict] = []
    i = 0
    skip_next_place = False
    pending_out: dict | None = None
    while i < len(skeleton):
        if pending_out is not None:
            fences.append(pending_out)
            pending_out = None
            i += 1
            continue
        lane, z, yaw, rel = skeleton[i]
        x = lane_x(lane, z, xr, xl)
        kind, fill = kinds[i]
        # lesson: no oxers
        if cid == "lesson" and kind == "oxer":
            kind, fill = "vertical", "white"
        h = hs[i]
        this_sp = sp if kind == "oxer" else 0.0
        num = len(fences) + 1
        rel_obj = None
        if rel in (1, 2, 3) and i + 1 < len(skeleton):
            dist = {1: D1, 2: D2, 3: D3}[rel]
            # tiny legal jitter inside the band
            dist = dist + rng.uniform(-0.15, 0.15)
            ox, oz = place_along(x, z, yaw, dist)
            rel_obj = related_to(num + 1, rel, dist)
            nkind, nfill = kinds[i + 1]
            if cid == "lesson" and nkind == "oxer":
                nkind, nfill = "vertical", "plank"
            nh = hs[i + 1]
            nsp = sp if nkind == "oxer" else 0.0
            pending_out = fence(
                num + 1, nkind, nh, nsp, ox, oz, yaw, kind_name(nkind, nfill), None
            )
        fences.append(
            fence(num, kind, h, this_sp, x, z, yaw, kind_name(kind, fill), rel_obj)
        )
        i += 1
    # Renumber in order
    for n, f in enumerate(fences, 1):
        f["num"] = n
        if f.get("related"):
            f["related"]["to"] = n + 1
    return fences


def lane_x(lane: str, z: float, xr: float, xl: float) -> float:
    if lane == "R":
        return xr
    if lane == "L":
        return xl
    if lane == "C":
        return 0.0
    if lane == "RH":
        return xr * 0.92
    if lane == "LH":
        return xl * 0.92
    if lane == "D":
        # diagonal: x slides with z
        t = (z + 24.0) / 52.0
        return xl + t * (xr - xl)
    if lane == "DR":
        t = (z + 24.0) / 52.0
        return xr - t * (xr * 0.55)
    if lane == "DL":
        t = (z + 24.0) / 52.0
        return xl + t * (abs(xl) * 0.55)
    return 0.0


def skel_lesson(rng: random.Random, variant: int) -> list[tuple[str, float, float, int]]:
    """3 fences. Pole, a single, a related two-stride — or a quiet S."""
    v = variant % 10
    if v == 0:
        z0 = rng.uniform(-20.0, -16.0)
        return [("C", z0, 0.0, 0), ("R", z0 + 12.0, -0.04, 2)]
        # related consumes next; we only listed 2 entries + related out
    if v == 1:
        z0 = rng.uniform(-22.0, -17.0)
        return [("R", z0, 0.0, 0), ("L", z0 + 11.0, 0.05, 2)]
    if v == 2:
        z0 = rng.uniform(-20.0, -16.5)
        return [("L", z0, 0.02, 0), ("R", z0 + 10.5, -0.03, 2)]
    if v == 3:
        z0 = rng.uniform(-21.0, -17.0)
        return [("C", z0, 0.0, 0), ("C", z0 + 11.5, 0.0, 2)]
    if v == 4:
        z0 = rng.uniform(-19.0, -16.0)
        return [("R", z0, 0.0, 2), ("R", 0.0, 0.0, 0)]  # related first, then a third later — wait
    # remaining: three singles with a two-stride as 2-3
    z0 = rng.uniform(-22.0, -17.5)
    return [
        ("C" if v % 2 == 0 else "R", z0, 0.0, 0),
        ("R" if v % 3 else "L", z0 + 9.5, rng.uniform(-0.05, 0.05), 2),
    ]


def expand_lesson_skel(skel: list[tuple[str, float, float, int]]) -> list[tuple[str, float, float, int]]:
    """Ensure skeleton length accounts for related outs.

    instantiate already inserts the related-out as the next skeleton slot.
    Lesson skeletons with a related at the end need a dummy next slot.
    """
    out: list[tuple[str, float, float, int]] = []
    for i, (lane, z, yaw, rel) in enumerate(skel):
        out.append((lane, z, yaw, rel))
        if rel and (i == len(skel) - 1 or True):
            pass
    # If last has related, add a placeholder that instantiate will overwrite.
    if out and out[-1][3] in (1, 2, 3):
        lane, z, yaw, rel = out[-1]
        dist = {1: D1, 2: D2, 3: D3}[rel]
        tx, tz = travel_dir(yaw)
        out.append((lane, z + tz * dist, yaw, 0))
    # If a middle related, the next entry is the OUT and will be repositioned.
    return out


def skel_beginner(rng: random.Random, variant: int) -> list[tuple[str, float, float, int]]:
    v = variant % 12
    z = [rng.uniform(a, b) for a, b in (
        (-25.5, -21.5),
        (-14.5, -10.5),
        (-3.5, 1.0),
        (8.0, 13.0),
        (18.5, 23.5),
        (26.5, 30.2),
    )]
    # coming home zs must leave 6.2m from going-up fences; pick lower
    h1 = rng.uniform(6.0, 12.0)
    h2 = rng.uniform(-14.0, -8.0)
    if v == 0:
        # outside track, related two-stride down the right as 1-2
        return [
            ("R", z[0], 0.0, 2),
            ("R", z[0] + D2, 0.0, 0),
            ("L", z[2], 0.06, 0),
            ("R", z[3], -0.04, 0),
            ("L", z[4], 0.08, 0),
            ("C", z[5], 0.0, 0),
            ("LH", h1, PI + 0.05, 0),
            ("RH", h2, PI - 0.08, 0),
        ]
    if v == 1:
        return [
            ("L", z[0], 0.04, 0),
            ("R", z[1], -0.04, 0),
            ("L", z[2], 0.05, 2),
            ("L", z[2] + D2, 0.05, 0),
            ("R", z[4], -0.06, 0),
            ("C", z[5], 0.0, 0),
            ("RH", h1, PI - 0.06, 0),
            ("LH", h2, PI + 0.06, 0),
        ]
    if v == 2:
        return [
            ("R", z[0], 0.0, 0),
            ("L", z[1], 0.08, 0),
            ("R", z[2], -0.05, 0),
            ("L", z[3], 0.10, 0),
            ("R", z[4], -0.06, 0),
            ("C", z[5], 0.0, 0),
            ("LH", h1, PI + 0.04, 0),
            ("RH", h2, PI - 0.10, 0),
        ]
    if v == 3:
        return [
            ("R", z[0], 0.0, 0),
            ("DR", z[1], -0.18, 0),
            ("L", z[2], 0.12, 0),
            ("R", z[3], -0.08, 2),
            ("R", z[3] + D2, -0.08, 0),
            ("C", z[5], 0.0, 0),
            ("LH", h1, PI + 0.08, 0),
            ("RH", h2, PI - 0.05, 0),
        ]
    if v == 4:
        return [
            ("C", z[0] + 2.0, 0.0, 0),
            ("R", z[1], -0.04, 0),
            ("L", z[2], 0.06, 0),
            ("R", z[3], -0.05, 0),
            ("L", z[4], 0.07, 0),
            ("C", z[5], 0.0, 0),
            ("RH", h1, PI - 0.04, 0),
            ("LH", h2, PI + 0.07, 0),
        ]
    if v == 5:
        # one-stride on the left as 3-4
        return [
            ("R", z[0], 0.0, 0),
            ("L", z[1], 0.05, 0),
            ("R", z[2], -0.04, 1),
            ("R", z[2] + D1, -0.04, 0),
            ("L", z[4], 0.08, 0),
            ("C", z[5], 0.0, 0),
            ("LH", h1, PI + 0.05, 0),
            ("RH", h2, PI - 0.08, 0),
        ]
    if v == 6:
        return [
            ("L", z[0], 0.03, 2),
            ("L", z[0] + D2, 0.03, 0),
            ("R", z[2], -0.06, 0),
            ("L", z[3], 0.05, 0),
            ("R", z[4], -0.05, 0),
            ("C", z[5], 0.0, 0),
            ("RH", h1, PI - 0.07, 0),
            ("LH", h2, PI + 0.04, 0),
        ]
    if v == 7:
        return [
            ("R", z[0], 0.0, 0),
            ("L", z[1], 0.10, 0),
            ("C", z[2], 0.0, 0),
            ("R", z[3], -0.08, 0),
            ("L", z[4], 0.06, 0),
            ("C", z[5], 0.0, 0),
            ("LH", h1, PI + 0.03, 0),
            ("RH", h2, PI - 0.09, 0),
        ]
    if v == 8:
        return [
            ("R", z[0], 0.0, 0),
            ("L", z[1], 0.05, 0),
            ("R", z[2], -0.04, 0),
            ("DL", z[3], 0.22, 0),
            ("R", z[4], -0.07, 0),
            ("C", z[5], 0.0, 0),
            ("LH", h1, PI + 0.06, 0),
            ("RH", h2, PI - 0.06, 0),
        ]
    if v == 9:
        return [
            ("R", z[0], 0.0, 3),
            ("R", z[0] + D3, 0.0, 0),
            ("L", z[2], 0.07, 0),
            ("R", z[3], -0.05, 0),
            ("L", z[4], 0.06, 0),
            ("C", z[5], 0.0, 0),
            ("RH", h1, PI - 0.05, 0),
            ("LH", h2, PI + 0.08, 0),
        ]
    if v == 10:
        return [
            ("L", z[0], 0.04, 0),
            ("R", z[1], -0.04, 0),
            ("L", z[2], 0.05, 0),
            ("R", z[3], -0.05, 0),
            ("L", z[4], 0.06, 2),
            ("L", z[4] + D2, 0.06, 0),  # may collide with top — z[4] is ~20, +10.8 ~31
            ("RH", h1, PI - 0.06, 0),
            ("LH", h2, PI + 0.05, 0),
        ]
    return [
        ("R", z[0], 0.0, 0),
        ("L", z[1], 0.06, 0),
        ("R", z[2], -0.05, 0),
        ("L", z[3], 0.08, 0),
        ("R", z[4], -0.04, 0),
        ("C", z[5], 0.0, 0),
        ("LH", h1, PI + 0.10, 0),
        ("RH", h2, PI - 0.04, 0),
    ]


def skel_intermediate(rng: random.Random, variant: int) -> list[tuple[str, float, float, int]]:
    """10 fences. One related. One rollback max."""
    v = variant % 10
    z = [rng.uniform(a, b) for a, b in (
        (-26.0, -22.5),
        (-16.5, -13.0),
        (-7.5, -3.5),
        (2.0, 6.5),
        (12.0, 16.5),
        (21.0, 24.5),
        (27.0, 30.5),
    )]
    h1 = rng.uniform(14.0, 19.0)
    h2 = rng.uniform(2.0, 8.0)
    h3 = rng.uniform(-16.0, -9.0)
    if v == 0:
        return [
            ("R", z[0], 0.0, 2),
            ("R", z[0] + D2, 0.0, 0),
            ("L", z[2], 0.10, 0),
            ("R", z[3], -0.08, 0),
            ("L", z[4], 0.12, 0),
            ("R", z[5], -0.06, 0),
            ("C", z[6], 0.0, 0),
            ("LH", h1, PI + 0.08, 0),
            ("RH", h2, PI - 0.12, 0),
            ("LH", h3, PI + 0.05, 0),
        ]
    if v == 1:
        # rollback after the top: jump 7 going up, 8 comes home nearby
        return [
            ("L", z[0], 0.04, 0),
            ("R", z[1], -0.06, 0),
            ("L", z[2], 0.08, 2),
            ("L", z[2] + D2, 0.08, 0),
            ("R", z[4], -0.08, 0),
            ("L", z[5], 0.06, 0),
            ("C", z[6], 0.0, 0),
            ("RH", z[5] - 1.2, PI - 0.10, 0),  # rollback
            ("LH", h2, PI + 0.08, 0),
            ("RH", h3, PI - 0.06, 0),
        ]
    if v == 2:
        return [
            ("R", z[0], 0.0, 0),
            ("L", z[1], 0.12, 0),
            ("R", z[2], -0.10, 0),
            ("L", z[3], 0.08, 0),
            ("R", z[4], -0.08, 1),
            ("R", z[4] + D1, -0.08, 0),
            ("C", z[6], 0.0, 0),
            ("LH", h1, PI + 0.10, 0),
            ("RH", h2, PI - 0.10, 0),
            ("LH", h3, PI + 0.06, 0),
        ]
    if v == 3:
        return [
            ("R", z[0], 0.0, 0),
            ("DR", z[1], -0.22, 0),
            ("L", z[2], 0.14, 0),
            ("R", z[3], -0.08, 0),
            ("L", z[4], 0.10, 0),
            ("R", z[5], -0.06, 0),
            ("C", z[6], 0.0, 0),
            ("LH", h1, PI + 0.06, 0),
            ("RH", h2, PI - 0.14, 0),
            ("LH", h3, PI + 0.04, 0),
        ]
    if v == 4:
        return [
            ("L", z[0], 0.05, 3),
            ("L", z[0] + D3, 0.05, 0),
            ("R", z[2], -0.08, 0),
            ("L", z[3], 0.08, 0),
            ("R", z[4], -0.07, 0),
            ("L", z[5], 0.06, 0),
            ("C", z[6], 0.0, 0),
            ("RH", h1, PI - 0.08, 0),
            ("LH", h2, PI + 0.10, 0),
            ("RH", h3, PI - 0.05, 0),
        ]
    if v == 5:
        return [
            ("R", z[0], 0.0, 0),
            ("L", z[1], 0.08, 0),
            ("C", z[2], 0.0, 0),
            ("R", z[3], -0.10, 0),
            ("L", z[4], 0.10, 0),
            ("R", z[5], -0.06, 0),
            ("C", z[6], 0.0, 0),
            ("LH", h1, PI + 0.08, 0),
            ("RH", h2, PI - 0.08, 0),
            ("LH", h3, PI + 0.05, 0),
        ]
    if v == 6:
        return [
            ("R", z[0], 0.0, 2),
            ("R", z[0] + D2, 0.0, 0),
            ("L", z[2], 0.10, 0),
            ("R", z[3], -0.08, 0),
            ("DL", z[4], 0.20, 0),
            ("R", z[5], -0.07, 0),
            ("C", z[6], 0.0, 0),
            ("LH", h1, PI + 0.07, 0),
            ("RH", h2, PI - 0.11, 0),
            ("LH", h3, PI + 0.04, 0),
        ]
    if v == 7:
        return [
            ("L", z[0], 0.04, 0),
            ("R", z[1], -0.05, 0),
            ("L", z[2], 0.08, 0),
            ("R", z[3], -0.08, 2),
            ("R", z[3] + D2, -0.08, 0),
            ("L", z[5], 0.07, 0),
            ("C", z[6], 0.0, 0),
            ("RH", h1, PI - 0.09, 0),
            ("LH", h2, PI + 0.09, 0),
            ("RH", h3, PI - 0.04, 0),
        ]
    if v == 8:
        return [
            ("R", z[0], 0.0, 0),
            ("L", z[1], 0.09, 0),
            ("R", z[2], -0.07, 0),
            ("L", z[3], 0.08, 0),
            ("R", z[4], -0.06, 0),
            ("L", z[5], 0.07, 0),
            ("C", z[6], 0.0, 0),
            ("RH", z[5] - 0.8, PI - 0.12, 0),
            ("LH", h2, PI + 0.08, 0),
            ("RH", h3, PI - 0.06, 0),
        ]
    return [
        ("R", z[0], 0.0, 0),
        ("L", z[1], 0.10, 0),
        ("R", z[2], -0.09, 0),
        ("L", z[3], 0.07, 0),
        ("R", z[4], -0.07, 0),
        ("L", z[5], 0.08, 0),
        ("C", z[6], 0.0, 0),
        ("LH", h1, PI + 0.09, 0),
        ("RH", h2, PI - 0.09, 0),
        ("LH", h3, PI + 0.04, 0),
    ]


def skel_advanced(rng: random.Random, variant: int) -> list[tuple[str, float, float, int]]:
    """12 fences. Related + up to two rollbacks."""
    v = variant % 8
    z = [rng.uniform(a, b) for a, b in (
        (-26.5, -23.0),
        (-18.5, -15.0),
        (-10.5, -7.0),
        (-2.5, 1.5),
        (6.5, 10.5),
        (14.5, 18.5),
        (22.0, 25.5),
        (27.5, 31.0),
    )]
    h1 = rng.uniform(16.0, 21.0)
    h2 = rng.uniform(6.0, 12.0)
    h3 = rng.uniform(-4.0, 2.0)
    h4 = rng.uniform(-18.0, -11.0)
    if v == 0:
        return [
            ("R", z[0], 0.0, 2),
            ("R", z[0] + D2, 0.0, 0),
            ("L", z[2], 0.14, 0),
            ("R", z[3], -0.10, 0),
            ("L", z[4], 0.16, 0),
            ("R", z[5], -0.08, 0),
            ("C", z[7], 0.0, 0),
            ("LH", h1, PI + 0.10, 0),
            ("RH", h2, PI - 0.14, 0),
            ("LH", h3, PI + 0.06, 0),
            ("RH", h4, PI - 0.18, 0),
            ("R", z[0] + 3.5, 0.22, 0),  # last going up again? might be illegal approach
        ]
    # last fence of v0 is a problem (going up after coming home). Don't use that.
    if v == 0 or v == 1:
        return [
            ("R", z[0], 0.0, 2),
            ("R", z[0] + D2, 0.0, 0),
            ("L", z[2], 0.14, 0),
            ("R", z[3], -0.10, 0),
            ("L", z[4], 0.16, 0),
            ("R", z[5], -0.08, 0),
            ("L", z[6], 0.10, 0),
            ("C", z[7], 0.0, 0),
            ("LH", h1, PI + 0.10, 0),
            ("RH", h2, PI - 0.14, 0),
            ("LH", h3, PI + 0.06, 0),
            ("RH", h4, PI - 0.18, 0),
        ]
    if v == 2:
        return [
            ("L", z[0], 0.06, 0),
            ("R", z[1], -0.08, 0),
            ("L", z[2], 0.12, 2),
            ("L", z[2] + D2, 0.12, 0),
            ("R", z[4], -0.10, 0),
            ("L", z[5], 0.10, 0),
            ("R", z[6], -0.08, 0),
            ("C", z[7], 0.0, 0),
            ("RH", z[6] - 1.0, PI - 0.12, 0),  # rollback 1
            ("LH", h2, PI + 0.10, 0),
            ("RH", h3, PI - 0.10, 0),
            ("LH", h4, PI + 0.08, 0),
        ]
    if v == 3:
        return [
            ("R", z[0], 0.0, 0),
            ("L", z[1], 0.12, 0),
            ("R", z[2], -0.12, 0),
            ("L", z[3], 0.10, 0),
            ("R", z[4], -0.10, 1),
            ("R", z[4] + D1, -0.10, 0),
            ("L", z[6], 0.08, 0),
            ("C", z[7], 0.0, 0),
            ("LH", h1, PI + 0.12, 0),
            ("RH", h2, PI - 0.12, 0),
            ("LH", h3, PI + 0.08, 0),
            ("RH", h4, PI - 0.10, 0),
        ]
    if v == 4:
        return [
            ("R", z[0], 0.0, 3),
            ("R", z[0] + D3, 0.0, 0),
            ("L", z[2], 0.14, 0),
            ("DR", z[3], -0.24, 0),
            ("L", z[4], 0.16, 0),
            ("R", z[5], -0.10, 0),
            ("L", z[6], 0.10, 0),
            ("C", z[7], 0.0, 0),
            ("RH", h1, PI - 0.10, 0),
            ("LH", h2, PI + 0.14, 0),
            ("RH", h3, PI - 0.08, 0),
            ("LH", h4, PI + 0.06, 0),
        ]
    if v == 5:
        # two rollbacks: 8 and 11
        return [
            ("L", z[0], 0.05, 0),
            ("R", z[1], -0.07, 0),
            ("L", z[2], 0.11, 0),
            ("R", z[3], -0.11, 2),
            ("R", z[3] + D2, -0.11, 0),
            ("L", z[5], 0.09, 0),
            ("R", z[6], -0.08, 0),
            ("C", z[7], 0.0, 0),
            ("LH", z[6] - 0.6, PI + 0.12, 0),
            ("RH", h2, PI - 0.12, 0),
            ("LH", h3 + 4.0, PI + 0.10, 0),
            ("RH", h4, PI - 0.08, 0),
        ]
    if v == 6:
        return [
            ("R", z[0], 0.0, 0),
            ("L", z[1], 0.13, 0),
            ("R", z[2], -0.11, 0),
            ("L", z[3], 0.11, 0),
            ("R", z[4], -0.09, 0),
            ("L", z[5], 0.10, 0),
            ("R", z[6], -0.07, 0),
            ("C", z[7], 0.0, 0),
            ("LH", h1, PI + 0.11, 0),
            ("RH", h2, PI - 0.13, 0),
            ("LH", h3, PI + 0.07, 0),
            ("RH", h4, PI - 0.09, 0),
        ]
    return [
        ("L", z[0], 0.04, 2),
        ("L", z[0] + D2, 0.04, 0),
        ("R", z[2], -0.10, 0),
        ("L", z[3], 0.12, 0),
        ("R", z[4], -0.10, 0),
        ("L", z[5], 0.08, 0),
        ("R", z[6], -0.08, 0),
        ("C", z[7], 0.0, 0),
        ("RH", h1, PI - 0.11, 0),
        ("LH", h2, PI + 0.13, 0),
        ("RH", h3, PI - 0.09, 0),
        ("LH", h4, PI + 0.07, 0),
    ]


def skel_jump_off(rng: random.Random, variant: int) -> list[tuple[str, float, float, int]]:
    v = variant % 6
    z0 = rng.uniform(-22.0, -16.0)
    z1 = rng.uniform(-6.0, 2.0)
    z2 = rng.uniform(12.0, 20.0)
    h = rng.uniform(-14.0, -6.0)
    if v == 0:
        return [
            ("R", z0, 0.0, 0),
            ("L", z1, 0.12, 0),
            ("R", z2, -0.08, 0),
            ("LH", h, PI - 0.06, 0),
        ]
    if v == 1:
        return [
            ("L", z0, 0.04, 0),
            ("R", z1, -0.10, 0),
            ("L", z2, 0.08, 0),
            ("RH", h, PI + 0.06, 0),
        ]
    if v == 2:
        return [
            ("R", z0, 0.0, 2),
            ("R", z0 + D2, 0.0, 0),
            ("L", z2, 0.10, 0),
            ("RH", h, PI - 0.08, 0),
        ]
    if v == 3:
        return [
            ("C", z0 + 2.0, 0.0, 0),
            ("R", z1, -0.08, 0),
            ("L", z2, 0.10, 0),
            ("RH", h, PI - 0.05, 0),
        ]
    if v == 4:
        return [
            ("R", z0, 0.0, 0),
            ("DL", z1, 0.22, 0),
            ("R", z2, -0.10, 0),
            ("LH", h, PI + 0.08, 0),
        ]
    return [
        ("L", z0, 0.05, 0),
        ("R", z1, -0.12, 0),
        ("C", z2 + 4.0, 0.0, 0),
        ("LH", h, PI + 0.04, 0),
    ]


NAMES = {
    "lesson": [
        "Poles to a line",
        "Quiet three",
        "Right-hand two-stride",
        "Left-hand two-stride",
        "Center line",
        "First related",
        "Walk him in",
        "Tuesday poles",
        "Same three as last week",
        "Outside three",
    ],
    "beginner": [
        "Outside track, first week",
        "Outside track, the other way",
        "Right-hand related",
        "Left-hand related",
        "Welcome Stake schooling",
        "Diagonal and home",
        "Flower off the right",
        "Quiet eight",
        "Long approach, short track",
        "Crossrails, outside",
        "One-stride down the right",
        "Three-stride down the right",
    ],
    "intermediate": [
        "Schooling Jumpers, outside",
        "Classic track",
        "Related and a rollback",
        "Diagonal Classic",
        "Left-hand three-stride",
        "One-stride in the middle",
        "Long side related",
        "Inside rollback",
        "Ten, no tricks",
        "Classic, the other lead",
    ],
    "advanced": [
        "Mini Prix, outside",
        "Mini Prix, related first",
        "Two rollbacks",
        "One-stride and home",
        "Three-stride down the right",
        "Open Jumpers, long day",
        "Diagonal Mini Prix",
        "Left-hand related, home",
    ],
    "jump_off": [
        "Jump-off, four",
        "Jump-off, inside",
        "Jump-off, related",
        "Jump-off, center first",
        "Jump-off, diagonal",
        "Jump-off, left first",
    ],
}

NOTES = {
    "lesson": [
        "Poles, then a single, then a two-stride. Wait for the last stride.",
        "Same three as the lesson. Walk him in. Don't chase the line.",
        "Related two-stride on the right. Make the last canter stride.",
        "Left-hand line. Straight and quiet. He'll tell you.",
        "Center line. Eyes up. Don't drop him in front of the second.",
    ],
    "beginner": [
        "Outside track. Find the canter and leave him alone to the first.",
        "One related. Don't move on the in. Sit to the out.",
        "Flower off the right. Straight. He looks if you do.",
        "Welcome Stake track. School it quiet. Don't make a show of it.",
        "Long approaches. Half-halt, last stride, then ask.",
    ],
    "intermediate": [
        "Ten fences. One related. Don't cut the corners.",
        "One rollback. Sit, turn, and wait — don't chase the leave.",
        "Classic. Keep the outside track. He canters this ring.",
        "One-stride in the middle. Don't move. Let him jump it.",
        "Schooling jumpers. Make the distances. Don't invent one.",
    ],
    "advanced": [
        "Twelve. Related early. Don't get busy after the first leave.",
        "Two rollbacks. Sit down and wait. Don't pull him around.",
        "Mini Prix. Keep the canter. He has the scope if you wait.",
        "One-stride and home. Don't chip the in.",
        "Open jumpers. Eyes up. Leave with him.",
    ],
    "jump_off": [
        "Four fences. Don't chase him. The clock is already running.",
        "Inside turns. Sit. He knows the way home.",
        "Jump-off. Leave the first, then wait. Don't throw the rest away.",
    ],
}


def note_for(cid: str, jump_off: bool, rng: random.Random) -> str:
    key = "jump_off" if jump_off else cid
    return rng.choice(NOTES[key])


def name_for(cid: str, jump_off: bool, idx: int, rng: random.Random) -> str:
    key = "jump_off" if jump_off else cid
    base = NAMES[key][idx % len(NAMES[key])]
    extra = rng.choice(["", "", " · quiet", " · Tuesday", " · first school", " · the other way"])
    return (base + extra).strip(" ·")


def find_z(
    existing: list[dict],
    x: float,
    z_lo: float,
    z_hi: float,
    rng: random.Random,
    last: dict | None,
    yaw: float,
    tries: int = 90,
) -> float | None:
    for _ in range(tries):
        z = rng.uniform(z_lo, z_hi)
        if z > 31.6 or z < -27.8:
            continue
        pos = [x, 0.0, z]
        if any(dist_xz(pos, f["pos"]) < MIN_SEP for f in existing):
            continue
        if last is not None:
            dx = x - float(last["pos"][0])
            dz = z - float(last["pos"][2])
            mag = math.hypot(dx, dz)
            if mag < MIN_SEP:
                continue
            tx, tz = travel_dir(yaw)
            if mag > 0.2 and (dx * tx + dz * tz) / mag < 0.22:
                continue
            lx, lz = travel_dir(float(last["yaw"]))
            leave_dot = (dx * lx + dz * lz) / mag
            turn = math.acos(max(-1.0, min(1.0, leave_dot)))
            if mag < 12.0 and turn > math.radians(84.0):
                continue
        return z
    return None


MIN_SEP = 6.2


def build_safe(cid: str, rng: random.Random, jump_off: bool) -> list[dict] | None:
    """Canonical hunter track with jitter. Related pairs are placed exactly."""
    n = JO_COUNT if jump_off else COUNTS[cid]
    xr = rng.uniform(6.6, 8.9)
    xl = rng.uniform(-8.9, -6.6)
    hs = heights_for(cid, n, rng, jump_off)
    kinds = fillers_for(cid, n, rng)
    sp = oxer_sp(cid, rng)
    related_at: int | None = None  # 0-based index of IN
    related_n = rng.choice([2, 2, 2, 1, 3]) if n >= 3 else None
    if cid == "lesson":
        related_at = 1  # fences 2-3
        related_n = 2
    elif jump_off:
        related_at = 0 if rng.random() < 0.45 else None
        related_n = 2 if related_at is not None else None
    else:
        # related early on the way up, never as the last going-up pair into the top
        max_in = max(0, min(n - 5, 3))
        related_at = rng.randint(0, max_in) if n >= 6 else 0
        if related_n == 3 and related_at > 1:
            related_n = 2

    dist = {1: D1, 2: D2, 3: D3}.get(related_n or 2, D2)
    dist = dist + rng.uniform(-0.12, 0.12)

    fences: list[dict] = []

    def add(kind, fill, h, x, z, yaw, rel=None) -> dict:
        this_sp = sp if kind == "oxer" else 0.0
        if cid == "lesson" and kind == "oxer":
            kind, fill, this_sp = "vertical", "white", 0.0
        f = fence(len(fences) + 1, kind, h, this_sp, x, z, yaw, kind_name(kind, fill), rel)
        fences.append(f)
        return f

    if cid == "lesson":
        z0 = rng.uniform(-22.0, -17.5)
        x0 = rng.choice([0.0, rng.uniform(-1.8, 1.8), xr * 0.35])
        k0, f0 = kinds[0]
        add(k0, f0, hs[0], x0, z0, 0.0, None)
        side = rng.choice([xr, xl])
        yaw = 0.0 if side > 0 else 0.05
        z1 = z0 + rng.uniform(10.5, 13.5)
        k1, f1 = kinds[1]
        add(k1, f1, hs[1], side, z1, yaw, related_to(3, 2, dist))
        ox, oz = place_along(side, z1, yaw, dist)
        k2, f2 = kinds[2]
        add(k2, f2, hs[2], ox, oz, yaw, None)
        return fences if len(fences) == 3 else None

    # Going-up count, then home.
    if jump_off:
        n_up = 3
        n_home = 1
    elif n == 8:
        n_up, n_home = 6, 2
    elif n == 10:
        n_up, n_home = 7, 3
    else:
        n_up, n_home = 8, 4

    z = rng.uniform(-25.5, -21.5)
    for i in range(n_up):
        kind, fill = kinds[i]
        h = hs[i]
        if i == related_at:
            lane_x_ = xr if rng.random() < 0.62 else xl
            yaw = 0.0 if lane_x_ > 0 else 0.06
            if i > 0:
                z_try = find_z(fences, lane_x_, z + 6.4, z + 11.5, rng, fences[-1], yaw)
                if z_try is None:
                    return None
                z = z_try
            add(kind, fill, h, lane_x_, z, yaw, related_to(i + 2, related_n or 2, dist))
            ox, oz = place_along(lane_x_, z, yaw, dist)
            if oz > 31.4 or oz < -27.8 or abs(ox) > 9.8:
                return None
            if any(dist_xz([ox, 0, oz], f["pos"]) < MIN_SEP for f in fences):
                return None
            i2 = i + 1
            if i2 >= n_up:
                return None
            k2, f2 = kinds[i2]
            add(k2, f2, hs[i2], ox, oz, yaw, None)
            z = oz
            # skip the out in the for-loop by consuming an extra index — handled below
            continue
        if related_at is not None and i == related_at + 1:
            continue  # already placed as OUT
        # alternate rails
        lane_x_ = xr if (i % 2 == 0) else xl
        if i == n_up - 1:
            lane_x_ = 0.0  # top of the ring
        yaw = 0.0 if lane_x_ >= 0 else 0.07
        if lane_x_ == 0.0:
            yaw = rng.uniform(-0.04, 0.04)
        if i == 0:
            z = rng.uniform(-25.8, -21.0)
        else:
            z_try = find_z(
                fences,
                lane_x_,
                max(-27.0, z + 6.5),
                min(31.2, z + 12.8),
                rng,
                fences[-1],
                yaw,
            )
            if z_try is None:
                # try the other rail
                lane_x_ = xl if lane_x_ > 0 else xr
                yaw = 0.0 if lane_x_ > 0 else 0.07
                z_try = find_z(
                    fences,
                    lane_x_,
                    max(-27.0, z + 6.5),
                    min(31.2, z + 13.5),
                    rng,
                    fences[-1],
                    yaw,
                )
            if z_try is None:
                return None
            z = z_try
        add(kind, fill, h, lane_x_, z, yaw, None)

    # Coming home: yaw ~ PI, decreasing z, opposite-rail preference.
    z_home = 18.0
    for j in range(n_home):
        i = n_up + j
        kind, fill = kinds[i] if i < len(kinds) else ("vertical", "white")
        h = hs[i] if i < len(hs) else hs[-1]
        yaw = PI + rng.uniform(-0.10, 0.10)
        # alternate home rails
        hx = xl * 0.92 if j % 2 == 0 else xr * 0.92
        z_hi = min(30.0, (fences[-1]["pos"][2] if fences else 20.0) - 1.0)
        z_lo = -26.0 if j == n_home - 1 else -8.0
        if j == 0:
            z_hi = min(30.5, max(f["pos"][2] for f in fences) - 0.4)
            z_lo = 4.0
        z_try = find_z(fences, hx, z_lo, z_hi, rng, fences[-1] if fences else None, yaw)
        if z_try is None:
            hx = -hx
            z_try = find_z(fences, hx, z_lo - 4.0, z_hi, rng, fences[-1] if fences else None, yaw)
        if z_try is None:
            return None
        add(kind, fill, h, hx, z_try, yaw, None)

    if len(fences) != n:
        return None
    for k, f in enumerate(fences, 1):
        f["num"] = k
        if f.get("related"):
            f["related"]["to"] = k + 1
    return fences


def try_build(
    cid: str,
    idx: int,
    rng: random.Random,
    jump_off: bool,
) -> dict | None:
    fences = None
    # Prefer the geometry-first builder; fall back to skeletons for variety.
    if rng.random() < 0.72 or cid == "lesson":
        fences = build_safe(cid, rng, jump_off)
    if fences is None:
        xr = rng.uniform(6.4, 9.2)
        xl = rng.uniform(-9.2, -6.4)
        if jump_off:
            skel = skel_jump_off(rng, idx)
        elif cid == "lesson":
            skel = expand_lesson_skel(skel_lesson(rng, idx))
        elif cid == "beginner":
            skel = skel_beginner(rng, idx)
        elif cid == "intermediate":
            skel = skel_intermediate(rng, idx)
        else:
            skel = skel_advanced(rng, idx)
        need = JO_COUNT if jump_off else COUNTS[cid]
        fences = instantiate(skel, cid, rng, jump_off, xr, xl)
        if len(fences) != need:
            if abs(len(fences) - need) > 2:
                return None
            if len(fences) > need:
                fences = fences[:need]
                for n, f in enumerate(fences, 1):
                    f["num"] = n
                    if f.get("related") and int(f["related"]["to"]) > need:
                        f["related"] = None
            else:
                return None
    prefix = "hk"
    kind = "jo" if jump_off else {"lesson": "les", "beginner": "beg", "intermediate": "int", "advanced": "adv"}[cid]
    ident = f"{prefix}_{kind}_{idx:03d}"
    rec = pack(
        cid,
        ident,
        name_for(cid, jump_off, idx, rng),
        note_for(cid, jump_off, rng),
        fences,
        jump_off=jump_off,
    )
    errs = validate_course(rec)
    if errs:
        return None
    return rec


def generate_class(cid: str, target: int, jump_off: bool, start_idx: int, seen: set[str]) -> list[dict]:
    out: list[dict] = []
    idx = start_idx
    attempts = 0
    max_attempts = target * 80
    while len(out) < target and attempts < max_attempts:
        attempts += 1
        rng = random.Random(1000 * (2 if jump_off else 1) + idx * 17 + attempts * 3 + hash(cid) % 997)
        rec = try_build(cid, idx, rng, jump_off)
        idx += 1
        if rec is None:
            continue
        h = round_hash_part(rec)
        if h in seen:
            continue
        seen.add(h)
        # unique id
        rec["id"] = f"hk_{'jo' if jump_off else cid[:3]}_{len(out) + start_idx:03d}"
        if jump_off:
            rec["id"] = f"hk_jo_{cid[:3]}_{len(out) + 1:03d}"
        out.append(rec)
    return out


def write_course(rec: dict) -> Path:
    cid = rec["class_id"]
    folder = OUT / cid
    if rec.get("jump_off"):
        folder = OUT / "jump_off" / cid
    folder.mkdir(parents=True, exist_ok=True)
    path = folder / f"{rec['id']}.json"
    path.write_text(json.dumps(rec, indent=2) + "\n", encoding="utf-8")
    return path


def write_index(rows: list[dict]) -> None:
    INDEX.parent.mkdir(parents=True, exist_ok=True)
    INDEX.write_text(json.dumps(rows, indent=2) + "\n", encoding="utf-8")


def main() -> int:
    # Expanded targets so a later pass is not inventing tracks.
    targets = {
        ("lesson", False): 50,
        ("beginner", False): 70,
        ("intermediate", False): 70,
        ("advanced", False): 60,
        ("beginner", True): 18,
        ("intermediate", True): 18,
        ("advanced", True): 18,
    }
    seen: set[str] = set()
    all_rows: list[dict] = []
    all_courses: list[dict] = []
    for (cid, jo), n in targets.items():
        print(f"generating {cid} jump_off={jo} target={n}")
        batch = generate_class(cid, n, jo, start_idx=1, seen=seen)
        print(f"  got {len(batch)}")
        for rec in batch:
            path = write_course(rec)
            rel = path.relative_to(ROOT).as_posix()
            all_rows.append(
                {
                    "id": rec["id"],
                    "class": rec["class_id"],
                    "jump_off": bool(rec.get("jump_off")),
                    "name": rec["name"],
                    "path": rel,
                    "time_allowed_school": rec["time_allowed_school"],
                    "time_allowed_show": rec["time_allowed_show"],
                    "fence_count": len(rec["fences"]),
                }
            )
            all_courses.append(rec)
    write_index(all_rows)
    print(f"wrote {len(all_courses)} courses, index {INDEX}")
    # Minimum bar for this script; validator is the real gate.
    if len(all_courses) < 160:
        print(f"UNDER 160 ({len(all_courses)})")
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
