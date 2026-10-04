# She shows it at the halt

The tree at the start is the give board's: SHOULDER_GIVE 19, the yaw, the side signs, the seat line and the fist target. The nod lines are 26 / 48 / 64 and the hip lines 12 / 18 / 22. Each phase below adds one constant, multiplied by `_hand_unrest()`, at gait 0 only. `_hand_unrest()` is 0.18 on the pin and 0.565 on day-one.

## Before — the halt, from one throwaway scene

The same ruler as `dist/same_002.md`, plus three extra prints:

- the helmet, elbow and hip **means** at the halt;
- her left heel and the iron, in the rider body frame;
- the walk's elbow slope against the stride sine, so the phase 2 constant can be signed.

```
pin-halt neck1=-0.09 tail1=-0.22 hand_travel=0.001 nod_p2p=0.00 nod_mean=+9.69 elbowL=129.98/0.02 elbowR=134.20/0.02 hipx_p2p=0.07 hipx_mean=+7.97 heel_iron=0.069/0.069 heel_max=0.070/0.070 lowest_hoof=0.053 frames=145 head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 hips_body=(-0.0, 0.0, 0.0) elbowL_per_unit_stride_sine=+0.000 heelL_body=(-0.154, -0.494268, -0.09828) ironL_body=(-0.17, -0.414271, -0.093196) 
dayone-halt neck1=+9.81 tail1=-10.12 hand_travel=0.001 nod_p2p=0.00 nod_mean=+9.69 elbowL=129.98/0.01 elbowR=134.20/0.01 hipx_p2p=0.07 hipx_mean=+7.97 heel_iron=0.069/0.069 heel_max=0.070/0.070 lowest_hoof=0.053 frames=145 head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 hips_body=(-0.0, 0.0, 0.0) elbowL_per_unit_stride_sine=+0.000 heelL_body=(-0.154, -0.494265, -0.098279) ironL_body=(-0.17, -0.414273, -0.093192) 
```

| halt | pin | day-one |
| --- | ---: | ---: |
| helmet pitch mean / p2p | +9.69° / 0.00° | +9.69° / 0.00° |
| elbow L / R mean | 129.98° / 134.20° | 129.98° / 134.20° |
| hip_x mean / p2p | 7.97° / 0.07° | 7.97° / 0.07° |
| heel to iron, mean / farthest | 0.069 / 0.070 | 0.069 / 0.070 |
| hand travel | 0.001 | 0.001 |
| Neck1 / Tail1 | −0.09 / −0.22 | +9.81 / −10.12 |

The halt block in `horse._update_rider` is `if gait == 0 and not jumping and land_recover <= 0.0`. It sets head_x 8, hip_x 8, shin_x −10, pitch −16.

## Phase 1 — her head at the halt (`horse.gd`, halt block only)

`head_x -= 20.0 * _hand_unrest()`, after `head_x = 8.0` in the halt block. It is a constant, with no sine.

The math: the helmet follows −0.45° per degree of head_x (walk head_x 12 → mean +7.90, halt 8 → +9.69). At steady state the ease passes a constant whole. So 0.45 × 20 × 0.385 = **3.47°** more on day-one.

After:

```
pin-halt neck1=-0.10 tail1=-0.22 hand_travel=0.001 nod_p2p=0.02 nod_mean=+11.31 elbowL=129.98/0.01 elbowR=134.20/0.02 hipx_p2p=0.07 hipx_mean=+7.97 heel_iron=0.069/0.069 heel_max=0.070/0.070 lowest_hoof=0.053 frames=143 head+Z=+1.000 fist_to_target=0.0000/0.0000
dayone-halt neck1=+9.80 tail1=-10.12 hand_travel=0.001 nod_p2p=0.05 nod_mean=+14.76 elbowL=129.98/0.01 elbowR=134.21/0.01 hipx_p2p=0.07 hipx_mean=+7.97 heel_iron=0.069/0.069 heel_max=0.070/0.070 lowest_hoof=0.053 frames=145 head+Z=+1.000 fist_to_target=0.0000/0.0000
pin-walk neck1=-4.56 tail1=+0.21 hand_travel=0.029 nod_p2p=2.29 nod_mean=+7.90 elbowL=129.96/2.10 elbowR=134.19/2.25 hipx_p2p=4.52 hipx_mean=+3.50 heel_iron=0.120/0.120 heel_max=0.138/0.138 lowest_hoof=0.052 frames=236 head+Z=+1.000 fist_to_target=0.0000/0.0000
dayone-walk neck1=+5.37 tail1=-9.69 hand_travel=0.056 nod_p2p=5.83 nod_mean=+7.91 elbowL=129.99/6.56 elbowR=134.20/7.01 hipx_p2p=8.15 hipx_mean=+3.52 heel_iron=0.120/0.120 heel_max=0.154/0.154 lowest_hoof=0.052 frames=238 head+Z=+1.000 fist_to_target=0.0000/0.0000
pin-trot neck1=-4.49 tail1=+0.21 hand_travel=0.055 nod_p2p=3.67 nod_mean=+7.10 elbowL=129.99/2.10 elbowR=134.21/2.24 hipx_p2p=10.54 hipx_mean=+15.32 heel_iron=0.088/0.088 heel_max=0.111/0.111 lowest_hoof=0.052 frames=164 head+Z=+1.000 fist_to_target=0.0000/0.0000
dayone-trot neck1=+5.41 tail1=-9.70 hand_travel=0.081 nod_p2p=8.38 nod_mean=+7.08 elbowL=130.02/6.56 elbowR=134.23/7.01 hipx_p2p=14.22 hipx_mean=+15.31 heel_iron=0.091/0.091 heel_max=0.107/0.107 lowest_hoof=0.052 frames=164 head+Z=+1.000 fist_to_target=0.0000/0.0000
pin-canter neck1=-15.23 tail1=-0.73 hand_travel=0.078 nod_p2p=2.85 nod_mean=+5.22 elbowL=129.99/2.11 elbowR=134.21/2.24 hipx_p2p=5.55 hipx_mean=+5.67 heel_iron=0.127/0.127 heel_max=0.159/0.159 lowest_hoof=0.053 frames=119 head+Z=+1.000 fist_to_target=0.0000/0.0000
dayone-canter neck1=-5.36 tail1=-10.65 hand_travel=0.103 nod_p2p=7.51 nod_mean=+5.22 elbowL=130.03/6.56 elbowR=134.23/7.02 hipx_p2p=9.09 hipx_mean=+5.67 heel_iron=0.127/0.127 heel_max=0.170/0.170 lowest_hoof=0.053 frames=120 head+Z=+1.000 fist_to_target=0.0000/0.0000
```

| halt | pin | day-one | apart |
| --- | ---: | ---: | ---: |
| helmet pitch mean | **+11.31°** (was +9.69) | **+14.76°** (was +9.69) | **3.45°** |
| helmet p2p | 0.02° | 0.05° | still |
| elbow L / R mean | 129.98° / 134.20° | 129.98° / 134.21° | same |
| hip_x mean | 7.97° | 7.97° | same |
| nose dot | +1.000 | +1.000 | |

Moving-gait check against `dist/same_002.md`:

| gait | helmet p2p | elbow L / R p2p | hip_x p2p | wrist travel | hoof |
| --- | --- | --- | --- | --- | --- |
| walk | 2.29 / 5.83 (2.33 / 5.84) | 2.10 / 6.56, 2.25 / 7.01 | 4.52 / 8.15 | 0.029 / 0.056 | 0.052 |
| trot | 3.67 / 8.38 | 2.10 / 6.56, 2.24 / 7.01 | 10.54 / 14.22 | 0.055 / 0.081 | 0.052 |
| canter | 2.85 / 7.51 | 2.11 / 6.56, 2.24 / 7.02 | 5.55 / 9.09 | 0.078 / 0.103 | 0.053 |

Every cell is within 0.04° and 0.0 cm of `same_002`. The halt term does not leak into the moving gaits. **Kept.**

Three clocks with the halt head in, copied from their logs:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.58 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=94.01 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.54 (0, 0), 91.58 (2, 0), 94.01 (3, 0); teleported=false, complete. The halt head stays.

## Phase 2 — her elbows at the halt (`rider_mesh.gd`, a constant shoulder angle at gait 0)

- **The code:** `const SHOULDER_HALT := -40.0`. While gait is 0, he is not jumping and land_recover is 0, her shoulder turns by `-40 × _hand_unrest()`, eased in over 0.25 s. It is a constant, with no sine; `SHOULDER_GIVE[0]` stays 0. It uses the same shoulder turn before the IK as the moving give, and the moving give's 19 is untouched.
- **The sign:** in the before scene the walk's elbow moves +0.305° per degree of positive give (L: 1.048 per unit sine ÷ 3.42°, 3.27 ÷ 10.74°). So the negative sign **bends** the elbow and cannot lock it toward 173°.
- **The math:** 0.305 × 40 × 0.385 ≈ 4.7° apart (L), 0.327 × 40 × 0.385 ≈ 5.0° (R).

After:

```
pin-halt neck1=-0.09 tail1=-0.22 hand_travel=0.001 nod_p2p=0.02 nod_mean=+11.31 elbowL=127.81/0.02 elbowR=131.87/0.02 hipx_p2p=0.07 hipx_mean=+7.97 heel_iron=0.069/0.069 heel_max=0.070/0.070 lowest_hoof=0.053 frames=144 head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0357/-0.0305
dayone-halt neck1=+9.80 tail1=-10.12 hand_travel=0.001 nod_p2p=0.05 nod_mean=+14.76 elbowL=123.55/0.01 elbowR=127.17/0.01 hipx_p2p=0.07 hipx_mean=+7.97 heel_iron=0.069/0.069 heel_max=0.070/0.070 lowest_hoof=0.053 frames=145 head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0417/-0.0366
pin-walk neck1=-4.51 tail1=+0.21 hand_travel=0.029 nod_p2p=2.29 nod_mean=+7.90 elbowL=129.98/2.10 elbowR=134.21/2.24 hipx_p2p=4.53 hipx_mean=+3.50 heel_iron=0.120/0.120 heel_max=0.138/0.138 lowest_hoof=0.052 frames=239 head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276
dayone-walk neck1=+5.43 tail1=-9.70 hand_travel=0.056 nod_p2p=5.84 nod_mean=+7.96 elbowL=130.02/6.56 elbowR=134.23/7.01 hipx_p2p=8.16 hipx_mean=+3.58 heel_iron=0.120/0.120 heel_max=0.154/0.154 lowest_hoof=0.052 frames=236 head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0277
pin-trot neck1=-4.49 tail1=+0.20 hand_travel=0.055 nod_p2p=3.68 nod_mean=+7.09 elbowL=129.99/2.10 elbowR=134.21/2.24 hipx_p2p=10.55 hipx_mean=+15.35 heel_iron=0.088/0.088 heel_max=0.112/0.112 lowest_hoof=0.052 frames=164 head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276
dayone-trot neck1=+5.41 tail1=-9.70 hand_travel=0.081 nod_p2p=8.36 nod_mean=+7.09 elbowL=130.03/6.56 elbowR=134.23/7.01 hipx_p2p=14.29 hipx_mean=+15.31 heel_iron=0.091/0.091 heel_max=0.107/0.107 lowest_hoof=0.052 frames=163 head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0277
pin-canter neck1=-15.21 tail1=-0.72 hand_travel=0.077 nod_p2p=2.84 nod_mean=+5.20 elbowL=129.99/2.10 elbowR=134.21/2.25 hipx_p2p=5.53 hipx_mean=+5.65 heel_iron=0.128/0.128 heel_max=0.159/0.159 lowest_hoof=0.053 frames=120 head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276
dayone-canter neck1=-5.36 tail1=-10.65 hand_travel=0.103 nod_p2p=7.50 nod_mean=+5.21 elbowL=130.02/6.57 elbowR=134.23/7.02 hipx_p2p=9.08 hipx_mean=+5.67 heel_iron=0.127/0.127 heel_max=0.170/0.170 lowest_hoof=0.053 frames=120 head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0277
```

| halt | pin | day-one | apart |
| --- | ---: | ---: | ---: |
| elbow L mean | **127.81°** (was 129.98) | **123.55°** (was 129.98) | **4.26°** |
| elbow R mean | **131.87°** (was 134.20) | **127.17°** (was 134.20) | **4.70°** |
| fist to target | 0.000 / 0.000 | 0.000 / 0.000 | |
| shoulder to target − reach | −0.036 / −0.031 | −0.042 / −0.037 | more spare (bent) |
| helmet pitch mean | +11.31° | +14.76° | 3.45° |
| hip_x mean | 7.97° | 7.97° | same |
| nose dot / hips | +1.000 / on the seat | +1.000 / on the seat | |

- **Moving gaits:** elbow p2p 2.10 / 6.56 (L) and 2.24–2.25 / 7.01–7.02 (R) at every gait, so the give of 19 still reads 4.46 / 4.77 more on day-one.
- **Helmet:** 2.29 / 5.84, 3.68 / 8.36, 2.84 / 7.50.
- **Hip:** 4.53 / 8.16, 10.55 / 14.29, 5.53 / 9.08.
- **Hands and hoof:** hand travel 0.029 / 0.056, 0.055 / 0.081, 0.077 / 0.103; hoof 0.052–0.053.

All within 0.3° and 0.5 cm of `same_002`. The halt constant does not leak into the moving gaits. **Kept.**

Three clocks with the halt head and halt elbows in, copied from their logs:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.6 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=94.0 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.53 (0, 0), 91.60 (2, 0), 94.00 (3, 0); teleported=false, complete. The halt elbows stay.

## Phase 3 — her hip at the halt (`horse.gd`, halt block only)

`hip_x += 9.0 * _hand_unrest()`, after the halt head line. It is a constant: not a sine, not the walk's 12, not the post.

**The heel before the term** (the before scene): mean 0.069 m, farthest 0.070 m, on both horses. Heel body (−0.154, −0.494, −0.098), iron body (−0.170, −0.414, −0.093).

`_set_leg` counters the hip in the shin, so the heel moves only with the thigh. Worked through `rider_mesh._spec`, the model reproduces the scene's heel to the millimetre (−0.154, −0.4942, −0.0980). For K = 9 it gives:

- hip means 3.46° apart;
- the heel 0.5 cm (pin) / 1.6 cm (day-one) closer to the iron, inside 2 cm.

For comparison, K = 10 would give 3.85° and 1.8 cm.

After:

```
pin-halt neck1=-0.09 tail1=-0.22 hand_travel=0.001 nod_p2p=0.02 nod_mean=+11.31 elbowL=127.81/0.02 elbowR=131.87/0.02 hipx_p2p=0.09 hipx_mean=+9.58 heel_iron=0.064/0.064 heel_max=0.065/0.065 lowest_hoof=0.053 frames=144 head+Z=+1.000 fist_to_target=0.0000/0.0000 heelL_body=(-0.154, -0.487789, -0.101498)
dayone-halt neck1=+9.80 tail1=-10.12 hand_travel=0.001 nod_p2p=0.05 nod_mean=+14.76 elbowL=123.55/0.01 elbowR=127.17/0.01 hipx_p2p=0.12 hipx_mean=+13.03 heel_iron=0.054/0.054 heel_max=0.054/0.054 lowest_hoof=0.053 frames=145 head+Z=+1.000 fist_to_target=0.0000/0.0000 heelL_body=(-0.154, -0.473632, -0.107757)
pin-walk neck1=-4.50 tail1=+0.21 hand_travel=0.029 nod_p2p=2.30 nod_mean=+7.90 elbowL=129.99/2.10 elbowR=134.21/2.24 hipx_p2p=4.53 hipx_mean=+3.50 heel_iron=0.120/0.120 heel_max=0.138/0.138 lowest_hoof=0.052 frames=238 head+Z=+1.000 fist_to_target=0.0000/0.0000 heelL_body=(-0.154, -0.522613, -0.119953)
dayone-walk neck1=+5.36 tail1=-9.69 hand_travel=0.056 nod_p2p=5.83 nod_mean=+7.86 elbowL=130.00/6.56 elbowR=134.21/7.01 hipx_p2p=8.14 hipx_mean=+3.44 heel_iron=0.121/0.121 heel_max=0.154/0.154 lowest_hoof=0.052 frames=237 head+Z=+1.000 fist_to_target=0.0000/0.0000 heelL_body=(-0.154, -0.522726, -0.11971)
pin-trot neck1=-4.57 tail1=+0.21 hand_travel=0.055 nod_p2p=3.67 nod_mean=+7.14 elbowL=129.95/2.10 elbowR=134.17/2.24 hipx_p2p=10.58 hipx_mean=+15.20 heel_iron=0.088/0.088 heel_max=0.111/0.111 lowest_hoof=0.052 frames=160 head+Z=+1.000 fist_to_target=0.0000/0.0000 heelL_body=(-0.154, -0.466917, -0.117361)
dayone-trot neck1=+5.41 tail1=-9.70 hand_travel=0.081 nod_p2p=8.37 nod_mean=+7.07 elbowL=130.02/6.56 elbowR=134.23/7.01 hipx_p2p=14.22 hipx_mean=+15.34 heel_iron=0.091/0.091 heel_max=0.107/0.107 lowest_hoof=0.052 frames=164 head+Z=+1.000 fist_to_target=0.0000/0.0000 heelL_body=(-0.154, -0.466119, -0.117004)
pin-canter neck1=-15.27 tail1=-0.75 hand_travel=0.078 nod_p2p=2.86 nod_mean=+5.21 elbowL=129.98/2.10 elbowR=134.21/2.24 hipx_p2p=5.56 hipx_mean=+5.66 heel_iron=0.127/0.127 heel_max=0.159/0.159 lowest_hoof=0.053 frames=120 head+Z=+1.000 fist_to_target=0.0000/0.0000 heelL_body=(-0.154, -0.511879, -0.1171)
dayone-canter neck1=-5.22 tail1=-10.57 hand_travel=0.102 nod_p2p=7.49 nod_mean=+5.30 elbowL=130.05/6.57 elbowR=134.26/7.02 hipx_p2p=9.09 hipx_mean=+5.77 heel_iron=0.126/0.126 heel_max=0.169/0.169 lowest_hoof=0.053 frames=120 head+Z=+1.000 fist_to_target=0.0000/0.0000 heelL_body=(-0.154, -0.511278, -0.11702)
```

| halt | pin | day-one | apart |
| --- | ---: | ---: | ---: |
| hip_x mean | **9.58°** (was 7.97) | **13.03°** (was 7.97) | **3.45°** |
| hip_x p2p | 0.09° | 0.12° | still |
| heel to iron, mean / farthest | 0.064 / 0.065 (was 0.069 / 0.070) | 0.054 / 0.054 (was 0.069 / 0.070) | moves 0.5 / 1.5 cm, toward the iron (up and forward with the knee) |
| elbow L / R mean | 127.81° / 131.87° | 123.55° / 127.17° | 4.26° / 4.70° |
| helmet pitch mean | +11.31° | +14.76° | 3.45° |
| nose dot | +1.000 | +1.000 | |

- **Moving gaits:** helmet 2.30 / 5.83, 3.67 / 8.37, 2.86 / 7.49.
- **Elbow p2p:** 2.10 / 6.56, 2.24 / 7.01.
- **Hip p2p:** 4.53 / 8.14, 10.58 / 14.22, 5.56 / 9.09.
- **Hands and hoof:** wrist travel 0.029 / 0.056, 0.055 / 0.081, 0.078 / 0.102; hoof 0.052–0.053.

All within 0.3° and 0.5 cm of `same_002`. **Kept.**

Three clocks with all three halt terms in, copied from their logs:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.52 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.59 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=93.98 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.52 (0, 0), 91.59 (2, 0), 93.98 (3, 0); teleported=false, complete. The halt hip stays.

## The check is a halt — style, once, `--ridecert-style --ridecert-id=hk_beg_035` (probe on the refusal only, at 0.25 s and 0.80 s, stripped after)

```
PROBE32 refuse t=0.25 conf=85.0 gait=0 neck1=+11.71 tail1=-0.32 ear=+7.69 clip=Idle FFB=0.053/0.053 helmet=+5.18 head_x=+18.04 elbowL=129.98 elbowR=134.21 hip_x=+21.71 unrest=0.180
PROBE32 refuse t=0.80 conf=85.0 gait=0 neck1=+6.60 tail1=-0.16 ear=+6.48 clip=Idle FFB=0.053/0.053 helmet=+9.30 head_x=+8.87 elbowL=127.98 elbowR=132.05 hip_x=+16.22 unrest=0.180
RIDECERT hk_beg_035 style=refuse_early success=true faults=4 jumped=8/8 t=69.84 teleported=false complete=true refused=[1] rail_fences=[] rail_air=[] conf=83.0 scope=82.5
FENCE knock 3 by horse at 9.0,-2.5 next=3 jumping=true
RIDECERT hk_beg_035 style=rail_late success=true faults=4 jumped=8/8 t=67.15 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=81.0
```

- **The check stays the check.** B refused fence 1, 0 rails, Idle, hinds 0.053 / 0.053, Neck1 +11.71, Tail1 −0.32 at 0.25 s. The give board read +11.73 / −0.31.
- **Her pose on B is the pin's halt.** Unrest on the check is 0.180. At 0.80 s:
  - **Helmet:** +9.30°, still easing from the approach (+5.18 at 0.25 s) toward the pin halt +11.31°. Day-one's halt is +14.76°, and this does not match it.
  - **Elbows:** 127.98° / 132.05°, the pin halt's 127.81 / 131.87, not day-one's 123.55 / 127.17.
  - **Hip:** hip_x still easing down from the approach (21.71 → 16.22) toward the pin halt 9.58.
- **The head term stays.**
- **C:** one rail, the knock on fence 3 with `jumping=true`, in the air, 67.15 (give board 67.17). B 69.84 (69.89).

## Board — one full `--ridecert`, `board_table.py`

The background waiter shell was stopped for low memory at round 18. The board's Godot and its wrapper kept riding, and it was waited out, not restarted. `RIDECERT done pass=false board=21/23 style=true`, 26 rounds in the log. The wrapper wrote `dist/ridecert_results.json` and kept `dist/ridecert_board.json` itself (01:03), with `GODOT_EXIT 1` because the board is not 23/23.

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
| hk_int_001 | CLEAR | 0 | 10/10 | 90.9 | 90 | — |
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

Against the board in `dist/give_002.md`: 26 rows, worst |Δ| **0.06 s** (`hk_int_001`), all 21 clears within 0.1 s, no rail changed, 0 teleported. Same 21/23. The halt terms stay.

## Playtest — headless `--playtest`, this run, after the board line was copied

```
PLAYTEST begin fences=8
PLAYTEST clear faults=0 complete=true
PLAYTEST refuse faults=4
PLAYTEST rail faults=4
PLAYTEST done pass=true
```
