"""Mark Michelle ship lines that do not name the event. Read-only."""
import json
from collections import Counter
from pathlib import Path

data = json.loads(
    Path("game/content/rail/michelle_ship.json").read_text(encoding="utf-8")
)
lines = data["lines"]
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
need = {
    "early": ["early", "too soon", "a stride too soon"],
    "deep": ["deep", "late"],
    "chip": ["chip"],
    "spot": ["spot"],
    "leave": ["leave", "release"],
    "straight": ["straight"],
    "looked": ["look"],
    "wrong": ["wrong"],
    "halt": ["halt", "stop"],
}
c = Counter(row["key"] for row in lines)
print("count", len(lines))
print("keys", dict(c))
print("extra", sorted(set(c) - set(keys)))
out = []
for key in keys:
    rows = [row for row in lines if row["key"] == key]
    weak = []
    longish = []
    for row in rows:
        text = row["text"]
        low = text.lower()
        named = any(word in low for word in need[key])
        words = len(text.replace("—", " ").replace("-", " ").split())
        sentences = text.count(".") + text.count("!") + text.count("?")
        if not named:
            weak.append((row["id"], words, text))
        if words > 14 or sentences > 1:
            longish.append((row["id"], words, sentences, text))
    print(f"## {key} n={len(rows)} weak={len(weak)} long={len(longish)}")
    for item in weak:
        print("WEAK", key, item[0], item[1], item[2])
    for item in longish:
        print("FORM", key, item[0], item[1], item[2], item[3])
    out.append((key, len(rows), len(weak)))
print("SUMMARY", out)
