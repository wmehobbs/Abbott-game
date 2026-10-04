# Opus — finish the hands, then the clocks

You are in `E:\Workspace\Madison`. The inventory is already in
`dist/hands_002.md`. The walk and the trot terms are already in
`horse.gd` `_update_rider`. This job finishes that work. It does
not start a new picture. Do not stop when the first clock prints.

One Godot is already riding. `dist/ridecert_godot.log` was opened
for `--ridecert-id=hk_adv_003` and was on the come-again into
fence 10. That is the one process. Do not launch another. Do not
kill it. Do not edit a script while it is running. Wait until that
log has a `RIDECERT hk_adv_003` line and the process has exited.

`--headless` stays the first argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`. No
window, no editor, no F5, no `--artshot`, no `ride_ids.py`, no
`dist\Abbott.exe`. One Godot. Timeouts: one id 8 minutes, a fresh
id 12 minutes, a style id 15 minutes, the full board 70 minutes.
No `RIDECERT round` in 2 minutes is a compile error: kill only
that process. `run_ridecert.py` opens the log with `"w"`, so the
next id erases the previous one. Copy each `RIDECERT hk_…` line
into `dist/hands_002.md` before you start the next id.

## What is already true

Step 0 in `dist/hands_002.md` matches the rides it names:

- Pin fists stay within 0.017 m of the learned spot from u 0.20
  to 0.80. The two wrists are 0.100 m apart. That 0.13–0.15 m
  from the last job was the old spread mixing frames. Do not
  pull her hands together.
- Walk and trot, from the throwaway scene: neck 9.9°, tail 9.9°,
  hand travel identical (walk 0.017 / 0.017, trot 0.043 / 0.043).
  The horse already carries his head. Her hands do not.
- Half-halt: day-one Neck1 is 9.9° higher than the pin
  (−11.86 against −21.76 at the first sit). Phase 3 stays
  unwritten. Do not add a sit.
- Canter on the ride, before the walk term: neck 10.2°, tail
  9.8°, hands 2.2 cm. Leave `WORRY_NECK`, `WORRY_TAIL`,
  `WORRY_EAR`, `_worry_w`, and the canter branch of
  `_update_rider` alone.

The fresh log `dist/ridecert_fresh.log` is a later day-one
`hk_les_001`, probes still in that file, t=18.52, ending
conf 54. That is not the pin clock. Its fist probe (PROBE41)
does not match the inventory: u 0.70 is 0.026 m off the spot,
u 0.80 is 0.016 / 0.020, and at u 0.55 the shoulder-to-target
is 0.298 / 0.302 against a reach of 0.351. The arm reaches at
the crest. Nobody printed shoulder-to-target at the u where
the wrist leaves the spot.

## Phase 1 — write the negative you actually measured

No second fix. `rider_mesh.gd` stays as it is. Do not lift her
fists, do not move the seat, do not parent her to a neck bone,
do not bend the rein.

Append one paragraph to `dist/hands_002.md`. The inventory ride
has the day-one wrist 0.038 / 0.036 m off the learned spot at
u 0.80. The later ride has 0.026 m at u 0.70 and under 0.02 m
at u 0.80. The "1.6–3.4 cm short of reach" sentence is not in
either file. Do not promote it. The negative is: the miss moves
between runs, it is a few centimetres, and holding it would mean
moving her arm or her seat. Left.

## The three clocks

`hk_adv_003` is the run already going. When it finishes, copy
faults, rails, time, teleported. The keep is 93.91–94.07, 3
faults, 0 rails, teleported=false, complete.

`hk_les_001` and `hk_adv_001` from this phase are not in
`ridecert_godot.log`. Ride them after 003 exits, one at a time,
pin rides, not fresh. Copy each line before the next id.

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

Outside the window: revert only the walk and trot additions in
`_update_rider` (the `walk_unrest` lines on gait 1 and the
`trot_unrest` lines on gait 2). The canter branch, the quiet
picture, the crest, the pastern, the beat gate, the landing
camera, and the straight rein stay. Then ride the three ids
again on that reverted tree. One miss after the revert is the
end of the phase: write the times and stop. Do not tune the
10° / 0.05 m walk or the 14° / 0.07 m trot a third time.

## The table the pass claimed

The 2.5–2.7 cm, and the canter difference 9.5° / 10.1° / 2.0 cm,
are not in `dist/hands_002.md`. The only saved post-change
canter line is PROBE40 in the fresh log: day-one only, Neck1
−5.48, Tail1 −10.69, hand travel 0.115. One horse is not a
difference.

After the clocks are in, and only if they held: one throwaway
scene, deleted after, pin and day-one, one settled stride of
walk, trot, and canter. Same columns as the inventory. Append
the six rows under a heading "after the walk and trot terms."
Hand-travel difference at the walk and at the trot has to be
at least 2 cm. Canter difference has to stay at least 8° of
neck, 8° of tail, and 2 cm of hand. A planted hoof on each
gait stays at 0.053. If a hoof lifts, or the canter picture
drops under those minimums, revert the walk and trot terms
and say so. Do not add more amplitude to buy the 2 cm.

If the clocks did not hold, you already reverted. The scene
is then the reverted tree, and the rows should match step 0
(hands identical at the walk and the trot). Write that.

## Then the pin, once

Style, once, on the tree you are keeping:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, no jump clip, hinds
on the sand from 0.25 s, Neck1 around +11.7, Tail1 around −0.3,
not the day-one headset. C one rail on fence 3 in the air
(`jumping=true`). Copy the three result lines and the knock
line before the next command. The style log is a different
file. The godot log is not.

One full `python tools/content_factory/run_ridecert.py`. Render
with `python tools/content_factory/board_table.py`. The 21
within 0.1 s of the board in `dist/STATUS.md`, no new rail,
`teleported=false`. Headless `--playtest`: clear 0 / refuse 4 /
rail 4. Do not start the board if a Godot is still in the log.
Do not chase 23/23. Do not export.

If the board moves, revert the walk and trot terms. Everything
else from this morning stays.

## Write it

Top of `dist/STATUS.md`: the three clocks you copied, the walk
and trot rows before and after, the fist negative in the words
above (both rides, not a reach you did not print), and that the
half-halt was left because the neck difference survived it.
A number that is only in the chat is not a number. A job that
stops while `hk_adv_003` is still on fence 10 is not this job.
