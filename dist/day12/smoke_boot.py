"""Headless boot with user args. Finds script errors before a window."""
import os
import subprocess
import sys

ROOT = r"E:\Workspace\Madison"
GODOT = (
    r"C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages"
    r"\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe"
    r"\Godot_v4.7.2-stable_win64_console.exe"
)
out = os.path.join(ROOT, "dist", "day12", "shots", "_parse")
os.makedirs(out, exist_ok=True)
log = os.path.join(ROOT, "dist", "day12", "smoke_boot.log")
cmd = [
    GODOT,
    "--headless",
    "--path",
    os.path.join(ROOT, "game"),
    "--quit-after",
    "4",
    "--",
    "--shots",
    "--shots-out=" + out.replace("\\", "/"),
]
if cmd[1] != "--headless":
    raise SystemExit("refusing")
print("RUN", " ".join(cmd), flush=True)
with open(log, "w", encoding="utf-8", newline="\n") as f:
    p = subprocess.Popen(
        cmd,
        cwd=ROOT,
        stdout=f,
        stderr=subprocess.STDOUT,
        creationflags=subprocess.CREATE_NO_WINDOW,
    )
    try:
        rc = p.wait(timeout=90)
    except subprocess.TimeoutExpired:
        p.kill()
        print("TIMEOUT", p.pid, flush=True)
        raise SystemExit(124)
print("GODOT_EXIT", rc, flush=True)
raise SystemExit(rc)
