# Grok Build — the second refusal, then the third

You are Grok Build in `E:\Workspace\Madison`. Ernie will not be at the machine. A Godot window locks the desktop. The game stays closed. Do not stop to ask him anything.

This day is long on purpose. A schooling check is not the day. The two-refusal list is not the day. You do not stop after the four lessons. You do not stop after `hk_beg_035`.

Product stays **2.348.0.0**. Do not bump it. Do not export. Do not launch `dist\Abbott.exe`. Last write 24 September, 11:44. Leave it.

Godot, console build only:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

Leave these alone: every earlier `dist/DAY*.md`, `dist/NIGHT*.md`, `dist/day3/` through `dist/day8/`, `dist/night/`. This day writes `dist/DAY9_LOG.md`, `dist/DAY9_MEASURE.md`, and logs under `dist/day9/`.

## What already stays

Come again is the morning test. Do not edit that block.

The official time is the raw clock truncated to the hundredth. Time faults, the cert line, and the result line use that number. Do not round it again.

A fallen pole is that fence's number. Schooling `hk_adv_001` is refuse 11 with `[6]`, rail 10 with `[3, 6]`. Show rail of that course is 11 faults, fences `[3, 6]`, 3 time faults, printed t 90.99.

`save()` returns immediately on `--playtest` or any arg that begins with `--ridecert`. Do not weaken it.

`--ridecert-show` sets a non-lesson to show. A lesson stays a lesson. Do not change `time_allowed`, `time_show`, `time_limit`, `_ribbon`, the knock box, or the leave math. Do not move a fence.

Show clears are 17 of 23. The other six are time faults only. Do not try to clear them.

## The rule that has never been ridden

`note_refuse` already prices a show refusal. The first adds 4. The second adds 8. The third calls `eliminate("three")` and returns without adding more. Schooling adds 4 every time and does not eliminate. Every style ride so far has refused once, so the second 8 and the third elimination have never happened.

The cert print `refusals_this_round * 4` is schooling arithmetic. Two show refusals cost 12, not 8. When the print disagrees with `note_refuse`, the print is wrong. Do not change `note_refuse` to match the print.

## Silent

`--headless` is the first argument after the exe. If it is not, do not run the command.

Two show refusals, one course:

`python tools/content_factory/run_ridecert.py --ridecert-show --ridecert-refusals=2 --ridecert-id <id>`

Three show refusals:

`python tools/content_factory/run_ridecert.py --ridecert-show --ridecert-refusals=3 --ridecert-id <id>`

Schooling is the same command without `--ridecert-show`.

Do not pass `--ridecert-style` on these commands. The old style pair stays what it is: refuse once, then the rail.

The wrapper passes `--headless` and opens `dist/ridecert_godot.log` with `"w"`. Copy that log to `dist/day9/` before the next launch.

One Godot. If any Godot is already running, wait. Do not taskkill a ride that is still printing. Do not start the next id beside it. Do not batch the twenty-three into one SceneTree.

Forbidden all day: `dist\Abbott.exe`, the editor, F5, F6, `--artshot`, `--artshot-rider`, a second Godot, export, pack, a version bump, PowerShell `>` on Godot, `place_fence.py`, a clear board.

If a window appears, close it, write the command under `BLACKLIST`, and do not retry it.

No `RIDECERT round` within 2 minutes is a compile error. Kill only that process. Fix. Ride that id again.

Wall clock: one refusal round is about 10 to 15 minutes, longer when she stops twice or three times. Forty-six show rounds is the day. An advanced jump-off can sit until the time limit. Budget 30 minutes for a lesson or a jump-off and 45 for an advanced. Do not shrink the list because `hk_les_001` already eliminated.

## The save, before any Godot

Copy

`C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json`

to `dist/day9/save_snapshot.json`. If it is absent, the absence is the snapshot. After every Godot, the live file matches it. If it does not, copy the snapshot back and fix only `save()`.

## The only edits

1. A new cert arg `--ridecert-refusals=2` runs one round, style name `refuse_twice`, fence 1. `--ridecert-refusals=3` runs one round, style name `refuse_three`, fence 1. No rail round beside it. `--ridecert-style` with no refusals arg still runs refuse-once then rail, unchanged.

2. In `ride_ai.gd`, only those two new style names. Fence 1 is asked early, the same 4.2 already used by `refuse_early`, until that many early asks have been issued. Then the flag that ends the style is set, and the next approach is an ordinary leave. `refuse_early`, `rail_late`, and `clear` stay on the path they have today. Do not change 4.2. Do not change 1.3. Do not change when `style_done` flips for the old styles.

3. The cert's `refusal_faults` print is the sum `note_refuse` actually added. Show is 4, then 12. Schooling is 4 times the refusal count. Do not change the adds.

`_success` for `refuse_early` still expects 4 faults. Do not force the new styles through that test. A keep is the formula below, not `success=true`.

## Proof before the lists

Playtest. Clear 0, refuse 4, rail 4. Save matches.

One old style pair, no refusals arg:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id hk_les_001`

Refuse faults 4, empty rail list. Rail faults 4, `rail_fences=[3]`. Save matches. If this moved, the new styles leaked. Take them out of the old path and ride this pair again. Then stop if it still moves.

Schooling, one course, both counts. `hk_beg_035`. Two refusals: faults from refusals are 8, the round is not eliminated, fence 1 is jumped after the second refusal. Three refusals: faults from refusals are 12, the round is not eliminated, fence 1 is jumped after the third. Rails, if any, are 4 each and must appear in `rail_fences`. Time faults use the official hundredth. Parts add up. Save matches. Copy to `dist/day9/hk_beg_035.school2.log` and `dist/day9/hk_beg_035.school3.log`.

## Show, two lists, all twenty-three

List one is `--ridecert-refusals=2`. Every file `dist/day9/<id>.r2.log` exists before list two starts. List two is `--ridecert-refusals=3`, files `dist/day9/<id>.r3.log`.

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

Lessons stay lessons on both lists. Two refusals cost 8, three cost 12, no elimination, no time faults, no ribbon.

A show two-refusal keep:

- Exactly two `RIDECERT refuse` lines, both fence 1, then fence 1 is jumped
- Refusal faults are 12, not 8
- Not eliminated
- Rails, if any, match `FENCE knock` and add 4 each
- Time faults match the official hundredth against show allowed time
- Parts add up to `faults`
- Ribbon follows `_ribbon` for that fault total
- Save matches

A show three-refusal keep:

- Exactly three `RIDECERT refuse` lines, all fence 1
- `eliminate_reason=three`
- Faults are 12 plus any rails scored before the third refusal. The third refusal adds nothing. Time faults are not added after elimination
- No ribbon
- The round completed because it was eliminated, `teleported=false`
- Save matches

`hk_jo_adv_001` may hit the show jump-off limit of 63.0 before the third refusal. If `eliminate_reason=time` and the clock is past 63, write how many refusals had landed and go on. Do not raise the limit. Do not edit `ride_ai.gd` to make the circle faster. Every other id is not allowed that excuse. If another id eliminates for time, or never reaches the refusal count, read the log. Fix only the new style's ask count. Ride that id again once. If the second ride still misses, write it and go on. Do not change `note_refuse`.

An id with no `RIDECERT done` at 30 minutes, 45 for an advanced, is stuck. Kill only that process. Retry once. If the retry sticks, write the id and go on. Restore the snapshot if it wrote the file.

## Stop

Stop only when all of these are true, or a window appeared:

- Playtest is 0 / 4 / 4 and `hk_les_001` style is still 4 and 4
- Schooling `hk_beg_035` is 8 and 12, not eliminated
- 23 two-refusal show logs and 23 three-refusal show logs are in `dist/day9/`
- The save matches the snapshot
- `dist/DAY9_LOG.md` lists every elimination reason

The last lines: how many shows eliminated for three refusals, how many for time, files changed, blacklist, and that `dist\Abbott.exe` was not launched and not rewritten.

The next id is the one after the last file in `dist/day9/`. The two-refusal files come first.
