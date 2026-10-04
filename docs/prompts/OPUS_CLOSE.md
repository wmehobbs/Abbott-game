# Opus — the picture you have

You are in `E:\Workspace\Madison`. This job writes the
picture down. It does not add a coefficient. It does
not flip a sign. It does not ride. If you finish the
paragraph, stop.

The trot minus is a written negative, and the 0.01°
is not why. `dist/post_002.md` measured it. With the
plus, trot body-pitch peak-to-peak is 8.46° on the
pin and 5.57° on day-one, 2.89° less on day-one.
With `pitch -= swing * 14.0 * trot_unrest` it became
11.21° / 14.20°, 2.99° more on day-one. The same
scene took her trot hands from 0.055 / 0.081 m to
0.044 / 0.046 m, 3.5 cm off day-one, and her farthest
trot heel from 0.107 m to 0.133 m, 2.6 cm. The nod,
the hip, and the rise held. The plus is the picture
the hands were kept on. Her fist target is
body-relative, so a back that swings more is a back
whose hands swing less. Do not come back with a 16
or a 12. Do not flip the head line or the rise.

`horse.gd` is the heel tree. The trot line is
`pitch += swing * 14.0 * trot_unrest`. Leave it.

## Do not open these

They are already written. A new number on any of
them is not this job.

- the lean. `LEAN` 8, roll 3.05° apart, heels slid
  2.48 / 2.54 cm. No shin term for a lean.
- the canter's extra 8 beside `rock * 14`. It gave
  3.45° and moved canter hands from 0.103 m to
  0.109 m.
- the trot minus, above.
- the elbows over the fence. They read 2.8°, then
  0.24°, then 4.4°, then 0.35°, on the same fence.
- the rein, a straight rod.
- the five `hk_adv_002` landings that lose only to a
  straight approach.
- the tail hair. Tail7 at the walk and the trot
  differs by 5.1 cm and hangs.
- the late fist.
- the half-halt. At `collect_pulse` 0.717 she
  already shows him. No new sit.
- the horse's bank, `visual.rotation.z`.
- `ride_ai.gd`, `_place_cam`, `bascule.gd`, the
  fences, `land_recover` 2.72.

## What stays, and is already in the files

Do not reprint these by riding. They are the paragraph.

- Fold: `FOLD_PITCH` 18, `FOLD_SHIN` 20. Eased pitch
  at u 0.55 is −40.68° / −47.66°. Two-point heels
  0.1153 m / 0.1180 m. Fence 3 changes 0.00°. Fence
  12's 0.02–0.04° at u 0.012 is the keys.
- Air hip: `SIT_HIP` 10 in the two-point and the arc.
  Eased hip at u 0.55 is 3.84° apart.
- Helmet through the two-point, the arc, and the sit:
  about 3.8° / 4.9° / 5.2°.
- Halt: helmet 3.45° apart, elbows 4.26° / 4.70°,
  hip 3.45°, still. `head_x -= 20 * unrest`,
  `hip_x += 9 * unrest`, `SHOULDER_HALT` −40.
- Moving gaits: the nod, the elbows, the hip, the
  hands, as in `dist/same_002.md`. Walk body-pitch
  already 3° more on day-one. Trot body-pitch less
  on day-one, on purpose, because that is the plus.
  Canter body-pitch about 2.2–2.7° more, and the
  extra term is the negative above.
- The horse: neck, tail, and ears up on day-one.
  The crest at u 0.55 is the same horse. The return
  at 0.50 s is 9.9° of neck and tail, and the ear's
  own 8.8°.
- Clocks on this tree: 18.54 / 91.60 / 93.99, faults
  0 / 2 / 3, 0 rails, `teleported=false`.
- Board: 21/23. `hk_int_007` at 84.93. Do not chase
  it. Do not export.

## Silent

Do not launch Godot. Do not open a window. Do not
run `run_ridecert.py`. Do not insert a probe. Do
not add a scene file. A Godot window locks the
desktop, and this job has nothing to ride.

Read `horse.gd` `_update_rider` once. Every pitch,
roll, head, hip, shin, and rest term is either in
the list above or it is not. If you find a term
that is none of those, write its line and stop.
Do not give it a coefficient tonight.

## Write it

Top of `dist/STATUS.md`, one paragraph, then the
tables you need and no more. The date is 27 Sep.
Say the picture is the one in the files. Name the
trot plus as kept because the minus takes the
hands, and name the lean and the canter 8 as
closed. The clocks and the 21/23 are the heel
board's. No new `dist/post_002` rows. That file
already holds the minus.

Then stop. Do not invent a channel.
