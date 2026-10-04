# Grok Build — Table A, the rules already written

You are Grok Build in `E:\Workspace\Madison`. Ernie is at the machine and will not watch you. A Godot window locks the desktop. The game stays closed.

The cert has ridden lessons and schooling. It has never ridden a show. The show rules are already in `game_state.gd`. You do not invent a new clock, a new refusal price, or a faster horse. You turn the cert to show, then you check the rules that are already there.

Product stays **2.348.0.0**. Do not bump it. Do not export. Do not launch `dist\Abbott.exe`. Last write 24 September, 11:44. Leave it.

Godot, console build only:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

Leave these alone: every earlier `dist/DAY*.md`, `dist/NIGHT*.md`, `dist/day3/` through `dist/day6/`, `dist/night/`. This day writes `dist/DAY7_LOG.md`, `dist/DAY7_MEASURE.md`, and logs under `dist/day7/`.

## What already stays

Come again is the morning test. Do not edit that block.

A fallen pole is stored as that fence's number. `hk_adv_001` schooling refuse is faults 11 and `rail_fences=[6]`. Its rail round is faults 10 and `[3, 6]`.

`save()` returns immediately when a user arg is `--playtest` or begins with `--ridecert`. That includes `--ridecert-show`. Do not weaken it.

The hear line, the +4, the 320 ship lines, the knock box, the leave math, `time_allowed`, `time_school`, `time_show`, and `time_limit` stay. Do not edit `ride_ai.gd`. Do not move a fence. Do not ride a clear board.

## Silent

`--headless` is the first argument after the exe. If it is not, do not run the command.

A show style ride is:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-show --ridecert-id <id>`

The wrapper already appends those args after `--ridecert` and passes `--headless`. It opens `dist/ridecert_godot.log` with `"w"`. Copy that log to `dist/day7/` before the next launch.

A playtest is `python dist/_run_userarg.py --playtest`. It is not a show.

One Godot. If any Godot is already running, wait. Do not taskkill a ride that is still printing. Do not start the next id beside it. Do not batch the twenty-three into one SceneTree.

Forbidden all day: `dist\Abbott.exe`, the editor, F5, F6, `--artshot`, `--artshot-rider`, a second Godot, export, pack, a version bump, PowerShell `>` on Godot, `place_fence.py`, a clear `--ridecert` of the whole board.

If a window appears, close it, write the command under `BLACKLIST`, and do not retry it.

No `RIDECERT round` within 2 minutes is a compile error. Kill only that process. Fix the flag. Ride that id again.

## The save, first

Before any Godot, copy

`C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json`

to `dist/day7/save_snapshot.json`. If the file is absent, the absence is the snapshot. After every Godot, the live file matches that snapshot. If it does not, copy the snapshot back, fix only the early return in `save()`, and ride that id again.

## The one edit

In `ride_cert.gd` `_setup`, a lesson stays a lesson. Any other class becomes `show` when `--ridecert-show` is present, and stays `schooling` when it is not. No other branch. Do not change how faults are added. Do not change ribbons. Do not change the time-limit elimination in `tick`.

## Schooling still means schooling

Before any show ride, one schooling style ride, flag absent:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id hk_adv_001`

Copy it to `dist/day7/hk_adv_001.school.log`. Refuse stays 11 with `[6]`. Rail stays 10 with `[3, 6]`. Time parts stay 3 and 2. The save matches the snapshot. If this moved, the flag leaked. Take it out and stop.

Playtest after that. Clear 0, refuse 4, rail 4. Save still matches.

## What a show round is worth

Show uses `time_show`, then the same jump-off rule `max(28, time_show * 0.42)`.

| class | time_show | jump-off allowed | time limit |
| --- | ---: | ---: | ---: |
| beginner | 95 | 39.9 | 79.8 |
| intermediate | 85 | 35.7 | 71.4 |
| advanced | 75 | 31.5 | 63.0 |

Lessons are not shows. Their allowed time stays 180, and they still take no time faults. Their style totals stay 4 and 4.

A show refusal is 4 the first time, 8 the second, and the third eliminates with reason `three`. These style rides refuse once. You will see a 4, not an 8, unless the log prints two `RIDECERT refuse` lines.

A completed round that is not eliminated still adds `floor((time_sec - time_allowed) / 4)` when that is positive. Rails are 4 each. The parts on the result line must add up to `faults`.

`tick` eliminates a show round when `time_sec` passes `time_limit`. `finish_round` does not add time faults after that, because the round is already eliminated. That is the rule. `hk_jo_adv_001` schooling refuse took 65.30 seconds. The show jump-off limit is 63.0. If that refuse round stops with `eliminate_reason=time` and the clock past 63, it is a keep. Do not raise the limit. Do not edit `ride_ai.gd` to make it faster. Do not ride it a second time to "finish."

A completed, not eliminated, round prints a ribbon that matches the function already in `game_state.gd`: 0 and first clear Blue, 0 otherwise Red, 4 Yellow, 8 or less White, anything more Pink. Style rounds are not clears. A 4-fault round is Yellow. Write the ribbon on the row. If the printed ribbon disagrees with that function, the print is wrong. Fix the print. Do not change `_ribbon`.

## The twenty-three shows

One process each. Copy each log to `dist/day7/<id>.show.log`. Then the row, then the next id.

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

For each round write:

| id | style | kind | faults | rails | refusals | time_sec | allowed | time faults | eliminated | ribbon | parts add up | save |

`kind` is lesson or show. Lessons: time faults 0, faults 4, save matched. Shows that finish: parts add up, ribbon matches, save matched, `rail_fences` equals the `FENCE knock` numbers. Shows eliminated for time: reason `time`, clock past the limit, faults equal only the rails and refusals scored before the stop, save matched.

`hk_adv_001` show will not match the schooling 11 and 10. The allowed time is 75, not 80. Check the formula against this log's own time. The rail list still names fence 6 where the log prints `FENCE knock 6`.

An id with no `RIDECERT done` at 30 minutes, 45 for an advanced, is stuck. Kill only that process. Retry once. If the retry sticks, write the id and go on. Restore the snapshot if that process wrote the file.

## Stop

Stop only when all of these are true, or a window appeared:

- Schooling `hk_adv_001` still reads 11 / `[6]` and 10 / `[3, 6]`
- Playtest is 0 / 4 / 4
- `dist/day7/` has 23 show logs
- The save matches the snapshot
- `dist/DAY7_LOG.md` lists every elimination and every ribbon

The last lines: how many shows finished, how many eliminated for time, files changed, blacklist, and that `dist\Abbott.exe` was not launched and not rewritten.

Do not ask Ernie. The next id is the one after the last file in `dist/day7/`.
