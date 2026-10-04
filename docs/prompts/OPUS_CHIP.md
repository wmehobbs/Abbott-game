# Opus — close the bascule, then the chip

You are in `E:\Workspace\Madison`. The bascule is already in the tree
(`game/scripts/bascule.gd`, the jump look in `horse.gd`, the crest anchor
in `rider_mesh.gd`). A full `--ridecert` was started and may still be
running. 21/23 is the board. The two Mini Prix clocks stay closed.
Do not edit `ride_ai.gd`. Do not move a fence. Do not export.

## Silent

Ernie is at the machine. A Godot window or `dist\Abbott.exe` locks the
desktop. That is a failed run.

`--headless` is the first argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides go through `python tools/content_factory/run_ridecert.py`.
Do not run the windowed exe, the editor, F5, F6, `--artshot`,
`ride_ids.py`, or `dist\Abbott.exe`.

**One Godot.** If one is already running, that is the board. Do not
taskkill it. Do not start another. Sit until `dist/ridecert_godot.log`
contains `RIDECERT done`. Read the log. Do not guess from a partial file.

## Gate — the board already in flight

When that run finishes, render it with
`python tools/content_factory/board_table.py`. Compare to the kept 21/23
in `dist/STATUS.md` (001 at 91.6, 003 at 94.0, both 0 rails, the other 21
clear). Keep the bascule only if every time is within 0.1 s, no new rail,
`teleported=false`, and style on `hk_beg_035` is still A clear, B a refusal
at fence 1, C one rail.

Then `--playtest`, headless: clear 0 / refuse 4 / rail 4.

If the board moved, revert `bascule.gd`, the jump-look and `_air_sounds`
edits in `horse.gd`, and the crest-anchor edits in `rider_mesh.gd`.
Write that in `dist/STATUS.md`. Stop. Do not start the chip.

If it held, append the table and the three clocks (18.53, 91.60, 94.00)
to `dist/STATUS.md`. The seesaw is gone. That part is done.

## The lie that is left

A rail and a refusal currently get the same round back as a clear.
`will_rail` is set before the jump and the pole comes down in the knock
window that already exists (`u` 0.42–0.62). The spine in `bascule.gd`
does not read it, so a chip still crests. A refusal never leaves the
ground (`_do_refuse`, `jumping` stays false) and still has to read as a
check: forehand up, hind legs under, no jump clip.

You may edit only:

- `game/scripts/bascule.gd` — when `horse.will_rail`, do not round the
  back. A chip is flat: neck a little up, fore cannons not folded into
  a crest, nothing left at the land.
- `game/scripts/horse.gd` — the refusal pose only. Not `_process_jump`'s
  lerp, not `land_d`, not the knock window, not `land_recover` 2.72,
  not leave windows, not `TAKEOFF`, not `GAIT_SPEED`.
- `game/scripts/rider_mesh.gd` — her hip follows the check and the chip.
  Hands stay on the crest on a clear. On a refusal they stay with the
  neck and do not shoot forward into a release she did not make.

Do not add an AnimationPlayer. Do not write `global_position`. Do not
rebuild the skeleton every frame. Madison stays on `Torso`.

## What the three rides must show

Probe prints at four values of `u`, then strip them before the timed
rides. A print every frame moves the clock.

| | u 0.20 | u 0.55 | u 0.85 |
| --- | --- | --- | --- |
| clear | neck starting up | back round, the crest you already kept | opening, fore cannon down |
| chip (`will_rail`) | no round yet | still no crest — flatter than the clear by a margin you print | pole already down, spine quiet |
| refusal | not a jump. No `Gallop_Jump` crest at all. | | |

The clear column has to stay the bascule you just kept. Flattening both
is a revert.

## How it survives

One Godot at a time, after the board gate is done.

1. `python tools/content_factory/run_ridecert.py --ridecert-id=hk_les_001`
2. `--ridecert-id=hk_adv_001`
3. `--ridecert-id=hk_adv_003`
4. `python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

Keep it only if the three clocks are within 0.05 s of 18.53 / 91.60 /
94.00, same faults, 0 rails, and style is still A clear, B refused
fence 1, C one rail in the air. Then headless `--playtest`: clear 0 /
refuse 4 / rail 4.

If a clock moves or style B jumps the fence or style C misses the rail,
revert this phase. The bascule on a clear stays.

Write the samples and the four results at the top of `dist/STATUS.md`.
Do not export. Do not start another system. A chip that rounds like a
clear is a lie. A check that plays the jump is a lie. The clock not
noticing is the whole constraint.
