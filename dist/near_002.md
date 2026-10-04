# The fence she is standing next to

## Step 0 — the fences, from the course files

**hk_adv_002** — "Three-stride down the right", 12 fences:

| num | name | kind | height m | pos (x, z) | related |
| ---: | --- | --- | ---: | --- | --- |
| 1 | white vertical | vertical | 0.840 | (8.39, -24.95) | null |
| 2 | natural vertical | vertical | 0.875 | (-6.98, -16.13) | to 3, 1 strides, 7.49 m |
| 3 | plank vertical | vertical | 0.885 | (-6.53, -8.66) | to 4, 2 strides, 10.80 m |
| 4 | plank vertical | vertical | 0.870 | (-5.89, 2.12) | null |
| 5 | flower box | flower | 0.898 | (8.39, 7.88) | null |
| 6 | natural vertical | vertical | 0.893 | (-0.10, 17.00) | null |
| 7 | brush oxer | oxer | 0.919 | (9.40, 26.00) | null |
| 8 | flower box | flower | 0.916 | (-2.10, 29.50) | null |
| 9 | white vertical | vertical | 0.909 | (-4.39, 8.89) | null |
| 10 | flower box | flower | 0.922 | (4.40, 1.70) | to 11, 2 strides, 10.80 m |
| 11 | plank oxer | oxer | 0.943 | (4.16, -9.10) | to 12, 1 strides, 7.45 m |
| 12 | plank vertical | vertical | 0.937 | (4.69, -16.53) | null |

**hk_les_001** — "Tuesday poles", 3 fences:

| num | name | kind | height m | pos (x, z) | related |
| ---: | --- | --- | ---: | --- | --- |
| 1 | white vertical | vertical | 0.422 | (-1.13, -19.15) | null |
| 2 | plank vertical | vertical | 0.528 | (-8.82, -8.60) | to 3, 2 strides, 10.73 m |
| 3 | plank vertical | vertical | 0.600 | (-8.29, 2.11) | null |

**hk_les_002** — "Single then the line", 3 fences:

| num | name | kind | height m | pos (x, z) | related |
| ---: | --- | --- | ---: | --- | --- |
| 1 | white vertical | vertical | 0.419 | (3.10, -19.29) | null |
| 2 | plank vertical | vertical | 0.528 | (8.86, -6.97) | to 3, 2 strides, 10.81 m |
| 3 | plank vertical | vertical | 0.606 | (8.86, 3.85) | null |

**hk_les_003** — "Right-hand two-stride", 3 fences:

| num | name | kind | height m | pos (x, z) | related |
| ---: | --- | --- | ---: | --- | --- |
| 1 | white vertical | vertical | 0.432 | (0.93, -20.95) | null |
| 2 | plank vertical | vertical | 0.514 | (8.22, -9.91) | to 3, 2 strides, 10.92 m |
| 3 | plank vertical | vertical | 0.596 | (8.22, 1.00) | null |

**hk_les_004** — "Center line", 3 fences:

| num | name | kind | height m | pos (x, z) | related |
| ---: | --- | --- | ---: | --- | --- |
| 1 | white vertical | vertical | 0.423 | (-0.62, -19.65) | null |
| 2 | plank vertical | vertical | 0.524 | (-7.92, -7.42) | to 3, 2 strides, 10.78 m |
| 3 | plank vertical | vertical | 0.592 | (-7.38, 3.34) | null |

Today's walk label on hk_adv_002, anywhere on the course (`ContentLibrary.walk_line`, the course line only):

> Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait.

It is the same label beside fence 2 as in the middle of the ring: it does not name the fence.

## The near-line

One function, `ContentLibrary.near_line(course, at) -> String`, in `content_library.gd`. Its input is `Course.loaded` (the dictionary the round built its fences from) and her world position.

- **Which fence:** the nearest fence whose `pos` is within **4 m** of her on the ground plane (height ignored). `const NEAR_FENCE_M := 4.0` sits inside hk_adv_002's 7.45 / 7.49 m one-strides.
- **The line:** `Fence {num}. {name}.`, plus ` {strides} to {to}.` only when that fence's own `related` is not null, with the numbers from the file. Otherwise `""`.
- **What it leaves out:** no `walk_text`, and no course id.
- **`hud.gd`:** `set_walk_mode(on, line)` keeps the course line. `set_walk_near(near)` sets the walk label to the course line, with the near-line on the next line when it is non-empty.
- **`arena.gd`:** `_walk_near_tick()` runs each frame in walk mode and does something only when the near-line changes. When it changes it updates the label, and if the new line is non-empty Michelle says it once (`speak_soft`). Leaving a fence (empty) and coming back says it again. `_enter_walk` still says the course line once, and resets the near-line.
- **Unchanged:** WASD, the walker, the horse, the course files, `walk_line`, `Course.loaded`.

## Every fence, headless (her position on each fence's `pos`; a throwaway script deleted after)

| course | her position | nearest fence (m) | next nearest (m) | near-line |
| --- | --- | --- | --- | --- |
| hk_adv_002 | on fence 1 (8.39, -24.95) | 1 (0.00) | 12 (9.19) | Fence 1. white vertical. |
| hk_adv_002 | on fence 2 (-6.98, -16.13) | 2 (0.00) | 3 (7.49) | Fence 2. natural vertical. 1 to 3. |
| hk_adv_002 | on fence 3 (-6.53, -8.66) | 3 (0.00) | 2 (7.49) | Fence 3. plank vertical. 2 to 4. |
| hk_adv_002 | on fence 4 (-5.89, 2.12) | 4 (0.00) | 9 (6.93) | Fence 4. plank vertical. |
| hk_adv_002 | on fence 5 (8.39, 7.88) | 5 (0.00) | 10 (7.36) | Fence 5. flower box. |
| hk_adv_002 | on fence 6 (-0.10, 17.00) | 6 (0.00) | 9 (9.18) | Fence 6. natural vertical. |
| hk_adv_002 | on fence 7 (9.40, 26.00) | 7 (0.00) | 8 (12.02) | Fence 7. brush oxer. |
| hk_adv_002 | on fence 8 (-2.10, 29.50) | 8 (0.00) | 7 (12.02) | Fence 8. flower box. |
| hk_adv_002 | on fence 9 (-4.39, 8.89) | 9 (0.00) | 4 (6.93) | Fence 9. white vertical. |
| hk_adv_002 | on fence 10 (4.40, 1.70) | 10 (0.00) | 5 (7.36) | Fence 10. flower box. 2 to 11. |
| hk_adv_002 | on fence 11 (4.16, -9.10) | 11 (0.00) | 12 (7.45) | Fence 11. plank oxer. 1 to 12. |
| hk_adv_002 | on fence 12 (4.69, -16.53) | 12 (0.00) | 11 (7.45) | Fence 12. plank vertical. |
| hk_les_001 | on fence 1 (-1.13, -19.15) | 1 (0.00) | 2 (13.05) | Fence 1. white vertical. |
| hk_les_001 | on fence 2 (-8.82, -8.60) | 2 (0.00) | 3 (10.73) | Fence 2. plank vertical. 2 to 3. |
| hk_les_001 | on fence 3 (-8.28, 2.11) | 3 (0.00) | 2 (10.73) | Fence 3. plank vertical. |
| hk_les_002 | on fence 1 (3.10, -19.29) | 1 (0.00) | 2 (13.60) | Fence 1. white vertical. |
| hk_les_002 | on fence 2 (8.86, -6.97) | 2 (0.00) | 3 (10.81) | Fence 2. plank vertical. 2 to 3. |
| hk_les_002 | on fence 3 (8.86, 3.85) | 3 (0.00) | 2 (10.81) | Fence 3. plank vertical. |
| hk_les_003 | on fence 1 (0.93, -20.94) | 1 (0.00) | 2 (13.22) | Fence 1. white vertical. |
| hk_les_003 | on fence 2 (8.22, -9.91) | 2 (0.00) | 3 (10.92) | Fence 2. plank vertical. 2 to 3. |
| hk_les_003 | on fence 3 (8.22, 1.00) | 3 (0.00) | 2 (10.92) | Fence 3. plank vertical. |
| hk_les_004 | on fence 1 (-0.63, -19.65) | 1 (0.00) | 2 (14.24) | Fence 1. white vertical. |
| hk_les_004 | on fence 2 (-7.92, -7.42) | 2 (0.00) | 3 (10.78) | Fence 2. plank vertical. 2 to 3. |
| hk_les_004 | on fence 3 (-7.38, 3.34) | 3 (0.00) | 2 (10.78) | Fence 3. plank vertical. |

- **Every row names its own fence.**
- **hk_adv_002 fence 2** reads "Fence 2. natural vertical. **1 to 3.**"
- **Its out, fence 3,** does not claim that stride. Its own `related` is `to 4, 2 strides`, so it reads "2 to 4.", which is its own line from the file.
- **hk_adv_002 fences 10 and 11** read "2 to 11." and "1 to 12.", their own lines. Fence 12, the out, has none.
- **Each lesson:** fence 1 names no stride, fence 2 reads "2 to 3." and fence 3 names none.

**The middle of the ring** (hk_adv_002, a point more than 4 m from every fence):

| her position | nearest fence (m) | next nearest (m) | near-line | walk label |
| --- | --- | --- | --- | --- |
| (0.00, -3.00) | 10 (6.44) | 11 (7.38) | (empty) | Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait. |

Beside no fence: the near-line is empty, and the label is the course line only.

**The midpoint of hk_adv_002 fence 2 → fence 3:**

| her position | fence 3 (m) | fence 2 (m) | near-line |
| --- | --- | --- | --- |
| (-6.76, -12.40) | 3.74 | 3.74 | Fence 3. plank vertical. 2 to 4. |

- **Both fences claim her.** 7.49 m / 2 = 3.745 m, so the midpoint is inside 4 m of both, and to two decimals it is an exact tie.
- **How the tie breaks.** The function keeps the nearest with `d <= best`, so on an exact tie the later fence in the file wins, here fence 3. One step toward either fence makes that fence the nearer one and the line.
- **4 m was not widened.**

## The walk boot (headless, a throwaway script deleted before any clock)

It sets `start_session("lesson", "lesson")`, `course_seed = 0` and mode "walk", then loads the real `res://scenes/arena.tscn`. On frame 10 it sets the walker on fence 1's `pos`; on frame 40 it prints:

```
MICHELLE soft | Tuesday poles. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line.
NEARBOOT placed on fence 1 at (-1.13, -19.15), course=hk_les_001
MICHELLE soft | Fence 1. white vertical.
NEARBOOT mode=walk walker=(-1.13, -19.15)
NEARBOOT walk_hint | Tuesday poles. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line. // Fence 1. white vertical.
NEARBOOT trainer_line | Fence 1. white vertical.
```

- **The label:** the course line, then "Fence 1. white vertical." on the next line.
- **Michelle:** she said the course line once (on entering the walk) and the near-line once (when she arrived beside fence 1). The near-line was not repeated over the next 30 frames.


## Three clocks (the near-line in, no probe or boot in the tree)

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.6 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=94.02 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.54 (0, 0), 91.60 (2, 0), 94.02 (3, 0); teleported=false, complete. The pin confidence is 91.0. The hk_les_001 cert log has no walk line and no near-line (0 hits): a cert round never enters the walk.

## Style, once, `--ridecert-style --ridecert-id=hk_beg_035` (probe on the refusal only, stripped after)

```
PROBE32 refuse t=0.25 conf=85.0 gait=0 neck1=+11.72 tail1=-0.32 ear=+7.73 clip=Idle FFB=0.053/0.053 helmet=+6.95 head_x=+14.10 elbowL=129.98 elbowR=134.20 hip_x=+23.13 unrest=0.180
PROBE32 refuse t=0.80 conf=85.0 gait=0 neck1=+6.60 tail1=-0.16 ear=+6.48 clip=Idle FFB=0.053/0.053 helmet=+10.51 head_x=+6.18 elbowL=127.96 elbowR=132.03 hip_x=+17.13 unrest=0.180
RIDECERT hk_beg_035 style=refuse_early success=true faults=4 jumped=8/8 t=69.88 teleported=false complete=true refused=[1] rail_fences=[] rail_air=[] conf=83.0 scope=82.5
FENCE knock 3 by horse at 9.0,-2.5 next=3 jumping=true
RIDECERT hk_beg_035 style=rail_late success=true faults=4 jumped=8/8 t=67.16 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=81.0
```

- **B:** refused fence 1, 0 rails, Idle, hinds 0.053 / 0.053, Neck1 +11.72, Tail1 −0.32, 69.88.
- **C:** one rail, the knock on fence 3 with `jumping=true`, in the air, 67.16.
- **Style does not enter the walk:** there is no walk line or near-line in its log.

## Board — one full `--ridecert`, `board_table.py`

`RIDECERT done pass=false board=21/23 style=true`, 26 rounds in the log (copied to scratch before the playtest). The wrapper kept `dist/ridecert_board.json`, with `GODOT_EXIT 1` because the board is not 23/23.

| id | result | faults | jumped | time_s | allowed | why |
| --- | --- | --- | --- | --- | --- | --- |
| hk_les_001 | CLEAR | 0 | 3/3 | 18.6 | — | — |
| hk_les_002 | CLEAR | 0 | 3/3 | 16.5 | — | — |
| hk_les_003 | CLEAR | 0 | 3/3 | 18.2 | — | — |
| hk_les_004 | CLEAR | 0 | 3/3 | 18.0 | — | — |
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
| hk_int_007 | CLEAR | 0 | 10/10 | 85.0 | 90 | — |
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

Against the walk board, compared log to log: 25 id/style rows, faults and rails identical, 0 teleported, same 21/23. Worst |Δ| **0.03 s** (`hk_int_007` 84.93 → 84.96, `hk_int_002` 80.34 → 80.31). No walk line or near-line appears anywhere in the board log. The near-line stays.

## Playtest — headless `--playtest`, this run, after the board log was copied

```
PLAYTEST begin fences=8
PLAYTEST clear faults=0 complete=true
PLAYTEST refuse faults=4
PLAYTEST rail faults=4
PLAYTEST done pass=true
```
