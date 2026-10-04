"""After a closing-distance try: lies quiet, circles still speak, times hold."""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(r"E:\Workspace\Madison")
DAY4 = ROOT / "dist" / "day4"
MEASURE = ROOT / "dist" / "DAY4_MEASURE.md"
BOARD = json.loads((ROOT / "dist" / "day3" / "board.json").read_text(encoding="utf-8"))

IDS = [
    "hk_les_001", "hk_les_002", "hk_les_003", "hk_les_004",
    "hk_beg_035", "hk_beg_039", "hk_beg_004", "hk_beg_034", "hk_beg_007", "hk_beg_033",
    "hk_int_001", "hk_int_002", "hk_int_005", "hk_int_006", "hk_int_007", "hk_int_009",
    "hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005",
    "hk_jo_beg_001", "hk_jo_int_001", "hk_jo_adv_001",
]
ROW_RE = re.compile(
    r"\| (hk_\S+) \| (\d+) \| ([0-9.]+) \| ([0-9.]+) \| ([0-9.]*) \| ([0-9.]*) \| (yes|no) \| (yes|no) \|"
)
COUNT_RE = re.compile(r"COUNT fence=(\d+) ahead=([0-9.]+) lateral=([0-9.]+) stride=(-?\d+) word=([^ ]+)")
JUMP_RE = re.compile(r"RIDEAI fence (\d+) ->")
CIRCLE_RE = re.compile(r"RIDEAI come again n=(\d+)")
COME = "MICHELLE soft | Come again."
RESULT_RE = re.compile(
    r"faults=(\d+) jumped=\d+/\d+ t=([0-9.]+) teleported=(true|false).*rail_fences=(\[[^\]]*\])"
)


def board_times() -> dict[str, float]:
    times: dict[str, float] = {}

    def take(node):
        if isinstance(node, dict):
            if node.get("style") in ("clear", "A_clear") and "id" in node and "time_sec" in node:
                cid = node["id"]
                if cid not in times:
                    times[cid] = float(node["time_sec"])
            for value in node.values():
                take(value)
        elif isinstance(node, list):
            for value in node:
                take(value)

    take(BOARD)
    return times


def lie_and_true() -> tuple[set[tuple[str, str]], set[tuple[str, str]]]:
    """Clear-round fences. Style rows in the board are separate rounds and are not re-ridden."""
    text = MEASURE.read_text(encoding="utf-8")
    # The published table mixes rounds. Re-read the board log's clear rounds only via the same rows
    # is not possible without style. The measure file's prose lists the fences. Parse the table and
    # treat a fence as a lie when lined and not circled, and true when circled.
    lies: set[tuple[str, str]] = set()
    trues: set[tuple[str, str]] = set()
    for cid, fence, _a, lat, _na, _nl, lined, circled in ROW_RE.findall(text):
        if lined == "yes" and circled == "no":
            lies.add((cid, fence))
        if circled == "yes" or (lined == "no" and float(lat) >= 4.0):
            trues.add((cid, fence))
    return lies - trues, trues


def fence_windows(lines: list[str]) -> dict[str, list[str]]:
    """Lines from arrival on a fence until its jump, keyed by fence number. Last visit wins."""
    windows: dict[str, list[str]] = {}
    current = ""
    buf: list[str] = []
    for line in lines:
        jump = JUMP_RE.search(line)
        count = COUNT_RE.search(line)
        if count:
            fence = count.group(1)
            if fence != current:
                if current:
                    windows[current] = buf
                current = fence
                buf = [line]
            else:
                buf.append(line)
            continue
        if jump:
            fence = jump.group(1)
            if fence != current:
                if current:
                    windows[current] = buf
                current = fence
                buf = []
            buf.append(line)
            windows[current] = buf
            current = ""
            buf = []
            continue
        if current:
            buf.append(line)
    if current:
        windows[current] = buf
    return windows


def said_on(window: list[str]) -> bool:
    return any(line.strip() == COME for line in window)


def said_before_lineup(window: list[str]) -> bool:
    for line in window:
        if line.strip() == COME:
            return True
        count = COUNT_RE.search(line)
        if count and float(count.group(3)) < 1.6:
            return False
    return False


def main() -> None:
    suffix = sys.argv[1] if len(sys.argv) > 1 else ".log"
    times = board_times()
    pure, trues = lie_and_true()
    bad: list[str] = []
    for cid in IDS:
        path = DAY4 / f"{cid}{suffix}"
        if not path.exists():
            bad.append(f"{cid} missing")
            continue
        lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
        windows = fence_windows(lines)
        said = {fence for fence, window in windows.items() if said_on(window)}
        for fence in sorted(pure):
            if fence[0] != cid:
                continue
            if fence[1] in said:
                bad.append(f"{cid} fence {fence[1]} still speaks on a lie")
        for fence in sorted(trues):
            if fence[0] != cid:
                continue
            window = windows.get(fence[1], [])
            if not said_before_lineup(window):
                bad.append(f"{cid} fence {fence[1]} silent on a wide or circled approach")
        if cid == "hk_les_001" and "2" in said:
            bad.append("hk_les_001 fence 2 said Come again")
        if cid == "hk_beg_033":
            window = windows.get("2", [])
            blob = "\n".join(window)
            if COME in blob:
                bad.append("hk_beg_033 fence 2 said Come again")
            if "word=Two." in blob or "Two. " in blob:
                bad.append("hk_beg_033 fence 2 said Two")
        if cid == "hk_adv_001":
            for fence in ("7", "9"):
                window = windows.get(fence, [])
                blob = "\n".join(window)
                if f"RIDEAI come again n={fence}" not in blob:
                    bad.append(f"hk_adv_001 fence {fence} no circle in the new log")
                elif not said_before_lineup(window):
                    bad.append(f"hk_adv_001 fence {fence} circle approach did not hear it")
        res = RESULT_RE.search("\n".join(lines))
        if not res:
            bad.append(f"{cid} no result")
            continue
        faults, t, tele, rail = res.groups()
        old = times.get(cid)
        if old is None:
            bad.append(f"{cid} no board time")
        elif abs(float(t) - old) > 0.3:
            bad.append(f"{cid} time {old} -> {t}")
        if tele == "true":
            bad.append(f"{cid} teleported")
        if rail != "[]":
            bad.append(f"{cid} rail {rail}")
        if cid not in ("hk_adv_001", "hk_adv_003") and faults != "0":
            bad.append(f"{cid} faults {faults}")
        print(f"{cid} said={sorted(said, key=int)} t={t} faults={faults}")
    print("BAD" if bad else "PASS")
    for line in bad:
        print(line)


if __name__ == "__main__":
    main()
