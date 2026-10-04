# Hidden K Ride Certificate

Headless rider. Same keys as a person. No teleport. `--playtest` is still the
teleport unit test; `--ridecert` is the real ride.

**Not certified. 21/23. Do not export `dist/Abbott.exe`.**

Leave windows (`horse.gd`, unchanged): TAKEOFF 2.55; lined lateral < 1.20·rs and
ang < 28°·rs; early ahead > TAKEOFF + 1.05·ws; late ahead < TAKEOFF − 0.80·ws;
ideal |ahead − TAKEOFF| ≤ 0.55·ws. Space hold = collect. Space release at canter
= ask.

## The horse the cert rides

`ride_cert.gd` pins **confidence 85, scope 80, rideability 44, timing 38, feel 36**
at the start of every round. It used to pin only confidence and scope, so
`user://abbott_save.json` leaked in — a save drifted to 100/100/100 raises
`turn_scale` from 0.99 to 1.13 and quietly made later tracks in a run easier
than earlier ones. Confidence 85 is the one lift: it makes `_might_look` a flat
p = 0. The board below is the horse a kid gets on a fresh install.

## Board — full `--ridecert`, twice, `teleported=false` on every round

Both runs 21/23. **Zero differences** — same clears, same failures, every time
within 0.1 s.

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
| hk_int_001 | CLEAR | 0 | 10/10 | 90.8 | 90 | — |
| hk_int_002 | CLEAR | 0 | 10/10 | 80.3 | 90 | — |
| hk_int_005 | CLEAR | 0 | 10/10 | 92.3 | 90 | — |
| hk_int_006 | CLEAR | 0 | 10/10 | 79.0 | 90 | — |
| hk_int_007 | CLEAR | 0 | 10/10 | 84.9 | 90 | — |
| hk_int_009 | CLEAR | 0 | 10/10 | 85.0 | 90 | — |
| hk_adv_001 | fail | 2 | 12/12 | 91.6 | 80 | clock only — no rails |
| hk_adv_002 | **CLEAR** | 0 | 12/12 | 83.1 | 80 | — |
| hk_adv_003 | fail | 3 | 12/12 | 94.0 | 80 | clock only — no rails |
| hk_adv_005 | **CLEAR** | 0 | 12/12 | 78.9 | 80 | — |
| hk_jo_beg_001 | CLEAR | 0 | 4/4 | 35.3 | 42 | — |
| hk_jo_int_001 | CLEAR | 0 | 4/4 | 36.5 | 38 | — |
| hk_jo_adv_001 | CLEAR | 0 | 4/4 | 35.8 | 34 | — |

**21/23.** Lessons, all six beginner, all six intermediate, all three jump-offs,
and **two of the four Mini Prix inside the time**. Every round finishes. The two
that fail jump 12/12 clear and lose on the clock alone.

Style on `hk_beg_035`, all three honest, no teleport:

- A clear — 0 faults, 8/8, 67.3 s
- B refuse_early fence 1 then re-approach — 4 faults, refused `[1]`, 8/8, 69.9 s
- C rail_late fence 3 — 4 faults, 1 rail, 8/8, 67.2 s

`--playtest` PASS (clear 0 / refuse 4 / rail 4). `prove_ship.py` PASS.

The board is kept at `dist/ridecert_board.json` (both runs also at
`ridecert_board_runA.json` / `runB.json`); `dist/ridecert_results.json` is
whatever ran last, and a `--ridecert-id` run overwrites it with a 1/1. Render the
table, never type it: `python tools/content_factory/board_table.py`.

## There is no rail left on the board

Last night there was one — `hk_int_001` #9 on the setup path to fence 5. It is
gone, and nothing replaced it. The only knock in a board run is `hk_beg_035`
style C, which is the deliberate `rail_late` and is in the air.

**The cause was not the planner's route. It was the planner's model of a fence.**
`_would_knock` hard-coded a 1.10 m through-depth and ignored `spread`. The real
`Knock` area is `0.35 + spread` deep and sits half a spread back along the
takeoff dir. `hk_int_001` #9 is an **oxer**: the planner thought its plane was
about 0.4 m shallower than it is, so every detour candidate round it scored
clear and he cantered it at 3.9 m/s with `rein=0` — dead straight, never even
turning. Now:

```
box  = fp - d * (spread * 0.5)
thru = 1.10 + spread * 0.5      # 1.10 for a pole, as proven; an oxer is deeper
```

The 1.10 base is left exactly where it was. Deepening *every* fence by 0.125 m
was tried and it cost `hk_jo_adv_001` — see the dead ends.

With the model honest he missed #9 — by refusing and circling, which is correct
riding and cost 12 s and the class its clock (100.7 s against 90). #9 also
needed room: its honest plane left **0.22 m** beside fence 5's approach corridor.
`fix_board_lines.py` opened it (see the fence moves).

## The rider — what changed and why

### The come-again is a committed circle, not a timer

`_reapproach = 2.2` was a timer plus a distance: lock steering at a setup point
for 2.2 s, exit if he happens to be near it, pointing the right way, with room.
It orbited, and every escape hatch tried against it fed it a target it could not
reach. It is gone. In its place, `_cc`:

1. **`away`** — pick one rein at entry (`_cc_begin`: away from the poles, so the
   first thing he does is put the fence behind his shoulder; head-on, toward the
   open side of the ring). Hold it. Sit, so the circle is 3.2 m and not 5.2 m.
   Exit on **heading**: when he is pointing back down the ring (`|err to −d| <
   0.55`).
2. **`again`** — ride back up the line until there is room. Exit on **distance**:
   `along ≥ 12 m` and `on_line < 6 m`. Then re-plan normally.

Each phase has one number that only moves one way — heading, then distance — so
it cannot orbit. Both phases carry a cap (5 s, 11 s) as a backstop, not as the
exit condition. It logs `RIDEAI come again n=… rein=… pos=…`.

### He refuses the plane instead of putting a shoulder through it

With the circle safe, the crooked arrival can do what a person does. At
`along < 4.4 m` with `ang > 26°` at canter he cannot ask — the ask wants ≤ 18°
and lateral ≤ 1.15 m — so he turns away and comes again. This trigger was tried
before against the old `_reapproach` and hung two tracks; against the circle it
is part of what cleared six of the eight.

### He keeps sitting while there is still a turn to make

The single biggest fix, and not where I was looking. Reaching the setup point is
not arriving: he can be standing **on** the line pointing 90° across it, and
that is exactly when the aim error goes quiet. He gave the rein back, wound up
to 5.1 m/s, turned on a 5.2 m circle and met the fence 2.6 m out and 29° crooked.
That is the shoulder-rail. Now, when he is near the line and near the fence, the
sit is held on the heading error **to the line direction**, not to the waypoint.
`hk_beg_034` went from a rail to a clear *and got 8 s faster*; `hk_int_007` from
8 faults to clear.

The sit gate also came down from `speed > 4.5` to `> 3.9` — at 4.34 m/s he still
turns on 4.0 m, which does not fit a nine-metre run onto the line.

### Smaller

- **No unchecked shortcut to the setup.** `_aim_setup` used to return the setup
  point directly when `along > 14`, skipping the obstacle test. That is how he
  cantered through #2 on the way to #10 with seventeen metres still to run.
  `_path_target` hands the setup straight back when the way is clear, so the
  rollback home costs nothing. This cleared `hk_int_002`.
- **He shies off what is straight ahead.** Before the rein can bite he runs
  about one turning radius on. If a standard is in that leg he turns the other
  way and sits. Not a re-route — just don't hit it. This took the last rail off
  `hk_adv_001`.
- Lines up on fence one behind the start flags at the trot (the clock starts at
  the flags); rides the whole 30.48 × 76.20 sand; one hysteretic sit per corner;
  never drops the rein inside another fence's takeoff window; counts the fence he
  is jumping as an obstacle on the way to its own setup; rides around a standard
  on the line home; keeps riding to the spot while still off the line.

### horse.gd — the half-halt is a stride, not a paragraph

`collect_pulse` 1.82 s → **0.95 s**, and `collect_pulse` / `land_recover` /
`halt_sit` take the **strongest single restraint instead of multiplying**.
Multiplied they came to 0.146 of canter — 0.81 m/s, a walk, between the two
elements of a labeled two-stride. No leave window was touched; `present(` and
the takeoff maths are untouched.

## Dead ends — do not put these back

All of these are out of the tree:

1. **Pure pursuit onto the approach line** instead of a setup waypoint —
   `hk_beg_035` 5/8 and a timeout.
2. **Bailing to the old `_reapproach` when crooked** — `hk_int_001` 3/10,
   `hk_int_007` 4/10, infinite orbit. (The same trigger against the *circle*
   works; it was the machine underneath, not the trigger.)
3. **Steering past the wing** — `hk_beg_035` 100 s with a 47 s segment,
   `hk_beg_034` 1/8.
4. **Committing the rein on any big aim error** — fires constantly during normal
   setups, not just in rollbacks: `hk_beg_034` 1/8, `hk_adv_003` a 77 s segment.
5. **Arc-aware path checking** (knee leg + line, used to trigger *and* to reject
   detours) — over-detours: `hk_int_001` picked up a second rail, `hk_adv_001`
   went 105 → 118 s. The narrow version of the same idea — shy off what is
   straight ahead, without re-routing — is in and is good.
6. **Turn-fit scoring** of `_path_target` candidates — did not clear #9, cost
   `hk_int_007`.
7. **Deepening every fence plane by 0.125 m** — cost `hk_jo_adv_001`. The spread
   term alone is what the oxer needed.
8. **The ROOM-scored `--sweep`** — converged, prove green, ride worse
   (002 89.1→108, 003 94→112.4, 005 90.8→108).
9. **Moving the `hk_adv_003` 11→12 labeled pair as a rigid body.** Built and
   ridden (see below). All four candidates legal, band held at exactly 10.800,
   prove green — and all four **slower**: 110.9 / 109.0 / 107.2 / 116.2 against
   94.0. Both fences put back byte-identical. The pair is not where 003's clock
   is.
6. **Scoring detour candidates by whether the turn fits** (`_turn_fits`: reject a
   candidate inside his own turning circle, or whose swept arc drives the
   blocker's plane; score = distance + turn cost). It did not fix `hk_int_001`
   — the rail was the knock *model*, not the route — and it cost `hk_int_007`
   its clear (8 faults, 108 s). Removed; `hk_int_007` came straight back at
   84.8 s.
7. **Deepening every fence's knock plane by 0.125 m** (`thru = (0.35 + spread) *
   0.5 + 1.05`). Physically truer, but it moved him just enough to arrive
   crooked at a `sp=0` flower and cost `hk_jo_adv_001` its clear (8 faults,
   51.2 s). The spread term alone is what the oxer needed; the 1.10 base for a
   plain pole is proven and stays.

## Fence moves — `tools/content_factory/fix_board_lines.py`

Kind counts, heights, spreads and fence numbers untouched. Both copies written
(`game/content/courses/` and `content/courses/`), byte-identical. Bands from
`content/pedagogy/related_distances.md`: 1 = 7.0–7.8, 2 = 10.4–11.2, 3 = 14.0–15.2.
The tool is idempotent — re-running it on the shipped JSON changes nothing.

**Lines that were not a stride.** 6.28 m means he lands 3.5 m past the first and
the second is already under him; 9.4 m is neither a one nor a two. Slid along
their own line to the middle of the nearest band, and labeled:

- `hk_beg_035` 4→5 9.14 → 10.80 (2) · `hk_beg_034` 4→5 12.62 → 10.80 (2)
- `hk_beg_033` 2→3 12.74 → 10.80 (2)
- `hk_int_001` 1→2 9.84 → 10.80 (2), 2→3 6.45 → 7.45 (1)
- `hk_int_002` 4→5 9.31 → 10.80 (2), 8→9 8.26 → 7.45 (1)
- `hk_int_005` 2→3 10.09 → 10.80 (2), 3→4 10.20 → 10.80 (2)
- `hk_int_006` 3→4 8.71 → 7.45 (1), 4→5 12.03 → 10.80 (2)
- `hk_int_007` 2→3 10.00 → 10.80 (2), 3→4 10.02 → 10.80 (2)
- `hk_int_009` 3→4 10.26 → 10.80 (2)
- `hk_adv_001` 3→4 8.62 → 7.45 (1), 4→5 11.87 → 10.80 (2), 10→11 6.54 → 7.45 (1)
- `hk_adv_002` 3→4 9.35 → 10.80 (2), 10→11 9.24 → 10.80 (2), 11→12 8.19 → 7.45 (1)
- `hk_adv_003` 2→3 6.62 → 7.45 (1), 11→12 9.44 → 10.80 (2)
- `hk_adv_005` 3→4 8.08 → 7.45 (1), 4→5 8.06 → 7.45 (1), 9→10 8.60 → 7.45 (1),
  10→11 7.44 → 7.45 (1)

**A third fence parked on somebody else's approach**, moved toward the middle:

- `hk_beg_035` #8 x 8.02 → 5.51 · `hk_beg_034` #8 x 7.24 → 4.67
- `hk_int_001` #8 x −4.35 → −3.11 · `hk_int_007` #10 x −7.68 → −5.82

**Two standards crowding each other.** Sliding a fence to make a real stride can
push it into a fence from the other half of the course; `prove_ship` calls that
at 6.2 m. Opened back up:

- `hk_beg_033` #8 slid 0.83 m along its own line (was 6.12 m from #3)
- `hk_adv_002` #9 slid 1.05 m along its own line (was 5.90 m from #4)
- `hk_adv_001` #2 x −7.34 → −8.01 — it stood 6.28 m from #11, and #11 is pinned
  by the 10→11 one-stride, so the *earlier* fence moved sideways instead. A
  crossing does not care about x; a labeled band does.

**A corridor a horse can ride.** `fix_clashes` used a 2.3 m lateral threshold,
which was calibrated against the knock model that ignored oxer spread. The
planner's plane is 2.35 m half-wide and he has to ride the last three strides
within ~1.2 m of the line, so anything inside 3.55 m of an approach crowds it.
The threshold is now `CORRIDOR = 3.9`. **It has only been applied to
`hk_int_001`** — the rest of the board was not re-swept, because the four
advanced tracks showed that this mover and a yaw pass fight each other:

- `hk_int_001` #9 x 4.40 → 3.92 (it stood 9.9 m out on the approach to #5 with
  0.22 m of margin beside its corridor) and #8 x −3.11 → −2.05. That is the
  whole difference between 100.7 s with a come-again and **90.9 s clear**.

**Two related labels were lies and were dropped, not moved:**

- `hk_adv_001` 7→8 claimed a one-stride at 7.13 m between fences **90° apart** —
  #8 sits 7.0 m to the *side* of #7 and 1.3 m along, so he lands past it every
  time. The class keeps a one-stride at 3→4 and its two-stride at 4→5, so
  "related off the first" still holds.
- `hk_beg_007` 7→8 claimed a three-stride at 15.23 m bending 12.4 m off a 15.2 m
  line — a 55° turn, not a bend. It keeps its bending three at 5→6 (33°).

Earlier moves from `patch_line_clashes.py` are still in place and were not repeated.

## Fence 8 — a fence you land past is not a distance

On all four Mini Prix tracks #7 stood on the right rail at z ≈ 29–30 facing
north, so he landed at z ≈ 32.6–33.6; #8 sat at x ≈ 0, z ≈ 31.4 facing north as
well. The run from #7's landing to #8's takeoff line was **negative** — −1.9,
+2.1, −1.4, −1.4. He was already on its landing side, so every round he turned
round and came again. All four logs showed `RIDEAI come again n=8`.

`tools/content_factory/place_fence.py` searches position and yaw for somewhere
the fence can actually be jumped from. Kind, height, spread and number never
move, no related label is invented, and `prove_ship`'s own rules are **hard
constraints inside the search**, not something to discover afterwards:

- the brief's `run ≥ 8 m` into the fence, and `≥ 5 m` out of it;
- `rules.py`: no >85° turn off the leave direction inside 12 m, and no approach
  from behind or the side (`dot ≥ 0.20`);
- ring bounds, the landing stays on the sand, 6.6 m from every other standard;
- nobody parked in the approach corridor either way;
- nothing standing on the line from this fence's landing to three strides out
  from the next one;
- no unlabeled straight line that fits no band.

Scored with the rider's own rule out of `walk_courses.py` — `run ≥ 1.9·off + 6.5`
— on the leg **in and the leg out**, so opening one does not shut the other.

| id | #8 was | #8 is | run in | run out |
| --- | --- | --- | --- | --- |
| hk_adv_001 | (0.00, 31.44) yaw −0.04 | (−0.60, 20.50) yaw −1.745 | −1.9 → **+9.8** | +5.6 |
| hk_adv_002 | (0.00, 31.22) yaw +0.04 | (−2.10, 29.50) yaw −1.396 | +2.1 → **+10.4** | +21.2 |
| hk_adv_003 | (0.00, 31.46) yaw +0.03 | (−4.60, 29.50) yaw −1.571 | −1.4 → **+12.7** | +21.5 |
| hk_adv_005 | (0.00, 31.59) yaw −0.03 | (−4.10, 29.50) yaw −1.745 | −1.4 → **+12.8** | +18.2 |

`#8` is the only fence that moved on any of the four. No come-again at 8 in any
log now, and no new rail anywhere. It is worth 5–11 s a round:

| id | before | after |
| --- | --- | --- |
| hk_adv_001 | 109.8 (7 faults) | 105.2 (6) |
| hk_adv_002 | 98.5 (4) | **89.1 (2)** |
| hk_adv_003 | 103.9 (5) | 94.0 (3) |
| hk_adv_005 | 102.0 (5) | **90.8 (2)** |

One earlier placement is worth recording because it is the trap: with the out-leg
merely "positive" (≥4 m), `hk_adv_001` #8 went to (−0.60, 20.50) and the line
from its landing out to #9 crossed **#6** — a new rail, 9 faults. The fix was not
a longer out-run (that leaves `hk_adv_001` with no legal placement at all); it
was checking the **path**, which is what `seg_clear` does.

## Two Mini Prix inside the time — the clock as the objective

The geometry sweep converged and made the ride worse, so the objective changed
from the ROOM score to **Godot wall time**. `tools/content_factory/ride_place.py`
takes one fence, asks `place_fence.search` for its top four candidates — the same
hard constraints, nothing relaxed: `prove_ship`'s >85°-in-12 m turn rule and
approach-from-behind, `run ≥ 8` in, `seg_clear` on the path out, ring bounds,
6.6 m separation, corridor, no unlabeled no-band line, 7 m leash, 40° cap from
the shipped yaw — then **writes each one, proves it, and rides it**. A candidate
is kept only if it is faster with **zero rails** and the round completes.
Otherwise the fence goes back exactly where it was.

Which fence: the one on the **slowest `RIDEAI fence n -> n+1` segment**, not the
biggest ROOM line. The sweep already showed those diverge.

| id | fence | candidates ridden | result |
| --- | --- | --- | --- |
| hk_adv_002 | #6 | 1 | keep — 89.13 → 87.33 |
| hk_adv_002 | #7 | 3 | keep — 87.34 → **83.13, 0 faults** |
| hk_adv_005 | #12 | 4 | keep — 90.82 → **79.46, 0 faults** |
| hk_adv_005 | #6 | 1 | keep — 79.45 → 78.91 |
| hk_adv_001 | #12 | 4 | keep — 105.19 → 92.88 |
| hk_adv_001 | #7 | 1 | **discard** — 87.86 s but it put a rail in |
| hk_adv_001 | #2 | 4 | keep — 92.89 → 91.59 |
| hk_adv_003 | #6 | 4 | discard — best 96.43, all slower |
| hk_adv_003 | #7 | 4 | discard — best 95.56, all slower |

`hk_adv_002` **83.1 s clear** and `hk_adv_005` **78.9 s clear**. `hk_adv_001`
105.2 → 91.6. Nothing that already cleared moved by more than 0.1 s.

The discards are the point. `hk_adv_001` #7's only legal candidate was **5 s
faster and rolled a pole** — the geometry score would have taken it. And every
one of `hk_adv_003`'s eight candidates was legal, proved green, and slower.
A placement that reads better does not ride better, and only the ride knows.

Every fence moved tonight is ≤ 40° from its shipped yaw and inside the 7 m
leash. (The larger totals against the pre-pass baseline, 82–98°, are #8's
re-placement from the pass before, which is a different operation — a fence he
was landing past.)

## Dead end 8 — the geometry sweep (kept here so it is not tried again)

The four still lose on the clock alone: 89.1–105.2 s against 80. What is left is
the rail-to-rail crossing — 14–17 m off the line with 2–7 m of run, 8–13 s each,
because the fences are square to the ring.

A joint solver was built and run: `place_fence.py --sweep`, one rule set, one
loop over every eligible crossing on a file until nothing moves, `prove_ship`'s
rules inside the loop, a 7 m leash on position and a **cumulative** 40° cap on
yaw (capping per pass compounds to 74°, which is the mistake from the night
before). It **converged** — `hk_adv_002` and `hk_adv_005` in two passes,
`hk_adv_003` in three, `hk_adv_001` settling with two crossings it could not open
at the leash. `prove_ship` stayed green and no label lied.

**And the ride got worse.** Reverted as a set:

| id | job 1 only | after the sweep |
| --- | --- | --- |
| hk_adv_001 | 105.2 | 100.3 |
| hk_adv_002 | 89.1 | **108.0** |
| hk_adv_003 | 94.0 | **112.4** |
| hk_adv_005 | 90.8 | **108.0** |

The ROOM metric improved on paper on all four and the clock collapsed on three.
`hk_adv_002` segment 10 alone went to 30.4 s. So `run ≥ 1.9·off + 6.5` is a good
*diagnosis* of a crossing and a bad *objective* to optimise: an angled fence that
shortens one correction lengthens the approach to the next one, and the rider
pays for the turn it costs him to get square again. The objective has to be the
clock, not the geometry — which means the loop needs a ride in it, not a metric.

## Not done — hk_adv_001 and hk_adv_003

| id | faults | time / 80 | needs |
| --- | --- | --- | --- |
| hk_adv_001 | 2 | 91.6 | 11.6 s |
| hk_adv_003 | 3 | 94.0 | 14.0 s |

Both jump 12/12 clear. Segment profile now (label = segment **into** that fence):

- `hk_adv_001` 1:3.9 2:8.1 **3:12.3** 4:3.5 5:4.6 6:9.7 **7:12.4** 8:9.6 **9:12.9** 10:5.3 11:3.5 12:5.4
- `hk_adv_003` 1:4.2 2:3.5 3:3.5 4:10.1 5:10.4 **6:11.8** 7:8.2 8:6.6 9:7.5 **10:13.3** **11:17.6** 12:4.5

What is left is pinned or has no legal placement:

- `hk_adv_001` — #9 and #3 are ends of labeled relateds (the 3-stride 9→10 and
  the 2-stride 4→5 chain). #7 was tried and its only candidate railed. #6 has no
  legal placement under the leash.
- `hk_adv_003` — its worst two, **#11 (17.6 s) and #10 (13.3 s)**, are the
  labeled 11→12 two-stride and a fence with no legal placement. #6 and #7 were
  both ridden, four candidates each, all slower. #4 and #5 have no legal
  placement.

So the method is out of moves on these two without unpinning a labeled line,
which would mean re-walking the related itself — a bigger change than moving a
fence, and not one to start at the end of a night.

## The rigid triple — and both clocks say no (23 Sep 2026)

`place_fence.search_triple` is the pair mover with three ends. One rotation
about the centroid, one translation. Both gaps and both relative yaws stay.
Same 0.5 m / 5° grid, same leash, same prove rules. Nothing relaxed.
`ride_ids.py` was not used.

`hk_adv_001` 9–10–11 had one legal pose out of 12615. Ridden: 117.32 s,
13 faults, 1 rail, come-agains at 7, 9 and 11, against a 91.61 s baseline
with 0 rails. Put back byte-identical.

`hk_adv_001` 3–4–5 had zero legal poses (the way out to #6 fails run or
`seg_clear`). Not ridden. Leash not loosened.

#7 is not in a chain of three. Left. `hk_adv_003` #6 and #10 are not in a
chain of three. The only triple on that file is 1–2–3, which does not
contain them, so it was not ridden. The 11–12 pair was not ridden again.

No fence stayed moved. Full `--ridecert` twice after the lesson words:
21/23 both runs, no clear picked up a rail, times within 0.02 s. Detail in
`dist/STATUS.md`.

## The labeled pair moves as one body — and 003 says no

`place_fence.search` returns `[]` for either end of a labeled 1 / 2 / 3, which
is correct: rotating or sliding one end alone walks the band. So the tool grew a
rigid mode. `place_fence.search_pair` rotates both ends about the pair's
midpoint and translates them together, so **the distance and the relative yaw
are preserved by construction** — the band cannot drift. Everything else is the
same hard constraint set as the single-fence search, nothing relaxed: prove's
85°/12 m and `dot ≥ 0.20` on both 10→11 and 11→12, `run ≥ 8` in and `≥ 5` out,
`seg_clear` on the way out of each element, ring, landing on the sand, 6.6 m,
corridor 3.9, no unlabeled no-band line, 7 m leash and 40° cap measured against
**each end's own** shipped pose. `ride_place.py --pair` writes, proves and rides
each candidate and keeps one only if it is faster by ≥ 0.2 s with zero rails.

`hk_adv_003` #11 `(-4.40, -7.94)` + #12 `(-4.12, -18.73)`, gap 10.800:

| cand | #11 | #12 | gap | run in | ride |
| --- | --- | --- | --- | --- | --- |
| 1 | (−7.47, −11.50) | (−1.05, −20.18) | 10.80 | +15.2 | 110.92 s, 7 faults |
| 2 | (−5.17, −13.00) | (−0.35, −22.67) | 10.80 | +14.6 | 109.00 s, 7 faults |
| 3 | (−1.79, −12.66) | (+1.27, −23.01) | 10.80 | +12.5 | 107.17 s, 6 faults |
| 4 | (−4.58, −9.73) | (+1.06, −18.94) | 10.80 | +11.8 | 116.16 s, 9 faults |

Baseline 93.99. Nothing beat it; both fences restored byte-identical and 003
rides back at 93.99. **The 21 never moved** — `hk_adv_003.json` is the only
course file written since board run B, and it is unchanged.

Why it was never going to be the 31 s story: on the **board** ride (not the
stale per-id logs) the pair is cheap — into #11 is 7.5 s with no come-again,
into #12 is 4.6 s. 003's clock is the **12.6 s come-again into #10**, and #10
has no legal solo placement. Moving the out of that rollback was the one legal
lever left, and the ride says it does not move the clock.

## Tools

- `run_ridecert.py [--ridecert-id=<id>]` — the real ride. A full run keeps the
  board at `dist/ridecert_board.json`.
- `ride_ids.py <id> …` — one line per id, log per id in `dist/ridecert_logs/`.
  Kills stray headless Godots first: a killed shell leaves one behind, and two of
  those eating a core apiece turn every wall-clock cap in the cert into a lie.
- `walk_courses.py [<id> …]` — walks the board the way the rider has to, landing
  point to next takeoff. Flags labels that are not a band, lines that fit no
  band, landings off the sand, standards on an approach.
- `fix_board_lines.py [<id> …]` — applies the three fixes above to both copies.
- `board_table.py` — renders the board out of the results JSON.
- `prove_ship.py`, and `Godot --headless --path game -- --playtest`.
