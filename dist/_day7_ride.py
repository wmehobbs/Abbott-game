"""Day 7 show list. One Godot at a time. Lessons stay lessons."""
from __future__ import annotations

import ctypes
import math
import re
import shutil
import subprocess
import sys
import time
from ctypes import wintypes
from pathlib import Path

ROOT = Path(r"E:\Workspace\Madison")
DAY7 = ROOT / "dist" / "day7"
LOG = ROOT / "dist" / "ridecert_style.log"
DAY_LOG = ROOT / "dist" / "DAY7_LOG.md"
MEASURE = ROOT / "dist" / "DAY7_MEASURE.md"
SAVE = Path(r"C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json")
SNAP = DAY7 / "save_snapshot.json"
RUN = [sys.executable, str(ROOT / "tools" / "content_factory" / "run_ridecert.py")]
IDS = [
    "hk_les_001", "hk_les_002", "hk_les_003", "hk_les_004",
    "hk_beg_035", "hk_beg_039", "hk_beg_004", "hk_beg_034", "hk_beg_007", "hk_beg_033",
    "hk_int_001", "hk_int_002", "hk_int_005", "hk_int_006", "hk_int_007", "hk_int_009",
    "hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005",
    "hk_jo_beg_001", "hk_jo_int_001", "hk_jo_adv_001",
]
ADVANCED = {"hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005"}
SHOW = {"beginner": 95.0, "intermediate": 85.0, "advanced": 75.0}

kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
user32 = ctypes.WinDLL("user32", use_last_error=True)

KNOCK_RE = re.compile(r"FENCE knock (\d+)")
RESULT_RE = re.compile(
    r"faults=(\d+) refusal_faults=(\d+) rail_faults=(\d+) time_faults=(\d+) "
    r"jumped=(\d+)/(\d+) t=([0-9.]+) teleported=(true|false) complete=(true|false) "
    r"refused=(\[[^\]]*\]) rail_fences=(\[[^\]]*\]) .* "
    r"eliminated=(true|false) reason=([^ ]*) ribbon=(\S*)"
)
ROUND_RE = re.compile(
    r"RIDECERT round \S+ class=(\S+) seed=\d+ jo=(true|false) style=(\S+)"
)


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


def save_matches() -> bool:
    if not SAVE.exists() or not SNAP.exists():
        return False
    return SAVE.read_bytes() == SNAP.read_bytes()


def restore_save() -> None:
    shutil.copyfile(SNAP, SAVE)


def allowed_for(klass: str, jo: bool) -> float:
    if klass == "lesson":
        return 180.0
    base = SHOW[klass]
    if jo:
        return max(28.0, base * 0.42)
    return base


def paper_time_faults(clock: float, allowed: float, lesson: bool, eliminated: bool) -> int:
    if lesson or eliminated or clock <= allowed:
        return 0
    return int(math.floor((clock - allowed) / 4.0))


def time_faults_match(clock_f: float, allowed: float, lesson: bool, eliminated: bool, got: int) -> bool:
    """The result prints snapped(time_sec, 0.01). finish_round floors the raw clock.

    A printed hundredth is the raw clock in [t - 0.005, t + 0.005). Accept the
    floor that clock can produce. Away from a 4-second line that set has one value.
    """
    if lesson or eliminated:
        return got == 0
    lo = clock_f - 0.005
    hi = clock_f + 0.005
    low = paper_time_faults(lo, allowed, False, False)
    high = paper_time_faults(hi - 1e-9, allowed, False, False)
    return low <= got <= high


def paper_ribbon(faults: int) -> str:
    if faults == 0:
        return "Red"
    if faults == 4:
        return "Yellow"
    if faults <= 8:
        return "White"
    return "Pink"


def blocks(text: str) -> list[tuple[str, str, bool, re.Match[str]]]:
    out = []
    current: tuple[str, str, bool] | None = None
    for line in text.splitlines():
        head = ROUND_RE.search(line)
        if head:
            current = (head.group(3), head.group(1), head.group(2) == "true")
            continue
        hit = RESULT_RE.search(line)
        if hit and current is not None:
            out.append((current[0], current[1], current[2], hit))
            current = None
    return out


def judge(course_id: str, log_path: Path) -> tuple[list[str], list[str]]:
    text = log_path.read_text(encoding="utf-8", errors="replace")
    bad: list[str] = []
    rows: list[str] = []
    if "RIDECERT done" not in text:
        return [f"{course_id} no RIDECERT done"], rows
    found = blocks(text)
    styles = [item[0] for item in found]
    if styles != ["refuse_early", "rail_late"]:
        return [f"{course_id} rounds {styles}"], rows
    lesson = course_id.startswith("hk_les_")
    for style, klass, jo, hit in found:
        (
            faults, refusal, rails_pts, time_faults, _jumped, _needed, clock, tele,
            _complete, refused, listed, eliminated, reason, ribbon,
        ) = hit.groups()
        kind = "lesson" if klass == "lesson" else "show"
        if lesson and kind != "lesson":
            bad.append(f"{course_id} {style} kind {kind}")
        if not lesson and kind != "show":
            bad.append(f"{course_id} {style} stayed {kind}")
        allowed = allowed_for(klass, jo)
        limit = allowed * 2.0
        clock_f = float(clock)
        nrail = len(nums(listed))
        nref = len(nums(refused))
        parts = int(refusal) + int(rails_pts) + int(time_faults)
        add = "yes" if parts == int(faults) else "no"
        if add == "no":
            bad.append(f"{course_id} {style} parts {refusal}+{rails_pts}+{time_faults} != {faults}")
        if tele != "false":
            bad.append(f"{course_id} {style} teleported")
        knocks = KNOCK_RE.findall(text.split(f"style={style}")[1].split("RIDECERT round ")[0])
        # Knocks belong to the round block, not the whole file. Re-slice below.
        del knocks
        round_blob = text.split(f"style={style}", 1)[1]
        if "RIDECERT round " in round_blob:
            round_blob = round_blob.split("RIDECERT round ", 1)[0]
        knocks = KNOCK_RE.findall(round_blob)
        if nums(listed) != knocks:
            bad.append(f"{course_id} {style} rail_fences {nums(listed)} != knocks {knocks}")
        gone = eliminated == "true"
        if not time_faults_match(clock_f, allowed, kind == "lesson", gone, int(time_faults)):
            bad.append(
                f"{course_id} {style} time faults {time_faults} "
                f"t={clock} allowed={allowed:g}"
            )
        ribbon_cell = ribbon if ribbon else "none"
        elim_cell = "no"
        if kind == "lesson":
            if faults != "4" or time_faults != "0":
                bad.append(f"{course_id} {style} lesson faults {faults} time {time_faults}")
            if gone or ribbon:
                bad.append(f"{course_id} {style} lesson eliminated={eliminated} ribbon={ribbon or 'none'}")
        elif gone:
            elim_cell = reason or "yes"
            if reason != "time":
                bad.append(f"{course_id} {style} eliminated {reason or 'blank'}")
            elif clock_f <= limit:
                bad.append(f"{course_id} {style} time stop at {clock} limit {limit:g}")
            if int(time_faults) != 0:
                bad.append(f"{course_id} {style} eliminated but time faults {time_faults}")
            if int(faults) != int(refusal) + int(rails_pts):
                bad.append(f"{course_id} {style} eliminated faults include time")
        else:
            expect = paper_ribbon(int(faults))
            if ribbon != expect:
                bad.append(f"{course_id} {style} ribbon {ribbon or 'none'} != {expect}")
        rows.append(
            f"| {course_id} | {style} | {kind} | {faults} | {nrail} | {nref} | {clock_f:.2f} | "
            f"{allowed:g} | {time_faults} | {elim_cell} | {ribbon_cell} | {add} | matched |"
        )
    return bad, rows


def append_kept(course_id: str, rows: list[str]) -> None:
    with MEASURE.open("a", encoding="utf-8", newline="\n") as handle:
        for row in rows:
            handle.write(row + "\n")
    with DAY_LOG.open("a", encoding="utf-8", newline="\n") as handle:
        for row in rows:
            handle.write(row + "\n")


def ride(course_id: str) -> int:
    while godot_alive():
        print(f"WAIT godot before {course_id}", flush=True)
        time.sleep(5)
    dest = DAY7 / f"{course_id}.show.log"
    limit = 45 * 60 if course_id in ADVANCED else 30 * 60
    cmd = RUN + ["--ridecert-style", "--ridecert-show", "--ridecert-id", course_id]
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
                f"--ridecert-style --ridecert-show --ridecert-id {course_id} ({window})"
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
    DAY7.mkdir(parents=True, exist_ok=True)
    if not SNAP.exists():
        print("NO SNAPSHOT", flush=True)
        return 1
    for course_id in IDS:
        dest = DAY7 / f"{course_id}.show.log"
        if dest.exists() and "RIDECERT done" in dest.read_text(encoding="utf-8", errors="replace"):
            bad, _rows = judge(course_id, dest)
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
            print(f"SAVE {course_id} differed. Snapshot restored.", flush=True)
            return 2
        bad, rows = judge(course_id, dest)
        if bad:
            print(f"FAIL {course_id}", flush=True)
            for line in bad:
                print(line, flush=True)
            return 1
        append_kept(course_id, rows)
        print(f"KEEP {course_id}", flush=True)
    print("DONE day7", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
