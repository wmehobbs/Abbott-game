"""Pick a trainer-board SHIP. Does not scan the 25k pile. Does not mint courses."""
from __future__ import annotations

import json
import math
import shutil
from pathlib import Path

from rules import COUNTS, JO_COUNT, PI, path_length_m, validate_course

ROOT = Path(__file__).resolve().parents[2]
COURSES = ROOT / "content" / "courses"
GAME = ROOT / "game" / "content" / "courses"
SHIP_SRC = COURSES / "SHIP.json"
SCORES = COURSES / "SCORES.jsonl"
REPORT = Path(__file__).resolve().parent / "SHIP_REAL.md"

LIVE_BEG = [
    (7.0, -20.0, "vertical"),
    (-7.2, -10.0, "vertical"),
    (7.5, 2.0, "flower"),
    (-6.5, 12.0, "oxer"),
    (6.8, 22.0, "vertical"),
    (0.0, 28.0, "oxer"),
    (-7.0, 8.0, "vertical"),
    (5.5, -8.0, "vertical"),
]

NEED = {
    "lesson": 4,
    "beginner": 6,
    "intermediate": 6,
    "advanced": 4,
}

BARN_NAMES = {
    "lesson": [
        "Tuesday poles",
        "Single then the line",
        "Right-hand two-stride",
        "Center line",
    ],
    "beginner": [
        "Welcome Stake, outside",
        "Left-hand related",
        "Flower off the right",
        "Diagonal and home",
        "Quiet eight",
        "Crossrails, the other lead",
    ],
    "intermediate": [
        "Classic, outside",
        "Related and a rollback",
        "One-stride in the middle",
        "Diagonal Classic",
        "Inside rollback",
        "Schooling Jumpers, home",
    ],
    "advanced": [
        "Mini Prix, related first",
        "Three-stride down the right",
        "Rollback Mini Prix",
        "Open Jumpers, long day",
    ],
    "jo_beginner": ["Jump-off, four"],
    "jo_intermediate": ["Jump-off, Classic"],
    "jo_advanced": ["Jump-off, Mini Prix"],
}


def guess_path(cid: str) -> Path | None:
    for folder in (
        "lesson", "beginner", "intermediate", "advanced",
        "jump_off/beginner", "jump_off/intermediate", "jump_off/advanced",
        "indoor/lesson", "indoor/beginner", "indoor/intermediate", "indoor/advanced",
    ):
        p = COURSES / folder / f"{cid}.json"
        if p.exists():
            return p
    return None


def load_rec(cid: str) -> dict | None:
    p = guess_path(cid)
    if p is None:
        return None
    rec = json.loads(p.read_text(encoding="utf-8"))
    rec["_path"] = p
    return rec


def has_related(rec: dict) -> bool:
    return any(f.get("related") for f in rec.get("fences") or [])


def consec_flowers(rec: dict) -> int:
    n = 0
    prev = ""
    for f in rec.get("fences") or []:
        k = f.get("kind")
        if k == "flower" and prev == "flower":
            n += 1
        prev = k
    return n


def first_vertical(rec: dict) -> bool:
    fs = rec.get("fences") or []
    return bool(fs) and fs[0].get("kind") == "vertical"


def cousin_score(rec: dict) -> float:
    fs = rec.get("fences") or []
    if len(fs) != 8:
        return -99.0
    s = 0.0
    for i, live in enumerate(LIVE_BEG):
        f = fs[i]
        x, z = float(f["pos"][0]), float(f["pos"][2])
        s -= math.hypot(x - live[0], z - live[1]) * 0.08
        if f.get("kind") == live[2]:
            s += 1.2
        if (x >= 0) == (live[0] >= 0):
            s += 0.6
    return s


def dump_name(name: str) -> bool:
    n = name.lower()
    if any(ch.isdigit() for ch in name) and ("outside track" in n or "lesson single" in n or "jump-off jump" in n):
        return True
    if "the other way" in n and n.startswith("outside"):
        return True
    return False


def layout_sig(rec: dict) -> str:
    fs = rec.get("fences") or []
    kinds = "".join(str(f.get("kind", "?"))[0] for f in fs)
    sides = "".join("R" if float(f["pos"][0]) >= 0 else "L" for f in fs)
    rel = "r" if has_related(rec) else "s"
    return f"{kinds}:{sides}:{rel}"


def why(rec: dict) -> str:
    bits = []
    if first_vertical(rec):
        bits.append("quiet first vertical")
    if has_related(rec):
        bits.append("labeled related")
    if consec_flowers(rec) == 0:
        bits.append("no stacked flowers")
    if rec.get("class_id") == "beginner" and not rec.get("jump_off"):
        cs = cousin_score(rec)
        if cs > 4:
            bits.append("cousin of the live eight")
    pat = str(rec.get("pattern", "")).replace("_", " ")
    if pat:
        bits.append(pat)
    notes = str(rec.get("notes", "")).strip()
    if notes and "Don't chase" not in notes:
        bits.append(notes.split(".")[0])
    return "; ".join(bits) if bits else ""


def quality(rec: dict) -> float:
    cid = rec.get("class_id", "")
    jo = bool(rec.get("jump_off"))
    indoor = rec.get("ring") == "indoor"
    if indoor:
        return -999.0
    need = JO_COUNT if jo else COUNTS.get(cid, 0)
    fs = rec.get("fences") or []
    if len(fs) != need:
        return -999.0
    if validate_course(rec):
        return -500.0
    pts = 0.0
    if first_vertical(rec):
        pts += 12
    else:
        pts -= 20
    if not jo and cid != "lesson":
        pts += 14 if has_related(rec) else -18
    elif cid == "lesson" and has_related(rec):
        pts += 8
    if consec_flowers(rec):
        pts -= 25
    else:
        pts += 4
    if dump_name(str(rec.get("name", ""))):
        pts -= 6
    length = path_length_m(rec)
    t = float(rec.get("time_allowed_school") or 90.0)
    expected = length / 350.0 * 60.0
    if t > 20 and abs(t - expected) / max(t, 1) < 0.7:
        pts += 3
    if cid == "beginner" and not jo:
        pts += max(-4.0, min(10.0, cousin_score(rec)))
    # prefer original Phase 1 ids (three-digit)
    ident = str(rec.get("id", ""))
    try:
        n = int(ident.split("_")[-1])
        if n <= 70:
            pts += 8
        elif n <= 18 and jo:
            pts += 8
    except ValueError:
        pass
    return pts


def collect_ids() -> list[str]:
    ids: list[str] = []
    seen: set[str] = set()

    def add(i: str) -> None:
        if i and i not in seen:
            seen.add(i)
            ids.append(i)

    # Original Phase 1 ids first — those are the tracks a barn would recognize.
    for prefix, n in (("hk_les_", 20), ("hk_beg_", 40), ("hk_int_", 40), ("hk_adv_", 30)):
        for k in range(1, n + 1):
            add(f"{prefix}{k:03d}")
    for cls in ("beg", "int", "adv"):
        for k in range(1, 19):
            add(f"hk_jo_{cls}_{k:03d}")
    if SHIP_SRC.exists():
        ship = json.loads(SHIP_SRC.read_text(encoding="utf-8"))
        for v in ship.values():
            if isinstance(v, list):
                for i in v[:12]:
                    add(str(i))
            elif isinstance(v, dict):
                for item in v.values():
                    if isinstance(item, list):
                        for i in item[:4]:
                            add(str(i))
                    elif item:
                        add(str(item))
    if SCORES.exists():
        per: dict[str, int] = {}
        with SCORES.open(encoding="utf-8") as f:
            for line in f:
                if not line.strip():
                    continue
                row = json.loads(line)
                if row.get("indoor"):
                    continue
                key = ("jo_" if row.get("jump_off") else "") + str(row.get("class_id", ""))
                per[key] = per.get(key, 0) + 1
                if per[key] <= 30:
                    add(str(row.get("id", "")))
                if sum(per.values()) > 200:
                    break
    return ids


def pick_diverse(rows: list[dict], n: int) -> list[dict]:
    rows = sorted(rows, key=lambda r: r["_q"], reverse=True)
    out: list[dict] = []
    sigs: set[str] = set()
    pats: dict[str, int] = {}
    for r in rows:
        if r["_q"] < 0:
            continue
        sig = layout_sig(r)
        pat = str(r.get("pattern", "outside_track"))
        if sig in sigs:
            continue
        if pats.get(pat, 0) >= max(2, n // 2) and len(out) < n:
            continue
        out.append(r)
        sigs.add(sig)
        pats[pat] = pats.get(pat, 0) + 1
        if len(out) >= n:
            break
    if len(out) < n:
        for r in rows:
            if r in out or r["_q"] < 0:
                continue
            out.append(r)
            if len(out) >= n:
                break
    return out[:n]


def flatten_ids(ship: dict) -> list[str]:
    ids: list[str] = []
    for v in ship.values():
        if isinstance(v, dict):
            for item in v.values():
                if isinstance(item, list):
                    ids.extend(item)
                elif item:
                    ids.append(str(item))
        elif isinstance(v, list):
            ids.extend(v)
    return ids


def write_ship(ship: dict, by_id: dict) -> None:
    text = json.dumps(ship, indent=2) + "\n"
    SHIP_SRC.write_text(text, encoding="utf-8")
    if GAME.exists():
        shutil.rmtree(GAME)
    GAME.mkdir(parents=True, exist_ok=True)
    (GAME / "SHIP.json").write_text(text, encoding="utf-8")
    index = []
    names_used = {k: 0 for k in BARN_NAMES}
    for i in flatten_ids(ship):
        rec = by_id[i]
        src: Path = rec["_path"]
        # barn name, not generator dump
        bucket = rec.get("class_id", "")
        if rec.get("jump_off"):
            bucket = "jo_" + bucket
        names = BARN_NAMES.get(bucket, [])
        idx = names_used.get(bucket, 0)
        if idx < len(names):
            rec["name"] = names[idx]
            names_used[bucket] = idx + 1
        dump = {k: v for k, v in rec.items() if not k.startswith("_")}
        rel = src.relative_to(COURSES)
        dst = GAME / rel
        dst.parent.mkdir(parents=True, exist_ok=True)
        body = json.dumps(dump, indent=2) + "\n"
        dst.write_text(body, encoding="utf-8")
        src.write_text(body, encoding="utf-8")
        index.append({
            "id": rec["id"],
            "class": rec.get("class_id"),
            "jump_off": bool(rec.get("jump_off")),
            "indoor": False,
            "name": rec.get("name"),
            "path": "content/courses/" + rel.as_posix(),
            "time_allowed_school": rec.get("time_allowed_school"),
            "time_allowed_show": rec.get("time_allowed_show"),
            "fence_count": len(rec.get("fences") or []),
            "pattern": rec.get("pattern"),
        })
    (GAME / "INDEX.json").write_text(json.dumps(index, indent=2) + "\n", encoding="utf-8")


def main() -> int:
    raw_ids = collect_ids()[:200]
    print(f"reading {len(raw_ids)} candidate files (cap 200)")
    buckets: dict[str, list] = {
        "lesson": [], "beginner": [], "intermediate": [], "advanced": [],
        "jo_beginner": [], "jo_intermediate": [], "jo_advanced": [],
    }
    by_id: dict[str, dict] = {}
    reads = 0
    for cid in raw_ids:
        rec = load_rec(cid)
        reads += 1
        if rec is None:
            continue
        rec["_q"] = quality(rec)
        rec["_why"] = why(rec)
        by_id[cid] = rec
        jo = bool(rec.get("jump_off"))
        cl = rec.get("class_id", "")
        if jo:
            buckets[f"jo_{cl}"].append(rec)
        elif cl in buckets:
            buckets[cl].append(rec)
    print(f"loaded {reads} files")

    # Force a live-eight cousin into beginner.
    beg = buckets["beginner"]
    if beg:
        cousin = max(beg, key=cousin_score)
        cousin["_q"] = cousin.get("_q", 0) + 20
        cousin["_why"] = (cousin.get("_why") or "") + "; closest cousin of the hardcoded eight"

    beg_picks = pick_diverse(buckets["beginner"], NEED["beginner"])
    if beg:
        cousin = max(beg, key=cousin_score)
        if cousin["id"] not in [r["id"] for r in beg_picks]:
            beg_picks = [cousin] + [r for r in beg_picks if r["id"] != cousin["id"]][: NEED["beginner"] - 1]
    ship = {
        "lesson": [r["id"] for r in pick_diverse(buckets["lesson"], NEED["lesson"])],
        "beginner": [r["id"] for r in beg_picks],
        "intermediate": [r["id"] for r in pick_diverse(buckets["intermediate"], NEED["intermediate"])],
        "advanced": [r["id"] for r in pick_diverse(buckets["advanced"], NEED["advanced"])],
        "jump_off": {
            "beginner": pick_diverse(buckets["jo_beginner"], 1)[0]["id"] if pick_diverse(buckets["jo_beginner"], 1) else "",
            "intermediate": pick_diverse(buckets["jo_intermediate"], 1)[0]["id"] if pick_diverse(buckets["jo_intermediate"], 1) else "",
            "advanced": pick_diverse(buckets["jo_advanced"], 1)[0]["id"] if pick_diverse(buckets["jo_advanced"], 1) else "",
        },
    }
    write_ship(ship, by_id)

    lines = [
        "# SHIP — the board at Hidden K",
        "",
        "Indoor is scenery. `Course.build` always calls `_build_outdoor()`. `GameState.indoor` is never set from the title. Indoor SHIP is empty.",
        "",
        "Hardcoded tracks in `course.gd` stay the fallback if JSON misses.",
        "",
    ]
    for label in ("lesson", "beginner", "intermediate", "advanced"):
        lines.append(f"## {label}")
        lines.append("")
        for i in ship[label]:
            r = by_id[i]
            w = r.get("_why") or why(r)
            if not w:
                w = "Dropped if I cannot say why — kept because the layout is legal and first fence is quiet."
            lines.append(f"- `{i}` **{r.get('name')}** — {w}.")
        lines.append("")
    lines.append("## jump-off")
    lines.append("")
    for cid, i in ship["jump_off"].items():
        r = by_id[i]
        lines.append(f"- **{cid}** `{i}` **{r.get('name')}** — four fences. Don't chase. {r.get('_why','')}.")
    lines.append("")
    REPORT.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print("SHIP", json.dumps(ship, indent=2))
    print("wrote", REPORT)
    nfiles = len(list(GAME.rglob("*.json")))
    print("game/content course json (incl SHIP+INDEX)", nfiles)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
