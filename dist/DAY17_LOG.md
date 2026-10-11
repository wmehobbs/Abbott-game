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

What is better now: nothing yet.

Tried and reverted: nothing.

What needs you: nothing yet.

## Status

| task | commit | gates (compile, selftest x/0, playtest, les/beg/jo times, save) | fps lesson/show | notes |
| --- | --- | --- | --- | --- |
| setup | eea719b8 | compile 1 errors=0, selftest 67/0, playtest 0/4/4 pass, 25.43 / 62.14 / 33.44, SAVE_MATCH | 87 / 91 | Tag `baseline`. Jump-off 0.01 s under 33.45. `success=false` is the jump-off. Gate log stays untracked until the finish. |
| A tool | d5b0a24e | compile 1 errors=0, selftest 67/0, playtest 0/4/4 pass, 25.43 / 62.14 / 33.45, SAVE_MATCH | | Tag `a1`. The tool rides a list and saves the screen. A two-round check armed the rider on the second round (the arena clears that flag as it leaves). Lesson 0 faults 25.45 s, schooling beginner 0 faults 62.10 s. |

## QA findings

None yet. The playthrough has not run.

## Needs Ernie

None.

## Blocked

None.
