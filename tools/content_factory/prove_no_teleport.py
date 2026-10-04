"""Static proof that ride_ai / ride_cert do not teleport or call Horse.present."""
from __future__ import annotations

import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
AI = ROOT / "game" / "scripts" / "ride_ai.gd"
CERT = ROOT / "game" / "scripts" / "ride_cert.gd"
HORSE = ROOT / "game" / "scripts" / "horse.gd"

PRESENT = re.compile(r"present\s*\(")
JUMP_FENCE = re.compile(r"_jump_fence\s*\(")
ASSIGN_POS = re.compile(r"global_position\s*=")


def lines_with(path: pathlib.Path, rx: re.Pattern[str]) -> list[tuple[int, str]]:
    hits = []
    for i, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        if rx.search(line):
            hits.append((i, line.strip()))
    return hits


def main() -> int:
    errs: list[str] = []
    for path in (AI, CERT, HORSE):
        if not path.is_file():
            errs.append(f"missing {path}")
    if errs:
        print("FAIL")
        for e in errs:
            print(" ", e)
        return 1

    for path in (AI, CERT):
        for i, line in lines_with(path, PRESENT):
            errs.append(f"{path.name}:{i} present(: {line}")
        for i, line in lines_with(path, JUMP_FENCE):
            errs.append(f"{path.name}:{i} _jump_fence(: {line}")

    ai_pos = lines_with(AI, ASSIGN_POS)
    if ai_pos:
        for i, line in ai_pos:
            errs.append(f"ride_ai.gd:{i} global_position = : {line}")

    cert_pos = lines_with(CERT, ASSIGN_POS)
    allowed = [h for h in cert_pos if "course.start_pos" in h[1]]
    other = [h for h in cert_pos if "course.start_pos" not in h[1]]
    if other:
        for i, line in other:
            errs.append(f"ride_cert.gd:{i} extra global_position = : {line}")
    if len(allowed) != 1:
        errs.append(
            f"ride_cert.gd must have exactly one start_pos reset, found {len(allowed)}: {allowed}"
        )

    horse = HORSE.read_text(encoding="utf-8")
    need = [
        "const TAKEOFF := 2.55",
        "var lined := lateral < 1.20 * rs and ang < deg_to_rad(28.0 * rs)",
        "var early := ahead > TAKEOFF + 1.05 * ws",
        "var late := ahead < TAKEOFF - 0.80 * ws",
        "var ideal := absf(ahead - TAKEOFF) <= 0.55 * ws",
        "const GAIT_SPEED: Array[float] = [0.0, 1.45, 2.80, 5.55]",
        "const GAIT_TURN: Array[float] = [1.8, 2.40, 1.62, 1.08]",
    ]
    for n in need:
        if n not in horse:
            errs.append(f"horse.gd missing quoted leave/gait line: {n}")

    if errs:
        print("FAIL prove_no_teleport")
        for e in errs:
            print(" ", e)
        return 1
    print("PASS prove_no_teleport")
    print("  ride_ai.gd: no present(, no _jump_fence(, no global_position =")
    print("  ride_cert.gd: no present(, no _jump_fence(, one start_pos reset")
    print("  horse.gd: TAKEOFF / lined / early / late / ideal / gait numbers unchanged")
    return 0


if __name__ == "__main__":
    sys.exit(main())
