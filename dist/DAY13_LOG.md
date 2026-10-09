# Day 13

Branch `day13-polish`. Version stays 2.348.0.0. Nothing pushed. ASSETS: ALLOWED.

MORNING is 07:00 local. Windows until 06:00. Save snapshot `dist/day12/save_snapshot.json` matched before the first run. SHA256 `DCAF7E223063BC97406AE83CA2C714CF15CC6D1EB60925518B1AC0249DE5B4A8`.

## Status

| item | status | commit | gates | GPU p95 | verdict |
| --- | --- | --- | --- | --- | --- |
| T0 | done |  | compile ok, selftest 22/0, playtest 0/4/4, rides below, save match | 2.952 | Baseline. Pink sky, disc trees, stick poles, empty ring. |
| M1 camera | kept | b6d39711 | compile ok, selftest 23/0, playtest 0/4/4, les 25.42, beg 62.14 jo 33.45, save match |  | Better. The lens reads the interpolated horse. Jerk p95 42354 to 3448. Pops after 0.5 s: 1 to 0. |
| M1 legs | kept |  | compile ok, selftest 24/0, playtest 0/4/4, les 25.43, beg 62.13 jo 33.45, save match |  | Better. Walk 1.00, trot 1.00, canter 1.08. The cruise strip is still one gallop cycle per stride. Legs now slow when he slows. |

## T0 rides

Re-measured on this tree. Later ride gates stay within 0.10 s of these and of the Day 12 numbers.

| id | faults | time | offer | jump-off | teleported |
| --- | --- | --- | --- | --- | --- |
| hk_les_001 | 0 | 25.43 | no |  | no |
| hk_beg_035 | 0 | 62.14 | yes | 0 faults, 33.45 | no |
| hk_int_002 | 0 | 74.74 | yes | 1 time fault, 40.85, White | no |

Day 12 comparison target was lesson 25.42, beginner 62.14 and 33.45, intermediate 74.73 and 40.87. All inside 0.02 s.

Playtest: clear 0, refuse 4, rail 4, pass true.

## T0 motion

Lesson telemetry, `dist/day13/telemetry_hk_les_001.T0_summary.csv`. 1663 frames.

- Canter speed over animation: 2.9337
- Trot: 0.9761 (55 frames)
- Walk: 0.0833 (2 frames, still leaving the halt)
- Pops: 13, of which 1 is after 0.5 s (the first step into the walk, at 0.51 s)
- Jerk p95, whole ride: 42353.88. During the round (0.5 s to 25.5 s): 37492. The tail is uneven frame gaps, not a camera cut.
- zero_blend_switches: 0

Shots: `dist/day12/shots/d13_baseline`. Contact sheet `dist/day12/shots/d13_baseline_sheet.jpg`. Canter strip is canter_00 through canter_11. GPU p95 2.952 ms after the first 2 seconds (89 samples). Median FPS was 3, so the window was not in front. GPU time is the number.

## Decisions

- The canter strip was added to the shot list before the baseline, so the before pictures include the legs.
- Walker already interpolates because the camera is a child. The step-off now reads the horse's interpolated transform too.
- Seat-probe Godots 114976 and 115652 stay. This night did not start them.
- M1 camera: `_place_cam` and the ground shade read `get_global_transform_interpolated()`. The walk step-off does too. Lesson 25.42 (T0 25.43), beginner 62.14 and jump-off 33.45. Jerk p95 fell from 42354 to 3448. No pop after the first half second.
- M1 legs: the clip rate is his ground speed, and the stride advances by distance. At the posted canter that is the same cycle as before, so the strip still shows one gallop per stride. Walk 1.00, trot 1.00, canter 1.08. Lesson 25.43, beginner 62.13 and jump-off 33.45.
