"""Day 11. One sentence, two pin proofs, then the day-one horse."""
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
DAY = ROOT / "dist" / "day11"
DAY_LOG = ROOT / "dist" / "DAY11_LOG.md"
MEASURE = ROOT / "dist" / "DAY11_MEASURE.md"
SAVE = Path(r"C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json")
SNAP = DAY / "save_snapshot.json"
ABBOTT = ROOT / "dist" / "Abbott.exe"
STATE = ROOT / "game" / "scripts" / "game_state.gd"
STAMP = DAY / "abbott_stamp.txt"
STATUS = DAY / "_status.txt"
PIDF = DAY / "_driver.pid"
HEART = DAY / "_heartbeat.txt"
RUN = [sys.executable, str(ROOT / "tools" / "content_factory" / "run_ridecert.py")]
PLAY = [sys.executable, str(ROOT / "dist" / "_run_userarg.py"), "--playtest"]
GODOT_LOG = ROOT / "dist" / "ridecert_godot.log"
FRESH_LOG = ROOT / "dist" / "ridecert_fresh.log"
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
PHRASE = "Over the time allowed"
SENTENCE_RE = re.compile(
    r'\n\t\telif session_kind == "show" and not jump_off:\n'
    r'\t\t\tclear \+= "  Over the time allowed\."'
)

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


def revert_sentence() -> None:
    text = STATE.read_text(encoding="utf-8")
    new, n = SENTENCE_RE.subn("", text, count=1)
    if n != 1:
        print("REVERT missed", flush=True)
        log_line("Revert missed the sentence.")
        return
    STATE.write_text(new, encoding="utf-8", newline="\n")
    log_line("Reverted the sentence in result_line.")
    print("REVERT", flush=True)


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
    allow = jo_allowed_cents(klass) if jo else SHOW_ALLOWED[klass] if show else 0
    if not show and not jo:
        return 0
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
    return HEAD_RE.match(chunk), RESULT_RE.search(chunk)


def rails_ok(chunk: str, listed: str, rail_pts: str, bad: list[str], label: str) -> None:
    knocks = re.findall(r"FENCE knock (\d+)", chunk)
    if nums(listed) != knocks:
        bad.append(f"{label} rails {nums(listed)} != knocks {knocks}")
    if int(rail_pts) != 4 * len(knocks):
        bad.append(f"{label} rail faults {rail_pts} != {4 * len(knocks)}")


def check_round(chunk: str, label: str, show_best: dict, bad: list[str]) -> dict | None:
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
    expect = paper_time(clock, klass, jo, not lesson, lesson, gone)
    if int(time_faults) != expect:
        bad.append(f"{label} time {time_faults} paper {expect} t={clock}")
    rails_ok(chunk, listed, rail_pts, bad, label)
    want_ribbon = expect_ribbon(klass, int(faults), clock, show_best, lesson, gone)
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
        "rails": nums(listed),
    }


def within_show(row: dict) -> bool:
    cap = SHOW_ALLOWED.get(row["class"])
    if cap is None:
        return False
    return cents_of(row["clock"]) <= cap + 5


def judge_fresh(text: str, course_id: str, show_best: dict) -> tuple[list[str], str, bool]:
    bad: list[str] = []
    revert = False
    chunks = rounds_of(text)
    if not chunks:
        return [f"{course_id} no round"], "", False
    first = check_round(chunks[0], f"{course_id} first", show_best, bad)
    if first is None:
        return bad, "", False
    if first["id"] != course_id:
        bad.append(f"{course_id} header {first['id']}")
    offer = "RIDECERT offer true" in text
    dones = text.count("RIDECERT done")
    lesson = course_id.startswith("hk_les_") or first["class"] == "lesson"
    already = course_id in ALREADY or first["jo"]
    zero = first["faults"] == "0" and first["time_faults"] == "0" and not first["eliminated"]
    inside = within_show(first)
    must_offer = (not lesson) and (not already) and zero and inside
    must_phrase = (not lesson) and (not already) and zero and not inside
    said = PHRASE in text
    if lesson or already:
        if offer or len(chunks) > 1:
            bad.append(f"{course_id} offered and must not")
        if said:
            bad.append(f"revert: {course_id} sentence on a lesson or jump-off")
            revert = True
    elif must_offer:
        if not offer:
            bad.append(f"{course_id} clear and did not offer")
        if said:
            bad.append(f"revert: {course_id} sentence on an offer")
            revert = True
    elif must_phrase:
        if offer:
            bad.append(f"{course_id} offered and must not")
        if not said:
            bad.append(f"{course_id} sentence missing")
    elif said:
        bad.append(f"revert: {course_id} sentence on a faulted round")
        revert = True
    if offer and said:
        bad.append(f"revert: {course_id} sentence on an offer")
        revert = True
    if offer and dones < 2:
        bad.append(f"{course_id} offer with {dones} done")
    if not offer and dones < 1:
        bad.append(f"{course_id} no done")
    jo_faults = ""
    if offer:
        if len(chunks) < 2:
            bad.append(f"{course_id} offer without a second round")
        else:
            second = check_round(chunks[1], f"{course_id} jumpoff", show_best, bad)
            if second is not None:
                jo_faults = second["faults"]
                if second["needed"] != "4":
                    bad.append(f"{course_id} fences_needed {second['needed']}")
                past = cents_of(second["clock"]) + 1 > jo_limit_cents(second["class"])
                time_elim = second["eliminated"] and second["reason"] == "time" and past
                cleared = second["jumped"] == "4" and second["needed"] == "4" and second["complete"] == "true"
                if not cleared and not time_elim:
                    bad.append(
                        f"{course_id} jumpoff {second['jumped']}/{second['needed']} "
                        f"complete={second['complete']} elim={second['reason'] or 'no'} t={second['clock']}"
                    )
                if PHRASE in chunks[1]:
                    bad.append(f"revert: {course_id} sentence on the jump-off")
                    revert = True
    rails = " ".join(first["rails"]) if first["rails"] else "—"
    row = (
        f"| {course_id} | {first['faults']} | {first['clock']} | {first['time_faults']} | "
        f"{rails} | {'yes' if offer else 'no'} | {jo_faults} | {'yes' if said else 'no'} | matched |"
    )
    return bad, row, revert


def judge_pin_adv(text: str) -> tuple[list[str], str, bool]:
    bad: list[str] = []
    revert = False
    if "RIDECERT offer true" in text or "round=jumpoff" in text or text.count("RIDECERT done") > 1:
        bad.append("revert: hk_adv_005 pin ran a second round")
        revert = True
    if "Stay for the jump-off" in text:
        bad.append("revert: hk_adv_005 pin said Stay for the jump-off")
        revert = True
    chunks = rounds_of(text)
    show_best = load_show_best()
    row = check_round(chunks[0], "hk_adv_005 pin", show_best, bad) if chunks else None
    clock = ""
    rails = "—"
    if row is None:
        bad.append("hk_adv_005 pin no result")
    else:
        clock = row["clock"]
        rails = " ".join(row["rails"]) if row["rails"] else "—"
        if row["faults"] != "0":
            bad.append(f"hk_adv_005 pin faults {row['faults']}")
        if row["time_faults"] != "0":
            bad.append(f"revert: hk_adv_005 pin time faults {row['time_faults']}")
            revert = True
        if cents_of(row["clock"]) <= 7500:
            bad.append(f"hk_adv_005 pin time {row['clock']} is not over 75")
        if row["eliminated"]:
            bad.append("hk_adv_005 pin eliminated")
    if PHRASE not in text:
        bad.append("hk_adv_005 pin sentence missing")
    line = (
        f"| hk_adv_005 pin | {row['faults'] if row else ''} | {clock} | "
        f"{row['time_faults'] if row else ''} | {rails} | no |  | "
        f"{'yes' if PHRASE in text else 'no'} | matched |"
    )
    return bad, line, revert


def judge_pin_beg(text: str) -> tuple[list[str], str, bool]:
    bad: list[str] = []
    revert = False
    offer = "RIDECERT offer true" in text
    if PHRASE in text:
        bad.append("revert: hk_beg_035 pin contains Over the time allowed")
        revert = True
    if not offer or "round=jumpoff" not in text or text.count("RIDECERT done") < 2:
        bad.append("revert: hk_beg_035 pin offer disappeared")
        revert = True
    chunks = rounds_of(text)
    show_best = load_show_best()
    first = check_round(chunks[0], "hk_beg_035 pin", show_best, bad) if chunks else None
    jo_faults = ""
    clock = ""
    rails = "—"
    faults = ""
    time_faults = ""
    if first is None:
        bad.append("hk_beg_035 pin no result")
    else:
        clock = first["clock"]
        faults = first["faults"]
        time_faults = first["time_faults"]
        rails = " ".join(first["rails"]) if first["rails"] else "—"
        if first["faults"] != "0" or first["time_faults"] != "0" or not within_show(first):
            bad.append(
                f"revert: hk_beg_035 pin first faults {first['faults']} "
                f"time {first['time_faults']} t={first['clock']}"
            )
            revert = True
    if offer and len(chunks) > 1:
        second = check_round(chunks[1], "hk_beg_035 pin jumpoff", show_best, bad)
        if second is not None:
            jo_faults = second["faults"]
            if second["needed"] != "4":
                bad.append(f"hk_beg_035 pin fences_needed {second['needed']}")
            elif not (second["jumped"] == "4" and second["complete"] == "true"):
                bad.append(f"hk_beg_035 pin jumpoff {second['jumped']}/{second['needed']}")
    line = (
        f"| hk_beg_035 pin | {faults} | {clock} | {time_faults} | {rails} | "
        f"{'yes' if offer else 'no'} | {jo_faults} | no | matched |"
    )
    return bad, line, revert


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
        append_row("| playtest | 0/4/4 |  |  |  | no |  | no | matched |")
    print("KEEP playtest", flush=True)
    return 0


def do_pin(name: str, course_id: str, judge) -> int:
    dest = DAY / f"{course_id}.pin.log"
    text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
    bad, row, revert = judge(text) if text else (["missing"], "", False)
    if bad:
        cmd = RUN + ["--ridecert-show", "--ridecert-jumpoff", "--ridecert-id", course_id]
        status = after_ride(ride_once(cmd, GODOT_LOG, dest, 25 * 60), dest)
        if status != 0:
            return status
        text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
        bad, row, revert = judge(text)
    if revert:
        note_problems(name, bad)
        revert_sentence()
        return 8
    gate = any(
        "sentence missing" in line or "fences_needed" in line or "no result" in line
        for line in bad
    )
    return consider(name, bad, row, gate or bool(bad))


def do_fresh() -> int:
    for course_id in IDS:
        dest = DAY / f"{course_id}.fresh.log"
        state = marker_state(course_id)
        text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
        offer = "RIDECERT offer true" in text
        dones = text.count("RIDECERT done")
        good_file = dones >= (2 if offer else 1) and "RIDECERT round" in text and state != "pending"
        if not good_file:
            cmd = RUN + ["--ridecert-fresh", "--ridecert-show", "--ridecert-jumpoff", "--ridecert-id", course_id]
            status = after_ride(ride_once(cmd, FRESH_LOG, dest, 25 * 60), dest)
            if status != 0:
                return status
            text = dest.read_text(encoding="utf-8", errors="replace") if dest.exists() else ""
            if "RIDECERT done" not in text:
                if not already(course_id):
                    append_row(f"| {course_id} |  |  |  |  | no |  | no | stuck |")
                print(f"STUCK-GO {course_id}", flush=True)
                continue
        bad, row, revert = judge_fresh(text, course_id, load_show_best())
        if revert:
            note_problems(course_id, bad)
            revert_sentence()
            return 8
        gate = any(
            "did not offer" in line
            or "fences_needed" in line
            or "offered and must not" in line
            or "sentence missing" in line
            or "sentence on" in line
            for line in bad
        )
        code = consider(course_id, bad, row, gate)
        if code != 0:
            print(f"LOOK {course_id}", flush=True)
            return code
    return 0


def count_ready() -> tuple[int, int, list[str]]:
    first = 0
    jumped = 0
    offered: list[str] = []
    for course_id in IDS:
        path = DAY / f"{course_id}.fresh.log"
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


def rails_added() -> tuple[int, list[str]]:
    total = 0
    ids: list[str] = []
    for course_id in IDS:
        path = DAY / f"{course_id}.fresh.log"
        if not path.exists():
            continue
        text = path.read_text(encoding="utf-8", errors="replace")
        knocks = re.findall(r"FENCE knock (\d+)", text)
        pin = ROOT / "dist" / "day10" / f"{course_id}.log"
        pin_n = 0
        if pin.exists():
            pin_n = len(re.findall(r"FENCE knock (\d+)", pin.read_text(encoding="utf-8", errors="replace")))
        added = len(knocks) - pin_n
        if added > 0:
            total += added
            ids.append(f"{course_id} {added}")
    return total, ids


def adv_no_jumpoff() -> str:
    bits = []
    for label, path in (
        ("pin", DAY / "hk_adv_005.pin.log"),
        ("fresh", DAY / "hk_adv_005.fresh.log"),
    ):
        if not path.exists():
            bits.append(f"{label} missing")
            continue
        text = path.read_text(encoding="utf-8", errors="replace")
        second = "RIDECERT offer true" in text or "round=jumpoff" in text
        bits.append(f"{label} jump-off {'ran' if second else 'no'}")
    return ", ".join(bits)


def write_close(offered: list[str], first: int, jumped: int) -> None:
    log = DAY_LOG.read_text(encoding="utf-8") if DAY_LOG.exists() else ""
    if "## Close" in log:
        return
    black = "none" if "BLACKLIST:" not in log else "see BLACKLIST above"
    stamp = abbott_stamp()
    started = STAMP.read_text(encoding="utf-8").strip() if STAMP.exists() else ""
    version = (ROOT / "game" / "project.godot").read_text(encoding="utf-8")
    names = ", ".join(offered) if offered else "none"
    added, which = rails_added()
    which_s = ", ".join(which) if which else "none"
    log_line("\n".join([
        "",
        "## Close",
        "",
        f"Fresh first rounds: {first}.",
        "",
        f"Jump-offs ridden: {jumped}.",
        "",
        f"Offered: {names}.",
        "",
        f"Rails the day-one horse added: {added}. {which_s}.",
        "",
        f"hk_adv_005 jump-off: {adv_no_jumpoff()}.",
        "",
        f"The save matches the snapshot: {save_matches()}.",
        "",
        "Watch a round is on the title, next to Lesson. A demo does not save.",
        "",
        "Files changed: `game/scripts/game_state.gd`, `game/scripts/ride_cert.gd`, "
        "`game/scripts/title.gd`, `game/scripts/arena.gd`, `dist/_day11_ride.py`, "
        "`dist/DAY11_LOG.md`, `dist/DAY11_MEASURE.md`, and the logs under `dist/day11/`.",
        "",
        f"BLACKLIST: {black}.",
        "",
        f"`dist\\Abbott.exe` was not launched and not rewritten. Last write {stamp}. "
        f"Stamp at the start of the day: {started}. Product stayed 2.348.0.0. "
        f"Version line present: {VERSION in version}.",
        "",
    ]))


def ensure_headers() -> None:
    if not DAY_LOG.exists():
        DAY_LOG.write_text(
            "# Day 11\n\n"
            "Over the time allowed, then the day-one horse. Product stayed 2.348.0.0.\n\n"
            f"Abbott.exe last write at start: {abbott_stamp()}.\n",
            encoding="utf-8",
            newline="\n",
        )
    if not MEASURE.exists():
        MEASURE.write_text(
            "# Day 11 measure\n\n"
            "| id | faults | time | time faults | rails | offered | jump-off faults | over the time allowed | save |\n"
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
    code = do_pin("hk_adv_005 pin", "hk_adv_005", judge_pin_adv)
    if code != 0:
        return finish(code, "window" if code == 4 else "reverted" if code == 8 else "pin adv")
    code = do_pin("hk_beg_035 pin", "hk_beg_035", judge_pin_beg)
    if code != 0:
        return finish(code, "window" if code == 4 else "reverted" if code == 8 else "pin beg")
    code = do_fresh()
    if code != 0:
        return finish(code, "window" if code == 4 else "reverted" if code == 8 else f"fresh code {code}")
    first, jumped, offered = count_ready()
    play = DAY / "playtest.log"
    adv = DAY / "hk_adv_005.pin.log"
    beg = DAY / "hk_beg_035.pin.log"
    if first != 23:
        return finish(1, f"count first={first}")
    if "PLAYTEST clear faults=0" not in play.read_text(encoding="utf-8", errors="replace"):
        return finish(1, "playtest")
    adv_bad, _, adv_revert = judge_pin_adv(adv.read_text(encoding="utf-8", errors="replace"))
    if adv_revert:
        revert_sentence()
        return finish(8, "reverted")
    if adv_bad:
        return finish(1, "pin adv")
    beg_bad, _, beg_revert = judge_pin_beg(beg.read_text(encoding="utf-8", errors="replace"))
    if beg_revert:
        revert_sentence()
        return finish(8, "reverted")
    if beg_bad:
        return finish(1, "pin beg")
    if not save_matches():
        restore_save()
        return finish(2, "save")
    write_close(offered, first, jumped)
    print(f"CLOSE first={first} jumpoff={jumped} abbott={abbott_stamp()}", flush=True)
    return finish(0, "day 11")


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except SystemExit:
        raise
    except Exception as exc:
        STATUS.write_text(f"FAILED {exc}\n", encoding="utf-8")
        print(f"FAILED {exc}", flush=True)
        raise
