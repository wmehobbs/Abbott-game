"""Windowed Godot for one tool script, with Madison's save and settings off.

usage: python dist/day17/run_window.py <res://tools/x.gd> <out dir> [timeout s] [extra user args...]

Always passes --shots-<tool> (GameState skips every save and settings write for
any user arg that starts with --shots) and --out=<dir>. Never pass a bare
--shots: that starts the Day 12 shot list instead. One Godot at a time.
After the run it compares her save and settings with the Day 17 snapshot."""
import hashlib
import os
import subprocess
import sys

ROOT = r"E:\Workspace\Madison"
GODOT = (
    r"C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages"
    r"\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe"
    r"\Godot_v4.7.2-stable_win64_console.exe"
)
USERDATA = r"C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott"
SNAPDIR = os.path.join(ROOT, "dist", "day17")


def sha(p):
    return hashlib.sha256(open(p, "rb").read()).hexdigest() if os.path.exists(p) else "missing"


def check():
    # Her save must have a snapshot. Settings may never have been saved;
    # then they must still be absent, so a settings file that appears is a
    # change (sha() calls a missing file "missing" on both sides).
    ok = True
    for name in ["abbott_save.json", "settings.cfg"]:
        live = os.path.join(USERDATA, name)
        snap = os.path.join(SNAPDIR, "snapshot_" + name)
        if name == "abbott_save.json" and not os.path.exists(snap):
            print("NO_SNAPSHOT", snap)
            print("SAVE_CHANGED")
            return False
        if sha(live) != sha(snap):
            print("CHANGED", name)
            ok = False
    print("SAVE_MATCH" if ok else "SAVE_CHANGED")
    return ok


def busy():
    out = subprocess.run(["tasklist", "/FI", "IMAGENAME eq Godot*"], capture_output=True, text=True).stdout
    return "Godot" in out


if __name__ == "__main__":
    if len(sys.argv) < 3:
        raise SystemExit(__doc__)
    script = sys.argv[1]
    out = os.path.abspath(sys.argv[2])
    timeout = int(sys.argv[3]) if len(sys.argv) > 3 and sys.argv[3].isdigit() else 600
    extra = sys.argv[4:] if len(sys.argv) > 3 and sys.argv[3].isdigit() else sys.argv[3:]
    if not os.path.exists(os.path.join(SNAPDIR, "snapshot_abbott_save.json")):
        raise SystemExit("NO_SNAPSHOT: do the setup step first")
    if busy():
        raise SystemExit("BUSY: another Godot is running; wait and retry")
    os.makedirs(out, exist_ok=True)
    tool = os.path.splitext(os.path.basename(script))[0].replace("_", "-")
    cmd = [GODOT, "--path", os.path.join(ROOT, "game"), "--windowed", "--resolution", "1600x900",
           "--position", "0,0", "--audio-driver", "Dummy", "-s", script, "--",
           "--shots-" + tool, "--out=" + out.replace("\\", "/"), *extra]
    if any(a == "--shots" for a in cmd):
        raise SystemExit("refusing a bare --shots")
    log = os.path.join(out, "run.log")
    with open(log, "w", encoding="utf-8", newline="\n") as f:
        f.write("CMD " + " ".join(cmd) + "\n")
        f.flush()
        p = subprocess.Popen(cmd, cwd=ROOT, stdout=f, stderr=subprocess.STDOUT)
        try:
            rc = p.wait(timeout=timeout)
        except subprocess.TimeoutExpired:
            p.kill()
            print("TIMEOUT", p.pid)
            rc = 124
    print("EXIT", rc, "LOG", log)
    txt = open(log, encoding="utf-8", errors="replace").read()
    for line in txt.splitlines():
        if "SCRIPT ERROR" in line or line.startswith("ERROR"):
            print(line[:300])
    check()
