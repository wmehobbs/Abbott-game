# Say stride, say fence

## Step 0 — the words now (`ContentLibrary.near_line` as it is; a throwaway script deleted after)

| where | position | line now |
| --- | --- | --- |
| hk_adv_002 fence 2 | (-6.98, -16.13) | Fence 2. natural vertical. 1 to 3. |
| hk_adv_002 midpoint 2 -> 3 | (-6.76, -12.40) | Fence 2. natural vertical. 1 to 3. |
| hk_adv_002 midpoint 3 -> 4 | (-6.21, -3.27) | Fence 3. plank vertical. 2 to 4. |
| hk_adv_002 fence 3, under a standard | (-8.06, -8.66) | Fence 3. plank vertical. 2 to 4. |
| hk_adv_002 ring (0, -3) | (0.00, -3.00) | (empty) |
| hk_les_001 fence 1 | (-1.13, -19.15) | Fence 1. white vertical. |
| hk_les_001 midpoint 2 -> 3 | (-8.55, -3.24) | Fence 2. plank vertical. 2 to 3. |
| hk_adv_002 2 -> 3 line, 1.9 m off | (-4.86, -12.51) | Fence 2. natural vertical. 1 to 3. |
| hk_adv_002 2 -> 3 line, 2.5 m off | (-4.26, -12.55) | (empty) |

The stride lines read "1 to 3.", "2 to 4." and "2 to 3.", with neither "stride" nor "fence" in them. "1 to 3" reads like fence 1 to fence 3, and the lesson's "2 to 3" reads like fence numbers. **Not already worded, so the words are the job.**

## The words (`content_library.gd`, `_fence_line` only)

When the fence's own `related` is a dictionary, the stride words are now ` 1 stride to fence {to}.` when strides is 1, and ` {strides} strides to fence {to}.` otherwise. They follow `Fence {num}. {name}.` as before. A fence with no related is still `Fence {num}. {name}.` with no stride words. Which fence owns the line, the 4 m rule, the 1.5 m rail and the 2 m corridor are unchanged, and no height was added.

## After (the same probe; throwaway, deleted after)

| where | position | line now |
| --- | --- | --- |
| hk_adv_002 fence 2 | (-6.98, -16.13) | Fence 2. natural vertical. 1 stride to fence 3. |
| hk_adv_002 midpoint 2 -> 3 | (-6.76, -12.40) | Fence 2. natural vertical. 1 stride to fence 3. |
| hk_adv_002 midpoint 3 -> 4 | (-6.21, -3.27) | Fence 3. plank vertical. 2 strides to fence 4. |
| hk_adv_002 fence 3, under a standard | (-8.06, -8.66) | Fence 3. plank vertical. 2 strides to fence 4. |
| hk_adv_002 ring (0, -3) | (0.00, -3.00) | (empty) |
| hk_les_001 fence 1 | (-1.13, -19.15) | Fence 1. white vertical. |
| hk_les_001 midpoint 2 -> 3 | (-8.55, -3.24) | Fence 2. plank vertical. 2 strides to fence 3. |
| hk_adv_002 2 -> 3 line, 1.9 m off | (-4.86, -12.51) | Fence 2. natural vertical. 1 stride to fence 3. |
| hk_adv_002 2 -> 3 line, 2.5 m off | (-4.26, -12.55) | (empty) |

- **2 → 3 midpoint:** "Fence 2. natural vertical. 1 stride to fence 3."
- **3 → 4 midpoint:** "Fence 3. plank vertical. 2 strides to fence 4."
- **The lesson's fence 2:** "Fence 2. plank vertical. 2 strides to fence 3."
- **Unchanged rules:** fence 3 under a standard still names fence 3's own line, now in the new words. 1.9 m off the 2 → 3 line still names it, 2.5 m off is empty, and the ring is empty. Lesson fence 1 has no stride words.

## The boot (hk_adv_002 in walk mode, the real `arena.tscn`; throwaway, deleted before any clock)

```
BOOT frame 2 Michelle says | Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait.
BOOT frame 10 course=hk_adv_002, placed on the 2 -> 3 midpoint (-6.76, -12.40)
BOOT frame 11 Michelle says | Fence 2. natural vertical. 1 stride to fence 3.
BOOT frame 70 walk_hint | Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait. // Fence 2. natural vertical. 1 stride to fence 3.
BOOT frame 70 moved to the ring (0, -3)
BOOT frame 130 walk_hint | Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait.
```

- **Michelle:** the course line once on entering, then "Fence 2. natural vertical. 1 stride to fence 3." once at frame 11, with no repeat over the next 59 frames.
- **In the ring (0, −3):** the near-line goes quiet, and the course line stays.

## Three clocks (the words in, no boot script in the tree)

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.61 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=94.01 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.53 (0, 0), 91.61 (2, 0), 94.01 (3, 0); teleported=false, complete. The pin confidence is 91.0. The hk_les_001 cert log has no walk line and no "stride" (0 and 0 hits). No style, board or playtest was run: the words are not on the cert. The between board (21/23, worst 0.06 s on hk_les_001, hk_int_007 84.94) stands.
