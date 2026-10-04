"""Block until schooling three finishes, the process dies, or a window shows."""
import ctypes
import time
from ctypes import wintypes
from pathlib import Path

LOG = Path(r"E:\Workspace\Madison\dist\day9\hk_beg_035.school3.log")
GODOT = Path(r"E:\Workspace\Madison\dist\ridecert_godot.log")
kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
user32 = ctypes.WinDLL("user32", use_last_error=True)


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


def godot_alive() -> bool:
    import subprocess
    for image in (
        "Godot_v4.7.2-stable_win64.exe",
        "Godot_v4.7.2-stable_win64_console.exe",
    ):
        out = subprocess.run(
            ["tasklist", "/FI", f"IMAGENAME eq {image}", "/NH"],
            capture_output=True,
            text=True,
        )
        text = (out.stdout or "") + (out.stderr or "")
        if image in text:
            return True
    return False


def main() -> int:
    started = time.time()
    while True:
        win = window()
        if win:
            print("WINDOW " + win, flush=True)
            return 4
        if LOG.exists() and "RIDECERT done" in LOG.read_text(encoding="utf-8", errors="replace"):
            print("DONE school3", flush=True)
            return 0
        if not godot_alive() and time.time() - started > 15:
            if LOG.exists() and "RIDECERT done" in LOG.read_text(encoding="utf-8", errors="replace"):
                print("DONE school3", flush=True)
                return 0
            print("DEAD", flush=True)
            return 1
        if time.time() - started > 50 * 60:
            print("STUCK", flush=True)
            return 3
        time.sleep(5)


if __name__ == "__main__":
    raise SystemExit(main())
