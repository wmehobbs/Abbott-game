# Grok Build — stay for the jump-off

You are Grok Build in `E:\Workspace\Madison`. Ernie is not here. He will not answer. A message that describes the remaining courses is a failed day. Ride the next id in the same turn. Do not tell him the plan.

A Godot window locks the desktop. The game stays closed.

Product stays **2.348.0.0**. Do not bump it. Do not export. Do not launch `dist\Abbott.exe`. Last write 24 September, 11:44. Leave it.

Godot, console build only:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

Leave these alone: every earlier `dist/DAY*.md`, `dist/NIGHT*.md`, `dist/day3/` through `dist/day9/`, `dist/night/`. This day writes `dist/DAY10_LOG.md`, `dist/DAY10_MEASURE.md`, and logs under `dist/day10/`.

## What already stays

Come again is the morning test. The official time is the raw clock truncated to the hundredth. A fallen pole is that fence's number. `save()` returns immediately on `--playtest` or any arg that begins with `--ridecert`. `--ridecert-show` sets a non-lesson to show. A lesson stays a lesson.

The second show refusal is 12. The third eliminates. Do not ride `--ridecert-refusals` today. Do not change `note_refuse`.

Day 8 show clears were 17 of 23. These six were time faults only, no rails: `hk_int_001`, `hk_int_005`, `hk_adv_001`, `hk_adv_002`, `hk_adv_003`, `hk_jo_adv_001`. Do not move a fence to clear them. Do not edit `ride_ai.gd`. Do not change `time_allowed`, `time_show`, `time_limit`, `_ribbon`, or `can_offer_jump_off`.

## The round that has never been ridden

`can_offer_jump_off` is already the rule. Show, not already a jump-off, not eliminated, zero faults, zero time faults, time within `time_show`. `begin_jump_off` sets the flag, resets the round, and speaks. `arena.gd` then rebuilds the course and places the horse at the new start. The cert has never done that second round.

You add that chain and you ride it. You do not invent a new offer rule.

## What done means

Count files. A plan is not done. `dist/DAY10_LOG.md` with a paragraph and no rides is not done.

All of these must exist, and each ride log must contain `RIDECERT done` for every round inside it:

- `dist/day10/playtest.log`
- `dist/day10/hk_beg_035.school.log`
- 23 files `dist/day10/<id>.log`

A show log whose first round finished with `can_offer_jump_off` true must also contain a second `RIDECERT done` for the jump-off. A file that offered and has only one done-line does not count. Ride that id again.

You may append one row after each finished file. Then launch the next id in the same turn. Do not end a turn between ids.

## Silent

`--headless` is the first argument after the exe. Use the python wrapper.

Playtest: `python dist/_run_userarg.py --playtest`

Schooling clear, flag absent:

`python tools/content_factory/run_ridecert.py --ridecert-id hk_beg_035`

Show, one id at a time. The new arg rides the first round and, when the offer is true, the jump-off before the process exits:

`python tools/content_factory/run_ridecert.py --ridecert-show --ridecert-jumpoff --ridecert-id <id>`

The wrapper passes `--headless` and opens `dist/ridecert_godot.log` with `"w"`. Copy it to `dist/day10/` before the next launch.

One Godot. If one is already running, wait. Do not taskkill a live ride. Do not batch the twenty-three into one SceneTree.

Forbidden: `dist\Abbott.exe`, the editor, F5, F6, `--artshot`, a second Godot, export, pack, a version bump, PowerShell `>` on Godot, `place_fence.py`, `--ridecert-refusals`, `--ridecert-style`.

If a window appears, close it, write the command under `BLACKLIST`, and do not retry it.

No `RIDECERT round` within 2 minutes is a compile error. Kill only that process. Fix. Ride that id again.

Wall clock: a clear round is about 8 to 12 minutes. A jump-off is shorter. Twenty-three first rounds plus the offered jump-offs are the night. If the show list finishes in under four hours, you skipped the second rounds. Count the done-lines again.

## The save, before any Godot

Copy

`C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json`

to `dist/day10/save_snapshot.json`. After every Godot, the live file matches it. If it does not, copy the snapshot back and fix only `save()`. `--ridecert-jumpoff` begins with `--ridecert`, so the early return already covers it. Do not weaken that return.

## The only edit

When `--ridecert-jumpoff` is set, a show round that finishes with `can_offer_jump_off()` true does what the arena already does:

- `begin_jump_off()`
- `course.build` with the same arguments the arena uses
- place the horse at the course start, the same placement `_setup` already uses
- ride one clear round
- then quit

If the offer is false, quit after the first round. Do not call `begin_jump_off` anyway.

A lesson never offers. A course that is already a jump-off never offers. A round with faults or time faults never offers. If one of those offers, you called it wrong. Take the call out. Do not change `can_offer_jump_off`.

The jump-off needs 4 fences. If the second round's `fences_needed` is not 4, the rebuild did not see `jump_off`. Fix that call. Do not edit the course JSON.

## Proof, then the twenty-three

Playtest. Clear 0, refuse 4, rail 4. Save matches.

`hk_beg_035` schooling, no show flag, no jumpoff arg. It must stay a clear, the log must not contain a second round, and the save must match. Copy to `dist/day10/hk_beg_035.school.log`.

Then the twenty-three, in this order. One process each. The file exists before the next launch.

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

After each file, one row:

| id | first faults | first time | offered | jump-off faults | jump-off fences | jump-off time | eliminated | save |

Offered is yes only when the second round ran. Jump-off fences must be 4 of 4, or the round eliminated for time with the clock past `time_limit`. Advanced jump-off limit is 63.0. Do not raise it.

The six day-8 time-fault ids are a keep when they do not offer, including if they are time faults again. If one of them is suddenly clear and offers, ride the jump-off. That is the rule. Do not refuse the offer to match day 8.

Lessons do not offer. `hk_jo_beg_001`, `hk_jo_int_001`, and `hk_jo_adv_001` are already jump-offs. They do not offer a further one.

Every other show id that finishes at zero faults and zero time faults must offer, and the second round must be in that same log. `hk_adv_005` is the advanced one that was clear on day 8. If it is clear again and the log has no jump-off, the id is not done.

Parts add up on both rounds. The printed time is the official hundredth. Rails match `FENCE knock`. `teleported=false`. Ribbon is whatever `_ribbon` already returns. Do not empty the save to force a Blue.

An id with no `RIDECERT done` at 25 minutes for a single round, or 45 minutes when a jump-off should follow, is stuck. Kill only that process. Retry once. If the retry sticks, write the id and go on. Restore the snapshot if it wrote the file.

## Stop

Stop only when the file count is true, or a window appeared.

Then the last lines of `dist/DAY10_LOG.md`: how many first rounds, how many jump-offs were ridden, which ids offered, whether the save matches the snapshot, files changed, blacklist, and that `dist\Abbott.exe` was not launched.

Until that count is true, the next action is the next missing id. Not a message.
