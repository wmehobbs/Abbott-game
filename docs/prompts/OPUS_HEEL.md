# Opus — her heel stays while she folds

You are in `E:\Workspace\Madison`. This is a long job. Do not
stop after the prediction. Do not write `dist/STATUS.md`
and quit until the counter has been ridden or the
prediction has closed it, and, if you kept it, the
clocks and the leave are written.

`dist/back_002.md` tried `FOLD_PITCH` 18. Her eased
pitch at u 0.55 went from 0.14° apart to 6.85° apart
(−40.73° on the pin, −47.58° on day-one). The pin
moved 3.2°. The fists stayed in. Neck1 stayed −21.44.
Day-one's two-point heel went from 0.1169 m to
0.1670 m, 5.0 cm off the iron. That is the revert.
The three pitch lines are out. `horse.gd` is the seat
tree. Do not put a bare pitch share back by itself.

The heel moved because her legs hang on her body.
`LLeg` is under `Body`, and the shin is under the leg.
`_set_leg` aims the lower leg at `shin_x` in the body
frame: the hip rotates by `hip_x`, the shin by
`shin_x - hip_x`, so the foot's direction in the body
is `shin_x`. Pitching the body rotates that foot
against an iron that is fixed on the saddle.

The two-point helmet move of 0.57° and the two-point
hip gap of 2.82° were measured against this job's own
step 0, which already read 3.17° and 1.81° there.
The seat job's kept rows are 3.8° / 4.9° / 5.2° of
helmet and 3.8° of hip at u 0.55. Those are the
gates. A noisy two-point reprint is not a revert.

The air hip stays. `hk_int_007` at 85.03 stays. Do
not remove the air `SIT_HIP` lines. Do not chase
that row.

The elbows over the fence stay a written negative.
The rein stays a straight rod. The five `hk_adv_002`
landings stay a written negative. The tail hair stays
a written negative. The late fist stays a written
negative. Do not move her fist target. The crest
stays. The return stays. The half-halt stays: it
already shows him at the deepest `collect_pulse`,
and you do not add a constant sit. Do not edit
`ride_ai.gd`. Do not edit `_place_cam`. Do not edit
`bascule.gd`. Do not move a fence. Do not export.
Do not launch `dist\Abbott.exe`. Do not chase 23/23.

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
`dist/heel_002.md` before the next id. Copy the board
log out before `--playtest`.

A probe is inserted once and stripped before a timed
ride. Do not leave one in the tree.

## What stays

- `FOLD_HEAD` 30
- `SIT_HIP` 10 in the sit and in the air
- the halt block, `SHOULDER_HALT` −40, `SHOULDER_GIVE` 19
- the nod lines and the hip lines on the moving gaits
- `land_recover` 2.72, `TAKEOFF` 2.55, `collect_pulse`,
  `GAIT_SPEED`, `STRIDE_HZ`, the beat gate
- the jump key table
- the crest at u 0.55: round +15.0, Neck1 −21.4,
  fore cannon −30.2 on the pin
- `bascule.gd`, `ride_ai.gd`, `ride_cert.gd`,
  `game_state.gd`, both course trees

`FOLD_PITCH` is 18 if you ride the counter. It is not
a number you search. The pin's unrest starts at 0.18,
day-one's at about 0.565.

A keep, after the counter if you ride it:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The tree you
start from is the seat board: clocks 18.54 / 91.58 /
94.01, faults 0 / 2 / 3, 0 rails, 21/23, `hk_int_007`
at 85.03. Within 0.1 s includes 0.10 s. Outside a
window, revert the counter and the pitch together.
One attempt. If the heel is still past 2 cm, the
back is closed. Do not try a smaller pitch.

## The leave stays one pose

Fences 3 and 12 change 0.00° in pitch, hip, and head.
The pitch share and the shin counter at `last_stride`
1 have to be the same share at jump u 0. Jump u 1 is
pitch key 2 and the sit is pitch 2, so the pitch
share and the shin counter both belong in the sit
window too (`land_recover` > 0, not jumping,
`last_stride` ≤ 0.20). A leave that changes by 8°
or more is a revert.

## Step 0 — predict the counter, before any new line

No pose code until the prediction is in
`dist/heel_002.md`. You already have the body-frame
points from the back job's step 0, day-one
two-point:

- heel (−0.154, −0.386, −0.093)
- iron (−0.170, −0.424, −0.224)

Reprint them on one pin ride and one fresh ride of
`hk_les_001`, fence 1, the frame before the leave
and at u 0.55. Same probe shape. Strip it before a
timed clock. If the fresh ride leaks into the next
pin ride, confidence near 50, stop and ride the pin
again before you trust the points.

From those points, on paper:

The body pitch share is `d = 18 * _hand_unrest()`,
more negative, the same three places as the reverted
attempt. The foot has to come back toward the iron
by a change in `shin_x` only. Do not change `hip_x`
to buy the heel. The air hip is already the seat.

Rotate the body-frame heel about the seat by `d` and
write where it lands relative to the iron. Then
write the `shin_x` delta, one sign, that puts it
back. Use the same delta times `_hand_unrest()` in
the three places, beside the pitch share, so the
pin gets the small one and day-one the larger one.

Predict day-one's two-point heel-to-iron distance
after both changes. The step-0 distance is 0.1169 m.

- If the prediction is still more than 2 cm off
  0.1169 m, or the shin delta locks the knee (the
  lower leg and the thigh in one line), do not
  ride it. Write the centimetres and the knee.
  The back is a written negative. No clocks, no
  board. The seat 21/23 stands.
- If the prediction is inside 2 cm and the knee
  stays bent, one ride. You are not done.

## Phase 1 — 18, and the shin counter

Only if the prediction passed.

`pitch -= 18 * _hand_unrest()` and
`shin_x += C * _hand_unrest()`, with `C` the sign
and the scale from the prediction. `C` is one
number. It is not a search.

Three places, same as the pitch:

- after the last_stride lerp, × `s`, gait ≥ 1, not jumping
- after the jump keys, × 1
- in the sit window, beside the sit's head and hip

After, both horses, fence 1:

- eased pitch at u 0.55 at least 3° apart. 18
  already gave 6.85°. If the counter knocks it
  under 3°, revert
- the pin's eased pitch at u 0.55 within 4° of
  −37.53
- day-one's two-point heel within 2 cm of 0.1169 m.
  The pin's two-point heel within 2 cm of 0.1209 m
- eased hip at u 0.55 still at least 3° apart
- helmet gaps within 0.5° of 3.8 / 4.9 / 5.2 on
  the two-point, u 0.55, and the sit. Judge them
  against those kept numbers
- fists: a hand within 1 cm in step 0 stays within
  1 cm, and none moves more than 0.5 cm farther
  from its target than its own step 0. The late
  fist stays
- the knee stays bent. Print it at the two-point
  and at u 0.55. If either leg is straight, revert
- pin Neck1 at u 0.55 still −21.4

One ride. If the heel is past 2 cm, revert the
pitch and the shin together. Do not try 12. Do
not try a second `C`.

Three clocks if you kept it. Then pin `hk_adv_002`.
Fences 3 and 12: target pitch, hip, and head, frame
before and first jumping frame, each change 0.00°.
Also print `shin_x` on those two frames. It changes
0.00° across the leave as well. The round completes,
0 rails, `teleported=false`.

## The moving picture still holds

If you kept the counter, one throwaway scene,
deleted after. Halt, walk, trot, canter, pin and
day-one. They still match `dist/halt_002.md` on the
halt means and `dist/same_002.md` within 0.3° and
0.5 cm on the moving gaits. Hoof 0.052–0.053. The
shin counter runs only with the pitch share, which
is off at a settled gait and at the halt. If a heel
on the flat moves more than 2 cm from the scene you
print first, before the counter, revert.

## The check is still a check

Style, once, only if you kept the counter:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds
0.053, Neck1 around +11.7, Tail1 around −0.3. Her
helmet on that check heads for the pin's halt
(+11.31), not day-one's (+14.76). C one rail on
fence 3 in the air. Copy the knock line.

One full `python tools/content_factory/run_ridecert.py`.
Render with `python tools/content_factory/board_table.py`.
The 21 within 0.1 s of the seat board. 0.10 s counts.
No new rail, `teleported=false`. `hk_int_007` may
sit on 85.03. Copy the board log before the
playtest. Headless `--playtest`: clear 0 / refuse 4
/ rail 4.

If you did not keep the counter, do not run style
and do not run the board.

If the board moves past 0.1 s, revert the pitch and
the shin. The air hip and the helmet shares stay.

## Write it

`dist/heel_002.md` holds the prediction, the rows
if you rode, the fences 3 and 12 lines, and, if you
kept it, the clocks, the style lines, and the board.

Top of `dist/STATUS.md`: the back as kept with the
counter, or as closed because the heel still leaves,
and the clocks from the tree you left. The air hip
stays in that paragraph. `hk_int_007` at 85.03 stays.
A job that tries a second pitch number is not this
job. A job that removes the air `SIT_HIP` lines is
not this job.
