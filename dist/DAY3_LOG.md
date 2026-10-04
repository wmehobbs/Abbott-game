# Day 3 log — Abbott 2.348.0.0

Headless only. Product version not bumped. `dist\Abbott.exe` not launched. Yesterday's `dist/DAY_LOG.md`, `dist/DAY_MEASURE.md`, `dist/DAY2_LOG.md`, and `dist/DAY2_MEASURE.md` were not overwritten.

The hear line, the 320 ship lines, the courses, and `ride_ai.gd` stay as they were this morning.

## Rows

| hypothesis | files | command | result | decision |
| --- | --- | --- | --- | --- |
| A COUNT line with the fence number, the stride, and whether speak_soft kept it makes the 23 rides readable. One silent line per unlined approach. | `game/scripts/horse.gd`, `game/scripts/game_state.gd` | `--playtest` via `dist/_run_userarg.py` | clear faults=0, refuse faults=4, `FENCE knock 3 by horse`, rail faults=4, `PLAYTEST done pass=true`. COUNT lines are one per word change, not per frame. Godot exit 0. Watch printed DONE. No window. | keep the print. Start the 23. |
| Twenty-three courses, one Godot each, then the table | none | `python tools/content_factory/run_ridecert.py --ridecert-id <id>` via `dist/_day3_ride.py` | 23 logs in `dist/day3/`. 23 rows. 45 fences are too short, including `hk_beg_033` fence 2. 55 stride 1 or 2 lines dropped on 19 courses. 134 silent fences. No window. `hk_adv_001` exited 1 because the round is a time fault, 12/12, no rail, 91.6 s. That log was kept. | phase 1 kept. Do not fix the too-short fences. |
| A dropped stride line may speak over the 3.8 s hold | `game/scripts/game_state.gd` `speak_soft` only | re-ride the 19 ids that dropped a stride 1 or 2 line, logs `dist/day3/<id>.after.log` | All 55 dropped stride lines are `kept=true`. Largest time move is `hk_int_002` 80.3 to 80.18. No new rail. None teleported. Faults unchanged. The 3.8 s hold and `last_leave` were not touched. | keep |
| Come again at 8 m, try 1 | `game/scripts/horse.gd` | `hk_les_001` and `hk_adv_001`, then the other 21 | Lesson says it only on fence 2. Mini Prix says it on fences 7 and 9, and on every phase-1 silent fence. Four fences stayed quiet: `hk_beg_034` 4 and 8, `hk_beg_033` 8, `hk_int_005` 3, `hk_adv_002` 1. Their silent sample was past 8 m and she lined up before the sentence. | try 2. Same line, 8 m becomes 11 m. |
| Come again at 11 m, try 2 | `game/scripts/horse.gd` one line | try pair, then the four quiet courses | Lesson still only fence 2, twice, 18.53 s. Mini Prix still fences 7 and 9, 91.6 s, faults 2, no rail. The four quiet fences now say it. All 23: every phase-1 silent fence says Come again, and no other fence does. `hk_beg_033` fence 2 does not. No lesson or beginner was without a silent fence, so that empty set was not ridden. Clears stay clear. Clock courses stay time-only. Largest move 0.02 s. | keep. Two tries. Not a third. |
| One full board against the coaching table | none | `python tools/content_factory/run_ridecert.py` | `pass=false board=21/23 style=true`. Godot exit 1 is the two clock courses. Every clear still clears. No teleport. No new rail. Largest clear move is `hk_beg_034` 63.44 to 63.52, under 0.1 s. `hk_adv_001` 91.61 unchanged, faults 2, no rail. `hk_adv_003` 93.99 to 94.01, faults 3, no rail. Style on `hk_beg_035` is clear 0, refuse 4, rail 4, same shape as yesterday. Watch printed DONE. No window. Copied to `dist/day3/board.log` and `dist/day3/board.json`. | keep. No second board. |
| Day-one horse on the six rounds within 4 s of the clock | none | `python tools/content_factory/run_ridecert.py --ridecert-fresh --ridecert-id <id>` | Confirmed on `dist/day3/board.json`: `hk_int_001` 90.84, `hk_int_005` 92.28, `hk_int_007` 84.93, `hk_int_009` 85.0, `hk_adv_001` 91.61, `hk_adv_003` 94.01. Fresh logs are `dist/day3/<id>.fresh.log`, `fresh=true`. None added a rail. None looked. `refused=[]` and `rail_fences=[]` on all six. The four intermediates stay clear. The two Mini Prix stay time-only, faults 2 and 3. | finding, not a patch. Do not retune. |

## Close

23 of the 23 course files exist in `dist/day3/`, and the measure has 23 rows.

Playtest: clear faults 0, refuse faults 4, rail faults 4, the knock fired, `pass=true`.

Board against yesterday's coaching table: **21/23**. Every clear still clears. No new rail. No teleport. Largest clear move is `hk_beg_034`, +0.08 s. The clock courses are `hk_adv_001` 91.61 s, faults 2, and `hk_adv_003` 94.01 s, faults 3. Neither gained a rail. Beginner style is still clear 0, refuse 4, rail 4.

Come again stayed. It speaks on a silent approach inside 11 m, and on no straight fence.

Files changed: `game/scripts/horse.gd` (the COUNT print and Come again), `game/scripts/game_state.gd` (a stride line, and Come again, may speak over the hold). The hear line, the 320 ship lines, the courses, and `ride_ai.gd` were not edited.

BLACKLIST: none. No window appeared.

`dist\Abbott.exe` was not launched and not rewritten. Last write 24 September 2026, 11:44. Version stays 2.348.0.0.
