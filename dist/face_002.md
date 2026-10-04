# She faces his ears

The tree under test is Ernie's. `person_look._mount_mesh` sets `vis.rotation_degrees.y = 180.0` on the mounted Casual. `rider_mesh.gd` loops `[["L", -1.0], ["R", 1.0]]`. `horse.gd` and `bascule.gd` are the hip keep, byte-identical.

## Which way her nose points

One throwaway scene (`game/tools/probe_quiet.gd`, deleted after): pin and day-one, one settled stride of walk, trot and canter, plus the pin at the halt for one second.

**Which axis of Head is her face.** From the mesh itself: each surface's vertices within 16 cm of the Head bone, averaged, in Head's own rest axes (x, y, z):

```
FACE head_rest_origin=(-0.013742, 1.547726, 0.087765) neck_to_head_local=(0.000019, 0.076636, 0.00376)
FACE model+Z in head local=(0.004621, 0.071662, 0.997418)
FACE mesh=Cube037 surf=0 mat=Skin verts=4362 near_head=142 centroid_in_head_local=(0.014, -0.025, -0.03)
FACE mesh=Cube037_1 surf=0 mat=White verts=976 near_head=299 centroid_in_head_local=(0.001, -0.063, -0.013)
FACE mesh=Cube070 surf=0 mat=Skin verts=222
FACE mesh=Cube070_1 surf=0 mat=Grey verts=860
FACE mesh=Cube001 surf=0 mat=Skin verts=674 near_head=554 centroid_in_head_local=(0.013, 0.057, -0.011)
FACE mesh=Cube001_1 surf=0 mat=Hair_Brown verts=80
FACE mesh=Cube001_2 surf=0 mat=Brown verts=48 near_head=21 centroid_in_head_local=(0.005, 0.137, 0.046)
FACE mesh=Cube001_3 surf=0 mat=Hair_Blond verts=4320 near_head=1118 centroid_in_head_local=(0.013, 0.045, -0.058)
FACE mesh=Casual_Legs surf=0 mat=Orange verts=1426
FACE mesh=@MeshInstance3D@37 surf=0 mat=? verts=522
FACE mesh=@MeshInstance3D@38 surf=0 mat=? verts=24
FACE mesh=@MeshInstance3D@43 surf=0 mat=? verts=24
FACE mesh=@MeshInstance3D@44 surf=0 mat=? verts=24
FACE mesh=@MeshInstance3D@45 surf=0 mat=? verts=522
```

- Neck → Head is local **+Y** (0.000, 0.077, 0.004), so +Y is the neck/crown axis.
- The glb's model forward (+Z) is Head local (0.005, 0.072, 0.997), i.e. **+Z**.
- The small `Brown` surface at the head (48 verts: brows/eyes) sits at z = **+0.046**, high on the head (y +0.137).
- The hair (`Hair_Blond`) centroid sits at z = **−0.058**, behind.

So **her face is Head local +Z**. That axis is neither the neck nor the crown, and the mesh agrees with it.

**The dot** of Head +Z (in the world, flattened on Y) with his forward, −basis.z flattened:

| row | nose dot (Head +Z · his forward) | nose below level | wrist L / R, his frame x | foot L / R, his frame x |
| --- | ---: | ---: | --- | --- |
| halt, pin, 1 s | **+1.000** | 16.9° | −0.046 / +0.051 | −0.131 / +0.131 |
| walk, pin | +1.000 | 26.9° | −0.045 / +0.053 | −0.130 / +0.132 |
| trot, pin | +1.000 | 33.7° | −0.045 / +0.053 | −0.130 / +0.132 |
| canter, pin | **+1.000** | 31.9° | −0.066 / +0.032 | −0.157 / +0.105 |
| canter, day-one | +1.000 | 31.8° | −0.066 / +0.032 | −0.157 / +0.105 |

**She looks the way he is going**, positive at the halt and at the canter. Her left wrist and left foot are on his left (−X, his left when he faces −Z), and her right ones on his right. The yaw is on the right node, and the side signs match it. No correction applies.

## The kept picture on this tree

| gait | horse | helmet p2p | elbow L mean / p2p | elbow R mean / p2p | hip_x p2p | wrist travel | lowest hoof |
| --- | --- | ---: | --- | --- | ---: | ---: | ---: |
| walk | pin | 2.30° | 172.89° / 0.03° | 173.00° / 0.03° | 4.53° | 0.030 | 0.052 |
| walk | day-one | 5.85° | 172.89° / 0.10° | 172.99° / 0.10° | 8.17° | 0.059 | 0.052 |
| trot | pin | 3.67° | 172.89° / 0.03° | 173.00° / 0.03° | 10.54° | 0.058 | 0.052 |
| trot | day-one | 8.38° | 172.89° / 0.10° | 172.99° / 0.10° | 14.29° | 0.085 | 0.052 |
| canter | pin | 2.87° | 172.89° / 0.03° | 173.00° / 0.03° | 5.57° | 0.079 | 0.053 |
| canter | day-one | 7.50° | 172.89° / 0.10° | 172.99° / 0.10° | 9.08° | 0.105 | 0.053 |

```
pin-halt gait=0 hand_travel=0.001 nod_p2p=0.00 nod_mean=+9.69 elbowL=172.89/0.00 elbowR=173.00/0.00 wristR_travel=0.001 hipx_p2p=0.07 lowest_hoof=0.053 frames=145 nose_dot head+X=+0.004 head+Y=+1.000 head+Z=+1.000 horse_x wristL=-0.046 wristR=+0.051 footL=-0.131 footR=+0.131 nose_down=16.9 fist_to_target=0.0298/0.0373 shoulder_to_target_minus_reach=+0.0291/+0.0366
pin-walk gait=1 hand_travel=0.030 nod_p2p=2.30 nod_mean=+7.90 elbowL=172.89/0.03 elbowR=173.00/0.03 wristR_travel=0.030 hipx_p2p=4.53 lowest_hoof=0.052 frames=239 nose_dot head+X=+0.005 head+Y=+1.000 head+Z=+1.000 horse_x wristL=-0.045 wristR=+0.053 footL=-0.130 footR=+0.132 nose_down=26.9 fist_to_target=0.0298/0.0373 shoulder_to_target_minus_reach=+0.0291/+0.0366
dayone-walk gait=1 hand_travel=0.059 nod_p2p=5.85 nod_mean=+7.91 elbowL=172.89/0.10 elbowR=172.99/0.10 wristR_travel=0.059 hipx_p2p=8.17 lowest_hoof=0.052 frames=239 nose_dot head+X=+0.005 head+Y=+1.000 head+Z=+1.000 horse_x wristL=-0.044 wristR=+0.053 footL=-0.130 footR=+0.132 nose_down=26.8 fist_to_target=0.0298/0.0373 shoulder_to_target_minus_reach=+0.0291/+0.0366
pin-trot gait=2 hand_travel=0.058 nod_p2p=3.67 nod_mean=+7.10 elbowL=172.89/0.03 elbowR=173.00/0.03 wristR_travel=0.059 hipx_p2p=10.54 lowest_hoof=0.052 frames=164 nose_dot head+X=+0.005 head+Y=+1.000 head+Z=+1.000 horse_x wristL=-0.045 wristR=+0.053 footL=-0.130 footR=+0.132 nose_down=33.8 fist_to_target=0.0298/0.0373 shoulder_to_target_minus_reach=+0.0291/+0.0366
dayone-trot gait=2 hand_travel=0.085 nod_p2p=8.38 nod_mean=+7.08 elbowL=172.89/0.10 elbowR=172.99/0.10 wristR_travel=0.086 hipx_p2p=14.29 lowest_hoof=0.052 frames=164 nose_dot head+X=+0.005 head+Y=+1.000 head+Z=+1.000 horse_x wristL=-0.045 wristR=+0.053 footL=-0.130 footR=+0.132 nose_down=33.7 fist_to_target=0.0298/0.0373 shoulder_to_target_minus_reach=+0.0291/+0.0366
pin-canter gait=3 hand_travel=0.079 nod_p2p=2.87 nod_mean=+5.22 elbowL=172.89/0.03 elbowR=173.00/0.03 wristR_travel=0.078 hipx_p2p=5.57 lowest_hoof=0.053 frames=120 nose_dot head+X=+0.024 head+Y=+1.000 head+Z=+1.000 horse_x wristL=-0.066 wristR=+0.032 footL=-0.157 footR=+0.105 nose_down=32.0 fist_to_target=0.0298/0.0373 shoulder_to_target_minus_reach=+0.0291/+0.0366
dayone-canter gait=3 hand_travel=0.105 nod_p2p=7.50 nod_mean=+5.21 elbowL=172.89/0.10 elbowR=172.99/0.10 wristR_travel=0.105 hipx_p2p=9.08 lowest_hoof=0.053 frames=120 nose_dot head+X=+0.024 head+Y=+1.000 head+Z=+1.000 horse_x wristL=-0.066 wristR=+0.032 footL=-0.157 footR=+0.105 nose_down=31.8 fist_to_target=0.0298/0.0373 shoulder_to_target_minus_reach=+0.0291/+0.0366
```

- **Held:** nods 2.30 / 5.85, 3.67 / 8.38, 2.87 / 7.50. Hips 3.64°, 3.75° and 3.51° more on day-one. Lowest hoof 0.052–0.053.
- **Does not hold: the elbows.** They were 145.62° / 150.38° with p2p 2.1 / 6.6° (L) and 2.4 / 7.6° (R). Under the yaw they are **172.89° / 173.00°, nearly straight, and move 0.03° on the pin and 0.10° on day-one**, so 0.07° apart instead of 4.5° / 5.2°.
- **Why.** Each hand target (body (±0.05, 0.09, −0.22), unchanged) is now **2.9 cm (L) / 3.7 cm (R) farther from her shoulder than her arm is long**. `_ik2` clamps the reach at a + b − 0.001, and the elbow sits at that clamp angle. Her fists stop **3.0 cm / 3.7 cm short** of their targets (`fist_to_target` above), at every gait on both horses. The shoulder give still turns her shoulder, but a clamped arm cannot bend, so the elbow cannot open.
- **Cause.** Turning her 180° about the body's Y moves her shoulders to the other side of her hips along the body's Z, away from targets that were placed for the old facing. Before the yaw, the same scene had the shoulder 0.336 m from the target with 0.351 m of arm.
- **Hands.** Wrist travel is 0.030 / 0.059 walk, 0.058 / 0.085 trot and 0.079 / 0.105 canter, against 0.029 / 0.056, 0.055 / 0.081 and 0.078 / 0.103. That is within 0.5 cm, because it is now the travel of a straight arm that falls short, not of the target.

The brief's one correction covers a negative dot, or a positive dot with the left hand on the wrong side. Neither is the case, so no code was changed. Getting the elbows back means putting the hand targets back inside her reach, which is the frozen fist target. That is Ernie's call, and it is not taken here.

## Clocks on the yaw tree, before the seat fix (the yaw and the side-sign flip in), copied from their logs

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.59 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=94.0 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.53 (0, 0), 91.59 (2, 0), 94.00 (3, 0); teleported=false, complete. Against the hip board, 18.54 / 91.59 / 94.00: the yaw does not touch the cert. The yaw stays.

Style and the board were held here for Ernie's call on the elbows.


## Why her arms could not reach: the yaw moved her seat

Asked, Ernie chose to bring the fist target in. Before touching it, the same scene printed where her shoulders and her Hips bone sit in the rider body frame:

```
shoulder_body L=(-0.082796, 0.40202, 0.099121) R=(0.140566, 0.402401, 0.100174) arm=0.3513 hips_body=(0.012656, 0.0, 0.116837)
```

Her hips were **11.7 cm behind the seat point and 1.3 cm to the right**. `_sit_hips` placed the mesh with `visual.position = -visual.scale * hip`. That cancels the Hips' rest offset only for an unrotated mesh. Under the 180° yaw it doubles the offset instead, so she sat back toward the cantle. The reach problem followed from that, so the fist target was the wrong thing to move.

Asked again with this, **Ernie chose to fix the seat and keep the fist target frozen**, and to report the elbows as they fall, with no SHOULDER_GIVE retune.

## The seat fix (`rider_mesh.gd`, `_sit_hips`, one line)

`visual.position = -(visual.basis * hip)`. The basis carries the yaw and the scale, so the turned mesh sits its hips on the seat point. The fist target, the pole, the side signs, the yaw, SHOULDER_GIVE, and the nod and hip lines are untouched.

The scene right after:

```
pin-halt gait=0 hand_travel=0.001 nod_p2p=0.00 nod_mean=+9.69 elbowL=129.98/0.02 elbowR=134.20/0.02 wristR_travel=0.001 hipx_p2p=0.07 heel_iron=0.069/0.069 heel_max=0.070/0.070 lowest_hoof=0.053 frames=145 nose_dot head+Z=+1.000 horse_x wristL=-0.042 wristR=+0.042 footL=-0.131 footR=+0.131 nose_down=16.9 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 shoulder_body L=(-0.095452, 0.402023, -0.017715) R=(0.12791, 0.402409, -0.016678) arm=0.3513 hips_body=(-0.0, 0.000008, -0.000015)
pin-walk gait=1 hand_travel=0.029 nod_p2p=2.30 nod_mean=+7.90 elbowL=129.98/1.33 elbowR=134.21/1.42 wristR_travel=0.029 hipx_p2p=4.53 heel_iron=0.120/0.120 heel_max=0.138/0.138 lowest_hoof=0.052 frames=239 nose_dot head+Z=+1.000 horse_x wristL=-0.041 wristR=+0.044 footL=-0.130 footR=+0.132 nose_down=26.9 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 shoulder_body L=(-0.09545, 0.402027, -0.017715) R=(0.127905, 0.402412, -0.016685) arm=0.3513 hips_body=(0.0, 0.0, 0.0)
dayone-walk gait=1 hand_travel=0.056 nod_p2p=5.85 nod_mean=+7.91 elbowL=130.00/4.16 elbowR=134.21/4.44 wristR_travel=0.056 hipx_p2p=8.17 heel_iron=0.120/0.120 heel_max=0.154/0.154 lowest_hoof=0.052 frames=239 nose_dot head+Z=+1.000 horse_x wristL=-0.041 wristR=+0.044 footL=-0.130 footR=+0.132 nose_down=26.8 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 shoulder_body L=(-0.095451, 0.402027, -0.017731) R=(0.127905, 0.402409, -0.016701) arm=0.3513 hips_body=(0.0, 0.0, 0.0)
pin-trot gait=2 hand_travel=0.055 nod_p2p=3.67 nod_mean=+7.10 elbowL=129.98/1.32 elbowR=134.21/1.42 wristR_travel=0.055 hipx_p2p=10.55 heel_iron=0.088/0.088 heel_max=0.111/0.111 lowest_hoof=0.052 frames=164 nose_dot head+Z=+1.000 horse_x wristL=-0.041 wristR=+0.044 footL=-0.130 footR=+0.132 nose_down=33.8 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 shoulder_body L=(-0.095453, 0.402023, -0.01784) R=(0.127908, 0.402409, -0.016809) arm=0.3513 hips_body=(0.0, 0.0, 0.0)
dayone-trot gait=2 hand_travel=0.081 nod_p2p=8.39 nod_mean=+7.08 elbowL=130.00/4.15 elbowR=134.22/4.44 wristR_travel=0.081 hipx_p2p=14.24 heel_iron=0.091/0.091 heel_max=0.107/0.107 lowest_hoof=0.052 frames=164 nose_dot head+Z=+1.000 horse_x wristL=-0.041 wristR=+0.044 footL=-0.130 footR=+0.132 nose_down=33.7 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 shoulder_body L=(-0.095447, 0.402025, -0.018127) R=(0.127907, 0.402412, -0.017094) arm=0.3513 hips_body=(0.0, 0.0, 0.0)
pin-canter gait=3 hand_travel=0.078 nod_p2p=2.86 nod_mean=+5.22 elbowL=129.98/1.33 elbowR=134.20/1.42 wristR_travel=0.078 hipx_p2p=5.56 heel_iron=0.127/0.127 heel_max=0.159/0.159 lowest_hoof=0.053 frames=119 nose_dot head+Z=+1.000 horse_x wristL=-0.062 wristR=+0.023 footL=-0.157 footR=+0.105 nose_down=32.0 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 shoulder_body L=(-0.095449, 0.402016, -0.017853) R=(0.127907, 0.402405, -0.01683) arm=0.3513 hips_body=(0.0, 0.0, 0.0)
dayone-canter gait=3 hand_travel=0.102 nod_p2p=7.50 nod_mean=+5.24 elbowL=130.00/4.15 elbowR=134.22/4.45 wristR_travel=0.102 hipx_p2p=9.10 heel_iron=0.127/0.127 heel_max=0.170/0.170 lowest_hoof=0.053 frames=119 nose_dot head+Z=+1.000 horse_x wristL=-0.062 wristR=+0.023 footL=-0.157 footR=+0.105 nose_down=31.7 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 shoulder_body L=(-0.095445, 0.402016, -0.018166) R=(0.127907, 0.402412, -0.017143) arm=0.3513 hips_body=(0.0, 0.0, 0.0)
```

| gait | horse | nose dot | helmet p2p | elbow L mean / p2p | elbow R mean / p2p | hip_x p2p | wrist travel | heel mean / farthest | lowest hoof |
| --- | --- | ---: | ---: | --- | --- | ---: | ---: | --- | ---: |
| halt | pin | **+1.000** | 0.00° | 129.98° / 0.02° | 134.20° / 0.02° | 0.07° | 0.001 | 0.069 / 0.070 | 0.053 |
| walk | pin | +1.000 | 2.30° | 129.98° / 1.33° | 134.21° / 1.42° | 4.53° | 0.029 | 0.120 / 0.138 | 0.052 |
| walk | day-one | +1.000 | 5.85° | 130.00° / 4.16° | 134.21° / 4.44° | 8.17° | 0.056 | 0.120 / 0.154 | 0.052 |
| trot | pin | +1.000 | 3.67° | 129.98° / 1.32° | 134.21° / 1.42° | 10.55° | 0.055 | 0.088 / 0.111 | 0.052 |
| trot | day-one | +1.000 | 8.39° | 130.00° / 4.15° | 134.22° / 4.44° | 14.24° | 0.081 | 0.091 / 0.107 | 0.052 |
| canter | pin | **+1.000** | 2.86° | 129.98° / 1.33° | 134.20° / 1.42° | 5.56° | 0.078 | 0.127 / 0.159 | 0.053 |
| canter | day-one | +1.000 | 7.50° | 130.00° / 4.15° | 134.22° / 4.45° | 9.10° | 0.102 | 0.127 / 0.170 | 0.053 |

- **Seat:** her Hips sit at body (0.000, 0.000, 0.000).
- **Fists:** on their targets (0.0000 m), with **3.3 cm (L) / 2.8 cm (R) of reach to spare**.
- **Hands:** wrist travel is exactly the kept 0.029 / 0.056, 0.055 / 0.081, 0.078 / 0.102.
- **Nose:** +1.000 at the halt and the canter. Left wrist and foot on his left.
- **Held:** nods 2.30 / 5.85, 3.67 / 8.39, 2.86 / 7.50. Hips 3.64 / 3.69 / 3.54° more on day-one. Heels as the hip job. Hoof 0.052–0.053.
- **Elbows:**
  - They now sit bent, at 130.0° / 134.2°. They were 145.6° / 150.4° when she faced the tail.
  - They open **2.83° (L) / 3.02° (R) more on day-one at every gait**, against the kept 4.51 / 5.15.
  - The reason: a more bent elbow turns less per millimetre of shoulder give. At 130° it is about 70 % of the 145.6° rate, so the same `SHOULDER_GIVE` 12 buys less.
  - They still open and close with the hands (pin 1.3°, day-one 4.2–4.4°), just not by the kept margin.
  - Per Ernie's call, no retune. **This row does not meet 4.5 / 5.2**, and is written as it stands.

## Clocks on this tree (yaw, side signs, seat fix), copied from their logs

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.61 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=93.99 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.54 (0, 0), 91.61 (2, 0), 93.99 (3, 0); teleported=false, complete. The yaw, the side signs and the seat stay.

## The pin is still the pin — style, once, `--ridecert-style --ridecert-id=hk_beg_035` (probe on the refusal only, stripped after)

```
PROBE32 refuse t=0.25 conf=85.0 gait=0 neck1=+11.71 tail1=-0.32 ear=+7.63 clip=Idle FFB=0.053/0.053 helmet=+4.81 head_x=+18.86 elbowL=129.98 elbowR=134.21 hip_x=+21.62
RIDECERT hk_beg_035 style=refuse_early success=true faults=4 jumped=8/8 t=69.88 teleported=false complete=true refused=[1] rail_fences=[] rail_air=[] conf=83.0 scope=82.5
FENCE knock 3 by horse at 9.0,-2.5 next=3 jumping=true
RIDECERT hk_beg_035 style=rail_late success=true faults=4 jumped=8/8 t=67.11 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=81.0
```

- **B:** refused fence 1, 0 rails, Idle, hinds 0.053 / 0.053, Neck1 +11.71, Tail1 −0.32. Elbows at their new rest angles (129.98° / 134.21°).
- **Helmet sign:** it reads +4.81° where the tail-facing tree read −5.03°. The turned mesh reverses the side axis this angle is signed about. The peak-to-peak (the nod) is unchanged.
- **C:** one rail, the knock on fence 3 with `jumping=true`, in the air, 67.11 (hip job 67.17).

## Board — one full `--ridecert`, `board_table.py`

`RIDECERT done pass=false board=21/23 style=true`, 26 rounds in the log, wrapper `GODOT_EXIT 1` (the board is not 23/23).

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

Against the board in `dist/hip_002.md`: 26 rows, worst |Δ| **0.02 s** (`hk_int_009`), all 21 clears within 0.1 s, no rail changed, 0 teleported. Same 21/23. The board did not move; the yaw, the side signs and the seat fix stay.

## Playtest — headless `--playtest`, this run, after the board line was copied

```
PLAYTEST begin fences=8
PLAYTEST clear faults=0 complete=true
PLAYTEST refuse faults=4
PLAYTEST rail faults=4
PLAYTEST done pass=true
```
