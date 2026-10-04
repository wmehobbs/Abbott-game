# Opus — look at the fence he is jumping

You are in `E:\Workspace\Madison`. The gait-change beat is kept. The
rein is one straight rod, and it stays that way. The pastern, the
crest, and the chip stay. Board is 21/23. Do not edit `ride_ai.gd`.
Do not move a fence. Do not export. Do not launch `dist\Abbott.exe`.
Do not add a rein segment.

On the approach, the camera looks at the face of the next fence, blend
capped at 0.88, aimed about 0.85 m up. The moment `jumping` is true,
that look is replaced: an extra 1.86 m along his heading, plus a
fraction of `jump_apex`. He leaves the ground looking past the fence.
The job is to look at the fence he is actually over, and to come back
to the old look without a pop when he lands.

## Silent

Ernie is at the machine. `--headless` is the first argument after the
console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`. No
windowed exe, no editor, no F5, no `--artshot`, no `ride_ids.py`.
One Godot. One id, 8 minutes. No `RIDECERT round` in 2 minutes is a
compile error: kill only that process. No full board. This does not
move the horse, and a board is how the wrapper gets killed for memory.

## Frozen

`_camera` is the only function you may change, and not all of it.

Leave these numbers alone:

- FOV: 52 canter, 48.5 collected, 50 in the air, 46 on the last stride
- the approach blend cap 0.88, and the aim at `y = 0.85` while he is
  not jumping
- `CAM_MIN_Y`
- anything outside `_camera`

Do not touch `_animate`, `_process_jump`, the beat gate, `bascule.gd`,
`_update_reins`, leave windows, `TAKEOFF`, `GAIT_SPEED`, `STRIDE_HZ`.

A keep:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`. If a clock moves, the camera is writing into the
ride. Revert `_camera` and stop.

## Step 0

One headless `hk_les_001`. On the first jump, print at u 0.20, 0.55,
0.85:

- where `cam_look` is, in meters, relative to that fence's face
  (`jump_fence.global_position`, up the face by the fence height)
- the camera's distance to the withers bone `Torso3`

Strip the probe before the timed rides. You are proving he looks past
the fence today. If he already looks at the face within about half a
metre, write that and stop. Do not invent a second camera.

## The look

While `jumping` and `jump_fence` is set, `cam_look` goes to the face
of that fence: its position, and up the face to the top rail (the
fence's own height, not a point in the dirt, not a stride past the
landing). Blend into it. Do not snap on the frame `jumping` becomes
true, and do not snap on the frame it becomes false.

Through `land_recover`, hand the look back to the look this function
already computes for the canter. The hand-back is over the start of
the recover, not a cut.

The camera stays behind the cantle and above the croup. It does not
enter the neck. Distance to `Torso3` through the jump stays at least
what Step 0 measured on the approach, minus 0.15 m. If the bascule
puts the neck into the lens, lift the camera. Do not move her fists
and do not move the horse.

Same probe, after, on the first jump of `hk_les_001`: at u 0.55 the
look is within 0.4 m of the top rail, not a stride past it. Then
strip it.

## Clocks

The three ids, one at a time. Then headless `--playtest`: clear 0 /
refuse 4 / rail 4. No style run unless you touched something besides
`_camera`. No full board.

Write the before and after look points, and the three times, at the
top of `dist/STATUS.md`. Then stop.

A look past the fence is not a distance. A camera that moves the
clock is not a camera.
