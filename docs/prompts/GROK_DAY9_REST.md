# Grok Build — finish the refusals, no status reports

You are Grok Build in `E:\Workspace\Madison`. Ernie is not here. He will not answer. A message that describes the remaining rides is a failed day, even if the code is right. Ride the next id. Do not tell him the plan.

A Godot window locks the desktop. The game stays closed.

The styles are already in the code. Do not rewrite them. Do not tune them. `--ridecert-refusals=2` is `refuse_twice`. `--ridecert-refusals=3` is `refuse_three`. The old `--ridecert-style` pair is still refuse-once, then the rail. `note_refuse` stays as it is. The cert print already reports the sum `note_refuse` added.

Product stays **2.348.0.0**. Do not bump it. Do not export. Do not launch `dist\Abbott.exe`.

Godot, console build only:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

## What done means

Count files. If the count is short, you are not done. `dist/DAY9_LOG.md` having two rows is not done.

These files must all exist, and each ride log must contain `RIDECERT done`:

- `dist/day9/playtest.log` — already on disk. Do not ride it again.
- `dist/day9/hk_les_001.style.log` — already on disk. Faults 4 and 4. Do not ride it again.
- `dist/day9/hk_beg_035.school2.log`
- `dist/day9/hk_beg_035.school3.log`
- 23 files `dist/day9/<id>.r2.log`
- 23 files `dist/day9/<id>.r3.log`

That is 48 ride logs after the two you already have. A log that does not contain `RIDECERT done` does not count. Delete it and ride that id again.

You may not write the closing lines of `dist/DAY9_LOG.md` until that count is true. You may append one row after each finished file. Then launch the next id in the same turn. Do not end a turn between ids.

## If a Godot is already up

`dist/day9/_last_cmd.txt` may be the schooling two-refusal ride of `hk_beg_035`. If that process is still printing, wait for it. Do not start a second Godot. When it exits, copy `dist/ridecert_godot.log` to `dist/day9/hk_beg_035.school2.log` if that copy is missing. Then continue. If the process is dead and the file is missing, ride that id. Do not taskkill a live ride.

## Silent

`--headless` is the first argument after the exe. The python wrapper does this. Use only:

Schooling two, then schooling three:

`python tools/content_factory/run_ridecert.py --ridecert-refusals=2 --ridecert-id hk_beg_035`

`python tools/content_factory/run_ridecert.py --ridecert-refusals=3 --ridecert-id hk_beg_035`

Show two, then show three, one id at a time:

`python tools/content_factory/run_ridecert.py --ridecert-show --ridecert-refusals=2 --ridecert-id <id>`

`python tools/content_factory/run_ridecert.py --ridecert-show --ridecert-refusals=3 --ridecert-id <id>`

The wrapper opens `dist/ridecert_godot.log` with `"w"`. Copy it to `dist/day9/` before the next launch.

One Godot. Do not batch the twenty-three into one SceneTree. Do not pass `--ridecert-style` on a refusals command.

Forbidden: `dist\Abbott.exe`, the editor, F5, F6, `--artshot`, a second Godot, export, pack, a version bump, PowerShell `>` on Godot, `place_fence.py`, editing `note_refuse`, editing Come again, moving a fence, editing `ride_ai.gd` unless a refusal count is short and the second ride of that same id is the fix. One fix, one retry, then go on.

If a window appears, close it, write the command under `BLACKLIST` in `dist/DAY9_LOG.md`, and do not retry it.

No `RIDECERT round` within 2 minutes is a compile error. Kill only that process. Fix. Ride that id again.

A finished id is 10 to 15 minutes. Three refusals take longer. Forty-six show rounds are the rest of the night. If your clock says you finished the show lists in under six hours, you skipped. Count the files again and ride every missing id.

An id with no `RIDECERT done` at 40 minutes, 55 for an advanced, is stuck. Kill only that process. Retry once. If the retry sticks, write the id and go on. Restore `dist/day9/save_snapshot.json` over the live save if that process wrote it. The live save is `C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json`. The snapshot is 1109 bytes and must match after every id.

## Schooling pair, then the shows

`hk_beg_035` schooling, two refusals: refusal faults 8, not eliminated, fence 1 jumped after the second refusal, parts add up, save matches.

`hk_beg_035` schooling, three refusals: refusal faults 12, not eliminated, fence 1 jumped after the third, parts add up, save matches.

If either file already exists and contains `RIDECERT done` and those faults, do not ride it again.

Then show `--ridecert-refusals=2`, every file `<id>.r2.log`, in this order. Do not start `.r3.log` until all 23 `.r2.log` files contain `RIDECERT done`.

Then show `--ridecert-refusals=3`, every file `<id>.r3.log`, same order.

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

Lessons stay lessons. Two refusals cost 8. Three cost 12. No elimination. No time faults. No ribbon.

A show two-refusal keep: exactly two `RIDECERT refuse` lines, both fence 1, fence 1 jumped after, refusal faults 12, not eliminated, rails match `FENCE knock`, time faults from the official hundredth, parts add up, save matches.

A show three-refusal keep: exactly three `RIDECERT refuse` lines, all fence 1, `eliminate_reason=three`, faults are 12 plus rails scored before the third refusal, no ribbon, `teleported=false`, save matches.

`hk_jo_adv_001` may hit the 63.0 second show jump-off limit first. If `eliminate_reason=time` and the clock is past 63, write the refusal count and go on. Do not raise the limit. No other id may use that excuse. One retry if another id misses the count. Then go on. Do not change `note_refuse`.

## Stop

Stop only when the file count above is true, or a window appeared.

Then, and only then, the last lines of `dist/DAY9_LOG.md`: how many `.r2.log` files, how many `.r3.log` files, how many eliminated for three refusals, how many for time, whether the save still matches the snapshot, and that `dist\Abbott.exe` was not launched.

Until that count is true, the next action is the next missing id. Not a message.
