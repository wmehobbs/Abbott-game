# Day 6 measure — the parts already add up

From `dist/day5` style logs, before any edit. Cert rounds are schooling. A refusal is 4. A rail is 4. A lesson takes no time faults. Any other round takes floor((time_sec - allowed) / 4) when that is positive. Jump-off allowed is max(28, time_school * 0.42). `hk_jo_adv_001` refuse is 65.30 s, allowed 33.6, time faults 7, rails 8, refusal 4, sum 19.

| id | style | faults | rails | refusals | time_sec | allowed | time faults | sum | match |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| hk_les_001 | refuse_early | 4 | 0 | 1 | 21.31 | 180 | 0 | 4 | yes |
| hk_les_001 | rail_late | 4 | 1 | 0 | 18.12 | 180 | 0 | 4 | yes |
| hk_les_002 | refuse_early | 4 | 0 | 1 | 19.26 | 180 | 0 | 4 | yes |
| hk_les_002 | rail_late | 4 | 1 | 0 | 16.47 | 180 | 0 | 4 | yes |
| hk_les_003 | refuse_early | 4 | 0 | 1 | 20.93 | 180 | 0 | 4 | yes |
| hk_les_003 | rail_late | 4 | 1 | 0 | 18.15 | 180 | 0 | 4 | yes |
| hk_les_004 | refuse_early | 4 | 0 | 1 | 20.69 | 180 | 0 | 4 | yes |
| hk_les_004 | rail_late | 4 | 1 | 0 | 17.83 | 180 | 0 | 4 | yes |
| hk_beg_035 | refuse_early | 4 | 0 | 1 | 69.89 | 100 | 0 | 4 | yes |
| hk_beg_035 | rail_late | 4 | 1 | 0 | 67.14 | 100 | 0 | 4 | yes |
| hk_beg_039 | refuse_early | 4 | 0 | 1 | 73.50 | 100 | 0 | 4 | yes |
| hk_beg_039 | rail_late | 4 | 1 | 0 | 71.24 | 100 | 0 | 4 | yes |
| hk_beg_004 | refuse_early | 4 | 0 | 1 | 73.01 | 100 | 0 | 4 | yes |
| hk_beg_004 | rail_late | 4 | 1 | 0 | 70.03 | 100 | 0 | 4 | yes |
| hk_beg_034 | refuse_early | 4 | 0 | 1 | 66.04 | 100 | 0 | 4 | yes |
| hk_beg_034 | rail_late | 4 | 1 | 0 | 63.53 | 100 | 0 | 4 | yes |
| hk_beg_007 | refuse_early | 4 | 0 | 1 | 68.28 | 100 | 0 | 4 | yes |
| hk_beg_007 | rail_late | 4 | 1 | 0 | 65.55 | 100 | 0 | 4 | yes |
| hk_beg_033 | refuse_early | 4 | 0 | 1 | 62.60 | 100 | 0 | 4 | yes |
| hk_beg_033 | rail_late | 4 | 1 | 0 | 60.12 | 100 | 0 | 4 | yes |
| hk_int_001 | refuse_early | 4 | 0 | 1 | 93.89 | 90 | 0 | 4 | yes |
| hk_int_001 | rail_late | 4 | 1 | 0 | 92.08 | 90 | 0 | 4 | yes |
| hk_int_002 | refuse_early | 4 | 0 | 1 | 82.66 | 90 | 0 | 4 | yes |
| hk_int_002 | rail_late | 4 | 1 | 0 | 80.68 | 90 | 0 | 4 | yes |
| hk_int_005 | refuse_early | 4 | 0 | 1 | 90.01 | 90 | 0 | 4 | yes |
| hk_int_005 | rail_late | 4 | 1 | 0 | 87.74 | 90 | 0 | 4 | yes |
| hk_int_006 | refuse_early | 4 | 0 | 1 | 81.72 | 90 | 0 | 4 | yes |
| hk_int_006 | rail_late | 4 | 1 | 0 | 79.23 | 90 | 0 | 4 | yes |
| hk_int_007 | refuse_early | 4 | 0 | 1 | 87.68 | 90 | 0 | 4 | yes |
| hk_int_007 | rail_late | 4 | 1 | 0 | 84.84 | 90 | 0 | 4 | yes |
| hk_int_009 | refuse_early | 4 | 0 | 1 | 87.89 | 90 | 0 | 4 | yes |
| hk_int_009 | rail_late | 4 | 1 | 0 | 84.69 | 90 | 0 | 4 | yes |
| hk_adv_001 | refuse_early | 11 | 1 | 1 | 94.44 | 80 | 3 | 11 | yes |
| hk_adv_001 | rail_late | 10 | 2 | 0 | 91.00 | 80 | 2 | 10 | yes |
| hk_adv_002 | refuse_early | 5 | 0 | 1 | 87.40 | 80 | 1 | 5 | yes |
| hk_adv_002 | rail_late | 5 | 1 | 0 | 84.09 | 80 | 1 | 5 | yes |
| hk_adv_003 | refuse_early | 11 | 0 | 1 | 108.22 | 80 | 7 | 11 | yes |
| hk_adv_003 | rail_late | 10 | 1 | 0 | 107.74 | 80 | 6 | 10 | yes |
| hk_adv_005 | refuse_early | 4 | 0 | 1 | 81.65 | 80 | 0 | 4 | yes |
| hk_adv_005 | rail_late | 4 | 1 | 0 | 78.66 | 80 | 0 | 4 | yes |
| hk_jo_beg_001 | refuse_early | 4 | 0 | 1 | 37.74 | 42 | 0 | 4 | yes |
| hk_jo_beg_001 | rail_late | 4 | 1 | 0 | 35.90 | 42 | 0 | 4 | yes |
| hk_jo_int_001 | refuse_early | 11 | 1 | 1 | 50.60 | 37.8 | 3 | 11 | yes |
| hk_jo_int_001 | rail_late | 5 | 1 | 0 | 43.11 | 37.8 | 1 | 5 | yes |
| hk_jo_adv_001 | refuse_early | 19 | 2 | 1 | 65.30 | 33.6 | 7 | 19 | yes |
| hk_jo_adv_001 | rail_late | 4 | 1 | 0 | 36.41 | 33.6 | 0 | 4 | yes |
