"""Run --ridecert for one or more ids, keep each log, print a one-line summary."""
from __future__ import annotations

import os
import re
import subprocess
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
GODOT = (
    r"C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages"
    r"\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe"
    r"\Godot_v4.7.2-stable_win64_console.exe"
)
LOGS = os.path.join(ROOT, "dist", "ridecert_logs")
os.makedirs(LOGS, exist_ok=True)

def kill_strays() -> None:
    """A killed shell leaves the headless Godot behind, and two of those eating
    a core apiece turn every wall-clock time cap in the cert into a lie."""
    subprocess.run(
        ["taskkill", "/F", "/IM", "Godot_v4.7.2-stable_win64.exe"],
        capture_output=True,
    )
    subprocess.run(
        ["taskkill", "/F", "/IM", "Godot_v4.7.2-stable_win64_console.exe"],
        capture_output=True,
    )


kill_strays()
for cid in sys.argv[1:]:
    log = os.path.join(LOGS, cid + ".log")
    cmd = [GODOT, "--headless", "--path", "game", "--", "--ridecert", "--ridecert-id=" + cid]
    with open(log, "w", encoding="utf-8", newline="\n") as f:
        subprocess.Popen(cmd, cwd=ROOT, stdout=f, stderr=subprocess.STDOUT).wait()
    text = open(log, encoding="utf-8", errors="replace").read()
    m = re.search(r"RIDECERT %s style=clear (.*)" % re.escape(cid), text)
    knocks = re.findall(r"FENCE knock (\d+) by horse", text)
    segs = re.findall(r"RIDEAI fence (\d+) -> (\d+) t=([\d.]+)", text)
    worst = ""
    prev = 0.0
    slow = []
    for a, b, t in segs:
        dt = float(t) - prev
        prev = float(t)
        slow.append((dt, a))
    slow.sort(reverse=True)
    worst = " ".join("%s:%.1fs" % (n, dt) for dt, n in slow[:3])
    print("%-14s %s" % (cid, m.group(1) if m else "NO RESULT"))
    print("    knocks=%s  slowest=%s" % (",".join(knocks) or "-", worst), flush=True)
