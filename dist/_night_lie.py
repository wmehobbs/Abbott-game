"""Every Come again in the day-3 board, and whether a circle followed it."""
import re
from pathlib import Path

text = Path("dist/day3/board.log").read_text(encoding="utf-8", errors="replace").splitlines()
round_re = re.compile(r"RIDECERT round (\S+) .* style=(\S+)")
count_re = re.compile(
    r"COUNT fence=(\d+) ahead=([0-9.]+) lateral=([0-9.]+) stride=(-?\d+)"
)
come = "MICHELLE soft | Come again."
circle_re = re.compile(r"RIDEAI come again n=(\d+)")
jump_re = re.compile(r"RIDEAI fence (\d+) ->")
result_re = re.compile(r"RIDECERT (\S+) style=(\S+) success=")

rows = []
course = ""
style = ""
i = 0
while i < len(text):
    m = round_re.search(text[i])
    if m:
        course, style = m.group(1), m.group(2)
        i += 1
        continue
    if text[i].strip() != come:
        i += 1
        continue
    fence = ahead = lateral = ""
    for j in range(i, -1, -1):
        c = count_re.search(text[j])
        if c:
            fence, ahead, lateral = c.group(1), c.group(2), c.group(3)
            break
        if round_re.search(text[j]):
            break
    circled = False
    jumped = False
    for j in range(i + 1, len(text)):
        if round_re.search(text[j]) or result_re.search(text[j]):
            break
        cir = circle_re.search(text[j])
        if cir and cir.group(1) == fence:
            circled = True
            break
        jp = jump_re.search(text[j])
        if jp and jp.group(1) == fence:
            jumped = True
            break
    lie = (not circled) and jumped
    rows.append((course, style, fence, ahead, lateral, circled, lie))
    i += 1

out = Path("dist/NIGHT_MEASURE.md")
lines = [
    "# Night measure — Abbott 2.348.0.0",
    "",
    "Each row is one `Come again.` in `dist/day3/board.log`. Ahead and lateral are the COUNT line on that fence just before the sentence. A circle is `RIDEAI come again` on that fence before the jump. Jumped without a circle is a lie.",
    "",
    "| id | fence | ahead | lateral | RIDEAI come again on that fence before the jump | jumped without a circle |",
    "| --- | ---: | ---: | ---: | --- | --- |",
]
lies = 0
under4 = 0
for course, style, fence, ahead, lateral, circled, lie in rows:
    tag = course if style == "clear" else f"{course} {style}"
    lines.append(
        f"| {tag} | {fence} | {ahead} | {lateral} | {'yes' if circled else 'no'} | {'yes' if lie else 'no'} |"
    )
    if lie and style == "clear":
        lies += 1
        if float(lateral) < 4.0:
            under4 += 1
out.write_text("\n".join(lines) + "\n", encoding="utf-8")
print(f"rows {len(rows)} clear_lies {lies} clear_lies_under_4 {under4}")
# sample of clear lies
for course, style, fence, ahead, lateral, circled, lie in rows:
    if lie and style == "clear":
        print(f"LIE {course} fence {fence} ahead {ahead} lat {lateral}")
