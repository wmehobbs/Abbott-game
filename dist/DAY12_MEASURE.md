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

## Performance

Baseline ride, VSync off, 10 seconds, `dist/day12/shots/baseline/perf.csv`. 127 samples. After the first 2 seconds (87 samples): FPS median 9, GPU median 2.831 ms, GPU p95 3.007 ms. The performance rule uses GPU time. A later pass must not push GPU p95 more than 15 percent above 3.007 ms.

## T5 lighting

Looked at the stills after the sky rotation. Three groups, then reverted. The picture stayed the T4 sky turn.

- Group A: warm fog turned the ring orange (worse). Less fog on the sky was the same picture. A lower sun and less ambient shortened the shadow toward noon (worse).
- Group B: less exposure and less glow only made the same picture darker. ACES washed the sky brighter (worse). SSIL cost GPU p95 3.303 ms and the belly shadow stayed a black blob (same).
- Group C: tighter shadow bias moved the horse shadow by a few pixels and left it black (same). MSAA is already 4x, with FXAA and debanding. The rail still does not stair-step.

## T6 telemetry baseline

`--telemetry` on the ride cert. Clock unchanged: hk_les_001 0 faults 25.42 offer no. hk_beg_035 0 faults 62.15 offer yes, jump-off 0 faults 33.43. Playtest still clear 0, refuse 4, rail 4.

Lesson, 2382 frames. Beginner plus jump-off, 8450 frames. Files: `dist/day12/telemetry_hk_les_001.csv` and `telemetry_hk_beg_035.csv` (not committed).

After the first half second the camera does not pop. Lesson max step 0.18 m. Horizon roll is 0 on every frame. Gait changes already blend (0 zero-blend switches). Canter ground speed divided by animation rate is 2.94 on the lesson and 3.33 on the beginner round, next to the 3.35 m stride. The approach shot shows the ears and the next fence. The apex shot shows the whole horse. No camera or animation edit.

## T10 options, pause, results

Headless. No window. Selftest pass=19 fail=0. Playtest clear 0, refuse 4, rail 4.

hk_les_001 0 faults 25.43, offer no, teleported false. T0 was 25.42.
hk_beg_035 0 faults 62.14, offer yes, jump-off 0 faults 33.44, teleported false. T0 was 62.14 and 33.45.

Defaults match the ride that was already shipping. A saved field of view slides the whole lens together. Low quality is in the options and was not timed on the GPU.

## T13 season, T14 first lesson, T15 native size

Headless. No window. Selftest pass=22 fail=0. Playtest clear 0, refuse 4, rail 4. Save hash matched.

hk_les_001 0 faults 25.42, offer no, teleported false. T0 was 25.42.
hk_beg_035 0 faults 62.13, offer yes, jump-off 0 faults 33.45, teleported false. T0 was 62.14 and 33.45.

The first lesson does not run under --playtest, --ridecert, or --selftest. The stretch change is the display size only. Low quality is still not timed on the GPU.

## Screens and Low quality

Windowed, dummy audio, 1920x1080, VSync off for the ride samples. Save matched. Godot exited.

High, `dist/day12/shots/screens_b/perf.csv`: 128 samples, GPU p95 2.92 ms, median 2.82. The old baseline p95 was 3.007. Median FPS was 6.

Low, `dist/day12/shots/low/perf.csv`: 131 samples, GPU p95 1.995 ms, median 1.80. MSAA off, SSAO off, glow off, shadow distance 70. The ride camera still shows the horse, the rail, and the next fence. Default quality stays High.
