# Grok Build — one day, headless, the ride

You are Grok Build in `E:\Workspace\Madison`. Ernie is at the machine and will not watch you. Tokens are cheap. A Godot window is a failed day: it locks the mouse and the keyboard. The game stays closed.

Product is Abbott **2.348.0.0**. Do not bump it. Do not export. Do not launch `dist\Abbott.exe`.

Godot, console build only:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

## Silent

`--headless` is the first argument after that exe. If it is not, do not run the command.

Rides go through `python tools/content_factory/run_ridecert.py`. That wrapper already passes `--headless` and `CREATE_NO_WINDOW`, and writes a UTF-8 log. Use it. Do not invent a second launcher. Do not redirect Godot through PowerShell (`>`), which writes UTF-16 and hides the board.

Playtest, when you need the fast check:

`Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game -- --playtest`

Stdout is the evidence. Read the log. One Godot process. If any Godot is already running, do not start another and do not taskkill it. Do Python work until it exits, and write `WAIT` plus the process name in `dist/DAY_LOG.md`.

Forbidden, all day:

- `dist\Abbott.exe`, `Start-Process` on it, the editor, F5, F6, a debug window
- `--artshot`, `--artshot-rider`, any screenshot pass
- A second Godot of any kind
- Export, pack, or a version bump

If a window appears anyway, close it immediately, write the exact command in `dist/DAY_LOG.md` under `BLACKLIST`, and do not retry it.

## What this game is

Madison rides Abbott in one outdoor ring at Hidden K. The skill is seeing a distance and leaving the ground with him. Lesson, then schooling (2'3" / 2'6" / 3'0"), then Table A. Walk on foot with C, mount with Enter. W/S is the gait ladder. A/D steers. Space held is the half-halt. Space released at the canter is the ask. Early is a refusal. Late or a chip is a rail.

The live board is 23 courses in `game/content/courses/SHIP.json` (4 lesson, 6 beginner, 6 intermediate, 4 advanced, 3 jump-offs). The 25k pile under `content/courses/` is archive. Do not ship it. Do not raise quotas. Do not delete it.

## What is already true — do not redo it

- `--playtest` is the teleport unit test. Contract: clear 0 faults, refuse 4, rail 4. Knock still fires on the rail round.
- `--ridecert` is the real ride. Same keys as a person. No teleport. Last honest board was **21/23, twice, times within 0.1 s**. `hk_adv_002` and `hk_adv_005` clear. `hk_adv_001` ~91.6 s and `hk_adv_003` ~94.0 s jump 12/12 with no rails and lose on time faults. A clear at advanced needs **t < 84** against an allowed 80. Come-agains, not rails, are why those two are slow. Remeasure. Do not trust a number you did not just print.
- The cert pins confidence 85, scope 80, rideability 44, timing 38, feel 36 so a flower never spooks. Day-one defaults in `game_state.gd` are **48 / 40 / 44 / 38 / 36**. `--ridecert-fresh` rides the defaults. A save that has drifted to 100/100/100 is not the game.
- Leave math in `horse.gd` `_try_leave` is the game. TAKEOFF **2.55**. Ideal is `|ahead − 2.55| ≤ 0.55·window_scale`. Early (refusal) is `ahead > 2.55 + 1.05·window_scale`. Late is `ahead < 2.55 − 0.80·window_scale`. Ask outside 0.50–5.4 does not register. `window_scale` is 1.24 lesson, 1.16 beginner, 1.0 intermediate, 0.88 advanced. **Do not retune these.**
- Canter is 5.55 m/s, `STRIDE_HZ` 1.71, so a stride is about **3.25 m** if the horse actually holds that speed. `_lesson_count` still divides by **3.35**. Those two numbers disagree. Measure the horse. Do not assume the comment.
- The count ("Two. Wait." / "One. Now.") is spoken only when `session_kind == "lesson"`. Schooling and show are silent until the rail or the refusal. That is the hole.
- Knock Area stays `(width*0.9, height+0.15, 0.35+spread)`. Width, height, spread, and position of that box stay put.
- People, saddle, reins, and trees have had their passes. You cannot see a mesh today. Do not open `person_look.gd`, `abbott_look.gd`, `rider_mesh.gd`, or `farm.gd` unless a headless playtest fails to compile because of them.
- `content/rail/LESSON_BEATS.json` is a huge unwired file. Do not wire it.
- No Jev, no LLM, no new horse, no new class, no fourth fence kind, no indoor class.

## What "more playable" means today

A rider who does not yet have a feel can hear the last two strides, and the word matches the stride the horse actually covers. A day-one horse can finish the lesson. A distance that is not a whole stride is written down, and a fence moves only when a measured ride gets faster with zero rails. Courses that already clear stay cleared, to 0.1 s.

## Frozen

Do not edit, even if a measurement tempts you:

- TAKEOFF, the early / late / ideal bands, `window_scale`, `refuse_scale`, `balance_need`, `GAIT_SPEED`, `GAIT_TURN`, `STRIDE_HZ`
- The knock box
- Course kind, height, spread, or fence number
- `NEAR_FENCE_M` 4, `AT_FENCE_M` 1.5, `LINE_CORRIDOR_M` 2
- Sand and wood albedo
- The 25k archive, quotas, Michelle's 48k pile at `content/rail/michelle.json`

`ride_ai.gd` changes only if a fresh cert shows the rider doing something a person would not (a come-again on a straight line with room, a release outside the window). One change, then that id again. Revert unless that id is faster or equally fast, still zero rails, `teleported=false`.

## Budget

A full `--ridecert` is about 70 minutes. You may run it **three times**: baseline, after the coaching change, and once more only if a kept fence move or a ride_ai change needs the whole board. Single-id rides are `--ridecert-id` and are the normal proof. Playtest is the compile check and stays short.

Do not ask Ernie anything. Decide from the log. If a step has no measured reason, skip it and write why.

Write `dist/DAY_LOG.md` after every keep and every revert, before the next edit. One row: hypothesis, files, command, result, keep or revert. Append. Do not overwrite the morning baseline.

## Phase 0 — gate

1. `Get-Process *Godot*`. If anything is live, Python only, until it is gone.
2. Headless `--playtest`. It must print clear 0, refuse 4, rail 4, `pass=true`. If it fails, stop feature work and fix the compile or the regression. Re-run playtest. Do not continue on a red playtest.
3. One full board: `python tools/content_factory/run_ridecert.py`
4. `python tools/content_factory/board_table.py` and copy the table into `dist/DAY_MEASURE.md`. Copy `dist/ridecert_board.json` to `dist/day_baseline_board.json` before any later ride overwrites it. Segment times come from `dist/ridecert_godot.log` for this run, not from `dist/ridecert_logs/`.

## Phase 1 — measure, no behavior change

All of this is written into `dist/DAY_MEASURE.md` with the numbers from the run, not from this prompt.

**Stride ledger.** Python over the 23 ship JSON files only (`game/content/courses/`, ids in `SHIP.json`). For every fence-to-fence leg and every labeled `related`: ground distance, labeled stride count, implied meters per stride, turn from the previous takeoff yaw. Flag a related whose implied stride is outside **3.05–3.45 m**. That band is the question, not a license to edit.

**Canter stride, from the horse.** Add `game/tools/stride_measure.gd`, started the same way playtest starts (a user arg `--stride` checked beside `--playtest` in `title.gd` and `arena.gd`). Headless. Canter in a straight line on the sand for 8 seconds. Print speed, footfall count, and meters per stride. Then quit. Delete nothing else. If meters per stride disagrees with 3.35 by more than 0.15, the spoken count is lying. The only legal fix is the divisor inside `_lesson_count` (the `3.35` in that function and the comment next to it). Leave TAKEOFF alone. Playtest, then `--ridecert-id hk_les_001`. The lesson must still clear, 3/3, and the log must show Two / One / Now on the way in. If `hk_les_001` gains a fault or moves by more than 0.3 s, revert the divisor.

**Leave sweep.** Add `game/tools/leave_sweep.gd` and a `--leave-sweep` user arg, same boot path as playtest, still headless. On one lesson fence and one beginner vertical, release Space at 0.1 m steps from 0.4 m to 5.6 m, horse lined up, canter, charge at a recorded value. Print `ahead`, the speak key (`early` / `deep` / `chip` / `spot` / `leave` / none), and whether a rail was asked. Quit. This is the feel, in a table. Do not change the bands to make the table prettier.

**Day-one ride.** `python tools/content_factory/run_ridecert.py --ridecert-fresh --ridecert-id hk_les_001` and the same for one beginner id (`hk_beg_033`, the shortest clear on the old board — confirm the id still exists, else the first beginner in `SHIP.json`). Record faults, time, and any `looked` refusal. A flower look uses `(48 − confidence) / 140`, so at confidence 48 the chance is already 0. Do not "fix" flowers unless this log shows a look.

**Coaching hole.** Confirm in code, and write the line number, that `_lesson_count` returns immediately unless the session is `lesson`. That is the change in phase 2. Do not make it yet.

**Michelle.** Read `game/content/rail/michelle_ship.json` only (336 lines). For keys `early`, `deep`, `chip`, `spot`, `leave`, `straight`, `looked`, `wrong`, `halt`: count lines, and mark any line that does not name the thing that happened (early, deep, chip, the spot, a look, the wrong fence). Write the weak ids. Do not generate new sentences. If you replace one, replace it with a sentence already in that ship file, still max 14 words, still one sentence.

## Phase 2 — say the distance until she has it

This is the day's feature. In `_lesson_count`, speak the same Two / One / word on schooling and show when `madison_timing < 55`. Lesson behavior stays. The words stay the ones `_leave_word` already returns: Wait, Early, Now, Too deep. No new vocabulary. `speak_soft` only. Do not press inputs. Do not alter speed, charge, gait, or the ask.

The cert horse's timing is 38, so the words will fire during a board run. That is the test that speech is free.

Proof, in order:

1. Headless playtest. clear 0 / refuse 4 / rail 4. Knock fires.
2. `--ridecert-id hk_les_001` and `--ridecert-id hk_beg_033` (or the beginner you measured). Both still clear, `teleported=false`, times within 0.3 s of this morning's baseline. The log shows the count on the beginner, not only the lesson.
3. One full `--ridecert`. Compare to `dist/day_baseline_board.json` with `board_table.py`. Every id that cleared this morning still clears. No new rail. No time moves by more than **0.1 s** except the two clock failures, which may move by 0.3 s and must not gain a rail. If any of that fails, revert the coaching and write the revert. Do not tune around it.

## Phase 3 — half-halt, only if the sweep says so

From the leave sweep: if a release inside the ideal band with `charge` below `balance_need()` always takes the `chip` path on a lesson fence, the lesson is punishing a missing half-halt without having named it. Check the ship `chip` lines. If none of them say to hold and then release, promote one existing ship line that does, by ordering inside the ship file only. Do not add a line. Do not change `balance_need`. Re-run the sweep and playtest. No full board unless phase 2's board has not run yet — this change must not touch the horse, so a playtest plus `hk_les_001` is enough. If times move, you touched the horse. Revert.

## Phase 4 — the two slow Mini Prix, capped

Only after phase 1's ledger and this morning's segment log agree.

Open `hk_adv_001` and `hk_adv_003` segment times from `dist/ridecert_godot.log`. The old failure mode was come-agains into fences that ate 11–13 s. For each come-again segment, look at the ledger. Move a fence only when all of these are true:

- The related stride, if labeled, is outside 3.05–3.45 m per stride, **or** the segment is a come-again on a line a person could not count
- You use `tools/content_factory/place_fence.py` / `ride_place.py` as they exist. Same hard constraints those tools already enforce (ring, corridor, leash, yaw cap, kind / height / spread / number unchanged). Do not relax them. Do not hand-edit a coordinate to skip the tool.
- That id, ridden headless, is faster, 0 rails, 12/12, `teleported=false`
- Otherwise the fence goes back exactly where it was

**At most four fence moves all day**, each one fence or one rigid pair, each proved before the next. If every legal candidate is slower or adds a rail, stop that course. A placement that reads better and rides worse is a revert. Do not chase 23/23. Two clears that got slower are a failed day even if the two clock courses finally duck under 84.

If you kept any move, one full board (this is the third, if phase 2 used one). Same 0.1 s rule. Revert the move if any other id breaks.

## Phase 5 — fill the day only with evidence

If phases 2–4 are done and the board is still honest, do not invent a feature. Spend the rest of the day on tables, appended to `dist/DAY_MEASURE.md`:

- Every ship related, sorted by how far its stride is from the measured canter stride
- The leave-sweep table next to the band math, so a person can see how wide Now is at each class (it gets narrower at 3'0"; that is intended)
- Fresh vs pinned on the lesson and one beginner
- Which Michelle keys are vague
- A one-page "what a rider feels" note: gait speeds, the Space rule, when the count is spoken, what Early / Too deep / chip do

No new scenes. No new UI panels. A label is allowed only if a headless probe prints its text. You will not see it.

## Stop

Stop, write `dist/DAY_LOG.md` closing section, and do not start another Godot, when any of these is true:

- Phase 2 is kept or reverted, phase 4's cap is spent or skipped, and phase 5's tables are in the file
- Three full boards have finished
- A window appeared
- You are about to edit leave bands, the knock box, gait speeds, or a course file by hand

The last lines of `dist/DAY_LOG.md` are: playtest result, board score against this morning, files changed, commands blacklisted, and whether `dist\Abbott.exe` was left untouched. It must have been.
