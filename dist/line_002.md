# A one-stride does not wait

## Step 0 — hk_adv_002, one ride, one probe, before any pose code

`--ridecert-id=hk_adv_002`, headless, with one probe in `horse.gd`, stripped after; the tree is byte-identical to the halt board's again. The probe reads:

- **the leave:** `_begin_jump`;
- **the pose:** the targets `_update_rider` is about to apply (`pitch`, `hip_x`, just before the ease), on the frame before the leave, the first jumping frame, and the first frame at u ≥ 0.05;
- **the applied pose:** `rider_body.rotation_degrees.x`, the eased pose she actually shows;
- **the lens:** the camera height on the frame before and the leave frame;
- **the sound:** `_air_sounds` for the true grunt and the thud on the hoof, whether `land.wav` is still playing on `sfx` at the leave and at the grunt, and `hoof_i` across the air, which counts hoof strikes while jumping.

```
LINE fence=1 land_recover_at_leave=0.000 air_sound_at_leave=0 pitch -36.44 -> first -42.00 (u 0.000) -> u05 -41.57 (u 0.060) | hip 44.36 -> first 28.00 -> u05 27.57 | applied body -38.56 -> -38.43 | cam_y 2.8102 -> 2.8141 | grunt_u=0.345 land_playing_at_leave=false (pos -1.000) land_playing_at_grunt=false since_last_thud=-1.000 hoof_strikes_in_air=0
LINE thud after fence 1 fore_y=0.0500 wait=0.000 land_recover=2.72
LINE fence=2 land_recover_at_leave=0.000 air_sound_at_leave=0 pitch -37.22 -> first -42.00 (u 0.000) -> u05 -41.57 (u 0.060) | hip 42.87 -> first 28.00 -> u05 27.57 | applied body -37.70 -> -37.68 | cam_y 2.8102 -> 2.8112 | grunt_u=0.345 land_playing_at_leave=false (pos -1.000) land_playing_at_grunt=false since_last_thud=8.038 hoof_strikes_in_air=0
LINE thud after fence 2 fore_y=0.0497 wait=0.000 land_recover=2.72
LINE fence=3 land_recover_at_leave=0.653 air_sound_at_leave=0 pitch -42.00 -> first -42.00 (u 0.000) -> u05 -41.57 (u 0.060) | hip 28.00 -> first 28.00 -> u05 27.57 | applied body -37.85 -> -38.05 | cam_y 2.1904 -> 2.1915 | grunt_u=0.345 land_playing_at_leave=false (pos -1.000) land_playing_at_grunt=false since_last_thud=2.046 hoof_strikes_in_air=0
LINE thud after fence 3 fore_y=0.0501 wait=0.000 land_recover=2.72
LINE fence=4 land_recover_at_leave=0.000 air_sound_at_leave=0 pitch -52.89 -> first -42.00 (u 0.000) -> u05 -41.57 (u 0.060) | hip 18.44 -> first 28.00 -> u05 27.57 | applied body -36.77 -> -37.29 | cam_y 2.6797 -> 2.6874 | grunt_u=0.345 land_playing_at_leave=false (pos -1.000) land_playing_at_grunt=false since_last_thud=3.115 hoof_strikes_in_air=0
LINE thud after fence 4 fore_y=0.0454 wait=0.000 land_recover=2.72
LINE fence=5 land_recover_at_leave=0.000 air_sound_at_leave=0 pitch -52.77 -> first -42.00 (u 0.000) -> u05 -41.57 (u 0.060) | hip 18.54 -> first 28.00 -> u05 27.57 | applied body -39.87 -> -40.32 | cam_y 2.8102 -> 2.8114 | grunt_u=0.345 land_playing_at_leave=false (pos -1.000) land_playing_at_grunt=false since_last_thud=10.309 hoof_strikes_in_air=0
LINE thud after fence 5 fore_y=0.0500 wait=0.000 land_recover=2.72
LINE fence=6 land_recover_at_leave=0.000 air_sound_at_leave=0 pitch -36.86 -> first -42.00 (u 0.000) -> u05 -41.57 (u 0.060) | hip 44.01 -> first 28.00 -> u05 27.57 | applied body -37.91 -> -37.88 | cam_y 2.7962 -> 2.7977 | grunt_u=0.345 land_playing_at_leave=false (pos -1.000) land_playing_at_grunt=false since_last_thud=3.684 hoof_strikes_in_air=0
LINE thud after fence 6 fore_y=0.0504 wait=0.000 land_recover=2.72
LINE fence=7 land_recover_at_leave=0.000 air_sound_at_leave=0 pitch -52.70 -> first -42.00 (u 0.000) -> u05 -41.57 (u 0.060) | hip 18.61 -> first 28.00 -> u05 27.57 | applied body -38.32 -> -38.77 | cam_y 2.8099 -> 2.8110 | grunt_u=0.345 land_playing_at_leave=false (pos -1.000) land_playing_at_grunt=false since_last_thud=4.801 hoof_strikes_in_air=0
LINE thud after fence 7 fore_y=0.0493 wait=0.000 land_recover=2.72
LINE fence=8 land_recover_at_leave=0.000 air_sound_at_leave=0 pitch -36.82 -> first -42.00 (u 0.000) -> u05 -41.57 (u 0.060) | hip 44.11 -> first 28.00 -> u05 27.57 | applied body -37.51 -> -37.49 | cam_y 2.8098 -> 2.8110 | grunt_u=0.345 land_playing_at_leave=false (pos -1.000) land_playing_at_grunt=false since_last_thud=5.496 hoof_strikes_in_air=0
LINE thud after fence 8 fore_y=0.0500 wait=0.000 land_recover=2.72
LINE fence=9 land_recover_at_leave=0.000 air_sound_at_leave=0 pitch -37.05 -> first -42.00 (u 0.000) -> u05 -41.57 (u 0.060) | hip 43.39 -> first 28.00 -> u05 27.57 | applied body -38.18 -> -38.14 | cam_y 2.8102 -> 2.8114 | grunt_u=0.345 land_playing_at_leave=false (pos -1.000) land_playing_at_grunt=false since_last_thud=5.736 hoof_strikes_in_air=0
LINE thud after fence 9 fore_y=0.0499 wait=0.000 land_recover=2.72
LINE fence=10 land_recover_at_leave=0.000 air_sound_at_leave=0 pitch -36.70 -> first -42.00 (u 0.000) -> u05 -41.57 (u 0.060) | hip 44.49 -> first 28.00 -> u05 27.57 | applied body -38.82 -> -38.75 | cam_y 2.8102 -> 2.8112 | grunt_u=0.345 land_playing_at_leave=false (pos -1.000) land_playing_at_grunt=false since_last_thud=11.346 hoof_strikes_in_air=0
LINE thud after fence 10 fore_y=0.0498 wait=0.000 land_recover=2.72
LINE fence=11 land_recover_at_leave=0.000 air_sound_at_leave=0 pitch -49.24 -> first -42.00 (u 0.000) -> u05 -41.57 (u 0.060) | hip 21.64 -> first 28.00 -> u05 27.57 | applied body -39.08 -> -39.43 | cam_y 2.6795 -> 2.6882 | grunt_u=0.345 land_playing_at_leave=false (pos -1.000) land_playing_at_grunt=false since_last_thud=3.120 hoof_strikes_in_air=0
LINE thud after fence 11 fore_y=0.0496 wait=0.000 land_recover=2.72
LINE fence=12 land_recover_at_leave=0.970 air_sound_at_leave=0 pitch -42.00 -> first -42.00 (u 0.000) -> u05 -41.57 (u 0.060) | hip 28.00 -> first 28.00 -> u05 27.57 | applied body -38.05 -> -38.17 | cam_y 2.1909 -> 2.1920 | grunt_u=0.345 land_playing_at_leave=false (pos -1.000) land_playing_at_grunt=false since_last_thud=1.741 hoof_strikes_in_air=0
LINE thud after fence 12 fore_y=0.0493 wait=0.000 land_recover=2.72
RIDECERT hk_adv_002 style=clear success=true faults=0 jumped=12/12 t=83.12 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
```

The five rows the brief asks for:

| fence | strides | land_recover at leave | her pitch, frame before → first frame → u 0.05 | her hip_x, frame before → first frame → u 0.05 | one-frame change, pitch / hip | camera height, frame before → leave frame | grunt u | previous thud still playing | hoof strike in the air |
| --- | --- | ---: | --- | --- | --- | --- | ---: | --- | ---: |
| 1 (control) | — | 0.000 | −36.44 → −42.00 → −41.57 | 44.36 → 28.00 → 27.57 | 5.56° / 16.36° | 2.8102 → 2.8141 | 0.345 | no (at leave, at grunt) | 0 |
| 3 | one | **0.653** | **−42.00 → −42.00** → −41.57 | **28.00 → 28.00** → 27.57 | **0.00° / 0.00°** | 2.1904 → 2.1915 | 0.345 | no (thud 2.05 s earlier, finished) | 0 |
| 4 | two | 0.000 | −52.89 → −42.00 → −41.57 | 18.44 → 28.00 → 27.57 | 10.89° / 9.56° | 2.6797 → 2.6874 | 0.345 | no (3.12 s) | 0 |
| 11 | two | 0.000 | −49.24 → −42.00 → −41.57 | 21.64 → 28.00 → 27.57 | 7.24° / 6.36° | 2.6795 → 2.6882 | 0.345 | no (3.12 s) | 0 |
| 12 | one | **0.970** | **−42.00 → −42.00** → −41.57 | **28.00 → 28.00** → 27.57 | **0.00° / 0.00°** | 2.1909 → 2.1920 | 0.345 | no (thud 1.74 s earlier, finished) | 0 |

Reading:

- **The one-strides already wait.**
  - At fences 3 and 12 he leaves with land_recover still up (0.653, 0.970), which is the case the brief describes. But her target on the frame before is already exactly the jump's first key (−42 / 28), not the sit (pitch 2, hip 20).
  - `_update_rider` puts the land sit first and then `if last_stride > 0.20 and not jumping` lerps it toward the two-point. On a related line `ride_ai` holds `last_stride` at 1, so she is fully in two-point before he leaves.
  - The two poses do not meet on one frame: the change is 0.00° pitch and 0.00° hip.
- **The two-strides are normal leaves.**
  - By fences 4 and 11 the recover has run out (land_recover 0.000; the last thud was 3.12 s earlier, past 2.72).
  - Fence 4's frame-before pitch −52.89 is the canter rock at the instant of the leave. It changes 10.89° / 9.56° onto the keys, the same as the unrelated fences 5 (−52.77) and 7 (−52.70).
  - Fence 11 changes 7.24° / 6.36°. The control, fence 1, changes 5.56° pitch but 16.36° hip.
  - The brief defines a snap as 8° or more on that frame *with land_recover still above zero*. Fence 4 is over 8° with land_recover 0. It is the ordinary canter-to-keys leave every unrelated fence makes, and it is not a related-line snap. The brief also says a normal leave "still starts on the keys", so a blend gated on land_recover > 0 would not touch it.
- **The applied pose.** Through the ease `k = 1 − 0.10^delta` (about 4 % a frame), the pose she actually shows moves by at most 0.52° on any leave frame (fence 4: −36.77 → −37.29).
- **The lens.** The camera height moves by at most 0.9 cm on any leave frame (fence 11: 2.6795 → 2.6882). On the one-strides it sits at 2.19 m, still low from the landing, and moves 0.1 cm.
- **The sound.**
  - Every thud played on a fore hoof within 2 cm of 0.053 on the land frame (fore_y 0.045–0.050, wait 0.000).
  - No `land.wav` was still playing at any leave or at any grunt. The closest are the one-strides: the previous thud started 2.05 s and 1.74 s before the leave and had finished (`sfx.playing` false).
  - No thud was left waiting at a leave (`_air_sound` 0).
  - The true grunt is at u 0.345 on all twelve. No hoof strike fired in the air on any fence (`hoof_i` unchanged across every jump).

## Phase 1 — she leaves from the pose she is in: written negative, no code

No in-fence snaps under the brief's definition. The two in-fences with land_recover above zero at the leave (3 and 12) change 0.00° / 0.00°, because `last_stride` already has her in two-point. The two with a larger change (4, and 11 under 8°) leave with land_recover 0, and fence 4 matches the ordinary leave of fences 5 and 7. So no blend was added.

## Phase 2 — the thud and the next grunt: written negative, no code

No overlap in step 0. No thud is playing when any grunt starts, none is waiting at a leave, every thud is on a hoof, and there is no strike in the air. No second sound was added.

## Clocks on the tree left (unchanged, the halt board's), copied from their logs

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.6 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=93.99 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.53 (0, 0), 91.60 (2, 0), 93.99 (3, 0); teleported=false, complete. No phase kept code, so there was no style run and no board. The halt board (21/23, worst move 0.06 s on hk_int_001) stands.
