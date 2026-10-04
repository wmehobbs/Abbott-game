# She still shows him when she stands up

## Step 0 — fence 1 of hk_les_001, both horses, one probe, before any coefficient

One probe in `horse.gd`, stripped before any timed clock; the tree is the halt board's.

- **The rides:** pin `--ridecert-id=hk_les_001` (writes `ridecert_godot.log`), then day-one `--ridecert-fresh --ridecert-id=hk_les_001` (writes `ridecert_fresh.log`).
- **Targets:** `pitch`, `hip_x`, `head_x` exactly as `_update_rider` is about to ease toward them.
- **The eased pose she shows:** `rider_body` x, `rider_lleg` x, `rider_head` x.
- **Her rider channels:** the helmet (Head against Chest, the halt job's angle), the elbows (the angle at LowerArm), and each fist's distance to the target the IK uses (the neck spot, lerped by `_on_neck_weight`, in the air).
- **His channels:** last_stride, `_hand_unrest()`, confidence, and his Neck1 against rest, read after the modifiers.
- **Sampling:** on `skeleton_updated`.

Pin:

```
FOLD two-point fence=1 conf=85.0 unrest=0.180 last_stride=1.000 land_recover=0.000 jumping=false u=-1.000 neck1=-10.38 target pitch=-37.74 hip=+41.25 head=+21.90 eased pitch=-39.41 hip=+26.41 head=+31.79 helmet=-1.01 elbowL=130.83 elbowR=135.11 fistL=0.0000 fistR=0.0000
FOLD first-jump-frame fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=0.000 jumping=true u=0.000 neck1=-10.38 target pitch=-37.74 hip=+41.25 head=+21.90 eased pitch=-39.41 hip=+26.41 head=+31.79 helmet=-1.01 elbowL=130.83 elbowR=135.11 fistL=0.0000 fistR=0.0000
FOLD air-0.20 fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=0.000 jumping=true u=0.202 neck1=-5.18 target pitch=-40.01 hip=+26.01 head=+24.03 eased pitch=-40.12 hip=+26.65 head=+28.97 helmet=+0.26 elbowL=136.00 elbowR=140.74 fistL=0.0000 fistR=0.0000
FOLD air-0.55 fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=0.000 jumping=true u=0.560 neck1=-21.44 target pitch=-34.00 hip=+22.00 head=+18.00 eased pitch=-37.49 hip=+24.50 head=+22.99 helmet=+2.95 elbowL=100.01 elbowR=103.40 fistL=0.0002 fistR=0.0002
FOLD air-0.85 fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=0.000 jumping=true u=0.857 neck1=-51.07 target pitch=-14.01 hip=+18.00 head=+10.01 eased pitch=-28.01 hip=+21.51 head=+17.01 helmet=+5.64 elbowL=158.79 elbowR=171.15 fistL=0.0040 fistR=0.0040
FOLD sit fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=2.720 jumping=false u=-1.000 neck1=-34.15 target pitch=+2.00 hip=+20.00 head=+6.00 eased pitch=-19.09 hip=+20.58 head=+13.42 helmet=+7.25 elbowL=129.98 elbowR=134.21 fistL=0.0000 fistR=0.0000
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
```

Day-one (fresh):

```
FOLD two-point fence=1 conf=48.0 unrest=0.565 last_stride=1.000 land_recover=0.000 jumping=false u=-1.000 neck1=-0.78 target pitch=-33.43 hip=+48.03 head=+2.18 eased pitch=-40.07 hip=+25.43 head=+34.10 helmet=-2.05 elbowL=132.67 elbowR=137.06 fistL=0.0000 fistR=0.0000
FOLD first-jump-frame fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=0.000 jumping=true u=0.000 neck1=-0.78 target pitch=-33.43 hip=+48.03 head=+2.18 eased pitch=-40.07 hip=+25.43 head=+34.10 helmet=-2.05 elbowL=132.67 elbowR=137.06 fistL=0.0000 fistR=0.0000
FOLD air-0.20 fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=0.000 jumping=true u=0.202 neck1=-2.72 target pitch=-40.01 hip=+26.01 head=+24.03 eased pitch=-40.49 hip=+26.14 head=+30.27 helmet=-0.33 elbowL=138.89 elbowR=143.94 fistL=0.0000 fistR=0.0000
FOLD air-0.55 fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=0.000 jumping=true u=0.560 neck1=-21.44 target pitch=-34.00 hip=+22.00 head=+18.00 eased pitch=-37.66 hip=+24.39 head=+23.48 helmet=+2.73 elbowL=102.82 elbowR=106.24 fistL=0.0002 fistR=0.0002
FOLD air-0.85 fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=0.000 jumping=true u=0.857 neck1=-51.07 target pitch=-14.01 hip=+18.00 head=+10.01 eased pitch=-28.06 hip=+21.45 head=+17.16 helmet=+5.57 elbowL=172.41 elbowR=172.50 fistL=0.0049 fistR=0.0091
FOLD sit fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=2.720 jumping=false u=-1.000 neck1=-34.20 target pitch=+2.00 hip=+20.00 head=+6.00 eased pitch=-19.17 hip=+20.54 head=+13.52 helmet=+7.21 elbowL=129.98 elbowR=134.20 fistL=0.0000 fistR=0.0000
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=54.0 scope=44.5
```

The `first-jump-frame` line repeats the frame-before targets: that skeleton update runs in the physics step, before `_update_rider`. It is not used. The two-point sample is the frame before the leave.

| sample | horse | conf / unrest | last_stride | his Neck1 | target pitch / hip / head | eased pitch | eased hip | eased head | helmet | elbow L / R | fist L / R (m) |
| --- | --- | --- | ---: | ---: | --- | ---: | ---: | ---: | ---: | --- | --- |
| two-point (frame before fence 1 leaves) | pin | 85.0 / 0.180 | 1.000 | −10.38 | −37.74 / 41.25 / 21.90 | −39.41 | 26.41 | 31.79 | −1.01 | 130.83 / 135.11 | 0.000 / 0.000 |
| | day-one | 48.0 / 0.565 | 1.000 | −0.78 | −33.43 / 48.03 / 2.18 | −40.07 | 25.43 | 34.10 | −2.05 | 132.67 / 137.06 | 0.000 / 0.000 |
| air u 0.20 | pin | 0.180 | | −5.18 | −40.01 / 26.01 / 24.03 | −40.12 | 26.65 | 28.97 | +0.26 | 136.00 / 140.74 | 0.000 / 0.000 |
| | day-one | 0.565 | | −2.72 | −40.01 / 26.01 / 24.03 | −40.49 | 26.14 | 30.27 | −0.33 | 138.89 / 143.94 | 0.000 / 0.000 |
| air u 0.55 | pin | 0.180 | | −21.44 | −34.00 / 22.00 / 18.00 | −37.49 | 24.50 | 22.99 | +2.95 | 100.01 / 103.40 | 0.000 / 0.000 |
| | day-one | 0.565 | | −21.44 | −34.00 / 22.00 / 18.00 | −37.66 | 24.39 | 23.48 | +2.73 | 102.82 / 106.24 | 0.000 / 0.000 |
| air u 0.85 | pin | 0.180 | | −51.07 | −14.01 / 18.00 / 10.01 | −28.01 | 21.51 | 17.01 | +5.64 | 158.79 / 171.15 | 0.004 / 0.004 |
| | day-one | 0.565 | | −51.07 | −14.01 / 18.00 / 10.01 | −28.06 | 21.45 | 17.16 | +5.57 | 172.41 / 172.50 | 0.005 / 0.009 |
| sit (first frame, land_recover 2.72, last_stride 0) | pin | 0.180 | 0.000 | −34.15 | +2.00 / 20.00 / 6.00 | −19.09 | 20.58 | 13.42 | +7.25 | 129.98 / 134.21 | 0.000 / 0.000 |
| | day-one | 0.565 | 0.000 | −34.20 | +2.00 / 20.00 / 6.00 | −19.17 | 20.54 | 13.52 | +7.21 | 129.98 / 134.20 | 0.000 / 0.000 |

Reading:

- **The two-point is flat.**
  - On the eased pose, day-one is 0.66° off the pin in pitch, 0.98° in hip and 1.04° in the helmet, while his Neck1 is 9.60° higher.
  - The day-one targets differ (head 2.18 against 21.90) only because the canter nod is on its rock at that instant; the eased head is 2.3° apart. **Phase 1 is the job.**
- **u 0.55 is flat:** 0.17° pitch, 0.11° hip, 0.22° helmet. The key targets are identical numbers on both horses. The pin crest reads Neck1 −21.44 on both.
- **The sit exists and is flat.** The first frame is the landing frame itself (land_recover 2.72, last_stride 0), with a 0.08° / 0.04° / 0.04° spread. Its targets (2 / 20 / 6) carry no unrest, and she enters it from the same key on both horses, so it stays flat for as long as she sits. **Phase 2 is the job.**
- **The elbows at u 0.55 are 2.81° (L) and 2.84° (R) apart.**
  - That is not "already showing" (4°) and not "within 1°", so **phase 3's gate is not met**. Phase 3 is a written negative, with no term.
  - The difference is the day-one spot learned on the neck, carried into the air.
- **Fists:** within 1 cm at u 0.20, 0.55 and 0.85 on both horses. The largest is 0.0091 m (day-one R at u 0.85), where both her arms are near straight (172.4° / 172.5°): the late fist, a standing negative.
- **Ratio for phase 1** (pin rows): the helmet moves −0.450° per degree of eased head_x. From the two-point to the sit, (7.25 − (−1.01)) / (13.42 − 31.79) = −0.450, which is `rider_mesh._pose_head`'s 0.45.

## Phase 1 — the two-point, and the first key with it (`horse.gd`)

`const FOLD_HEAD := 30.0`. One share, `head_x -= FOLD_HEAD * _hand_unrest()`, in two places:

- **The two-point:** right after the last_stride lerp (`head_x = lerpf(head_x, 28.0, s)`), scaled by `s` = last_stride, only when gait ≥ 1.
- **The arc:** after the jump key interpolation, at 1, held through the arc.

At last_stride 1 the two-point and u 0 carry the same share on the same frame. The keys are unchanged. It does not run at gait 0 (the `gait >= 1` guard), and it does not run in the sit, where last_stride ≤ 0.20 so the lerp block is skipped.

**Why 30:**

- The step-0 pin rows give −0.450° of helmet per degree of eased head_x. The share is K × (0.565 − 0.180) = 0.385 K degrees of head on day-one over the pin, so the helmet gap is 0.173 K once the ease has arrived.
- On the frame before the leave the eased head had not reached its target in step 0 (31.79 against a target of 21.90), so K is set for about 60 % arrival: 0.6 × 0.173 × 30 ≈ 3.1°.
- The pin moves 0.45 × 30 × 0.18 = 2.4° at most, under 4°.

After, pin:

```
FOLD two-point fence=1 conf=85.0 unrest=0.180 last_stride=1.000 land_recover=0.000 jumping=false u=-1.000 neck1=-10.68 target pitch=-37.74 hip=+41.25 head=+16.50 eased pitch=-39.53 hip=+26.14 head=+27.43 helmet=+0.95 elbowL=130.83 elbowR=135.11 fistL=0.0000 fistR=0.0000
FOLD air-0.20 fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=0.000 jumping=true u=0.202 neck1=-5.18 target pitch=-40.01 hip=+26.01 head=+18.63 eased pitch=-40.23 hip=+26.54 head=+24.02 helmet=+2.49 elbowL=137.37 elbowR=142.25 fistL=0.0000 fistR=0.0000
FOLD air-0.55 fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=0.000 jumping=true u=0.560 neck1=-21.44 target pitch=-34.00 hip=+22.00 head=+12.60 eased pitch=-37.49 hip=+24.45 head=+17.76 helmet=+5.30 elbowL=101.07 elbowR=104.47 fistL=0.0002 fistR=0.0002
FOLD air-0.85 fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=0.000 jumping=true u=0.857 neck1=-51.07 target pitch=-14.01 hip=+18.00 head=+4.61 eased pitch=-27.78 hip=+21.42 head=+11.53 helmet=+8.11 elbowL=164.74 elbowR=172.43 fistL=0.0039 fistR=0.0056
FOLD sit fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=2.720 jumping=false u=-1.000 neck1=-33.99 target pitch=+2.00 hip=+20.00 head=+0.60 eased pitch=-18.51 hip=+20.52 head=+7.82 helmet=+9.77 elbowL=129.98 elbowR=134.20 fistL=0.0000 fistR=0.0000
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
```

After, day-one:

```
FOLD two-point fence=1 conf=48.0 unrest=0.565 last_stride=1.000 land_recover=0.000 jumping=false u=-1.000 neck1=-1.05 target pitch=-33.43 hip=+48.03 head=-14.77 eased pitch=-39.96 hip=+25.53 head=+19.33 helmet=+4.59 elbowL=132.67 elbowR=137.05 fistL=0.0000 fistR=0.0000
FOLD air-0.20 fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=0.000 jumping=true u=0.202 neck1=-2.72 target pitch=-40.01 hip=+26.01 head=+7.08 eased pitch=-40.42 hip=+26.20 head=+14.19 helmet=+6.91 elbowL=138.84 elbowR=143.89 fistL=0.0000 fistR=0.0000
FOLD air-0.55 fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=0.000 jumping=true u=0.560 neck1=-21.44 target pitch=-34.00 hip=+22.00 head=+1.05 eased pitch=-37.61 hip=+24.38 head=+6.82 helmet=+10.22 elbowL=102.47 elbowR=105.89 fistL=0.0002 fistR=0.0002
FOLD air-0.85 fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=0.000 jumping=true u=0.857 neck1=-51.07 target pitch=-14.01 hip=+18.00 head=-6.94 eased pitch=-27.90 hip=+21.41 head=+0.26 helmet=+13.18 elbowL=172.39 elbowR=172.49 fistL=0.0044 fistR=0.0084
FOLD sit fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=2.720 jumping=false u=-1.000 neck1=-34.02 target pitch=+2.00 hip=+20.00 head=-10.95 eased pitch=-18.60 hip=+20.52 head=-3.56 helmet=+14.89 elbowL=129.98 elbowR=134.20 fistL=0.0000 fistR=0.0000
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=54.0 scope=44.5
```

| sample | pin eased pitch / hip / helmet (step 0) | day-one eased pitch / hip / helmet (step 0) | helmet apart |
| --- | --- | --- | ---: |
| two-point, frame before the leave | −39.53 / 26.14 / **+0.95** (−39.41 / 26.41 / −1.01) | −39.96 / 25.53 / **+4.59** (−40.07 / 25.43 / −2.05) | **3.64°** (was 1.04) |
| air u 0.20 | −40.23 / 26.54 / +2.49 | −40.42 / 26.20 / +6.91 | 4.42° |
| air u 0.55 | −37.49 / 24.45 / +5.30 | −37.61 / 24.38 / +10.22 | **4.92°** (was 0.22) |
| air u 0.85 | −27.78 / 21.42 / +8.11 | −27.90 / 21.41 / +13.18 | 5.07° |

- **Held:** the pin's two-point stays a two-point. Its helmet moves 1.96°, its pitch 0.12° and its hip 0.27°, all within 4° of the step-0 pin row.
- **Fists:** within 1 cm at every air sample (max 0.0084 m, day-one R at u 0.85). The crest target at u 0.55 is unchanged (the keys), and the pin's Neck1 is −21.44.
- **The sit's first frame** now shows day-one's helmet 5.1° higher (+14.89 against +9.77). The sit's own target head is still 6 with no share; the printed sit target (0.60 / −10.95) is the last jump frame, because that skeleton update runs before `_update_rider`. The difference is the eased head still arriving from the arc, and it fades as she sits.

**Kept.**

Three clocks with phase 1 in, probe stripped, copied from their logs:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.59 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=94.01 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.54 (0, 0), 91.59 (2, 0), 94.01 (3, 0); teleported=false, complete. The pin confidence is 91.0 / 86.5, so no fresh leak.

**The leave stays one pose** (pin hk_adv_002, probe on, stripped after):

```
LINE head 22.60 -> first 22.60 | fence=3 land_recover_at_leave=0.653 air_sound_at_leave=0 pitch -42.00 -> first -42.00 (u 0.000) -> u05 -41.57 (u 0.060) | hip 28.00 -> first 28.00 -> u05 27.57 grunt_u=0.345 land_playing_at_leave=false (pos -1.000) land_playing_at_grunt=false since_last_thud=2.033 hoof_strikes_in_air=0
LINE head 22.60 -> first 22.60 | fence=12 land_recover_at_leave=0.970 air_sound_at_leave=0 pitch -42.00 -> first -42.00 (u 0.000) -> u05 -41.57 (u 0.060) | hip 28.00 -> first 28.00 -> u05 27.57 grunt_u=0.345 land_playing_at_leave=false (pos -1.000) land_playing_at_grunt=false since_last_thud=1.746 hoof_strikes_in_air=0
RIDECERT hk_adv_002 style=clear success=true faults=0 jumped=12/12 t=83.14 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
```

Fences 3 and 12 leave with land_recover 0.653 / 0.970. On both, the change from the frame before to the first jumping frame is 0.00° pitch (−42.00 → −42.00), 0.00° hip (28.00 → 28.00) and **0.00° head** (22.60 → 22.60, the key less the pin's share 30 × 0.18). Under 8°. The round is clear, 83.14, 12/12, 0 rails, teleported=false, complete.

## Phase 2 — the sit, when she actually sits (`horse.gd`, the land block)

Inside `if land_recover > 0.0`, after pitch 2 / hip 20 / head 6, and only when she is **not jumping and last_stride ≤ 0.20**:

- `head_x -= FOLD_HEAD * _hand_unrest()`, the arc's share of 30, so her head target does not step at the landing;
- `hip_x += SIT_HIP * _hand_unrest()`, with `const SIT_HIP := 10.0`.

Both are constants, with no sine. Not the halt's 20 and 9: the sit head is 6, not 8. The ratio is the same −0.450 helmet per degree of eased head, so the sit helmet gap is 0.173 × 30 = 5.2° once the ease arrives. The hip share adds 3.85° of hip target on day-one over the pin. land_recover's length, the half-halt and the two-point lerp are untouched. A related line lerps out of the sit into phase 1's two-point once last_stride passes 0.20.

The step-0 probe only printed the brief's sit sample, the landing frame. That frame shows the eased pose still arriving from the arc. The probe for this phase also prints the sit at 0.5 s and 1.0 s in, and its last frame (`sit-end`, when last_stride passes 0.20). On hk_les_001 the sit lasts 0.57 s (land_recover 2.72 → 2.153), so there is no 1.0 s sample.

After, pin:

```
FOLD two-point fence=1 conf=85.0 unrest=0.180 last_stride=1.000 land_recover=0.000 jumping=false u=-1.000 neck1=-10.68 target pitch=-37.74 hip=+41.25 head=+16.50 eased pitch=-39.52 hip=+25.93 head=+27.56 helmet=+0.89 elbowL=130.83 elbowR=135.11 fistL=0.0000 fistR=0.0000
FOLD air-0.20 fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=0.000 jumping=true u=0.202 neck1=-5.18 target pitch=-40.01 hip=+26.01 head=+18.63 eased pitch=-40.19 hip=+26.41 head=+24.16 helmet=+2.42 elbowL=137.54 elbowR=142.43 fistL=0.0000 fistR=0.0000
FOLD air-0.55 fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=0.000 jumping=true u=0.560 neck1=-21.44 target pitch=-34.00 hip=+22.00 head=+12.60 eased pitch=-37.56 hip=+24.46 head=+17.83 helmet=+5.27 elbowL=101.40 elbowR=104.81 fistL=0.0002 fistR=0.0002
FOLD air-0.85 fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=0.000 jumping=true u=0.857 neck1=-51.07 target pitch=-14.01 hip=+18.00 head=+4.61 eased pitch=-27.80 hip=+21.42 head=+11.56 helmet=+8.09 elbowL=167.26 elbowR=172.44 fistL=0.0039 fistR=0.0064
FOLD sit fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=2.720 jumping=false u=-1.000 neck1=-34.15 target pitch=+2.00 hip=+20.00 head=+0.60 eased pitch=-18.72 hip=+20.53 head=+7.91 helmet=+9.73 elbowL=129.98 elbowR=134.20 fistL=0.0000 fistR=0.0000
FOLD sit+0.5s fence=1 conf=85.0 unrest=0.180 last_stride=0.189 land_recover=2.203 jumping=false u=-1.000 neck1=-18.72 target pitch=+2.00 hip=+21.80 head=+0.60 eased pitch=-4.38 hip=+21.41 head=+2.85 helmet=+12.07 elbowL=129.98 elbowR=134.20 fistL=0.0000 fistR=0.0000
FOLD sit-end fence=1 conf=85.0 unrest=0.180 last_stride=0.201 land_recover=2.153 jumping=false u=-1.000 neck1=-12.88 target pitch=+2.00 hip=+21.80 head=+0.60 eased pitch=-3.58 hip=+21.46 head=+2.57 helmet=+12.20 elbowL=129.98 elbowR=134.20 fistL=0.0000 fistR=0.0000
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
```

After, day-one:

```
FOLD two-point fence=1 conf=48.0 unrest=0.565 last_stride=1.000 land_recover=0.000 jumping=false u=-1.000 neck1=-0.72 target pitch=-33.43 hip=+48.03 head=-14.77 eased pitch=-39.71 hip=+25.85 head=+18.68 helmet=+4.89 elbowL=132.67 elbowR=137.05 fistL=0.0000 fistR=0.0000
FOLD air-0.20 fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=0.000 jumping=true u=0.202 neck1=-2.72 target pitch=-40.01 hip=+26.01 head=+7.08 eased pitch=-40.29 hip=+26.36 head=+14.00 helmet=+6.99 elbowL=137.19 elbowR=142.05 fistL=0.0000 fistR=0.0000
FOLD air-0.55 fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=0.000 jumping=true u=0.560 neck1=-21.44 target pitch=-34.00 hip=+22.00 head=+1.05 eased pitch=-37.55 hip=+24.42 head=+6.70 helmet=+10.28 elbowL=101.16 elbowR=104.57 fistL=0.0002 fistR=0.0002
FOLD air-0.85 fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=0.000 jumping=true u=0.857 neck1=-51.07 target pitch=-14.01 hip=+18.00 head=-6.94 eased pitch=-28.01 hip=+21.47 head=+0.30 helmet=+13.16 elbowL=164.50 elbowR=172.42 fistL=0.0039 fistR=0.0056
FOLD sit fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=2.720 jumping=false u=-1.000 neck1=-34.17 target pitch=+2.00 hip=+20.00 head=-10.95 eased pitch=-18.89 hip=+20.55 head=-3.46 helmet=+14.85 elbowL=129.98 elbowR=134.20 fistL=0.0000 fistR=0.0000
FOLD sit+0.5s fence=1 conf=48.0 unrest=0.565 last_stride=0.189 land_recover=2.203 jumping=false u=-1.000 neck1=-8.82 target pitch=+2.00 hip=+25.65 head=-10.95 eased pitch=-4.40 hip=+24.09 head=-8.66 helmet=+17.27 elbowL=129.98 elbowR=134.20 fistL=0.0000 fistR=0.0000
FOLD sit-end fence=1 conf=48.0 unrest=0.565 last_stride=0.201 land_recover=2.153 jumping=false u=-1.000 neck1=-2.98 target pitch=+2.00 hip=+25.65 head=-10.95 eased pitch=-3.70 hip=+24.26 head=-8.91 helmet=+17.38 elbowL=129.98 elbowR=134.20 fistL=0.0000 fistR=0.0000
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=54.0 scope=44.5
```

| sit sample | pin eased pitch / hip / helmet | day-one eased pitch / hip / helmet | apart: helmet / hip |
| --- | --- | --- | --- |
| first frame, land_recover 2.72 | −18.72 / 20.53 / +9.73 (step 0: −19.09 / 20.58 / +7.25) | −18.89 / 20.55 / +14.85 (step 0: −19.17 / 20.54 / +7.21) | 5.12° / 0.02° |
| +0.5 s, land_recover 2.203 | −4.38 / 21.41 / +12.07 | −4.40 / 24.09 / +17.27 | **5.20°** / 2.68° |
| sit-end, land_recover 2.153 | −3.58 / 21.46 / +12.20 | −3.70 / 24.26 / +17.38 | 5.18° / 2.80° |

- **The sit shows it:** day-one's eased helmet is 5.20° off the pin's 0.5 s into the sit (≥ 3°). The hip gap is 2.68–2.80°, so the helmet is the channel that clears.
- **The pin's sit:** it moves 2.48° of helmet on the first frame against step 0, and its pitch and hip move under 0.4°, all within 4°.
- **The two-point still holds:** +0.89 against +4.89, 4.00° apart. u 0.55 is 5.01° apart.
- **The leave:** this term is gated on last_stride ≤ 0.20, so it cannot touch the leave. Fences 3 and 12 stay on the phase 1 numbers, and no leave check was ridden for this phase.

**Kept.**

## Phase 3 — her elbows over the fence: not run, the gate is not met

The brief runs phase 3 only if step 0's elbows at u 0.55 are within 1° across the two horses. They are not:

| u 0.55 (step 0) | elbow L | elbow R |
| --- | ---: | ---: |
| pin | 100.01° | 103.40° |
| day-one | 102.82° | 106.24° |
| apart | **2.81°** | **2.84°** |

- **Not flat, not showing.** 2.8° is not within 1°, and it is not the 4° that would count as "already showing". So no in-air shoulder term was added. The 19 on gaits 1–3, the −40 at the halt and the fist target are unchanged.
- **Where the gap comes from.** In the air her fists ride the spot each horse's canter taught on the neck (\`_hand_on_neck\`). Day-one's canter arm differs, and that carries a little into the arc.
- **The fist gate held.** Each fist was within 1 cm of its target at u 0.20, 0.55 and 0.85 on both horses (max 0.0091 m).
- **After phases 1 and 2** the u 0.55 elbows read 101.40 / 104.81 (pin) against 101.16 / 104.57 (day-one), now 0.24° apart. The spread moved between rides of the same fence, and I have not measured why. The brief's gate is on step 0, which read 2.8°, so phase 3 stays unrun rather than being re-gated on a later ride.

**Written negative.**

Three clocks with phases 1 and 2 in, probe stripped, copied from their logs:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.59 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=94.01 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.53 (0, 0), 91.59 (2, 0), 94.01 (3, 0); teleported=false, complete. Pin confidence 91.0 / 86.5.

## The moving picture still holds

One throwaway scene (`game/tools/probe_quiet.gd`, deleted after), on the tree with phases 1 and 2: one second of halt, then one settled stride of walk, trot and canter, pin and day-one.

```
pin-halt hand_travel=0.001 nod_p2p=0.02 nod_mean=+11.31 elbowL=127.81/0.01 elbowR=131.87/0.02 hipx_p2p=0.09 hipx_mean=+9.58 heel_iron=0.064/0.064 heel_max=0.065/0.065 lowest_hoof=0.053 frames=145 head+Z=+1.000
dayone-halt hand_travel=0.001 nod_p2p=0.05 nod_mean=+14.76 elbowL=123.55/0.01 elbowR=127.17/0.01 hipx_p2p=0.12 hipx_mean=+13.03 heel_iron=0.054/0.054 heel_max=0.054/0.054 lowest_hoof=0.053 frames=145 head+Z=+1.000
pin-walk hand_travel=0.029 nod_p2p=2.30 nod_mean=+7.90 elbowL=129.98/2.10 elbowR=134.21/2.24 hipx_p2p=4.53 hipx_mean=+3.50 heel_iron=0.120/0.120 heel_max=0.138/0.138 lowest_hoof=0.052 frames=239 head+Z=+1.000
dayone-walk hand_travel=0.056 nod_p2p=5.85 nod_mean=+7.90 elbowL=130.02/6.56 elbowR=134.23/7.01 hipx_p2p=8.17 hipx_mean=+3.51 heel_iron=0.120/0.120 heel_max=0.154/0.154 lowest_hoof=0.052 frames=239 head+Z=+1.000
pin-trot hand_travel=0.055 nod_p2p=3.67 nod_mean=+7.11 elbowL=129.99/2.10 elbowR=134.21/2.24 hipx_p2p=10.55 hipx_mean=+15.29 heel_iron=0.088/0.088 heel_max=0.111/0.111 lowest_hoof=0.052 frames=164 head+Z=+1.000
dayone-trot hand_travel=0.081 nod_p2p=8.37 nod_mean=+7.08 elbowL=130.03/6.56 elbowR=134.23/7.01 hipx_p2p=14.28 hipx_mean=+15.32 heel_iron=0.091/0.091 heel_max=0.107/0.107 lowest_hoof=0.052 frames=164 head+Z=+1.000
pin-canter hand_travel=0.078 nod_p2p=2.87 nod_mean=+5.21 elbowL=129.98/2.10 elbowR=134.21/2.24 hipx_p2p=5.59 hipx_mean=+5.66 heel_iron=0.128/0.128 heel_max=0.159/0.159 lowest_hoof=0.053 frames=120 head+Z=+1.000
dayone-canter hand_travel=0.102 nod_p2p=7.50 nod_mean=+5.24 elbowL=130.02/6.56 elbowR=134.23/7.01 hipx_p2p=9.10 hipx_mean=+5.70 heel_iron=0.127/0.127 heel_max=0.170/0.170 lowest_hoof=0.053 frames=119 head+Z=+1.000
```

- **Halt, against `dist/halt_002.md`:**
  - helmet means +11.31 / +14.76, 3.45° apart;
  - elbow means 127.81 / 123.55 and 131.87 / 127.17, 4.26° / 4.70° apart;
  - hip means 9.58 / 13.03, 3.45° apart;
  - peak-to-peak 0.02–0.12°;
  - identical to the halt job's rows.
- **Moving gaits, against `dist/same_002.md`:**
  - helmet 2.30 / 5.85, 3.67 / 8.37, 2.87 / 7.50;
  - elbow p2p 2.10 / 6.56 and 2.24 / 7.01;
  - hip p2p 4.53 / 8.17, 10.55 / 14.28, 5.59 / 9.10;
  - wrist travel 0.029 / 0.056, 0.055 / 0.081, 0.078 / 0.102;
  - hoof 0.052–0.053;
  - all within 0.05° and 0.0 cm.
- **Why the new terms stay out.** The fold share runs only when last_stride > 0.20, which the ride AI sets on the approach, or while jumping. The sit share runs only while land_recover > 0. Neither is present on a settled gait or at the halt. **No leak.**

## The check is still a check — style, once, `--ridecert-style --ridecert-id=hk_beg_035` (probe on the refusal only, stripped after)

```
PROBE32 refuse t=0.25 conf=85.0 gait=0 neck1=+11.72 tail1=-0.31 ear=+7.83 clip=Idle FFB=0.053/0.053 helmet=+7.06 head_x=+13.86 elbowL=129.98 elbowR=134.20 hip_x=+22.47 unrest=0.180
PROBE32 refuse t=0.80 conf=85.0 gait=0 neck1=+6.60 tail1=-0.16 ear=+6.49 clip=Idle FFB=0.053/0.053 helmet=+10.57 head_x=+6.05 elbowL=128.03 elbowR=132.11 hip_x=+17.09 unrest=0.180
RIDECERT hk_beg_035 style=refuse_early success=true faults=4 jumped=8/8 t=69.88 teleported=false complete=true refused=[1] rail_fences=[] rail_air=[] conf=83.0 scope=82.5
FENCE knock 3 by horse at 9.0,-2.5 next=3 jumping=true
RIDECERT hk_beg_035 style=rail_late success=true faults=4 jumped=8/8 t=67.17 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=81.0
```

- **B:** refused fence 1, 0 rails, Idle, hinds 0.053 / 0.053, Neck1 +11.72, Tail1 −0.31, 69.88.
- **Her helmet on the check:** unrest 0.180. The helmet is +10.57° at 0.80 s, heading for the pin's halt (+11.31°), not day-one's (+14.76°). It starts nearer the halt than on the halt board's style (+9.30 at 0.80 s), because the approach head now carries the pin's fold share. Her elbows are the pin's halt (128.03 / 132.11).
- **C:** one rail, the knock on fence 3 with `jumping=true`, in the air, 67.17.

## Board — one full `--ridecert`, `board_table.py`

`RIDECERT done pass=false board=21/23 style=true`, 26 rounds in the log. The wrapper wrote `dist/ridecert_results.json` and kept `dist/ridecert_board.json` itself (14:11), with `GODOT_EXIT 1` because the board is not 23/23.

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

Against the halt board, compared log to log (`RIDECERT hk_… t=` in the halt board's full log against this one; the job-start copy of `ridecert_results.json` held a single clock, not a board): 25 id/style rows, worst |Δ| **0.03 s** (`hk_int_005`), all 21 clears within 0.1 s, faults and rails identical, 0 teleported. Same 21/23. The board did not move; the fold and sit terms stay.

## Playtest — headless `--playtest`, this run, after the board line was copied

```
PLAYTEST begin fences=8
PLAYTEST clear faults=0 complete=true
PLAYTEST refuse faults=4
PLAYTEST rail faults=4
PLAYTEST done pass=true
```
