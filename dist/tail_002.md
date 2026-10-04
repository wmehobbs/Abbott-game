# The tail she can see

## Step 0 — the hair, before any pose code

One throwaway scene (stats set, gait set, two seconds, one settled stride measured after the modifiers), deleted after. The last tail bone in the skeleton is **Tail7**; the last ear bone is **Ear4.L**. Tail tips are world height over the withers (Torso3), m. Tail7 → hip is the distance from the Tail7 tip to her `Hips` bone. Ear4.L tip is in the horse's Head frame. Head travel is the extent of her `Head` bone (the helmet sits on it) over the stride, in the withers frame.

| gait | horse | Tail1 | Tail3 tip | Tail7 tip | Tail7 → hip | Ear1.L | Ear4.L tip (head frame) | her head travel | hands | lowest hoof |
| --- | --- | ---: | ---: | ---: | ---: | ---: | --- | ---: | ---: | ---: |
| walk | pin | +0.21 | +0.105 | −0.465 | 0.922 | −11.46 | (−0.109, −0.098, +0.202) | 0.040 | 0.029 | 0.052 |
| walk | day-one | −9.69 | +0.139 | −0.414 | 0.943 | −20.24 | (−0.108, −0.044, +0.217) | 0.076 | 0.056 | 0.052 |
| trot | pin | +0.20 | +0.105 | −0.465 | 0.971 | −11.42 | (−0.109, −0.098, +0.202) | 0.101 | 0.055 | 0.052 |
| trot | day-one | −9.66 | +0.138 | −0.414 | 0.992 | −20.50 | (−0.108, −0.044, +0.217) | 0.100 | 0.081 | 0.052 |
| canter | pin | −0.72 | +0.213 | +0.131 | 1.103 | +5.45 | (−0.110, −0.163, +0.111) | 0.109 | 0.078 | 0.053 |
| canter | day-one | −10.59 | +0.248 | +0.264 | 1.084 | −3.35 | (−0.111, −0.135, +0.151) | 0.145 | 0.103 | 0.053 |

Reading:

- The tail. At the walk and the trot Tail1 is 9.9° apart but the Tail7 tip only 5.1 cm (−0.465 against −0.414; Tail3 3.4 cm). Both tips hang 0.41–0.47 m below the withers. The dock moved; the hair still hangs. Phase 1 is the job. The canter tip already differs by 13.3 cm (+0.131 / +0.264).
- Her head. At the walk it already travels 3.6 cm more on day-one (0.040 / 0.076). At the trot it is identical (0.101 / 0.100) though her hands differ by 2.6 cm. Phase 2 is the trot only.

## After the hair (`bascule.gd`: WORRY_HAIR on Tail2–Tail5, scaled by `_tail_hang`)

The scene measured right after the change, the same columns as step 0:

| gait | horse | Tail1 | Neck1 | Tail7 tip | Tail7 → hip | lowest hoof |
| --- | --- | ---: | ---: | ---: | ---: | ---: |
| walk | pin | +0.21 | −4.51 | −0.465 | 0.922 | 0.052 |
| walk | day-one | −9.69 | +5.38 | **−0.318** | 1.021 | 0.052 |
| trot | pin | +0.20 | −4.48 | −0.465 | 0.971 | 0.052 |
| trot | day-one | −9.69 | +5.41 | **−0.318** | 1.063 | 0.052 |
| canter | pin | −0.73 | −15.23 | +0.131 | 1.103 | 0.053 |
| canter | day-one | −10.64 | −5.36 | **+0.305** | 1.082 | 0.053 |

Walk and trot tips 14.7 cm higher on day-one (was 5.1 cm); day-one tips 1.02–1.06 m from her hip; Tail1 and Neck1 9.9° apart; lowest hoof 0.052–0.053; the pin's tail unchanged (worry 0).

The canter band is +0.264 ± 0.04 for day-one: **+0.305 is 4.1 cm off — outside by 1 mm.** A second scene of the identical code (`tailtip=+0.303`) read 3.9 cm. The same code falls on both sides of the line depending on the stride. Under the rule the rows above miss, so **the hair is a negative**: `WORRY_HAIR` and `_tail_hang` reverted, no second set of angles. It lifted the hanging hair 14.7 cm and cost 3.9–4.1 cm at the canter.

Three clocks with the hair in, copied from their logs (all inside the keep; recorded, but the phase is reverted on the canter band, not on the clock):

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.59 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=93.99 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

## Phase 2 — her head at the trot: not run

Phase 2 was conditional on the hair rows holding; they did not (the canter band above), so no head term was written. For the record, the step 0 head measure is the origin of her `Head` bone, which a `head_x` rotation does not move; the helmet crown (the Cap attachment, (0, 0.20, 0.01) on that bone) was also measured in the same scene: walk 0.047 / 0.092, trot 0.115 / 0.105, canter 0.127 / 0.170 (pin / day-one) — the trot helmet is not larger on day-one.

## Phase 3 — coming back to himself: printed, no code

Fence 1 of `hk_les_001`, pin and `--ridecert-fresh`, on the tree with the hair reverted. Time is recover elapsed (2.72 − land_recover). Copied from the two rides:

```
PROBE50 conf=85.0 recover t=0.00(elapsed 0.000) land_recover=2.720 neck1=-34.54 tail1=-11.01 tail7tip=+0.207
PROBE50 conf=85.0 recover t=0.25(elapsed 0.250) land_recover=2.470 neck1=-16.42 tail1=-0.40 tail7tip=-0.033
PROBE50 conf=85.0 recover t=0.50(elapsed 0.500) land_recover=2.220 neck1=-20.34 tail1=-3.97 tail7tip=+0.372
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.
PROBE50 conf=48.0 recover t=0.00(elapsed 0.000) land_recover=2.720 neck1=-34.17 tail1=-9.81 tail7tip=+0.163
PROBE50 conf=48.0 recover t=0.25(elapsed 0.250) land_recover=2.470 neck1=-11.47 tail1=-5.35 tail7tip=+0.034
PROBE50 conf=48.0 recover t=0.50(elapsed 0.500) land_recover=2.220 neck1=-10.44 tail1=-13.87 tail7tip=+0.507
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=54.
```

At touchdown the two necks are together (−34.5 / −34.2): the worry is faded out in the air by design. By 0.50 s day-one's neck is 9.9° higher (−10.44 against −20.34) and his tail tip 13.5 cm higher (+0.507 against +0.372). The return is already the picture. No code.

## The pin, the board

No phase of this job kept code: the hair is a negative and reverted, the head was not run, the recover needed none. `horse.gd`, `bascule.gd`, `rider_mesh.gd` are byte-identical to the start of this job. So no style run and no board; the 21/23 board in `dist/hands_002.md` stands. The last playtest, from that board's job, not re-run here:

```
PLAYTEST done pass=true
```
