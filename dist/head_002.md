# Her head at the trot

## Step 0 — the nod, no pose code

One throwaway scene (`game/tools/probe_quiet.gd`, deleted after; stats set, gait set, two seconds, one settled stride sampled on `skeleton_updated`). Pin = conf 85 / scope 80 / ride 44 / timing 38 / feel 36; day-one = 48 / 40 / 44 / 38 / 36. Helmet pitch = the angle of her `Head` bone (the Cap sits on it) against her `Chest` bone (her shoulders), in the horse's side plane. Commanded head_x = `rider_head.rotation_degrees.x` over the stride. Hands = wrist travel in the withers frame; head bone = travel of the `Head` bone origin; Ear4.L tip in the horse's Head frame, m.

| gait | horse | helmet pitch vs shoulders p2p (°) | mean (°) | head_x p2p (°) | hands | head bone | helmet crown | Ear1.L | Ear4.L tip (head frame) | lowest hoof |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | --- | ---: |
| walk | pin | 0.64 | −7.90 | 1.42 | 0.029 | 0.040 | 0.047 | −11.44 | (−0.109, −0.098, +0.202) | 0.052 |
| walk | day-one | 0.64 | −7.90 | 1.42 | 0.056 | 0.076 | 0.092 | −20.24 | (−0.108, −0.044, +0.217) | 0.052 |
| trot | pin | 1.48 | −7.12 | 3.29 | 0.055 | 0.101 | 0.115 | −11.42 | (−0.109, −0.098, +0.202) | 0.052 |
| trot | day-one | 1.48 | −7.12 | 3.30 | 0.081 | 0.101 | 0.105 | −20.22 | (−0.108, −0.044, +0.217) | 0.052 |
| canter | pin | 0.68 | −5.21 | 1.52 | 0.078 | 0.108 | 0.127 | +5.45 | (−0.110, −0.163, +0.111) | 0.053 |
| canter | day-one | 0.68 | −5.20 | 1.53 | 0.103 | 0.146 | 0.171 | −3.44 | (−0.111, −0.135, +0.151) | 0.053 |

Copied from the scene:

```
pin-walk gait=1 neck1=-4.51 tail1=+0.21 ear=-11.44 hand_travel=0.029 eartip_head=(-0.109,-0.098,+0.202) head_travel=0.040 helmet_travel=0.047 nod_p2p=0.64 nod_mean=-7.90 headx_p2p=1.42 lowest_hoof=0.052 frames=239
dayone-walk gait=1 neck1=+5.39 tail1=-9.69 ear=-20.24 hand_travel=0.056 eartip_head=(-0.108,-0.044,+0.217) head_travel=0.076 helmet_travel=0.092 nod_p2p=0.64 nod_mean=-7.90 headx_p2p=1.42 lowest_hoof=0.052 frames=239
pin-trot gait=2 neck1=-4.49 tail1=+0.21 ear=-11.42 hand_travel=0.055 eartip_head=(-0.109,-0.098,+0.202) head_travel=0.101 helmet_travel=0.115 nod_p2p=1.48 nod_mean=-7.12 headx_p2p=3.29 lowest_hoof=0.052 frames=164
dayone-trot gait=2 neck1=+5.41 tail1=-9.69 ear=-20.22 hand_travel=0.081 eartip_head=(-0.108,-0.044,+0.217) head_travel=0.101 helmet_travel=0.105 nod_p2p=1.48 nod_mean=-7.12 headx_p2p=3.30 lowest_hoof=0.052 frames=164
pin-canter gait=3 neck1=-15.27 tail1=-0.75 ear=+5.45 hand_travel=0.078 eartip_head=(-0.110,-0.163,+0.111) head_travel=0.108 helmet_travel=0.127 nod_p2p=0.68 nod_mean=-5.21 headx_p2p=1.52 lowest_hoof=0.053 frames=120
dayone-canter gait=3 neck1=-5.50 tail1=-10.71 ear=-3.44 hand_travel=0.103 eartip_head=(-0.111,-0.135,+0.151) head_travel=0.146 helmet_travel=0.171 nod_p2p=0.68 nod_mean=-5.20 headx_p2p=1.53 lowest_hoof=0.053 frames=117
```

Reading:

- The nod. At every gait her helmet pitches against her shoulders by exactly the same amount on both horses (trot 1.48° / 1.48°; head_x 3.29° / 3.30°). Her hands differ by 2.6 cm at the trot, her head not at all: the trot unrest moves her whole body, never her head on her neck. **0° apart, under 4°: phase 1 is the job.**
- The ear. Ear4.L tip at the canter, pin against day-one, is (0.001, 0.028, 0.040) apart = **4.9 cm, not under 4 cm: phase 2 is the table**, no Ear2 bend.
- Arithmetic for phase 1: the helmet follows 0.45 of head_x (`rider_mesh._pose_head`), and head_x is smoothed by `k = 1 − 0.10^delta`, which passes 0.289 of the trot stride (11.4° commanded post/sit, 3.29° reached). `_hand_unrest()` is 0.18 on the pin and 0.565 on day-one (feel 36 on both; tension 0 / 0.55). A line `head_x += swing * K * trot_unrest` then adds 0.45 × 0.289 × 2K × 0.385 ≈ 0.100·K degrees more nod on day-one: K = 40 is the floor, one attempt at K = 48 (≈ 4.8°).

## Phase 1 — her head nods at the trot (`horse.gd`, gait 2 only)

One line after the trot pitch/rest unrest lines, the same shape: `head_x += swing * 48.0 * trot_unrest`. Post × 8.4, pitch, rest, the walk and the canter untouched.

The scene right after, same columns:

| gait | horse | helmet pitch vs shoulders p2p (°) | head_x p2p (°) | hands | head bone | Neck1 | Tail1 | lowest hoof |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| walk | pin | 0.64 | 1.41 | 0.029 | 0.039 | −4.55 | +0.21 | 0.052 |
| walk | day-one | 0.64 | 1.42 | 0.056 | 0.076 | +5.39 | −9.69 | 0.052 |
| trot | pin | **3.67** | 8.15 | 0.055 | 0.101 | −4.50 | +0.21 | 0.052 |
| trot | day-one | **8.39** | 18.64 | 0.081 | 0.101 | +5.41 | −9.70 | 0.052 |
| canter | pin | 0.68 | 1.52 | 0.078 | 0.108 | −15.26 | −0.74 | 0.053 |
| canter | day-one | 0.68 | 1.52 | 0.103 | 0.145 | −5.33 | −10.63 | 0.053 |

```
pin-walk gait=1 neck1=-4.55 tail1=+0.21 ear=-11.50 hand_travel=0.029 eartip_head=(-0.109,-0.098,+0.202) head_travel=0.039 helmet_travel=0.047 nod_p2p=0.64 nod_mean=-7.90 headx_p2p=1.41 lowest_hoof=0.052 frames=236
dayone-walk gait=1 neck1=+5.39 tail1=-9.69 ear=-20.24 hand_travel=0.056 eartip_head=(-0.108,-0.044,+0.217) head_travel=0.076 helmet_travel=0.092 nod_p2p=0.64 nod_mean=-7.90 headx_p2p=1.42 lowest_hoof=0.052 frames=239
pin-trot gait=2 neck1=-4.50 tail1=+0.21 ear=-11.43 hand_travel=0.055 eartip_head=(-0.109,-0.098,+0.202) head_travel=0.101 helmet_travel=0.110 nod_p2p=3.67 nod_mean=-7.11 headx_p2p=8.15 lowest_hoof=0.052 frames=164
dayone-trot gait=2 neck1=+5.41 tail1=-9.70 ear=-20.22 hand_travel=0.081 eartip_head=(-0.108,-0.044,+0.217) head_travel=0.101 helmet_travel=0.100 nod_p2p=8.39 nod_mean=-7.09 headx_p2p=18.64 lowest_hoof=0.052 frames=164
pin-canter gait=3 neck1=-15.26 tail1=-0.74 ear=+5.45 hand_travel=0.078 eartip_head=(-0.110,-0.163,+0.111) head_travel=0.108 helmet_travel=0.127 nod_p2p=0.68 nod_mean=-5.20 headx_p2p=1.52 lowest_hoof=0.053 frames=120
dayone-canter gait=3 neck1=-5.33 tail1=-10.63 ear=-3.34 hand_travel=0.103 eartip_head=(-0.111,-0.135,+0.151) head_travel=0.145 helmet_travel=0.170 nod_p2p=0.68 nod_mean=-5.21 headx_p2p=1.52 lowest_hoof=0.053 frames=119
```

Against the rows: trot helmet pitch **4.72° more on day-one** (8.39 / 3.67; was 1.48 / 1.48) ✓ ≥ 4°. Trot hands 0.055 / 0.081 ✓ (0.0 cm off). Walk head 0.039 / 0.076 = 3.7 cm ✓, walk hands 2.7 cm ✓. Lowest hoof 0.052–0.053 ✓. Canter Neck1 9.93° apart, Tail1 9.89° apart ✓. The pin's trot nod also grows (1.48 → 3.67°): feel 36 gives him unrest 0.18 too. Mean head pitch unchanged (−7.11 / −7.09 against −7.12). Kept.

## Phase 2 — the ear: the table

The Ear4.L tip at the canter is already 4.9 cm apart in the horse's head frame (step 0: pin (−0.110, −0.163, +0.111), day-one (−0.111, −0.135, +0.151)). Not under 4 cm, so there is no Ear2 bend. `bascule.gd` is untouched.

## Clocks (phase 1 in), copied from their logs

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.6 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=94.02 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.54 (18.50–18.60, 0 faults, 0 rails), 91.60 (91.51–91.67, 2, 0), 94.02 (93.91–94.07, 3, 0); teleported=false, complete.

## Style, once, `--ridecert-style --ridecert-id=hk_beg_035`

```
RIDECERT hk_beg_035 style=refuse_early success=true faults=4 jumped=8/8 t=69.89 teleported=false complete=true refused=[1] rail_fences=[] rail_air=[] conf=83.0 scope=82.5
RIDECERT hk_beg_035 style=rail_late success=true faults=4 jumped=8/8 t=67.17 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=81.0
```

B refused fence 1, 4 faults, 0 rails, 69.89 (last 69.87); C 4 faults, 67.17 (last 67.17).

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

Against this job's floor (`board_floor.json`, taken before any code): 26 rows, worst |Δ| **0.02 s** (`hk_int_001`), no rail changed, 0 teleported. Same 21/23; the two fails are the known adv time faults.

## Playtest — headless `--playtest`, this run

```
PLAYTEST begin fences=8
PLAYTEST clear faults=0 complete=true
PLAYTEST refuse faults=4
PLAYTEST rail faults=4
PLAYTEST done pass=true
```
