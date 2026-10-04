from pathlib import Path
from collections import Counter
import json

root = Path(r"E:\Workspace\Madison")
print("=== REQUIRED FILES ===")
req = [
    "game/assets/ATTRIBUTION_HARVEST.md",
    "tools/content_factory/HARVEST_REPORT.md",
    "tools/content_factory/HARVEST_CATALOG.json",
    "tools/content_factory/convert_harvest.py",
    "tools/content_factory/make_plates.py",
    "tools/content_factory/validate_content.py",
    "tools/content_factory/STATUS.md",
    "content/README.md",
    "content/courses/INDEX.json",
    "content/rail/michelle.json",
    "content/rail/barn_notes.json",
    "content/fences/catalog.json",
    "game/scripts/content_library.gd",
    "content/meshes/RIDER_HUNT.md",
    "content/meshes/CANDIDATES.json",
]
for r in req:
    print(("OK " if (root / r).exists() else "MISSING"), r)

h = root / "game/assets/textures/harvest"
print("harvest albedo", len(list(h.glob("*_albedo.jpg"))))
print("harvest normal", len(list(h.glob("*_normal.jpg"))))
print("harvest rough", len(list(h.glob("*_rough.jpg"))))
print("proc files", len(list((h / "proc").glob("*.jpg"))))

courses = [p for p in (root / "content/courses").rglob("*.json") if p.name != "INDEX.json"]
print("course json", len(courses))
for cls in ["lesson", "beginner", "intermediate", "advanced"]:
    print(" ", cls, len(list((root / "content/courses" / cls).glob("*.json"))))
for cls in ["beginner", "intermediate", "advanced"]:
    d = root / "content/courses" / "jump_off" / cls
    print("  jo", cls, len(list(d.glob("*.json"))) if d.exists() else 0)

m = json.loads((root / "content/rail/michelle.json").read_text(encoding="utf-8"))
print("michelle lines", len(m["lines"]), "unique", len({x["text"] for x in m["lines"]}))
c = Counter(x["key"] for x in m["lines"])
existing = [
    "early", "spot", "deep", "chip", "looked", "wrong", "rail", "refuse",
    "off_course", "three", "time", "lesson_start", "jump_off", "clear",
    "ribbon", "steady", "walk_out", "halt", "pat", "straight", "leave",
]
new = [
    "half_halt", "crooked", "long_spot", "short_spot", "related_in", "related_out",
    "looky_flower", "oxer", "first_fence", "last_fence", "whoa", "walk_first",
    "sit", "eyes_up", "confidence_low", "he's_with_you", "don't_chase",
]
print("min existing variants", min(c[k] for k in existing))
print("min new variants", min(c[k] for k in new))
over = [x["id"] for x in m["lines"] if len(x["text"].replace("—", " ").split()) > 14]
print("lines over 14 words", len(over))

bn = json.loads((root / "content/rail/barn_notes.json").read_text(encoding="utf-8"))
print("barn notes", len(bn["notes"]))
fc = json.loads((root / "content/fences/catalog.json").read_text(encoding="utf-8"))
print("fence recipes", len(fc["recipes"]))

cand = json.loads((root / "content/meshes/CANDIDATES.json").read_text(encoding="utf-8"))
print("saddle ranked", len(cand["saddle"]), "rider ranked", len(cand["rider"]))
print("quota", cand["quota"])
raw = root / "content/meshes/raw"
print("raw mesh slugs", sorted(p.name for p in raw.iterdir() if p.is_dir()))
for p in raw.iterdir():
    if p.is_dir():
        glbs = list(p.glob("*.glb")) + list(p.glob("*.zip"))
        print(" ", p.name, [x.name for x in glbs])
