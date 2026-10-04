# Day 3 measure — Abbott 2.348.0.0

Each row is copied from `dist/day3/<id>.log` after that ride, not from yesterday. Fence 2 on `hk_beg_033` missing Two is a one-stride. It is not a bug.

The full board is `dist/day3/board.log`. Score against the coaching table is 21/23. Largest clear move is `hk_beg_034` 63.44 to 63.52. Day-one rides are `dist/day3/<id>.fresh.log`. On all six, the day-one horse added no rail and no look.

| id | faults | time | teleported | fences | fences with Two or One | fences with only a bare word | fences silent | dropped=true count |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| hk_les_001 | 0 | 18.53 | false | 3/3 | 1 2 3 | — | 2 | 2 |
| hk_les_002 | 0 | 16.54 | false | 3/3 | 1 2 3 | — | 2 | 1 |
| hk_les_003 | 0 | 18.21 | false | 3/3 | 1 2 3 | — | 2 | 2 |
| hk_les_004 | 0 | 17.95 | false | 3/3 | 1 2 3 | — | 2 | 1 |
| hk_beg_035 | 0 | 67.28 | false | 8/8 | 1 2 3 4 5 6 7 8 | — | 1 2 3 6 7 8 | 1 |
| hk_beg_039 | 0 | 70.74 | false | 8/8 | 1 2 3 4 5 6 7 8 | — | 1 3 4 5 6 7 8 | 2 |
| hk_beg_004 | 0 | 70.32 | false | 8/8 | 1 2 3 4 5 6 7 8 | — | 1 2 3 5 6 7 8 | 4 |
| hk_beg_034 | 0 | 63.43 | false | 8/8 | 1 2 3 4 5 6 7 8 | — | 1 2 3 4 6 7 8 | 2 |
| hk_beg_007 | 0 | 65.54 | false | 8/8 | 1 2 3 4 5 6 7 8 | — | 1 2 5 6 7 8 | 2 |
| hk_beg_033 | 0 | 59.87 | false | 8/8 | 1 2 3 4 5 6 7 8 | — | 1 4 5 6 7 8 | 2 |
| hk_int_001 | 0 | 90.84 | false | 10/10 | 1 2 3 4 5 6 7 8 9 10 | — | 1 4 5 6 7 8 9 10 | 4 |
| hk_int_002 | 0 | 80.3 | false | 10/10 | 1 2 3 4 5 6 7 8 9 10 | — | 1 2 3 6 7 8 | 3 |
| hk_int_005 | 0 | 92.28 | false | 10/10 | 1 2 3 4 5 6 7 8 9 10 | — | 1 2 3 5 6 7 8 9 | 0 |
| hk_int_006 | 0 | 79.02 | false | 10/10 | 1 2 3 4 5 6 7 8 9 10 | — | 1 2 3 6 7 8 9 10 | 5 |
| hk_int_007 | 0 | 84.95 | false | 10/10 | 1 2 3 4 5 6 7 8 9 10 | — | 1 2 5 6 7 8 9 10 | 3 |
| hk_int_009 | 0 | 84.99 | false | 10/10 | 1 2 3 4 5 6 7 8 9 10 | — | 1 2 5 6 7 8 9 10 | 1 |
| hk_adv_001 | 2 | 91.6 | false | 12/12 | 1 2 3 4 5 6 7 8 9 10 11 12 | — | 1 2 3 6 7 8 9 12 | 4 |
| hk_adv_002 | 0 | 83.14 | false | 12/12 | 1 2 3 4 5 6 7 8 9 10 11 12 | — | 1 2 5 6 7 8 9 10 | 7 |
| hk_adv_003 | 3 | 94.0 | false | 12/12 | 1 2 3 4 5 6 7 8 9 10 11 12 | — | 1 4 5 6 7 8 9 10 11 | 3 |
| hk_adv_005 | 0 | 78.91 | false | 12/12 | 1 2 3 4 5 6 7 8 9 10 11 12 | — | 1 2 3 6 7 8 9 12 | 6 |
| hk_jo_beg_001 | 0 | 35.31 | false | 4/4 | 1 2 3 4 | — | 1 2 3 4 | 0 |
| hk_jo_int_001 | 0 | 36.5 | false | 4/4 | 1 2 3 4 | — | 1 2 3 4 | 0 |
| hk_jo_adv_001 | 0 | 35.82 | false | 4/4 | 1 3 4 | 2 | 1 2 3 4 | 0 |

## Second table, from the phase 1 logs

Too short: 45. First COUNT is stride 0 or 1, and that fence has no stride 2. Not a swallow. Not fixed.

| course | fence | first stride |
| --- | ---: | ---: |
| hk_les_002 | 2 | 1 |
| hk_les_004 | 2 | 1 |
| hk_beg_035 | 1 | 1 |
| hk_beg_035 | 2 | 1 |
| hk_beg_035 | 3 | 1 |
| hk_beg_035 | 6 | 1 |
| hk_beg_035 | 8 | 1 |
| hk_beg_004 | 4 | 1 |
| hk_beg_007 | 6 | 1 |
| hk_beg_007 | 8 | 1 |
| hk_beg_033 | 2 | 1 |
| hk_beg_033 | 5 | 1 |
| hk_beg_033 | 6 | 1 |
| hk_int_001 | 3 | 1 |
| hk_int_001 | 6 | 1 |
| hk_int_001 | 10 | 1 |
| hk_int_002 | 2 | 1 |
| hk_int_002 | 3 | 1 |
| hk_int_002 | 9 | 1 |
| hk_int_005 | 2 | 1 |
| hk_int_006 | 2 | 1 |
| hk_int_006 | 4 | 1 |
| hk_int_006 | 6 | 1 |
| hk_int_007 | 6 | 1 |
| hk_int_009 | 2 | 1 |
| hk_int_009 | 9 | 1 |
| hk_adv_001 | 3 | 1 |
| hk_adv_001 | 4 | 1 |
| hk_adv_001 | 11 | 1 |
| hk_adv_002 | 2 | 1 |
| hk_adv_002 | 3 | 1 |
| hk_adv_002 | 12 | 1 |
| hk_adv_003 | 2 | 1 |
| hk_adv_003 | 3 | 1 |
| hk_adv_005 | 3 | 1 |
| hk_adv_005 | 4 | 1 |
| hk_adv_005 | 5 | 1 |
| hk_adv_005 | 10 | 1 |
| hk_adv_005 | 11 | 1 |
| hk_jo_beg_001 | 2 | 1 |
| hk_jo_beg_001 | 3 | 1 |
| hk_jo_int_001 | 2 | 1 |
| hk_jo_int_001 | 3 | 1 |
| hk_jo_adv_001 | 2 | 0 |
| hk_jo_adv_001 | 3 | 1 |

Dropped: 55 stride 1 or 2 lines, `kept=false`, on 19 courses. These are the swallow.

| course | fence | stride | word | ahead | lateral |
| --- | ---: | ---: | --- | ---: | ---: |
| hk_les_001 | 2 | 2 | Two. Wait. | 10.91 | 0.41 |
| hk_les_001 | 3 | 2 | Two. Wait. | 10.13 | 1.34 |
| hk_les_002 | 3 | 2 | Two. Wait. | 10.27 | 0.60 |
| hk_les_003 | 2 | 2 | Two. Wait. | 10.88 | 1.32 |
| hk_les_003 | 3 | 2 | Two. Wait. | 10.31 | 1.42 |
| hk_les_004 | 3 | 2 | Two. Wait. | 10.19 | 1.41 |
| hk_beg_035 | 4 | 2 | Two. Wait. | 10.32 | 1.46 |
| hk_beg_039 | 2 | 2 | Two. Wait. | 10.21 | 0.12 |
| hk_beg_039 | 6 | 1 | One. Wait. | 7.35 | 1.50 |
| hk_beg_004 | 4 | 1 | One. Wait. | 6.99 | 0.93 |
| hk_beg_004 | 4 | 1 | One. Early. | 5.37 | 0.22 |
| hk_beg_004 | 6 | 2 | Two. Wait. | 8.06 | 1.55 |
| hk_beg_004 | 6 | 1 | One. Wait. | 7.53 | 0.27 |
| hk_beg_034 | 4 | 2 | Two. Wait. | 10.15 | 1.51 |
| hk_beg_034 | 5 | 2 | Two. Wait. | 10.29 | 0.02 |
| hk_beg_007 | 3 | 2 | Two. Wait. | 9.83 | 1.50 |
| hk_beg_007 | 4 | 2 | Two. Wait. | 10.21 | 0.40 |
| hk_beg_033 | 2 | 1 | One. Wait. | 6.79 | 0.22 |
| hk_beg_033 | 2 | 1 | One. Early. | 5.40 | 0.22 |
| hk_int_001 | 2 | 2 | Two. Wait. | 10.26 | 0.52 |
| hk_int_001 | 3 | 1 | One. Wait. | 6.93 | 0.07 |
| hk_int_001 | 3 | 1 | One. Early. | 5.37 | 0.07 |
| hk_int_001 | 7 | 2 | Two. Wait. | 10.89 | 0.28 |
| hk_int_002 | 4 | 2 | Two. Wait. | 10.16 | 1.47 |
| hk_int_002 | 9 | 1 | One. Wait. | 6.93 | 0.65 |
| hk_int_002 | 9 | 1 | One. Early. | 5.39 | 0.04 |
| hk_int_006 | 4 | 1 | One. Wait. | 6.87 | 1.34 |
| hk_int_006 | 4 | 1 | One. Early. | 5.39 | 0.24 |
| hk_int_006 | 5 | 2 | Two. Wait. | 9.72 | 0.17 |
| hk_int_006 | 7 | 2 | Two. Wait. | 7.87 | 1.48 |
| hk_int_006 | 7 | 1 | One. Wait. | 7.54 | 0.24 |
| hk_int_007 | 3 | 2 | Two. Wait. | 9.83 | 0.06 |
| hk_int_007 | 4 | 2 | Two. Wait. | 10.28 | 0.37 |
| hk_int_007 | 7 | 1 | One. Wait. | 6.51 | 1.57 |
| hk_int_009 | 4 | 2 | Two. Wait. | 10.26 | 0.09 |
| hk_adv_001 | 4 | 1 | One. Wait. | 6.86 | 0.92 |
| hk_adv_001 | 4 | 1 | One. Early. | 5.38 | 0.23 |
| hk_adv_001 | 5 | 2 | Two. Wait. | 10.30 | 0.45 |
| hk_adv_001 | 12 | 2 | Two. Wait. | 10.60 | 1.56 |
| hk_adv_002 | 3 | 1 | One. Wait. | 6.86 | 1.21 |
| hk_adv_002 | 3 | 1 | One. Early. | 5.40 | 0.25 |
| hk_adv_002 | 4 | 2 | Two. Wait. | 10.32 | 0.37 |
| hk_adv_002 | 6 | 2 | Two. Wait. | 10.47 | 1.47 |
| hk_adv_002 | 11 | 2 | Two. Wait. | 10.27 | 0.14 |
| hk_adv_002 | 12 | 1 | One. Wait. | 6.25 | 0.25 |
| hk_adv_002 | 12 | 1 | One. Early. | 5.39 | 0.25 |
| hk_adv_003 | 3 | 1 | One. Wait. | 6.95 | 0.26 |
| hk_adv_003 | 3 | 1 | One. Early. | 5.39 | 0.26 |
| hk_adv_003 | 12 | 2 | Two. Wait. | 10.18 | 1.53 |
| hk_adv_005 | 5 | 1 | One. Wait. | 6.95 | 0.24 |
| hk_adv_005 | 5 | 1 | One. Early. | 5.38 | 0.24 |
| hk_adv_005 | 10 | 1 | One. Wait. | 6.96 | 0.45 |
| hk_adv_005 | 10 | 1 | One. Early. | 5.39 | 0.45 |
| hk_adv_005 | 11 | 1 | One. Wait. | 6.33 | 0.34 |
| hk_adv_005 | 11 | 1 | One. Early. | 5.39 | 0.34 |

Silent: 134 fences she still jumped. First silent COUNT on that fence.

| course | fence | ahead | lateral |
| --- | ---: | ---: | ---: |
| hk_les_001 | 2 | 10.80 | 6.79 |
| hk_les_002 | 2 | 10.94 | 2.42 |
| hk_les_003 | 2 | 10.72 | 1.71 |
| hk_les_004 | 2 | 10.93 | 3.54 |
| hk_beg_035 | 1 | 5.83 | 8.24 |
| hk_beg_035 | 2 | 10.13 | 16.29 |
| hk_beg_035 | 3 | 10.86 | 4.70 |
| hk_beg_035 | 6 | 6.11 | 6.58 |
| hk_beg_035 | 7 | 0.86 | 25.39 |
| hk_beg_035 | 8 | 10.95 | 7.16 |
| hk_beg_039 | 1 | 6.33 | 9.37 |
| hk_beg_039 | 3 | 10.83 | 8.57 |
| hk_beg_039 | 4 | 11.00 | 8.93 |
| hk_beg_039 | 5 | 10.96 | 9.05 |
| hk_beg_039 | 6 | 6.91 | 5.96 |
| hk_beg_039 | 7 | 0.81 | 14.98 |
| hk_beg_039 | 8 | 10.87 | 7.40 |
| hk_beg_004 | 1 | 7.88 | 2.52 |
| hk_beg_004 | 2 | 10.52 | 14.73 |
| hk_beg_004 | 3 | 10.99 | 9.09 |
| hk_beg_004 | 5 | 10.84 | 9.48 |
| hk_beg_004 | 6 | 7.40 | 6.53 |
| hk_beg_004 | 7 | 0.99 | 23.18 |
| hk_beg_004 | 8 | 10.94 | 7.68 |
| hk_beg_034 | 1 | 6.32 | 9.24 |
| hk_beg_034 | 2 | 7.20 | 16.01 |
| hk_beg_034 | 3 | 10.98 | 8.88 |
| hk_beg_034 | 4 | 10.21 | 1.87 |
| hk_beg_034 | 6 | 10.89 | 4.54 |
| hk_beg_034 | 7 | 0.94 | 15.46 |
| hk_beg_034 | 8 | 10.98 | 6.02 |
| hk_beg_007 | 1 | 6.29 | 8.43 |
| hk_beg_007 | 2 | 6.96 | 15.56 |
| hk_beg_007 | 5 | 10.93 | 8.54 |
| hk_beg_007 | 6 | 10.90 | 4.99 |
| hk_beg_007 | 7 | 1.05 | 18.67 |
| hk_beg_007 | 8 | 8.81 | 12.32 |
| hk_beg_033 | 1 | 6.23 | 8.77 |
| hk_beg_033 | 4 | 10.98 | 8.99 |
| hk_beg_033 | 5 | 10.98 | 8.06 |
| hk_beg_033 | 6 | 10.97 | 4.37 |
| hk_beg_033 | 7 | 1.03 | 17.44 |
| hk_beg_033 | 8 | 10.99 | 6.84 |
| hk_int_001 | 1 | 7.82 | 4.19 |
| hk_int_001 | 4 | 6.50 | 14.83 |
| hk_int_001 | 5 | 9.50 | 15.00 |
| hk_int_001 | 6 | 8.72 | 15.87 |
| hk_int_001 | 7 | 10.41 | 1.62 |
| hk_int_001 | 8 | 1.04 | 20.74 |
| hk_int_001 | 9 | 10.86 | 5.95 |
| hk_int_001 | 10 | 10.58 | 9.55 |
| hk_int_002 | 1 | 6.13 | 8.58 |
| hk_int_002 | 2 | 10.87 | 16.92 |
| hk_int_002 | 3 | 10.50 | 14.03 |
| hk_int_002 | 6 | 5.22 | 16.21 |
| hk_int_002 | 7 | 8.33 | 6.16 |
| hk_int_002 | 8 | 1.16 | 30.05 |
| hk_int_005 | 1 | 6.44 | 8.28 |
| hk_int_005 | 2 | 8.40 | 15.58 |
| hk_int_005 | 3 | 10.18 | 1.76 |
| hk_int_005 | 5 | 9.43 | 13.75 |
| hk_int_005 | 6 | 10.87 | 15.71 |
| hk_int_005 | 7 | 4.87 | 7.83 |
| hk_int_005 | 8 | 0.98 | 17.75 |
| hk_int_005 | 9 | 10.00 | 5.11 |
| hk_int_006 | 1 | 7.99 | 2.47 |
| hk_int_006 | 2 | 6.99 | 16.13 |
| hk_int_006 | 3 | 10.97 | 9.03 |
| hk_int_006 | 6 | 11.00 | 8.86 |
| hk_int_006 | 7 | 7.46 | 5.97 |
| hk_int_006 | 8 | 0.98 | 23.74 |
| hk_int_006 | 9 | 10.99 | 3.66 |
| hk_int_006 | 10 | 10.98 | 3.56 |
| hk_int_007 | 1 | 6.14 | 8.84 |
| hk_int_007 | 2 | 10.95 | 10.46 |
| hk_int_007 | 5 | 6.34 | 14.38 |
| hk_int_007 | 6 | 10.95 | 8.78 |
| hk_int_007 | 7 | 5.04 | 7.33 |
| hk_int_007 | 8 | 0.83 | 14.29 |
| hk_int_007 | 9 | 10.98 | 7.55 |
| hk_int_007 | 10 | 10.95 | 7.98 |
| hk_int_009 | 1 | 7.84 | 2.51 |
| hk_int_009 | 2 | 7.64 | 16.01 |
| hk_int_009 | 5 | 10.98 | 8.93 |
| hk_int_009 | 6 | 8.76 | 14.42 |
| hk_int_009 | 7 | 3.73 | 6.79 |
| hk_int_009 | 8 | 0.86 | 14.82 |
| hk_int_009 | 9 | 10.88 | 5.49 |
| hk_int_009 | 10 | 10.95 | 7.00 |
| hk_adv_001 | 1 | 7.46 | 5.81 |
| hk_adv_001 | 2 | 8.07 | 13.79 |
| hk_adv_001 | 3 | 3.04 | 16.39 |
| hk_adv_001 | 6 | 8.34 | 14.55 |
| hk_adv_001 | 7 | 7.03 | 13.86 |
| hk_adv_001 | 8 | 0.92 | 17.59 |
| hk_adv_001 | 9 | 3.98 | 5.13 |
| hk_adv_001 | 12 | 9.37 | 8.19 |
| hk_adv_002 | 1 | 8.10 | 2.38 |
| hk_adv_002 | 2 | 7.90 | 15.76 |
| hk_adv_002 | 5 | 6.50 | 13.34 |
| hk_adv_002 | 6 | 9.74 | 7.20 |
| hk_adv_002 | 7 | 1.82 | 13.06 |
| hk_adv_002 | 8 | 0.95 | 13.01 |
| hk_adv_002 | 9 | 1.07 | 20.52 |
| hk_adv_002 | 10 | 7.11 | 8.19 |
| hk_adv_003 | 1 | 5.96 | 8.41 |
| hk_adv_003 | 4 | 8.44 | 16.14 |
| hk_adv_003 | 5 | 10.20 | 15.31 |
| hk_adv_003 | 6 | 9.55 | 14.12 |
| hk_adv_003 | 7 | 11.00 | 8.94 |
| hk_adv_003 | 8 | 1.60 | 12.57 |
| hk_adv_003 | 9 | 1.73 | 21.65 |
| hk_adv_003 | 10 | 4.90 | 8.85 |
| hk_adv_003 | 11 | 10.06 | 8.08 |
| hk_adv_005 | 1 | 6.44 | 8.73 |
| hk_adv_005 | 2 | 11.00 | 8.91 |
| hk_adv_005 | 3 | 10.86 | 8.42 |
| hk_adv_005 | 6 | 8.49 | 16.44 |
| hk_adv_005 | 7 | 0.91 | 18.91 |
| hk_adv_005 | 8 | 0.88 | 12.30 |
| hk_adv_005 | 9 | 4.92 | 17.63 |
| hk_adv_005 | 12 | 8.97 | 7.03 |
| hk_jo_beg_001 | 1 | 7.56 | 11.32 |
| hk_jo_beg_001 | 2 | 10.96 | 7.61 |
| hk_jo_beg_001 | 3 | 10.99 | 5.52 |
| hk_jo_beg_001 | 4 | 1.22 | 35.44 |
| hk_jo_int_001 | 1 | 7.05 | 12.13 |
| hk_jo_int_001 | 2 | 10.98 | 5.44 |
| hk_jo_int_001 | 3 | 10.99 | 6.17 |
| hk_jo_int_001 | 4 | 1.02 | 34.20 |
| hk_jo_adv_001 | 1 | 7.21 | 14.51 |
| hk_jo_adv_001 | 2 | 11.00 | 6.57 |
| hk_jo_adv_001 | 3 | 10.97 | 5.18 |
| hk_jo_adv_001 | 4 | 1.31 | 34.19 |
