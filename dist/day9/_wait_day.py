"""Block until 23 r2 and 23 r3 logs contain RIDECERT done, the driver dies, or a window shows."""
import ctypes
import subprocess
import time
from ctypes import wintypes
from pathlib import Path

DAY = Path(r"E:\Workspace\Madison\dist\day9")
PIDF = DAY / "_driver.pid"
STATUS = DAY / "_status.txt"
HEART = DAY / "_heartbeat.txt"
IDS = [
    "hk_les_001", "hk_les_002", "hk_les_003", "hk_les_004",
    "hk_beg_035", "hk_beg_039", "hk_beg_004", "hk_beg_034", "hk_beg_007", "hk_beg_033",
    "hk_int_001", "hk_int_002", "hk_int_005", "hk_int_006", "hk_int_007", "hk_int_009",
    "hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005",
    "hk_jo_beg_001", "hk_jo_int_001", "hk_jo_adv_001",
]
kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
user32 = ctypes.WinDLL("user32", use_last_error=True)


def alive(pid: int) -> bool:
    handle = kernel32.OpenProcess(0x1000, False, pid)
    if not handle:
        return False
    kernel32.CloseHandle(handle)
    return True


def is_godot(pid: int) -> bool:
    handle = kernel32.OpenProcess(0x1000, False, pid)
    if not handle:
        return False
    try:
        buf = ctypes.create_unicode_buffer(512)
        size = wintypes.DWORD(512)
        if not kernel32.QueryFullProcessImageNameW(handle, 0, buf, ctypes.byref(size)):
            return False
        return "godot" in buf.value.lower()
    finally:
        kernel32.CloseHandle(handle)


def window() -> str:
    found = []

    @ctypes.WINFUNCTYPE(wintypes.BOOL, wintypes.HWND, wintypes.LPARAM)
    def visit(hwnd, _lparam):
        if not user32.IsWindowVisible(hwnd):
            return True
        length = user32.GetWindowTextLengthW(hwnd)
        if length <= 0:
            return True
        buf = ctypes.create_unicode_buffer(length + 1)
        user32.GetWindowTextW(hwnd, buf, length + 1)
        pid = wintypes.DWORD()
        user32.GetWindowThreadProcessId(hwnd, ctypes.byref(pid))
        if is_godot(pid.value):
            found.append(f"pid={pid.value} title={buf.value}")
        return True

    user32.EnumWindows(visit, 0)
    return found[0] if found else ""


def done_count(tag: str) -> int:
    n = 0
    for course_id in IDS:
        path = DAY / f"{course_id}.{tag}.log"
        if not path.exists():
            continue
        text = path.read_text(encoding="utf-8", errors="replace")
        if "RIDECERT done" in text:
            n += 1
    return n


def main() -> int:
    started = time.time()
    while True:
        win = window()
        if win:
            print("WINDOW " + win, flush=True)
            return 4
        r2 = done_count("r2")
        r3 = done_count("r3")
        if r2 == 23 and r3 == 23:
            print(f"COUNT r2={r2} r3={r3}", flush=True)
            return 0
        pid = 0
        if PIDF.exists():
            try:
                pid = int(PIDF.read_text(encoding="utf-8").strip())
            except ValueError:
                pid = 0
        if pid and not alive(pid):
            status = STATUS.read_text(encoding="utf-8", errors="replace").strip() if STATUS.exists() else ""
            heart = HEART.read_text(encoding="utf-8", errors="replace").strip() if HEART.exists() else ""
            print(f"DEAD r2={r2} r3={r3} status={status} heart={heart}", flush=True)
            return 1
        if time.time() - started > 12 * 3600:
            print(f"TIMEOUT r2={r2} r3={r3}", flush=True)
            return 3
        time.sleep(15)


if __name__ == "__main__":
    raise SystemExit(main())
