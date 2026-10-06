# Cursor, Day 12 overnight: make Abbott a better game (Ernie is away, windows allowed)

You are Cursor in E:\Workspace\Madison. The Godot 4.7.2 project is game/. Ernie has gone to bed and will not answer. Work through the tasks below in order, at full speed, all night. Verify each one, commit it on a branch, update the log, and start the next task in the same turn. Do not stop to ask questions. Do not end your turn while tasks remain.

Why: Ernie is making this game for his daughter Madison, who rides her horse Abbott at Hidden K Stables. The riding mechanic and the rules are good. It still looks and feels crude. One big reason: for weeks every agent worked headless and changed visuals it could not see, so the same things got "fixed" over and over without getting better. Tonight you can see. Use your eyes to fix what is visibly wrong, then build what makes it feel like a finished game: safe saves, a controller that just works, a mix you can adjust, menus that behave, a clear path through the classes, and a first ride that teaches.

MORNING = 07:00 local. Check the time (Get-Date) at the start of every task.

## Rule 1: running Godot tonight

Godot, console build:
C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe

- Ernie is away from his desk. Game windows are allowed until MORNING minus 60 minutes. After that, headless only, and no Godot may still be running when he sits down.
- Tests, playtest, and ride cert stay headless through the existing wrappers, which add --headless and CREATE_NO_WINDOW. Read them before first use:
  python dist/_run_userarg.py <user args>            (playtest, and the selftest you will add)
  python tools/content_factory/run_ridecert.py ...   (one ride id per process)
- Windowed runs are for screenshots only, through one wrapper you write: dist/day12/run_shots.py. It runs
  <godot> --path game --windowed --resolution 1920x1080 --position 0,0 --audio-driver Dummy -- --shots ...
  with a timeout (5 minutes, 30 for a ride sequence). The game quits itself when the shots are done. The mouse is never captured in shots mode. Dummy audio keeps the house quiet.
- One Godot at a time. Before launching: Get-Process *Godot* -ErrorAction SilentlyContinue. If a Godot you did not start is running, wait. Never kill it. Never run tools/content_factory/ride_ids.py (it kills Godots). After every run, confirm your Godot exited.
- Headless timeouts: compile check 5 min, selftest 10 min, playtest 30 min, one ride id 25 min (45 if a jump-off runs). On timeout, kill only the PID you started.
- Never: the Godot editor GUI (you cannot operate it; if new files need importing, run --headless --import), exporting or packing, any .exe in dist, a version bump, PowerShell > redirection on Godot output, changing any Windows setting.
- If a command opens something you did not expect (the editor, a dialog, an extra window) or hangs: close it, write the exact command under BLACKLIST in dist/DAY12_LOG.md, and never run it again.
- If a capture comes back nearly black, or identical to the one before it, the screen may be locked. Log it, stop windowed runs for the night, and continue with the headless tasks.
- For file work, write small Python scripts into dist/day12/ and run them. Avoid complicated inline PowerShell quoting. You may pip install pillow if it is missing. No other downloads.

## Rule 2: protect Madison's save

Her real progress: C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json

- Before the first Godot run, copy it to dist/day12/save_snapshot.json. If it does not exist, say so in the log. Do not commit the snapshot.
- After every Godot run, compare it byte for byte with the snapshot. If it changed: copy the snapshot back at once, log it, and fix the cause before anything else.
- save() already returns immediately for --playtest and for any arg starting with --ridecert. Every mode you add (--shots, --selftest, --telemetry) gets the same guard. Tests read and write only under user://selftest/. No test or shots mode ever writes user://abbott_save.json or the new user://settings.cfg.

## Rule 3: what you may change

Frozen, do not edit:
- The leave and jump math in horse.gd: TAKEOFF 2.55, the early, deep, chip, and ideal bands, window_scale, refuse_scale, balance_need, gait speeds, the 3.35 stride divisor, _try_leave. The knock box stays (width*0.9, height+0.15, 0.35+spread).
- The rules in game_state.gd: Table A, time allowed, time_show, can_offer_jump_off, _ribbon, _school_from_round, _record_round, the unlock rules, note_refuse, and the confidence, scope, rideability, and timing math.
- ride_ai.gd, course JSON in both trees, SHIP.json, michelle_ship.json, the content/ archives, game/assets/meshes/abbott.glb, every existing texture file, dist/Abbott*.exe, earlier dist/DAY* and dist/NIGHT* files, dist/day3 through dist/day11. The version stays 2.348.0.0.

Visual files (farm.gd, mesh_kit.gd, person_look.gd, rider_mesh.gd, abbott_look.gd, bascule.gd, game/shaders, lighting and environment) change only through the visual loop below.

Not tonight:
- New third-party assets, a new art style, new props or set dressing. Ernie and Madison will decide the art direction.
- Madison's face, posture, or riding kit, and Abbott's coat color and markings, unless a shot shows an outright bug (clipping, floating, broken proportions). Those were adjusted dozens of times already. The real fix is properly rigged models, which is Ernie's decision. Write what you see under NEEDS ERNIE.
- Deleting, moving, or renaming existing files. New image, audio, font, or model files inside game/. Network calls in game code. git push, history rewrites, commits to main.

Player-facing text: short plain sentences, American English, no em dashes. Michelle's lines stay one sentence, 14 words or fewer.

## The visual loop (the only way anything visible changes)

1. Take the top open item from dist/day12/visual_backlog.csv.
2. Write the goal in one sentence and what "better" will look like in the shots.
3. Make the change.
4. Capture the same shots again: same cameras, same moments.
5. Build a before/after sheet, open it, and look. Write a one-line verdict in the backlog: better, same, or worse, and why.
6. Better: run the gates and commit. Same or worse: revert. At most 3 attempts per item, then close it with a note. Never reopen a closed item tonight.
7. Performance: GPU frame time from the capture run must not get more than 15 percent worse than the baseline.

Before viewing, make 1280 px wide JPG copies; full-size PNGs can be too large to open. Do not commit any images. Add dist/day12/shots/ and dist/day12/save_snapshot.json to .git/info/exclude.

## Gates

- Quick gate, every task: compile check (run game/tools/compile_check.gd headless; read it first to see how), selftest once it exists (SELFTEST SUMMARY ... fail=0), Madison's save matches, no Godot left running.
- Play gate, when a task touches code that runs during a round (horse, arena, hud, game_state, walker, trainer, fence, course, bascule): python dist/_run_userarg.py --playtest still reports clear 0, refuse 4, rail 4.
- Ride gate, when a task touches horse.gd, bascule.gd, the camera, input, round timing, physics, or display settings. One process per id, same flags as Day 11:
  python tools/content_factory/run_ridecert.py --ridecert-fresh --ridecert-show --ridecert-jumpoff --ridecert-id <id>
  Routine ids: hk_les_001 and hk_beg_035. T0 and the final gate add hk_int_002.
  Copy dist/ridecert_godot.log to dist/day12/<id>.<task>.log before the next launch (every run overwrites it). Every round has RIDECERT done. Pass: same faults, same jump-off offer and result, teleported=false, time within 0.10 s of the T0 baseline. No RIDECERT round within 2 minutes means a script error: kill only that process and fix it.
- Visual gate: for visual items, the loop verdict is "better". For code tasks that should not change the picture, capture the ride-camera and title shots and confirm nothing changed by accident.

Commit only when the gates pass: git commit -m "Day 12 T<n>: <what changed>". Include dist/DAY12_LOG.md, dist/DAY12_MEASURE.md, the backlog, and the scripts in dist/day12/.

If a task fails its gates twice or runs past 90 minutes: git stash push -u -m "day12 T<n> attempt" -- game docs README.md, mark it STASHED in the log with the reason, and go to the next task.

## Keeping your place

After every task: update the status table in dist/DAY12_LOG.md (task, status, commit, gates, notes), then re-read docs/prompts/CURSOR_DAY12.md. If your context gets summarized, that file, the log, and the backlog are the truth.

Decide small questions yourself and write the decision in the log. Anything that needs the frozen list, a deletion, Madison's save, or an art-direction choice goes under NEEDS ERNIE, and you move on.

At MORNING minus 75 minutes, start no new task: finish or stash the current one, then do T19.

## Tasks, in order

T0. Baseline, branch, and can you see
- git status. git switch -c wip-before-day12, and commit any uncommitted changes there (including this prompt file) as "Checkpoint before day 12". Lose nothing.
- Make dist/day12/. Snapshot the save (Rule 2).
- Run the compile check, the playtest, and the three ride ids headless. Record them in dist/DAY12_MEASURE.md as BASELINE beside the Day 11 rows: hk_les_001 0 faults 18.53; hk_beg_035 0 faults 67.28, jump-off offered, jump-off 0; hk_int_002 0 faults 80.30, jump-off offered, jump-off 0. A difference from Day 11 is information, not a failure.
- Green: git switch -c day12-overnight and commit the logs. Red: spend at most 45 minutes on the smallest fix (commit it on wip-before-day12). Still red: git switch -c day12-overnight 0796b0a, bring this prompt along with git checkout wip-before-day12 -- docs/prompts/CURSOR_DAY12.md, commit it, re-run the baseline, and log why.
- Vision check: open dist/artshot_play_cam.png (an old September screenshot; make a small JPG copy first). If you can see it, describe it in one line in the log. If you cannot view images, write VISION: NO at the top of the log. Then still capture before/after shots for every change, but keep only visual changes you can verify objectively, and leave the judging to Ernie.

T1. Eyes: a repeatable shot list
- Add a --shots user arg that captures a fixed list into the folder given by --shots-out=<dir>, then quits. Follow game/scripts/artshot.gd (viewport image capture), but write only to the given folder and never overwrite an earlier set. Keep every camera position and moment in one table in the script so every set is comparable.
- Stills: ride camera at walk; halt from the side; seat from the side; halt from behind; mid-walk side; Abbott's head close; Michelle on the rail; barn wide; house wide; the ring from the in-gate with the course set; one fence close; the tree line and sky.
- Ride sequence (RideAI on hk_les_001, ride camera): three strides out, the last stride, takeoff, top of the jump, landing, the turn after, plus an 8-frame strip from takeoff to landing.
- UI: title, HUD mid-ride, pause, options, the result card.
- Performance: with VSync off, record FPS and GPU frame time over 10 seconds of riding into <dir>/perf.csv (RenderingServer.viewport_set_measure_render_time and viewport_get_measured_render_time_gpu).
- Write dist/day12/run_shots.py (Rule 1) and dist/day12/make_sheet.py (before/after sheets and contact sheets, both images scaled to the same width, 1280 px wide JPG).
- Capture the BASELINE set to dist/day12/shots/baseline/. Look at every shot.
- Write dist/day12/visual_backlog.csv with columns: rank, shot, problem, likely cause (file and function), fix idea, status, attempts, verdict. Be specific ("left boot passes through the saddle flap", not "rider looks off"). Rank by what a player sees most, ride camera first. List the 15 most visible problems. Be blunt.
- Fallback if --shots is not working after 90 minutes: run the existing --artshot mode windowed, copy dist/artshot_*.png into a labeled folder under dist/day12/shots/ after each run, then restore dist/artshot_*.png and tools/content_factory/artshots/ with git checkout so the archive stays untouched.

T2. Selftest suite
- Add a --selftest user arg that runs tests inside the real game boot (so GameState is loaded), following the pattern --playtest uses. Print SELFTEST PASS <name> or SELFTEST FAIL <name>: <reason> per test, then SELFTEST SUMMARY pass=<n> fail=<m>, and exit with code 0 only when fail=0. Add --selftest to the save() guard.
- First tests: every script in res://scripts loads; the title and arena scenes instantiate and free cleanly; every SHIP.json course id loads and builds (reuse tools/smoke_library_courses.gd); every input action the game reads exists in InputMap; Watch a round (demo_ride) does not save; a save round trip under user://selftest/. Every later task adds its tests here.

T3. Save safety
- save(): write <path>.tmp, close it, keep the previous good file as <path>.bak, then replace the real file. If renaming over an existing file fails on Windows, remove and then rename. There must never be a moment with no valid save.
- Load: if the file is missing, unreadable, invalid JSON, or missing required keys, try .bak, then defaults. Never crash. Log a warning.
- Add save_version and _migrate(data), which fills missing keys with defaults. Existing saves load exactly as before.
- Tests (test paths only): round trip; a truncated file recovers from .bak; a garbage file gives defaults without a crash; an old save without the new keys migrates; a copy of Madison's snapshot loads with every value unchanged.

T4. Fix what is visibly broken
- Work the backlog from the top, bugs before taste: clipping, floating, z-fighting, stretched or swimming textures, missing or magenta textures, shadow acne or shadows that detach from objects, objects inside other objects, wrong scale, popping. Visual loop for each. Play gate or ride gate when the file calls for it.

T5. Light and image quality
- One pass, in three groups: (a) sun angle and color, sky, ambient light, fog; (b) tonemapper, exposure, SSAO (and SSIL if it helps), glow, color; (c) shadow cascades and bias, anti-aliasing (thin rails and boards must not shimmer or stair-step).
- Better means: shadows keep detail instead of going black; white boards and Abbott's blaze keep detail instead of blowing out; horse and rider stand out from the background; objects sit on the ground; the sky has no banding; it reads as warm late afternoon without turning everything orange.
- Visual loop on the full still set and the ride sequence. Performance rule. At most 3 attempts per group. The lighting was tweaked blind about 11 times before; this is the one pass with eyes. Do not chase.

T6. Ride camera and motion
- Add an opt-in --telemetry user arg (zero effect when off) that writes dist/day12/telemetry_<id>.csv per physics frame (camera position, rotation, FOV; horse speed and gait; current animation, playback speed, blend time) and a summary CSV (camera pops, jerk p95 and p99, animation switches with zero blend, ground speed divided by animation speed per gait as a foot-slide check). Record a BASELINE on hk_les_001 and hk_beg_035.
- Using telemetry and the ride sequence: remove camera pops and jerk; no clipping into horse or rider; level horizon; on the approach, the ears and the next fence are both in view. Cross-fade gait changes; match animation playback to ground speed so the hooves do not slide.
- Never touch the leave math. Ride gate: results identical. Visual loop on the ride sequence and the 8-frame strip. Before and after telemetry go in DAY12_MEASURE.md.

T7. Theme and the screens Madison sees first
- Create game/assets/ui/abbott_theme.tres from the fonts and colors already in use. Restyle the title, HUD, pause, and options for readability and consistency: contrast, size, spacing, alignment. Visual loop with the UI shots.
- Layout tests in the selftest: each screen inside a SubViewport at 1280x720, 1920x1080, 2560x1440, 3840x2160, 1280x800, and 2560x1080. Everything sits inside the viewport, no buttons overlap, no label text is clipped, something has focus when the screen opens, and every button is reachable with ui_up, ui_down, ui_left, ui_right. Fix failures with containers and anchors, not hard-coded positions.

T8. Controller and input
- Every action game_state.gd registers gets a keyboard event and a gamepad event. Gamepad: left stick steers with a deadzone, D-pad up and down change gait, A holds to collect (half-halt), B halts, X mounts, Y walk mode, Start pauses, right stick looks. Every existing keyboard binding stays exactly as it is.
- Track the last device used so prompts name the right button. Text, not icon images.
- Add the gamepad controls to the Ride section of README.md. Change nothing else there.
- Tests: every action has both event types; simulated presses change gait, steering, and collect the same way the keys do. Ride gate.

T9. Audio buses and mix
- Add game/default_bus_layout.tres with Master, Music, SFX, Ambience, Voice, and UI. Route every audio player to the right bus: hooves, fences, and horse sounds to SFX; the bed and wind to Ambience; Michelle and Madison to Voice.
- When a Voice line plays, duck Music and Ambience by about 6 dB with a short fade, then restore.
- Tests: no audio player is left on Master; the duck lowers and restores bus volumes. Captures use dummy audio, so put "listen to the mix" on the morning look list.

T10. Settings that persist
- One Options screen, reachable from the title and from pause: volume per bus; mouse sensitivity; invert look; camera shake or bob on or off if any exists; field of view within 10 degrees of today's value; fullscreen or windowed; VSync; 3D render scale 50 to 100 percent; graphics quality Low, Medium, High (High is the T5 look; Low must measurably lower GPU frame time); subtitles on or off; HUD text size.
- Store in user://settings.cfg (ConfigFile), separate from the save. Defaults match tonight's look and today's feel. A missing or corrupt file gives defaults.
- Tests: round trip; corrupt file; each setting changes what it controls. Screenshot the screen. Ride gate.

T11. Pause that behaves
- Esc or Start pauses. The round clock does not move while paused. Menu: Resume, Restart round, Options, Quit to title.
- Restart resets the round cleanly: fences up, clock zero, faults zero, horse at the start. Quit to title records and saves nothing from the partial round.
- Tests for each. Screenshot. Ride gate.

T12. Results card
- After a round: class name; faults by fence (which numbers had a rail or a stop); time against time allowed; time faults; ribbon; personal best when it is one; Michelle's line. Buttons: Ride again, Next class (when unlocked), Back to the barn. The jump-off offer and the Stay path work exactly as today.
- Everything comes from existing GameState values. No rule changes.
- Tests: six synthetic rounds (clear, one rail, a refusal, elimination, time faults, jump-off) show the right numbers. Screenshot each.

T13. Season map
- A screen reachable from the title showing the whole ladder from SHIP.json in order: Lessons 1 to 4; Schooling: Crossrails 2'3", Schooling Jumpers 2'6", Open Jumpers 3'0"; Show day: Welcome Stake, Classic, Hidden K Mini Prix. Each shows locked, open, or done, with best time and ribbon. Choosing one starts it the way the title buttons do now. Keep the existing title buttons.
- Use the existing unlock rules unchanged.
- Tests: from a fresh save, completing classes in order through the existing unlock functions opens every class and orphans none. Screenshot.

T14. First ride with Michelle
- Fresh saves only: Michelle walks Madison through walk on, trot, canter, steering, whoa, the half-halt (hold to collect, release to ask), a ground pole, and a first cross-rail. Each step shows one short instruction naming the right key or button for the last device used, and completes when the player does it. Skip tutorial is always available.
- Save a tutorial_done flag. Migration: any existing save with progress gets tutorial_done = true, so Madison is never forced through it.
- Reuse Michelle's existing lines where they fit. New lines: one sentence, 14 words or fewer, no em dashes.
- Tests: drive every step with simulated actions; skip works; a copy of Madison's snapshot loads with tutorial_done = true. Screenshot two steps. Ride gate.

T15. Sharp on any screen
- project.godot uses stretch mode viewport with the default keep aspect, so 3D renders at a fixed 1920x1080 and is scaled: soft on 4K, black bars on 16:10 and ultrawide. Switch to canvas_items with aspect expand so 3D renders at native resolution, and make the HUD and every menu anchor correctly. Render scale (T10) handles performance.
- T7 layout tests pass at every size. Capture the UI and ride shots again. Ride gate.

T16. Second visual pass
- Keep working down visual_backlog.csv (materials that look like plastic, textures at the wrong scale, trees and props that read badly from the ride camera) with the same loop and budgets. Rule 3 limits still apply.

T17. Unused asset audit, no deleting
- Write dist/day12/unused_assets.csv: every file under game/assets with its path, bytes, and where it is referenced (scripts, scenes, shaders, .tres, JSON; search for the res:// path and the file name). Mark unused files that export_presets.cfg still packs. Summarize the count and MB in the log. Delete and move nothing. The proposal goes under NEEDS ERNIE.

T18. A map for the next agent
- docs/ARCHITECTURE.md: what each script owns, key functions with line numbers, the frozen list and why, where new code goes, how to run each gate, the shots tool, and the visual loop.

T19. Final captures and the morning report (always, by MORNING)
- At MORNING minus 75 minutes: capture the full set to dist/day12/shots/final/. Make a baseline-vs-final sheet for every shot, and one before/after sheet per kept change.
- Then no more windows. Quick gate, plus the ride gate with all three ids if any ride-touching task was committed. Confirm no Godot is running.
- At the top of dist/DAY12_LOG.md, in this order:
  1. Branch and commits, one line each.
  2. What Madison would notice, in plain words.
  3. The sheets to open first, in order, with paths.
  4. Morning look list: about 10 minutes of things for Ernie to try in Godot, each with steps.
  5. Numbers: BASELINE against now, for rides, performance, and telemetry.
  6. STASHED and BLOCKED tasks with reasons.
  7. NEEDS ERNIE, including what the backlog says cannot be fixed without new models.
  8. BLACKLIST.
  9. Confirmation: Madison's save matched all night, no .exe touched, version 2.348.0.0, nothing pushed, no Godot running.

If every task is done early, keep working down visual_backlog.csv with the same loop until MORNING minus 75 minutes. Do not invent new features.
