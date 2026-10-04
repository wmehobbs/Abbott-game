# The line under her feet

## Step 0 — what `near_line` says now (called, headless; a throwaway script deleted after)

Every point runs through today's `ContentLibrary.near_line(course, at)`: the nearest fence within 4 m, and that fence's own related or none. The last column is each fence within 8 m of the point.

| course | where | position | near_line now | fences near (m) |
| --- | --- | --- | --- | --- |
| hk_adv_002 | on fence 2 | (-6.98, -16.13) | Fence 2. natural vertical. 1 to 3. | f2 0.00, f3 7.49 |
| hk_adv_002 | midpoint 2 -> 3 | (-6.76, -12.40) | Fence 3. plank vertical. 2 to 4. | f2 3.74, f3 3.74 |
| hk_adv_002 | on fence 3 | (-6.53, -8.66) | Fence 3. plank vertical. 2 to 4. | f2 7.49, f3 0.00 |
| hk_adv_002 | midpoint 3 -> 4 | (-6.21, -3.27) | (empty) | f3 5.40, f4 5.40 |
| hk_adv_002 | on fence 10 | (4.40, 1.70) | Fence 10. flower box. 2 to 11. | f5 7.36, f10 0.00 |
| hk_adv_002 | midpoint 10 -> 11 | (4.28, -3.70) | (empty) | f10 5.40, f11 5.40 |
| hk_adv_002 | midpoint 11 -> 12 | (4.43, -12.81) | Fence 12. plank vertical. | f11 3.73, f12 3.73 |
| hk_adv_002 | middle of the ring | (0.00, -3.00) | (empty) | f4 7.80, f10 6.44, f11 7.38 |
| hk_les_001 | midpoint 2 -> 3 | (-8.55, -3.24) | (empty) | f2 5.36, f3 5.36 |
| hk_les_002 | midpoint 2 -> 3 | (8.86, -1.56) | (empty) | f2 5.41, f3 5.41 |
| hk_les_003 | midpoint 2 -> 3 | (8.22, -4.46) | (empty) | f2 5.46, f3 5.46 |
| hk_les_004 | midpoint 2 -> 3 | (-7.65, -2.04) | (empty) | f2 5.39, f3 5.39 |

- **At the fences, the rule is right:** fence 2 "1 to 3.", fence 3 "2 to 4.", fence 10 "2 to 11.", and the ring (0, −3) is empty.
- **Between them it is wrong or empty.**
  - The 2 → 3 midpoint (3.745 m from both) reads **fence 3's line "2 to 4."**, not the one-stride she is standing on.
  - The 11 → 12 midpoint (3.73 m from both) reads **"Fence 12. plank vertical."**, the out, with no stride.
  - The two-stride midpoints (hk_adv_002 3 → 4 and 10 → 11, and every lesson's 2 → 3, 5.36–5.46 m from both ends) are **empty**, just the course line.
- **Phase 1 is the job.**

## Phase 1 — name the segment she is on (`content_library.gd`, inside `near_line`)

`near_line(course, at)` keeps its signature and its caller (`arena._walk_near_tick`, which speaks once when the line changes). The label is still the course line, with this line under it. `NEAR_FENCE_M` stays 4. The rule, in this order:

1. **At a fence:** her ground distance to the fence **itself**, its rail from standard to standard, is ≤ `AT_FENCE_M` 1.5 m. That fence's own line.
   - **Why the rail and not the centre.** The fences are 3.05 m wide (`course.gd`'s default, and the files carry no width), so a standard sits 1.525 m from the centre. Measured to the centre, "under fence 3's standard" would fall 0.025 m outside 1.5 m, and the 2 → 3 corridor would take it. Measured to the rail, the standard is at 0 m.
2. **On one related line:** otherwise, a segment from a fence to the fence its own `related.to` names, where her closest point lies strictly between the two ends and within `LINE_CORRIDOR_M` 2 m on the ground. The line is `Fence {from}. {name}. {strides} to {to}.`, from the in-fence. If two segments claim her, the one she is closer to wins.
3. **Otherwise:** today's rule, the nearest fence within 4 m with its own related or none, or empty.

The same probe after (throwaway, deleted), with extra rows at fence 3's standards, the corridor edge, and each lesson's fence 1 and fence 3:

| course | where | position | near_line after | fences near (m) |
| --- | --- | --- | --- | --- |
| hk_adv_002 | on fence 2 | (-6.98, -16.13) | Fence 2. natural vertical. 1 to 3. | f2 0.00, f3 7.49 |
| hk_adv_002 | midpoint 2 -> 3 | (-6.76, -12.40) | Fence 2. natural vertical. 1 to 3. | f2 3.74, f3 3.74 |
| hk_adv_002 | on fence 3 | (-6.53, -8.66) | Fence 3. plank vertical. 2 to 4. | f2 7.49, f3 0.00 |
| hk_adv_002 | midpoint 3 -> 4 | (-6.21, -3.27) | Fence 3. plank vertical. 2 to 4. | f3 5.40, f4 5.40 |
| hk_adv_002 | on fence 10 | (4.40, 1.70) | Fence 10. flower box. 2 to 11. | f5 7.36, f10 0.00 |
| hk_adv_002 | midpoint 10 -> 11 | (4.28, -3.70) | Fence 10. flower box. 2 to 11. | f10 5.40, f11 5.40 |
| hk_adv_002 | midpoint 11 -> 12 | (4.43, -12.81) | Fence 11. plank oxer. 1 to 12. | f11 3.73, f12 3.73 |
| hk_adv_002 | middle of the ring | (0.00, -3.00) | (empty) | f4 7.80, f10 6.44, f11 7.38 |
| hk_adv_002 | fence 3, left standard | (-8.06, -8.66) | Fence 3. plank vertical. 2 to 4. | f2 7.55, f3 1.52 |
| hk_adv_002 | fence 3, right standard | (-5.01, -8.66) | Fence 3. plank vertical. 2 to 4. | f2 7.73, f3 1.53 |
| hk_adv_002 | 2 -> 3 line, 1.9 m to the side of the midpoint | (-4.86, -12.51) | Fence 2. natural vertical. 1 to 3. | f2 4.20, f3 4.20 |
| hk_adv_002 | 2 -> 3 line, 2.5 m to the side of the midpoint | (-4.26, -12.55) | (empty) | f2 4.50, f3 4.50 |
| hk_adv_002 | 2 -> 3 line, 1 m short of fence 3 (on the line) | (-6.59, -9.66) | Fence 3. plank vertical. 2 to 4. | f2 6.49, f3 1.00 |
| hk_les_001 | midpoint 2 -> 3 | (-8.55, -3.24) | Fence 2. plank vertical. 2 to 3. | f2 5.36, f3 5.36 |
| hk_les_001 | on fence 3 | (-8.28, 2.11) | Fence 3. plank vertical. | f3 0.00 |
| hk_les_001 | on fence 1 | (-1.13, -19.15) | Fence 1. white vertical. | f1 0.00 |
| hk_les_002 | midpoint 2 -> 3 | (8.86, -1.56) | Fence 2. plank vertical. 2 to 3. | f2 5.41, f3 5.41 |
| hk_les_002 | on fence 3 | (8.86, 3.85) | Fence 3. plank vertical. | f3 0.00 |
| hk_les_002 | on fence 1 | (3.10, -19.29) | Fence 1. white vertical. | f1 0.00 |
| hk_les_003 | midpoint 2 -> 3 | (8.22, -4.46) | Fence 2. plank vertical. 2 to 3. | f2 5.46, f3 5.46 |
| hk_les_003 | on fence 3 | (8.22, 1.00) | Fence 3. plank vertical. | f3 0.00 |
| hk_les_003 | on fence 1 | (0.93, -20.94) | Fence 1. white vertical. | f1 0.00 |
| hk_les_004 | midpoint 2 -> 3 | (-7.65, -2.04) | Fence 2. plank vertical. 2 to 3. | f2 5.39, f3 5.39 |
| hk_les_004 | on fence 3 | (-7.38, 3.34) | Fence 3. plank vertical. | f3 0.00 |
| hk_les_004 | on fence 1 | (-0.63, -19.65) | Fence 1. white vertical. | f1 0.00 |

- **The 2 → 3 midpoint reads "Fence 2. natural vertical. 1 to 3."**, the one-stride she is on. **The 3 → 4 midpoint reads "Fence 3. plank vertical. 2 to 4."** The 10 → 11 and 11 → 12 midpoints read their in-fences' "2 to 11." and "1 to 12."
- **At the fences:** fence 2 is still "1 to 3.", and fence 3 is still "2 to 4." under either standard (1.52 m from its centre, 0 m from its rail). One metre short of fence 3 on the 2 → 3 line is fence 3's own line: she is at the standard.
- **The corridor:** 1.9 m to the side of the 2 → 3 midpoint is still on the line. 2.5 m to the side is empty (4.50 m from both fences). The ring at (0, −3) is still empty.
- **The lessons:** each fence-2 midpoint reads "Fence 2. plank vertical. 2 to 3." Each fence 3 (the out) reads its own line with no stride, and each fence 1 has none.

**The boot** (headless, a throwaway script deleted before any clock): the real `arena.tscn` in walk mode, school class "advanced" with `course_seed` 1, which is hk_adv_002. She is set on the 2 → 3 midpoint at frame 10 and moved to the ring at frame 70. The script prints a line each time Michelle speaks, detected by `trainer_until` jumping up. `speak_soft` prints its `MICHELLE soft` line only in a lesson, so on this school course the speech is read from `trainer_line`.

```
BOOT frame 2 Michelle says | Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait.
BOOT frame 10 course=hk_adv_002, placed on the 2 -> 3 midpoint (-6.76, -12.40)
BOOT frame 11 Michelle says | Fence 2. natural vertical. 1 to 3.
BOOT frame 70 walk_hint | Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait. // Fence 2. natural vertical. 1 to 3.
BOOT frame 70 moved to the ring (0, -3)
BOOT frame 130 walk_hint | Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait.
```

- **Michelle, course line:** once, on entering the walk.
- **Michelle, the midpoint:** "Fence 2. natural vertical. 1 to 3." once, at frame 11 when she arrived, with no repeat over the next 59 frames.
- **In the ring:** the near-line goes quiet, and the label is the course line alone.


## Three clocks (the segment rule in, no probe or boot in the tree)

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.61 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=94.0 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.54 (0, 0), 91.61 (2, 0), 94.00 (3, 0); teleported=false, complete. The pin confidence is 91.0. The hk_les_001 cert log has no walk line or fence line (0 hits).

## Style, once, `--ridecert-style --ridecert-id=hk_beg_035` (probe on the refusal only, stripped after)

```
PROBE32 refuse t=0.25 conf=85.0 gait=0 neck1=+11.72 tail1=-0.31 ear=+7.87 clip=Idle FFB=0.053/0.053 helmet=+7.16 head_x=+13.63 elbowL=129.98 elbowR=134.20 hip_x=+23.27 unrest=0.180
PROBE32 refuse t=0.80 conf=85.0 gait=0 neck1=+6.60 tail1=-0.16 ear=+6.49 clip=Idle FFB=0.053/0.053 helmet=+10.58 head_x=+6.02 elbowL=128.05 elbowR=132.13 hip_x=+17.36 unrest=0.180
RIDECERT hk_beg_035 style=refuse_early success=true faults=4 jumped=8/8 t=69.87 teleported=false complete=true refused=[1] rail_fences=[] rail_air=[] conf=83.0 scope=82.5
FENCE knock 3 by horse at 9.0,-2.5 next=3 jumping=true
RIDECERT hk_beg_035 style=rail_late success=true faults=4 jumped=8/8 t=67.17 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=81.0
```

- **B:** refused fence 1, 0 rails, Idle, hinds 0.053 / 0.053, 69.87.
- **C:** one rail, the knock on fence 3 with `jumping=true`, in the air, 67.17.
- **No walk line** in the style log.

## Board — one full `--ridecert`, `board_table.py`

`RIDECERT done pass=false board=21/23 style=true`, 26 rounds in the log (copied to scratch before the playtest). The wrapper kept `dist/ridecert_board.json`, with `GODOT_EXIT 1` because the board is not 23/23.

| id | result | faults | jumped | time_s | allowed | why |
| --- | --- | --- | --- | --- | --- | --- |
| hk_les_001 | CLEAR | 0 | 3/3 | 18.5 | — | — |
| hk_les_002 | CLEAR | 0 | 3/3 | 16.6 | — | — |
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

Against the near board, compared log to log: 25 id/style rows, faults and rails identical, 0 teleported, same 21/23. Worst |Δ| **0.06 s** (`hk_les_001`, 18.55 → 18.49). hk_int_007 is 84.94. No walk line appears anywhere in the board log. The segment rule stays.

## Playtest — headless `--playtest`, this run, after the board log was copied

```
PLAYTEST begin fences=8
PLAYTEST clear faults=0 complete=true
PLAYTEST refuse faults=4
PLAYTEST rail faults=4
PLAYTEST done pass=true
```
