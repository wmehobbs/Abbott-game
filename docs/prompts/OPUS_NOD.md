# Opus — her head at the walk and the canter

You are in `E:\Workspace\Madison`. This is a long job. Do not stop
after the walk. Do not write `dist/STATUS.md` and quit until both
the walk nod and the canter nod have been printed, each one kept
or a written negative, and any phase that kept code has its three
clocks.

The trot is kept. `head_x += swing * 48.0 * trot_unrest` stays
that line, in the trot branch only. Day-one's helmet pitch against
her shoulders went from 1.48° to 8.39°, the pin from 1.48° to
3.67°, 4.72° apart. Do not retune the 48.

The same table shows the other two gaits still flat. After that
line, helmet pitch against her shoulders is 0.64° on both horses
at the walk, and 0.68° on both at the canter. Her body already
moves more on day-one. Her head does not, except at the trot.
That is the gap. The numbers are in `dist/head_002.md`.

The hair stays a written negative. Do not put Tail2–Tail5 back.
The recover already returns him by 0.50 s. Do not touch that
fade. The ear tip is already 4.9 cm apart. Do not bend Ear2.
The fist that leaves the learned spot late in the jump stays a
written negative. `rider_mesh.gd` stays. The rein stays a
straight rod. The five `hk_adv_002` landings stay a written
negative. The crest, the hoof plant, the pastern, the beat gate,
and the landing camera stay. Do not edit `ride_ai.gd`. Do not
move a fence. Do not chase 23/23. Do not export. Do not launch
`dist\Abbott.exe`.

The pin's nod may grow. Feel is 36 on both horses, so his unrest
is 0.18, not 0. That happened at the trot (1.48° to 3.67°) and
it was kept. The test is the difference, not a quiet pin.

## Silent

Ernie is at the machine. A Godot window locks the desktop.
`--headless` is the first argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`. No
windowed exe, no editor, no F5, no `--artshot`, no `ride_ids.py`.
One Godot. Timeouts: one id 8 minutes, a fresh id 12 minutes, a
style id 15 minutes, the full board 70 minutes. No `RIDECERT round`
in 2 minutes is a compile error: kill only that process. If the
wrapper dies for memory, wait for the ride that is already going.
Do not start a second board.

`run_ridecert.py` opens the log with `"w"`. Copy each
`RIDECERT hk_…` line out before the next id. A probe is inserted
once and stripped before a timed ride. Do not leave one in the
tree. Walk and trot on `hk_les_001` are shorter than one stride.
Take them from one throwaway scene, then delete it. No Godot is
running now.

## Frozen

- `refuse_scale`, `turn_scale`, `scope_bonus`, `balance_need`,
  `charge_need`, `_might_look`
- leave windows, `TAKEOFF` 2.55, `collect_pulse` 0.95, `GAIT_SPEED`,
  `STRIDE_HZ`, `land_recover` 2.72, the beat gate
- `_process_jump`, `_place_cam`, the rein rods, `rider_mesh.gd`,
  `bascule.gd`
- the trot branch, including `head_x += swing * 48.0 * trot_unrest`
  and `post * 8.4`
- the walk and canter lines that are not `head_x`
- the crest at u 0.55: round +15.0, Neck1 −21.4, fore cannon −30.2
- fore hooves at the thud within 2 cm of 0.053
- the lowest hoof on a settled stride in 0.052–0.053
- the pin constants and `_day_one`
- `WORRY_NECK`, `WORRY_TAIL`, `WORRY_EAR`
- `ride_ai.gd`, both course trees, `ride_cert.gd`, `game_state.gd`

The picture reads the stats. It does not write them.

A keep, after a phase that touches code:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. This job's board is the
floor: `hk_les_001` 18.53 on the full log, the solo clock 18.54,
`hk_adv_001` 91.60, `hk_adv_003` 94.00 on the full log and 94.02
on the solo. The window is the keep. Outside it, revert that
phase. Two fails on one phase: write the negative and go to the
next gait. Do not spend a second coefficient on the same gait.

## Step 0 — reprint the flat gaits

Nothing changes until this is in `dist/nod_002.md`.

One throwaway scene, pin and day-one, one settled stride of
walk, trot, and canter. Delete it after. Helmet pitch is the
angle of her Head bone against her Chest bone, peak-to-peak,
degrees, the same ruler as `dist/head_002.md`.

Print, for each gait and each horse:

- that pitch
- commanded `head_x` peak-to-peak
- hand travel
- lowest hoof

The trot row has to still read about 3.67° / 8.39°. If it does
not, stop. The trot line has moved, and this job is not a retune.

If the walk pitch is already at least 3° more on day-one, phase
1 is the table. If the canter pitch is already at least 4° more
on day-one, phase 2 is the table. Do not nod a gait that already
clears its number.

## Phase 1 — the walk

`head_x` on gait 1 only, a share of `_hand_unrest()` on the
stride. The walk is the small gait. Do not copy the trot's 48.
One coefficient, chosen from the same smoothing you already
measured (the helmet follows about 0.45 of `head_x`, and the
ease passes a fraction of the stride). Do not touch gait 2 or
gait 3. Do not touch `pitch` or `rest`.

After:

- walk helmet pitch at least 3° more on day-one than on the pin
- walk hands still within 0.5 cm of 0.029 pin and 0.056 day-one
- trot pitch still about 3.67° / 8.39°
- lowest hoof 0.052–0.053
- canter Neck1 and Tail1 still about 9.9° apart

One attempt. If the pitch does not gain 3° without the trot or
the hands moving, revert and write both numbers.

Three clocks if you kept it. Then the canter. You are not done.

## Phase 2 — the canter

`head_x` on gait 3 only, a share of the unrest already used on
the canter rock. Not the trot's 48, and not the walk's
coefficient unless the stride math says the same number. Do not
touch gait 1 or gait 2. Do not touch `pitch` or `rest`.

After:

- canter helmet pitch at least 4° more on day-one than on the pin
- canter hands still within 0.5 cm of 0.078 pin and 0.103 day-one
- trot pitch still about 3.67° / 8.39°
- the walk pitch, if you kept phase 1, still at least 3° apart
- lowest hoof 0.052–0.053
- Neck1 and Tail1 still about 9.9° apart

One attempt. If it misses, revert the canter line only. The
walk, if it held, stays.

Three clocks if you kept it.

## The pin is still the pin

If any phase kept code, style once:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds at 0.053,
Neck1 around +11.7, Tail1 around −0.3. The check is not a trot
and not a canter, so her new nod should not be on it. C one
rail on fence 3 in the air (`jumping=true`). Copy the knock
line. The last style writeup left it in the log and out of the
file.

One full `python tools/content_factory/run_ridecert.py`. Render
with `python tools/content_factory/board_table.py`. The 21
within 0.1 s of the board in `dist/head_002.md`, no new rail,
`teleported=false`. Headless `--playtest`: clear 0 / refuse 4 /
rail 4. Copy the five `PLAYTEST` lines into `dist/nod_002.md`
from this run. Run the playtest after the board line is copied.
The board log does not keep a playtest that starts next.

If no phase kept code, do not run style and do not run the
board. The 21/23 log still stands.

If the board moves, revert this prompt's `head_x` lines. The
trot's 48 stays.

## Write it

Top of `dist/STATUS.md`: the walk pitch and the canter pitch,
before and after, in degrees, and the three clocks if you rode
them. A job that stops after the walk is not this job. A job
that changes the trot's 48 is not this job.
