# He gets quieter — the horse's stats in the picture

## Step 0 — what the stats do now (before any pose code)

From the source:

| stat | read by | what it changes | any bone or camera? |
| --- | --- | --- | --- |
| confidence | `GameState.refuse_scale()` (the lined/refusal window), `Horse._might_look()` (the flower spook, p = (48 − c)/140), barn-note text | whether he refuses or looks | **no** |
| scope | `GameState.scope_bonus()` → `jump_apex` in `_begin_jump` | how high he jumps | **no** |
| rideability | `GameState.turn_scale()` → turn rate (horse, ride_ai lead) | how he turns | **no** |
| timing | barn-note text only | nothing in the ride | **no** |
| feel | `GameState.balance_need()` / `charge_need()` → the leave's balance threshold | whether an off-spot leave is a rail | **no** |

`horse.gd`, `bascule.gd`, `rider_mesh.gd` and `_place_cam` never read any of the five.

Two headless `hk_les_001`, one settled canter stride each (canter, not in the air, no land_recover, no half-halt pulse), averaged over the stride. Neck1, Tail1, Tail3, Ear1.L: degrees against rest. Poll: Head y minus Torso3 y (m). Hand travel: the extent of her left wrist over the stride in the withers frame (m). The skeleton has ears (Ear1.L … Ear4.L / .R) and a tail (Tail1 … Tail7).

| ride | stats at the start of the round | Neck1 | Tail1 | Tail3 | Ear1.L | poll | hand travel |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: |
| pin (`--ridecert-id`) | conf 85, scope 80, ride 44, timing 38, feel 36 | −15.15 | −0.71 | −61.17 | +5.57 | 0.422 | 0.079 |
| pin, next stride | | −15.41 | −0.84 | −61.38 | +5.44 | 0.447 | 0.076 |
| day-one (`--ridecert-fresh`) | conf 48, scope 40, ride 44, timing 38, feel 36 | −15.29 | −0.75 | −61.17 | +5.43 | 0.420 | 0.083 |
| day-one, next stride | | −15.45 | −0.88 | −61.47 | +5.39 | 0.447 | 0.073 |

That is the gap: the two horses look the same. Both rides clear (pin 18.54, fresh 18.53); the fresh round ends schooled at conf 54, and the next pin round starts at 85 again — no leak.


## After the change

`bascule.gd`: worry = clamp((70 − confidence) / 40, 0, 1) raises Neck1 (+18° × worry), lifts Tail1 (the tail tip up) and pricks both Ear1 forward, on the ground only — faded out by u 0.30 of a jump (the crest is identical at any confidence: round +15.0, Neck1 −21.4, fore cannon −30.2 on the day-one horse too) and faded back in over the first 0.5 s of the recover. `horse.gd` `_update_rider`: her canter rock gets more bounce with 0.7 × worry + 0.3 × (low feel), so her hands travel more on a worried horse or with a green seat; on a jump her fists are on the withers anchor as before. Neither file writes a stat; the pin horse (worry 0) keeps his neck, tail and ears.

### The two canters (settled stride, two strides each)

| ride | stats at the start | Neck1 | Tail1 | tail tip over withers | Ear1.L | poll | hand travel |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: |
| pin `--ridecert-id=hk_les_001` | conf 85, scope 80, ride 44, timing 38, feel 36 | −15.24 / −15.44 | −0.70 / −0.86 | +0.126 / +0.066 | +5.41 / +5.38 | 0.420 / 0.447 | 0.090 / 0.085 |
| day-one `--ridecert-fresh --ridecert-id=hk_les_001` | conf 48, scope 40, ride 44, timing 38, feel 36 | −5.20 / −5.38 | −10.53 / −10.70 | +0.257 / +0.205 | −3.28 / −3.20 | 0.509 / 0.533 | 0.121 / 0.114 |
| difference | | **10.0° higher** | **9.8°**, tail up | +0.13 m | **8.6° forward** | +0.087 m | **3.0 cm more** |

### A clear changes him — one scene, not the cert, two seconds of canter per row, then deleted

| row | stats (source) | Neck1 | Tail1 | tail tip | Ear1.L | poll | hand travel |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: |
| day-one | 48 / 40 / 44 / 38 / 36 (`_day_one`) | −5.37 | −10.65 | +0.268 | −3.35 | 0.506 | 0.103 |
| after a clear | 54.0 / 44.5 / 48.0 / 42.0 / 39.0 (written by `--ridecert-fresh --ridecert-id=hk_beg_035`: `ridecert_fresh_one.json` conf 54.0, scope 44.5; the save it wrote for the rest) | **−8.02** | **−7.94** | +0.232 | −0.90 | 0.484 | **0.094** |
| after a refusal | 46.0 / 42.5 / 44.0 / 40.0 / 37.0 (`_school_from_round`, one refusal, 4 faults, no rail) | **−4.42** | **−11.52** | +0.278 | −4.13 | 0.514 | **0.104** |
| pin, same scene | 85 / 80 / 44 / 38 / 36 | −15.26 | −0.75 | +0.133 | +5.45 | 0.419 | 0.078 |

Monotone in confidence: after a clear the neck is lower, the tail quieter and the hands travel less than day-one; after a refusal all three go the other way. The hoof plant still wins (bones touched are Neck1, Tail1, Ear1 only). Fists in the air spread 0.13–0.15 m in the withers frame on both horses between u 0.20 and 0.80 — the same as on this morning's floor files (0.15–0.22), so it is not this change; recorded, not chased.

### The pin is still the pin

Clocks: 18.52 / 91.60 / 94.00 after the change, and 18.53 / 91.61 / 93.99 again after the scene. Every pin round starts at conf 85 — a fresh round before it (which ends schooled at 54) does not leak. Style: B refused fence 1, 0 rails, Idle, hinds 0.053 / 0.053, and at conf 85 his check is Neck1 +11.72, Tail1 −0.31 — the check he had before, no day-one head set; C one rail on fence 3 in the air.

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

Against the floor: worst |Δ| 0.02 s (`hk_int_009`), no new rail, teleported=false. `--playtest` PASS: clear 0 / refuse 4 / rail 4. The board wrapper was stopped for memory; its Godot rode to `RIDECERT done` and `ridecert_results.json` was copied onto `ridecert_board.json` after that line.
