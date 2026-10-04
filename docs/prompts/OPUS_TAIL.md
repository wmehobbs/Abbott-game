# Opus — the tail she can see

You are in `E:\Workspace\Madison`. This is a long job. Do not stop
after the first keep. Do not write `dist/STATUS.md` and quit until
the tail tip has been printed at the walk, the trot, and the canter,
either carried or a written negative, and the three clocks still
hold.

Her hands now move more on the day-one horse at the walk and the
trot, as they already did at the canter. That is kept. The only
change that did it is `horse.gd` `_update_rider`, gaits 1 and 2.
Do not retune those lines. Do not retune `WORRY_NECK`, `WORRY_TAIL`,
`WORRY_EAR`, or the canter branch.

The numbers you are not allowed to "improve" are already in
`dist/hands_002.md`. At the walk and the trot, Tail1 differs by
9.9° and the tail tip over the withers differs by 5.1 cm. Both
tips are still below the withers: pin −0.465 m, day-one −0.414 m.
The dock moved. The hair still hangs. That is the gap. The canter
tip already differs by 13.5 cm (pin +0.133, day-one +0.268). Leave
that canter tip where it is, within 4 cm.

The fist that leaves the learned spot late in the jump stays a
written negative. `rider_mesh.gd` stays. Do not move her arm or
her seat to catch it. The rein stays a straight rod. The five
`hk_adv_002` landings that lose only to a straight approach stay
a written negative. The crest, the hoof plant, the pastern, the
beat gate, and the landing camera stay. Do not edit `ride_ai.gd`.
Do not move a fence. Do not chase 23/23. Do not export. Do not
launch `dist\Abbott.exe`.

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
tree. The walk and the trot on `hk_les_001` are shorter than one
stride. Take them from one throwaway scene, then delete it.

## Frozen

- `refuse_scale`, `turn_scale`, `scope_bonus`, `balance_need`,
  `charge_need`, `_might_look`
- leave windows, `TAKEOFF` 2.55, `collect_pulse` 0.95, `GAIT_SPEED`,
  `STRIDE_HZ`, `land_recover` 2.72, the beat gate
- `_process_jump`, `_place_cam`, the rein rods, `rider_mesh.gd`
- the walk and trot unrest lines, and the canter unrest lines
- the crest at u 0.55: round +15.0, Neck1 −21.4, fore cannon −30.2
- the chip at u 0.55: round 0.0
- fore hooves at the thud within 2 cm of 0.053
- the lowest hoof on a settled stride in 0.052–0.053
- pastern gap within 3 cm
- the pin constants and `_day_one`
- Tail1, Neck1, and Ear1 worry degrees as they are now
- `ride_ai.gd`, both course trees, `ride_cert.gd`, `game_state.gd`

The picture reads the stats. It does not write them. The pin's
worry is 0 at confidence 85. A bend multiplied by worry does
nothing to him. If the pin's tail moves, the bend is not on worry.

A keep, after every phase that touches code:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The board log that just
finished reads 18.54 / 91.61 / 94.00 on those three ids, faults
0 / 2 / 3, 0 rails. The solo clocks before it were 18.53 / 91.61 /
93.99. The window is the keep.

Outside the window, revert that phase. Two fails on one phase:
write the negative and go to the next phase.

## Step 0 — the hair, no pose code

Nothing changes until this is in `dist/tail_002.md`.

One throwaway scene, pin and day-one, one settled stride of walk,
trot, and canter. Delete the scene after. For each, print:

- Tail1 angle against rest, as now
- the tail tip over the withers, metres, as now
- the same tip measure at Tail3 and at the last tail bone
  (`Tail1` … `Tail7` are in the skeleton; use the last one you
  find, and name it)
- distance from that tip to her hip, so a tail that comes up
  into her back is visible in the table
- Ear1.L, and the tip of the last ear bone, in the head frame
- her head travel over the stride, metres, the helmet bone in
  the withers frame

The walk and trot rows you already have say the tip differs by
5.1 cm while Tail1 differs by 9.9°. If this print agrees, the
hair is the job. If the tip already differs by at least 8 cm at
the walk and at the trot, phase 1 is the table. Do not add a
bend to a tip that already reads.

If her head travel already differs by at least 2 cm at the walk
and the trot, her helmet already goes with the hands. Phase 2
is the table.

## Phase 1 — the hair, only if the tip is still short

`bascule.gd` only, on the ground, the same worry weight that
already bends Tail1. Tail1 stays at `WORRY_TAIL`. Add the next
tail bones, a smaller share each, so the hair follows the dock.
Not a new swish, not a sine, not a second animation. The pin
stays put because his worry is 0.

After, in the same scene:

- walk tip and trot tip at least 8 cm higher on day-one than
  on the pin
- both of those day-one tips still below her hip by at least
  10 cm
- canter tip within 4 cm of today's +0.133 pin and +0.268
  day-one
- Tail1 still about 9.9° apart
- Neck1 still about 9.9° apart
- lowest hoof still 0.052–0.053

One attempt on the angles. If the tip does not gain 8 cm without
the canter tip leaving that 4 cm band, or the hair enters 10 cm
of her hip, revert and write the centimetres. That is the
negative. Do not push Tail1 harder to buy it.

Three clocks. Then you are not done.

## Phase 2 — her head, only if step 0 showed it still

`head_x` does not read `_hand_unrest`. Her body already does.
If her helmet travel at the walk and the trot differs by less
than 2 cm, add a share of the same unrest to `head_x` only, on
gaits 1 and 2, on the stride. Do not multiply the posting
constants. Do not touch gait 3. The hands stay on the numbers
in `dist/hands_002.md` (walk difference about 2.7 cm, trot
about 2.6 cm). If the hands move by more than 0.5 cm from
those differences, the head term is coupled and you revert it.

If step 0 already has the 2 cm, write the rows. Do not nod her
again.

Three clocks if you touched code. Then you are not done.

## Phase 3 — coming back to himself

Worry is already supposed to return over the first 0.5 s of
`land_recover`. Nobody printed it. On fence 1 of pin
`hk_les_001` and of fresh `hk_les_001`, Neck1 and the tail tip
at touchdown, at 0.25 s, and at 0.50 s.

If day-one's neck is at least 8° higher than the pin's by 0.50 s,
and his tip is at least 8 cm higher, the return is already the
picture. Write it. Do not code.

If the land pose holds both necks together through that half
second, one attempt in `bascule.gd`: the worry that already
exists may come back on the neck and the tail. It may not
change `LAND_X`, `_place_cam`, the crest, or the hoof plant.
The pin's check on a refusal stays Neck1 around +11.7 and
Tail1 around −0.3. Two fails: the recover is a negative.

Three clocks if you touched code.

## The pin is still the pin

Style, once, if any phase kept code:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds at 0.053,
Neck1 around +11.7, Tail1 around −0.3, not the day-one tail.
C one rail on fence 3 in the air (`jumping=true`). Copy the
lines before the next command.

One full `python tools/content_factory/run_ridecert.py`. Render
with `python tools/content_factory/board_table.py`. The 21
within 0.1 s of the board in `dist/hands_002.md`, no new rail,
`teleported=false`. Headless `--playtest`: clear 0 / refuse 4 /
rail 4. Write the `PLAYTEST done` line into `dist/tail_002.md`.
The last board log does not contain one.

If no phase kept code, do not run the board. The 21/23 log
still stands.

If the board moves, revert this prompt's bends. The hand terms,
the quiet picture, and the straight rein stay.

## Write it

Top of `dist/STATUS.md`: the tip rows before and after, whether
the hair followed the dock, her head if you measured it, the
recover samples, and the three clocks from the rides. A tail
that only changes Tail1's angle is the tail you already have.
A job that stops before the walk tip is printed again is not
this job.
