"""Come again rows from dist/day3/board.log. A lie lines up before any circle."""
from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(r"E:\Workspace\Madison")
BOARD = ROOT / "dist" / "day3" / "board.log"
OUT = ROOT / "dist" / "DAY4_MEASURE.md"

ROUND_RE = re.compile(
    r"RIDECERT round (hk_\S+) class=\S+ seed=\d+ jo=\S+ style=(\S+)"
)
COUNT_RE = re.compile(
    r"COUNT fence=(\d+) ahead=([0-9.]+) lateral=([0-9.]+)"
)
JUMP_RE = re.compile(r"RIDEAI fence (\d+) ->")
CIRCLE_RE = re.compile(r"RIDEAI come again n=(\d+)")
COME = "MICHELLE soft | Come again."


def main() -> None:
    lines = BOARD.read_text(encoding="utf-8", errors="replace").splitlines()
    rounds: list[tuple[str, str, int, int]] = []
    for i, line in enumerate(lines):
        hit = ROUND_RE.search(line)
        if hit:
            rounds.append((hit.group(1), hit.group(2), i, len(lines)))
    for i, row in enumerate(rounds):
        end = rounds[i + 1][2] if i + 1 < len(rounds) else len(lines)
        rounds[i] = (row[0], row[1], row[2], end)

    table: list[str] = []
    lies = 0
    clear_lies: dict[tuple[str, str], int] = {}
    clear_true: set[tuple[str, str]] = set()
    non_adjacent = 0
    for cid, style, start, end in rounds:
        block = lines[start:end]
        counts: list[tuple[int, str, float, float]] = []
        jumps: dict[str, int] = {}
        circles: dict[str, list[int]] = {}
        for i, line in enumerate(block):
            count = COUNT_RE.search(line)
            if count:
                counts.append((i, count.group(1), float(count.group(2)), float(count.group(3))))
            jump = JUMP_RE.search(line)
            if jump and jump.group(1) not in jumps:
                jumps[jump.group(1)] = i
            circle = CIRCLE_RE.search(line)
            if circle:
                circles.setdefault(circle.group(1), []).append(i)
        for i, line in enumerate(block):
            if line.strip() != COME:
                continue
            prev = [c for c in counts if c[0] < i]
            if not prev:
                continue
            if i == 0 or not COUNT_RE.search(block[i - 1]):
                non_adjacent += 1
            _pi, fence, ahead, lateral = prev[-1]
            nxt = next((c for c in counts if c[0] > i), None)
            jump_at = jumps.get(fence, len(block))
            lined_at = next(
                (
                    c[0]
                    for c in counts
                    if c[0] > i and c[1] == fence and c[3] < 1.6 and c[0] < jump_at
                ),
                None,
            )
            lined = "yes" if lined_at is not None else "no"
            circle_at = next(
                (n for n in circles.get(fence, []) if i < n < jump_at),
                None,
            )
            circled = "yes" if circle_at is not None else "no"
            lie = lined == "yes" and (circle_at is None or (lined_at is not None and circle_at > lined_at))
            if lie:
                lies += 1
                if style == "clear":
                    clear_lies[(cid, fence)] = clear_lies.get((cid, fence), 0) + 1
            elif style == "clear" and (circled == "yes" or (lined == "no" and lateral >= 4.0)):
                clear_true.add((cid, fence))
            if nxt:
                na, nl = f"{nxt[2]:.2f}", f"{nxt[3]:.2f}"
            else:
                na, nl = "", ""
            table.append(
                f"| {cid} | {fence} | {ahead:.2f} | {lateral:.2f} | {na} | {nl} | {lined} | {circled} |"
            )

    pure = sorted(set(clear_lies) - clear_true)
    both = sorted(set(clear_lies) & clear_true)
    text = [
        "# Day 4 measure — Abbott 2.348.0.0",
        "",
        "Each row is one `Come again.` in `dist/day3/board.log`. Ahead and lateral at the sentence are the COUNT on that fence just before it. The next COUNT is the following COUNT line. Lined up means a later COUNT on that same fence with lateral under 1.6 before the jump. A circle is `RIDEAI come again` on that fence before the jump.",
        "",
        "A lie is lined up, with no circle between the sentence and that lined count. The sample already on the fence plane (ahead under 2 m, lateral 15 to 35 m) is in the table and is not a sentence to keep. Clear-round lies with no true row on that fence have to go silent. A fence that also has a circle still has to say it on that approach.",
        "",
        f"{len(table)} sentences. {lies} are lies. {non_adjacent} were not on the line after their COUNT. Clear-round fences that only lie: {len(pure)}. Clear-round fences with both a lie and a true sentence: {len(both)}.",
        "",
        "Clear-round lie-only fences: "
        + ", ".join(f"{c} fence {f}" for c, f in pure)
        + ".",
        "",
        "Clear-round fences with a lie and a circle or a wide jump: "
        + ", ".join(f"{c} fence {f}" for c, f in both)
        + ".",
        "",
        "| id | fence | ahead at the sentence | lateral at the sentence | ahead at the next COUNT | lateral at the next COUNT | lined up before the jump | circle before the jump |",
        "| --- | ---: | ---: | ---: | ---: | ---: | --- | --- |",
        *table,
        "",
    ]
    OUT.write_text("\n".join(text), encoding="utf-8", newline="\n")
    print(f"rows={len(table)} lies={lies} pure={len(pure)} both={len(both)} non_adjacent={non_adjacent}")
    print("PURE")
    for c, f in pure:
        print(f"  {c} {f} n={clear_lies[(c, f)]}")
    print("BOTH")
    for c, f in both:
        print(f"  {c} {f}")


if __name__ == "__main__":
    main()
