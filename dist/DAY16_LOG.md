# Day 16 — Grok, headless

Saturday, October 10. Branch `day16-grok`, from `day15-claude`. Version stays 2.348.0.0. Nothing pushed, nothing merged.

## Summary for Ernie

A course checker is in (`game/tools/validate_content.gd`). It only reports. No course file was edited, and nothing about how the game plays changed.

It read 23 course files. The index lists the same 23, ids match the file names, fence numbers run 1..N, every kind is in the catalog, heights sit in the class band, every fence is inside the ring, and the walk text and fence names come out non-empty. The prompt said 24 course files. There is no 24th file in `game/content/courses/`.

The shortest jump-to-jump distance on a shipped course is 7.25 m, hk_adv_001 fence 8 to 9. Nothing is shorter.

19 courses store a time allowed that the clock does not use. Lessons match (180 s). The others are shorter than `CLASS_INFO`. A jump-off file is shorter than `max(28, class time × 0.42)`. She rides the game clock, not the number in the file. Left for you. Details are in `dist/day16/content_report.md`.

Every public function in `game_state.gd` and `content_library.gd` that returns a value now has a self-test. Functions that return nothing were left alone. `load_save` is not called from a test, because it reads her save.

`dist/ARCHITECTURE.md` is a guide to the 31 scripts, the scene flow, the modifier chain, the gates, and her save. Nothing in the game changed for it.

Doc comments are on the visual scripts. Comments only. The self-test stayed at 64/0. `trainer.gd` already had a comment on its one top-level function, so it was left as it was.

Those same scripts were already typed. Declarations, parameters, and return types. The one argument left open is `sig` on `hud.gd` `_btn`, because it is used both as a Signal and as a Callable. No type covers both. Nothing was committed for that.

`dist/day16/assets_report.md` lists all 5,398 files under `game/assets/`, except `.import` and `.uid`. Nothing was deleted, moved, or re-encoded. 1,430 are not named by a script or a data file. 1,389 of those are plates under `textures/harvest/proc/`. Five textures are larger than 2048 px on a side. Three files are over 5 MB. 3,808 have no credit line. The ones that need a decision are under Needs Ernie.

Her save SHA-256 is `03d19706fc11dd9737786f3012904b2d82981e797a72032dcb1a58d4dd75b52d` (1109 bytes, last written by her session at 20:43 on Oct 9). The same hash was on the file after the copy. Copies are `dist/day16/save_snapshot.json` and `dist/day16/save_backup.json`. Neither is committed. Both are in `.git/info/exclude`.

`photos_jpg/` stays deleted and unstaged. The Day 15 compile logs stay untracked.

## Status

| task | commit | gates (compile, selftest x/0, playtest, les/beg/jo times, save) | notes |
| --- | --- | --- | --- |
| setup | bdfde927 | compile 1 errors=0, selftest 57/0, playtest 0/4/4 pass, 25.43 / 62.15 / 33.45, SAVE_MATCH | Beg time is 0.01 s off the printed 62.14. That is the allowed wobble. Jump-off `success=false` is the jump-off round. |
| 1 content | 485becd1 | compile 1 errors=0, selftest 57/0, tool exit 0. Playtest and ride not run: this is a new tool, not game code. | 23 courses, 0 failed checks. Report `dist/day16/content_report.md`. |
| 2 clock | dae4f4cb | compile 1 errors=0, selftest 58/0, playtest 0/4/4 pass, 25.42 / 62.14 / 33.45, SAVE_MATCH | New test `class_clock`. Lesson time 0.01 s under 25.43, inside 0.10. |
| 2 glass | 1708c625 | compile 1 errors=0, selftest 59/0, playtest 0/4/4 pass, 25.43 / 62.15 / 33.44, SAVE_MATCH | New test `glass_lines`. Jump-off time 0.01 s under 33.45, inside 0.10. |
| 2 show card | 193d3b18 | compile 1 errors=0, selftest 60/0, playtest 0/4/4 pass, 25.43 / 62.14 / 33.45, SAVE_MATCH | New test `show_card`: unlocks, jump-off offer, ribbons. |
| 2 scales | 4eb5cd47 | compile 1 errors=0, selftest 61/0, playtest 0/4/4 pass, 25.43 / 62.15 / 33.45, SAVE_MATCH | New test `horse_scales`. Beginner time 0.01 s over 62.14, inside 0.10. |
| 2 numbers | 70802036 | compile 1 errors=0, selftest 62/0, playtest 0/4/4 pass, 25.43 / 62.14 / 33.45, SAVE_MATCH | New test `round_numbers`: official time, finish, best, key name, next fence. |
| 2 voice | 5bcc40ce | compile 1 errors=0, selftest 63/0, playtest 0/4/4 pass, 25.42 / 62.14 / 33.44, SAVE_MATCH | New test `voice_and_start`. Lesson and jump-off 0.01 s inside the wobble. |
| 2 library | 99e8f480 | compile 1 errors=0, selftest 64/0, playtest 0/4/4 pass, 25.43 / 62.15 / 33.44, SAVE_MATCH | New test `library_lines`. Beginner 0.01 s over 62.14 and jump-off 0.01 s under 33.45, both inside 0.10. Task 2 is done: every public function that returns a value in `game_state.gd` and `content_library.gd` has a test. `load_course`, `specs_from_course` and `load_ship` were already in the older course tests. Functions that return nothing are not pinned. `load_save` is not called from a test, because it reads her save. |
| 3 architecture | 9a540281 | no gates: markdown only | `dist/ARCHITECTURE.md`. All 31 scripts in `game/scripts/`. |

| 4 scoreboard | 8127da3b | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `scoreboard_live.gd`. |
| 4 rosette | 16f4a161 | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `rosette.gd`. |
| 4 tail | b09553d8 | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `tail_carriage.gd`. |
| 4 ears | a4b0a3fc | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `ear_life.gd`. |
| 4 braids | 55140975 | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `braids.gd`. |
| 4 crowd | 6f021143 | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `watch_rider.gd`. |
| 4 lesson | 511564b8 | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `first_lesson.gd`. |
| 4 walk | 2389869a | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `walker.gd`. |
| 4 bascule | 1a3af23b | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `bascule.gd`. |
| 4 options | b0a83af4 | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `settings_menu.gd`. |
| 4 people | 4c9062a2 | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `person_look.gd`. |
| 4 title | af82698d | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `title.gd`. |
| 4 horse look | e699da42 | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `abbott_look.gd`. |
| 4 meshes | 4f5f2269 | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `mesh_kit.gd`. |
| 4 farm | a16abc30 | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `farm.gd`. |
| 4 hud | 1bda3969 | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `hud.gd`. |
| 4 rider | 67ece06a | selftest 64/0. Comment only, so compile, playtest and the rides were not run. | Doc comments on `rider_mesh.gd`. |
| 4 trainer | none | no change | Every top-level func in `trainer.gd` already had a `##` comment. One function. No commit. |
| 5 types | none | no change | No untyped `var` and no missing return type in the named files. `hud.gd` `_btn` still takes `sig` with no type: the call sites pass a Signal or a Callable, and one parameter cannot be both. For-loop variables were left as they are. No commit. |
| 6 assets | t6 | no gates: markdown only | `dist/day16/assets_report.md`. 5398 files. Referenced 3968. Unreferenced 1430. No credit 3808. Over 2048 px: 5. Over 5 MB: 3. Nothing deleted. |

## Baseline

```
COMPILE 1 errors=0
SELFTEST SUMMARY pass=57 fail=0
PLAYTEST clear faults=0 complete=true
PLAYTEST refuse faults=4
PLAYTEST rail faults=4
PLAYTEST done pass=true
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=25.43 teleported=false
RIDECERT done round=first offer=false
RIDECERT hk_beg_035 style=clear success=true faults=0 jumped=8/8 t=62.15 teleported=false
RIDECERT hk_beg_035 style=clear success=false faults=0 jumped=4/4 t=33.45 teleported=false
RIDECERT done round=first offer=true RIDECERT done round=jumpoff
SAVE_MATCH
GATES_DONE
```

`dist/day16/gates.sh` and `dist/day16/GROK_PROMPT.md` were already on `day15-claude` (the Day 16 prep commit). This commit adds the log.

## Needs Ernie

- The course files and the clock disagree on 19 courses. The game uses `CLASS_INFO` (`time_allowed()`), not `time_allowed_school` / `time_allowed_show` in the file. Beginner file 82.0 / 77.9, game 100 / 95. Intermediate 73.8 / 69.7 against 90 / 85. Advanced 65.6 / 61.5 against 80 / 75. Jump-off beginner 34.4 / 32.7 against 42.00 / 39.90, intermediate 31.0 / 29.3 against 37.80 / 35.70, advanced 28.0 / 28.0 against 33.60 / 31.50. Lessons already match. I did not change a course or the clock.
- There are 23 course files, not 24. Index and files agree. No missing id turned up.
- Five textures are larger than 2048 px: `photos/IMG_3408.jpg` and `photos/IMG_3409.jpg` (4284 x 5712), `photos/abbott_title_drawn.jpg` (2560 x 1440), `textures/abbott_shader_face.jpg` (2227 x 5426), `textures/abbott_shader_stall.jpg` (1149 x 2499). I did not resize them.
- Three files are over 5 MB: `cc0/polyhaven/kloofendal_48d_partly_cloudy_2k.hdr` (6.18 MB, the sky, credited), `meshes/abbott.glb` (9.11 MB, referenced, no credit line), `photos/IMG_3409.jpg` (5.55 MB). I did not re-encode them.
- 1,389 plates under `textures/harvest/proc/` are not named by any script or data file. Rough maps are never loaded: `mat_tex` and the sand loader build the `_normal` path from the albedo name and do not touch `_rough`. I did not delete any of them.
- `audio/ambient_indoor.wav` is not loaded. The title and the farm load `ambient_outdoor.wav`.
- The horse the game builds is `meshes/abbott_v2d.glb`. That file has no credit line. `meshes/ATTRIBUTION.txt` names `abbott_v2.glb`, and nothing references that file. `meshes/abbott.glb` is referenced and has no credit line either. `meshes/quaternius-WhiteHorse.glb` has no credit line.
- The three fonts, the photos, and the loose coat, mane, and rider photos have no credit line. The attribution files themselves show as uncredited because they are the credit notes. Kenney's kit, the audio set, and the Poly Haven sky are credited as packs.

## Blocked

None.
