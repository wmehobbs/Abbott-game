# Day 13

Branch `day13-polish`. Version stays 2.348.0.0. Nothing pushed. ASSETS: ALLOWED.

MORNING is 07:00 local. Windows until 06:00. Save snapshot `dist/day12/save_snapshot.json` matched before the first run. SHA256 `DCAF7E223063BC97406AE83CA2C714CF15CC6D1EB60925518B1AC0249DE5B4A8`.

## Status

| item | status | commit | gates | GPU p95 | verdict |
| --- | --- | --- | --- | --- | --- |
| T0 | done |  | compile ok, selftest 22/0, playtest 0/4/4, rides below, save match | 2.952 | Baseline. Pink sky, disc trees, stick poles, empty ring. |
| M1 camera | kept | b6d39711 | compile ok, selftest 23/0, playtest 0/4/4, les 25.42, beg 62.14 jo 33.45, save match |  | Better. The lens reads the interpolated horse. Jerk p95 42354 to 3448. Pops after 0.5 s: 1 to 0. |
| M1 legs | kept | 6b8ccf0f | compile ok, selftest 24/0, playtest 0/4/4, les 25.43, beg 62.13 jo 33.45, save match |  | Better. Walk 1.00, trot 1.00, canter 1.08. The cruise strip is still one gallop cycle per stride. Legs now slow when he slows. |
| M1 feel | kept | 1c6f1b43 | compile ok, selftest 24/0, playtest 0/4/4, les 25.44, beg 62.14 jo 33.45, pops after 0.5 s = 0, save match |  | Better. Canter bob, a lean up to 3 degrees, a short lens push on the leave. Camera motion slider defaults to 70. An extra landing thud popped once, so the landing stays on the dip that was already there. |
| M1 steer | kept | 93090bcf | compile ok, selftest 25/0, playtest 0/4/4, les 25.43, beg 62.15 jo 33.44, save match |  | Better for a person. Human ramp is 4.0 in and 3.0 out. Walk and trot turn a little more. The stick has a curve past the 0.25 deadzone. A gait tap in the air waits for the landing. The auto rider's ramp stays 4.0. |
| M2 grade | kept | c342bdb3 | compile ok, selftest 26/0, playtest 0/4/4, les 25.43, beg 62.15 jo 33.44, save match |  | Better. Releasing Space shows Long spot, Right on, Deep, or Chip for one second. The still shows Right on in green. The leave math was not edited. |
| M2 aid | kept | ff14f953 | compile ok, selftest 27/0, playtest 0/4/4, les 25.42, beg 62.13 jo 33.44, save match |  | Better. Three stride dots sit on the lesson approach and light as he closes. A ring marks the takeoff spot while he is collected, and it turns with the leave word. Shows stay off. The leave math was not edited. |
| M2 reins | kept | 7a8209f5 | compile ok, selftest 28/0, playtest 0/4/4, les 25.42, beg 62.14 jo 33.45, save match |  | Better. The reins card is up at the halt and fades once he steps off. Pause puts it back at the lower left, clear of the buttons. |
| M2 board | kept |  | compile ok, selftest 29/0, playtest 0/4/4, les 25.43, beg 62.15 jo 33.45, save match |  | Better. The clock is larger on a darker card. Three fence pips mark the one he is riding. In the last 10 seconds the clock turns amber. |

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
- M1 feel: Options has Camera motion, 0 to 100, default 70. At 70 the canter bobs 4 cm, the horizon leans up to 3 degrees, and the leave pushes the lens in for a sixth of a second. The landing dip stays the one that was already shipping. Lesson 25.44, beginner 62.14 and jump-off 33.45. No pop after the first half second.
- M2 aid: Options has Riding aid, default on. Dots and the ring draw only in a lesson. The stills `three_strides` and `last_stride` in `dist/day12/shots/d13_aid` show the dots on the line and the ring at the takeoff spot. GPU was not retimed. Three unshaded meshes sit well under the 2.952 ms baseline.
- M2 reins: the card fades after the first step, or after 6 seconds if he stands. A new round shows it again. Pause draws it at the lower left. Judged `reins_hold` against `hud_mid` in `dist/day12/shots/d13_reins2`. The horse is clear once he is moving.
- M2 board: time is 56 px on a darker card, with a pip for each fence. The current one is gold. `clock_amber` in `dist/day12/shots/d13_board` shows 176 / 180 in amber. That still sets the clock for one frame and puts it back.
