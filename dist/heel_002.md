# Her heel stays while she folds

## Step 0 — the points, reprinted, before any new line

One probe in `horse.gd`, stripped before any timed clock; the tree is the seat board's. It is the back probe plus, in the rider body frame, her left hip joint (`UpperLegL`) and knee (`LowerLegL`), the eased shin_x (`LShin` rotation + hip, the angle `rider_mesh` gives `_spec`), and the knee angle (hip joint, knee, heel; 180° = straight). The rides are pin `--ridecert-id=hk_les_001`, then fresh, fence 1. The pin clock printed confidence 91.0, so no fresh leak.

Pin:

```
FOLD two-point fence=1 conf=85.0 unrest=0.180 last_stride=1.000 land_recover=0.000 jumping=false u=-1.000 neck1=-10.45 target pitch=-37.74 hip=+43.05 head=+16.50 eased pitch=-39.59 hip=+27.68 head=+27.48 helmet=+0.93 fistL=0.0000 fistR=0.0000 heelL=0.1188 heelR=0.1188 heelL_body=(-0.154, -0.395, -0.0907) ironL_body=(-0.17, -0.4275, -0.2258) hipjL_body=(-0.0652, 0.0316, 0.0672) kneeL_body=(-0.15, -0.0515, -0.2667) shin_x=-15.47 knee_angle=77.38
FOLD air-0.55 fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=0.000 jumping=true u=0.560 neck1=-21.44 target pitch=-34.00 hip=+23.80 head=+12.60 eased pitch=-37.50 hip=+26.21 head=+17.75 helmet=+5.31 fistL=0.0002 fistR=0.0002 heelL=0.1073 heelR=0.1073 heelL_body=(-0.154, -0.4073, -0.1016) ironL_body=(-0.17, -0.4389, -0.2228) hipjL_body=(-0.0652, 0.0316, 0.0672) kneeL_body=(-0.15, -0.0581, -0.2658) shin_x=-13.52 knee_angle=80.33
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
```

Day-one:

```
FOLD two-point fence=1 conf=48.0 unrest=0.565 last_stride=1.000 land_recover=0.000 jumping=false u=-1.000 neck1=-0.92 target pitch=-33.43 hip=+53.68 head=-14.77 eased pitch=-39.91 hip=+30.28 head=+19.39 helmet=+4.57 fistL=0.0000 fistR=0.0000 heelL=0.1197 heelR=0.1197 heelL_body=(-0.154, -0.3836, -0.0923) ironL_body=(-0.17, -0.4259, -0.2257) hipjL_body=(-0.0652, 0.0316, 0.0672) kneeL_body=(-0.15, -0.0399, -0.268) shin_x=-15.42 knee_angle=75.56
FOLD air-0.55 fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=0.000 jumping=true u=0.560 neck1=-21.44 target pitch=-34.00 hip=+27.65 head=+1.05 eased pitch=-37.61 hip=+29.89 head=+6.82 helmet=+10.23 fistL=0.0002 fistR=0.0002 heelL=0.1103 heelR=0.1103 heelL_body=(-0.154, -0.3909, -0.1035) ironL_body=(-0.17, -0.4386, -0.2232) hipjL_body=(-0.0652, 0.0316, 0.0672) kneeL_body=(-0.15, -0.0417, -0.2678) shin_x=-13.53 knee_angle=77.67
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=54.0 scope=44.5
```

| sample | horse | unrest | eased pitch | heel (body) | iron (body) | knee (body) | shin_x | knee angle | heel to iron |
| --- | --- | ---: | ---: | --- | --- | --- | ---: | ---: | ---: |
| two-point | pin | 0.180 | −39.59 | (−0.154, −0.395, −0.0907) | (−0.170, −0.4275, −0.2258) | (−0.150, −0.0515, −0.2667) | −15.47 | 77.38° | **0.1188** |
| | day-one | 0.565 | −39.91 | (−0.154, −0.3836, −0.0923) | (−0.170, −0.4259, −0.2257) | (−0.150, −0.0399, −0.268) | −15.42 | 75.56° | **0.1197** |
| u 0.55 | pin | 0.180 | −37.50 | (−0.154, −0.4073, −0.1016) | (−0.170, −0.4389, −0.2228) | (−0.150, −0.0581, −0.2658) | −13.52 | 80.33° | 0.1073 |
| | day-one | 0.565 | −37.61 | (−0.154, −0.3909, −0.1035) | (−0.170, −0.4386, −0.2232) | (−0.150, −0.0417, −0.2678) | −13.53 | 77.67° | 0.1103 |

The day-one two-point points reprint the back job's within 3 mm (heel (−0.154, −0.386, −0.093), iron (−0.170, −0.424, −0.224)). The heel-to-iron distance is 0.1197 this ride, against 0.1169 there.

## The prediction, on paper

**The sign of the fold, from the measured revert.** In `dist/back_002.md`, day-one's eased two-point pitch went −40.04 → −48.59 (−8.55°), and the iron in her body frame went from (y, z) (−0.424, −0.224) to (−0.387, −0.288). That is a rotation of **+8.80°** about body X at the seat (radius 0.480 → 0.482 m): −1.03° of iron rotation per degree of pitch. Her heel stayed put in the body frame (−0.3862 → −0.3828), because her legs hang on her body.

**The fold alone**, d = −18 × unrest on the two-point:

| | pitch change | heel relative to the iron (y, z), before → after | heel to iron |
| --- | ---: | --- | --- |
| pin | −3.24° | (0.028, 0.115) → (0.016, 0.136) | 0.1188 → 0.1372 (+1.8 cm) |
| day-one | −10.17° | (0.036, 0.113) → (−0.005, 0.176) | 0.1197 → **0.1766 (+5.7 cm)**; it was measured at +5.0 cm with 84 % arrival |

**The counter, shin_x only.** `_spec` puts the heel at `leg_o + Rx(hip) · knee_o + Rx(shin_x) · v`, so a shin_x change Δ turns the heel about the knee by Δ in the body frame, and hip_x is untouched. Heel-to-iron distance for `shin_x += C × unrest`, with the fold of 18, at full arrival:

| C | pin (cm off step 0) | day-one (cm off step 0) | knee pin / day-one |
| ---: | --- | --- | --- |
| 0 | 0.1372 (+1.8) | 0.1765 (+5.7) | 77.4° / 75.6° |
| 10 | 0.1276 (+0.9) | 0.1482 (+2.9) | 79.1° / 81.0° |
| 14 | 0.1238 (+0.5) | 0.1369 (+1.7) | 79.8° / 83.2° |
| 18 | 0.1199 (+0.1) | 0.1256 (+0.6) | 80.5° / 85.4° |
| **20** | **0.1180 (−0.1)** | **0.1200 (+0.0)** | **80.9° / 86.5°** |
| 24 | 0.1142 (−0.5) | 0.1089 (−1.1) | 81.6° / 88.7° |

- **C = +20**, one sign: shin_x more positive, the lower leg swung back under her toward the iron.
- **The prediction:** day-one's two-point heel at **0.1200 m (0.1197 step 0)**, the pin's at 0.1180 m (0.1188). The pitch and the shin ease at the same `k`, so at 60 % / 80 % arrival it is 0.1169 / 0.1179 (day-one) and 0.1180 / 0.1179 (pin), all inside 2 cm.
- **The knee stays bent:** 75.6° → 86.5° on day-one, 77.4° → 80.9° on the pin, far from 180°.
- **The prediction passes, so one ride.**

## Phase 1 — 18, and the shin counter (`horse.gd`)

`const FOLD_PITCH := 18.0` and `const FOLD_SHIN := 20.0`, as `pitch -= FOLD_PITCH * _hand_unrest()` and `shin_x += FOLD_SHIN * _hand_unrest()`, in three places:

- after the last_stride lerp, × s, gait ≥ 1, not jumping;
- after the jump keys, × 1;
- in the sit window (land_recover > 0, not jumping, last_stride ≤ 0.20), beside the sit's head and hip.

hip_x, the head shares, the keys and the air SIT_HIP are unchanged.

After, pin:

```
FOLD two-point fence=1 conf=85.0 unrest=0.180 last_stride=1.000 land_recover=0.000 jumping=false u=-1.000 neck1=-10.53 target pitch=-40.98 hip=+43.05 head=+16.50 eased pitch=-42.48 hip=+27.23 head=+27.86 helmet=+0.76 fistL=0.0000 fistR=0.0000 heelL=0.1153 heelR=0.1153 heelL_body=(-0.154, -0.4063, -0.1099) ironL_body=(-0.17, -0.4145, -0.2444) hipjL_body=(-0.0652, 0.0316, 0.0672) kneeL_body=(-0.15, -0.0535, -0.2664) shin_x=-12.26 knee_angle=80.81
FOLD air-0.20 fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=0.000 jumping=true u=0.202 neck1=-5.18 target pitch=-43.25 hip=+27.81 head=+18.63 eased pitch=-43.30 hip=+27.96 head=+24.16 helmet=+2.42 fistL=0.0000 fistR=0.0000 heelL=0.1269 heelR=0.1269 heelL_body=(-0.154, -0.4044, -0.1133) ironL_body=(-0.17, -0.4216, -0.2608) hipjL_body=(-0.0652, 0.0316, 0.0672) kneeL_body=(-0.15, -0.0502, -0.2669) shin_x=-11.79 knee_angle=80.74
FOLD air-0.55 fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=0.000 jumping=true u=0.560 neck1=-21.44 target pitch=-37.24 hip=+23.80 head=+12.60 eased pitch=-40.68 hip=+26.13 head=+17.79 helmet=+5.29 fistL=0.0002 fistR=0.0002 heelL=0.1057 heelR=0.1057 heelL_body=(-0.154, -0.4171, -0.1234) ironL_body=(-0.17, -0.4257, -0.2464) hipjL_body=(-0.0652, 0.0316, 0.0672) kneeL_body=(-0.15, -0.0584, -0.2657) shin_x=-9.98 knee_angle=83.82
FOLD air-0.85 fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=0.000 jumping=true u=0.857 neck1=-51.07 target pitch=-17.25 hip=+19.80 head=+4.61 eased pitch=-31.55 hip=+23.31 head=+11.82 helmet=+7.97 fistL=0.0039 fistR=0.0047 heelL=0.0548 heelR=0.0548 heelL_body=(-0.154, -0.4293, -0.1205) ironL_body=(-0.17, -0.4263, -0.1829) hipjL_body=(-0.0652, 0.0316, 0.0672) kneeL_body=(-0.15, -0.0708, -0.2634) shin_x=-10.08 knee_angle=85.75
FOLD sit fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=2.720 jumping=false u=-1.000 neck1=-34.15 target pitch=-1.24 hip=+21.80 head=+0.60 eased pitch=-21.92 hip=+22.34 head=+7.92 helmet=+9.73 fistL=0.0000 fistR=0.0000 heelL=0.0194 heelR=0.0194 heelL_body=(-0.154, -0.4304, -0.1118) ironL_body=(-0.17, -0.4181, -0.1225) hipjL_body=(-0.0652, 0.0316, 0.0672) kneeL_body=(-0.15, -0.0751, -0.2625) shin_x=-11.33 knee_angle=85.24
FOLD sit+0.5s fence=1 conf=85.0 unrest=0.180 last_stride=0.189 land_recover=2.203 jumping=false u=-1.000 neck1=-18.72 target pitch=-1.24 hip=+21.80 head=+0.60 eased pitch=-7.49 hip=+21.96 head=+2.81 helmet=+12.09 fistL=0.0000 fistR=0.0000 heelL=0.0490 heelR=0.0624 heelL_body=(-0.154, -0.4261, -0.0982) ironL_body=(-0.1528, -0.4005, -0.0466) hipjL_body=(-0.0652, 0.0316, 0.0672) kneeL_body=(-0.15, -0.0767, -0.2621) shin_x=-13.47 knee_angle=83.42
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.51 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
```

After, day-one:

```
FOLD two-point fence=1 conf=48.0 unrest=0.565 last_stride=1.000 land_recover=0.000 jumping=false u=-1.000 neck1=-0.53 target pitch=-43.60 hip=+53.68 head=-14.77 eased pitch=-48.76 hip=+30.43 head=+19.34 helmet=+4.59 fistL=0.0000 fistR=0.0000 heelL=0.1180 heelR=0.1180 heelL_body=(-0.154, -0.4075, -0.1525) ironL_body=(-0.17, -0.3864, -0.2888) hipjL_body=(-0.0652, 0.0316, 0.0672) kneeL_body=(-0.15, -0.0393, -0.268) shin_x=-5.76 knee_angle=84.83
FOLD air-0.20 fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=0.000 jumping=true u=0.202 neck1=-2.72 target pitch=-50.32 hip=+31.80 head=+7.35 eased pitch=-49.76 hip=+31.35 head=+14.65 helmet=+6.70 fistL=0.0000 fistR=0.0000 heelL=0.1260 heelR=0.1260 heelL_body=(-0.154, -0.4053, -0.1591) ironL_body=(-0.17, -0.3891, -0.3055) hipjL_body=(-0.0652, 0.0316, 0.0672) kneeL_body=(-0.15, -0.0352, -0.2683) shin_x=-4.78 knee_angle=85.12
FOLD air-0.55 fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=0.000 jumping=true u=0.560 neck1=-21.44 target pitch=-44.20 hip=+27.67 head=+1.08 eased pitch=-47.66 hip=+29.97 head=+7.04 helmet=+10.12 fistL=0.0003 fistR=0.0003 heelL=0.1072 heelR=0.1072 heelL_body=(-0.154, -0.4155, -0.1731) ironL_body=(-0.17, -0.3933, -0.2962) hipjL_body=(-0.0652, 0.0316, 0.0672) kneeL_body=(-0.15, -0.0413, -0.2679) shin_x=-2.56 knee_angle=88.26
FOLD air-0.85 fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=0.000 jumping=true u=0.857 neck1=-51.07 target pitch=-24.18 hip=+23.65 head=-6.94 eased pitch=-37.88 hip=+26.98 head=+0.21 helmet=+13.20 fistL=0.0038 fistR=0.0038 heelL=0.0555 heelR=0.0555 heelL_body=(-0.154, -0.4288, -0.1718) ironL_body=(-0.17, -0.4014, -0.2289) hipjL_body=(-0.0652, 0.0316, 0.0672) kneeL_body=(-0.15, -0.0546, -0.2663) shin_x=-2.51 knee_angle=90.45
FOLD sit fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=2.720 jumping=false u=-1.000 neck1=-34.11 target pitch=-8.17 hip=+25.65 head=-10.95 eased pitch=-28.69 hip=+26.13 head=-3.57 helmet=+14.90 fistL=0.0000 fistR=0.0000 heelL=0.0298 heelR=0.0298 heelL_body=(-0.154, -0.4306, -0.1636) ironL_body=(-0.17, -0.4002, -0.171) hipjL_body=(-0.0652, 0.0316, 0.0672) kneeL_body=(-0.15, -0.0584, -0.2657) shin_x=-3.69 knee_angle=89.94
FOLD sit+0.5s fence=1 conf=48.0 unrest=0.565 last_stride=0.189 land_recover=2.203 jumping=false u=-1.000 neck1=-8.82 target pitch=-8.17 hip=+25.65 head=-10.95 eased pitch=-14.45 hip=+25.80 head=-8.69 helmet=+17.30 fistL=0.0000 fistR=0.0000 heelL=0.0566 heelR=0.0700 heelL_body=(-0.154, -0.4281, -0.1498) ironL_body=(-0.1531, -0.3921, -0.0938) hipjL_body=(-0.0652, 0.0316, 0.0672) kneeL_body=(-0.15, -0.0599, -0.2655) shin_x=-5.78 knee_angle=88.13
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=54.0 scope=44.5
```

| gate | step 0 | with 18 + shin 20 | rule | |
| --- | --- | --- | --- | --- |
| eased pitch at u 0.55, pin / day-one | −37.50 / −37.61 | −40.68 / −47.66 (**6.98°** apart) | ≥ 3° | pass |
| the pin's eased pitch at u 0.55 | −37.53 (back step 0) | −40.68 (3.15°) | within 4° | pass |
| day-one two-point heel to iron | 0.1197 (back step 0 0.1169) | **0.1180** (−0.2 cm; +0.1 cm on 0.1169); predicted 0.1169–0.1200 | within 2 cm of 0.1169 | pass |
| pin two-point heel to iron | 0.1188 (back 0.1209) | 0.1153 (−0.4 cm; −0.6 cm on 0.1209); predicted 0.1180 | within 2 cm of 0.1209 | pass |
| eased hip at u 0.55, pin / day-one | 26.21 / 29.89 | 26.13 / 29.97 (**3.84°**) | ≥ 3° | pass |
| helmet gap: two-point / u 0.55 / sit +0.5 s | kept 3.8 / 4.9 / 5.2 | **3.83 / 4.83 / 5.21** | within 0.5° of the kept | pass |
| fists at u 0.20 / 0.55 / 0.85, max each | pin 0 / 0.02 / 0.58 cm; day-one 0 / 0.02 / 0.83 cm | pin 0 / 0.02 / 0.47 cm; day-one 0 / 0.03 / 0.38 cm | ≤ 1 cm and ≤ own + 0.5 cm | pass |
| left knee, two-point / u 0.55, pin | 77.38° / 80.33° | 80.81° / 83.82° | bent | pass |
| left knee, two-point / u 0.55, day-one | 75.56° / 77.67° | 84.83° / 88.26° (predicted 86.5° at the two-point) | bent | pass |
| the pin's Neck1 at u 0.55 | −21.44 | −21.44 (day-one −21.44) | −21.4 | pass |

- **The knees.** Only the left leg is printed. The right leg takes the same hip_x and shin_x through `_spec` mirrored by its side sign, so its knee angle is the same. Neither leg is near 180°.
- **The shin.** The shin_x she eases toward moves by +20 × unrest on the two-point: day-one −15.42 → −5.76, pin −15.47 → −12.26. Her lower leg swings back under her as she folds. **Kept.**

Three clocks with the fold and the shin counter in, probe stripped, copied from their logs:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.6 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=93.99 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.54 (0, 0), 91.60 (2, 0), 93.99 (3, 0); teleported=false, complete. The pin confidence is 91.0, so no fresh leak.

**The leave stays one pose** (pin hk_adv_002, probe on, stripped after):

```
LINE shin -12.40 -> first -12.40 | head 22.60 -> first 22.60 | fence=3 land_recover_at_leave=0.653 air_sound_at_leave=0 pitch -45.24 -> first -45.24 (u 0.000) -> u05 -44.81 (u 0.060) | hip 29.80 -> first 29.80 -> u05 29.37 grunt_u=0.345 land_playing_at_leave=false (pos -1.000) land_playing_at_grunt=false since_last_thud=2.064 hoof_strikes_in_air=0
LINE shin -12.40 -> first -12.38 | head 22.60 -> first 22.56 | fence=12 land_recover_at_leave=0.970 air_sound_at_leave=0 pitch -45.24 -> first -45.22 (u 0.012) -> u05 -44.81 (u 0.060) | hip 29.80 -> first 29.78 -> u05 29.37 grunt_u=0.345 land_playing_at_leave=false (pos -1.000) land_playing_at_grunt=false since_last_thud=1.726 hoof_strikes_in_air=0
RIDECERT hk_adv_002 style=clear success=true faults=0 jumped=12/12 t=83.14 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
```

| fence | land_recover at leave | first jumping frame u | pitch | hip | head | shin_x |
| --- | ---: | ---: | --- | --- | --- | --- |
| 3 | 0.653 | 0.000 | −45.24 → −45.24 (**0.00°**) | 29.80 → 29.80 (**0.00°**) | 22.60 → 22.60 (**0.00°**) | −12.40 → −12.40 (**0.00°**) |
| 12 | 0.970 | 0.012 | −45.24 → −45.22 (0.02°) | 29.80 → 29.78 (0.02°) | 22.60 → 22.56 (0.04°) | −12.40 → −12.38 (0.02°) |

- **The share is continuous.** −45.24 is −42 − 18 × 0.18, and −12.40 is −16 + 20 × 0.18: the same share on the two-point at last_stride 1 and on the jump.
- **Fence 12.** On this ride its first jumping frame fell at u 0.012, not 0. The 0.02–0.04° is the jump keys' own travel over that 0.012 of u: pitch −42 → −40, hip 28 → 26, head 28 → 24 and shin −16 → −14 over u 0 → 0.20, so smoothstep(0.06) = 0.0104 gives 0.021 / 0.021 / 0.042 / 0.021. That is not a step in the share.
- **All under 8°.** The round is clear, 83.14, 12/12, 0 rails, teleported=false, complete.

## The moving picture still holds

One throwaway scene, run twice and deleted after each run: on the seat tree first (before the counter), then with the fold and the counter in. Each run is one second of halt, then one stride of walk, trot and canter, pin and day-one.

Before the counter:

```
pin-halt hand_travel=0.001 nod_p2p=0.02 nod_mean=+11.31 elbowL=127.81/0.01 elbowR=131.87/0.02 hipx_p2p=0.09 hipx_mean=+9.58 heel_iron=0.064/0.064 heel_max=0.065/0.065 lowest_hoof=0.053
dayone-halt hand_travel=0.001 nod_p2p=0.05 nod_mean=+14.76 elbowL=123.55/0.01 elbowR=127.17/0.02 hipx_p2p=0.11 hipx_mean=+13.03 heel_iron=0.054/0.054 heel_max=0.054/0.054 lowest_hoof=0.053
pin-walk hand_travel=0.029 nod_p2p=2.30 nod_mean=+7.90 elbowL=129.98/2.10 elbowR=134.21/2.25 hipx_p2p=4.54 hipx_mean=+3.49 heel_iron=0.120/0.120 heel_max=0.138/0.138 lowest_hoof=0.052
dayone-walk hand_travel=0.056 nod_p2p=5.84 nod_mean=+7.91 elbowL=130.03/6.56 elbowR=134.24/7.01 hipx_p2p=8.17 hipx_mean=+3.52 heel_iron=0.120/0.120 heel_max=0.154/0.154 lowest_hoof=0.052
pin-trot hand_travel=0.055 nod_p2p=3.66 nod_mean=+7.11 elbowL=129.99/2.10 elbowR=134.21/2.24 hipx_p2p=10.57 hipx_mean=+15.29 heel_iron=0.088/0.088 heel_max=0.111/0.111 lowest_hoof=0.052
dayone-trot hand_travel=0.081 nod_p2p=8.39 nod_mean=+7.10 elbowL=130.02/6.56 elbowR=134.23/7.02 hipx_p2p=14.22 hipx_mean=+15.29 heel_iron=0.091/0.091 heel_max=0.107/0.107 lowest_hoof=0.052
pin-canter hand_travel=0.078 nod_p2p=2.86 nod_mean=+5.22 elbowL=129.99/2.10 elbowR=134.21/2.25 hipx_p2p=5.55 hipx_mean=+5.68 heel_iron=0.127/0.127 heel_max=0.158/0.158 lowest_hoof=0.053
dayone-canter hand_travel=0.103 nod_p2p=7.51 nod_mean=+5.23 elbowL=130.02/6.57 elbowR=134.23/7.02 hipx_p2p=9.11 hipx_mean=+5.68 heel_iron=0.127/0.127 heel_max=0.170/0.170 lowest_hoof=0.053
```

With the counter:

```
pin-halt hand_travel=0.001 nod_p2p=0.02 nod_mean=+11.31 elbowL=127.81/0.02 elbowR=131.87/0.02 hipx_p2p=0.09 hipx_mean=+9.58 heel_iron=0.064/0.064 heel_max=0.065/0.065 lowest_hoof=0.053
dayone-halt hand_travel=0.001 nod_p2p=0.05 nod_mean=+14.76 elbowL=123.55/0.01 elbowR=127.17/0.01 hipx_p2p=0.11 hipx_mean=+13.03 heel_iron=0.054/0.054 heel_max=0.054/0.054 lowest_hoof=0.053
pin-walk hand_travel=0.029 nod_p2p=2.27 nod_mean=+7.80 elbowL=129.95/2.10 elbowR=134.17/2.25 hipx_p2p=4.47 hipx_mean=+3.31 heel_iron=0.122/0.122 heel_max=0.139/0.139 lowest_hoof=0.052
dayone-walk hand_travel=0.056 nod_p2p=5.84 nod_mean=+7.91 elbowL=130.02/6.56 elbowR=134.23/7.01 hipx_p2p=8.16 hipx_mean=+3.51 heel_iron=0.120/0.120 heel_max=0.154/0.154 lowest_hoof=0.052
pin-trot hand_travel=0.055 nod_p2p=3.67 nod_mean=+7.12 elbowL=129.98/2.10 elbowR=134.21/2.24 hipx_p2p=10.55 hipx_mean=+15.30 heel_iron=0.088/0.088 heel_max=0.111/0.111 lowest_hoof=0.052
dayone-trot hand_travel=0.081 nod_p2p=8.40 nod_mean=+7.10 elbowL=130.02/6.56 elbowR=134.23/7.01 hipx_p2p=14.21 hipx_mean=+15.29 heel_iron=0.091/0.091 heel_max=0.107/0.107 lowest_hoof=0.052
pin-canter hand_travel=0.077 nod_p2p=2.84 nod_mean=+5.18 elbowL=129.99/2.11 elbowR=134.21/2.25 hipx_p2p=5.55 hipx_mean=+5.60 heel_iron=0.128/0.128 heel_max=0.159/0.159 lowest_hoof=0.053
dayone-canter hand_travel=0.103 nod_p2p=7.52 nod_mean=+5.27 elbowL=130.03/6.56 elbowR=134.23/7.01 hipx_p2p=9.13 hipx_mean=+5.74 heel_iron=0.127/0.127 heel_max=0.169/0.169 lowest_hoof=0.053
```

- **Heels on the flat:** they move by at most 0.2 cm between the two runs (pin walk 0.120 → 0.122, farthest 0.138 → 0.139), inside 2 cm.
- **Halt means:** identical, and they still match `dist/halt_002.md`: helmet 3.45° apart, elbows 4.26 / 4.70°, hip 3.45°, peak-to-peak 0.01–0.11°.
- **Moving gaits:** helmet 2.27 / 5.84, 3.67 / 8.40, 2.84 / 7.52; elbow p2p 2.10 / 6.56, 2.24–2.25 / 7.01; hip p2p 4.47 / 8.16, 10.55 / 14.21, 5.55 / 9.13; wrist travel 0.029 / 0.056, 0.055 / 0.081, 0.077 / 0.103; hoof 0.052–0.053. That matches `dist/same_002.md` within 0.07° and 0.1 cm. The pin walk row is a 0.07° / 0.1 cm stride-to-stride difference.
- **No leak.** The pitch share and the shin counter run only with last_stride > 0.20, while jumping, or in the sit window, and none is present on a settled gait or at the halt.

## The check is still a check — style, once, `--ridecert-style --ridecert-id=hk_beg_035` (probe on the refusal only, stripped after)

```
PROBE32 refuse t=0.25 conf=85.0 gait=0 neck1=+11.70 tail1=-0.32 ear=+7.30 clip=Idle FFB=0.053/0.053 helmet=+7.53 head_x=+12.81 elbowL=129.98 elbowR=134.20 hip_x=+23.45 unrest=0.180
PROBE32 refuse t=0.80 conf=85.0 gait=0 neck1=+6.60 tail1=-0.17 ear=+6.47 clip=Idle FFB=0.053/0.053 helmet=+10.73 head_x=+5.69 elbowL=127.99 elbowR=132.06 hip_x=+17.28 unrest=0.180
RIDECERT hk_beg_035 style=refuse_early success=true faults=4 jumped=8/8 t=69.89 teleported=false complete=true refused=[1] rail_fences=[] rail_air=[] conf=83.0 scope=82.5
FENCE knock 3 by horse at 9.0,-2.5 next=3 jumping=true
RIDECERT hk_beg_035 style=rail_late success=true faults=4 jumped=8/8 t=67.16 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=81.0
```

- **B:** refused fence 1, 0 rails, Idle, hinds 0.053 / 0.053, Neck1 +11.70, Tail1 −0.32, 69.89.
- **Her pose on the check:** unrest 0.180. The helmet is +10.73° at 0.80 s, heading for the pin's halt (+11.31), not day-one's (+14.76). Her elbows are the pin halt's (127.99 / 132.06).
- **C:** one rail, the knock on fence 3 with `jumping=true`, in the air, 67.16.

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
| hk_beg_034 | CLEAR | 0 | 8/8 | 63.5 | 100 | — |
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

Against the seat board, compared log to log: 25 id/style rows, faults and rails identical, 0 teleported, same 21/23. The largest move is **hk_int_007, 85.03 → 84.93 (0.10 s)**, back on the fold and halt boards' time. 0.10 s counts as within 0.1 s. Every other row moved ≤ 0.03 s (hk_beg_007 65.55 → 65.52). The fold and the counter stay.

## Playtest — headless `--playtest`, this run, after the board log was copied

```
PLAYTEST begin fences=8
PLAYTEST clear faults=0 complete=true
PLAYTEST refuse faults=4
PLAYTEST rail faults=4
PLAYTEST done pass=true
```
