# Day 17 — Grok, windows allowed

Sunday, October 11. Branch `day17-grok`, from `day16-grok`. Version stays 2.348.0.0. Nothing pushed, nothing merged.

## Summary for Ernie

Setup is done. Nothing in the game has changed yet.

Open `dist/day17/review/00_morning.png` first when it exists. It is not made yet. This log is the summary.

The computer is set to stay awake (AC sleep, hibernate, and the monitor timeout are 0, and a stay-awake loop is running). Grok Build was already on always-approve. No config change.

Her save was copied and not modified. SHA-256 `03d19706fc11dd9737786f3012904b2d82981e797a72032dcb1a58d4dd75b52d`, 1109 bytes. There is no `settings.cfg` and no `abbott_save.json.bak`. The copy is `dist/day17/snapshot_abbott_save.json`. It is not committed.

Baseline gates, tag `baseline`: compile clean, self-test 67/0, playtest 0/4/4, rides 25.43 / 62.14 / 33.44, her save unchanged. The jump-off printed 33.44. That is 0.01 s under 33.45, inside the allowed wobble. `success=false` on that line is the jump-off round.

Baseline pictures, all `SAVE_MATCH`:

- Day 12 shot list: `dist/day17/shots/base_list`
- Title: `dist/day17/shots/base_title` (`title_500.png`, `title_8000.png`)
- Frame rate, twice each: lesson 79 and 95 (median 87), show 101 and 81 (median 91). Logs in `dist/day17/shots/fps/`. A later lesson median must stay at or above 82.7, and a show median at or above 86.5 (5% under these medians).
- Show-day probes (`showday.json` and `braids1.json`): `dist/day17/shots/base_show`

What is better now: the distance word ("Deep", "Right on") no longer sits on her back. It is under the scoreboard, in the sky. Sheet: `dist/day17/review/a_grade_deep.png`.

Tried and reverted: nothing.

What needs you: see Needs Ernie. The short version is the finish camera in the in-gate, "1 faults", and the advanced rounds being over the time allowed.

## Status

| task | commit | gates (compile, selftest x/0, playtest, les/beg/jo times, save) | fps lesson/show | notes |
| --- | --- | --- | --- | --- |
| setup | eea719b8 | compile 1 errors=0, selftest 67/0, playtest 0/4/4 pass, 25.43 / 62.14 / 33.44, SAVE_MATCH | 87 / 91 | Tag `baseline`. Jump-off 0.01 s under 33.45. `success=false` is the jump-off. Gate log stays untracked until the finish. |
| A tool | d5b0a24e | compile 1 errors=0, selftest 67/0, playtest 0/4/4 pass, 25.43 / 62.14 / 33.45, SAVE_MATCH | | Tag `a1`. The tool rides a list and saves the screen. A two-round check armed the rider on the second round (the arena clears that flag as it leaves). Lesson 0 faults 25.45 s, schooling beginner 0 faults 62.10 s. |
| A grade | (this commit) | compile 1 errors=0, selftest 67/0, playtest 0/4/4 pass, 25.42 / 62.15 / 33.44, SAVE_MATCH | see note | Tag `a2`. Each time is 0.01 s off the posted line, inside the wobble. Frame counter: lesson 36, 65, 51 and show 39, 42, 38. The same lesson with the label put back was 67. GPU time stayed about 0.8 to 1.0 ms, the same as the baseline. The counter is the machine, not the label, so the move stays. |

## QA findings

Six, written up in `dist/day17/QA_FINDINGS.md`. One medium visual, fixed (the distance word). Two for you (the finish in the in-gate, "1 faults"). One low camera note. Two riding reports (advanced fence 6 and the clock, both intermediate jump-offs one time-fault over).

## Needs Ernie

- After the finish he stands in the in-gate and the camera sits in the jump standard. The camera is `horse.gd`. Pictures on the results cards under `dist/day17/shots/a_rounds/`.
- A one-fault card says "1 faults". The wording is `game_state.gd` `result_line`.
- Advanced seed 0 knocks fence 6 and is over the 75 s time allowed (93.31 s). Both intermediate jump-offs are 40.06 s against 36 s allowed. Riding was not changed. The Day 16 time-allowed note still stands.

## Blocked

None.
