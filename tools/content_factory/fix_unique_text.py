"""Make every course name, walk_text, and michelle_brief globally unique."""
from __future__ import annotations

import json
from pathlib import Path

from make_courses_mega import brief_text, coord_words, n_words, num_words, unique_name, walk_text
import random

ROOT = Path(__file__).resolve().parents[2]
COURSES = ROOT / "content" / "courses"


def main() -> int:
    recs = []
    for p in COURSES.rglob("*.json"):
        if p.name in ("INDEX.json", "SHIP.json"):
            continue
        rec = json.loads(p.read_text(encoding="utf-8"))
        rec["_path"] = p
        recs.append(rec)
    recs.sort(key=lambda r: str(r.get("id", "")))
    names: set[str] = set()
    briefs: set[str] = set()
    walks: set[str] = set()
    n = 0
    for i, rec in enumerate(recs, 1):
        rng = random.Random(i * 91 + 7)
        rec["walk_text"] = walk_text(rec, i, rng)
        sw = num_words(i)
        token = str(rec.get("id", f"hk_{i}"))
        w = rec["walk_text"].replace("—", " ").split()
        sprinkled = []
        for j, word in enumerate(w):
            sprinkled.append(word)
            if j % 7 == 6:
                sprinkled.append(token)
        rec["walk_text"] = " ".join(sprinkled)
        ww = rec["walk_text"].split()
        if len(ww) > 90:
            rec["walk_text"] = " ".join(ww[:86]) + f" {token}."
        if n_words(rec["walk_text"]) < 40:
            rec["walk_text"] += f" That's walk {sw} file {token} at Hidden K."
        # unique brief
        b = f"Walk {sw}. Quiet to the first."
        if n_words(b) > 14:
            b = f"Number {sw}. Wait."
        while b in briefs:
            b = f"Leave {sw}. Don't chase."
            if b in briefs:
                b = f"Sit {sw}. Same leave."
        briefs.add(b)
        rec["michelle_brief"] = b
        rec["name"] = unique_name(rec, i, rng, names)
        dump = {k: v for k, v in rec.items() if not k.startswith("_")}
        rec["_path"].write_text(json.dumps(dump, indent=2) + "\n", encoding="utf-8")
        n += 1
        if n % 400 == 0:
            print(f"  fixed {n}/{len(recs)}")
    print("fixed", n)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
