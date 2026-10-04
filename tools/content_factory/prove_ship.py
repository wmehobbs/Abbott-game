"""Every live SHIP id loads. Fence counts match. Kinds and bounds legal. File count matches."""
from __future__ import annotations

import json
import sys
from pathlib import Path

from rules import COUNTS, JO_COUNT, validate_course

ROOT = Path(__file__).resolve().parents[2]
GAME = ROOT / "game" / "content" / "courses"
SHIP = GAME / "SHIP.json"


def flatten(ship: dict) -> list[str]:
    ids: list[str] = []
    for k, v in ship.items():
        if k == "indoor":
            continue
        if isinstance(v, dict):
            for item in v.values():
                if isinstance(item, list):
                    ids.extend(item)
                elif item:
                    ids.append(str(item))
        elif isinstance(v, list):
            ids.extend(v)
    return ids


def find(cid: str) -> Path | None:
    for p in GAME.rglob(f"{cid}.json"):
        if p.name in ("INDEX.json", "SHIP.json"):
            continue
        return p
    return None


def main() -> int:
    ship = json.loads(SHIP.read_text(encoding="utf-8"))
    ids = flatten(ship)
    errs: list[str] = []
    if ship.get("indoor"):
        inn = ship["indoor"]
        n = 0
        if isinstance(inn, dict):
            for v in inn.values():
                n += len(v) if isinstance(v, list) else (1 if v else 0)
        if n:
            errs.append(f"indoor SHIP has {n} ids; indoor is not selectable")
    for label, n in (("lesson", 4), ("beginner", 6), ("intermediate", 6), ("advanced", 4)):
        got = ship.get(label) or []
        if len(got) != n:
            errs.append(f"SHIP {label} {len(got)} != {n}")
    jo = ship.get("jump_off") or {}
    for cid in ("beginner", "intermediate", "advanced"):
        v = jo.get(cid, "")
        if isinstance(v, list):
            if len(v) != 1:
                errs.append(f"SHIP jo {cid} {len(v)} != 1")
        elif not v:
            errs.append(f"SHIP jo {cid} empty")
    for i in ids:
        p = find(i)
        if p is None:
            errs.append(f"missing file {i}")
            continue
        rec = json.loads(p.read_text(encoding="utf-8"))
        cid = rec.get("class_id")
        jo_f = bool(rec.get("jump_off"))
        need = JO_COUNT if jo_f else COUNTS.get(cid, -1)
        if len(rec.get("fences") or []) != need:
            errs.append(f"{i} count {len(rec.get('fences') or [])} != {need}")
        ve = validate_course(rec)
        if ve:
            errs.append(f"{i} {'; '.join(ve[:3])}")
    course_files = [p for p in GAME.rglob("*.json") if p.name not in ("INDEX.json", "SHIP.json")]
    if len(course_files) != len(ids):
        errs.append(f"game/content course files {len(course_files)} != SHIP ids {len(ids)}")
    extra = {p.stem for p in course_files} - set(ids)
    if extra:
        errs.append(f"leftover files {sorted(extra)[:8]}")
    if errs:
        print("FAIL")
        for e in errs:
            print(" ", e)
        return 1
    print(f"PASS  {len(ids)} SHIP ids, {len(course_files)} course files")
    for i in ids:
        print(" ", i)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
