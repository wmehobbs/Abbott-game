# Opus — her elbow opens again

You are in `E:\Workspace\Madison`. This is one attempt. Do not
write `dist/STATUS.md` and quit until the elbow rows are printed
again, kept or a written negative, and the three clocks have
been ridden if you kept the attempt.

She faces his ears. The nose dot is +1.000 at the halt and at
the canter. Her hips sit on the seat point. That stays.
`visual.position = -(visual.basis * hip)` stays. The yaw stays.
The side signs stay. The fist target
`Vector3(side * 0.05, 0.09, -0.22)` stays. Do not pull it.

What is short, from `dist/face_002.md`. With her hips on the
seat her elbows rest at 130.0° / 134.2° and open **2.83° (L) /
3.02° (R)** more on day-one. Before the yaw, at 145.6° / 150.4°,
the same `SHOULDER_GIVE` of 12 opened them 4.51° / 5.15°. A
more bent elbow turns less for the same shoulder give. The
fists are on the targets, with 3.3 / 2.8 cm of reach to spare.
Nods, hips, hand travel, heels, and the hoof held. The clocks
on this tree are 18.54 / 91.61 / 93.99.

One change. `SHOULDER_GIVE` is `[0.0, 12.0, 12.0, 12.0]`. The
halt entry stays 0. Raise the other three together, one
number, from the rate you already measured: at 130° the give
buys about 70 % of the swing it bought at 145.6°, and 12 ×
(4.5 / 2.83) is about 19. Pick that one number. Do not tune
the walk, the trot, and the canter apart. Do not touch the
nod lines or the hip lines.

Do not export. Do not edit `ride_ai.gd`. Do not move a fence.
Do not chase 23/23. Do not launch `dist\Abbott.exe`. The hair,
the late fist, the straight rein, and the five `hk_adv_002`
landings stay written negatives.

## Silent

Ernie is at the machine. A Godot window locks the desktop.
`--headless` is the first argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`.
No window, no editor, no F5, no `--artshot`, no `ride_ids.py`.
One Godot. Timeouts: one id 8 minutes, a style id 15 minutes,
the full board 70 minutes. No `RIDECERT round` in 2 minutes is
a compile error: kill only that process. If the wrapper dies
for memory, wait for the Godot it already started. Do not
start a second board.

`run_ridecert.py` opens the log with `"w"`. Copy each
`RIDECERT hk_…` line out before the next id. A probe is
inserted once and stripped. Do not leave one in the tree.
No Godot is running now.

## After the one number

The same throwaway scene, deleted after. Pin and day-one,
walk, trot, and canter.

- nose dot still +1 at the halt and the canter
- hips still on the seat point
- fists within 1 cm of the target, and
  shoulder-to-target still inside the reach
- elbow peak-to-peak at least 4° more on day-one than on
  the pin, both arms, at each gait
- nods still about 2.30 / 5.85, 3.67 / 8.39, 2.86 / 7.50
- hips still about 3.6° more on day-one at each gait
- wrist travel still about 0.029 / 0.056, 0.055 / 0.081,
  0.078 / 0.102
- lowest hoof 0.052–0.053

If the elbows do not gain 4° on both arms without the fists
leaving the target, revert `SHOULDER_GIVE` to 12. That short
row is then the negative. Do not try a second number.

## Clocks

Only if the 4° held:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The face board is the
floor: 18.54 / 91.61 / 93.99. Outside the window, revert
the give to 12. The yaw and the seat stay.

Style once:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds at 0.053,
Neck1 around +11.7, Tail1 around −0.3. C one rail on fence
3 in the air (`jumping=true`). Copy the knock line.

One full `python tools/content_factory/run_ridecert.py`.
Render with `python tools/content_factory/board_table.py`.
The 21 within 0.1 s of `dist/face_002.md`, no new rail,
`teleported=false`. Headless `--playtest`: clear 0 / refuse
4 / rail 4. Copy the five `PLAYTEST` lines into
`dist/give_002.md` after the board line.

If you reverted the give, do not run the board. The face
21/23 still stands.

## Write it

Top of `dist/STATUS.md`: the elbow rows before and after,
the one number you used, and the three clocks if you rode
them. A job that moves the fist target is not this job. A
job that turns her back toward the tail is not this job.
