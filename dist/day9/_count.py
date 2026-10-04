import re
from pathlib import Path

DAY = Path(r"E:\Workspace\Madison\dist\day9")
SAVE = Path(r"C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json")
SNAP = DAY / "save_snapshot.json"
ABBOTT = Path(r"E:\Workspace\Madison\dist\Abbott.exe")
IDS = [
    "hk_les_001", "hk_les_002", "hk_les_003", "hk_les_004",
    "hk_beg_035", "hk_beg_039", "hk_beg_004", "hk_beg_034", "hk_beg_007", "hk_beg_033",
    "hk_int_001", "hk_int_002", "hk_int_005", "hk_int_006", "hk_int_007", "hk_int_009",
    "hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005",
    "hk_jo_beg_001", "hk_jo_int_001", "hk_jo_adv_001",
]
RESULT = re.compile(
    r"faults=(\d+) refusal_faults=(\d+) rail_faults=(\d+) time_faults=(\d+) "
    r"jumped=(\d+)/(\d+) t=([0-9.]+) teleported=(true|false) complete=(true|false) "
    r".*?eliminated=(true|false) reason=(\S*) ribbon=(\S*)"
)
bad = []
three = 0
timed = 0
for tag in ("r2", "r3"):
    n = 0
    for course_id in IDS:
        path = DAY / f"{course_id}.{tag}.log"
        text = path.read_text(encoding="utf-8", errors="replace")
        if "RIDECERT done" not in text:
            bad.append(f"{course_id} {tag} no done")
            continue
        n += 1
        fences = re.findall(r"RIDECERT refuse fence=(\d+)", text)
        hit = RESULT.search(text)
        if not hit:
            bad.append(f"{course_id} {tag} no result")
            continue
        faults, refusal, rails, tf, _j, _need, clock, tele, complete, elim, reason, ribbon = hit.groups()
        lesson = course_id.startswith("hk_les_")
        want = 3 if tag == "r3" else 2
        if fences != ["1"] * want:
            bad.append(f"{course_id} {tag} fences {fences}")
        if int(refusal) + int(rails) + int(tf) != int(faults):
            bad.append(f"{course_id} {tag} parts {refusal}+{rails}+{tf} != {faults}")
        if tele != "false":
            bad.append(f"{course_id} {tag} tele")
        if lesson:
            if elim != "false" or tf != "0" or ribbon or int(refusal) != 4 * want:
                bad.append(f"{course_id} {tag} lesson elim={elim} tf={tf} ribbon={ribbon} refusal={refusal}")
        elif tag == "r3":
            excused = course_id == "hk_jo_adv_001" and reason == "time" and float(clock) + 0.01 > 63
            if excused:
                timed += 1
            else:
                if reason != "three" or elim != "true":
                    bad.append(f"{course_id} r3 reason={reason or 'blank'} elim={elim}")
                else:
                    three += 1
                if tf != "0" or ribbon:
                    bad.append(f"{course_id} r3 tf={tf} ribbon={ribbon}")
                if int(faults) != 12 + int(rails):
                    bad.append(f"{course_id} r3 faults {faults} rails {rails}")
        else:
            if elim == "true":
                if course_id == "hk_jo_adv_001" and reason == "time":
                    timed += 1
                else:
                    bad.append(f"{course_id} r2 elim {reason}")
            elif int(refusal) != 12:
                bad.append(f"{course_id} r2 refusal {refusal}")
    print(tag, n)
print("three", three, "time", timed)
print("bad", len(bad))
for line in bad:
    print(line)
print("save", SAVE.read_bytes() == SNAP.read_bytes(), SAVE.stat().st_size, SNAP.stat().st_size)
import time
print("abbott", time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(ABBOTT.stat().st_mtime)))
