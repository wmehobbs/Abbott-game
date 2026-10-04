# Opus — she still shows him when she stands up

You are in `E:\Workspace\Madison`. This is a long job. Do not
stop after the first pose. Do not write `dist/STATUS.md` and
quit until the two-point, the arc, and the sit have each
been printed on both horses, and each one is either kept
or a written negative.

`dist/line_002.md` measured `hk_adv_002`. On the one-strides
(fences 3 and 12) he leaves with `land_recover` still up,
and her target is already the jump's first key, −42 / 28,
on the frame before. `last_stride` is 1 on a related line,
so `_update_rider` has already lerped her out of the sit
and into that key. The change on the leave frame is
0.00° / 0.00°. That job added no blend. Leave it that way.
A blend across the leave, or a shorter `land_recover`, is
not this job.

Those keys do not read `_hand_unrest()`. Neither does the
sit (pitch 2, hip 20, head 6). The nod, the hip lines, and
`SHOULDER_GIVE` 19 run only on a gait, with `land_recover`
at 0 and not jumping. From the moment she stands into
two-point until she is cantering again, both horses can
wear one girl. This job prints that, and builds it only
where the print is flat.

The rein stays a straight rod. The five `hk_adv_002`
landings that lose only to a straight approach stay a
written negative. The tail hair stays a written negative.
The late fist stays a written negative: do not move her
fist target and do not anchor her hands anywhere new.
The crest stays the pin's crest. Do not edit `ride_ai.gd`.
Do not edit `_place_cam`. Do not move a fence. Do not
export. Do not launch `dist\Abbott.exe`. Do not chase
23/23.

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
`RIDECERT hk_…` line into `dist/fold_002.md` before the
next id.

A probe is inserted once and stripped before a timed
ride. Do not leave one in the tree. A throwaway scene
for the halt and the moving gaits is deleted after.
The scene file does not stay.

## What stays

The halt is kept. The moving gaits are kept. The line
job is a written negative.

- `head_x -= 20.0 * _hand_unrest()` and
  `hip_x += 9.0 * _hand_unrest()` in the gait-0 block
- `SHOULDER_HALT` −40, `SHOULDER_GIVE` 19 on gaits 1–3
- the nod lines (walk 26, trot 48, canter 64) and the
  hip lines (walk 12, trot 18, canter 22)
- nose dot +1, hips on the seat point, fists on the target
- `land_recover` 2.72, `TAKEOFF` 2.55, `collect_pulse`,
  `GAIT_SPEED`, `STRIDE_HZ`, the beat gate
- the crest at u 0.55 on the pin: round +15.0, Neck1
  −21.4, fore cannon −30.2
- the chip, the pastern, the hoof plant, the rein
- the jump key table's shape. You may add one share of
  unrest on top of a key. You may not replace the keys.
- `bascule.gd`, `ride_ai.gd`, `ride_cert.gd`,
  `game_state.gd`, both course trees

`_hand_unrest()` is 0.18 on the pin at the start of a
round (confidence 85, feel 36) and about 0.565 on
day-one (confidence 48, feel 36). Print the value on
the frame you measure. A clear schools him, so a later
fence is not the start of the round.

The pin is `--ridecert-id=hk_les_001`. Day-one is
`--ridecert-fresh --ridecert-id=hk_les_001`. Fresh
overwrites the save on purpose. The next pin ride has
to start from `_pin_stats` again. If a pin clock prints
a confidence near 50, the fresh ride leaked. Revert
the phase and ride the pin again.

A keep, after every phase that touches code:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The line job left
the halt board's tree: 18.53 / 91.6 / 93.99, faults
0 / 2 / 3, 0 rails. That board is 21/23, worst move
0.06 s on `hk_int_001`. Outside a window, revert that
phase only. Two fails on one pose: write the negative
and go to the next pose. Do not spend a second
coefficient on the same pose.

## Step 0 — both horses, fence 1, before any coefficient

No pose code until this table is in `dist/fold_002.md`.
One probe. Pin `hk_les_001`, then fresh `hk_les_001`.
Strip the probe before any timed clock.

On fence 1, print the targets `_update_rider` is about
to apply and the eased pose she shows. Pitch, hip, and
head are those targets. The helmet is the eased head
against her shoulders, the same angle the halt job
printed. Elbows are that job's elbow angle, both arms.
Also `last_stride`, `_hand_unrest()`, confidence, and
Neck1 against rest, so a flat girl on a different horse
is visible.

| sample | when |
| --- | --- |
| two-point | the frame before fence 1 leaves, and `last_stride` on that frame |
| air | jump u 0.20, u 0.55, u 0.85 |
| sit | the first frame after fence 1 where `land_recover` > 1.0 and `last_stride` ≤ 0.20. If this ride never has that frame, write "no sit on hk_les_001" and take the sit from the landing of fence 1 on `hk_adv_002`, pin and fresh. Do not invent one. |

A sample already shows him when day-one's pitch, or her
hip, or her helmet, is at least 3° off the pin's on the
eased pose, once she has been in that pose long enough
for the ease to arrive (the frame before the leave, and
u 0.55, not the first frame of a blend). An elbow sample
already shows him when each elbow mean is at least 4°
off the pin. A sample that already shows is a written
line. Do not add a term there.

If the two-point, u 0.55, and the sit all already show,
and the elbows at u 0.55 already show, write that, add
nothing, and do not run a board. The 21/23 stands.

## The leave stays one pose

Fences 3 and 12 of `hk_adv_002` change 0.00° / 0.00°
because the two-point target and the jump's first key
are the same numbers. Any share you add on the
two-point at `last_stride` 1 has to be the same share
on the jump at u 0, on that same frame, for both
horses. A one-stride leave that changes by 8° or more
of pitch or of hip is a revert of the term that did it.

After every phase that touches the two-point or the
jump keys, ride pin `hk_adv_002` once and print fences
3 and 12 the way `dist/line_002.md` printed them:
`land_recover` at the leave, target pitch and hip on
the frame before and on the first jumping frame. Both
rows stay under 8°. The round completes, 0 rails,
`teleported=false`. Copy the `RIDECERT hk_adv_002` line.
This ride is not a clock window. Do not start it while
another Godot is riding.

## Phase 1 — the two-point, and the first key with it

Only if the two-point row is flat.

After the `last_stride` lerp, not inside the key table,
add one constant share of `_hand_unrest()`. Scale it by
`last_stride` while she is not jumping, and by 1 while
she is jumping, so u 0 continues the two-point she left
from when `last_stride` was 1. Hold that share through
the arc. The keys stay the keys. The pin's two-point
may move a little (his unrest is 0.18). It stays a
two-point: within 4° of the step-0 pin row.

The halt used 20 and 9 because the halt head sits near
8°. The two-point head sits near 28°. Do not copy 20
and 9 across. Print, on the step-0 pin row, how many
degrees of `head_x` the eased helmet actually shows,
and pick the share from that, one attempt. You want
day-one at least 3° off the pin on the eased helmet,
or on the eased pitch, or on the hip, at the frame
before the leave.

The stride terms on gaits 1–3 stay. The gait-0 block
stays. This share does not run in the sit
(`land_recover` > 0, not jumping, `last_stride` ≤ 0.20)
and it does not run at gait 0.

After, the same two-point row, both horses. Then the
three clocks. Then the `hk_adv_002` leave check. Then
phase 2. You are not done.

If the 3° only comes by moving the pin more than 4°,
or by editing `ride_ai.gd`, or by a sine on the stride,
revert and write the degrees.

## Phase 2 — the sit, when she actually sits

Only if step 0 found a sit and that row is flat. A
course with no sit is a written negative. Do not build
a sit the ride does not have.

The sit block sets pitch 2, hip 20, head 6 for as long
as `land_recover` is above zero. On a related line the
`last_stride` lerp then takes her to the two-point,
and phase 1 owns that. This phase owns only the frames
where `land_recover` > 0, she is not jumping, and
`last_stride` ≤ 0.20.

One constant share of `_hand_unrest()` on `head_x` and
`hip_x` in that window. Not a sine. Not the halt's 20
and 9 unless the step-0 sit head is actually the halt
head, which it is not (the sit head is 6). One attempt,
from the ratio you print. Day-one at least 3° off the
pin on the eased helmet, the pitch, or the hip, at the
sit sample. The pin's sit stays within 4° of the
step-0 pin sit.

The half-halt (`collect_pulse`) is not this sit. His
neck already stays up through a half-halt, and that
was left. Do not write a new half-halt. Do not change
how long `land_recover` lasts.

After, the sit row, both horses. The two-point row
still holds if phase 1 kept it. The gait-0 halt still
holds (helmet means still about 3.5° apart, elbows
still about 4° apart, hip still about 3.5° apart).
Three clocks if you kept it. The `hk_adv_002` leave
check only if this phase also touched the two-point
or the keys. A sit gated on `last_stride` ≤ 0.20 does
not, and fences 3 and 12 stay on the phase-1 numbers.

## Phase 3 — her elbows over the fence

Only if step 0's elbows at u 0.55 are within 1° across
the two horses, and each fist is within 1 cm of its
target on both horses at u 0.20, 0.55, and 0.80.

`SHOULDER_GIVE` is off while jumping. A constant
shoulder turn, times `_hand_unrest()`, only while
jumping, before the IK, the way `SHOULDER_HALT` runs
at gait 0. The 19 on gaits 1–3 stays. The −40 at the
halt stays. The fist target stays.

After, both elbows at least 4° different, day-one
against the pin, at u 0.55. Fists still within 1 cm.
The pin crest still round +15.0, Neck1 −21.4, fore
cannon −30.2. Fore hooves at the thud within 2 cm of
0.053. The rein is still one straight rod.

One attempt. If an arm locks toward straight, or a
fist leaves the target by more than 1 cm, revert. Do
not move the target to buy the bend. The late fist
stays the late fist.

Three clocks if you kept it. Then the `hk_adv_002`
leave check, because a shoulder in the air can show
up as a pose change on the leave frame. Fences 3 and
12 still under 8°.

## The moving picture still holds

After the last phase you kept, one throwaway scene,
deleted after. Halt, walk, trot, canter, pin and
day-one. Helmet, elbow peak-to-peak, hip peak-to-peak,
wrist travel, hoof, and the halt means.

They still match `dist/same_002.md` within 0.3° and
0.5 cm on the moving gaits, except the halt row, which
matches `dist/halt_002.md`: helmet means apart by at
least 3°, both elbows by at least 4°, hip by at least
3°, peak-to-peak still about 0. If a new term leaks
into a moving gait or into the halt, revert that term.

## The check is still a check

Style, once, only if a phase kept code:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds
0.053, Neck1 around +11.7, Tail1 around −0.3. Her
helmet on that check is the pin's halt, not day-one's.
C one rail on fence 3 in the air. Copy the knock line.

One full `python tools/content_factory/run_ridecert.py`.
Render with `python tools/content_factory/board_table.py`.
The 21 within 0.1 s of the halt board, no new rail,
`teleported=false`. Headless `--playtest` after the
board line is copied: clear 0 / refuse 4 / rail 4.

If no phase kept code, do not run style and do not run
the board. The halt 21/23 stands.

If the board moves, revert this job's pose terms. The
halt, the stride terms, the crest, and the straight
rein stay.

## Write it

`dist/fold_002.md` holds the step-0 table for both
horses, the same rows after each phase you kept, the
fences 3 and 12 leave lines, the three clocks, and,
if you ran them, the style lines and the board.

Top of `dist/STATUS.md`: each pose as kept or as
already showing, and the clocks from the tree you
left. A channel you did not print is not a channel
you kept. A job that edits `ride_ai.gd` is not this
job. A job that shortens `land_recover` is not this
job. A job that snaps fences 3 and 12 is not this job.
