# Hidden K — ride cert status

**21/23, twice, zero differences. Not certified. Do not export `dist/Abbott.exe`.**

`--playtest` PASS (clear 0 / refuse 4 / rail 4). `prove_ship.py` PASS.
`--ridecert` is real: `Input.action_press` only, no `present(`, one
`global_position = course.start_pos` per round. All 23 rounds finish.
`teleported=false` on every round of both runs. Style A/B/C on `hk_beg_035`
honest. **No rail anywhere on the board** — the only knock in a board run is
style C's deliberate `rail_late`, in the air.

Lessons, all six beginner, all six intermediate, all three jump-offs, and **two
of the four Mini Prix inside the time**. The 19 that already cleared are
unchanged to 0.1 s.

Detail and the dead ends: `dist/RIDE_CERT.md`. Numbers out of
`dist/ridecert_board.json` via `python tools/content_factory/board_table.py` —
none typed by hand. Both runs at `ridecert_board_runA.json` / `runB.json`.

## What moved: the clock became the objective

The geometry sweep converged and made the ride worse, so the score changed to
Godot wall time. `tools/content_factory/ride_place.py` takes **one** fence —
the one on the slowest `RIDEAI fence n -> n+1` segment, not the biggest ROOM
line — asks `place_fence.search` for its top four candidates under the *same*
hard constraints (nothing relaxed: prove's turn and approach-from-behind rules,
`run ≥ 8` in, `seg_clear` on the path out, ring, 6.6 m, corridor, no unlabeled
no-band line, 7 m leash, 40° cap from the shipped yaw), then **writes, proves
and rides each one**. Keep only if faster with zero rails and the round
completes; otherwise the fence goes back exactly where it was.

| id | fence | ridden | result |
| --- | --- | --- | --- |
| hk_adv_002 | #6 | 1 | keep 89.13 → 87.33 |
| hk_adv_002 | #7 | 3 | keep 87.34 → **83.13, 0 faults** |
| hk_adv_005 | #12 | 4 | keep 90.82 → **79.46, 0 faults** |
| hk_adv_005 | #6 | 1 | keep 79.45 → 78.91 |
| hk_adv_001 | #12 | 4 | keep 105.19 → 92.88 |
| hk_adv_001 | #7 | 1 | **discard** — 87.86 s but it rolled a pole |
| hk_adv_001 | #2 | 4 | keep 92.89 → 91.59 |
| hk_adv_003 | #6 | 4 | discard — best 96.43, all slower |
| hk_adv_003 | #7 | 4 | discard — best 95.56, all slower |

**hk_adv_002 83.1 s clear. hk_adv_005 78.9 s clear.** hk_adv_001 105.2 → 91.6.

The discards are the whole argument. `hk_adv_001` #7's only legal candidate was
5 s faster **and put a rail in** — a geometry score would have taken it. All
eight of `hk_adv_003`'s candidates were legal, proved green, and slower. A
placement that reads better does not ride better.

Every fence moved tonight is ≤ 40° from its shipped yaw and inside the 7 m
leash. Kind, height, spread and number never move.

## The two that still fail — clock only, no rails

Cert success is 0 faults, and time faults are `floor((t-80)/4)`, so a clear
needs **t < 84**.

| id | faults | time / 80 | needs |
| --- | --- | --- | --- |
| hk_adv_001 | 2 | 91.59 | 7.6 s |
| hk_adv_003 | 3 | 94.00 | 10.1 s |

Segments **from the board log** (`dist/ridecert_godot.log`, the rounds that read
91.59 and 94.00) — label = segment into that fence:

- `hk_adv_001` 1:3.9 2:7.5 3:9.4 4:3.5 5:4.6 6:9.7 **7:12.4** 8:9.6 **9:12.8** 10:5.3 11:3.5 12:5.5
  — come-agains at **#7** and **#9**
- `hk_adv_003` 1:4.2 2:3.5 3:3.5 4:10.1 5:10.4 **6:11.8** 7:9.0 8:5.5 9:7.3 **10:12.6** 11:7.5 12:4.6
  — come-agains at **#6** and **#10**

**Do not plan from `dist/ridecert_logs/*.log`.** Those are `ride_ids` leftovers
and they disagree with the board.

### Tried tonight and rejected: the 003 11→12 pair

`place_fence.search_pair` + `ride_place.py --pair` now move both ends of a
labeled related as one rigid body — rotation about the pair midpoint plus a
translation, so the distance and relative yaw are preserved by construction and
the band cannot drift. Same hard constraints as the single-fence search,
nothing relaxed.

All four candidates were legal, held the gap at exactly 10.800, proved green —
and all four were **slower**: 110.9 / 109.0 / 107.2 / 116.2 against 94.0. Both
fences were put back byte-identical and 003 rides at 93.99.

That closes the "31 s in two segments" idea I wrote here last night, which came
from a stale log. On the board the pair is cheap: into #11 is 7.5 s with no
come-again, into #12 is 4.6 s. **003's clock is the 12.6 s come-again into #10**,
and #10 has no legal solo placement. Moving the out of that rollback was the one
legal lever and the ride says no.

## What is actually left

- `hk_adv_003` — #10 (12.6 s) and #6 (11.8 s) are the two come-agains. Neither
  has a legal solo placement under the leash; the pair that could have shifted
  #10 has now been ridden and rejected. #4/#5 have no legal placement; #6/#7
  were ridden four candidates deep last pass and every one was slower.
- `hk_adv_001` — #9 (12.8 s) and #7 (12.4 s) are its come-agains. #9 and #3 sit
  in relateds that are **chains of three** (3–4–5 and 9–10–11), so the rigid
  pair mover cannot help: moving two ends of one label walks the shared fence
  out of the other band. #7's only legal candidate was 5 s faster and rolled a
  pole.

Both tracks are out of moves that do not either break a band or relax a
constraint, and relaxing a constraint is what keeps the rails off.

### If someone picks this up

The remaining honest lever is a **rigid triple** — move all three ends of a
3-fence chain together, both bands preserved by construction, scored by the
ride. `search_pair` is the shape to copy; it would need the chain's two
distances held instead of one. That is the only thing left that does not
loosen a rule. It may also say no, and that is a real answer.

## Nothing is half-applied

Fences differing from the pre-pass baseline: `hk_adv_001` #2/#8/#12,
`hk_adv_002` #6/#7/#8, `hk_adv_003` #8, `hk_adv_005` #6/#8/#12 — every one of
them kept because a ride was faster with no rail. Kind counts, heights and
spreads per track unchanged. Both copies (`game/content/courses/` and
`content/courses/`) byte-identical. `prove_ship.py` passes. Every labeled
related is inside its band in `content/pedagogy/related_distances.md`.

`walk_courses.py` reports one label worth an argument — `hk_int_002` 6→7, a
two-stride bending 7.1 m off 10.7 m (41°). Left alone: bending line, not a lie.

`DIAGONALS.md` not applied or run. `walk_diagonals.py` present and **not
applied** — no advanced fence is yawed by it.

**No game script was edited this pass** — course JSON and tools only. `farm.gd`,
`mesh_kit.gd` and `person_look.gd` carry recent mtimes: that is the look-agent
in the lockbox, not this pass. Board and `--playtest` are green with those in
the tree.

The planner twins in `dist/planner/<id>.json` are still stale.

Indoor is scenery. Quotas unchanged. The 25k pile is archive. Michelle untouched.
`abbott.glb` untouched. Leave windows, `present(`, the pin constants,
`playtest.gd` and `arena.gd` untouched.

`dist/Abbott.exe` not exported and not touched by this pass. It keeps
re-packing on its own: 1 738 385 672 B (09-17) -> 1 738 404 424 B (09-19 19:43)
-> 1738406648 B (2026-09-20 15:58), created 2026-09-12 throughout. No hook, nothing in
`tools/` or `game/scripts/` writes it, and no `--export` has been run. Its
tail is a Godot `.pck` index, so something is re-packing rather than
appending. **Unverified build — do not ship it.**
