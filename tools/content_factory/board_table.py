"""Render the board out of dist/ridecert_results.json — no hand-typed times."""
from __future__ import annotations

import json
import pathlib
import sys

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

ROOT = pathlib.Path(__file__).resolve().parents[2]
SRC = ROOT / "dist" / "ridecert_results.json"

ALLOWED = {"lesson": None, "beginner": 100.0, "intermediate": 90.0, "advanced": 80.0}


def allowed(row: dict) -> float | None:
    t = ALLOWED.get(str(row.get("class_id")))
    if t is None:
        return None
    if row.get("jump_off"):
        return max(28.0, t * 0.42)
    return t


def why(row: dict) -> str:
    if row.get("success"):
        return "—"
    bits = []
    if not row.get("round_complete"):
        bits.append("did not finish (%d/%d)" % (row["fences_jumped"], row["fences_needed"]))
    if row.get("eliminated"):
        bits.append("eliminated %s" % row.get("eliminate_reason"))
    rails = int(row.get("rails", 0))
    refs = len(row.get("refused") or [])
    if rails:
        bits.append("%d rail%s" % (rails, "" if rails == 1 else "s"))
    if refs:
        bits.append("%d refusal%s" % (refs, "" if refs == 1 else "s"))
    a = allowed(row)
    if a is not None and float(row["time_sec"]) > a:
        over = int((float(row["time_sec"]) - a) // 4)
        if over > 0:
            bits.append("%d time fault%s (allowed %.0f s)" % (over, "" if over == 1 else "s", a))
    return ", ".join(bits) or "faults %s" % row.get("faults")


def main() -> None:
    rep = json.loads(SRC.read_text(encoding="utf-8"))
    print("| id | result | faults | jumped | time_s | allowed | why |")
    print("| --- | --- | --- | --- | --- | --- | --- |")
    for row in rep.get("tracks", []):
        a = allowed(row)
        print("| %s | %s | %s | %d/%d | %.1f | %s | %s |" % (
            row["id"],
            "CLEAR" if row["success"] else "fail",
            row["faults"],
            row["fences_jumped"], row["fences_needed"],
            float(row["time_sec"]),
            "—" if a is None else "%.0f" % a,
            why(row),
        ))
    print()
    print("board %s  pass=%s" % (rep.get("board"), rep.get("pass")))
    for row in rep.get("style", []):
        print("style %s %s faults=%s refused=%s rails=%s t=%.1f teleported=%s" % (
            row.get("style"), "PASS" if row["success"] else "FAIL",
            row["faults"], row["refused"], row["rails"],
            float(row["time_sec"]), row["teleported"],
        ))
    tp = [r for r in rep.get("tracks", []) + rep.get("style", []) if r.get("teleported")]
    print("teleported rounds:", len(tp))


if __name__ == "__main__":
    sys.exit(main())
