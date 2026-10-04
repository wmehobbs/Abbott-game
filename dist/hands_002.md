# Her hands stay with him

## Step 0 — inventory, before any pose code

### The fists over fence 1, `hk_les_001`

Withers frame = `Bascule.withers` of the frame being drawn. Learned spot = `rider_mesh._hand_on_neck` at take-off, i.e. the target she learned on the last canter frame; "settled" = her wrist on the last settled canter frame before the jump. `w` = `_on_neck_weight`. Distances in m.

Pin (conf 85). Learned spot L (0.050, −0.376, 0.518), R (−0.050, −0.376, 0.518).

| u | w | L to spot | R to spot | L to settled | between the wrists |
| --- | ---: | ---: | ---: | ---: | ---: |
| 0.20 | 1.00 | 0.002 | 0.002 | 0.014 | 0.100 |
| 0.40 | 1.00 | 0.008 | 0.008 | 0.019 | 0.100 |
| 0.55 | 1.00 | 0.005 | 0.005 | 0.007 | 0.100 |
| 0.70 | 1.00 | 0.009 | 0.009 | 0.010 | 0.100 |
| 0.80 | 1.00 | 0.013 | 0.017 | 0.010 | 0.102 |

Day-one (conf 48). Same learned spot.

| u | w | L to spot | R to spot | L to settled | between the wrists |
| --- | ---: | ---: | ---: | ---: | ---: |
| 0.20 | 1.00 | 0.001 | 0.001 | 0.011 | 0.100 |
| 0.40 | 1.00 | 0.008 | 0.008 | 0.020 | 0.100 |
| 0.55 | 1.00 | 0.000 | 0.000 | 0.013 | 0.100 |
| 0.70 | 1.00 | 0.007 | 0.007 | 0.006 | 0.100 |
| 0.80 | 1.00 | **0.038** | **0.036** | 0.040 | 0.102 |

IK at u 0.55: shoulder-to-target 0.298 / 0.302 (pin), 0.296 / 0.300 (day-one), against a reach of 0.351 — the arm reaches.

Reading: the "0.13–0.15 m" of the last log was not the hold failing. Her two wrists are 0.100 m apart the whole jump, and on the pin horse each stays within 0.017 m of its learned spot from u 0.20 to 0.80. The same wrists measured against the *previous* frame's withers read 0.04–0.11 m — the old spread mixed frames. On the day-one horse the hold is good to u 0.70 and then leaves its spot by 0.038 / 0.036 m at u 0.80: that is a throw, and it is phase 1.

### Walk, trot, canter

`hk_les_001` walks and trots for less than one full steady stride on both horses (`gait=1` and `gait=2` "ended before one full steady stride"), so walk and trot come from one throwaway scene — stats set, gait set, two seconds, one stride measured after the modifiers — deleted after. The canter is from the ride and from the same scene.

| gait | horse | Neck1 | Tail1 | tail tip over withers | Ear1.L | poll | hand travel |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: |
| walk (scene) | pin | −4.52 | +0.21 | −0.465 | −11.46 | 0.560 | 0.017 |
| walk (scene) | day-one | +5.39 | −9.69 | −0.414 | −20.24 | 0.629 | 0.017 |
| trot (scene) | pin | −4.48 | +0.20 | −0.465 | −11.40 | 0.560 | 0.043 |
| trot (scene) | day-one | +5.41 | −9.70 | −0.414 | −20.22 | 0.630 | 0.043 |
| canter (ride) | pin | −15.39 | −0.81 | +0.132 | +5.37 | 0.419 | 0.093 |
| canter (ride) | day-one | −5.19 | −10.57 | +0.263 | −3.28 | 0.509 | 0.115 |
| canter (scene) | pin | −15.25 | −0.74 | +0.133 | +5.47 | 0.419 | 0.077 |
| canter (scene) | day-one | −5.40 | −10.67 | +0.269 | −3.36 | 0.506 | 0.103 |

The kept canter picture is intact (neck 10.2°, tail 9.8°, hands 2.2 cm in the ride). At the walk and the trot the horse already carries it — neck 9.9°, tail 9.9° — and her hands are identical (0.017 / 0.017, 0.043 / 0.043): those are the open columns, phase 2.

### One half-halt

The deepest sit (lowest speed while `collect_pulse` runs) of the first two half-halts at the canter, `hk_les_001`. Wrists against their last settled canter position, m.

| horse | sit | speed | Neck1 | Tail1 | wrist L | wrist R |
| --- | --- | ---: | ---: | ---: | ---: | ---: |
| pin | 1 | 1.58 | −21.76 | −4.58 | 0.015 | 0.014 |
| pin | 2 | 1.92 | −24.72 | −5.87 | 0.130 | 0.130 |
| day-one | 1 | 1.58 | −11.86 | −14.48 | 0.018 | 0.018 |
| day-one | 2 | 1.92 | −14.82 | −15.77 | 0.127 | 0.127 |

At the sit the day-one neck is still 9.9° higher than the pin's: the half-halt does not erase the head. Phase 3 is not needed. (The second sit's 0.13 m is her own half-halt seat — upright, hands back — the same on both horses.)

## Phase 1 — the release: a written negative, no code

`rider_mesh.gd` is unchanged. The day-one wrist leaves its learned spot late in the jump, but by an amount that moves from run to run: the inventory ride has it 0.038 / 0.036 m off the spot at u 0.80; a later day-one ride (`dist/ridecert_fresh.log`) has it 0.026 m off at u 0.70 and 0.016 / 0.020 m at u 0.80. It is a few centimetres, it is not the same between runs, and holding it would mean moving her arm or her seat — both ruled out. Left.

The hold's target is already the learned spot there (`_on_neck_weight` 1.00 to u 0.85). A third day-one ride printed the arm at the u where the wrist leaves; its lines, copied from that ride's log:

```
PROBE41 u=0.70(at 0.702) w=1.00 hip=-34.9 dL_spot=0.007 dR_spot=0.007 between=0.100 L_sh2tgt=0.329 reach=0.351 wrist2tgt=0.006 R_sh2tgt=0.333 reach=0.351 wrist2tgt=0.006
PROBE41 u=0.75(at 0.762) w=1.00 hip=-32.2 dL_spot=0.035 dR_spot=0.035 between=0.100 L_sh2tgt=0.327 reach=0.351 wrist2tgt=0.030 R_sh2tgt=0.331 reach=0.351 wrist2tgt=0.030
PROBE41 u=0.78(at 0.786) w=1.00 hip=-31.2 dL_spot=0.010 dR_spot=0.014 between=0.101 L_sh2tgt=0.359 reach=0.351 wrist2tgt=0.008 R_sh2tgt=0.362 reach=0.351 wrist2tgt=0.012
PROBE41 u=0.80(at 0.810) w=1.00 hip=-30.2 dL_spot=0.019 dR_spot=0.023 between=0.105 L_sh2tgt=0.367 reach=0.351 wrist2tgt=0.016 R_sh2tgt=0.370 reach=0.351 wrist2tgt=0.020
PROBE41 u=0.82(at 0.821) w=1.00 hip=-29.6 dL_spot=0.023 dR_spot=0.028 between=0.106 L_sh2tgt=0.370 reach=0.351 wrist2tgt=0.020 R_sh2tgt=0.374 reach=0.351 wrist2tgt=0.023
PROBE41 u=0.85(at 0.857) w=0.99 hip=-28.0 dL_spot=0.034 dR_spot=0.038 between=0.111 L_sh2tgt=0.379 reach=0.351 wrist2tgt=0.029 R_sh2tgt=0.383 reach=0.351 wrist2tgt=0.032
PROBE41 u=0.90(at 0.905) w=0.70 hip=-25.9 dL_spot=0.041 dR_spot=0.045 between=0.110 L_sh2tgt=0.385 reach=0.351 wrist2tgt=0.035 R_sh2tgt=0.388 reach=0.351 wrist2tgt=0.038
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true (--ridecert-fresh)
```

The later fresh ride, `dist/ridecert_fresh.log`, its fist lines:

```
PROBE41 u=0.20 w=1.00 dL_spot=0.001 dR_spot=0.002 between=0.100
PROBE41 u=0.40 w=1.00 dL_spot=0.008 dR_spot=0.008 between=0.100
PROBE41 u=0.55 w=1.00 dL_spot=0.003 dR_spot=0.003 between=0.100 L_shoulder_to_target=0.298 reach=0.351 R_shoulder_to_target=0.302 reach=0.351
PROBE41 u=0.70 w=1.00 dL_spot=0.026 dR_spot=0.026 between=0.100
PROBE41 u=0.80 w=1.00 dL_spot=0.016 dR_spot=0.020 between=0.104
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.52 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=54.
```

## The three clocks, walk and trot terms in (`horse.gd` `_update_rider`, gait 1 and gait 2 only)

Pin rides, one at a time, each line copied from its own log before the next id:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.61 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=93.99 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All three inside the keep. Every pin round started at conf 85.

## Style, once, `--ridecert-style --ridecert-id=hk_beg_035` (probe on the refusal only)

```
PROBE32 refuse t=0.25 conf=85.0 neck1=+11.71 tail1=-0.32 ear=+7.65 clip=Idle FFB=0.053/0.053
RIDECERT hk_beg_035 style=refuse_early success=true faults=4 jumped=8/8 t=69.87 teleported=false complete=true refused=[1] rail_fences=[] rail_air=[] conf=83.0 scope=82.5
FENCE knock 3 by horse at 9.0,-2.5 next=3 jumping=true
RIDECERT hk_beg_035 style=rail_late success=true faults=4 jumped=8/8 t=67.17 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=81.0
```

B refused fence 1, 0 rails, Idle, hinds 0.053 / 0.053 at 0.25 s, Neck1 +11.71 and Tail1 −0.32 — the pin's check, not the day-one headset. C one rail on fence 3 in the air. The style run rides B and C; A is the plain round, on the board below.

## After the walk and trot terms

One throwaway scene (stats set, gait set, two seconds, one stride measured after the modifiers), deleted after. Same columns as the inventory, plus the lowest hoof over the stride (contact 0.053).

| gait | horse | Neck1 | Tail1 | tail tip over withers | Ear1.L | poll | hand travel | lowest hoof |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| walk | pin | −4.51 | +0.21 | −0.465 | −11.44 | 0.560 | 0.029 | 0.052 |
| walk | day-one | +5.40 | −9.69 | −0.414 | −20.24 | 0.629 | 0.056 | 0.052 |
| trot | pin | −4.49 | +0.20 | −0.465 | −11.42 | 0.560 | 0.055 | 0.052 |
| trot | day-one | +5.41 | −9.69 | −0.414 | −20.22 | 0.630 | 0.081 | 0.052 |
| canter | pin | −15.26 | −0.75 | +0.133 | +5.46 | 0.419 | 0.078 | 0.053 |
| canter | day-one | −5.35 | −10.64 | +0.268 | −3.34 | 0.506 | 0.103 | 0.053 |

Hand travel difference: walk **2.7 cm** (inventory 0.0), trot **2.6 cm** (inventory 0.0), canter 2.5 cm. Neck and tail unchanged at every gait (9.9° / 9.9°). No hoof goes under the sand or lifts off it. The terms: gait 1 `pitch += w × 10° × unrest`, `rest.y += w × 0.050 × unrest`; gait 2 `pitch += sin(stride) × 14° × unrest`, `rest.y += sin(stride) × 0.070 × unrest`, on top of the post — the posting constants untouched. A first try at twice the stride rate (6° / 0.03 m walk, 9° / 0.045 m trot) moved her hands only 0.6 cm and 0.2 cm: her body eases in over ~0.4 s and filtered it out.

## Board — one full `--ridecert`, `board_table.py`

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

Against this morning's floor: worst |Δ| 0.02 s (`hk_beg_034`), no new rail, teleported=false. `--playtest` PASS: clear 0 / refuse 4 / rail 4.
