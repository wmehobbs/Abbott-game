# Day 17 QA — ten watched rounds

Sunday, October 11. Branch `day17-grok`. The computer rider rode the lesson, three schooling classes, and both courses of each show class. Every round finished. Her save did not change. Contact sheets: `dist/day17/review/a_*.png`. Full frames: `dist/day17/shots/a_rounds/`.

| round | faults | time | jump-off |
| --- | --- | --- | --- |
| lesson | 0 | 25.44 | no |
| schooling beginner | 0 | 62.06 | no |
| schooling intermediate | 0 | 82.35 | no |
| schooling advanced | 7 | 93.31 | no |
| show beginner seed 0 | 0 | 62.09 | clear, 34.32 |
| show beginner seed 1 | 0 | 76.65 | clear, 34.33 |
| show intermediate seed 0 | 0 | 82.37 | 1 fault, 40.06 |
| show intermediate seed 1 | 0 | 73.34 | 1 fault, 40.06 |
| show advanced seed 0 | 8 | 93.31 | no (not clear) |
| show advanced seed 1 | 1 | 81.11 | no (not clear) |

The rider stayed on the horse. No round hung. No magenta textures. The opening frame of each round is the black fade-in (`t000.png`). That is the fade, not a missed capture.

## Findings

### 1. Distance word sits on the rider — medium — visual

The word after a fence ("Deep", "Right on", and the others) is drawn at the middle of the screen, so it lands on Madison when Abbott is in the middle of the picture.

Picture: `dist/day17/shots/a_rounds/lesson_lesson_s0/t010.png` ("Deep" across her back). Also `schooling_intermediate_s0/t014.png` ("Right on", that time in the open sand because he was off to the left).

Cause: `hud.gd` placed the grade label just below the screen centre. It now sits under the scoreboard, in the sky, so it no longer covers her. Before and after: `dist/day17/review/a_grade_deep.png`. Same moment of the lesson (12.41 s). On the after picture the word crosses the barn roof because the camera is outside the rail there. She is clear of it.

### 2. At the finish he stands in the in-gate — medium — needs Ernie

On every results card the horse has walked into the in-gate. His head and neck go through the rail, and the camera sits inside the jump standard on the left. The card itself is readable.

Pictures: `dist/day17/shots/a_rounds/show_advanced_s0/results.png`, `show_advanced_s1/results.png`, `show_intermediate_s0/results_jo.png`, `schooling_beginner_s0/results.png` from the earlier check.

The follow camera is `horse.gd` `_camera`. Where he stops is the ride, not a visual script. Not changed.

### 3. "1 faults" — low — needs Ernie

A one-fault card says "1 faults". The time-fault half is already right ("1 time fault").

Pictures: `dist/day17/shots/a_rounds/show_advanced_s1/results.png`, `show_intermediate_s0/results_jo.png`.

The line is built in `game_state.gd` `result_line`. That file is not to be edited. Not changed.

### 4. On a turn he sits on the left edge — low — needs Ernie

In a tight turn the camera looks ahead and Abbott is at the left edge. He is still in the picture. He was not lost for a whole shot in this pass.

Pictures: `dist/day17/shots/a_rounds/show_advanced_s1/t016.png`, `show_intermediate_s0/t028.png`, `schooling_intermediate_s0/t047.png`.

The camera is `horse.gd`. Not changed.

### 5. Advanced fence 6, and the clock — riding, report only

Same course, seed 0, schooling and show: the log says the horse knocked fence 6 at (-7.2, 21.8). The show card is 8 faults, 93.31 s, 4 of them time faults, rail 6. Time allowed on that card is 75 s. Schooling advanced was 7 faults in 93.31 s.

Show advanced seed 1 was clear of rails and 1 time fault (81.11 s, allowed 75 s).

Pictures: `dist/day17/shots/a_rounds/show_advanced_s0/results.png`, `show_advanced_s1/results.png`.

Not a visual script. The time-allowed mismatch Day 16 already logged is still yours. The rider was not tuned.

### 6. Both intermediate jump-offs are one second-band over — riding, report only

Seed 0 and seed 1 each jumped off clear of rails in 40.06 s. The card says time allowed 36 s, so 1 time fault. The two times match to the hundredth.

Picture: `dist/day17/shots/a_rounds/show_intermediate_s0/results_jo.png` (seed 1 has the same line in the log).

Not changed.
