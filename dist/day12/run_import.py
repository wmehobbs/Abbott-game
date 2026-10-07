"""Headless project import so new class_name scripts register. No window."""
import os
import subprocess
import sys

ROOT = r"E:\Workspace\Madison"
GODOT = (
    r"C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages"
    r"\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe"
    r"\Godot_v4.7.2-stable_win64_console.exe"
)
cmd = [GODOT, "--headless", "--path", os.path.join(ROOT, "game"), "--import"]
if cmd[1] != "--headless":
    raise SystemExit("refusing to run: --headless is not first")
log = os.path.join(ROOT, "dist", "day12", "import_t10.log")
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
        rc = p.wait(timeout=180)
    except subprocess.TimeoutExpired:
        p.kill()
        print("TIMEOUT", p.pid, flush=True)
        raise SystemExit(124)
print("GODOT_EXIT", rc, "LOG", log, flush=True)
raise SystemExit(rc)
