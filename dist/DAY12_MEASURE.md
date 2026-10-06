# Day 12 measure

Times are the printed ride clock. A difference from Day 11 is the T0 baseline, not a failure. Later ride gates compare to T0 within 0.10 s.

The fresh-flag wrapper writes `dist/ridecert_fresh.log`, not `dist/ridecert_godot.log`. Copies below are from that file.

## Rides

| id | source | faults | time | offer | jump-off faults | jump-off time | teleported |
| --- | --- | ---: | ---: | --- | ---: | ---: | --- |
| hk_les_001 | Day 11 | 0 | 18.53 | no |  |  | no |
| hk_les_001 | T0 | 0 | 25.42 | no |  |  | no |
| hk_beg_035 | Day 11 | 0 | 67.28 | yes | 0 |  | no |
| hk_beg_035 | T0 | 0 | 62.14 | yes | 0 | 33.45 | no |
| hk_int_002 | Day 11 | 0 | 80.30 | yes | 0 |  | no |
| hk_int_002 | T0 | 0 | 74.75 | yes | 1 | 40.88 | no |

T0 jump-off on hk_int_002 is one time fault, ribbon White, complete, not teleported. hk_beg_035 jump-off is 0 faults. Both first rounds offered.

Playtest T0: clear 0, refuse 4, rail 4, pass true. Compile check printed COMPILE ok.
