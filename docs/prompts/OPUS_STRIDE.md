# Opus — say stride, say fence

You are in `E:\Workspace\Madison`. On the walk she
can read the line she is standing on. The words
do not say what the numbers are.

`dist/between_002.md` left the 2 → 3 midpoint as
"Fence 2. natural vertical. 1 to 3." Fence 2's
file says 1 stride to fence 3. A person can read
"1 to 3" as fence 1 to fence 3. The lesson's
fence 2 says "2 to 3.", which is 2 strides to
fence 3, and it looks like the fence numbers.

This job changes only those words. The fence,
the line, the 4 m rule, the 1.5 m rail, and the
2 m corridor stay. Do not edit a course file,
`walk_text`, `horse.gd`, or a fence. Do not
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
`dist/stride_002.md` before the next id.

A boot script is deleted before a timed ride.
Do not leave one in the tree.

## The words

In `_fence_line` only. When the fence's own
`related` is a dictionary:

- strides is 1: `1 stride to fence {to}.`
- strides is anything else: `{strides} strides to fence {to}.`

The fence sentence stays `Fence {num}. {name}.`
in front of that. A fence with no related stays
`Fence {num}. {name}.` with no stride words.

So the 2 → 3 midpoint becomes:

`Fence 2. natural vertical. 1 stride to fence 3.`

The 3 → 4 midpoint becomes:

`Fence 3. plank vertical. 2 strides to fence 4.`

A lesson fence 2 becomes:

`Fence 2. plank vertical. 2 strides to fence 3.`

Do not add a height. Do not change which fence
owns the line.

## Step 0 — the words now

No edit until the current strings are in
`dist/stride_002.md`. Call `near_line` as it is.

| where | line now |
| --- | --- |
| hk_adv_002 fence 2 | |
| hk_adv_002 midpoint 2 → 3 | |
| hk_adv_002 midpoint 3 → 4 | |
| hk_adv_002 fence 3, under a standard | |
| hk_adv_002 ring (0, −3) | |
| hk_les_001 fence 1 | |
| hk_les_001 midpoint 2 → 3 | |

If those lines already say "stride" and
"fence" in the way above, write that and stop.
No clocks. The between board stands.

## After

The same table, with the new words. The ring
is still empty. Fence 3 under a standard still
names fence 3's own line, now with "strides"
and "fence" in it. 1.9 m off the 2 → 3 line
still names that line. 2.5 m off is empty.

One boot, deleted after, on the 2 → 3 midpoint
of hk_adv_002. Michelle says the new sentence
once, no repeat. Move her to (0, −3). The
near-line goes quiet. The course line stays.

Three clocks, because you edited a script:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The between
board is the floor: 21/23, worst move 0.06 s on
`hk_les_001` (18.49), `hk_int_007` at 84.94.
A cert log has no walk line and no "stride".

Do not run a style. Do not run a board. Do not
run a playtest. The words are not on the cert.
If a clock leaves its window, you changed more
than the words. Revert and write what else moved.

## Write it

`dist/stride_002.md` holds both tables, the boot
lines, and the three clocks.

Top of `dist/STATUS.md`: the words, and the
clocks from the tree you left. The 4 m rule,
the rail, and the corridor stay in that
paragraph. A job that changes a distance is
not this job. A job that edits a course file
is not this job.
