"""Prize lists, HUD class cards, pedagogy, and 120 fence recipes."""
from __future__ import annotations

import json
import sys
from pathlib import Path

from make_fences import RECIPES as BASE_RECIPES, rec as fence_rec

ROOT = Path(__file__).resolve().parents[2]
COPY = ROOT / "content" / "copy"
PED = ROOT / "content" / "pedagogy"
FENCES = ROOT / "content" / "fences" / "catalog.json"
QUOTAS = Path(__file__).resolve().parent / "MEGA_QUOTAS.json"


def load_need(key: str, default: int) -> int:
    if QUOTAS.exists():
        q = json.loads(QUOTAS.read_text(encoding="utf-8"))
        return int(q.get(key, default))
    return default


def prize_pages(n: int) -> list[dict]:
    classes = [
        ("Welcome Stake", "beginner", '2\'3"', "Table A. Eight fences. Time allowed from the path at 350 mpm."),
        ("Classic", "intermediate", '2\'6"', "Table A. Ten fences. A related and a rollback."),
        ("Hidden K Mini Prix", "advanced", '3\'0"', "Table A. Twelve fences. Don't chase the clock."),
        ("Schooling card", "beginner", '2\'3"', "Schooling. Same track as the Welcome Stake. Rails down stay down."),
        ("Schooling card", "intermediate", '2\'6"', "Schooling jumpers. Classic height. Same leave as Tuesday."),
        ("Schooling card", "advanced", '3\'0"', "Open schooling. Mini Prix height. Walk it first."),
        ("Lesson card", "lesson", "poles to 2'3\"", "Lesson. Walk him first. Three fences. Related if it fits."),
    ]
    pages = []
    for i in range(n):
        name, cid, h, blurb = classes[i % len(classes)]
        day = ["Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"][i % 5]
        pages.append({
            "id": f"pl_{i+1:03d}",
            "title": name if i < 3 else f"{name} {i+1}",
            "class_id": cid,
            "height": h,
            "table": "A",
            "day": day,
            "barn": "Hidden K, Pfafftown",
            "text": f"{blurb} Hidden K. {day}. One horse. Abbott.",
            "pace_mpm": 350,
            "kind": "show" if name in ("Welcome Stake", "Classic", "Hidden K Mini Prix") and i < 12 else "schooling",
        })
    return pages


def class_cards(n: int) -> list[dict]:
    rows = [
        ("lesson", "Lesson", "poles to 2'3\"", "Walk first. Then the canter."),
        ("beginner", "Welcome Stake", '2\'3"', "Eight. Outside track. Quiet to one."),
        ("intermediate", "Classic", '2\'6"', "Ten. Related. Don't chase the out."),
        ("advanced", "Hidden K Mini Prix", '3\'0"', "Twelve. Sit the rollback."),
        ("beginner", "Schooling 2'3\"", '2\'3"', "Same leave as the class."),
        ("intermediate", "Schooling 2'6\"", '2\'6"', "Classic height. School what you need."),
        ("advanced", "Schooling 3'0\"", '3\'0"', "Mini Prix height. Walk it."),
        ("beginner", "Jump-off", '2\'3"', "Four. Don't throw the first away."),
        ("intermediate", "Jump-off", '2\'6"', "Four. Inside turn if it fits."),
        ("advanced", "Jump-off", '3\'0"', "Four. The clock is enough."),
    ]
    cards = []
    for i in range(n):
        cid, title, h, line = rows[i % len(rows)]
        cards.append({
            "id": f"cc_{i+1:03d}",
            "class_id": cid,
            "title": title,
            "height": h,
            "hud": line,
            "table": "A",
        })
    return cards


def extra_fences(need: int) -> list[dict]:
    out = list(BASE_RECIPES)
    fillers = ["none", "brush", "plank", "gate", "flower box"]
    kinds = ["vertical", "oxer", "flower"]
    bands = [
        (0.40, 0.64, 0.0, 0.0, "lesson"),
        (0.58, 0.70, 0.28, 0.50, "beginner"),
        (0.72, 0.90, 0.40, 0.70, "intermediate"),
        (0.84, 0.96, 0.55, 0.85, "advanced"),
    ]
    names = {
        "vertical": ["white vertical", "natural vertical", "plank vertical", "brush vertical", "gate vertical", "navy vertical"],
        "oxer": ["white oxer", "brush oxer", "plank oxer", "gate oxer", "natural oxer", "navy oxer"],
        "flower": ["flower box", "white flower", "brush flower"],
    }
    i = 0
    while len(out) < need:
        kind = kinds[i % 3]
        fill = fillers[i % len(fillers)]
        if kind == "flower":
            fill = "flower box"
        hlo, hhi, slo, shi, band = bands[i % 4]
        if kind != "oxer":
            slo = shi = 0.0
        if kind == "oxer" and band == "lesson":
            i += 1
            continue
        nm = names[kind][i % len(names[kind])]
        ident = f"mega_{kind}_{band}_{i:03d}"
        out.append(fence_rec(
            ident, nm, kind, hlo, hhi, slo, shi, fill,
            kind in ("flower",) or fill == "brush",
            f"{band} {nm}. Same leave. Still a {kind}.",
        ))
        i += 1
        if i > need * 4:
            break
    return out[:need]


def related_table() -> dict:
    """Legal 1/2/3 stride at 3.20 / 3.35 / 3.50 m canter."""
    rows = []
    for stride in (3.20, 3.35, 3.50):
        for n in (1, 2, 3):
            # takeoff+landing ~ 2.55*2, remaining n strides
            # Hidden K labeled bands: 1: 7.0-7.8, 2: 10.4-11.2, 3: 14.0-15.2
            # Base formula: 2*takeoff + n*stride, takeoff 2.55 → 5.1 + n*stride
            dist = round(5.10 + n * stride, 2)
            why = {
                1: "He leaves off the one-stride if you don't pick. Sit.",
                2: "Two strides. Don't move on the in. The out is already there.",
                3: "Three. Hold the canter you have. Don't invent a fourth.",
            }[n]
            if stride < 3.30:
                why = "Shorter canter. He leaves a little quieter. Don't chase."
            elif stride > 3.40:
                why = "Bigger canter. He'll leave out if you wait. Go with him."
            rows.append({
                "strides": n,
                "canter_m": stride,
                "distance_m": dist,
                "band": {1: [7.0, 7.8], 2: [10.4, 11.2], 3: [14.0, 15.2]}[n],
                "why": why,
            })
    return {"pace_note": "350 mpm show. Schooling is the same leave, a little more time.", "rows": rows}


def related_md(data: dict) -> str:
    lines = [
        "# Related distances at Hidden K",
        "",
        "Labeled 1 / 2 / 3 stride only. Outdoor bands from the ring facts.",
        "Takeoff 2.55 m. Canter 3.20 / 3.35 / 3.50. Why he leaves is the last column.",
        "",
        "| strides | canter (m) | distance (m) | band | why the horse leaves |",
        "| --- | --- | --- | --- | --- |",
    ]
    for r in data["rows"]:
        band = f"{r['band'][0]}–{r['band'][1]}"
        lines.append(f"| {r['strides']} | {r['canter_m']:.2f} | {r['distance_m']:.2f} | {band} | {r['why']} |")
    lines += ["", data["pace_note"], ""]
    return "\n".join(lines)


def table_a() -> dict:
    return {
        "name": "Table A",
        "barn": "Hidden K, Pfafftown",
        "classes": {
            "beginner": {"show_name": "Welcome Stake", "height": "2'3\"", "fences": 8, "time_school": 100.0, "time_show": 95.0},
            "intermediate": {"show_name": "Classic", "height": "2'6\"", "fences": 10, "time_school": 90.0, "time_show": 85.0},
            "advanced": {"show_name": "Hidden K Mini Prix", "height": "3'0\"", "fences": 12, "time_school": 80.0, "time_show": 75.0},
            "lesson": {"show_name": "Lesson", "height": "poles to 2'3\"", "fences": 3, "time_school": 180.0, "time_show": 180.0},
        },
        "faults": {
            "rail": 4,
            "refusal": 4,
            "time": "1 per second over time allowed, show only",
            "three_refusals": "elimination",
            "off_course": "elimination",
            "fall": "not modeled; we don't joke about it",
        },
        "jump_off": {
            "fences": 4,
            "indoor_fences": 3,
            "time": "tighter; don't chase",
            "offered": "clear first round, show only",
        },
        "pace_mpm": 350,
        "kinds": ["vertical", "oxer", "flower"],
        "notes": "Table A as the live game already runs it. No new rules.",
    }


def main() -> int:
    COPY.mkdir(parents=True, exist_ok=True)
    PED.mkdir(parents=True, exist_ok=True)
    n_prize = load_need("prize_list", 40)
    n_cards = load_need("class_cards", 30)
    n_fence = load_need("fence_recipes", 120)
    pages = prize_pages(n_prize)
    (COPY / "prize_list.json").write_text(json.dumps({"pages": pages}, indent=2) + "\n", encoding="utf-8")
    cards = class_cards(n_cards)
    (COPY / "class_cards.json").write_text(json.dumps({"cards": cards}, indent=2) + "\n", encoding="utf-8")
    rel = related_table()
    (PED / "related_distances.json").write_text(json.dumps(rel, indent=2) + "\n", encoding="utf-8")
    (PED / "related_distances.md").write_text(related_md(rel), encoding="utf-8")
    (PED / "table_a.json").write_text(json.dumps(table_a(), indent=2) + "\n", encoding="utf-8")
    recipes = extra_fences(n_fence)
    FENCES.parent.mkdir(parents=True, exist_ok=True)
    FENCES.write_text(json.dumps({
        "voice": "HUD names stay quiet. Next  4  ·  brush oxer. Never invent a fourth kind.",
        "kinds": ["vertical", "oxer", "flower"],
        "fillers": ["none", "brush", "plank", "gate", "flower box"],
        "recipes": recipes,
    }, indent=2) + "\n", encoding="utf-8")
    print("prize", len(pages), "cards", len(cards), "fences", len(recipes))
    return 0


if __name__ == "__main__":
    sys.exit(main())
