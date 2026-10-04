# Opus — overnight, the whole card

You are in `E:\Workspace\Madison`. This is the
overnight job. Do not stop after the first course.
Do not stop after the audit. Do not stop after the
lesson. Do not go to bed with a Godot still riding
and the table unwritten. If you finish every phase,
write `dist/STATUS.md` and stop. Do not invent a
channel after that.

The walk line is kept. A fence says its number, its
name, its own `h`, its own `sp` when that number is
above 0, and, when the file relates it,
`1 stride to fence {to}.` or `{n} strides to fence {to}.`
At the rail, within 1.5 m standard to standard, that
fence's own line wins. On the segment, within 2 m,
the in-fence's line wins. Otherwise the nearest
fence within 4 m, or nothing. The ring stays empty.
Do not widen those distances. Do not edit a course
file. Do not edit `walk_text`, `horse.gd`, or
`ride_ai.gd`. Do not export. Do not launch
`dist\Abbott.exe`. Do not chase 23/23.

## Silent

Ernie is asleep. A Godot window locks the desktop.
`--headless` is the first argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`.
No window, no editor, no F5, no `--artshot`, no
`ride_ids.py`. One Godot. One id 8 minutes, a fresh
id 12 minutes, a style id 15, the full board 70.
No `RIDECERT round` in 2 minutes is a compile error:
kill only that process. If the wrapper dies for
memory, wait for the Godot that is already riding.
Do not start a second board. Do not kill Godot to
free RAM. The log is opened with `"w"`. Copy each
`RIDECERT` line and each `MICHELLE` line into
`dist/card_002.md` before the next id.

A boot or a probe is deleted before a timed ride.
Do not leave one in the tree. One headless script
may call `ContentLibrary.near_line` on the course
dictionaries. Delete it when the audit table is
written.

## What stays

The picture stays. The knee shares, the fold
(`FOLD_PITCH` 18, `FOLD_SHIN` 20, `FOLD_HEAD` 30,
`SIT_HIP` 10), the trot plus, and the roll stay.
The between board stays the floor unless a later
phase keeps code that can move a horse. A wording
change does not.

Clocks, if a phase keeps code that is not only
words in `_fence_line`:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The spread job
left 18.54 / 91.6 / 93.99. The between board is
21/23, `hk_les_001` 18.49, `hk_int_007` 84.94.
Outside a window, revert that phase only.

## Phase 1 — every course on the card

`game/content/courses/SHIP.json` is the card.
Every id under lesson, beginner, intermediate,
advanced, and every jump-off id. Not a sample.
All of them.

For each course, from its file, then through
`near_line`:

- On each fence's `pos`: the line's fence number
  is that fence. The height in the line is that
  fence's `h`, the way `str` prints it. If `sp`
  is above 0, the line contains that `sp`. If
  `sp` is 0, the line has no `spread`. If
  `related` is a dictionary, the stride words
  match it (`1 stride` only when strides is 1).
- On each related midpoint: the line is the
  in-fence's line, with the in-fence's `h` and
  `sp`, not the out-fence's.
- One point in that course farther than 6 m from
  every fence: the line is empty.
- If `related.to` is not a fence number in that
  file, write the id and the number. Do not
  invent the fence. Do not edit the file.

Write the count: courses, fences, related
midpoints, failures. A course that matches is
one row, not a fence-by-fence reprint. A failure
is the whole line, the file's `h` and `sp`, and
what `near_line` said.

If every course matches, this phase is done.
Do not retune a distance to make a midpoint
look nicer.

If a failure is in `near_line` and not in the
file, fix `near_line` only. One attempt. Then
rerun the audit. If the same failure remains,
write it and go on. Do not edit the course.

You are not done.

## Phase 2 — the lesson she sits

Read the four lesson courses. For each: fence
count, each fence's name, `h`, and related.
The design is poles to a single to a related
line, one true sentence after a leave. These
ids are on the board. You do not move a fence
to match the design. You write what they are.

One headless pin ride:

`python tools/content_factory/run_ridecert.py --ridecert-id=hk_les_001`

Copy every `MICHELLE` line and the `RIDECERT`
line. The old words on that course were
Two. Wait. / One. Wait. / One. Early. /
Early. / Wait. / Now. then one sentence.
Write what this ride said.

You are not done.

## Phase 3 — the horse she brings home

A person starts at confidence 48, scope 40,
rideability 44, timing 38, feel 36. A clear
is supposed to quiet him. One fresh ride:

`python tools/content_factory/run_ridecert.py --ridecert-fresh --ridecert-id=hk_les_001`

Print confidence, Neck1, and Tail1 before the
first fence and after the round. Copy the
`RIDECERT` line. The next pin ride of
`hk_les_001` must still finish at confidence
91.0. If this fresh ride leaked, say so. Do
not change `_pin_stats`, `_day_one`, or
`_school_from_round`.

If he is still as worried at the end as at
the start (Neck1 within 2° and Tail1 within
2°), write the degrees. That is a finding.
Do not edit the picture to buy a change
tonight. The knee shares and the fold stay.

You are not done.

## Phase 4 — the card

From `game_state.gd` `result_line`, write the
sentence for each of these, with the numbers
you choose written next to it:

- a lesson clear, 18.54 s
- a show clear inside the time, 67.30 s
- a show round with 2 time faults and no rail, 91.60 s
- a rail on fence 3, 4 faults
- a refusal on fence 1, 4 faults
- elimination, three refusals

A card lies if a clear with time faults says
Clear, or a lesson offers a jump-off, or a
rail does not name the fence. If none of
those lies are in the function, the card is
already true. Do not reword it.

If one lie is in the function, fix that
branch only. A string on the card does not
get a board.

You are not done.

## Phase 5 — which way she is walking

The line does not care which way she faces.
On hk_adv_002's 2 → 3 segment she always
reads "1 stride to fence 3," even if she is
walking back toward fence 2.

No code until you have printed her forward.
Find the walker's facing in the source. Do
not guess the axis. One boot, deleted after.
Place her on the 2 → 3 midpoint twice:

- facing along the segment toward fence 3
- facing along the segment toward fence 2

Print the facing you read, the segment
direction from fence 2 to fence 3, and the
dot of the two. Write which facing is toward
the out.

Then, only on the segment branch of
`near_line`, when that dot is negative she
is walking back. The words become
`Walking back. ` in front of the same line.
Toward the out, the line stays as it is.
At the rail, within 1.5 m, do not add
`Walking back.` She is at the fence.

The boot again, both facings. Toward fence 3
she hears the line once, without
`Walking back.` Toward fence 2 she hears it
once, with `Walking back.` No repeat while
she stays. The ring is still empty.

If you cannot read a facing off the walker,
write that and do not invent one. The rest
of the night still stands.

## The clocks, once

Run the three clocks once, at the end, if
any phase kept code. Not after every phase.
A cert log has no walk line, no `spread`,
and no `Walking back.`

Do not run a style. Do not run a board. Do
not run a playtest. The between board stands.
If a clock leaves its window, revert the
phase that was not only words, and write
which one.

## Write it

`dist/card_002.md` holds the audit count and
every failure, the four lessons, the Michelle
lines, the fresh horse before and after, the
six card sentences, the two facings, and the
clocks if you ran them.

Top of `dist/STATUS.md`: one paragraph for
the night. The audit count. Whether the
lesson said one sentence. Whether the clear
quieted him. Whether the card lied. Whether
walking back is kept or unreadable. The
clocks from the tree you left. The spread
paragraph stays under it.

A job that moves a fence is not this job.
A job that edits `ride_ai.gd` is not this job.
A job that packs `dist\Abbott.exe` is not
this job. A job that stops after the audit
is not this job.
