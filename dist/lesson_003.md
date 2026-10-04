# The lesson she sits

No code changed in this job. `horse.gd`, `bascule.gd`, `rider_mesh.gd`, `person_look.gd` and `game_state.gd` are byte-identical to the knee board's tree. The one probe (in `horse.gd`, for the fresh ride) and the one throwaway scene were removed after use.

## Step 0 — the four lessons

`game/content/courses/SHIP.json` lists the lesson as hk_les_001 to hk_les_004. From each course file:

| course | name | fences (num · kind · height m) | related line (from the file) |
| --- | --- | --- | --- |
| hk_les_001 | Tuesday poles | 1 · vertical · 0.422 — 2 · vertical · 0.528 — 3 · vertical · 0.600 | **2 → 3, 2 strides, 10.73 m** |
| hk_les_002 | Single then the line | 1 · vertical · 0.419 — 2 · vertical · 0.528 — 3 · vertical · 0.606 | **2 → 3, 2 strides, 10.81 m** |
| hk_les_003 | Right-hand two-stride | 1 · vertical · 0.432 — 2 · vertical · 0.514 — 3 · vertical · 0.596 | **2 → 3, 2 strides, 10.92 m** |
| hk_les_004 | Center line | 1 · vertical · 0.423 — 2 · vertical · 0.524 — 3 · vertical · 0.592 | **2 → 3, 2 strides, 10.78 m** |

All four are `pattern: lesson_single_then_line`, "poles to 2'3\"", `session_kinds: ["lesson"]`, with 180 s allowed. Each is three fences, a single white vertical (0.42–0.43 m) then a two-stride line of plank verticals. **None is a prix, and none opens on a 3' oxer.**

One pin ride, `--ridecert-id=hk_les_001`:

```
MICHELLE soft | Two. Wait.
MICHELLE soft | One. Wait.
MICHELLE soft | One. Early.
MICHELLE soft | Early.
MICHELLE soft | Wait.
MICHELLE soft | Now.
MICHELLE spot | That was the spot.
MICHELLE soft | One. Wait.
MICHELLE soft | One. Early.
MICHELLE soft | Early.
MICHELLE soft | Wait.
MICHELLE soft | Now.
MICHELLE spot | You waited, then asked. That's it.
MICHELLE soft | One. Wait.
MICHELLE soft | One. Early.
MICHELLE soft | Early.
MICHELLE soft | Wait.
MICHELLE soft | Now.
MICHELLE spot | That's the one. Don't fuss after.
MICHELLE clear | Clear round. Don't pick at him now.
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.52 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
```

- **The counts:** she counts him in to every fence ("Two. Wait. / One. Wait. / One. Early. / Early. / Wait. / Now." on fence 1, and the same from "One. Wait." on fences 2 and 3).
- **After each leave:** one sentence ("That was the spot." · "You waited, then asked. That's it." · "That's the one. Don't fuss after.").
- **At the end:** "Clear round. Don't pick at him now."

**The lesson is already the design:** short, a single then a related line, the count to each fence, and one sentence after each leave. No fence was moved.

**Not in the scope of this job, noted.** Every lesson file's `walk_text` and `michelle_brief` is garbled generator text, not a sentence. For example hk_les_001's brief is "Walk twenty-two thousand seven hundred twenty-seven. Quiet to the first.", and its walk text splices "hk_les_001" into the words every few terms. The course files were not edited.

## Phase 1 — the horse she brings home

One fresh ride, `--ridecert-fresh --ridecert-id=hk_les_001`, with a probe in `horse.gd` (removed after). It printed confidence, unrest, Neck1 and Tail1 against rest (after the modifiers) on a settled canter before fence 1, on the leave, and on every frame after the round completed (the cert keeps processing about 0.47 s). Selected lines:

```
SCHOOL before-fence-1 (1 s settled canter) conf=48.0 unrest=0.565 neck1=-15.75 tail1=-14.75 gait=3 jumping=false land_recover=0.00 last_stride=0.00 next_fence=1 round_complete=false
MICHELLE soft | Two. Wait.
MICHELLE soft | One. Wait.
MICHELLE soft | One. Early.
MICHELLE soft | Early.
MICHELLE soft | Wait.
MICHELLE soft | Now.
MICHELLE spot | Yes. That's the leave.
SCHOOL leave fence 1 conf=48.0 unrest=0.565 neck1=-12.70 tail1=-0.67 gait=3 jumping=false land_recover=0.00 last_stride=1.00 next_fence=1 round_complete=false
MICHELLE soft | One. Wait.
MICHELLE soft | One. Early.
MICHELLE soft | Early.
MICHELLE soft | Wait.
MICHELLE soft | Now.
MICHELLE spot | That's the one. Don't fuss after.
MICHELLE soft | One. Wait.
MICHELLE soft | One. Early.
MICHELLE soft | Early.
MICHELLE soft | Wait.
MICHELLE soft | Now.
MICHELLE spot | That was the spot.
MICHELLE clear | That's clean. Pat him and be done.
SCHOOL after-round frame 1 conf=54.0 unrest=0.438 neck1=+3.14 tail1=-3.23 gait=3 jumping=false land_recover=1.32 last_stride=0.00 next_fence=4 round_complete=true
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=54.0 scope=44.5
SCHOOL after-round frame 14 conf=54.0 unrest=0.438 neck1=-3.05 tail1=-4.29 gait=3 jumping=false land_recover=1.22 last_stride=0.00 next_fence=4 round_complete=true
SCHOOL after-round frame 28 conf=54.0 unrest=0.438 neck1=-15.34 tail1=-10.62 gait=3 jumping=false land_recover=1.14 last_stride=0.00 next_fence=4 round_complete=true
```

- **The school writes the stats.** On this clear, `finish_round → _school_from_round` took **confidence 48.0 → 54.0**, scope 40 → 44.5, rideability 44 → 48, timing 38 → 42 and feel 36 → 39, and his `_hand_unrest()` went **0.565 → 0.438**.
- **Single frames do not show the neck.** In the ride his Neck1 swings about ±10° with the canter rock (after the round it runs +4.79 to −15.34 in 28 frames), so no single frame is a before or an after. The pose reads the stats live, so a stride mean at those stats is the ruler.
- **The throwaway scene:** one settled stride, day-one's stats against the after-clear stats:

```
row=dayone-walk conf=48.0 scope=40.0 ride=44.0 timing=38.0 feel=36.0 neck1=+5.45 tail1=-9.68 ear=-20.21 hand_travel=0.057 nod_p2p=5.89 frames=172
row=afterclear-walk conf=54.0 scope=44.5 ride=48.0 timing=42.0 feel=39.0 neck1=+2.59 tail1=-6.98 ear=-17.99 hand_travel=0.047 nod_p2p=4.66 frames=214
row=dayone-canter conf=48.0 scope=40.0 ride=44.0 timing=38.0 feel=36.0 neck1=-5.17 tail1=-10.60 ear=-3.24 hand_travel=0.109 nod_p2p=7.88 frames=107
row=afterclear-canter conf=54.0 scope=44.5 ride=48.0 timing=42.0 feel=39.0 neck1=-6.65 tail1=-7.30 ear=-0.23 hand_travel=0.093 nod_p2p=5.89 frames=97
```

| stride means | day-one (48 / 40 / 44 / 38 / 36) | after the clear (54 / 44.5 / 48 / 42 / 39) | change |
| --- | --- | --- | --- |
| canter Neck1 / Tail1 / Ear1.L | −5.17 / −10.60 / −3.24 | −6.65 / −7.30 / −0.23 | −1.48° / +3.30° / +3.01° |
| walk Neck1 / Tail1 / Ear1.L | +5.45 / −9.68 / −20.21 | +2.59 / −6.98 / −17.99 | −2.86° / +2.70° / +2.22° |
| her nod p2p at the canter / walk | 7.88 / 5.89° | 5.89 / 4.66° | quieter |
| her hand travel at the canter / walk | 0.109 / 0.057 m | 0.093 / 0.047 m | quieter |

- **The clear quiets him, and the picture reads it.** Worry is (70 − conf) / 40, from 0.55 to 0.40. His neck comes down (the canter −1.5°, toward −8; the walk −2.9°), his tail and ears come down with it (2.2–3.3°), and her nod and hands settle with his unrest. The canter neck alone is inside 2° of its start, but the tail is not (3.3°), so he is not "as worried as the start". **The school is already in the picture**; `_school_from_round` was not touched.
- **The canter scene rows ran on slow frames** (107 / 97 frames a stride). The worry-weight arithmetic gives 18 × 0.15 = 2.7° for the canter neck; this scene printed 1.48°.
- **No leak.** The next pin `--ridecert-id=hk_les_001` after the fresh ride:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
```

That is confidence 91.0, not near 50. No code changed, so no clocks or board are needed; the knee board's 21/23 stands.

## Phase 2 — the card (`game_state.gd` `result_line`, from the source)

| round | the card says |
| --- | --- |
| a lesson clear (hk_les_001, 18.54) | `Clear.  18.54s` |
| a show clear inside the time (a first clear on that class, 67.28) | `Clear.  Stay for the jump-off.  67.28s` then `Blue ribbon.` (`Red ribbon.` if it is not a new best) |
| a show round with time faults and no rail (hk_adv_001, 91.60, 80 allowed) | `2 faults   ·   91.60s   ·   2 time faults` then `White ribbon.` |
| a rail on fence 3 (67.17) | `4 faults   ·   67.17s   ·   rail 3` (plus `Yellow ribbon.` in a show) |
| a refusal on fence 1 (69.88) | `4 faults   ·   69.88s   ·   refusal 1` (plus `Yellow ribbon.` in a show) |
| elimination, three refusals | `Eliminated  ·  three refusals.  <time>s` |

- **Time faults are never called Clear.** The clear branch needs `last_faults == 0 and time_faults == 0`, and `finish_round` adds time faults into `faults`. So a round with time faults goes to the fault line, which names them.
- **A lesson never says jump-off.** "Jump-off clear." needs `jump_off`, which only `begin_jump_off` sets. The offer needs `can_offer_jump_off()`, which requires `session_kind == "show"`. Lessons also never take time faults (`session_kind != "lesson"` in `finish_round`) or a ribbon (show only).
- **A rail names its fence.** `note_rail` appends `next_fence`. The knock happens in the air (u 0.42–0.62), before `note_jumped` moves `next_fence` on at the land, so it is the fence being jumped. A refusal names its fence the same way (`refuse_nums`).
- **The card is already true.** No branch was reworded, so no clocks and no board.
