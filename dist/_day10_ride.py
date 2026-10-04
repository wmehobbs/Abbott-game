"""Day 10. One clear round, then the jump-off when the offer is true."""
from __future__ import annotations

import ctypes
import json
import re
import shutil
import subprocess
import sys
import time
from ctypes import wintypes
from pathlib import Path

ROOT = Path(r"E:\Workspace\Madison")
DAY = ROOT / "dist" / "day10"
DAY_LOG = ROOT / "dist" / "DAY10_LOG.md"
MEASURE = ROOT / "dist" / "DAY10_MEASURE.md"
SAVE = Path(r"C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json")
SNAP = DAY / "save_snapshot.json"
ABBOTT = ROOT / "dist" / "Abbott.exe"
STAMP = DAY / "abbott_stamp.txt"
STATUS = DAY / "_status.txt"
PIDF = DAY / "_driver.pid"
HEART = DAY / "_heartbeat.txt"
RUN = [sys.executable, str(ROOT / "tools" / "content_factory" / "run_ridecert.py")]
PLAY = [sys.executable, str(ROOT / "dist" / "_run_userarg.py"), "--playtest"]
GODOT_LOG = ROOT / "dist" / "ridecert_godot.log"
PLAY_LOG = ROOT / "dist" / "playtest_day.log"
IDS = [
    "hk_les_001", "hk_les_002", "hk_les_003", "hk_les_004",
    "hk_beg_035", "hk_beg_039", "hk_beg_004", "hk_beg_034", "hk_beg_007", "hk_beg_033",
    "hk_int_001", "hk_int_002", "hk_int_005", "hk_int_006", "hk_int_007", "hk_int_009",
    "hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005",
    "hk_jo_beg_001", "hk_jo_int_001", "hk_jo_adv_001",
]
ALREADY = {"hk_jo_beg_001", "hk_jo_int_001", "hk_jo_adv_001"}
VERSION = 'config/version="2.348.0.0"'
SHOW_ALLOWED = {"beginner": 9500, "intermediate": 8500, "advanced": 7500}
SCHOOL_ALLOWED = {"beginner": 10000, "intermediate": 9000, "advanced": 8000}

kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
user32 = ctypes.WinDLL("user32", use_last_error=True)
kernel32.GetCurrentProcessId.restype = wintypes.DWORD

RESULT_RE = re.compile(
    r"faults=(\d+) refusal_faults=(\d+) rail_faults=(\d+) time_faults=(\d+) "
    r"jumped=(\d+)/(\d+) t=([0-9.]+) teleported=(true|false) complete=(true|false) "
    r"refused=\[([^\]]*)\] rail_fences=\[([^\]]*)\] .*?"
    r"eliminated=(true|false) reason=(\S*) ribbon=(\S*)"
)
HEAD_RE = re.compile(r"^(\S+) class=(\S+) seed=\d+ jo=(true|false) style=(\S+)")


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
    if SNAP.exists():
        return SAVE.exists() and SAVE.read_bytes() == SNAP.read_bytes()
    return not SAVE.exists()


def restore_save() -> None:
    if not SNAP.exists():
        if SAVE.exists():
            SAVE.unlink()
        return
    shutil.copyfile(SNAP, SAVE)


def nums(blob: str) -> list[str]:
    return re.findall(r"\d+", blob)


def cents_of(clock: str) -> int:
    whole, _, frac = clock.partition(".")
    frac = (frac + "00")[:2]
    return int(whole) * 100 + int(frac)


def jo_allowed_cents(klass: str) -> int:
    base = SHOW_ALLOWED[klass] / 100.0
    return int(round(max(28.0, base * 0.42) * 100.0))


def jo_limit_cents(klass: str) -> int:
    return jo_allowed_cents(klass) * 2


def paper_time(clock: str, klass: str, jo: bool, show: bool, lesson: bool, eliminated: bool) -> int:
    if lesson or eliminated:
        return 0
    if jo:
        allow = jo_allowed_cents(klass)
    elif show:
        allow = SHOW_ALLOWED[klass]
    else:
        allow = SCHOOL_ALLOWED[klass]
    over = cents_of(clock) - allow
    if over <= 0:
        return 0
    return over // 400


def load_show_best() -> dict:
    if not SNAP.exists():
        return {}
    data = json.loads(SNAP.read_text(encoding="utf-8"))
    best = data.get("show_best") or {}
    return dict(best) if isinstance(best, dict) else {}


def expect_ribbon(class_id: str, faults: int, clock: str, show_best: dict, lesson: bool, eliminated: bool) -> str:
    if lesson or eliminated:
        return ""
    rec = show_best.get(class_id) or {"faults": 999, "time": 9999.0}
    old_f = int(float(rec.get("faults", 999)))
    old_t = float(rec.get("time", 9999.0))
    clock_f = cents_of(clock) / 100.0
    improved = faults < old_f or (faults == old_f and clock_f < old_t)
    if improved:
        show_best[class_id] = {"faults": faults, "time": clock_f}
    if faults == 0:
        return "Blue" if improved else "Red"
    if faults == 4:
        return "Yellow"
    if faults <= 8:
        return "White"
    return "Pink"


def abbott_stamp() -> str:
    if not ABBOTT.exists():
        return "missing"
    return time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(ABBOTT.stat().st_mtime))


def log_line(text: str) -> None:
    with DAY_LOG.open("a", encoding="utf-8", newline="\n") as handle:
        handle.write(text + "\n")


def append_row(row: str) -> None:
    with MEASURE.open("a", encoding="utf-8", newline="\n") as handle:
        handle.write(row + "\n")
    log_line(row)


def already(course_id: str) -> bool:
    text = MEASURE.read_text(encoding="utf-8") if MEASURE.exists() else ""
    return f"| {course_id} |" in text


def finish(code: int, msg: str) -> int:
    if code == 0:
        STATUS.write_text("DONE\n", encoding="utf-8")
        print("DONE " + msg, flush=True)
    else:
        STATUS.write_text(f"FAILED {msg}\n", encoding="utf-8")
        print(f"FAILED {msg}", flush=True)
    return code


def assert_safe(cmd: list[str]) -> None:
    joined = " ".join(cmd).lower()
    if (
        "abbott.exe" in joined
        or "--artshot" in joined
        or "place_fence" in joined
        or "--ridecert-refusals" in joined
        or "--ridecert-style" in joined
    ):
        raise SystemExit("refusing forbidden command")


def fresh_text(source: Path, prior_mtime: float) -> str:
    if not source.exists():
        return ""
    try:
        if source.stat().st_mtime <= prior_mtime:
            return ""
        return source.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return ""


def run_proc(cmd: list[str], source: Path, dest: Path, single_s: int, want_round: bool = True) -> int:
    assert_safe(cmd)
    while godot_alive():
        print("WAIT godot", flush=True)
        HEART.write_text(f"wait-godot {dest.name}\n", encoding="utf-8")
        time.sleep(5)
    proc_out = DAY / "_last_cmd.txt"
    try:
        if source.exists():
            source.unlink()
    except OSError:
        pass
    prior_mtime = source.stat().st_mtime if source.exists() else 0.0
    handle = proc_out.open("w", encoding="utf-8", newline="\n")
    proc = subprocess.Popen(cmd, cwd=ROOT, stdout=handle, stderr=subprocess.STDOUT)
    started = time.time()
    saw_round = False
    checked = False
    while proc.poll() is None:
        HEART.write_text(f"riding {dest.name} {int(time.time() - started)}s\n", encoding="utf-8")
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
            line = ""
            if proc_out.exists():
                for raw in proc_out.read_text(encoding="utf-8", errors="replace").splitlines():
                    if raw.startswith("RUN "):
                        line = raw
                        break
            if line:
                checked = True
                parts = line.split()
                if len(parts) < 3 or parts[2] != "--headless":
                    kill_tree(proc.pid)
                    handle.close()
                    blacklist(line)
                    print(f"NO HEADLESS {line}", flush=True)
                    return 4
        body = fresh_text(source, prior_mtime)
        if "RIDECERT round" in body or (not want_round and "PLAYTEST" in body):
            saw_round = True
        offer = "RIDECERT offer true" in body
        limit = 45 * 60 if offer else single_s
        dones = body.count("RIDECERT done")
        if not want_round:
            dones = 1 if "PLAYTEST rail faults=" in body else 0
        need = 2 if offer else 1
        if "SCRIPT ERROR" in body and dones < need:
            kill_tree(proc.pid)
            handle.close()
            if source.exists():
                shutil.copyfile(source, dest)
            if not save_matches():
                restore_save()
            print(f"COMPILE {dest.name}", flush=True)
            return 1
        if not saw_round and time.time() - started > 120:
            kill_tree(proc.pid)
            handle.close()
            if source.exists():
                shutil.copyfile(source, dest)
            if not save_matches():
                restore_save()
            print(f"COMPILE {dest.name}", flush=True)
            return 1
        if time.time() - started > limit and dones < need:
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
    print(f"COPIED {dest.name}", flush=True)
    return 0


def ride_once(cmd: list[str], source: Path, dest: Path, single_s: int, want_round: bool = True) -> int:
    status = run_proc(cmd, source, dest, single_s, want_round)
    if status == 3:
        print(f"RETRY {dest.name}", flush=True)
        status = run_proc(cmd, source, dest, single_s, want_round)
        if status == 3:
            log_line(f"STUCK {dest.name} after one retry. Go on.")
            return 0
    return status


def after_ride(status: int, dest: Path) -> int:
    if status != 0:
        return status
    if not save_matches():
        restore_save()
        print(f"SAVE {dest.name} differed. Snapshot restored.", flush=True)
        return 2
    return 0


def rounds_of(text: str) -> list[str]:
    return text.split("RIDECERT round ")[1:]


def parse_round(chunk: str) -> tuple[re.Match[str] | None, re.Match[str] | None]:
    head = HEAD_RE.match(chunk)
    return head, RESULT_RE.search(chunk)


def rails_ok(chunk: str, listed: str, rail_pts: str, bad: list[str], label: str) -> None:
    knocks = re.findall(r"FENCE knock (\d+)", chunk)
    if nums(listed) != knocks:
        bad.append(f"{label} rails {nums(listed)} != knocks {knocks}")
    if int(rail_pts) != 4 * len(knocks):
        bad.append(f"{label} rail faults {rail_pts} != {4 * len(knocks)}")


def check_round(chunk: str, label: str, show_best: dict, show: bool, bad: list[str]) -> dict | None:
    head, hit = parse_round(chunk)
    if head is None or hit is None:
        bad.append(f"{label} missing result")
        return None
    (
        faults, refusal, rail_pts, time_faults, jumped, needed, clock, tele, complete,
        _refused, listed, eliminated, reason, ribbon,
    ) = hit.groups()
    klass = head.group(2)
    jo = head.group(3) == "true"
    lesson = klass == "lesson"
    gone = eliminated == "true"
    if tele != "false":
        bad.append(f"{label} teleported")
    if int(refusal) + int(rail_pts) + int(time_faults) != int(faults):
        bad.append(f"{label} parts {refusal}+{rail_pts}+{time_faults} != {faults}")
    expect = paper_time(clock, klass, jo, show and not lesson, lesson, gone)
    if int(time_faults) != expect:
        bad.append(f"{label} time {time_faults} paper {expect} t={clock}")
    rails_ok(chunk, listed, rail_pts, bad, label)
    want_ribbon = expect_ribbon(klass, int(faults), clock, show_best, lesson or not show, gone)
    if ribbon != want_ribbon:
        bad.append(f"{label} ribbon {ribbon or 'none'} != {want_ribbon or 'none'}")
    return {
        "id": head.group(1),
        "class": klass,
        "jo": jo,
        "faults": faults,
        "time_faults": time_faults,
        "jumped": jumped,
        "needed": needed,
        "clock": clock,
        "complete": complete,
        "eliminated": gone,
        "reason": reason,
        "ribbon": ribbon,
    }


def judge_show(text: str, course_id: str, show_best: dict) -> tuple[list[str], str]:
    bad: list[str] = []
    chunks = rounds_of(text)
    if not chunks:
        return [f"{course_id} no round"], ""
    first = check_round(chunks[0], f"{course_id} first", show_best, True, bad)
    if first is None:
        return bad, ""
    if first["id"] != course_id:
        bad.append(f"{course_id} header {first['id']}")
    offer = "RIDECERT offer true" in text
    dones = text.count("RIDECERT done")
    lesson = course_id.startswith("hk_les_") or first["class"] == "lesson"
    already = course_id in ALREADY or first["jo"]
    zero = first["faults"] == "0" and first["time_faults"] == "0" and not first["eliminated"]
    # Same window as can_offer_jump_off: last_time <= time_show + 0.05.
    show_cap = SHOW_ALLOWED.get(first["class"])
    within = show_cap is None or cents_of(first["clock"]) <= show_cap + 5
    must = (not lesson) and (not already) and zero and within
    if lesson or already:
        if offer or len(chunks) > 1:
            bad.append(f"{course_id} offered and must not")
    elif must and not offer:
        bad.append(f"{course_id} clear and did not offer")
    elif offer and (not zero or not within):
        bad.append(
            f"{course_id} offered with faults {first['faults']} time {first['time_faults']} t={first['clock']}"
        )
    if offer and dones < 2:
        bad.append(f"{course_id} offer with {dones} done")
    if not offer and dones < 1:
        bad.append(f"{course_id} no done")
    jo_faults = ""
    jo_fences = ""
    jo_time = ""
    elim = first["reason"] if first["eliminated"] else "no"
    if offer:
        if len(chunks) < 2:
            bad.append(f"{course_id} offer without a second round")
        else:
            second = check_round(chunks[1], f"{course_id} jumpoff", show_best, True, bad)
            if second is not None:
                jo_faults = second["faults"]
                jo_fences = f"{second['jumped']}/{second['needed']}"
                jo_time = second["clock"]
                elim = second["reason"] if second["eliminated"] else "no"
                if second["needed"] != "4":
                    bad.append(f"{course_id} fences_needed {second['needed']}")
                past = cents_of(second["clock"]) + 1 > jo_limit_cents(second["class"])
                time_elim = second["eliminated"] and second["reason"] == "time" and past
                cleared = second["jumped"] == "4" and second["needed"] == "4" and second["complete"] == "true"
                if not cleared and not time_elim:
                    bad.append(
                        f"{course_id} jumpoff {jo_fences} complete={second['complete']} "
                        f"elim={second['reason'] or 'no'} t={second['clock']}"
                    )
    row = (
        f"| {course_id} | {first['faults']} | {first['clock']} | "
        f"{'yes' if offer else 'no'} | {jo_faults} | {jo_fences} | {jo_time} | {elim} | matched |"
    )
    return bad, row


def judge_school(text: str) -> list[str]:
    bad: list[str] = []
    chunks = rounds_of(text)
    if len(chunks) != 1:
        bad.append(f"school rounds {len(chunks)}")
    if "RIDECERT offer true" in text or "round=jumpoff" in text:
        bad.append("school ran a jump-off")
    if text.count("RIDECERT done") < 1:
        bad.append("school no done")
    show_best = load_show_best()
    row = check_round(chunks[0], "school", show_best, False, bad) if chunks else None
    if row is not None:
        if row["faults"] != "0" or row["eliminated"] or row["complete"] != "true":
            bad.append(f"school faults {row['faults']} elim {row['reason'] or 'no'} complete {row['complete']}")
    return bad


def marker_state(name: str) -> str:
    path = DAY / f"{name}.retry"
    if not path.exists():
        return ""
    lines = path.read_text(encoding="utf-8").strip().splitlines()
    return lines[0] if lines else ""


def note_problems(name: str, bad: list[str]) -> None:
    log_line(f"MISS {name}")
    for line in bad:
        log_line(line)
        print(line, flush=True)


def consider(name: str, bad: list[str], row: str, gate: bool) -> int:
    marker = DAY / f"{name}.retry"
    if not bad:
        if marker.exists():
            marker.unlink()
        if row and not already(name):
            append_row(row)
        print(f"KEEP {name}", flush=True)
        return 0
    state = marker_state(name)
    if state == "recorded":
        if row and not already(name):
            append_row(row)
        print(f"RECORDED {name}", flush=True)
        return 0
    if state == "pending":
        marker.write_text("recorded\n" + "\n".join(bad) + "\n", encoding="utf-8")
        note_problems(name, bad)
        if row and not already(name):
            append_row(row)
        if gate:
            log_line(f"Stopped. {name} still missed.")
            return 6
        log_line(f"SECOND MISS {name}. Go on.")
        return 0
    marker.write_text("pending\n" + "\n".join(bad) + "\n", encoding="utf-8")
    note_problems(name, bad)
    return 7


def do_playtest() -> int:
    dest = DAY / "playtest.log"
    text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
    ok = (
        "PLAYTEST clear faults=0" in text
        and "PLAYTEST refuse faults=4" in text
        and "PLAYTEST rail faults=4" in text
    )
    if not ok:
        status = after_ride(ride_once(PLAY, PLAY_LOG, dest, 10 * 60, False), dest)
        if status != 0:
            return status
        text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
        ok = (
            "PLAYTEST clear faults=0" in text
            and "PLAYTEST refuse faults=4" in text
            and "PLAYTEST rail faults=4" in text
        )
    if not ok:
        log_line("PLAYTEST was not 0 / 4 / 4.")
        return 1
    if not save_matches():
        restore_save()
        return 2
    if not already("playtest"):
        append_row("| playtest | 0/4/4 |  | no |  |  |  | no | matched |")
    print("KEEP playtest", flush=True)
    return 0


def do_school() -> int:
    dest = DAY / "hk_beg_035.school.log"
    cmd = RUN + ["--ridecert-id", "hk_beg_035"]
    state = marker_state("school")
    if state == "recorded":
        log_line("Stopped. schooling still missed.")
        return 6
    text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
    if "RIDECERT done" not in text or state == "pending":
        status = after_ride(ride_once(cmd, GODOT_LOG, dest, 25 * 60), dest)
        if status != 0:
            return status
        text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
    bad = judge_school(text)
    row = "| hk_beg_035 | school |  | no |  |  |  | no | matched |"
    if not bad and "faults=0" in text:
        row = "| hk_beg_035 school | 0 |  | no |  |  |  | no | matched |"
    return consider("hk_beg_035 school", bad, row, True)


def do_shows(show_best: dict) -> int:
    for course_id in IDS:
        dest = DAY / f"{course_id}.log"
        state = marker_state(course_id)
        text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
        offer = "RIDECERT offer true" in text
        dones = text.count("RIDECERT done")
        good_file = dones >= (2 if offer else 1) and "RIDECERT round" in text and state != "pending"
        if not good_file:
            cmd = RUN + ["--ridecert-show", "--ridecert-jumpoff", "--ridecert-id", course_id]
            status = after_ride(ride_once(cmd, GODOT_LOG, dest, 25 * 60), dest)
            if status != 0:
                return status
            text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
            if "RIDECERT done" not in text:
                if not already(course_id):
                    append_row(f"| {course_id} |  |  | no |  |  |  | stuck | matched |")
                print(f"STUCK-GO {course_id}", flush=True)
                continue
        fresh = load_show_best()
        bad, row = judge_show(text, course_id, fresh)
        gate = any("did not offer" in line or "fences_needed" in line or "offered and must not" in line for line in bad)
        code = consider(course_id, bad, row, gate)
        if code != 0:
            print(f"LOOK {course_id}", flush=True)
            return code
        show_best.clear()
        show_best.update(fresh)
    return 0


def count_ready() -> tuple[int, int, list[str]]:
    first = 0
    jumped = 0
    offered: list[str] = []
    for course_id in IDS:
        path = DAY / f"{course_id}.log"
        if not path.exists():
            continue
        text = path.read_text(encoding="utf-8", errors="replace")
        if "RIDECERT done" not in text:
            continue
        offer = "RIDECERT offer true" in text
        if offer and text.count("RIDECERT done") < 2:
            continue
        first += 1
        if offer:
            jumped += 1
            offered.append(course_id)
    return first, jumped, offered


def write_close(offered: list[str], first: int, jumped: int) -> None:
    log = DAY_LOG.read_text(encoding="utf-8") if DAY_LOG.exists() else ""
    if "## Close" in log:
        return
    black = "none" if "BLACKLIST:" not in log else "see BLACKLIST above"
    stamp = abbott_stamp()
    started = STAMP.read_text(encoding="utf-8").strip() if STAMP.exists() else ""
    version = (ROOT / "game" / "project.godot").read_text(encoding="utf-8")
    names = ", ".join(offered) if offered else "none"
    log_line("\n".join([
        "",
        "## Close",
        "",
        f"First rounds: {first}.",
        "",
        f"Jump-offs ridden: {jumped}.",
        "",
        f"Offered: {names}.",
        "",
        f"The save matches the snapshot: {save_matches()}.",
        "",
        "Files changed: `game/scripts/ride_cert.gd`, `dist/_day10_ride.py`, "
        "`dist/DAY10_LOG.md`, `dist/DAY10_MEASURE.md`, and the logs under `dist/day10/`.",
        "",
        f"BLACKLIST: {black}.",
        "",
        f"`dist\\Abbott.exe` was not launched. Last write {stamp}. "
        f"Stamp at the start of the day: {started}. Product stayed 2.348.0.0. "
        f"Version line present: {VERSION in version}.",
        "",
    ]))


def ensure_headers() -> None:
    if not DAY_LOG.exists():
        DAY_LOG.write_text(
            "# Day 10\n\n"
            "The jump-off, when the offer is true. Product stayed 2.348.0.0.\n\n"
            f"Abbott.exe last write at start: {abbott_stamp()}.\n",
            encoding="utf-8",
            newline="\n",
        )
    if not MEASURE.exists():
        MEASURE.write_text(
            "# Day 10 measure\n\n"
            "| id | first faults | first time | offered | jump-off faults | jump-off fences | jump-off time | eliminated | save |\n"
            "| --- | --- | --- | --- | --- | --- | --- | --- | --- |\n",
            encoding="utf-8",
            newline="\n",
        )
    if not STAMP.exists():
        STAMP.write_text(abbott_stamp() + "\n", encoding="utf-8")


def snapshot() -> int:
    DAY.mkdir(parents=True, exist_ok=True)
    if not SNAP.exists() and not (DAY / "save_snapshot.ABSENT").exists():
        if SAVE.exists():
            shutil.copyfile(SAVE, SNAP)
            print(f"SNAPSHOT {SNAP.stat().st_size} bytes", flush=True)
        else:
            (DAY / "save_snapshot.ABSENT").write_text("abbott_save.json was absent\n", encoding="utf-8")
            print("SNAPSHOT absent", flush=True)
    if not save_matches():
        print("SAVE does not match snapshot before start", flush=True)
        return 2
    return 0


def main() -> int:
    DAY.mkdir(parents=True, exist_ok=True)
    if STATUS.exists():
        STATUS.unlink()
    PIDF.write_text(str(kernel32.GetCurrentProcessId()) + "\n", encoding="utf-8")
    code = snapshot()
    if code != 0:
        return finish(code, "save")
    ensure_headers()
    code = do_playtest()
    if code != 0:
        return finish(code, "window" if code == 4 else "playtest")
    code = do_school()
    if code != 0:
        return finish(code, "window" if code == 4 else "school")
    code = do_shows(load_show_best())
    if code != 0:
        return finish(code, "window" if code == 4 else f"show code {code}")
    first, jumped, offered = count_ready()
    school = DAY / "hk_beg_035.school.log"
    play = DAY / "playtest.log"
    if first != 23 or not school.exists() or "RIDECERT done" not in school.read_text(encoding="utf-8", errors="replace"):
        return finish(1, f"count first={first}")
    if "PLAYTEST clear faults=0" not in play.read_text(encoding="utf-8", errors="replace"):
        return finish(1, "playtest")
    if not save_matches():
        restore_save()
        return finish(2, "save")
    write_close(offered, first, jumped)
    print(f"CLOSE first={first} jumpoff={jumped} abbott={abbott_stamp()}", flush=True)
    return finish(0, "day 10")


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except SystemExit:
        raise
    except Exception as exc:
        STATUS.write_text(f"FAILED {exc}\n", encoding="utf-8")
        print(f"FAILED {exc}", flush=True)
        raise
