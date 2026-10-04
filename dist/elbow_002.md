# Her elbow

## Step 0 — the arm and the hip, no pose code

One throwaway scene (`game/tools/probe_quiet.gd`, deleted after), pin 85/80/44/38/36 and day-one 48/40/44/38/36, one settled stride of each gait, sampled on `skeleton_updated`. Elbow = the angle at `LowerArm` between `UpperArm` and `Wrist` (180° = straight arm), mean / peak-to-peak. Wrist travel in the withers frame. hip_x = `rider_lleg.rotation_degrees.x`. Heel to iron = her `Foot` bone to the nearest saddle `Iron` (placed where `person_look.gd` puts it, (±0.17, −0.378, 0.055) on the saddle), mean. The tree is the nod board's.

| gait | horse | elbow L mean / p2p | elbow R mean / p2p | wrist L / R travel | hip_x p2p | heel to iron L / R | helmet p2p | lowest hoof |
| --- | --- | --- | --- | --- | ---: | --- | ---: | ---: |
| walk | pin | 145.62° / 0.03° | 150.38° / 0.02° | 0.029 / 0.029 | 2.83° | 0.120 / 0.120 | 2.30° | 0.052 |
| walk | day-one | 145.62° / 0.01° | 150.38° / 0.02° | 0.056 / 0.056 | 2.83° | 0.120 / 0.120 | 5.84° | 0.052 |
| trot | pin | 145.62° / 0.00° | 150.38° / 0.01° | 0.055 / 0.055 | 8.82° | 0.087 / 0.087 | **3.67°** | 0.052 |
| trot | day-one | 145.62° / 0.01° | 150.38° / 0.01° | 0.081 / 0.081 | 8.87° | 0.088 / 0.088 | **8.39°** | 0.052 |
| canter | pin | 145.62° / 0.02° | 150.38° / 0.01° | 0.078 / 0.078 | 3.91° | 0.127 / 0.127 | 2.86° | 0.053 |
| canter | day-one | 145.62° / 0.03° | 150.38° / 0.04° | 0.103 / 0.103 | 3.91° | 0.127 / 0.127 | 7.51° | 0.053 |

```
pin-walk conf=85.0 gait=1 neck1=-4.51 tail1=+0.21 hand_travel=0.029 nod_p2p=2.30 nod_mean=-7.90 headx_p2p=5.11 elbowL=145.62/0.03 elbowR=150.38/0.02 wristR_travel=0.029 hipx_p2p=2.83 hipx_mean=+3.50 heel_iron=0.120/0.120 lowest_hoof=0.052 frames=239
dayone-walk conf=48.0 gait=1 neck1=+5.39 tail1=-9.69 hand_travel=0.056 nod_p2p=5.84 nod_mean=-7.90 headx_p2p=12.97 elbowL=145.62/0.01 elbowR=150.38/0.02 wristR_travel=0.056 hipx_p2p=2.83 hipx_mean=+3.50 heel_iron=0.120/0.120 lowest_hoof=0.052 frames=239
pin-trot conf=85.0 gait=2 neck1=-4.49 tail1=+0.20 hand_travel=0.055 nod_p2p=3.67 nod_mean=-7.10 headx_p2p=8.15 elbowL=145.62/0.00 elbowR=150.38/0.01 wristR_travel=0.055 hipx_p2p=8.82 hipx_mean=+15.31 heel_iron=0.087/0.087 lowest_hoof=0.052 frames=164
dayone-trot conf=48.0 gait=2 neck1=+5.41 tail1=-9.70 hand_travel=0.081 nod_p2p=8.39 nod_mean=-7.07 headx_p2p=18.65 elbowL=145.62/0.01 elbowR=150.38/0.01 wristR_travel=0.081 hipx_p2p=8.87 hipx_mean=+15.31 heel_iron=0.088/0.088 lowest_hoof=0.052 frames=164
pin-canter conf=85.0 gait=3 neck1=-15.25 tail1=-0.74 hand_travel=0.078 nod_p2p=2.86 nod_mean=-5.21 headx_p2p=6.36 elbowL=145.62/0.02 elbowR=150.38/0.01 wristR_travel=0.078 hipx_p2p=3.91 hipx_mean=+5.67 heel_iron=0.127/0.127 lowest_hoof=0.053 frames=120
dayone-canter conf=48.0 gait=3 neck1=-5.38 tail1=-10.66 hand_travel=0.103 nod_p2p=7.51 nod_mean=-5.21 headx_p2p=16.70 elbowL=145.62/0.03 elbowR=150.38/0.04 wristR_travel=0.103 hipx_p2p=3.91 hipx_mean=+5.65 heel_iron=0.127/0.127 lowest_hoof=0.053 frames=120
```

Reading:

- **The nod is still the nod.** Trot 3.67° / 8.39° (nod table 3.66 / 8.37); walk 2.30 / 5.84, canter 2.86 / 7.51.
- **The arm is one stiff line that shifts.** At every gait on both horses the elbow is 145.62° (L) / 150.38° (R) to the hundredth, and it moves by at most 0.04° over a stride. Her fists travel 2.6–2.7 cm more on day-one only because her body carries a fixed arm. The elbow is flat at the walk, the trot and the canter (0° apart in mean, 0° in p2p): **phase 1 is the job at all three gaits.**
- **The walk hip is flat:** hip_x p2p 2.83° / 2.83° (under 3° apart). **Phase 2 is the job.**
- The heel sits 0.087–0.127 m from the iron by gait (the `Foot` bone is her ankle); these are the 2 cm references.

Why the elbow cannot open by the two means named in the brief. `rider_mesh._ik2` is an exact two-bone solve with fixed bone lengths. The elbow angle is set only by the distance from her shoulder joint to the fist target, by the law of cosines. The pole only turns the arm's plane about the shoulder–fist line, so **moving the pole cannot change the angle**. A bend added after the IK takes the wrist off the target by forearm × angle (0.183 m × 4° ≈ 1.3 cm per side), past the 0.5 cm hand rule. What does change the angle with the fist exactly on its target is her **shoulder** giving, because it moves the joint the upper arm hangs from. The same scene printed the geometry (no pose code):

```
pin-walk geo a=0.168 b=0.183 d=0.336 sh_len=0.049 d_elbow_per_deg_x=+0.291 d_elbow_per_deg_y=-0.486 d_elbow_per_deg_z=+0.587
```

Upper arm 0.168 m, forearm 0.183 m, reach 0.336 m of 0.351, shoulder bone 0.049 m. One degree of shoulder give about her body's vertical axis (forward/back, the way a rein asks) turns the elbow **−0.49°**.

Stride math for phase 1. The give is `sin(stride_u · TAU) × K × _hand_unrest()`, applied directly (no ease), so the elbow p2p gains 2 × 0.49 × 0.385 × K on day-one over the pin = **0.37·K**°. K ≥ 10.8 for 4°: **K = 12°** of shoulder give per unit unrest (≈ 4.5°; day-one's shoulder ±6.8°, 6 mm at the joint; the pin's ±2.2°). The same stride signal and unrest drive all three gaits, so the math gives the same number at each; each gait still gets its own entry and its own attempt.

## Phase 1a — the trot elbow (`rider_mesh.gd`: her shoulder gives before the IK)

`SHOULDER_GIVE := [0.0, 0.0, 12.0, 0.0]`: on gait 2 only, each frame, before `_ik2`, her `Shoulder` bone turns about her body's vertical axis by `sin(stride_u · TAU) × 12 × _hand_unrest()` (mirrored left/right). It rotates from the pose it had on the first frame, is faded in and out over 0.25 s, and is off in the air, on the landing and on the halt. The fist target, the pole, the withers spot and the rein are untouched: the IK still puts the wrist exactly on its target, so only the elbow angle changes.

The scene right after:

| gait | horse | elbow L mean / p2p | elbow R mean / p2p | wrist L / R travel | helmet p2p | hip_x p2p | heel to iron | lowest hoof |
| --- | --- | --- | --- | --- | ---: | ---: | --- | ---: |
| walk | pin | 145.62° / 0.03° | 150.38° / 0.03° | 0.029 / 0.029 | 2.29° | 2.82° | 0.120 | 0.052 |
| walk | day-one | 145.62° / 0.01° | 150.38° / 0.02° | 0.056 / 0.056 | 5.84° | 2.83° | 0.120 | 0.052 |
| trot | pin | 145.63° / **2.11°** | 150.39° / **2.40°** | 0.055 / 0.055 | 3.67° | 8.83° | 0.087 | 0.052 |
| trot | day-one | 145.69° / **6.62°** | 150.48° / **7.55°** | 0.081 / 0.081 | 8.39° | 8.83° | 0.088 | 0.052 |
| canter | pin | 145.62° / 0.02° | 150.38° / 0.02° | 0.078 / 0.078 | 2.87° | 3.92° | 0.127 | 0.053 |
| canter | day-one | 145.62° / 0.03° | 150.38° / 0.04° | 0.102 / 0.102 | 7.49° | 3.91° | 0.127 | 0.053 |

```
pin-walk conf=85.0 gait=1 neck1=-4.53 tail1=+0.21 hand_travel=0.029 nod_p2p=2.29 nod_mean=-7.89 headx_p2p=5.09 elbowL=145.62/0.03 elbowR=150.38/0.03 wristR_travel=0.029 hipx_p2p=2.82 hipx_mean=+3.49 heel_iron=0.120/0.120 lowest_hoof=0.052 frames=237
dayone-walk conf=48.0 gait=1 neck1=+5.39 tail1=-9.69 hand_travel=0.056 nod_p2p=5.84 nod_mean=-7.90 headx_p2p=12.98 elbowL=145.62/0.01 elbowR=150.38/0.02 wristR_travel=0.056 hipx_p2p=2.83 hipx_mean=+3.50 heel_iron=0.120/0.120 lowest_hoof=0.052 frames=239
pin-trot conf=85.0 gait=2 neck1=-4.49 tail1=+0.21 hand_travel=0.055 nod_p2p=3.67 nod_mean=-7.10 headx_p2p=8.15 elbowL=145.63/2.11 elbowR=150.39/2.40 wristR_travel=0.055 hipx_p2p=8.83 hipx_mean=+15.32 heel_iron=0.087/0.087 lowest_hoof=0.052 frames=164
dayone-trot conf=48.0 gait=2 neck1=+5.41 tail1=-9.70 hand_travel=0.081 nod_p2p=8.39 nod_mean=-7.08 headx_p2p=18.65 elbowL=145.69/6.62 elbowR=150.48/7.55 wristR_travel=0.081 hipx_p2p=8.83 hipx_mean=+15.28 heel_iron=0.088/0.088 lowest_hoof=0.052 frames=164
pin-canter conf=85.0 gait=3 neck1=-15.27 tail1=-0.75 hand_travel=0.078 nod_p2p=2.87 nod_mean=-5.21 headx_p2p=6.38 elbowL=145.62/0.02 elbowR=150.38/0.02 wristR_travel=0.078 hipx_p2p=3.92 hipx_mean=+5.66 heel_iron=0.127/0.127 lowest_hoof=0.053 frames=120
dayone-canter conf=48.0 gait=3 neck1=-5.32 tail1=-10.62 hand_travel=0.102 nod_p2p=7.49 nod_mean=-5.24 headx_p2p=16.66 elbowL=145.62/0.03 elbowR=150.38/0.04 wristR_travel=0.102 hipx_p2p=3.91 hipx_mean=+5.67 heel_iron=0.127/0.127 lowest_hoof=0.053 frames=119
```

Against the rows: trot elbow p2p **4.51° (L) / 5.15° (R) more on day-one** (the math said ≈ 4.5) ✓ ≥ 4°. Trot hands 0.055 / 0.081 ✓ (0.0 cm). Helmet pitches the nod table ✓. Lowest hoof 0.052–0.053 ✓. Neck1 9.90° apart, Tail1 9.91° ✓. Walk and canter unchanged. Kept.

Three clocks with the trot elbow in, copied from their logs:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.61 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=94.01 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.53 (0, 0), 91.61 (2, 0), 94.01 (3, 0); teleported=false, complete. The trot elbow stays.

## Phase 1b — the walk elbow

`SHOULDER_GIVE := [0.0, 12.0, 12.0, 0.0]`. The walk has the same stride signal, the same `_hand_unrest()` and no ease between them, so the stride math gives the same 12 (≈ 4.5°). This is the walk's own entry and its own attempt.

| gait | horse | elbow L mean / p2p | elbow R mean / p2p | wrist L / R travel | helmet p2p | lowest hoof |
| --- | --- | --- | --- | --- | ---: | ---: |
| walk | pin | 145.63° / **2.12°** | 150.39° / **2.41°** | 0.029 / 0.029 | 2.30° | 0.052 |
| walk | day-one | 145.72° / **6.63°** | 150.52° / **7.56°** | 0.056 / 0.056 | 5.83° | 0.052 |
| trot | pin | 145.63° / 2.11° | 150.39° / 2.40° | 0.055 / 0.055 | 3.67° | 0.052 |
| trot | day-one | 145.69° / 6.62° | 150.48° / 7.55° | 0.081 / 0.081 | 8.37° | 0.052 |
| canter | pin | 145.62° / 0.02° | 150.38° / 0.02° | 0.078 / 0.078 | 2.85° | 0.053 |
| canter | day-one | 145.62° / 0.02° | 150.38° / 0.03° | 0.103 / 0.103 | 7.50° | 0.053 |

```
pin-walk conf=85.0 gait=1 neck1=-4.51 tail1=+0.21 hand_travel=0.029 nod_p2p=2.30 nod_mean=-7.90 headx_p2p=5.10 elbowL=145.63/2.12 elbowR=150.39/2.41 wristR_travel=0.029 hipx_p2p=2.83 hipx_mean=+3.50 heel_iron=0.120/0.120 lowest_hoof=0.052 frames=239
dayone-walk conf=48.0 gait=1 neck1=+5.39 tail1=-9.69 hand_travel=0.056 nod_p2p=5.83 nod_mean=-7.91 headx_p2p=12.96 elbowL=145.72/6.63 elbowR=150.52/7.56 wristR_travel=0.056 hipx_p2p=2.83 hipx_mean=+3.50 heel_iron=0.120/0.120 lowest_hoof=0.052 frames=235
pin-trot conf=85.0 gait=2 neck1=-4.49 tail1=+0.20 hand_travel=0.055 nod_p2p=3.67 nod_mean=-7.11 headx_p2p=8.16 elbowL=145.63/2.11 elbowR=150.39/2.40 wristR_travel=0.055 hipx_p2p=8.85 hipx_mean=+15.30 heel_iron=0.087/0.087 lowest_hoof=0.052 frames=164
dayone-trot conf=48.0 gait=2 neck1=+5.41 tail1=-9.70 hand_travel=0.081 nod_p2p=8.37 nod_mean=-7.10 headx_p2p=18.61 elbowL=145.69/6.62 elbowR=150.48/7.55 wristR_travel=0.081 hipx_p2p=8.80 hipx_mean=+15.30 heel_iron=0.088/0.088 lowest_hoof=0.052 frames=164
pin-canter conf=85.0 gait=3 neck1=-15.22 tail1=-0.72 hand_travel=0.078 nod_p2p=2.85 nod_mean=-5.22 headx_p2p=6.34 elbowL=145.62/0.02 elbowR=150.38/0.02 wristR_travel=0.078 hipx_p2p=3.91 hipx_mean=+5.67 heel_iron=0.127/0.127 lowest_hoof=0.053 frames=119
dayone-canter conf=48.0 gait=3 neck1=-5.14 tail1=-10.52 hand_travel=0.103 nod_p2p=7.50 nod_mean=-5.34 headx_p2p=16.68 elbowL=145.62/0.02 elbowR=150.38/0.03 wristR_travel=0.103 hipx_p2p=3.90 hipx_mean=+5.73 heel_iron=0.126/0.126 lowest_hoof=0.053 frames=116
```

Against the rows: walk elbow p2p **4.51° (L) / 5.15° (R) more on day-one** ✓. Walk hands 0.029 / 0.056 ✓. Trot elbow row unchanged ✓. Nod table ✓. Hoof ✓. Canter Neck1 10.08° / Tail1 9.80° apart (the canter code is untouched; a different settled stride of the same code) ✓. Kept.

Three clocks with the walk and trot elbows in, copied from their logs:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.62 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=94.0 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.54 (0, 0), 91.62 (2, 0), 94.00 (3, 0); teleported=false, complete. The walk elbow stays.

## Phase 1c — the canter elbow

`SHOULDER_GIVE := [0.0, 12.0, 12.0, 12.0]`. The canter rock is the same `sin(stride_u · TAU)` and uses the same `_hand_unrest()` the rock already uses, with no ease on the give, so the stride math gives 12 again. This is the canter's own entry and attempt.

| gait | horse | elbow L mean / p2p | elbow R mean / p2p | wrist L / R travel | helmet p2p | Neck1 | Tail1 | lowest hoof |
| --- | --- | --- | --- | --- | ---: | ---: | ---: | ---: |
| walk | pin | 145.60° / 2.11° | 150.36° / 2.41° | 0.029 / 0.029 | 2.29° | −4.55 | +0.21 | 0.052 |
| walk | day-one | 145.69° / 6.63° | 150.48° / 7.56° | 0.056 / 0.056 | 5.86° | +5.44 | −9.70 | 0.052 |
| trot | pin | 145.62° / 2.11° | 150.39° / 2.40° | 0.055 / 0.055 | 3.67° | −4.48 | +0.20 | 0.052 |
| trot | day-one | 145.61° / 6.63° | 150.39° / 7.55° | 0.081 / 0.081 | 8.35° | +5.36 | −9.69 | 0.052 |
| canter | pin | 145.63° / **2.12°** | 150.39° / **2.40°** | 0.078 / 0.078 | 2.85° | −15.26 | −0.74 | 0.053 |
| canter | day-one | 145.69° / **6.64°** | 150.48° / **7.56°** | 0.102 / 0.102 | 7.50° | −5.33 | −10.63 | 0.053 |

```
pin-walk conf=85.0 gait=1 neck1=-4.55 tail1=+0.21 hand_travel=0.029 nod_p2p=2.29 nod_mean=-7.85 headx_p2p=5.10 elbowL=145.60/2.11 elbowR=150.36/2.41 wristR_travel=0.029 hipx_p2p=2.83 hipx_mean=+3.44 heel_iron=0.121/0.121 lowest_hoof=0.052 frames=229
dayone-walk conf=48.0 gait=1 neck1=+5.44 tail1=-9.70 hand_travel=0.056 nod_p2p=5.86 nod_mean=-7.98 headx_p2p=13.02 elbowL=145.69/6.63 elbowR=150.48/7.56 wristR_travel=0.056 hipx_p2p=2.84 hipx_mean=+3.53 heel_iron=0.120/0.120 lowest_hoof=0.052 frames=236
pin-trot conf=85.0 gait=2 neck1=-4.48 tail1=+0.20 hand_travel=0.055 nod_p2p=3.67 nod_mean=-7.11 headx_p2p=8.15 elbowL=145.62/2.11 elbowR=150.39/2.40 wristR_travel=0.055 hipx_p2p=8.86 hipx_mean=+15.27 heel_iron=0.087/0.087 lowest_hoof=0.052 frames=165
dayone-trot conf=48.0 gait=2 neck1=+5.36 tail1=-9.69 hand_travel=0.081 nod_p2p=8.35 nod_mean=-7.11 headx_p2p=18.57 elbowL=145.61/6.63 elbowR=150.39/7.55 wristR_travel=0.081 hipx_p2p=8.81 hipx_mean=+15.24 heel_iron=0.088/0.088 lowest_hoof=0.052 frames=162
pin-canter conf=85.0 gait=3 neck1=-15.26 tail1=-0.74 hand_travel=0.078 nod_p2p=2.85 nod_mean=-5.21 headx_p2p=6.35 elbowL=145.63/2.12 elbowR=150.39/2.40 wristR_travel=0.078 hipx_p2p=3.91 hipx_mean=+5.66 heel_iron=0.128/0.128 lowest_hoof=0.053 frames=120
dayone-canter conf=48.0 gait=3 neck1=-5.33 tail1=-10.63 hand_travel=0.102 nod_p2p=7.50 nod_mean=-5.25 headx_p2p=16.68 elbowL=145.69/6.64 elbowR=150.48/7.56 wristR_travel=0.102 hipx_p2p=3.91 hipx_mean=+5.67 heel_iron=0.127/0.127 lowest_hoof=0.053 frames=119
```

Against the rows: canter elbow p2p **4.52° (L) / 5.16° (R) more on day-one** ✓. Canter hands 0.078 / 0.102 ✓ (0.1 cm of 0.103). Walk and trot elbow rows hold ✓. Nod table ✓. Hoof ✓. Neck1 9.93°, Tail1 9.89° apart ✓. Kept.

Three clocks with all three elbows in, copied from their logs:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.59 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=94.0 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.54 (0, 0), 91.59 (2, 0), 94.00 (3, 0); teleported=false, complete. The canter elbow stays.

## Phase 2 — the walk hip (`horse.gd`, gait 1 only)

`hip_x += w * 12.0 * walk_unrest`, one line after the walk nod. The trot's `post * 32`, gait 3, pitch and rest untouched. Math: the walk's `hip_x += w * 3.6` commands 7.2° and reaches 2.83° (0.393, the same walk ease the nod measured), so this adds 2 × 0.393 × 0.385 × K = 0.30·K° on day-one; K = 12 ≈ 3.6°.

| gait | horse | hip_x p2p | heel to iron mean | heel farthest (hip line out → in) | elbow L / R p2p | helmet p2p | wrist travel | lowest hoof |
| --- | --- | ---: | ---: | --- | --- | ---: | ---: | ---: |
| walk | pin | **4.54°** (was 2.83) | 0.120 (was 0.120) | 0.136 → 0.138 | 2.12° / 2.42° | 2.30° | 0.029 | 0.052 |
| walk | day-one | **8.17°** (was 2.83) | 0.120 (was 0.120) | 0.145 → 0.154 | 6.63° / 7.56° | 5.84° | 0.056 | 0.052 |

After:

```
pin-walk conf=85.0 gait=1 neck1=-4.51 tail1=+0.21 hand_travel=0.029 nod_p2p=2.30 nod_mean=-7.90 headx_p2p=5.11 elbowL=145.63/2.12 elbowR=150.40/2.42 wristR_travel=0.029 hipx_p2p=4.54 hipx_mean=+3.50 heel_iron=0.120/0.120 heel_max=0.138/0.138 lowest_hoof=0.052 frames=237
dayone-walk conf=48.0 gait=1 neck1=+5.39 tail1=-9.69 hand_travel=0.056 nod_p2p=5.84 nod_mean=-7.90 headx_p2p=12.98 elbowL=145.69/6.63 elbowR=150.48/7.56 wristR_travel=0.056 hipx_p2p=8.17 hipx_mean=+3.50 heel_iron=0.120/0.120 heel_max=0.154/0.154 lowest_hoof=0.052 frames=239
pin-trot conf=85.0 gait=2 neck1=-4.37 tail1=+0.19 hand_travel=0.056 nod_p2p=3.77 nod_mean=-6.84 headx_p2p=8.37 elbowL=145.60/2.11 elbowR=150.36/2.40 wristR_travel=0.056 hipx_p2p=8.84 hipx_mean=+16.09 heel_iron=0.089/0.089 heel_max=0.117/0.117 lowest_hoof=0.052 frames=153
dayone-trot conf=48.0 gait=2 neck1=+5.41 tail1=-9.69 hand_travel=0.081 nod_p2p=8.38 nod_mean=-7.08 headx_p2p=18.63 elbowL=145.69/6.62 elbowR=150.48/7.55 wristR_travel=0.081 hipx_p2p=8.83 hipx_mean=+15.32 heel_iron=0.088/0.088 heel_max=0.107/0.107 lowest_hoof=0.052 frames=164
pin-canter conf=85.0 gait=3 neck1=-15.23 tail1=-0.73 hand_travel=0.078 nod_p2p=2.86 nod_mean=-5.22 headx_p2p=6.36 elbowL=145.62/2.11 elbowR=150.40/2.40 wristR_travel=0.078 hipx_p2p=3.92 hipx_mean=+5.67 heel_iron=0.127/0.127 heel_max=0.156/0.156 lowest_hoof=0.053 frames=119
dayone-canter conf=48.0 gait=3 neck1=-5.37 tail1=-10.65 hand_travel=0.103 nod_p2p=7.50 nod_mean=-5.21 headx_p2p=16.68 elbowL=145.69/6.64 elbowR=150.48/7.57 wristR_travel=0.103 hipx_p2p=3.91 hipx_mean=+5.66 heel_iron=0.127/0.127 heel_max=0.161/0.161 lowest_hoof=0.053 frames=120
```

The same scene with the hip line taken out, for the heel's farthest-from-the-iron baseline (the line was then put back):

```
pin-walk hipx_p2p=2.83 heel_iron=0.120/0.120 heel_max=0.136/0.136
dayone-walk hipx_p2p=2.83 heel_iron=0.120/0.120 heel_max=0.145/0.145
pin-trot hipx_p2p=8.86 heel_iron=0.087/0.087 heel_max=0.112/0.112
dayone-trot hipx_p2p=8.86 heel_iron=0.088/0.088 heel_max=0.107/0.107
pin-canter hipx_p2p=3.90 heel_iron=0.128/0.128 heel_max=0.156/0.156
dayone-canter hipx_p2p=3.93 heel_iron=0.127/0.127 heel_max=0.161/0.161
```

Against the rows: walk hip_x p2p **3.63° more on day-one** (8.17 / 4.54) ✓ ≥ 3°. Heel mean to the iron unchanged (0.120); its farthest point moves 0.2 cm (pin) and 0.9 cm (day-one) ✓, within 2 cm. Elbow rows hold at every gait ✓. Nod pitches hold (walk 2.30 / 5.84, trot 3.77 / 8.38, canter 2.86 / 7.50). The pin trot row is a different settled stride (153 frames, not 164) of the trot code, which is untouched. Hoof 0.052–0.053 ✓. Kept.

Three clocks with the elbows and the walk hip in, copied from their logs:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.6 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=93.99 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.54 (0, 0), 91.60 (2, 0), 93.99 (3, 0); teleported=false, complete. The walk hip stays.

## The pin is still the pin — style, once, `--ridecert-style --ridecert-id=hk_beg_035` (probe on the refusal only, stripped after)

```
PROBE32 refuse t=0.25 conf=85.0 gait=0 neck1=+11.72 tail1=-0.31 ear=+7.85 clip=Idle FFB=0.053/0.053 helmet=-5.07 head_x=+18.28 elbowL=145.62 elbowR=150.38
RIDECERT hk_beg_035 style=refuse_early success=true faults=4 jumped=8/8 t=69.88 teleported=false complete=true refused=[1] rail_fences=[] rail_air=[] conf=83.0 scope=82.5
FENCE knock 3 by horse at 9.0,-2.5 next=3 jumping=true
RIDECERT hk_beg_035 style=rail_late success=true faults=4 jumped=8/8 t=67.17 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=81.0
```

B refused fence 1, 0 rails, Idle, hinds 0.053 / 0.053, Neck1 +11.72, Tail1 −0.31. On the check her elbows are 145.62° / 150.38°, the rest angles to the hundredth: the shoulder give is off at gait 0. C one rail; the knock on fence 3 with `jumping=true`, in the air.

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

Against the board in `dist/nod_002.md`: 26 rows, worst |Δ| **0.02 s** (`hk_int_009`), all 21 clears within 0.1 s, no rail changed, 0 teleported. Same 21/23. The board did not move; the lines stay.

## Playtest — headless `--playtest`, this run, after the board line was copied

```
PLAYTEST begin fences=8
PLAYTEST clear faults=0 complete=true
PLAYTEST refuse faults=4
PLAYTEST rail faults=4
PLAYTEST done pass=true
```
