# What is still the same

This job prints; no coefficient, no ride. One throwaway scene (`game/tools/probe_quiet.gd`, deleted after), pin 85/80/44/38/36 and day-one 48/40/44/38/36: one second of halt, then one settled stride of walk, trot and canter. The tree is the give board's (SHOULDER_GIVE 19, the yaw, the seat line), byte-identical before and after.

| | halt | walk | trot | canter |
| --- | --- | --- | --- | --- |
| nose dot, pin | +1.000 | +1.000 | +1.000 | +1.000 |
| Tail7 tip over the withers, pin / day-one (difference) | −0.297 / −0.245 (5.2 cm) | −0.465 / −0.414 (**5.1 cm**) | −0.465 / −0.414 (**5.1 cm**) | +0.132 / +0.268 (13.6 cm) |
| Ear4 tip distance, head frame | 5.6 cm | 5.6 cm | 5.6 cm | 4.9 cm |
| elbow p2p, more on day-one, L / R | **0.00° / 0.00°** (0.02 / 0.02 on both) | 4.46° / 4.76° | 4.46° / 4.77° | 4.46° / 4.75° |
| hip_x p2p, more on day-one | **0.00°** (0.07 / 0.07) | 3.57° | 3.63° | 3.54° |
| helmet pitch p2p, pin / day-one | **0.00 / 0.00°** (mean +9.69 / +9.69) | 2.33 / 5.84° | 3.67 / 8.40° | 2.85 / 7.50° |
| hips on the seat point | yes (0.000) | yes | yes | yes |

Copied from the scene:

```
pin-halt conf=85.0 gait=0 neck1=-0.09 tail1=-0.22 ear=-2.27 tailtip=-0.297 hand_travel=0.001 eartip_head=(-0.109,-0.098,+0.202) nod_p2p=0.00 nod_mean=+9.69 elbowL=129.98/0.02 elbowR=134.20/0.02 hipx_p2p=0.07 lowest_hoof=0.053 frames=145 nose_dot head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 hips_body=(-0.0, 0.0, 0.0)
dayone-halt conf=48.0 gait=0 neck1=+9.80 tail1=-10.12 ear=-11.13 tailtip=-0.245 hand_travel=0.001 eartip_head=(-0.108,-0.044,+0.217) nod_p2p=0.00 nod_mean=+9.69 elbowL=129.98/0.02 elbowR=134.20/0.02 hipx_p2p=0.07 lowest_hoof=0.053 frames=143 nose_dot head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 hips_body=(-0.0, -0.000004, 0.0)
pin-walk conf=85.0 gait=1 neck1=-4.54 tail1=+0.22 ear=-11.49 tailtip=-0.465 hand_travel=0.030 eartip_head=(-0.109,-0.098,+0.202) nod_p2p=2.33 nod_mean=+7.93 elbowL=129.92/2.10 elbowR=134.14/2.25 hipx_p2p=4.59 lowest_hoof=0.052 frames=225 nose_dot head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0330/-0.0277 hips_body=(0.0, 0.0, 0.0)
dayone-walk conf=48.0 gait=1 neck1=+5.38 tail1=-9.69 ear=-20.26 tailtip=-0.414 hand_travel=0.056 eartip_head=(-0.108,-0.044,+0.217) nod_p2p=5.84 nod_mean=+7.89 elbowL=130.02/6.56 elbowR=134.23/7.01 hipx_p2p=8.16 lowest_hoof=0.052 frames=240 nose_dot head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0277 hips_body=(-0.0, 0.0, -0.000001)
pin-trot conf=85.0 gait=2 neck1=-4.48 tail1=+0.20 ear=-11.40 tailtip=-0.465 hand_travel=0.055 eartip_head=(-0.109,-0.098,+0.202) nod_p2p=3.67 nod_mean=+7.08 elbowL=129.99/2.10 elbowR=134.21/2.24 hipx_p2p=10.61 lowest_hoof=0.052 frames=165 nose_dot head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 hips_body=(0.0, 0.0, 0.0)
dayone-trot conf=48.0 gait=2 neck1=+5.36 tail1=-9.69 ear=-20.29 tailtip=-0.414 hand_travel=0.081 eartip_head=(-0.108,-0.044,+0.217) nod_p2p=8.40 nod_mean=+7.21 elbowL=129.92/6.56 elbowR=134.12/7.01 hipx_p2p=14.24 lowest_hoof=0.052 frames=160 nose_dot head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0330/-0.0278 hips_body=(0.0, 0.0, 0.0)
pin-canter conf=85.0 gait=3 neck1=-15.23 tail1=-0.73 ear=+5.47 tailtip=+0.132 hand_travel=0.078 eartip_head=(-0.110,-0.163,+0.111) nod_p2p=2.85 nod_mean=+5.21 elbowL=129.99/2.10 elbowR=134.21/2.26 hipx_p2p=5.54 lowest_hoof=0.053 frames=119 nose_dot head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0276 hips_body=(0.0, 0.0, 0.0)
dayone-canter conf=48.0 gait=3 neck1=-5.37 tail1=-10.65 ear=-3.35 tailtip=+0.268 hand_travel=0.103 eartip_head=(-0.111,-0.135,+0.151) nod_p2p=7.50 nod_mean=+5.21 elbowL=130.03/6.56 elbowR=134.23/7.01 hipx_p2p=9.08 lowest_hoof=0.053 frames=120 nose_dot head+Z=+1.000 fist_to_target=0.0000/0.0000 shoulder_to_target_minus_reach=-0.0329/-0.0277 hips_body=(-0.0, 0.000015, -0.000015)
```

**Check against the give board** (`dist/give_002.md`):

- **Nose:** +1.000 at every row.
- **Seat:** hips on the seat point (0.000 m) at every row. Fists on their targets (0.000 m).
- **Elbows:** 4.46 / 4.75–4.77° more on day-one (give board 4.46 / 4.76–4.77).
- **Hips:** 3.57 / 3.63 / 3.54° (3.64 / 3.70 / 3.56). The pin walk row is a 225-frame stride, the rest 240.
- **Helmet:** 2.33 / 5.84, 3.67 / 8.40, 2.85 / 7.50.
- **Neck and tail:** Neck1 and Tail1 9.9° apart at the three gaits, Neck1 9.9° and Tail1 9.9° at the halt.
- **Hands and hoof:** hand travel 0.030 / 0.056, 0.055 / 0.081, 0.078 / 0.103. Hoof 0.052–0.053.

**The tail tip is the standing negative:** at the walk and the trot the Tail7 tips differ by 5.1 cm, under 8 cm, and both still hang 0.41–0.47 m below the withers. The Tail2–Tail5 curl stays reverted and is not tried again.

**Identical, not on the closed list: her own pose at the halt.** On both horses, over one second of halt:

- her helmet pitch against her shoulders is +9.69° mean, 0.00° p2p;
- her elbows are 129.98° / 134.20° with 0.02° p2p;
- her hip_x p2p is 0.07°;
- her hands travel 0.001 m.

Every rider channel kept so far (nod, elbow give, hip) is a stride term, and all of them are off at gait 0. So at the halt the horse shows the difference (Neck1 +9.80 against −0.09, Tail1 −10.12 against −0.22, the ear 5.6 cm) and she does not. Named here, not built. The give board (21/23, worst move 0.06 s on hk_int_001) stands; no style, board or playtest was run.
