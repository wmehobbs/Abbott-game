"""Run remaining SHIP ids one at a time. Copies each log. Stops on first fail."""
from __future__ import annotations

import json
import os
import shutil
import subprocess
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
RUNNER = os.path.join(ROOT, "tools", "content_factory", "run_ridecert.py")
LOG = os.path.join(ROOT, "dist", "ridecert_godot.log")
RESULTS = os.path.join(ROOT, "dist", "ridecert_results.json")
LOGDIR = os.path.join(ROOT, "dist", "ridecert_logs")
STATUS = os.path.join(ROOT, "dist", "remaining_status.txt")
os.makedirs(LOGDIR, exist_ok=True)


def status(msg: str) -> None:
    with open(STATUS, "w", encoding="utf-8") as f:
        f.write(msg + "\n")
    print(msg, flush=True)

IDS = [
    "hk_adv_003",
    "hk_beg_035",
]


def ok_row(t: dict) -> bool:
    need = int(t.get("fences_needed") or 0)
    sec = float(t.get("time_sec") or 0.0)
    min_t = 8.0 if need <= 4 else 20.0
    return (
        t.get("success") is True
        and int(t.get("faults") or 0) == 0
        and int(t.get("fences_jumped") or 0) == need
        and not bool(t.get("teleported"))
        and sec > min_t
    )


def main() -> int:
    python = sys.executable
    cleared: list[str] = []
    for i, cid in enumerate(IDS):
        status(f"RUNNING {i + 1}/{len(IDS)} {cid}")
        rc = subprocess.call([python, RUNNER, f"--ridecert-id={cid}"], cwd=ROOT)
        if os.path.isfile(LOG):
            shutil.copy2(LOG, os.path.join(LOGDIR, f"{cid}.log"))
        if not os.path.isfile(RESULTS):
            status(f"FAILED: {cid} no results json rc={rc}")
            return 1
        data = json.loads(open(RESULTS, encoding="utf-8").read())
        tracks = data.get("tracks") or []
        if not tracks:
            status(f"FAILED: {cid} empty board rc={rc}")
            return 1
        t = tracks[0]
        summary = (
            f"{cid} f={t.get('faults')} {t.get('fences_jumped')}/{t.get('fences_needed')} "
            f"t={t.get('time_sec')} tele={t.get('teleported')} suc={t.get('success')}"
        )
        print(summary, flush=True)
        if not ok_row(t):
            status(f"FAILED: {summary}")
            return 1
        cleared.append(cid)
    status(f"DONE: remaining {len(cleared)}/{len(IDS)} clear")
    return 0


if __name__ == "__main__":
    sys.exit(main())
