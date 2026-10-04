"""Deterministic Hidden K tracks. Built to validate, not rejection-sampled."""
from __future__ import annotations

import math
import random

from make_courses import D1, D2, D3, fence, kind_name, pack, place_along, related_to
from rules import (
    COUNTS,
    HEIGHT_LABEL,
    HEIGHTS,
    INDOOR_COUNTS,
    INDOOR_FINISH,
    INDOOR_JO_COUNT,
    INDOOR_MIN_SEPARATION,
    INDOOR_START_POS,
    INDOOR_TURN_MAG,
    INDOOR_X_MAX,
    INDOOR_Z_MAX,
    JO_COUNT,
    MIN_SEPARATION,
    OXER_SPREAD,
    PI,
    START_YAW,
    dist_xz,
    path_length_m,
    time_from_path,
    travel_dir,
    validate_course,
)

PATTERNS = [
    "outside_track",
    "inside_track",
    "figure_eight",
    "diagonal_both_ways",
    "related_out",
    "related_in",
    "rollback_short",
    "rollback_long",
    "bending_five",
    "fan_three",
    "in_and_out_two",
    "liverpool_lookalike_flower",
    "jump_off_tight",
    "lesson_poles",
    "lesson_single_then_line",
]


def clamp(v: float, lo: float, hi: float) -> float:
    return max(lo, min(hi, v))


def kinds_for(n: int, cid: str, rng: random.Random) -> list[str]:
    out: list[str] = []
    for i in range(n):
        if i == 0 or cid == "lesson":
            out.append("vertical")
            continue
        r = rng.random()
        prev = out[-1] if out else "vertical"
        if r < 0.13 and prev != "flower":
            out.append("flower")
        elif r < (0.42 if cid in ("intermediate", "advanced") else 0.32):
            out.append("oxer")
        else:
            out.append("vertical")
    if cid in ("intermediate", "advanced") and n >= 8 and "oxer" not in out:
        out[min(3, n - 2)] = "oxer"
    return out


def heights_for(cid: str, n: int, serial: int, rng: random.Random) -> list[float]:
    lo, hi = HEIGHTS[cid]
    out = []
    for i in range(n):
        t = i / max(1, n - 1)
        h = lo + (hi - lo) * (0.08 + 0.84 * t)
        h += ((serial * 17 + i * 13) % 11) * 0.001
        h += rng.uniform(-0.008, 0.008)
        out.append(round(clamp(h, lo, hi), 3))
    return out


def oxer_sp(cid: str, rng: random.Random) -> float:
    mx = OXER_SPREAD[cid]
    if mx <= 0:
        return 0.0
    lo = 0.28 if cid == "beginner" else 0.40
    return round(clamp(rng.uniform(lo, mx * 0.94), 0.20, mx), 3)


def _ok_pos(x: float, z: float, yaw: float, existing: list[dict], min_sep: float, turn_mag: float, indoor: bool) -> bool:
    zmax = INDOOR_Z_MAX - 0.35 if indoor else 31.6
    zmin = -INDOOR_Z_MAX + 0.35 if indoor else -27.7
    xmax = INDOOR_X_MAX - 0.1 if indoor else 9.7
    if abs(x) > xmax or z > zmax or z < zmin:
        return False
    pos = [x, 0.0, z]
    for f in existing:
        d = dist_xz(pos, f["pos"])
        if d < min_sep - 1e-6:
            return False
    if existing:
        prev = existing[-1]
        dx = x - float(prev["pos"][0])
        dz = z - float(prev["pos"][2])
        mag = math.hypot(dx, dz)
        if mag < 0.2:
            return False
        tx, tz = travel_dir(yaw)
        dot = (dx * tx + dz * tz) / mag
        if dot < 0.20:
            return False
        lx, lz = travel_dir(float(prev["yaw"]))
        leave_dot = (dx * lx + dz * lz) / mag
        turn = math.acos(max(-1.0, min(1.0, leave_dot)))
        limit = turn_mag
        if mag < limit and turn > math.radians(85.0 if not indoor else 100.0):
            return False
    return True


def _place_home(n_home: int, xr: float, xl: float, existing: list[dict], kinds: list[str], hs: list[float], sp: float, rng: random.Random, indoor: bool) -> list[dict] | None:
    min_sep = INDOOR_MIN_SEPARATION if indoor else MIN_SEPARATION
    turn_mag = INDOOR_TURN_MAG if indoor else 12.0
    z_hi = INDOOR_Z_MAX - 0.5 if indoor else 20.0
    z_lo = -INDOOR_Z_MAX + 0.5 if indoor else -26.0
    out: list[dict] = []
    placed = list(existing)
    n_up = len(existing)
    for j in range(n_home):
        found = None
        hx_opts = [xl * 0.92, xr * 0.92, xl * 0.80, xr * 0.80]
        z = z_hi
        while z >= z_lo:
            for hx in hx_opts:
                hyaw = PI + rng.uniform(-0.06, 0.06)
                if _ok_pos(hx, z, hyaw, placed, min_sep, turn_mag, indoor):
                    found = (hx, z, hyaw)
                    break
            if found:
                break
            z -= 0.45
        if not found:
            return None
        hx, hz, hyaw = found
        i = n_up + j
        kind = kinds[i] if i < len(kinds) else "vertical"
        if placed and placed[-1]["kind"] == "flower" and kind == "flower":
            kind = "vertical"
        this_sp = sp if kind == "oxer" else 0.0
        f = fence(i + 1, kind, hs[min(i, len(hs) - 1)], this_sp, hx, hz, hyaw, kind_name(kind, fill_for(kind, rng)), None)
        out.append(f)
        placed.append(f)
    return out


def fill_for(kind: str, rng: random.Random) -> str:
    if kind == "flower":
        return "flower"
    if kind == "oxer":
        return rng.choice(["brush", "plank", "gate", "white"])
    return rng.choice(["white", "brush", "plank", "natural"])


def lane_x(i: int, n_up: int, xr: float, xl: float, pattern: str) -> float:
    if pattern in ("inside_track",):
        return xl if i % 2 == 0 else xr
    if pattern in ("figure_eight",):
        return xr if (i // 2) % 2 == 0 else xl
    if pattern in ("diagonal_both_ways", "bending_five"):
        t = i / max(1, n_up - 1)
        return xr + t * (xl - xr)
    if pattern == "fan_three":
        return [xr, 0.0, xl][i % 3]
    if i == n_up - 1 and n_up >= 3:
        return 0.0
    return xr if i % 2 == 0 else xl


def construct_outdoor(cid: str, serial: int, rng: random.Random, jump_off: bool, pattern: str) -> dict | None:
    n = JO_COUNT if jump_off else COUNTS[cid]
    xr = clamp(6.55 + (serial % 29) * 0.105, 6.2, 9.55)
    xl = -clamp(6.50 + ((serial * 5) % 29) * 0.100, 6.2, 9.55)
    z0 = -26.35 + (serial % 19) * 0.085
    if jump_off:
        n_home = 1
        pattern = "jump_off_tight"
    elif cid == "lesson":
        n_home = 0
        if pattern not in ("lesson_poles", "lesson_single_then_line"):
            pattern = "lesson_single_then_line" if serial % 2 else "lesson_poles"
    else:
        n_home = 2 if n <= 8 else (3 if n <= 10 else 4)
    n_up = n - n_home
    if n_up < 1:
        return None

    related_strides = 0
    if n_up >= 2 and cid != "lesson":
        related_strides = 1 if pattern in ("in_and_out_two", "jump_off_tight") else (3 if pattern == "related_out" and n_up >= 3 else 2)
        if pattern == "related_in":
            related_strides = 2
    elif cid == "lesson" and pattern == "lesson_single_then_line":
        related_strides = 2
    dist = {0: 0.0, 1: D1, 2: D2, 3: D3}[related_strides]
    dist = dist + rng.uniform(-0.12, 0.12) if dist else 0.0

    kinds = kinds_for(n, cid, rng)
    if pattern == "liverpool_lookalike_flower" and n > 3:
        kinds[min(3, n - 2)] = "flower"
        if kinds[2] == "flower":
            kinds[2] = "vertical"
    hs = heights_for(cid, n, serial, rng)
    sp = oxer_sp(cid, rng)
    fences: list[dict] = []
    z_top = 28.2
    span = max(8.0, z_top - z0)
    zs = [z0 + span * i / max(1, n_up - 1) for i in range(n_up)]
    if related_strides and n_up >= 2:
        zs[1] = z0 + dist
        if n_up > 2:
            rest = z_top - zs[1]
            for i in range(2, n_up):
                zs[i] = zs[1] + rest * (i - 1) / (n_up - 2)
    for i in range(n_up):
        yaw = 0.0
        rel = None
        z = zs[i]
        if i == 1 and related_strides and fences:
            x, z = place_along(fences[0]["pos"][0], fences[0]["pos"][2], fences[0]["yaw"], dist)
            yaw = fences[0]["yaw"]
            fences[0]["related"] = related_to(2, related_strides, dist)
        else:
            x = lane_x(i, n_up, xr, xl, pattern)
            if i == 0:
                x = xr
                yaw = 0.0
            else:
                yaw = 0.05 if x < 0 else (-0.05 if x > 0.4 else 0.0)
                if pattern in ("bending_five", "diagonal_both_ways"):
                    yaw = clamp((xl - xr) / 40.0, -0.22, 0.22)
        if abs(x) > 9.7:
            x = 9.7 if x > 0 else -9.7
        if z > 31.4 or z < -27.8:
            return None
        if not _ok_pos(x, z, yaw, fences, MIN_SEPARATION if not (i == 1 and related_strides) else 0.1, 12.0, False) and not (i == 1 and related_strides):
            # try the other rail
            x = -x
            if not _ok_pos(x, z, yaw, fences, MIN_SEPARATION, 12.0, False):
                return None
        kind = kinds[i]
        this_sp = sp if kind == "oxer" else 0.0
        fences.append(
            fence(i + 1, kind, hs[i], this_sp, x, z, yaw, kind_name(kind, fill_for(kind, rng)), rel)
        )

    home = _place_home(n_home, xr, xl, fences, kinds, hs, sp, rng, False)
    if home is None:
        return None
    fences.extend(home)

    if len(fences) != n:
        return None
    for k, f in enumerate(fences, 1):
        f["num"] = k
        if f.get("related"):
            f["related"]["to"] = k + 1

    notes = "Outside track. Quiet to the first. Same leave."
    if related_strides:
        notes = f"Related {related_strides}-stride labeled. Don't move on the in."
    if cid in ("intermediate", "advanced"):
        if pattern in ("rollback_short", "rollback_long") or n_home >= 3:
            notes += " Rollback on the home stretch. Sit, turn, wait."
        else:
            notes += " Bending line off the diagonal. Hold the outside."
    if jump_off:
        notes = "Jump-off. Don't chase. Four fences."
    rec = pack(cid, f"hk_{'jo_' if jump_off else ''}{cid[:3]}_{serial:04d}", "tmp", notes, fences, jump_off)
    rec["ring"] = "outdoor"
    rec["pattern"] = pattern
    rec["indoor"] = False
    return rec


def construct_indoor(cid: str, serial: int, rng: random.Random, jump_off: bool, pattern: str) -> dict | None:
    n = INDOOR_JO_COUNT if jump_off else INDOOR_COUNTS[cid]
    xr = clamp(3.8 + (serial % 12) * 0.12, 3.6, 5.25)
    xl = -xr
    z0 = -11.4 + (serial % 8) * 0.08
    n_home = 0 if (cid == "lesson" and not jump_off) else (1 if n <= 4 else (2 if n <= 6 else 3))
    n_up = n - n_home
    if n_up < 1:
        return None
    related_strides = 1 if n_up >= 2 else 0
    dist = D1 + rng.uniform(-0.10, 0.10) if related_strides else 0.0
    kinds = kinds_for(n, cid, rng)
    hs = heights_for(cid, n, serial, rng)
    sp = oxer_sp(cid, rng)
    fences: list[dict] = []
    z_top = INDOOR_Z_MAX - 1.4
    span = max(6.0, z_top - z0)
    zs = [z0 + span * i / max(1, n_up - 1) for i in range(n_up)]
    if related_strides and n_up >= 2:
        zs[1] = z0 + dist
        if n_up > 2:
            rest = z_top - zs[1]
            for i in range(2, n_up):
                zs[i] = zs[1] + rest * (i - 1) / (n_up - 2)
    for i in range(n_up):
        z = zs[i]
        if i == 1 and related_strides and fences:
            x, z = place_along(fences[0]["pos"][0], fences[0]["pos"][2], fences[0]["yaw"], dist)
            yaw = fences[0]["yaw"]
            fences[0]["related"] = related_to(2, related_strides, dist)
        else:
            x = xr if i % 2 == 0 else xl
            if i == 0:
                x = xr
                yaw = 0.0
            else:
                yaw = 0.04 if x < 0 else -0.04
        if abs(x) > INDOOR_X_MAX - 0.08 or abs(z) > INDOOR_Z_MAX - 0.08:
            return None
        if i != 1 or not related_strides:
            if not _ok_pos(x, z, yaw, fences, INDOOR_MIN_SEPARATION, INDOOR_TURN_MAG, True):
                x = -x
                if not _ok_pos(x, z, yaw, fences, INDOOR_MIN_SEPARATION, INDOOR_TURN_MAG, True):
                    return None
        kind = kinds[i]
        this_sp = sp if kind == "oxer" else 0.0
        fences.append(
            fence(i + 1, kind, hs[i], this_sp, x, z, yaw, kind_name(kind, fill_for(kind, rng)), None)
        )
    home = _place_home(n_home, xr, xl, fences, kinds, hs, sp, rng, True)
    if home is None:
        return None
    fences.extend(home)
    if len(fences) != n:
        return None
    for k, f in enumerate(fences, 1):
        f["num"] = k
        if f.get("related"):
            f["related"]["to"] = k + 1
    rec = {
        "id": f"hk_in_{'jo_' if jump_off else ''}{cid[:3]}_{serial:04d}",
        "class_id": cid,
        "ring": "indoor",
        "indoor": True,
        "session_kinds": ["lesson"] if cid == "lesson" and not jump_off else (["show"] if jump_off else ["schooling", "show"]),
        "name": "tmp",
        "height_label": HEIGHT_LABEL[cid],
        "pattern": "jump_off_tight" if jump_off else pattern,
        "start_pos": list(INDOOR_START_POS),
        "start_yaw": round(START_YAW, 5),
        "finish_z": INDOOR_FINISH if cid == "lesson" and not jump_off else -13.4,
        "notes": "Indoor. Smaller canter. Same leave.",
        "fences": fences,
    }
    if jump_off:
        rec["jump_off"] = True
        rec["finish_z"] = -13.4
    length = path_length_m(rec)
    rec["time_allowed_school"] = time_from_path(length, False, cid, jump_off)
    rec["time_allowed_show"] = time_from_path(length, True, cid, jump_off)
    errs = validate_course(rec)
    if errs:
        return None
    return rec


def try_construct(cid: str, serial: int, rng: random.Random, jump_off: bool, indoor: bool, pattern: str) -> dict | None:
    rec = construct_indoor(cid, serial, rng, jump_off, pattern) if indoor else construct_outdoor(cid, serial, rng, jump_off, pattern)
    if rec is None:
        return None
    errs = validate_course(rec)
    if errs:
        return None
    return rec
