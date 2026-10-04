# The spread in the file

## Step 0 — the spread, before the words

`h` and `sp` are read from each fence's own dictionary in the course JSON (hk_adv_002.json: every fence has `sp`; the verticals and flower boxes store `0.0`, fences 7 and 11 store `0.659`). The line comes from `ContentLibrary.near_line` as it is now (throwaway script, deleted after). The h and sp columns belong to the fence that owns the line.

| where | h | sp | position | line now |
| --- | --- | --- | --- | --- |
| hk_adv_002 fence 1 | fence 1 h = 0.84 | sp = 0.0 | (8.39, -24.95) | Fence 1. white vertical. 0.84 m. |
| hk_adv_002 fence 7 | fence 7 h = 0.919 | sp = 0.659 | (9.40, 26.00) | Fence 7. brush oxer. 0.919 m. |
| hk_adv_002 fence 11 | fence 11 h = 0.943 | sp = 0.659 | (4.16, -9.10) | Fence 11. plank oxer. 0.943 m. 1 stride to fence 12. |
| hk_adv_002 midpoint 11 -> 12 | fence 11 h = 0.943 | sp = 0.659 | (4.43, -12.81) | Fence 11. plank oxer. 0.943 m. 1 stride to fence 12. |
| hk_les_001 fence 1 | fence 1 h = 0.422 | sp = 0.0 | (-1.13, -19.15) | Fence 1. white vertical. 0.422 m. |
| hk_adv_002 ring (0, -3) | — | — | (0.00, -3.00) | (empty) |

- **The oxers:** hk_adv_002 fence 7 (brush oxer) and fence 11 (plank oxer) both store **sp 0.659**, above 0.
- **The verticals:** fence 1 and hk_les_001 fence 1 store **sp 0.0**.
- **No line contains a spread yet**, so the words are the job.
- **The same number.** The two oxers' files store the same value, so fence 7's spread and fence 11's cannot be told apart by the number. Each line reads its own fence's dictionary, the fence that owns the line.

## The words (`content_library.gd`, `_fence_line` only)

After the height, when the fence's own dictionary has `sp` and it is greater than 0, add ` spread {str(sp)} m.`. That is `str()` of the file's own number: metres, not converted, not re-rounded. A vertical storing `0.0`, or a fence with no `sp`, gets nothing. The order is `Fence {num}. {name}.`, then the height, then the spread, then the stride words (unchanged). Which fence owns the line, 4 m, 1.5 m and 2 m are unchanged.

## After (the same probe; throwaway, deleted after)

| where | h | sp | position | line now |
| --- | --- | --- | --- | --- |
| hk_adv_002 fence 1 | fence 1 h = 0.84 | sp = 0.0 | (8.39, -24.95) | Fence 1. white vertical. 0.84 m. |
| hk_adv_002 fence 7 | fence 7 h = 0.919 | sp = 0.659 | (9.40, 26.00) | Fence 7. brush oxer. 0.919 m. spread 0.659 m. |
| hk_adv_002 fence 11 | fence 11 h = 0.943 | sp = 0.659 | (4.16, -9.10) | Fence 11. plank oxer. 0.943 m. spread 0.659 m. 1 stride to fence 12. |
| hk_adv_002 midpoint 11 -> 12 | fence 11 h = 0.943 | sp = 0.659 | (4.43, -12.81) | Fence 11. plank oxer. 0.943 m. spread 0.659 m. 1 stride to fence 12. |
| hk_les_001 fence 1 | fence 1 h = 0.422 | sp = 0.0 | (-1.13, -19.15) | Fence 1. white vertical. 0.422 m. |
| hk_adv_002 ring (0, -3) | — | — | (0.00, -3.00) | (empty) |

- **Fence 7:** "Fence 7. brush oxer. 0.919 m. spread 0.659 m.", its own height and its own file's spread. Fence 11's file stores the same 0.659, so the two cannot be told apart by the number; each line reads the dictionary of the fence that owns it.
- **The 11 → 12 midpoint:** carries fence 11's 0.943 and 0.659, and still says "1 stride to fence 12."
- **The verticals:** hk_adv_002 fence 1 and hk_les_001 fence 1 keep their height and get no spread words (sp 0.0).
- **The ring:** empty.

## The boot (hk_adv_002 in walk mode, the real `arena.tscn`, her placed on fence 7; throwaway, deleted before any clock)

```
BOOT frame 2 Michelle says | Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait.
BOOT frame 10 course=hk_adv_002, placed on fence 7 (9.40, 26.00)
BOOT frame 11 Michelle says | Fence 7. brush oxer. 0.919 m. spread 0.659 m.
BOOT frame 70 walk_hint | Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait. // Fence 7. brush oxer. 0.919 m. spread 0.659 m.
BOOT frame 70 moved to the ring (0, -3)
BOOT frame 130 walk_hint | Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait.
```

- **Michelle:** the course line once, then "Fence 7. brush oxer. 0.919 m. spread 0.659 m." once (the spread, with the file's number), and no repeat over the next 59 frames.
- **In the ring (0, −3):** the near-line goes quiet, and the course line stays.

## Three clocks (the spread words in, no boot script in the tree)

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.6 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=93.99 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.54 (0, 0), 91.60 (2, 0), 93.99 (3, 0); teleported=false, complete. The pin confidence is 91.0. The hk_les_001 cert log has no walk line and no "spread" (0 and 0 hits). No style, board or playtest was run: the spread is not on the cert. The between board (21/23, hk_les_001 18.49, hk_int_007 84.94) stands.
