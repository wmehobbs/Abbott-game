# Opus — the line under her feet

You are in `E:\Workspace\Madison`. On the walk she
can read the fence she is standing next to.
`ContentLibrary.near_line` takes the nearest fence
within 4 m. That is kept. This job is the related
line she is walking, which that rule gets wrong.

`dist/near_002.md` measured hk_adv_002. Fence 2's
own file says 1 stride to fence 3, 7.49 m. The
midpoint is 3.745 m from both ends, inside 4 m of
both. The tie keeps the later fence, so the label
is fence 3's line, "2 to 4." She is standing on
the one-stride, and the label names the next one.

A two-stride is about 10.8 m. Its midpoint is
5.4 m from either end, outside 4 m, so the label
there is the course line alone. She cannot read
the line she is on.

Do not widen 4 m. At a fence, the label stays
that fence's own line. Fence 3, under its
standard, still says "2 to 4." Fence 2 still
says "1 to 3." The middle of the ring stays
empty. Do not edit a course file, `walk_text`,
`horse.gd`, or a fence. Do not export. Do not
launch `dist\Abbott.exe`. Do not edit
`ride_ai.gd`.

## Silent

Ernie is at the machine. `--headless` is the first
argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`.
No window, no editor, no F5, no `--artshot`, no
`ride_ids.py`. One Godot. One id 8 minutes, a
style id 15, the full board 70. No `RIDECERT round`
in 2 minutes is a compile error: kill only that
process. If the wrapper dies for memory, wait for
the Godot that is already riding. Do not start a
second board. The log is opened with `"w"`. Copy
each `RIDECERT` line into `dist/between_002.md`
before the next id.

A probe or a boot script is deleted before a
timed ride. Do not leave one in the tree.

## What stays

`near_line` still owns "she is at a fence":
nearest fence within 4 m, that fence's own
`related` or none. `NEAR_FENCE_M` stays 4.
Michelle still says a line once when it
changes, and again if she leaves and comes
back. WASD and the walker stay. The course
line from `walk_line` stays the first line
of the label.

The knee shares, the fold, the trot plus, and
the roll stay. Clocks:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The near
board is the floor: 21/23, worst move 0.03 s,
`hk_int_007` at 84.96. Outside a window,
revert this job's line. Do not run a board
if you changed no code.

## Step 0 — where she is, before any new rule

No code until this table is in `dist/between_002.md`.
Call the function you have. Do not guess.

hk_adv_002:

| where | position | what near_line says now |
| --- | --- | --- |
| on fence 2 | its pos | Fence 2. natural vertical. 1 to 3. |
| midpoint 2 → 3 | (-6.76, -12.40) | print it |
| on fence 3 | its pos | Fence 3. plank vertical. 2 to 4. |
| midpoint 3 → 4 | the halfway point you compute from the file | print it |
| on fence 10 | its pos | its own 2 to 11 |
| midpoint 10 → 11 | halfway | print it |
| middle of the ring | (0, -3) | empty |

The four lessons, fence 2's midpoint to fence 3.
Print the line.

If the 2 → 3 midpoint already says "1 to 3."
and the 3 → 4 midpoint already says "2 to 4."
and the ring is still empty, the line under
her feet is already named. Write that. Do
not add a rule. Skip the clocks. The near
board stands.

## Phase 1 — name the segment she is on

Only if a midpoint above is wrong or empty.

A related line is the segment from a fence
to the fence its own `related.to` names.
She is on that segment when her closest
point on the segment lies between the two
ends, and she is within 2 m of that segment
on the ground. 2 m is the corridor. It is
not a wider circle around a fence.

Priority:

1. Within 1.5 m of a fence, today's
   `near_line`. She is at the standard.
2. Else if she is on exactly one related
   segment, that segment's line:
   `Fence {from}. {name}. {strides} to {to}.`
   The name and the strides come from the
   fence that owns the related, the in-fence,
   not from the out-fence's next line.
3. Else today's `near_line`.

If two segments both claim her, keep the
one she is closer to. Do not invent a third
priority.

After, the same table. The 2 → 3 midpoint
says "1 to 3." The 3 → 4 midpoint says
"2 to 4." Fence 3 under its standard still
says "2 to 4." The ring at (0, -3) is
still empty. A lesson fence-2 midpoint
says "2 to 3."

Michelle says the new line once when it
changes. A boot on the 2 → 3 midpoint of
hk_adv_002, deleted after: one
`MICHELLE soft` of that line, not a repeat
on the next frames. Then move her to the
ring and the line goes quiet.

Three clocks if you kept it. Then style
once on `hk_beg_035`. B refused fence 1,
0 rails, Idle, hinds 0.053. C one rail on
fence 3 in the air. Copy the knock line.
A cert log still has no walk line.

One full board. The 21 within 0.1 s of the
near board. 0.10 s counts. No new rail,
`teleported=false`. `hk_int_007` may sit
on 84.96. Copy the log before `--playtest`.
Playtest: clear 0 / refuse 4 / rail 4.

If the board moves past 0.1 s, revert the
segment rule. The 4 m fence label stays.

## Write it

`dist/between_002.md` holds the before table,
the after table, the boot lines, and, if you
kept code, the clocks and the board.

Top of `dist/STATUS.md`: the line under her
feet as kept or as already named, and the
clocks from the tree you left. The 4 m
fence label stays in that paragraph. A job
that widens 4 m is not this job. A job
that edits a course file is not this job.
