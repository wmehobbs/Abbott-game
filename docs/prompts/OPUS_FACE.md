# Opus — she faces his ears

You are in `E:\Workspace\Madison`. This is one job. Do not add a
new pose channel. Do not write `dist/STATUS.md` and quit until
you have printed which way her nose points, the kept picture
still holds, and the three clocks have been ridden on this tree.

The hips are kept. Canter `hip_x` is 5.54° / 9.09°, trot
10.58° / 14.27°, walk 4.53° / 8.16°. The lines stay:

- canter: `hip_x += rock * 22.0 * unrest`
- trot: `hip_x += swing * 18.0 * trot_unrest`
- walk: `hip_x += w * 12.0 * walk_unrest`
- `post * 32` untouched

The elbows stay `SHOULDER_GIVE := [0.0, 12.0, 12.0, 12.0]`. The
three nod lines stay (walk 26, trot 48, canter 64). Do not
retune any of them.

What is not in that board: the mounted mesh is yawed 180° in
`person_look.gd` `_mount_mesh`, and `rider_mesh.gd` poses her
left side at body `-X` (`[["L", -1.0], ["R", 1.0]]`). The glb
faces `+Z`. The horse and the seat face `-Z`. Without the yaw
she looks at the tail. Ernie opened a lesson and saw her facing
backwards. This job proves the yaw, on this tree, headless.

Do not launch a window. Do not export. Do not edit `ride_ai.gd`.
Do not move a fence. Do not chase 23/23. Do not launch
`dist\Abbott.exe`. The hair, the late fist, the straight rein,
and the five `hk_adv_002` landings stay written negatives.

## Silent

Ernie is at the machine. A Godot window locks the desktop.
`--headless` is the first argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`. No
windowed exe, no editor, no F5, no `--artshot`, no `ride_ids.py`.
One Godot. Timeouts: one id 8 minutes, a style id 15 minutes,
the full board 70 minutes. No `RIDECERT round` in 2 minutes is
a compile error: kill only that process. If the wrapper dies
for memory, wait for the Godot it already started. Do not start
a second board.

`run_ridecert.py` opens the log with `"w"`. Copy each
`RIDECERT hk_…` line out before the next id. A probe is inserted
once and stripped before a timed ride. Do not leave one in the
tree. No Godot is running now.

## What to print

One throwaway scene, then delete it. Pin horse, canter, one
settled stride. Also the halt, one second, because that is
what a lesson shows first.

Her nose is the head bone's forward. Find which local axis of
`Head` points out of her face (the face is the side the eyes
and the nose mesh sit on; if you cannot tell, say so and use
the axis that is not the neck and not the crown). Print the
dot of that direction with the horse's forward, `-basis.z`,
flattened on Y. Positive means she looks the way he is going.
Negative means she still looks at the tail.

Also print, pin and day-one, one stride of walk, trot, and
canter, the rows you already know:

- helmet pitch against her shoulders
- elbow peak-to-peak, both arms
- `hip_x` peak-to-peak
- wrist travel
- lowest hoof

Write them in `dist/face_002.md`.

She is facing the right way only if that dot is positive at
the halt and at the canter. The kept picture still has to
read: nods about 2.3° / 5.8° walk, 3.7° / 8.4° trot, 2.9° /
7.5° canter; elbows about 4.5° / 5.2° more on day-one; hips
about 3.6° more on day-one at each gait; hoof 0.052–0.053.

## If she still looks at the tail

One correction, not a search. The yaw is 180 or it is 0. Do
not try 90. If the dot is negative, the yaw is on the wrong
node or the side signs were flipped without it. Fix that one
mismatch. If the dot is positive but her left hand is on the
right side of the neck, flip only the side signs back, and
leave the yaw.

One attempt. Then print the dot and the rows again.

## Clocks

The yaw was not in the hip board. Ride the three pins after
the picture is right:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The hip board is the
floor: 18.54 / 91.59 / 94.00. Outside the window, revert the
yaw and the side-sign flip together. The hips, the elbows,
and the nods stay.

If the clocks hold, style once:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds at 0.053,
Neck1 around +11.7, Tail1 around −0.3. C one rail on fence 3
in the air (`jumping=true`). Copy the knock line.

One full `python tools/content_factory/run_ridecert.py`.
Render with `python tools/content_factory/board_table.py`.
The 21 within 0.1 s of the board in `dist/hip_002.md`, no
new rail, `teleported=false`. Headless `--playtest`: clear
0 / refuse 4 / rail 4. Copy the five `PLAYTEST` lines into
`dist/face_002.md` after the board line is copied.

If you reverted the yaw, do not run the board. The hip 21/23
still stands, and say that she still faces the tail.

## Write it

Top of `dist/STATUS.md`: the nose dot at the halt and at the
canter, whether the kept rows still held, and the three
clocks. A job that only repeats the hip table is not this job.
