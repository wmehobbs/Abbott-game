# Opus — the spread in the file

You are in `E:\Workspace\Madison`. The walk line now
says the fence's own height. An oxer is still only
a name.

`hk_adv_002` fence 7 is "brush oxer". Its file has
`h` 0.919 and `sp` 0.659. Fence 11 is "plank oxer",
`h` 0.943, `sp` 0.659. The verticals on that course
have `sp` 0.0. The line says the height and, on a
related fence, the strides. It does not say the
spread.

This job adds `sp` from that fence's own dictionary,
in metres, as the file stores it, and only when the
number is greater than 0. A vertical with `sp` 0.0
gains no spread words. Do not convert to feet. Do
not round it into a different width. `str` of the
file's number is the words. If `sp` is missing, add
nothing.

Order stays: `Fence {num}. {name}.` then the height,
then the spread, then the stride words.

Fence 7, standing on it, becomes:

`Fence 7. brush oxer. 0.919 m. spread 0.659 m.`

Print the `sp` you actually read. If the file's
number is not 0.659, use the file.

Do not change which fence owns the line. Do not
change 4 m, 1.5 m, or 2 m. Do not edit a course
file, `walk_text`, `horse.gd`, or a fence. Do not
export. Do not launch `dist\Abbott.exe`. Do not
edit `ride_ai.gd`.

## Silent

Ernie is at the machine. `--headless` is the first
argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`.
No window, no editor, no F5, no `--artshot`, no
`ride_ids.py`. One Godot. One id 8 minutes. No
`RIDECERT round` in 2 minutes is a compile error:
kill only that process. If the wrapper dies for
memory, wait for the Godot that is already riding.
Do not start a second board. The log is opened
with `"w"`. Copy each `RIDECERT` line into
`dist/spread_002.md` before the next id.

A boot script is deleted before a timed ride.
Do not leave one in the tree.

## Step 0 — the spread, before the words

No edit until this table is in `dist/spread_002.md`.
From the course JSON, `h` and `sp`. Then `near_line`
as it is now.

| where | h | sp | line now |
| --- | --- | --- | --- |
| hk_adv_002 fence 1 | | | |
| hk_adv_002 fence 7 | | | |
| hk_adv_002 fence 11 | | | |
| hk_adv_002 midpoint 11 → 12 | | | |
| hk_les_001 fence 1 | | | |
| hk_adv_002 ring (0, −3) | | | |

Fence 7 and fence 11 have to show a spread above
0 if the files say so. Fence 1 and the lesson
fence have to show `sp` 0, and their lines have
no spread words yet. If a line already contains
its own `sp`, write that and do not add it again.

## After

The same table. Fence 7's line contains its own
`sp` and not fence 11's. Fence 1's line has its
height and no spread words. The 11 → 12 midpoint
carries fence 11's height and fence 11's spread,
and still says `1 stride to fence 12.` The ring
is empty.

One boot, deleted after, placed on fence 7 of
hk_adv_002. Michelle says the new sentence once,
including `spread` and the file's number. No
repeat. Move her to (0, −3). The near-line goes
quiet.

Three clocks:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The between
board stays the floor: 21/23, `hk_les_001` 18.49,
`hk_int_007` 84.94. A cert log has no walk line
and no `spread`.

Do not run a style, a board, or a playtest.
The spread is not on the cert. If a clock leaves
its window, you changed more than the words.
Revert and write what else moved.

## Write it

`dist/spread_002.md` holds both tables, the boot
lines, and the three clocks.

Top of `dist/STATUS.md`: the spread words, and
the clocks from the tree you left. The height
and the stride words stay in that paragraph.
A job that prints `spread 0 m` on a vertical is
not this job. A job that edits a course file is
not this job.
