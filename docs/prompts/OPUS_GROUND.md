# Opus — the hooves meet the sand

You are in `E:\Workspace\Madison`. This is an unattended night. Ernie is
asleep. Finish every phase you can. Do not stop after the first one.

The bascule and the chip are kept. Board is 21/23. The two Mini Prix fail
on time only, and that is closed. Do not edit `ride_ai.gd`. Do not move a
fence. Do not export. Do not launch `dist\Abbott.exe`.

What is still wrong, in his own note: in the landing pose the forehand
sits up, so just after the root touches, the front hooves float about
10 cm above the sand. A planted canter hoof reads about 0.11 m. The land
pose reads about 0.21 m. The thud was timed to the bottom of that float.
The float is the bug. The sand is the job.

## Silent

A Godot window locks the desktop. Headless only. `--headless` is the
first argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides go through `python tools/content_factory/run_ridecert.py`.
Do not run the windowed exe, the editor, F5, F6, `--artshot`, or
`ride_ids.py`.

One Godot. If one is already running and `dist/ridecert_godot.log` is
still growing, wait for `RIDECERT done`. If a Godot is running and the
log has not grown for ten minutes, it is the hung probe from earlier:
kill only that process, then start. Never two.

Every launch needs a timeout. One id: 8 minutes. A style id: 15 minutes.
The full board at the end: 70 minutes. If `RIDECERT round` has not
appeared within 2 minutes, it is a compile error. Kill only that
process, read the error, fix it, do not leave it running. A hung Godot
is a failed night even if the pose is right.

## Frozen

These stay byte-for-byte:

- `_process_jump` — the lerp, apex, duration, landing point, the knock
  test at u 0.42–0.62, `land_recover = 2.72`, the speed he lands with
- `_begin_jump` / `_begin_schooling_jump` — `land_d`
- leave windows, `TAKEOFF` 2.55, `collect_pulse`, `GAIT_SPEED`,
  `STRIDE_HZ`, turn rate
- `ride_ai.gd`, course JSON both trees, `ride_cert.gd`, `game_state.gd`
- the clear crest at u 0.55: round about +15°, Neck1 about −21° out and
  down, fore cannon folded. A chip at u 0.55 stays about 15° flatter,
  neck a little up, forelegs hanging. Do not flatten the clear to fix
  the land.

You may change the land pose. `visual.rotation.x = 0.16 * smoothstep(...)`
on the way down is the tilt that holds the forehand up. It is no longer
protected. Bone pose on the way down and in the first strides after is
allowed. The root `global_position` stays on the parabola. No second
AnimationPlayer. No skeleton rebuild every frame. No `global_position`
on the rider. Madison stays on `Torso`.

`hk_les_001` already wanders 18.53–18.56 on an unchanged tree. A keep is:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

Same finish, `teleported=false`. Anything outside that is a revert of
the phase you just wrote. Two fails on the same phase: revert it, write
why, and go to the next phase. Do not spend the night on one number.

## Step 0 — measure, then strip

One headless `hk_les_001`. Print, for the first jump and the first
canter strides after it, the world Y of each hoof bone. Fore feet are
`FF.L` and `FF.R` (`_fore_low` already uses them). Find the hind hoof
bones the same way. Do not invent names.

Record, in meters:

- canter, the low point of the striking hoof on three beats, and the
  other three hooves at that same frame
- the jump at u 0.20, 0.55, 0.85, 1.00, and 0.15 s after the root lands
- which hoof is lowest at the thud

Strip the probe before any timed ride. A print every frame moves the
clock. The canter low point is the contact height for the rest of the
night. The land is wrong by the gap between that and the hoof at the
thud.

Also sample one walk stride and one trot stride on the same round
(she walks to the flags, then trots). Same four hooves. If a gait
already meets the contact height on the beat, say so and do not
rewrite that gait.

## Phase 1 — the land meets the sand

Fore hooves at the thud within 2 cm of the canter contact height.
Both of them, not the average. Hind hooves may still be coming down
at that frame; by 0.4 s into `land_recover` they are in the canter
pattern, striking hoof at contact height.

The crest at u 0.55 does not change. The root does not change.
Nothing pops on the frame `jumping` goes false: the pose he has at
u 1.00 is the pose he has on the next frame.

Retimed thud: it plays when a fore hoof reaches contact height, not
when a floating hoof stops falling at 0.21 m. Same `land` file.
Grunt stays when the last fore hoof leaves. Rail stays in the knock
window.

Three clocks. Then the next phase.

## Phase 2 — the striking hoof

Walk four beats, trot two, canter three. On the frame `_hoof_strike`
fires, the hoof that beat belongs to is at contact height, and at
least one other hoof is clearly up (more than 4 cm). A beat where
all four are on the ground is a miss. A beat where the sound fires
and every hoof is in the air is a miss.

Do this with bone pose on top of the clip, the way `bascule.gd` bends
on top of `Gallop_Jump`, and clear it so the jump does not inherit a
gait correction. Do not change `STRIDE_HZ` or `GAIT_SPEED`. The trot
already seeks the Walk clip onto the post; leave that seek unless the
measurement shows a diagonal that never reaches, and if you move it
the three clocks still have to keep.

If Step 0 showed the three gaits already hit, write the numbers and
skip to phase 3. Do not repaint a hoof that already lands.

Three clocks.

## Phase 3 — the chip and the check

Style, one course, after the clocks from phase 2 are a keep:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

- A clear. The crest is the one you kept. Fore hooves meet the sand
  on the land, same 2 cm.
- B refused fence 1, 4 faults, 0 rails. He never plays `Gallop_Jump`.
  While the forehand is up, both hind hooves stay at contact height.
  A refusal that lifts all four feet is a rear, not a check. Her
  fists stay with the neck and do not go forward of the canter spot.
- C one rail on fence 3, knocked in the air (`jumping=true`). At
  u 0.55 the back is still about 15° flatter than the clear. When
  he lands the chip, the fore hooves still meet the sand.

If B jumps the fence or C misses the rail, revert phase 3 only.
The land from phase 1 stays.

## Phase 4 — the reins

`_update_reins` already draws a rod from `BitL`/`BitR` to
`LGlove`/`RGlove`. Measure those two lengths through a clear jump
(u 0.20, 0.55, 0.85, 1.00), through the land, and on the refusal.
A rein that passes through the neck, or that goes slack by more than
a hand (about 10 cm shorter than its canter length), gets fixed.
Same rods. No second bridle. If both reins stay within a hand of the
canter length and miss the neck, write the lengths and move on.

Her fists stay on the withers within 0.02 m through the new land.
Heel down, knee on the roll. If dropping the forehand left her hands
in the air, that is this phase, in `rider_mesh.gd`.

Three clocks. Style again only if you touched the chip or the check.

## Phase 5 — the board, once

One full `python tools/content_factory/run_ridecert.py`. Not two.
Render with `python tools/content_factory/board_table.py`.
The 21 stay within 0.1 s of the board in `dist/STATUS.md`, no new
rail, `teleported=false`. Style on `hk_beg_035` still A clear, B
refused fence 1, C one rail in the air. Headless `--playtest`:
clear 0 / refuse 4 / rail 4.

If the board moves, revert every file this prompt touched and say
which phase did it. The bascule and the chip from before this prompt
are the floor you revert to, not the seesaw.

## Write it down

Top of `dist/STATUS.md`, from the tool and from the probe you
stripped, not from memory:

- contact height, and the land hoof Y before and after
- the four hoof lows on one beat of walk, trot, and canter
- rein lengths if you measured them
- the three clocks after the last keep
- the board table

Do not plant a tree, add a sentence for Michelle, or start a 23/23
attempt. A hoof in the air at the thud is not a landing. A clock
that moved is not a landing either.
