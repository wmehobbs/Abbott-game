# Grok Build — the turn is not a circle

You are Grok Build in `E:\Workspace\Madison`. Ernie is at the machine and will not watch you. A Godot window locks the desktop. The game stays closed.

This day is long on purpose. A table is not the day. Three rides are not the day. You do not stop when `hk_les_001` fence 2 is classified. You do not restore the sentence in the middle of a list. Each try is all twenty-three, then a decision.

Product stays **2.348.0.0**. Do not bump it. Do not export. Do not launch `dist\Abbott.exe`. Last write 24 September, 11:44. Leave it.

Godot, console build only:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

Leave these alone: `dist/DAY_LOG.md`, `dist/DAY_MEASURE.md`, `dist/DAY2_LOG.md`, `dist/DAY2_MEASURE.md`, `dist/DAY3_LOG.md`, `dist/DAY3_MEASURE.md`, `dist/day3/`, `dist/NIGHT_LOG.md`, `dist/NIGHT_MEASURE.md`, `dist/night/`. This day writes `dist/DAY4_LOG.md`, `dist/DAY4_MEASURE.md`, and logs under `dist/day4/`.

## What the night already closed

Come again is the morning test again. `ahead < 11.0 or straight_run < 11.0` inside the block where ahead is already 0.8 to 11. That test is restored in `game/scripts/horse.gd`. Do not put 4.0 or 6.0 back as the moment she speaks. Both failed. At 4 m she spoke as soon as the line crossed 4 m, then lined up and jumped. `hk_les_001` fence 2 did that at 6.79 m with no circle. At 6 m that same fence still spoke, and fence 9 of `hk_adv_001` lost the 5.13 m line on a real circle. There is no third lateral. There is no 5 m, no 7 m, no 8 m.

Style is closed. All 23 refused fence 1 and jumped it again, then knocked fence 3, finished, and did not teleport. `rail_fences` is empty because the rail is already down before `rail_down`. The knock is in the log and the fault is scored. Do not edit `ride_cert.gd` to fill that list. Five rounds picked up extra poles (`hk_adv_001`, `hk_adv_002`, `hk_adv_003`, `hk_jo_int_001`, `hk_jo_adv_001`). Do not chase them. Do not ride `--ridecert-style` today.

The board is still **21/23** from day 3. Every clear still clears. Largest clear move was `hk_beg_034` **+0.08 s**. `hk_adv_001` **91.61 s**, 2 time faults, no rail. `hk_adv_003` **94.01 s**, 3 time faults, no rail. Do not retune confidence, flowers, or the window.

Fence 2 of `hk_beg_033` is a one-stride. Early / Wait / Now. It does not say Two. It does not say Come again. Leave that fence's distance alone.

The hear line, the +4, the 3.8 s hold, and the bypass that lets a stride word and Come again speak over that hold all stay. The ship pool stays at 320 lines.

`dist/night/*.clear.log` is the 4.0 sentence, not this morning. `dist/night/*.try6.log` is the 6.0 sentence. Classify from `dist/day3/board.log` only.

## Silent

`--headless` is the first argument after the exe. If it is not, do not run the command.

A clear ride is `python tools/content_factory/run_ridecert.py --ridecert-id <id>`.

The wrapper passes `--headless` and `CREATE_NO_WINDOW`. It opens `dist/ridecert_godot.log` with `"w"`. Copy that log to `dist/day4/` before the next launch. A playtest goes through `python dist/_run_userarg.py --playtest`.

One Godot. If any Godot is already running, wait. Do not taskkill a ride that is still printing. Do not start the next id beside it. Do not batch the twenty-three into one SceneTree.

Forbidden all day: `dist\Abbott.exe`, the editor, F5, F6, `--artshot`, `--artshot-rider`, a second Godot, export, pack, a version bump, PowerShell `>` on Godot, `--ridecert-style`, `place_fence.py`.

If a window appears, close it, write the command under `BLACKLIST`, and do not retry it.

No `RIDECERT round` within 2 minutes is a compile error. Kill only that process. Fix. Ride that id again.

Wall clock: a clear id is about 8 to 12 minutes. One try of the list is about four hours. Two tries is the day. The full board is about 70 minutes. You may run it **once**, and only after a try is kept. A restored sentence does not get a board.

## Frozen

Do not edit:

- The hear condition, the +4, `_school_from_round`
- TAKEOFF, the early / late / ideal bands, `window_scale`, `refuse_scale`, `balance_need`, gait speeds, the 3.35 divisor
- The 1.6 m line that blanks Two / One on that tick. Wide is still not a count.
- The 11 m window. Ahead under 0.8 or over 11 still resets the stride word.
- The knock box
- Any course JSON, either tree
- `ride_ai.gd`, `ride_cert.gd`, `person_look.gd`, `abbott_look.gd`, `rider_mesh.gd`, `farm.gd`
- `michelle_ship.json`
- The 25k archive, the 48k pile, sand and wood albedo

## What a lie is, now that a lateral floor failed

She speaks on the first wide sample inside 11 m. That sample is often the turn onto the line. `hk_les_001` fence 2 speaks at ahead 10.80, lateral 6.79, and the same fence is already at lateral 1.75 a moment later, and she jumps with no circle. A horse-width wobble also speaks, because `come_again_fence` is cleared back to -1 when lateral drops to 1.6 or under. The next tick at 1.64 says it again.

A missing `RIDEAI come again` is not, by itself, a lie. The night marked 138 sentences that way. Some of those she was still wide at the jump. A rider who is still 8 m off the line should hear it, even when the cert horse jumps it crooked.

A lie is a Come again that is followed, on that same approach, by a COUNT with lateral under 1.6 before the jump, and no `RIDEAI come again` between the sentence and that lined count.

A true sentence is one where a later sample is still at lateral 4 m or more after she has closed on the fence, or where `RIDEAI come again` follows it. Fence 9's circle at 5.13 m is true. Fence 7's circle at 13.86 m is true. The sample beside the fence, ahead under 2 m and lateral 15 to 35 m, is not a sentence. She is already at the plane.

From `dist/day3/board.log`, for every `Come again.` write one row in `dist/DAY4_MEASURE.md` before you edit:

| id | fence | ahead at the sentence | lateral at the sentence | ahead at the next COUNT | lateral at the next COUNT | lined up before the jump | circle before the jump |

Lined up means a later COUNT on that fence with lateral under 1.6 before the jump. Use the COUNT lines, not only the sentence row. The night's table has one row per sentence and hides the straighten.

This table does not cancel the rides. It tells you what the tries have to keep.

## The only edit

Two tries. Both are a closing distance. Neither is a new lateral.

On a wide tick (`lateral > 1.6`, ahead still 0.8 to 11), remember the ahead if you are not already remembering it for this spell. If lateral falls to 1.6 or under before she has spoken, forget that ahead. Do not speak on the tick you first remember it.

Speak only when all of these are true:

- lateral is still at least **4.0**
- ahead has fallen at least **3.0** m from the remembered ahead
- ahead is still greater than **2.0**
- this approach has not heard Come again yet

Try 2, only if try 1's full list still contains a lie: the same rule with **5.0** m of closing. The 4.0 stays. The 2.0 stays. Do not try 3.5, 4.0, or 6.0 m of closing. Do not try lateral 5, 6, 7, or 8.

Once she has heard it, do not clear that latch because she lined up. Clearing on the straighten is why a 1.64 m wobble speaks. Clear the latch when ahead goes back above 11, or when `next_fence` changes, so a new approach can speak. A refuse that presents the same fence again comes back through ahead above 11. That is enough. Do not edit `ride_ai.gd` to signal the re-present.

The 1.6 m branch still returns before Two / One. When she lines up, the stride words run as they do this morning. Do not drop them. Do not delete the COUNT print.

`hk_beg_033` fence 2 stays silent. If a try makes that fence say Come again, or Two, that try is already a fail. Finish its list anyway, then revert that number and start the other try. Do not restore in the middle.

## How a try is kept

After all 23 logs for that try are in `dist/day4/`:

- `hk_les_001` fence 2 does not say Come again
- `hk_beg_033` fence 2 does not say Come again, and does not say Two
- `hk_adv_001` fence 7 still says it on the approach that prints `RIDEAI come again`
- `hk_adv_001` fence 9 still says it on the approach that prints `RIDEAI come again`
- Every lie in the day-4 table (sentence, then lateral under 1.6, no circle) is silent on that fence in the new log
- A fence that stayed at lateral 4 m or more until the jump, or until the circle, still says it
- Clears stay clear. No new rail. No teleport. Time within 0.3 s of `dist/day3/board.json`

If those hold, keep the try. Do not start try 2. One full `python tools/content_factory/run_ridecert.py`. Compare to `dist/day3/board.json`. Every clear still clears. No new rail. No teleport. No clear moves more than **0.1 s**. The two clock courses may move 0.3 s and must not gain a rail. Copy the log to `dist/day4/board.log` and the json to `dist/day4/board.json`. If the board breaks, revert the sentence and do not ride a second board. Try 2 does not run after a reverted board.

If the list fails the sentence test, write the failing fences, set the closing distance to 5.0, and ride all 23 again to `dist/day4/<id>.try5.log`. Same keep rule. If try 2 fails, put the morning bytes back. No third try. No board.

## The twenty-three, in this order

One process each. The file exists before the next launch. Try 1 copies to `dist/day4/<id>.log`. You do not reorder and you do not stop at lesson 4.

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

## Stop

Stop only when all of these are true, or a window appeared:

- The lined-up table is in `dist/DAY4_MEASURE.md`
- Try 1 has 23 logs, and try 2 has 23 logs if try 1 failed the sentence test
- The sentence is either kept, with one board, or back to this morning's bytes
- `dist/DAY4_LOG.md` lists the closing distance, every failing fence, and the revert if there was one

The last lines: which try was kept, the board score if you rode one, files changed, blacklist, and that `dist\Abbott.exe` was not launched and not rewritten.

Do not ask Ernie. The next id is the one after the last file in `dist/day4/`.
