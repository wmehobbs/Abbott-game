# Course content

Report only. No course file was edited. 23 courses, 0 with a failed check.

Limits, read from the code:

- Ring 30.48 m by 76.20 m, centred on the origin (`RING_W` and `RING_D` in `farm.gd`). A fence is inside when its centre and both standards are.
- Class labels and fence counts are `CLASS_INFO` in `game_state.gd`. A jump-off's fence count is what `fences_needed()` returns with `jump_off` set.
- Height bands are `HEIGHTS` in `tools/content_factory/rules.py`, the bands the course builder checks for those same class ids.
  - lesson: label "poles to 2'3"", 3 fences, heights 0.4–0.64 m
  - beginner: label "2'3"", 8 fences, heights 0.58–0.7 m
  - intermediate: label "2'6"", 10 fences, heights 0.72–0.9 m
  - advanced: label "3'0"", 12 fences, heights 0.84–0.96 m
- Shortest consecutive distance on a shipped course is 7.25 m (hk_adv_001 fence 8 to 9). Nothing is shorter.

| id | class | jump-off | fences | height | min gap m | in ring | text | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| hk_les_001 | lesson | no | 3 | poles to 2'3" | 10.73 | yes | yes | — |
| hk_les_002 | lesson | no | 3 | poles to 2'3" | 10.81 | yes | yes | — |
| hk_les_003 | lesson | no | 3 | poles to 2'3" | 10.92 | yes | yes | — |
| hk_les_004 | lesson | no | 3 | poles to 2'3" | 10.78 | yes | yes | — |
| hk_beg_035 | beginner | no | 8 | 2'3" | 9.43 | yes | yes | — |
| hk_beg_039 | beginner | no | 8 | 2'3" | 9.49 | yes | yes | — |
| hk_beg_004 | beginner | no | 8 | 2'3" | 7.54 | yes | yes | — |
| hk_beg_034 | beginner | no | 8 | 2'3" | 10.80 | yes | yes | — |
| hk_beg_007 | beginner | no | 8 | 2'3" | 10.43 | yes | yes | — |
| hk_beg_033 | beginner | no | 8 | 2'3" | 7.29 | yes | yes | — |
| hk_int_001 | intermediate | no | 10 | 2'6" | 7.45 | yes | yes | — |
| hk_int_002 | intermediate | no | 10 | 2'6" | 7.45 | yes | yes | — |
| hk_int_005 | intermediate | no | 10 | 2'6" | 9.55 | yes | yes | — |
| hk_int_006 | intermediate | no | 10 | 2'6" | 7.45 | yes | yes | — |
| hk_int_007 | intermediate | no | 10 | 2'6" | 9.19 | yes | yes | — |
| hk_int_009 | intermediate | no | 10 | 2'6" | 8.23 | yes | yes | — |
| hk_adv_001 | advanced | no | 12 | 3'0" | 7.25 | yes | yes | — |
| hk_adv_002 | advanced | no | 12 | 3'0" | 7.45 | yes | yes | — |
| hk_adv_003 | advanced | no | 12 | 3'0" | 7.41 | yes | yes | — |
| hk_adv_005 | advanced | no | 12 | 3'0" | 7.45 | yes | yes | — |
| hk_jo_beg_001 | beginner | yes | 4 | 2'3" | 22.76 | yes | yes | — |
| hk_jo_int_001 | intermediate | yes | 4 | 2'6" | 21.16 | yes | yes | — |
| hk_jo_adv_001 | advanced | yes | 4 | 3'0" | 20.51 | yes | yes | — |

## Findings

- Shortest consecutive distance on a shipped course is 7.25 m (hk_adv_001 fence 8 to 9). Nothing is shorter.
- The clock does not read the course file. time_allowed() uses CLASS_INFO, and on a jump-off the greater of 28 seconds and that time multiplied by 0.42. 19 courses store other numbers. She rides the game clock.
- hk_beg_035 file 82.0/77.9, game 100.00/95.00
- hk_beg_039 file 82.0/77.9, game 100.00/95.00
- hk_beg_004 file 82.0/77.9, game 100.00/95.00
- hk_beg_034 file 82.0/77.9, game 100.00/95.00
- hk_beg_007 file 82.0/77.9, game 100.00/95.00
- hk_beg_033 file 82.0/77.9, game 100.00/95.00
- hk_int_001 file 73.8/69.7, game 90.00/85.00
- hk_int_002 file 73.8/69.7, game 90.00/85.00
- hk_int_005 file 73.8/69.7, game 90.00/85.00
- hk_int_006 file 73.8/69.7, game 90.00/85.00
- hk_int_007 file 73.8/69.7, game 90.00/85.00
- hk_int_009 file 73.8/69.7, game 90.00/85.00
- hk_adv_001 file 65.6/61.5, game 80.00/75.00
- hk_adv_002 file 65.6/61.5, game 80.00/75.00
- hk_adv_003 file 65.6/61.5, game 80.00/75.00
- hk_adv_005 file 65.6/61.5, game 80.00/75.00
- hk_jo_beg_001 file 34.4/32.7, game 42.00/39.90
- hk_jo_int_001 file 31.0/29.3, game 37.80/35.70
- hk_jo_adv_001 file 28.0/28.0, game 33.60/31.50
