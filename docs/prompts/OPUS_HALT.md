# Opus — overnight, she shows it at the halt

You are in `E:\Workspace\Madison`. This is the overnight job.
Work until the board and the playtest are written, or until
each phase below is either kept or a written negative. Do not
stop after the first keep. Do not stop after the halt helmet.
Do not go to bed with a Godot still riding and the table
unwritten. If you finish every phase, write `dist/STATUS.md`
and stop. Do not invent a new channel after that.

Ernie is asleep. A Godot window locks the desktop. Never open
one. `--headless` is the first argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`.
No windowed exe, no editor, no F5, no `--artshot`, no
`ride_ids.py`, no `dist\Abbott.exe`. One Godot. Timeouts: one
id 8 minutes, a fresh id 12 minutes, a style id 15 minutes,
the full board 70 minutes. No `RIDECERT round` in 2 minutes
is a compile error: kill only that process. If the wrapper
dies for low memory, the Godot it already started is still
the ride. Wait for it. Do not start a second board. Do not
kill Godot to free RAM. Copy each `RIDECERT hk_…` line out
before the next id, because the log is opened with `"w"`.

A probe is inserted once and stripped before a timed ride.
Do not leave one in the tree. Walk and trot on `hk_les_001`
are shorter than a stride. Halt, walk, and trot numbers come
from one throwaway scene, deleted after. The scene file does
not stay.

## What is already true

`dist/same_002.md` is the picture. Do not reprint it as a
way to avoid the work. Use it as the floor.

She faces his ears. Nose dot +1.000 at the halt, the walk,
the trot, and the canter. Her hips are on the seat point.
`visual.position = -(visual.basis * hip)` stays. The yaw
stays. The side signs stay. The fist target
`Vector3(side * 0.05, 0.09, -0.22)` stays.

At the walk, the trot, and the canter, day-one already
shows: elbows 4.46° / about 4.76° more, hips about 3.6°
more, helmet 2.33 / 5.84, 3.67 / 8.40, 2.85 / 7.50. Do not
retune `SHOULDER_GIVE` 19, the three nod lines (walk 26,
trot 48, canter 64), or the three hip lines (walk 12,
trot 18, canter 22). `post * 32` stays.

At the halt, gait 0, she is the same horse on both stats.
Helmet mean +9.69° both. Elbows 129.98° / 134.20° both.
Hip peak-to-peak 0.07° both. Hands travel 0.001 m both.
Every rider term kept so far is a stride term, and the
stride terms are off at gait 0. He is not the same. Neck1
is +9.80 on day-one and −0.09 on the pin. Tail1 is −10.12
and −0.22. That is the job. When he stands, she should
show it too.

The tail hair stays a written negative. Tail7 at the walk
and the trot differs by 5.1 cm and both tips hang. Do not
touch Tail2–Tail5. The rein stays a straight rod. The five
`hk_adv_002` landings stay a written negative. The late
fist stays a written negative. The crest, the hoof, the
pastern, the beat, and the landing camera stay. Do not
edit `ride_ai.gd`. Do not move a fence. Do not chase 23/23.
Do not export.

The pin's `_hand_unrest()` is 0.18, not 0, because feel
is 36 on both horses. His halt pose may shift a little.
The test is the difference. Day-one's unrest is about
0.56. A term in proportion to unrest gives him a small
change and her a larger one.

## Frozen

- the yaw, the side signs, the seat line, the fist target
- `SHOULDER_GIVE` 19 on gaits 1, 2, and 3. The halt entry
  may change. The other three numbers may not.
- the nod lines and the hip lines on gaits 1, 2, and 3
- `post * 32`, `pitch` and `rest` on the moving gaits
- `bascule.gd`
- `refuse_scale`, `turn_scale`, `scope_bonus`, `balance_need`,
  `charge_need`, `_might_look`
- leave windows, `TAKEOFF` 2.55, `collect_pulse` 0.95,
  `GAIT_SPEED`, `STRIDE_HZ`, `land_recover` 2.72, the beat
- `_process_jump`, `_place_cam`, the rein
- the crest at u 0.55: round +15.0, Neck1 −21.4, fore
  cannon −30.2
- lowest hoof 0.052–0.053
- nose dot positive
- hips on the seat point
- fists within 1 cm of the target, reach still spare
- `ride_ai.gd`, both course trees, `ride_cert.gd`,
  `game_state.gd`

A keep, after every phase that touches code:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The give board is the
floor: 18.53 / 91.61 / 94.00. The window is the keep.
Outside it, revert that phase only. Two fails on one
phase: write the negative and go to the next phase. Do
not spend a second coefficient on the same joint.

The moving gaits are the regression check after every
kept phase. One scene. Walk, trot, canter, pin and
day-one. Helmet, elbow peak-to-peak, hip peak-to-peak,
wrist travel, hoof. They have to still match
`dist/same_002.md` within 0.3° and 0.5 cm. If a halt
term leaks into a moving gait, revert it.

## Phase 1 — her head at the halt

Gait 0 only. Not a sine. There is no stride to ride.
Add a constant share of `_hand_unrest()` to `head_x` in
the halt block of `_update_rider`, and nowhere else.

After, one second of halt, both horses:

- helmet pitch mean at least 3° more on day-one than
  on the pin
- peak-to-peak still about 0. She is still, not nodding
- nose dot still +1
- elbows, hip, and hands at the halt still the same
  on both horses, unless a later phase changes them
- the moving-gait table still holds

One attempt. If you cannot get 3° without a wave, or
without moving the walk helmet off 2.33 / 5.84, revert
and write the degrees.

Three clocks if you kept it. Then phase 2. You are not
done.

## Phase 2 — her elbows at the halt

The halt has no swing, so peak-to-peak is the wrong
ruler. The means are 129.98° / 134.20° on both horses.
Day-one's means have to differ by at least 4° from the
pin's, on both arms.

`SHOULDER_GIVE[0]` is 0 because the stride sine is off
at gait 0. Do not turn that sine on. A constant shoulder
angle, times `_hand_unrest()`, only while gait is 0 and
he is not jumping and `land_recover` is 0. The 19 on
the other three gaits stays.

After:

- both elbow means at least 4° different, day-one
  against the pin, at the halt
- fists still on the targets, reach still spare
- the give of 19 on the moving gaits still reads
  about 4.46° / 4.76° more on day-one
- nose dot still +1, hips still on the seat
- helmet halt row, if phase 1 kept, still at least 3°

One attempt. If the arms lock toward 173°, the constant
is too large. Revert. Do not move the fist target to
buy the bend.

Three clocks if you kept it. Then phase 3.

## Phase 3 — her hip at the halt

`hip_x` mean at the halt. It is the same on both horses
now (peak-to-peak 0.07°). Add a constant share of
`_hand_unrest()` to `hip_x` in the gait 0 block only.
Not a sine. Not the walk's 12. Not `post * 32`.

Print the heel-to-iron mean and the farthest point
before you add it. The halt heel in the face job was
about 0.069 m. Stay within 2 cm of whatever this scene
prints before the term.

After: hip mean at least 3° more on day-one. Heel
inside that 2 cm. Elbows and helmet from the phases
you kept still hold. Moving gaits still hold.

One attempt. If the heel lifts, revert.

Three clocks if you kept it.

## The check is a halt

Style B stands the pin at gait 0. Your new terms run
there. That is allowed only if the horse's check stays
the check.

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds at
0.053, Neck1 around +11.7, Tail1 around −0.3. Her
helmet on that check is the pin's halt, not day-one's.
If her helmet on B matches the day-one halt row, revert
the halt head term. C one rail on fence 3 in the air
(`jumping=true`). Copy the knock line into
`dist/halt_002.md`.

If no phase kept code, do not run style and do not run
the board. The give 21/23 stands. Write that.

## The board, once

One full `python tools/content_factory/run_ridecert.py`
only if a phase kept code. Render with
`python tools/content_factory/board_table.py`. The 21
within 0.1 s of the board in `dist/give_002.md`, no
new rail, `teleported=false`. The give board's worst
move was 0.06 s on `hk_int_001`. A worse row than 0.1 s
reverts every halt term from this job. The yaw, the
seat, and the give of 19 stay.

Headless `--playtest` after the board line is copied:
clear 0 / refuse 4 / rail 4. Copy the five `PLAYTEST`
lines into `dist/halt_002.md`. If the wrapper dies and
Godot is still writing `dist/ridecert_godot.log`, wait
for `RIDECERT done`. Then copy
`dist/ridecert_results.json` yourself if the wrapper
did not. Do not start another board.

## Write it

`dist/halt_002.md` holds the halt rows before and after
each phase, the moving-gait check, the three clocks for
each phase you kept, the style lines, and the board.

Top of `dist/STATUS.md`: the halt helmet, the halt
elbows, and the halt hip, each as kept or as a
negative, the nose dot, and the clocks from the tree
you left. A job that only reprints `dist/same_002.md`
is not this job. A job that retunes the stride is not
this job.
