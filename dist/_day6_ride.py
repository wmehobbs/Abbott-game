"""Day 6 style list. One Godot at a time. A cert must not write the save."""
from __future__ import annotations

import ctypes
import re
import shutil
import subprocess
import sys
import time
from ctypes import wintypes
from pathlib import Path

ROOT = Path(r"E:\Workspace\Madison")
DAY6 = ROOT / "dist" / "day6"
DAY5 = ROOT / "dist" / "day5"
LOG = ROOT / "dist" / "ridecert_style.log"
DAY_LOG = ROOT / "dist" / "DAY6_LOG.md"
SAVE = Path(r"C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json")
SNAP = DAY6 / "save_snapshot.json"
RUN = [sys.executable, str(ROOT / "tools" / "content_factory" / "run_ridecert.py")]
IDS = [
    "hk_les_001", "hk_les_002", "hk_les_003", "hk_les_004",
    "hk_beg_035", "hk_beg_039", "hk_beg_004", "hk_beg_034", "hk_beg_007", "hk_beg_033",
    "hk_int_001", "hk_int_002", "hk_int_005", "hk_int_006", "hk_int_007", "hk_int_009",
    "hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005",
    "hk_jo_beg_001", "hk_jo_int_001", "hk_jo_adv_001",
]
ADVANCED = {"hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005"}

kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
user32 = ctypes.WinDLL("user32", use_last_error=True)

KNOCK_RE = re.compile(r"FENCE knock (\d+)")
JUMP_RE = re.compile(r"RIDEAI fence (\d+) ->")
RESULT_RE = re.compile(
    r"faults=(\d+) refusal_faults=(\d+) rail_faults=(\d+) time_faults=(\d+) "
    r"jumped=(\d+)/(\d+) .* teleported=(true|false) complete=(true|false) "
    r"refused=(\[[^\]]*\]) rail_fences=(\[[^\]]*\])"
)
DAY5_RE = re.compile(r"faults=(\d+) jumped=")


def _is_godot(pid: int) -> bool:
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


def godot_window() -> str:
    found: list[str] = []

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
        if _is_godot(pid.value):
            found.append(f"pid={pid.value} title={buf.value}")
        return True

    user32.EnumWindows(visit, 0)
    return found[0] if found else ""


def godot_alive() -> bool:
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


def blacklist(cmd: str) -> None:
    with DAY_LOG.open("a", encoding="utf-8", newline="\n") as handle:
        handle.write(f"\nBLACKLIST: {cmd}\n")


def kill_tree(pid: int) -> None:
    subprocess.run(["taskkill", "/PID", str(pid), "/T", "/F"], capture_output=True)


def nums(blob: str) -> list[str]:
    return re.findall(r"\d+", blob)


def blocks(text: str) -> dict[str, str]:
    found: dict[str, str] = {}
    for block in text.split("RIDECERT round ")[1:]:
        head = block.split("\n", 1)[0]
        if "style=refuse_early" in head:
            found["refuse_early"] = block
        elif "style=rail_late" in head:
            found["rail_late"] = block
    return found


def save_matches() -> bool:
    if not SAVE.exists() or not SNAP.exists():
        return False
    return SAVE.read_bytes() == SNAP.read_bytes()


def restore_save() -> None:
    shutil.copyfile(SNAP, SAVE)


def day5_faults(course_id: str) -> dict[str, str]:
    text = (DAY5 / f"{course_id}.style.log").read_text(encoding="utf-8", errors="replace")
    out: dict[str, str] = {}
    for style, block in blocks(text).items():
        hit = DAY5_RE.search(block)
        if hit:
            out[style] = hit.group(1)
    return out


def judge(course_id: str, log_path: Path) -> list[str]:
    text = log_path.read_text(encoding="utf-8", errors="replace")
    bad: list[str] = []
    if "RIDECERT done" not in text:
        return [f"{course_id} no RIDECERT done"]
    got = blocks(text)
    old = day5_faults(course_id)
    for style in ("refuse_early", "rail_late"):
        block = got.get(style, "")
        hit = RESULT_RE.search(block) if block else None
        if not hit:
            bad.append(f"{course_id} {style} no result")
            continue
        faults, refusal, rails, time_faults, jumped, needed, tele, complete, refused, listed = hit.groups()
        parts = int(refusal) + int(rails) + int(time_faults)
        if faults != old.get(style):
            bad.append(f"{course_id} {style} faults {old.get(style)} -> {faults}")
        if parts != int(faults):
            bad.append(f"{course_id} {style} parts {refusal}+{rails}+{time_faults} != {faults}")
        if tele != "false":
            bad.append(f"{course_id} {style} teleported")
        if complete != "true" or jumped != needed:
            bad.append(f"{course_id} {style} incomplete {jumped}/{needed} complete={complete}")
        knocks = KNOCK_RE.findall(block)
        if nums(listed) != knocks:
            bad.append(f"{course_id} {style} rail_fences {nums(listed)} != knocks {knocks}")
        if style == "refuse_early":
            saw = False
            jumped_after = False
            for line in block.splitlines():
                jump = JUMP_RE.search(line)
                if jump and jump.group(1) == "1" and saw:
                    jumped_after = True
                if "RIDECERT refuse" in line and "fence=1" in line:
                    saw = True
            if "1" not in nums(refused):
                bad.append(f"{course_id} refuse did not name fence 1")
            if not jumped_after:
                bad.append(f"{course_id} fence 1 was not jumped again")
        if course_id == "hk_jo_adv_001" and style == "refuse_early":
            if (faults, refusal, rails, time_faults) != ("19", "4", "8", "7"):
                bad.append(f"hk_jo_adv_001 refuse parts {refusal},{rails},{time_faults} faults {faults}")
        if course_id == "hk_adv_001" and style == "refuse_early":
            if faults != "11" or nums(listed) != ["6"]:
                bad.append(f"hk_adv_001 refuse faults {faults} list {listed}")
    return bad


def append_rows(course_id: str, log_path: Path) -> None:
    text = log_path.read_text(encoding="utf-8", errors="replace")
    old = day5_faults(course_id)
    lines = []
    for style in ("refuse_early", "rail_late"):
        hit = RESULT_RE.search(blocks(text)[style])
        assert hit is not None
        faults, refusal, rails, time_faults = hit.group(1), hit.group(2), hit.group(3), hit.group(4)
        total = int(refusal) + int(rails) + int(time_faults)
        lines.append(
            f"| {course_id} | {style} | {old[style]} | {faults} | {refusal} | {rails} | "
            f"{time_faults} | {total} | matched |"
        )
    with DAY_LOG.open("a", encoding="utf-8", newline="\n") as handle:
        for line in lines:
            handle.write(line + "\n")


def ride(course_id: str) -> int:
    while godot_alive():
        print(f"WAIT godot before {course_id}", flush=True)
        time.sleep(5)
    dest = DAY6 / f"{course_id}.style.log"
    limit = 45 * 60 if course_id in ADVANCED else 30 * 60
    cmd = RUN + ["--ridecert-style", "--ridecert-id", course_id]
    proc = subprocess.Popen(cmd, cwd=ROOT, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    started = time.time()
    saw_round = False
    while proc.poll() is None:
        window = godot_window()
        if window:
            kill_tree(proc.pid)
            if not save_matches():
                restore_save()
            blacklist(
                "python tools/content_factory/run_ridecert.py "
                f"--ridecert-style --ridecert-id {course_id} ({window})"
            )
            print(f"WINDOW {course_id} {window}", flush=True)
            return 4
        if not saw_round and LOG.exists():
            try:
                saw_round = "RIDECERT round" in LOG.read_text(encoding="utf-8", errors="replace")
            except OSError:
                saw_round = False
        if not saw_round and time.time() - started > 120:
            kill_tree(proc.pid)
            if LOG.exists():
                shutil.copyfile(LOG, dest)
            if not save_matches():
                restore_save()
            print(f"COMPILE {course_id}", flush=True)
            return 1
        if time.time() - started > limit:
            kill_tree(proc.pid)
            if LOG.exists():
                shutil.copyfile(LOG, dest)
            if not save_matches():
                restore_save()
            print(f"STUCK {course_id}", flush=True)
            return 3
        time.sleep(2)
    if LOG.exists():
        shutil.copyfile(LOG, dest)
    text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
    if "RIDECERT done" not in text:
        if not save_matches():
            restore_save()
        print(f"NO DONE {course_id} exit={proc.returncode}", flush=True)
        return 1
    print(f"COPIED {dest.name}", flush=True)
    return 0


def main() -> int:
    DAY6.mkdir(parents=True, exist_ok=True)
    if not SNAP.exists():
        print("NO SNAPSHOT", flush=True)
        return 1
    for course_id in IDS:
        dest = DAY6 / f"{course_id}.style.log"
        if dest.exists() and "RIDECERT done" in dest.read_text(encoding="utf-8", errors="replace"):
            bad = judge(course_id, dest)
            if not bad and save_matches():
                print(f"SKIP {course_id}", flush=True)
                continue
            if bad:
                print(f"FAIL {course_id} existing log", flush=True)
                for line in bad:
                    print(line, flush=True)
                return 1
        status = ride(course_id)
        if status == 4:
            return 4
        if status == 3:
            print(f"RETRY {course_id}", flush=True)
            status = ride(course_id)
            if status == 3:
                with DAY_LOG.open("a", encoding="utf-8", newline="\n") as handle:
                    handle.write(f"\nSTUCK {course_id} after one retry. Go on.\n")
                print(f"STUCK-WROTE {course_id}", flush=True)
                continue
        if status != 0:
            return status
        if not save_matches():
            restore_save()
            wrote = DAY6 / f"{course_id}.style.wrote.log"
            if dest.exists():
                shutil.copyfile(dest, wrote)
            print(f"SAVE {course_id} differed. Snapshot restored.", flush=True)
            return 2
        bad = judge(course_id, dest)
        if bad:
            print(f"FAIL {course_id}", flush=True)
            for line in bad:
                print(line, flush=True)
            return 1
        append_rows(course_id, dest)
        print(f"KEEP {course_id}", flush=True)
    print("DONE day6", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
