# The knee, before the shin

## Step 0 — the knee, three gaits

One throwaway scene (`game/tools/probe_quiet.gd`, deleted after), on the heel board's tree. It is the flat-back scene plus both knees and shin_x:

- **Knee:** the angle at `LowerLeg` between `UpperLeg` and `Foot`, 180° = straight, both legs, peak-to-peak, max and mean.
- **shin_x:** `LShin` rotation + hip, the foot's direction in her body, peak-to-peak.
- **The rest:** one second of halt and one settled stride of walk, trot and canter, pin and day-one.

```
pin-halt  hand_travel=0.001 nod_p2p=0.02 elbowL=127.81/0.02 hipx_p2p=0.09 heel_iron=0.064/0.064 heel_max=0.065/0.065 lowest_hoof=0.053 frames=144 body_pitch_p2p=0.15 kneeL_p2p=0.15 kneeR_p2p=0.16 kneeL_max=95.78 kneeR_max=103.26 kneeL_mean=95.68 shin_p2p=0.09
dayone-halt  hand_travel=0.001 nod_p2p=0.05 elbowL=123.55/0.01 hipx_p2p=0.12 heel_iron=0.054/0.054 heel_max=0.054/0.054 lowest_hoof=0.053 frames=145 body_pitch_p2p=0.15 kneeL_p2p=0.17 kneeR_p2p=0.19 kneeL_max=93.33 kneeR_max=100.22 kneeL_mean=93.22 shin_p2p=0.09
pin-walk  hand_travel=0.029 nod_p2p=2.30 elbowL=129.98/2.10 hipx_p2p=4.53 heel_iron=0.120/0.120 heel_max=0.138/0.138 lowest_hoof=0.052 frames=239 body_pitch_p2p=2.42 kneeL_p2p=4.75 kneeR_p2p=5.49 kneeL_max=107.21 kneeR_max=116.10 kneeL_mean=104.84 shin_p2p=1.57
dayone-walk  hand_travel=0.056 nod_p2p=5.84 elbowL=130.02/6.56 hipx_p2p=8.17 heel_iron=0.121/0.121 heel_max=0.154/0.154 lowest_hoof=0.052 frames=240 body_pitch_p2p=5.45 kneeL_p2p=7.33 kneeR_p2p=8.66 kneeL_max=108.50 kneeR_max=117.68 kneeL_mean=104.85 shin_p2p=1.57
pin-trot  hand_travel=0.055 nod_p2p=3.65 elbowL=129.97/2.10 hipx_p2p=10.51 heel_iron=0.088/0.088 heel_max=0.111/0.111 lowest_hoof=0.052 frames=166 body_pitch_p2p=8.41 kneeL_p2p=9.80 kneeR_p2p=11.75 kneeL_max=97.23 kneeR_max=104.60 kneeL_mean=92.61 shin_p2p=2.39
dayone-trot  hand_travel=0.081 nod_p2p=8.40 elbowL=130.02/6.56 hipx_p2p=14.26 heel_iron=0.091/0.091 heel_max=0.107/0.107 lowest_hoof=0.052 frames=164 body_pitch_p2p=5.58 kneeL_p2p=12.50 kneeR_p2p=15.13 kneeL_max=98.45 kneeR_max=106.11 kneeL_mean=92.54 shin_p2p=2.40
pin-canter  hand_travel=0.075 nod_p2p=2.77 elbowL=130.10/2.10 hipx_p2p=5.49 heel_iron=0.125/0.125 heel_max=0.157/0.157 lowest_hoof=0.053 frames=105 body_pitch_p2p=6.67 kneeL_p2p=5.14 kneeR_p2p=6.06 kneeL_max=104.64 kneeR_max=113.24 kneeL_mean=101.93 shin_p2p=1.28
dayone-canter  hand_travel=0.102 nod_p2p=7.50 elbowL=130.02/6.56 hipx_p2p=9.10 heel_iron=0.127/0.127 heel_max=0.170/0.170 lowest_hoof=0.053 frames=119 body_pitch_p2p=9.13 kneeL_p2p=7.68 kneeR_p2p=9.19 kneeL_max=105.88 kneeR_max=114.76 kneeL_mean=102.10 shin_p2p=1.29
```

| gait | pin knee p2p L / R | day-one knee p2p L / R | day-one more by L / R | shin_x p2p, both | hip_x p2p pin / day-one (apart) | knee max L / R, pin / day-one |
| --- | --- | --- | --- | --- | --- | --- |
| walk | 4.75 / 5.49 | 7.33 / 8.66 | **2.58** / 3.17 | 1.57 / 1.57 | 4.53 / 8.17 (3.64) | 107.2 / 116.1, 108.5 / 117.7 |
| trot | 9.80 / 11.75 | 12.50 / 15.13 | **2.70** / 3.38 | 2.39 / 2.40 | 10.51 / 14.26 (3.75) | 97.2 / 104.6, 98.5 / 106.1 |
| canter | 5.14 / 6.06 | 7.68 / 9.19 | **2.54** / 3.13 | 1.28 / 1.29 | 5.49 / 9.10 (3.61) | 104.6 / 113.2, 105.9 / 114.8 |

Heel to iron, mean / farthest, pin / day-one: walk 0.120 / 0.138, 0.121 / 0.154; trot 0.088 / 0.111, 0.091 / 0.107; canter 0.125 / 0.157, 0.127 / 0.170. Wrist travel matches `same_002` (the pin canter 0.075 is a 105-frame stride). The halt knees are still (0.15–0.19° p2p).

- **shin_x p2p matches on the two horses**, as the source says: nothing multiplies it by unrest. That match is not the ruler.
- **The knee is.** Day-one's bigger hip swing opens and closes her knee more at every gait. The right knee (which sits about 8° more open on this mesh) reads 3.13–3.38° more. **The left knee reads 2.54–2.70° more, under 3°, at all three gaits.** Judging it as the elbows were, both limbs, **all three gaits are flat on the left knee**, and phase 1 runs once per gait. The left knee is also the one the heel job printed.
- **The ratio.** The left knee's difference is 0.71°, 0.72° and 0.70° per degree of hip difference at the walk, trot and canter (the right knee's 0.87–0.90). The knee closes on the thigh against the shin, and the shin lines run opposite to the hip (`shin_x −= w × 2` against `hip_x += w × 3.6`). So a shin share with the same sign as its line adds to the knee swing at the same 0.71 per degree of eased shin difference.
- **Aimed at about 3.4° on the left knee** (0.4° of margin for stride noise):
  - **walk:** shin_x −= w × K × unrest. The walk ease passes 0.394, so the eased shin gap is 2 × 0.385 × 0.394 × K = 0.303 K. It needs (3.4 − 2.58) / 0.71 = 1.16° of eased shin gap, so **K = 4**.
  - **trot:** shin_x −= (post × 9.6 + sit × 2.8) × C × unrest. The shape's own eased p2p is 2.39°, so the gap is 2.39 × 0.385 × C = 0.92 C. It needs 0.99°, so **C = 1.0**.
  - **canter:** shin_x −= (rock × 4.8 + sit × 3.8) × C × unrest. The shape reads 1.28°, so the gap is 0.49 C. It needs 1.21°, so **C = 2.5**.

## Phase 1 — one share per gait, beside its shin line (`horse.gd`)

Each share has the same shape and sign as the line it sits beside, times `_hand_unrest()`. The shin constants themselves are unchanged. They were added one gait at a time and each scene-checked before the next.

**Walk:** `shin_x -= w * 4.0 * walk_unrest`, beside `shin_x -= w * 2.0`.

```
pin-walk  hand_travel=0.029 nod_p2p=2.30 elbowL=129.99/2.10 hipx_p2p=4.53 heel_iron=0.120/0.120 heel_max=0.139/0.139 lowest_hoof=0.052 frames=239 body_pitch_p2p=2.42 kneeL_p2p=5.29 kneeR_p2p=6.04 kneeL_max=107.48 kneeR_max=116.37 kneeL_mean=104.83 shin_p2p=2.13
dayone-walk  hand_travel=0.056 nod_p2p=5.86 elbowL=130.04/6.56 hipx_p2p=8.19 heel_iron=0.119/0.119 heel_max=0.155/0.155 lowest_hoof=0.052 frames=237 body_pitch_p2p=5.46 kneeL_p2p=9.09 kneeR_p2p=10.43 kneeL_max=109.35 kneeR_max=118.53 kneeL_mean=104.74 shin_p2p=3.36
```

**Trot:** `shin_x -= (post * 9.6 + sit * 2.8) * 1.0 * trot_unrest`, beside `shin_x -= post * 9.6 + sit * 2.8`.

```
pin-trot  hand_travel=0.055 nod_p2p=3.67 elbowL=129.99/2.10 hipx_p2p=10.55 heel_iron=0.090/0.090 heel_max=0.116/0.116 lowest_hoof=0.052 frames=164 body_pitch_p2p=8.44 kneeL_p2p=10.26 kneeR_p2p=12.22 kneeL_max=96.72 kneeR_max=104.08 kneeL_mean=91.90 shin_p2p=2.83
dayone-trot  hand_travel=0.081 nod_p2p=8.37 elbowL=130.03/6.56 hipx_p2p=14.24 heel_iron=0.100/0.100 heel_max=0.123/0.123 lowest_hoof=0.052 frames=164 body_pitch_p2p=5.58 kneeL_p2p=13.79 kneeR_p2p=16.43 kneeL_max=96.93 kneeR_max=104.59 kneeL_mean=90.40 shin_p2p=3.75
```

**Canter:** `shin_x -= (rock * 4.8 + sit * 3.8) * 2.5 * unrest`, beside `shin_x -= rock * 4.8 + sit * 3.8`. The scene with all three shares in:

```
pin-halt  hand_travel=0.001 nod_p2p=0.02 elbowL=127.81/0.02 hipx_p2p=0.09 heel_iron=0.064/0.064 heel_max=0.065/0.065 lowest_hoof=0.053 frames=138 body_pitch_p2p=0.15 kneeL_p2p=0.15 kneeR_p2p=0.16 kneeL_max=95.77 kneeR_max=103.26 kneeL_mean=95.67 shin_p2p=0.09
dayone-halt  hand_travel=0.001 nod_p2p=0.05 elbowL=123.55/0.01 hipx_p2p=0.12 heel_iron=0.054/0.054 heel_max=0.054/0.054 lowest_hoof=0.053 frames=143 body_pitch_p2p=0.15 kneeL_p2p=0.17 kneeR_p2p=0.20 kneeL_max=93.33 kneeR_max=100.22 kneeL_mean=93.22 shin_p2p=0.09
pin-walk  hand_travel=0.029 nod_p2p=2.30 elbowL=129.99/2.10 hipx_p2p=4.54 heel_iron=0.120/0.120 heel_max=0.139/0.139 lowest_hoof=0.052 frames=238 body_pitch_p2p=2.42 kneeL_p2p=5.31 kneeR_p2p=6.06 kneeL_max=107.49 kneeR_max=116.38 kneeL_mean=104.80 shin_p2p=2.14
dayone-walk  hand_travel=0.056 nod_p2p=5.84 elbowL=130.03/6.56 hipx_p2p=8.17 heel_iron=0.120/0.120 heel_max=0.155/0.155 lowest_hoof=0.052 frames=240 body_pitch_p2p=5.45 kneeL_p2p=9.06 kneeR_p2p=10.40 kneeL_max=109.36 kneeR_max=118.55 kneeL_mean=104.85 shin_p2p=3.35
pin-trot  hand_travel=0.055 nod_p2p=3.66 elbowL=129.98/2.10 hipx_p2p=10.58 heel_iron=0.090/0.090 heel_max=0.116/0.116 lowest_hoof=0.052 frames=164 body_pitch_p2p=8.44 kneeL_p2p=10.30 kneeR_p2p=12.26 kneeL_max=96.77 kneeR_max=104.13 kneeL_mean=91.90 shin_p2p=2.84
dayone-trot  hand_travel=0.081 nod_p2p=8.36 elbowL=130.03/6.56 hipx_p2p=14.21 heel_iron=0.100/0.100 heel_max=0.123/0.123 lowest_hoof=0.052 frames=164 body_pitch_p2p=5.57 kneeL_p2p=13.77 kneeR_p2p=16.41 kneeL_max=96.91 kneeR_max=104.57 kneeL_mean=90.40 shin_p2p=3.75
pin-canter  hand_travel=0.078 nod_p2p=2.86 elbowL=129.99/2.10 hipx_p2p=5.55 heel_iron=0.127/0.127 heel_max=0.158/0.158 lowest_hoof=0.052 frames=119 body_pitch_p2p=6.91 kneeL_p2p=5.72 kneeR_p2p=6.65 kneeL_max=104.38 kneeR_max=112.98 kneeL_mean=101.59 shin_p2p=1.85
dayone-canter  hand_travel=0.102 nod_p2p=7.50 elbowL=130.04/6.57 hipx_p2p=9.10 heel_iron=0.125/0.125 heel_max=0.169/0.169 lowest_hoof=0.053 frames=120 body_pitch_p2p=9.13 kneeL_p2p=9.43 kneeR_p2p=10.95 kneeL_max=105.01 kneeR_max=113.87 kneeL_mean=100.35 shin_p2p=3.11
```

| gait | knee p2p pin / day-one, L (more by) | R (more by) | shin_x p2p pin / day-one | heel mean / farthest, pin; day-one (step 0) | wrist travel (same_002) | knee max | |
| --- | --- | --- | --- | --- | --- | --- | --- |
| walk | 5.31 / 9.06 (**3.75**; was 2.58) | 6.06 / 10.40 (4.34) | 2.14 / 3.35 | 0.120 / 0.139; 0.120 / 0.155 (0.120 / 0.138; 0.121 / 0.154) | 0.029 / 0.056 (0.029 / 0.056) | 118.6° | **kept** |
| trot | 10.30 / 13.77 (**3.47**; was 2.70) | 12.26 / 16.41 (4.15) | 2.84 / 3.75 | 0.090 / 0.116; 0.100 / 0.123 (0.088 / 0.111; 0.091 / 0.107) | 0.055 / 0.081 (0.055 / 0.081) | 106.1° | **kept** |
| canter | 5.72 / 9.43 (**3.71**; was 2.54) | 6.65 / 10.95 (4.30) | 1.85 / 3.11 | 0.127 / 0.158; 0.125 / 0.169 (0.125 / 0.157; 0.127 / 0.170) | 0.078 / 0.102 (0.078 / 0.103) | 113.9° | **kept** |

- **Knees:** each gait's left knee is now 3.47–3.75° more on day-one (the right 4.15–4.34°), at or near the aimed 3.4°.
- **Heels:** within 2 cm of step 0 at every gait. The largest move is day-one's trot heel, +0.9 cm mean and +1.6 cm farthest, because the trot share aims her foot on the post.
- **Held:** wrist travel within 0.1 cm of `same_002`. The knee stays bent (max 118.6°, far under 150°). Hoof 0.052–0.053. Each share left the gaits it does not run on within 0.06°, and the halt is unchanged (knee 95.7 / 93.2°, still).

Three clocks with the three shin shares in, copied from their logs:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.59 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=93.99 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.53 (0, 0), 91.59 (2, 0), 93.99 (3, 0); teleported=false, complete. The pin confidence is 91.0.

## Style, once, `--ridecert-style --ridecert-id=hk_beg_035` (probe on the refusal only, stripped after)

```
PROBE32 refuse t=0.25 conf=85.0 gait=0 neck1=+11.72 tail1=-0.31 ear=+7.77 clip=Idle FFB=0.053/0.053 helmet=+6.98 head_x=+14.03 elbowL=129.98 elbowR=134.20 hip_x=+23.11 unrest=0.180
PROBE32 refuse t=0.80 conf=85.0 gait=0 neck1=+6.60 tail1=-0.16 ear=+6.49 clip=Idle FFB=0.053/0.053 helmet=+10.55 head_x=+6.10 elbowL=128.01 elbowR=132.08 hip_x=+17.23 unrest=0.180
RIDECERT hk_beg_035 style=refuse_early success=true faults=4 jumped=8/8 t=69.88 teleported=false complete=true refused=[1] rail_fences=[] rail_air=[] conf=83.0 scope=82.5
FENCE knock 3 by horse at 9.0,-2.5 next=3 jumping=true
RIDECERT hk_beg_035 style=rail_late success=true faults=4 jumped=8/8 t=67.17 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=81.0
```

- **B:** refused fence 1, 0 rails, Idle, hinds 0.053 / 0.053, Neck1 +11.72, Tail1 −0.31, 69.88.
- **Her pose on the check:** the helmet is +10.55° at 0.80 s, heading for the pin's halt (+11.31). Her elbows are the pin halt's (128.01 / 132.08). The shin shares run only on gaits 1–3, not on the check.
- **C:** one rail, the knock on fence 3 with `jumping=true`, in the air, 67.17.

## Board — one full `--ridecert`, `board_table.py`

`RIDECERT done pass=false board=21/23 style=true`, 26 rounds in the log (copied to scratch before the playtest). The wrapper kept `dist/ridecert_board.json`, with `GODOT_EXIT 1` because the board is not 23/23.

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
| hk_int_007 | CLEAR | 0 | 10/10 | 85.0 | 90 | — |
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

Against the heel board, compared log to log: 25 id/style rows, faults and rails identical, 0 teleported, same 21/23. Worst |Δ| **0.04 s** (`hk_beg_034`, 63.46 → 63.42). hk_int_007 is 84.95 (84.93). The shin shares stay.

## Playtest — headless `--playtest`, this run, after the board log was copied

```
PLAYTEST begin fences=8
PLAYTEST clear faults=0 complete=true
PLAYTEST refuse faults=4
PLAYTEST rail faults=4
PLAYTEST done pass=true
```

## The fence still folds (pin hk_les_001, one probe, stripped after)

```
FOLD two-point fence=1 conf=85.0 unrest=0.180 last_stride=1.000 land_recover=0.000 jumping=false u=-1.000 neck1=-10.83 target pitch=-40.98 hip=+43.05 head=+16.50 eased pitch=-42.37 hip=+27.70 head=+27.48 helmet=+0.93 fistL=0.0000 fistR=0.0000 heelL=0.1201 heelR=0.1201 shin_x=-12.81 knee_angle=79.95
FOLD air-0.55 fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=0.000 jumping=true u=0.560 neck1=-21.44 target pitch=-37.24 hip=+23.80 head=+12.60 eased pitch=-40.67 hip=+26.21 head=+17.75 helmet=+5.31 fistL=0.0002 fistR=0.0002 heelL=0.1064 heelR=0.1064 shin_x=-10.07 knee_angle=83.68
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
```

- **u 0.55:** the pin's eased pitch is −40.67° (kept −40.68) and Neck1 is −21.44.
- **Two-point heel:** 0.1201 m. The kept figure is 0.1153, and the pin's two-point heel has read 0.1153–0.1209 on the fold tree across these jobs. That is inside 2 cm, and within the ride-to-ride spread.
- **The gait shin shares** sit inside the walk, trot and canter blocks, which run only with land_recover 0 and not jumping, so they do not run in the air. The fold is unchanged.
