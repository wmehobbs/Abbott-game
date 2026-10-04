# Grok Build — the long day, one course at a time

You are Grok Build in `E:\Workspace\Madison`. Ernie is at the machine and will not watch you. A Godot window locks the desktop. The game stays closed.

This day is long on purpose. The last two finished in an hour because a gate let you skip the rides. There is no such gate today. You do not get to be done after `hk_beg_033`. You do not get to be done after the four lessons. You do not get to decide the other twenty-two courses from one beginner log.

Product stays **2.348.0.0**. Do not bump it. Do not export. Do not launch `dist\Abbott.exe`. Last write 24 September, 11:44. Leave it.

Godot, console build only:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

Yesterday's files stay as they are: `dist/DAY_LOG.md`, `dist/DAY_MEASURE.md`, `dist/DAY2_LOG.md`, `dist/DAY2_MEASURE.md`. This day writes `dist/DAY3_LOG.md`, `dist/DAY3_MEASURE.md`, and one log per course under `dist/day3/`.

## What already stays

The hear line stays. Lesson always hears the count. Schooling and show hear it while timing is under 55, or while that class has fewer than two clears. The probe already printed hear, hear, silent, hear. Do not edit that condition. Do not change the +4.

The ship pool stays at 320 lines. Do not put the sixteen back. Do not cut more. Do not write a new sentence.

Coaching board, not re-ridden since, is still 21/23. `hk_adv_001` 91.61 s, `hk_adv_003` 93.99 s, both time faults only. `hk_beg_033` after the hear change was 59.86 s, clear, 8/8, not teleported. Fence 2 on that course is Early / Wait / Now and has no Two or One. That is a one-stride. Two strides out is 2.55 + 2×3.35 = 9.25 m, and a one-stride related is about 7.5 m including the jump, so the horse never reaches "Two." Missing Two there is not a bug. Do not teach her to say Two inside one stride.

`speak_soft` still drops a line when `trainer_until > 1.4` and `last_leave` is set. That may be eating a count on a longer line, or it may not. One beginner log cannot say. You will find out from twenty-three rides, each with a fence number on the line.

Come again was not added. It is part of today. It is not waiting on a swallow fix.

Three fence moves were reverted yesterday's yesterday. Do not run `place_fence.py`. Do not edit a course file. Do not edit `ride_ai.gd`.

## Silent

`--headless` is the first argument after the exe. If it is not, do not run the command.

A ride is `python tools/content_factory/run_ridecert.py --ridecert-id <id>`. That wrapper passes `--headless` and `CREATE_NO_WINDOW`. A playtest or the hear probe, if you need one, goes through `python dist/_run_userarg.py --playtest` (or `--hear`). It refuses an empty arg and it refuses artshot.

One Godot. If any Godot is already running, wait. Do not taskkill a ride that is still printing. Do not start the next id beside it.

The wrapper opens `dist/ridecert_godot.log` with `"w"`. The next id erases it. Before you launch the next id, copy that log to `dist/day3/<id>.log`. If the copy is missing, you have not finished that course.

Forbidden all day: `dist\Abbott.exe`, the editor, F5, F6, `--artshot`, `--artshot-rider`, a second Godot, export, pack, a version bump, PowerShell `>` on Godot.

If a window appears, close it, write the command under `BLACKLIST`, and do not retry that command.

A course that prints no `RIDECERT round` within 2 minutes is a compile error. Kill only that process. Fix the script. Ride that id again. Do not skip it.

Wall clock, not a wish: a lesson or a jump-off is about 8 minutes, a beginner or intermediate about 10, an advanced about 12, the full board about 70. Budget the day to that. Do not batch the twenty-three into one SceneTree. A full board is a different job, later, and it does not replace the twenty-three files.

## Frozen

Do not edit:

- The hear condition in `_lesson_count`
- TAKEOFF, the early / late / ideal bands, `window_scale`, `refuse_scale`, `balance_need`, `GAIT_SPEED`, `GAIT_TURN`, `STRIDE_HZ`, the 3.35 divisor
- `_school_from_round`
- The knock box
- Any course JSON, either tree
- `ride_ai.gd`, `person_look.gd`, `abbott_look.gd`, `rider_mesh.gd`, `farm.gd`
- `michelle_ship.json`
- `NEAR_FENCE_M`, `AT_FENCE_M`, `LINE_CORRIDOR_M`
- The 25k archive, the 48k Michelle pile, sand and wood albedo

No new horse, class, fence kind, Jev, or LLM.

## The twenty-three, in this order

Ride them in this order. One process each. Copy the log. Write one row in `dist/DAY3_MEASURE.md` for that id. Then the next. Do not reorder to do the short ones and stop.

1. `hk_les_001`
2. `hk_les_002`
3. `hk_les_003`
4. `hk_les_004`
5. `hk_beg_035`
6. `hk_beg_039`
7. `hk_beg_004`
8. `hk_beg_034`
9. `hk_beg_007`
10. `hk_beg_033`
11. `hk_int_001`
12. `hk_int_002`
13. `hk_int_005`
14. `hk_int_006`
15. `hk_int_007`
16. `hk_int_009`
17. `hk_adv_001`
18. `hk_adv_002`
19. `hk_adv_003`
20. `hk_adv_005`
21. `hk_jo_beg_001`
22. `hk_jo_int_001`
23. `hk_jo_adv_001`

## Phase 0 — the line that makes the rides readable

Before the first id, add one print. No other behavior change.

From `_lesson_count`, every time you have a fence and a word you are about to pass to `speak_soft`, print:

`COUNT fence=<n> ahead=<m> lateral=<m> stride=<0|1|2> word=<words> kept=<true|false>`

`speak_soft` returns whether it kept the line. A drop still prints, with `kept=false`.

Also, when the fence is in front (`ahead` between 0.8 and 11) but `lateral > 1.6`, so the count is cleared, print once per approach, not every frame:

`COUNT fence=<n> ahead=<m> lateral=<m> stride=-1 word=silent kept=false`

"Once per approach" means once until `next_fence` changes or she gets lined again. A silent print every physics frame will wreck the log and can move the clock. If a course's log is mostly COUNT lines, you did it wrong. Revert the spam, keep the one-line-per-change print, ride that id again.

Playtest once. Clear 0, refuse 4, rail 4, knock fires, `pass=true`. Then start the list. Do not start the list on a red playtest.

## Phase 1 — twenty-three files, then a table

Each `dist/day3/<id>.log` must contain the ride result (faults, time, teleported) and the COUNT lines. The row in `dist/DAY3_MEASURE.md` is copied from that file, not from memory of yesterday:

| id | faults | time | teleported | fences | fences with Two or One | fences with only a bare word | fences silent | dropped=true count |

A bare word is `Wait.` / `Early.` / `Now.` / `Too deep.` with no Two or One on that fence.

When all 23 rows exist, add a second table, still from those logs:

- **Too short.** The first COUNT on that fence has `stride` 0 or 1, and there is no `stride=2`. This is the one-stride case. `hk_beg_033` fence 2 is the example. Do not fix these.
- **Dropped.** `kept=false` on a stride 1 or 2 line. These are the swallow. Count them.
- **Silent.** `word=silent` and she still jumped the fence. These are the come-agains and the crooked approaches. List every one, with ahead and lateral.

If you are tempted to skip an id because yesterday's coaching log already had soft lines: those lines have no fence number and no `kept`. They do not fill a row. Ride it.

## Phase 2 — the swallow, only where the table shows a drop

If the dropped count across all 23 is zero, write that, and do not edit `speak_soft`. Go to phase 3.

If any stride line was dropped, then and only then: a stride line may speak even when `trainer_until > 1.4`. A stride line starts with `Two. ` or `One. `, or is exactly `Wait.`, `Early.`, `Now.`, or `Too deep.` Walk lines still yield. Do not shorten the 3.8 s hold. Do not clear `last_leave`. The COUNT print already records `kept`.

Re-ride only the ids that had a drop. Copy those logs to `dist/day3/<id>.after.log`. Every previously dropped stride line on those ids is `kept=true`. Times within 0.3 s of that id's phase 1 time, no new rail, not teleported. If an id gets worse, revert `speak_soft` and keep the print. Do not tune the hold.

## Phase 3 — Come again, on the silent fences, and nowhere else

This phase runs even if phase 2 changed nothing.

Add one soft sentence, `Come again.`, from the same place the silent COUNT is printed. It fires only when all of these are true:

- canter, not jumping, the hear line is on
- `word=silent` would have printed (ahead 0.8–11, lateral > 1.6)
- she is inside 8 m, or the straight run to the plane is under 8 m

Once per approach, same rule as the silent print. It uses the stride bypass if phase 2 added one. If phase 2 did not, `Come again.` may still speak over the 3.8 s hold. Nothing else may. It must not press a key or change speed, charge, gait, or the ask.

Do not edit `ride_ai.gd`. Do not move a fence.

Proof, and this is another list, not a sample:

- Re-ride every id whose phase 1 row had a silent fence. `Come again.` must appear on that fence. Copy to `dist/day3/<id>.again.log`. Faults unchanged in kind: a clear stays clear, a clock failure stays a clock failure, no new rail. Time within 0.3 s.
- Re-ride every lesson and every beginner that had **no** silent fence. The log must contain **zero** `Come again.` Time within 0.1 s of phase 1. `hk_beg_033` fence 2 saying Early / Wait / Now is not a come-again. If it says `Come again.`, the predicate is wrong.

You get four tries at the predicate. Each try is a revert of the sentence, a one-line change to the numbers, and a re-ride of `hk_les_001` plus one silent advanced fence (`hk_adv_001` fence 7 or 9, if phase 1 marked it silent; otherwise the first silent fence in the table). If the fourth try still nags a straight lesson or stays silent on the advanced fence, take the sentence out, leave the COUNT print, and write the four tries in the log. Do not spend a fifth. Do not "fix" it by editing the rider or the course.

## Phase 4 — one full board, required

After phase 3 is kept or pulled out, run one full `python tools/content_factory/run_ridecert.py`. Not before. This is the board the hear-line day never rode.

Copy `dist/ridecert_godot.log` to `dist/day3/board.log` and `dist/ridecert_board.json` to `dist/day3/board.json` before anything else launches.

Compare to the coaching table in `dist/DAY_MEASURE.md`. Every id that cleared still clears. No new rail. No teleport. No clear moves more than **0.1 s**. The two clock courses may move 0.3 s and must not gain a rail. Style on the beginner is still clear 0, refuse 4, rail 4.

If the board breaks, revert the last keep (Come again if it was kept, otherwise the swallow edit, otherwise the COUNT print) and ride the full board once more. That is the second board, and it is the last one. If the second also breaks, revert back to the tree as it was at the start of today, playtest, and stop.

## Phase 5 — only if the board is in and the twenty-three files exist

Do not start this if a board is still running. Do not start this instead of an id you have not ridden.

Ride `--ridecert-fresh` for each id that, on the pinned board, finished within 4 seconds of its allowed time. From the coaching table those are the intermediate rounds at 90.8, 92.3, 84.9, and 85.0, and both clock Mini Prix. Confirm the ids from `dist/day3/board.json` before you launch: `hk_int_001`, `hk_int_005`, `hk_int_007`, `hk_int_009`, `hk_adv_001`, `hk_adv_003`. Six rides. Day-one stats are 48 / 40 / 44 / 38 / 36. Copy each log to `dist/day3/<id>.fresh.log`.

Write whether the day-one horse adds a rail or a look the pinned horse did not. Do not retune confidence, flowers, or the window to make them match. A difference is a finding, not a patch.

## Stop

Stop only when all of these are true, or when you have reverted to the morning tree after two bad boards:

- `dist/day3/` has 23 course logs and 23 rows
- Phase 2 and phase 3 are each either kept or written up as a revert
- The full board has been compared to the coaching table
- Phase 5's six fresh rides are in, or you stopped because a window appeared

The last lines of `dist/DAY3_LOG.md`: how many of the 23 files exist, playtest result, board score against the coaching table, whether Come again stayed, files changed, blacklist, and that `dist\Abbott.exe` was not launched and not rewritten.

Do not ask Ernie. The next course is the one after the last file in `dist/day3/`.
