"""Windowed Day 15 probe: python dist/day15/run_probe.py <plan.json> <out dir> [timeout]
One Godot at a time. Dummy audio. The probe quits itself."""
import os
import subprocess
import sys
import hashlib

ROOT = r"E:\Workspace\Madison"
GODOT = (
    r"C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages"
    r"\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe"
    r"\Godot_v4.7.2-stable_win64_console.exe"
)
SAVE = r"C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json"
SNAP = os.path.join(ROOT, "dist", "day15", "save_snapshot.json")


def sha(p):
    return hashlib.sha256(open(p, "rb").read()).hexdigest()


def busy():
    out = subprocess.run(["tasklist", "/FI", "IMAGENAME eq Godot*"], capture_output=True, text=True).stdout
    return "Godot" in out


plan = os.path.abspath(sys.argv[1])
out = os.path.abspath(sys.argv[2])
timeout = int(sys.argv[3]) if len(sys.argv) > 3 else 180
if busy():
    raise SystemExit("another Godot is running; wait")
os.makedirs(out, exist_ok=True)
cmd = [GODOT, "--path", os.path.join(ROOT, "game"), "--windowed", "--resolution", "1600x900",
       "--position", "0,0", "--audio-driver", "Dummy", "-s", "res://tools/day15_probe.gd", "--",
       "--shots-probe", "--out=" + out.replace("\\", "/"), "--plan=" + plan.replace("\\", "/")]
log = os.path.join(out, "probe.log")
with open(log, "w", encoding="utf-8", newline="\n") as f:
    p = subprocess.Popen(cmd, cwd=ROOT, stdout=f, stderr=subprocess.STDOUT)
    try:
        rc = p.wait(timeout=timeout)
    except subprocess.TimeoutExpired:
        p.kill()
        print("TIMEOUT", p.pid)
        rc = 124
print("EXIT", rc)
txt = open(log, encoding="utf-8", errors="replace").read()
for line in txt.splitlines():
    if line.startswith("PROBE") or "ERROR" in line or "SCRIPT" in line:
        print(line[:300])
same = sha(SAVE) == sha(SNAP)
print("SAVE_MATCH", same)
if not same:
    print("!!! SAVE CHANGED")
