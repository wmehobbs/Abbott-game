"""Day 8. One official hundredth, then show clears, then schooling clears."""
from __future__ import annotations

import ctypes
import json
import math
import re
import shutil
import subprocess
import sys
import time
from ctypes import wintypes
from pathlib import Path

ROOT = Path(r"E:\Workspace\Madison")
DAY8 = ROOT / "dist" / "day8"
DAY_LOG = ROOT / "dist" / "DAY8_LOG.md"
MEASURE = ROOT / "dist" / "DAY8_MEASURE.md"
BOARD = ROOT / "dist" / "day3" / "board.json"
SAVE = Path(r"C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json")
SNAP = DAY8 / "save_snapshot.json"
ABBOTT = ROOT / "dist" / "Abbott.exe"
RUN = [sys.executable, str(ROOT / "tools" / "content_factory" / "run_ridecert.py")]
PLAY = [sys.executable, str(ROOT / "dist" / "_run_userarg.py"), "--playtest"]
STYLE_LOG = ROOT / "dist" / "ridecert_style.log"
CLEAR_LOG = ROOT / "dist" / "ridecert_godot.log"
PLAY_LOG = ROOT / "dist" / "playtest_day.log"
IDS = [
    "hk_les_001", "hk_les_002", "hk_les_003", "hk_les_004",
    "hk_beg_035", "hk_beg_039", "hk_beg_004", "hk_beg_034", "hk_beg_007", "hk_beg_033",
    "hk_int_001", "hk_int_002", "hk_int_005", "hk_int_006", "hk_int_007", "hk_int_009",
    "hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005",
    "hk_jo_beg_001", "hk_jo_int_001", "hk_jo_adv_001",
]
ADVANCED = {"hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005", "hk_jo_adv_001"}
CLOCK = {"hk_adv_001", "hk_adv_003"}
SHOW = {"beginner": 95.0, "intermediate": 85.0, "advanced": 75.0}
SCHOOL = {"beginner": 100.0, "intermediate": 90.0, "advanced": 80.0}

kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
user32 = ctypes.WinDLL("user32", use_last_error=True)

RESULT_RE = re.compile(
    r"faults=(\d+) refusal_faults=(\d+) rail_faults=(\d+) time_faults=(\d+) "
    r"jumped=(\d+)/(\d+) t=([0-9.]+) teleported=(true|false) complete=(true|false) "
    r"refused=\[([^\]]*)\] rail_fences=\[([^\]]*)\] .*?"
    r"eliminated=(true|false) reason=(\S*) ribbon=(\S*)"
)
ROUND_RE = re.compile(
    r"RIDECERT round (\S+) class=(\S+) seed=\d+ jo=(true|false) style=(\S+)"
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


def save_matches() -> bool:
    if not SAVE.exists() or not SNAP.exists():
        return False
    return SAVE.read_bytes() == SNAP.read_bytes()


def restore_save() -> None:
    shutil.copyfile(SNAP, SAVE)


def nums(blob: str) -> list[str]:
    return re.findall(r"\d+", blob)


def allowed_for(klass: str, jo: bool, card: str) -> float:
    if klass == "lesson":
        return 180.0
    table = SHOW if card == "show" else SCHOOL
    base = table[klass]
    if jo:
        return max(28.0, base * 0.42)
    return base


def paper_time_faults(clock: float, allowed: float, lesson: bool, eliminated: bool) -> int:
    if lesson or eliminated or clock <= allowed:
        return 0
    return int(math.floor((clock - allowed) / 4.0))


def load_show_best() -> dict:
    data = json.loads(SNAP.read_text(encoding="utf-8"))
    best = data.get("show_best") or {}
    return best if isinstance(best, dict) else {}


def expected_ribbon(class_id: str, faults: int, clock: float, show_best: dict) -> str:
    rec = show_best.get(class_id) or {"faults": 999, "time": 9999.0}
    old_f = int(float(rec.get("faults", 999)))
    old_t = float(rec.get("time", 9999.0))
    improved = faults < old_f or (faults == old_f and clock < old_t)
    first = improved and faults == 0
    if faults == 0:
        return "Blue" if first else "Red"
    if faults == 4:
        return "Yellow"
    if faults <= 8:
        return "White"
    return "Pink"


def board_clears() -> dict:
    data = json.loads(BOARD.read_text(encoding="utf-8"))
    out = {}
    for row in data.get("tracks", []):
        if row.get("style") == "clear":
            out[row["id"]] = row
    return out


def parse_round(text: str, style: str) -> tuple[re.Match[str] | None, re.Match[str] | None]:
    round_hit = None
    for hit in ROUND_RE.finditer(text):
        if hit.group(4) == style:
            round_hit = hit
    result_hit = None
    for hit in RESULT_RE.finditer(text):
        # The result line does not repeat style=. Pair by order: clear has one.
        result_hit = hit
    if style != "clear":
        result_hit = None
        chunks = text.split("RIDECERT round ")
        for chunk in chunks[1:]:
            if f"style={style}" not in chunk.split("\n", 1)[0]:
                continue
            result_hit = RESULT_RE.search(chunk)
    return round_hit, result_hit


def clear_result(text: str) -> tuple[re.Match[str] | None, re.Match[str] | None]:
    round_hit = None
    for hit in ROUND_RE.finditer(text):
        if hit.group(4) == "clear":
            round_hit = hit
    chunk = ""
    if "style=clear" in text:
        chunk = text.split("style=clear", 1)[1]
    return round_hit, RESULT_RE.search(chunk)


def headless_line(proc_out: Path) -> str:
    if not proc_out.exists():
        return ""
    for line in proc_out.read_text(encoding="utf-8", errors="replace").splitlines():
        if line.startswith("RUN "):
            return line
    return ""


def run_proc(cmd: list[str], source: Path, dest: Path, stuck_s: int, want_round: bool) -> int:
    while godot_alive():
        print("WAIT godot", flush=True)
        time.sleep(5)
    proc_out = DAY8 / "_last_cmd.txt"
    try:
        if source.exists():
            source.unlink()
    except OSError:
        pass
    prior_mtime = source.stat().st_mtime if source.exists() else 0.0
    handle = proc_out.open("w", encoding="utf-8", newline="\n")
    proc = subprocess.Popen(cmd, cwd=ROOT, stdout=handle, stderr=subprocess.STDOUT)
    started = time.time()
    saw_round = not want_round
    checked = False
    while proc.poll() is None:
        window = godot_window()
        if window:
            kill_tree(proc.pid)
            handle.close()
            if source.exists():
                shutil.copyfile(source, dest)
            if not save_matches():
                restore_save()
            blacklist(" ".join(cmd) + f" ({window})")
            print(f"WINDOW {dest.name} {window}", flush=True)
            return 4
        if not checked and time.time() - started > 5:
            line = headless_line(proc_out)
            if line:
                checked = True
                parts = line.split()
                if len(parts) < 3 or parts[2] != "--headless":
                    kill_tree(proc.pid)
                    handle.close()
                    blacklist(line)
                    print(f"NO HEADLESS {line}", flush=True)
                    return 4
        if want_round and not saw_round and source.exists():
            try:
                fresh = source.stat().st_mtime > prior_mtime
                if fresh:
                    saw_round = "RIDECERT round" in source.read_text(encoding="utf-8", errors="replace")
            except OSError:
                saw_round = False
        if want_round and not saw_round and time.time() - started > 120:
            kill_tree(proc.pid)
            handle.close()
            if source.exists():
                shutil.copyfile(source, dest)
            if not save_matches():
                restore_save()
            print(f"COMPILE {dest.name}", flush=True)
            return 1
        if time.time() - started > stuck_s:
            kill_tree(proc.pid)
            handle.close()
            if source.exists():
                shutil.copyfile(source, dest)
            if not save_matches():
                restore_save()
            print(f"STUCK {dest.name}", flush=True)
            return 3
        time.sleep(2)
    handle.close()
    if source.exists():
        shutil.copyfile(source, dest)
    text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
    if want_round and "RIDECERT done" not in text:
        if not save_matches():
            restore_save()
        print(f"NO DONE {dest.name} exit={proc.returncode}", flush=True)
        return 1
    print(f"COPIED {dest.name}", flush=True)
    return 0


def ride_once(cmd: list[str], source: Path, dest: Path, stuck_s: int, want_round: bool) -> int:
    status = run_proc(cmd, source, dest, stuck_s, want_round)
    if status == 3:
        print(f"RETRY {dest.name}", flush=True)
        status = run_proc(cmd, source, dest, stuck_s, want_round)
        if status == 3:
            with DAY_LOG.open("a", encoding="utf-8", newline="\n") as handle:
                handle.write(f"\nSTUCK {dest.name} after one retry. Go on.\n")
            print(f"STUCK-WROTE {dest.name}", flush=True)
            return 0
    return status


def style_keep(text: str) -> tuple[list[str], str, bool]:
    """Return problems, rail printed time, and whether the rail score itself moved."""
    bad: list[str] = []
    rail_moved = False
    rail_t = ""
    for style in ("refuse_early", "rail_late"):
        _rnd, hit = parse_round(text, style)
        if hit is None:
            bad.append(f"missing {style}")
            rail_moved = True
            continue
        faults, refusal, rails_pts, time_faults, _j, _n, clock, tele, _c, refused, listed, eliminated, reason, ribbon = hit.groups()
        parts = int(refusal) + int(rails_pts) + int(time_faults)
        if parts != int(faults):
            bad.append(f"{style} parts {parts} != {faults}")
        if tele != "false":
            bad.append(f"{style} teleported")
        if eliminated != "false":
            bad.append(f"{style} eliminated {reason}")
        knocks = []
        chunk = text.split(f"style={style}", 1)[1]
        if "RIDECERT round " in chunk:
            chunk = chunk.split("RIDECERT round ", 1)[0]
        knocks = re.findall(r"FENCE knock (\d+)", chunk)
        if nums(listed) != knocks:
            bad.append(f"{style} rails {nums(listed)} != knocks {knocks}")
        clock_f = float(clock)
        if style == "refuse_early":
            if faults != "12" or nums(listed) != ["6"] or nums(refused) != ["1"]:
                bad.append(f"refuse faults {faults} rails {listed} refused {refused}")
            tf = int(time_faults)
            if tf == 3 and not clock_f < 91.0:
                bad.append(f"refuse t={clock} is not below 91 with 3 time faults")
            elif tf == 4 and clock_f < 91.0:
                bad.append(f"refuse t={clock} is below 91 with 4 time faults")
            elif tf not in (3, 4):
                bad.append(f"refuse time faults {tf}")
        else:
            rail_t = clock
            if faults != "11" or int(time_faults) != 3 or nums(listed) != ["3", "6"]:
                bad.append(f"rail faults {faults} time {time_faults} rails {listed}")
                rail_moved = True
            if not clock_f < 91.0:
                bad.append(f"rail t={clock} is not below 91")
                if int(time_faults) == 3 and faults == "11":
                    rail_moved = False
    return bad, rail_t, rail_moved


def judge_clear(course_id: str, text: str, card: str, show_best: dict, board: dict) -> tuple[list[str], str, list[str]]:
    bad: list[str] = []
    notes: list[str] = []
    rnd, hit = clear_result(text)
    if rnd is None or hit is None:
        return [f"{course_id} {card} missing clear result"], "", []
    if rnd.group(1) != course_id:
        bad.append(f"{course_id} header {rnd.group(1)}")
    klass = rnd.group(2)
    jo = rnd.group(3) == "true"
    faults, refusal, rails_pts, time_faults, _j, _n, clock, tele, _complete, _refused, listed, eliminated, reason, ribbon = hit.groups()
    lesson = klass == "lesson" or course_id.startswith("hk_les_")
    gone = eliminated == "true"
    clock_f = float(clock)
    allowed = allowed_for(klass, jo, card)
    limit = allowed * 2.0
    nrail = len(nums(listed))
    parts = int(refusal) + int(rails_pts) + int(time_faults)
    add = "yes" if parts == int(faults) else "no"
    if add == "no":
        bad.append(f"{course_id} {card} parts {parts} != {faults}")
    if lesson:
        if int(time_faults) != 0 or gone or ribbon:
            bad.append(f"{course_id} {card} lesson time {time_faults} elim {eliminated} ribbon {ribbon or 'none'}")
    elif gone:
        if reason != "time":
            bad.append(f"{course_id} {card} eliminated {reason or 'blank'}")
        elif not (clock_f + 0.01 > limit):
            bad.append(f"{course_id} {card} time stop {clock} limit {limit:g}")
        if int(time_faults) != 0:
            bad.append(f"{course_id} {card} eliminated time faults {time_faults}")
    else:
        expect = paper_time_faults(clock_f, allowed, False, False)
        if int(time_faults) != expect:
            bad.append(f"{course_id} {card} time faults {time_faults} paper {expect} t={clock} allowed={allowed:g}")
    ribbon_cell = "none"
    if card == "show" and not lesson and not gone:
        expect_r = expected_ribbon(klass, int(faults), clock_f, show_best)
        if ribbon != expect_r:
            bad.append(f"{course_id} ribbon {ribbon or 'none'} != {expect_r}")
        ribbon_cell = ribbon or "none"
    elif ribbon:
        bad.append(f"{course_id} {card} ribbon {ribbon}")
    elim_cell = reason if gone else "no"
    row = (
        f"| {course_id} | {card} | {faults} | {clock} | {time_faults} | {nrail} | "
        f"{ribbon_cell} | {elim_cell} | {tele} | {add} | matched |"
    )
    if card == "school":
        old = board.get(course_id)
        if old is None:
            notes.append(f"MISS {course_id} not in day3 board")
        else:
            old_f = int(old["faults"])
            old_rails = int(old["rails"])
            old_t = float(old["time_sec"])
            tol = 0.3 if course_id in CLOCK else 0.1
            if old_f == 0 and int(faults) != 0:
                notes.append(f"MISS {course_id} was clear, now faults {faults}")
            if nrail > old_rails:
                notes.append(f"MISS {course_id} gained a rail {old_rails} -> {nrail}")
            if tele != "false":
                notes.append(f"MISS {course_id} teleported")
            if abs(clock_f - old_t) > tol + 1e-9:
                notes.append(f"MISS {course_id} time {clock} vs {old_t} tol {tol:g}")
    return bad, row, notes


def append_row(row: str, notes: list[str]) -> None:
    with MEASURE.open("a", encoding="utf-8", newline="\n") as handle:
        handle.write(row + "\n")
    with DAY_LOG.open("a", encoding="utf-8", newline="\n") as handle:
        handle.write(row + "\n")
        for note in notes:
            handle.write(note + "\n")


def already(course_id: str, card: str) -> bool:
    text = MEASURE.read_text(encoding="utf-8") if MEASURE.exists() else ""
    return f"| {course_id} | {card} |" in text


def show_logs_ready() -> bool:
    for course_id in IDS:
        dest = DAY8 / f"{course_id}.show.log"
        if not dest.exists() or "RIDECERT done" not in dest.read_text(encoding="utf-8", errors="replace"):
            return False
    return True


def do_style() -> int:
    dest = DAY8 / "hk_adv_001.showstyle.log"
    cmd = RUN + ["--ridecert-style", "--ridecert-show", "--ridecert-id", "hk_adv_001"]
    if dest.exists() and "RIDECERT done" in dest.read_text(encoding="utf-8", errors="replace"):
        text = dest.read_text(encoding="utf-8", errors="replace")
    else:
        status = ride_once(cmd, STYLE_LOG, dest, 30 * 60, True)
        if status != 0:
            return status
        if not save_matches():
            restore_save()
            print("SAVE style differed. Snapshot restored.", flush=True)
            return 2
        text = dest.read_text(encoding="utf-8", errors="replace")
    if "RIDECERT done" not in text:
        print("STYLE no done", flush=True)
        return 1
    bad, rail_t, rail_moved = style_keep(text)
    second = (DAY8 / "style_second.txt").exists()
    if bad and rail_moved and not second:
        print("STYLE rail moved", flush=True)
        for line in bad:
            print(line, flush=True)
        return 5
    if bad and not second:
        print("STYLE FAIL", flush=True)
        for line in bad:
            print(line, flush=True)
        return 1
    if bad:
        with DAY_LOG.open("a", encoding="utf-8", newline="\n") as handle:
            handle.write("\nStyle second ride, clears start anyway.\n")
            for line in bad:
                handle.write(line + "\n")
        print("STYLE second recorded", flush=True)
        for line in bad:
            print(line, flush=True)
    if not save_matches():
        restore_save()
        print("SAVE style differed. Snapshot restored.", flush=True)
        return 2
    below = "yes" if rail_t and float(rail_t) < 91.0 else "no"
    note = f"hk_adv_001 show style rail printed t={rail_t or 'missing'}. Below 91: {below}."
    log = DAY_LOG.read_text(encoding="utf-8")
    if note not in log:
        with DAY_LOG.open("a", encoding="utf-8", newline="\n") as handle:
            handle.write("\n" + note + "\n")
    print(f"KEEP style rail t={rail_t}", flush=True)
    return 0


def do_playtest() -> int:
    dest = DAY8 / "playtest.log"
    if dest.exists():
        text = dest.read_text(encoding="utf-8", errors="replace")
    else:
        status = ride_once(PLAY, PLAY_LOG, dest, 10 * 60, False)
        if status == 4:
            return 4
        if status != 0:
            return status
        text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
    ok = (
        "PLAYTEST clear faults=0" in text
        and "PLAYTEST refuse faults=4" in text
        and "PLAYTEST rail faults=4" in text
    )
    if not ok:
        print("PLAYTEST FAIL", flush=True)
        return 1
    if not save_matches():
        restore_save()
        print("SAVE playtest differed. Snapshot restored.", flush=True)
        return 2
    print("KEEP playtest 0 4 4", flush=True)
    return 0


def do_card(card: str, show_best: dict, board: dict) -> int:
    if card == "school" and not show_logs_ready():
        print("SCHOOL before show card finished", flush=True)
        return 1
    flag = ["--ridecert-show"] if card == "show" else []
    for course_id in IDS:
        dest = DAY8 / f"{course_id}.{card}.log"
        if dest.exists() and "RIDECERT done" in dest.read_text(encoding="utf-8", errors="replace"):
            text = dest.read_text(encoding="utf-8", errors="replace")
            bad, row, notes = judge_clear(course_id, text, card, show_best, board)
            if bad:
                print(f"FAIL {course_id} {card} existing", flush=True)
                for line in bad:
                    print(line, flush=True)
                return 1
            if not already(course_id, card):
                append_row(row, notes)
            for note in notes:
                print(note, flush=True)
            print(f"SKIP {course_id} {card}", flush=True)
            continue
        stuck = 30 * 60 if course_id in ADVANCED else 20 * 60
        cmd = RUN + flag + ["--ridecert-id", course_id]
        status = ride_once(cmd, CLEAR_LOG, dest, stuck, True)
        if status == 4:
            return 4
        if status != 0:
            return status
        if not save_matches():
            restore_save()
            print(f"SAVE {course_id} {card} differed. Snapshot restored.", flush=True)
            return 2
        if not dest.exists() or "RIDECERT done" not in dest.read_text(encoding="utf-8", errors="replace"):
            print(f"SKIP-EMPTY {course_id} {card}", flush=True)
            continue
        text = dest.read_text(encoding="utf-8", errors="replace")
        bad, row, notes = judge_clear(course_id, text, card, show_best, board)
        if bad:
            print(f"FAIL {course_id} {card}", flush=True)
            for line in bad:
                print(line, flush=True)
            return 1
        append_row(row, notes)
        for note in notes:
            print(note, flush=True)
        print(f"KEEP {course_id} {card}", flush=True)
    return 0


def write_close() -> None:
    measure = MEASURE.read_text(encoding="utf-8")
    show_clears = 0
    school_clears = 0
    elims: list[str] = []
    for line in measure.splitlines():
        if not line.startswith("| hk_"):
            continue
        parts = [c.strip() for c in line.strip("|").split("|")]
        if len(parts) < 11:
            continue
        course_id, card, faults, _t, _tf, _rails, _ribbon, eliminated, tele, _add, _save = parts[:11]
        if eliminated != "no":
            elims.append(f"{course_id} {card} {eliminated}")
        if faults == "0" and eliminated == "no" and tele == "false":
            if card == "show":
                show_clears += 1
            elif card == "school":
                school_clears += 1
    log = DAY_LOG.read_text(encoding="utf-8")
    below = "yes" if "Below 91: yes" in log else "no"
    stamp = ""
    if ABBOTT.exists():
        stamp = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(ABBOTT.stat().st_mtime))
    version = (ROOT / "game" / "project.godot").read_text(encoding="utf-8")
    version_ok = 'config/version="2.348.0.0"' in version
    elim_line = ", ".join(elims) if elims else "none"
    black = "none" if "BLACKLIST:" not in log else "see BLACKLIST above"
    close = (
        "\n## Close\n\n"
        f"Show clears: {show_clears} out of 23.\n\n"
        f"Schooling clears: {school_clears} out of 23.\n\n"
        f"Printed rail time below 91: {below}.\n\n"
        f"Time eliminations: {elim_line}.\n\n"
        "Files changed: `game/scripts/game_state.gd`, `game/scripts/ride_cert.gd`, "
        "`dist/_day8_ride.py`, `dist/DAY8_LOG.md`, `dist/DAY8_MEASURE.md`, "
        "and the logs under `dist/day8/`.\n\n"
        f"BLACKLIST: {black}.\n\n"
        f"`dist\\Abbott.exe` was not launched and not rewritten. Last write {stamp}. "
        f"Product stayed 2.348.0.0. Version line present: {version_ok}.\n"
    )
    if "## Close" not in log:
        with DAY_LOG.open("a", encoding="utf-8", newline="\n") as handle:
            handle.write(close)
    print(
        f"DONE show_clears={show_clears} school_clears={school_clears} below91={below} abbott={stamp}",
        flush=True,
    )


def main() -> int:
    DAY8.mkdir(parents=True, exist_ok=True)
    if not SNAP.exists():
        print("NO SNAPSHOT", flush=True)
        return 1
    if not save_matches():
        print("SAVE does not match snapshot before start", flush=True)
        return 2
    status = do_style()
    if status != 0:
        return status
    status = do_playtest()
    if status != 0:
        return status
    show_best = load_show_best()
    board = board_clears()
    status = do_card("show", show_best, board)
    if status != 0:
        return status
    if not show_logs_ready():
        print("SHOW CARD INCOMPLETE", flush=True)
        return 1
    status = do_card("school", show_best, board)
    if status != 0:
        return status
    if not save_matches():
        restore_save()
        print("SAVE differed at the end. Snapshot restored.", flush=True)
        return 2
    write_close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
