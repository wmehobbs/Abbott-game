# The whole card

## Phase 1 — every course on the card

One headless script (deleted after) loaded every id in `game/content/courses/SHIP.json`: 4 lesson, 6 beginner, 6 intermediate, 4 advanced and 3 jump-off. For each, it built the expected line from the file with the kept rules:
- `Fence {num}. {name}.`, then `str(h)` m;
- then `spread str(sp) m.` only when sp > 0;
- then `1 stride to fence {to}.` / `{n} strides to fence {to}.` when `related` is a dictionary.

It compared that exactly against `ContentLibrary.near_line` on each fence's `pos` and on each related midpoint (the in-fence's line). It also checked one point farther than 6 m from every fence (empty), and every `related.to` against the file's fence numbers.

`AUDITCOUNT courses=23 fences=180 related_midpoints=45 failures=1`

| course | fences | related midpoints | far point | result |
| --- | ---: | ---: | --- | --- |
| hk_les_001 | 3 | 1 | (-14.0, -40.0) 24.50 m: (empty) | match |
| hk_les_002 | 3 | 1 | (-14.0, -40.0) 26.86 m: (empty) | match |
| hk_les_003 | 3 | 1 | (-14.0, -40.0) 24.21 m: (empty) | match |
| hk_les_004 | 3 | 1 | (-14.0, -40.0) 24.35 m: (empty) | match |
| hk_beg_035 | 8 | 2 | (-14.0, -40.0) 28.33 m: (empty) | match |
| hk_beg_039 | 8 | 1 | (-14.0, -40.0) 19.35 m: (empty) | match |
| hk_beg_004 | 8 | 1 | (-14.0, -40.0) 25.75 m: (empty) | match |
| hk_beg_034 | 8 | 2 | (-14.0, -40.0) 25.48 m: (empty) | match |
| hk_beg_007 | 8 | 3 | (-14.0, -40.0) 25.65 m: (empty) | match |
| hk_beg_033 | 8 | 3 | (-14.0, -40.0) 28.73 m: (empty) | match |
| hk_int_001 | 10 | 2 | (-14.0, -40.0) 27.07 m: (empty) | match |
| hk_int_002 | 10 | 4 | (-14.0, -40.0) 16.15 m: (empty) | match |
| hk_int_005 | 10 | 2 | (-14.0, -40.0) 19.24 m: (empty) | match |
| hk_int_006 | 10 | 2 | (-14.0, -40.0) 19.37 m: (empty) | match |
| hk_int_007 | 10 | 2 | (-14.0, -40.0) 20.99 m: (empty) | match |
| hk_int_009 | 10 | 2 | (-14.0, -40.0) 24.28 m: (empty) | FAIL |
| hk_adv_001 | 12 | 4 | (-14.0, -40.0) 26.52 m: (empty) | match |
| hk_adv_002 | 12 | 4 | (-14.0, -40.0) 24.88 m: (empty) | match |
| hk_adv_003 | 12 | 3 | (-14.0, -40.0) 23.45 m: (empty) | match |
| hk_adv_005 | 12 | 4 | (-14.0, -40.0) 28.41 m: (empty) | match |
| hk_jo_beg_001 | 4 | 0 | (-14.0, -40.0) 21.70 m: (empty) | match |
| hk_jo_int_001 | 4 | 0 | (-14.0, -40.0) 22.04 m: (empty) | match |
| hk_jo_adv_001 | 4 | 0 | (-14.0, -40.0) 23.77 m: (empty) | match |

**The one failure, whole:**

```
AUDITFAIL hk_int_009 | midpoint 2 -> 3 (-7.12, -9.33) | file h=0.76 sp=0.0 | want: Fence 2. plank vertical. 0.76 m. 3 strides to fence 3. | near_line: Fence 10. natural vertical. 0.886 m.
```

- **Why.** hk_int_009 fence 2 (plank vertical, h 0.76, related `to 3, 3 strides, 14.55 m`) to fence 3 is a long three-stride. Fence 10 (natural vertical, h 0.886, yaw 3.23, jumped the other way) stands beside that line, its centre 2.71 m off the segment at t 0.52. The 2 → 3 midpoint (−7.12, −9.33) is 2.72 m from fence 10's centre and **1.21 m from its rail**, standard to standard.
- **So the rule is working.** "At the rail, within 1.5 m, that fence's own line wins" gives fence 10's line: at that spot she is standing at fence 10's standard.
- **Not a `near_line` bug and not a file error.** The course sets fence 10 beside the 2 → 3 line, and the priority puts the rail first. Making the midpoint read fence 2 would mean moving the 1.5 m rail priority, which this job forbids. So **no fix**; it is written here.
- **The rest match:** every other midpoint on the card reads its in-fence's line with the in-fence's h and sp. Every fence reads its own number, h, sp (only when above 0) and stride words. Every far point is empty. Every `related.to` names a fence in its file.

## Phase 2 — the lesson she sits

| course | fences | fence 1 | fence 2 | fence 3 |
| --- | ---: | --- | --- | --- |
| hk_les_001 | 3 | white vertical, 0.422, related null | plank vertical, 0.528, **2 strides to 3 (10.73 m)** | plank vertical, 0.6, null |
| hk_les_002 | 3 | white vertical, 0.419, null | plank vertical, 0.528, **2 strides to 3 (10.81 m)** | plank vertical, 0.606, null |
| hk_les_003 | 3 | white vertical, 0.432, null | plank vertical, 0.514, **2 strides to 3 (10.92 m)** | plank vertical, 0.596, null |
| hk_les_004 | 3 | white vertical, 0.423, null | plank vertical, 0.524, **2 strides to 3 (10.78 m)** | plank vertical, 0.592, null |

Each is a single white vertical, then a two-stride related line of plank verticals, poles to 2'3". The files carry no separate ground pole; the first fence is the single. The ids are on the board, and no fence was moved.

One pin ride, `--ridecert-id=hk_les_001`:

```
MICHELLE soft | Two. Wait.
MICHELLE soft | One. Wait.
MICHELLE soft | One. Early.
MICHELLE soft | Early.
MICHELLE soft | Wait.
MICHELLE soft | Now.
MICHELLE spot | Spot. Sit still on the other side.
MICHELLE soft | One. Wait.
MICHELLE soft | One. Early.
MICHELLE soft | Early.
MICHELLE soft | Wait.
MICHELLE soft | Now.
MICHELLE spot | True leave. He jumped with you.
MICHELLE soft | One. Wait.
MICHELLE soft | One. Early.
MICHELLE soft | Early.
MICHELLE soft | Wait.
MICHELLE soft | Now.
MICHELLE spot | You found it. Don't chase the next.
MICHELLE clear | That's clean. Walk out quiet.
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
```

- **The counts:** she counts him in to every fence ("Two. Wait. / One. Wait. / One. Early. / Early. / Wait. / Now." on fence 1; from "One. Wait." on fences 2 and 3), as before.
- **One sentence after each leave:** "Spot. Sit still on the other side." · "True leave. He jumped with you." · "You found it. Don't chase the next."
- **At the end:** "That's clean. Walk out quiet."
- **The words vary from ride to ride.** The lesson job's ride said "That was the spot." · "You waited, then asked. That's it." · "That's the one. Don't fuss after." The design, one sentence after each leave, holds.

## Phase 3 — the horse she brings home

One fresh ride, `--ridecert-fresh --ridecert-id=hk_les_001`, with a probe in `horse.gd` (removed after). It averaged Neck1 and Tail1 against rest (after the modifiers) over his settled canter before fence 1, and over every frame after the round completed:

```
SCHOOL before-fence-1 (1 s settled canter) conf=48.0 unrest=0.565 neck1=-16.36 tail1=-15.15 gait=3 jumping=false land_recover=0.00 last_stride=0.01 next_fence=1 round_complete=false
SCHOOL leave fence 1 conf=48.0 unrest=0.565 neck1=-12.70 tail1=-0.67 gait=3 jumping=false land_recover=0.00 last_stride=1.00 next_fence=1 round_complete=false settled-canter mean before fence 1: neck1=-3.05 tail1=-10.03 over 85 frames
MICHELLE clear | Clear. Walk him. Let him blow.
SCHOOL after-round frame 1 conf=54.0 unrest=0.438 neck1=+3.14 tail1=-3.23 gait=3 jumping=false land_recover=1.32 last_stride=0.00 next_fence=4 round_complete=true mean_so_far neck1=+3.14 tail1=-3.23 over 1 frames
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=54.0 scope=44.5
SCHOOL after-round frame 10 conf=54.0 unrest=0.438 neck1=-0.65 tail1=-2.98 gait=3 jumping=false land_recover=1.20 last_stride=0.00 next_fence=4 round_complete=true mean_so_far neck1=+1.46 tail1=-2.82 over 10 frames
```

- **The school wrote the stats:** confidence 48.0 → 54.0 and unrest 0.565 → 0.438 on the clear.
- **In-ride, before fence 1:** 85 frames of settled canter at conf 48 average Neck1 −3.05, Tail1 −10.03.
- **In-ride, after the round:** the cert quits after 10 frames, all still in fence 3's landing recovery (land_recover 1.2–1.3), averaging Neck1 +1.46, Tail1 −2.82. **Those ten frames are not a settled stride, so they are not a fair after.**
- **The fair ruler** is the same throwaway scene as `dist/lesson_003.md` (deleted after): one settled stride at day-one's stats against the after-clear stats (54 / 44.5 / 48 / 42 / 39):

```
row=dayone-walk conf=48.0 feel=36.0 neck1=+5.39 tail1=-9.69 ear=-20.25 frames=239
row=afterclear-walk conf=54.0 feel=39.0 neck1=+2.69 tail1=-6.99 ear=-17.85 frames=240
row=dayone-canter conf=48.0 feel=36.0 neck1=-4.86 tail1=-10.39 ear=-3.08 frames=113
row=afterclear-canter conf=54.0 feel=39.0 neck1=-8.00 tail1=-7.92 ear=-0.90 frames=120
```

| stride means | day-one | after the clear | change |
| --- | --- | --- | --- |
| canter Neck1 / Tail1 / Ear1.L | −4.86 / −10.39 / −3.08 | −8.00 / −7.92 / −0.90 | neck **3.14° lower**, tail **2.47°** up, ear 2.18° |
| walk Neck1 / Tail1 / Ear1.L | +5.39 / −9.69 / −20.25 | +2.69 / −6.99 / −17.85 | **2.70°** / **2.70°** / 2.40° |

- **The clear quiets him.** Neither neck nor tail stays within 2° of the start. At normal frame rate the canter neck reaches the −8 the worry weights predict (the lesson job's slow-frame scene read 1.48°).
- **No leak:** the next pin ride:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
```

That is confidence 91.0. `_pin_stats`, `_day_one` and `_school_from_round` are unchanged.

## Phase 4 — the card (`game_state.gd` `result_line`, byte-identical to the lesson job's reading)

| round | numbers | the card says |
| --- | --- | --- |
| a lesson clear | 0 faults, 18.54 s | `Clear.  18.54s` |
| a show clear inside the time | 0 faults, 67.30 s, a new best | `Clear.  Stay for the jump-off.  67.30s` then `Blue ribbon.` |
| a show round with 2 time faults and no rail | 2 faults (both time), 91.60 s | `2 faults   ·   91.60s   ·   2 time faults` then `White ribbon.` |
| a rail on fence 3 | 4 faults, e.g. 67.17 s | `4 faults   ·   67.17s   ·   rail 3` (plus `Yellow ribbon.` in a show) |
| a refusal on fence 1 | 4 faults, e.g. 69.88 s | `4 faults   ·   69.88s   ·   refusal 1` (plus `Yellow ribbon.` in a show) |
| elimination, three refusals | e.g. 45.00 s | `Eliminated  ·  three refusals.  45.00s` |

- **Time faults are never called Clear.** The clear branch needs `last_faults == 0 and time_faults == 0`, and time faults are added into the faults.
- **A lesson never offers a jump-off.** `can_offer_jump_off()` requires a show.
- **A rail names its fence.** `note_rail` appends `next_fence` in the air, before the land moves it on.
- **The card is already true.** Not reworded.

## Phase 5 — which way she is walking

**Her facing, from the source (`walker.gd`):** `rotation.y = yaw`, and W (`gait_up`) moves her along `Basis(Vector3.UP, yaw) * Vector3(0, 0, -1)`. So the way she faces and walks is **`-global_transform.basis.z`**, flattened on Y. It is read off the walker, not guessed.

**Before any code** (one boot, the real `arena.tscn` in walk mode on hk_adv_002, her on the 2 → 3 midpoint facing each way by setting the walker's `yaw`; deleted after):

```
FACING frame 2 Michelle says | Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait.
FACING toward fence 3 set yaw=-3.0816
FACING frame 11 Michelle says | Fence 2. natural vertical. 0.875 m. 1 stride to fence 3.
FACING toward fence 3 facing(-basis.z)=(0.060, 0.998) segment 2->3=(0.060, 0.998) dot=+1.000 | label: Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait. // Fence 2. natural vertical. 0.875 m. 1 stride to fence 3.
FACING toward fence 2 set yaw=0.0600
FACING toward fence 2 facing(-basis.z)=(-0.060, -0.998) segment 2->3=(0.060, 0.998) dot=-1.000 | label: Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait. // Fence 2. natural vertical. 0.875 m. 1 stride to fence 3.
FACING frame 110 moved to the ring (0, -3)
FACING frame 160 ring label: Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait.
```

| facing | facing read (−basis.z) | segment 2 → 3 | dot | toward |
| --- | --- | --- | ---: | --- |
| yaw −3.0816 | (0.060, 0.998) | (0.060, 0.998) | **+1.000** | fence 3, **the out** |
| yaw 0.0600 | (−0.060, −0.998) | (0.060, 0.998) | **−1.000** | fence 2, walking back |

Both facings read the same line before the code, "1 stride to fence 3."

**The code** (`content_library.gd`, `near_line`'s segment branch only; `arena.gd` passes her facing):
- `near_line(c, at, facing = Vector3.ZERO)`. On the related-line branch, when `facing · (to − from) < 0`, the line is `"Walking back. " + the same line`. Toward the out it is unchanged.
- The at-the-rail branch (within 1.5 m) and the 4 m branch never add it.
- With no facing (the audit, or any caller that passes none) nothing changes.
- `arena._walk_near_tick` passes `-walker.global_transform.basis.z`. Turning round on the line changes the line, so Michelle says it once more; standing still, she does not repeat.

**The boot again, after:**

```
FACING frame 2 Michelle says | Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait.
FACING toward fence 3 set yaw=-3.0816
FACING frame 11 Michelle says | Fence 2. natural vertical. 0.875 m. 1 stride to fence 3.
FACING toward fence 3 facing(-basis.z)=(0.060, 0.998) segment 2->3=(0.060, 0.998) dot=+1.000 | label: Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait. // Fence 2. natural vertical. 0.875 m. 1 stride to fence 3.
FACING toward fence 2 set yaw=0.0600
FACING frame 61 Michelle says | Walking back. Fence 2. natural vertical. 0.875 m. 1 stride to fence 3.
FACING toward fence 2 facing(-basis.z)=(-0.060, -0.998) segment 2->3=(0.060, 0.998) dot=-1.000 | label: Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait. // Walking back. Fence 2. natural vertical. 0.875 m. 1 stride to fence 3.
FACING frame 110 moved to the ring (0, -3)
FACING frame 160 ring label: Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait.
FACING at fence 2's rail, facing back toward fence 2 set yaw=0.0600
FACING frame 161 Michelle says | Fence 2. natural vertical. 0.875 m. 1 stride to fence 3.
FACING at fence 2's rail, facing back facing(-basis.z)=(-0.060, -0.998) segment 2->3=(0.060, 0.998) dot=-1.000 | label: Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait. // Fence 2. natural vertical. 0.875 m. 1 stride to fence 3.
```

- **Toward fence 3:** she hears "Fence 2. natural vertical. 0.875 m. 1 stride to fence 3." once, without "Walking back."
- **Turned toward fence 2:** she hears "Walking back. Fence 2. natural vertical. 0.875 m. 1 stride to fence 3." once (frame 61), with no repeat over the next 49 frames.
- **At fence 2's rail, facing back:** the plain fence line. She is at the fence, so no "Walking back."
- **The ring (0, −3):** empty; the course line alone. **Kept.**

**The audit, rerun on this tree** (the same throwaway script, no facing passed):

```
AUDITFAIL hk_int_009 | midpoint 2 -> 3 (-7.12, -9.33) | file h=0.76 sp=0.0 | want: Fence 2. plank vertical. 0.76 m. 3 strides to fence 3. | near_line: Fence 10. natural vertical. 0.886 m.
AUDITCOUNT courses=23 fences=180 related_midpoints=45 failures=1
```

Unchanged: 23 courses, 180 fences, 45 related midpoints, and the one hk_int_009 finding.

## The clocks, once, at the end (phase 5 kept code; nothing else touched a horse)

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.6 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=94.0 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.53 (0, 0), 91.60 (2, 0), 94.00 (3, 0); teleported=false, complete. The pin confidence is 91.0. The hk_les_001 cert log has no walk line, no spread and no "Walking back" (0, 0, 0). No style, board or playtest was run; the between board (21/23, hk_les_001 18.49, hk_int_007 84.94) stands.
