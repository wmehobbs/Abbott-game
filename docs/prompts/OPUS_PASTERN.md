# Opus — the pastern, then the rein

You are in `E:\Workspace\Madison`. The hooves meet the sand. The crest
and the chip are kept. Board is 21/23. The two Mini Prix clocks are
closed. Do not edit `ride_ai.gd`. Do not move a fence. Do not export.
Do not launch `dist\Abbott.exe`.

Two things were measured last night and left.

The hoof bones are IK roots, not children of the legs. In the gallop
clip they sit up to 16 cm from the cannon tips, and the bascule's
cannon bends add to that in the air, so the pastern stretches. Do not
edit the glb. Move the hoof so it belongs to the leg.

The rein is one straight rod from bit ring to glove. It passes through
the neck at the canter, the jump, the land, and the refusal. It does
not go slack. A straight rod cannot clear a neck that arches above
that line. You may break each rein into two segments of the same rein,
bit to a point on the crest and crest to the hand. You may not add a
bridle, a bit, or a second pair of reins, and you may not lift her
fists off the withers to buy the clearance.

## Silent

Ernie is at the machine. A Godot window locks the desktop.

`--headless` first, then the path:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides go through `python tools/content_factory/run_ridecert.py`.
No windowed exe, no editor, no F5, no `--artshot`, no `ride_ids.py`.

One Godot. If one is running and the log is growing, wait. If the log
has not grown for ten minutes, kill only that process. Timeouts: one
id 8 minutes, a style id 15 minutes, the full board 70 minutes. If
`RIDECERT round` has not appeared in 2 minutes, it is a compile error.
Kill only that process and fix it. Last night the wrapper was killed
for memory while Godot kept riding. If that happens again, do not
start a second board. Wait for `RIDECERT done`, then copy
`ridecert_results.json` to `ridecert_board.json` the way the wrapper
would have.

## Frozen

Byte-for-byte:

- `_process_jump`, `_begin_jump`, `_begin_schooling_jump`
- leave windows, `TAKEOFF` 2.55, `collect_pulse`, `GAIT_SPEED`,
  `STRIDE_HZ`, turn rate, `land_recover` 2.72
- `ride_ai.gd`, both course trees, `ride_cert.gd`, `game_state.gd`
- contact height 0.053, and a fore hoof at the thud within 2 cm of it
- the clear crest at u 0.55: round +15.0, Neck1 −21.4, fore cannon
  −30.2. The chip at u 0.55: round 0.0, neck a little up, forelegs
  hanging
- her fists on the withers within 0.02 m, including through the jump

A keep is the same window as last night:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. Outside that, revert the phase.
Two fails on one phase: revert it, write why, go to the next. Do not
spend the day on one number.

You may edit `bascule.gd`, the rein draw in `horse.gd`, and a marker
for the crest point. Not the jump arc. Not a new AnimationPlayer.
Not a `global_position` on the rider. Madison stays on `Torso`.

## Step 0 — the gap

Headless `hk_les_001`, then strip the probe before any timed ride.

For each hoof, the distance from `FF.L` / `FF.R` / `FFB.L` / `FFB.R`
to the tip of its cannon. Name the cannon bones you actually find
(`FrontLowerLeg`, `BackLowerLeg`, or whatever the skeleton calls the
last bone before the hoof). Print that distance at:

- a planted canter beat
- the same beat, the hoof that is in the air
- the clear jump at u 0.20, 0.55, 0.85, 1.00

The number to beat is the air gap at u 0.55. Last night it was as
much as 0.16 m in the clip alone, more once the cannon bends.

## Phase 1 — the pastern

In the air and on the ground, each hoof stays within 3 cm of its
cannon tip. A planted hoof stays at contact height 0.053. An airborne
hoof stays up with the cannon, not left behind at the clip's IK
target and not dragged down to the sand.

Do it in `bascule.gd`, on the IK root, after the cannon bend. The
plant you already have pins a grounded hoof's height. This phase is
the length of the pastern. Do not flatten the cannon bend to hide
the gap. The crest numbers above have to survive a probe.

Three clocks. If they hold, one style course:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear, B refused fence 1 with 0 rails and no `Gallop_Jump`, C one
rail on fence 3 in the air. The chip's pastern is held to the same
3 cm. A refusal's hind hooves stay on the sand from 0.25 s, and the
fore pastern does not stretch while the forehand is up.

## Phase 2 — the rein clears the neck

One rein a side. Two segments: bit ring to a point on the crest,
crest to the glove that is already there. The crest point rides a
neck bone (`Neck1` or the bone you measure), not her hand and not
a new bridle.

Clearance is against the neck mesh, not the bone centreline. Last
night the rod's closest approach to the Neck1→Head centreline was
0.009–0.056 m while the mesh is 0.10–0.28 m wide, which is why it
was inside. After the fix, every sample below is at least 1 cm
outside the mesh:

- canter
- clear jump u 0.20, 0.55, 0.85, 1.00
- 0.15 s and 0.40 s after the land
- refusal at 0.10, 0.25, 0.50 s

The two segments together stay within a hand (10 cm) of last night's
canter length, 1.357 m left and 1.356 m right. A rein that doubles
back on itself is slack. Her fists do not move to make this true.

If you cannot clear the mesh without moving her hands or adding a
bridle, revert the rein and write the clearance you got. The pastern
stays.

Three clocks again. Style again only if a segment crosses the neck
on the chip or the refusal in the probe.

## The board, once

One full `python tools/content_factory/run_ridecert.py`. Render with
`python tools/content_factory/board_table.py`. The 21 within 0.1 s
of the board at the top of `dist/STATUS.md`, no new rail,
`teleported=false`. Style A clear, B refused fence 1, C one rail in
the air. Headless `--playtest`: clear 0 / refuse 4 / rail 4.

If the board moves, revert this prompt's files. Last night's hoof
plant and the crest are the floor.

Write the gap before and after, the rein clearance, and the three
clocks at the top of `dist/STATUS.md`. Do not start a 23/23 attempt.
A pastern longer than the cannon is not a leg. A rein inside the
neck is not a rein.
