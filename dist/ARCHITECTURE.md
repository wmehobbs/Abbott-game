# Abbott — architecture

Godot 4.7 project in `game/`. The game is named Abbott, version 2.348.0.0. The boot scene is `res://scenes/title.tscn`. The only autoload is `GameState` (`res://scripts/game_state.gd`).

There are 33 scripts in `game/scripts/`. Tools that are not part of a round live in `game/tools/` and are not in the list below. `game/tools/validate_content.gd` is the Day 16 course checker. It only writes a report.

## How a round is put together

The title is the menu. Every ride, walk, and headless check that needs the ring loads `res://scenes/arena.tscn`. `arena.gd` builds the world in code: the farm, then the course, then the horse, the walker, and the HUD. Nothing in the arena scene file is the round itself.

`GameState.mode` is `ride` or `walk`. The title sets it, then changes scene.

- **Lesson** calls `start_session("lesson", "lesson")` and enters the arena in ride mode. A fresh save with the tutorial still open gets `FirstLesson`, one line at a time. Skip ends it.
- **School Abbott** opens a class picker (`schooling`). The clock uses that class's school time.
- **Show day** opens the same picker for `show`. The clock uses the show time. His mane is braided, she wears her number, the ring has pennants, a judge's stand, flowers at the in-gate, and trailers in the field. A clear round gets one round of applause. A ribbon she wins stays on his bridle until the next round.
- **Walk** sets walk mode. She is on foot. The walker camera is current, the horse is not controllable, and the clock is stopped. The course line is on the glass. Standing beside a fence says that fence's line once. Mount starts the ride. From the saddle, the walk key puts her back on foot.
- **Watch a round** sets `demo_ride`, starts a beginner show at seed 0, and lets `RideAI` ride. It is not her round. `save()` does not run.
- **Season** stays on the title. It fills a panel from `season_rows()`.
- **Options** stays on the title. Sound, picture, and keys go through `SettingsMenu` into `user://settings.cfg`, which is not the ride save.

The HUD owns the glass (time, faults, gait, the next fence, Michelle's line) and the cards. Pause is one card. The results card is another: time, then faults, then the ribbon, and one gold button. That button is the jump-off when one is offered, Next after a clear round, and Retry otherwise. The arena wires those buttons back to retry, jump-off, next class, walk, and quit-to-title.

A clear show round inside the time can offer a jump-off. `begin_jump_off()` keeps her in the arena, marks the round as a jump-off, and resets the clock and the fences. The jump-off course is a different file (four fences), picked by `ship_course` when `jump_off` is set.

## Scripts

`abbott_look.gd` builds Abbott from the Quaternius white horse (`abbott_v2d.glb`) and mounts Madison and the saddle on `Torso2`. Neck bones are not a seat. Clips are Idle, Walk, Gallop, Gallop_Jump, and Jump_toIdle. Trot and Canter are used when the file has them.

`arena.gd` is the round. It builds Hidden K, the course, Abbott, the walker, and the HUD, and it is where pause, walk, mount, the first lesson, and the headless riders attach. User args `--playtest`, `--ridecert`, `--artshot`, `--shots`, `--stride`, `--leave-sweep`, and `--hear` are handled here or on the title before the scene change.

`artshot.gd` is a windowed still camera. The headless runners refuse anything named artshot. People run it. It must not be part of a gate.

`bascule.gd` is a `SkeletonModifier3D`. Gallop_Jump poses the back as one plank. This bends it on top of the clip: forehand up at the leave, round over the fence, neck out and down, then gone by the land so the canter does not keep the shape. Bone pose only. The root does not move. It also puts each hoof back on its cannon, because the hoof bones are IK roots and a bend would stretch the pastern. `withers` is the drawn withers after that bend.

`braids.gd` puts button braids down the crest on show day only. Each braid is attached to a neck bone, so it follows the neck after the bascule, and it takes its colour from the mane under it. Lessons and schooling hide the braids and show `mane.gd` instead.

`content_library.gd` reads the JSON. Search order is `user://content/`, then `res://../content/` (the checkout's `content/` folder), then `res://content/` (the copy shipped under `game/content/`). If a file is missing, the course and Michelle fall back to what is written in code. The HUD asks for fence names every frame, so the fence catalog is read once.

`course.gd` builds the fences, the start, and the finish for this round from the shipped course (`loaded`). The built-in layout is the fallback when the file is missing.

`course_map.gd` (`CourseMap`) is the small overhead map on the HUD. The long side of the ring runs up the screen and the in-gate is at the bottom. Each fence is a short bar with its number, the next fence is gold, jumped fences are dim, and Abbott is an arrow. It redraws about twelve times a second. It hides for pause, the results card, options, and the lesson card, and it steps aside for the reins card. Options, Picture, "Course map" turns it off. It is on by default.

`ear_life.gd` is the ear modifier. It runs before the bascule, so a worried horse's pricked ears still sit on the bent neck. Idle, walk, and trot hold the ears still in the clip. This tips one back to listen, and both go forward at the canter.

`farm.gd` (`HiddenK`) is the outdoor ring: sand `RING_W` 30.48 m by `RING_D` 76.20 m, centred on the origin, plus mirrors, pines, the house, and the barn. Show day adds the pennant strings, a judge's stand on the left rail, flower urns beside the in-gate, a pickup and two trailers past the far stands, and one applause player. A lesson builds none of those.

`fence.gd` (`JumpFence`) is one obstacle: rails, standards, the number, the flower box or oxer dressing, and the knocked / refused / cleared flags the round reads.

`first_lesson.gd` is the tutorial card for a fresh save on a lesson. It does not start for a demo, a cert, a playtest, or a self-test.

`game_state.gd` is the autoload. Class rules live in `CLASS_INFO` (lesson, beginner, intermediate, advanced): fence count, school time, and show time. Jump-off time is `max(28, that time × 0.42)` and the fence count becomes 4. The clock does not read `time_allowed_school` or `time_allowed_show` out of a course file. It also holds the round (faults, clock, ribbon), the season totals, the horse and rider scales, Michelle's line, the key bindings, and the save.

`horse.gd` is Abbott: gaits, steering, the jump, the landing, the camera, and the reins. It finds the skeleton and binds the modifiers. Do not change how this plays on a maintenance day.

`hud.gd` is the glass and the cards: the running round, pause, the first-lesson line, the results card, options opened from pause, the walk line, and the course map.

`mane.gd` is the loose mane for a lesson or a schooling round: short locks down the off side of the neck, one mesh per neck bone, hung with gravity so a lifted neck does not leave them standing up. Show day hides it.

`mesh_kit.gd` builds materials, loads textures, and packs small props (leaves, blooms, a hedge) into one mesh so the farm and a course are not thousands of shadow casters.

`person_look.gd` builds hunt-seat Madison from the three-view kit, and Michelle on the rail. The saddle pad, flaps, and girth are measured off Abbott's barrel.

`playtest.gd` runs three scripted rounds (clear, refusal, rail) and writes a report. It is the fast check. It teleports. It is not a ride.

`ride_ai.gd` is the finite rider used by Watch a round and by the ride certificate. Same keys a person has. It does not teleport. Sit, get on the line, wait for the last stride, then ask.

`ride_cert.gd` is the headless certificate: a real ride of one course, with the horse and rider pinned so a save that has drifted to 100 does not make the track easier. `--playtest` stays the fast check. `--ridecert-fresh` is a separate path.

`rider_mesh.gd` poses Madison's skeleton in the saddle. There is no animation player and no root motion. `horse.gd` still drives the seat: lean on the body pitch, turn on the body roll, the seat's lift, and the head. This reads those and poses the bones in the seat frame. Legs hang from the hip to the iron at full length. The fists sit a hand's width apart, a fist above the withers, and they use `bascule.withers` so they follow the bend. At a show her number is tied on her back, built once for the session.

`rosette.gd` pins the ribbon she just won on the near side of the bridle, where the browband meets the cheekpiece, and keeps it until the next round. It follows the head with a `BoneAttachment3D`. Reading the head bone from `_process` sees the clip before the bascule, which left the ribbon on the noseband of a horse whose neck was up.

`scoreboard_live.gd` is the board by the ring. It copies the clock and the faults about ten times a second.

`selftest.gd` is added by the title when `--selftest` is set. It runs inside the real boot, so `GameState` is already loaded. It writes only under `user://selftest/` and deletes what it creates. It must not read or write `abbott_save.json`.

`settings.gd` (`PlayerSettings`) is `user://settings.cfg`: buses, look, camera, riding aid, and picture, including whether the course map is on. Tests pass their own path. It is never the ride save.

`settings_menu.gd` is the options list (sound, picture, and from pause the key list). It saves only in a real session.

`shots.gd` is the fixed-camera pass for `dist/day12/shots`. The mouse stays visible. The player save must not be written. The runner that launches it opens a window. People use it. A gate does not.

`tail_carriage.gd` is the tail modifier. It runs first, before the ears and the bascule, so a worried horse can still lift it. The canter clip holds the tail out like a flag. This lets it hang from the dock, drops the idle metronome, and lets a swish and a late bend through a turn show on top of the clip.

`title.gd` is the menu described above. `--selftest` and `--shots` stay on the title scene. Playtest, hear, stride, leave-sweep, artshot, and ridecert change to the arena straight away.

`trainer.gd` is Michelle. After a leave she has one sentence. She prefers the line in the content library for this session and class, and falls back to the sentences written in this file.

`walker.gd` is Madison on foot: a capsule, the same mesh as the saddle, hidden until walk mode so the ring does not show two of her. Enter still mounts. The clock stays on the flags.

`watch_rider.gd` turns a standing figure's head to follow Abbott: Michelle on the rail, and the people in the stands. Neck and head only, eased, and no further than a person turns without moving her feet. With an animation player she idles, and she waves once when Madison finishes a clear round. The first of those waves asks the farm to play the one applause. The player exists only on show day.

## The horse's modifier chain

`horse.gd` `_bind_rig` adds three `SkeletonModifier3D` children to the skeleton, in this order:

1. `TailCarriage` (`tail_carriage.gd`)
2. `EarLife` (`ear_life.gd`)
3. `Bascule` (`bascule.gd`)

They pose bones on top of the clip. The tail and the ears are first so a worried horse's lifted tail and pricked ears sit on the pose. The back bends last. Show braids are a separate node (`Braids`), built once on the bones and shown only at a show. The loose mane (`Mane`) is built the same way and shown only when it is not a show. Neither one is a modifier.

A script that reads a bone from `_process` sees the clip before these modifiers. `rosette.gd` says so about the head, and `bascule.gd` says so about the withers: `rider_mesh` anchors her fists on the `withers` transform the modifier stores after the bend, not on a raw bone read. `tail_carriage.gd` says the same about the tail's hang. Follow a bone with a `BoneAttachment3D`, or read the transform the modifier publishes, if the drawn pose is what you need.

## The rider

`abbott_look.gd` parents her to `Torso2`. `rider_mesh.gd` then poses that skeleton every frame from the seat signals `horse.gd` is already driving. The seat frame has its origin at the deepest point of the saddle, −Z toward his head, +X to his right. Her ankles hang on the barrel under her hip. The knee rides the knee roll. No clip plays on her.

## Content and data

Shipped courses are `game/content/courses/`: 23 course files, plus `INDEX.json` and `SHIP.json`. The index is a JSON array. `load_index` wraps it as `{courses: ...}`.

- 4 lesson courses, `hk_les_001` through `hk_les_004`, 3 fences.
- 6 beginner, 8 fences.
- 6 intermediate, 10 fences.
- 4 advanced, 12 fences. There is no `hk_adv_004`.
- 3 jump-offs, `hk_jo_beg_001`, `hk_jo_int_001`, `hk_jo_adv_001`, 4 fences, `jump_off` true.

All 23 are in `SHIP.json`. The prompt that said 24 files is wrong. The tree and the index agree at 23.

`game/content/fences/catalog.json` is the fence catalog (vertical, oxer, flower, and the heights those names match).

`game/content/rail/barn_notes.json` is the barn line on the title. `game/content/rail/michelle_ship.json` is the live board, what `phrase()` says. The long pile is `content/rail/michelle.json` at the checkout root (found as `res://../content/`). It is not the export copy.

`user://content/` wins over both, when a file is present there.

Nineteen course files store a school time and a show time that `time_allowed()` does not use. Lessons match (180 / 180). The rest are shorter than `CLASS_INFO`. That is recorded in `dist/day16/content_report.md`. Do not "fix" it without Ernie.

## Save

Her save is `user://abbott_save.json`. On this machine that is `C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json`, and `abbott_save.json.bak` sits beside it.

`save()` writes a temp file, renames the current file to `.bak`, then renames the temp into place. If the replace fails, the backup is still there. `load_save()` reads the main file. A missing or unusable file falls back to defaults. `read_save_migrated()` is the path a test may call on a file under `user://selftest/`.

`save()` returns without writing when any of these are true:

- `demo_ride` (Watch a round)
- a user arg `--playtest`, `--ridecert…`, `--shots` or `--shots-…`, `--selftest` or `--selftest-…`, `--telemetry` or `--telemetry-…`

A maintenance run never writes, moves, renames, or deletes her save or the `.bak`. The Day 16 gate compares the file to `dist/day16/save_snapshot.json`. `SAVE_CHANGED` means stop. She may have just played. Do not put the snapshot back.

`user://settings.cfg` is picture and sound only.

The Day 16 copies `dist/day16/save_snapshot.json` and `dist/day16/save_backup.json` are private. They are listed in `.git/info/exclude`. Do not commit them.

## Gates and the numbers they must print

Day 16 gates are `dist/day16/gates.sh`, run from Git Bash:

`"C:\Program Files\Git\bin\bash.exe" dist/day16/gates.sh <tag>`

One Godot at a time, always through a runner, always `--headless` first. The script compiles, runs the self-test, runs the playtest, rides `hk_les_001` and `hk_beg_035` (`--ridecert-fresh --ridecert-show --ridecert-jumpoff`), copies those two logs to `dist/day16/logs/<id>.<tag>.log`, and compares her save to the snapshot.

The ride lines the work is judged against:

- `hk_les_001` clear, faults 0, jumped 3/3, about 25.43 s, `teleported=false`
- `hk_beg_035` first round clear, faults 0, jumped 8/8, about 62.14 s, `teleported=false`, then `done` with `offer=true`
- the same id again, the jump-off: `success=false` is normal, faults 0, jumped 4/4, about 33.45 s, `teleported=false`, then `done` with `round=jumpoff`

A run-to-run wobble of ±0.01 s is normal. Anything past 0.10 s is not. Faults, jumped counts, the done lines, and `teleported=false` do not move.

Playtest prints four lines: clear faults 0 complete, refuse faults 4, rail faults 4, and `done pass=true`.

Compile is `COMPILE 1 errors=0`.

The self-test on `day15-claude` was `pass=57 fail=0`. Day 16 added characterization tests. After `cue_files` the count is `pass=67 fail=0`: `library_lines` had reached 64, then `built_meshes`, `standing_people`, and `cue_files`. A new test must keep `fail=0` and raise the pass count by the tests it adds. Do not edit a test, a baseline, or the gate to make a red run green. If a new characterization test fails, the test is wrong.

`gates.sh` rewrites `dist/selftest_day.log`, `dist/playtest_day.log`, `dist/ridecert_fresh.log`, `dist/playtest_results.json`, `dist/ridecert_fresh_one.json`, and `dist/traces/*`. Those stay unstaged until the final commit of the day. `dist/day12/compile_check_*.log` stays untracked. The deleted files under `photos_jpg/` stay unstaged.

A code change, including a new test, gets a full gate with a new tag before it is committed. A comment-only change to a `.gd` file gets at least the self-test. A markdown-only change gets no gate.

## Headless runners, and the tools that open a window

Run Godot only through these. Each puts `--headless` first and creates no window:

- `python dist/day12/run_script.py res://tools/<script>.gd <log name>` — one tool, log at `dist/day12/<log name>`. Refuses artshot.
- `python dist/_run_userarg.py --selftest` and `--playtest` — logs `dist/selftest_day.log` and `dist/playtest_day.log`.
- `python tools/content_factory/run_ridecert.py` — only from the gate.
- `python dist/day12/run_import.py` — only when a new resource needs importing.
- `dist/day16/gates.sh` — the Day 16 gate, which calls the runners above.
- `dist/day17/gates.sh` — the Day 17 gate, same checks, tag on the command line.

These open a window. They are for people, not for this run:

- Godot with no `--headless`, and the editor (`-e`)
- `dist/day12/run_shots.py`, `dist/day15/run_probe.py`
- `python dist/day17/run_window.py` — the Day 17 windowed runner. It always passes a `--shots-` argument, so the game cannot save, and it checks her save afterwards.
- `game/tools/day15_probe.gd`, `day15_titleshot.gd`, `day15_fps.gd`, `day15_perf.gd`, `day15_camlog.gd`, `day15_hudtime.gd`, `day17_playthrough.gd`
- anything named artshot
- Blender (`dist/day14/run_blender.py` and the rest of that folder)

Never start Godot by hand. One process at a time. Never kill a Godot process this run did not start.

## Where the day logs are

Each day's note is `dist/DAY<n>_LOG.md`. The latest is `dist/DAY17_LOG.md`. Day 16 is `dist/DAY16_LOG.md`. Older measure notes sit beside some of them (`DAY<n>_MEASURE.md`).

Per-day artifacts are `dist/day<n>/`. Day 16's gate copies are `dist/day16/logs/`. The course report is `dist/day16/content_report.md`. The asset audit is `dist/day16/assets_report.md`. The Day 16 prompt is `dist/day16/GROK_PROMPT.md`. The Day 17 prompt is `dist/day17/GROK_PROMPT.md`, and its before-and-after sheets are `dist/day17/review/`.

`dist/STATUS.md` is the short standing status. `dist/RIDE_CERT.md` is the certificate note.
