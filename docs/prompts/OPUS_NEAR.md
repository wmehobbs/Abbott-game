# Opus — the fence she is standing next to

You are in `E:\Workspace\Madison`. This is a long job. Do not
stop after the first fence, and do not write `dist/STATUS.md`
and quit until every fence of `hk_adv_002` and every fence
of the four lessons has a row, and the board is written, or
until the near-line is a written negative.

The walk now says the course. It does not say the fence.
`hk_adv_002` fence 2 is a natural vertical, and its own
file says it is one stride to fence 3, 7.49 m. She can
stand on it and the label still says only "Mini Prix."

Do not rewrite `walk_text` or `michelle_brief`. Do not
edit a course file. Do not move a fence. Do not edit
`horse.gd`. Do not export. Do not launch `dist\Abbott.exe`.

## Silent

Ernie is at the machine. A Godot window locks the desktop.
`--headless` is the first argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`.
No windowed exe, no editor, no F5, no `--artshot`, no
`ride_ids.py`. One Godot. Timeouts: one id 8 minutes, a
style id 15 minutes, the full board 70 minutes. No
`RIDECERT round` in 2 minutes is a compile error: kill
only that process. If the wrapper dies for low memory,
wait for the ride that is already going. Do not start a
second board. Do not kill Godot to free RAM. The log is
opened with `"w"`. Copy each `RIDECERT hk_…` line into
`dist/near_002.md` before the next id.

A probe is inserted once and stripped before a timed
ride. Do not leave one in the tree. A boot that enters
the walk is deleted before any clock.

## What stays

`ContentLibrary.walk_line` stays the course line:
`{name}. {height_label}. {notes}`. Away from the
fences, that is still the whole label.

`Course.loaded` stays the dictionary the round already
built. Read the fences from there. Do not load a second
copy.

The rider picture stays. `horse.gd`, `bascule.gd`,
`rider_mesh.gd`, and `ride_ai.gd` stay. The rein, the
five landings, the tail hair, the late fist, the crest,
the hoof, the pastern, the beat, and the camera stay.
`_school_from_round` and `result_line` stay.

You may change the walk label and one function that
names the nearest fence. You may not change how the
horse moves, or how she walks (WASD stays).

A keep, after the words are in and the probe is gone:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The walk board is
the floor: 21/23, worst move 0.04 s on `hk_int_002`,
`hk_int_007` 84.93. Outside a window, revert the
near-line. The course line stays.

## Step 0 — twelve fences, before any label code

No near-line until this table is in `dist/near_002.md`.

From `hk_adv_002.json`, every fence: number, name,
kind, height in metres, and the related block if it
has one (`to`, `strides`, `distance_m`). Then the
same for `hk_les_001` through `hk_les_004`. That is
12 + 12 rows. The lesson rows are three fences each.

Quote today's walk label when she is on the course
and not beside a fence. It is the course line only.

## The near-line

One function. Input is `course.loaded` and a world
position. Output is one string, or empty if she is
not beside a fence.

She is beside a fence when she is within 4 m of its
`pos` (ignore height). 4 m is inside the one-stride
on `hk_adv_002` (7.49 m), so two fences do not both
claim her. If two are within 4 m, the nearer one
wins. If she is beside none, the function returns
empty and the label stays the course line.

The near-line is:

`Fence {num}. {name}.`

and, only when that fence's own `related` is not
null:

` {strides} to {to}.`

One stride reads "1 to 3", the number from the file,
not a word you invent. A fence with `related: null`
does not mention a stride. Do not use `walk_text`.
Do not speak the course id.

On the walk, the label is the course line, and when
the near-line is non-empty it follows on the next
line. Michelle says the near-line once, when she
arrives beside that fence, and not on every frame.
Leaving it and coming back may say it again. The
course line is still said once, on entering the
walk, as it is now. A cert round never enters the
walk, so it never says either line.

## Prove it on the fences, before any clock

Headless. Place her, do not ride the horse.

For every fence in the step-0 table, one row: her
position on that fence's `pos`, the distance to the
nearest fence, and the near-line. It names that
fence. Fence 2 of `hk_adv_002` includes "1 to 3".
Fence 3, the out, does not claim the stride unless
its own `related` says so. Fence 1 of each lesson
does not mention a stride.

One row in the middle of the ring, away from every
fence on `hk_adv_002`: the near-line is empty, and
the label is only the course line.

One row on the midpoint of fence 2 to fence 3. Say
which fence wins, and the two distances. If the
midpoint is inside 4 m of both, the nearer one is
the line. If your 4 m makes the midpoint belong to
neither, write the two distances and leave it
empty. Do not widen 4 m to catch it.

Then one headless boot into the walk on `hk_les_001`,
her position set on fence 1. The label shows the
course line and "Fence 1." plus that fence's name.
Michelle has said the course line once and the
near-line once. Strip the boot before any timed ride.

If you cannot do this without editing a course file
or moving a fence, write the negative and stop. Do
not run a board.

## The pin is still the pin

Three clocks. Then style:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds
0.053. C one rail on fence 3 in the air. Copy the
knock line. Style does not enter the walk.

One full `python tools/content_factory/run_ridecert.py`.
Render with `python tools/content_factory/board_table.py`.
The 21 within 0.1 s of the walk board, no new rail,
`teleported=false`. Headless `--playtest` after the
board line is copied: clear 0 / refuse 4 / rail 4.

If the board moves, revert the near-line. The course
line stays.

## Write it

`dist/near_002.md` holds the step-0 fence tables, the
near rows, the empty-middle row, the midpoint row,
the walk boot, the three clocks, the style lines,
and the board.

Top of `dist/STATUS.md`: the near-line, that the
course line is still the line away from the fences,
and the clocks from the tree you left. A job that
rewrites `walk_text` is not this job. A job that
only reprints `dist/walk_002.md` is not this job.
