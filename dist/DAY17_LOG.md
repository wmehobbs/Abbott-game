# Day 17 — Grok, windows allowed

Sunday, October 11. Branch `day17-grok`, from `day16-grok`. Version stays 2.348.0.0. Nothing pushed, nothing merged.

## Summary for Ernie

Setup is done. The distance word, the course map, a loose mane for lessons and schooling, show-day dressing, and applause after a clear show round are in. Show day still braids him.

Open `dist/day17/review/00_morning.png` first. It is the before-and-after page: the distance word, the course map, the mane, the flowers, and the wide view of show day. This log is the summary.

The computer is set to stay awake (AC sleep, hibernate, and the monitor timeout are 0, and a stay-awake loop is running). Grok Build was already on always-approve. No config change.

Her save was copied and not modified. SHA-256 `03d19706fc11dd9737786f3012904b2d82981e797a72032dcb1a58d4dd75b52d`, 1109 bytes. There is no `settings.cfg` and no `abbott_save.json.bak`. The copy is `dist/day17/snapshot_abbott_save.json`. It is not committed.

Baseline gates, tag `baseline`: compile clean, self-test 67/0, playtest 0/4/4, rides 25.43 / 62.14 / 33.44, her save unchanged. The jump-off printed 33.44. That is 0.01 s under 33.45, inside the allowed wobble. `success=false` on that line is the jump-off round.

Baseline pictures, all `SAVE_MATCH`:

- Day 12 shot list: `dist/day17/shots/base_list`
- Title: `dist/day17/shots/base_title` (`title_500.png`, `title_8000.png`)
- Frame rate, twice each: lesson 79 and 95 (median 87), show 101 and 81 (median 91). Logs in `dist/day17/shots/fps/`. A later lesson median must stay at or above 82.7, and a show median at or above 86.5 (5% under these medians).
- Show-day probes (`showday.json` and `braids1.json`): `dist/day17/shots/base_show`

What is better now: the distance word ("Deep", "Right on") no longer sits on her back. It is under the scoreboard, in the sky. Sheet: `dist/day17/review/a_grade_deep.png`. A course map sits in the top-right corner while she rides or walks the course. Sheet: `dist/day17/review/b_course_map.png` (off beside on, plus the results card).

What the map tells her: the ring, long side up the screen and the in-gate at the bottom; each fence as a short bar with its number; the next fence in gold, the same number as the "Fence 3 of 8" line; fences already jumped drawn dim; Abbott as an arrow pointing the way he faces. It steps aside while the reins card is up, so those instructions stay clear, and it hides for pause, the results card, options, and the lesson card. Turn it off under Options, Picture, "Course map". It is on by default and is saved with the other picture settings.

Lessons and schooling now have a loose mane down the off side of his neck, in place of only the painted stripe. Show day still hides it and shows the braids. Sheet: `dist/day17/review/c_mane.png` (painted stripe beside the hair, at the halt, the canter, and over a jump). From the side and the three-quarter it reads as short pale hair lying on the right side of the neck. From the saddle it barely shows, which is the same as hair lying on the off side. The painted stripe is still there underneath.

Tried and not kept: the first mane stood up off the crest in spikes. The hair had been shaped on the neck's rest pose, and the pose he actually stands in lifted that into a mohawk. That version was never committed. The one that is in hangs with gravity, so a lowered neck does not leave it standing up.

Show day now has a small judge's stand outside the left rail (the stands are at the far end, and the clock booth is on the right), flower urns either side of the in-gate, and a pickup with two trailers in the field past the stands. A lesson does not build them. Sheet: `dist/day17/review/d_show_dress.png` (the riding view, the in-gate, the stand, a wide view, and the field, each before beside after). From the saddle the course is the same: the stand is a small booth on the rail as she looks toward the gate, and the trailers sit beyond the far end. The urns flank the opening and do not fill it. The two people in the booth face into the ring.

A clear round at a show gets one burst of applause as the crowd starts to wave. It is generated, not a recording, about 4.5 seconds, and it plays once from one player on the Barn slider at about −10 dB. Lessons and schooling stay quiet. The picture of the sound is `dist/day17/review/e_applause_spec.png`. Please listen in the morning. Peak is 0.89 of full scale, so it does not clip. 98.9% of the energy sits between 1 and 4 kHz. The first 0.3 seconds rise in, and the last fifth of a second is nearly quiet.

The show classes were ridden again on seeds 2 and 3. All six finished. Nothing new to fix in the picture. The final shot list is `dist/day17/shots/final_list`. The final show-day probe is `dist/day17/shots/final_show`.

What needs you: see Needs Ernie. The short version is the finish camera in the in-gate, "1 faults", and the advanced rounds being over the time allowed.

## Status

| task | commit | gates (compile, selftest x/0, playtest, les/beg/jo times, save) | fps lesson/show | notes |
| --- | --- | --- | --- | --- |
| setup | eea719b8 | compile 1 errors=0, selftest 67/0, playtest 0/4/4 pass, 25.43 / 62.14 / 33.44, SAVE_MATCH | 87 / 91 | Tag `baseline`. Jump-off 0.01 s under 33.45. `success=false` is the jump-off. Gate log stays untracked until the finish. |
| A tool | d5b0a24e | compile 1 errors=0, selftest 67/0, playtest 0/4/4 pass, 25.43 / 62.14 / 33.45, SAVE_MATCH | | Tag `a1`. The tool rides a list and saves the screen. A two-round check armed the rider on the second round (the arena clears that flag as it leaves). Lesson 0 faults 25.45 s, schooling beginner 0 faults 62.10 s. |
| A grade | 1b30b1a8 | compile 1 errors=0, selftest 67/0, playtest 0/4/4 pass, 25.42 / 62.15 / 33.44, SAVE_MATCH | see note | Tag `a2`. Each time is 0.01 s off the posted line, inside the wobble. Frame counter: lesson 36, 65, 51 and show 39, 42, 38. The same lesson with the label put back was 67. GPU time stayed about 0.8 to 1.0 ms, the same as the baseline. The counter is the machine, not the label, so the move stays. |
| B map | be78b52c | compile 1 errors=0, selftest 68/0, playtest 0/4/4 pass, 25.43 / 62.14 / 33.45, SAVE_MATCH | 73 and 42 / 46 and 40 | Tag `b1`. Times match the posted line. The new test is the 68th. The frame counter's median is under the 5% floor. GPU stayed 0.87 to 0.97 ms, the same band as the grade-move runs tonight (about 0.8 to 1.0). The two lesson samples disagree with each other by far more than 5%, so the counter is the machine. The map stays. |
| C mane | ad57d32c | compile 1 errors=0, selftest 68/0, playtest 0/4/4 pass, 25.43 / 62.15 / 33.45, SAVE_MATCH | 66 and 42 / 37 and 40 | Tag `c1`. Beginner 62.15 is 0.01 s over 62.14, inside the wobble. The mane check is inside the existing braid test, so the pass count stays 68. GPU 0.85 to 1.00 ms, the same band as the map. The two lesson samples disagree by far more than 5%, so the counter is the machine. The mane stays. |
| D dress | 0acd12af | compile 1 errors=0, selftest 68/0, playtest 0/4/4 pass, 25.43 / 62.14 / 33.45, SAVE_MATCH | 66 and 83 / 96 and 92 | Tag `d1`. Times match the posted line. The dressing check is inside the existing braid test, so the pass count stays 68. Lesson samples disagree by far more than 5%, and the slower one had the lower GPU time (0.81 ms against 1.19). Show median 94 is above the baseline 91. The counter is the machine. The dressing stays. |
| E applause | af002017 | compile 1 errors=0, selftest 68/0, playtest 0/4/4 pass, 25.43 / 62.14 / 33.44, SAVE_MATCH | 35 and 35 / 54 and 39 | Tag `e1`. Jump-off 33.44 is 0.01 s under 33.45, inside the wobble. `success=false` is the jump-off. The player is silent during the sample. GPU stayed 0.94 to 1.03 ms, the same band as the dressing runs that scored 66 to 96. The counter is the machine. The applause stays. |
| F again | ef89eb07 | no code change, so no new gate. The show pass printed SAVE_MATCH. | | Show classes, seeds 2 and 3. All six finished. No new visual fix. The architecture note is that commit. |
| final | (this commit) | compile 1 errors=0, selftest 68/0, playtest 0/4/4 pass, 25.43 / 62.14 / 33.45, SAVE_MATCH | | Tag `final`. Times match the posted line. Morning sheet: `dist/day17/review/00_morning.png`. |

## QA findings

Seven, written up in `dist/day17/QA_FINDINGS.md`. One medium visual, fixed (the distance word). Two for you (the finish in the in-gate, "1 faults"). One low camera note. Three riding reports. The third is the extra show courses, seeds 2 and 3: more rounds over the time allowed, and an advanced jump-off with a rail. No new visual break on that pass. The map stayed in the corner, and the new show dressing did not sit on the course.

Seen while shooting the map, and left alone: on a course walk the course sentence is drawn over the scoreboard (`walk_hint` sits at y 96, inside that card). It was already there. Moving it is a separate visual change, so it is not in the map commit.

## Needs Ernie

- After the finish he stands in the in-gate and the camera sits in the jump standard. The camera is `horse.gd`. Pictures on the results cards under `dist/day17/shots/a_rounds/`.
- A one-fault card says "1 faults". The wording is `game_state.gd` `result_line`.
- Advanced seed 0 knocks fence 6 and is over the 75 s time allowed (93.31 s). Both intermediate jump-offs are 40.06 s against 36 s allowed. Riding was not changed. The Day 16 time-allowed note still stands.
- Listen to the applause after a clear show round. It is on the Barn slider. If you don't like it, revert `af002017` ("Day 17: applause after a clear round"). That removes the sound and the one line that starts it. Lessons and schooling never play it.

## Blocked

None.
