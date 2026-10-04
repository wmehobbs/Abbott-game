import json
from pathlib import Path
from collections import defaultdict
COURSES = Path("content/courses")

def grams(text, n=12):
    w = text.replace("—", " ").split()
    if len(w) < n:
        return []
    return [" ".join(w[i:i+n]).lower() for i in range(len(w)-n+1)]

gmap = defaultdict(list)
for p in COURSES.rglob("*.json"):
    if p.name in ("INDEX.json", "SHIP.json"):
        continue
    rec = json.loads(p.read_text(encoding="utf-8"))
    for g in grams(str(rec.get("walk_text",""))):
        gmap[g].append(rec["id"])
clash = [(g, ids) for g, ids in gmap.items() if len(set(ids))>1]
print("walk clashes", len(clash))
if clash:
    print(clash[0])
print("sample walk", json.loads((COURSES/"advanced/hk_adv_001.json").read_text())["walk_text"])
print("wc", len(json.loads((COURSES/"advanced/hk_adv_001.json").read_text())["walk_text"].split()))
