"""Named hunter fence recipes. All map to vertical | oxer | flower."""
from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "content" / "fences" / "catalog.json"


def rec(
    ident: str,
    name: str,
    kind: str,
    h_min: float,
    h_max: float,
    sp_min: float,
    sp_max: float,
    filler: str,
    looky: bool,
    notes: str,
) -> dict:
    return {
        "id": ident,
        "name": name,
        "kind": kind,
        "h_min": h_min,
        "h_max": h_max,
        "sp_min": sp_min,
        "sp_max": sp_max,
        "filler": filler,
        "looky": looky,
        "notes": notes,
    }


RECIPES = [
    rec("white_vertical_poles", "white vertical", "vertical", 0.40, 0.52, 0.0, 0.0, "none", False, "Lesson pole. Teaching stripe lives in the lesson, not here."),
    rec("white_vertical_23", "white vertical", "vertical", 0.58, 0.70, 0.0, 0.0, "none", False, "Crossrails / Welcome Stake."),
    rec("white_vertical_26", "white vertical", "vertical", 0.72, 0.86, 0.0, 0.0, "none", False, "Schooling jumpers."),
    rec("white_vertical_30", "white vertical", "vertical", 0.84, 0.96, 0.0, 0.0, "none", False, "Open jumpers / Mini Prix."),
    rec("natural_vertical_23", "natural vertical", "vertical", 0.58, 0.70, 0.0, 0.0, "none", False, "Unpainted rail. Same leave."),
    rec("natural_vertical_26", "natural vertical", "vertical", 0.72, 0.88, 0.0, 0.0, "none", False, "Unpainted rail at 2'6\"."),
    rec("plank_vertical_23", "plank vertical", "vertical", 0.58, 0.70, 0.0, 0.0, "plank", False, "Plank filler. Solid face, quiet leave."),
    rec("plank_vertical_26", "plank vertical", "vertical", 0.72, 0.88, 0.0, 0.0, "plank", False, "Plank filler at 2'6\"."),
    rec("plank_vertical_30", "plank vertical", "vertical", 0.84, 0.96, 0.0, 0.0, "plank", False, "Plank filler at 3'0\"."),
    rec("brush_vertical_23", "brush vertical", "vertical", 0.58, 0.70, 0.0, 0.0, "brush", True, "Brush in front. He may look. Straight."),
    rec("brush_vertical_26", "brush vertical", "vertical", 0.72, 0.88, 0.0, 0.0, "brush", True, "Brush vertical, schooling."),
    rec("brush_vertical_30", "brush vertical", "vertical", 0.84, 0.96, 0.0, 0.0, "brush", True, "Brush at Mini Prix height."),
    rec("gate_vertical_23", "gate vertical", "vertical", 0.58, 0.68, 0.0, 0.0, "gate", False, "Hunter gate filler. Still a vertical."),
    rec("gate_vertical_26", "gate vertical", "vertical", 0.72, 0.86, 0.0, 0.0, "gate", False, "Gate at 2'6\"."),
    rec("navy_vertical_23", "navy vertical", "vertical", 0.58, 0.70, 0.0, 0.0, "none", False, "Show pole. Same fence."),
    rec("navy_vertical_26", "navy vertical", "vertical", 0.72, 0.88, 0.0, 0.0, "none", False, "Show pole, Classic."),
    rec("red_vertical_26", "red vertical", "vertical", 0.72, 0.88, 0.0, 0.0, "none", False, "Show stripe. Don't ride the color."),
    rec("red_vertical_30", "red vertical", "vertical", 0.84, 0.96, 0.0, 0.0, "none", False, "Mini Prix stripe."),
    rec("brush_oxer_23", "brush oxer", "oxer", 0.60, 0.70, 0.28, 0.50, "brush", True, "First oxer. Square. Don't chip the back rail."),
    rec("brush_oxer_26", "brush oxer", "oxer", 0.74, 0.88, 0.40, 0.70, "brush", True, "Classic oxer."),
    rec("brush_oxer_30", "brush oxer", "oxer", 0.86, 0.96, 0.55, 0.85, "brush", True, "Mini Prix oxer."),
    rec("plank_oxer_23", "plank oxer", "oxer", 0.60, 0.70, 0.28, 0.50, "plank", False, "Square oxer, plank face."),
    rec("plank_oxer_26", "plank oxer", "oxer", 0.74, 0.88, 0.40, 0.70, "plank", False, "Schooling oxer."),
    rec("plank_oxer_30", "plank oxer", "oxer", 0.86, 0.96, 0.55, 0.85, "plank", False, "Open oxer."),
    rec("gate_oxer_23", "gate oxer", "oxer", 0.60, 0.70, 0.30, 0.50, "gate", False, "Gate in front, oxer behind."),
    rec("gate_oxer_26", "gate oxer", "oxer", 0.74, 0.88, 0.42, 0.70, "gate", False, "Classic gate oxer."),
    rec("gate_oxer_30", "gate oxer", "oxer", 0.86, 0.96, 0.55, 0.85, "gate", False, "Mini Prix gate oxer."),
    rec("white_oxer_23", "white oxer", "oxer", 0.60, 0.70, 0.28, 0.48, "none", False, "Plain white oxer."),
    rec("white_oxer_26", "white oxer", "oxer", 0.74, 0.88, 0.40, 0.68, "none", False, "Plain oxer, 2'6\"."),
    rec("white_oxer_30", "white oxer", "oxer", 0.86, 0.96, 0.55, 0.82, "none", False, "Plain oxer, 3'0\"."),
    rec("navy_oxer_26", "navy oxer", "oxer", 0.74, 0.88, 0.42, 0.70, "none", False, "Show oxer."),
    rec("red_oxer_30", "red oxer", "oxer", 0.86, 0.96, 0.55, 0.85, "none", False, "Show oxer, Mini Prix."),
    rec("flower_box_23", "flower box", "flower", 0.58, 0.68, 0.0, 0.0, "flower box", True, "He looks. Straight and quiet."),
    rec("flower_box_26", "flower box", "flower", 0.72, 0.86, 0.0, 0.0, "flower box", True, "Flower at Classic height."),
    rec("flower_box_30", "flower box", "flower", 0.84, 0.94, 0.0, 0.0, "flower box", True, "Flower at Mini Prix height."),
    rec("flower_white_23", "white flower", "flower", 0.58, 0.68, 0.0, 0.0, "flower box", True, "White box, same look."),
    rec("first_fence_white", "white vertical", "vertical", 0.58, 0.84, 0.0, 0.0, "none", False, "First fence. Long approach. Don't move."),
    rec("last_fence_oxer", "brush oxer", "oxer", 0.64, 0.92, 0.35, 0.80, "brush", False, "Last oxer. Don't throw it away."),
    rec("related_in_vertical", "white vertical", "vertical", 0.58, 0.90, 0.0, 0.0, "none", False, "In of a related. Don't move."),
    rec("related_out_oxer", "plank oxer", "oxer", 0.62, 0.94, 0.32, 0.80, "plank", False, "Out of a related. Sit. Let him jump it."),
    rec("related_out_vertical", "white vertical", "vertical", 0.58, 0.92, 0.0, 0.0, "none", False, "Out of a related vertical."),
    rec("rollback_vertical", "natural vertical", "vertical", 0.72, 0.92, 0.0, 0.0, "none", False, "Rollback fence. Sit, turn, wait."),
    rec("long_approach_oxer", "brush oxer", "oxer", 0.74, 0.94, 0.45, 0.82, "brush", False, "Long approach oxer. Half-halt, then leave."),
    rec("short_turn_vertical", "plank vertical", "vertical", 0.72, 0.90, 0.0, 0.0, "plank", False, "After a turn. Straighten before you ask."),
    rec("looky_brush_23", "brush vertical", "vertical", 0.58, 0.68, 0.0, 0.0, "brush", True, "Looky brush. Eyes up. Don't drop him."),
    rec("looky_flower_first", "flower box", "flower", 0.58, 0.70, 0.0, 0.0, "flower box", True, "Flower as a first fence. Walk the line first."),
    rec("gate_plank_vertical", "gate vertical", "vertical", 0.72, 0.90, 0.0, 0.0, "gate", False, "Gate slats. Same vertical."),
    rec("natural_oxer_26", "natural oxer", "oxer", 0.74, 0.88, 0.40, 0.68, "none", False, "Unpainted oxer."),
    rec("natural_oxer_30", "natural oxer", "oxer", 0.86, 0.96, 0.55, 0.82, "none", False, "Unpainted oxer at 3'0\"."),
    rec("lesson_crossrail", "white vertical", "vertical", 0.40, 0.58, 0.0, 0.0, "none", False, "Crossrail height. Still a leave."),
]


def main() -> int:
    OUT.parent.mkdir(parents=True, exist_ok=True)
    payload = {
        "voice": "HUD names stay quiet. Next  4  ·  brush oxer. Never invent a fourth kind.",
        "kinds": ["vertical", "oxer", "flower"],
        "fillers": ["none", "brush", "plank", "gate", "flower box"],
        "recipes": RECIPES,
    }
    OUT.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
    print(f"wrote {len(RECIPES)} fence recipes -> {OUT}")
    return 0 if len(RECIPES) >= 40 else 1


if __name__ == "__main__":
    sys.exit(main())
