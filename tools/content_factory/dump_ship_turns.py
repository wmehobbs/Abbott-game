"""Print consecutive-fence turn radius demand for the 23 SHIP tracks."""
from __future__ import annotations

import json
import math
import pathlib

ROOT = pathlib.Path(__file__).resolve().parents[2]
SHIP = ROOT / "game" / "content" / "courses" / "SHIP.json"

# Canter with half-halt: v=5.55*0.82, w=1.08*0.99*1.14 ≈ 3.73 m radius.
CANTER_R = 3.73


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


def dir_yaw(yaw: float) -> tuple[float, float]:
    # Fence yaw 0 → takeoff_dir +Z. Travel +Z.
    return math.sin(yaw), math.cos(yaw)


def main() -> None:
    ship = json.loads(SHIP.read_text(encoding="utf-8"))
    ids: list[str] = []
    for k in ("lesson", "beginner", "intermediate", "advanced"):
        ids.extend(ship[k])
    for v in ship["jump_off"].values():
        ids.append(v)
    print(f"canter half-halt radius {CANTER_R:.2f} m")
    for i in ids:
        c = load(i)
        fs = c["fences"]
        print(f"\n{i}  {c.get('name')}  n={len(fs)}  finish_z={c.get('finish_z')}")
        for a, b in zip(fs, fs[1:]):
            ax, az = float(a["pos"][0]), float(a["pos"][2])
            bx, bz = float(b["pos"][0]), float(b["pos"][2])
            mag = math.hypot(bx - ax, bz - az)
            lx, lz = dir_yaw(float(a["yaw"]))
            tx, tz = dir_yaw(float(b["yaw"]))
            leave_dot = ((bx - ax) * lx + (bz - az) * lz) / mag if mag else 1.0
            turn = math.degrees(math.acos(max(-1.0, min(1.0, leave_dot))))
            # Heading change of takeoff dirs.
            ddot = max(-1.0, min(1.0, lx * tx + lz * tz))
            dyaw = math.degrees(math.acos(ddot))
            need_r = mag / max(math.radians(max(turn, 1.0)), 0.05) if turn > 40 else 0.0
            flag = ""
            if turn > 70 and mag < 12:
                flag = " TIGHT"
            if dyaw > 120 and mag < 14:
                flag = " ROLLBACK"
            if mag < 8.2:
                flag += " RELATED-1?"
            print(
                f"  {a['num']}->{b['num']}  {mag:5.1f}m  turn {turn:5.1f}deg  "
                f"dyaw {dyaw:5.1f}  {a['kind'][:3]}->{b['kind'][:3]}{flag}"
            )


if __name__ == "__main__":
    main()
