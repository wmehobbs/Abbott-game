# Abbott: a long, headless maintenance run (Day 16, Grok)

You are working alone for many hours on **Abbott**, a Godot 4.7.2 horse-jumping game made for Madison (Ernie's daughter). Ernie is busy with other work. He will not answer questions, and nothing may appear on his screen. Work through the backlog below in order, carefully, and keep a log he can read later.

The repo is `E:\Workspace\Madison`. The Godot project is in `game/`. For context, read `README.md`, then the "Morning" section at the top of `dist/DAY15_LOG.md`, then the top entry of `dist/STATUS.md`.

---

## Hard rules: never break these

1. **Headless only. Never open a window.**
   - Run Godot only through these runners. Each one puts `--headless` first and hides the console:
     - `python dist/day12/run_script.py res://tools/<script>.gd <log name>` runs one tool script; the log goes to `dist/day12/<log name>`.
     - `python dist/_run_userarg.py --selftest` and `python dist/_run_userarg.py --playtest`; logs go to `dist/selftest_day.log` and `dist/playtest_day.log`.
     - `python tools/content_factory/run_ridecert.py ...`, used only through the gate script.
     - `python dist/day12/run_import.py`, a headless import. Use it only if a new resource needs importing.
     - The gate script `dist/day16/gates.sh`, which uses the runners above.
   - Never run any of these. They open windows, and they are for humans only:
     - `godot --path game` without `--headless`, or the editor (`-e`);
     - `dist/day12/run_shots.py` or `dist/day15/run_probe.py`;
     - any of `game/tools/day15_probe.gd`, `day15_titleshot.gd`, `day15_fps.gd`, `day15_perf.gd`, `day15_camlog.gd`, `day15_hudtime.gd`;
     - anything named "artshot";
     - Blender.
   - Never launch Godot directly. Always go through a runner.
   - Run one Godot at a time and wait for it to finish. Never kill a Godot process you did not start. Ernie or Madison may have the game open.

2. **Madison's save is not yours.** It lives at `C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json` (there is also a `.bak` beside it). Never write, move, rename, delete, "fix" or reset either file.
   - The gate script compares the save to your snapshot. If it ever prints `SAVE_CHANGED`, stop all work at once. Do not touch the save, not even to restore it: Madison may have just played. Write the time and what you were doing at the top of the log, commit the log, and end your run.

3. **Do not change how the game plays.**
   - Never edit `game/scripts/horse.gd`, `ride_ai.gd`, `ride_cert.gd`, `playtest.gd`, `course.gd`, `game_state.gd`, `content_library.gd`, `arena.gd` or `fence.gd`.
   - Never edit anything under `game/content/`, nor `game/project.godot`, `game/export_presets.cfg`, the input map, the audio buses, or the version number (2.348.0.0).
   - You may only edit the files each task names.

4. **Git.**
   - Create branch `day16-grok` from `day15-claude` and do all your work there.
   - Make one commit per change. Stage only the files you changed for that change (`git add <paths>`), never `git add -A` or `git add .`.
   - Never push, merge, rebase, amend, reset, or force anything.
   - Never stage the deleted `photos_jpg/` files (they were deleted outside this work, and Ernie decides), nor the `dist/day12/compile_check_*.log` files.

5. **No money, no downloads.** Use no paid APIs or services, and download no assets. Work offline with what is in the repo.

6. **Never stop to ask.** If something blocks you, write it under "Blocked" in the log and move to the next task.

7. **Never delete or move project files.** When something looks unused or wrong, report it. The only files you may delete are your own temporary ones.

---

## Setup (do this first)

1. Run `git status`. You should be on `day15-claude` with a clean tree, apart from the `photos_jpg/` deletions and untracked logs. Then run `git switch -c day16-grok`.
2. Copy Madison's save, without changing it, to `dist/day16/save_snapshot.json`, and also to `dist/day16/save_backup.json`. Note its SHA-256 in the log. Do not commit the backup: it is her private data, so add `dist/day16/save_backup.json` to `.git/info/exclude`.
3. Run the baseline gates with Git Bash (they take about 5 minutes):
   `"C:\Program Files\Git\bin\bash.exe" dist/day16/gates.sh baseline`
4. The output must match this (a run-to-run wobble of ±0.01 s on the times is normal):
   ```
   COMPILE 1 errors=0
   SELFTEST SUMMARY pass=57 fail=0
   PLAYTEST clear faults=0 complete=true
   PLAYTEST refuse faults=4
   PLAYTEST rail faults=4
   PLAYTEST done pass=true
   RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=25.43 teleported=false
   RIDECERT done round=first offer=false
   RIDECERT hk_beg_035 style=clear success=true faults=0 jumped=8/8 t=62.14 teleported=false
   RIDECERT hk_beg_035 style=clear success=false faults=0 jumped=4/4 t=33.45 teleported=false
   RIDECERT done round=first offer=true RIDECERT done round=jumpoff
   SAVE_MATCH
   GATES_DONE
   ```
   - `success=false` on the second `hk_beg_035` line is normal: that line is the jump-off round.
   - If the baseline does not match, do not start the backlog. Log the output and end.
5. Create `dist/DAY16_LOG.md` (layout below) with the baseline in it, and commit it together with `dist/day16/gates.sh` and this prompt file.

## The gate rule (every change)

- **Code changes** (anything that changes what a `.gd` file does, including new tests): before committing, run the full gates, `"C:\Program Files\Git\bin\bash.exe" dist/day16/gates.sh <short-tag>`. Use a new tag each time, such as `t1a`, `t2c` or `t5-hud`. A change passes only if all of these hold:
  - `COMPILE 1 errors=0`;
  - `SELFTEST ... fail=0`, with the pass count equal to the last pass count plus any tests you just added;
  - the playtest shows 0 / 4 / 4 and `done pass=true`;
  - each ride time is within 0.10 s of 25.43, 62.14 and 33.45, with the same faults, `jumped` counts and `done` lines, and `teleported=false`;
  - `SAVE_MATCH`.
- **Comment-only changes** to `.gd` files: run at least the selftest (`python dist/_run_userarg.py --selftest`), then check `dist/selftest_day.log` for `SELFTEST SUMMARY pass=N fail=0`. The selftest loads every script, so it catches a broken comment.
- **Markdown-only changes**: no gates needed.
- **If a gate fails:** revert that change (`git restore <files>`), write what failed in the log, and move on. Never make a gate pass by editing a test, a baseline number, or the gate script.
- Every gate run rewrites some tracked logs (`dist/selftest_day.log`, `dist/playtest_day.log`, `dist/ridecert_fresh.log`, `dist/playtest_results.json`, `dist/ridecert_fresh_one.json`, `dist/traces/*`). Do not stage them with your changes. Commit them once at the very end.

---

## Backlog (in order)

Read the code before writing anything. Every script in this repo opens with a comment saying what it is for.

### Task 1: course content validator (report only)

Write `game/tools/validate_content.gd`, which `extends SceneTree`, does its work, prints a summary, and calls `quit()`. Run it with:
`python dist/day12/run_script.py res://tools/validate_content.gd validate_content.log`

First learn the course format from `game/scripts/content_library.gd` (`load_index`, `load_course`, `specs_from_course`, `ship_course`), from `game/scripts/course.gd`, and from a few files under `game/content/courses/`. There are 24 course files plus `INDEX.json`, and the fence catalog is `game/content/fences/catalog.json`. Then check at least the following, reading every limit from the code rather than inventing one:

- every course file parses;
- every `INDEX.json` entry has a file, and every file is in the index;
- ids are unique and match file names;
- fence numbers run 1..N with no gaps or repeats;
- every fence kind exists in the fence catalog;
- heights fit the class (see `CLASS_INFO` in `game_state.gd`);
- every fence lies inside the ring, which is 30.48 m × 76.20 m centred on the origin (`RING_W` and `RING_D` in `farm.gd`);
- distances between consecutive fences are not shorter than the shortest distance in any shipped course (report outliers rather than failing);
- each jump-off course is consistent with its parent class;
- all the text the game shows for a course (`walk_line`, `near_line`, names) comes out non-empty.

Write the results to `dist/day16/content_report.md`: one table row per course and a "Findings" list. **Do not edit any course file.** Findings go to Ernie.

This is a new tool, not game code, so the compile check and selftest are enough as gates, plus a clean run of the tool itself. It is done when the tool exits 0 and the report covers every course file.

### Task 2: characterization self-tests

Add self-tests to `game/scripts/selftest.gd` (you may edit this file) for logic that has none yet. Each test pins what the code does **today**. It must pass on the current code with no game code changed. If a test fails, the test is wrong, so fix the test.

- First read how the existing tests are written and registered in `_run()`. Note especially the save-safety pattern in `_old_save_migrates`, `_bak_recovers`, `_garbage_defaults` and `_write_raw`. Never read or write the real save path in a test. Use in-memory data, or files under `user://selftest_*` that the test deletes afterwards.
- Candidates (check each function exists and read it first):
  - `GameState`: `time_allowed` for every class and session, `result_line` for clear, faults and eliminated, `class_unlocked`, `can_offer_jump_off`, `_ribbon` for placings, `class_best_display`, `class_title`, `control_line`. Several of these take no arguments and read `GameState` fields (`session_kind`, `class_id`, `faults`, `last_time` and so on). Set the fields, call the function, then restore every field you touched, as the existing tests do;
  - `ContentLibrary`: `fence_name` for every catalog kind, `phrase` fallbacks, non-empty `walk_line` and `near_line` for every course, `barn_note` across its input ranges.
- Keep each test short, with a one-line comment saying what it guards, in the voice of the existing tests. Add one test (or a small related group) per commit, with full gates each time, and record the new selftest count.

It is done when every public function in `game_state.gd` and `content_library.gd` that returns a value has a test, or a line in the log saying why not.

### Task 3: `dist/ARCHITECTURE.md` (markdown only)

Write an architecture guide for the next person or agent. It should cover:

- every script in `game/scripts/`, with one to three lines each written from reading it;
- the scene flow: title to arena, the results card, walk mode, show day versus lesson;
- the content and data files;
- the horse's skeleton-modifier chain (`TailCarriage`, then `EarLife`, then `Bascule`, added in `horse.gd` `_bind_rig`), and why a script reading bones in `_process` sees the clip before the modifiers (see `rosette.gd` and `bascule.gd` `withers`);
- how the rider is posed (`rider_mesh.gd`);
- the gates and their expected numbers;
- the save protections;
- the headless runners versus the windowed tools, which are for humans only;
- where the day logs are.

It is done when every `.gd` file in `game/scripts/` is listed.

### Task 4: doc comments (comments only)

Add a `##` doc comment above every top-level `func` that lacks one, in these files only: `hud.gd`, `title.gd`, `settings_menu.gd`, `farm.gd`, `mesh_kit.gd`, `person_look.gd`, `walker.gd`, `trainer.gd`, `first_lesson.gd`, `scoreboard_live.gd`, `watch_rider.gd`, `rosette.gd`, `braids.gd`, `tail_carriage.gd`, `ear_life.gd`, `abbott_look.gd`, `rider_mesh.gd` and `bascule.gd`.

- Change comments only: no code and no whitespace changes. Indentation is tabs.
- Match the existing voice: short and plain, saying what the function is for and why, never "This function...".
- One file per commit, with the selftest as the gate.

### Task 5: static types in visual and UI scripts

Use the Task 4 file list minus `bascule.gd`, `rider_mesh.gd`, `abbott_look.gd` and `watch_rider.gd`, which hold rig maths and are left alone.

- Add explicit types where the type is certain from the code: untyped `var` declarations, function parameters and return types.
- Never change a numeric literal (`5` stays `5`, `5.0` stays `5.0`). Never change logic, order or behaviour. If a type is uncertain, leave it untyped.
- One file per commit, with **full gates**. The ride times must not move.

### Task 6: asset audit (report only)

There is an existing helper, `dist/day12/unused_assets.py`; read it and reuse what fits. Write `dist/day16/assets_report.md`, a table of every file under `game/assets/` (skip `.import` and `.uid` files) showing:

- its size;
- whether any `.gd`, `.tscn`, `.tres`, `.cfg` or `.json` file references it, by `res://` path or file name;
- whether it is credited in `game/assets/ATTRIBUTION_HARVEST.md`, `game/assets/audio/ATTRIBUTION.txt`, or any other attribution file you find.

Also flag:

- textures larger than 2048 px on a side;
- files over 5 MB;
- unreferenced files;
- files with no credit.

**Do not delete, move or re-encode anything.** It is done when every asset is in the table.

### Task 7: keep going

When tasks 1 to 6 are done, keep working in this order, with the same rules and gates:

1. more characterization tests for pure helpers elsewhere (for example `MeshKit` builders return non-empty meshes, `person_look` and `rider_mesh` static builders, and the settings round trip, using temporary files only);
2. any further content check you can justify from the code;
3. a pass making `ARCHITECTURE.md` more accurate.

Stop when nothing useful remains, or after about 12 hours of work, whichever comes first.

---

## The log: `dist/DAY16_LOG.md`

Put a **Summary for Ernie** at the top: what changed, what was found, what needs him, kept short and plain. Below it:

- a **Status** table with columns `task | commit | gates (compile, selftest x/0, playtest, les/beg/jo times, save) | notes`, updated after every commit;
- **Needs Ernie**: findings from tasks 1 and 6, and anything you chose not to do. You never act on these yourself;
- **Blocked**: anything that stopped you.

## Finish

1. Run the gates one last time with tag `final`.
2. Update the summary, then commit the log and the tracked gate logs.
3. Leave branch `day16-grok` unpushed and unmerged.
4. Make sure no Godot process you started is still running.
