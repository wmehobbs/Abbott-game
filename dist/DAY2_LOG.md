# Day 2 log — Abbott 2.348.0.0

Headless only. Product version not bumped. `dist\Abbott.exe` not launched. Yesterday's `dist/DAY_LOG.md` and `dist/DAY_MEASURE.md` were not overwritten.

## Rows

| hypothesis | files | command | result | decision |
| --- | --- | --- | --- | --- |
| Playtest still clears 0, refuses 4, rails 4, and the knock fires | none | `Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game -- --playtest` via `dist/_run_userarg.py` | `PLAYTEST clear faults=0`, refuse faults=4, `FENCE knock 3 by horse`, rail faults=4, `PLAYTEST done pass=true`. Godot exit 0. Both processes had `MainWindowHandle` 0. | keep — gate passed, no edit |
| The 3.8 s hold swallows Two / One on the beginner, so the count dies after the first fence | none | counted `MICHELLE soft` in `dist/ridecert_hk_beg_033_coaching.log` and `dist/ridecert_godot.coaching.log` | `hk_beg_033` shows a Two or a One on 7 of 8 fences in both logs. Fence 2, the one-stride, has Early / Wait / Now and no Two or One. The other seven have the count. The full board's other courses are the same shape: a missing Two / One is the exception, not the course. | skip phase 1. Do not edit `speak_soft`. No full board. The gate was six of eight. |
| Schooling and show go quiet after one clear Crossrails, because four lessons land on 54 and the fifth clear crosses 55 | `game/scripts/horse.gd` hear line only. Probe wiring: `game/tools/hear_probe.gd`, `game/scripts/title.gd`, `game/scripts/arena.gd` | `--hear` via `dist/_run_userarg.py`, then `--playtest` the same way, then `python tools/content_factory/run_ridecert.py --ridecert-id hk_beg_033` | Probe `dist/hear_day.log`: timing 38 hear, timing 60 beginner clears 0 hear, timing 60 beginner clears 2 silent, timing 60 intermediate clears 0 (beginner already 2) hear. `HEAR done pass=true`. Playtest still clear 0, refuse 4, knock, rail 4, `pass=true`. `hk_beg_033` faults 0, 8/8, t=59.86, teleported=false. Yesterday's board was 59.87 and the single-id coaching ride was 59.88. Move is 0.01 s and 0.02 s. Two or One still on 7 of 8. Fence 2 is still Early / Wait / Now. Godot exit 0. No window. | keep. The +4 was not changed. No second full board. |
| Come again on the Mini Prix fences that are not a line | none | not run | Phase 1 was skipped, so it was not kept. Come again was allowed only after that keep, and it needs the stride bypass phase 1 would have put in `speak_soft`. That bypass was not added just so this sentence could talk. | skip phase 3. Do not edit `horse.gd` again. Do not ride `hk_adv_001` for this. |
| Ten lines that never name the event come out of the ship pool, then the other 192 are scored the same way | `game/content/rail/michelle_ship.json` only | `--playtest` via `dist/_run_userarg.py` | 16 objects removed, 320 left, no new sentence, order kept. Early 12, deep 15, chip 14, spot 15, straight 15, looked 15. Second pass: rail_14, refuse_06, off_course_12, lesson_start_08, jump_off_10, ribbon_08. Each of those keys still has 15. Leave, wrong, and halt stay at 16. No key was left weak because it would have gone under 8. Playtest: clear faults=0, refuse faults=4, `FENCE knock 3 by horse` while jumping, rail faults=4, `PLAYTEST done pass=true`. Godot exit 0. Watch printed DONE. No window. | keep. No ride cert. |

## Close

Playtest after the ship edit: clear 0, refuse 4, rail 4, knock fired, `pass=true`, Godot exit 0.

Board against yesterday's coaching table: not re-ridden. The one full board was allowed only after a swallow fix, and phase 1 was skipped because `hk_beg_033` already had a Two or a One on 7 of 8 fences. Yesterday's board stays 21/23. The only proof ride was `hk_beg_033`: clear, teleported false, 59.86 s against yesterday's 59.87 s board and 59.88 s single-id. Inside 0.1 s. No new rail.

Files changed: `game/scripts/horse.gd` (hear line only), `game/tools/hear_probe.gd` (new), `game/scripts/title.gd` (`--hear`), `game/scripts/arena.gd` (probe, then return, no arena ride), `game/content/rail/michelle_ship.json` (16 lines removed). This day wrote `dist/DAY2_LOG.md` and `dist/DAY2_MEASURE.md`. `speak_soft`, `ride_ai.gd`, the courses, the +4, and the leave math were not edited.

BLACKLIST: none. No window appeared.

`dist\Abbott.exe` was not launched and not rewritten. Last write 24 September 2026, 11:44. Version stays 2.348.0.0.
