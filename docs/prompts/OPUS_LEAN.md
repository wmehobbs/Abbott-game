# Opus — she leans with him

You are in `E:\Workspace\Madison`. This is a long job. Do not
stop after the lean. Do not write `dist/STATUS.md` and quit
until a turn has been printed on both horses, and her back
on the flat has been printed on both horses. Code only
where the print is flat.

The fold is kept. `FOLD_PITCH` is 18 and `FOLD_SHIN` is 20.
At u 0.55 her eased pitch is −40.68° on the pin and
−47.66° on day-one. Her two-point heel is 0.1153 m and
0.1180 m. Fence 12's 0.02–0.04° at u 0.012 is the jump
keys moving across that sliver. It is not a step. Do not
chase it. Do not change 18 or 20.

Her roll does not read him. At the bottom of
`_update_rider` it is `last_turn * (4.2 if gait >= 2 else 2.4)`,
the same number on both horses for the same turn. The
horse's own bank, `visual.rotation.z = last_turn * 0.05`,
stays. You do not lean the horse. You lean her.

The air hip stays. `hk_int_007` at 84.93 stays. The
elbows over the fence stay a written negative. The rein
stays a straight rod. The five `hk_adv_002` landings
stay a written negative. The tail hair stays a written
negative. The late fist stays a written negative. The
half-halt stays as printed. Do not edit `ride_ai.gd`.
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
`dist/lean_002.md` before the next id. Copy the board
log out before `--playtest`.

A probe is inserted once and stripped before a timed
ride. Do not leave one in the tree. A throwaway scene
is deleted after.

## What stays

- `FOLD_PITCH` 18, `FOLD_SHIN` 20, `FOLD_HEAD` 30, `SIT_HIP` 10
- the halt block, `SHOULDER_HALT` −40, `SHOULDER_GIVE` 19
- the nod lines and the hip lines on the moving gaits
- the canter pitch share `rock * 14.0 * unrest` and the
  walk and trot pitch shares. Phase 2 prints them. It
  does not retune them unless the print is flat.
- `land_recover` 2.72, `TAKEOFF` 2.55, `collect_pulse`,
  `GAIT_SPEED`, `STRIDE_HZ`, the beat gate
- the jump key table, the crest, the horse's
  `visual.rotation.z`
- `bascule.gd`, `ride_ai.gd`, `ride_cert.gd`,
  `game_state.gd`, both course trees

A keep, after a phase that touches code:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The heel job left
18.54 / 91.60 / 93.99, faults 0 / 2 / 3, 0 rails. The
board is 21/23. Within 0.1 s includes 0.10 s. Outside
a window, revert that phase only. One attempt on the
lean. If the heel slides, revert. Do not spend a
second coefficient.

## Step 0 — one turn, both horses

No pose code until this table is in `dist/lean_002.md`.
One probe. Pin `hk_les_001`, then fresh. Strip it
before a timed clock.

Find one bend where `|last_turn|` stays above 0.3 for
at least a quarter second, cantering, not jumping,
`land_recover` 0. The same bend on both rides if the
track gives it to you. If day-one does not ride that
bend, say so and take the deepest `|last_turn|` each
horse actually holds.

On the frame of peak `|last_turn|` in that bend, print
`last_turn`, her eased `rider_body` roll, her
heel-to-iron on both feet, `_hand_unrest()`, and
confidence.

Her roll already shows him when day-one's `|roll|` is
at least 3° more than the pin's at a comparable
`|last_turn|` (within 0.1 of each other). If the
turns are not comparable, divide roll by `last_turn`
and compare those. If that ratio is already at least
3° apart per unit of turn, do not add a lean. Go to
the flat back.

## Phase 1 — a share of the turn

Only if step 0 is flat.

One constant, `LEAN`, times `_hand_unrest()`, times
`last_turn`, added to the roll she already has. The
4.2 and the 2.4 stay. Gait 0 with `last_turn` near 0
does not lean. Do not multiply the horse's bank.

Pick `LEAN` from the step-0 ratio so day-one's extra
lean on that bend is about 3°. The pin leans a little
more (his unrest is 0.18). One attempt.

After, the same bend, both horses:

- day-one at least 3° more `|roll|` than the pin at a
  comparable turn, or 3° more per unit of `last_turn`
- the pin's `|roll|` within 4° of his step-0 roll on
  that bend
- each heel within 2 cm of its own step-0 distance
  on that frame. A lean that slides a heel off the
  iron is a revert. Do not counter it with a new
  shin term. The shin counter is for the fold.
- the two-point heel on fence 1 still about
  0.115 m / 0.118 m. If the lean runs on the approach
  and moves either heel more than 2 cm, revert
- eased pitch at u 0.55 still about 7° apart, and
  Neck1 still −21.4

One attempt. If the heel slides, or the pin's roll
moves more than 4°, revert and write the degrees.

Three clocks if you kept it. Then you are not done.

## Phase 2 — her back on the flat

Print only, unless it is flat.

The canter already has `pitch += rock * 14.0 * unrest`,
and the walk and the trot have their own pitch shares.
One throwaway scene, deleted after. One settled stride
of walk, trot, and canter, pin and day-one. Print
eased body-pitch peak-to-peak, and the halt means.

The flat back already shows him when day-one's pitch
peak-to-peak is at least 3° more than the pin's at
the canter. Write the three rows. Do not add another
pitch term on a gait that already clears 3°.

If the canter is under 3° more, one term beside the
14, not inside it, the way the nod was added. One
attempt. The fold's 18 does not run on a settled
canter (`last_stride` is 0, she is not jumping). If
your term moves the two-point heel, or the u 0.55
pitch gap falls under 3°, revert it. The fold stays.

The scene also checks the leak. Halt means still
match `dist/halt_002.md`. Moving gaits still match
`dist/same_002.md` within 0.3° and 0.5 cm. Hoof
0.052–0.053. Heels on the flat within 2 cm of the
heel job's scene.

Three clocks only if this phase kept code.

## The check is still a check

Style, once, only if a phase kept code:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds
0.053, Neck1 around +11.7, Tail1 around −0.3. Her
helmet on that check heads for the pin's halt
(+11.31), not day-one's (+14.76). She does not lean
on the check. C one rail on fence 3 in the air.
Copy the knock line.

One full `python tools/content_factory/run_ridecert.py`.
Render with `python tools/content_factory/board_table.py`.
The 21 within 0.1 s of the heel board. 0.10 s counts.
No new rail, `teleported=false`. `hk_int_007` may sit
on 84.93. Copy the board log before the playtest.
Headless `--playtest`: clear 0 / refuse 4 / rail 4.

If no phase kept code, do not run style and do not
run the board. The heel 21/23 stands.

If the board moves past 0.1 s, revert the lean. The
fold, the shin counter, and the air hip stay.

## Write it

`dist/lean_002.md` holds the turn table, the flat
pitch rows, and, if you kept code, the clocks, the
style lines, and the board.

Top of `dist/STATUS.md`: the lean as kept or as
already showing or as reverted because the heel
slid, the flat back as already showing or as the
term you kept, and the clocks from the tree you
left. The fold stays in that paragraph. A job that
changes `FOLD_PITCH` or `FOLD_SHIN` is not this job.
A job that leans the horse is not this job.
