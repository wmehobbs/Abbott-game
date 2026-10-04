# Grok Build — the hundredth, then both cards, clear

You are Grok Build in `E:\Workspace\Madison`. Ernie will not be at the machine. A Godot window locks the desktop. The game stays closed. Do not stop to ask him anything. The day is not over when the print is fixed. The day is not over when the four lessons are done. The day is not over when the show card is done.

Product stays **2.348.0.0**. Do not bump it. Do not export. Do not launch `dist\Abbott.exe`. Last write 24 September, 11:44. Leave it.

Godot, console build only:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

Leave these alone: every earlier `dist/DAY*.md`, `dist/NIGHT*.md`, `dist/day3/` through `dist/day7/`, `dist/night/`. This day writes `dist/DAY8_LOG.md`, `dist/DAY8_MEASURE.md`, and logs under `dist/day8/`.

## What already stays

Come again is the morning test. Do not edit that block.

A fallen pole is that fence's number. Schooling `hk_adv_001` is refuse 11 with `[6]`, rail 10 with `[3, 6]`.

`save()` returns immediately on `--playtest` or any arg that begins with `--ridecert`. Do not weaken it.

`--ridecert-show` sets a non-lesson to show. A lesson stays a lesson. Do not change `time_allowed`, `time_school`, `time_show`, `time_limit`, the refusal prices, or `_ribbon`.

The hear line, the +4, the 320 ship lines, the knock box, and the leave math stay. Do not edit `ride_ai.gd`. Do not move a fence. Do not ride one SceneTree of all 23.

Day 7 already rode the style card. Do not ride `--ridecert-style` today except the one show check named below.

## Silent

`--headless` is the first argument after the exe. If it is not, do not run the command.

Show clear:

`python tools/content_factory/run_ridecert.py --ridecert-show --ridecert-id <id>`

Schooling clear, flag absent:

`python tools/content_factory/run_ridecert.py --ridecert-id <id>`

The one show style check:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-show --ridecert-id hk_adv_001`

The wrapper passes `--headless` and opens `dist/ridecert_godot.log` with `"w"`. Copy that log to `dist/day8/` before the next launch.

A playtest is `python dist/_run_userarg.py --playtest`.

One Godot. If any Godot is already running, wait. Do not taskkill a ride that is still printing. Do not start the next id beside it.

Forbidden all day: `dist\Abbott.exe`, the editor, F5, F6, `--artshot`, `--artshot-rider`, a second Godot, export, pack, a version bump, PowerShell `>` on Godot, `place_fence.py`.

If a window appears, close it, write the command under `BLACKLIST`, and do not retry it.

No `RIDECERT round` within 2 minutes is a compile error. Kill only that process. Fix. Ride that id again.

Wall clock: a clear id is about 8 to 12 minutes. Forty-six of them is the rest of the day. Budget for that. An advanced style check is about 30 minutes. Do not shrink the list because the first rides look the same.

## The save, before any Godot

Copy

`C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json`

to `dist/day8/save_snapshot.json`. If it is absent, the absence is the snapshot. After every Godot, the live file matches it. If it does not, copy the snapshot back and fix only `save()`. The snapshot is never edited.

## The hundredth

`dist/day7/hk_adv_001.show.log` prints `t=91.0` and `time_faults=3` on the rail round. Allowed time is 75. Four time faults begin at 91. The score used a raw clock under 91. `snapped(time, 0.01)` rounded the print up to 91.0. The player's result line uses `%0.2f`, which rounds the same way.

One number. Call it the official time. It is the raw `time_sec` truncated to the hundredth, not rounded:

`floor(time_sec * 100.0) / 100.0`

Time faults use that official time. The cert line prints that official time. `last_time` and the result line print that official time. There is no second clock.

Do not change the 4-second step. Do not change the allowed times. Do not change a fault price.

Then the one show style ride of `hk_adv_001`. Copy it to `dist/day8/hk_adv_001.showstyle.log`.

A keep:

- Refuse faults 12, rail list `[6]`, the printed t is strictly below 91 if time faults are 3, and strictly 91 or more if time faults are 4. Day 7's refuse was 12 at 94.45 with 4 time faults. It may stay 12.
- Rail faults stay 11, list `[3, 6]`, time faults stay 3, and the printed t is strictly below 91. Parts still add up.
- Save matches the snapshot.

If truncation changes the rail round off 11 or off 3 time faults, the official time is display-only: faults stay on the raw clock, and only the printed t is truncated. Ride this id once more. Not a third try. Then start the clears either way. Do not spend the day on the hundredth.

Playtest. Clear 0, refuse 4, rail 4. Save matches.

## Clears, show first, then schooling

Same order twice. Show, all 23, files `dist/day8/<id>.show.log`. Then schooling, all 23, files `dist/day8/<id>.school.log`. One process each. The file exists before the next launch. You do not start schooling until show file 23 exists. You do not stop after `hk_les_004`.

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

A clear row, written before the next id:

| id | card | faults | time | time faults | rails | ribbon | eliminated | teleported | parts add up | save |

Show ribbon is whatever `_ribbon` already returns from the save that was loaded. Do not empty `show_best` or `clears` to force a Blue. Do not edit the save.

`hk_adv_001` and `hk_adv_003` on the show clock are not clears. Allowed time is 75. Time faults are a keep. A jump-off that stops with `eliminate_reason=time` because the clock passed `time_limit` is a keep. Day 7's jump-off limit for advanced is 63.0. Do not raise it. Do not edit `ride_ai.gd`. Do not ride a stopped id again to finish it.

Schooling rows compare to `dist/day3/board.json`. Every id that was clear there is still clear. No new rail. No teleport. No clear moves more than **0.1 s**. The two clock courses may move 0.3 s and must not gain a rail. A schooling miss against that file is a horse change. Revert anything you touched in `horse.gd` or a course. The hundredth may stay. Do not ride a second schooling board, and do not restart the 23 if one id is already inside 0.1 s.

Lessons are lessons on both cards. No time faults. No ribbon.

An id with no `RIDECERT done` at 20 minutes, 30 for an advanced, is stuck. Kill only that process. Retry once. If the retry sticks, write the id and go on. Restore the snapshot if it wrote the file.

## Stop

Stop only when all of these are true, or a window appeared:

- The show style check of `hk_adv_001` is in `dist/day8/`
- 23 show clear logs and 23 schooling clear logs are in `dist/day8/`
- The save matches the snapshot
- `dist/DAY8_LOG.md` has both cards, the printed t on the style rail, and every time elimination

The last lines: show clears out of 23, schooling clears out of 23, whether the printed rail time is below 91, files changed, blacklist, and that `dist\Abbott.exe` was not launched and not rewritten.

The next id is the one after the last file in `dist/day8/`. Show files come first.
