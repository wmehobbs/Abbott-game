"""Python smoke of 80 SHIP + high-score courses. No Godot window."""
from __future__ import annotations

import json
import sys
from pathlib import Path

from rules import validate_course

ROOT = Path(__file__).resolve().parents[2]
COURSES = ROOT / "content" / "courses"
SHIP = COURSES / "SHIP.json"
SCORES = COURSES / "SCORES.jsonl"
OUT = Path(__file__).resolve().parent / "smoke_results.json"


def load_rec(cid: str) -> dict | None:
    for p in COURSES.rglob(f"{cid}.json"):
        if p.name in ("INDEX.json", "SHIP.json"):
            continue
        return json.loads(p.read_text(encoding="utf-8"))
    return None


def ship_ids(ship: dict) -> list[str]:
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


def main() -> int:
    need = 80
    qpath = Path(__file__).resolve().parent / "MEGA_QUOTAS.json"
    if qpath.exists():
        need = int(json.loads(qpath.read_text(encoding="utf-8")).get("smoke", 80))
    ids: list[str] = []
    if SHIP.exists():
        ids.extend(ship_ids(json.loads(SHIP.read_text(encoding="utf-8"))))
    if SCORES.exists():
        for line in SCORES.read_text(encoding="utf-8").splitlines():
            if not line.strip():
                continue
            row = json.loads(line)
            i = str(row.get("id", ""))
            if i and i not in ids:
                ids.append(i)
            if len(ids) >= need:
                break
    ids = ids[:need]
    rows = []
    ok = 0
    for i in ids:
        rec = load_rec(i)
        if rec is None:
            rows.append({"id": i, "ok": False, "err": "missing"})
            continue
        errs = validate_course(rec)
        if errs:
            rows.append({"id": i, "ok": False, "err": "; ".join(errs[:4])})
            continue
        rows.append({
            "id": i,
            "ok": True,
            "class": rec.get("class_id"),
            "n": len(rec.get("fences") or []),
            "indoor": rec.get("ring") == "indoor",
            "jump_off": bool(rec.get("jump_off")),
        })
        ok += 1
        print(f"  OK  {i:24s}  n={len(rec['fences'])}  {rec.get('class_id')}")
    passed = ok >= min(80, len(ids)) and ok >= 1 and all(r["ok"] for r in rows)
    # If we have fewer than 80 yet, pass only the ones we have; mega validator wants 80.
    payload = {"ok": ok, "n": len(ids), "pass": ok >= need and all(r["ok"] for r in rows), "rows": rows}
    OUT.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
    print(f"smoke {ok}/{len(ids)} pass={payload['pass']}")
    return 0 if payload["pass"] else 1


if __name__ == "__main__":
    sys.exit(main())
