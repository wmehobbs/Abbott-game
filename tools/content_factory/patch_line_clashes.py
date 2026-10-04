"""Move later fences 2 m toward x=0 when they sit on an earlier approach line."""
from __future__ import annotations

import json
import math
import pathlib
import shutil

ROOT = pathlib.Path(__file__).resolve().parents[2]
GAME = ROOT / "game" / "content" / "courses"
PILE = ROOT / "content" / "courses"


def folder(i: str) -> str:
    if i.startswith("hk_les"):
        return "lesson"
    if i.startswith("hk_beg"):
        return "beginner"
    if i.startswith("hk_int"):
        return "intermediate"
    if i.startswith("hk_adv"):
        return "advanced"
    if "jo_beg" in i:
        return "jump_off/beginner"
    if "jo_int" in i:
        return "jump_off/intermediate"
    return "jump_off/advanced"


def yawdir(y: float) -> tuple[float, float]:
    return math.sin(y), math.cos(y)


def dist(a: dict, b: dict) -> float:
    return math.hypot(a["pos"][0] - b["pos"][0], a["pos"][2] - b["pos"][2])


def patch(cid: str) -> list[str]:
    rel = folder(cid) + f"/{cid}.json"
    path = GAME / rel
    course = json.loads(path.read_text(encoding="utf-8"))
    fs = course["fences"]
    by = {int(f["num"]): f for f in fs}
    moved: set[int] = set()
    notes: list[str] = []
    for a in fs:
        ax, az = a["pos"][0], a["pos"][2]
        dx, dz = yawdir(float(a["yaw"]))
        for b in fs:
            if a["num"] == b["num"]:
                continue
            if abs(int(a["num"]) - int(b["num"])) == 1:
                continue
            bx, bz = b["pos"][0], b["pos"][2]
            along = (bx - ax) * dx + (bz - az) * dz
            lat = abs((bx - ax) * (-dz) + (bz - az) * dx)
            if not (0.8 < along < 13.0 and lat < 2.6):
                continue
            # Move the later fence toward center.
            later = b if int(b["num"]) > int(a["num"]) else a
            n = int(later["num"])
            if n in moved:
                continue
            oldx = float(later["pos"][0])
            if abs(oldx) < 4.2:
                continue
            newx = oldx - 2.0 * math.copysign(1.0, oldx)
            if abs(newx) < 4.0:
                newx = math.copysign(4.0, oldx)
            later["pos"][0] = round(newx, 3)
            moved.add(n)
            notes.append(f"{cid} #{n} x {oldx:.2f}->{newx:.2f} off #{a['num']} line")
    if not moved:
        return notes
    # Recompute related distance_m.
    for f in fs:
        relp = f.get("related")
        if not isinstance(relp, dict):
            continue
        to = int(relp.get("to", 0))
        if to not in by:
            continue
        relp["distance_m"] = round(dist(f, by[to]), 2)
    text = json.dumps(course, indent=2) + "\n"
    path.write_text(text, encoding="utf-8")
    pile = PILE / rel
    if pile.exists():
        shutil.copy2(path, pile)
    return notes


def main() -> None:
    ship = json.loads((GAME / "SHIP.json").read_text(encoding="utf-8"))
    ids = []
    for k in ("intermediate", "advanced"):
        ids += ship[k]
    ids += list(ship["jump_off"].values())
    for i in ids:
        for n in patch(i):
            print(n)


if __name__ == "__main__":
    main()
