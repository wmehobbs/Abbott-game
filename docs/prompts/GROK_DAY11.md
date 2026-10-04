# Grok Build — over the time allowed, then the day-one horse

You are Grok Build in `E:\Workspace\Madison`. Ernie is not here. He will not answer. A message that describes the remaining courses is a failed day. Ride the next id in the same turn. Do not tell him the plan.

A Godot window locks the desktop. The game stays closed.

This night is the Demo button, then 23 day-one show rounds. A jump-off is a second round only when `can_offer_jump_off()` is true. It is not another 23. It is not a schooling card.

Product stays **2.348.0.0**. Do not bump it. Do not export. Do not launch `dist\Abbott.exe`. Last write 24 September, 11:44. Leave it.

Godot, console build only:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

Leave these alone: every earlier `dist/DAY*.md`, `dist/NIGHT*.md`, `dist/day3/` through `dist/day10/`, `dist/night/`. This day writes `dist/DAY11_LOG.md`, `dist/DAY11_MEASURE.md`, and logs under `dist/day11/`.

## What already stays

Come again is the morning test. The official time is the raw clock truncated to the hundredth. A fallen pole is that fence's number. `save()` returns immediately on `--playtest` or any arg that begins with `--ridecert`. Do not weaken it.

`--ridecert-show` sets a non-lesson to show. A lesson stays a lesson. `--ridecert-jumpoff` already rides the second round when the offer is true. Do not change `can_offer_jump_off`, `time_show`, `time_allowed`, `note_refuse`, `_ribbon`, the knock box, or the leave math. Do not move a fence. Do not edit `ride_ai.gd`. Do not retune confidence, scope, or flowers.

Day 10 rode the pin horse. Ten rounds offered a jump-off. `hk_adv_005` was 0 faults and 0 time faults at 78.92. Advanced `time_show` is 75. `floor((78.92 - 75) / 4)` is 0, so there is no time fault. The offer stays false because 78.92 is over 75. That is the rule. Do not add a fault to make the sentence true. Do not shorten the course so she offers.

## The one sentence

On the pin horse, ride nothing until this sentence exists.

In `result_line`, a show round that is not a jump-off, has 0 faults and 0 time faults, and `can_offer_jump_off()` is false, adds the words `Over the time allowed.` It does not say `Stay for the jump-off.` A round that offers does not get those words. A lesson does not. A jump-off round does not. Ribbon stays whatever `_ribbon` already returns.

## The Demo button

Madison should be able to watch a good round. The rider is already `RideAI`. She presses the same keys a person does. Style `clear`. No teleport. Do not edit `ride_ai.gd`. Do not invent a move.

On the title, next to Lesson, a button reads `Watch a round`. It starts a show round at beginner, `course_seed` 0, which is `hk_beg_035`. It sets `GameState.demo_ride` true, then enters the arena the way `_go_ride` already does.

The arena, when `demo_ride` is true, adds one `RideAI`, binds the horse and the course, sets style `clear`, and enables her. The horse stays controllable so her key presses are the input. She is the only one pressing them.

A demo does not write the player's horse. `save()` returns immediately when `demo_ride` is true, the same as it already returns for `--playtest` and `--ridecert`. `_school_from_round` and `_record_round` do not run. Confidence, clears, ribbons, bests, and `course_seed` stay what they were when the button was pressed. A normal Lesson, School, or Show still saves. The cert flags still return before any of this.

If the round offers a jump-off, wait two seconds so the result line can be read, then take the path the Stay button already uses. The same rider stays on for the jump-off. If it does not offer, the result stays up. Escape still pauses and shows the mouse. Leaving the arena releases her keys and sets `demo_ride` false.

Do not open the game to watch this. Do not launch `dist\Abbott.exe`. Do not run the editor. The button is in the project. The September 24 exe does not get it. Ernie will show Madison later.

## What done means

Count files. Each ride log must contain `RIDECERT done` for every round inside it.

- `dist/day11/playtest.log`
- `dist/day11/hk_adv_005.pin.log`
- `dist/day11/hk_beg_035.pin.log`
- 23 files `dist/day11/<id>.fresh.log`

A fresh log whose first round left `can_offer_jump_off()` true must contain a second `RIDECERT done`. A file that offered and has only one done-line does not count.

Append one row after each finished file. Then launch the next id in the same turn. Do not end a turn between ids.

## Silent

`--headless` is the first argument after the exe.

Playtest: `python dist/_run_userarg.py --playtest`

Pin proofs, no fresh flag:

`python tools/content_factory/run_ridecert.py --ridecert-show --ridecert-jumpoff --ridecert-id hk_adv_005`

`python tools/content_factory/run_ridecert.py --ridecert-show --ridecert-jumpoff --ridecert-id hk_beg_035`

Day-one show, one id at a time:

`python tools/content_factory/run_ridecert.py --ridecert-fresh --ridecert-show --ridecert-jumpoff --ridecert-id <id>`

The wrapper passes `--headless`. Copy `dist/ridecert_godot.log` to `dist/day11/` before the next launch. `--ridecert-fresh` begins with `--ridecert`, so the save stays unwritten.

One Godot. If one is already running, wait. Do not taskkill a live ride. Do not batch the twenty-three.

Forbidden: `dist\Abbott.exe`, the editor, F5, F6, `--artshot`, a second Godot, export, pack, a version bump, PowerShell `>` on Godot, `place_fence.py`, `--ridecert-refusals`, `--ridecert-style`.

If a window appears, close it, write the command under `BLACKLIST`, and do not retry it.

No `RIDECERT round` within 2 minutes is a compile error. Kill only that process. Fix. Ride that id again.

A clear round is about 8 to 12 minutes. Twenty-three of them, plus a jump-off only when the offer is true, is the night. If the fresh list finishes in under three hours, you skipped ids. Count the files.

## The save, before any Godot

Copy

`C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json`

to `dist/day11/save_snapshot.json`. After every Godot, the live file matches it. If it does not, copy the snapshot back and fix only `save()`.

## Proof, then the twenty-three

Playtest. Clear 0, refuse 4, rail 4. Save matches.

`hk_adv_005` pin. Copy to `dist/day11/hk_adv_005.pin.log`. Faults stay 0. Time faults stay 0. The printed time stays over 75. No second round. The log contains `Over the time allowed.` The save matches. If a second round ran, or a time fault appeared, revert the sentence and stop.

`hk_beg_035` pin. Copy to `dist/day11/hk_beg_035.pin.log`. The first round stays a clear inside the time. The log does not contain `Over the time allowed.` A jump-off round runs, 4 fences. The save matches. If the offer disappeared, revert the sentence and stop.

Then the day-one horse. Confidence 48, scope 40, rideability 44, timing 38, feel 36. That is `--ridecert-fresh`. Do not change those numbers.

Same order. One process each.

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

A row before the next id:

| id | faults | time | time faults | rails | offered | jump-off faults | over the time allowed | save |

Lessons do not offer and do not get the new sentence. Already-jump-off ids do not offer a further one. A round over `time_show` with 0 time faults does not offer, and the sentence is present. A round that offers does not contain the sentence, and the jump-off is in the same log.

Rails match `FENCE knock`. Parts add up. Printed time is the official hundredth. `teleported=false`. The save matches.

If the day-one horse rails a course the pin horse cleared, write the rail. Do not edit the horse. Do not ride it again to make it clear. A jump-off that does not run because she faulted is a keep.

An id with no `RIDECERT done` at 25 minutes, or 45 when a jump-off is running, is stuck. Kill only that process. Retry once. If the retry sticks, write the id and go on. Restore the snapshot if it wrote the file.

## Stop

Stop only when the file count is true, or a window appeared, or you reverted the sentence.

Then the last lines of `dist/DAY11_LOG.md`: that `Watch a round` is on the title and a demo does not save, how many fresh first rounds, how many jump-offs, how many rails the day-one horse added, whether `hk_adv_005` still has no jump-off, whether the save matches, files changed, blacklist, and that `dist\Abbott.exe` was not launched and not rewritten.

Until that count is true, the next action is the next missing id. Not a message.
