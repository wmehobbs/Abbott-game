# Opus — her canter hip

You are in `E:\Workspace\Madison`. This is a long job. Do not stop
after the canter. Do not write `dist/STATUS.md` and quit until the
canter hip and the trot hip have each been printed, kept or a
written negative, and any phase that kept code has its three clocks.

The elbow and the walk hip are kept. Do not retune them.

- `SHOULDER_GIVE := [0.0, 12.0, 12.0, 12.0]` stays. The shoulder
  turns before the arm IK. The fist stays on its target. That
  route is the keep. Do not revert it to the pole or to a bend
  after the IK.
- Walk: `hip_x += w * 12.0 * walk_unrest` stays. The walk hip is
  4.54° / 8.17°, 3.63° more on day-one. Her heel's mean stays
  0.120 m. Do not retune the 12.

The three nod lines stay: walk 26, trot 48, canter 64.

What is still flat, from `dist/elbow_002.md`. At the canter,
`hip_x` peak-to-peak is 3.91° on the pin and 3.91° on day-one.
At the trot it is 8.82° and 8.87°, five hundredths apart, because
both horses take the same `post * 32` and unrest is not in it.
Her seat does not read him at those two gaits. The walk does.

The hair stays a written negative. The late fist stays a written
negative. The rein stays a straight rod. The five `hk_adv_002`
landings stay a written negative. The crest, the hoof plant, the
pastern, the beat gate, and the landing camera stay. Do not edit
`ride_ai.gd`. Do not move a fence. Do not chase 23/23. Do not
export. Do not launch `dist\Abbott.exe`.

## Silent

Ernie is at the machine. A Godot window locks the desktop.
`--headless` is the first argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`. No
windowed exe, no editor, no F5, no `--artshot`, no `ride_ids.py`.
One Godot. Timeouts: one id 8 minutes, a fresh id 12 minutes, a
style id 15 minutes, the full board 70 minutes. No `RIDECERT round`
in 2 minutes is a compile error: kill only that process. If the
wrapper dies for memory, wait for the Godot it already started.
Do not start a second board. Do not kill Godot to free RAM.

`run_ridecert.py` opens the log with `"w"`. Copy each
`RIDECERT hk_…` line out before the next id. A probe is inserted
once and stripped before a timed ride. Do not leave one in the
tree. No Godot is running now.

## Frozen

- `SHOULDER_GIVE`, the fist target, the pole, the withers spot,
  the rein
- the three nod lines, and `hip_x += w * 12.0 * walk_unrest`
- `post * 32` on the trot. You may add a term. You may not
  multiply the posting constant.
- `pitch`, `rest`, `bascule.gd`
- `refuse_scale`, `turn_scale`, `scope_bonus`, `balance_need`,
  `charge_need`, `_might_look`
- leave windows, `TAKEOFF` 2.55, `collect_pulse` 0.95, `GAIT_SPEED`,
  `STRIDE_HZ`, `land_recover` 2.72, the beat gate
- `_process_jump`, `_place_cam`
- the crest at u 0.55: round +15.0, Neck1 −21.4, fore cannon −30.2
- the lowest hoof on a settled stride in 0.052–0.053
- the heel stays within 2 cm of where it sits today, mean and
  farthest point
- the pin constants and `_day_one`
- `ride_ai.gd`, both course trees, `ride_cert.gd`, `game_state.gd`

The picture reads the stats. It does not write them. The pin's
unrest is 0.18 because feel is 36. His hip may swing a little
more. The test is the difference.

A keep, after a phase that touches code:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The elbow board is the floor.
The last clocks are 18.54 / 91.60 / 93.99. The window is the keep.
Outside it, revert that phase. Two fails on one gait: write the
negative and go to the next gait. Do not spend a second
coefficient on the same gait.

## Step 0 — reprint the two hips

Nothing changes until this is in `dist/hip_002.md`.

One throwaway scene, pin and day-one, one settled stride of
walk, trot, and canter. Delete it after. For each:

- `hip_x` peak-to-peak, degrees
- heel-to-iron mean, and the farthest point, metres
- elbow peak-to-peak, both arms, so the kept elbows are still
  there (about 4.5° / 5.2° more on day-one)
- helmet pitch, so the nods are still about 2.31° / 5.85° at
  the walk, 3.66° / 8.37° at the trot, 2.85° / 7.55° at the canter
- lowest hoof

The walk hip has to still be about 4.54° / 8.17°. If it is not,
stop. The 12 has moved.

If the canter hip already differs by at least 3°, phase 1 is
the table. If the trot hip already differs by at least 3°,
phase 2 is the table. Do not swing a hip that already reads.

## Phase 1 — the canter

`hip_x` on gait 3 only, a share of the unrest the canter rock
already uses, on the stride. Not the walk's 12 unless the same
ease math says 12. Do not touch gait 1 or gait 2. Do not touch
`pitch` or `rest`.

After:

- canter `hip_x` peak-to-peak at least 3° more on day-one
- heel mean and farthest point within 2 cm of today's canter
  iron (about 0.127 m mean)
- walk hip still about 4.54° / 8.17°
- elbows and nods still the kept table
- lowest hoof 0.052–0.053

One attempt. If the heel lifts, or the hip does not gain 3°,
revert and write both numbers.

Three clocks if you kept it. Then the trot. You are not done.

## Phase 2 — the trot

An added term on gait 2, a share of `_hand_unrest()` on the
stride. `post * 32` stays the posting constant. Do not touch
gait 1 or gait 3.

After:

- trot `hip_x` peak-to-peak at least 3° more on day-one
- heel within 2 cm of today's trot iron (about 0.087 m mean)
- the canter hip, if you kept it, still at least 3° apart
- the walk hip still about 4.54° / 8.17°
- elbows and nods still the kept table

One attempt. The posting swing is large. If a term big enough
to show 3° lifts the heel, that is the negative. Revert the
trot term. Do not shrink the post to buy it.

Three clocks if you kept it.

## The pin is still the pin

If any phase kept code, style once:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds at 0.053,
Neck1 around +11.7, Tail1 around −0.3. The check is gait 0,
so the new hip line does not run on it. C one rail on fence 3
in the air (`jumping=true`). Copy the knock line.

One full `python tools/content_factory/run_ridecert.py`. Render
with `python tools/content_factory/board_table.py`. The 21
within 0.1 s of the board in `dist/elbow_002.md`, no new rail,
`teleported=false`. Headless `--playtest`: clear 0 / refuse 4 /
rail 4. Copy the five `PLAYTEST` lines into `dist/hip_002.md`
from this run, after the board line is copied. If the wrapper
dies for memory and Godot is still riding, wait.

If no phase kept code, do not run style and do not run the
board. The 21/23 log still stands.

If the board moves, revert this prompt's hip lines. The elbow
table and the walk hip stay.

## Write it

Top of `dist/STATUS.md`: the canter hip and the trot hip, before
and after, in degrees, the heel distances, and the three clocks
if you rode them. A job that stops after the canter is not this
job. A job that multiplies `post * 32` is not this job.
