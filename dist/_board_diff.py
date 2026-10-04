"""Compare the coaching board to the morning baseline. Read-only."""
import json
from pathlib import Path

base = json.loads(Path("dist/day_baseline_board.json").read_text(encoding="utf-8"))
new = json.loads(Path("dist/ridecert_board.json").read_text(encoding="utf-8"))
CLOCK = {"hk_adv_001", "hk_adv_003"}
print("baseline", base["board"], "pass", base["pass"], "style_n", len(base["style"]))
print("coaching", new["board"], "pass", new["pass"], "style_n", len(new["style"]))
bt = {row["id"]: row for row in base["tracks"]}
nt = {row["id"]: row for row in new["tracks"]}
bad = False
print("| id | morning | now | dt | success | rails | faults | teleported | rule |")
for cid in bt:
    b, n = bt[cid], nt[cid]
    dt = round(float(n["time_sec"]) - float(b["time_sec"]), 2)
    limit = 0.3 if cid in CLOCK else 0.1
    reasons = []
    if b["success"] and not n["success"]:
        reasons.append("LOST_CLEAR")
    if int(n["rails"]) > int(b["rails"]):
        reasons.append("NEW_RAIL")
    if abs(dt) > limit + 1e-9:
        reasons.append("TIME")
    if n["teleported"]:
        reasons.append("TELEPORT")
    if n["rail_fences"] != b["rail_fences"] and int(n["rails"]) > int(b["rails"]):
        reasons.append("RAIL_FENCES")
    flag = ",".join(reasons) if reasons else "ok"
    if reasons:
        bad = True
    print(
        "| %s | %.2f | %.2f | %+.2f | %s -> %s | %s -> %s | %s -> %s | %s | %s |"
        % (
            cid, b["time_sec"], n["time_sec"], dt,
            b["success"], n["success"], b["rails"], n["rails"],
            b["faults"], n["faults"], n["teleported"], flag,
        )
    )
print("--- style ---")
for b, n in zip(base["style"], new["style"]):
    print(
        b["style"], "faults", b["faults"], "->", n["faults"],
        "rails", b["rails"], "->", n["rails"],
        "t", b["time_sec"], "->", n["time_sec"],
        "success", n["success"], "teleported", n["teleported"],
        "refused", n["refused"], "rail_fences", n["rail_fences"],
    )
print("BREAK" if bad else "KEEP")
