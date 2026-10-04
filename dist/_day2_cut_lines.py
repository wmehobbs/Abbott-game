"""Remove named Michelle ship lines. Do not reorder what stays. No new sentences."""
import json
from pathlib import Path

path = Path("game/content/rail/michelle_ship.json")
raw = path.read_text(encoding="utf-8")
newline = "\r\n" if "\r\n" in raw else "\n"

remove = [
    "early_06",
    "early_08",
    "early_11",
    "early_15",
    "deep_14",
    "chip_08",
    "chip_15",
    "spot_13",
    "straight_15",
    "looked_10",
    "rail_14",
    "refuse_06",
    "off_course_12",
    "lesson_start_08",
    "jump_off_10",
    "ribbon_08",
]

before = json.loads(raw)
before_ids = [row["id"] for row in before["lines"]]
for line_id in remove:
    if before_ids.count(line_id) != 1:
        raise SystemExit(f"id {line_id} count {before_ids.count(line_id)}")

text = raw

def cut_object(text, line_id):
    needle = f'"id": "{line_id}"'
    at = text.find(needle)
    if at < 0:
        raise SystemExit(f"missing {line_id}")
    brace = text.rfind("{", 0, at)
    depth = 0
    j = brace
    while j < len(text):
        c = text[j]
        if c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
            if depth == 0:
                j += 1
                break
        j += 1
    else:
        raise SystemExit(f"unclosed {line_id}")
    k = j
    while k < len(text) and text[k] in " \t":
        k += 1
    if k < len(text) and text[k] == ",":
        k += 1
    if text.startswith("\r\n", k):
        k += 2
    elif k < len(text) and text[k] == "\n":
        k += 1
    line_start = text.rfind("\n", 0, brace) + 1
    return text[:line_start] + text[k:]

for line_id in remove:
    text = cut_object(text, line_id)

after = json.loads(text)
after_ids = [row["id"] for row in after["lines"]]
expect = [line_id for line_id in before_ids if line_id not in set(remove)]
if after_ids != expect:
    raise SystemExit("order changed or an id was lost")

from collections import Counter
counts = Counter(row["key"] for row in after["lines"])
thin = {key: n for key, n in counts.items() if n < 8}
if thin:
    raise SystemExit(f"thin keys {thin}")
for key in ("leave", "wrong", "halt"):
    if counts[key] != 16:
        raise SystemExit(f"{key} changed to {counts[key]}")

texts_before = {row["id"]: row["text"] for row in before["lines"]}
for row in after["lines"]:
    if row["text"] != texts_before[row["id"]]:
        raise SystemExit(f"text changed {row['id']}")

path.write_text(text, encoding="utf-8", newline=newline)
print("removed", len(remove))
print("left", len(after_ids))
print("counts", dict(counts))
