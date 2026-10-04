# Grok Build — overnight, the sentence and the fault

You are Grok Build in `E:\Workspace\Madison`. Ernie is asleep. A Godot window locks the desktop. The game stays closed.

This night is long on purpose. Classifying a log is not the night. The night is twenty-three more rides after that, and then twenty-three style rides. You do not stop when the table is written. You do not stop after the four lessons.

Product stays **2.348.0.0**. Do not bump it. Do not export. Do not launch `dist\Abbott.exe`. Last write 24 September, 11:44. Leave it.

Godot, console build only:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

Day 3 stays as it is: `dist/DAY3_LOG.md`, `dist/DAY3_MEASURE.md`, `dist/day3/`. This night writes `dist/NIGHT_LOG.md`, `dist/NIGHT_MEASURE.md`, and logs under `dist/night/`.

## What already stays

The hear line stays. The +4 stays. The ship pool stays at 320 lines. Do not put a line back. Do not cut another. Do not write a new sentence except the one Come again that is already in `horse.gd`.

The board is **21/23**. Every clear still clears. Largest clear move was `hk_beg_034` **+0.08 s** (63.44 to 63.52). `hk_adv_001` is **91.61 s**, 2 time faults, no rail. `hk_adv_003` is **94.01 s**, 3 time faults, no rail. Day-one on those six near-clock rounds added no rail and no look. Do not retune confidence, flowers, or the window.

A stride word may speak over the 3.8 s hold. That stays. Come again may speak over the hold. That stays. Fence 2 of `hk_beg_033` is a one-stride. It says Early / Wait / Now. It does not say Two. It does not say Come again. Leave that fence alone.

Do not run `place_fence.py`. Do not edit a course file. Do not edit `ride_ai.gd`. The two clock courses are circles with a few meters of run and 9 to 16 m of offset. Moving the fence made them worse. Teaching the rider a faster circle is not this night.

## Silent

`--headless` is the first argument after the exe. If it is not, do not run the command.

A clear ride is `python tools/content_factory/run_ridecert.py --ridecert-id <id>`.

A style ride is `python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id <id>`.

The wrapper passes `--headless` and `CREATE_NO_WINDOW`. It opens `dist/ridecert_godot.log` with `"w"`. Copy that log to `dist/night/` before the next launch. A playtest goes through `python dist/_run_userarg.py --playtest`.

One Godot. If any Godot is already running, wait. Do not taskkill a ride that is still printing. Do not start the next id beside it. Do not batch the twenty-three into one SceneTree. A style-all with no id is forbidden. One id, then the file, then the next id.

Forbidden all night: `dist\Abbott.exe`, the editor, F5, F6, `--artshot`, `--artshot-rider`, a second Godot, export, pack, a version bump, PowerShell `>` on Godot.

If a window appears, close it, write the command under `BLACKLIST`, and do not retry it.

No `RIDECERT round` within 2 minutes is a compile error. Kill only that process. Fix. Ride that id again.

Wall clock: a clear id is about 8 to 12 minutes. A style id is two rounds, so budget 20 minutes for a lesson or a jump-off and 30 for an advanced. The full board is about 70 minutes. You may run the full board **once**, and only after a Come again edit is kept. Style does not replace it and does not get a second one.

## Frozen

Do not edit:

- The hear condition, the +4, `_school_from_round`
- TAKEOFF, the early / late / ideal bands, `window_scale`, `refuse_scale`, `balance_need`, gait speeds, the 3.35 divisor
- The 1.6 m line that blanks Two / One. Wide is still not a count.
- The knock box
- Any course JSON, either tree
- `ride_ai.gd`, `person_look.gd`, `abbott_look.gd`, `rider_mesh.gd`, `farm.gd`
- `michelle_ship.json`
- The 25k archive, the 48k pile, sand and wood albedo

## The lie to measure before you touch it

In `_lesson_count`, Come again sits inside the block where `ahead` is already between 0.8 and 11. The test `ahead < 11.0` is already true there. Every unlined approach in that window says Come again, including a lateral of 1.62 m. A horse-width off the line is not a circle. The real rollbacks in `dist/DAY3_MEASURE.md` are 8 to 16 m off.

From `dist/day3/board.log` (and `dist/day3/<id>.after.log` where the board does not have the line), for every `Come again.` write one row in `dist/NIGHT_MEASURE.md`:

| id | fence | ahead | lateral | RIDEAI come again on that fence before the jump | jumped without a circle |

`RIDEAI come again` is the line `ride_ai.gd` already prints. Do not add another. A fence she leaves without that line is a lie: she heard Come again and then jumped it. Lateral under 4 m with no circle is the lie you are looking for. Lateral of 8 m and a circle is a true sentence. Do not "fix" those.

If every Come again in the board log is followed by a circle, write that, and do not edit the sentence. Go to the style list.

If any lie exists, change one number in the Come again test only: she says it when `lateral >= 4.0`, still inside the same ahead window, still once per approach. Do not change 1.6. Do not change 11. Do not delete the COUNT print. The `ahead < 11.0 or straight_run < 11.0` clause is not a filter. Remove that trick so the lateral floor is the only new gate.

Then re-ride all 23 clear ids, in the order below. Copy each log to `dist/night/<id>.clear.log` before the next. Come again must be absent on every fence whose night row was a lie. It must still be present on a circled fence with lateral >= 4, including `hk_adv_001` fences 7 and 9 if those rows were circles. `hk_beg_033` fence 2 still does not say it. Clears stay clear. No new rail. No teleport. Times within 0.3 s of `dist/day3/board.json`. If a clear breaks, revert the number and stop editing. The style list still runs.

You get two tries at the number (4.0, then 6.0 if 4.0 still speaks on a lie or goes silent on fences 7 and 9). The second try re-rides only `hk_les_001`, `hk_beg_033`, and `hk_adv_001`, then the courses that still lie. Not a third number. If both fail, put the sentence back to this morning's bytes and write the two tries.

If the sentence stayed changed, one full `python tools/content_factory/run_ridecert.py`. Compare to `dist/day3/board.json`. Same rule as day 3: every clear still clears, no new rail, no teleport, no clear moves more than **0.1 s**. The two clock courses may move 0.3 s and must not gain a rail. Copy the log to `dist/night/board.log` and the json to `dist/night/board.json`. If the board breaks, revert the sentence and do not ride a second board.

## The twenty-three, in this order

Use this order for the clear re-rides, if you re-ride, and for every style id. One process each. The file exists before the next launch.

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

## Style, all twenty-three, no sample

This starts whether or not the sentence changed. It is the rest of the night.

`--ridecert-style --ridecert-id <id>` rides that one course twice: `refuse_early` on fence 1, then `rail_late` on fence 3, or on the last fence if the course has fewer than 3. Jump-offs use fence 4 for the rail. That is already what `_run_style_all` does. Do not change it.

Copy each log to `dist/night/<id>.style.log`. Write one row before the next id:

| id | refuse faults | refuse fence jumped again | rail knocked | rail faults | round complete | teleported | Come again on a straight fence |

A straight fence is one that, on today's clear log or on `dist/day3/board.json`'s clear round, was not silent. Come again on a straight fence is a regression. Revert the sentence if it is still the edited one. If the sentence is already this morning's bytes, write the fence and do not edit.

What a keep looks like:

- The refuse round finishes, `teleported=false`, fence 1 is in the refused list, and fence 1 is jumped after the refuse. All fences jumped.
- The rail round finishes, `teleported=false`, the log contains `FENCE knock` on the style fence, and that fence is in the rail list. All fences jumped.
- Lessons and schooling may score those as 4 and 4. Show rounds add those faults under Table A. The two Mini Prix may also carry time faults. A time fault is not a failure of the style. A missing refuse, a missing knock, a teleport, or a round that does not finish is a failure.

On a failure, read the log before you edit. Fix only if the horse ate the refuse or the knock: `horse.gd` or `game_state.gd`, not the course and not `ride_ai.gd`. One fix, then that id again. If the rider never presented the fence, that is the planner. Write it. Do not edit `ride_ai.gd`. Do not move the fence. Go on to the next id.

A style id with no `RIDECERT done` at 30 minutes (45 for an advanced) is stuck. Kill only that process. Retry once. If the retry sticks, write the id and go on. Do not start a second Godot to "finish it."

## Stop

Stop only when all of these are true, or a window appeared:

- The Come again table is in `dist/NIGHT_MEASURE.md`, and the sentence is either kept with a board or put back
- `dist/night/` has 23 style logs and 23 style rows
- `dist/NIGHT_LOG.md` lists every keep and every revert

The last lines: how many style files exist, whether Come again changed, the board score if you rode one, files changed, blacklist, and that `dist\Abbott.exe` was not launched and not rewritten.

Do not ask Ernie. The next id is the one after the last file in `dist/night/`.
