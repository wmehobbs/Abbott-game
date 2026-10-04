# Opus — the trot's back fights the post

You are in `E:\Workspace\Madison`. This is a long job. Do not
stop after the sign. Do not write `dist/STATUS.md` and quit
until the trot's pitch has been kept or reverted, and the
nod, the hip, and the hands have been printed on that
same scene.

`dist/lean_002.md` closed two things.

The lean is a written negative. `LEAN` 8 made her roll
+5.59° on the pin and +8.64° on day-one, 3.05° apart,
and day-one's heels slid 2.48 cm and 2.54 cm. Her legs
roll with her body. Do not put the lean back. Do not
add a shin term for it. `FOLD_SHIN` 20 belongs to the
fold.

The canter back on the flat is a written negative.
`pitch += rock * 8 * unrest` beside the 14 gave 3.45°
more body-pitch on day-one and moved her canter hand
travel from 0.103 m to 0.109 m. Do not put that 8 back.
Do not try a 6 or a 4.

The walk already shows: body-pitch peak-to-peak was
3.00° and 3.15° more on day-one. Leave the walk line.

The trot reads the wrong way. Body-pitch peak-to-peak
was 8.51° / 5.56° and 8.48° / 5.58°, about 2.9° *less*
on day-one. In the trot block the post is
`pitch += -post * 26.4`, and `post` is the positive
half of `sin`. The unrest line under it is
`pitch += swing * 14.0 * trot_unrest`, and `swing` is
that same `sin`. On the half where she posts, the 14
adds the other way, and day-one has more unrest, so
her back swings less. The head line
`head_x += swing * 48.0 * trot_unrest` adds with the
post's `head_x += post * 8.4`. The rise
`rest.y += swing * 0.070 * trot_unrest` adds with
`rest.y += post * 0.228`. Do not flip those. Only the
pitch line fights.

The fold stays. `FOLD_PITCH` 18 and `FOLD_SHIN` 20.
The air hip stays. `hk_int_007` at 84.93 stays. The
elbows over the fence stay a written negative. The
rein, the five landings, the tail hair, and the late
fist stay written negatives. Do not edit `ride_ai.gd`.
Do not edit `_place_cam`. Do not edit `bascule.gd`.
Do not move a fence. Do not export. Do not launch
`dist\Abbott.exe`. Do not chase 23/23.

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
`dist/post_002.md` before the next id. Copy the board
log out before `--playtest`.

A throwaway scene is deleted after. Do not leave it in
the tree. A probe, if you need one for the fence, is
stripped before a timed ride.

## What stays

- the post's own numbers: `-post * 26.4`, the rise
  `post * 0.228`, `post * 32`, `post * 8.4`
- `swing * 48` on the head, `swing * 18` on the hip,
  `swing * 0.070` on the rise
- the walk pitch share and the canter `rock * 14`
- `FOLD_PITCH` 18, `FOLD_SHIN` 20, `FOLD_HEAD` 30,
  `SIT_HIP` 10 in the sit and in the air
- the halt block, `SHOULDER_HALT` −40, `SHOULDER_GIVE` 19
- the roll line, with no unrest
- `land_recover` 2.72 and the rest of the frozen list
  from the heel job

One change, if you keep it: the sign of
`pitch += swing * 14.0 * trot_unrest`.
It becomes a minus, so the unrest adds to the post
instead of against it. The 14 stays 14. Do not pick
a new coefficient. If the minus fails a gate, revert
to the plus. Do not try 10 or 18.

A keep, if the sign stays:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The tree you
start from left 18.54 / 91.60 / 93.99, faults
0 / 2 / 3, 0 rails. The board is 21/23. Within
0.1 s includes 0.10 s. Outside a window, revert
the sign. The fold and the air hip stay.

## Step 0 — the signs, on one scene

No edit until this table is in `dist/post_002.md`.
One throwaway scene, the heel tree, deleted after.
One settled stride of the trot, pin and day-one.
Also the walk and the canter, so you can see the
sign that already works.

Print eased body-pitch peak-to-peak, helmet
peak-to-peak, hip peak-to-peak, wrist travel, and
the posting rise (the peak of `rest.y`, or the
body's height peak-to-peak if that is what the scene
can read). Hoof. Heels.

The lean job already measured pitch at 8.5° / 5.6°.
Reprint it. A number you did not just print is not
the before.

From the source, one line: on the positive half of
`sin`, the sign of the post's pitch term and the
sign of the unrest pitch term. If they already
agree, the lean job's scene was wrong and you do
not flip anything. Write that and stop. No clocks,
no board.

## Phase 1 — the minus

Only if those two signs disagree.

Change the one pitch line to
`pitch -= swing * 14.0 * trot_unrest`.
Nothing else in the trot block.

The same scene, after:

- trot body-pitch peak-to-peak at least 3° more on
  day-one than on the pin
- trot wrist travel within 0.5 cm of 0.055 / 0.081.
  The canter's extra pitch failed at 0.6 cm. The
  same rule here. If day-one's trot hands move past
  that, revert the sign
- trot helmet peak-to-peak still about 3.67 / 8.40,
  within 0.3°. You did not flip the head line. If
  the nod drops under 3° of difference, revert
- trot hip peak-to-peak still about 3.6° more on
  day-one, within 0.3°
- the posting rise still happens, and day-one's rise
  is not smaller than the pin's. If she posts less,
  revert
- heels within 2 cm of the step-0 trot heels
- hoof 0.052–0.053
- walk and canter pitch rows unchanged, within 0.3°
  of step 0. The canter stays under 3° more if that
  is what step 0 printed. Do not "fix" it
- halt means still match `dist/halt_002.md`

One attempt. If the hands, the nod, or the rise
fail, the plus sign goes back. The trot back is
then a written negative. Do not spend a second
number.

If the minus holds, you are not done.

## The fence still folds

The trot block does not run in the air. Still print
it once, pin `hk_les_001`, one probe, stripped
after. Fence 1, u 0.55: eased pitch still about
−40.7° / −47.7°, two-point heels still about
0.115 m / 0.118 m, Neck1 still −21.4. If the sign
leaked into the jump, revert.

Three clocks. Pin confidence on `hk_les_001` still
finishes at 91.0, not near 50.

## The check is still a check

Style, once, only if the minus stayed:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds
0.053, Neck1 around +11.7, Tail1 around −0.3. Her
helmet on that check heads for the pin's halt
(+11.31), not day-one's (+14.76). C one rail on
fence 3 in the air. Copy the knock line.

One full `python tools/content_factory/run_ridecert.py`.
Render with `python tools/content_factory/board_table.py`.
The 21 within 0.1 s of the heel board. 0.10 s counts.
No new rail, `teleported=false`. `hk_int_007` may sit
on 84.93. Copy the board log before the playtest.
Headless `--playtest`: clear 0 / refuse 4 / rail 4.

If you reverted the sign, do not run style and do not
run the board. The heel 21/23 stands.

If the board moves past 0.1 s, put the plus back.
The fold and the air hip stay.

## Write it

`dist/post_002.md` holds the step-0 trot row, the
row after the minus or the sentence that the signs
already agreed, the fence sample, and, if you kept
it, the clocks, the style lines, and the board.

Top of `dist/STATUS.md`: the trot pitch as kept on
the minus or as reverted, and the clocks from the
tree you left. The lean and the canter 8 stay
written negatives in that paragraph. The fold stays.
A job that flips the head line or the rise is not
this job. A job that puts `LEAN` back is not this
job. A job that puts the canter 8 back is not this
job.
