# Twenty-three walks

## Phase 1 — fence 10 does not take the line (`content_library.gd`, `near_line`)

**Before** (the card night's audit, `dist/card_002.md`):

```
AUDITFAIL hk_int_009 | midpoint 2 -> 3 (-7.12, -9.33) | file h=0.76 sp=0.0 | want: Fence 2. plank vertical. 0.76 m. 3 strides to fence 3. | near_line: Fence 10. natural vertical. 0.886 m.
AUDITCOUNT courses=23 fences=180 related_midpoints=45 failures=1
```

**The change.** The rail claim (her distance to a fence's rail, standard to standard, ≤ `AT_FENCE_M` 1.5) no longer returns first. It is compared with the related-segment claim (her distance to the segment while her closest point lies between the ends, ≤ `LINE_CORRIDOR_M` 2):
- **Both claim her:** the smaller distance wins, and a tie keeps the segment.
- **The segment wins:** its line is the in-fence's, with "Walking back." when she faces the in-fence.
- **Neither claims her:** the old `NEAR_FENCE_M` 4 m nearest-fence rule.
- **Unchanged:** the three distances, the words, the height, the spread and the strides.

**After** (a throwaway script, deleted after):

```
ROW hk_int_009 fence 2 file h = 0.76
ROW hk_int_009 midpoint 2 -> 3 | (-7.12, -9.33) | Fence 2. plank vertical. 0.76 m. 3 strides to fence 3.
ROW hk_int_009 on fence 10 | (-4.40, -9.27) | Fence 10. natural vertical. 0.886 m.
ROW hk_adv_002 fence 3, under a standard | (-8.06, -8.66) | Fence 3. plank vertical. 0.885 m. 2 strides to fence 4.
ROW hk_adv_002 midpoint 2 -> 3 | (-6.76, -12.40) | Fence 2. natural vertical. 0.875 m. 1 stride to fence 3.
ROW hk_adv_002 ring (0, -3) | (0.00, -3.00) | (empty)
```

- **hk_int_009's 2 → 3 midpoint now reads fence 2:** "Fence 2. plank vertical. 0.76 m. 3 strides to fence 3." (the file's h is 0.76). There the segment is about 0 m away and fence 10's rail 1.21 m.
- **Fence 10's own `pos`** is still fence 10 (rail 0 m; the 2 → 3 segment is 2.71 m off, outside 2 m).
- **hk_adv_002:** fence 3 under a standard keeps its own line, and the 2 → 3 midpoint is still fence 2's one stride.
- **The ring** is empty.

**The 45 midpoints and 180 fences again** (the card night's audit script, rerun and deleted):

```
AUDITCOUNT courses=23 fences=180 related_midpoints=45 failures=0
```

**0 failures.** The hk_int_009 row is the one that changed; every row that matched last night still matches.

## Phase 2 — twenty-three walks, one Godot each, in SHIP.json order

Each launch is one course. The boot script is copied into `game/tools/` for that launch only and deleted after it. It loads the real `res://scenes/arena.tscn` in walk mode with that course's class, jump-off flag and seed, the same inputs `ship_course` uses. Then:
- **Fence 1:** it places her on fence 1's `pos` and records the label, plus every time Michelle speaks over the next 0.5 s (read from `trainer_until` jumping up).
- **The out:** it places her on the first related midpoint, facing the out.
- **Walking back:** it turns her on the same spot to face the in-fence.
- **Far:** it places her on a point more than 6 m from every fence.

This block is written after each launch, before the next.

### 1. hk_les_001 (exit 0)

```
MICHELLE soft | Tuesday poles. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line.
WALK id=hk_les_001 loaded=hk_les_001 fences=3 mode=walk
MICHELLE soft | Fence 1. white vertical. 0.422 m.
WALK on fence 1 (then 0.5 s) | label: Tuesday poles. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line. // Fence 1. white vertical. 0.422 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.422 m.
MICHELLE soft | Fence 2. plank vertical. 0.528 m. 2 strides to fence 3.
WALK on the 2 -> 3 midpoint, facing the out (then 0.5 s) | label: Tuesday poles. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line. // Fence 2. plank vertical. 0.528 m. 2 strides to fence 3. | Michelle said 1 time(s): Fence 2. plank vertical. 0.528 m. 2 strides to fence 3.
MICHELLE soft | Walking back. Fence 2. plank vertical. 0.528 m. 2 strides to fence 3.
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Tuesday poles. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line. // Walking back. Fence 2. plank vertical. 0.528 m. 2 strides to fence 3. | Michelle said 1 time(s): Walking back. Fence 2. plank vertical. 0.528 m. 2 strides to fence 3.
WALK far point (14.0, 40.0), 43.96 m from every fence (then 0.5 s) | label: Tuesday poles. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line. | Michelle said 0 time(s): 
```

### 2. hk_les_002 (exit 0)

```
MICHELLE soft | Single then the line. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line.
WALK id=hk_les_002 loaded=hk_les_002 fences=3 mode=walk
MICHELLE soft | Fence 1. white vertical. 0.419 m.
WALK on fence 1 (then 0.5 s) | label: Single then the line. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line. // Fence 1. white vertical. 0.419 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.419 m.
MICHELLE soft | Fence 2. plank vertical. 0.528 m. 2 strides to fence 3.
WALK on the 2 -> 3 midpoint, facing the out (then 0.5 s) | label: Single then the line. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line. // Fence 2. plank vertical. 0.528 m. 2 strides to fence 3. | Michelle said 1 time(s): Fence 2. plank vertical. 0.528 m. 2 strides to fence 3.
MICHELLE soft | Walking back. Fence 2. plank vertical. 0.528 m. 2 strides to fence 3.
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Single then the line. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line. // Walking back. Fence 2. plank vertical. 0.528 m. 2 strides to fence 3. | Michelle said 1 time(s): Walking back. Fence 2. plank vertical. 0.528 m. 2 strides to fence 3.
WALK far point (-14.0, 40.0), 42.78 m from every fence (then 0.5 s) | label: Single then the line. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line. | Michelle said 0 time(s): 
```

### 3. hk_les_003 (exit 0)

```
MICHELLE soft | Right-hand two-stride. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line.
WALK id=hk_les_003 loaded=hk_les_003 fences=3 mode=walk
MICHELLE soft | Fence 1. white vertical. 0.432 m.
WALK on fence 1 (then 0.5 s) | label: Right-hand two-stride. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line. // Fence 1. white vertical. 0.432 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.432 m.
MICHELLE soft | Fence 2. plank vertical. 0.514 m. 2 strides to fence 3.
WALK on the 2 -> 3 midpoint, facing the out (then 0.5 s) | label: Right-hand two-stride. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line. // Fence 2. plank vertical. 0.514 m. 2 strides to fence 3. | Michelle said 1 time(s): Fence 2. plank vertical. 0.514 m. 2 strides to fence 3.
MICHELLE soft | Walking back. Fence 2. plank vertical. 0.514 m. 2 strides to fence 3.
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Right-hand two-stride. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line. // Walking back. Fence 2. plank vertical. 0.514 m. 2 strides to fence 3. | Michelle said 1 time(s): Walking back. Fence 2. plank vertical. 0.514 m. 2 strides to fence 3.
WALK far point (-14.0, 40.0), 44.88 m from every fence (then 0.5 s) | label: Right-hand two-stride. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line. | Michelle said 0 time(s): 
```

### 4. hk_les_004 (exit 0)

```
MICHELLE soft | Center line. poles to 2'3". Left-hand line. Straight and quiet. He'll tell you.
WALK id=hk_les_004 loaded=hk_les_004 fences=3 mode=walk
MICHELLE soft | Fence 1. white vertical. 0.423 m.
WALK on fence 1 (then 0.5 s) | label: Center line. poles to 2'3". Left-hand line. Straight and quiet. He'll tell you. // Fence 1. white vertical. 0.423 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.423 m.
MICHELLE soft | Fence 2. plank vertical. 0.524 m. 2 strides to fence 3.
WALK on the 2 -> 3 midpoint, facing the out (then 0.5 s) | label: Center line. poles to 2'3". Left-hand line. Straight and quiet. He'll tell you. // Fence 2. plank vertical. 0.524 m. 2 strides to fence 3. | Michelle said 1 time(s): Fence 2. plank vertical. 0.524 m. 2 strides to fence 3.
MICHELLE soft | Walking back. Fence 2. plank vertical. 0.524 m. 2 strides to fence 3.
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Center line. poles to 2'3". Left-hand line. Straight and quiet. He'll tell you. // Walking back. Fence 2. plank vertical. 0.524 m. 2 strides to fence 3. | Michelle said 1 time(s): Walking back. Fence 2. plank vertical. 0.524 m. 2 strides to fence 3.
WALK far point (14.0, 40.0), 42.44 m from every fence (then 0.5 s) | label: Center line. poles to 2'3". Left-hand line. Straight and quiet. He'll tell you. | Michelle said 0 time(s): 
```

### 5. hk_beg_035 (exit 0)

```
WALK id=hk_beg_035 loaded=hk_beg_035 fences=8 mode=walk
WALK on fence 1 (then 0.5 s) | label: Welcome Stake, outside. 2'3". Welcome Stake track. School it quiet. Don't make a show of it. // Fence 1. white vertical. 0.58 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.58 m.
WALK on the 3 -> 4 midpoint, facing the out (then 0.5 s) | label: Welcome Stake, outside. 2'3". Welcome Stake track. School it quiet. Don't make a show of it. // Fence 3. flower box. 0.618 m. 2 strides to fence 4. | Michelle said 1 time(s): Fence 3. flower box. 0.618 m. 2 strides to fence 4.
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Welcome Stake, outside. 2'3". Welcome Stake track. School it quiet. Don't make a show of it. // Walking back. Fence 3. flower box. 0.618 m. 2 strides to fence 4. | Michelle said 1 time(s): Walking back. Fence 3. flower box. 0.618 m. 2 strides to fence 4.
WALK far point (-14.0, -40.0), 28.33 m from every fence (then 0.5 s) | label: Welcome Stake, outside. 2'3". Welcome Stake track. School it quiet. Don't make a show of it. | Michelle said 0 time(s): 
```

### 6. hk_beg_039 (exit 0)

```
WALK id=hk_beg_039 loaded=hk_beg_039 fences=8 mode=walk
WALK on fence 1 (then 0.5 s) | label: Left-hand related. 2'3". Outside track. Find the canter and leave him alone to the first. // Fence 1. white vertical. 0.603 m. 2 strides to fence 2. | Michelle said 1 time(s): Fence 1. white vertical. 0.603 m. 2 strides to fence 2.
WALK on the 1 -> 2 midpoint, facing the out (then 0.5 s) | label: Left-hand related. 2'3". Outside track. Find the canter and leave him alone to the first. // Fence 1. white vertical. 0.603 m. 2 strides to fence 2. | Michelle said 0 time(s): 
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Left-hand related. 2'3". Outside track. Find the canter and leave him alone to the first. // Walking back. Fence 1. white vertical. 0.603 m. 2 strides to fence 2. | Michelle said 1 time(s): Walking back. Fence 1. white vertical. 0.603 m. 2 strides to fence 2.
WALK far point (14.0, -40.0), 28.16 m from every fence (then 0.5 s) | label: Left-hand related. 2'3". Outside track. Find the canter and leave him alone to the first. | Michelle said 0 time(s): 
```

### 7. hk_beg_004 (exit 0)

```
WALK id=hk_beg_004 loaded=hk_beg_004 fences=8 mode=walk
WALK on fence 1 (then 0.5 s) | label: One related. 2'3". One related. Don't move on the in. Sit to the out. // Fence 1. white vertical. 0.598 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.598 m.
WALK on the 3 -> 4 midpoint, facing the out (then 0.5 s) | label: One related. 2'3". One related. Don't move on the in. Sit to the out. // Fence 3. natural vertical. 0.609 m. 1 stride to fence 4. | Michelle said 1 time(s): Fence 3. natural vertical. 0.609 m. 1 stride to fence 4.
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: One related. 2'3". One related. Don't move on the in. Sit to the out. // Walking back. Fence 3. natural vertical. 0.609 m. 1 stride to fence 4. | Michelle said 1 time(s): Walking back. Fence 3. natural vertical. 0.609 m. 1 stride to fence 4.
WALK far point (-14.0, -40.0), 25.75 m from every fence (then 0.5 s) | label: One related. 2'3". One related. Don't move on the in. Sit to the out. | Michelle said 0 time(s): 
```

### 8. hk_beg_034 (exit 0)

```
WALK id=hk_beg_034 loaded=hk_beg_034 fences=8 mode=walk
WALK on fence 1 (then 0.5 s) | label: Diagonal and home. 2'3". Outside track. Find the canter and leave him alone to the first. // Fence 1. white vertical. 0.588 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.588 m.
WALK on the 3 -> 4 midpoint, facing the out (then 0.5 s) | label: Diagonal and home. 2'3". Outside track. Find the canter and leave him alone to the first. // Fence 3. flower box. 0.631 m. 2 strides to fence 4. | Michelle said 1 time(s): Fence 3. flower box. 0.631 m. 2 strides to fence 4.
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Diagonal and home. 2'3". Outside track. Find the canter and leave him alone to the first. // Walking back. Fence 3. flower box. 0.631 m. 2 strides to fence 4. | Michelle said 1 time(s): Walking back. Fence 3. flower box. 0.631 m. 2 strides to fence 4.
WALK far point (-14.0, -40.0), 25.48 m from every fence (then 0.5 s) | label: Diagonal and home. 2'3". Outside track. Find the canter and leave him alone to the first. | Michelle said 0 time(s): 
```

### 9. hk_beg_007 (exit 0)

```
WALK id=hk_beg_007 loaded=hk_beg_007 fences=8 mode=walk
WALK on fence 1 (then 0.5 s) | label: Flower off the right. 2'3". Flower off the right. Straight. He looks if you do. // Fence 1. white vertical. 0.613 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.613 m.
WALK on the 2 -> 3 midpoint, facing the out (then 0.5 s) | label: Flower off the right. 2'3". Flower off the right. Straight. He looks if you do. // Fence 2. brush vertical. 0.607 m. 2 strides to fence 3. | Michelle said 1 time(s): Fence 2. brush vertical. 0.607 m. 2 strides to fence 3.
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Flower off the right. 2'3". Flower off the right. Straight. He looks if you do. // Walking back. Fence 2. brush vertical. 0.607 m. 2 strides to fence 3. | Michelle said 1 time(s): Walking back. Fence 2. brush vertical. 0.607 m. 2 strides to fence 3.
WALK far point (-14.0, -40.0), 25.65 m from every fence (then 0.5 s) | label: Flower off the right. 2'3". Flower off the right. Straight. He looks if you do. | Michelle said 0 time(s): 
```

### 10. hk_beg_033 (exit 0)

```
WALK id=hk_beg_033 loaded=hk_beg_033 fences=8 mode=walk
WALK on fence 1 (then 0.5 s) | label: Crossrails, the other lead. 2'3". Long approaches. Half-halt, last stride, then ask. // Fence 1. white vertical. 0.58 m. 1 stride to fence 2. | Michelle said 1 time(s): Fence 1. white vertical. 0.58 m. 1 stride to fence 2.
WALK on the 1 -> 2 midpoint, facing the out (then 0.5 s) | label: Crossrails, the other lead. 2'3". Long approaches. Half-halt, last stride, then ask. // Fence 1. white vertical. 0.58 m. 1 stride to fence 2. | Michelle said 0 time(s): 
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Crossrails, the other lead. 2'3". Long approaches. Half-halt, last stride, then ask. // Walking back. Fence 1. white vertical. 0.58 m. 1 stride to fence 2. | Michelle said 1 time(s): Walking back. Fence 1. white vertical. 0.58 m. 1 stride to fence 2.
WALK far point (-14.0, -40.0), 28.73 m from every fence (then 0.5 s) | label: Crossrails, the other lead. 2'3". Long approaches. Half-halt, last stride, then ask. | Michelle said 0 time(s): 
```

### 11. hk_int_001 (exit 0)

```
WALK id=hk_int_001 loaded=hk_int_001 fences=10 mode=walk
WALK on fence 1 (then 0.5 s) | label: Classic, outside. 2'6". Classic. Keep the outside track. He canters this ring. // Fence 1. white vertical. 0.731 m. 2 strides to fence 2. | Michelle said 1 time(s): Fence 1. white vertical. 0.731 m. 2 strides to fence 2.
WALK on the 1 -> 2 midpoint, facing the out (then 0.5 s) | label: Classic, outside. 2'6". Classic. Keep the outside track. He canters this ring. // Fence 1. white vertical. 0.731 m. 2 strides to fence 2. | Michelle said 0 time(s): 
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Classic, outside. 2'6". Classic. Keep the outside track. He canters this ring. // Walking back. Fence 1. white vertical. 0.731 m. 2 strides to fence 2. | Michelle said 1 time(s): Walking back. Fence 1. white vertical. 0.731 m. 2 strides to fence 2.
WALK far point (-14.0, -40.0), 27.07 m from every fence (then 0.5 s) | label: Classic, outside. 2'6". Classic. Keep the outside track. He canters this ring. | Michelle said 0 time(s): 
```

### 12. hk_int_002 (exit 0)

```
WALK id=hk_int_002 loaded=hk_int_002 fences=10 mode=walk
WALK on fence 1 (then 0.5 s) | label: Related and a rollback. 2'6". One rollback. Sit, turn, and wait — don't chase the leave. // Fence 1. white vertical. 0.76 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.76 m.
WALK on the 3 -> 4 midpoint, facing the out (then 0.5 s) | label: Related and a rollback. 2'6". One rollback. Sit, turn, and wait — don't chase the leave. // Fence 3. flower box. 0.767 m. 2 strides to fence 4. | Michelle said 1 time(s): Fence 3. flower box. 0.767 m. 2 strides to fence 4.
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Related and a rollback. 2'6". One rollback. Sit, turn, and wait — don't chase the leave. // Walking back. Fence 3. flower box. 0.767 m. 2 strides to fence 4. | Michelle said 1 time(s): Walking back. Fence 3. flower box. 0.767 m. 2 strides to fence 4.
WALK far point (14.0, -40.0), 18.17 m from every fence (then 0.5 s) | label: Related and a rollback. 2'6". One rollback. Sit, turn, and wait — don't chase the leave. | Michelle said 0 time(s): 
```

### 13. hk_int_005 (exit 0)

```
WALK id=hk_int_005 loaded=hk_int_005 fences=10 mode=walk
WALK on fence 1 (then 0.5 s) | label: One-stride in the middle. 2'6". Ten fences. One related. Don't cut the corners. // Fence 1. white vertical. 0.754 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.754 m.
WALK on the 2 -> 3 midpoint, facing the out (then 0.5 s) | label: One-stride in the middle. 2'6". Ten fences. One related. Don't cut the corners. // Fence 2. natural vertical. 0.746 m. 2 strides to fence 3. | Michelle said 1 time(s): Fence 2. natural vertical. 0.746 m. 2 strides to fence 3.
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: One-stride in the middle. 2'6". Ten fences. One related. Don't cut the corners. // Walking back. Fence 2. natural vertical. 0.746 m. 2 strides to fence 3. | Michelle said 1 time(s): Walking back. Fence 2. natural vertical. 0.746 m. 2 strides to fence 3.
WALK far point (-14.0, -40.0), 19.24 m from every fence (then 0.5 s) | label: One-stride in the middle. 2'6". Ten fences. One related. Don't cut the corners. | Michelle said 0 time(s): 
```

### 14. hk_int_006 (exit 0)

```
WALK id=hk_int_006 loaded=hk_int_006 fences=10 mode=walk
WALK on fence 1 (then 0.5 s) | label: Diagonal Classic. 2'6". Ten fences. One related. Don't cut the corners. // Fence 1. white vertical. 0.725 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.725 m.
WALK on the 3 -> 4 midpoint, facing the out (then 0.5 s) | label: Diagonal Classic. 2'6". Ten fences. One related. Don't cut the corners. // Fence 3. natural vertical. 0.765 m. 1 stride to fence 4. | Michelle said 1 time(s): Fence 3. natural vertical. 0.765 m. 1 stride to fence 4.
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Diagonal Classic. 2'6". Ten fences. One related. Don't cut the corners. // Walking back. Fence 3. natural vertical. 0.765 m. 1 stride to fence 4. | Michelle said 1 time(s): Walking back. Fence 3. natural vertical. 0.765 m. 1 stride to fence 4.
WALK far point (-14.0, -40.0), 19.37 m from every fence (then 0.5 s) | label: Diagonal Classic. 2'6". Ten fences. One related. Don't cut the corners. | Michelle said 0 time(s): 
```

### 15. hk_int_007 (exit 0)

```
WALK id=hk_int_007 loaded=hk_int_007 fences=10 mode=walk
WALK on fence 1 (then 0.5 s) | label: Inside rollback. 2'6". Classic. Keep the outside track. He canters this ring. // Fence 1. white vertical. 0.724 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.724 m.
WALK on the 2 -> 3 midpoint, facing the out (then 0.5 s) | label: Inside rollback. 2'6". Classic. Keep the outside track. He canters this ring. // Fence 2. brush oxer. 0.747 m. spread 0.467 m. 2 strides to fence 3. | Michelle said 1 time(s): Fence 2. brush oxer. 0.747 m. spread 0.467 m. 2 strides to fence 3.
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Inside rollback. 2'6". Classic. Keep the outside track. He canters this ring. // Walking back. Fence 2. brush oxer. 0.747 m. spread 0.467 m. 2 strides to fence 3. | Michelle said 1 time(s): Walking back. Fence 2. brush oxer. 0.747 m. spread 0.467 m. 2 strides to fence 3.
WALK far point (-14.0, -40.0), 20.99 m from every fence (then 0.5 s) | label: Inside rollback. 2'6". Classic. Keep the outside track. He canters this ring. | Michelle said 0 time(s): 
```

### 16. hk_int_009 (exit 0)

```
WALK id=hk_int_009 loaded=hk_int_009 fences=10 mode=walk
WALK on fence 1 (then 0.5 s) | label: Schooling Jumpers, home. 2'6". Classic. Keep the outside track. He canters this ring. // Fence 1. white vertical. 0.74 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.74 m.
WALK on the 2 -> 3 midpoint, facing the out (then 0.5 s) | label: Schooling Jumpers, home. 2'6". Classic. Keep the outside track. He canters this ring. // Fence 2. plank vertical. 0.76 m. 3 strides to fence 3. | Michelle said 1 time(s): Fence 2. plank vertical. 0.76 m. 3 strides to fence 3.
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Schooling Jumpers, home. 2'6". Classic. Keep the outside track. He canters this ring. // Walking back. Fence 2. plank vertical. 0.76 m. 3 strides to fence 3. | Michelle said 1 time(s): Walking back. Fence 2. plank vertical. 0.76 m. 3 strides to fence 3.
WALK far point (-14.0, -40.0), 24.28 m from every fence (then 0.5 s) | label: Schooling Jumpers, home. 2'6". Classic. Keep the outside track. He canters this ring. | Michelle said 0 time(s): 
```

### 17. hk_adv_001 (exit 0)

```
WALK id=hk_adv_001 loaded=hk_adv_001 fences=12 mode=walk
WALK on fence 1 (then 0.5 s) | label: Mini Prix, related first. 3'0". Open jumpers. Eyes up. Leave with him. // Fence 1. white vertical. 0.84 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.84 m.
WALK on the 3 -> 4 midpoint, facing the out (then 0.5 s) | label: Mini Prix, related first. 3'0". Open jumpers. Eyes up. Leave with him. // Fence 3. white vertical. 0.879 m. 1 stride to fence 4. | Michelle said 1 time(s): Fence 3. white vertical. 0.879 m. 1 stride to fence 4.
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Mini Prix, related first. 3'0". Open jumpers. Eyes up. Leave with him. // Walking back. Fence 3. white vertical. 0.879 m. 1 stride to fence 4. | Michelle said 1 time(s): Walking back. Fence 3. white vertical. 0.879 m. 1 stride to fence 4.
WALK far point (-14.0, -40.0), 26.52 m from every fence (then 0.5 s) | label: Mini Prix, related first. 3'0". Open jumpers. Eyes up. Leave with him. | Michelle said 0 time(s): 
```

### 18. hk_adv_002 (exit 0)

```
WALK id=hk_adv_002 loaded=hk_adv_002 fences=12 mode=walk
WALK on fence 1 (then 0.5 s) | label: Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait. // Fence 1. white vertical. 0.84 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.84 m.
WALK on the 2 -> 3 midpoint, facing the out (then 0.5 s) | label: Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait. // Fence 2. natural vertical. 0.875 m. 1 stride to fence 3. | Michelle said 1 time(s): Fence 2. natural vertical. 0.875 m. 1 stride to fence 3.
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait. // Walking back. Fence 2. natural vertical. 0.875 m. 1 stride to fence 3. | Michelle said 1 time(s): Walking back. Fence 2. natural vertical. 0.875 m. 1 stride to fence 3.
WALK far point (-14.0, -40.0), 24.88 m from every fence (then 0.5 s) | label: Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait. | Michelle said 0 time(s): 
```

### 19. hk_adv_003 (exit 0)

```
WALK id=hk_adv_003 loaded=hk_adv_003 fences=12 mode=walk
WALK on fence 1 (then 0.5 s) | label: Rollback Mini Prix. 3'0". One-stride and home. Don't chip the in. // Fence 1. white vertical. 0.848 m. 1 stride to fence 2. | Michelle said 1 time(s): Fence 1. white vertical. 0.848 m. 1 stride to fence 2.
WALK on the 1 -> 2 midpoint, facing the out (then 0.5 s) | label: Rollback Mini Prix. 3'0". One-stride and home. Don't chip the in. // Fence 1. white vertical. 0.848 m. 1 stride to fence 2. | Michelle said 0 time(s): 
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Rollback Mini Prix. 3'0". One-stride and home. Don't chip the in. // Walking back. Fence 1. white vertical. 0.848 m. 1 stride to fence 2. | Michelle said 1 time(s): Walking back. Fence 1. white vertical. 0.848 m. 1 stride to fence 2.
WALK far point (-14.0, -40.0), 23.45 m from every fence (then 0.5 s) | label: Rollback Mini Prix. 3'0". One-stride and home. Don't chip the in. | Michelle said 0 time(s): 
```

### 20. hk_adv_005 (exit 0)

```
WALK id=hk_adv_005 loaded=hk_adv_005 fences=12 mode=walk
WALK on fence 1 (then 0.5 s) | label: Open Jumpers, long day. 3'0". Twelve. Related early. Don't get busy after the first leave. // Fence 1. white vertical. 0.871 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.871 m.
WALK on the 3 -> 4 midpoint, facing the out (then 0.5 s) | label: Open Jumpers, long day. 3'0". Twelve. Related early. Don't get busy after the first leave. // Fence 3. natural vertical. 0.882 m. 1 stride to fence 4. | Michelle said 1 time(s): Fence 3. natural vertical. 0.882 m. 1 stride to fence 4.
WALK same midpoint, turned to face the in-fence (then 0.5 s) | label: Open Jumpers, long day. 3'0". Twelve. Related early. Don't get busy after the first leave. // Walking back. Fence 3. natural vertical. 0.882 m. 1 stride to fence 4. | Michelle said 1 time(s): Walking back. Fence 3. natural vertical. 0.882 m. 1 stride to fence 4.
WALK far point (-14.0, -40.0), 28.41 m from every fence (then 0.5 s) | label: Open Jumpers, long day. 3'0". Twelve. Related early. Don't get busy after the first leave. | Michelle said 0 time(s): 
```

### 21. hk_jo_beg_001 (exit 0)

```
WALK id=hk_jo_beg_001 loaded=hk_jo_beg_001 fences=4 mode=walk
WALK on fence 1 (then 0.5 s) | label: Jump-off, four. 2'3". Four fences. Don't chase him. The clock is already running. // Fence 1. white vertical. 0.614 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.614 m.
WALK far point (14.0, -40.0), 29.34 m from every fence (then 0.5 s) | label: Jump-off, four. 2'3". Four fences. Don't chase him. The clock is already running. | Michelle said 0 time(s): 
WALK no related line in this course
```

### 22. hk_jo_int_001 (exit 0)

```
WALK id=hk_jo_int_001 loaded=hk_jo_int_001 fences=4 mode=walk
WALK on fence 1 (then 0.5 s) | label: Jump-off, Classic. 2'6". Jump-off. Leave the first, then wait. Don't throw the rest away. // Fence 1. white vertical. 0.757 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.757 m.
WALK far point (14.0, 40.0), 32.14 m from every fence (then 0.5 s) | label: Jump-off, Classic. 2'6". Jump-off. Leave the first, then wait. Don't throw the rest away. | Michelle said 0 time(s): 
WALK no related line in this course
```

### 23. hk_jo_adv_001 (exit 0)

```
WALK id=hk_jo_adv_001 loaded=hk_jo_adv_001 fences=4 mode=walk
WALK on fence 1 (then 0.5 s) | label: Jump-off, Mini Prix. 3'0". Inside turns. Sit. He knows the way home. // Fence 1. white vertical. 0.874 m. | Michelle said 1 time(s): Fence 1. white vertical. 0.874 m.
WALK far point (14.0, 40.0), 33.58 m from every fence (then 0.5 s) | label: Jump-off, Mini Prix. 3'0". Inside turns. Sit. He knows the way home. | Michelle said 0 time(s): 
WALK no related line in this course
```

### The twenty-three, read together

All 23 launches loaded their own id (`loaded=` matches `id=` on every block), exited 0, and deleted their boot before the next.

- **On fence 1:** every course's label is the course line plus fence 1's own line, and Michelle said it once in the next 0.5 s.
- **On a related midpoint facing the out:** the label is the in-fence's line, without "Walking back." Michelle said it once. On hk_beg_039, hk_beg_033, hk_int_001 and hk_adv_003 she said it 0 times there: fence 1 is itself the in-fence of the first related line (1 → 2), so the line does not change from fence 1 to the midpoint, and a line is said once when it changes.
- **Turned to face the in-fence:** the label starts "Walking back.", said once.
- **On the far point:** the near-line is empty, the course line remains, and Michelle says nothing.
- **hk_int_009**, in its own launch: "Fence 2. plank vertical. 0.76 m. 3 strides to fence 3.", not fence 10.
- **The three jump-offs** have no related line; fence 1 and the far point are their rows.

## Phase 3 — the next lesson (`game_state.gd`)

- **`finish_round`:** after the round completes, **only when `session_kind == "lesson"`**, `course_seed += 1`. Schooling and shows do not move it.
- **The save:** `save()` writes `course_seed`, and `load_save()` reads it back. It was not saved before, so every start began at 1.
- **`ride_cert.gd` is unchanged.** It still sets `course_seed` from each spec before it builds.

Four launches, each a separate Godot, each starting a lesson the way `title.gd` `_go_lesson` does (`start_session("lesson", "lesson")`, mode "ride", `change_scene_to_file("res://scenes/arena.tscn")`), with the seed set to 1, 2, 3 and 0. Each prints the loaded course and quits (the throwaway boot is deleted after each):

```
LESSONSTART course_seed=1 session=lesson mode=ride loaded=hk_les_002 name=Single then the line
LESSONSTART course_seed=2 session=lesson mode=ride loaded=hk_les_003 name=Right-hand two-stride
LESSONSTART course_seed=3 session=lesson mode=ride loaded=hk_les_004 name=Center line
LESSONSTART course_seed=0 session=lesson mode=ride loaded=hk_les_001 name=Tuesday poles
```

Four different ids, the four lessons in SHIP.json: seed 1 → hk_les_002, 2 → hk_les_003, 3 → hk_les_004, 0 → hk_les_001 (`seed % 4` into the file's order).

One pin cert, `--ridecert-id=hk_les_001`:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
```

- **The cert is unaffected:** still hk_les_001, clear, 18.54, confidence 91.0, inside 18.50–18.60. The cert set its spec seed 0 before it built.
- **The advance, shown:** the save before this cert had no `course_seed`; after it, `course_seed` is **1**. The lesson round advanced it by one, so the next lesson start from the saved game is hk_les_002.

## Phase 4 — the clocks, the style, the board

Three clocks, once, after the walks and the lesson seed:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.6 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=94.01 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.53 (0, 0), 91.60 (2, 0), 94.01 (3, 0); teleported=false, complete. The pin confidence is 91.0. The hk_les_001 cert log has no walk line, no "Walking back" and no spread (0, 0, 0). (`game/tools/boot_arena.gd` and `boot_horse.gd` are project files from 11–12 Sep, not this night's boots.)

Style, once, `--ridecert-style --ridecert-id=hk_beg_035` (probe on the refusal only, stripped after):

```
PROBE32 refuse t=0.25 conf=85.0 gait=0 neck1=+11.71 tail1=-0.32 ear=+7.68 clip=Idle FFB=0.053/0.053 helmet=+7.01 head_x=+13.96 elbowL=129.98 elbowR=134.21 hip_x=+23.17 unrest=0.180
PROBE32 refuse t=0.80 conf=85.0 gait=0 neck1=+6.60 tail1=-0.16 ear=+6.48 clip=Idle FFB=0.053/0.053 helmet=+10.55 head_x=+6.09 elbowL=127.91 elbowR=131.98 hip_x=+17.05 unrest=0.180
RIDECERT hk_beg_035 style=refuse_early success=true faults=4 jumped=8/8 t=69.88 teleported=false complete=true refused=[1] rail_fences=[] rail_air=[] conf=83.0 scope=82.5
FENCE knock 3 by horse at 9.0,-2.5 next=3 jumping=true
RIDECERT hk_beg_035 style=rail_late success=true faults=4 jumped=8/8 t=67.17 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=81.0
```

- **B:** refused fence 1, 0 rails, Idle, hinds 0.053 / 0.053, 69.88.
- **C:** one rail, the knock on fence 3 with `jumping=true`, in the air, 67.17.

One full `--ridecert`, `board_table.py`. `RIDECERT done pass=false board=21/23 style=true`, 26 rounds in the log (copied to scratch before the playtest). The wrapper kept `dist/ridecert_board.json`, with `GODOT_EXIT 1` because the board is not 23/23.

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
| hk_int_009 | CLEAR | 0 | 10/10 | 85.1 | 90 | — |
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

Against the between board, compared log to log: 25 id/style rows, faults and rails identical, 0 teleported, same 21/23. Worst |Δ| **0.09 s** (`hk_int_009`, 84.99 → 85.08), inside 0.1 s. Next hk_les_001 18.49 → 18.52 and hk_int_002 0.03 s. Neither of tonight's changes can reach a cert round's clock: `near_line` is only called on the walk, and the cert sets `course_seed` from its spec before every build. So this reads as ride-to-ride spread. There are no walk words in the board log. The rail-versus-segment rule and the lesson seed stay.

Headless `--playtest`, this run, after the board log was copied:

```
PLAYTEST begin fences=8
PLAYTEST clear faults=0 complete=true
PLAYTEST refuse faults=4
PLAYTEST rail faults=4
PLAYTEST done pass=true
```
