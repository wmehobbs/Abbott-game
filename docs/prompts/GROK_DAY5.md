# Grok Build — name the pole that fell

You are Grok Build in `E:\Workspace\Madison`. Ernie is at the machine and will not watch you. A Godot window locks the desktop. The game stays closed.

This day is a checklist. The answer is already in a log. You are not choosing a sentence, a distance, or a fence. If a number is not printed as `FENCE knock`, you do not invent it.

Product stays **2.348.0.0**. Do not bump it. Do not export. Do not launch `dist\Abbott.exe`. Last write 24 September, 11:44. Leave it.

Godot, console build only:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

Leave these alone: `dist/DAY_LOG.md`, `dist/DAY_MEASURE.md`, `dist/DAY2_LOG.md`, `dist/DAY2_MEASURE.md`, `dist/DAY3_LOG.md`, `dist/DAY3_MEASURE.md`, `dist/day3/`, `dist/NIGHT_LOG.md`, `dist/NIGHT_MEASURE.md`, `dist/night/`, `dist/DAY4_LOG.md`, `dist/DAY4_MEASURE.md`, `dist/day4/`. This day writes `dist/DAY5_LOG.md`, `dist/DAY5_MEASURE.md`, and logs under `dist/day5/`.

## What is already true

Come again is the morning test. She speaks on the wide tick inside 11 m, and lining up clears the latch. Lateral floors of 4 and 6 failed. Closing distances of 3 m and 5 m failed. There is no third try. Do not edit that block. Do not add `come_wide_ahead` back.

The board is **21/23**. Do not ride a clear board today. Do not move a fence. Do not edit `ride_ai.gd`.

Style already works. All 23 refused fence 1 and jumped it again, then knocked the style rail, finished, and did not teleport. Five rounds also knocked an extra pole. Those extra poles stay. You are not here to stop them.

The hear line, the +4, the 3.8 s hold, the 320 ship lines, the knock box, and the leave math stay.

## The bug, already printed

`dist/night/hk_adv_001.style.log` has this line on the refuse round:

`FENCE knock 6 by horse at -9.8,23.4 next=9 jumping=false`

Fence 6 fell. The horse was aimed at fence 9. `note_rail` stores `next_fence`, so the results card says rail 9. The same round's result line says `rail_fences=[]` because `ride_cert.gd` only appends when `horse.rail_down` fires, and `horse.gd` skips that emit once the pole is already down. The fault was still scored. The name was wrong, and the cert list was empty.

On the rail round of that same file, fence 3 falls with `next=3` and fence 6 falls with `next=9`. The card names 9 for a pole that was 6.

`hk_jo_adv_001` refuse knocks fence 1 with `next=1` and fence 2 with `next=2`. Those names already match. The list is still empty. Both shapes are this day's job: a wrong name gets corrected, an empty list gets filled, a fault total does not change.

## Silent

`--headless` is the first argument after the exe. If it is not, do not run the command.

A style ride is `python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id <id>`.

A playtest is `python dist/_run_userarg.py --playtest`.

The wrapper passes `--headless` and `CREATE_NO_WINDOW`. It opens `dist/ridecert_godot.log` with `"w"`. Copy that log to `dist/day5/` before the next launch.

One Godot. If any Godot is already running, wait. Do not taskkill a ride that is still printing. Do not start the next id beside it. Do not batch the twenty-three into one SceneTree. A style-all with no id is forbidden.

Forbidden all day: `dist\Abbott.exe`, the editor, F5, F6, `--artshot`, `--artshot-rider`, a second Godot, export, pack, a version bump, PowerShell `>` on Godot, `place_fence.py`, a clear `--ridecert` of the whole board.

If a window appears, close it, write the command under `BLACKLIST`, and do not retry it.

No `RIDECERT round` within 2 minutes is a compile error. Kill only that process. Fix. Ride that id again.

Wall clock: read the night logs first, with no Godot. The playtest is a few minutes. Each style id is two rounds, about 20 minutes, 30 for an advanced. The list is the evening. You do not stop after `hk_les_001`.

## Frozen

Do not edit:

- Come again, the hear condition, the +4, `_school_from_round`
- TAKEOFF, the early / late / ideal bands, `window_scale`, `refuse_scale`, `balance_need`, gait speeds, the 3.35 divisor
- The knock box, `add_faults`, how many faults a rail or a refusal is worth
- Any course JSON, either tree
- `ride_ai.gd`, `person_look.gd`, `abbott_look.gd`, `rider_mesh.gd`, `farm.gd`
- `michelle_ship.json`
- The 25k archive, the 48k pile, sand and wood albedo

You may edit `game/scripts/game_state.gd` `note_rail`, `game/scripts/fence.gd` `knock`, and the place in `game/scripts/ride_cert.gd` that fills `rail_fences` on the result row. Nothing else in those files.

## The table, before any edit

From `dist/night/<id>.style.log`, for every `FENCE knock`, one row in `dist/DAY5_MEASURE.md`:

| id | style | knock fence | next= | jumping | names differ |

`names differ` is yes when the knock fence is not `next=`. Count the yes rows. `hk_adv_001` refuse, knock 6, next 9, is one of them. Do not start Godot until this table is written. The night files are the answer key for fault totals. Do not overwrite them.

## The only edit

When a pole falls, the number stored is the fence's own `number`, the same integer printed in `FENCE knock`. It is not `next_fence`.

`GameState.rail_nums` is that list, one entry per knock, in order. The results line that already prints `rail %s` from `rail_nums` then names the pole that fell. Do not write a second results string.

The cert result's `rail_fences` is that same list. A body knock that never emits `rail_down` still appears. The jump path in `horse.gd` calls `knock` and then may emit `rail_down`. That pair must produce one list entry, not two. Do not delete the `knocked` guard. Do not emit `rail_down` from a second place.

`add_faults(4)` stays once per knock. A refusal stays whatever it is this morning. Time faults stay whatever they are this morning.

## Proof

Playtest first. `python dist/_run_userarg.py --playtest`. Clear faults 0. Refuse faults 4. Rail faults 4. The rail round's log has one `FENCE knock`, and that fence number is the one `note_rail` stored. If any of those fail, put the three functions back and stop. Do not start the style list.

Then the twenty-three, in this order. One process each. Copy each log to `dist/day5/<id>.style.log` before the next launch.

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

- `faults=` equals the night log for that id and that style. `hk_adv_001` refuse stays 11. Its rail round stays 10. `hk_jo_adv_001` refuse stays 19. A fault total that moves is a fail.
- `teleported=false`, the round completes, fence 1 is refused and jumped again on the refuse round, and the style rail still prints `FENCE knock`.
- `rail_fences` equals the `FENCE knock` numbers in that same new log, in that order, one each. No extras.
- Where the day-5 table says the names differ, the new list contains the knock fence, not `next=`.

If one id fails, read the log. Fix only the recording. Ride that id again. If the second ride still changes a fault total, put the three functions back, write the id, and stop the list. Do not edit `ride_ai.gd` to avoid the extra pole. Do not move the fence.

An id with no `RIDECERT done` at 30 minutes, 45 for an advanced, is stuck. Kill only that process. Retry once. If the retry sticks, write the id and go on.

## Stop

Stop only when all of these are true, or a window appeared, or a fault total moved and you reverted:

- The differ table is in `dist/DAY5_MEASURE.md`
- Playtest is 0 / 4 / 4
- `dist/day5/` has 23 style logs, or the list stopped because you reverted
- `dist/DAY5_LOG.md` shows, for each id, night faults, new faults, and the new `rail_fences`

The last lines: how many names differed in the night logs, whether the list now matches `FENCE knock`, files changed, blacklist, and that `dist\Abbott.exe` was not launched and not rewritten.

Do not ask Ernie. The next id is the one after the last file in `dist/day5/`.
