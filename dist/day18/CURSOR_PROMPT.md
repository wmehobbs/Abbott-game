# Abbott: a long headless work session (Day 18, Cursor)

You are working for many hours on **Abbott**, a Godot 4.7.2 horse-jumping game made for Madison (Ernie's daughter, who rides hunters). Ernie checks in now and then but will not answer questions. **Keep working.**

- After each commit, go straight to the next item. Do not stop to summarize, and do not ask what to do next.
- Only end your turn when every task below, including the open-ended Task 10, is truly exhausted, or when a hard rule tells you to stop.
- If you are restarted with "continue", read `dist/DAY18_LOG.md` and pick up at the first unfinished task.

The repo is `E:\Workspace\Madison`, and the Godot project is in `game/`. Read these first:

- `README.md`;
- `dist/ARCHITECTURE.md`, the guide to every script;
- the summaries at the top of `dist/DAY17_LOG.md` and `dist/DAY16_LOG.md`;
- `tools/content_factory/RIDE_CERT.md`.

---

## Hard rules: never break these

1. **Headless only. Never open a game window.**
   - Run Godot only through these runners. Each one puts `--headless` first and hides the console:
     - `python dist/day12/run_script.py res://tools/<script>.gd <log name>` runs one tool script; the log goes to `dist/day12/<log name>`.
     - `python dist/_run_userarg.py --selftest` and `python dist/_run_userarg.py --playtest`; logs go to `dist/selftest_day.log` and `dist/playtest_day.log`.
     - `python tools/content_factory/run_ridecert.py <args>`; the log goes to `dist/ridecert_fresh.log`.
     - `python dist/day12/run_import.py`, a headless import.
     - The gate script `dist/day18/gates.sh`.
   - **Never run any of these.** They open windows, and they are for humans only:
     - `godot --path game` without `--headless`, the Godot editor, or the game itself;
     - `dist/day17/run_window.py`, `dist/day15/run_probe.py` or `dist/day12/run_shots.py`;
     - `game/tools/day15_probe.gd`, `day15_titleshot.gd`, `day15_fps.gd`, `day15_perf.gd`, `day15_camlog.gd`, `day15_hudtime.gd` or `day17_playthrough.gd`;
     - Blender.
   - Run one Godot at a time and wait for it to finish. Never kill a Godot process you did not start.

2. **Madison's save is not yours.** It lives at `C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json` (and `settings.cfg`, if it exists). Never write, move, delete or reset it.
   - The gates and `python dist/day18/save_check.py` compare it with your snapshot. If either prints `SAVE_CHANGED`, stop all work. Do not touch the file: Madison may have just played. Write the time and what you were doing at the top of the log, commit the log, and end your turn.

3. **Do not change how the game plays.** Ride times, faults, refusals, rails and the clock must not move.
   - Never edit `game/scripts/horse.gd`, `ride_ai.gd`, `ride_cert.gd`, `playtest.gd`, `course.gd`, `content_library.gd`, `arena.gd` or `fence.gd`.
   - Never edit anything under `game/content/`, nor `game/project.godot`, `export_presets.cfg`, the input map, `default_bus_layout.tres`, or the version number (2.348.0.0).
   - `game_state.gd` gets **one** allowed edit, described in Task 1. Otherwise, edit only the files each task names. You may read anything.

4. **Git.**
   - Create `day18-cursor` from `day17-grok` and work only there. Make one commit per change, and stage only the files you changed (`git add <paths>`, never `-A` or `.`).
   - Never push, merge, rebase, amend, reset, or force anything.
   - Never stage the deleted `photos_jpg/` files, `dist/day12/compile_check_*.log`, or anything named `snapshot_*`.

5. **No money, no downloads.** Use no paid services and download no packages or assets.

6. **Never stop to ask.** If something blocks you, write it under "Blocked" in the log and move to the next task.

7. **Never delete or move project files.** The only files you may delete are your own temporary ones. When something looks wrong, report it.

---

## Setup (do this first)

1. Run `git status`. You should be on `day17-grok` with a clean tree, apart from the `photos_jpg/` deletions and untracked logs. Then run `git switch -c day18-cursor`.
2. Copy Madison's save, without changing it, to `dist/day18/snapshot_abbott_save.json`. If `settings.cfg` exists, copy it to `dist/day18/snapshot_settings.cfg` as well. Then add `dist/day18/snapshot_*` to `.git/info/exclude`.
3. Run the baseline gates with Git Bash (they take about 5 minutes):
   `"C:\Program Files\Git\bin\bash.exe" dist/day18/gates.sh baseline`
4. The output must match the Day 17 final:
   ```
   COMPILE 1 errors=0
   SELFTEST SUMMARY pass=68 fail=0
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
   - Each time may wobble by 0.01 s and must stay within 0.10 s.
   - `success=false` on the second `hk_beg_035` line is normal: that line is the jump-off round.
   - If the baseline does not match, log it and end.
5. Create `dist/DAY18_LOG.md` (layout at the end) and commit it together with `dist/day18/gates.sh`, `dist/day18/save_check.py` and this file.

## The gate rule (every change)

- **Code changes** (anything that changes what a `.gd` file does, including new tests): run the full gates before committing, with a new tag each time (`t1`, `t2b`...). A change passes only if:
  - compile is clean;
  - the selftest shows `fail=0`, with the pass count equal to the last count plus the tests you added;
  - the playtest shows 0 / 4 / 4 and `done pass=true`;
  - each ride time is within 0.10 s of its baseline, with the same faults, `jumped` counts and `done` lines, and `teleported=false`;
  - `SAVE_MATCH`.
- **Comment-only changes** to `.gd` files: run at least the selftest.
- **Markdown-only changes**: no gates needed.
- **If a gate fails:** revert the change (`git restore <files>`), log it, and move on. Never make a gate pass by editing a test, a baseline or a gate script.
- **Tracked logs:** the gates rewrite some tracked logs (`dist/selftest_day.log`, `dist/playtest_day.log`, `dist/ridecert_fresh.log`, `dist/playtest_results.json`, `dist/ridecert_fresh_one.json`, `dist/traces/*`). Do not stage them with your changes. Commit them once at the very end.
- **Comment voice:** the code's comments are short and plain and say why. Match them. GDScript is indented with tabs.

---

## Backlog (in order)

### Task 1: "1 faults"

**The bug:** a round with one fault says "1 faults". The one-fault card was found on Day 17.

**The fix:** make the fault count singular for 1 and plural otherwise (the time-fault line in `result_line` already does this) in these places:

- `game_state.gd` `result_line`, the line `bits.append("%d faults" % last_faults)`. This is your one allowed edit in `game_state.gd`: that string only.
- `hud.gd`, the results count-up (`"%0.2f\n%d faults"`) and the pause card (`"%s\n%d faults   ·   ..."`).
- Search all the UI scripts (`hud.gd`, `title.gd`, `settings_menu.gd`) for any other "%d faults", "%d refusals" or similar counts, and fix those too.

**Tests:** add a self-test where 1 fault reads "1 fault", 4 reads "4 faults" and 0 is unchanged. Set the `GameState` fields, call the function, and restore every field you touched, the way the existing tests do. If an existing test pins the old wording, update only that expected string, and say so in the commit message.

### Task 2: the course-walk hint covers the info card

**The bug:** on a course walk, the course sentence (`walk_hint` in `hud.gd`, at about y 96) is drawn inside the top-left info card. This was found on Day 17.

- Move it, in `hud.gd` only, so it never overlaps the info card, the course map (top-right), the hint band, or the trainer's line, at all six sizes the selftest's `_layout` test uses. Layout works headless.
- **Tests:** add a self-test that puts the HUD in walk mode in a SubViewport at each size and checks that the walk hint's global rect does not intersect the info card's or the course map's. Read `_layout_hud` and `_audit_screen` for how the existing layout tests build the HUD.

### Task 3: the full ride-cert board, headless

**Why:** `tools/content_factory/RIDE_CERT.md` holds a board of every course ridden by the headless rider, but it is from before Days 15 to 17.

1. Read `game/scripts/ride_cert.gd` to learn its arguments (`--ridecert-fresh`, `--ridecert-show`, `--ridecert-jumpoff`, `--ridecert-id`, `--ridecert-style`...) and how a full board run is started.
2. Run the full board twice through `run_ridecert.py`. Copy each run's `dist/ridecert_fresh.log` to `dist/day18/logs/board_1.log` and `board_2.log`.
3. Write `dist/day18/ridecert_board.md`, in the same columns as the board in `RIDE_CERT.md`:
   - every course, with result, faults, jumped, time, allowed and why;
   - the differences between your two runs (should be none);
   - the differences from the old board, with a likely reason for each, from reading the code;
   - for every course that does not clear, a read-only diagnosis.
4. **Do not change any gameplay file or course file.** Findings go to Ernie.

### Task 4: soak test (leaks over many rounds, headless)

**Why:** Madison may ride twenty rounds in one sitting. Nobody has checked whether nodes, objects or memory pile up between rounds.

1. Write `game/tools/day18_soak.gd` (`extends SceneTree`). It rides **N rounds in one process** using the demo rider, the way the title's "Watch a round" does: set `GameState.demo_ride = true`, `start_session(...)`, `course_seed`, `set_mode("ride")`, then change to `res://scenes/arena.tscn`. Read `title.gd` `_watch_round`, `arena.gd` `_arm_demo`, and `game/tools/day17_playthrough.gd`, but take no screenshots: headless has no picture.
2. Ride 20 rounds, cycling through lesson, schooling beginner and show beginner. After each round, print:
   - `Performance.get_monitor(Performance.OBJECT_COUNT)`;
   - `OBJECT_NODE_COUNT`;
   - `OBJECT_ORPHAN_NODE_COUNT`;
   - `MEMORY_STATIC`;
   - the round's time and faults.
   Cap each round at 240 s.
3. Run it with `run_script.py`. Write `dist/day18/soak_report.md` with the numbers and a verdict.
4. If counts climb round after round, find what is not freed. Typical suspects are the HUD's confetti, sound players, attachments, and tweens. Fix it in an allowed visual or UI script (`hud.gd`, `farm.gd`, `rider_mesh.gd`, `person_look.gd`, `mesh_kit.gd`, `watch_rider.gd`, `rosette.gd`, `braids.gd`, `mane.gd`, `tail_carriage.gd`, `ear_life.gd`, `bascule.gd`, `abbott_look.gd`, `scoreboard_live.gd`, `course_map.gd` if it exists, `walker.gd`, `trainer.gd`) with full gates, then re-run the soak to show it is flat.
5. If the cause is in a forbidden file, write a diagnosis under "Needs Ernie".

### Task 5: the courses, by the numbers (report only)

Write `game/tools/day18_course_stats.gd` (headless, via `run_script.py`), or extend `game/tools/validate_content.gd`. For every course, it reports:

- the track length: start, then each fence in order, then the finish, along straight lines. Say that it is a straight-line lower bound;
- the time allowed the game clock uses (`CLASS_INFO`; read `time_allowed()`), and the speed that implies, in m/min;
- the distance between each pair of consecutive fences, in strides of 3.66 m (12 ft). Flag related distances, under about 25 m, that fall near a half stride;
- the turn angle between approach lines, flagging sharp turns.

Write `dist/day18/course_stats.md`, and compare with the Day 16 note that most courses store a time allowed the clock does not use. **Do not edit course files.**

### Task 6: every word on screen (text audit)

1. Collect every string a player can see into `dist/day18/STRINGS.md`, with file and line:
   - labels and buttons in `hud.gd`, `title.gd`, `settings_menu.gd` and `first_lesson.gd`;
   - Michelle's lines and the barn notes in `game/content/rail/*.json`;
   - course names and notes;
   - callouts in `game_state.gd`.
2. Flag typos, wrong plurals, inconsistent capitals, double spaces, lines long enough to overflow, and anything unclear for a young rider.
3. Fix only strings in `hud.gd`, `title.gd` and `settings_menu.gd`, one commit per kind of fix, with full gates. Everything in content files or `game_state.gd` is report-only.

### Task 7: more self-tests

Add characterization tests to `game/scripts/selftest.gd`. Each must pass on the current code with no game code changed, and each must leave every `GameState` field and file as it found it. Use only `user://selftest_*` files, deleted afterwards. Candidates, after first checking that each exists and reading it:

- `rider_mesh.gd` `_two_bone`: the solution reaches the target when it can, keeps both bone lengths, and bends toward the pole;
- the course map: it marks the same fence as next that the HUD's "Fence N of M" line names;
- crowd sizes: 6 spectators in a lesson and 18 at a show;
- `mane.gd`: it builds and hides at a show;
- `settings.gd`: the "Course map" setting round-trips;
- `tail_carriage.gd`: `hang_deg` is published;
- the HUD's time and fault formatting.

Add one test or a small related group per commit, with full gates.

### Task 8: docs (markdown only)

1. `dist/PLAYER_GUIDE.md`, written for Madison, in plain words:
   - how to ride (the keys and pad from `GameState.control_line()` and the reins card);
   - gaits, steering, the half-halt and the ask;
   - what "Right on", "Deep" and "Long" mean;
   - lesson, then schooling, then show day;
   - faults, refusals, the time allowed, ribbons and the jump-off;
   - the course map and walking the course.
   Read the code for every fact. Invent nothing.
2. `dist/DEVELOPING.md`, for the next person or agent:
   - the branches and day logs;
   - the gates and their expected numbers;
   - the headless runners versus the windowed tools;
   - how saves are protected;
   - how to add a self-test.
3. Bring `dist/ARCHITECTURE.md` up to date with Day 17 (the course map, the mane, the show dressing, the applause) and with everything you add.

### Task 9: code health (report only)

Write `dist/day18/code_health.md` listing:

- functions never called (search all `.gd`, `.tscn` and `call("...")` strings before calling anything unused);
- functions over 80 lines;
- copied blocks that appear in two or more scripts;
- `TODO` and `FIXME` notes;
- tool scripts in `game/tools/` that nothing uses any more.

Do not delete or refactor anything for this task.

### Task 10: keep going (open-ended)

When Tasks 1 to 9 are done, cycle through these until you are stopped, logging each round:

1. More characterization tests for any function in an allowed script that has none.
2. Re-run the full board (Task 3) and the soak (Task 4) with other seeds or styles, and add to their reports.
3. More checks in `validate_content.gd` or the course stats that you can justify from the code. Findings are report-only.
4. Accuracy passes on `ARCHITECTURE.md`, `PLAYER_GUIDE.md` and `DEVELOPING.md`.

---

## The log: `dist/DAY18_LOG.md`

Put a **Summary for Ernie** at the top, short and plain: what changed, what was found, what needs him. Update it as you go. Below it:

- a **Status** table with columns `task | commit | gates (compile, selftest x/0, playtest, les/beg/jo times, save) | notes`, with one row per commit;
- **Needs Ernie**: findings from Tasks 3 to 6 and 9, and anything that needs a forbidden file;
- **Blocked**.

## When you finally stop

1. Run the gates with tag `final`.
2. Update the summary, then commit the log and the tracked gate logs.
3. Leave `day18-cursor` unpushed and unmerged.
4. Make sure no Godot process you started is still running.
