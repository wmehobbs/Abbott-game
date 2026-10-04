"""Stride ledger for the 23 SHIP courses. Ground distance, not the label."""
from __future__ import annotations

import json
import math
from pathlib import Path

ROOT = Path(r"E:\Workspace\Madison")
SHIP = ROOT / "game" / "content" / "courses" / "SHIP.json"
OUT = ROOT / "dist" / "stride_ledger.md"
LO = 3.05
HI = 3.45


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
    raise SystemExit("unknown id " + i)


def takeoff(yaw: float) -> tuple[float, float]:
    # Godot basis.z after rotation.y: yaw 0 travels +Z.
    return math.sin(yaw), math.cos(yaw)


def turn_deg(yaw: float, dx: float, dz: float) -> float:
    mag = math.hypot(dx, dz)
    if mag < 1e-6:
        return 0.0
    lx, lz = takeoff(yaw)
    dot = max(-1.0, min(1.0, (dx * lx + dz * lz) / mag))
    return math.degrees(math.acos(dot))


def main() -> None:
    ship = json.loads(SHIP.read_text(encoding="utf-8"))
    ids: list[str] = []
    for k in ("lesson", "beginner", "intermediate", "advanced"):
        ids.extend(ship[k])
    for v in ship["jump_off"].values():
        ids.append(v)
    lines: list[str] = []
    flagged: list[str] = []
    related_rows: list[tuple[float, str]] = []
    lines.append("# Stride ledger — 23 ship courses")
    lines.append("")
    lines.append(
        "Ground distance is the horizontal distance between fence positions. "
        "Turn is the angle between the previous fence's takeoff yaw (Godot basis.z) "
        "and the ground vector to the next fence. Implied stride is ground / labeled strides. "
        f"Flag when a labeled related is outside {LO:.2f}–{HI:.2f} m."
    )
    lines.append("")
    lines.append("| course | leg | ground_m | labeled_strides | labeled_m | implied_m | turn_deg | flag |")
    lines.append("| --- | --- | ---: | ---: | ---: | ---: | ---: | --- |")
    for cid in ids:
        path = ROOT / "game" / "content" / "courses" / folder(cid) / f"{cid}.json"
        course = json.loads(path.read_text(encoding="utf-8"))
        fences = course["fences"]
        by_num = {int(f["num"]): f for f in fences}
        for a, b in zip(fences, fences[1:]):
            ax, az = float(a["pos"][0]), float(a["pos"][2])
            bx, bz = float(b["pos"][0]), float(b["pos"][2])
            ground = math.hypot(bx - ax, bz - az)
            turn = turn_deg(float(a["yaw"]), bx - ax, bz - az)
            rel = a.get("related")
            labeled_n = ""
            labeled_m = ""
            implied = ""
            flag = ""
            if isinstance(rel, dict) and int(rel.get("to", -1)) == int(b["num"]):
                n = int(rel.get("strides", 0))
                lm = float(rel.get("distance_m", 0))
                labeled_n = str(n)
                labeled_m = f"{lm:.2f}"
                if n > 0:
                    imp = ground / n
                    implied = f"{imp:.3f}"
                    if imp < LO or imp > HI:
                        flag = "OUT"
                        flagged.append(f"{cid} {a['num']}->{b['num']} {imp:.3f} m ({n} strides, ground {ground:.2f})")
                    related_rows.append((abs(imp - 3.25), f"| {cid} | {a['num']}->{b['num']} | {ground:.2f} | {n} | {lm:.2f} | {imp:.3f} | {turn:.1f} | {flag} |"))
                else:
                    flag = "NO_STRIDES"
            lines.append(
                f"| {cid} | {a['num']}->{b['num']} | {ground:.2f} | {labeled_n} | {labeled_m} | {implied} | {turn:.1f} | {flag} |"
            )
        # Related that does not point at the next fence.
        for a in fences:
            rel = a.get("related")
            if not isinstance(rel, dict):
                continue
            nxt = fences[fences.index(a) + 1]["num"] if fences.index(a) + 1 < len(fences) else None
            if int(rel.get("to", -1)) == nxt:
                continue
            b = by_num.get(int(rel["to"]))
            if b is None:
                lines.append(f"| {cid} | {a['num']}->?{rel.get('to')} |  |  |  |  |  | MISSING_TO |")
                continue
            ax, az = float(a["pos"][0]), float(a["pos"][2])
            bx, bz = float(b["pos"][0]), float(b["pos"][2])
            ground = math.hypot(bx - ax, bz - az)
            turn = turn_deg(float(a["yaw"]), bx - ax, bz - az)
            n = int(rel.get("strides", 0))
            lm = float(rel.get("distance_m", 0))
            implied = ""
            flag = "NONCONSEC"
            if n > 0:
                imp = ground / n
                implied = f"{imp:.3f}"
                if imp < LO or imp > HI:
                    flag = "NONCONSEC OUT"
                    flagged.append(f"{cid} {a['num']}->{b['num']} {imp:.3f} m nonconsecutive")
            lines.append(
                f"| {cid} | {a['num']}->{b['num']} | {ground:.2f} | {n} | {lm:.2f} | {implied} | {turn:.1f} | {flag} |"
            )
    lines.append("")
    lines.append(f"## Flagged relateds ({len(flagged)})")
    lines.append("")
    lines.append(
        "Flag is ground distance divided by the labeled stride count. "
        "A one-stride line is about 7.4 m of fence-to-fence ground, so that quotient "
        "is not the canter stride. The band is the question, not a license to edit."
    )
    lines.append("")
    if not flagged:
        lines.append("None.")
    else:
        for row in flagged:
            lines.append(f"- {row}")
    # Increment: how many meters the label adds per extra stride.
    by_n: dict[int, list[float]] = {}
    for cid in ids:
        path = ROOT / "game" / "content" / "courses" / folder(cid) / f"{cid}.json"
        course = json.loads(path.read_text(encoding="utf-8"))
        fences = course["fences"]
        for a, b in zip(fences, fences[1:]):
            rel = a.get("related")
            if not isinstance(rel, dict) or int(rel.get("to", -1)) != int(b["num"]):
                continue
            n = int(rel.get("strides", 0))
            if n <= 0:
                continue
            ax, az = float(a["pos"][0]), float(a["pos"][2])
            bx, bz = float(b["pos"][0]), float(b["pos"][2])
            by_n.setdefault(n, []).append(math.hypot(bx - ax, bz - az))
    lines.append("")
    lines.append("## Ground distance by labeled stride count")
    lines.append("")
    lines.append("| strides | n | min_m | median_m | max_m |")
    lines.append("| ---: | ---: | ---: | ---: | ---: |")
    medians: dict[int, float] = {}
    for n in sorted(by_n):
        xs = sorted(by_n[n])
        med = xs[len(xs) // 2]
        medians[n] = med
        lines.append(f"| {n} | {len(xs)} | {xs[0]:.2f} | {med:.2f} | {xs[-1]:.2f} |")
    lines.append("")
    lines.append("## Meters added per extra stride (median to median)")
    lines.append("")
    for n in sorted(medians):
        if n - 1 in medians:
            lines.append(f"- {n - 1} to {n}: {medians[n] - medians[n - 1]:.3f} m")
    lines.append("")
    OUT.write_text("\n".join(lines) + "\n", encoding="utf-8", newline="\n")
    print(f"courses {len(ids)} flagged {len(flagged)} wrote {OUT}")
    for row in flagged:
        print("FLAG", row)


if __name__ == "__main__":
    main()
