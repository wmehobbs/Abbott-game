# The height in the file

## Step 0 — the height, before the words

`h` is read from each fence's own dictionary in the course JSON, the way the file stores it (`"h": 0.422` in hk_les_001.json, `"h": 0.84` and `"h": 0.875` in hk_adv_002.json). The line comes from `ContentLibrary.near_line` as it is now (throwaway script, deleted after). The h column is the fence that owns the line.

| where | h in the file | position | line now |
| --- | --- | --- | --- |
| hk_les_001 fence 1 | fence 1 h = 0.422 | (-1.13, -19.15) | Fence 1. white vertical. |
| hk_les_001 fence 2 | fence 2 h = 0.528 | (-8.82, -8.60) | Fence 2. plank vertical. 2 strides to fence 3. |
| hk_les_001 midpoint 2 -> 3 | fence 2 h = 0.528 | (-8.55, -3.24) | Fence 2. plank vertical. 2 strides to fence 3. |
| hk_adv_002 fence 1 | fence 1 h = 0.84 | (8.39, -24.95) | Fence 1. white vertical. |
| hk_adv_002 fence 2 | fence 2 h = 0.875 | (-6.98, -16.13) | Fence 2. natural vertical. 1 stride to fence 3. |
| hk_adv_002 midpoint 2 -> 3 | fence 2 h = 0.875 | (-6.76, -12.40) | Fence 2. natural vertical. 1 stride to fence 3. |
| hk_adv_002 fence 3, under a standard | fence 3 h = 0.885 | (-8.06, -8.66) | Fence 3. plank vertical. 2 strides to fence 4. |
| hk_adv_002 ring (0, -3) | — | (0.00, -3.00) | (empty) |
| hk_adv_002 2 -> 3 line, 1.9 m off | fence 2 h = 0.875 | (-4.86, -12.51) | Fence 2. natural vertical. 1 stride to fence 3. |
| hk_adv_002 2 -> 3 line, 2.5 m off | — | (-4.26, -12.55) | (empty) |

- **The two "white vertical" fences differ in their files:** hk_les_001 fence 1 is **0.422** and hk_adv_002 fence 1 is **0.84**. The line reads "Fence 1. white vertical." on both.
- **No fence line carries its height yet**, so the words are the job. hk_adv_002 fence 2 is 0.875 in its file and fence 3 is 0.885.

## The words (`content_library.gd`, `_fence_line` only)

After `Fence {num}. {name}.`, when the fence's own dictionary has `h`, add ` {str(h)} m.`. That is `str()` of the file's own number: metres, not converted, not re-rounded. With no `h`, nothing is added. The stride words follow unchanged (` 1 stride to fence {to}.` / ` {n} strides to fence {to}.`). Which fence owns the line, 4 m, 1.5 m and 2 m are unchanged.

## After (the same probe; throwaway, deleted after)

| where | h in the file | position | line now |
| --- | --- | --- | --- |
| hk_les_001 fence 1 | fence 1 h = 0.422 | (-1.13, -19.15) | Fence 1. white vertical. 0.422 m. |
| hk_les_001 fence 2 | fence 2 h = 0.528 | (-8.82, -8.60) | Fence 2. plank vertical. 0.528 m. 2 strides to fence 3. |
| hk_les_001 midpoint 2 -> 3 | fence 2 h = 0.528 | (-8.55, -3.24) | Fence 2. plank vertical. 0.528 m. 2 strides to fence 3. |
| hk_adv_002 fence 1 | fence 1 h = 0.84 | (8.39, -24.95) | Fence 1. white vertical. 0.84 m. |
| hk_adv_002 fence 2 | fence 2 h = 0.875 | (-6.98, -16.13) | Fence 2. natural vertical. 0.875 m. 1 stride to fence 3. |
| hk_adv_002 midpoint 2 -> 3 | fence 2 h = 0.875 | (-6.76, -12.40) | Fence 2. natural vertical. 0.875 m. 1 stride to fence 3. |
| hk_adv_002 fence 3, under a standard | fence 3 h = 0.885 | (-8.06, -8.66) | Fence 3. plank vertical. 0.885 m. 2 strides to fence 4. |
| hk_adv_002 ring (0, -3) | — | (0.00, -3.00) | (empty) |
| hk_adv_002 2 -> 3 line, 1.9 m off | fence 2 h = 0.875 | (-4.86, -12.51) | Fence 2. natural vertical. 0.875 m. 1 stride to fence 3. |
| hk_adv_002 2 -> 3 line, 2.5 m off | — | (-4.26, -12.55) | (empty) |

- **Each named fence carries its own file's h:** hk_les_001 fence 1 "0.422 m.", and hk_adv_002 fence 1, the other "white vertical", "0.84 m." (its file stores `0.84`, which `str` prints as 0.84).
- **The 2 → 3 midpoint carries fence 2's 0.875, not fence 3's 0.885:** "Fence 2. natural vertical. 0.875 m. 1 stride to fence 3."
- **Fence 3 under a standard** carries its own 0.885 and still says "2 strides to fence 4."
- **The corridor:** 1.9 m off the 2 → 3 line still names that line with fence 2's height. 2.5 m off is empty, and the ring is empty.

## The boot (hk_adv_002 in walk mode, the real `arena.tscn`; throwaway, deleted before any clock)

```
BOOT frame 2 Michelle says | Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait.
BOOT frame 10 course=hk_adv_002, placed on the 2 -> 3 midpoint (-6.76, -12.40)
BOOT frame 11 Michelle says | Fence 2. natural vertical. 0.875 m. 1 stride to fence 3.
BOOT frame 70 walk_hint | Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait. // Fence 2. natural vertical. 0.875 m. 1 stride to fence 3.
BOOT frame 70 moved to the ring (0, -3)
BOOT frame 130 walk_hint | Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait.
```

- **Michelle:** the course line once, then "Fence 2. natural vertical. 0.875 m. 1 stride to fence 3." once, with the height and the stride, and no repeat over the next 59 frames.
- **In the ring (0, −3):** the near-line goes quiet, and the course line stays.

## Three clocks (the height words in, no boot script in the tree)

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.61 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=94.01 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.54 (0, 0), 91.61 (2, 0), 94.01 (3, 0); teleported=false, complete. The pin confidence is 91.0. The hk_les_001 cert log has no walk line and no height words ("<digit> m." appears 0 times). No style, board or playtest was run: the height is not on the cert. The between board (21/23, hk_les_001 18.49, hk_int_007 84.94) stands.
