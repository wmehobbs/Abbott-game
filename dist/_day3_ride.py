"""Ride the day-3 list one Godot at a time. Copy each log before the next id."""
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
DAY3 = ROOT / "dist" / "day3"
LOG = ROOT / "dist" / "ridecert_godot.log"
MEASURE = ROOT / "dist" / "DAY3_MEASURE.md"
RUN = [sys.executable, str(ROOT / "tools" / "content_factory" / "run_ridecert.py")]
IDS = [
    "hk_les_001",
    "hk_les_002",
    "hk_les_003",
    "hk_les_004",
    "hk_beg_035",
    "hk_beg_039",
    "hk_beg_004",
    "hk_beg_034",
    "hk_beg_007",
    "hk_beg_033",
    "hk_int_001",
    "hk_int_002",
    "hk_int_005",
    "hk_int_006",
    "hk_int_007",
    "hk_int_009",
    "hk_adv_001",
    "hk_adv_002",
    "hk_adv_003",
    "hk_adv_005",
    "hk_jo_beg_001",
    "hk_jo_int_001",
    "hk_jo_adv_001",
]

kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
user32 = ctypes.WinDLL("user32", use_last_error=True)


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
    out = subprocess.run(
        ["tasklist", "/FI", "IMAGENAME eq Godot_v4.7.2-stable_win64.exe", "/NH"],
        capture_output=True,
        text=True,
    )
    text = (out.stdout or "") + (out.stderr or "")
    if "Godot_v4.7.2-stable_win64.exe" in text:
        return True
    out = subprocess.run(
        ["tasklist", "/FI", "IMAGENAME eq Godot_v4.7.2-stable_win64_console.exe", "/NH"],
        capture_output=True,
        text=True,
    )
    text = (out.stdout or "") + (out.stderr or "")
    return "Godot_v4.7.2-stable_win64_console.exe" in text


def finished(path: Path) -> bool:
    if not path.exists():
        return False
    text = path.read_text(encoding="utf-8", errors="replace")
    return "RIDECERT round" in text and " faults=" in text and "teleported=" in text


def append_row(course_id: str, log_path: Path) -> None:
    proc = subprocess.run(
        [sys.executable, str(ROOT / "dist" / "_day3_row.py"), str(log_path)],
        cwd=ROOT,
        capture_output=True,
        text=True,
        encoding="utf-8",
    )
    if proc.returncode != 0:
        raise SystemExit(proc.stderr.strip() or proc.stdout.strip() or f"row failed {course_id}")
    measure = MEASURE.read_text(encoding="utf-8")
    if f"| {course_id} |" not in measure:
        row = proc.stdout.splitlines()[0]
        with MEASURE.open("a", encoding="utf-8", newline="\n") as handle:
            handle.write(row + "\n")
    silent = ROOT / "dist" / "day3" / "silent.txt"
    blob = silent.read_text(encoding="utf-8") if silent.exists() else ""
    if f"SILENT_DETAIL {course_id}\n" not in blob:
        with silent.open("a", encoding="utf-8", newline="\n") as handle:
            handle.write(proc.stdout)
            if not proc.stdout.endswith("\n"):
                handle.write("\n")


def blacklist(cmd: str) -> None:
    with (ROOT / "dist" / "DAY4_LOG.md").open("a", encoding="utf-8", newline="\n") as handle:
        handle.write(f"\nBLACKLIST: {cmd}\n")


def ride(
    course_id: str,
    suffix: str = ".log",
    record: bool = True,
    extra: list[str] | None = None,
    log_path: Path | None = None,
    folder: Path | None = None,
    notes: bool = True,
    max_sec: float | None = None,
) -> int:
    if godot_alive():
        print(f"FAILED godot already live before {course_id}", flush=True)
        return 2
    dest = (folder or DAY3) / f"{course_id}{suffix}"
    source = log_path or LOG
    proc = subprocess.Popen(
        RUN + (extra or []) + ["--ridecert-id", course_id],
        cwd=ROOT,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
    started = time.time()
    saw_round = False
    while proc.poll() is None:
        window = godot_window()
        if window:
            subprocess.run(
                ["taskkill", "/PID", str(proc.pid), "/T", "/F"],
                capture_output=True,
            )
            blacklist(
                f"python tools/content_factory/run_ridecert.py --ridecert-id {course_id} ({window})"
            )
            print(f"WINDOW {course_id} {window}", flush=True)
            return 4
        if not saw_round and source.exists():
            try:
                saw_round = "RIDECERT round" in source.read_text(encoding="utf-8", errors="replace")
            except OSError:
                saw_round = False
        if max_sec is not None and time.time() - started > max_sec:
            subprocess.run(
                ["taskkill", "/PID", str(proc.pid), "/T", "/F"],
                capture_output=True,
            )
            print(f"STUCK {course_id}", flush=True)
            return 3
        if not saw_round and time.time() - started > 120:
            subprocess.run(
                ["taskkill", "/PID", str(proc.pid), "/T", "/F"],
                capture_output=True,
            )
            print(f"FAILED no RIDECERT round {course_id}", flush=True)
            return 1
        time.sleep(5)
    code = proc.wait()
    if not source.exists():
        print(f"FAILED exit {code} missing log {course_id}", flush=True)
        return 1
    shutil.copyfile(source, dest)
    text = dest.read_text(encoding="utf-8", errors="replace")
    if not finished(dest) or "SCRIPT ERROR" in text or "Parse Error" in text:
        print(f"FAILED exit {code} incomplete log {course_id}", flush=True)
        return 1
    if notes and record:
        append_row(course_id, dest)
    elif notes:
        proc_row = subprocess.run(
            [sys.executable, str(ROOT / "dist" / "_day3_row.py"), str(dest)],
            cwd=ROOT,
            capture_output=True,
            text=True,
            encoding="utf-8",
        )
        if proc_row.returncode != 0:
            print(proc_row.stderr.strip() or proc_row.stdout.strip(), flush=True)
            return 1
        with (DAY3 / "after_rows.txt").open("a", encoding="utf-8", newline="\n") as handle:
            handle.write(proc_row.stdout)
            if not proc_row.stdout.endswith("\n"):
                handle.write("\n")
    if notes:
        (DAY3 / "progress.txt").write_text(course_id + suffix + "\n", encoding="utf-8")
    return 0


AFTER_IDS = [
    "hk_les_001", "hk_les_002", "hk_les_003", "hk_les_004",
    "hk_beg_035", "hk_beg_039", "hk_beg_004", "hk_beg_034", "hk_beg_007", "hk_beg_033",
    "hk_int_001", "hk_int_002", "hk_int_006", "hk_int_007", "hk_int_009",
    "hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005",
]


RESULT_RE = re.compile(
    r"RIDECERT (hk_\S+) style=(\S+) success=\S+ faults=(\d+) jumped=(\d+)/(\d+) "
    r"t=[0-9.]+ teleported=(true|false) complete=(true|false) "
    r"refused=(\[[^\]]*\]) rail_fences=(\[[^\]]*\])"
)
COUNT_RE = re.compile(r"COUNT fence=(\d+) .*stride=(-?\d+)")
KNOCK_RE = re.compile(r"FENCE knock (\d+)")
FENCE_JUMP_RE = re.compile(r"RIDEAI fence (\d+) ->")
SIT_RE = re.compile(r"RIDEAI sit n=(\d+)")
COME = "MICHELLE soft | Come again."
# _run_style_all rails fence 3 whenever the class need is at least 3, jump-offs included.
STYLE_FENCE = "3"


def straight_fences(course_id: str) -> set[str]:
    path = ROOT / "dist" / "night" / f"{course_id}.clear.log"
    found: set[str] = set()
    if not path.exists():
        return found
    for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        hit = COUNT_RE.search(line)
        if hit and int(hit.group(2)) >= 0:
            found.add(hit.group(1))
    return found


def style_logged(course_id: str) -> bool:
    measure = ROOT / "dist" / "NIGHT_MEASURE.md"
    text = measure.read_text(encoding="utf-8") if measure.exists() else ""
    if "## Style" not in text:
        return False
    return f"| {course_id} |" in text.split("## Style", 1)[1]


def judge_style(course_id: str, log_path: Path) -> tuple[str, str]:
    text = log_path.read_text(encoding="utf-8", errors="replace")
    refuse_b = ""
    rail_b = ""
    for block in text.split("RIDECERT round ")[1:]:
        head = block.split("\n", 1)[0]
        if "style=refuse_early" in head:
            refuse_b = block
        elif "style=rail_late" in head:
            rail_b = block
    if not refuse_b or not rail_b or "RIDECERT done" not in text:
        return f"| {course_id} | | | | | no | | unfinished |", "fail"
    ref = RESULT_RE.search(refuse_b)
    rail = RESULT_RE.search(rail_b)
    if not ref or not rail:
        return f"| {course_id} | | | | | no | | no result line |", "fail"
    refused_1 = "1" in re.findall(r"\d+", ref.group(8))
    saw_refuse = False
    jumped_after = False
    presented_1 = False
    for line in refuse_b.splitlines():
        jump = FENCE_JUMP_RE.search(line)
        if jump and jump.group(1) == "1":
            presented_1 = True
            if saw_refuse:
                jumped_after = True
        if "RIDECERT refuse" in line:
            saw_refuse = True
    knocks = KNOCK_RE.findall(rail_b)
    knocked = STYLE_FENCE in knocks
    in_list = STYLE_FENCE in re.findall(r"\d+", rail.group(9))
    presented_rail = False
    for line in rail_b.splitlines():
        jump = FENCE_JUMP_RE.search(line)
        if jump and jump.group(1) == STYLE_FENCE:
            presented_rail = True
    come_straight: list[str] = []
    straight = straight_fences(course_id)
    for block in (refuse_b, rail_b):
        cur = ""
        for line in block.splitlines():
            sit = SIT_RE.search(line)
            if sit:
                cur = sit.group(1)
            count = COUNT_RE.search(line)
            if count:
                cur = count.group(1)
            if line.strip() == COME and cur in straight and cur not in come_straight:
                come_straight.append(cur)
    tele = ref.group(6) == "true" or rail.group(6) == "true"
    complete = (
        ref.group(7) == "true"
        and rail.group(7) == "true"
        and ref.group(4) == ref.group(5)
        and rail.group(4) == rail.group(5)
    )
    if knocked and in_list:
        knock_cell = "yes " + STYLE_FENCE
    elif knocked:
        knock_cell = "yes, list empty"
    else:
        knock_cell = "no"
    row = (
        f"| {course_id} | {ref.group(3)} | {'yes' if jumped_after else 'no'} | {knock_cell} | "
        f"{rail.group(3)} | {'yes' if complete else 'no'} | {'yes' if tele else 'no'} | "
        f"{','.join(come_straight) if come_straight else 'none'} |"
    )
    if tele or not complete:
        return row, "fail"
    if not refused_1:
        return row, "ate-refuse" if presented_1 else "planner-refuse"
    if not jumped_after:
        return row, "fail"
    if not knocked:
        return row, "ate-knock" if presented_rail else "planner-rail"
    return row, "keep"


def append_style(row: str, decision: str) -> None:
    measure = ROOT / "dist" / "NIGHT_MEASURE.md"
    text = measure.read_text(encoding="utf-8")
    if "## Style" not in text:
        text = text.rstrip() + (
            "\n\n## Style\n\n"
            "Refuse fence 1, rail fence 3, including jump-offs. That is `_run_style_all`. It was not changed.\n\n"
            "| id | refuse faults | refuse fence jumped again | rail knocked | rail faults | round complete | teleported | Come again on a straight fence |\n"
            "| --- | --- | --- | --- | --- | --- | --- | --- |\n"
        )
        measure.write_text(text, encoding="utf-8", newline="\n")
    with measure.open("a", encoding="utf-8", newline="\n") as handle:
        handle.write(row + "\n")
    log = ROOT / "dist" / "NIGHT_LOG.md"
    log_text = log.read_text(encoding="utf-8")
    if "## Style rows" not in log_text:
        with log.open("a", encoding="utf-8", newline="\n") as handle:
            handle.write("\n## Style rows\n\n")
    with log.open("a", encoding="utf-8", newline="\n") as handle:
        handle.write(f"{row} {decision}\n")


def night_style() -> int:
    night = ROOT / "dist" / "night"
    night.mkdir(parents=True, exist_ok=True)
    style_log = ROOT / "dist" / "ridecert_style.log"
    for course_id in IDS:
        if style_logged(course_id):
            print(f"SKIP {course_id}", flush=True)
            continue
        dest = night / f"{course_id}.style.log"
        limit = 45 * 60 if course_id.startswith("hk_adv_") else 30 * 60
        status = ride(
            course_id, ".style.log", False, ["--ridecert-style"], style_log, night, False, limit
        )
        if status == 3:
            status = ride(
                course_id, ".style.log", False, ["--ridecert-style"], style_log, night, False, limit
            )
            if status == 3:
                append_style(f"| {course_id} | | | | | no | | stuck |", "stuck twice. Go on.")
                print(f"STUCK-WROTE {course_id}", flush=True)
                continue
        if status == 4:
            print(f"WINDOW stop {course_id}", flush=True)
            return 4
        if status != 0:
            print(f"FAILED ride {course_id} status {status}", flush=True)
            return status
        row, kind = judge_style(course_id, dest)
        if kind in ("ate-refuse", "ate-knock", "fail"):
            shutil.copyfile(dest, night / f"{course_id}.style.before.log")
            print(f"FAILED {kind} {course_id}", flush=True)
            print(row, flush=True)
            return 1
        if kind == "keep":
            fences = row.rsplit("|", 2)[-2].strip()
            decision = "keep"
            if fences != "none":
                decision = (
                    f"keep. Come again on straight fence {fences}. "
                    "Morning bytes, no edit."
                )
        else:
            decision = kind + ". No edit."
        append_style(row, decision)
        print(f"ROW {course_id} {decision}", flush=True)
    print("DONE night-style", flush=True)
    return 0


def main() -> int:
    DAY3.mkdir(parents=True, exist_ok=True)
    if len(sys.argv) > 1 and sys.argv[1] == "--night-clear":
        night = ROOT / "dist" / "night"
        night.mkdir(parents=True, exist_ok=True)
        for course_id in IDS:
            dest = night / f"{course_id}.clear.log"
            if finished(dest):
                continue
            status = ride(course_id, ".clear.log", False, None, None, night)
            if status != 0:
                return status
        print("DONE night-clear", flush=True)
        return 0
    if len(sys.argv) > 1 and sys.argv[1] == "--try6":
        night = ROOT / "dist" / "night"
        night.mkdir(parents=True, exist_ok=True)
        for course_id in ("hk_les_001", "hk_beg_033", "hk_adv_001"):
            dest = night / f"{course_id}.try6.log"
            if dest.exists():
                dest.unlink()
            status = ride(course_id, ".try6.log", False, None, None, night, False)
            if status != 0:
                return status
            print(f"COPIED {dest.name}", flush=True)
        print("DONE try6", flush=True)
        return 0
    if len(sys.argv) > 1 and sys.argv[1] in ("--day4", "--day4-try5"):
        day4 = ROOT / "dist" / "day4"
        day4.mkdir(parents=True, exist_ok=True)
        suffix = ".try5.log" if sys.argv[1] == "--day4-try5" else ".log"
        for course_id in IDS:
            dest = day4 / f"{course_id}{suffix}"
            if finished(dest):
                print(f"SKIP {course_id}", flush=True)
                continue
            status = ride(course_id, suffix, False, None, None, day4, False)
            if status != 0:
                return status
            print(f"COPIED {dest.name}", flush=True)
        print("DONE " + sys.argv[1], flush=True)
        return 0
    if len(sys.argv) > 1 and sys.argv[1] == "--night-style":
        return night_style()
    if len(sys.argv) > 1 and sys.argv[1] == "--fresh":
        fresh_ids = [
            "hk_int_001", "hk_int_005", "hk_int_007", "hk_int_009",
            "hk_adv_001", "hk_adv_003",
        ]
        fresh_log = ROOT / "dist" / "ridecert_fresh.log"
        for course_id in fresh_ids:
            dest = DAY3 / f"{course_id}.fresh.log"
            if finished(dest):
                continue
            status = ride(course_id, ".fresh.log", False, ["--ridecert-fresh"], fresh_log)
            if status != 0:
                return status
        print("DONE fresh", flush=True)
        return 0
    if len(sys.argv) > 1 and sys.argv[1] == "--again":
        for course_id in IDS:
            dest = DAY3 / f"{course_id}.again.log"
            if finished(dest):
                continue
            status = ride(course_id, ".again.log", False)
            if status != 0:
                return status
        print("DONE again", flush=True)
        return 0
    if len(sys.argv) > 1 and sys.argv[1] == "--suffix":
        suffix = sys.argv[2]
        for course_id in sys.argv[3:]:
            dest = DAY3 / f"{course_id}{suffix}"
            if finished(dest):
                dest.unlink()
            status = ride(course_id, suffix, False)
            if status != 0:
                return status
        print("DONE suffix", flush=True)
        return 0
    if len(sys.argv) > 1 and sys.argv[1] == "--after":
        for course_id in AFTER_IDS:
            dest = DAY3 / f"{course_id}.after.log"
            if finished(dest):
                continue
            status = ride(course_id, ".after.log", False)
            if status != 0:
                return status
        print("DONE after", flush=True)
        return 0
    for course_id in IDS:
        dest = DAY3 / f"{course_id}.log"
        if finished(dest):
            append_row(course_id, dest)
            continue
        status = ride(course_id)
        if status != 0:
            return status
    print("DONE 23", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
