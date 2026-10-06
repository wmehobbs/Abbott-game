"""Windowed shot capture. No --headless. Dummy audio. Quits itself when done."""
import os
import subprocess
import sys

ROOT = r"E:\Workspace\Madison"
GODOT = (
    r"C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages"
    r"\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe"
    r"\Godot_v4.7.2-stable_win64_console.exe"
)
if len(sys.argv) < 2:
    raise SystemExit("usage: run_shots.py <output dir> [timeout seconds]")
out = os.path.abspath(sys.argv[1])
timeout = int(sys.argv[2]) if len(sys.argv) > 2 else 300
os.makedirs(out, exist_ok=True)
cmd = [
    GODOT,
    "--path",
    os.path.join(ROOT, "game"),
    "--windowed",
    "--resolution",
    "1920x1080",
    "--position",
    "0,0",
    "--audio-driver",
    "Dummy",
    "--",
    "--shots",
    "--shots-out=" + out.replace("\\", "/"),
]
if "--headless" in cmd or cmd[0].endswith("Godot_v4.7.2-stable_win64.exe"):
    raise SystemExit("refusing this command")
log = os.path.join(out, "shots_run.log")
print("RUN", " ".join(cmd), flush=True)
with open(log, "w", encoding="utf-8", newline="\n") as f:
    # No CREATE_NO_WINDOW: this run must show the game window so the viewport is real.
    p = subprocess.Popen(cmd, cwd=ROOT, stdout=f, stderr=subprocess.STDOUT)
    try:
        rc = p.wait(timeout=timeout)
    except subprocess.TimeoutExpired:
        p.kill()
        print("TIMEOUT", p.pid, flush=True)
        raise SystemExit(124)
print("GODOT_EXIT", rc, "LOG", log, flush=True)
raise SystemExit(rc)
