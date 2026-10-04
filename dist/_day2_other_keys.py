"""Dump the 192 Michelle lines that were not in yesterday's nine-key pass."""
import json
from pathlib import Path

data = json.loads(Path("game/content/rail/michelle_ship.json").read_text(encoding="utf-8"))
done = {"early", "deep", "chip", "spot", "leave", "straight", "looked", "wrong", "halt"}
keys = []
for row in data["lines"]:
    if row["key"] not in done and row["key"] not in keys:
        keys.append(row["key"])
out = []
for key in keys:
    rows = [row for row in data["lines"] if row["key"] == key]
    out.append(f"## {key} {len(rows)}")
    for row in rows:
        out.append(f"{row['id']}\t{row['text']}")
Path("dist/_day2_other_keys.txt").write_text("\n".join(out) + "\n", encoding="utf-8")
print("keys", keys, "lines", sum(1 for row in data["lines"] if row["key"] not in done))
