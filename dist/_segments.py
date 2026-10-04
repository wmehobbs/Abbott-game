"""Segment deltas and come-agains from this run's dist/ridecert_godot.log."""
from __future__ import annotations

import re
from pathlib import Path

LOG = Path(r"E:\Workspace\Madison\dist\ridecert_godot.log")
OUT = Path(r"E:\Workspace\Madison\dist\segments.md")

ROUND = re.compile(r"RIDECERT round (\S+)")
FENCE = re.compile(r"RIDEAI fence (\d+) -> (\d+) t=([\d.]+)")
AGAIN = re.compile(r"RIDEAI come again n=(\d+)")
DONE = re.compile(
    r"RIDECERT (\S+) style=clear success=(\w+) faults=(\d+) jumped=(\d+)/(\d+) "
    r"t=([\d.]+) teleported=(\w+)"
)


def main() -> None:
    text = LOG.read_text(encoding="utf-8", errors="replace")
    blocks = re.split(r"(?=RIDECERT round )", text)
    lines = ["# Segments from dist/ridecert_godot.log", ""]
    for block in blocks:
        m = ROUND.search(block)
        if not m:
            continue
        cid = m.group(1)
        segs = [(int(a), int(b), float(t)) for a, b, t in FENCE.findall(block)]
        agains = [int(n) for n in AGAIN.findall(block)]
        done = DONE.search(block)
        lines.append(f"## {cid}")
        lines.append("")
        if done:
            lines.append(
                f"success={done.group(2)} faults={done.group(3)} "
                f"jumped={done.group(4)}/{done.group(5)} t={done.group(6)} "
                f"teleported={done.group(7)}"
            )
        if agains:
            lines.append("come-again fences: " + ", ".join(str(n) for n in agains))
        else:
            lines.append("come-again fences: none")
        lines.append("")
        lines.append("| into | t | dt |")
        lines.append("| ---: | ---: | ---: |")
        prev = 0.0
        for a, b, t in segs:
            lines.append(f"| {a}->{b} | {t:.2f} | {t - prev:.2f} |")
            prev = t
        lines.append("")
    OUT.write_text("\n".join(lines) + "\n", encoding="utf-8", newline="\n")
    print(f"wrote {OUT} rounds {text.count('RIDECERT round ')}")


if __name__ == "__main__":
    main()
