# Opus — finish the tail, then her head

You are in `E:\Workspace\Madison`. Step 0 is already in
`dist/tail_002.md`. The hair bends are already in `bascule.gd`
(`WORRY_HAIR`, `_tail_hang`). This job finishes that work. It
does not start a new picture, and it does not tune the hair a
second time.

One Godot is already riding. `dist/ridecert_godot.log` is
`--ridecert-id=hk_adv_001` and was on fence 8 at about 51 s.
That is the one process. Do not launch another. Do not kill it.
Do not edit a script while it is running. Wait until that log
has a `RIDECERT hk_adv_001` line and the process has exited.

`--headless` stays the first argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`. No
window, no editor, no F5, no `--artshot`, no `ride_ids.py`, no
`dist\Abbott.exe`. One Godot. Timeouts: one id 8 minutes, a fresh
id 12 minutes, a style id 15 minutes, the full board 70 minutes.
No `RIDECERT round` in 2 minutes is a compile error: kill only
that process. The wrapper opens the log with `"w"`. Copy each
`RIDECERT hk_…` line into `dist/tail_002.md` before the next id.

## What step 0 already proved

`dist/tail_002.md`, before the hair bends:

| gait | Tail7 tip, pin / day-one | head travel, pin / day-one |
| --- | --- | --- |
| walk | −0.465 / −0.414 (5.1 cm) | 0.040 / 0.076 (3.6 cm) |
| trot | −0.465 / −0.414 (5.1 cm) | 0.101 / 0.100 (0.1 cm) |
| canter | +0.131 / +0.264 (13.3 cm) | 0.109 / 0.145 |

Tail1 is 9.9° apart. Both walk and trot tips hang below the
withers. Her helmet already moves at the walk. It does not move
more at the trot. Phase 2 is the trot only. Do not add a head
term to the walk.

The 14.7 cm sentence is not in `dist/tail_002.md`. Append the
six rows from the scene you already measured, under "after the
hair," with Tail7 tip, Tail7-to-hip, Tail1, Neck1, and the
lowest hoof. If you did not save them, measure that scene once
more after the clocks, and only if the clocks held. Do not
change `WORRY_HAIR` to chase a centimetre.

The keep you are aiming at, from that same scene:

- walk tip and trot tip at least 8 cm higher on day-one than
  on the pin
- those day-one tips still at least 10 cm from her hip
- canter tips within 4 cm of +0.131 and +0.264
- Tail1 still about 9.9° apart, Neck1 still about 9.9°
- lowest hoof still 0.052–0.053
- the pin's tail unchanged, because his worry is 0

If the appended rows miss any of those, the hair is a negative.
Revert `WORRY_HAIR` and `_tail_hang`. Do not try a second set
of angles.

## The three clocks

`hk_adv_001` is the run already going. The keep is 91.51–91.67,
2 faults, 0 rails, teleported=false, complete.

`hk_les_001` and `hk_adv_003` are not in this log. Ride them
after 001 exits, one at a time, pin rides. Copy each line.

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

Outside the window: revert only the hair (`WORRY_HAIR` and
`_tail_hang`). Tail1, the neck, the ears, the hand terms, and
the canter branch stay. Ride the three ids again on that
reverted tree. One miss after the revert ends the phase.

## Phase 2 — her head at the trot

Only if the clocks held and the hair rows held.

`head_x` on gait 2 only, a share of `_hand_unrest()` on the
stride, on top of the post. Do not touch gait 1. Do not touch
gait 3. Do not multiply the posting constants. Her hands at the
trot stay within 0.5 cm of the kept difference (0.055 pin,
0.081 day-one). Her walk head travel stays about 3.6 cm. The
trot head travel has to differ by at least 2 cm.

One attempt. If the hands move, or the walk head changes by
more than 0.5 cm, revert the head term. The hair stays.

Three clocks if you kept the head term.

## Phase 3 — coming back to himself

Worry is supposed to return over the first 0.5 s of
`land_recover`. Print it. Fence 1 of pin `hk_les_001` and of
fresh `hk_les_001`: Neck1 and the Tail7 tip at touchdown, at
0.25 s, and at 0.50 s.

If day-one's neck is at least 8° higher than the pin's by
0.50 s, and his tip is at least 8 cm higher, write the rows.
Do not code.

If the land pose holds both necks together through that half
second, one attempt in `bascule.gd`: the worry that already
exists may come back on the neck and the tail. It may not
change `LAND_X`, `_place_cam`, the crest, or the hoof plant.
The pin's check stays Neck1 around +11.7 and Tail1 around
−0.3. Two fails: the recover is a negative.

Three clocks if you touched code.

## Then the pin, once

Style, once, on the tree you are keeping:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds at 0.053,
Neck1 around +11.7, Tail1 around −0.3, and his tail tip is
not the day-one hair. C one rail on fence 3 in the air
(`jumping=true`).

One full `python tools/content_factory/run_ridecert.py` if
any phase of this prompt kept code. Render with
`python tools/content_factory/board_table.py`. The 21 within
0.1 s of the board in `dist/hands_002.md`, no new rail,
`teleported=false`. Headless `--playtest`: clear 0 / refuse 4 /
rail 4. Copy the `PLAYTEST done` line into `dist/tail_002.md`.

If the hair was reverted and the head was not kept, do not
run the board. The 21/23 log still stands.

## Write it

Top of `dist/STATUS.md`: the tip rows before and after, the
three clocks you copied, the trot head if you measured it, and
the recover samples. The 14.7 cm figure counts only when it
is a row in `dist/tail_002.md`. A job that stops while
`hk_adv_001` is still on fence 8 is not this job.
