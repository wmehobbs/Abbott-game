"""Write the day-6 paper sum from dist/day5 style logs. Does not launch Godot."""
from __future__ import annotations

import math
import re
from pathlib import Path

ROOT = Path(r"E:\Workspace\Madison")
DAY5 = ROOT / "dist" / "day5"
OUT = ROOT / "dist" / "DAY6_MEASURE.md"
IDS = [
    "hk_les_001", "hk_les_002", "hk_les_003", "hk_les_004",
    "hk_beg_035", "hk_beg_039", "hk_beg_004", "hk_beg_034", "hk_beg_007", "hk_beg_033",
    "hk_int_001", "hk_int_002", "hk_int_005", "hk_int_006", "hk_int_007", "hk_int_009",
    "hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005",
    "hk_jo_beg_001", "hk_jo_int_001", "hk_jo_adv_001",
]
SCHOOL = {"lesson": 180.0, "beginner": 100.0, "intermediate": 90.0, "advanced": 80.0}
ROUND_RE = re.compile(
    r"RIDECERT round (\S+) class=(\S+) seed=\d+ jo=(true|false) style=(\S+)"
)
RES_RE = re.compile(
    r"RIDECERT (\S+) style=(\S+) success=\S+ faults=(\d+) jumped=\d+/\d+ "
    r"t=([0-9.]+) teleported=\S+ complete=\S+ refused=(\[[^\]]*\]) rail_fences=(\[[^\]]*\])"
)


def main() -> None:
    lines = [
        "# Day 6 measure — the parts already add up",
        "",
        "From `dist/day5` style logs, before any edit. Cert rounds are schooling. "
        "A refusal is 4. A rail is 4. A lesson takes no time faults. Any other round "
        "takes floor((time_sec - allowed) / 4) when that is positive. Jump-off allowed "
        "is max(28, time_school * 0.42). `hk_jo_adv_001` refuse is 65.30 s, allowed 33.6, "
        "time faults 7, rails 8, refusal 4, sum 19.",
        "",
        "| id | style | faults | rails | refusals | time_sec | allowed | time faults | sum | match |",
        "| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |",
    ]
    for cid in IDS:
        text = (DAY5 / f"{cid}.style.log").read_text(encoding="utf-8", errors="replace")
        cur: dict[str, object] | None = None
        for line in text.splitlines():
            hit = ROUND_RE.search(line)
            if hit:
                cur = {
                    "klass": hit.group(2),
                    "jo": hit.group(3) == "true",
                    "style": hit.group(4),
                }
                continue
            res = RES_RE.search(line)
            if res is None or cur is None or res.group(1) != cid or res.group(2) != cur["style"]:
                continue
            faults = int(res.group(3))
            clock = float(res.group(4))
            nref = len(re.findall(r"\d+", res.group(5)))
            nrail = len(re.findall(r"\d+", res.group(6)))
            allowed = float(SCHOOL[str(cur["klass"])])
            if cur["jo"]:
                allowed = max(28.0, allowed * 0.42)
            if cur["klass"] == "lesson" or clock <= allowed:
                time_faults = 0
            else:
                time_faults = int(math.floor((clock - allowed) / 4.0))
            total = 4 * nrail + 4 * nref + time_faults
            match = "yes" if total == faults else "no"
            lines.append(
                f"| {cid} | {cur['style']} | {faults} | {nrail} | {nref} | "
                f"{clock:.2f} | {allowed:g} | {time_faults} | {total} | {match} |"
            )
    OUT.write_text("\n".join(lines) + "\n", encoding="utf-8", newline="\n")
    body = OUT.read_text(encoding="utf-8")
    print("rows", body.count("\n| hk_"), "no", body.count("| no |"))


if __name__ == "__main__":
    main()
