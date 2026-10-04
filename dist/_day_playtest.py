"""One-shot headless playtest. Not a ride launcher. Deleted after the gate."""
import os
import subprocess

ROOT = r"E:\Workspace\Madison"
GODOT = (
    r"C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages"
    r"\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe"
    r"\Godot_v4.7.2-stable_win64_console.exe"
)
LOG = os.path.join(ROOT, "dist", "playtest_day.log")
cmd = [GODOT, "--headless", "--path", os.path.join(ROOT, "game"), "--", "--playtest"]
if cmd[1] != "--headless":
    raise SystemExit("refusing to run: --headless is not the first argument")
print("RUN", " ".join(cmd), flush=True)
with open(LOG, "w", encoding="utf-8", newline="\n") as f:
    p = subprocess.Popen(
        cmd,
        cwd=ROOT,
        stdout=f,
        stderr=subprocess.STDOUT,
        creationflags=subprocess.CREATE_NO_WINDOW,
    )
    rc = p.wait()
print("GODOT_EXIT", rc, flush=True)
raise SystemExit(rc)
