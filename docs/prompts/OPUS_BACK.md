# Opus — her back over the fence

You are in `E:\Workspace\Madison`. This is a long job. Do not
stop after the pitch. Do not write `dist/STATUS.md` and quit
until her back over the fence has been kept or reverted, and
one half-halt has been printed on both horses.

The air hip stays. `hk_int_007` at 85.03 is a keep. The
rule is within 0.1 s, and 0.10 s is inside it. Do not
revert the two air `SIT_HIP` lines. Do not chase that
row back to 84.93.

`dist/seat_002.md` closed her hip in the air. At u 0.55
her eased hip is 26.18° on the pin and 29.95° on day-one.
Her eased pitch at that same sample is still one number:
−37.52° against −37.65°. The helmet looks down and the
seat closes, and the jacket line over the fence does not
read him.

The elbows over the fence stay a written negative. On
the seat job's own step 0 they were 4.4° apart at
u 0.55, and after the hip they were 0.35° apart. That
is not a ruler. Do not add a shoulder in the air.

The rein stays a straight rod. The five `hk_adv_002`
landings stay a written negative. The tail hair stays
a written negative. The late fist stays a written
negative. Do not move her fist target. The crest stays
the pin's crest. The return stays as printed: no bend
in `bascule.gd`. Do not edit `ride_ai.gd`. Do not edit
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
`RIDECERT hk_…` line into `dist/back_002.md` before the
next id. Copy the board log out before `--playtest`.

A probe is inserted once and stripped before a timed
ride. Do not leave one in the tree. A throwaway scene
is deleted after. The scene file does not stay.

## What stays

- `FOLD_HEAD` 30, on the two-point, the arc, and the sit head
- `SIT_HIP` 10, in the sit and in the air. Do not raise it.
  Do not remove the air lines.
- the halt: `head_x -= 20 * _hand_unrest()`,
  `hip_x += 9 * _hand_unrest()`, gait 0 only
- `SHOULDER_HALT` −40, `SHOULDER_GIVE` 19 on gaits 1–3
- the nod lines and the hip lines on the moving gaits
- nose dot +1, hips on the seat point, fists on the target
- `land_recover` 2.72, `TAKEOFF` 2.55, `collect_pulse`,
  `GAIT_SPEED`, `STRIDE_HZ`, the beat gate
- the jump key table. A pitch share goes after the
  interpolation, beside `FOLD_HEAD`.
- the crest at u 0.55 on the pin: round +15.0, Neck1
  −21.4, fore cannon −30.2
- `bascule.gd`, `ride_ai.gd`, `ride_cert.gd`,
  `game_state.gd`, both course trees

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

`teleported=false`, round complete. The seat job left
18.54 / 91.58 / 94.01, faults 0 / 2 / 3, 0 rails. The
board is 21/23. `hk_int_007` is 85.03, and that counts
as inside 0.1 s of the fold board's 84.93. Outside a
window, revert that phase only. One attempt on the
pitch. If it fails, write the degrees and go to the
half-halt. Do not spend a second coefficient.

## The leave stays one pose

Fences 3 and 12 of `hk_adv_002` change 0.00° in pitch,
hip, and head. The pin's hip there is 29.80, which is
key 28 plus 10 × 0.18. A pitch share at `last_stride` 1
has to be the same pitch share at jump u 0. A leave
that changes by 8° or more is a revert.

Jump u 1 is pitch key 2. The sit is pitch 2. The pitch
share has to be on both, or her back steps when he
lands. Same number, three places: the two-point scaled
by `last_stride`, the arc at 1, and the sit window
(`land_recover` > 0, not jumping, `last_stride` ≤ 0.20).

After a phase that touches pitch, ride pin `hk_adv_002`
once. Print fences 3 and 12: target pitch, hip, and
head on the frame before and on the first jumping
frame. All three stay at 0.00° of change. The round
completes, 0 rails, `teleported=false`. Copy the line.

## Step 0 — her back, before the share

No pose code until this table is in `dist/back_002.md`.
One probe. Pin `hk_les_001`, then fresh. Strip it
before any timed clock.

Fence 1. The target pitch `_update_rider` is about to
apply, and the eased `rider_body` pitch. Also the
helmet, the eased hip, each fist's distance to its
target, and `_hand_unrest()`.

| sample | when |
| --- | --- |
| two-point | the frame before fence 1 leaves |
| air | u 0.20, u 0.55, u 0.85 |
| sit | 0.5 s after fence 1 lands |

If the eased pitch is already at least 3° apart at
u 0.55, her back already reads him. Do not add a
share. Go to the half-halt.

The seat rows say it is flat. Reprint it. A number
you did not just print is not the before.

On the pin's u 0.55 row, print how many degrees of
eased pitch you get per degree of target pitch, from
two samples on that ride whose targets differ. One
number. The share comes from that, once.

## Phase 1 — one share, more folded on day-one

Only if u 0.55 is under 3° apart.

She folds more, not less. Pitch goes more negative.
One constant, `FOLD_PITCH`, times `_hand_unrest()`:

- after the last_stride lerp, `pitch -= FOLD_PITCH * _hand_unrest() * s`, gait ≥ 1, not jumping
- after the jump keys, `pitch -= FOLD_PITCH * _hand_unrest()`
- in the sit window, beside the sit's head and hip lines, `pitch -= FOLD_PITCH * _hand_unrest()`

Pick `FOLD_PITCH` from the step-0 ratio so the eased
pitch at u 0.55 should land about 3° apart. The pin
moves a little (his unrest is 0.18). One attempt. Do
not try a second number if it misses.

After, both horses:

- eased pitch at least 3° apart at u 0.55
- the pin's eased pitch within 4° of the step-0 pin row at that sample
- helmets still about 3.8° / 4.9° / 5.2° apart on the two-point, u 0.55, and the sit. If the pitch share moves any of those gaps by more than 0.5°, revert
- eased hip still about 3.1° apart at the two-point and about 3.8° at u 0.55. If either gap falls under 3°, revert
- fists: a hand that was within 1 cm in step 0 stays within 1 cm. A hand may not move more than 0.5 cm farther from its target than its own step-0 distance. The late fist already crosses 1 cm on some rides at u 0.85. That row stays a written negative. Do not move the target to clean it up
- two-point heel within 2 cm of the step-0 two-point
- pin Neck1 at u 0.55 still −21.4

One attempt. If the eased pitch is still under 3°,
or a fist or the helmet or the hip fails, revert all
three pitch lines and write the degrees. The air hip
and the helmet shares stay.

Three clocks if you kept it. Then the `hk_adv_002`
leave check. Then the half-halt. You are not done.

## Phase 2 — one half-halt

Print only, unless step 0 of this phase shows her
flat while his neck is not.

The hands job left the half-halt because day-one's
neck stayed up through it. Her own pitch, hip, and
helmet at that sit were not printed. `collect_pulse`
sets pitch 3, hip 16, head 2, and the stride terms
still add when `land_recover` is 0.

Both horses. Catch the deepest `collect_pulse` above
0.10 on `hk_les_001`, not during a jump and not while
`last_stride` is above 0.20 (that sample is the
two-point, already kept). Print `collect_pulse`,
Neck1, eased pitch, eased hip, helmet, `_hand_unrest()`.

If the ride never holds that sit long enough to read,
one throwaway scene, one half-halt, deleted after.
Do not leave the scene in the tree.

If her helmet or her hip is already at least 3° apart,
the half-halt already shows him. Write the row. Do
not code a new sit. Do not change `collect_pulse`.

If both are under 3° and his Neck1 is still at least
8° higher on day-one, one constant share of
`_hand_unrest()` on `head_x` and `hip_x` inside the
`collect_pulse` block only, not a new pulse and not
the stride sine. One attempt. The pin's check on
style B has to stay the pin's halt, not day-one's
headset. If the share puts that headset on the check,
revert. Two fails: the half-halt is a negative. The
pitch phase stays if it was kept.

Three clocks only if this phase kept code.

## The moving picture still holds

After the last phase you kept, one throwaway scene,
deleted after. Halt, walk, trot, canter, pin and
day-one. They still match `dist/halt_002.md` on the
halt means (helmet at least 3° apart, both elbows at
least 4°, hip at least 3°, peak-to-peak about 0) and
`dist/same_002.md` within 0.3° and 0.5 cm on the
moving gaits. Hoof 0.052–0.053. If the pitch share
leaks into a gait or into the halt, revert it.

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
The 21 within 0.1 s of the seat board, and 0.10 s
counts. No new rail, `teleported=false`. `hk_int_007`
may sit on 85.03. That is not a revert. Copy the
board log before the playtest. Headless `--playtest`
after that copy: clear 0 / refuse 4 / rail 4.

If no phase kept code, do not run style and do not
run the board. The seat 21/23 stands.

If the board moves past 0.1 s, revert this job's
pitch lines. The air hip, the helmet shares, the
sit, the crest, and the straight rein stay.

## Write it

`dist/back_002.md` holds the pitch rows before, the
same rows after if you kept the share, the fences
3 and 12 lines, the half-halt row, the clocks, and,
if you ran them, the style lines and the board.

Top of `dist/STATUS.md`: the back as kept or as the
degrees you reverted, the half-halt as already
showing or as the constant you kept, and the clocks
from the tree you left. The air hip stays in that
paragraph. `hk_int_007` at 85.03 stays. A job that
removes the air `SIT_HIP` lines is not this job. A
job that adds a shoulder in the air is not this job.
A job that snaps fences 3 and 12 is not this job.
