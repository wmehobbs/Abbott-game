# The trot's back fights the post

## Step 0 — the signs, on one scene

One throwaway scene (`game/tools/probe_quiet.gd`, deleted after), on the heel board's tree. It is the halt-job scene plus her eased `rider_body` pitch (peak-to-peak and mean) and the posting rise, `rider_body.position.y` (peak-to-peak and peak). It covers one second of halt and one settled stride of walk, trot and canter, pin and day-one.

```
pin-halt  hand_travel=0.001 nod_p2p=0.02 nod_mean=+11.31 elbowL=127.81/0.01 elbowR=131.87/0.01 hipx_p2p=0.09 hipx_mean=+9.58 heel_iron=0.064/0.064 heel_max=0.065/0.065 lowest_hoof=0.053 frames=145 body_pitch_p2p=0.15 body_pitch_mean=-16.07 rise_p2p=0.0003 rise_peak=0.0340
dayone-halt  hand_travel=0.001 nod_p2p=0.05 nod_mean=+14.76 elbowL=123.55/0.01 elbowR=127.17/0.01 hipx_p2p=0.12 hipx_mean=+13.03 heel_iron=0.054/0.054 heel_max=0.054/0.054 lowest_hoof=0.053 frames=145 body_pitch_p2p=0.15 body_pitch_mean=-16.07 rise_p2p=0.0003 rise_peak=0.0340
pin-walk  hand_travel=0.029 nod_p2p=2.30 nod_mean=+7.90 elbowL=129.98/2.10 elbowR=134.21/2.24 hipx_p2p=4.54 hipx_mean=+3.50 heel_iron=0.120/0.120 heel_max=0.138/0.138 lowest_hoof=0.052 frames=238 body_pitch_p2p=2.42 body_pitch_mean=-27.00 rise_p2p=0.0181 rise_peak=0.0231
dayone-walk  hand_travel=0.056 nod_p2p=5.84 nod_mean=+7.89 elbowL=130.02/6.56 elbowR=134.23/7.01 hipx_p2p=8.16 hipx_mean=+3.49 heel_iron=0.121/0.121 heel_max=0.154/0.154 lowest_hoof=0.052 frames=240 body_pitch_p2p=5.45 body_pitch_mean=-27.01 rise_p2p=0.0332 rise_peak=0.0306
pin-trot  hand_travel=0.055 nod_p2p=3.69 nod_mean=+7.05 elbowL=129.99/2.10 elbowR=134.21/2.24 hipx_p2p=10.61 hipx_mean=+15.39 heel_iron=0.088/0.088 heel_max=0.112/0.112 lowest_hoof=0.052 frames=164 body_pitch_p2p=8.46 body_pitch_mean=-33.25 rise_p2p=0.0860 rise_peak=0.1204
dayone-trot  hand_travel=0.081 nod_p2p=8.38 nod_mean=+7.08 elbowL=130.02/6.56 elbowR=134.23/7.02 hipx_p2p=14.24 hipx_mean=+15.35 heel_iron=0.091/0.091 heel_max=0.107/0.107 lowest_hoof=0.052 frames=164 body_pitch_p2p=5.57 body_pitch_mean=-33.15 rise_p2p=0.1006 rise_peak=0.1273
pin-canter  hand_travel=0.078 nod_p2p=2.85 nod_mean=+5.21 elbowL=129.98/2.10 elbowR=134.21/2.25 hipx_p2p=5.55 hipx_mean=+5.67 heel_iron=0.127/0.127 heel_max=0.159/0.159 lowest_hoof=0.053 frames=119 body_pitch_p2p=6.88 body_pitch_mean=-28.84 rise_p2p=0.0477 rise_peak=0.0215
dayone-canter  hand_travel=0.102 nod_p2p=7.48 nod_mean=+5.15 elbowL=130.11/6.56 elbowR=134.33/7.02 hipx_p2p=9.06 hipx_mean=+5.60 heel_iron=0.128/0.128 heel_max=0.170/0.170 lowest_hoof=0.053 frames=115 body_pitch_p2p=9.11 body_pitch_mean=-28.93 rise_p2p=0.0620 rise_peak=0.0286
```

| gait | horse | body-pitch p2p | helmet p2p | hip p2p | wrist travel | rise p2p / peak | heel to iron / farthest | hoof |
| --- | --- | ---: | ---: | ---: | ---: | --- | --- | ---: |
| walk | pin | 2.42 | 2.30 | 4.54 | 0.029 | 0.0181 / 0.0231 | 0.120 / 0.138 | 0.052 |
| walk | day-one | 5.45 (**+3.03**) | 5.84 | 8.16 | 0.056 | 0.0332 / 0.0306 | 0.121 / 0.154 | 0.052 |
| **trot** | pin | **8.46** | 3.69 | 10.61 | 0.055 | 0.0860 / 0.1204 | 0.088 / 0.112 | 0.052 |
| **trot** | day-one | **5.57 (−2.89)** | 8.38 | 14.24 | 0.081 | 0.1006 / 0.1273 | 0.091 / 0.107 | 0.052 |
| canter | pin | 6.88 | 2.85 | 5.55 | 0.078 | 0.0477 / 0.0215 | 0.127 / 0.159 | 0.053 |
| canter | day-one | 9.11 (+2.23) | 7.48 | 9.06 | 0.102 | 0.0620 / 0.0286 | 0.128 / 0.170 | 0.053 |

The halt means match `dist/halt_002.md` (helmet +11.31 / +14.76, elbows 127.81 / 123.55 and 131.87 / 127.17, hip 9.58 / 13.03, still).

- **The trot reprints the lean job's 8.51 / 5.56 and 8.48 / 5.58:** 8.46 / 5.57, 2.89° *less* on day-one. Her posting rise is larger on day-one (0.1006 against 0.0860 m), because the rise's unrest share adds with the post.
- **The signs, from the source.** On the positive half of sin (`post = max(0, sin)` > 0, `swing = sin` > 0), the post's pitch term `pitch += -post * 26.4` is **negative**, and the unrest pitch term `pitch += swing * 14.0 * trot_unrest` is **positive**. **They disagree**: the unrest share takes back pitch on the half where she posts. The head line (`+post * 8.4` with `+swing * 48`) and the rise (`+post * 0.228` with `+swing * 0.070`) agree and are not touched. **Phase 1 is the job.**

## Phase 1 — the minus, one attempt: **reverted**

`pitch -= swing * 14.0 * trot_unrest`: only the sign of that one line, nothing else in the trot block. The same scene right after:

```
pin-halt  hand_travel=0.001 nod_p2p=0.02 nod_mean=+11.31 elbowL=127.81/0.01 elbowR=131.87/0.02 hipx_p2p=0.09 hipx_mean=+9.58 heel_iron=0.064/0.064 heel_max=0.065/0.065 lowest_hoof=0.053 frames=145 body_pitch_p2p=0.15 body_pitch_mean=-16.07 rise_p2p=0.0003 rise_peak=0.0340
dayone-halt  hand_travel=0.001 nod_p2p=0.05 nod_mean=+14.76 elbowL=123.55/0.01 elbowR=127.17/0.01 hipx_p2p=0.11 hipx_mean=+13.03 heel_iron=0.054/0.054 heel_max=0.054/0.054 lowest_hoof=0.053 frames=138 body_pitch_p2p=0.15 body_pitch_mean=-16.07 rise_p2p=0.0003 rise_peak=0.0340
pin-walk  hand_travel=0.029 nod_p2p=2.29 nod_mean=+7.90 elbowL=129.99/2.10 elbowR=134.21/2.25 hipx_p2p=4.52 hipx_mean=+3.50 heel_iron=0.120/0.120 heel_max=0.138/0.138 lowest_hoof=0.052 frames=239 body_pitch_p2p=2.42 body_pitch_mean=-27.01 rise_p2p=0.0181 rise_peak=0.0230
dayone-walk  hand_travel=0.056 nod_p2p=5.88 nod_mean=+7.97 elbowL=130.04/6.56 elbowR=134.25/7.01 hipx_p2p=8.22 hipx_mean=+3.60 heel_iron=0.120/0.120 heel_max=0.154/0.154 lowest_hoof=0.052 frames=240 body_pitch_p2p=5.49 body_pitch_mean=-26.94 rise_p2p=0.0335 rise_peak=0.0309
pin-trot  hand_travel=0.044 nod_p2p=3.67 nod_mean=+7.11 elbowL=129.99/2.10 elbowR=134.21/2.24 hipx_p2p=10.55 hipx_mean=+15.32 heel_iron=0.089/0.089 heel_max=0.120/0.120 lowest_hoof=0.052 frames=164 body_pitch_p2p=11.21 body_pitch_mean=-33.17 rise_p2p=0.0861 rise_peak=0.1198
dayone-trot  hand_travel=0.046 nod_p2p=8.38 nod_mean=+7.07 elbowL=130.01/6.56 elbowR=134.22/7.02 hipx_p2p=14.22 hipx_mean=+15.32 heel_iron=0.093/0.093 heel_max=0.133/0.133 lowest_hoof=0.052 frames=165 body_pitch_p2p=14.20 body_pitch_mean=-33.19 rise_p2p=0.1006 rise_peak=0.1273
pin-canter  hand_travel=0.077 nod_p2p=2.85 nod_mean=+5.22 elbowL=129.99/2.10 elbowR=134.21/2.24 hipx_p2p=5.55 hipx_mean=+5.68 heel_iron=0.127/0.127 heel_max=0.158/0.158 lowest_hoof=0.053 frames=119 body_pitch_p2p=6.88 body_pitch_mean=-28.83 rise_p2p=0.0476 rise_peak=0.0215
dayone-canter  hand_travel=0.102 nod_p2p=7.48 nod_mean=+5.28 elbowL=130.00/6.55 elbowR=134.21/7.02 hipx_p2p=9.08 hipx_mean=+5.75 heel_iron=0.126/0.126 heel_max=0.169/0.169 lowest_hoof=0.053 frames=120 body_pitch_p2p=9.11 body_pitch_mean=-28.76 rise_p2p=0.0619 rise_peak=0.0289
```

| gate | step 0 (plus) | minus | rule | |
| --- | --- | --- | --- | --- |
| trot body-pitch p2p, pin / day-one | 8.46 / 5.57 (−2.89) | 11.21 / 14.20 (**+2.99**) | ≥ 3° more on day-one | **fail, by 0.01°** |
| trot wrist travel, pin / day-one | 0.055 / 0.081 | **0.044 / 0.046** | within 0.5 cm of 0.055 / 0.081 | **fail: day-one −3.5 cm, pin −1.1 cm** |
| trot helmet p2p | 3.69 / 8.38 | 3.67 / 8.38 | within 0.3° | pass |
| trot hip p2p | 10.61 / 14.24 (3.63°) | 10.55 / 14.22 (3.67°) | about 3.6° more, within 0.3° | pass |
| posting rise p2p / peak | 0.0860 / 0.1204; 0.1006 / 0.1273 | 0.0861 / 0.1198; 0.1006 / 0.1273 | she still posts, day-one not smaller | pass |
| trot heel to iron, mean / farthest | 0.088 / 0.112; 0.091 / 0.107 | 0.089 / 0.120; 0.093 / **0.133** | within 2 cm of step 0 | **day-one farthest +2.6 cm: fail** |
| hoof | 0.052 | 0.052 | 0.052–0.053 | pass |
| walk / canter body-pitch p2p | 2.42 / 5.45; 6.88 / 9.11 | 2.42 / 5.49; 6.88 / 9.11 | unchanged within 0.3° | pass (canter stays +2.23, not "fixed") |
| halt means | as `halt_002` | identical | | pass |

- **With the minus her back does swing more on day-one than the pin** (14.20 against 11.21), the right way round, but by 2.99°, not 3.
- **It takes her hands away.** Her fist target is set in the body frame. With the plus, the unrest share and the post partly cancel in her pitch but not in her hands, so day-one's trot hands travel 0.081 m. With the minus, the two pitch terms add, and the trot hands fall to 0.044 / 0.046 m: day-one loses 3.5 cm and the two horses read almost the same. Her day-one heel also swings 2.6 cm farther off the iron at its farthest.
- **The plus sign is back.** `horse.gd` is byte-identical to the heel board's. **The trot back is a written negative** at these numbers: the minus gains 5.88° of pitch difference (−2.89 → +2.99), and costs 3.5 cm of day-one hand travel and 2.6 cm of heel.
- **The fence, the clocks, the style and the board were not run.** The sign did not stay, and the trot block does not run in the air. The heel board's 21/23 stands. The clocks on the tree left are the heel job's: 18.54 / 91.60 / 93.99, 0 / 2 / 3 faults, 0 rails, teleported=false.
