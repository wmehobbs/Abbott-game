# Opus — her elbow

You are in `E:\Workspace\Madison`. This is a long job. Do not stop
after the first gait. Do not write `dist/STATUS.md` and quit until
the elbow has been printed at the walk, the trot, and the canter,
each one kept or a written negative, and the hip has been printed
the same way.

Her helmet now nods more on day-one at all three gaits. That is
kept. The lines stay:

- walk: `head_x -= w * 26.0 * walk_unrest`
- trot: `head_x += swing * 48.0 * trot_unrest`
- canter: `head_x -= rock * 64.0 * unrest`

Do not retune them. The pitches in `dist/nod_002.md` stay: walk
2.31° / 5.85°, trot 3.66° / 8.37°, canter 2.85° / 7.55°.

Her hands already travel more on day-one. Nobody has printed
whether her elbow opens with them, or the arm stays one stiff
line that just shifts. That is the gap.

The hair stays a written negative. The fist that leaves the
learned spot late in the jump stays a written negative. The rein
stays a straight rod. The five `hk_adv_002` landings stay a
written negative. The crest, the hoof plant, the pastern, the
beat gate, and the landing camera stay. Do not edit `ride_ai.gd`.
Do not move a fence. Do not chase 23/23. Do not export. Do not
launch `dist\Abbott.exe`. Do not start another board of the tree
you already have. The one that finished, wrapper killed and Godot
still riding, is the board: 21/23, `RIDECERT done`.

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
Do not start a second board. Free RAM is the machine. Comet was
the pile. Do not kill Godot to free it.

`run_ridecert.py` opens the log with `"w"`. Copy each
`RIDECERT hk_…` line out before the next id. A probe is inserted
once and stripped before a timed ride. Do not leave one in the
tree. Walk and trot on `hk_les_001` are shorter than one stride.
Take them from one throwaway scene, then delete it. No Godot is
running now.

## Frozen

- the three `head_x` nod lines above
- `pitch`, `rest`, `post * 8.4`, the walk and canter unrest on
  `pitch` and `rest.y`
- `bascule.gd`, `rider_mesh.gd`'s fist target and the withers anchor
- `refuse_scale`, `turn_scale`, `scope_bonus`, `balance_need`,
  `charge_need`, `_might_look`
- leave windows, `TAKEOFF` 2.55, `collect_pulse` 0.95, `GAIT_SPEED`,
  `STRIDE_HZ`, `land_recover` 2.72, the beat gate
- `_process_jump`, `_place_cam`, the rein rods
- the crest at u 0.55: round +15.0, Neck1 −21.4, fore cannon −30.2
- fore hooves at the thud within 2 cm of 0.053
- the lowest hoof on a settled stride in 0.052–0.053
- heels on the iron: if you move the hip, the heel stays within
  2 cm of where it sits today
- the pin constants and `_day_one`
- `ride_ai.gd`, both course trees, `ride_cert.gd`, `game_state.gd`

The picture reads the stats. It does not write them. The pin's
unrest is 0.18 because feel is 36. His elbow may open a little.
The test is the difference.

A keep, after a phase that touches code:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The nod board is the floor:
solo clocks 18.54 / 91.61 / 93.98, the full log 18.54 / 91.61 /
94.01. The window is the keep. Outside it, revert that phase.
Two fails on one phase: write the negative and go to the next.
Do not spend a second coefficient on the same joint.

## Step 0 — the arm and the hip, no pose code

Nothing changes until this is in `dist/elbow_002.md`.

One throwaway scene, pin and day-one, one settled stride of
walk, trot, and canter. Delete it after. For each, both arms:

- elbow angle, the angle at `LowerArm` between `UpperArm` and
  `Wrist`, mean and peak-to-peak, degrees
- wrist travel in the withers frame, so the kept hands are
  still there (walk about 0.029 / 0.056, trot 0.055 / 0.081,
  canter 0.078 / 0.103)
- commanded `hip_x` peak-to-peak, degrees
- heel-to-iron distance, metres, mean

Helmet pitch on the trot, one stride, both horses. It has to
still be about 3.66° / 8.37°. If it is not, stop. A nod line
has moved.

Read it this way:

- If a gait's elbow mean already differs by at least 5°, or its
  peak-to-peak by at least 4°, that gait is the table. Do not
  soften an elbow that already reads.
- If `hip_x` peak-to-peak at the walk already differs by at
  least 3°, the walk hip is the table. The trot's posting hip
  is already a large swing. Do not multiply `post * 32`.

## Phase 1 — the elbow, only on a gait step 0 showed is flat

The fist stays on the neck. Hand travel stays within 0.5 cm of
the numbers above. You may move the IK pole, or add a small
bend after the IK, so the elbow softens with `_hand_unrest()`.
You may not move the learned withers spot. You may not lift her
hands. You may not bend the rein.

One coefficient for the flat gait. If more than one gait is
flat, do the trot first, then the walk, then the canter. Each
is one attempt. A miss reverts that gait only.

After, on a gait you kept:

- elbow mean at least 5° different, or peak-to-peak at least 4°
  more on day-one than on the pin
- hands within 0.5 cm of the kept travel
- helmet pitches still the nod table
- lowest hoof 0.052–0.053
- Neck1 and Tail1 still about 9.9° apart

Three clocks if you kept one. Then the next flat gait. You are
not done until every gait is a row.

## Phase 2 — the walk hip, only if step 0 showed it flat

`hip_x` on gait 1 only, a share of `walk_unrest` on the stride.
Do not touch the trot's `post * 32`. Do not touch gait 3.
The heel stays within 2 cm of today's iron. If it lifts, revert.

After: walk `hip_x` peak-to-peak at least 3° more on day-one.
The elbow rows you kept still hold. The nod pitches still hold.
One attempt.

Three clocks if you kept it.

## The pin is still the pin

If any phase kept code, style once:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds at 0.053,
Neck1 around +11.7, Tail1 around −0.3. C one rail on fence 3
in the air (`jumping=true`). Copy the knock line.

One full `python tools/content_factory/run_ridecert.py` only
if a phase kept code. Render with
`python tools/content_factory/board_table.py`. The 21 within
0.1 s of the board in `dist/nod_002.md`, no new rail,
`teleported=false`. Headless `--playtest`: clear 0 / refuse 4 /
rail 4. Copy the five `PLAYTEST` lines into `dist/elbow_002.md`
from this run, after the board line is copied. If the wrapper
dies for memory and Godot is still riding, wait. Do not start
a second board.

If no phase kept code, do not run style and do not run the
board. The 21/23 log still stands.

If the board moves, revert this prompt's lines. The three nod
lines stay.

## Write it

Top of `dist/STATUS.md`: the elbow rows before and after, the
walk hip if you measured it, and the three clocks if you rode
them. An arm that only shifts, with the same elbow, is not
this job done. A job that stops after one gait is not this job.
