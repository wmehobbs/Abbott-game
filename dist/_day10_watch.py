"""Wake only when day 10 stops. Progress stays in dist/day10/_watch.log."""
from __future__ import annotations

import ctypes
import time
from ctypes import wintypes
from pathlib import Path

ROOT = Path(r"E:\Workspace\Madison")
DAY = ROOT / "dist" / "day10"
STATUS = DAY / "_status.txt"
HEART = DAY / "_heartbeat.txt"
LOG = ROOT / "dist" / "DAY10_LOG.md"
DBG = DAY / "_watch.log"
PIDF = DAY / "_driver.pid"

kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
STILL_ACTIVE = 259


def dbg(msg: str) -> None:
    try:
        DAY.mkdir(parents=True, exist_ok=True)
        with DBG.open("a", encoding="utf-8", newline="\n") as handle:
            handle.write(time.strftime("%H:%M:%S ") + msg + "\n")
    except OSError:
        pass


def alive(pid: int) -> bool:
    handle = kernel32.OpenProcess(0x1000, False, pid)
    if not handle:
        return False
    try:
        code = wintypes.DWORD()
        if not kernel32.GetExitCodeProcess(handle, ctypes.byref(code)):
            return False
        return code.value == STILL_ACTIVE
    finally:
        kernel32.CloseHandle(handle)


def main() -> int:
    seen = ""
    changed = time.time()
    saw_pid = False
    while True:
        if STATUS.exists():
            text = STATUS.read_text(encoding="utf-8", errors="replace").strip()
            if text.startswith("DONE"):
                print("DONE", flush=True)
                return 0
            if text.startswith("FAILED"):
                print(f"FAILED: {text}", flush=True)
                return 1
        if LOG.exists() and "BLACKLIST:" in LOG.read_text(encoding="utf-8", errors="replace"):
            print("FAILED: window blacklist", flush=True)
            return 1
        if HEART.exists():
            heart = HEART.read_text(encoding="utf-8", errors="replace").strip()
            if heart != seen:
                seen = heart
                changed = time.time()
                dbg(heart)
            elif time.time() - changed > 180:
                print(f"FAILED: heartbeat stalled {heart}", flush=True)
                return 1
        if PIDF.exists():
            raw = PIDF.read_text(encoding="utf-8", errors="replace").strip()
            if raw.isdigit():
                saw_pid = True
                pid = int(raw)
                if not alive(pid):
                    time.sleep(2)
                    if STATUS.exists():
                        text = STATUS.read_text(encoding="utf-8", errors="replace").strip()
                        if text.startswith("DONE"):
                            print("DONE", flush=True)
                            return 0
                        print(f"FAILED: {text or 'driver exited'}", flush=True)
                        return 1
                    print("FAILED: driver exited without status", flush=True)
                    return 1
        elif saw_pid:
            print("FAILED: driver pid file disappeared", flush=True)
            return 1
        time.sleep(30)


if __name__ == "__main__":
    raise SystemExit(main())
