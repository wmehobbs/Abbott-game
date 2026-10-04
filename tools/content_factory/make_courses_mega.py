"""Scale the Hidden K course library. Keeps existing tracks. Adds walks, briefs, indoor."""
from __future__ import annotations

import json
import math
import random
import sys
from pathlib import Path

from construct_courses import PATTERNS as CONSTRUCT_PATTERNS, try_construct
from make_courses import (
    D1,
    D2,
    D3,
    fence,
    kind_name,
    pack,
    place_along,
    related_to,
    try_build,
)
from rules import strides_for_distance, dist_xz
from rules import (
    COUNTS,
    HEIGHT_LABEL,
    HEIGHTS,
    INDOOR_COUNTS,
    INDOOR_FINISH,
    INDOOR_JO_COUNT,
    INDOOR_START_POS,
    INDOOR_X_MAX,
    INDOOR_Z_MAX,
    JO_COUNT,
    OXER_SPREAD,
    PI,
    START_POS,
    START_YAW,
    path_length_m,
    round_hash_part,
    time_from_path,
    validate_course,
)

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "content" / "courses"
INDEX = OUT / "INDEX.json"

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

DAYS = [
    "Tuesday", "Wednesday", "Thursday", "first school", "the other way",
    "quiet", "late", "after work", "morning", "before the show",
]
SIDES = ["right", "left", "outside", "inside"]


def n_words(s: str) -> int:
    return len(s.replace("—", " ").split())


def num_words(n: int) -> str:
    ones = ["zero","one","two","three","four","five","six","seven","eight","nine",
            "ten","eleven","twelve","thirteen","fourteen","fifteen","sixteen",
            "seventeen","eighteen","nineteen"]
    tens = ["","","twenty","thirty","forty","fifty","sixty","seventy","eighty","ninety"]
    n = int(n)
    if n < 0:
        return "minus " + num_words(-n)
    if n < 20:
        return ones[n]
    if n < 100:
        a, b = divmod(n, 10)
        return tens[a] if b == 0 else f"{tens[a]}-{ones[b]}"
    if n < 1000:
        a, b = divmod(n, 100)
        return f"{ones[a]} hundred" if b == 0 else f"{ones[a]} hundred {num_words(b)}"
    if n < 1000000:
        a, b = divmod(n, 1000)
        return f"{num_words(a)} thousand" if b == 0 else f"{num_words(a)} thousand {num_words(b)}"
    return str(n)


def coord_words(v: float) -> str:
    sign = "minus " if v < 0 else ""
    a = abs(v)
    whole = int(a)
    tenths = int(round((a - whole) * 10))
    if tenths == 10:
        whole += 1
        tenths = 0
    if tenths == 0:
        return sign + num_words(whole)
    return f"{sign}{num_words(whole)} point {num_words(tenths)}"


def walk_text(rec: dict, serial: int, rng: random.Random) -> str:
    cid = rec.get("class_id", "beginner")
    pattern = rec.get("pattern", "outside_track").replace("_", " ")
    related = "a labeled related" if any(f.get("related") for f in rec["fences"]) else "singles, no related"
    side = rng.choice(SIDES)
    day = rng.choice(DAYS)
    hlab = rec.get("height_label", "")
    n = len(rec["fences"])
    first = rec["fences"][0]
    last = rec["fences"][-1]
    indoor = rec.get("ring") == "indoor"
    place = "the indoor" if indoor else "the outdoor ring"
    jo = " Jump-off: don't chase." if rec.get("jump_off") else ""
    x1, z1 = float(first["pos"][0]), float(first["pos"][2])
    xn, zn = float(last["pos"][0]), float(last["pos"][2])
    sw = num_words(serial)
    text = (
        f"Hidden K walk {sw} in {place} on {day} for {cid}. "
        f"Height {hlab}, {n} fences, pattern {pattern}, side {side}. "
        f"Fence one of walk {sw} is a {first.get('name','white vertical')} at {coord_words(x1)} by {coord_words(z1)}. "
        f"Walk {sw} meat is {related}. Sit after the in of walk {sw}. "
        f"Last of walk {sw} is a {last.get('name','vertical')} at {coord_words(xn)} by {coord_words(zn)}. "
        f"Same leave on walk {sw}. Then walk him out.{jo} "
        f"If he looks on walk {sw}, straighten. Come again. That's walk {sw}."
    )
    while n_words(text) < 42:
        text += f" Abbott canters walk {sw} if you wait."
    w = text.split()
    if len(w) > 90:
        text = " ".join(w[:86]) + f" That's walk {sw}."
    return text


def brief_text(rec: dict, serial: int, rng: random.Random) -> str:
    opts = [
        f"Walk {num_words(serial)}. Wait for the last stride.",
        f"Number {num_words(serial)}. Quiet to the first.",
        f"This one is {rec.get('pattern','outside').replace('_',' ')}. Don't chase.",
        f"Related in the middle. Sit. Then the out.",
        f"Outside track. Find the canter before the flags.",
        f"Same leave as Tuesday. Don't make it bigger.",
        f"First fence quiet. I'm watching the distance.",
        f"Don't cut. Hold the line and wait.",
        f"Indoor. Smaller canter. Same leave.",
        f"Jump-off. Four. Don't throw the first away.",
        f"Come home straight. Don't drop him.",
        f"Count. Don't invent a stride.",
    ]
    if rec.get("ring") == "indoor":
        opts = [o for o in opts if "Jump-off. Four" not in o] + ["Indoor. Sit. Same leave."]
    if rec.get("jump_off"):
        opts = [f"Jump-off {num_words(serial)}. Don't chase him.", "Four fences. Wait. Then the turn."]
    t = rng.choice(opts)
    if n_words(t) > 14:
        t = "Wait for the last stride."
    return t


def unique_name(rec: dict, serial: int, rng: random.Random, used: set[str]) -> str:
    pattern = rec.get("pattern", "outside").replace("_", " ")
    cid = rec.get("class_id", "")
    indoor = "indoor " if rec.get("ring") == "indoor" else ""
    jo = "jump-off " if rec.get("jump_off") else ""
    day = rng.choice(DAYS)
    side = rng.choice(SIDES)
    for _ in range(20):
        name = f"{indoor}{jo}{pattern}, {side}, {day} {serial}".strip()
        if name not in used:
            used.add(name)
            return name
        serial += 1
    name = f"{cid} track {serial}"
    used.add(name)
    return name


def load_existing() -> tuple[list[dict], set[str], set[str]]:
    recs = []
    hashes: set[str] = set()
    names: set[str] = set()
    if not OUT.exists():
        return recs, hashes, names
    for p in OUT.rglob("*.json"):
        if p.name in ("INDEX.json", "SHIP.json"):
            continue
        rec = json.loads(p.read_text(encoding="utf-8"))
        rec["_path"] = p
        recs.append(rec)
        hashes.add(round_hash_part(rec))
        names.add(str(rec.get("name", "")))
    return recs, hashes, names


def retrofit_related(rec: dict) -> bool:
    changed = False
    fences = rec.get("fences") or []
    if rec.get("jump_off") or rec.get("class_id") == "lesson":
        return False
    if rec.get("ring") == "indoor":
        return False
    for i, f in enumerate(fences[:-1]):
        if f.get("related"):
            continue
        g = fences[i + 1]
        d = dist_xz(f["pos"], g["pos"])
        st = strides_for_distance(d)
        if not st:
            continue
        dyaw = abs(float(f.get("yaw", 0)) - float(g.get("yaw", 0)))
        dyaw = min(dyaw, abs(dyaw - 2 * PI), abs(dyaw - 4 * PI))
        if dyaw > 0.30:
            continue
        f["related"] = related_to(int(g.get("num", i + 2)), st, d)
        changed = True
        break
    return changed


def enrich_existing(recs: list[dict], names: set[str]) -> int:
    n = 0
    used_walks: set[str] = set()
    for i, rec in enumerate(recs, 1):
        changed = False
        if not rec.get("pattern"):
            if rec.get("jump_off"):
                rec["pattern"] = "jump_off_tight"
            elif rec.get("class_id") == "lesson":
                rec["pattern"] = "lesson_single_then_line"
            else:
                rec["pattern"] = "outside_track"
            changed = True
        if not rec.get("ring"):
            rec["ring"] = "indoor" if "indoor" in str(rec.get("_path", "")).replace("\\", "/") else "outdoor"
            changed = True
        if retrofit_related(rec):
            changed = True
        wt = str(rec.get("walk_text", ""))
        if not wt or n_words(wt) < 40 or n_words(wt) > 90 or wt in used_walks:
            rec["walk_text"] = walk_text(rec, i, random.Random(i * 17 + 3))
            changed = True
        used_walks.add(str(rec.get("walk_text", "")))
        if not rec.get("michelle_brief"):
            rec["michelle_brief"] = brief_text(rec, i, random.Random(i * 19 + 5))
            changed = True
        if changed:
            path: Path = rec["_path"]
            dump = {k: v for k, v in rec.items() if not k.startswith("_")}
            path.write_text(json.dumps(dump, indent=2) + "\n", encoding="utf-8")
            n += 1
    return n


def indoor_build(cid: str, rng: random.Random, jump_off: bool) -> list[dict] | None:
    n = INDOOR_JO_COUNT if jump_off else INDOOR_COUNTS[cid]
    lo, hi = HEIGHTS[cid]
    xr = rng.uniform(2.6, 5.1)
    xl = -xr
    hs = [round(min(hi, max(lo, lo + (hi - lo) * i / max(1, n - 1) + rng.uniform(-0.02, 0.02))), 3) for i in range(n)]
    sp = 0.0 if cid == "lesson" else round(min(OXER_SPREAD[cid] * 0.85, max(0.28, OXER_SPREAD[cid] * 0.6)), 3)
    drel = D1 if n <= 6 else D2
    if drel > 11.5:
        drel = D1
    z0 = rng.uniform(-11.8, -8.5)
    yaw = 0.0
    fences: list[dict] = []

    def add(kind, h, x, z, yaw, name, rel=None, spv=0.0):
        if abs(x) > INDOOR_X_MAX - 0.05 or abs(z) > INDOOR_Z_MAX - 0.05:
            return False
        fences.append(fence(len(fences) + 1, kind, h, spv, x, z, yaw, name, rel))
        return True

    # related 1-2 on the right going up
    if not add("vertical", hs[0], xr, z0, yaw, "white vertical", related_to(2, 1 if drel < 9 else 2, drel)):
        return None
    ox, oz = place_along(xr, z0, yaw, drel)
    k2 = "vertical" if cid == "lesson" else rng.choice(["vertical", "oxer"])
    if not add(k2, hs[1] if n > 1 else hs[0], ox, oz, yaw, kind_name(k2, "plank"), None, sp if k2 == "oxer" else 0.0):
        return None
    z = oz
    i = 2
    while i < n:
        is_home = i >= n - (1 if jump_off or n <= 3 else 2)
        if is_home:
            hx = xl if i % 2 == 0 else xr * 0.9
            hyaw = PI + rng.uniform(-0.08, 0.08)
            hz = rng.uniform(-10.0, 4.0) if i == n - 1 else rng.uniform(2.0, 10.0)
            kind = "vertical" if rng.random() < 0.7 else ("flower" if cid != "lesson" else "vertical")
            if not add(kind, hs[min(i, n - 1)], hx, hz, hyaw, kind_name(kind, "white"), None, 0.0):
                return None
        else:
            hx = xl if i % 2 else xr
            hyaw = 0.04 if hx < 0 else -0.04
            hz = min(INDOOR_Z_MAX - 0.4, z + rng.uniform(6.4, 8.8))
            kind = "flower" if (i == 3 and cid != "lesson") else ("oxer" if i == 4 and cid != "lesson" else "vertical")
            if kind == "oxer" and cid == "lesson":
                kind = "vertical"
            if not add(kind, hs[min(i, n - 1)], hx, hz, hyaw, kind_name(kind, "brush" if kind == "flower" else "white"), None, sp if kind == "oxer" else 0.0):
                return None
            z = hz
        i += 1
    if len(fences) != n:
        return None
    for k, f in enumerate(fences, 1):
        f["num"] = k
        if f.get("related"):
            f["related"]["to"] = k + 1
    return fences


def pack_indoor(cid, ident, name, notes, fences, jump_off, pattern, serial, rng):
    rec = {
        "id": ident,
        "class_id": cid,
        "ring": "indoor",
        "indoor": True,
        "session_kinds": ["lesson"] if cid == "lesson" and not jump_off else (["show"] if jump_off else ["schooling", "show"]),
        "name": name,
        "height_label": HEIGHT_LABEL[cid],
        "pattern": pattern,
        "start_pos": list(INDOOR_START_POS),
        "start_yaw": round(START_YAW, 5),
        "finish_z": INDOOR_FINISH if cid == "lesson" and not jump_off else -13.4,
        "notes": notes,
        "fences": fences,
    }
    if jump_off:
        rec["jump_off"] = True
        rec["finish_z"] = -13.4
    length = path_length_m(rec)
    rec["time_allowed_school"] = time_from_path(length, False, cid, jump_off)
    rec["time_allowed_show"] = time_from_path(length, True, cid, jump_off)
    rec["walk_text"] = walk_text(rec, serial, rng)
    rec["michelle_brief"] = brief_text(rec, serial, rng)
    return rec


def write_any(rec: dict) -> Path:
    cid = rec["class_id"]
    if rec.get("ring") == "indoor":
        folder = OUT / "indoor" / cid
        if rec.get("jump_off"):
            folder = OUT / "indoor" / "jump_off" / cid
    elif rec.get("jump_off"):
        folder = OUT / "jump_off" / cid
    else:
        folder = OUT / cid
    folder.mkdir(parents=True, exist_ok=True)
    path = folder / f"{rec['id']}.json"
    dump = {k: v for k, v in rec.items() if not k.startswith("_")}
    path.write_text(json.dumps(dump, indent=2) + "\n", encoding="utf-8")
    return path


def rebuild_index() -> int:
    rows = []
    for p in sorted(OUT.rglob("*.json")):
        if p.name in ("INDEX.json", "SHIP.json"):
            continue
        rec = json.loads(p.read_text(encoding="utf-8"))
        rows.append({
            "id": rec["id"],
            "class": rec.get("class_id"),
            "jump_off": bool(rec.get("jump_off")),
            "indoor": rec.get("ring") == "indoor",
            "name": rec.get("name"),
            "path": p.relative_to(ROOT).as_posix(),
            "time_allowed_school": rec.get("time_allowed_school"),
            "time_allowed_show": rec.get("time_allowed_show"),
            "fence_count": len(rec.get("fences") or []),
            "pattern": rec.get("pattern"),
        })
    INDEX.write_text(json.dumps(rows, indent=2) + "\n", encoding="utf-8")
    return len(rows)


def gen_outdoor(cid: str, target: int, jo: bool, hashes: set[str], names: set[str], start_serial: int) -> int:
    got = 0
    attempts = 0
    serial = start_serial
    max_a = max(target * 40, 200)
    patterns = [p for p in PATTERNS if not p.startswith("lesson") or cid == "lesson"]
    if jo:
        patterns = ["jump_off_tight"]
    while got < target and attempts < max_a:
        attempts += 1
        serial += 1
        rng = random.Random(serial * 997 + attempts * 13 + (hash(cid) % 1009))
        pattern = patterns[serial % len(patterns)]
        rec = try_construct(cid, serial, rng, jo, False, pattern)
        if rec is None:
            rec = try_build(cid, serial, rng, jo)
            if rec is None:
                continue
            rec["ring"] = "outdoor"
            rec["pattern"] = pattern
        h = round_hash_part(rec)
        if h in hashes:
            continue
        rec["name"] = unique_name(rec, serial, rng, names)
        rec["walk_text"] = walk_text(rec, serial, rng)
        rec["michelle_brief"] = brief_text(rec, serial, rng)
        if jo:
            rec["id"] = f"hk_jo_{cid[:3]}_{serial:04d}"
        else:
            rec["id"] = f"hk_{cid[:3]}_{serial:04d}"
        rec["ring"] = "outdoor"
        errs = validate_course(rec)
        if errs:
            continue
        if not jo and cid != "lesson":
            if not any(f.get("related") for f in rec["fences"]):
                continue
        hashes.add(h)
        write_any(rec)
        got += 1
        if got % 100 == 0:
            print(f"  {cid} jo={jo} {got}/{target}", flush=True)
    print(f"  {cid} jo={jo} done {got}/{target} attempts={attempts}", flush=True)
    return got


def gen_indoor(cid: str, target: int, jo: bool, hashes: set[str], names: set[str], start_serial: int) -> int:
    got = 0
    attempts = 0
    serial = start_serial
    patterns = ["related_out", "outside_track", "inside_track", "lesson_single_then_line", "jump_off_tight"]
    while got < target and attempts < max(target * 80, 400):
        attempts += 1
        serial += 1
        rng = random.Random(serial * 131 + attempts)
        pattern = "jump_off_tight" if jo else patterns[serial % len(patterns)]
        rec = try_construct(cid, serial, rng, jo, True, pattern)
        if rec is None:
            continue
        rec["name"] = unique_name(rec, serial, rng, names)
        rec["walk_text"] = walk_text(rec, serial, rng)
        rec["michelle_brief"] = brief_text(rec, serial, rng)
        h = round_hash_part(rec)
        if h in hashes:
            continue
        hashes.add(h)
        write_any(rec)
        got += 1
        if got % 80 == 0:
            print(f"  indoor {cid} jo={jo} {got}/{target}", flush=True)
    print(f"  indoor {cid} jo={jo} done {got}/{target} attempts={attempts}", flush=True)
    return got


def count_now() -> dict:
    c = {
        "lesson": 0, "beginner": 0, "intermediate": 0, "advanced": 0,
        "jo_beg": 0, "jo_int": 0, "jo_adv": 0,
        "in_les": 0, "in_beg": 0, "in_int": 0, "in_adv": 0,
        "in_jo_beg": 0, "in_jo_int": 0, "in_jo_adv": 0,
        "outdoor_full": 0,
    }
    for p in OUT.rglob("*.json"):
        if p.name in ("INDEX.json", "SHIP.json"):
            continue
        rec = json.loads(p.read_text(encoding="utf-8"))
        indoor = rec.get("ring") == "indoor"
        jo = bool(rec.get("jump_off"))
        cid = rec.get("class_id")
        if indoor and jo:
            c[{"beginner": "in_jo_beg", "intermediate": "in_jo_int", "advanced": "in_jo_adv"}.get(cid, "in_jo_beg")] += 1
        elif indoor:
            c[{"lesson": "in_les", "beginner": "in_beg", "intermediate": "in_int", "advanced": "in_adv"}[cid]] += 1
        elif jo:
            c[{"beginner": "jo_beg", "intermediate": "jo_int", "advanced": "jo_adv"}[cid]] += 1
        else:
            c[cid] += 1
            c["outdoor_full"] += 1
    return c


def load_wants() -> tuple[dict, dict, dict, dict]:
    qpath = Path(__file__).resolve().parent / "MEGA_QUOTAS.json"
    extra = 1.18  # generate spare so scoring can drop the bottom 15%
    if qpath.exists():
        q = json.loads(qpath.read_text(encoding="utf-8"))
        want_out = {
            "lesson": int(q.get("outdoor_lesson", 300) * extra),
            "beginner": int(q.get("outdoor_beginner", 600) * extra),
            "intermediate": int(q.get("outdoor_intermediate", 600) * extra),
            "advanced": int(q.get("outdoor_advanced", 500) * extra),
        }
        jo_n = int(q.get("jump_off_per_class", 100) * extra)
        want_jo = {"beginner": jo_n, "intermediate": jo_n, "advanced": jo_n}
        want_in = {
            "lesson": int(q.get("indoor_lesson", 80) * extra),
            "beginner": int(q.get("indoor_beginner", 120) * extra),
            "intermediate": int(q.get("indoor_intermediate", 120) * extra),
            "advanced": int(q.get("indoor_advanced", 80) * extra),
        }
    else:
        want_out = {"lesson": 354, "beginner": 708, "intermediate": 708, "advanced": 590}
        want_jo = {"beginner": 118, "intermediate": 118, "advanced": 118}
        want_in = {"lesson": 94, "beginner": 142, "intermediate": 142, "advanced": 94}
    want_in_jo = {"beginner": 24, "intermediate": 24, "advanced": 24}
    return want_out, want_jo, want_in, want_in_jo


def main() -> int:
    recs, hashes, names = load_existing()
    print("existing", len(recs), "hashes", len(hashes), flush=True)
    n_en = enrich_existing(recs, names)
    print("enriched", n_en, flush=True)

    want_out, want_jo, want_in, want_in_jo = load_wants()
    print("wants", want_out, want_jo, want_in, flush=True)

    cur = count_now()
    print("counts", cur)

    serial = 0
    for p in OUT.rglob("*.json"):
        if p.name in ("INDEX.json", "SHIP.json"):
            continue
        try:
            serial = max(serial, int(p.stem.split("_")[-1]))
        except ValueError:
            pass
    serial = max(serial, 2000) + 10
    print("start_serial", serial, flush=True)
    for cid, want in want_out.items():
        have = cur.get(cid, 0)
        need = max(0, want - have)
        if need:
            print(f"outdoor {cid} need {need}")
            gen_outdoor(cid, need, False, hashes, names, serial)
            serial += need + 500

    cur = count_now()
    for cid, want in want_jo.items():
        key = {"beginner": "jo_beg", "intermediate": "jo_int", "advanced": "jo_adv"}[cid]
        need = max(0, want - cur.get(key, 0))
        if need:
            print(f"jo {cid} need {need}")
            gen_outdoor(cid, need, True, hashes, names, serial)
            serial += need + 200

    cur = count_now()
    for cid, want in want_in.items():
        key = {"lesson": "in_les", "beginner": "in_beg", "intermediate": "in_int", "advanced": "in_adv"}[cid]
        need = max(0, want - cur.get(key, 0))
        if need:
            print(f"indoor {cid} need {need}")
            gen_indoor(cid, need, False, hashes, names, serial)
            serial += need + 200

    cur = count_now()
    for cid, want in want_in_jo.items():
        key = {"beginner": "in_jo_beg", "intermediate": "in_jo_int", "advanced": "in_jo_adv"}[cid]
        need = max(0, want - cur.get(key, 0))
        if need:
            print(f"indoor jo {cid} need {need}")
            gen_indoor(cid, need, True, hashes, names, serial)
            serial += need + 50

    nidx = rebuild_index()
    print("index", nidx)
    print("final", count_now())
    return 0


if __name__ == "__main__":
    sys.exit(main())
