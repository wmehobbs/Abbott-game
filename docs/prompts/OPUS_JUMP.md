# Opus — the bascule

You are in `E:\Workspace\Madison`. Hidden K, Pfafftown. One horse, one ring.
The two Mini Prix clocks are closed. 21/23 stands. Do not reopen them.

A person jumps this horse and the whole body tips on one pivot. That is a
seesaw. A bascule is a spine: forehand up, back round, neck out, hind legs
following, then the forehand down and her seat closing. Same arc he already
jumps. The root does not move.

## Silent

Ernie is at the machine, in other windows. A Godot window or `dist\Abbott.exe`
locks the desktop. That is a failed run. Headless only.

One binary. `--headless` is the first argument after it. If it is not, do
not run the command.

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides go through `python tools/content_factory/run_ridecert.py`. One id:
`python tools/content_factory/run_ridecert.py --ridecert-id=hk_les_001`.
Playtest is the same exe, `--headless` first, then `--path game -- --playtest`.

Do not run the windowed exe, the editor, F5, F6, `--artshot`, `ride_ids.py`,
or `dist\Abbott.exe`. One Godot at a time. If one is already running, sit.
If a window appears, close it and do not retry that command.

## Frozen

Do not edit `ride_ai.gd`. Do not edit course JSON, either tree. Do not edit
`ride_cert.gd` or the pin 85/80/44/38/36. Do not edit `game_state.gd`.
Do not export.

In `horse.gd`, these stay byte-for-byte:

- `_process_jump` — the lerp, `jump_apex`, `jump_dur`, `jump_land`, the knock
  test at `u` 0.42–0.62, `land_recover = 2.72`, the speed he lands with
- `_begin_jump` / `_begin_schooling_jump` — `land_d`, the clip you start
- leave windows, `TAKEOFF` 2.55, `collect_pulse`, `GAIT_SPEED`, turn rate
- when `note_jumped` fires

`Gallop_Jump` keeps playing. Do not add a second AnimationPlayer. Do not
rebuild the skeleton every frame. Do not write `global_position` on the
rider or the hip. Both of those moved the cert by ~0.2 s last time and
were reverted. Madison stays parented to the mid-back (`Torso` / `Torso2` /
`Back`). Posing `Neck*` for the jump is allowed. Parenting her to a neck
bone is not.

## What is there now

`_animate`, while `jumping`, sets `visual.rotation.x` from 0 to −0.30 to
0.12 to 0.36 and returns. The whole horse, saddle, and girl rotate as one
board. `_update_rider` snaps her through three poses at u 0.40 and 0.70.
`rider_mesh.gd` copies those pivot angles onto the Quaternius girl. Her
hands are IK'd to a fixed point on the body, so a neck that reaches will
leave the fists in the air unless you move the target onto the crest.

WhiteHorse bones already in the tree include `Torso`, `Torso2`, `Neck1`,
`Head`, `FrontLowerLeg.L`, `BackLowerLeg.L`, `Tail1`. Read the skeleton
before you invent names. `game/tools/inspect_whitehorse.gd` and
`diag_playable.gd` exist. Run them headless or not at all.

## Step 0 — measure, then the clip

Before any edit, ride these three, headless, one at a time. Write the
times down. If they are not these, stop and say what the tree actually did.

| id | time | faults | rails |
| --- | ---: | ---: | --- |
| hk_les_001 | 18.54 | 0 | 0 |
| hk_adv_001 | 91.59 | 2 | 0 |
| hk_adv_003 | 93.99 | 3 | 0 |

Then sample `Gallop_Jump` at 0, 0.25, 0.5, 0.75, 1 of its own length.
Print neck, spine, one fore cannon, one hind cannon, against rest. Four
lines. If the clip already rounds the back, your job is to stop the rigid
tilt from hiding it, and to keep the girl on that spine. If the clip is a
flat gallop, add the bascule as bone pose on top of the clip and clear it
when he lands so the canter does not inherit it.

Strip the probe before any timed ride. A print every frame moves the clock.

## The shape

One jump, four samples of bone pose, printed once from a headless
`hk_les_001` and then removed before the timed rides. Angles are relative
to rest, in degrees. Name the bones you actually found.

| u | spine | neck | fore cannon | hind cannon | her hip |
| --- | --- | --- | --- | --- | --- |
| 0.20 | still long | starting up | reaching | driving | closing into two-point |
| 0.55 | round, the crest of it | out and down | folded | trailing | with the back, hands on the crest |
| 0.85 | opening | out | down, toward the sand | coming under | seat returning |
| 1.00 | the land pose he already has (`want_x` 0.16) | quiet | down | under | sitting, not popped |

u 0.55 must not look like u 0.20. A single pose held through the air is
the seesaw with different numbers. The root `global_position` at those
same four samples stays on the parabola `_process_jump` already writes.
Record it. If the root moved, revert.

Her fists stay on the crest at u 0.55, both sides, within about a hand of
where they sit at the canter. A fist in the air is a miss. Heel stays
down. Knee stays on the roll. No second skeleton.

## How a phase survives

After the shape is in, strip every probe print. Ride the same three ids.
Keep the phase only if all three are within **0.05 s** of the Step 0
times, same faults, 0 rails, `teleported=false`, rounds complete. This
change does not touch the ride. A bigger drift means the root moved or
the skeleton is being rebuilt. Revert the phase.

Order. Do not start the next until the three rides have kept this one.

1. **Horse.** The spine, on the clip or on top of it. Kill the rigid
   `visual.rotation.x` seesaw, or reduce it to something a back can still
   bend around. The four samples above, for the horse columns.
2. **Girl.** One fold through the same u, not three snaps. Hands on the
   crest after the neck moves. `rider_mesh.gd` may copy new angles. It
   may not grow an AnimationPlayer or write a world position.
3. **Land.** He arrives at the land pose. He does not pop to it on the
   frame `jumping` goes false. `land_recover` stays 2.72 s. Camera may
   dip with that pose. It may not change FOV targets, the last-stride
   look, or anything in `_try_leave`.
4. **Sound.** Grunt when the forehand actually leaves, land when the fore
   cannon reaches the sand, rail only inside the knock window that already
   exists. Same files in `assets/audio`. No new recordings.

## When to revert

- Any of the three clocks moves more than 0.05 s, or gains a rail, or
  fails to finish
- The root leaves the parabola
- Fists leave the crest
- The canter after the land is still holding jump bones
- You changed a frozen function to buy the pose

Revert that phase to the bytes you started it from. Do not stack the next
phase on a revert. If phase 1 will not hold the clock, stop. Write the
samples and the three times in `dist/STATUS.md`. A seesaw that keeps
91.59 is the horse. A bascule that changes it is not.

## After phase 4 holds

One full `--ridecert`. Not two. Render with
`python tools/content_factory/board_table.py`. The 21 stay within 0.1 s,
no new rail, `teleported=false`. Style is not required again unless a
time moved. `--playtest` stays clear 0 / refuse 4 / rail 4.

If the board moves, revert every file this prompt touched and say so.
Do not export. Do not plant a tree, move a fence, or edit `ride_ai.gd`.
Append the three clocks and the four bone samples to `dist/STATUS.md`.

The round sings when the same parabola has a spine, and the clock does
not notice.
