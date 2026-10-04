# Opus — overnight, twenty-three walks

You are in `E:\Workspace\Madison`. This is the
overnight job. The last night finished in a
minute because it was one script and a sentence.
This night is twenty-three walks, one Godot
each, and you do not start the next until the
row is in the file.

Do not batch the twenty-three into one
SceneTree. Do not audit them by calling
`near_line` in a loop and calling that a walk.
A walk is the arena, the walker, the label, and
Michelle. One course. Then the file. Then the
next course.

Do not stop after hk_int_009. Do not stop after
the first walk. Do not go to bed with a Godot
still riding and that course's row unwritten.
If you finish every phase, write `dist/STATUS.md`
and stop.

## Silent

Ernie is asleep. A Godot window locks the desktop.
`--headless` is the first argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`
when the phase says a cert. A walk boot is a
throwaway script, deleted before the next
course, not left in the tree. No window, no
editor, no F5, no `--artshot`, no `ride_ids.py`.
One Godot. One id 8 minutes, a fresh id 12,
a style id 15, the full board 70. No
`RIDECERT round` in 2 minutes is a compile
error: kill only that process. If the wrapper
dies for memory, wait for the Godot that is
already riding. Do not start a second board.
Do not kill Godot to free RAM. The log is
opened with `"w"`. Copy the lines into
`dist/long_002.md` before the next launch.

## What stays

Do not edit a course file, `walk_text`,
`horse.gd`, or `ride_ai.gd`. Do not export.
Do not launch `dist\Abbott.exe`. Do not chase
23/23. Do not widen 4 m, 1.5 m, or 2 m.
`NEAR_FENCE_M` stays 4. `AT_FENCE_M` stays 1.5.
`LINE_CORRIDOR_M` stays 2. The height, the
spread, and the stride words stay. The knee
shares, the fold, the trot plus, and the roll
stay.

`dist/card_002.md` is the audit. 23 courses,
180 fences, 45 related midpoints, one failure.
hk_int_009's 2 → 3 midpoint reads fence 10,
because fence 10's rail is 1.21 m from that
midpoint and the rail rule runs first. Fence
10's centre is 2.71 m off the segment. You
do not "fix" that by moving 1.5 m.

Clocks, once, at the end, after the walks:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The card
night left 18.53 / 91.6 / 94.0. The between
board is 21/23, `hk_les_001` 18.49,
`hk_int_007` 84.94. Outside a window, revert
the phase that was not only a walk boot.

## Phase 1 — fence 10 does not take the line

Before any walk. One change in `near_line`.

She can be claimed by a rail and by a segment
at the same time. The smaller distance wins.

- Distance to a fence is the distance to its
  rail, the same standard-to-standard segment
  you already use. That fence's own line.
- Distance to a related segment is the distance
  to the segment, and only while her closest
  point lies between the ends. That is the
  in-fence's line, including `Walking back.`
  when she faces the in-fence.
- If both claim her, keep the one whose
  distance is smaller. A tie keeps the segment.
- If neither is inside its own limit, the old
  4 m nearest-fence rule remains.

On the hk_int_009 midpoint the segment
distance is about 0 and the rail is 1.21 m,
so the line is fence 2's:
`Fence 2. plank vertical. 0.76 m. 3 strides to fence 3.`
Use the `h` the file actually stores if it
is not 0.76.

On fence 10's own `pos` the rail distance is
0 and the segment is about 2.71 m, outside
the corridor, so the line is fence 10's.

On hk_adv_002 fence 3, under a standard, the
rail distance is 0, so fence 3's own line
stays, spread and strides included.

Print those three, plus the hk_adv_002
2 → 3 midpoint (still fence 2's one stride,
not fence 3's), plus the ring (0, −3), still
empty. Then the 45 midpoints again, in one
script if you want. The hk_int_009 row is
the one that has to change. Every other
midpoint that matched last night still
matches. If a new midpoint goes wrong,
revert this rule and write the row. Do not
try a second rule.

You are not done. The walks are next.

## Phase 2 — twenty-three walks

One Godot launch per id. The ids are every
entry in `SHIP.json`: 4 lesson, 6 beginner,
6 intermediate, 4 advanced, 3 jump-off.
That is 23. The order is the file's order.

Each launch loads the real arena, starts the
walk on that course, and does only this:

1. Place her on fence 1's `pos`. Record the
   walk label and the one Michelle line.
   She must not say it again on the next
   half second.
2. If the course has a related line, place
   her on that midpoint, facing the out.
   Record the label. It is the in-fence's
   line. No `Walking back.`
3. Turn her to face the in-fence. Record
   the label. It starts with `Walking back.`
   Said once.
4. Place her on a point farther than 6 m
   from every fence. The near-line is empty.
   The course line remains.

Write that course's four lines into
`dist/long_002.md` before you launch the
next id. If you stop for the night, the
file shows the last id. Continue from the
next one. Do not relaunch the ones already
written.

hk_int_009's related midpoint is part of
its own launch, not a special case. It
reads fence 2's three strides, not fence 10.

A launch that prints all 23 courses is not
this phase. Delete the boot before the next
id.

You are not done.

## Phase 3 — the next lesson

`course_seed` starts at 1. `_pick_id` is
`seed % count`. The lesson list has four
ids, so a person who never changes the seed
walks the same lesson forever. The cert
sets `course_seed` from the spec before it
builds. That line stays. A cert of
`hk_les_001` still loads `hk_les_001`.

After a lesson round completes, and only
then, advance the saved seed by one. The
next lesson start uses the next id. Do not
advance on schooling or a show. Do not
advance in `ride_cert.gd`.

Prove it with four launches, not one loop
that only calls `_pick_id`. Each launch
starts a lesson the way the title does,
prints the loaded course id, and quits.
Seeds 1, 2, 3, 0. Four different ids, the
four in `SHIP.json`, in that order. Write
them down as you go.

Then one pin cert:

`python tools/content_factory/run_ridecert.py --ridecert-id=hk_les_001`

It is still `hk_les_001`, confidence 91.0
at the end, inside 18.50–18.60. If the
cert loads a different lesson, revert the
seed change.

You are not done.

## Phase 4 — the clocks, the style, the board

Once. After phase 3. Not before the walks.

Three clocks. Copy the lines. No walk
line, no `Walking back`, no `spread` in
the cert log.

Style, once, `--ridecert-style --ridecert-id=hk_beg_035`.
A clear. B refused fence 1, 0 rails, Idle,
hinds 0.053. C one rail on fence 3 in the
air. Copy the knock line.

One full
`python tools/content_factory/run_ridecert.py`.
Render with `board_table.py`. The 21 within
0.1 s of the between board. 0.10 s counts.
No new rail, `teleported=false`.
`hk_int_007` may sit on 84.94. Copy the
board log before the playtest. Headless
`--playtest`: clear 0 / refuse 4 / rail 4.

If the board moves past 0.1 s, revert the
rail-versus-segment change and the lesson
seed. The height, the spread, and the
stride words stay. Run the three clocks
again after that revert and write them.
Do not start a second board while the
first Godot is alive.

## Write it

`dist/long_002.md` is written as you go.
The hk_int_009 before and after. Then one
block per course, in order, from the arena.
Then the four lesson ids. Then the clocks,
the style, the board.

Top of `dist/STATUS.md`: the night. How
many walks are in the file. Whether
hk_int_009's midpoint names fence 2. Whether
the next lesson advances. The clocks you
left. The card paragraph stays under it.

A job that walks twenty-three courses
inside one process is not this job. A job
that stops after the audit script is not
this job.
