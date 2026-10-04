# Abbott — three lanes (20 Sep 2026, night)

Paste the matching file into that window. Do not start a fourth implementation
lane. Do not pack unless Godot is down. `ride_ids.py` kills stray headless
Godots — check `Get-Process *Godot*` before any ride or export.

| Lane | File | Owns | Does not touch |
| --- | --- | --- | --- |
| Claude Code | `docs/prompts/CLAUDE.md` | `ride_place.py`, `place_fence.py`, 23 course JSON (both trees) | look scripts, `Abbott.exe`, Michelle |
| Grok Build | `docs/prompts/GROK_BUILD.md` | `person_look.gd`, `abbott_look.gd`, reins bind in `horse.gd` | `farm.gd`, course JSON, leave windows |
| Cursor | `docs/prompts/CURSOR.md` | `farm.gd` `_pine_plant` / `_oak_plant` only | people, ride, courses, exe |

Board on disk: **21/23**, twice, `ridecert_board.json` === runA === runB.
`hk_adv_002` 83.12 clear. `hk_adv_005` 78.92 clear. Failures are clock only:
`hk_adv_001` 91.59 / 80 (needs **7.6 s** to duck under 84). `hk_adv_003` 94.00
(needs **10.1 s**). Score segments from `dist/ridecert_godot.log` board run,
not `dist/ridecert_logs/`.

Exe: **2.345.0.0**, created 2026-09-12 08:34:04, look 1–46 packed.
Knock stays `(width*0.9, height+0.15, 0.35+spread)`.

Godot:
`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

If only two lanes can run, run Grok (people) and Claude (clock). Trees can wait
one night. A girl inside the rib is not a seat. A metric that slows the horse
is not a metric.
