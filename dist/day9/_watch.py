"""Wake only when day 9's driver finishes or dies. Silent while it rides."""
from __future__ import annotations

import ctypes
import time
from pathlib import Path

DAY9 = Path(r"E:\Workspace\Madison\dist\day9")
STATUS = DAY9 / "_status.txt"
PIDF = DAY9 / "_driver.pid"
kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)


def alive(pid: int) -> bool:
    handle = kernel32.OpenProcess(0x1000, False, pid)
    if not handle:
        return False
    kernel32.CloseHandle(handle)
    return True


def main() -> int:
    seen_pid = 0
    while True:
        if STATUS.exists():
            text = STATUS.read_text(encoding="utf-8", errors="replace").strip()
            if text.startswith("DONE"):
                print("DONE", flush=True)
                return 0
            if text.startswith("FAILED"):
                print("FAILED", flush=True)
                return 1
        if PIDF.exists():
            try:
                seen_pid = int(PIDF.read_text(encoding="utf-8").strip())
            except ValueError:
                seen_pid = 0
        if seen_pid and not STATUS.exists() and not alive(seen_pid):
            print("FAILED", flush=True)
            return 1
        time.sleep(30)


if __name__ == "__main__":
    raise SystemExit(main())
