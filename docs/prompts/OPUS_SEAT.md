# Opus — her seat closes in the air

You are in `E:\Workspace\Madison`. This is a long job. Do not
stop after the hip. Do not write `dist/STATUS.md` and quit
until the air hip has been kept or reverted, and the
landing return has been printed on both horses.

`dist/fold_002.md` kept her helmet. `FOLD_HEAD` is 30.
Through the two-point, the arc, and the sit, day-one's
helmet is 4.00°, 5.01°, and 5.20° off the pin's. Her
eased hip over the fence did not move. At u 0.55 it is
24.46° on the pin and 24.42° on day-one. The sit's
`SIT_HIP` of 10 closes her hip only while she is
actually sitting. In the air the hip key is the same
number on both horses.

The elbows over the fence stay a written negative.
Step 0 had them 2.8° apart at u 0.55. A later ride of
the same fence had them 0.24° apart. That swing is not
a ruler. Do not add a shoulder in the air. Do not
re-gate phase 3 of the fold job.

The rein stays a straight rod. The five `hk_adv_002`
landings stay a written negative. The tail hair stays
a written negative. The late fist stays a written
negative. Do not move her fist target. The crest stays
the pin's crest. Do not edit `ride_ai.gd`. Do not edit
`_place_cam`. Do not move a fence. Do not export. Do
not launch `dist\Abbott.exe`. Do not chase 23/23.

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
opened with `"w"`. A pin id writes `dist/ridecert_godot.log`.
A fresh id writes `dist/ridecert_fresh.log`. Copy each
`RIDECERT hk_…` line into `dist/seat_002.md` before the
next id.

A probe is inserted once and stripped before a timed
ride. Do not leave one in the tree. A throwaway scene
is deleted after. The scene file does not stay.

## What stays

- `FOLD_HEAD` 30, on the two-point, the arc, and the sit head
- `SIT_HIP` 10, in the sit. You may use this same 10 in
  the air. You may not raise it.
- the halt: `head_x -= 20 * _hand_unrest()`,
  `hip_x += 9 * _hand_unrest()`, gait 0 only
- `SHOULDER_HALT` −40, `SHOULDER_GIVE` 19 on gaits 1–3
- the nod lines and the hip lines on the moving gaits
- nose dot +1, hips on the seat point, fists on the target
- `land_recover` 2.72, `TAKEOFF` 2.55, `collect_pulse`,
  `GAIT_SPEED`, `STRIDE_HZ`, the beat gate
- the jump key table. Add the share after the
  interpolation, the way `FOLD_HEAD` is added.
- the crest at u 0.55 on the pin: round +15.0, Neck1
  −21.4, fore cannon −30.2
- `bascule.gd` in phase 1. Phase 2 may read it. It may
  not put the worry back on the crest.
- `ride_ai.gd`, `ride_cert.gd`, `game_state.gd`,
  both course trees

`_hand_unrest()` starts at 0.18 on the pin and about
0.565 on day-one. Print it on the frame you measure.

The pin is `--ridecert-id=hk_les_001`. Day-one is
`--ridecert-fresh --ridecert-id=hk_les_001`. The next
pin ride has to start from `_pin_stats`. If a pin clock
prints a confidence near 50, the fresh ride leaked.
Revert the phase.

A keep, after every phase that touches code:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The fold job left
18.53 / 91.59 / 94.01, faults 0 / 2 / 3, 0 rails. The
board is 21/23, worst move 0.03 s on `hk_int_005`.
Outside a window, revert that phase only. One attempt
on the hip. If it fails, write the degrees and go to
the return. Do not spend a second coefficient.

## The leave stays one pose

Fences 3 and 12 of `hk_adv_002` change 0.00° in pitch,
hip, and head, because the two-point at `last_stride` 1
and the jump's first key carry the same share. Any hip
share at `last_stride` 1 has to be the same hip share
at jump u 0. A leave that changes by 8° or more is a
revert.

The sit hip and the arc hip meet at the landing. Jump
u 1 is hip key 20. The sit is hip 20 plus
`SIT_HIP * _hand_unrest()`. The air share has to be
that same `SIT_HIP`, not a new number, or her hip steps
when he lands.

After a phase that touches the hip in the air, ride pin
`hk_adv_002` once. Print fences 3 and 12: `land_recover`
at the leave, target pitch, hip, and head on the frame
before and on the first jumping frame. All three stay
at 0.00° of change, and under 8°. The round completes,
0 rails, `teleported=false`. Copy the line.

## Step 0 — the hip and the heel, before the share

No pose code until this table is in `dist/seat_002.md`.
One probe. Pin `hk_les_001`, then fresh. Strip it
before any timed clock.

Fence 1. Targets `_update_rider` is about to apply,
and the eased pose. Hip, helmet, and the heel-to-iron
distance, both feet, mean. Also `_hand_unrest()` and
each fist's distance to its target.

| sample | when |
| --- | --- |
| two-point | the frame before fence 1 leaves |
| air | u 0.55 |
| sit | 0.5 s after fence 1 lands, `land_recover` still up, `last_stride` ≤ 0.20 |

If the eased hip is already at least 3° apart at the
two-point or at u 0.55, the air already closes. Do
not add a share. Go to the return.

The fold job's rows are the reason this phase exists.
Reprint them anyway. A number you did not just print
is not the before.

## Phase 1 — the same 10, through the two-point and the arc

Only if those two hip rows are under 3° apart.

After the last_stride lerp, `hip_x += SIT_HIP * _hand_unrest() * s`,
gait ≥ 1, not jumping. After the jump-key interpolation,
`hip_x += SIT_HIP * _hand_unrest()`, held through the arc.
`SIT_HIP` stays 10. The sit block stays as it is. The
head block stays as it is. The keys stay the keys.

This does not run at gait 0. It does not run in the sit
window (`land_recover` > 0, not jumping, `last_stride`
≤ 0.20), which already has the 10.

After, both horses:

- eased hip at least 3° apart at u 0.55, or at the
  frame before the leave
- the pin's eased hip within 4° of the step-0 pin row
- helmets still about 4° / 5° / 5.2° apart on the
  two-point, u 0.55, and the sit. If the hip share
  moves the helmet, revert
- heel-to-iron at the two-point within 2 cm of the
  step-0 two-point, mean, both feet. In the air, print
  the heel and do not require the iron. If the
  two-point heel lifts, revert
- fists within 1 cm at u 0.20, 0.55, and 0.85
- pin Neck1 at u 0.55 still −21.4

One attempt. If the eased hip is still under 3°,
revert the air lines and write the degrees. Do not
raise 10. The sit keeps its 10 either way.

Three clocks if you kept it. Then the `hk_adv_002`
leave check. Then the return. You are not done.

## Phase 2 — he comes back, and she is already looking

Print only, unless a bone is left behind. Do not
retune `FOLD_HEAD` or `SIT_HIP` in this phase. Do not
put worry on the crest.

The worry in `bascule.gd` is off by u 0.30 of a jump
and comes back over the first half-second of
`land_recover`. The fold job printed Neck1 at the
landing frame (both near −34) and at 0.5 s (pin
−18.72, day-one −8.82). It did not print the tail or
the ears, and it did not print the middle of the return.

Both horses, fence 1 of `hk_les_001`, one probe:

| t after the land | print |
| --- | --- |
| 0.00 s | Neck1, Tail1, Ear1.L, her eased helmet, his `_hand_unrest()` |
| 0.25 s | the same |
| 0.50 s | the same |

Also u 0.55 of that fence: Neck1 on both horses. It
stays about −21.4. If your probe moves it, the probe
is in the crest. Take it out.

The return is already the picture when, at 0.50 s,
day-one's Neck1, Tail1, and Ear1 are each off the
pin's by about the worry weight (neck about 10°, tail
about 10°, ear larger), and her helmet is still the
sit's 5° and did not step by 8° on any one of those
three frames. Write that. Do not edit `bascule.gd`.

If the neck has split and the tail or the ear has
not, the bend for that bone is missing from `_worry`.
One bend, the same `w` the neck uses, one attempt.
Do not add a second weight. If u 0.55 Neck1 moves, or
a clock leaves the window, revert the bend.

Three clocks only if this phase kept code.

## The moving picture still holds

After the last phase you kept, one throwaway scene,
deleted after. Halt, walk, trot, canter, pin and
day-one. They still match `dist/halt_002.md` on the
halt means (helmet at least 3° apart, both elbows at
least 4°, hip at least 3°, peak-to-peak about 0) and
`dist/same_002.md` within 0.3° and 0.5 cm on the
moving gaits. Hoof 0.052–0.053. If the air hip leaks
into a gait or into the halt, revert it.

## The check is still a check

Style, once, only if a phase kept code:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds
0.053, Neck1 around +11.7, Tail1 around −0.3. Her
helmet on that check heads for the pin's halt
(+11.31), not day-one's (+14.76). C one rail on
fence 3 in the air. Copy the knock line.

One full `python tools/content_factory/run_ridecert.py`.
Render with `python tools/content_factory/board_table.py`.
The 21 within 0.1 s of the fold board, no new rail,
`teleported=false`. Copy the `RIDECERT` lines, or the
board log, before the playtest, because the next
launch opens the log with `"w"`. Headless `--playtest`
after that copy: clear 0 / refuse 4 / rail 4.

If no phase kept code, do not run style and do not
run the board. The fold 21/23 stands.

If the board moves, revert the air hip. The helmet
shares, the sit, the crest, and the straight rein stay.

## Write it

`dist/seat_002.md` holds the hip and heel rows before,
the same rows after if you kept the share, the fences
3 and 12 lines, the return table, the clocks, and,
if you ran them, the style lines and the board.

Top of `dist/STATUS.md`: the air hip as kept or as
the degrees you reverted, the return as already back
or as the one bend you kept, and the clocks from the
tree you left. A job that raises `SIT_HIP` is not
this job. A job that adds a shoulder in the air is
not this job. A job that snaps fences 3 and 12 is
not this job.
