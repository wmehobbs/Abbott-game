# Grok Build — do not save the cert, and show the parts

You are Grok Build in `E:\Workspace\Madison`. Ernie is at the machine and will not watch you. A Godot window locks the desktop. The game stays closed.

This day is two checklists. The fault totals already add up. You are not here to shrink them. The save file is the player's horse. A cert must not write it.

Product stays **2.348.0.0**. Do not bump it. Do not export. Do not launch `dist\Abbott.exe`. Last write 24 September, 11:44. Leave it.

Godot, console build only:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

Leave these alone: every `dist/DAY*.md`, `dist/NIGHT*.md`, `dist/day3/`, `dist/day4/`, `dist/night/`, `dist/day5/`. This day writes `dist/DAY6_LOG.md`, `dist/DAY6_MEASURE.md`, and logs under `dist/day6/`.

## What already stays

Come again is the morning test. Do not edit that block.

The pole that fell is the fence's own number. `note_rail(fence_number)` and the cert copy of `rail_nums` stay. `hk_adv_001` refuse is faults 11 and `rail_fences=[6]`. Its rail round is faults 10 and `[3, 6]`. Do not undo that.

The board is **21/23**. Do not ride a clear board. Do not move a fence. Do not edit `ride_ai.gd`. Do not change `add_faults`, `time_allowed`, `time_school`, or `time_show`.

The hear line, the +4, the 320 ship lines, the knock box, and the leave math stay.

## Silent

`--headless` is the first argument after the exe. If it is not, do not run the command.

A style ride is `python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id <id>`.

A playtest is `python dist/_run_userarg.py --playtest`.

The wrapper passes `--headless` and `CREATE_NO_WINDOW`. It opens `dist/ridecert_godot.log` with `"w"`. Copy that log to `dist/day6/` before the next launch.

One Godot. If any Godot is already running, wait. Do not taskkill a ride that is still printing. Do not start the next id beside it. Do not batch the twenty-three into one SceneTree.

Forbidden all day: `dist\Abbott.exe`, the editor, F5, F6, `--artshot`, `--artshot-rider`, a second Godot, export, pack, a version bump, PowerShell `>` on Godot, `place_fence.py`, a clear `--ridecert` of the whole board, editing the save by hand except to copy the snapshot back over it.

If a window appears, close it, write the command under `BLACKLIST`, and do not retry it.

No `RIDECERT round` within 2 minutes is a compile error. Kill only that process. Fix. Ride that id again.

## The save, before any Godot

The player's file is:

`C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json`

If that file exists, copy it to `dist/day6/save_snapshot.json` before the first Godot. That copy is sacred. If the file does not exist, write `absent` in `dist/DAY6_MEASURE.md` and the absence is the snapshot.

`finish_round` calls `save()`. A cert round updates confidence, scope, timing, feel, clears, best rounds, `course_seed`, and `lesson_done`, then writes them. The next round pins the stats in memory only. The file on disk keeps the last round. After a night of rides, the horse Ernie loads is the cert's horse.

You will prove that once, then stop it.

## The 19, on paper, before any edit

Cert rounds are schooling, not show. A refusal is 4. A rail is 4. A lesson does not take time faults. Any other round takes `floor((time_sec - time_allowed) / 4)`, and only when that is positive.

`time_allowed` is `time_school` except a jump-off, which is `max(28, time_school * 0.42)`.

| class | time_school | jump-off allowed |
| --- | ---: | ---: |
| lesson | 180 | — |
| beginner | 100 | 42 |
| intermediate | 90 | 37.8 |
| advanced | 80 | 33.6 |

`hk_jo_adv_001` refuse in `dist/day5/` is the example. Time 65.30. Allowed 33.6. `floor(31.7 / 4)` is 7. Rails `[1, 2]` are 8. Refusal `[1]` is 4. 7 + 8 + 4 = 19. That 19 stays. It is not an extra pole and it is not a second refusal scored as 8.

From `dist/day5/<id>.style.log`, for both rounds of all 23 courses, one row in `dist/DAY6_MEASURE.md`:

| id | style | faults | rails | refusals | time_sec | allowed | time faults | sum | match |

`sum` is `4 * rails + 4 * refusals + time faults`. Lessons use 0 time faults even if the clock is over. `match` is yes when `sum` equals `faults`. Do not start Godot until all 46 rows are written. If a row is no, write it and do not change the formula. The print you add later will show the same parts. A mismatch is a finding, not a retune.

## The only edits

1. `GameState.save()` returns before it opens the file when any user arg is `--playtest` or begins with `--ridecert`. A normal game, which has neither arg, still saves. Do not skip `save()` any other way. Do not clear the file. Do not change what a normal save writes.

2. The `RIDECERT` result line gains the parts already stored on `GameState`: `time_faults`, and the three counts that make `faults`. Compute nothing new. Do not round the clock differently. One rail still adds 4. One refusal still adds 4.

You may edit `save()` and the result print in `ride_cert.gd`. Nothing else.

## Proof

Playtest first, after the edits. Clear faults 0. Refuse faults 4. Rail faults 4. Then the save file matches the snapshot byte for byte. If the playtest faults are wrong, put both edits back and stop. If only the save changed, copy the snapshot back, and fix only `save()`. Ride the playtest again. The snapshot is never edited.

Then the twenty-three, in this order. One process each. Copy each log to `dist/day6/<id>.style.log`. After each id, before the next launch, compare the save to the snapshot. If it differs, copy the snapshot back, fix only `save()`, and ride that id again. If the second ride still writes the file, put `save()` back, write the id, and stop the list.

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

A keep, for every id, both rounds:

- `faults=` equals the day-5 log for that id and that style.
- `rail_fences` equals the `FENCE knock` numbers in the new log, in order.
- `teleported=false`, the round completes, fence 1 is refused and jumped again on the refuse round.
- The new line's parts add up to `faults`. `hk_jo_adv_001` refuse still prints 19, and the parts are 4, 8, and 7. `hk_adv_001` refuse still prints 11, with rail list `[6]`.
- The save matches the snapshot.

An id with no `RIDECERT done` at 30 minutes, 45 for an advanced, is stuck. Kill only that process. Retry once. If the retry sticks, write the id and go on. Restore the snapshot if that killed process wrote the file.

## Stop

Stop only when all of these are true, or a window appeared, or you reverted:

- The 46-row sum table is in `dist/DAY6_MEASURE.md`
- Playtest is 0 / 4 / 4 and the save matches the snapshot
- `dist/day6/` has 23 style logs, or the list stopped because you reverted
- `dist/DAY6_LOG.md` says, for each id, that the save matched and that the parts summed

The last lines: whether any paper row mismatched, whether the save still matches the snapshot, files changed, blacklist, and that `dist\Abbott.exe` was not launched and not rewritten.

Do not ask Ernie. The next id is the one after the last file in `dist/day6/`.
