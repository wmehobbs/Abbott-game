# She leans with him

## Step 0 — one turn, both horses

One probe in `horse.gd`, stripped before any timed clock; the tree is the heel board's (FOLD_PITCH 18, FOLD_SHIN 20). It tracks every bend with gait 3, not jumping, land_recover 0 and |last_turn| > 0.3 for at least 0.25 s. At the peak |last_turn| it prints last_turn, her roll target (`last_turn × 4.2`), her eased `rider_body` roll, both heels to the iron, `_hand_unrest()` and confidence. The rides are pin `--ridecert-id=hk_les_001`, then fresh.

The first probe ride printed only the first frame at the peak. last_turn saturates at 1.000 on this bend, so that frame is where the roll has only begun to ease in:

```
BEND last_turn=+1.000 roll_target=+4.20 roll_eased=+0.43 heelL=0.0880 heelR=0.0859 unrest=0.180 conf=85.0 pos=(-7.9,-17.6) after_fence=1 last_stride=0.00 pitch_eased=-2.25 bend=1 dur=4.67
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
BEND last_turn=+1.000 roll_target=+4.20 roll_eased=+0.36 heelL=0.0954 heelR=0.0937 unrest=0.565 conf=48.0 pos=(-7.9,-17.6) after_fence=1 last_stride=0.00 pitch_eased=-8.50 bend=1 dur=4.73
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=54.0 scope=44.5
```

The probe was changed to print both the first and the last frame at the peak, and ridden again, pin then fresh. These are the step-0 rows:

```
BEND-first-peak last_turn=+1.000 roll_target=+3.64 roll_eased=+0.16 heelL=0.0814 heelR=0.0806 unrest=0.180 conf=85.0 pos=(-7.9,-17.6) after_fence=1 last_stride=0.00 pitch_eased=-2.04 bend=1 dur=4.93
BEND-last-peak last_turn=+1.000 roll_target=+4.20 roll_eased=+4.16 heelL=0.0473 heelR=0.0353 unrest=0.180 conf=85.0 pos=(-10.8,-14.8) after_fence=1 last_stride=0.64 pitch_eased=-16.03 bend=1 dur=4.93
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
BEND-first-peak last_turn=+1.000 roll_target=+3.92 roll_eased=+0.30 heelL=0.0946 heelR=0.0931 unrest=0.565 conf=48.0 pos=(-7.9,-17.6) after_fence=1 last_stride=0.00 pitch_eased=-8.71 bend=1 dur=4.69
BEND-last-peak last_turn=+1.000 roll_target=+4.20 roll_eased=+4.16 heelL=0.0473 heelR=0.0395 unrest=0.565 conf=48.0 pos=(-10.8,-14.8) after_fence=1 last_stride=0.64 pitch_eased=-17.96 bend=1 dur=4.69
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=54.0 scope=44.5
```

| bend | horse | conf / unrest | peak last_turn | roll target | **eased roll** | roll per unit turn | heel to iron L / R |
| --- | --- | --- | ---: | ---: | ---: | ---: | --- |
| after fence 1, (−7.9, −17.6) → (−10.8, −14.8), 4.7–4.9 s above 0.3 | pin | 85.0 / 0.180 | +1.000 | +4.20 | **+4.16** (last frame at the peak) | 4.16 | 0.0473 / 0.0353 |
| | day-one | 48.0 / 0.565 | +1.000 | +4.20 | **+4.16** | 4.16 | 0.0473 / 0.0395 |
| first frame at the peak | pin / day-one | | +1.000 / +1.000 | +3.64 / +3.92 | +0.16 / +0.30 | | 0.0814 / 0.0806, 0.0946 / 0.0931 |

- **Her roll is flat:** the same bend on both horses (same position, last_turn 1.000), and the eased roll is 4.16° on both, **0.00° apart**. The roll `last_turn × (4.2 if gait ≥ 2 else 2.4)` carries no unrest. **Phase 1 is the job.**
- **LEAN, from the ratio:** 4.16° of eased roll per unit turn against a 4.20 target, so the ease has arrived to 0.99 at the settled frame. The extra roll gap is LEAN × (0.565 − 0.180) × 1.0 × 0.99, so a 3° gap needs 7.87: **LEAN = 8**, about 3.05° apart. The pin's own roll grows by 8 × 0.18 = 1.4°.
- **The heels.** Her legs roll with her body, so a lean moves the heels sideways against the irons. It is measured on the ride.

## Phase 1 — LEAN 8, one attempt: **reverted, the heel slid**

`const LEAN := 8.0`, `roll += LEAN * _hand_unrest() * last_turn`, gait ≥ 1 only, after `var roll := last_turn * (4.2 if gait >= 2 else 2.4)`. The 4.2, the 2.4 and the horse's `visual.rotation.z` are unchanged.

The first attempt to insert the probe on this tree failed on its anchor, so its pin ride did not run. The fresh ride that followed ran on the lean tree with no probe; it printed nothing and is not used. With the anchor fixed, pin then fresh:

```
FOLD two-point fence=1 conf=85.0 unrest=0.180 last_stride=1.000 land_recover=0.000 jumping=false u=-1.000 neck1=-10.05 target pitch=-40.98 hip=+43.05 head=+16.50 eased pitch=-42.27 hip=+27.89 head=+27.28 helmet=+1.02 fistL=0.0000 fistR=0.0000 heelL=0.1188 heelR=0.1188
FOLD air-0.55 fence=1 conf=85.0 unrest=0.180 last_stride=0.000 land_recover=0.000 jumping=true u=0.560 neck1=-21.44 target pitch=-37.24 hip=+23.80 head=+12.60 eased pitch=-40.73 hip=+26.30 head=+17.85 helmet=+5.26 fistL=0.0002 fistR=0.0002 heelL=0.1069 heelR=0.1069
BEND-first-peak last_turn=+1.000 roll_target=+5.26 roll_eased=+0.46 heelL=0.0866 heelR=0.0844 unrest=0.180 conf=85.0 pos=(-7.9,-17.6) after_fence=1 last_stride=0.00 pitch_eased=-2.20 bend=1 dur=4.94
BEND-last-peak last_turn=+1.000 roll_target=+5.64 roll_eased=+5.59 heelL=0.0529 heelR=0.0398 unrest=0.180 conf=85.0 pos=(-10.8,-14.8) after_fence=1 last_stride=0.64 pitch_eased=-16.92 bend=1 dur=4.94
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
```

```
FOLD two-point fence=1 conf=48.0 unrest=0.565 last_stride=1.000 land_recover=0.000 jumping=false u=-1.000 neck1=-0.64 target pitch=-43.60 hip=+53.68 head=-14.77 eased pitch=-48.63 hip=+30.47 head=+19.19 helmet=+4.66 fistL=0.0000 fistR=0.0000 heelL=0.1175 heelR=0.1175
FOLD air-0.55 fence=1 conf=48.0 unrest=0.565 last_stride=0.000 land_recover=0.000 jumping=true u=0.560 neck1=-21.44 target pitch=-44.17 hip=+27.65 head=+1.05 eased pitch=-47.58 hip=+29.94 head=+6.88 helmet=+10.20 fistL=0.0002 fistR=0.0002 heelL=0.1067 heelR=0.1067
BEND-first-peak last_turn=+1.000 roll_target=+8.14 roll_eased=+0.62 heelL=0.0946 heelR=0.0916 unrest=0.565 conf=48.0 pos=(-7.9,-17.6) after_fence=1 last_stride=0.00 pitch_eased=-8.67 bend=1 dur=4.83
BEND-last-peak last_turn=+1.000 roll_target=+8.72 roll_eased=+8.64 heelL=0.0721 heelR=0.0649 unrest=0.565 conf=48.0 pos=(-10.8,-14.8) after_fence=1 last_stride=0.64 pitch_eased=-17.69 bend=1 dur=4.83
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=54.0 scope=44.5
```

| settled frame of the bend (last frame at the peak) | step 0 pin / day-one | with LEAN 8 | rule | |
| --- | --- | --- | --- | --- |
| eased roll | +4.16 / +4.16 (0.00°) | +5.59 / +8.64 (**3.05°** apart; predicted 3.05) | ≥ 3° more on day-one | pass |
| the pin's roll | +4.16 | +5.59 (1.43°) | within 4° | pass |
| heel L to iron | 0.0473 / 0.0473 | 0.0529 (+0.56 cm) / **0.0721 (+2.48 cm)** | each within 2 cm of its own step 0 | **day-one fails** |
| heel R to iron | 0.0353 / 0.0395 | 0.0398 (+0.45 cm) / **0.0649 (+2.54 cm)** | each within 2 cm | **day-one fails** |
| fence 1 two-point heel | 0.1174 / 0.1187 (this job's first probe) | 0.1188 / 0.1175 | within 2 cm | pass (last_turn ≈ 0 on the approach) |
| eased pitch at u 0.55 | −40.68 / −47.49 | −40.73 / −47.58 (6.85°) | about 7° | pass |
| the pin's Neck1 at u 0.55 | −21.44 | −21.44 | −21.4 | pass |

- **Her lean does read him with 8:** 3.05° more into the turn on day-one.
- **But her legs roll with her body.** On day-one both heels slide 2.5 cm off the irons at the settled frame, past 2 cm. The brief keeps the shin counter for the fold, so this is not countered with a new shin term.
- **The lean is a written negative** at these degrees: 3.05° gained, 2.48 / 2.54 cm of heel lost. The lean line is reverted, and `horse.gd` is byte-identical to the heel board's. No clocks for this phase.

## Phase 2 — her back on the flat

One throwaway scene (`game/tools/probe_quiet.gd`, deleted after), on the heel board's tree (the lean reverted). It is the halt-job scene plus the eased `rider_body` pitch, peak-to-peak and mean, over one second of halt and one settled stride of walk, trot and canter, pin and day-one. The machine was running slow (canter strides of 101–120 frames against the usual 120), so the scene was run twice.

Run 1:

```
pin-halt  conf=85.0 frames=128 body_pitch_p2p=0.15 body_pitch_mean=-16.06
dayone-halt  conf=48.0 frames=137 body_pitch_p2p=0.14 body_pitch_mean=-16.06
pin-walk  conf=85.0 frames=216 body_pitch_p2p=2.40 body_pitch_mean=-26.95
dayone-walk  conf=48.0 frames=211 body_pitch_p2p=5.40 body_pitch_mean=-27.15
pin-trot  conf=85.0 frames=157 body_pitch_p2p=8.51 body_pitch_mean=-33.35
dayone-trot  conf=48.0 frames=147 body_pitch_p2p=5.56 body_pitch_mean=-33.25
pin-canter  conf=85.0 frames=101 body_pitch_p2p=6.61 body_pitch_mean=-28.35
dayone-canter  conf=48.0 frames=110 body_pitch_p2p=9.30 body_pitch_mean=-28.65
```

Run 2:

```
pin-halt  conf=85.0 frames=117 body_pitch_p2p=0.15 body_pitch_mean=-16.06
dayone-halt  conf=48.0 frames=132 body_pitch_p2p=0.14 body_pitch_mean=-16.06
pin-walk  conf=85.0 frames=214 body_pitch_p2p=2.37 body_pitch_mean=-27.08
dayone-walk  conf=48.0 frames=204 body_pitch_p2p=5.52 body_pitch_mean=-27.15
pin-trot  conf=85.0 frames=165 body_pitch_p2p=8.48 body_pitch_mean=-33.24
dayone-trot  conf=48.0 frames=155 body_pitch_p2p=5.58 body_pitch_mean=-33.03
pin-canter  conf=85.0 frames=105 body_pitch_p2p=6.90 body_pitch_mean=-29.02
dayone-canter  conf=48.0 frames=120 body_pitch_p2p=9.16 body_pitch_mean=-28.75
```

| gait | pin p2p (runs 1 / 2) | day-one p2p (runs 1 / 2) | day-one more by |
| --- | --- | --- | --- |
| halt | 0.15 / 0.15 (mean −16.06) | 0.14 / 0.14 (mean −16.06) | 0.0 |
| walk | 2.40 / 2.37 | 5.40 / 5.52 | **3.00 / 3.15°**, already shows |
| trot | 8.51 / 8.48 | 5.56 / 5.58 | **−2.95 / −2.90°** (less on day-one) |
| canter | 6.61 / 6.90 | 9.30 / 9.16 | **2.69 / 2.26°**, under 3° |

- **Walk:** it already shows him (≥ 3°). No term.
- **Trot:** day-one's back swings *less*. The trot's unrest share `pitch += swing × 14 × unrest` runs against the post's `−post × 26.4` on the same half of the stride. This job's gate is the canter only; the trot is written as it reads.
- **Canter:** flat, under 3° on both runs, so one term beside the 14, not inside it: `pitch += rock × K × unrest`. The command `rock × 11 − sit × 5.8 + rock × 14 × unrest` was run through the ease at 1.71 Hz. With the term off it gives 6.91 / 9.17 (2.26° apart), which reproduces run 2.

| K | pin p2p | day-one p2p | apart |
| ---: | ---: | ---: | ---: |
| 4 | 7.22 | 10.12 | 2.90 |
| 6 | 7.37 | 10.59 | 3.22 |
| **8** | **7.52** | **11.06** | **3.55** |
| 10 | 7.67 | 11.54 | 3.87 |

**K = 8** leaves 0.5° of margin over the 0.4° spread between the two runs.

### The canter term, one attempt: **reverted, it moved her hands**

`pitch += rock * 8.0 * unrest`, beside the canter's `pitch += rock * 14.0 * unrest`. The same scene right after (normal frame rate this run, canter strides of 118–119 frames):

```
pin-halt  hand_travel=0.001 nod_p2p=0.02 elbowL=127.81/0.02 elbowR=131.87/0.02 hipx_p2p=0.09 heel_iron=0.064/0.064 heel_max=0.065/0.065 lowest_hoof=0.053 frames=145 body_pitch_p2p=0.15
dayone-halt  hand_travel=0.001 nod_p2p=0.05 elbowL=123.55/0.01 elbowR=127.17/0.01 hipx_p2p=0.11 heel_iron=0.054/0.054 heel_max=0.054/0.054 lowest_hoof=0.053 frames=143 body_pitch_p2p=0.15
pin-walk  hand_travel=0.029 nod_p2p=2.30 elbowL=129.98/2.10 elbowR=134.21/2.25 hipx_p2p=4.53 heel_iron=0.120/0.120 heel_max=0.138/0.138 lowest_hoof=0.052 frames=239 body_pitch_p2p=2.42
dayone-walk  hand_travel=0.056 nod_p2p=5.84 elbowL=130.03/6.56 elbowR=134.24/7.01 hipx_p2p=8.16 heel_iron=0.120/0.120 heel_max=0.154/0.154 lowest_hoof=0.052 frames=239 body_pitch_p2p=5.45
pin-trot  hand_travel=0.055 nod_p2p=3.67 elbowL=129.99/2.10 elbowR=134.21/2.24 hipx_p2p=10.53 heel_iron=0.088/0.088 heel_max=0.111/0.111 lowest_hoof=0.052 frames=164 body_pitch_p2p=8.42
dayone-trot  hand_travel=0.081 nod_p2p=8.37 elbowL=130.03/6.56 elbowR=134.24/7.01 hipx_p2p=14.19 heel_iron=0.091/0.091 heel_max=0.106/0.106 lowest_hoof=0.052 frames=165 body_pitch_p2p=5.56
pin-canter  hand_travel=0.080 nod_p2p=2.86 elbowL=129.98/2.11 elbowR=134.21/2.25 hipx_p2p=5.57 heel_iron=0.127/0.127 heel_max=0.159/0.159 lowest_hoof=0.053 frames=119 body_pitch_p2p=7.49
dayone-canter  hand_travel=0.109 nod_p2p=7.46 elbowL=130.04/6.56 elbowR=134.25/7.02 hipx_p2p=9.06 heel_iron=0.127/0.127 heel_max=0.172/0.172 lowest_hoof=0.053 frames=118 body_pitch_p2p=10.94
```

| check | before the term (runs 1 / 2) | with the term | rule | |
| --- | --- | --- | --- | --- |
| canter body-pitch p2p, pin / day-one | 6.61 / 9.30, 6.90 / 9.16 | 7.49 / 10.94 (**3.45°** more; the sim said 3.55) | ≥ 3° more | pass |
| canter wrist travel, pin / day-one | 0.074 / 0.104, 0.078 / 0.103 (kept 0.078 / 0.103) | 0.080 / **0.109** | within 0.5 cm of `same_002` | **day-one +0.6 cm: fail** |
| canter helmet p2p | 2.76 / 7.66, 2.84 / 7.53 | 2.86 / 7.46 | within 0.3° | pass |
| canter elbow p2p, hip p2p | 2.10 / 6.56, 5.48–5.50 / 9.13–9.30 | 2.11 / 6.56, 5.57 / 9.06 | within 0.3° | pass |
| canter heel to iron, mean / farthest | 0.123–0.129 / 0.156–0.169 | 0.127 / 0.159–0.172 | within 2 cm | pass |
| walk, trot, halt | | unchanged (the term is gait 3 only) | | pass |

- **Her back does swing with him on the flat with 8:** 3.45° more at the canter on day-one.
- **But her fist target is set in the body frame.** Swinging her back more carries her hands with it: day-one's canter hand travel goes 0.103 → 0.109 m, 0.1 cm past the 0.5 cm rule. Both earlier runs on the unchanged tree read 0.103–0.104, so this is the term, not the slow frames.
- **The canter back on the flat is a written negative** at these degrees: 3.45° gained, 0.6 cm of hand travel added. The line is reverted. The walk already shows (3.0–3.15°). The trot reads less on day-one, by the code's own signs, and is written as it reads.
- **The leak check** (halt means, the moving gaits against `same_002`, hoof) held on every row except that canter hand-travel cell.

## No phase kept code

The lean is reverted (the heels slid 2.5 cm), and the canter back is reverted (the hands moved 0.6 cm). `horse.gd`, `bascule.gd`, `rider_mesh.gd` and `person_look.gd` are byte-identical to the heel board's tree, so no style run, no board, no playtest and no new clocks. **The heel board's 21/23 stands.** The clocks on the tree left are the heel job's: 18.54 / 91.60 / 93.99, 0 / 2 / 3 faults, 0 rails, teleported=false.
