import json, shutil
from pathlib import Path
from score_courses import copy_into_game, load_all

ROOT = Path(__file__).resolve().parents[2]
ship = json.loads((ROOT / "content/courses/SHIP.json").read_text(encoding="utf-8"))
allc = load_all()
by_id = {r["id"]: r for r in allc}
copy_into_game(ship, by_id)
print("copied", len(by_id), "ship keys", list(ship.keys()))
