# hk_adv_002 — one clear round, from the saddle

Headless `--ridecert-id=hk_adv_002`, 83.14 s, 0 faults, 12/12, teleported=false. Probe inserted once into a copy of `bascule.gd` and restored before any timed ride.

Columns: look = distance from `cam_look` to `jump_fence.global_position + (0, height, 0)` at u 0.55. Approach / landing = largest turn of the view per frame (deg); approach from the end of the previous landing window to take-off at the canter, landing over the first 0.8 s after touchdown. Fore at thud = FF.L / FF.R world y on the land-sound frame (contact 0.053). Pastern = largest hoof-to-cannon-tip gap at u 0.55. Rein = signed distance to the posed neck mesh (938 vertices skinned from the posed skeleton), worst of both reins, cm, positive outside.

A row passes if: look ≤ 0.40 m; landing ≤ that fence's approach; both fore hooves within 2 cm of 0.053; pastern ≤ 0.03 m; both reins ≥ 1 cm outside at u 0.55 and at 0.40 s after the land.

## Step 0 — before any change

| fence | look u0.55 (m) | approach °/f | landing °/f | fore at thud (m) | pastern u0.55 (m) | rein u0.55 (cm) | rein land+0.40 (cm) | pass |
| ---: | ---: | ---: | ---: | --- | ---: | ---: | ---: | --- |
| 1 | 0.072 | 0.52 | 6.08 | 0.057 / 0.071 | 0.000 | -20.0 | -12.8 | fail: land, rein |
| 2 | 0.066 | 2.21 | 6.19 | 0.055 / 0.067 | 0.000 | -19.9 | -13.8 | fail: land, rein |
| 3 | 0.021 | 0.28 | 1.51 | 0.055 / 0.069 | 0.000 | -19.8 | -12.1 | fail: land, rein |
| 4 | 0.066 | 4.16 | 6.13 | 0.053 / 0.062 | 0.000 | -19.5 | -12.4 | fail: land, rein |
| 5 | 0.071 | 4.53 | 6.17 | 0.053 / 0.061 | 0.000 | -20.3 | -11.7 | fail: land, rein |
| 6 | 0.066 | 3.73 | 6.28 | 0.061 / 0.082 | 0.000 | -19.9 | -12.4 | fail: land, thud, rein |
| 7 | 0.070 | 4.02 | 6.57 | 0.053 / 0.061 | 0.000 | -20.3 | -12.2 | fail: land, rein |
| 8 | 0.051 | 2.11 | 6.02 | 0.053 / 0.062 | 0.000 | -19.9 | -12.7 | fail: land, rein |
| 9 | 0.065 | 1.73 | 6.11 | 0.056 / 0.068 | 0.000 | -19.5 | -12.6 | fail: land, rein |
| 10 | 0.064 | 4.15 | 6.11 | 0.057 / 0.071 | 0.000 | -20.3 | -12.6 | fail: land, rein |
| 11 | 0.068 | 4.12 | 6.59 | 0.053 / 0.062 | 0.000 | -20.3 | -12.3 | fail: land, rein |
| 12 | 0.019 | 0.32 | 1.07 | 0.055 / 0.070 | 0.000 | -19.8 | -12.1 | fail: land, rein |

0 of 12 rows pass. Rein columns: signed distance to the posed neck mesh, worst of both reins, positive = outside.


## Phase 1 — the landing camera (kept)

`_place_cam`: the recover's sit (height −0.62, look −0.42) became a state that eases in and out and takes up the jump's own +0.22 / +0.18 when jumping switches, so the lens height is continuous through take-off, land, a related line that jumps again inside the recover, and the recover's end. Phase 3's second class fix eased the half-halt lens (0.40 in, 0.20 up, look 0.16) the same way. Look target, FOV, the approach cap and aim, CAM_MIN_Y unchanged. `hk_les_001` fence 1: landing 6.05 → 0.63°/frame against its approach 1.22. Clocks 18.54 / 91.60 / 94.00.

## Phase 2 — the rein laid on the neck (written negative)

Built every frame from the posed neck (skin skinned from the posed bones after the bends), samples pushed out along their own side until clear of the skin, short rods of the same leather, bit to glove; fists untouched. Drawn, on `hk_les_001`:

- 18 samples, 1.5 cm: worst **−5.0 cm** (fence 3, u 0.85); joints 0.1–1.7 cm out, but rods dipped between them, and with the neck bent down the nearest skin was the crest, which the per-side vertex set left out.
- 30 samples, 2 cm, all nearby vertices: worst **−6.7 cm** — searching every vertex put the far side's skin nearest to samples deep in the neck — and the per-frame vertex searches moved `hk_les_001` to 18.61 (outside the keep).
- Offline, cheap skin-profile tables (cross-section per arc length and height, holes filled, plus a local correction): worst −7.4 then **−4.2 cm**, on the right rein near the withers where the two sides of the neck meet.

Two drawn attempts failed, so the rein is a written negative: `_update_reins` is the straight rod, byte-identical to this morning. Straight-rod clearance, all twelve fences below: −19.4 … −20.5 cm at u 0.55, −11.8 … −14.2 cm at 0.40 s after the land.

## Phase 3 — first ride (phase 1 in, straight rein)

| fence | look u0.55 (m) | approach °/f | landing °/f | fore at thud (m) | pastern u0.55 (m) | rein u0.55 (cm) | rein land+0.40 (cm) | pass |
| ---: | ---: | ---: | ---: | --- | ---: | ---: | ---: | --- |
| 1 | 0.063 | 0.52 | 0.78 | 0.056 / 0.070 | 0.000 | -19.9 | -13.5 | fail: land |
| 2 | 0.062 | 2.11 | 2.83 | 0.056 / 0.069 | 0.000 | -19.9 | -13.6 | fail: land |
| 3 | 0.020 | 0.39 | 5.77 | 0.054 / 0.068 | 0.000 | -19.8 | -12.4 | fail: land |
| 4 | 0.066 | 4.16 | 0.99 | 0.053 / 0.062 | 0.000 | -19.9 | -12.1 | pass |
| 5 | 0.074 | 4.52 | 0.63 | 0.053 / 0.062 | 0.000 | -20.3 | -11.8 | pass |
| 6 | 0.063 | 3.75 | 1.19 | 0.056 / 0.069 | 0.000 | -19.9 | -12.2 | pass |
| 7 | 0.064 | 4.03 | 0.65 | 0.053 / 0.062 | 0.000 | -20.3 | -12.2 | pass |
| 8 | 0.058 | 2.11 | 1.06 | 0.056 / 0.068 | 0.000 | -20.0 | -12.4 | pass |
| 9 | 0.075 | 9.92 | 0.62 | 0.055 / 0.067 | 0.000 | -19.9 | -13.0 | pass |
| 10 | 0.074 | 4.26 | 2.56 | 0.056 / 0.068 | 0.000 | -20.4 | -12.3 | pass |
| 11 | 0.057 | 4.12 | 3.02 | 0.053 / 0.065 | 0.000 | -20.3 | -12.8 | pass |
| 12 | 0.019 | 0.40 | 5.86 | 0.054 / 0.066 | 0.000 | -19.4 | -12.5 | fail: land |

8 of 12 rows pass. Rein columns: signed distance to the posed neck mesh, worst of both reins, positive = outside.

Landing fails on 1, 2, 3, 12. Fences 3 and 12 were a new 5.8°/frame pop: a related line jumps again while the previous recover is still sinking the lens, and the recover restarting popped it back up 0.62 m. Class fix 1: the sit as a continuous state.

## Phase 3 — second ride (class fix 1)

| fence | look u0.55 (m) | approach °/f | landing °/f | fore at thud (m) | pastern u0.55 (m) | rein u0.55 (cm) | rein land+0.40 (cm) | pass |
| ---: | ---: | ---: | ---: | --- | ---: | ---: | ---: | --- |
| 1 | 0.068 | 0.52 | 0.72 | 0.055 / 0.068 | 0.000 | -20.0 | -12.9 | fail: land |
| 2 | 0.069 | 2.97 | 2.45 | 0.056 / 0.069 | 0.000 | -19.9 | -13.6 | pass |
| 3 | 0.021 | 0.28 | 2.07 | 0.053 / 0.056 | 0.000 | -19.8 | -12.7 | fail: land |
| 4 | 0.064 | 0.58 | 1.00 | 0.053 / 0.061 | 0.000 | -19.5 | -12.1 | fail: land |
| 5 | 0.072 | 2.50 | 0.63 | 0.053 / 0.062 | 0.000 | -20.3 | -12.8 | pass |
| 6 | 0.060 | 0.92 | 0.99 | 0.057 / 0.071 | 0.000 | -19.9 | -14.2 | fail: land |
| 7 | 0.058 | 1.72 | 0.71 | 0.053 / 0.061 | 0.000 | -20.3 | -12.4 | pass |
| 8 | 0.059 | 2.26 | 0.99 | 0.057 / 0.071 | 0.000 | -19.9 | -12.7 | pass |
| 9 | 0.074 | 1.41 | 2.71 | 0.056 / 0.069 | 0.000 | -19.4 | -14.1 | fail: land |
| 10 | 0.079 | 2.94 | 2.45 | 0.057 / 0.071 | 0.000 | -20.3 | -13.1 | pass |
| 11 | 0.069 | 0.30 | 2.68 | 0.053 / 0.063 | 0.000 | -20.3 | -12.0 | fail: land |
| 12 | 0.020 | 0.28 | 1.11 | 0.054 / 0.067 | 0.000 | -19.8 | -11.9 | fail: land |

5 of 12 rows pass. Rein columns: signed distance to the posed neck mesh, worst of both reins, positive = outside.

The pop is gone (worst 2.71), and the approaches got steadier too — they had carried the old instant pop at the end of each recover. The biggest remaining landing frame (fence 11, 2.68) was the half-halt lens jumping 0.43 m as he sat after the land. Class fix 2: ease that lens too.

## Phase 3 — third ride (class fix 2) — the result

| fence | look u0.55 (m) | approach °/f | landing °/f | fore at thud (m) | pastern u0.55 (m) | rein u0.55 (cm) | rein land+0.40 (cm) | pass |
| ---: | ---: | ---: | ---: | --- | ---: | ---: | ---: | --- |
| 1 | 0.065 | 0.53 | 0.79 | 0.056 / 0.069 | 0.000 | -19.9 | -12.5 | fail: land |
| 2 | 0.059 | 1.63 | 0.75 | 0.056 / 0.069 | 0.000 | -19.9 | -13.8 | pass |
| 3 | 0.019 | 0.34 | 0.30 | 0.055 / 0.069 | 0.000 | -19.5 | -12.7 | pass |
| 4 | 0.067 | 0.31 | 1.01 | 0.053 / 0.061 | 0.000 | -19.9 | -12.2 | fail: land |
| 5 | 0.075 | 4.25 | 0.63 | 0.053 / 0.063 | 0.000 | -20.3 | -11.8 | pass |
| 6 | 0.064 | 0.69 | 1.02 | 0.056 / 0.069 | 0.000 | -19.9 | -13.3 | fail: land |
| 7 | 0.065 | 0.99 | 0.72 | 0.053 / 0.061 | 0.000 | -20.5 | -12.4 | pass |
| 8 | 0.058 | 2.29 | 1.11 | 0.056 / 0.069 | 0.000 | -19.9 | -13.1 | pass |
| 9 | 0.073 | 1.46 | 0.64 | 0.056 / 0.069 | 0.000 | -19.5 | -14.1 | pass |
| 10 | 0.068 | 5.92 | 0.60 | 0.056 / 0.070 | 0.000 | -20.3 | -13.1 | pass |
| 11 | 0.055 | 0.23 | 0.52 | 0.053 / 0.067 | 0.000 | -20.3 | -13.6 | fail: land |
| 12 | 0.018 | 0.22 | 1.09 | 0.053 / 0.057 | 0.000 | -19.5 | -12.0 | fail: land |

7 of 12 rows pass. Rein columns: signed distance to the posed neck mesh, worst of both reins, positive = outside.

Landing turn is 0.30–1.11°/frame on every fence (Step 0: 6.02–6.59 on ten of twelve). Five fences still fail only because their approach is a near-straight line (0.22–0.69°/frame) and the landing has to hand the look back from the rail behind him. Two fixes of that class: **the landing-turn test is a written negative**. Every other test passes on every row: look 0.018–0.075 m, both fore hooves within 1.7 cm of 0.053, pastern 0.000, rein under the written negative. Clocks after phase 3: 18.54 / 91.60 / 94.00.

## Phase 4 — the chip and the check on this picture

`--ridecert-style --ridecert-id=hk_beg_035` plus the plain `hk_beg_035`, probed:

- A clear, 0 faults, 8/8, 67.28. Landing turn 0.64–1.01°/frame on all eight fences; camera 5.38–5.50 m from Torso3.
- B refused fence 1, 4 faults, 0 rails, 69.89. At 0.25 s: Idle, hinds FFB.L 0.053 / FFB.R 0.053, fores 0.145 / 0.144, forehand +0.140. Never Gallop_Jump while halted.
- C one rail on fence 3, `FENCE knock 3 … jumping=true`, 67.17. Chip at u 0.55 round 0.0 (clears +15.0). Landing turn 0.60–0.99°/frame.
- The rein is the straight rod (phase 2 negative), so there is no strip to test on B or C.

## Phase 5 — the board, once

| id | result | faults | jumped | time_s | allowed | why |
| --- | --- | --- | --- | --- | --- | --- |
| hk_les_001 | CLEAR | 0 | 3/3 | 18.5 | — | — |
| hk_les_002 | CLEAR | 0 | 3/3 | 16.5 | — | — |
| hk_les_003 | CLEAR | 0 | 3/3 | 18.2 | — | — |
| hk_les_004 | CLEAR | 0 | 3/3 | 17.9 | — | — |
| hk_beg_035 | CLEAR | 0 | 8/8 | 67.3 | 100 | — |
| hk_beg_039 | CLEAR | 0 | 8/8 | 70.7 | 100 | — |
| hk_beg_004 | CLEAR | 0 | 8/8 | 70.3 | 100 | — |
| hk_beg_034 | CLEAR | 0 | 8/8 | 63.4 | 100 | — |
| hk_beg_007 | CLEAR | 0 | 8/8 | 65.5 | 100 | — |
| hk_beg_033 | CLEAR | 0 | 8/8 | 59.9 | 100 | — |
| hk_int_001 | CLEAR | 0 | 10/10 | 90.8 | 90 | — |
| hk_int_002 | CLEAR | 0 | 10/10 | 80.3 | 90 | — |
| hk_int_005 | CLEAR | 0 | 10/10 | 92.3 | 90 | — |
| hk_int_006 | CLEAR | 0 | 10/10 | 79.0 | 90 | — |
| hk_int_007 | CLEAR | 0 | 10/10 | 84.9 | 90 | — |
| hk_int_009 | CLEAR | 0 | 10/10 | 85.0 | 90 | — |
| hk_adv_001 | fail | 2 | 12/12 | 91.6 | 80 | 2 time faults (allowed 80 s) |
| hk_adv_002 | CLEAR | 0 | 12/12 | 83.1 | 80 | — |
| hk_adv_003 | fail | 3 | 12/12 | 94.0 | 80 | 3 time faults (allowed 80 s) |
| hk_adv_005 | CLEAR | 0 | 12/12 | 78.9 | 80 | — |
| hk_jo_beg_001 | CLEAR | 0 | 4/4 | 35.3 | 42 | — |
| hk_jo_int_001 | CLEAR | 0 | 4/4 | 36.5 | 38 | — |
| hk_jo_adv_001 | CLEAR | 0 | 4/4 | 35.8 | 34 | — |

board 21/23  pass=False
style A_clear PASS faults=0 refused=[] rails=0 t=67.3 teleported=False
style B_refuse PASS faults=4 refused=[1] rails=0 t=69.9 teleported=False
style C_rail PASS faults=4 refused=[] rails=1 t=67.2 teleported=False
teleported rounds: 0

Against this morning's floor: worst |Δ| 0.05 s (`hk_jo_beg_001`), no new rail, teleported=false. `--playtest` PASS: clear 0 / refuse 4 / rail 4.
