# Her elbow opens again

One change in `rider_mesh.gd`: `SHOULDER_GIVE := [0.0, 12.0, 12.0, 12.0]` → **`[0.0, 19.0, 19.0, 19.0]`**. One number for the walk, the trot and the canter; the halt stays 0.

- Why 19: with her hips on the seat, 12 opened the elbows 2.83° (L) / 3.02° (R) more on day-one. 12 × 4.5 / 2.83 = 19.1.
- Untouched: the yaw, the side signs, the seat line `visual.position = -(visual.basis * hip)`, the fist target `Vector3(side * 0.05, 0.09, -0.22)`, the pole, and the nod and hip lines.

## The scene, after the one number

The same throwaway scene as `dist/face_002.md`, deleted after: pin at the halt for 1 s, then pin and day-one at the walk, trot and canter.

```
pin-halt gait=0 hand_travel=0.001 nod_p2p=0.00 nod_mean=+9.69 elbowL=129.98/0.01 elbowR=134.20/0.02 wristR_travel=0.001 hipx_p2p=0.07 heel_iron=0.069/0.069 heel_max=0.070/0.070 lowest_hoof=0.053 frames=145 nose_dot head+Z=+1.000 horse_x wristL=-0.042 wristR=+0.042 footL=-0.131 footR=+0.131 nose_down=16.9 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 shoulder_body L=(-0.095452, 0.402027, -0.017715) R=(0.12791, 0.402409, -0.016663) arm=0.3513 hips_body=(-0.0, 0.0, 0.0)
pin-walk gait=1 hand_travel=0.029 nod_p2p=2.30 nod_mean=+7.90 elbowL=129.98/2.10 elbowR=134.21/2.25 wristR_travel=0.029 hipx_p2p=4.53 heel_iron=0.120/0.120 heel_max=0.138/0.138 lowest_hoof=0.052 frames=239 nose_dot head+Z=+1.000 horse_x wristL=-0.041 wristR=+0.044 footL=-0.130 footR=+0.132 nose_down=26.9 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 shoulder_body L=(-0.095452, 0.40202, -0.017723) R=(0.127908, 0.402409, -0.016685) arm=0.3513 hips_body=(0.0, 0.0, 0.0)
dayone-walk gait=1 hand_travel=0.056 nod_p2p=5.85 nod_mean=+7.90 elbowL=130.02/6.56 elbowR=134.23/7.01 wristR_travel=0.056 hipx_p2p=8.17 heel_iron=0.120/0.120 heel_max=0.154/0.154 lowest_hoof=0.052 frames=239 nose_dot head+Z=+1.000 horse_x wristL=-0.041 wristR=+0.044 footL=-0.130 footR=+0.132 nose_down=26.8 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0277 shoulder_body L=(-0.095452, 0.402023, -0.017735) R=(0.127906, 0.402411, -0.016708) arm=0.3513 hips_body=(0.0, 0.0, 0.0)
pin-trot gait=2 hand_travel=0.055 nod_p2p=3.67 nod_mean=+7.10 elbowL=129.99/2.10 elbowR=134.21/2.24 wristR_travel=0.055 hipx_p2p=10.53 heel_iron=0.088/0.088 heel_max=0.111/0.111 lowest_hoof=0.052 frames=164 nose_dot head+Z=+1.000 horse_x wristL=-0.041 wristR=+0.044 footL=-0.130 footR=+0.132 nose_down=33.8 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 shoulder_body L=(-0.095452, 0.402023, -0.017919) R=(0.127906, 0.40241, -0.016889) arm=0.3513 hips_body=(0.0, 0.0, -0.0)
dayone-trot gait=2 hand_travel=0.081 nod_p2p=8.38 nod_mean=+7.09 elbowL=130.03/6.56 elbowR=134.23/7.01 wristR_travel=0.081 hipx_p2p=14.23 heel_iron=0.091/0.091 heel_max=0.107/0.107 lowest_hoof=0.052 frames=164 nose_dot head+Z=+1.000 horse_x wristL=-0.041 wristR=+0.044 footL=-0.130 footR=+0.132 nose_down=33.7 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0277 shoulder_body L=(-0.095441, 0.402023, -0.018375) R=(0.127905, 0.402409, -0.017342) arm=0.3513 hips_body=(0.0, 0.0, 0.0)
pin-canter gait=3 hand_travel=0.078 nod_p2p=2.85 nod_mean=+5.21 elbowL=129.99/2.10 elbowR=134.21/2.25 wristR_travel=0.078 hipx_p2p=5.54 heel_iron=0.127/0.127 heel_max=0.159/0.159 lowest_hoof=0.053 frames=120 nose_dot head+Z=+1.000 horse_x wristL=-0.062 wristR=+0.023 footL=-0.156 footR=+0.105 nose_down=32.0 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 shoulder_body L=(-0.09545, 0.402023, -0.017944) R=(0.127906, 0.402405, -0.016914) arm=0.3513 hips_body=(-0.0, 0.0, -0.000008)
dayone-canter gait=3 hand_travel=0.102 nod_p2p=7.50 nod_mean=+5.24 elbowL=130.02/6.56 elbowR=134.23/7.02 wristR_travel=0.102 hipx_p2p=9.10 heel_iron=0.127/0.127 heel_max=0.170/0.170 lowest_hoof=0.053 frames=119 nose_dot head+Z=+1.000 horse_x wristL=-0.062 wristR=+0.023 footL=-0.157 footR=+0.105 nose_down=31.7 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0277 shoulder_body L=(-0.095442, 0.402023, -0.018433) R=(0.127902, 0.40242, -0.017418) arm=0.3513 hips_body=(0.0, 0.0, 0.0)
```

| gait | horse | nose dot | elbow L mean / p2p | elbow R mean / p2p | fist to target L / R | shoulder to target − reach L / R | helmet p2p | hip_x p2p | wrist travel | lowest hoof |
| --- | --- | ---: | --- | --- | --- | --- | ---: | ---: | ---: | ---: |
| halt | pin | **+1.000** | 129.98° / 0.01° | 134.20° / 0.02° | 0.000 / 0.000 | −0.033 / −0.028 | 0.00° | 0.07° | 0.001 | 0.053 |
| walk | pin | +1.000 | 129.98° / **2.10°** | 134.21° / **2.25°** | 0.000 / 0.000 | −0.033 / −0.028 | 2.30° | 4.53° | 0.029 | 0.052 |
| walk | day-one | +1.000 | 130.02° / **6.56°** | 134.23° / **7.01°** | 0.000 / 0.000 | −0.033 / −0.028 | 5.85° | 8.17° | 0.056 | 0.052 |
| trot | pin | +1.000 | 129.99° / **2.10°** | 134.21° / **2.24°** | 0.000 / 0.000 | −0.033 / −0.028 | 3.67° | 10.53° | 0.055 | 0.052 |
| trot | day-one | +1.000 | 130.03° / **6.56°** | 134.23° / **7.01°** | 0.000 / 0.000 | −0.033 / −0.028 | 8.38° | 14.23° | 0.081 | 0.052 |
| canter | pin | **+1.000** | 129.99° / **2.10°** | 134.21° / **2.25°** | 0.000 / 0.000 | −0.033 / −0.028 | 2.85° | 5.54° | 0.078 | 0.053 |
| canter | day-one | +1.000 | 130.02° / **6.56°** | 134.23° / **7.02°** | 0.000 / 0.000 | −0.033 / −0.028 | 7.50° | 9.10° | 0.102 | 0.053 |

Her hips sit at body (0, 0, 0) on every row.

Against the rows:

- **Elbow p2p, more on day-one:** 4.46° (L) / 4.76° (R) at the walk, 4.46 / 4.77 at the trot, 4.46 / 4.77 at the canter. ✓ ≥ 4° on both arms at each gait. It was 2.83 / 3.02 with 12; linear in the give, 19/12 × 2.83 = 4.48.
- **Fists:** on their targets (0.000 m) ✓, and still 3.3 / 2.8 cm inside her reach ✓.
- **Nose:** +1.000 at the halt and the canter ✓.
- **Nods:** 2.30 / 5.85, 3.67 / 8.38, 2.85 / 7.50 ✓.
- **Hips:** 3.64 / 3.70 / 3.56° more on day-one ✓.
- **Wrist travel:** 0.029 / 0.056, 0.055 / 0.081, 0.078 / 0.102 ✓.
- **Hoof:** 0.052–0.053 ✓.

**Kept.**

## Clocks with the give at 19, copied from their logs

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.61 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=94.0 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.53 (0, 0), 91.61 (2, 0), 94.00 (3, 0); teleported=false, complete. Against the face board, 18.54 / 91.61 / 93.99. The give of 19 stays.

## Style, once, `--ridecert-style --ridecert-id=hk_beg_035` (probe on the refusal only, stripped after)

```
PROBE32 refuse t=0.25 conf=85.0 gait=0 neck1=+11.73 tail1=-0.31 ear=+7.94 clip=Idle FFB=0.053/0.053 helmet=+5.24 head_x=+17.90 elbowL=129.98 elbowR=134.20 hip_x=+21.66
RIDECERT hk_beg_035 style=refuse_early success=true faults=4 jumped=8/8 t=69.89 teleported=false complete=true refused=[1] rail_fences=[] rail_air=[] conf=83.0 scope=82.5
FENCE knock 3 by horse at 9.0,-2.5 next=3 jumping=true
RIDECERT hk_beg_035 style=rail_late success=true faults=4 jumped=8/8 t=67.17 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=81.0
```

- **B:** refused fence 1, 0 rails, Idle, hinds 0.053 / 0.053, Neck1 +11.73, Tail1 −0.31. Elbows at rest (129.98° / 134.20°): the give is off at gait 0.
- **C:** one rail, the knock on fence 3 with `jumping=true`, in the air, 67.17.

## Board — one full `--ridecert`, `board_table.py`

`RIDECERT done pass=false board=21/23 style=true`, 26 rounds in the log, wrapper `GODOT_EXIT 1` (the board is not 23/23).

| id | result | faults | jumped | time_s | allowed | why |
| --- | --- | --- | --- | --- | --- | --- |
| hk_les_001 | CLEAR | 0 | 3/3 | 18.5 | — | — |
| hk_les_002 | CLEAR | 0 | 3/3 | 16.5 | — | — |
| hk_les_003 | CLEAR | 0 | 3/3 | 18.2 | — | — |
| hk_les_004 | CLEAR | 0 | 3/3 | 18.0 | — | — |
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

Against the board in `dist/face_002.md`: 26 rows, worst |Δ| **0.06 s** (`hk_int_001`), all 21 clears within 0.1 s, no rail changed, 0 teleported. Same 21/23. The give of 19 stays.

## Playtest — headless `--playtest`, this run, after the board line was copied

```
PLAYTEST begin fences=8
PLAYTEST clear faults=0 complete=true
PLAYTEST refuse faults=4
PLAYTEST rail faults=4
PLAYTEST done pass=true
```
