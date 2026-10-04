"""Kinematic twin of the cert rider. No Godot. Same leave/gait numbers as horse.gd."""
from __future__ import annotations

import json
import math
import pathlib

ROOT = pathlib.Path(__file__).resolve().parents[2]
SHIP = ROOT / "game" / "content" / "courses" / "SHIP.json"
OUT = ROOT / "dist" / "planner"

CANTER_V = 5.55
CANTER_W = 1.08
TURN_SCALE = 0.88 + 44.0 / 400.0  # default rideability
COLLECT_V = CANTER_V * 0.82
COLLECT_W = CANTER_W * TURN_SCALE * 1.14
FREE_W = CANTER_W * TURN_SCALE
TAKEOFF = 2.55
SETUP_BACK = 10.0
LAND_S = 1.55
R_MIN = COLLECT_V / COLLECT_W  # ~3.7 m


def folder(i: str) -> str:
    if i.startswith("hk_les"):
        return "lesson"
    if i.startswith("hk_beg"):
        return "beginner"
    if i.startswith("hk_int"):
        return "intermediate"
    if i.startswith("hk_adv"):
        return "advanced"
    if i.startswith("hk_jo_beg"):
        return "jump_off/beginner"
    if i.startswith("hk_jo_int"):
        return "jump_off/intermediate"
    if i.startswith("hk_jo_adv"):
        return "jump_off/advanced"
    return "?"


def load(i: str) -> dict:
    p = ROOT / "game" / "content" / "courses" / folder(i) / f"{i}.json"
    return json.loads(p.read_text(encoding="utf-8"))


def takeoff_dir(yaw: float) -> tuple[float, float]:
    return math.sin(yaw), math.cos(yaw)


def hypot(a: tuple[float, float], b: tuple[float, float]) -> float:
    return math.hypot(a[0] - b[0], a[1] - b[1])


def plan(course: dict) -> dict:
    fences = course["fences"]
    start = (float(course["start_pos"][0]), float(course["start_pos"][2]))
    finish_z = float(course.get("finish_z", -36.2))
    wps: list[dict] = []
    t = 2.0  # walk-on
    pos = start
    # IN flags
    inn = (0.0, -32.0)
    t += hypot(pos, inn) / CANTER_V
    pos = inn
    wps.append({"kind": "in", "x": inn[0], "z": inn[1], "t": round(t, 2)})
    min_r_need = 0.0
    unrideable: list[str] = []
    for i, f in enumerate(fences):
        yaw = float(f["yaw"])
        dx, dz = takeoff_dir(yaw)
        fp = (float(f["pos"][0]), float(f["pos"][2]))
        take = (fp[0] - dx * TAKEOFF, fp[1] - dz * TAKEOFF)
        setup = (fp[0] - dx * SETUP_BACK, fp[1] - dz * SETUP_BACK)
        setup = (max(-11.5, min(11.5, setup[0])), max(-33.5, min(33.5, setup[1])))
        lat = abs((pos[0] - fp[0]) * (-dz) + (pos[1] - fp[1]) * dx)
        along = (fp[0] - pos[0]) * dx + (fp[1] - pos[1]) * dz
        # Straight related: skip the long setup.
        related = False
        if i > 0:
            prev = fences[i - 1]
            pyaw = float(prev["yaw"])
            pdx, pdz = takeoff_dir(pyaw)
            mag = hypot(
                (float(prev["pos"][0]), float(prev["pos"][2])),
                fp,
            )
            dot = (fp[0] - float(prev["pos"][0])) * dx + (fp[1] - float(prev["pos"][2])) * dz
            if 6.8 <= mag <= 12.2 and mag > 0 and abs(dot / mag) > 0.88:
                related = True
        if (not related) and (lat > 2.0 or along < 8.0):
            d_setup = hypot(pos, setup)
            t += d_setup / COLLECT_V
            # 90° of collected canter as a lower bound on a rollback.
            heading_change = abs(math.atan2(setup[0] - pos[0], setup[1] - pos[1]))
            arc = R_MIN * min(heading_change, math.pi)
            t += arc / COLLECT_V * 0.25
            pos = setup
            wps.append({"kind": "setup", "n": f["num"], "x": setup[0], "z": setup[1], "t": round(t, 2)})
            if heading_change > math.radians(70) and d_setup < 8.0:
                need = d_setup / max(heading_change, 0.2)
                min_r_need = max(min_r_need, need)
                if need + 0.4 < R_MIN and d_setup < 6.0:
                    unrideable.append(f"#{f['num']} rollback {d_setup:.1f}m / {math.degrees(heading_change):.0f}deg")
        t += hypot(pos, take) / CANTER_V
        t += 0.35  # collect last stride
        pos = take
        wps.append({"kind": "takeoff", "n": f["num"], "x": take[0], "z": take[1], "t": round(t, 2)})
        t += 0.70  # jump
        t += LAND_S * 0.35  # sit a beat
        pos = (fp[0] + dx * 2.6, fp[1] + dz * 2.6)
        wps.append({"kind": "land", "n": f["num"], "x": pos[0], "z": pos[1], "t": round(t, 2)})
    fout = (0.0, finish_z)
    t += hypot(pos, fout) / CANTER_V
    wps.append({"kind": "out", "x": fout[0], "z": fout[1], "t": round(t, 2)})
    return {
        "id": course["id"],
        "est_time_sec": round(t, 2),
        "min_radius_m": round(R_MIN, 2),
        "min_radius_needed_m": round(min_r_need, 2),
        "unrideable": unrideable,
        "waypoints": wps,
    }


def ids() -> list[str]:
    ship = json.loads(SHIP.read_text(encoding="utf-8"))
    out: list[str] = []
    for k in ("lesson", "beginner", "intermediate", "advanced"):
        out.extend(ship[k])
    out.extend(ship["jump_off"].values())
    return out


def main() -> None:
    OUT.mkdir(parents=True, exist_ok=True)
    summary = []
    for i in ids():
        p = plan(load(i))
        (OUT / f"{i}.json").write_text(json.dumps(p, indent=2), encoding="utf-8")
        summary.append(
            {
                "id": i,
                "est_time_sec": p["est_time_sec"],
                "unrideable": p["unrideable"],
            }
        )
        flag = " UNRIDEABLE" if p["unrideable"] else ""
        print(f"{i:16} {p['est_time_sec']:6.1f}s{flag}")
    (OUT / "SUMMARY.json").write_text(json.dumps(summary, indent=2), encoding="utf-8")


if __name__ == "__main__":
    main()
