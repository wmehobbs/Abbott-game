"""Dump the nine coaching keys, one line each. Read-only."""
import json
from pathlib import Path

data = json.loads(
    Path("game/content/rail/michelle_ship.json").read_text(encoding="utf-8")
)
keys = [
    "early",
    "deep",
    "chip",
    "spot",
    "leave",
    "straight",
    "looked",
    "wrong",
    "halt",
]
out = Path("dist/_michelle_nine.txt")
chunks = []
for key in keys:
    rows = [row for row in data["lines"] if row["key"] == key]
    chunks.append(f"## {key} {len(rows)}")
    for row in rows:
        chunks.append(f"{row['id']}\t{row['text']}")
out.write_text("\n".join(chunks) + "\n", encoding="utf-8")
print(out, "lines", len(chunks))
