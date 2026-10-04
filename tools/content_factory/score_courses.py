"""Score the existing course library and write a curated SHIP.json. Does not mint new tracks."""
from __future__ import annotations

import json
import math
import shutil
from pathlib import Path

from rules import COUNTS, INDOOR_COUNTS, INDOOR_JO_COUNT, JO_COUNT, PI, path_length_m, travel_dir

ROOT = Path(__file__).resolve().parents[2]
COURSES = ROOT / "content" / "courses"
OUT_SHIP = COURSES / "SHIP.json"
OUT_REPORT = Path(__file__).resolve().parent / "SHIP_REPORT.md"
GAME_CONTENT = ROOT / "game" / "content"

NEED = {
    "lesson": 3,
    "beginner": 8,
    "intermediate": 10,
    "advanced": 12,
}
SHIP_NEED = {
    "lesson": 6,
    "beginner": 12,
    "intermediate": 12,
    "advanced": 10,
}
SHIP_INDOOR = {
    "lesson": 3,
    "beginner": 5,
    "intermediate": 5,
    "advanced": 3,
}
OUT_SCORES = Path(__file__).resolve().parents[2] / "content" / "courses" / "SCORES.jsonl"

# Live beginner cousin (course.gd hardcoded).
LIVE_BEG = [
    (7.0, -20.0, 0.0, "vertical"),
    (-7.2, -10.0, 0.06, "vertical"),
    (7.5, 2.0, -0.04, "flower"),
    (-6.5, 12.0, 0.10, "oxer"),
    (6.8, 22.0, -0.06, "vertical"),
    (0.0, 28.0, 0.0, "oxer"),
    (-7.0, 8.0, PI + 0.05, "vertical"),
    (5.5, -8.0, PI - 0.08, "vertical"),
]


def load_all() -> list[dict]:
    out = []
    for p in COURSES.rglob("*.json"):
        if p.name in ("INDEX.json", "SHIP.json"):
            continue
        rec = json.loads(p.read_text(encoding="utf-8"))
        rec["_path"] = p
        out.append(rec)
    return out


def has_related(rec: dict) -> bool:
    for f in rec.get("fences") or []:
        if f.get("related"):
            return True
    return False


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


def outside_frac(rec: dict) -> float:
    fs = rec.get("fences") or []
    if not fs:
        return 0.0
    n = sum(1 for f in fs if abs(float(f["pos"][0])) >= 5.5)
    return n / len(fs)


def home_stretch(rec: dict) -> int:
    n = 0
    for f in rec.get("fences") or []:
        yaw = float(f.get("yaw", 0.0))
        if abs(abs(yaw) - PI) < 0.45 or abs(abs(yaw) - 3.0) < 0.45:
            n += 1
    return n


def cousin_score(rec: dict) -> float:
    fs = rec.get("fences") or []
    if len(fs) != 8:
        return 0.0
    s = 0.0
    for i, live in enumerate(LIVE_BEG):
        f = fs[i]
        x, z = float(f["pos"][0]), float(f["pos"][2])
        s -= math.hypot(x - live[0], z - live[1]) * 0.08
        if f.get("kind") == live[3]:
            s += 1.2
        # same side of the ring
        if (x >= 0) == (live[0] >= 0):
            s += 0.6
    return s


def score(rec: dict) -> tuple[float, list[str]]:
    notes: list[str] = []
    fs = rec.get("fences") or []
    cid = rec.get("class_id", "")
    jo = bool(rec.get("jump_off"))
    indoor = rec.get("ring") == "indoor" or bool(rec.get("indoor"))
    if indoor:
        need = INDOOR_JO_COUNT if jo else INDOOR_COUNTS.get(cid, 0)
    else:
        need = JO_COUNT if jo else NEED.get(cid, 0)
    pts = 50.0
    if len(fs) != need:
        return 0.0, [f"count {len(fs)}!={need}"]
    if first_vertical(rec):
        pts += 12.0
        notes.append("quiet first vertical")
    else:
        pts -= 10.0
        notes.append("first is not a vertical")
    if not jo and cid != "lesson":
        if has_related(rec):
            pts += 14.0
            notes.append("labeled related")
        else:
            pts -= 8.0
            notes.append("no related")
    elif cid == "lesson" and has_related(rec):
        pts += 8.0
        notes.append("related line")
    cf = consec_flowers(rec)
    if cf:
        pts -= 15.0
        notes.append("consecutive flowers")
    else:
        pts += 4.0
    of = outside_frac(rec)
    pts += of * 10.0
    if of >= 0.55:
        notes.append("outside track")
    hs = home_stretch(rec)
    if not jo and cid != "lesson":
        if hs >= 2:
            pts += 8.0
            notes.append("comes home")
        elif hs == 1:
            pts += 3.0
    wt = str(rec.get("walk_text", ""))
    wc = len(wt.replace("—", " ").split())
    if 40 <= wc <= 90:
        pts += 8.0
        notes.append("walk")
    if rec.get("michelle_brief"):
        pts += 3.0
    if rec.get("pattern"):
        pts += 4.0
    if cid in ("intermediate", "advanced") and not jo:
        notes_s = str(rec.get("notes", "")) + " " + str(rec.get("pattern", ""))
        if "rollback" in notes_s or "bending" in notes_s:
            pts += 6.0
            notes.append("rollback/bending")
    # path vs time
    length = path_length_m(rec)
    t = float(rec.get("time_allowed_school") or 90.0)
    expected = length / 350.0 * 60.0
    if t > 20 and abs(t - expected) / t < 0.7:
        pts += 2.0
    else:
        pts -= 1.0
    if cid == "beginner" and not jo and not indoor:
        cs = cousin_score(rec)
        pts += max(-4.0, min(8.0, cs))
        if cs > 4:
            notes.append("cousin of live 8")
    # penalize a pile at x~0
    mid = sum(1 for f in fs if abs(float(f["pos"][0])) < 2.5)
    if mid >= 3:
        pts -= 5.0
        notes.append("pile in the middle")
    pts = max(0.0, min(100.0, pts))
    return pts, notes


def pick(rows: list[dict], n: int) -> list[dict]:
    rows = sorted(rows, key=lambda r: r["_score"], reverse=True)
    out = []
    seen_hash = set()
    for r in rows:
        if r["_score"] < 0:
            continue
        key = r["id"]
        if key in seen_hash:
            continue
        out.append(r)
        if len(out) >= n:
            break
    return out


def _ship_ids(ship: dict) -> list[str]:
    ids: list[str] = []
    for k, v in ship.items():
        if isinstance(v, dict):
            for item in v.values():
                if isinstance(item, list):
                    ids.extend(item)
                elif item:
                    ids.append(str(item))
        elif isinstance(v, list):
            ids.extend(v)
    return ids


def copy_into_game(ship: dict, by_id: dict) -> None:
    dest_root = GAME_CONTENT / "courses"
    if dest_root.exists():
        shutil.rmtree(dest_root)
    dest_root.mkdir(parents=True, exist_ok=True)
    (dest_root / "SHIP.json").write_text(json.dumps(ship, indent=2) + "\n", encoding="utf-8")
    ids = _ship_ids(ship)
    index_rows = []
    for i in ids:
        rec = by_id.get(i)
        if not rec:
            continue
        src: Path = rec["_path"]
        rel = src.relative_to(COURSES)
        dst = dest_root / rel
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dst)
        index_rows.append({
            "id": rec["id"],
            "class": rec.get("class_id"),
            "jump_off": bool(rec.get("jump_off")),
            "indoor": rec.get("ring") == "indoor",
            "name": rec.get("name"),
            "path": ("content/courses/" + rel.as_posix()),
            "time_allowed_school": rec.get("time_allowed_school"),
            "time_allowed_show": rec.get("time_allowed_show"),
            "fence_count": len(rec.get("fences") or []),
            "pattern": rec.get("pattern"),
        })
    (dest_root / "INDEX.json").write_text(json.dumps(index_rows, indent=2) + "\n", encoding="utf-8")
    # rail + fences the export can see
    for rel in ("rail/michelle.json", "rail/barn_notes.json", "fences/catalog.json"):
        src = ROOT / "content" / rel
        if src.exists():
            dst = GAME_CONTENT / rel
            dst.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(src, dst)


def write_scores(allc: list[dict]) -> float:
    OUT_SCORES.parent.mkdir(parents=True, exist_ok=True)
    vals = []
    with OUT_SCORES.open("w", encoding="utf-8") as f:
        for rec in sorted(allc, key=lambda r: r["_score"], reverse=True):
            row = {
                "id": rec.get("id"),
                "class_id": rec.get("class_id"),
                "jump_off": bool(rec.get("jump_off")),
                "indoor": rec.get("ring") == "indoor",
                "score": round(rec["_score"], 2),
                "pattern": rec.get("pattern"),
                "notes": rec.get("_notes"),
            }
            f.write(json.dumps(row) + "\n")
            vals.append(rec["_score"])
    return (sum(vals) / len(vals)) if vals else 0.0


def main() -> None:
    allc = load_all()
    buckets: dict[str, list] = {
        "lesson": [],
        "beginner": [],
        "intermediate": [],
        "advanced": [],
        "jo_beginner": [],
        "jo_intermediate": [],
        "jo_advanced": [],
        "in_lesson": [],
        "in_beginner": [],
        "in_intermediate": [],
        "in_advanced": [],
    }
    for rec in allc:
        pts, notes = score(rec)
        rec["_score"] = pts
        rec["_notes"] = notes
        cid = rec.get("class_id", "")
        indoor = rec.get("ring") == "indoor" or bool(rec.get("indoor"))
        jo = bool(rec.get("jump_off"))
        if indoor and not jo:
            buckets[f"in_{cid}"].append(rec)
        elif jo and not indoor:
            buckets[f"jo_{cid}"].append(rec)
        elif not indoor and cid in ("lesson", "beginner", "intermediate", "advanced"):
            buckets[cid].append(rec)

    mean = write_scores(allc)
    print(f"mean score {mean:.1f} n={len(allc)}")

    qpath = Path(__file__).resolve().parent / "MEGA_QUOTAS.json"
    ship_need = dict(SHIP_NEED)
    ship_in = dict(SHIP_INDOOR)
    jo_n = 3
    if qpath.exists():
        q = json.loads(qpath.read_text(encoding="utf-8"))
        ship_need = {
            "lesson": int(q.get("ship_lesson", 6)),
            "beginner": int(q.get("ship_beginner", 12)),
            "intermediate": int(q.get("ship_intermediate", 12)),
            "advanced": int(q.get("ship_advanced", 10)),
        }
        inn = int(q.get("ship_indoor", 16))
        ship_in = {
            "lesson": max(2, inn // 8),
            "beginner": max(3, inn // 4),
            "intermediate": max(3, inn // 4),
            "advanced": max(2, inn - (inn // 8) - 2 * (inn // 4)),
        }
        jo_n = max(3, int(q.get("ship_jump_off", 9)) // 3)

    ship = {
        "lesson": [r["id"] for r in pick(buckets["lesson"], ship_need["lesson"])],
        "beginner": [r["id"] for r in pick(buckets["beginner"], ship_need["beginner"])],
        "intermediate": [r["id"] for r in pick(buckets["intermediate"], ship_need["intermediate"])],
        "advanced": [r["id"] for r in pick(buckets["advanced"], ship_need["advanced"])],
        "jump_off": {
            "beginner": [r["id"] for r in pick(buckets["jo_beginner"], jo_n)],
            "intermediate": [r["id"] for r in pick(buckets["jo_intermediate"], jo_n)],
            "advanced": [r["id"] for r in pick(buckets["jo_advanced"], jo_n)],
        },
        "indoor": {
            "lesson": [r["id"] for r in pick(buckets["in_lesson"], ship_in["lesson"])],
            "beginner": [r["id"] for r in pick(buckets["in_beginner"], ship_in["beginner"])],
            "intermediate": [r["id"] for r in pick(buckets["in_intermediate"], ship_in["intermediate"])],
            "advanced": [r["id"] for r in pick(buckets["in_advanced"], ship_in["advanced"])],
        },
    }
    OUT_SHIP.write_text(json.dumps(ship, indent=2) + "\n", encoding="utf-8")
    by_id = {r["id"]: r for r in allc}
    copy_into_game(ship, by_id)

    lines = ["# SHIP course picks", "", "Top scores, pattern mix, live cousins kept as fallback in course.gd.", ""]
    for label, ids in [
        ("lesson", ship["lesson"]),
        ("beginner", ship["beginner"]),
        ("intermediate", ship["intermediate"]),
        ("advanced", ship["advanced"]),
    ]:
        lines.append(f"## {label}")
        lines.append("")
        lines.append("| id | score | name | why |")
        lines.append("| --- | --- | --- | --- |")
        for i in ids:
            r = by_id[i]
            why = "; ".join(r["_notes"]) or r.get("notes", "")
            lines.append(f"| `{i}` | {r['_score']:.1f} | {r.get('name','')} | {why} |")
        lines.append("")
    lines.append("## jump-off")
    lines.append("")
    for cid, ids in ship["jump_off"].items():
        for i in ids:
            r = by_id[i]
            lines.append(f"- **{cid}** `{i}` — {r.get('name','')}. {'; '.join(r['_notes'])}.")
    lines.append("")
    lines.append("## indoor")
    lines.append("")
    for cid, ids in ship["indoor"].items():
        for i in ids:
            r = by_id[i]
            lines.append(f"- **{cid}** `{i}` — {r.get('name','')}.")
    lines.append("")
    lines.append("Copied SHIP + rail + fences into `game/content/` for `res://content`.")
    OUT_REPORT.write_text("\n".join(lines) + "\n", encoding="utf-8")

    print("RANKED (top per class)")
    for k, rows in buckets.items():
        rows = sorted(rows, key=lambda r: r["_score"], reverse=True)
        print(f"\n{k}")
        for r in rows[:8]:
            print(f"  {r['_score']:6.1f}  {r['id']:20s}  {r.get('name','')[:40]:40s}  {', '.join(r['_notes'][:3])}")
    print("\nSHIP", json.dumps(ship, indent=2))
    print("wrote", OUT_SHIP)
    print("wrote", OUT_REPORT)


if __name__ == "__main__":
    main()
