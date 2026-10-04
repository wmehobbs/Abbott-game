# Opus — her hands stay with him

You are in `E:\Workspace\Madison`. This is a long job. Do not stop
after the first keep. Do not write `dist/STATUS.md` and quit until
the inventory is on disk, the jump hands are either on the neck or
a written negative, the walk and the trot have been printed, the
half-halt has been printed, and the three clocks still hold.

Day-one carries his head and his tail up. The pin horse, confidence
85, does not. That picture is kept. The numbers are in
`dist/horse_feel.md` and the top of `dist/STATUS.md`. Do not retune
`WORRY_NECK`, `WORRY_TAIL`, `WORRY_EAR`, `_worry_w`, or
`_hand_unrest` to chase a bigger canter gap. The canter minimums
are already met: neck 10.0°, tail 9.8°, ears 8.6° forward, hands
3.0 cm.

The rein stays one straight rod. The five `hk_adv_002` landings
that lose only to a straight approach stay a written negative. The
jump crest, the hoof plant, the pastern, the beat gate, and the
landing camera stay. Do not edit `ride_ai.gd`. Do not move a fence.
Do not chase 23/23. Do not export. Do not launch `dist\Abbott.exe`.

What the last log recorded and did not chase: fists in the air
spread 0.13–0.15 m in the withers frame on both horses between
u 0.20 and 0.80. The floor files were 0.15–0.22. Both horses, so
confidence is not the cause. `rider_mesh.gd` `_on_neck_weight` is
supposed to hold each fist on the spot learned at the canter, in
the withers frame, from u 0.15 to 0.85. Thirteen centimetres is
either that hold failing, or just the gap between her two hands.
You do not know which until you print both.

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

A probe is inserted once and stripped before a timed ride. Do not
leave one in the tree. The style log from this afternoon still has
a `PROBE32` line. The board log does not, and the scripts do not.
Keep it that way.

## Frozen

- `refuse_scale`, `turn_scale`, `scope_bonus`, `balance_need`,
  `charge_need`, `_might_look`
- leave windows, `TAKEOFF` 2.55, `collect_pulse` 0.95, `GAIT_SPEED`,
  `STRIDE_HZ`, `land_recover` 2.72, the beat gate
- `_process_jump`, `_place_cam`, the rein rods
- the crest at u 0.55: round +15.0, Neck1 −21.4, fore cannon −30.2
- the chip at u 0.55: round 0.0
- fore hooves at the thud within 2 cm of 0.053
- pastern gap within 3 cm
- the pin constants and `_day_one`
- `_school_from_round`'s numbers
- `ride_ai.gd`, both course trees, `ride_cert.gd`, `game_state.gd`

The picture reads the stats. It does not write them.

A keep, after every phase that touches code:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The window is the keep. The
board log from 26 Sep 14:06 (`dist/ridecert_godot.log`) reads
18.53 / 91.59 / 94.01. The STATUS header's 91.61 and 93.99 are the
earlier trio. Both sit inside the window. Copy the ride you just
ran, not the header you liked.

The pin ride starts at confidence 85. A fresh ride ends schooled
and the next pin ride starts at 85 again. If a fresh ride leaks
into the next pin ride, that is a revert.

Outside the window, revert that phase. Two fails on one phase:
write the negative and go to the next phase. Do not spend the day
on one number.

## Step 0 — inventory, no pose code

Nothing in `bascule.gd`, `horse.gd`, or `rider_mesh.gd` changes
until this is in `dist/hands_002.md`.

### The fists over one fence

One headless pin `hk_les_001`, first fence, probe stripped after.
One headless `--ridecert-fresh --ridecert-id=hk_les_001`, first
fence. Withers frame is `Bascule.withers`. For each wrist, at
u 0.20, 0.40, 0.55, 0.70, 0.80:

- position in that frame
- distance to that wrist's position on the last settled canter
  stride before the jump (the learned spot)
- distance between the two wrists

Also the IK miss at u 0.55: shoulder-to-target against the arm's
reach, both sides.

Read it this way:

- If each wrist stays within 0.02 m of its own learned spot from
  u 0.20 to 0.80, the 0.13–0.15 m is the gap between her hands.
  Hands on a neck are apart. That is not a throw. Write the
  numbers. Do not pull her hands together. Phase 1 is the table.
- If any wrist leaves its learned spot by more than 0.02 m, that
  is the throw. Phase 1 keeps the spot she already learned. It
  does not invent a new one.

### Walk, trot, canter

Pin and day-one, one settled stride each, same columns as
`dist/horse_feel.md`: Neck1, Tail1, tail tip over the withers,
Ear1.L, poll, hand travel of the left wrist in the withers frame.

`hk_les_001` does walk, then trot, then canter. Use those strides
if each gait is actually there for a full stride. The cert walk
has been as short as a tenth of a second. If a gait is shorter
than one stride, say so, and take that gait from one headless
scene that is not the cert: set the gait, wait two seconds, print,
delete the scene. It does not stay as a second way to start a
round.

The canter row is a check that the kept picture is still the kept
picture. If the neck difference is under 8° or the pin's tail has
moved toward the day-one tail, stop and say so. Do not "improve"
it.

`_hand_unrest` runs on the canter only. The walk and the trot are
the open columns. If the neck already differs by at least 8° and
the tail by at least 8° at that gait, the horse already carries
it. Her hands are a separate number.

### One half-halt

Both horses, the deepest `collect_pulse` sit you can catch on
`hk_les_001` (a `rein=-1` land is one). Neck1, Tail1, and each
wrist against its canter spot. If the cert never sits long enough
to read, use the same throwaway scene, one sit, then delete it.

If day-one Neck1 is still at least 8° higher than the pin at that
sit, the sit does not erase the head. Write it. Do not code a
new sit.

## Phase 1 — the release, only if step 0 found a throw

`rider_mesh.gd` hand target only, while `jumping` and u is between
0.20 and 0.80. Each fist stays on the withers-frame spot learned
at the canter. You may hold that spot. You may not move the spot,
lift her fists, add a bend in the rein, parent her to a neck bone,
or write `global_position`.

After, on the pin fence and the day-one fence:

- each wrist within 0.02 m of its learned spot at u 0.20, 0.55,
  and 0.80
- crest at u 0.55 still round +15.0, Neck1 −21.4, fore cannon
  −30.2 on the pin
- fore hooves at the thud within 2 cm of 0.053
- the rein is still one straight rod

If the arm cannot reach the spot, the miss is the negative. Write
the centimetres and the reach, revert the phase, and continue.
One attempt. Do not search offsets.

Three clocks. Then you are not done.

## Phase 2 — the trot and the walk

Only a column step 0 showed is flat.

If her hand travel at the trot differs by less than 2 cm while his
neck already differs, the posting takes the same unrest the canter
rock takes. Add a term. Do not multiply the posting constants that
are already there (the rise, the 26°). The canter lines are the
shape: a fraction of `_hand_unrest()` on top of the gait, and the
hands still come back to the neck. A planted hoof stays at 0.053.
If a hoof lifts, revert.

The walk is short in the cert. The same idea, smaller, and only
if step 0 showed her hands identical while his head is up. If the
walk term puts `hk_les_001` outside 18.50–18.60, revert the walk
and keep the trot if the trot held.

If step 0 already has at least 2 cm of hand travel difference at
the trot and at the walk, this phase is the table. Do not add a
bounce you cannot see in the numbers.

Reprint one canter stride of each horse after this phase. The kept
picture still has to clear 8° of neck, 8° of tail, and 2 cm of
hand travel. If it does not, revert the phase.

Three clocks if you touched code. Then you are not done.

## Phase 3 — the sit, only if step 0 showed it erasing the head

One attempt. A half-halt may leave the worried neck up. It may
not put the pin's neck up, and it may not raise the day-one neck
more than a few degrees past his own canter. Her fists stay on the
neck, behind the withers, not into a release.

The refusal is not this sit. Style B on the pin stays a check:
Idle, hinds at 0.053, Neck1 around +11.7, Tail1 around −0.3, no
day-one headset. If your sit puts that headset on the pin's check,
revert.

Two fails: the sit is a negative. The other phases stay.

Three clocks if you touched code.

## The pin is still the pin

Three clocks again if any phase kept code. Then style, once:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, no jump clip, hinds on
the sand from 0.25 s, and his neck and tail are the check, not the
day-one headset. C one rail on fence 3 in the air (`jumping=true`).
Fresh is not this run.

If no phase kept code, do not run style and do not run the board.
The 21/23 log from 14:06 still stands. Write that.

If a phase kept code: one full
`python tools/content_factory/run_ridecert.py`. Render with
`python tools/content_factory/board_table.py`. The 21 within 0.1 s,
no new rail, `teleported=false`. Headless `--playtest`: clear 0 /
refuse 4 / rail 4.

If the board moves, revert this prompt's files. The quiet picture,
the landing camera, the pastern, the beat gate, and the straight
rein stay.

## Write it

Top of `dist/STATUS.md`: the fist table (the learned-spot distances,
or "already on the spot, 0.13 m is the gap between her hands"), the
walk and trot rows next to the canter, the half-halt row, and the
three clocks from the ride you just ran. Copy them from the rides.
A channel you did not print is not a channel you kept. A job that
stops after the hands is not this job.
