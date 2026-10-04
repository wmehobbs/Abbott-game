# Opus — her head at the trot

You are in `E:\Workspace\Madison`. This is a long job. Do not stop
after the first measurement. Do not write `dist/STATUS.md` and quit
until her trot nod has been printed as a pitch, either kept or a
written negative, and the ear tip has been printed the same way.

The hair is a written negative. Tail2–Tail5 lifted the day-one tip
14.7 cm at the walk and the trot, and the canter tip went to +0.305
against +0.264, 4.1 cm, 1 mm outside the band. A second scene of
that same code read 3.9 cm. It was reverted. Do not put
`WORRY_HAIR` or `_tail_hang` back. Do not try a smaller curl. The
tail she sees at the walk and the trot is Tail1's dock, 5.1 cm at
the tip. That stands.

The recover already returns him. By 0.50 s of `land_recover` on
fence 1, day-one's neck is 9.9° higher and his tail tip 13.5 cm
higher. Do not touch that fade.

Her hands at the walk and the trot stay the kept terms in
`horse.gd` `_update_rider`. Do not retune them. The fist that
leaves the learned spot late in the jump stays a written negative.
`rider_mesh.gd` stays. The rein stays a straight rod. The five
`hk_adv_002` landings stay a written negative. The crest, the hoof
plant, the pastern, the beat gate, and the landing camera stay.
Do not edit `ride_ai.gd`. Do not move a fence. Do not chase 23/23.
Do not export. Do not launch `dist\Abbott.exe`.

What is open: at the trot her hands travel 2.6 cm more on the
day-one horse, and her helmet does not. Step 0 of `dist/tail_002.md`
has the head-bone origin identical (0.101 / 0.100). The helmet
crown, which is what a `head_x` rotation actually moves, travels
0.115 on the pin and 0.105 on day-one. The path length is the
wrong ruler. The post is 23 cm and it swamps a nod. This job
measures the nod as a pitch against her shoulders.

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
- the walk unrest lines, the canter unrest lines, and the trot
  lines that are not `head_x` (the 26.4° post, the 0.228 rise,
  the 14° / 0.070 unrest already on `pitch` and `rest.y`)
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

`teleported=false`, round complete. The hands board is the floor:
18.53 / 91.61 / 93.99, and the full log 18.54 / 91.61 / 94.00.
The window is the keep. Outside it, revert that phase. Two fails
on one phase: write the negative and go to the next phase.

## Step 0 — the nod, no pose code

Nothing changes until this is in `dist/head_002.md`.

One throwaway scene, pin and day-one, one settled trot stride
and one settled walk stride. Delete the scene after. For each:

- peak-to-peak of her helmet pitch relative to her shoulders,
  degrees, over that stride. The helmet is the Cap on her Head
  bone. The shoulders are her body, not the horse.
- the commanded `head_x` peak-to-peak, degrees, so you can see
  whether the mesh follows it
- hand travel, to show the kept 2.6 cm at the trot and 2.7 cm
  at the walk are still there
- head-bone origin travel, which should stay about 0.101 / 0.100
  at the trot and 0.040 / 0.076 at the walk
- lowest hoof

If the helmet's pitch relative to her shoulders is already at
least 4° more on day-one at the trot, phase 1 is the table. Do
not nod her again. The crown's path length (0.115 / 0.105) is
not this test.

Same scene, canter too, one stride: Ear1.L and the Ear4 tip in
the head frame, both horses. Step 0 of the tail job had the
canter ear tip about 3 cm apart in one axis and about 4 cm in
another. If the tip is at least 4 cm from the pin's tip in the
head frame, phase 2 is the table. Do not bend Ear2.

## Phase 1 — the trot nod, only if the pitch is flat

`head_x` on gait 2 only. Add a share of `_hand_unrest()` on the
stride, the same shape as the trot pitch line that is already
there. Do not multiply `post * 8.4`. Do not touch gait 1 or
gait 3. Do not touch `pitch` or `rest`.

After, in the same scene:

- trot helmet pitch at least 4° more on day-one than on the pin
- trot hand travel still within 0.5 cm of 0.055 pin and 0.081
  day-one
- walk head-bone travel still about 3.6 cm, walk hands still
  about 2.7 cm
- lowest hoof 0.052–0.053
- canter Neck1 still about 9.9° apart, Tail1 still about 9.9°

One attempt on the degrees. If the pitch does not gain 4°
without the hands moving, revert and write both numbers. That
is the negative.

Three clocks if you kept it. Then you are not done.

## Phase 2 — the ear tip, only if step 0 showed it short

`bascule.gd`, Ear2 only, a smaller share of the same worry that
already bends Ear1. Both sides. On the ground. Ear1 stays at
`WORRY_EAR`. The pin's worry is 0, so his ear stays put.

After: the Ear4 tip at the canter is at least 4 cm from the
pin's tip, in the head frame. The crest at u 0.55 is unchanged.
The recover at 0.50 s still has the neck 8° apart. If the tip
does not move 4 cm without the crest or the recover moving,
revert. One attempt.

Three clocks if you kept it.

## The pin is still the pin

If any phase kept code, style once:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds at 0.053,
Neck1 around +11.7, Tail1 around −0.3. Her trot nod is not on
that check, because the check is not a trot. C one rail on
fence 3 in the air (`jumping=true`).

One full `python tools/content_factory/run_ridecert.py`. Render
with `python tools/content_factory/board_table.py`. The 21
within 0.1 s of the board in `dist/hands_002.md`, no new rail,
`teleported=false`. Headless `--playtest`: clear 0 / refuse 4 /
rail 4. Copy the `PLAYTEST done` line into `dist/head_002.md`.
The tail job's playtest line was copied from the hands job. This
one has to be from the run you just did.

If no phase kept code, do not run style and do not run the
board. The 21/23 log still stands.

If the board moves, revert this prompt's lines. The hand terms
and the straight rein stay.

## Write it

Top of `dist/STATUS.md`: the trot pitch before and after, in
degrees, the ear tip if you measured it, and the three clocks
if you rode them. A crown path of 0.115 against 0.105 is not a
nod. A job that stops before the pitch is printed is not this
job.
