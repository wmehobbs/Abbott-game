# Opus — her hands can reach

You are in `E:\Workspace\Madison`. The yaw stays. She faces his
ears. This job puts her hand targets back inside her arms, then
rides the clocks on that tree. Do not revert the yaw. Do not
write the elbow as a negative.

`dist/face_002.md` already shows it. Head local +Z (brows at +Z,
hair at −Z) dots his forward at **+1.000** at the halt and at
the canter. Her left wrist is on his left. The elbows are locked
near **173°** and move 0.03° / 0.10°, because each target sits
**2.9 cm (L) / 3.7 cm (R)** past her full reach and the fists
stop 3.0 / 3.7 cm short. Nods, hips, and the hoof held.

The old freeze was: do not move her fists to fix the rein or the
late jump. This is not that. The targets are past her hands.
Bring the targets to where her hands can be.

## Silent

One Godot is already riding `--ridecert-id=hk_adv_003`, on the
come-again into fence 10. That is the straight-arm tree. Do not
launch another. Do not kill it. Do not edit a script while it
is running. Wait until that log has a `RIDECERT hk_adv_003` line
and the process has exited. Copy the line. `hk_les_001` and
`hk_adv_001` are not in this log. Ride them after, one at a
time, and copy each line. Those three clocks are the
straight-arm tree. They are not the keep. Record them in
`dist/face_002.md` and go on.

`--headless` first:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`.
No window, no editor, no F5, no `ride_ids.py`, no
`dist\Abbott.exe`. One Godot. One id 8 minutes, style 15, the
full board 70. No `RIDECERT round` in 2 minutes is a compile
error: kill only that process. If the wrapper dies for memory,
wait. Do not start a second board. The log is opened with
`"w"`. Copy each result line before the next id.

## The one move

`rider_mesh.gd`, the hand target
`Vector3(side * 0.05, 0.09, -0.22)`.

Pull both targets about 4 cm back toward her shoulders, along
the line from the target to the shoulder, the same shift on
both sides. Not a search. Not up off the neck. Not forward
into a release. The yaw, the side signs, `SHOULDER_GIVE`, the
nod lines, and the hip lines stay.

Then the same throwaway scene, deleted after. Pin and day-one,
walk, trot, canter:

- nose dot still positive at the halt and the canter
- left wrist still on his left
- shoulder-to-target minus reach is negative (the target is
  inside the arm) on both sides
- fists within 1 cm of the new target
- elbow means leave 173°. Peak-to-peak is at least 4° more on
  day-one than on the pin, both arms, at each gait, the way
  `SHOULDER_GIVE` did before the yaw (about 4.5° / 5.2°)
- nods, hips, and hoof still the face_002 rows (within 0.5°
  and the hoof at 0.052–0.053)

One attempt. If the elbows stay locked, revert only this shift
and write the centimetres. The yaw stays, and she faces his
ears with straight arms. That is then the negative. Do not
try a second offset.

## Clocks, on the reached tree

Only if the elbows came back:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The hip board is the
floor: 18.54 / 91.59 / 94.00. Outside the window, revert the
target shift. The yaw stays.

Style once:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds at 0.053,
Neck1 around +11.7, Tail1 around −0.3. C one rail on fence 3
in the air (`jumping=true`). Copy the knock line.

One full `python tools/content_factory/run_ridecert.py`.
Render with `python tools/content_factory/board_table.py`.
The 21 within 0.1 s of `dist/hip_002.md`, no new rail,
`teleported=false`. Headless `--playtest`: clear 0 / refuse 4 /
rail 4. Copy the five `PLAYTEST` lines into `dist/face_002.md`
after the board line.

## Write it

Top of `dist/STATUS.md`: the nose dot, the reach before and
after in centimetres, the elbow rows, and the three clocks of
the tree you kept. A job that leaves her arms locked is not
this job. A job that turns her back toward the tail is not
this job.
