"""Mega quota gate. Exit 0 only when every MEGA_QUOTAS.json bar is green."""
from __future__ import annotations

import json
import sys
from datetime import datetime, timezone
from pathlib import Path

from rules import (
    COUNTS,
    INDOOR_COUNTS,
    JO_COUNT,
    MAX_LINE_WORDS,
    MEGA_RAIL_KEYS,
    EXISTING_RAIL_KEYS,
    NEW_RAIL_KEYS,
    PROC_NAMES,
    round_hash_part,
    validate_course,
)

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
COURSES = ROOT / "content" / "courses"
RAIL = ROOT / "content" / "rail" / "michelle.json"
BARN = ROOT / "content" / "rail" / "barn_notes.json"
BEATS = ROOT / "content" / "rail" / "LESSON_BEATS.json"
FENCES = ROOT / "content" / "fences" / "catalog.json"
PRIZE = ROOT / "content" / "copy" / "prize_list.json"
CARDS = ROOT / "content" / "copy" / "class_cards.json"
PED_REL = ROOT / "content" / "pedagogy" / "related_distances.json"
PED_TAB = ROOT / "content" / "pedagogy" / "table_a.json"
SHIP = COURSES / "SHIP.json"
SCORES = COURSES / "SCORES.jsonl"
HARVEST = ROOT / "game" / "assets" / "textures" / "harvest"
PROC = HARVEST / "proc"
ART = HERE / "artshots"
MMAP = HERE / "MATERIAL_MAP.md"
GAME_CONTENT = ROOT / "game" / "content"
SMOKE = HERE / "smoke_results.json"
PLAYTEST = ROOT / "dist" / "playtest_results.json"
PLAYTEST_USER = ROOT / "game"  # filled at runtime from user://
QUOTAS = HERE / "MEGA_QUOTAS.json"
STATUS = HERE / "STATUS.md"

ALL_KEYS = list(EXISTING_RAIL_KEYS) + list(NEW_RAIL_KEYS) + list(MEGA_RAIL_KEYS)


def load_quotas() -> dict:
    return json.loads(QUOTAS.read_text(encoding="utf-8"))


def loadj(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def iter_courses() -> list[Path]:
    if not COURSES.exists():
        return []
    return sorted(p for p in COURSES.rglob("*.json") if p.name not in ("INDEX.json", "SHIP.json"))


def grams(text: str, n: int) -> list[str]:
    w = text.replace("—", " ").split()
    if len(w) < n:
        return []
    return [" ".join(w[i : i + n]).lower() for i in range(len(w) - n + 1)]


def classify(rec: dict) -> str:
    indoor = rec.get("ring") == "indoor" or bool(rec.get("indoor"))
    jo = bool(rec.get("jump_off"))
    cid = rec.get("class_id", "")
    if indoor and jo:
        return f"in_jo_{cid}"
    if indoor:
        return f"in_{cid}"
    if jo:
        return f"jo_{cid}"
    return f"out_{cid}"


def check_courses(q: dict) -> tuple[dict, list[str]]:
    errs: list[str] = []
    counts = {
        "out_lesson": 0, "out_beginner": 0, "out_intermediate": 0, "out_advanced": 0,
        "jo_beginner": 0, "jo_intermediate": 0, "jo_advanced": 0,
        "in_lesson": 0, "in_beginner": 0, "in_intermediate": 0, "in_advanced": 0,
    }
    hashes: dict[str, str] = {}
    names: set[str] = set()
    walks: list[str] = []
    briefs: set[str] = set()
    walk_g12: dict[str, str] = {}
    ok = 0
    for path in iter_courses():
        try:
            rec = loadj(path)
        except Exception as e:
            errs.append(f"{path.name}: json {e}")
            continue
        ve = validate_course(rec)
        if ve:
            errs.append(f"{path.name}: " + "; ".join(ve[:4]))
            continue
        h = round_hash_part(rec)
        if h in hashes:
            errs.append(f"{path.name} duplicate hash of {hashes[h]}")
            continue
        hashes[h] = path.name
        nm = str(rec.get("name", "")).strip()
        if not nm:
            errs.append(f"{path.name} empty name")
            continue
        if nm in names:
            errs.append(f"{path.name} duplicate name {nm}")
            continue
        names.add(nm)
        wt = str(rec.get("walk_text", "")).strip()
        wc = len(wt.replace("—", " ").split())
        if wc < 40 or wc > 90:
            errs.append(f"{path.name} walk_text {wc} words")
        else:
            clash = False
            for g in grams(wt, 12):
                if g in walk_g12 and walk_g12[g] != rec.get("id"):
                    errs.append(f"{path.name} walk 12-gram clash with {walk_g12[g]}")
                    clash = True
                    break
            if not clash:
                for g in grams(wt, 12):
                    walk_g12[g] = str(rec.get("id"))
        brief = str(rec.get("michelle_brief", "")).strip()
        if not brief:
            errs.append(f"{path.name} missing michelle_brief")
        else:
            bw = len(brief.replace("—", " ").split())
            if bw > 14:
                errs.append(f"{path.name} brief {bw} words")
            if brief in briefs:
                errs.append(f"{path.name} duplicate brief")
            briefs.add(brief)
        indoor = rec.get("ring") == "indoor" or bool(rec.get("indoor"))
        jo = bool(rec.get("jump_off"))
        cid = rec.get("class_id", "")
        if not jo and cid != "lesson" and not indoor:
            if not any(f.get("related") for f in rec.get("fences") or []):
                errs.append(f"{path.name} full outdoor missing related")
        key = classify(rec)
        if key in counts:
            counts[key] += 1
        ok += 1
        walks.append(wt)
    outdoor = counts["out_lesson"] + counts["out_beginner"] + counts["out_intermediate"] + counts["out_advanced"]
    jo = counts["jo_beginner"] + counts["jo_intermediate"] + counts["jo_advanced"]
    indoor = counts["in_lesson"] + counts["in_beginner"] + counts["in_intermediate"] + counts["in_advanced"]
    if outdoor < int(q["outdoor"]):
        errs.append(f"outdoor {outdoor} < {q['outdoor']}")
    if counts["out_lesson"] < int(q["outdoor_lesson"]):
        errs.append(f"outdoor lesson {counts['out_lesson']} < {q['outdoor_lesson']}")
    if counts["out_beginner"] < int(q["outdoor_beginner"]):
        errs.append(f"outdoor beginner {counts['out_beginner']} < {q['outdoor_beginner']}")
    if counts["out_intermediate"] < int(q["outdoor_intermediate"]):
        errs.append(f"outdoor intermediate {counts['out_intermediate']} < {q['outdoor_intermediate']}")
    if counts["out_advanced"] < int(q["outdoor_advanced"]):
        errs.append(f"outdoor advanced {counts['out_advanced']} < {q['outdoor_advanced']}")
    if jo < int(q["jump_off"]):
        errs.append(f"jump-off {jo} < {q['jump_off']}")
    for cid in ("beginner", "intermediate", "advanced"):
        if counts[f"jo_{cid}"] < int(q["jump_off_per_class"]):
            errs.append(f"jo {cid} {counts[f'jo_{cid}']} < {q['jump_off_per_class']}")
    if indoor < int(q["indoor"]):
        errs.append(f"indoor {indoor} < {q['indoor']}")
    if counts["in_lesson"] < int(q["indoor_lesson"]):
        errs.append(f"indoor lesson {counts['in_lesson']} < {q['indoor_lesson']}")
    if counts["in_beginner"] < int(q["indoor_beginner"]):
        errs.append(f"indoor beginner {counts['in_beginner']} < {q['indoor_beginner']}")
    if counts["in_intermediate"] < int(q["indoor_intermediate"]):
        errs.append(f"indoor intermediate {counts['in_intermediate']} < {q['indoor_intermediate']}")
    if counts["in_advanced"] < int(q["indoor_advanced"]):
        errs.append(f"indoor advanced {counts['in_advanced']} < {q['indoor_advanced']}")
    counts["outdoor"] = outdoor
    counts["jump_off"] = jo
    counts["indoor"] = indoor
    counts["ok"] = ok
    return counts, errs


def check_rail(q: dict) -> tuple[int, list[str]]:
    errs: list[str] = []
    if not RAIL.exists():
        return 0, ["michelle.json missing"]
    data = loadj(RAIL)
    lines = data.get("lines") or []
    texts: set[str] = set()
    by_key: dict[str, int] = {}
    g5: dict[str, str] = {}
    for i, row in enumerate(lines):
        text = str(row.get("text", "")).strip()
        key = str(row.get("key", ""))
        if not text:
            errs.append(f"line {i} empty")
            continue
        if text in texts:
            errs.append(f"duplicate rail: {text}")
            continue
        texts.add(text)
        wc = len(text.replace("—", " ").split())
        if wc > MAX_LINE_WORDS:
            errs.append(f"{row.get('id')} {wc} words")
        for g in grams(text, 5):
            if g in g5 and g5[g] != text:
                errs.append(f"5-gram clash: {g!r}")
                break
            g5[g] = text
        by_key[key] = by_key.get(key, 0) + 1
        if "session" not in row or "class_id" not in row:
            errs.append(f"{row.get('id')} missing session/class")
    per = int(q["michelle_per_key"])
    for k in ALL_KEYS:
        if by_key.get(k, 0) < per:
            errs.append(f"key {k} has {by_key.get(k, 0)} < {per}")
    if len(texts) < int(q["michelle"]):
        errs.append(f"michelle {len(texts)} < {q['michelle']}")
    return len(texts), errs


def check_json_count(path: Path, key: str, need: int, label: str) -> tuple[int, list[str]]:
    errs = []
    if not path.exists():
        return 0, [f"{label} missing"]
    data = loadj(path)
    rows = data.get(key) or []
    texts = set()
    for r in rows:
        t = str(r.get("text", r.get("id", "")))
        texts.add(t)
    if len(rows) < need:
        errs.append(f"{label} {len(rows)} < {need}")
    return len(rows), errs


def check_harvest(q: dict) -> tuple[int, int, int, list[str]]:
    errs: list[str] = []
    plates = 0
    nr = 0
    if HARVEST.exists():
        for a in HARVEST.glob("*_albedo.jpg"):
            plates += 1
            n = HARVEST / a.name.replace("_albedo.jpg", "_normal.jpg")
            r = HARVEST / a.name.replace("_albedo.jpg", "_rough.jpg")
            if n.exists() and r.exists():
                nr += 1
    proc_ok = 0
    for name in PROC_NAMES:
        files = [PROC / f"{name}_{m}.jpg" for m in ("albedo", "normal", "rough")]
        if all(f.exists() for f in files):
            proc_ok += 1
    # extra proc names beyond PROC_NAMES
    if PROC.exists():
        extra = {p.name[: -len("_albedo.jpg")] for p in PROC.glob("*_albedo.jpg")}
        proc_ok = max(proc_ok, len(extra))
    if plates < int(q["harvest_plates"]):
        errs.append(f"harvest plates {plates} < {q['harvest_plates']}")
    if nr < int(q["harvest_nr"]):
        errs.append(f"harvest n+r {nr} < {q['harvest_nr']}")
    if proc_ok < int(q["proc_plates"]):
        errs.append(f"proc plates {proc_ok} < {q['proc_plates']}")
    return plates, nr, proc_ok, errs


def check_ship(q: dict) -> tuple[dict, list[str]]:
    errs: list[str] = []
    if not SHIP.exists():
        return {}, ["SHIP.json missing"]
    ship = loadj(SHIP)
    out_n = 0
    for cid, need in (
        ("lesson", int(q["ship_lesson"])),
        ("beginner", int(q["ship_beginner"])),
        ("intermediate", int(q["ship_intermediate"])),
        ("advanced", int(q["ship_advanced"])),
    ):
        ids = ship.get(cid) or []
        if not isinstance(ids, list) or len(ids) < need:
            errs.append(f"SHIP {cid} {len(ids) if isinstance(ids, list) else 0} < {need}")
        else:
            out_n += len(ids)
    if out_n < int(q["ship_outdoor"]):
        errs.append(f"SHIP outdoor {out_n} < {q['ship_outdoor']}")
    jo = ship.get("jump_off") or {}
    jo_n = 0
    if isinstance(jo, dict):
        for cid in ("beginner", "intermediate", "advanced"):
            v = jo.get(cid, [])
            if isinstance(v, str):
                v = [v] if v else []
            if not isinstance(v, list) or len(v) < 3:
                errs.append(f"SHIP jo {cid} {len(v) if isinstance(v, list) else 0} < 3")
            else:
                jo_n += len(v)
    if jo_n < int(q["ship_jump_off"]):
        errs.append(f"SHIP jump-off {jo_n} < {q['ship_jump_off']}")
    indoor = ship.get("indoor") or {}
    in_n = 0
    if isinstance(indoor, dict):
        for cid in ("lesson", "beginner", "intermediate", "advanced"):
            v = indoor.get(cid) or []
            if isinstance(v, list):
                in_n += len(v)
    if in_n < int(q["ship_indoor"]):
        errs.append(f"SHIP indoor {in_n} < {q['ship_indoor']}")
    # game/content copies
    if not (GAME_CONTENT / "courses" / "SHIP.json").exists():
        errs.append("game/content/courses/SHIP.json missing")
    if not (GAME_CONTENT / "rail" / "michelle.json").exists():
        errs.append("game/content/rail/michelle.json missing")
    if not (GAME_CONTENT / "fences" / "catalog.json").exists():
        errs.append("game/content/fences/catalog.json missing")
    return ship, errs


def check_artshots(q: dict) -> tuple[int, list[str]]:
    errs = []
    n = 0
    if ART.exists():
        n = len(list(ART.glob("*.png")))
    if n < int(q["artshots"]):
        errs.append(f"artshots {n} < {q['artshots']}")
    notes = ART / "NOTES.md"
    if not notes.exists():
        errs.append("artshots/NOTES.md missing")
    return n, errs


def check_binds(q: dict) -> tuple[int, list[str]]:
    errs = []
    if not MMAP.exists():
        return 0, ["MATERIAL_MAP.md missing"]
    n = 0
    for line in MMAP.read_text(encoding="utf-8").splitlines():
        if line.strip().startswith("|") and "harvest/" in line and "Live bind" not in line and "---" not in line:
            n += 1
    if n < int(q["material_binds"]):
        errs.append(f"material binds {n} < {q['material_binds']}")
    return n, errs


def check_scores(q: dict) -> tuple[float, list[str]]:
    errs = []
    if not SCORES.exists():
        return 0.0, ["SCORES.jsonl missing"]
    vals = []
    with SCORES.open(encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            row = json.loads(line)
            vals.append(float(row.get("score", 0)))
    if not vals:
        return 0.0, ["SCORES.jsonl empty"]
    mean = sum(vals) / len(vals)
    if mean < float(q["mean_score"]):
        errs.append(f"mean score {mean:.1f} < {q['mean_score']}")
    return mean, errs


def check_smoke(q: dict) -> tuple[int, list[str]]:
    errs = []
    if not SMOKE.exists():
        return 0, ["smoke_results.json missing"]
    data = loadj(SMOKE)
    n = int(data.get("ok", 0))
    if not data.get("pass"):
        errs.append("smoke did not pass")
    if n < int(q["smoke"]):
        errs.append(f"smoke {n} < {q['smoke']}")
    return n, errs


def check_playtest() -> list[str]:
    errs = []
    paths = [
        ROOT / "dist" / "playtest_results.json",
        HERE / "playtest_results.json",
        ROOT / "playtest_results.json",
    ]
    # Godot user:// on Windows
    home = Path.home() / "AppData" / "Roaming" / "Godot" / "app_userdata"
    for p in home.glob("*/playtest_results.json"):
        paths.append(p)
    found = None
    for p in paths:
        if p.exists():
            found = p
            break
    if found is None:
        errs.append("playtest_results.json missing (run headless --playtest)")
        return errs
    data = loadj(found)
    if not data.get("pass"):
        errs.append(f"playtest pass is not true ({found})")
    return errs


def write_status(q: dict, counts: dict, lines: int, harvest: tuple, ship_errs: list, extra: dict, errs: list[str], green: bool) -> None:
    now = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%SZ")
    def fl(ok: bool) -> str:
        return "GREEN" if ok else "RED"
    plates, nr, proc = harvest
    body = [
        "# Content factory status",
        "",
        f"timestamp: {now}",
        "",
        f"## Mega scoreboard (raise {q.get('raise', 0)})",
        "",
        f"- outdoor {counts.get('outdoor', 0)} / {q['outdoor']}  {fl(counts.get('outdoor', 0) >= q['outdoor'])}",
        f"  - lesson {counts.get('out_lesson', 0)} / {q['outdoor_lesson']}",
        f"  - beginner {counts.get('out_beginner', 0)} / {q['outdoor_beginner']}",
        f"  - intermediate {counts.get('out_intermediate', 0)} / {q['outdoor_intermediate']}",
        f"  - advanced {counts.get('out_advanced', 0)} / {q['outdoor_advanced']}",
        f"- jump-off {counts.get('jump_off', 0)} / {q['jump_off']}",
        f"- indoor {counts.get('indoor', 0)} / {q['indoor']}",
        f"- michelle {lines} / {q['michelle']}",
        f"- harvest {plates} / {q['harvest_plates']}  n+r {nr} / {q['harvest_nr']}",
        f"- proc {proc} / {q['proc_plates']}",
        f"- artshots {extra.get('artshots', 0)} / {q['artshots']}",
        f"- binds {extra.get('binds', 0)} / {q['material_binds']}",
        f"- mean score {extra.get('mean', 0):.1f} / {q['mean_score']}",
        f"- smoke {extra.get('smoke', 0)} / {q['smoke']}",
        f"- ALL MEGA QUOTAS: {fl(green)}",
        "",
        "## Last errors",
        "",
    ]
    if not errs:
        body.append("None.")
    else:
        for e in errs[:50]:
            body.append(f"- {e}")
        if len(errs) > 50:
            body.append(f"- … {len(errs) - 50} more")
    body += [
        "",
        "## Next batch",
        "",
    ]
    if green and int(q.get("raise", 0)) >= 3:
        body.append("Three quota raises done. Playtest still required green. Keep generating if anything slipped.")
    elif green:
        body.append("Mega quotas green but raise count < 3. DOUBLE quotas and keep going.")
    else:
        body.append("Fill the red bars. Do not idle.")
    STATUS.write_text("\n".join(body) + "\n", encoding="utf-8")


def main() -> int:
    q = load_quotas()
    all_errs: list[str] = []
    counts, e = check_courses(q)
    all_errs.extend(e)
    lines, e = check_rail(q)
    all_errs.extend(e)
    barn_n, e = check_json_count(BARN, "notes", int(q["barn_notes"]), "barn notes")
    all_errs.extend(e)
    beat_n, e = check_json_count(BEATS, "beats", int(q["lesson_beats"]), "lesson beats")
    all_errs.extend(e)
    fence_n, e = check_json_count(FENCES, "recipes", int(q["fence_recipes"]), "fences")
    all_errs.extend(e)
    prize_n, e = check_json_count(PRIZE, "pages", int(q["prize_list"]), "prize list")
    all_errs.extend(e)
    card_n, e = check_json_count(CARDS, "cards", int(q["class_cards"]), "class cards")
    all_errs.extend(e)
    if not PED_REL.exists():
        all_errs.append("related_distances.json missing")
    if not PED_TAB.exists():
        all_errs.append("table_a.json missing")
    plates, nr, proc, e = check_harvest(q)
    all_errs.extend(e)
    _, e = check_ship(q)
    all_errs.extend(e)
    art_n, e = check_artshots(q)
    all_errs.extend(e)
    binds, e = check_binds(q)
    all_errs.extend(e)
    mean, e = check_scores(q)
    all_errs.extend(e)
    smoke_n, e = check_smoke(q)
    all_errs.extend(e)
    all_errs.extend(check_playtest())
    green = not all_errs
    extra = {"artshots": art_n, "binds": binds, "mean": mean, "smoke": smoke_n}
    write_status(q, counts, lines, (plates, nr, proc), [], extra, all_errs, green)
    print(f"mega raise={q.get('raise', 0)} outdoor={counts.get('outdoor')} lines={lines} plates={plates} proc={proc}")
    if all_errs:
        print(f"{len(all_errs)} errors")
        for e in all_errs[:40]:
            print(" ", e)
        return 1
    print("MEGA GREEN")
    return 0


if __name__ == "__main__":
    sys.exit(main())
