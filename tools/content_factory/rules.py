"""Shared Hidden K ring geometry and course validation."""
from __future__ import annotations

import math
from typing import Any

PI = math.pi

# Outdoor ring, Godot, y=0 sand. Matches course.gd / farm.
RING_W = 30.48
RING_D = 76.20
SAND_X = 15.24
SAND_Z = 38.10
FENCE_X_MAX = 11.5
FENCE_Z_MAX = 32.0
START_FLAGS_Z = -32.0
START_CLEAR_M = 4.0
Z_MIN = START_FLAGS_Z + START_CLEAR_M  # -28.0
FENCE_WIDTH = 3.05
STANDARD_HALF = FENCE_WIDTH * 0.5
# Keep standards inside the fence box with a little kick-wall margin.
X_CENTER_MAX = 9.85

START_POS = [0.0, 0.0, -34.6]
START_YAW = PI
FINISH_HOME = -36.2

CANTER_STRIDE = 3.35
TAKEOFF = 2.55
PACE_MPM = 350.0  # jumper meters per minute

MIN_SEPARATION = 6.2
RELATED_TOL = 0.6

STRIDE_BANDS = {
    1: (7.0, 7.8),
    2: (10.4, 11.2),
    3: (14.0, 15.2),
}

HEIGHTS = {
    "lesson": (0.40, 0.64),
    "beginner": (0.58, 0.70),
    "intermediate": (0.72, 0.90),
    "advanced": (0.84, 0.96),
}

OXER_SPREAD = {
    "lesson": 0.0,
    "beginner": 0.50,
    "intermediate": 0.70,
    "advanced": 0.85,
}

COUNTS = {
    "lesson": 3,
    "beginner": 8,
    "intermediate": 10,
    "advanced": 12,
}

JO_COUNT = 4

INDOOR_X_MAX = 5.6
INDOOR_Z_MAX = 12.8
INDOOR_START_POS = [0.0, 0.0, -13.6]
INDOOR_FINISH = 13.2
INDOOR_COUNTS = {
    "lesson": 3,
    "beginner": 6,
    "intermediate": 8,
    "advanced": 8,
}
INDOOR_JO_COUNT = 3
# Indoor ring is ~16×32 m. 6.2 m outdoor sep does not fit eight fences
# unless they zigzag; related can sit tighter if the labeled band still holds.
INDOOR_MIN_SEPARATION = 4.8
INDOOR_TURN_MAG = 8.0
INDOOR_TURN_DEG = 100.0

HEIGHT_LABEL = {
    "lesson": 'poles to 2\'3"',
    "beginner": '2\'3"',
    "intermediate": '2\'6"',
    "advanced": '3\'0"',
}

CLASS_TIME_SCHOOL = {
    "lesson": 180.0,
    "beginner": 100.0,
    "intermediate": 90.0,
    "advanced": 80.0,
}
CLASS_TIME_SHOW = {
    "lesson": 180.0,
    "beginner": 95.0,
    "intermediate": 85.0,
    "advanced": 75.0,
}

KINDS = ("vertical", "oxer", "flower")

EXISTING_RAIL_KEYS = (
    "early",
    "spot",
    "deep",
    "chip",
    "looked",
    "wrong",
    "rail",
    "refuse",
    "off_course",
    "three",
    "time",
    "lesson_start",
    "jump_off",
    "clear",
    "ribbon",
    "steady",
    "walk_out",
    "halt",
    "pat",
    "straight",
    "leave",
)

NEW_RAIL_KEYS = (
    "half_halt",
    "crooked",
    "long_spot",
    "short_spot",
    "related_in",
    "related_out",
    "looky_flower",
    "oxer",
    "first_fence",
    "last_fence",
    "whoa",
    "walk_first",
    "sit",
    "eyes_up",
    "confidence_low",
    "he's_with_you",
    "don't_chase",
)

MEGA_RAIL_KEYS = (
    "indoor",
    "rain",
    "fresh",
    "quiet",
    "count_strides",
    "wait",
    "leave_with_him",
    "don't_drop_him",
    "pat_and_walk",
    "whoa_means_whoa",
    "find_the_clock",
    "inside_turn",
    "outside_turn",
    "don't_cut",
    "add_one",
    "leave_out",
    "hold_the_line",
)

# Raised after first green pass: +20 courses/class, +100 lines, +8 plates.
QUOTA_COURSES = {
    "lesson": 40,
    "beginner": 60,
    "intermediate": 60,
    "advanced": 50,
}
QUOTA_JO = {
    "beginner": 10,
    "intermediate": 10,
    "advanced": 10,
}
QUOTA_COURSES_TOTAL = 240
QUOTA_LINES = 500
QUOTA_PLATES = 48
QUOTA_PROC = 18
QUOTA_FENCES = 40
QUOTA_BARN_NOTES = 40
EXISTING_VARIANTS = 12
NEW_VARIANTS = 8
MAX_LINE_WORDS = 14

EXPAND_COURSES_PER_CLASS = 20
EXPAND_LINES = 100
EXPAND_PLATES = 8

PROC_NAMES = (
    "sand_worked_dry",
    "sand_worked_wet",
    "sand_rake",
    "grass_piedmont",
    "grass_dry_patch",
    "grass_late_rust",
    "pine_needles",
    "oak_bark",
    "board_white",
    "kick_dark",
    "rail_natural",
    "leather_bridle",
    "wool_navy_coat",
    "brush_box",
    "flower_soil",
    "gravel_drive",
    "hay_bale",
    "hoof_cut_sand",
    "sand_hoof",
    "sand_lip",
    "sand_wet_center",
    "grass_clover",
    "grass_shade",
    "grass_morning",
    "pine_duff_wet",
    "oak_rust",
    "wool_navy_weave",
    "leather_sweat",
    "board_chalk",
    "kick_scuff",
    "gravel_wet",
    "straw_gold",
    "hay_dust",
    "flower_bloom_soil",
    "brush_dry",
    "velvet_cap",
    "boot_black",
    "iron_polish",
    "pad_quilt",
    "pine_bark_wet",
    "fescue_late",
    "apron_dirt",
    "rail_white_scuff",
    "tack_trunk",
    "salt_block",
    "cooler_navy",
    "hydrant_metal",
    "stall_bar",
    "oak_fourboard",
    "clover_patch",
    "rake_deep",
    "hoof_wet",
    "duff_dry",
    "board_hunter",
    "kick_barn",
    "leather_reins",
    "wool_melton",
    "gravel_barn_yard",
    "sand_track",
    "grass_ring_edge",
    "pine_needle_shade",
    "oak_leaf_late",
    "flower_box_soil",
    "plank_gate",
    "natural_rail",
    "navy_pole",
)


def travel_dir(yaw: float) -> tuple[float, float]:
    """World XZ travel direction for a fence with Godot Y rotation `yaw`."""
    return (math.sin(yaw), math.cos(yaw))


def dist_xz(a: list[float], b: list[float]) -> float:
    return math.hypot(float(a[0]) - float(b[0]), float(a[2]) - float(b[2]))


def round_hash_part(course: dict[str, Any]) -> str:
    parts: list[str] = []
    for f in course["fences"]:
        x = round(float(f["pos"][0]), 1)
        z = round(float(f["pos"][2]), 1)
        h = round(float(f["h"]), 2)
        parts.append(f"{f['kind']}:{x:.1f}:{z:.1f}:{h:.2f}")
    return "|".join(parts)


def strides_for_distance(d: float) -> int | None:
    for n, (lo, hi) in STRIDE_BANDS.items():
        if lo - 0.05 <= d <= hi + 0.05:
            return n
    return None


def path_length_m(course: dict[str, Any]) -> float:
    start = course.get("start_pos") or START_POS
    finish_z = float(course.get("finish_z", FINISH_HOME))
    pts = [(float(start[0]), float(start[2]))]
    for f in course["fences"]:
        p = f["pos"]
        pts.append((float(p[0]), float(p[2])))
    pts.append((0.0, finish_z))
    d = 0.0
    for (x0, z0), (x1, z1) in zip(pts, pts[1:]):
        d += math.hypot(x1 - x0, z1 - z0)
    return d * 1.18  # bending room on the hunter track


def time_from_path(length_m: float, show: bool, class_id: str, jump_off: bool) -> float:
    raw = length_m / PACE_MPM * 60.0
    base_s = CLASS_TIME_SCHOOL[class_id]
    base_sh = CLASS_TIME_SHOW[class_id]
    base = base_sh if show else base_s
    # Blend computed time toward the live class clock so later wiring matches.
    t = 0.45 * raw + 0.55 * base
    lo = base * 0.82
    hi = base * 1.12
    t = max(lo, min(hi, t))
    if jump_off:
        t = max(28.0, t * 0.42)
    return round(t, 1)


def _as_pos(p: Any) -> list[float]:
    if isinstance(p, (list, tuple)) and len(p) >= 3:
        return [float(p[0]), float(p[1]), float(p[2])]
    raise ValueError("pos must be [x,y,z]")


def validate_course(course: dict[str, Any]) -> list[str]:
    """Return a list of error strings. Empty means OK."""
    errs: list[str] = []
    cid = str(course.get("class_id", ""))
    if cid not in COUNTS:
        errs.append(f"bad class_id {cid}")
        return errs
    indoor = str(course.get("ring", "outdoor")) == "indoor" or bool(course.get("indoor"))
    jump_off = bool(course.get("jump_off", False))
    if indoor:
        need = INDOOR_JO_COUNT if jump_off else INDOOR_COUNTS[cid]
        fx_max = INDOOR_X_MAX
        fz_max = INDOOR_Z_MAX
        x_center = INDOOR_X_MAX
        check_start_flags = False
    else:
        need = JO_COUNT if jump_off else COUNTS[cid]
        fx_max = FENCE_X_MAX
        fz_max = FENCE_Z_MAX
        x_center = X_CENTER_MAX
        check_start_flags = True
    fences = course.get("fences")
    if not isinstance(fences, list):
        errs.append("fences missing")
        return errs
    if len(fences) != need:
        errs.append(f"count {len(fences)} != {need}")
    hlo, hhi = HEIGHTS[cid]
    sp_max = OXER_SPREAD[cid]
    nums: set[int] = set()
    for i, f in enumerate(fences):
        if not isinstance(f, dict):
            errs.append(f"fence {i} not object")
            continue
        num = int(f.get("num", i + 1))
        if num in nums:
            errs.append(f"duplicate num {num}")
        nums.add(num)
        kind = str(f.get("kind", ""))
        if kind not in KINDS:
            errs.append(f"#{num} bad kind {kind}")
        try:
            h = float(f["h"])
            sp = float(f.get("sp", 0.0))
            pos = _as_pos(f["pos"])
            yaw = float(f["yaw"])
        except (KeyError, TypeError, ValueError) as e:
            errs.append(f"#{num} field error {e}")
            continue
        if not (hlo - 1e-6 <= h <= hhi + 1e-6):
            errs.append(f"#{num} height {h} outside {hlo}-{hhi}")
        if kind == "oxer":
            if sp < 0.15:
                errs.append(f"#{num} oxer spread {sp} too small")
            if sp > sp_max + 1e-6:
                errs.append(f"#{num} oxer spread {sp} > {sp_max}")
        else:
            if abs(sp) > 1e-6:
                errs.append(f"#{num} {kind} spread must be 0")
        if abs(pos[1]) > 0.05:
            errs.append(f"#{num} y {pos[1]} not sand")
        if abs(pos[0]) > fx_max + 1e-6:
            errs.append(f"#{num} |x| {pos[0]} > {fx_max}")
        if abs(pos[2]) > fz_max + 1e-6:
            errs.append(f"#{num} |z| {pos[2]} > {fz_max}")
        if abs(pos[0]) > x_center + 0.2:
            errs.append(f"#{num} standards tight to kick wall x={pos[0]}")
        if check_start_flags and abs(pos[2] - START_FLAGS_Z) < START_CLEAR_M - 1e-6:
            errs.append(f"#{num} inside {START_CLEAR_M}m of start flags")
        if "name" not in f or not str(f["name"]).strip():
            errs.append(f"#{num} missing name")

    # Pairwise spacing + related labels.
    n = len(fences)
    related_pairs: set[tuple[int, int]] = set()
    for i, f in enumerate(fences):
        rel = f.get("related")
        if rel is None:
            continue
        if not isinstance(rel, dict):
            errs.append(f"#{f.get('num')} related not object")
            continue
        to = int(rel.get("to", 0))
        strides = int(rel.get("strides", 0))
        dist_m = float(rel.get("distance_m", 0.0))
        if to < 1 or to > n:
            errs.append(f"#{f.get('num')} related.to {to} out of range")
            continue
        if strides not in STRIDE_BANDS:
            errs.append(f"#{f.get('num')} strides {strides} not 1/2/3")
            continue
        target = None
        for g in fences:
            if int(g.get("num", 0)) == to:
                target = g
                break
        if target is None:
            errs.append(f"#{f.get('num')} related target missing")
            continue
        actual = dist_xz(f["pos"], target["pos"])
        if abs(actual - dist_m) > RELATED_TOL:
            errs.append(
                f"#{f.get('num')} related distance_m {dist_m} != actual {actual:.2f}"
            )
        lo, hi = STRIDE_BANDS[strides]
        if not (lo - RELATED_TOL <= actual <= hi + RELATED_TOL):
            errs.append(
                f"#{f.get('num')} strides {strides} actual {actual:.2f} not in {lo}-{hi}"
            )
        a, b = sorted((int(f["num"]), to))
        related_pairs.add((a, b))
        # Related line should share approach (yaw close, roughly colinear).
        dyaw = abs(float(f["yaw"]) - float(target["yaw"]))
        dyaw = min(dyaw, abs(dyaw - 2 * PI), abs(dyaw - 4 * PI))
        if dyaw > 0.35:
            errs.append(f"#{f.get('num')}-#{to} related yaw mismatch {dyaw:.2f}")

    min_sep = INDOOR_MIN_SEPARATION if indoor else MIN_SEPARATION
    turn_mag = INDOOR_TURN_MAG if indoor else 12.0
    turn_deg = INDOOR_TURN_DEG if indoor else 85.0
    for i in range(n):
        for j in range(i + 1, n):
            a = fences[i]
            b = fences[j]
            d = dist_xz(a["pos"], b["pos"])
            pair = tuple(sorted((int(a["num"]), int(b["num"]))))
            if d < min_sep - 1e-6 and pair not in related_pairs:
                errs.append(
                    f"#{a['num']}-#{b['num']} {d:.2f}m < {min_sep} and not related"
                )

    # Approach: next fence should be jumpable from a canter, not a 90° one-stride.
    for i in range(n - 1):
        a = fences[i]
        b = fences[i + 1]
        pair = tuple(sorted((int(a["num"]), int(b["num"]))))
        dx = float(b["pos"][0]) - float(a["pos"][0])
        dz = float(b["pos"][2]) - float(a["pos"][2])
        mag = math.hypot(dx, dz)
        if mag < 0.2:
            errs.append(f"#{a['num']}-#{b['num']} stacked")
            continue
        tx, tz = travel_dir(float(b["yaw"]))
        dot = (dx * tx + dz * tz) / mag
        if dot < 0.20:
            errs.append(
                f"#{a['num']}-#{b['num']} approach from behind/side (dot {dot:.2f})"
            )
        # Tight turn into a related-length gap is illegal unless labeled related.
        leave_x, leave_z = travel_dir(float(a["yaw"]))
        # Heading from leave of A toward B vs leave direction.
        leave_dot = (dx * leave_x + dz * leave_z) / mag
        turn = math.acos(max(-1.0, min(1.0, leave_dot)))
        if mag < turn_mag and turn > math.radians(turn_deg) and pair not in related_pairs:
            errs.append(
                f"#{a['num']}-#{b['num']} {math.degrees(turn):.0f}° turn in {mag:.1f}m"
            )

    required = (
        "id",
        "class_id",
        "session_kinds",
        "name",
        "height_label",
        "time_allowed_school",
        "time_allowed_show",
        "start_pos",
        "start_yaw",
        "finish_z",
        "notes",
        "fences",
    )
    for k in required:
        if k not in course:
            errs.append(f"missing {k}")
    sk = course.get("session_kinds")
    if not isinstance(sk, list) or not sk:
        errs.append("session_kinds empty")
    return errs
