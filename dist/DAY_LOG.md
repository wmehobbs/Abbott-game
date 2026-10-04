# Day log — Abbott 2.348.0.0

Headless only. Product version not bumped. `dist\Abbott.exe` not launched.

## Gate

| hypothesis | files | command | result | decision |
| --- | --- | --- | --- | --- |
| Playtest contract is clear 0, refuse 4, rail 4, knock fires, pass=true | none | `Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game -- --playtest` (UTF-8 log `dist/playtest_day.log`, CREATE_NO_WINDOW, no PowerShell redirect) | clear faults=0 complete=true; refuse faults=4; `FENCE knock 3 by horse`; rail faults=4; `PLAYTEST done pass=true`; GODOT_EXIT 0 | keep — gate passed, no edit |

## Rows

| hypothesis | files | command | result | decision |
| --- | --- | --- | --- | --- |
| First baseline board would finish 23 courses | none (the ride had already loaded scripts) | `python tools/content_factory/run_ridecert.py` | Log stopped mid `hk_int_002` at 10:17. Godot and the wrapper were gone. No window. Partial log kept at `dist/ridecert_godot.partial1.log`. Finished clears in that fragment: four lessons, six beginners, `hk_int_001` 90.84 s. Not a board. | restart the baseline. Not a keep and not a revert. |
| Restart compiles | `game/tools/leave_sweep.gd` (`var fence =`, no inferred type) | `python tools/content_factory/run_ridecert.py` | Log opened with a parse error on the old `:=` line, then `RIDECERT begin`. Finished `pass=false board=21/23 style=true`. Exit 1 is the two time faults. Board copied to `dist/day_baseline_board.json`. | keep as the morning baseline |
| Spoken count uses 3.35 and the horse's stride is far enough off to lie | `game/tools/stride_measure.gd` only | `--headless --stride` | speed 5.55 held. Exact cycles 13.68. Meters per stride 3.246. Difference from 3.35 is 0.104, inside 0.15. | skip. Do not edit the divisor. |
| A release inside Now with charge under balance_need always chips on a lesson fence, and a ship chip line should be promoted | none | `--headless --leave-sweep` | Lesson Now (1.9–3.2 m) was spot, rail=false, charge 0.05. Chip was only the shoulder. No chip line says hold-then-release. | skip. Do not reorder `michelle_ship.json`. |
| A day-one horse can finish the lesson, and hk_beg_033, without a look | none | `run_ridecert.py --ridecert-fresh --ridecert-id` for hk_les_001 and hk_beg_033 | Both clear, 18.53 s and 59.87 s, 0 faults, 0 rails, teleported false, no looked line. Same times as the pinned board. | keep the horse as it is. No flower change. |
| Schooling and show should hear Two / One / word while timing is under 55, and the speech should not move the horse | `game/scripts/horse.gd` hear line in `_lesson_count`; `game/scripts/game_state.gd` prints every kept `speak_soft` line | playtest, then `run_ridecert.py --ridecert-id hk_les_001`, `--ridecert-id hk_beg_033`, then one full `run_ridecert.py` | Playtest pass=true, clear 0 / refuse 4 / rail 4, knock fired. Lesson 18.54 s (morning 18.53), beginner 59.88 s (morning 59.87), both clear, teleported false, count in both logs. Full board 21/23, same two clock failures, 0 rails on every track. Largest move on a morning clear is hk_beg_004 +0.05 s. Clock courses 91.61 s unchanged and 93.99 s (−0.02). Style still 0 / 4 / 4. No window. Godot exit 1 is pass=false, not a crash. | keep |
| Moving hk_adv_003 fence 9 to the only high-scoring place_fence spot opens the line into the fence-10 come-again | `game/content/courses/advanced/hk_adv_003.json` fence 9, and the same file under `content/courses/advanced/` because place_fence copies it | `place_fence.py hk_adv_003 9` then `run_ridecert.py --ridecert-id hk_adv_003` | Fence 9 moved 6.81 m to (−0.10, 13.00), yaw +2.618, kind height spread number unchanged. Ride 100.95 s, 5 time faults, 12/12, 0 rails, teleported false. Coaching ride was 93.99 s and 3 time faults. 10→11 went 12.58 s to 16.24 s and 11→12 went 7.46 s to 13.35 s. No come-again line, but he was lost on both of those. Log `dist/ridecert_hk_adv_003_fence9.log`. | revert. Both copies put back from `dist/course_backup/hk_adv_003.*.json`. |
| Moving hk_adv_003 fence 6, the come-again fence, onto the best place_fence spot gives him a run he can count | same course, fence 6 only, after fence 9 was put back | `place_fence.py hk_adv_003 6` then `run_ridecert.py --ridecert-id hk_adv_003` | Fence 6 moved 6.84 m to (−1.60, 19.50), yaw −0.524. Ride 96.41 s, 4 time faults, 12/12, 0 rails, teleported false. Slower than 93.99 s. The come-again moved from fence 6 to fence 7. Fence 10's come-again was unchanged (12.55 s). Log `dist/ridecert_hk_adv_003_fence6.log`. | revert. Course stopped. Fence 10 has no legal spot, fence 5 has none, and fence 9 already failed. |
| Moving hk_adv_001 fence 7, the come-again fence, onto its only legal spot removes the circle | `hk_adv_001.json` fence 7, game copy and archive copy | `place_fence.py hk_adv_001 7` then `run_ridecert.py --ridecert-id hk_adv_001` | Fence 7 moved 2.47 m to (9.40, 29.50), yaw +0.698. Ride 85.88 s against 91.61 s, 12/12, teleported false, but rails 1 (`FENCE knock 6` during the come-again to 9) and faults 5. Log `dist/ridecert_hk_adv_001_fence7.log`. | revert. Faster with a rail goes back. Both copies match `dist/course_backup/hk_adv_001.*.json`. |
| The come-agains are the rider choosing a circle on a straight line that has room | none | fresh rides of hk_les_001 and hk_beg_033, plus the morning segments | Fresh rides had no come-again and no look. The slow circles are on hk_adv_001 and hk_adv_003, where the run after landing is a few meters and the offset is 9–16 m. Not a straight line with room. | skip. Do not edit `ride_ai.gd`. |

## Close

Playtest after the coaching edit: clear faults 0, refuse faults 4, rail faults 4, knock fired, `pass=true`. Godot exit 0. Log `dist/playtest_day.log`.

Board against this morning: still 21/23. Same two clock failures (`hk_adv_001` 91.61 s, `hk_adv_003` 93.99 s against 94.01 s). Every morning clear still clears. No new rail. No teleport. Largest move on a morning clear is `hk_beg_004` +0.05 s. Coaching kept. Three fence moves reverted. No third board, because nothing from phase 4 was kept. Phase 5 tables are in `dist/DAY_MEASURE.md`.

Files that stay changed: `game/scripts/horse.gd` (schooling and show hear the count while timing is under 55), `game/scripts/game_state.gd` (a kept soft line is printed), `game/tools/stride_measure.gd`, `game/tools/leave_sweep.gd`. Course files are back to the morning bytes. `ride_ai.gd` and `michelle_ship.json` were not edited. Takeoff, the leave bands, the window scales, gait speeds, and the knock box were not edited.

BLACKLIST: none. No window appeared. No artshot, no editor, no F5.

`dist\Abbott.exe` was not launched and was not rewritten. Its last write is 2026-09-24 11:44. Product version stays 2.348.0.0.


