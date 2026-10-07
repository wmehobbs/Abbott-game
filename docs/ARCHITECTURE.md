# Abbott architecture

Godot 4.7.2 project in `game/`. Main scene `res://scenes/title.tscn`. Autoload `GameState` is `game/scripts/game_state.gd`. Version stays `2.348.0.0` until Ernie asks for a bump. Do not export `dist/Abbott.exe`.

The ride is one horse, one ring, Table A. Indoor is scenery. Michelle's lines are text.

## What each script owns

| Script | Owns |
| --- | --- |
| `game_state.gd` | The round, the save, unlocks, ribbons, input bindings, the voice duck, the season list. |
| `horse.gd` | Abbott: gait, the leave, the jump, the camera, hooves, the rider on his back. |
| `arena.gd` | Boots the ring, pause, restart, the lesson, and the scene changes. |
| `course.gd` | Builds the fences for the current class and seed. Start and finish flags. |
| `fence.gd` | One jump: rails, wings, the knock. Class `JumpFence`. |
| `hud.gd` | Scoreboard, pause, result card, options, the first-lesson line. |
| `title.gd` | Title buttons, the class picker, the season ladder, options. |
| `first_lesson.gd` | Fresh-save walk through walk, trot, canter, steer, whoa, half-halt, two fences. |
| `settings.gd` | `user://settings.cfg`. Not the ride save. |
| `settings_menu.gd` | Sound, picture, and key pages. |
| `farm.gd` | The ring, barn, sky, sun. Pictures live here. |
| `content_library.gd` | Reads `SHIP.json`, course files, and Michelle's lines. |
| `trainer.gd` | Fallback sentences when the content file has no line. |
| `ride_ai.gd` | The watched round and the cert rider. Do not edit. |
| `ride_cert.gd` | Headless `--ridecert` rounds. |
| `playtest.gd` | Clear, refuse, and rail rounds. |
| `selftest.gd` | Boot tests. Writes only under `user://selftest/`. |
| `walker.gd` | Course walk on foot. |
| `bascule.gd` | The jump shape on the skeleton. |
| `rider_mesh.gd`, `person_look.gd`, `abbott_look.gd`, `mesh_kit.gd` | How Madison, Michelle, and Abbott are built. |
| `shots.gd` | Windowed stills. Do not run it while someone is at the desk. |

## Key functions

Round and rules, `game_state.gd`:

- `class_unlocked` line 241. Lesson and beginner are open. Intermediate needs a posted beginner round. Advanced schooling needs a posted intermediate round. Advanced at a show needs an intermediate clear.
- `time_allowed` line 199. Schooling clock is the class `time_school` (80 for Open, not the JSON 65.6).
- `can_offer_jump_off` line 217. `finish_round` line 570. `_record_round` line 646. `_ribbon` line 676. `_school_from_round` line 611. `note_refuse` line 502.
- `save` line 930. Returns immediately for `--playtest`, `--ridecert`, `--shots`, `--selftest`, `--telemetry`, and a watched round. Writes `path.tmp`, keeps `path.bak`, then replaces the file.
- `_migrate_save` line 811. Missing keys are filled. A save with progress and no `tutorial_done` gets `tutorial_done` true so Madison is not sent through the first lesson.
- `season_rows` line 842. Lessons 1 to 4 from `SHIP.json`, then schooling and show. Locked, open, or done. It does not change the unlock rules.

The horse, `horse.gd`:

- `_process_ride` line 324. Gait keys and the stick.
- `_try_leave` line 775. The takeoff window. Do not retune it.
- `_place_cam` line 467. Field of view 52, pulled in when she collects or commits. A saved field of view slides that whole set.
- `_play_named` line 1077. Blends are 0.18 and 0.05 on the jump.

The ring, `arena.gd`:

- `_enter_ride` line 183. Mounts, resets the round, starts the first lesson when it applies.
- `_process` line 124. The round clock is `time_sec += delta` only while the clock is running and the game is not paused.
- `_retry` line 237. Fences up, clock zero, faults zero, horse at the start.

## Frozen, and why

These are the part that already rides. Changing them to "help" a clock or a picture has been tried and it makes a different game.

- Leave and jump math in `horse.gd`: `TAKEOFF` 2.55, the early, deep, chip, and ideal bands, `window_scale`, `refuse_scale`, `balance_need`, gait speeds, the 3.35 stride divisor, `_try_leave`.
- The knock box stays `(width * 0.9, height + 0.15, 0.35 + spread)`.
- Table A, time allowed, the jump-off offer, ribbons, `_school_from_round`, `_record_round`, unlocks, `note_refuse`, and the confidence, scope, rideability, and timing math.
- `ride_ai.gd`.
- Course JSON in both `game/content/courses/` and `content/courses/`. They stay byte-identical. `SHIP.json` and Michelle's ship lines too.
- `game/assets/meshes/abbott.glb` and every existing texture.
- Do not put back the old reapproach timer, pure pursuit, steering past the wing, a commit rein on any aim error, a blunt arc path check, or turn-fit scoring.

A fence you land past is not a distance.

## Where new code goes

- A new sentence from Michelle: the content line file, or `trainer.gd` if it is a fallback. One sentence, 14 words or fewer, no em dashes.
- A new menu: `hud.gd` or `title.gd`. Keep it on the dark card. The layout test must still reach every visible button at six sizes.
- A new option: `settings.gd` and `settings_menu.gd`. Tests pass their own path under `user://selftest/`. Never write `user://settings.cfg` from a test.
- A new check: `selftest.gd`. It runs inside the real boot.
- A picture: `farm.gd` only through the visual loop below. Do not guess a look from a headless run.

## How to run the checks

Godot console:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

Before every launch, `Get-Process *Godot*`. If a Godot you did not start is running, wait. Never kill it. Never run `tools/content_factory/ride_ids.py` (it kills Godots). After the run, confirm yours exited.

Headless wrappers, `--headless` first, no window:

- `python dist/day12/run_script.py res://tools/compile_check.gd <log>` compiles. 5 minute cap.
- `python dist/_run_userarg.py --selftest` boots the title and prints `SELFTEST SUMMARY`. 10 minute cap. Quit 0 only when `fail=0`.
- `python dist/_run_userarg.py --playtest` is the play gate. Pass is clear 0 faults, refuse 4, rail 4.
- `python tools/content_factory/run_ridecert.py --ridecert-fresh --ridecert-show --ridecert-jumpoff --ridecert-id <id>` is one ride. Copy `dist/ridecert_fresh.log` aside before the next id. Do not read `dist/ridecert_logs/` or treat `success=false` on a jump-off as a fault. Judge faults, the offer, and the time.

The ride gate, when the horse, camera, input, or the picture size changes: `hk_les_001` and `hk_beg_035`. Same faults, same jump-off offer and result, `teleported=false`, time within 0.10 s of T0. T0 on this tree is lesson 0 faults 25.42 offer no, beginner 0 faults 62.14 offer yes, jump-off 0 faults 33.45.

Madison's save is `C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json`. The snapshot is `dist/day12/save_snapshot.json`. Compare after every Godot run. If it changed, copy the snapshot back and fix the cause. Do not commit the snapshot.

While someone is at the desk, stay headless. No editor, no game window.

## Shots and the visual loop

`dist/day12/run_shots.py` is the only windowed path. It is for stills, not for play. The official set is `dist/day12/shots/baseline`. Do not use `baseline_v1` or `baseline_cam1`.

One change, then look. Keep it only when the still is clearly better and the GPU p95 stays within 15 percent of 3.007 ms (about 3.458). FPS near 9 with a low GPU time means the window was in the background. Use GPU time. If a shot comes back black or identical to the last one, stop windowed runs.

`python dist/day12/make_jpg.py` and `make_sheet.py` turn the pngs into a pair you can compare. Images are not committed.

## Screen size

`game/project.godot` uses stretch mode `canvas_items` and aspect `expand`, base size 1920x1080. The 3D view renders at the window size. The HUD anchors to that window. `PlayerSettings.render_scale` is the sharpness slider, 50 to 100 percent. High quality is the current look. Low turns off MSAA, SSAO, and glow. That GPU saving has not been timed, because it needs a window.

## Unused files

`python dist/day12/unused_assets.py` writes `dist/day12/unused_assets.csv`. One row per file under `game/assets`, with the size in bytes, whether a text file under `game/` or `content/` still names it, and whether an export would still pack it. A file's own `.import` sidecar does not count. The script deletes nothing. Do not delete from that list until Ernie says so.
