# Opus — the height in the file

You are in `E:\Workspace\Madison`. On the walk the
line now says what its numbers are. It still does
not say how high the fence is.

A lesson fence and a prix fence can share a name.
`hk_les_001` fence 1 is "white vertical" and its
file has `h` 0.422. `hk_adv_002` fence 1 is also
"white vertical" and its `h` is not 0.422. The
course line says the class height. The fence line
does not say this fence's height.

This job adds `h` from that fence's own dictionary,
in metres, as the file stores it. Do not convert
to feet. Do not round it into a different height.
`str` of the file's number is the words. If `h`
is missing, add nothing.

The fence sentence stays `Fence {num}. {name}.`
Then the height, ` {h} m.` Then the stride words,
unchanged: `1 stride to fence {to}.` or
`{n} strides to fence {to}.`

So the lesson's fence 1 becomes:

`Fence 1. white vertical. 0.422 m.`

And hk_adv_002's 2 → 3 midpoint becomes:

`Fence 2. natural vertical. 0.875 m. 1 stride to fence 3.`

Print the `h` you actually read. If the file's
number is not 0.875, use the file, not this
sentence.

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
`dist/height_002.md` before the next id.

A boot script is deleted before a timed ride.
Do not leave one in the tree.

## Step 0 — the height, before the words

No edit until this table is in `dist/height_002.md`.
From the course JSON, each fence's `h`. Then
`near_line` as it is now.

| where | h in the file | line now |
| --- | --- | --- |
| hk_les_001 fence 1 | | |
| hk_les_001 fence 2 | | |
| hk_les_001 midpoint 2 → 3 | | |
| hk_adv_002 fence 1 | | |
| hk_adv_002 fence 2 | | |
| hk_adv_002 midpoint 2 → 3 | | |
| hk_adv_002 fence 3, under a standard | | |
| hk_adv_002 ring (0, −3) | | |

The two "white vertical" rows have to show
different `h` if the files differ. If they are
the same number, write that. Do not invent a
difference.

If every fence line already contains its own
`h` and the ring is empty, write that and stop.
No clocks. The between board stands.

## After

The same table. Each named fence's line contains
the `h` from its own file, and not the other
fence's `h`. The 2 → 3 midpoint carries fence 2's
`h`, not fence 3's. Fence 3 under a standard
carries fence 3's `h` and still says
`2 strides to fence 4.` The ring is empty.
1.9 m off the 2 → 3 line still names that line,
with fence 2's height. 2.5 m off is empty.

One boot, deleted after, on the 2 → 3 midpoint
of hk_adv_002. Michelle says the new sentence
once, including the height and
`1 stride to fence 3.` No repeat. Move her to
(0, −3). The near-line goes quiet.

Three clocks:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The between
board stays the floor: 21/23, `hk_les_001` 18.49,
`hk_int_007` 84.94. A cert log has no walk line
and no ` m.`

Do not run a style, a board, or a playtest.
The height is not on the cert. If a clock leaves
its window, you changed more than the words.
Revert and write what else moved.

## Write it

`dist/height_002.md` holds both tables, the boot
lines, and the three clocks.

Top of `dist/STATUS.md`: the height words, and
the clocks from the tree you left. The stride
words and the distances stay in that paragraph.
A job that converts to feet is not this job.
A job that edits a course file is not this job.
