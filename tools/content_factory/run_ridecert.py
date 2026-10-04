"""Launch Godot --headless --ridecert with a UTF-8 log (no PowerShell UTF-16 redirect)."""
from __future__ import annotations

import os
import shutil
import subprocess
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
GODOT = (
    r"C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages"
    r"\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe"
    r"\Godot_v4.7.2-stable_win64_console.exe"
)
_args = sys.argv[1:]
_side = any(
    a in ("--ridecert-fresh", "--ridecert-style") or a.startswith("--ridecert-fresh") or a.startswith("--ridecert-style")
    for a in _args
)
LOG = os.path.join(ROOT, "dist", "ridecert_fresh.log" if "--ridecert-fresh" in _args else "ridecert_style.log" if "--ridecert-style" in _args else "ridecert_godot.log")
os.makedirs(os.path.join(ROOT, "dist"), exist_ok=True)

cmd = [GODOT, "--headless", "--path", "game", "--", "--ridecert"] + sys.argv[1:]
print("RUN", " ".join(cmd), flush=True)
with open(LOG, "w", encoding="utf-8", newline="\n") as f:
    p = subprocess.Popen(
        cmd,
        cwd=ROOT,
        stdout=f,
        stderr=subprocess.STDOUT,
        creationflags=subprocess.CREATE_NO_WINDOW if hasattr(subprocess, "CREATE_NO_WINDOW") else 0,
    )
    rc = p.wait()
print(f"GODOT_EXIT {rc}", flush=True)

# Keep the full board. A later --ridecert-id run overwrites
# ridecert_results.json with a 1/1, and then the write-up has nothing behind it.
if not _side and not any(a.startswith("--ridecert-id") for a in sys.argv[1:]):
    src = os.path.join(ROOT, "dist", "ridecert_results.json")
    if os.path.exists(src):
        shutil.copyfile(src, os.path.join(ROOT, "dist", "ridecert_board.json"))
        print("BOARD kept at dist/ridecert_board.json", flush=True)

sys.exit(rc)
