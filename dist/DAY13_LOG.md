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
| M2 board | kept | 268cf13f | compile ok, selftest 29/0, playtest 0/4/4, les 25.43, beg 62.15 jo 33.45, save match |  | Better. The clock is larger on a darker card. Three fence pips mark the one he is riding. In the last 10 seconds the clock turns amber. |
| M2 band | kept | 530a7c3d | compile ok, selftest 30/0, playtest 0/4/4, les 25.43, beg 62.15 jo 33.44, save match |  | Better. The hint sits on a dark band in cream type. A controller gets its own card and its own footer line. |
| M2 result | kept | 4eb8d56a | compile ok, selftest 31/0, playtest 0/4/4, les 25.45, beg 62.14 jo 33.44, save match |  | Better. The card counts the time, then the faults, then the ribbon. A clear round drops confetti. A rail names the fence. The buttons read Retry, Next, Walk the course, and Menu. |
| M2 fade | kept | 06154b78 | compile ok, selftest 32/0, playtest 0/4/4, les 25.43, beg 62.15 jo 33.44, save match |  | Better. Entering the ring fades through black in about a third of a second, then the course name sits at the top. The horse stays in frame. |
| M3 sky | kept | ec2f2d7d | compile ok, selftest 33/0, playtest 0/4/4, save match | 2.986 | Better. AgX and thinner fog. The ride view is less blown out (luminance 0.66 to 0.49) and a little more colored. The sun was already at 34 degrees. The pink panorama is still the sky. A warm fog pass was not kept. |
| M3 trees | kept | 152c556d | compile ok, selftest 34/0, playtest 0/4/4, save match | 2.463 | Better. Kenney trees in five shapes, painted olive and bark, replace the tan discs. Light poles are four, at the ends of the ring. |
| M3 kick | kept | f7fa323e | compile ok, selftest 35/0, playtest 0/4/4, save match | 2.464 | Better. The rail base is stained oak instead of a black band. Judged `in_gate` in `d13_kick3` against `d13_trees3`. |
| M3 track | reverted |  |  |  | Same. A shader oval and a rail band did not show in the stills. Mesh strips used the sand tint and disappeared into the footing. Put back. |
| M3 stands | kept | 8cc51f67 | compile ok, selftest 36/0, playtest 0/4/4, save match | 2.481 | Better. Two stands with three people each sit past the far rail. Judged `in_gate` in `d13_stand2`. The side-on pair looked like a pile and was moved. |
| M4 legs | kept | 385a61e3 | compile ok, selftest 37/0, playtest 0/4/4, les 25.43, beg 62.14 jo 33.46, int 74.74 jo 40.87 White, save match |  | Better. Her thighs sit on the saddle and the heels hang under her hips. Judged `halt_rear` and `halt_side` in `d13_legs` against `d13_stand2`. |
| M4 bridle | kept | 6cb8750b | compile ok, selftest 38/0, playtest 0/4/4, save match |  | Better. The brow bar no longer crosses his eyes. The straps are scaled onto the head bone. Judged `halt_rear` in `d13_bridle2` against `d13_legs`. A harder pull put the hardware on the saddle and was not kept. |
| M4 coat | kept | 45b33468 | compile ok, selftest 39/0, playtest 0/4/4, save match |  | Better on the body. The side photo is off, so the barrel is solid chestnut and the socks stay white. The face close-up is still the smeared photo. Judged `halt_side` in `d13_coat2` against `d13_bridle2`. |
| M4 bridle fix | kept | 56b6b3f5 | compile ok, selftest 40/0, playtest 0/4/4, les 25.41, beg 62.13 jo 33.45, int 74.74 jo 40.85 White, save match |  | The first bridle commit crashed on a type error, so the straps never drew. They are hidden on purpose now, and the bit markers stay for the reins. No script error. Judged `head` in `d13_bridle4`. |
| M5 land | kept | 56b6b3f5 | same gates as the bridle fix |  | A sand burst and a short rumble on the landing, a harder rumble on a rail. Options has Controller rumble, default on. The landing still is framed on the fence, so the burst is small in that picture. |
| M3 banner | kept |  | compile ok, selftest 41/0, playtest 0/4/4, save match | 2.472 | Better. A navy board at the far rail reads HIDDEN K from the in-gate. The first board sat edge-on and did not show. Judged `in_gate` in `d13_banner2`. |

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
- M2 band: the footer is cream type on a dark strip. Judged `hud_mid` in `dist/day12/shots/d13_band`. The reins card and the walk line follow the keyboard or the controller.
- M2 result: the card counts for about a second, then shows the round. Confetti falls on a clear. Michelle already says the clear line. Judged `results` in `dist/day12/shots/d13_result`. A rail adds "Rail down at fence N." There is no replay still yet.
- M2 fade: a black veil rises and falls in about 0.3 s when a ride or a walk starts, and the course name shows at the top. Judged `course_card` in `dist/day12/shots/d13_fade`. `play_cam` is clear of it.
- M3 sky: AgX, fog density 0.0007, the old cool fog color. Judged `hud_mid` in `dist/day12/shots/d13_sky2` against the baseline. GPU p95 2.986 ms. The first try warmed the fog and was not kept.
- M3 trees: five Kenney shapes, painted olive and bark, plus a large bush. The shade line and the windbreak use them too. Judged `hud_mid` and `sky` in `dist/day12/shots/d13_trees3`. GPU p95 2.463 ms. The first load failed until Godot imported the glbs. The raw Kenney colors were cyan, so they are painted.
- M3 kick: a light tint on the dark plank photo did not lift the band. A solid stained oak color does. Judged `in_gate` in `dist/day12/shots/d13_kick3` against `d13_trees3`. GPU p95 2.464 ms.
- M3 track: not kept. Three tries (a darker oval, a rail band in the sand shader, then footing strips) did not read as hoof marks from the in-gate. The sand shader is back as it shipped.
- M3 stands: two three-step stands past the far rail, three people on each, no collision. Judged `in_gate` in `dist/day12/shots/d13_stand2`. GPU p95 2.481 ms. A first pair along the long sides was edge-on and was moved.
- M4 legs: the knee sat 42 cm out, so the shin stuck straight out. It is 22 cm now, and the heel is 16 cm, under the hip. The fold still follows the hip angle. Lesson 25.43, beginner 62.14 and jump-off 33.46, intermediate 74.74 and jump-off 40.87 White. Judged `halt_rear` in `dist/day12/shots/d13_legs` against `d13_stand2`.
- M4 bridle: the straps sit on a fit node under the head bone, scaled to 0.92 and pulled back 7 cm. The bar across the eyes is gone. Judged `halt_rear` in `dist/day12/shots/d13_bridle2` against `d13_legs`. The coat is still smeared.
- M4 coat: the side and front photo projectors are off. The barrel reads as chestnut and the white socks stay. Judged `halt_side` in `dist/day12/shots/d13_coat2` against `d13_bridle2`. The face close-up still carries the smeared photo, so that part is open.
- M4 bridle fix: assigning the fit node onto a BoneAttachment3D variable threw every load, and the straps were skipped. The fit node is a Node3D now, and the strap meshes are hidden. The bit markers stay. Judged `head` in `dist/day12/shots/d13_bridle4`. No script error.
- M5 land: `_land_feel` throws a one-shot sand burst and a short controller rumble. A rail buzzes harder. Options has Controller rumble, default on. Lesson 25.41, beginner 62.13 and jump-off 33.45, intermediate 74.74 and jump-off 40.85 White.
- M3 banner: a navy board past the far rail, facing the start, reads HIDDEN K. The first try was a thin board on the side rail and the start camera saw its edge. Judged `in_gate` in `dist/day12/shots/d13_banner2`. GPU p95 2.472 ms.
