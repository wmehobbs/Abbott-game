# Day 7 log — Abbott 2.348.0.0

Headless only. Product version not bumped. `dist\Abbott.exe` not launched. Earlier day logs were not overwritten. Come again was not edited. `save()` still returns before it opens the file.

Schooling `hk_adv_001`, show flag absent. Refuse faults 11, `rail_fences=[6]`, time faults 3. Rail faults 10, `[3, 6]`, time faults 2. The save matched the snapshot.

Playtest: clear 0, refuse 4, rail 4. The save matched the snapshot.

## Rounds

| hk_les_001 | refuse_early | lesson | 4 | 0 | 1 | 21.29 | 180 | 0 | no | none | yes | matched |
| hk_les_001 | rail_late | lesson | 4 | 1 | 0 | 18.12 | 180 | 0 | no | none | yes | matched |
| hk_les_002 | refuse_early | lesson | 4 | 0 | 1 | 19.27 | 180 | 0 | no | none | yes | matched |
| hk_les_002 | rail_late | lesson | 4 | 1 | 0 | 16.47 | 180 | 0 | no | none | yes | matched |
| hk_les_003 | refuse_early | lesson | 4 | 0 | 1 | 20.94 | 180 | 0 | no | none | yes | matched |
| hk_les_003 | rail_late | lesson | 4 | 1 | 0 | 18.16 | 180 | 0 | no | none | yes | matched |
| hk_les_004 | refuse_early | lesson | 4 | 0 | 1 | 20.69 | 180 | 0 | no | none | yes | matched |
| hk_les_004 | rail_late | lesson | 4 | 1 | 0 | 17.82 | 180 | 0 | no | none | yes | matched |
| hk_beg_035 | refuse_early | show | 4 | 0 | 1 | 69.89 | 95 | 0 | no | Yellow | yes | matched |
| hk_beg_035 | rail_late | show | 4 | 1 | 0 | 67.17 | 95 | 0 | no | Yellow | yes | matched |
| hk_beg_039 | refuse_early | show | 4 | 0 | 1 | 73.51 | 95 | 0 | no | Yellow | yes | matched |
| hk_beg_039 | rail_late | show | 4 | 1 | 0 | 71.22 | 95 | 0 | no | Yellow | yes | matched |
| hk_beg_004 | refuse_early | show | 4 | 0 | 1 | 73.00 | 95 | 0 | no | Yellow | yes | matched |
| hk_beg_004 | rail_late | show | 4 | 1 | 0 | 70.03 | 95 | 0 | no | Yellow | yes | matched |
| hk_beg_034 | refuse_early | show | 4 | 0 | 1 | 66.03 | 95 | 0 | no | Yellow | yes | matched |
| hk_beg_034 | rail_late | show | 4 | 1 | 0 | 63.51 | 95 | 0 | no | Yellow | yes | matched |
| hk_beg_007 | refuse_early | show | 4 | 0 | 1 | 68.27 | 95 | 0 | no | Yellow | yes | matched |
| hk_beg_007 | rail_late | show | 4 | 1 | 0 | 65.55 | 95 | 0 | no | Yellow | yes | matched |
| hk_beg_033 | refuse_early | show | 4 | 0 | 1 | 62.59 | 95 | 0 | no | Yellow | yes | matched |
| hk_beg_033 | rail_late | show | 4 | 1 | 0 | 60.11 | 95 | 0 | no | Yellow | yes | matched |
| hk_int_001 | refuse_early | show | 6 | 0 | 1 | 93.89 | 85 | 2 | no | White | yes | matched |
| hk_int_001 | rail_late | show | 5 | 1 | 0 | 92.07 | 85 | 1 | no | White | yes | matched |
| hk_int_002 | refuse_early | show | 4 | 0 | 1 | 82.66 | 85 | 0 | no | Yellow | yes | matched |
| hk_int_002 | rail_late | show | 4 | 1 | 0 | 80.68 | 85 | 0 | no | Yellow | yes | matched |
| hk_int_005 | refuse_early | show | 5 | 0 | 1 | 90.01 | 85 | 1 | no | White | yes | matched |
| hk_int_005 | rail_late | show | 4 | 1 | 0 | 87.74 | 85 | 0 | no | Yellow | yes | matched |
| hk_int_006 | refuse_early | show | 4 | 0 | 1 | 81.74 | 85 | 0 | no | Yellow | yes | matched |
| hk_int_006 | rail_late | show | 4 | 1 | 0 | 79.24 | 85 | 0 | no | Yellow | yes | matched |
| hk_int_007 | refuse_early | show | 4 | 0 | 1 | 87.68 | 85 | 0 | no | Yellow | yes | matched |
| hk_int_007 | rail_late | show | 4 | 1 | 0 | 84.83 | 85 | 0 | no | Yellow | yes | matched |
| hk_int_009 | refuse_early | show | 4 | 0 | 1 | 87.88 | 85 | 0 | no | Yellow | yes | matched |
| hk_int_009 | rail_late | show | 4 | 1 | 0 | 84.69 | 85 | 0 | no | Yellow | yes | matched |
| hk_adv_001 | refuse_early | show | 12 | 1 | 1 | 94.45 | 75 | 4 | no | Pink | yes | matched |
| hk_adv_001 | rail_late | show | 11 | 2 | 0 | 91.00 | 75 | 3 | no | Pink | yes | matched |

hk_adv_001 rail_late prints t=91.0 and time faults 3. The result hundredth rounds the raw clock. Four time faults start at 91 exactly, and the stored count is 3, so the clock was still under 91. Parts are 0 + 8 + 3 = 11. Fence knocks are 3 then 6. The clock was not changed.
| hk_adv_002 | refuse_early | show | 7 | 0 | 1 | 87.42 | 75 | 3 | no | White | yes | matched |
| hk_adv_002 | rail_late | show | 6 | 1 | 0 | 84.08 | 75 | 2 | no | White | yes | matched |
| hk_adv_003 | refuse_early | show | 12 | 0 | 1 | 108.21 | 75 | 8 | no | Pink | yes | matched |
| hk_adv_003 | rail_late | show | 12 | 1 | 0 | 107.74 | 75 | 8 | no | Pink | yes | matched |
| hk_adv_005 | refuse_early | show | 5 | 0 | 1 | 81.65 | 75 | 1 | no | White | yes | matched |
| hk_adv_005 | rail_late | show | 4 | 1 | 0 | 78.66 | 75 | 0 | no | Yellow | yes | matched |
| hk_jo_beg_001 | refuse_early | show | 4 | 0 | 1 | 37.74 | 39.9 | 0 | no | Yellow | yes | matched |
| hk_jo_beg_001 | rail_late | show | 4 | 1 | 0 | 35.90 | 39.9 | 0 | no | Yellow | yes | matched |
| hk_jo_int_001 | refuse_early | show | 11 | 1 | 1 | 50.60 | 35.7 | 3 | no | Pink | yes | matched |
| hk_jo_int_001 | rail_late | show | 5 | 1 | 0 | 43.10 | 35.7 | 1 | no | White | yes | matched |
| hk_jo_adv_001 | refuse_early | show | 12 | 2 | 1 | 63.01 | 31.5 | 0 | time | none | yes | matched |
| hk_jo_adv_001 | rail_late | show | 5 | 1 | 0 | 36.42 | 31.5 | 1 | no | White | yes | matched |

## Close

Schooling `hk_adv_001` still reads refuse 11 / `[6]` and rail 10 / `[3, 6]`. Playtest is clear 0, refuse 4, rail 4. `dist/day7/` has 23 show logs. The save matches the snapshot.

37 show rounds finished. 1 show round was eliminated for time: `hk_jo_adv_001` refuse, reason time, clock 63.01, limit 63.0, faults 12 from rails 8 and one refusal 4, no time faults, no ribbon. It was not ridden again.

8 lesson rounds stayed lessons: faults 4, time faults 0, no ribbon.

Ribbons on the finished shows: 24 Yellow, 8 White, 5 Pink. No Blue. No Red. Each ribbon is the row above. One refusal line on each id, so each refusal is 4.

Files changed: `game/scripts/ride_cert.gd` (a lesson stays a lesson; any other class is show when `--ridecert-show` is present), `dist/_day7_ride.py`, `dist/DAY7_LOG.md`, `dist/DAY7_MEASURE.md`, and the logs under `dist/day7/`.

BLACKLIST: none.

`dist\Abbott.exe` was not launched and not rewritten. Last write 24 September 2026, 11:44. Product stayed 2.348.0.0.
