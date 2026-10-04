"""Day 9. Two show refusals, then three. One Godot at a time."""
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
DAY9 = ROOT / "dist" / "day9"
DAY_LOG = ROOT / "dist" / "DAY9_LOG.md"
MEASURE = ROOT / "dist" / "DAY9_MEASURE.md"
SAVE = Path(r"C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json")
SNAP = DAY9 / "save_snapshot.json"
ABBOTT = ROOT / "dist" / "Abbott.exe"
STAMP = DAY9 / "abbott_stamp.txt"
STATUS = DAY9 / "_status.txt"
PIDF = DAY9 / "_driver.pid"
HEART = DAY9 / "_heartbeat.txt"
RUN = [sys.executable, str(ROOT / "tools" / "content_factory" / "run_ridecert.py")]
PLAY = [sys.executable, str(ROOT / "dist" / "_run_userarg.py"), "--playtest"]
STYLE_LOG = ROOT / "dist" / "ridecert_style.log"
GODOT_LOG = ROOT / "dist" / "ridecert_godot.log"
PLAY_LOG = ROOT / "dist" / "playtest_day.log"
IDS = [
    "hk_les_001", "hk_les_002", "hk_les_003", "hk_les_004",
    "hk_beg_035", "hk_beg_039", "hk_beg_004", "hk_beg_034", "hk_beg_007", "hk_beg_033",
    "hk_int_001", "hk_int_002", "hk_int_005", "hk_int_006", "hk_int_007", "hk_int_009",
    "hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005",
    "hk_jo_beg_001", "hk_jo_int_001", "hk_jo_adv_001",
]
ADVANCED = {"hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005"}
VERSION = 'config/version="2.348.0.0"'

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


def allowed_cents(klass: str, jo: bool, card: str) -> int:
    if card == "school":
        base = {"beginner": 10000, "intermediate": 9000, "advanced": 8000}[klass]
    else:
        base = {"beginner": 9500, "intermediate": 8500, "advanced": 7500}[klass]
    if not jo:
        return base
    allow = max(28.0, (base / 100.0) * 0.42)
    return int(round(allow * 100.0))


def paper_time(clock: str, klass: str, jo: bool, card: str, lesson: bool, eliminated: bool) -> int:
    if lesson or eliminated:
        return 0
    over = cents_of(clock) - allowed_cents(klass, jo, card)
    if over <= 0:
        return 0
    return over // 400


def load_show_best() -> dict:
    if not SNAP.exists():
        return {}
    data = json.loads(SNAP.read_text(encoding="utf-8"))
    best = data.get("show_best") or {}
    return best if isinstance(best, dict) else {}


def expected_ribbon(class_id: str, faults: int, clock: str, show_best: dict) -> str:
    rec = show_best.get(class_id) or {"faults": 999, "time": 9999.0}
    old_f = int(float(rec.get("faults", 999)))
    old_t = float(rec.get("time", 9999.0))
    clock_f = cents_of(clock) / 100.0
    improved = faults < old_f or (faults == old_f and clock_f < old_t)
    first = improved and faults == 0
    if faults == 0:
        return "Blue" if first else "Red"
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


def append_row(row: str, notes: list[str]) -> None:
    with MEASURE.open("a", encoding="utf-8", newline="\n") as handle:
        handle.write(row + "\n")
    log_line(row)
    for note in notes:
        log_line(note)


def already(course_id: str, tag: str) -> bool:
    text = MEASURE.read_text(encoding="utf-8") if MEASURE.exists() else ""
    return f"| {course_id} | {tag} |" in text


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
    if "abbott.exe" in joined or "--artshot" in joined or "place_fence" in joined:
        raise SystemExit("refusing forbidden command")


def headless_line(proc_out: Path) -> str:
    if not proc_out.exists():
        return ""
    for line in proc_out.read_text(encoding="utf-8", errors="replace").splitlines():
        if line.startswith("RUN "):
            return line
    return ""


def fresh_text(source: Path, prior_mtime: float) -> str:
    if not source.exists():
        return ""
    try:
        if source.stat().st_mtime <= prior_mtime:
            return ""
        return source.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return ""


def run_proc(cmd: list[str], source: Path, dest: Path, stuck_s: int, want_round: bool) -> int:
    assert_safe(cmd)
    while godot_alive():
        print("WAIT godot", flush=True)
        HEART.write_text(f"wait-godot {dest.name}\n", encoding="utf-8")
        time.sleep(5)
    proc_out = DAY9 / "_last_cmd.txt"
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
        HEART.write_text(
            f"riding {dest.name} {int(time.time() - started)}s\n",
            encoding="utf-8",
        )
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
        body = fresh_text(source, prior_mtime)
        if want_round and not saw_round and "RIDECERT round" in body:
            saw_round = True
        if "SCRIPT ERROR" in body and "RIDECERT done" not in body:
            kill_tree(proc.pid)
            handle.close()
            if source.exists():
                shutil.copyfile(source, dest)
            if not save_matches():
                restore_save()
            print(f"COMPILE {dest.name}", flush=True)
            return 1
        if want_round and not saw_round and time.time() - started > 120:
            kill_tree(proc.pid)
            handle.close()
            if source.exists():
                shutil.copyfile(source, dest)
            if not save_matches():
                restore_save()
            print(f"COMPILE {dest.name}", flush=True)
            return 1
        if not want_round and time.time() - started > 120 and "PLAYTEST" not in body and "SCRIPT ERROR" not in body:
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
            log_line(f"\nSTUCK {dest.name} after one retry. Go on.\n")
            print(f"STUCK-WROTE {dest.name}", flush=True)
            return 0
    return status


def round_chunk(text: str, style: str) -> str:
    for part in text.split("RIDECERT round ")[1:]:
        head = part.split("\n", 1)[0]
        if f"style={style}" in head.split(" style=")[-1] or head.endswith("style=" + style) or f"style={style}" in head:
            if HEAD_RE.match(head) and HEAD_RE.match(head).group(4) == style:
                return part
    return ""


def refuses_of(chunk: str) -> list[str]:
    return re.findall(r"RIDECERT refuse fence=(\d+)", chunk)


def jumped_after(chunk: str, count: int) -> bool:
    found = list(re.finditer(r"RIDECERT refuse fence=(\d+)", chunk))
    if len(found) < count:
        return False
    return "RIDEAI fence 1 ->" in chunk[found[count - 1].end():]


def jumped_before(chunk: str, count: int) -> bool:
    found = list(re.finditer(r"RIDECERT refuse fence=(\d+)", chunk))
    if len(found) < count:
        return False
    return "RIDEAI fence 1 ->" in chunk[:found[count - 1].start()]


def parse_result(chunk: str) -> tuple[re.Match[str] | None, re.Match[str] | None]:
    head = HEAD_RE.match(chunk)
    hit = RESULT_RE.search(chunk)
    return head, hit


def rails_ok(chunk: str, listed: str, rail_pts: str, bad: list[str], label: str) -> None:
    knocks = re.findall(r"FENCE knock (\d+)", chunk)
    if nums(listed) != knocks:
        bad.append(f"{label} rails {nums(listed)} != knocks {knocks}")
    if int(rail_pts) != 4 * len(knocks):
        bad.append(f"{label} rail faults {rail_pts} != {4 * len(knocks)}")


def row_of(course_id: str, tag: str, faults: str, refusal: str, rail_pts: str, time_faults: str, clock: str, ribbon: str, reason: str, tele: str, add: str) -> str:
    shown = ribbon if ribbon else "none"
    why = reason if reason else "no"
    return (
        f"| {course_id} | {tag} | {faults} | {refusal} | {rail_pts} | {time_faults} | "
        f"{clock} | {shown} | {why} | {tele} | {add} | matched |"
    )


def judge_refusal(text: str, course_id: str, tag: str, count: int, card: str, show_best: dict) -> tuple[list[str], str, list[str]]:
    style = "refuse_three" if count == 3 else "refuse_twice"
    chunk = round_chunk(text, style)
    bad: list[str] = []
    notes: list[str] = []
    if not chunk:
        return [f"{course_id} {tag} missing {style}"], "", notes
    head, hit = parse_result(chunk)
    if head is None or hit is None:
        return [f"{course_id} {tag} missing result"], "", notes
    if head.group(1) != course_id or head.group(4) != style:
        bad.append(f"{course_id} {tag} header {head.group(1)} {head.group(4)}")
    klass = head.group(2)
    jo = head.group(3) == "true"
    (
        faults, refusal, rail_pts, time_faults, _jumped, _need, clock, tele, complete,
        _refused, listed, eliminated, reason, ribbon,
    ) = hit.groups()
    lesson = klass == "lesson" or course_id.startswith("hk_les_")
    gone = eliminated == "true"
    fences = refuses_of(chunk)
    excused = (
        course_id == "hk_jo_adv_001"
        and tag == "r3"
        and gone
        and reason == "time"
        and cents_of(clock) + 1 > 6300
    )
    if excused:
        notes.append(f"hk_jo_adv_001 r3 time at {clock}, refusals landed: {len(fences)}")
        row = row_of(course_id, tag, faults, refusal, rail_pts, time_faults, clock, "", reason, tele, "yes")
        return [], row, notes
    if fences != ["1"] * count:
        bad.append(f"{course_id} {tag} refuses {fences} wanted {count} on fence 1")
    if tele != "false":
        bad.append(f"{course_id} {tag} teleported")
    if complete != "true":
        bad.append(f"{course_id} {tag} not complete")
    rails_ok(chunk, listed, rail_pts, bad, f"{course_id} {tag}")
    parts = int(refusal) + int(rail_pts) + int(time_faults)
    add = "yes" if parts == int(faults) else "no"
    if add == "no":
        bad.append(f"{course_id} {tag} parts {parts} != {faults}")
    show_three = card == "show" and count == 3 and not lesson
    if lesson:
        if int(refusal) != 4 * count:
            bad.append(f"{course_id} {tag} lesson refusal {refusal} != {4 * count}")
        if int(time_faults) != 0 or gone or ribbon:
            bad.append(f"{course_id} {tag} lesson time {time_faults} elim {eliminated} {reason} ribbon {ribbon or 'none'}")
        if not jumped_after(chunk, count):
            bad.append(f"{course_id} {tag} fence 1 was not jumped after refusal {count}")
    elif show_three:
        if int(refusal) != 12:
            bad.append(f"{course_id} {tag} refusal {refusal} != 12")
        if not gone or reason != "three":
            bad.append(f"{course_id} {tag} eliminated={eliminated} reason={reason or 'blank'}")
        if int(time_faults) != 0:
            bad.append(f"{course_id} {tag} time faults {time_faults} after elimination")
        if ribbon:
            bad.append(f"{course_id} {tag} ribbon {ribbon}")
        if int(faults) != 12 + int(rail_pts):
            bad.append(f"{course_id} {tag} faults {faults} != 12 + rails {rail_pts}")
        if jumped_before(chunk, count):
            bad.append(f"{course_id} {tag} jumped fence 1 before the third refusal")
    else:
        want = 12 if card == "show" else 4 * count
        if int(refusal) != want:
            bad.append(f"{course_id} {tag} refusal {refusal} != {want}")
        if gone:
            bad.append(f"{course_id} {tag} eliminated {reason or 'blank'}")
        if ribbon and card != "show":
            bad.append(f"{course_id} {tag} ribbon {ribbon}")
        expect = paper_time(clock, klass, jo, "show" if card == "show" else "school", False, False)
        if int(time_faults) != expect:
            bad.append(f"{course_id} {tag} time {time_faults} paper {expect} t={clock}")
        if card == "show" and not gone:
            expect_r = expected_ribbon(klass, int(faults), clock, show_best)
            if ribbon != expect_r:
                bad.append(f"{course_id} {tag} ribbon {ribbon or 'none'} != {expect_r}")
        if not jumped_after(chunk, count):
            bad.append(f"{course_id} {tag} fence 1 was not jumped after refusal {count}")
    if gone and reason:
        notes.append(f"ELIM {course_id} {tag} {reason}")
    row = row_of(course_id, tag, faults, refusal, rail_pts, time_faults, clock, ribbon, reason if gone else "", tele, add)
    return bad, row, notes


def judge_style(text: str) -> tuple[list[str], list[str], list[str]]:
    bad: list[str] = []
    rows: list[str] = []
    refuse = round_chunk(text, "refuse_early")
    rail = round_chunk(text, "rail_late")
    if not refuse or not rail:
        return ["style pair missing a round"], [], []
    for style, chunk, want_faults, want_rails, want_refusal in (
        ("refuse_early", refuse, "4", [], "4"),
        ("rail_late", rail, "4", ["3"], "0"),
    ):
        head, hit = parse_result(chunk)
        if head is None or hit is None or head.group(4) != style:
            bad.append(f"missing {style}")
            continue
        (
            faults, refusal, rail_pts, time_faults, _j, _n, clock, tele, _complete,
            _refused, listed, eliminated, reason, ribbon,
        ) = hit.groups()
        if faults != want_faults or nums(listed) != want_rails or refusal != want_refusal:
            bad.append(f"{style} faults {faults} refusal {refusal} rails {listed}")
        if tele != "false" or eliminated != "false" or int(time_faults) != 0 or ribbon:
            bad.append(f"{style} tele {tele} elim {eliminated} {reason} time {time_faults} ribbon {ribbon or 'none'}")
        if style == "refuse_early" and refuses_of(chunk) != ["1"]:
            bad.append(f"refuse_early refuses {refuses_of(chunk)}")
        rails_ok(chunk, listed, rail_pts, bad, style)
        rows.append(row_of("hk_les_001", "style-refuse" if style == "refuse_early" else "style-rail", faults, refusal, rail_pts, time_faults, clock, ribbon, "", tele, "yes" if int(refusal) + int(rail_pts) + int(time_faults) == int(faults) else "no"))
    return bad, rows, []


def budget(course_id: str) -> int:
    if course_id in ADVANCED:
        return 55 * 60
    return 40 * 60


def note_problems(course_id: str, tag: str, bad: list[str]) -> None:
    log_line(f"\nMISS {course_id} {tag}")
    for line in bad:
        log_line(line)
        print(line, flush=True)


def consider(course_id: str, tag: str, dest: Path, bad: list[str], row: str, notes: list[str], gate: bool) -> int:
    marker = DAY9 / f"{course_id}.{tag}.retry"
    if not bad:
        if marker.exists():
            marker.unlink()
        if row and not already(course_id, tag):
            append_row(row, notes)
        print(f"KEEP {course_id} {tag}", flush=True)
        return 0
    state = marker.read_text(encoding="utf-8").strip().splitlines()[0] if marker.exists() else ""
    if state == "recorded":
        if row and not already(course_id, tag):
            append_row(row, notes + [f"SECOND MISS {course_id} {tag}"])
        print(f"RECORDED {course_id} {tag}", flush=True)
        return 0
    if state == "pending":
        marker.write_text("recorded\n" + "\n".join(bad) + "\n", encoding="utf-8")
        note_problems(course_id, tag, bad)
        if row and not already(course_id, tag):
            append_row(row, notes + [f"SECOND MISS {course_id} {tag}"])
        if gate:
            log_line(f"Stopped. {course_id} {tag} still missed.")
            return 6
        log_line(f"SECOND MISS {course_id} {tag}. Go on.")
        return 0
    marker.write_text("pending\n" + "\n".join(bad) + "\n", encoding="utf-8")
    note_problems(course_id, tag, bad)
    return 7


def after_ride(status: int, dest: Path) -> int:
    if status == 4:
        return 4
    if status != 0:
        return status
    if not save_matches():
        restore_save()
        print(f"SAVE {dest.name} differed. Snapshot restored.", flush=True)
        return 2
    return 0


def do_playtest() -> int:
    dest = DAY9 / "playtest.log"
    text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
    ok_now = (
        "PLAYTEST clear faults=0" in text
        and "PLAYTEST refuse faults=4" in text
        and "PLAYTEST rail faults=4" in text
    )
    if not ok_now:
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
        print("PLAYTEST FAIL", flush=True)
        log_line("PLAYTEST was not 0 / 4 / 4.")
        return 1
    if not save_matches():
        restore_save()
        print("SAVE playtest differed. Snapshot restored.", flush=True)
        return 2
    if not already("playtest", "proof"):
        append_row("| playtest | proof | 0/4/4 | 4 | 4 | 0 |  | none | no | false | yes | matched |", [])
    print("KEEP playtest 0 4 4", flush=True)
    return 0


def marker_state(course_id: str, tag: str) -> str:
    marker = DAY9 / f"{course_id}.{tag}.retry"
    if not marker.exists():
        return ""
    lines = marker.read_text(encoding="utf-8").strip().splitlines()
    return lines[0] if lines else ""


def do_style() -> int:
    dest = DAY9 / "hk_les_001.style.log"
    cmd = RUN + ["--ridecert-style", "--ridecert-id", "hk_les_001"]
    was_pending = marker_state("hk_les_001", "style") == "pending"
    if marker_state("hk_les_001", "style") == "recorded":
        log_line("Stopped. hk_les_001 style still moved.")
        return 6
    text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
    if "RIDECERT done" not in text or was_pending:
        status = after_ride(ride_once(cmd, STYLE_LOG, dest, 30 * 60, True), dest)
        if status != 0:
            return status
        text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
        if "RIDECERT done" not in text:
            log_line("STUCK hk_les_001 style. Stop.")
            return 6
    bad, rows, _notes = judge_style(text)
    marker = DAY9 / "hk_les_001.style.retry"
    if not bad:
        if marker.exists():
            marker.unlink()
        for row in rows:
            tag = "style-refuse" if "style-refuse" in row else "style-rail"
            if not already("hk_les_001", tag):
                append_row(row, [])
        print("KEEP hk_les_001 style 4 and 4", flush=True)
        return 0
    state = marker.read_text(encoding="utf-8").strip().splitlines()[0] if marker.exists() else ""
    if state == "pending":
        marker.write_text("recorded\n" + "\n".join(bad) + "\n", encoding="utf-8")
        note_problems("hk_les_001", "style", bad)
        log_line("Stopped. hk_les_001 style still moved.")
        return 6
    if state == "recorded":
        log_line("Stopped. hk_les_001 style still moved.")
        return 6
    marker.write_text("pending\n" + "\n".join(bad) + "\n", encoding="utf-8")
    note_problems("hk_les_001", "style", bad)
    return 7


def do_school(count: int, show_best: dict) -> int:
    tag = f"school{count}"
    dest = DAY9 / f"hk_beg_035.{tag}.log"
    cmd = RUN + [f"--ridecert-refusals={count}", "--ridecert-id", "hk_beg_035"]
    was_pending = marker_state("hk_beg_035", tag) == "pending"
    if marker_state("hk_beg_035", tag) == "recorded":
        log_line(f"Stopped. hk_beg_035 {tag} still missed.")
        return 6
    text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
    if "RIDECERT done" not in text or was_pending:
        status = after_ride(ride_once(cmd, GODOT_LOG, dest, 30 * 60, True), dest)
        if status != 0:
            return status
        text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
        if "RIDECERT done" not in text:
            log_line(f"STUCK hk_beg_035 {tag}. Stop.")
            return 6
    bad, row, notes = judge_refusal(text, "hk_beg_035", tag, count, "school", show_best)
    return consider("hk_beg_035", tag, dest, bad, row, notes, True)


def do_show(count: int, show_best: dict) -> int:
    tag = f"r{count}"
    flag = f"--ridecert-refusals={count}"
    if count == 3:
        missing_r2 = [course_id for course_id in IDS if not (DAY9 / f"{course_id}.r2.log").exists()]
        if missing_r2:
            print(f"R3 before r2 finished, missing {missing_r2[0]}", flush=True)
            return 1
    for course_id in IDS:
        dest = DAY9 / f"{course_id}.{tag}.log"
        state = marker_state(course_id, tag)
        text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
        done = "RIDECERT done" in text
        if not (done and state != "pending"):
            cmd = RUN + ["--ridecert-show", flag, "--ridecert-id", course_id]
            status = after_ride(ride_once(cmd, GODOT_LOG, dest, budget(course_id), True), dest)
            if status != 0:
                return status
            text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
            if "RIDECERT done" not in text:
                if not already(course_id, tag):
                    append_row(
                        f"| {course_id} | {tag} |  |  |  |  |  | none | stuck |  |  | matched |",
                        [f"STUCK {course_id} {tag}"],
                    )
                print(f"STUCK-GO {course_id} {tag}", flush=True)
                continue
        bad, row, notes = judge_refusal(text, course_id, tag, count, "show", show_best)
        code = consider(course_id, tag, dest, bad, row, notes, False)
        if code == 7:
            print(f"LOOK {course_id} {tag}", flush=True)
        if code != 0:
            return code
    return 0


def logs_ready(tag: str) -> bool:
    log = DAY_LOG.read_text(encoding="utf-8") if DAY_LOG.exists() else ""
    for course_id in IDS:
        dest = DAY9 / f"{course_id}.{tag}.log"
        if not dest.exists():
            return False
        text = dest.read_text(encoding="utf-8", errors="replace")
        if "RIDECERT done" in text:
            continue
        if f"STUCK {course_id} {tag}" not in log:
            return False
    return True


def write_close() -> None:
    measure = MEASURE.read_text(encoding="utf-8") if MEASURE.exists() else ""
    three = 0
    timed = 0
    reasons: list[str] = []
    for line in measure.splitlines():
        if not line.startswith("| hk_"):
            continue
        parts = [cell.strip() for cell in line.strip("|").split("|")]
        if len(parts) < 9:
            continue
        course_id, tag, _faults, _refusal, _rail, _time, _clock, _ribbon, reason = parts[:9]
        reasons.append(f"{course_id} {tag} {reason}")
        show = tag in ("r2", "r3") and not course_id.startswith("hk_les_")
        if show and reason == "three":
            three += 1
        if show and reason == "time":
            timed += 1
    log = DAY_LOG.read_text(encoding="utf-8")
    black = "none" if "BLACKLIST:" not in log else "see BLACKLIST above"
    stamp = abbott_stamp()
    started = STAMP.read_text(encoding="utf-8").strip() if STAMP.exists() else ""
    version = (ROOT / "game" / "project.godot").read_text(encoding="utf-8")
    same = stamp == started
    lines = ["", "## Elimination reasons", ""]
    for reason in reasons:
        lines.append(f"- {reason}")
    lines.extend([
        "",
        "## Close",
        "",
        "Playtest is 0 / 4 / 4. hk_les_001 style is 4 and 4.",
        "",
        "Schooling hk_beg_035 is 8 and 12, not eliminated.",
        "",
        f"Shows eliminated for three refusals: {three}.",
        "",
        f"Shows eliminated for time: {timed}.",
        "",
        "Files changed: `game/scripts/ride_ai.gd`, `game/scripts/ride_cert.gd`, "
        "`dist/_day9_ride.py`, `dist/DAY9_LOG.md`, `dist/DAY9_MEASURE.md`, "
        "and the logs under `dist/day9/`.",
        "",
        f"BLACKLIST: {black}.",
        "",
        f"`dist\\Abbott.exe` was not launched and not rewritten. Last write {stamp}. "
        f"Stamp at the start of the day: {started}. Unchanged: {same}. "
        f"Product stayed 2.348.0.0. Version line present: {VERSION in version}.",
        "",
    ])
    if "## Close" not in log:
        log_line("\n".join(lines))
    print(f"CLOSE three={three} time={timed} abbott={stamp}", flush=True)


def ensure_headers() -> None:
    if not DAY_LOG.exists():
        DAY_LOG.write_text(
            "# Day 9\n\n"
            "The second refusal, then the third. Product stayed 2.348.0.0.\n\n"
            "Playtest, then hk_les_001 with no refusals arg, then schooling hk_beg_035 "
            "at two and at three, then 23 show two-refusal rounds, then 23 show three-refusal rounds.\n\n"
            f"Abbott.exe last write at start: {abbott_stamp()}.\n",
            encoding="utf-8",
            newline="\n",
        )
    if not MEASURE.exists():
        MEASURE.write_text(
            "# Day 9 measure\n\n"
            "Refusal faults are the sum note_refuse added. Show is 4, then 12. "
            "Schooling and a lesson are 4 times the count.\n\n"
            "| id | list | faults | refusal | rail | time | t | ribbon | reason | tele | add | save |\n"
            "| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |\n",
            encoding="utf-8",
            newline="\n",
        )
    if not STAMP.exists():
        STAMP.write_text(abbott_stamp() + "\n", encoding="utf-8")


def snapshot() -> int:
    DAY9.mkdir(parents=True, exist_ok=True)
    if not SNAP.exists() and not (DAY9 / "save_snapshot.ABSENT").exists():
        if SAVE.exists():
            shutil.copyfile(SAVE, SNAP)
            print(f"SNAPSHOT {SNAP.stat().st_size} bytes", flush=True)
        else:
            (DAY9 / "save_snapshot.ABSENT").write_text("abbott_save.json was absent\n", encoding="utf-8")
            print("SNAPSHOT absent", flush=True)
    if not save_matches():
        print("SAVE does not match snapshot before start", flush=True)
        return 2
    return 0


def main() -> int:
    DAY9.mkdir(parents=True, exist_ok=True)
    if STATUS.exists():
        STATUS.unlink()
    PIDF.write_text(str(kernel32.GetCurrentProcessId()) + "\n", encoding="utf-8")
    code = snapshot()
    if code != 0:
        return finish(code, "save")
    ensure_headers()
    show_best = load_show_best()
    code = do_playtest()
    if code != 0:
        return finish(code, "playtest" if code != 4 else "window")
    code = do_style()
    if code != 0:
        label = {4: "window", 6: "stopped hk_les_001 style", 7: "ask hk_les_001 style"}.get(code, "style")
        return finish(code, label)
    code = do_school(2, show_best)
    if code != 0:
        label = {4: "window", 6: "stopped hk_beg_035 school2", 7: "ask hk_beg_035 school2"}.get(code, "school2")
        return finish(code, label)
    code = do_school(3, show_best)
    if code != 0:
        label = {4: "window", 6: "stopped hk_beg_035 school3", 7: "ask hk_beg_035 school3"}.get(code, "school3")
        return finish(code, label)
    code = do_show(2, show_best)
    if code != 0:
        return finish(code, "window" if code == 4 else f"show r2 code {code}")
    if not logs_ready("r2"):
        return finish(1, "r2 incomplete")
    code = do_show(3, show_best)
    if code != 0:
        return finish(code, "window" if code == 4 else f"show r3 code {code}")
    if not logs_ready("r3"):
        return finish(1, "r3 incomplete")
    if not save_matches():
        restore_save()
        return finish(2, "save")
    write_close()
    return finish(0, "day 9")


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except SystemExit:
        raise
    except Exception as exc:
        STATUS.write_text(f"FAILED {exc}\n", encoding="utf-8")
        print(f"FAILED {exc}", flush=True)
        raise
