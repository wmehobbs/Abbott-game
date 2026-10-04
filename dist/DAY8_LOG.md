# Day 8 log — Abbott 2.348.0.0

Headless only. Product version not bumped. `dist\Abbott.exe` not launched. Earlier day logs were not overwritten.

The official time is `floor(time_sec * 100.0) / 100.0`. Time faults, the cert line, `last_time`, and the result line use that number. It is truncated, not rounded.

A style command is written by the wrapper to `dist/ridecert_style.log`. A clear command is written to `dist/ridecert_godot.log`. Each log is copied here before the next launch.

## Rounds

hk_adv_001 show style rail printed t=90.99. Below 91: yes.
| hk_les_001 | show | 0 | 18.52 | 0 | 0 | none | no | false | yes | matched |
| hk_les_002 | show | 0 | 16.53 | 0 | 0 | none | no | false | yes | matched |
| hk_les_003 | show | 0 | 18.22 | 0 | 0 | none | no | false | yes | matched |
| hk_les_004 | show | 0 | 17.94 | 0 | 0 | none | no | false | yes | matched |
| hk_beg_035 | show | 0 | 67.27 | 0 | 0 | Blue | no | false | yes | matched |
| hk_beg_039 | show | 0 | 70.73 | 0 | 0 | Blue | no | false | yes | matched |
| hk_beg_004 | show | 0 | 70.32 | 0 | 0 | Blue | no | false | yes | matched |
| hk_beg_034 | show | 0 | 63.41 | 0 | 0 | Blue | no | false | yes | matched |
| hk_beg_007 | show | 0 | 65.52 | 0 | 0 | Blue | no | false | yes | matched |
| hk_beg_033 | show | 0 | 59.85 | 0 | 0 | Blue | no | false | yes | matched |
| hk_int_001 | show | 1 | 90.85 | 1 | 0 | White | no | false | yes | matched |
| hk_int_002 | show | 0 | 80.29 | 0 | 0 | Blue | no | false | yes | matched |
| hk_int_005 | show | 1 | 92.28 | 1 | 0 | White | no | false | yes | matched |
| hk_int_006 | show | 0 | 79.00 | 0 | 0 | Blue | no | false | yes | matched |
| hk_int_007 | show | 0 | 84.93 | 0 | 0 | Blue | no | false | yes | matched |
| hk_int_009 | show | 0 | 85.00 | 0 | 0 | Blue | no | false | yes | matched |
| hk_adv_001 | show | 4 | 91.60 | 4 | 0 | Yellow | no | false | yes | matched |
| hk_adv_002 | show | 2 | 83.12 | 2 | 0 | White | no | false | yes | matched |
| hk_adv_003 | show | 4 | 93.99 | 4 | 0 | Yellow | no | false | yes | matched |
| hk_adv_005 | show | 0 | 78.91 | 0 | 0 | Blue | no | false | yes | matched |
| hk_jo_beg_001 | show | 0 | 35.30 | 0 | 0 | Blue | no | false | yes | matched |
| hk_jo_int_001 | show | 0 | 36.50 | 0 | 0 | Blue | no | false | yes | matched |
| hk_jo_adv_001 | show | 1 | 35.81 | 1 | 0 | White | no | false | yes | matched |
| hk_les_001 | school | 0 | 18.54 | 0 | 0 | none | no | false | yes | matched |
| hk_les_002 | school | 0 | 16.53 | 0 | 0 | none | no | false | yes | matched |
| hk_les_003 | school | 0 | 18.21 | 0 | 0 | none | no | false | yes | matched |
| hk_les_004 | school | 0 | 17.95 | 0 | 0 | none | no | false | yes | matched |
| hk_beg_035 | school | 0 | 67.28 | 0 | 0 | none | no | false | yes | matched |
| hk_beg_039 | school | 0 | 70.73 | 0 | 0 | none | no | false | yes | matched |
| hk_beg_004 | school | 0 | 70.32 | 0 | 0 | none | no | false | yes | matched |
| hk_beg_034 | school | 0 | 63.42 | 0 | 0 | none | no | false | yes | matched |
| hk_beg_007 | school | 0 | 65.53 | 0 | 0 | none | no | false | yes | matched |
| hk_beg_033 | school | 0 | 59.87 | 0 | 0 | none | no | false | yes | matched |
| hk_int_001 | school | 0 | 90.84 | 0 | 0 | none | no | false | yes | matched |
| hk_int_002 | school | 0 | 80.30 | 0 | 0 | none | no | false | yes | matched |
| hk_int_005 | school | 0 | 92.28 | 0 | 0 | none | no | false | yes | matched |
| hk_int_006 | school | 0 | 79.01 | 0 | 0 | none | no | false | yes | matched |
| hk_int_007 | school | 0 | 84.91 | 0 | 0 | none | no | false | yes | matched |
| hk_int_009 | school | 0 | 85.00 | 0 | 0 | none | no | false | yes | matched |
| hk_adv_001 | school | 2 | 91.60 | 2 | 0 | none | no | false | yes | matched |
| hk_adv_002 | school | 0 | 83.12 | 0 | 0 | none | no | false | yes | matched |
| hk_adv_003 | school | 3 | 94.00 | 3 | 0 | none | no | false | yes | matched |
| hk_adv_005 | school | 0 | 78.92 | 0 | 0 | none | no | false | yes | matched |
| hk_jo_beg_001 | school | 0 | 35.31 | 0 | 0 | none | no | false | yes | matched |
| hk_jo_int_001 | school | 0 | 36.50 | 0 | 0 | none | no | false | yes | matched |
| hk_jo_adv_001 | school | 0 | 35.82 | 0 | 0 | none | no | false | yes | matched |

## Close

Show clears: 17 out of 23.

Schooling clears: 21 out of 23.

Printed rail time below 91: yes.

Time eliminations: none.

Files changed: `game/scripts/game_state.gd`, `game/scripts/ride_cert.gd`, `dist/_day8_ride.py`, `dist/DAY8_LOG.md`, `dist/DAY8_MEASURE.md`, and the logs under `dist/day8/`.

BLACKLIST: none.

`dist\Abbott.exe` was not launched and not rewritten. Last write 2026-09-24 11:44:00. Product stayed 2.348.0.0. Version line present: True.
