# Opus — the knee, before the shin

You are in `E:\Workspace\Madison`. This is a long job. Do not
stop after the walk. Do not write `dist/STATUS.md` and quit
until the knee has been printed at the walk, the trot, and
the canter, and each gait is either already showing or a
written negative.

`dist/STATUS.md` names the shin lines and does not give
them a coefficient. That was right. This job prints the
knee those lines sit under. It adds a share only on a
gait whose knee is flat.

`_set_leg` aims the thigh at `hip_x` and the lower leg at
`shin_x - hip_x`, so the foot's direction in her body is
`shin_x`. The comment on that line is the heel staying
down while the hip swings. The hip already has unrest
(walk 12, trot 18, canter 22). The shin lines do not:

- walk: `shin_x -= w * 2.0`
- trot: `shin_x -= post * 9.6 + sit * 2.8`
- canter: `shin_x -= rock * 4.8 + sit * 3.8`

`shin_x` peak-to-peak will match on the two horses,
because nothing multiplies it by unrest. That match is
not a gap. The knee is the angle between the thigh and
the shin. A bigger hip against the same shin opens and
closes the knee more. If that is already 3° or more,
the shin lines are the quiet foot, and they stay quiet.

The picture above them stays. Do not flip the trot plus.
Do not put the lean back. Do not put the canter 8 back.
Do not change `FOLD_SHIN` 20 or `FOLD_PITCH` 18. The air
hip stays. `hk_int_007` at 84.93 stays. The elbows over
the fence, the rein, the five landings, the tail hair,
the late fist, and the half-halt stay closed. Do not
edit `ride_ai.gd`, `_place_cam`, or `bascule.gd`. Do not
move a fence. Do not export. Do not launch
`dist\Abbott.exe`. Do not chase 23/23.

## Silent

Ernie is at the machine. A Godot window locks the desktop.
`--headless` is the first argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

The first print is a throwaway scene, deleted after. Do
not leave it in the tree. A ride, only if a share is
kept, goes through
`python tools/content_factory/run_ridecert.py`. No
windowed exe, no editor, no F5, no `--artshot`, no
`ride_ids.py`. One Godot. Timeouts: one id 8 minutes, a
style id 15 minutes, the full board 70 minutes. No
`RIDECERT round` in 2 minutes is a compile error: kill
only that process. If the wrapper dies for low memory,
wait for the ride that is already going. Do not start a
second board. Do not kill Godot to free RAM. The log is
opened with `"w"`. Copy each `RIDECERT hk_…` line into
`dist/knee_002.md` before the next id. Copy the board
log out before `--playtest`.

## What stays

- every unrest line already in `_update_rider`
- the three shin constants above, unless a gait's knee
  is under 3° and the share below survives its gates
- `FOLD_PITCH` 18, `FOLD_SHIN` 20, `FOLD_HEAD` 30,
  `SIT_HIP` 10
- the roll, with no unrest
- the trot plus: `pitch += swing * 14.0 * trot_unrest`
- halt, nod, elbows, hip, hands, crest, clocks
  18.54 / 91.60 / 93.99, board 21/23

A keep, only after a share that survives:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. Within 0.1 s
includes 0.10 s. Outside a window, revert that gait
only. One number per gait. If the heel moves, that
gait is closed. Do not spend a second number.

## Step 0 — the knee, three gaits

No pose code until this table is in `dist/knee_002.md`.
One scene, pin and day-one, one settled stride each of
walk, trot, and canter. Knee angle as in the heel job:
hip joint, knee, heel, 180° straight. Peak-to-peak.
Also `shin_x` peak-to-peak, `hip_x` peak-to-peak, both
heels to the iron (mean and farthest), wrist travel.

| gait | pin knee p2p | day-one knee p2p | day-one more by | shin_x p2p, both | hip_x p2p, pin / day-one |
| --- | --- | --- | --- | --- | --- |

A gait already shows him when day-one's knee
peak-to-peak is at least 3° more than the pin's. Do
not add a shin share on that gait.

If all three gaits already show, write that and stop.
No clocks, no board. The shin lines stay as they are.
The heel board's 21/23 stands.

## Phase 1 — one share, only on a flat gait

Only a gait under 3°.

Beside that gait's shin line, not inside the constant,
the same shape times `_hand_unrest()`. Walk beside
`w * 2.0`. Trot beside `post * 9.6 + sit * 2.8`.
Canter beside `rock * 4.8 + sit * 3.8`. Same sign as
the line it sits next to, so the foot does more of
the swing it already does. One coefficient per gait,
from the step-0 ratio, aimed at about 3° more knee
on day-one. The pin moves a little.

After, that gait only:

- knee peak-to-peak at least 3° more on day-one
- each heel, mean and farthest, within 2 cm of its
  step-0 number. A shin share aims the foot. If the
  heel leaves, revert the share. Do not counter it
  with a new hip term
- wrist travel within 0.5 cm of that gait's row in
  `dist/same_002.md`
- the knee stays bent. If either horse's knee passes
  150° at any frame of the stride, revert
- the other two gaits unchanged, within 0.3°
- hoof 0.052–0.053

One attempt on that gait. If it fails, revert it and
go to the next flat gait. Do not raise the number.

If no share survives, stop. No clocks, no board.

## If a share stayed

Three clocks. Then style, once:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds
0.053, Neck1 around +11.7, Tail1 around −0.3. Her
helmet on that check heads for the pin's halt
(+11.31). C one rail on fence 3 in the air. Copy
the knock line.

One full `python tools/content_factory/run_ridecert.py`.
Render with `python tools/content_factory/board_table.py`.
The 21 within 0.1 s of the heel board. No new rail,
`teleported=false`. `hk_int_007` may sit on 84.93.
Copy the board log before the playtest. Headless
`--playtest`: clear 0 / refuse 4 / rail 4.

Pin `hk_les_001` once with a probe, stripped after,
fence 1 at u 0.55. Eased pitch still about
−40.7° / −47.7°, two-point heels still about
0.115 m / 0.118 m, Neck1 still −21.4. The gait shin
share does not run in the air. If the fold moved,
revert the share.

If the board moves past 0.1 s, revert the shares you
added. The fold, the air hip, and the trot plus stay.

## Write it

`dist/knee_002.md` holds the three knee rows, and the
after rows for any gait you kept or reverted.

Top of `dist/STATUS.md`: each gait's knee as already
showing, as kept, or as reverted because the heel or
the hands moved. The shin lines that you did not
touch stay named and uncoded. The picture paragraph
stays. A job that changes `FOLD_SHIN` is not this job.
A job that flips the trot plus is not this job.
