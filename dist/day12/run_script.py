"""Run one Godot script headless. --headless is the first argument. No window."""
import os
import subprocess
import sys

ROOT = r"E:\Workspace\Madison"
GODOT = (
    r"C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages"
    r"\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe"
    r"\Godot_v4.7.2-stable_win64_console.exe"
)
if len(sys.argv) < 3:
    raise SystemExit("usage: run_script.py <res://script> <log name>")
script = sys.argv[1]
log_name = sys.argv[2]
if script.startswith("--artshot") or "artshot" in script:
    raise SystemExit("refusing artshot")
cmd = [GODOT, "--headless", "--path", os.path.join(ROOT, "game"), "--script", script]
if cmd[1] != "--headless":
    raise SystemExit("refusing to run: --headless is not first")
log = os.path.join(ROOT, "dist", "day12", log_name)
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
        rc = p.wait(timeout=300)
    except subprocess.TimeoutExpired:
        p.kill()
        print("TIMEOUT", p.pid, flush=True)
        raise SystemExit(124)
print("GODOT_EXIT", rc, "LOG", log, flush=True)
raise SystemExit(rc)
