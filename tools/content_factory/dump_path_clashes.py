"""Land-to-setup path vs other standards for remaining SHIP tracks."""
from __future__ import annotations

import json
import math
import pathlib

ROOT = pathlib.Path(__file__).resolve().parents[2]
GAME = ROOT / "game" / "content" / "courses"
TAKEOFF = 2.55
SETUP = 10.0
IDS = [
    "hk_int_001",
    "hk_int_005",
    "hk_int_009",
    "hk_adv_001",
    "hk_adv_002",
    "hk_adv_003",
    "hk_adv_005",
    "hk_jo_beg_001",
    "hk_jo_adv_001",
]


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


def closest(a, b, p) -> tuple[float, float]:
    ax, az = a
    bx, bz = b
    px, pz = p
    abx, abz = bx - ax, bz - az
    lab2 = abx * abx + abz * abz
    if lab2 < 1e-6:
        return math.hypot(px - ax, pz - az), 0.0
    t = max(0.0, min(1.0, ((px - ax) * abx + (pz - az) * abz) / lab2))
    cx, cz = ax + abx * t, az + abz * t
    return math.hypot(px - cx, pz - cz), t


def load(i: str) -> dict:
    return json.loads((GAME / folder(i) / f"{i}.json").read_text(encoding="utf-8"))


def main() -> None:
    for i in IDS:
        c = load(i)
        fs = c["fences"]
        print(f"\n{i}  n={len(fs)}")
        for f in fs:
            print(
                f"  #{f['num']:2d} {f['kind'][:3]}  ({f['pos'][0]:7.2f},{f['pos'][2]:7.2f})  "
                f"yaw={float(f['yaw']):.2f}  rel={f.get('related')}"
            )
        for a, b in zip(fs, fs[1:]):
            ax, az = float(a["pos"][0]), float(a["pos"][2])
            bx, bz = float(b["pos"][0]), float(b["pos"][2])
            adx, adz = yawdir(float(a["yaw"]))
            bdx, bdz = yawdir(float(b["yaw"]))
            land = (ax + adx * TAKEOFF, az + adz * TAKEOFF)
            setup = (bx - bdx * SETUP, bz - bdz * SETUP)
            mag = math.hypot(bx - ax, bz - az)
            leave_dot = ((bx - ax) * adx + (bz - az) * adz) / mag if mag else 1.0
            turn = math.degrees(math.acos(max(-1.0, min(1.0, leave_dot))))
            hits = []
            for o in fs:
                if o["num"] in (a["num"], b["num"]):
                    continue
                d, t = closest(land, setup, (float(o["pos"][0]), float(o["pos"][2])))
                ox, oz = float(o["pos"][0]), float(o["pos"][2])
                through = abs((ox - land[0]) * bdx + (oz - land[1]) * bdz)  # not quite
                # oriented vs blocker yaw
                odx, odz = yawdir(float(o["yaw"]))
                # closest point
                abx, abz = setup[0] - land[0], setup[1] - land[1]
                lab2 = abx * abx + abz * abz
                tt = t
                cx = land[0] + abx * tt
                cz = land[1] + abz * tt
                rail = abs((cx - ox) * (-odz) + (cz - oz) * odx)
                thru = abs((cx - ox) * odx + (cz - oz) * odz)
                if rail < 2.35 and thru < 1.10:
                    hits.append(f"#{o['num']}@{d:.1f}m rail={rail:.1f} thru={thru:.1f}")
                elif d < 3.2:
                    hits.append(f"#{o['num']} near {d:.1f}m")
            flag = ""
            if turn > 70 and mag < 12:
                flag = " TIGHT"
            if turn > 120 and mag < 16:
                flag = " ROLLBACK"
            extra = ("  HIT " + ", ".join(hits)) if hits else ""
            print(
                f"  {a['num']}->{b['num']}  {mag:5.1f}m turn {turn:5.1f}  "
                f"land=({land[0]:.1f},{land[1]:.1f}) setup=({setup[0]:.1f},{setup[1]:.1f})"
                f"{flag}{extra}"
            )


if __name__ == "__main__":
    main()
