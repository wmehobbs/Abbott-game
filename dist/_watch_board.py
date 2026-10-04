"""Wake only on a terminal board state. Diagnostics go to dist/_board_watch.log."""
from __future__ import annotations

import subprocess
import time
from pathlib import Path

ROOT = Path(r"E:\Workspace\Madison")
LOG = ROOT / "dist" / "ridecert_godot.log"
BOARD = ROOT / "dist" / "ridecert_board.json"
SIDE = ROOT / "dist" / "_board_watch.log"
STARTED = time.time()


def side(msg: str) -> None:
    with SIDE.open("a", encoding="utf-8", newline="\n") as f:
        f.write(f"{time.strftime('%H:%M:%S')} {msg}\n")


def procs() -> list[str]:
    script = r"""
$ps = Get-CimInstance Win32_Process | Where-Object {
  $_.Name -match 'Godot|python' -and $_.CommandLine -match 'Godot|run_ridecert'
}
foreach ($p in $ps) {
  $win = 0
  try { $win = (Get-Process -Id $p.ProcessId -ErrorAction Stop).MainWindowHandle } catch {}
  '{0}|{1}|{2}|{3}' -f $p.ProcessId, $p.Name, $win, ($p.CommandLine -replace '\s+', ' ')
}
"""
    r = subprocess.run(
        ["powershell", "-NoProfile", "-Command", script],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
    )
    return [ln.strip() for ln in (r.stdout or "").splitlines() if ln.strip()]


def main() -> None:
    seen = False
    quiet = 0
    side("watch start")
    while True:
        rows = procs()
        godot = [r for r in rows if "Godot" in r.split("|", 3)[1]]
        windows = [r for r in godot if r.split("|", 3)[2] not in ("0", "")]
        side(f"n={len(rows)} godot={len(godot)} quiet={quiet} " + " || ".join(rows)[:500])
        if windows:
            print("FAILED window " + windows[0], flush=True)
            return
        # The console exe spawns one --headless child. That pair is one ride.
        if len(godot) > 2:
            print("FAILED second Godot " + " || ".join(godot), flush=True)
            return
        for r in godot:
            cmd = r.split("|", 3)[-1]
            if "--headless" not in cmd:
                print("FAILED godot without --headless " + cmd, flush=True)
                return
        if godot:
            seen = True
            quiet = 0
        else:
            quiet += 1
        text = ""
        if LOG.exists():
            text = LOG.read_text(encoding="utf-8", errors="replace")
        # Three empty polls, and the log is not still growing.
        log_age = time.time() - LOG.stat().st_mtime if LOG.exists() else 1e9
        if seen and quiet >= 3 and ("RIDECERT done" in text or log_age > 90):
            tail = " ".join(text.splitlines()[-8:])[:400]
            board_ok = BOARD.exists() and BOARD.stat().st_mtime >= STARTED - 5
            if "RIDECERT done" in text and board_ok:
                print("DONE", flush=True)
                return
            print("FAILED board missing or no RIDECERT done :: " + tail, flush=True)
            return
        if time.time() - STARTED > 180 and not seen:
            print("FAILED ridecert never started", flush=True)
            return
        time.sleep(30)


if __name__ == "__main__":
    main()
