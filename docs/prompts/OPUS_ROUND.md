# Opus — one clear round, from the saddle

You are in `E:\Workspace\Madison`. This is a long job. Do not stop
after the first keep. Do not write `dist/STATUS.md` and quit until
the twelve-fence table at the bottom exists, every row a pass or a
written negative, and the three clocks still hold.

The look is on the rail. The pastern is on the cannon. The hooves
meet the sand. The beat after a gait change waits out the blend.
The rein is still one straight rod, and it still goes through the
neck. The landing still yanks: a 0.66 m camera drop that reads as
6.3°/frame now that the look is on the rail instead of 11 m past it.
Board is 21/23. The two Mini Prix that lose on time stay lost. Do
not edit `ride_ai.gd`. Do not move a fence. Do not export. Do not
launch `dist\Abbott.exe`.

## Silent

Ernie is at the machine, in other windows. A Godot window locks the
desktop. `--headless` is the first argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`. No
windowed exe, no editor, no F5, no `--artshot`, no `ride_ids.py`.
One Godot. Timeouts: one id 8 minutes, `hk_adv_002` 12 minutes, a
style id 15 minutes, the full board 70 minutes. No `RIDECERT round`
in 2 minutes is a compile error: kill only that process. If the
wrapper dies for memory and Godot is still riding, wait. Do not
start a second board.

A probe that does not compile gets restored before the next ride.
Insert it once. `bascule.gd` comes back to the pastern you have now
when the probe comes out. Do not leave a probe in the tree.

## Frozen

- `_process_jump`, leave windows, `TAKEOFF` 2.55, `collect_pulse`,
  `GAIT_SPEED`, `STRIDE_HZ`, `land_recover` 2.72, the beat gate
- `ride_ai.gd`, both course trees, `ride_cert.gd`, `game_state.gd`
- the crest at u 0.55: round +15.0, Neck1 −21.4, fore cannon −30.2
- the chip at u 0.55: round 0.0
- fore hooves at the thud within 2 cm of 0.053
- pastern gap within 3 cm
- fists within 0.02 m of the withers
- FOV 52 / 48.5 / 50 / 46, the approach blend cap 0.88, the approach
  aim at y 0.85
- the airborne look target: the top rail of `jump_fence`. You may
  change how the camera *sits* on the landing. You may not aim the
  jump somewhere else.

A keep, after every phase that touches code:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. Outside that, revert the phase.
Two fails on one phase: write the negative and go to the next phase.
Do not spend the day on one number. The three clocks are not a
reason to skip the rest of the round.

## Step 0 — the round, before you change anything

No code until this table is on disk, in `dist/round_002.md`.

One headless `hk_adv_002`. It is a clear Mini Prix, 12 fences, about
83 s. For every fence print, then strip the probe:

| fence | look at u 0.55, metres from the top rail | landing, °/frame | fore hooves at the thud | pastern gap at u 0.55 | rein, cm inside the neck at u 0.55 | rein, cm inside at 0.40 s after the land |
| --- | --- | --- | --- | --- | --- | --- |

Look distance is to `jump_fence.global_position + (0, height, 0)`.
The neck test is the posed mesh, the same reconstruction as this
morning, signed distance, both reins, the worst of the two. A
straight rod will be inside. Write the number anyway. That table is
the job. A fix that never meets it again does not count.

## Phase 1 — the landing does not yank

The 6.3°/frame on the landing frame is `_place_cam`'s existing drop
when `land_recover > 0` (`height -= 0.62`, `look_y -= 0.42`), about
0.66 m, read against a look that is now on the rail. You may change
those two offsets, and only those, so the worst frame of the landing
on fence 1 of `hk_les_001` is no faster than that fence's approach
(this morning the approach was about 1.2°/frame and the take-off was
0.99). The look target does not move to buy this. The camera does
not enter the neck: distance to `Torso3` stays at least 5.0 m.

Three clocks. Then you are not done.

## Phase 2 — the rein lies on the neck

The fixed-point search is closed. One crest point could not clear
inside a hand of slack. Two bends cleared 35 of 36 drawn samples and
touched the neck at +0.000 on the first landing, because the land
pose moves between runs and a fixed offset cannot. Do not search
Neck2 and Torso3 again. Do not add a fourth searched point.

Build the rein every frame from the posed neck. From the bit ring,
walk the neck bones to the withers, and put each sample 1.5 cm
outside the skin along the vertex normal. Short segments of the same
leather, same radius, bit to glove. Both sides. The points move when
the neck moves, including the head nod that already stretches a
straight rein from 1.36 m to 1.64 m, and including the land.

Her fists do not move. No second bridle, no new bit.

Clearance, both reins, on the posed mesh, at least 1 cm outside, on
one `hk_les_001` and on fences 1, 6, and 12 of `hk_adv_002`:

- canter, a nodded frame
- jump u 0.20, 0.55, 0.85
- 0.40 s after the land
- and, from the style course below, the refusal at 0.25 s and the
  chip at u 0.55

If a segment is inside, the normal is wrong or the sample is too
coarse. Add samples. Do not go back to a searched offset. If you
cannot stay outside without moving her fists, revert to the straight
rod, write the worst clearance, and continue to phase 3. The landing
camera stays.

Three clocks.

## Phase 3 — the same round again

Repeat the twelve-fence table on `hk_adv_002`, probe stripped before
you call it a result. A row passes only if all of these are true:

- look at u 0.55 within 0.40 m of the top rail
- landing turn no faster than that fence's own approach
- both fore hooves within 2 cm of 0.053 at the thud
- pastern gap at u 0.55 within 3 cm
- both reins at least 1 cm outside the neck at u 0.55 and at 0.40 s
  after the land, or the rein phase was a written negative and the
  rod is the straight one

Any failing row: one fix for that class of failure, not a special
case for that fence number. Re-ride `hk_adv_002` and the three
clocks. Two fails of the same class: that class is a negative, the
other rows still have to pass.

## Phase 4 — the chip and the check, on this picture

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, no `Gallop_Jump`, hind hooves on
the sand from 0.25 s. C one rail on fence 3, in the air, chip still
flat at u 0.55. The rein, if you kept it, is outside the neck on B
and on C. The landing camera does not yank on A or on C.

If B jumps the fence or C misses the rail, revert phase 4 only.

## Phase 5 — the board, once

One full `python tools/content_factory/run_ridecert.py`. Render with
`python tools/content_factory/board_table.py`. The 21 within 0.1 s of
the board in `dist/STATUS.md`, no new rail, `teleported=false`.
Headless `--playtest`: clear 0 / refuse 4 / rail 4.

If the board moves, revert this prompt's files back to this morning's
look, the straight rein, and the pastern. Do not revert the beat gate.

## Write it

Top of `dist/STATUS.md`: the three clocks, whether the rein is a
strip or still a rod, the landing °/frame before and after, and the
twelve-fence table copied from `dist/round_002.md`. A row you did not
ride is not a row. A job that stops after the camera is not this job.
