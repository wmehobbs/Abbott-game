# Opus — a one-stride does not wait

You are in `E:\Workspace\Madison`. This is a long job. Do not
stop after the first pair, and do not write `dist/STATUS.md`
and quit until every related in-fence on `hk_adv_002` is in
the table and each phase below is kept or a written negative.

A related line is two fences with a stride or two between
them. He lands and leaves again. `ride_ai.gd` already knows
that: on a related it does not sit the land. The picture
may still. Her land pose is the sit (pitch 2, hip 20) for
as long as `land_recover` is above zero, and the next
jump's fold starts from the two-point keys as if she had
been in two-point already. On a one-stride those two poses
meet on one frame.

The rein stays a straight rod. The five `hk_adv_002`
landings that lose only to a straight approach stay a
written negative. Do not reopen that test, and do not
edit `_place_cam` to chase it. Do not edit `ride_ai.gd`.
Do not move a fence. Do not export. Do not launch
`dist\Abbott.exe`.

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
`dist/line_002.md` before the next id.

A probe is inserted once and stripped before a timed
ride. Do not leave one in the tree.

## What stays

The halt job is kept. Do not retune it.

- `head_x -= 20.0 * _hand_unrest()` and
  `hip_x += 9.0 * _hand_unrest()` in the gait-0 block
- `SHOULDER_HALT` −40, `SHOULDER_GIVE` 19 on gaits 1–3
- the nod lines and the hip lines on the moving gaits
- nose dot +1, hips on the seat point
- `land_recover` 2.72, `TAKEOFF` 2.55, `collect_pulse`,
  `GAIT_SPEED`, `STRIDE_HZ`, the beat gate
- the crest, the chip, the pastern, the hoof plant
- the rein, the late fist, the tail hair
- `bascule.gd`, `ride_cert.gd`, `game_state.gd`,
  both course trees

You may change her jump blend and the air sounds. You
may not change how long he sits, how he steers, or
where the camera looks.

A keep, after every phase that touches code:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The halt board is
the floor: 21/23, worst move 0.06 s on `hk_int_001`.
Outside a window, revert that phase only.

## Step 0 — the four in-fences, before any pose code

`hk_adv_002` is the clear round. Its related in-fences
are 3 (one stride), 4 (two), 11 (two), and 12 (one).
Ride it once, headless, with one probe. No code until
this table is in `dist/line_002.md`.

On the frame `jumping` becomes true for each of those
four, and for fence 1 of the same round (he has been
cantering, `land_recover` is 0, that row is the
control):

| fence | strides | land_recover at leave | her pitch, frame before → u 0.05 | her hip_x, frame before → u 0.05 | camera height, that same frame | grunt u | previous thud still playing |

Pitch and hip are the values `_update_rider` is about
to apply, not a guess. Camera height is the lens, so
you can see a pop. You do not move the lens in this job.

Also print, for each of the four, whether a hoof
strike fired while `jumping` was true. The beat
returns before the strike today. If one fires in the
air, that is a row, not a theory.

If all four in-fences change pitch by under 8° and
hip by under 8° on that frame, and no thud is still
playing when the next grunt starts, the picture
already waits. Write that, do not add a blend, and
skip to the clocks only if you changed nothing — in
that case do not run a board. The halt 21/23 stands.

## Phase 1 — she leaves from the pose she is in

Only if an in-fence snaps. A snap is 8° or more of
pitch or hip on that one frame, and `land_recover`
was still above zero.

Blend from the pose she had on the frame before the
leave into the jump keys, over the first 0.15 of u.
The keys themselves stay. A normal leave, the control
row, `land_recover` already 0, still starts on the
keys. Fence 1's pitch and hip at u 0.05 stay within
2° of the step-0 row.

After, the same four rows. Each in-fence's one-frame
change is under 8°. The control is unchanged. Her
crest, his neck, and the hoof at the thud are
unchanged. You did not edit `ride_ai.gd`.

Three clocks if you kept it. Then phase 2.

## Phase 2 — the thud and the next grunt

On a one-stride the land and the next leave are close.
The thud plays when a fore hoof is within 2 cm of
0.053, or after 0.30 s, whichever is first. The grunt
plays at u 0.34 of the next jump.

From the step-0 rows: if a grunt starts while the land
stream is still playing, one class fix. The new grunt
is the true sound. Cut the thud that has not finished,
or let it finish and delay nothing that would move
the clock. Do not move the grunt off the fore-feet
leaving, and do not move the thud off the hoof on
the sand, except where the two occupy the same
moment on an in-fence.

Ride `hk_adv_002` again. The four rows: grunt still
at the leave, thud still on a hoof within 2 cm,
except the overlap you named. Fence 1 still thuds
once. No hoof strike in the air.

Three clocks if you kept it.

If step 0 had no overlap, this phase is a written
negative. Do not add a second sound.

## The rest of the round

Style, once, only if a phase kept code:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds
0.053, Neck1 around +11.7, Tail1 around −0.3, and her
halt is the pin's (helmet heading for about +11.3,
not day-one's +14.8). C one rail on fence 3 in the
air. Copy the knock line.

One full `python tools/content_factory/run_ridecert.py`.
Render with `python tools/content_factory/board_table.py`.
The 21 within 0.1 s of the halt board, no new rail,
`teleported=false`. Headless `--playtest` after the
board line is copied: clear 0 / refuse 4 / rail 4.

If the board moves, revert the blend and the sound.
The halt terms stay.

## Write it

`dist/line_002.md` holds the five rows before, the
five rows after each phase you kept, the three clocks,
the style lines, and the board.

Top of `dist/STATUS.md`: each in-fence as kept or as
already quiet, and the clocks from the tree you left.
A job that shortens `land_recover` is not this job.
A job that edits `ride_ai.gd` is not this job.
