"""Headless Godot for a user arg. Not a ride launcher. --headless stays first."""
import os
import subprocess
import sys

ROOT = r"E:\Workspace\Madison"
GODOT = (
    r"C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages"
    r"\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe"
    r"\Godot_v4.7.2-stable_win64_console.exe"
)
user = sys.argv[1:]
if not user or user[0].startswith("--artshot"):
    raise SystemExit("refusing artshot or empty user args")
leaf = user[0].lstrip("-").replace("-", "_")
log = os.path.join(ROOT, "dist", leaf + "_day.log")
cmd = [GODOT, "--headless", "--path", os.path.join(ROOT, "game"), "--", *user]
if cmd[1] != "--headless":
    raise SystemExit("refusing to run: --headless is not first")
print("RUN", " ".join(cmd), flush=True)
with open(log, "w", encoding="utf-8", newline="\n") as f:
    p = subprocess.Popen(
        cmd,
        cwd=ROOT,
        stdout=f,
        stderr=subprocess.STDOUT,
        creationflags=subprocess.CREATE_NO_WINDOW,
    )
    rc = p.wait()
print("GODOT_EXIT", rc, "LOG", log, flush=True)
raise SystemExit(rc)
