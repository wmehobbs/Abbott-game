"""Hidden K content factory validator. Exit 1 unless every quota is green."""
from __future__ import annotations

import json
import sys
from datetime import datetime, timezone
from pathlib import Path

from PIL import Image

from rules import (
    COUNTS,
    EXISTING_RAIL_KEYS,
    EXISTING_VARIANTS,
    JO_COUNT,
    MAX_LINE_WORDS,
    NEW_RAIL_KEYS,
    NEW_VARIANTS,
    PROC_NAMES,
    QUOTA_BARN_NOTES,
    QUOTA_COURSES,
    QUOTA_COURSES_TOTAL,
    QUOTA_FENCES,
    QUOTA_JO,
    QUOTA_LINES,
    QUOTA_PLATES,
    QUOTA_PROC,
    round_hash_part,
    validate_course,
)

ROOT = Path(__file__).resolve().parents[2]
COURSES = ROOT / "content" / "courses"
RAIL = ROOT / "content" / "rail" / "michelle.json"
BARN = ROOT / "content" / "rail" / "barn_notes.json"
FENCES = ROOT / "content" / "fences" / "catalog.json"
HARVEST_DIR = ROOT / "game" / "assets" / "textures" / "harvest"
PROC_DIR = HARVEST_DIR / "proc"
ATTR = ROOT / "game" / "assets" / "ATTRIBUTION_HARVEST.md"
CATALOG = Path(__file__).resolve().parent / "HARVEST_CATALOG.json"
STATUS = Path(__file__).resolve().parent / "STATUS.md"
INDEX = COURSES / "INDEX.json"


def load_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def iter_courses() -> list[Path]:
    if not COURSES.exists():
        return []
    return sorted(p for p in COURSES.rglob("*.json") if p.name not in ("INDEX.json", "SHIP.json"))


def check_courses() -> tuple[list[dict], list[str], dict[str, int], dict[str, int]]:
    errs: list[str] = []
    courses: list[dict] = []
    counts = {"lesson": 0, "beginner": 0, "intermediate": 0, "advanced": 0}
    jo = {"beginner": 0, "intermediate": 0, "advanced": 0}
    hashes: dict[str, str] = {}
    for path in iter_courses():
        try:
            rec = load_json(path)
        except Exception as e:
            errs.append(f"{path}: json {e}")
            continue
        if not isinstance(rec, dict):
            errs.append(f"{path}: not an object")
            continue
        cid = str(rec.get("class_id", ""))
        jump = bool(rec.get("jump_off", False))
        ve = validate_course(rec)
        if ve:
            errs.append(f"{path.name}: " + "; ".join(ve[:6]))
            continue
        h = round_hash_part(rec)
        if h in hashes:
            errs.append(f"{path.name} duplicate hash of {hashes[h]}")
            continue
        hashes[h] = path.name
        courses.append(rec)
        if jump:
            jo[cid] = jo.get(cid, 0) + 1
        else:
            counts[cid] = counts.get(cid, 0) + 1
    return courses, errs, counts, jo


def check_rail() -> tuple[int, list[str]]:
    errs: list[str] = []
    if not RAIL.exists():
        return 0, ["michelle.json missing"]
    data = load_json(RAIL)
    lines = data.get("lines") or []
    texts: set[str] = set()
    by_key: dict[str, int] = {}
    for i, row in enumerate(lines):
        if not isinstance(row, dict):
            errs.append(f"line {i} not object")
            continue
        text = str(row.get("text", "")).strip()
        key = str(row.get("key", ""))
        if not text:
            errs.append(f"{row.get('id')} empty text")
            continue
        if text in texts:
            errs.append(f"duplicate text: {text}")
            continue
        texts.add(text)
        wc = len(text.replace("—", " ").split())
        if wc > MAX_LINE_WORDS:
            errs.append(f"{row.get('id')} {wc} words: {text}")
        by_key[key] = by_key.get(key, 0) + 1
        if "id" not in row or "session" not in row or "class_id" not in row:
            errs.append(f"{row.get('id')} missing fields")
    for k in EXISTING_RAIL_KEYS:
        if by_key.get(k, 0) < EXISTING_VARIANTS:
            errs.append(f"key {k} has {by_key.get(k, 0)} < {EXISTING_VARIANTS}")
    for k in NEW_RAIL_KEYS:
        if by_key.get(k, 0) < NEW_VARIANTS:
            errs.append(f"new key {k} has {by_key.get(k, 0)} < {NEW_VARIANTS}")
    return len(texts), errs


def check_barn() -> tuple[int, list[str]]:
    errs: list[str] = []
    if not BARN.exists():
        return 0, ["barn_notes.json missing"]
    data = load_json(BARN)
    notes = data.get("notes") or []
    texts: set[str] = set()
    for n in notes:
        t = str(n.get("text", "")).strip()
        if not t:
            errs.append(f"{n.get('id')} empty")
            continue
        if t in texts:
            errs.append(f"duplicate barn note: {t}")
        texts.add(t)
    if len(notes) < QUOTA_BARN_NOTES:
        errs.append(f"barn notes {len(notes)} < {QUOTA_BARN_NOTES}")
    return len(notes), errs


def check_fences() -> tuple[int, list[str]]:
    errs: list[str] = []
    if not FENCES.exists():
        return 0, ["catalog.json missing"]
    data = load_json(FENCES)
    recipes = data.get("recipes") or []
    names = set()
    for r in recipes:
        kind = r.get("kind")
        if kind not in ("vertical", "oxer", "flower"):
            errs.append(f"{r.get('id')} bad kind {kind}")
        if not r.get("name"):
            errs.append(f"{r.get('id')} missing name")
        names.add(r.get("id"))
    if len(recipes) < QUOTA_FENCES:
        errs.append(f"fence recipes {len(recipes)} < {QUOTA_FENCES}")
    return len(recipes), errs


def parse_attr_rows() -> list[tuple[str, str, str, str, str, str]]:
    if not ATTR.exists():
        return []
    rows = []
    for line in ATTR.read_text(encoding="utf-8").splitlines():
        if not line.strip() or line.startswith("#") or line.startswith("path") or line.startswith("---"):
            continue
        if " | " not in line:
            continue
        parts = [p.strip() for p in line.split("|")]
        if len(parts) < 6:
            continue
        rows.append(tuple(parts[:6]))  # type: ignore[arg-type]
    return rows  # type: ignore[return-value]


def check_harvest() -> tuple[int, int, list[str]]:
    errs: list[str] = []
    plates = 0
    nr = 0
    if CATALOG.exists():
        cat = load_json(CATALOG)
        plist = cat.get("plates") or []
        plates = len(plist)
        nr = sum(1 for p in plist if p.get("harvested_normal") and p.get("harvested_rough"))
        for p in plist:
            for key in ("albedo", "normal", "rough"):
                rel = p.get(key)
                if not rel:
                    continue
                fp = ROOT / rel
                if not fp.exists():
                    errs.append(f"catalog file missing {rel}")
    else:
        albedos = list(HARVEST_DIR.glob("*_albedo.jpg")) if HARVEST_DIR.exists() else []
        plates = len(albedos)
        for a in albedos:
            slug = a.name[: -len("_albedo.jpg")]
            n = HARVEST_DIR / f"{slug}_normal.jpg"
            r = HARVEST_DIR / f"{slug}_rough.jpg"
            if n.exists() and r.exists():
                nr += 1
    if plates < QUOTA_PLATES:
        errs.append(f"plates {plates} < {QUOTA_PLATES}")
    if nr < 25:
        errs.append(f"harvested normal+rough pairs {nr} < 25")

    rows = parse_attr_rows()
    if not rows:
        errs.append("ATTRIBUTION_HARVEST.md has no rows")
    attr_paths = []
    for row in rows:
        path = row[0]
        attr_paths.append(path)
        fp = ROOT / path if not Path(path).is_absolute() else Path(path)
        if not fp.exists():
            errs.append(f"attribution path missing: {path}")
        url = row[1]
        if not url.startswith("http"):
            errs.append(f"attribution URL not real: {url}")
        lic = row[3].upper()
        if "CC0" not in lic and "CC-BY" not in lic and "CC BY" not in lic:
            errs.append(f"attribution license not CC0/CC-BY: {row[3]}")

    # Every harvest albedo (not proc) should be attributed.
    if HARVEST_DIR.exists():
        for p in sorted(HARVEST_DIR.glob("*_albedo.jpg")):
            rel = p.relative_to(ROOT).as_posix()
            if rel not in attr_paths:
                errs.append(f"harvest file not in attribution: {rel}")
    return plates, nr, errs


def check_proc() -> tuple[int, list[str]]:
    errs: list[str] = []
    ok = 0
    for name in PROC_NAMES:
        files = [PROC_DIR / f"{name}_{m}.jpg" for m in ("albedo", "normal", "rough")]
        if not all(f.exists() for f in files):
            missing = [f.name for f in files if not f.exists()]
            errs.append(f"proc {name} missing {missing}")
            continue
        small = False
        for f in files:
            im = Image.open(f)
            if min(im.size) < 512:
                errs.append(f"proc {f.name} {im.size} < 512")
                small = True
        if not small:
            ok += 1
    if ok < QUOTA_PROC:
        errs.append(f"proc plates {ok} < {QUOTA_PROC}")
    return ok, errs


def write_status(
    courses_ok: int,
    counts: dict,
    jo: dict,
    lines_ok: int,
    plates_ok: int,
    proc_ok: int,
    attr_ok: bool,
    fences_ok: int,
    barn_ok: int,
    errs: list[str],
    green: bool,
) -> None:
    now = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%SZ")
    def flag(ok: bool) -> str:
        return "GREEN" if ok else "RED"
    lines = [
        f"# Content factory status",
        "",
        f"timestamp: {now}",
        "",
        "## Scoreboard",
        "",
        f"- courses_ok / courses_target: {courses_ok} / {QUOTA_COURSES_TOTAL}  {flag(courses_ok >= QUOTA_COURSES_TOTAL)}",
        f"  - lesson {counts.get('lesson', 0)} / {QUOTA_COURSES['lesson']}",
        f"  - beginner {counts.get('beginner', 0)} / {QUOTA_COURSES['beginner']}",
        f"  - intermediate {counts.get('intermediate', 0)} / {QUOTA_COURSES['intermediate']}",
        f"  - advanced {counts.get('advanced', 0)} / {QUOTA_COURSES['advanced']}",
        f"  - jump-off beginner {jo.get('beginner', 0)} / {QUOTA_JO['beginner']}",
        f"  - jump-off intermediate {jo.get('intermediate', 0)} / {QUOTA_JO['intermediate']}",
        f"  - jump-off advanced {jo.get('advanced', 0)} / {QUOTA_JO['advanced']}",
        f"- lines_ok / {QUOTA_LINES}: {lines_ok} / {QUOTA_LINES}  {flag(lines_ok >= QUOTA_LINES)}",
        f"- plates_ok / {QUOTA_PLATES}: {plates_ok} / {QUOTA_PLATES}  {flag(plates_ok >= QUOTA_PLATES)}",
        f"- proc_ok / 18: {proc_ok} / {QUOTA_PROC}  {flag(proc_ok >= QUOTA_PROC)}",
        f"- fences {fences_ok} / {QUOTA_FENCES}  {flag(fences_ok >= QUOTA_FENCES)}",
        f"- barn notes {barn_ok} / {QUOTA_BARN_NOTES}  {flag(barn_ok >= QUOTA_BARN_NOTES)}",
        f"- attribution_ok: {flag(attr_ok)}",
        f"- ALL QUOTAS: {flag(green)}",
        "",
        "## Last errors",
        "",
    ]
    if not errs:
        lines.append("None.")
    else:
        for e in errs[:40]:
            lines.append(f"- {e}")
        if len(errs) > 40:
            lines.append(f"- … {len(errs) - 40} more")
    lines += [
        "",
        "## Next batch plan",
        "",
    ]
    if green:
        lines.append("STOP CONDITIONS met. validate_content.py exits 0. Do not rewrite the ride.")
        lines.append("Factory output stands alone. Wire later via content/README.md and content_library.gd.")
    else:
        if plates_ok < QUOTA_PLATES:
            lines.append("- Re-run harvest.py then convert_harvest.py.")
        if proc_ok < QUOTA_PROC:
            lines.append("- Re-run make_plates.py after harvest convert.")
        if courses_ok < QUOTA_COURSES_TOTAL:
            lines.append("- Re-run make_courses.py; throw invalid tracks; generate again.")
        if lines_ok < QUOTA_LINES:
            lines.append("- Re-run make_rail.py; add unique lines under 14 words.")
        lines.append("- Run validate_content.py until exit 0.")
    STATUS.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> int:
    all_errs: list[str] = []
    courses, c_errs, counts, jo = check_courses()
    all_errs.extend(c_errs)
    courses_ok = len(courses)
    for cid, need in QUOTA_COURSES.items():
        if counts.get(cid, 0) < need:
            all_errs.append(f"class {cid} {counts.get(cid, 0)} < {need}")
    for cid, need in QUOTA_JO.items():
        if jo.get(cid, 0) < need:
            all_errs.append(f"jump-off {cid} {jo.get(cid, 0)} < {need}")
    if courses_ok < QUOTA_COURSES_TOTAL:
        all_errs.append(f"courses {courses_ok} < {QUOTA_COURSES_TOTAL}")

    lines_ok, r_errs = check_rail()
    all_errs.extend(r_errs)
    if lines_ok < QUOTA_LINES:
        all_errs.append(f"lines {lines_ok} < {QUOTA_LINES}")

    barn_ok, b_errs = check_barn()
    all_errs.extend(b_errs)

    fences_ok, f_errs = check_fences()
    all_errs.extend(f_errs)

    plates_ok, nr, h_errs = check_harvest()
    all_errs.extend(h_errs)
    attr_ok = ATTR.exists() and not any("attribution" in e.lower() or "ATTRIBUTION" in e for e in h_errs)
    # stricter: no harvest errors about attribution
    attr_ok = ATTR.exists() and not any(
        e.startswith("attribution") or "not in attribution" in e or "ATTRIBUTION" in e for e in h_errs
    )

    proc_ok, p_errs = check_proc()
    all_errs.extend(p_errs)

    green = (
        courses_ok >= QUOTA_COURSES_TOTAL
        and all(counts.get(c, 0) >= n for c, n in QUOTA_COURSES.items())
        and all(jo.get(c, 0) >= n for c, n in QUOTA_JO.items())
        and lines_ok >= QUOTA_LINES
        and plates_ok >= QUOTA_PLATES
        and nr >= 25
        and proc_ok >= QUOTA_PROC
        and fences_ok >= QUOTA_FENCES
        and barn_ok >= QUOTA_BARN_NOTES
        and attr_ok
        and not all_errs
    )

    write_status(
        courses_ok, counts, jo, lines_ok, plates_ok, proc_ok, attr_ok, fences_ok, barn_ok, all_errs, green
    )

    print("SCOREBOARD")
    print(f"  courses_ok / courses_target  {courses_ok} / {QUOTA_COURSES_TOTAL}")
    print(f"    lesson {counts.get('lesson',0)}/{QUOTA_COURSES['lesson']}  beg {counts.get('beginner',0)}/{QUOTA_COURSES['beginner']}  int {counts.get('intermediate',0)}/{QUOTA_COURSES['intermediate']}  adv {counts.get('advanced',0)}/{QUOTA_COURSES['advanced']}")
    print(f"    jo beg {jo.get('beginner',0)}/{QUOTA_JO['beginner']}  int {jo.get('intermediate',0)}/{QUOTA_JO['intermediate']}  adv {jo.get('advanced',0)}/{QUOTA_JO['advanced']}")
    print(f"  lines_ok / {QUOTA_LINES}               {lines_ok} / {QUOTA_LINES}")
    print(f"  plates_ok / {QUOTA_PLATES}               {plates_ok} / {QUOTA_PLATES}  (n+r pairs {nr}/25)")
    print(f"  proc_ok / 18                 {proc_ok} / {QUOTA_PROC}")
    print(f"  fences                       {fences_ok} / {QUOTA_FENCES}")
    print(f"  barn notes                   {barn_ok} / {QUOTA_BARN_NOTES}")
    print(f"  attribution_ok               {attr_ok}")
    if all_errs:
        print(f"ERRORS ({len(all_errs)})")
        for e in all_errs[:30]:
            print(" ", e)
        if len(all_errs) > 30:
            print(f"  … {len(all_errs)-30} more")
    print(f"STATUS {STATUS}")
    return 0 if green and not all_errs else 1


if __name__ == "__main__":
    sys.exit(main())
