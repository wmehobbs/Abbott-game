# Hidden K — ride cert status

**29 Sep, overnight. Twenty-three walks.**

The night, in four results:

- **The file holds 23 walks**, one Godot launch per id in SHIP.json order, each block written before the next launch and each boot deleted after. Every course loaded its own id. On each:
  - fence 1: its own line, said once;
  - a related midpoint facing the out: the in-fence's line, no "Walking back";
  - turned to face the in-fence: "Walking back." first, said once;
  - more than 6 m from every fence: empty.
- **hk_int_009's midpoint now names fence 2:** "Fence 2. plank vertical. 0.76 m. 3 strides to fence 3." When a fence's rail (≤ 1.5 m) and a related line (≤ 2 m) both claim her, the nearer wins, and a tie keeps the line. Fence 10's own spot is still fence 10's. The audit reran at 0 failures (23 courses, 180 fences, 45 midpoints). 4 m, 1.5 m and 2 m are unchanged.
- **The next lesson advances.** `course_seed` is now saved, and it moves by one only after a lesson round completes. Four title-style lesson starts at seeds 1, 2, 3, 0 loaded hk_les_002, 003, 004, 001. After a pin cert of hk_les_001 (still hk_les_001, 18.54, confidence 91.0) the saved seed read 1. `ride_cert.gd` is unchanged.
- **The board did not move:** 21/23, worst 0.09 s (hk_int_009) against the between board, no new rail, 0 teleported. The playtest passed.

Files changed: `content_library.gd` (`near_line`: rail against segment, nearer wins) and `game_state.gd` (the lesson seed advance and its save). No course file, `walk_text`, `horse.gd`, `ride_ai.gd` or fence was touched. No export.

Clocks on the tree left: hk_les_001 **18.53**, hk_adv_001 **91.60**, hk_adv_003 **94.01**. That is 0 / 2 / 3 faults with 0 rails, teleported=false, and the pin confidence is 91.0.

- **Style:** B refused fence 1, Idle, hinds 0.053. C one rail, `FENCE knock 3 … jumping=true`.
- **Board:** 21/23, hk_int_007 84.93.
- **Playtest:** `PLAYTEST done pass=true`.

Details and every copied line: `dist/long_002.md`.

---

**29 Sep, overnight. The whole card.**

The night, in five checks:

- **The audit found one course that does not read as the rule's naive expectation, and it is right as written.** Every id in SHIP.json went through `ContentLibrary.near_line`: 23 courses, 180 fences, 45 related midpoints. The one failure is hk_int_009's 2 → 3 midpoint. It reads fence 10's line, because fence 10 is jumped the other way beside that line and its standard is 1.21 m from the midpoint. "At the rail, within 1.5 m, that fence's line wins" is the frozen rule, so it is written, not fixed. Every other fence and midpoint matches its file's h, sp (only above 0) and strides, every point farther than 6 m is empty, and every `related.to` names a fence.
- **The lesson said one sentence after each leave.** hk_les_001–004 are each a single white vertical, then a two-stride line. On the pin ride Michelle counted him in to each fence and said "Spot. Sit still on the other side." · "True leave. He jumped with you." · "You found it. Don't chase the next." · "That's clean. Walk out quiet."
- **The clear quieted him.** A fresh day-one clear took confidence 48 → 54 and his unrest 0.565 → 0.438. At a settled stride his canter Neck1 went −4.86 → −8.00 and Tail1 −10.39 → −7.92; at the walk, 2.7° each. The in-ride after-frames are 10 frames of landing recovery, not a stride. The next pin still finished at 91.0 (no leak).
- **The card did not lie.** `result_line` is unchanged and true: time faults read as faults, never "Clear"; a lesson never offers a jump-off; a rail names its fence.
- **Walking back is kept.** Her facing is readable off the walker (`-global_transform.basis.z`). On a related line, facing back toward the in-fence (dot −1.000) the line is "Walking back. Fence 2. natural vertical. 0.875 m. 1 stride to fence 3."; toward the out (dot +1.000) it is unchanged. At a fence's rail it never adds it, and the ring is still empty.

`near_line` and `arena._walk_near_tick` gained the facing, nothing else. No course file, `walk_text`, `horse.gd`, `ride_ai.gd` or fence was touched. No export.

Clocks on the tree left: hk_les_001 **18.53**, hk_adv_001 **91.60**, hk_adv_003 **94.00**. That is 0 / 2 / 3 faults with 0 rails, teleported=false, and the pin confidence is 91.0. The cert log has no walk line, no spread and no "Walking back". No style, board or playtest; the between board 21/23 stands.

Details and every copied line: `dist/card_002.md`.

---

**28 Sep. The spread in the file. An oxer's walk line now carries that fence's own spread, in metres, as its file stores it (`str` of `sp`), after its height and before the stride words, only when `sp` is above 0. A vertical (which stores sp 0.0) gains no spread words. Only `ContentLibrary._fence_line` changed. No export.**

| where | h / sp in the file | line now |
| --- | --- | --- |
| hk_adv_002 fence 7 | 0.919 / 0.659 | Fence 7. brush oxer. 0.919 m. spread 0.659 m. |
| hk_adv_002 fence 11 | 0.943 / 0.659 | Fence 11. plank oxer. 0.943 m. spread 0.659 m. 1 stride to fence 12. |
| hk_adv_002 midpoint 11 → 12 | fence 11's | Fence 11. plank oxer. 0.943 m. spread 0.659 m. 1 stride to fence 12. |
| hk_adv_002 fence 1 | 0.84 / 0.0 | Fence 1. white vertical. 0.84 m. |
| hk_les_001 fence 1 | 0.422 / 0.0 | Fence 1. white vertical. 0.422 m. |
| hk_adv_002 ring (0, −3) | — | (empty: the course line alone) |

- **The height words stay:** ` {str(h)} m.` after the name.
- **The stride words stay:** "1 stride to fence {to}." / "{n} strides to fence {to}."
- **The distances stay:** the 4 m rule, the 1.5 m rail and the 2 m corridor.
- **The two oxers store the same 0.659**, so their spreads cannot be told apart by the number. Each line reads the dictionary of the fence that owns it.
- **The walk boot:** on fence 7, Michelle said "Fence 7. brush oxer. 0.919 m. spread 0.659 m." once, with no repeat, and went quiet in the ring.
- **Untouched:** course files, `walk_text`, `horse.gd`, `ride_ai.gd` and the fences.

Clocks on the tree left: hk_les_001 **18.54**, hk_adv_001 **91.60**, hk_adv_003 **93.99**. That is 0 / 2 / 3 faults with 0 rails, teleported=false, and the pin confidence is 91.0. The cert log has no walk line and no "spread". No style, board or playtest; the between board 21/23 stands.

Details: `dist/spread_002.md`.

---

**28 Sep. The height in the file. The walk's fence line now carries that fence's own height, in metres, as its file stores it (`str` of `h`, not converted or re-rounded), before the stride words. Only `ContentLibrary._fence_line` changed. No export.**

| where | line now |
| --- | --- |
| hk_les_001 fence 1 | Fence 1. white vertical. 0.422 m. |
| hk_adv_002 fence 1 (the other "white vertical") | Fence 1. white vertical. 0.84 m. |
| hk_adv_002 midpoint 2 → 3 | Fence 2. natural vertical. 0.875 m. 1 stride to fence 3. |
| hk_adv_002 fence 3, under a standard | Fence 3. plank vertical. 0.885 m. 2 strides to fence 4. |
| hk_les_001 midpoint 2 → 3 | Fence 2. plank vertical. 0.528 m. 2 strides to fence 3. |
| hk_adv_002 ring (0, −3) | (empty: the course line alone) |

- **Each line reads its own fence's `h`:** the midpoint carries fence 2's 0.875, not fence 3's 0.885. A fence with no `h` would add nothing.
- **The stride words stay:** "1 stride to fence {to}." / "{n} strides to fence {to}."
- **The distances stay:** the 4 m nearest-fence rule, the 1.5 m rail and the 2 m corridor. 1.9 m off the 2 → 3 line still reads it with fence 2's height, and 2.5 m off is empty.
- **The walk boot:** on hk_adv_002's midpoint, Michelle said the new sentence once (height and stride), with no repeat, and went quiet in the ring.
- **Untouched:** course files, `walk_text`, `horse.gd`, `ride_ai.gd` and the fences.

Clocks on the tree left: hk_les_001 **18.54**, hk_adv_001 **91.61**, hk_adv_003 **94.01**. That is 0 / 2 / 3 faults with 0 rails, teleported=false, and the pin confidence is 91.0. The cert log has no walk line and no height words. No style, board or playtest; the between board 21/23 stands.

Details: `dist/height_002.md`.

---

**28 Sep. Say stride, say fence. The walk's related line now says what its numbers are: "Fence 2. natural vertical. 1 stride to fence 3." on hk_adv_002's one-stride, "Fence 3. plank vertical. 2 strides to fence 4." on its two-stride, and "Fence 2. plank vertical. 2 strides to fence 3." on a lesson. It read "1 to 3.", "2 to 4." and "2 to 3." Only the words changed, in `ContentLibrary._fence_line`. No export.**

- **The rules are unchanged.** The 4 m nearest-fence rule, the 1.5 m rail (standard to standard) and the 2 m related-line corridor stay, and so does which fence owns the line. Fence 3 under a standard still reads its own line, now "2 strides to fence 4." 1.9 m off the 2 → 3 line still reads it, and 2.5 m off and the ring are empty. A fence with no related line has no stride words.
- **The walk boot:** on hk_adv_002's 2 → 3 midpoint, Michelle said "Fence 2. natural vertical. 1 stride to fence 3." once, with no repeat. In the ring the near-line goes quiet and the course line stays.
- **Untouched:** course files, `walk_text`, `horse.gd`, `ride_ai.gd` and the fences.

Clocks on the tree left: hk_les_001 **18.53**, hk_adv_001 **91.61**, hk_adv_003 **94.01**. That is 0 / 2 / 3 faults with 0 rails, teleported=false, and the pin confidence is 91.0. The cert log has no walk line and no "stride". No style, board or playtest (the words are not on the cert); the between board 21/23 stands.

Details: `dist/stride_002.md`.

---

**28 Sep. The line under her feet: kept. Between two fences the file relates, the walk now names the line she is standing on, from its in-fence. hk_adv_002's 2 → 3 midpoint reads "Fence 2. natural vertical. 1 to 3." (it read fence 3's "2 to 4."), its 3 → 4 midpoint reads "Fence 3. plank vertical. 2 to 4." (it was empty), and every lesson's 2 → 3 midpoint reads "2 to 3." No course file, `walk_text`, `horse.gd` or fence was touched. No export.**

- **The 4 m fence label stays.** `NEAR_FENCE_M` is still 4, and it is still the rule when she is neither at a fence nor on a related line.
- **The rule, in order, inside `ContentLibrary.near_line`:**
  1. **At a fence:** within 1.5 m of the fence's rail (standard to standard), that fence's own line. Fence 3 under either standard still reads "2 to 4.", and fence 2 "1 to 3." The rail, not the centre, because a standard sits 1.525 m from the centre.
  2. **On one related line:** her closest point is between the in-fence and the fence its `related.to` names, within a 2 m corridor. The in-fence's line, `Fence {from}. {name}. {strides} to {to}.` The closer segment wins if two claim her.
  3. **Otherwise:** the 4 m nearest-fence rule, or empty.
- **The checks:**
  - 1.9 m off the 2 → 3 line still reads it, and 2.5 m off is empty.
  - The ring at (0, −3) is still empty.
  - The hk_adv_002 walk boot on the 2 → 3 midpoint: Michelle said "Fence 2. natural vertical. 1 to 3." once, with no repeat, and the label went back to the course line in the ring.
  - The clock, style and board logs contain no walk line.

Clocks on the tree left: hk_les_001 **18.54**, hk_adv_001 **91.61**, hk_adv_003 **94.00**. That is 0 / 2 / 3 faults with 0 rails, teleported=false, and the pin confidence is 91.0.

- **Style:** B refused fence 1, Idle, hinds 0.053. C one rail, `FENCE knock 3 … jumping=true`.
- **Board:** 21/23, worst |Δ| 0.06 s (hk_les_001) against the near board, no new rail, 0 teleported, hk_int_007 84.94.
- **Playtest:** `PLAYTEST done pass=true`.

Details: `dist/between_002.md`.

---

**28 Sep. The fence she is standing next to. On the walk, within 4 m of a fence, the label adds "Fence {num}. {name}." under the course line, plus "{strides} to {to}." when that fence's own file has a related line. Michelle says it once when she arrives. Away from every fence the label is still the course line alone. No course file, `walk_text`, `horse.gd` or fence was touched. No export.**

- **One function.** `ContentLibrary.near_line(Course.loaded, her position)` takes the nearest fence within 4 m on the ground plane. `hud.set_walk_near` puts it on the line under the course line, and `arena._walk_near_tick` says it once when it changes to a fence.
- **Every fence of hk_adv_002 and the four lessons names itself (24 rows):**
  - hk_adv_002 fence 2: "Fence 2. natural vertical. 1 to 3."
  - its out, fence 3, reads its own "2 to 4." and does not claim the 1 to 3;
  - fence 11: "1 to 12.";
  - each lesson's fence 1 names no stride, and its fence 2 reads "2 to 3."
- **Away from the fences:** the middle of the ring (6.44 m from the nearest fence) is empty, and the label is the course line alone.
- **The 2 → 3 midpoint** is inside 4 m of both, an exact tie at 3.745 m. The later fence in the file (3) wins. 4 m was not widened.
- **The walk boot:** hk_les_001, placed on fence 1. The label shows the course line and "Fence 1. white vertical.", and Michelle said the course line once and the near-line once.
- **Cert rounds never enter the walk.** The clock, style and board logs contain no walk line or near-line.

Clocks on the tree left: hk_les_001 **18.54**, hk_adv_001 **91.60**, hk_adv_003 **94.02**. That is 0 / 2 / 3 faults with 0 rails, teleported=false, and the pin confidence is 91.0.

- **Style:** B refused fence 1, Idle, hinds 0.053. C one rail, `FENCE knock 3 … jumping=true`.
- **Board:** 21/23, worst |Δ| 0.03 s against the walk board, no new rail, 0 teleported, hk_int_007 84.96.
- **Playtest:** `PLAYTEST done pass=true`.

Details: `dist/near_002.md`.

---

**28 Sep, overnight. She walks this course. Entering the walk now shows, and Michelle says once, the course's own line: "{name}. {height_label}. {notes}". For hk_les_001 that is "Tuesday poles. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line." `walk_text` and `michelle_brief` were not rewritten, and no course file was touched. No export.**

- **One function.** `ContentLibrary.walk_line(course)` returns `"{name}. {height_label}. {notes}"`, or `""` if any of the three is missing. It appends no `walk_text`, `michelle_brief`, id or serial.
- **The wiring.**
  - `course.gd`: `Course.loaded` keeps the ship dictionary the round already built its fences from (one field; not on the brief's file list, so it is named here).
  - `hud.gd`: `set_walk_mode(on, line)` puts the line on the walk label, and the controls stay on the bottom hint.
  - `arena.gd`: `_enter_walk` shows the line and calls `GameState.speak_soft(line)` once. `_enter_ride` is unchanged: `lesson_start` on a lesson, no repeat.
- **All 23 ship ids pass** (headless, through that function): no id, no "thousand", no "meat", and name, height and notes present in each. The four lesson lines are different strings, and the three jump-offs read their own notes.
- **The walk boot:** hk_les_001, mode walk. The walk label, Michelle's `MICHELLE soft |` line and the function's output are the same string. The cert, style and board logs contain no walk line.
- **Left alone:** `walk_text` stays the generator's text on disk, and nothing reads it. `fix_unique_text.py` and `make_courses_mega.py` were not run. The rider picture below is unchanged.

Clocks on the tree left: hk_les_001 **18.53**, hk_adv_001 **91.60**, hk_adv_003 **93.98**. That is 0 / 2 / 3 faults with 0 rails, teleported=false, and the pin confidence is 91.0.

- **Style:** B refused fence 1, Idle, hinds 0.053. C one rail, `FENCE knock 3 … jumping=true`.
- **Board:** 21/23, worst |Δ| 0.04 s (hk_int_002) against the knee board, no new rail, 0 teleported, hk_int_007 84.93.
- **Playtest:** `PLAYTEST done pass=true`.

Details: `dist/walk_002.md`.

---

**27 Sep. The lesson she sits. The lesson, the horse she brings home, and the card are each already true. No code changed. No export; the exe on disk is still THU SEP 24 · 2.348.0.0.**

- **The lesson.** hk_les_001–004 are each three fences, poles to 2'3": a single white vertical (0.42–0.43 m), then a two-stride related line of plank verticals (2 → 3, 10.73–10.92 m, from the files). No prix, no 3' oxer first. On the pin ride Michelle counts him in to every fence ("Two. Wait. / One. Wait. / One. Early. / Early. / Wait. / Now."), says one sentence after each leave ("That was the spot." · "You waited, then asked. That's it." · "That's the one. Don't fuss after."), and "Clear round. Don't pick at him now." Clear, 18.52.
- **What the clear does to him.** On a fresh day-one clear the school takes confidence 48 → 54, feel 36 → 39, and his unrest 0.565 → 0.438, and the picture reads it. At a settled stride his Neck1 comes down 1.5° (canter) / 2.9° (walk), his tail 3.3° / 2.7°, his ears 3.0° / 2.2°, and her nod and hands settle with him. `_school_from_round` is untouched. The next pin ride still finished at confidence 91.0 (no leak).
- **The card.** `result_line` is already true:
  - a lesson clear reads `Clear.  18.54s`;
  - a show clear inside the time reads `Clear.  Stay for the jump-off.` with a ribbon;
  - time faults read as `2 faults · 91.60s · 2 time faults`, never "Clear";
  - a rail reads `rail 3`, and a refusal `refusal 1`;
  - three refusals read `Eliminated · three refusals.`;
  - a lesson never offers or names a jump-off.
- **Noted, not in scope:** each lesson file's `walk_text` and `michelle_brief` is garbled generator text (e.g. "Walk twenty-two thousand seven hundred twenty-seven. Quiet to the first."). The course files were not edited.

Clocks on this tree (the knee board's): 18.53 / 91.59 / 93.99, 0 / 2 / 3 faults, 0 rails, teleported=false. Board 21/23, hk_int_007 84.95. Details: `dist/lesson_003.md`.

---

**27 Sep. The knee, before the shin. Each gait's knee now opens more on day-one, with a shin share beside that gait's shin line. All three are kept. The picture below stands, with this added. No export.**

The shin lines had no unrest, so shin_x p2p matched on both horses. The knee, the angle between the thigh and the shin, was the ruler. Her right knee already read 3.1–3.4° more on day-one, but the left read only 2.5–2.7°, so each gait was flat on the left knee and got one share:

| gait | share, beside its shin line (same shape, same sign) | left knee p2p more on day-one: before → after | right knee | heels (max move) | hands |
| --- | --- | --- | --- | --- | --- |
| walk | `shin_x −= w × 4 × unrest` | 2.58 → **3.75°** | 3.17 → 4.34° | 0.2 cm | unchanged |
| trot | `shin_x −= (post × 9.6 + sit × 2.8) × 1.0 × unrest` | 2.70 → **3.47°** | 3.38 → 4.15° | day-one +0.9 cm mean, +1.6 cm farthest | unchanged |
| canter | `shin_x −= (rock × 4.8 + sit × 3.8) × 2.5 × unrest` | 2.54 → **3.71°** | 3.13 → 4.30° | 0.2 cm | within 0.1 cm |

- **The three shin constants are unchanged.** No shin line is left uncoded on a moving gait now.
- **Held:** the knee stays bent (max 118.6°). The halt and each gait's neighbours did not move.
- **The fold at fence 1 is unchanged** on the pin: pitch −40.67 at u 0.55, Neck1 −21.44.

Clocks on the tree left: hk_les_001 **18.53**, hk_adv_001 **91.59**, hk_adv_003 **93.99**. That is 0 / 2 / 3 faults with 0 rails, teleported=false, and the pin confidence is 91.0.

- **Style:** B refused fence 1, Idle, hinds 0.053, Neck1 +11.72, Tail1 −0.31. Her helmet heads for the pin's halt (+10.55 at 0.8 s). C one rail, `FENCE knock 3 … jumping=true`.
- **Board:** 21/23, worst |Δ| 0.04 s (hk_beg_034) against the heel board, no new rail, 0 teleported, hk_int_007 84.95.
- **Playtest:** `PLAYTEST done pass=true`.

Details: `dist/knee_002.md`.

---

**27 Sep. The picture you have.** The picture is the one in the files: `horse.gd` is the heel board's tree, and nothing was ridden, probed or changed for this entry. On day-one, against the pin, she shows him at the halt, on the flat, over the fence and in the sit, and he shows it in his neck, tail and ears.

- **The trot keeps the plus**, `pitch += swing * 14.0 * trot_unrest`. The minus turns her back the other way (8.46 / 5.57° → 11.21 / 14.20°) but takes her trot hands from 0.055 / 0.081 m to 0.044 / 0.046 m and her farthest heel +2.6 cm, because her fist target is body-relative (`dist/post_002.md`).
- **Closed:** the lean (LEAN 8: roll 3.05° apart, day-one heels slid 2.48 / 2.54 cm) and the canter's extra 8 beside `rock * 14` (3.45° more pitch, canter hands 0.103 → 0.109 m).
- **The clocks and the 21/23 are the heel board's.**
- **What is left in `_update_rider`.** I read it once. Every term that reads `_hand_unrest()` is one of the kept lines below. The roll reads none. The rest carry no unrest and are the gait's own stride, the same on both horses, which the kept rows were measured on:
  - the walk `w × 1.28 / 0.014 / 3.6 / 2.0 / 1.8`;
  - the trot post constants;
  - the canter `rock × 11 − sit × 5.8`, rise and reach `0.072 / 0.050 / 0.034`, hip `12.6 / 6.8`, shin `4.8 / 3.8`, head `3.6 / +6`;
  - the halt, collect, pulse and land pose blocks;
  - the jump keys.

  Among those, the per-gait shin lines (walk `−w × 2.0`, trot `−post × 9.6 − sit × 2.8`, canter `−rock × 4.8 − sit × 3.8`) are the only rider channel with no share of unrest on a moving gait. They are named here and not given a coefficient. (Later on 27 Sep, the knee job gave each one a share beside it; see above.)

| kept | where | day-one against the pin |
| --- | --- | --- |
| halt: `head_x −= 20 × unrest`, `hip_x += 9 × unrest`, SHOULDER_HALT −40 | gait 0 | helmet 3.45° apart, elbows 4.26 / 4.70°, hip 3.45°, still |
| nod 26 / 48 / 64; elbows SHOULDER_GIVE 19; hips 12 / 18 / 22; hands | walk / trot / canter | as `dist/same_002.md`. Walk body-pitch 3° more; trot body-pitch less (the plus); canter 2.2–2.7° more |
| fold: FOLD_HEAD 30, SIT_HIP 10, FOLD_PITCH 18, FOLD_SHIN 20 | two-point, arc, sit | helmet 3.8 / 4.9 / 5.2°; hip 3.84° at u 0.55; pitch −40.68 / −47.66 at u 0.55; two-point heels 0.1153 / 0.1180 m |
| the leave | hk_adv_002 fences 3 and 12 | fence 3 changes 0.00°; fence 12's 0.02–0.04° at u 0.012 is the keys |
| the horse | `bascule.gd`, untouched | neck, tail and ears up on day-one; the crest at u 0.55 is the same horse; the return at 0.50 s is 9.9° of neck and tail, and the ear's own 8.8° |

| written negatives, not reopened |
| --- |
| the lean · the canter's extra 8 · the trot minus · the elbows over the fence (2.8 / 0.24 / 4.4 / 0.35° on the same fence) · the straight rein · the five hk_adv_002 landings · the tail hair · the late fist · the half-halt (already shows at collect_pulse 0.717) · the horse's bank |

Clocks on this tree (the heel board's): hk_les_001 **18.54**, hk_adv_001 **91.60**, hk_adv_003 **93.99**. That is 0 / 2 / 3 faults with 0 rails, teleported=false. Board 21/23, hk_int_007 at 84.93. No export.

---

**27 Sep. The trot's back fights the post: the minus was tried and reverted. It turned her back the right way, but it took her hands. No code changed in this job. No export.**

- **The trot pitch: reverted to the plus.**
  - Step 0, on one scene: trot body-pitch p2p 8.46° pin / 5.57° day-one (2.89° less on day-one). In the source, on the positive half of sin, the post's `−post × 26.4` is negative and the unrest's `+swing × 14 × unrest` is positive: they fight. The head and rise lines agree and were not touched.
  - With `pitch -= swing × 14 × trot_unrest` (the 14 kept), day-one's back swings more: 11.21 / 14.20, **+2.99°**, 0.01° short of 3°.
  - It also collapsed her trot hands, 0.055 / 0.081 → **0.044 / 0.046 m** (day-one −3.5 cm, past 0.5 cm), because the fist target is body-relative. And day-one's farthest trot heel went +2.6 cm.
  - The nod, the hip, the rise, the walk, the canter and the halt all held. The plus is back. The trot back is a written negative.
- **Still written negatives:** the lean (LEAN 8: roll 3.05° apart, day-one heels slid 2.48 / 2.54 cm) and the canter's extra 8 (3.45° more pitch, hands 0.103 → 0.109 m).
- **The walk already shows** (3.03° more on day-one).
- **The fold stays:** FOLD_PITCH 18 and FOLD_SHIN 20 (u 0.55 pitch −40.68 / −47.66, two-point heel 0.1153 / 0.1180). The air hip stays. hk_int_007 at 84.93 stays.

Clocks on the tree left (unchanged, the heel board's): hk_les_001 **18.54**, hk_adv_001 **91.60**, hk_adv_003 **93.99**. That is 0 / 2 / 3 faults with 0 rails, teleported=false. No fence probe, style, board or playtest, because the sign did not stay. The heel board's 21/23 stands.

Details and every copied line: `dist/post_002.md`.

---

**27 Sep. She leans with him: reverted, because her heels slid. Her back on the flat: walk already shows; canter reverted, because her hands moved; trot reads less on day-one. The fold and the air hip stay. No code changed in this job. No export.**

- **The fold stays:** FOLD_PITCH 18 and FOLD_SHIN 20 (kept in the heel job: eased pitch at u 0.55 −40.68 / −47.66, two-point heel 0.1153 / 0.1180). The air hip stays: SIT_HIP 10 in the two-point and the arc. hk_int_007 at 84.93 stays.
- **The lean: LEAN 8, one attempt, reverted.**
  - Step 0: one bend, the same on both horses (after fence 1, last_turn 1.000 for 4.7–4.9 s). Her settled roll was +4.16° on both, 0.00° apart; the roll carries no unrest.
  - With `roll += 8 × unrest × last_turn` (gait ≥ 1), her roll read him: +5.59 / +8.64, **3.05°** apart, the pin within 1.43°.
  - But her legs roll with her body, and day-one's heels slid **2.48 / 2.54 cm** off the irons at that frame, past 2 cm. No new shin term, per the brief. Reverted.
- **Her back on the flat** (eased body-pitch p2p, day-one over the pin, two scene runs):
  - **walk:** 3.00 / 3.15°, already shows;
  - **trot:** −2.95 / −2.90°, less on day-one: the trot's unrest share runs against the post in the code;
  - **canter:** 2.69 / 2.26°, flat. One term beside the 14, `pitch += rock × 8 × unrest` (from the ease simulation, which reproduced the scene), gave 3.45° more. But it carried her hands: day-one's canter wrist travel went 0.103 → **0.109 m**, past the 0.5 cm rule. Reverted.

Clocks on the tree left (unchanged, the heel board's): hk_les_001 **18.54**, hk_adv_001 **91.60**, hk_adv_003 **93.99**. That is 0 / 2 / 3 faults with 0 rails, teleported=false. The probed pin rides in this job started at confidence 85 (91.0 at the end), so no fresh leak. No style, board or playtest: the heel board's 21/23 stands.

Details and every copied line: `dist/lean_002.md`.

---

**27 Sep. Her heel stays while she folds. Her back over the fence is kept, with a shin counter. The air hip stays. No export.**

`horse.gd`: `const FOLD_PITCH := 18.0` and `const FOLD_SHIN := 20.0`, as `pitch -= 18 × unrest` and `shin_x += 20 × unrest`, in three places: after the last_stride lerp (× last_stride), after the jump keys, and in the sit window. hip_x is untouched. The air hip (`hip_x += SIT_HIP * _hand_unrest()`, SIT_HIP 10) stays, and hk_int_007 at 85.03 was inside 0.1 s.

**The prediction, before any line** (from this job's reprinted body-frame points; the sign comes from the back job's measured revert, where the iron turned +8.80° in her body frame for −8.55° of pitch):

- The fold alone moves day-one's two-point heel 0.1197 → 0.1766 m (+5.7 cm).
- Her legs hang on her body, so the counter is shin_x only: +20 × unrest turns the lower leg back about the knee and predicts **0.1200 m**, with the knee bent at 86.5°. It passed, so one ride.

| fence 1 of hk_les_001, pin / day-one | before | with 18 + shin 20 |
| --- | --- | --- |
| eased pitch at u 0.55 | −37.50 / −37.61 (0.11°) | −40.68 / −47.66 (**6.98°**); pin within 3.2° |
| two-point heel to iron | 0.1188 / 0.1197 | 0.1153 / **0.1180** (inside 2 cm) |
| eased hip at u 0.55 | 26.21 / 29.89 | 26.13 / 29.97 (3.84°) |
| helmet gaps: two-point / u 0.55 / sit | kept 3.8 / 4.9 / 5.2 | 3.83 / 4.83 / 5.21 |
| left knee, two-point / u 0.55 | 77.4 / 80.3°; 75.6 / 77.7° | 80.8 / 83.8°; 84.8 / 88.3° (bent) |

- **Held:** fists within 1 cm and none farther than its own step 0 (day-one R at u 0.85 went 0.83 → 0.38 cm). The pin crest reads Neck1 −21.44.
- **The leave stays one pose.** On hk_adv_002 (clear, 83.14), fence 3 changes 0.00° in pitch, hip, head and shin_x (−45.24 / 29.80 / 22.60 / −12.40). Fence 12's first jumping frame fell at u 0.012, so it reads 0.02–0.04°, exactly the jump keys' own travel over that u, not a step.
- **No leak:** the flat scene, run before and after the counter, matches (heels within 0.2 cm; halt means identical; moving gaits within 0.07°).

Clocks on the tree left: hk_les_001 **18.54**, hk_adv_001 **91.60**, hk_adv_003 **93.99**. That is 0 / 2 / 3 faults with 0 rails, teleported=false, rounds complete. The pin confidence is 91.0.

- **Style:** B refused fence 1, Idle, hinds 0.053, Neck1 +11.70, Tail1 −0.32. Her helmet heads for the pin's halt (+10.73 at 0.8 s). C one rail, `FENCE knock 3 … jumping=true`.
- **Board:** 21/23 against the seat board, no new rail, 0 teleported. hk_int_007 moved 85.03 → 84.93 (0.10 s, inside the rule); every other row moved ≤ 0.03 s.
- **Playtest:** `PLAYTEST done pass=true`, clear 0 / refuse 4 / rail 4.

Details and every copied line: `dist/heel_002.md`.

---

**27 Sep. Her back over the fence: reverted. It reads him, but it lifts her heel. The half-halt already shows him. The air hip stays. No code changed in this job. No export.**

- **The air hip stays.** `hip_x += SIT_HIP * _hand_unrest()` in the two-point and the arc, SIT_HIP 10. Eased hip 3.1° apart at the two-point and 3.8° at u 0.55. hk_int_007 at 85.03 is inside 0.1 s and is kept.
- **Her back: FOLD_PITCH 18, one attempt, reverted.**
  - Step 0: the eased pitch at u 0.55 was 0.14° apart (−37.53 / −37.67). The ratio was 0.43° eased per target degree, so 18.
  - With 18, her back read him: 6.85° apart at u 0.55 (−40.73 / −47.58), the pin within 3.2°.
  - But her legs pitch with her body, and day-one's two-point heel went **5.0 cm** off the iron (0.1169 → 0.1670), past 2 cm. The heel fail was predicted from the step-0 geometry before the ride. The two-point hip gap also fell to 2.82° and the two-point helmet gap moved 0.57°.
  - All three pitch lines are reverted. A share big enough for 3° of pitch moves the heel more than 2 cm.
- **The half-halt already shows him.** At the deepest collect_pulse (0.717) her helmet is 4.22° apart and her hip 3.12° apart, with his Neck1 9.90° higher on day-one. That is the canter's stride terms, which still run through a half-halt. By the pulse's last frame they are within 1°. No new sit and no change to collect_pulse.

Clocks on the tree left (unchanged, the seat board's): hk_les_001 **18.54**, hk_adv_001 **91.58**, hk_adv_003 **94.01**. That is 0 / 2 / 3 faults with 0 rails, teleported=false. The probed pin rides in this job printed 91.0 confidence, so no fresh leak. No style, board or playtest: the seat board's 21/23 stands.

Details and every copied line: `dist/back_002.md`.

---

**27 Sep. Her seat closes in the air. The air hip is kept, with the sit's own 10 and no new number. The return after the landing is already back; no bend was added. No export. One board row sits exactly on the 0.1 s line; see below.**

`horse.gd`: `hip_x += SIT_HIP * _hand_unrest()`, after the last_stride lerp (× last_stride, gait ≥ 1) and after the jump keys (× 1, held through the arc). SIT_HIP stays 10, so the arc's last hip and the sit's first are the same target.

| fence 1 of hk_les_001, eased hip, pin / day-one | before | after |
| --- | --- | --- |
| two-point, frame before the leave | 26.28 / 24.94 (1.34°) | 27.43 / 30.57 (**3.14°**) |
| u 0.55 | 24.51 / 24.24 (0.27°) | 26.18 / 29.95 (**3.77°**) |

- **Held:**
  - the pin's hip within 1.7° of step 0;
  - the helmets 3.84 / 4.92 / 5.20° apart (the two-point, u 0.55, the sit);
  - the two-point heel within 0.35 cm;
  - fists within 1 cm;
  - the pin crest, Neck1 −21.44.
- **The leave stays one pose.** On hk_adv_002 (clear, 83.12), fences 3 and 12 change 0.00° in pitch, hip and head.
- **The return is already back.** 0.50 s after fence 1 lands, day-one is off the pin by 9.90° in Neck1 and 9.90° in Tail1. Ear1.L is 8.80° apart, its own steady split on this ruler, the same as the halt and the walk. At the land they are within 0.2°, and at 0.25 s half split. Her helmet holds the sit's 5.1–5.2° with no step over 1.6°. `bascule.gd` is untouched.
- **No leak:** the halt and the moving gaits still match `halt_002` and `same_002`.

Clocks on the tree left: hk_les_001 **18.54**, hk_adv_001 **91.58**, hk_adv_003 **94.01**. That is 0 / 2 / 3 faults with 0 rails, teleported=false, rounds complete. The pin confidence is 91.0.

- **Style:** B refused fence 1, Idle, hinds 0.053, Neck1 +11.71, Tail1 −0.32. Her helmet on the check heads for the pin's halt (+10.57 at 0.8 s). C one rail, `FENCE knock 3 … jumping=true`.
- **Board:** 21/23, no new rail, 0 teleported. Worst |Δ| **0.10 s, on hk_int_007** (84.93 → 85.03, still clear, 90 s allowed), exactly on the 0.1 s line. I read the rule as ≤ 0.1 and kept the air hip. If the rule means strictly less than 0.1, revert the two air `SIT_HIP` lines; the helmet shares and the sit stay. Every other row moved ≤ 0.02 s.
- **Playtest:** `PLAYTEST done pass=true`, clear 0 / refuse 4 / rail 4.

Details and every copied line: `dist/seat_002.md`.

---

**27 Sep. She still shows him when she stands up. The two-point and the arc are kept, the sit is kept, and her elbows over the fence are a written negative. The one-stride leaves still change 0.00°. No export.**

`horse.gd`:

- `const FOLD_HEAD := 30.0`: `head_x -= 30 × _hand_unrest()` after the last_stride lerp (× last_stride, gait ≥ 1) and after the jump keys (× 1, held through the arc). The keys are unchanged.
- `const SIT_HIP := 10.0`: in the land sit, only when not jumping and last_stride ≤ 0.20, `head_x -= 30 × unrest` and `hip_x += 10 × unrest`.

Fence 1 of hk_les_001, pin (unrest 0.180) against day-one (0.565), on the eased pose:

| pose | step 0: helmet pin / day-one (apart) | after (apart) | |
| --- | --- | --- | --- |
| two-point, frame before the leave | −1.01 / −2.05 (1.04°) | +0.89 / +4.89 (**4.00°**) | **kept**; pin within 2° of step 0 |
| arc, u 0.55 | +2.95 / +2.73 (0.22°) | +5.27 / +10.28 (**5.01°**) | **kept**, with the two-point share |
| sit, 0.5 s in | flat (targets carry no unrest; first frame 0.04° apart) | +12.07 / +17.27 (**5.20°**) | **kept**; it lasts 0.57 s on hk_les_001 |
| elbows, u 0.55 | 100.01 / 102.82, 103.40 / 106.24 (2.8°) | — | **written negative**: not within the 1° gate, not the 4° that already shows |

- **The leave stays one pose.** On hk_adv_002 (clear, 83.14, 0 rails), fences 3 and 12 change 0.00° in pitch, hip and head from the frame before to the first jumping frame.
- **Held:** fists within 1 cm in the air. The pin crest reads Neck1 −21.44 on both horses.
- **No leak:** the halt and the moving gaits still match `halt_002` and `same_002`.

Clocks, from each phase's logs:

| tree | hk_les_001 | hk_adv_001 | hk_adv_003 |
| --- | ---: | ---: | ---: |
| + two-point and arc | 18.54 | 91.59 | 94.01 |
| + sit (**the tree left**) | **18.53** | **91.59** | **94.01** |

All clocks are 0 / 2 / 3 faults with 0 rails, teleported=false, rounds complete. The pin confidence is 91.0, so no fresh leak.

- **Style:** B refused fence 1, Idle, hinds 0.053, Neck1 +11.72, Tail1 −0.31. Her helmet on the check heads for the pin's halt (+10.57 at 0.8 s; pin +11.31, day-one +14.76). C one rail, `FENCE knock 3 … jumping=true`.
- **Board:** 21/23, worst |Δ| 0.03 s (`hk_int_005`) against the halt board, no new rail, 0 teleported.
- **Playtest:** `PLAYTEST done pass=true`, clear 0 / refuse 4 / rail 4.

Details and every copied line: `dist/fold_002.md`.

---

**27 Sep. A one-stride does not wait, and it does not need to. On hk_adv_002 the related in-fences are already quiet: her pose does not snap and the sounds do not overlap. No code changed. No board. No export.**

One probed ride of hk_adv_002 (clear, 83.12, 12/12), probe stripped. The targets `_update_rider` was about to apply, on the frame before the leave and on the leave frame:

| fence | strides | land_recover at leave | pitch / hip change on that frame | camera | sound |
| --- | --- | ---: | --- | --- | --- |
| 1 (control) | — | 0.000 | 5.56° / 16.36° | +0.4 cm | thud on hoof, grunt u 0.345, no strike in air |
| 3 | one | 0.653 | **0.00° / 0.00°**, **already quiet** | +0.1 cm | no thud playing at the leave or grunt |
| 4 | two | 0.000 | 10.89° / 9.56°, an ordinary leave, same as fences 5 and 7 | +0.8 cm | quiet |
| 11 | two | 0.000 | 7.24° / 6.36°, **already quiet** | +0.9 cm | quiet |
| 12 | one | 0.970 | **0.00° / 0.00°**, **already quiet** | +0.1 cm | no thud playing at the leave or grunt |

- **The one-strides:** on 3 and 12, `ride_ai`'s `last_stride` puts her fully in two-point (−42 / 28, the first jump key) before he leaves. So the land sit and the jump fold never meet on one frame.
- **Fence 4:** it is over 8°, but with land_recover 0. It is the canter-to-keys leave every unrelated fence makes, not a related-line snap, and the brief keeps normal leaves on the keys.
- **Applied pose:** after the ease, her shown pose moves at most 0.52° on any leave frame.
- **Sound:** every thud is on a fore hoof within 2 cm. No `land.wav` is playing at any leave or grunt. There are no strikes in the air.
- **Phases:** phase 1 (blend) and phase 2 (thud and grunt) are both written negatives.

Clocks on the tree left, unchanged from the halt board's: hk_les_001 **18.53**, hk_adv_001 **91.60**, hk_adv_003 **93.99**. That is 0 / 2 / 3 faults with 0 rails, teleported=false, rounds complete. The halt board 21/23 stands.

Details and every copied line: `dist/line_002.md`.

---

**27 Sep, overnight. She shows it at the halt. All three halt phases are kept: her helmet, her elbows and her hip each differ on day-one when he stands. She faces his ears. The stride terms are untouched. No export.**

Three constants, each multiplied by `_hand_unrest()` (0.18 pin, 0.565 day-one), running only at gait 0 with no jump and land_recover 0. None is a sine.

- `horse.gd` halt block: `head_x -= 20.0 * _hand_unrest()` and `hip_x += 9.0 * _hand_unrest()`.
- `rider_mesh.gd`: `SHOULDER_HALT := -40.0`, a constant shoulder turn before the IK, eased in over 0.25 s. `SHOULDER_GIVE[0]` stays 0.

| halt, pin / day-one | before | after | apart | |
| --- | --- | --- | ---: | --- |
| helmet pitch mean | +9.69° / +9.69° | +11.31° / +14.76° | **3.45°** | **kept**; p2p 0.02 / 0.05°, still |
| elbow L mean | 129.98° / 129.98° | 127.81° / 123.55° | **4.26°** | **kept**; bent, fists on target, reach more spare |
| elbow R mean | 134.20° / 134.20° | 131.87° / 127.17° | **4.70°** | **kept** |
| hip_x mean | 7.97° / 7.97° | 9.58° / 13.03° | **3.45°** | **kept**; heel 0.5 / 1.5 cm toward the iron (was 0.069 m) |

- **Nose dot:** +1.000 at the halt and at every gait. Hips on the seat point. Fists 0.000 m from their targets.
- **Moving gaits:** they still match `dist/same_002.md` within 0.3° and 0.5 cm after every phase (helmet, elbow p2p, hip p2p, wrist travel, hoof 0.052–0.053).

Clocks, from each phase's logs:

| after | hk_les_001 | hk_adv_001 | hk_adv_003 |
| --- | ---: | ---: | ---: |
| halt head | 18.54 | 91.58 | 94.01 |
| + halt elbows | 18.53 | 91.60 | 94.00 |
| + halt hip (**the tree left**) | **18.52** | **91.59** | **93.98** |

All clocks are 0 / 2 / 3 faults with 0 rails, teleported=false, rounds complete.

- **Style:**
  - B, the pin's check: Idle, hinds 0.053, Neck1 +11.71, Tail1 −0.32. Her helmet on it is easing to the pin's halt (+9.30° at 0.8 s, against pin +11.31 and day-one +14.76). Her elbows are the pin's (127.98 / 132.05).
  - C: one rail, `FENCE knock 3 … jumping=true`.
- **Board:** 21/23, worst |Δ| 0.06 s (`hk_int_001`) against the give board, no new rail, 0 teleported.
- **Playtest:** `PLAYTEST done pass=true`, clear 0 / refuse 4 / rail 4.

Details and every copied line: `dist/halt_002.md`.

---

**26 Sep, late. What is still the same: printed from one scene, no code. The kept picture holds. The tail tip is the standing negative. Her own pose at the halt is identical on both horses, which is named, not built. No ride, no board.**

| | halt | walk | trot | canter |
| --- | --- | --- | --- | --- |
| nose dot, pin | +1.000 | +1.000 | +1.000 | +1.000 |
| Tail7 tip over the withers, pin / day-one (difference) | −0.297 / −0.245 (5.2 cm) | −0.465 / −0.414 (**5.1 cm**) | −0.465 / −0.414 (**5.1 cm**) | +0.132 / +0.268 (13.6 cm) |
| Ear4 tip distance, head frame | 5.6 cm | 5.6 cm | 5.6 cm | 4.9 cm |
| elbow p2p, more on day-one, L / R | **0.00° / 0.00°** (0.02 / 0.02 on both) | 4.46° / 4.76° | 4.46° / 4.77° | 4.46° / 4.75° |
| hip_x p2p, more on day-one | **0.00°** (0.07 / 0.07) | 3.57° | 3.63° | 3.54° |
| helmet pitch p2p, pin / day-one | **0.00 / 0.00°** (mean +9.69 / +9.69) | 2.33 / 5.84° | 3.67 / 8.40° | 2.85 / 7.50° |
| hips on the seat point | yes (0.000) | yes | yes | yes |

**The tail tip:** at the walk and the trot the Tail7 tips still differ by only 5.1 cm (under 8 cm) and hang below the withers, so the hair stays the written negative.

**At the halt:** her helmet (+9.69° mean), elbows, hip and hands are identical on the pin and on day-one. Every rider term is a stride term, off at gait 0. The horse shows the difference there (Neck1 +9.80 against −0.09, Tail1 −10.12 against −0.22) and she does not.

The give board (21/23, worst move 0.06 s on hk_int_001) stands. Details: `dist/same_002.md`.

---

**26 Sep, late. Her elbow opens again. `SHOULDER_GIVE` goes from 12 to 19 at the walk, trot and canter (one number, halt 0). She still faces his ears and sits on the seat. No export.**

`rider_mesh.gd`: `SHOULDER_GIVE := [0.0, 19.0, 19.0, 19.0]`. With her hips on the seat, 12 opened the elbows 2.83 / 3.02° more on day-one; 12 × 4.5 / 2.83 = 19.1. Untouched: the yaw, side signs, seat line, fist target `Vector3(side * 0.05, 0.09, -0.22)`, pole, nod and hip lines.

| elbow p2p, pin / day-one (more on day-one) | give 12 (face board) | give 19 |
| --- | --- | --- |
| walk L | 1.33 / 4.16 (2.83°) | 2.10 / 6.56 (**4.46°**) |
| walk R | 1.42 / 4.44 (3.02°) | 2.25 / 7.01 (**4.76°**) |
| trot L | 1.32 / 4.15 (2.83°) | 2.10 / 6.56 (**4.46°**) |
| trot R | 1.42 / 4.44 (3.02°) | 2.24 / 7.01 (**4.77°**) |
| canter L | 1.33 / 4.15 (2.82°) | 2.10 / 6.56 (**4.46°**) |
| canter R | 1.42 / 4.45 (3.03°) | 2.25 / 7.02 (**4.77°**) |

- **Elbow means:** unchanged, 130.0° / 134.2°.
- **Fists:** on their targets (0.000 m), 3.3 / 2.8 cm inside her reach.
- **Facing and seat:** nose dot +1.000 at the halt and the canter; hips at the seat point.
- **Held:** nods 2.30 / 5.85, 3.67 / 8.38, 2.85 / 7.50. Hips 3.64 / 3.70 / 3.56° more on day-one. Wrist travel 0.029 / 0.056, 0.055 / 0.081, 0.078 / 0.102. Hoof 0.052–0.053.
- **Clocks:** hk_les_001 **18.53**, hk_adv_001 **91.61**, hk_adv_003 **94.00**. That is 0 / 2 / 3 faults with 0 rails, teleported=false, rounds complete.
- **Style:** B refused fence 1, Idle, hinds 0.053, Neck1 +11.73, Tail1 −0.31, elbows at rest on the check. C one rail, `FENCE knock 3 … jumping=true`.
- **Board:** 21/23, worst |Δ| 0.06 s (`hk_int_001`) against the face board, no new rail, 0 teleported.
- **Playtest:** `PLAYTEST done pass=true`, clear 0 / refuse 4 / rail 4.

Details and every copied line: `dist/give_002.md`.

---

**26 Sep, late. She faces his ears, and she sits on the seat. Her nose dot is +1.000 at the halt and +1.000 at the canter. The yaw also showed a seat bug, now fixed. Her elbows open less than the kept margin. No export.**

- **Her nose:** Head local +Z. The mesh confirms it (brows at +Z, hair at −Z, +Y is the neck/crown). Dot with his flattened forward:

  | row | nose dot |
  | --- | ---: |
  | halt | **+1.000** |
  | canter | **+1.000** |

  Her left wrist and left foot are on his left side, the right ones on his right. Ernie's yaw (`person_look._mount_mesh`, 180°) and side signs (`[["L", -1.0], ["R", 1.0]]`) are right.
- **The seat bug the yaw exposed:** `_sit_hips` set `visual.position = -visual.scale * hip`, which ignores the rotation. Her hips sat **11.7 cm behind the seat point and 1.3 cm right**. Her hand targets were then 2.9 / 3.7 cm beyond her reach, so her arms locked straight (173°).
- **The fix, Ernie's choice over moving the fist target:** `visual.position = -(visual.basis * hip)`, one line. Her hips now sit at the seat point (0, 0, 0). Her fists are on their targets with 3.3 / 2.8 cm of reach to spare.
- **Held:**
  - nods 2.30 / 5.85, 3.67 / 8.39, 2.86 / 7.50;
  - hips 3.64 / 3.69 / 3.54° more on day-one;
  - wrist travel exactly the kept 0.029 / 0.056, 0.055 / 0.081, 0.078 / 0.102;
  - heels as before, hoof 0.052–0.053.
- **Does not meet the kept number, the elbows:**
  - They now rest bent, at 130.0° / 134.2°.
  - They open **2.83° (L) / 3.02° (R) more on day-one** at every gait, against the kept 4.51 / 5.15.
  - A bent elbow turns less per millimetre of shoulder give (~70 % of the rate at 145.6°).
  - Not retuned, per Ernie.
- **Clocks:**

  | tree | hk_les_001 | hk_adv_001 | hk_adv_003 |
  | --- | ---: | ---: | ---: |
  | yaw only | 18.53 | 91.59 | 94.00 |
  | with the seat fix | **18.54** | **91.61** | **93.99** |

  All are 0 / 2 / 3 faults with 0 rails, teleported=false, rounds complete.
- **Style:** B refused fence 1, Idle, hinds 0.053, Neck1 +11.71, Tail1 −0.32. C one rail, `FENCE knock 3 … jumping=true`.
- **Board:** 21/23, worst |Δ| 0.02 s against the hip board, no new rail, 0 teleported.
- **Playtest:** `PLAYTEST done pass=true`, clear 0 / refuse 4 / rail 4.

Details and every copied line: `dist/face_002.md`.

---

**26 Sep, night. Her canter hip and her trot hip. On day-one her seat now reads him at all three gaits. The elbow table, the walk hip and the nod lines are unchanged. No export.**

`horse.gd`, two new lines:

- canter: `hip_x += rock * 22.0 * unrest`, beside the rock's own hip line.
- trot: `hip_x += swing * 18.0 * trot_unrest`, a term beside `post * 32.0 + sit * 5.0`, which is unchanged.

The coefficients come from running the command through the exact `k = 1 − 0.10^delta` ease at STRIDE_HZ. With the new term off, that reproduces today's p2p to 0.01°. The walk's 12 would give the canter only 1.9°.

| hip_x p2p | before (pin / day-one) | after (pin / day-one) | day-one more by |
| --- | --- | --- | ---: |
| canter | 3.91° / 3.93° | 5.54° / 9.09° | **3.55°** |
| trot | 8.84° / 8.81° | 10.58° / 14.27° | **3.69°** |
| walk (kept, not touched) | 4.53° / 8.17° | 4.53° / 8.16° | 3.63° |

Heel to the iron, mean / farthest point, m:

| gait | before (pin; day-one) | after (pin; day-one) |
| --- | --- | --- |
| canter | 0.127 / 0.156; 0.128 / 0.161 | 0.128 / 0.159; 0.127 / 0.170 |
| trot | 0.087 / 0.112; 0.088 / 0.107 | 0.087 / 0.111; 0.091 / 0.107 |

Every heel number is within 1 cm. The trot's farthest point did not move out.

The first trot scene caught a short day-one stride (142 frames), which read the hip 3.24° apart and the nod low (7.90°). The same code measured again on a full stride gives the row above, nod 3.67 / 8.42. Both scenes are in `dist/hip_002.md`. Elbows 4.51 / 5.15° more on day-one and the nods held at every gait. Lowest hoof 0.052–0.053.

Clocks, from each phase's logs:

| after | hk_les_001 | hk_adv_001 | hk_adv_003 |
| --- | ---: | ---: | ---: |
| canter hip | 18.55 | 91.60 | 94.00 |
| + trot hip | 18.54 | 91.59 | 94.00 |

All clocks are 0 / 2 / 3 faults with 0 rails, teleported=false, rounds complete.

- **Style:** B refused fence 1, Idle, hinds 0.053, Neck1 +11.72, Tail1 −0.31, at gait 0, so no hip line runs on the check. C one rail, `FENCE knock 3 … jumping=true`.
- **Board:** 21/23, worst |Δ| 0.02 s against the elbow board, no new rail, 0 teleported.
- **Playtest:** `PLAYTEST done pass=true`, clear 0 / refuse 4 / rail 4.

Details and every copied line: `dist/hip_002.md`.

---

**26 Sep, night. Her elbow. On day-one her elbows now open and close with her hands at all three gaits, and her walk hip swings more. The nod lines are unchanged. No export.**

Before this, her arm was one stiff line that only shifted: the elbow was 145.62° L / 150.38° R at every gait on both horses, moving ≤ 0.04° over a stride.

- **The elbow:** `rider_mesh.gd` `SHOULDER_GIVE := [0.0, 12.0, 12.0, 12.0]`. Her shoulder gives about her body's vertical axis by `sin(stride_u · TAU) × 12 × _hand_unrest()` before the arm IK, so the IK still puts the fist exactly on its target and only the elbow angle changes.
- **Why not the pole or a bend after the IK:** the IK has fixed bone lengths, so the elbow angle is set by the shoulder-to-fist distance alone. The pole only turns the arm's plane. A bend after the IK would move the fist about 1.3 cm, past the 0.5 cm hand rule.
- **Untouched:** the fist target, pole, withers spot and rein.
- **The walk hip:** `horse.gd`, gait 1, `hip_x += w * 12.0 * walk_unrest`.

| row | before (pin / day-one) | after (pin / day-one) | day-one more by |
| --- | --- | --- | ---: |
| walk elbow p2p, L / R | 0.03 / 0.01°, 0.02 / 0.02° | 2.12 / 6.63°, 2.41 / 7.56° | **4.51° / 5.15°** |
| trot elbow p2p, L / R | 0.00 / 0.01°, 0.01 / 0.01° | 2.11 / 6.62°, 2.40 / 7.55° | **4.51° / 5.15°** |
| canter elbow p2p, L / R | 0.02 / 0.03°, 0.01 / 0.04° | 2.12 / 6.64°, 2.40 / 7.56° | **4.52° / 5.16°** |
| walk hip_x p2p | 2.83 / 2.83° | 4.54 / 8.17° | **3.63°** |

Elbow means are unchanged (145.6° / 150.4°). The fists travel the same 0.029 / 0.056, 0.055 / 0.081 and 0.078 / 0.102–0.103. The heel's mean distance to the iron is unchanged (0.120 at the walk), and its farthest point moves 0.2 / 0.9 cm. Nod pitches, lowest hoof 0.052–0.053 and Neck1 / Tail1 9.9° apart all held.

Clocks, from each phase's logs:

| after | hk_les_001 | hk_adv_001 | hk_adv_003 |
| --- | ---: | ---: | ---: |
| trot elbow | 18.53 | 91.61 | 94.01 |
| + walk elbow | 18.54 | 91.62 | 94.00 |
| + canter elbow | 18.54 | 91.59 | 94.00 |
| + walk hip | 18.54 | 91.60 | 93.99 |

All clocks are 0 / 2 / 3 faults with 0 rails, teleported=false, rounds complete.

- **Style:** B refused fence 1, Idle, hinds 0.053, Neck1 +11.72, Tail1 −0.31, elbows at rest on the check. C one rail, `FENCE knock 3 … jumping=true`.
- **Board:** 21/23, worst |Δ| 0.02 s against the nod board, no new rail, 0 teleported.
- **Playtest:** `PLAYTEST done pass=true`, clear 0 / refuse 4 / rail 4.

Details and every copied line: `dist/elbow_002.md`.

---

**26 Sep, evening. Her head at the walk and the canter. On day-one her helmet now nods on her shoulders at all three gaits. The trot's 48 is unchanged. No export.**

`horse.gd`, two new lines: gait 1 `head_x -= w * 26.0 * walk_unrest`, gait 3 `head_x -= rock * 64.0 * unrest`. Both coefficients come from the measured ease (the helmet follows 0.45 of head_x; the ease passes 0.394 of the walk stride and 0.211 of the canter stride). Trot branch, pitch, rest and `bascule.gd` untouched.

| helmet pitch vs her shoulders, p2p | before (pin / day-one) | after (pin / day-one) | day-one more by |
| --- | ---: | ---: | ---: |
| walk | 0.64° / 0.64° | 2.31° / 5.85° | **3.54°** (≥ 3) |
| canter | 0.68° / 0.68° | 2.85° / 7.55° | **4.70°** (≥ 4) |
| trot (not touched) | 3.66° / 8.38° | 3.66° / 8.37° | 4.71° |

Hands, lowest hoof 0.052–0.053 and Neck1 / Tail1 9.9° apart held after each phase.

- **Clocks, walk line in:** hk_les_001 18.53, hk_adv_001 91.6, hk_adv_003 94.01.
- **Clocks, walk + canter:** hk_les_001 18.54, hk_adv_001 91.61, hk_adv_003 93.98.
- All clocks: 0 / 2 / 3 faults, 0 rails, teleported=false, complete.
- **Style:** B refused fence 1, Idle, hinds 0.053, Neck1 +11.72, Tail1 −0.32, at gait 0, so no nod line runs on the check. C one rail, `FENCE knock 3 … jumping=true`.
- **Board:** 21/23, worst |Δ| 0.02 s against the head_002 board, no new rail, 0 teleported.
- **Playtest:** `PLAYTEST done pass=true`, clear 0 / refuse 4 / rail 4.

Details and every copied line: `dist/nod_002.md`.

---

**26 Sep. Her head at the trot. On day-one her helmet now nods against her shoulders at the trot; the ear needed nothing. No export.**

`horse.gd`, gait 2 only: `head_x += swing * 48.0 * trot_unrest`, the same shape as the trot pitch line. Walk, canter, pitch, rest, post × 8.4 untouched. `bascule.gd` untouched.

- **Trot helmet pitch vs her shoulders, peak-to-peak: before 1.48° / 1.48° (pin / day-one), after 3.67° / 8.39°: 4.72° more on day-one.** Trot hands 0.055 / 0.081, walk head 3.7 cm, walk hands 2.7 cm, lowest hoof 0.052–0.053, canter Neck1 / Tail1 9.9° apart: all unchanged.
- **Ear4.L tip at the canter, head frame:** pin (−0.110, −0.163, +0.111), day-one (−0.111, −0.135, +0.151): 4.9 cm apart already, so no Ear2 bend.
- **Clocks: hk_les_001 18.54, hk_adv_001 91.6, hk_adv_003 94.02.** 0 / 2 / 3 faults, 0 rails, teleported=false, complete. Style B 69.89 / C 67.17. Board 21/23 (worst |Δ| 0.02 s against the floor). `PLAYTEST done pass=true`.

Details and every line copied from the logs: `dist/head_002.md`.

---

**27 Sep. The tail she can see: the hair followed the dock at the walk and trot, but missed the canter band by 1 mm, so it is a written negative and reverted. No code kept this job; the 21/23 board stands. No export.** Detail: `dist/tail_002.md`.

## The tail tip (Tail7, the last tail bone), height over the withers, m

| gait | before: pin / day-one | with the hair: pin / day-one | band |
| --- | --- | --- | --- |
| walk | −0.465 / −0.414 (5.1 cm) | −0.465 / **−0.318** (14.7 cm) | ≥ 8 cm — met |
| trot | −0.465 / −0.414 (5.1 cm) | −0.465 / **−0.318** (14.7 cm) | ≥ 8 cm — met |
| canter | +0.131 / +0.264 | +0.131 / **+0.305** | day-one within 4 cm of +0.264 — **4.1 cm, missed by 1 mm** (a second scene of the same code read 3.9) |

The hair (Tail2–Tail5, a share of the same worry, scaled by how much the tail hangs) lifted the hanging hair and left the pin untouched, the day-one tail 1.02–1.06 m from her hip, Tail1 and Neck1 9.9° apart, and the lowest hoof 0.052–0.053. The appended rows miss the canter band, so under the rule it is reverted with no second set of angles. The tree is back to the start of this job: the tail she sees at the walk and trot is Tail1's dock, 5.1 cm at the tip.

Clocks with the hair in, copied from their logs:

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.54 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.59 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=93.99 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

## Her head

Head-bone travel, pin / day-one: walk 0.040 / 0.076 (3.6 cm), trot 0.101 / 0.100. The trot term was gated on the hair holding, so it was not written. Her helmet crown travels walk 0.047 / 0.092, trot 0.115 / 0.105 — the trot helmet is not larger on day-one.

## Coming back to himself (fence 1, `hk_les_001`, recover elapsed)

| | touchdown | 0.25 s | 0.50 s |
| --- | --- | --- | --- |
| pin Neck1 / Tail7 tip | −34.54 / +0.207 | −16.42 / −0.033 | −20.34 / +0.372 |
| day-one Neck1 / Tail7 tip | −34.17 / +0.163 | −11.47 / +0.034 | −10.44 / +0.507 |

Together at touchdown, 9.9° and 13.5 cm apart by 0.50 s. The return is already the picture; no code.

---

**26 Sep, night. Her hands go with him at the walk and the trot now. Board 21/23, worst move 0.02 s. No export.**

Clocks, copied from the three pin rides after the change (`dist/hands_002.md`):

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.61 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=93.99 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

## The fists over a fence

Pin: each wrist stays within 0.017 m of its learned spot from u 0.20 to 0.80, and the two wrists are 0.100 m apart all the way — the 0.13–0.15 m of the last log was the old spread mixing frames, not a throw. Day-one: the wrist leaves its learned spot late in the jump by an amount that moves between runs — 0.038 / 0.036 m at u 0.80 in the inventory ride; 0.026 m at u 0.70 and 0.016 / 0.020 m at u 0.80 in a later day-one ride. It is a few centimetres, and holding it would mean moving her arm or her seat. Left; `rider_mesh.gd` unchanged.

## Walk and trot, before and after (throwaway scene, deleted), canter alongside

| gait | pin hands before → after | day-one hands before → after | difference after | neck / tail difference |
| --- | --- | --- | ---: | --- |
| walk | 0.017 → 0.029 | 0.017 → 0.056 | **2.7 cm** | 9.9° / 9.9° |
| trot | 0.043 → 0.055 | 0.043 → 0.081 | **2.6 cm** | 9.9° / 9.9° |
| canter | 0.077 → 0.078 | 0.103 → 0.103 | 2.5 cm | 9.9° / 9.9° |

`horse.gd` `_update_rider`, gait 1 and gait 2 only: a share of `_hand_unrest()` on top of the gait, on the stride. The canter branch, the quiet picture, the crest, the pastern, the beat gate, the landing camera and the straight rein are unchanged. The lowest hoof is 0.052–0.053 on every gait.

## The half-halt — left

At the deepest sit the day-one neck is still 9.9° higher than the pin's (−11.86 against −21.76). The half-halt does not erase the head, so no sit was written.

Style, pin: B refused fence 1, 0 rails, Idle, hinds 0.053 / 0.053, Neck1 +11.71, Tail1 −0.32 — his own check. C one rail on fence 3 in the air. Board below in `dist/hands_002.md`: 21/23, the 21 within 0.02 s, no new rail, teleported=false; `--playtest` PASS.

---

**26 Sep, evening. He gets quieter, and she can see it. The cert cannot: the pin horse looks and rides as before. Board 21/23, worst move 0.02 s. No export.**

Clocks: **hk_les_001 18.53, hk_adv_001 91.61, hk_adv_003 93.99** — 0 / 2 / 3 faults, 0 rails, teleported=false, complete. `--playtest` PASS. Detail: `dist/horse_feel.md`.

## The two canters, from the rides

| ride | stats at the start | Neck1 | Tail1 | tail tip over withers | Ear1.L | poll | hand travel |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: |
| pin `--ridecert-id=hk_les_001` | conf 85, scope 80, ride 44, timing 38, feel 36 | −15.24 / −15.44 | −0.70 / −0.86 | +0.126 / +0.066 | +5.41 / +5.38 | 0.420 / 0.447 | 0.090 / 0.085 |
| day-one `--ridecert-fresh --ridecert-id=hk_les_001` | conf 48, scope 40, ride 44, timing 38, feel 36 | −5.20 / −5.38 | −10.53 / −10.70 | +0.257 / +0.205 | −3.28 / −3.20 | 0.509 / 0.533 | 0.121 / 0.114 |
| difference | | **10.0° higher** | **9.8°**, tail up | +0.13 m | **8.6° forward** | +0.087 m | **3.0 cm more** |

## After a clear, after a refusal — from the scene, stats from the ride and the save

| row | stats (source) | Neck1 | Tail1 | tail tip | Ear1.L | poll | hand travel |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: |
| day-one | 48 / 40 / 44 / 38 / 36 (`_day_one`) | −5.37 | −10.65 | +0.268 | −3.35 | 0.506 | 0.103 |
| after a clear | 54.0 / 44.5 / 48.0 / 42.0 / 39.0 (written by `--ridecert-fresh --ridecert-id=hk_beg_035`: `ridecert_fresh_one.json` conf 54.0, scope 44.5; the save it wrote for the rest) | **−8.02** | **−7.94** | +0.232 | −0.90 | 0.484 | **0.094** |
| after a refusal | 46.0 / 42.5 / 44.0 / 40.0 / 37.0 (`_school_from_round`, one refusal, 4 faults, no rail) | **−4.42** | **−11.52** | +0.278 | −4.13 | 0.514 | **0.104** |
| pin, same scene | 85 / 80 / 44 / 38 / 36 | −15.26 | −0.75 | +0.133 | +5.45 | 0.419 | 0.078 |

The picture reads the stats in `bascule.gd` (neck, tail, ears, ground only) and `horse.gd` `_update_rider` (her canter bounce); it writes nothing. The rein stays the straight rod; the five slow landings stay a written negative.

---

**26 Sep, late. One clear round, from the saddle. The landing no longer yanks. The rein is still a straight rod — a written negative. Board 21/23, worst move 0.05 s. No export.**

Clocks after the last keep: **hk_les_001 18.54, hk_adv_001 91.60, hk_adv_003 94.00** — 0 / 2 / 3 faults, 0 rails, teleported=false, rounds complete. `--playtest` PASS.

- **Landing, °/frame:** 6.02–6.59 on ten of twelve `hk_adv_002` fences before (the 0.66 m lens drop read against the rail); **0.30–1.11 on all twelve after**. `hk_les_001` fence 1: 6.05 → 0.63 against its 1.22 approach. `_place_cam` only: the recover's sit and the half-halt's lens ease in and out as a continuous state that takes up the jump's own step. Look target, FOV, approach cap and aim, CAM_MIN_Y, camera-to-withers (≥ 5.12 m) unchanged.
- **Rein: a rod, not a strip.** Laid every frame on the posed neck it came to −5.0 cm, then −6.7 cm and a clock that moved (18.61); cheap skin-profile variants reached −4.2 cm offline, never +1 cm. Reverted; straight rod, −19.4 … −20.5 cm at u 0.55.
- **Twelve fences:** 0 of 12 before, **7 of 12 after**. The five that fail do so only on landing-vs-approach, where the approach is a near-straight line (0.22–0.69°/frame) and the landing must hand the look back from the rail; two class fixes were spent, so that test is a written negative. Look, thud, pastern, and the rein (under its negative) pass on every row.

Full record: `dist/round_002.md`.

## Twelve fences, `hk_adv_002` — after (from dist/round_002.md)

| fence | look u0.55 (m) | approach °/f | landing °/f | fore at thud (m) | pastern u0.55 (m) | rein u0.55 (cm) | rein land+0.40 (cm) | pass |
| ---: | ---: | ---: | ---: | --- | ---: | ---: | ---: | --- |
| 1 | 0.065 | 0.53 | 0.79 | 0.056 / 0.069 | 0.000 | -19.9 | -12.5 | fail: land |
| 2 | 0.059 | 1.63 | 0.75 | 0.056 / 0.069 | 0.000 | -19.9 | -13.8 | pass |
| 3 | 0.019 | 0.34 | 0.30 | 0.055 / 0.069 | 0.000 | -19.5 | -12.7 | pass |
| 4 | 0.067 | 0.31 | 1.01 | 0.053 / 0.061 | 0.000 | -19.9 | -12.2 | fail: land |
| 5 | 0.075 | 4.25 | 0.63 | 0.053 / 0.063 | 0.000 | -20.3 | -11.8 | pass |
| 6 | 0.064 | 0.69 | 1.02 | 0.056 / 0.069 | 0.000 | -19.9 | -13.3 | fail: land |
| 7 | 0.065 | 0.99 | 0.72 | 0.053 / 0.061 | 0.000 | -20.5 | -12.4 | pass |
| 8 | 0.058 | 2.29 | 1.11 | 0.056 / 0.069 | 0.000 | -19.9 | -13.1 | pass |
| 9 | 0.073 | 1.46 | 0.64 | 0.056 / 0.069 | 0.000 | -19.5 | -14.1 | pass |
| 10 | 0.068 | 5.92 | 0.60 | 0.056 / 0.070 | 0.000 | -20.3 | -13.1 | pass |
| 11 | 0.055 | 0.23 | 0.52 | 0.053 / 0.067 | 0.000 | -20.3 | -13.6 | fail: land |
| 12 | 0.018 | 0.22 | 1.09 | 0.053 / 0.057 | 0.000 | -19.5 | -12.0 | fail: land |

7 of 12 rows pass. Rein columns: signed distance to the posed neck mesh, worst of both reins, positive = outside.

## Twelve fences, `hk_adv_002` — Step 0, before

| fence | look u0.55 (m) | approach °/f | landing °/f | fore at thud (m) | pastern u0.55 (m) | rein u0.55 (cm) | rein land+0.40 (cm) | pass |
| ---: | ---: | ---: | ---: | --- | ---: | ---: | ---: | --- |
| 1 | 0.072 | 0.52 | 6.08 | 0.057 / 0.071 | 0.000 | -20.0 | -12.8 | fail: land, rein |
| 2 | 0.066 | 2.21 | 6.19 | 0.055 / 0.067 | 0.000 | -19.9 | -13.8 | fail: land, rein |
| 3 | 0.021 | 0.28 | 1.51 | 0.055 / 0.069 | 0.000 | -19.8 | -12.1 | fail: land, rein |
| 4 | 0.066 | 4.16 | 6.13 | 0.053 / 0.062 | 0.000 | -19.5 | -12.4 | fail: land, rein |
| 5 | 0.071 | 4.53 | 6.17 | 0.053 / 0.061 | 0.000 | -20.3 | -11.7 | fail: land, rein |
| 6 | 0.066 | 3.73 | 6.28 | 0.061 / 0.082 | 0.000 | -19.9 | -12.4 | fail: land, thud, rein |
| 7 | 0.070 | 4.02 | 6.57 | 0.053 / 0.061 | 0.000 | -20.3 | -12.2 | fail: land, rein |
| 8 | 0.051 | 2.11 | 6.02 | 0.053 / 0.062 | 0.000 | -19.9 | -12.7 | fail: land, rein |
| 9 | 0.065 | 1.73 | 6.11 | 0.056 / 0.068 | 0.000 | -19.5 | -12.6 | fail: land, rein |
| 10 | 0.064 | 4.15 | 6.11 | 0.057 / 0.071 | 0.000 | -20.3 | -12.6 | fail: land, rein |
| 11 | 0.068 | 4.12 | 6.59 | 0.053 / 0.062 | 0.000 | -20.3 | -12.3 | fail: land, rein |
| 12 | 0.019 | 0.32 | 1.07 | 0.055 / 0.070 | 0.000 | -19.8 | -12.1 | fail: land, rein |

0 of 12 rows pass. Rein columns: signed distance to the posed neck mesh, worst of both reins, positive = outside.

## Board — one full `--ridecert`, `board_table.py`

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

---

**26 Sep, evening. The jump look is on the fence he is jumping. No full board, no export.**

`horse.gd` `_place_cam` only (the look target; camera position, FOV, the 0.88 cap, the y 0.85 approach aim, CAM_MIN_Y unchanged). While he is over `jump_fence` the look goes from the aim he had on the last stride onto that fence's top rail (position + its own height), and starts back toward the canter look from u 0.60 (60 % by touchdown), finishing over the first second of land_recover. A schooling jump with no fence keeps the old push.

Look vs the top rail, first fence of `hk_les_001` (0.42 m):

| | before | after |
| --- | ---: | ---: |
| approach, fence 4 m ahead | 0.53 | 0.53 |
| jump u 0.20 | 2.56 (2.41 past it) | 0.46 |
| jump u 0.55 | **4.92 (4.77 past it)** | **0.139** |
| jump u 0.85 | 6.39 (6.13 past it) | 0.60 (handing back) |

Camera to Torso3 unchanged: 5.24 approach, 5.28–5.72 through the jump. Take-off turn 0.99°/frame (was 1.50). The 6.3° turn on the landing frame is the existing 0.66 m camera drop in `_place_cam` (the look point itself moves 0.09 m that frame), reading larger than the old 3.3° because the look is 6 m away on the rail instead of 11 m past it. Camera position left alone.

Clocks: **hk_les_001 18.54, hk_adv_001 91.59, hk_adv_003 94.00** — 0 / 2 / 3 faults, 0 rails, teleported=false, complete. `--playtest` PASS: clear 0 / refuse 4 / rail 4.

---

**26 Sep, afternoon. The gait-change beat is kept. The rein is reverted to one straight rod. No full board (this change does not move the horse). No export.**

## The beat after a gait change (kept)

`stride_u` runs straight through a gait change while the beat index is `floor(stride_u × beats)`, so when the count per stride changed (walk 4, trot 2, canter 3) the index jumped on the change frame and sounded a footfall mid-stride, inside the clip blend; from the halt, `stride_u` restarts at 0 and the walk sounded on its first frame, still in Idle. Now a new gait takes its beat index silently, and `_hoof_strike` sounds only once the gait is 0.18 s old (the blend `_play_named` uses). `horse.gd` `_animate` beat block only; STRIDE_HZ, GAIT_SPEED, the pastern, the crest, the straight rein untouched.

First footfall after each change, `hk_les_001` (contact 0.053; up = more than 0.093):

| first beat | before | after |
| --- | --- | --- |
| trot | FF.L only 0.076 up — a miss | FF.L 0.053 + FFB.R 0.055 down, FF.R 0.195 up |
| canter | all four in the air (lowest 0.172) | FFB.L 0.053 down, FF.L 0.188 up |
| walk | all four at 0.053 on the change frame | none — the cert walks ~0.07 s before the trot, so no footfall falls in it |

Clocks: **hk_les_001 18.54, hk_adv_001 91.59, hk_adv_003 94.00** — 0 / 2 / 3 faults, 0 rails, teleported=false, rounds complete.

Style `hk_beg_035`: A clear, 0 faults, 67.30 · B refused fence 1, 4 faults, 0 rails, 69.89 · C one rail on fence 3, `FENCE knock 3 … jumping=true`, 67.16. `--playtest` PASS: clear 0 / refuse 4 / rail 4.

## The rein (reverted)

Three segments a side — bit, a point beside the neck on Neck2, a point over the withers on Torso3, the glove — drawn after the skeleton update. On the drawn rods of the last probe (style `hk_beg_035`, posed-mesh clearance): 35 of 36 rein samples 1.0–3.7 cm outside the neck, extra length ≤ 0.130 over each sample's straight rod, no fold; the first landing at 0.40 s, left rein, **+0.000** (touching, 0.098 extra). The land pose varies from run to run and two fixed bends inside 0.13 m could not keep 1 cm through it. `_make_reins` / `_update_reins` are back to one straight rod, byte-identical to this morning.

---

**26 Sep, day. The pastern is on the leg. The rein is not fixed — a true negative, measured against the posed mesh. Board 21/23 (one full `--ridecert`, below), worst move 0.04 s, no new rail, teleported=false, style A/B/C honest, `--playtest` PASS. No export.**

Files: `bascule.gd` only (the hoof placed on its cannon; the leg reaches the sand). `horse.gd`, `rider_mesh.gd`, `ride_ai.gd`, `ride_cert.gd`, `game_state.gd`, course JSON (both trees) byte-identical to this morning's floor. No rein code was written. Frozen numbers held on every probe: crest u 0.55 round +15.0, Neck1 −21.4, fore cannon −30.2; chip round 0.0, Neck1 +11.5, fore cannon +3.7; fore hoof at the thud within 2 cm of 0.053.

## The pastern — gap before and after

Gap = distance from the hoof bone (FF.L / FF.R / FFB.L / FFB.R) to the tip of its cannon (FrontLowerLeg.* / BackLowerLeg.*, the last bone of each leg chain; the tip is where the hoof sits at rest, carried by the posed cannon — 0.002–0.005 m standing). `hk_les_001`, m:

| sample | before | after |
| --- | ---: | ---: |
| planted canter hoof (FFB.L at 0.053 / FFB.R at 0.053) | 0.086–0.107 / 0.141–0.144 | 0.000 / 0.017–0.022 |
| same beat, hoof in the air (FFB.R / FF.L) | 0.157–0.158 / 0.146–0.147 | 0.000 / 0.000 |
| clear u 0.20 (worst hoof) | 0.177 | 0.000 |
| clear u 0.55 (FF.R / FF.L) | **0.214 / 0.184** | **0.000 / 0.000** |
| clear u 0.85 | 0.155 | 0.000 |
| clear u 1.00 | 0.082 | 0.025 |

How: in `bascule.gd`, after the cannon bends, each IK root is set so its hoof sits on its cannon tip. In the air that is all. On the ground the leg does the reaching — a two-bone reach on UpperLeg + LowerLeg, the knee kept in its own plane — so a hoof the clip has down is on the sand at 0.053 and none goes under it; in a check the hinds are held down. Over u 0.90–1.00 the legs reach for the sand on the way down so u 1.00 is already there. Where the leg is already straight at touchdown, the pastern takes the last of it, capped at 0.03 m (the largest gap anywhere after the fix is 0.025). The cannon bends were not touched.

Thud, fore hooves: 0.056 / 0.069, 0.053 / 0.062, 0.053 / 0.054 on `hk_les_001`; every landing of the `hk_beg_035` style run between 0.053 and 0.069 (≤ 1.6 cm). Refusal: Idle on every sample, hinds 0.071 / 0.087 at 0.10 s and 0.053 / 0.053 from 0.25 s, fore pastern 0.000 while the forehand is up. Chip: u 0.55 gap 0.000, land fore 0.053 / 0.063, pastern ≤ 0.025.

Clocks after the pastern: **hk_les_001 18.53, hk_adv_001 91.60, hk_adv_003 94.00.** Style: A clear 67.28, B refused fence 1, 0 rails, 69.89, C one rail on fence 3 in the air, 67.16.

## The rein — measured against the mesh, not fixed

Clearance is the signed distance to the drawn neck mesh: the 938 withers/neck/head vertices skinned on the CPU from the posed skeleton after the bends (Σ weight × bone pose × bind pose), nearest vertex, along its normal. Checked: the lowest hoof vertex tracks its bone 0.03 m below on every sample. Style run of `hk_beg_035`, 16 samples: three canter, clear and chip at u 0.20 / 0.55 / 0.85 / 1.00, the land at 0.15 / 0.40 s, the refusal at 0.10 / 0.25 / 0.50 s.

- The straight rod today is **7–20 cm inside the mesh** on every sample (canter −0.12, clear crest −0.20, refusal −0.07 … −0.13). The bit ring sits 2 cm outside the mouth and the glove 10–18 cm above the withers; the rod dives in over 40–70 % of its length.
- One crest point riding a neck bone (Neck1 / Neck2 / Neck3, searched ±0.42 lateral, −0.25…+0.30 along, −0.15…+0.45 up, per side): **clearing every sample by ≥ 1 cm costs at least 0.214 m of extra rein** in some sample — two hands of slack.
- Held within a hand of the straight rein in every sample, the best crest point still leaves the rein **4.7 cm inside** at its worst sample.
- Even re-placed perfectly in each frame, the shortest clearing detour is +0.04–0.05 on the refusal and +0.078 at the canter, but **+0.095 to +0.125 at the jump** — over a hand.
- "Within 10 cm of 1.357" cannot be the test: the Gallop clip nods the head through the stride, and on this run's canter sample the straight rein is already 1.635.

So it does not clear without lifting her fists or a second bend — both ruled out. No rein code was written; the rods are as they were.

## Board — one full `--ridecert`, `board_table.py`

| id | result | faults | jumped | time_s | allowed | why |
| --- | --- | --- | --- | --- | --- | --- |
| hk_les_001 | CLEAR | 0 | 3/3 | 18.5 | — | — |
| hk_les_002 | CLEAR | 0 | 3/3 | 16.5 | — | — |
| hk_les_003 | CLEAR | 0 | 3/3 | 18.2 | — | — |
| hk_les_004 | CLEAR | 0 | 3/3 | 18.0 | — | — |
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
| hk_int_009 | CLEAR | 0 | 10/10 | 85.0 | 90 | — |
| hk_adv_001 | fail | 2 | 12/12 | 91.6 | 80 | 2 time faults (allowed 80 s) |
| hk_adv_002 | CLEAR | 0 | 12/12 | 83.1 | 80 | — |
| hk_adv_003 | fail | 3 | 12/12 | 94.0 | 80 | 3 time faults (allowed 80 s) |
| hk_adv_005 | CLEAR | 0 | 12/12 | 78.9 | 80 | — |
| hk_jo_beg_001 | CLEAR | 0 | 4/4 | 35.4 | 42 | — |
| hk_jo_int_001 | CLEAR | 0 | 4/4 | 36.5 | 38 | — |
| hk_jo_adv_001 | CLEAR | 0 | 4/4 | 35.8 | 34 | — |

board 21/23  pass=False
style A_clear PASS faults=0 refused=[] rails=0 t=67.3 teleported=False
style B_refuse PASS faults=4 refused=[1] rails=0 t=69.9 teleported=False
style C_rail PASS faults=4 refused=[] rails=1 t=67.2 teleported=False
teleported rounds: 0

Against this morning's floor: worst |Δ| 0.04 s (`hk_jo_beg_001`). No new rail. C's rail `FENCE knock 3 by horse … jumping=true`. `--playtest` PASS: clear 0 / refuse 4 / rail 4.

The board's wrapper was stopped by Claude Code for low memory right after the first round, as last night; its Godot rode on to `RIDECERT done`, no second board was started, and `ridecert_results.json` was copied to `ridecert_board.json` by hand.

---

**26 Sep, overnight, unattended. The hooves meet the sand. Board 21/23 (one full `--ridecert`, below), worst move 0.02 s, no new rail, teleported=false, style A/B/C honest, `--playtest` PASS. The reins still pass through the neck — measured, not fixed (phase 4). No export.**

Files: `horse.gd` (land tilt `LAND_X`, the thud at contact height, gait clips held to the beat, the sit sign), `bascule.gd` (foot plant; the check's hinds). `rider_mesh.gd`, `ride_ai.gd`, `ride_cert.gd`, `game_state.gd`, course JSON (both trees) byte-identical to the floor. `_process_jump`, `_begin_jump`, `_begin_schooling_jump`, leave windows, TAKEOFF, `collect_pulse` (the mechanic), GAIT_SPEED, STRIDE_HZ, turn rate, land_recover 2.72 untouched. The clear crest (round +15.0, Neck1 −21.4, fore cannon −30.2) and the chip (round 0.0) are the same numbers as before, on every probe.

## Which bones are the hooves

A headless read of the mesh skin: the lowest vertices under each foot are weighted to **FF.L / FF.R (fore)** and **FFB.L / FFB.R (hind)**, with their IK roots IKFrontLeg.* / IKBackLeg.*. They are separate roots, not children of the cannons — the leg bones do not carry the hoof.

## Contact height — 0.053 m

Standing on Idle: fore 0.037 / 0.036, hind 0.068 / 0.070 at `visual.rotation.x` −0.025, which levels to **0.053 for all four**. The Idle clip has every hoof exactly at rest (Δ 0.000), and `abbott_look` puts the mesh's lowest point on y 0. That is the sole on the sand.

The brief asked for the canter low point instead. There is not one: on clean strides (no half-halt) the lows were hinds −0.043 (both, every stride), FF.R 0.003–0.016, FF.L 0.096–0.19. The hinds were the procedural bob's trough, 10 cm into the sand; the half-halts drove the fore feet to −0.38 … −0.51. The canter was the thing that was wrong, so it could not be the ruler. Every number below is against 0.053.

## Phase 1 — the land (kept)

The old land pose held the forehand up 0.16 rad for all of land_recover. Now the descent eases to `LAND_X` −0.01 at touchdown (so u 1.00 is the next frame's pose) and levels off over 0.4 s. The thud plays when a fore hoof is within 2 cm of contact, not when a floating hoof stops falling.

| | FF.L | FF.R | FFB.L | FFB.R |
| --- | ---: | ---: | ---: | ---: |
| thud, before | 0.208 | 0.319 | 0.170 | 0.240 |
| thud, after (first clear) | **0.053** | **0.053** | 0.069 | 0.053 |
| 0.40 s after, before | 0.346 | 0.284 | −0.058 | −0.097 |
| 0.40 s after, after | 0.331 | 0.293 | 0.053 | 0.066 |

Every clear landing on `hk_beg_035` in the style probe reads fore 0.053 / 0.053 at the thud, 0.017–0.034 s after the root touches. Clocks 18.54 / 91.60 / 93.99.

## Phase 2 — the striking hoof (kept), and 2b — the sit (kept)

Two causes, both measured: the clips drift against the beat, and the procedural bob and rock move planted hooves through the sand.

- Clips held to the beat, the trot's own pattern (rate + seek): Walk 0.235, trot 0.25 (unchanged), Gallop 0.115 — the phases where the clip's own touchdowns fall on the beats. The trot's seek ran at rate 0, so its 0.18 s blend never finished and it trotted half in Idle; only the rate changed.
- Foot plant in `bascule.gd`: a hoof the clip has on the ground is pinned to the sand, and no hoof goes under it. Recomputed each frame, never in the air.
- 2b: `_animate` wrote every sit negative — forehand down. The half-halt dove 0.31 rad with the fore feet 15 cm in the sand. Now +0.06 (half-halt), +0.03 (collected), +0.05 (halt sit).

One beat of each, `hk_les_001`, steady state (contact 0.053; "up" = more than 0.093):

| gait | beat | FF.L | FF.R | FFB.L | FFB.R | hit |
| --- | --- | ---: | ---: | ---: | ---: | --- |
| trot | 1 | 0.053 | 0.219 | 0.070 | 0.055 | FF.L + FFB.R down, FF.R up |
| trot | 0 | 0.200 | 0.053 | 0.053 | 0.062 | FF.R + FFB.L down, FF.L up |
| canter | 0 | 0.068 | 0.284 | 0.478 | 0.426 | FF.L |
| canter | 1 | 0.487 | 0.422 | 0.312 | 0.053 | FFB.R |
| canter | 2 | 0.194 | 0.065 | 0.053 | 0.139 | FFB.L |

Lowest canter hoof over the whole ride: 0.053 (was −0.155). Misses: the first beat of each new gait lands inside the clip crossfade (walk beat 0 all four at 0.053; first trot FF.L only 0.076; first canter beat 1 all up). The cert walks 0.85 s — one beat, and it is that transition; the steady walk is from the clip held at 0.235: FFB.L 0.009, FF.L 0.000, FFB.R 0.016, FF.R 0.007 against rest, another hoof 0.15–0.22 up. Clocks 18.53 / 91.60 / 94.00 (2), 18.52 / 91.59 / 93.99 (2b).

## Phase 3 — the chip and the check (kept)

Style probe on `hk_beg_035`:

- A clear: crest round +15.0, fore feet 0.053 / 0.053 at every thud.
- B refused fence 1, 4 faults, 0 rails, Idle on every sample. Forehand up +0.14; hinds 0.068 / 0.075 at t 0.10 once pinned by `check_w` (0.078 / 0.096 before; a first try pulled them to 0.192 / 0.202 and was replaced), 0.053 / 0.053 from 0.25 s; fores 0.13 up. Fists never forward of the canter spot (withers-frame y −0.366 … −0.429 against −0.365).
- C one rail on fence 3, `FENCE knock 3 … jumping=true`. Chip u 0.55 round 0.0 (clear +15.0), neck +11.5, fore +3.7. Chip thud fore 0.053 / 0.053.

Clocks 18.53 / 91.59 / 94.00. Style A 67.29, B 69.87, C 67.14.

## Phase 4 — the reins (measured, not fixed)

Rein length (bit ring to glove), m:

| | L | R |
| --- | ---: | ---: |
| canter | 1.357 | 1.356 |
| clear u 0.20 / 0.55 / 0.85 / 1.00 | 1.494 / 1.535 / 1.534 / 1.601 | 1.493 / 1.534 / 1.535 / 1.600 |
| land 0.15 / 0.40 / 0.80 s | 1.603 / 1.559 / 1.631 | 1.602 / 1.558 / 1.631 |
| refusal 0.00 / 0.10 / 0.25 / 0.50 / 0.90 s | 1.564 / 1.425 / 1.320 / 1.358 / 1.400 | 1.563 / 1.424 / 1.317 / 1.350 / 1.389 |

Never slack by a hand: worst −0.039 (refusal, 0.25 s). Fists within 0.02 m of their withers spot through the new land; knee 20–27°, shin −13 to −17.

**Through the neck: yes, and at the plain canter too.** Each rod's closest approach to the Neck1→Head centreline is 0.009–0.056 m in every state; the neck mesh's half-width is 0.28 at the withers, 0.13–0.19 mid-neck, 0.10–0.15 at the throat. A straight rod from the bit ring to a fist over the withers cannot clear a neck that arches above that line. Fixing it needs a bend over the crest (a second rod a side) or her hands lifted off the withers; the brief rules out both ("same rods", fists on the crest). Left, measured.

## Phase 5 — the board, once

Clocks after the last keep: **hk_les_001 18.53, hk_adv_001 91.59, hk_adv_003 94.00.**

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

Against the floor board: worst |Δ| 0.02 s (`hk_beg_035`). No new rail. C's rail `FENCE knock 3 by horse … jumping=true`. `--playtest` PASS: clear 0 / refuse 4 / rail 4.

The board's Python wrapper was stopped mid-run by Claude Code for low system memory (at `hk_int_009`); its Godot kept riding and wrote `RIDECERT done` itself. No second board was started. `dist/ridecert_board.json` was copied from `ridecert_results.json` by hand, the step the wrapper would have done.

Also measured, not changed: the Gallop clip's hoof IK targets sit up to 0.16 m from the tips of its baked cannons at the canter — the clip's own IK does not reach — and the bascule's cannon bends add to that in the air.

---

**25 Sep, last. The chip and the check. A rail no longer crests like a clear; a refusal is a check, not a jump. The clock did not notice. The clear is the bascule kept below, unchanged. No export.**

Files this phase: `bascule.gd` (chip branch on `horse.will_rail`; check bends on `horse.check_w`), `horse.gd` refusal pose only (`_do_refuse`'s one-frame `visual.rotation.x = 0.12` replaced by an eased check in `_animate`; `check_w`). `rider_mesh.gd` not changed — measured, it already does what was asked (below). `_process_jump`, land_d, the knock window, `land_recover` 2.72, leave windows, TAKEOFF, GAIT_SPEED untouched. No AnimationPlayer, no global_position, no skeleton rebuild, Madison on Torso.

## Four results — headless, probes stripped, one Godot at a time

| ride | result | against |
| --- | --- | --- |
| `--ridecert-id=hk_les_001` | clear, 0 faults, 3/3, **18.53**, teleported=false | 18.53 |
| `--ridecert-id=hk_adv_001` | 2 faults, 0 rails, 12/12, **91.59**, teleported=false | 91.60 |
| `--ridecert-id=hk_adv_003` | 3 faults, 0 rails, 12/12, **93.99**, teleported=false | 94.00 |
| `--ridecert-style --ridecert-id=hk_beg_035` | B refused [1], 4 faults, 0 rails, 69.89 · C 1 rail on fence 3, `FENCE knock 3 … jumping=true` (in the air), 67.17 | 69.88 / 67.15 |

A (the plain `hk_beg_035` round, which the style run does not ride): clear, 0 faults, 8/8, 67.28 (board 67.27). `--playtest` PASS: clear 0 / refuse 4 / rail 4, knock on fence 3 in the air.

## Samples — probe on the style run of `hk_beg_035`, then stripped

Degrees against rest, tip up +. Round = Torso − Torso3. Root on the parabola (err 0.0000) on every jump sample.

| u | case | round | Neck1 | FrontLowerLeg.L | BackLowerLeg.L | her world lean | fists (withers) |
| --- | --- | ---: | ---: | ---: | ---: | ---: | --- |
| 0.20 | clear | 0.0 | −5.2 up | −1.7 | +74.1 | +37.0 | (±0.05, −0.331, 0.539) |
| 0.20 | chip | 0.0 no round yet | −5.2 | −1.7 | +74.1 | +33.1 | (±0.05, −0.298, 0.523) |
| 0.55 | clear | **+15.0** crest | −21.4 out, down | −30.2 folded | −13.3 | +9.9 | (±0.05, −0.332, 0.537) |
| 0.55 | chip | **0.0** — flatter by **15.0°** | +11.5 a little up | +3.7 hanging | −5.3 | +20.7 | (±0.05, −0.299, 0.522) |
| 0.85 | clear | +0.6 opening | −51.1 out | +41.5 down | +49.3 | +44.1 | (±0.05, −0.329, 0.545) |
| 0.85 | chip | 0.0 spine quiet, pole already down | −40.2 | +49.6 | +51.2 | +47.2 | (±0.05, −0.300, 0.537) |

Refusal at fence 1 (style B), t after `_do_refuse`. Clip is **Idle on every sample — no Gallop_Jump, no crest**. vx is `visual.rotation.x`, positive = forehand up.

| t s | vx | check | Neck1 | BackLowerLeg.L | her world lean | fists (withers) |
| --- | ---: | ---: | ---: | ---: | ---: | --- |
| 0.03 | −0.140 | 0.09 | −24.6 | −1.6 | +43.8 | (±0.05, −0.368, 0.515) |
| 0.10 | +0.052 | 0.72 | −4.3 | +3.4 | +28.1 | (±0.05, −0.359, 0.550) |
| 0.25 | +0.140 forehand up | 1.00 | +11.7 | +17.8 under | +10.0 | (±0.05, −0.406, 0.569) |
| 0.50 | +0.134 | 0.98 | +11.7 | +17.5 | +1.9 sat up | (±0.05, −0.428, 0.594) |
| 0.90 | −0.041 | 0.35 | +4.2 | +6.2 | +14.8 | (±0.05, −0.426, 0.590) |

Canter reference before it: fists (±0.05, −0.400, 0.523). On the refusal her fists never come further forward than 0.36 m behind the withers; the release in the air sits at 0.30. They stay with the neck and do not go forward into a release. The old code snapped vx to 0.12 in one frame; now it eases from where he was (−0.14 here) to +0.14 in a quarter second.

---

**25 Sep late. The bascule is in and the clock did not notice. Board 21/23 (one full `--ridecert`, below), worst move 0.05 s, no new rail, teleported=false, style A/B/C honest, `--playtest` PASS. No export.**

Files: `game/scripts/bascule.gd` (new, a `SkeletonModifier3D` on the horse skeleton), `horse.gd` (`_bind_rig` adds it; `_animate` jump branch, clip held to the root, landing bob, `_air_sounds`/`_fore_low`; `_update_rider` jump fold), `rider_mesh.gd` (hands anchored to the withers in the air). `_process_jump`, `_begin_jump`, `_begin_schooling_jump`, `_try_leave`, `_process_ride`, `_update_last_stride`, leave windows, TAKEOFF, `collect_pulse`, `GAIT_SPEED`, turn rate, `land_recover = 2.72` byte-identical. No second AnimationPlayer, no skeleton rebuild, no global_position on rider or hip, Madison still on Torso. `ride_ai.gd`, course JSON, `ride_cert.gd`, `game_state.gd` untouched.

## What the clip was

Gallop_Jump sampled headless at 0 / .25 / .5 / .75 / 1 against rest: Back, Torso, Torso2, Torso3 carry **identical** pitch at every sample (+10.4, +1.5, −22.6 …). The clip turns the spine as one plank. It also runs a quarter of a jump ahead of the root: its fore feet leave at f 0.20 and are down at f 0.80, the root leaves at u 0.42, crests at 0.69, lands at 1.0. Played 1:1 he folded on the ground and landed in the air.

## What changed, by phase — each kept on three rides within 0.05 s

| phase | change | les_001 | adv_001 | adv_003 |
| --- | --- | ---: | ---: | ---: |
| Step 0 | — | 18.56 / 18.53 (noise, same tree) | 91.59 | 93.99 |
| 1 horse | spine bend on top of the clip; clip held to the root (rate + seek, the trot's pattern); whole-body tilt cut | 18.52 | 91.63 | 94.01 |
| 2 girl | one fold keyed on u, landing on the land_recover pose; fists anchored to the withers after the bend | 18.54 | 91.61 | 94.01 |
| 3 land | canter bob fades in over 0.25 s instead of jumping up to 9 cm | 18.55 | 91.60 | 94.01 |
| 4 sound | grunt when the last fore hoof leaves (u 0.345); thud when the fore hoof stops falling; rail untouched (knock window) | 18.55 | 91.59 | 94.00 |
| fix | tilt sign (negative is forehand **down** — it sank the planted fore feet 7 cm); land trigger compared the hoof with itself | **18.53** | **91.60** | **94.00** |

Faults 0 / 2 / 3, rails 0, teleported=false, complete on every ride.

## The four samples — final code, headless `hk_les_001`, first fence

Degrees of each bone's axis against rest in skeleton space (tip up +). Round = Torso − Torso3. Fists in the withers (Torso3) frame, m. Root error against the parabola `_process_jump` writes.

| u | Back | round | Neck1 | FrontLowerLeg.L | BackLowerLeg.L | her hip | fists (withers) | root err |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | --- | ---: |
| canter | −0.1 | −1.6 | −1.2 | +4.3 | +4.7 | −29.6 | (±0.05, −0.395, 0.535) | — |
| 0.20 | +1.6 | 0.0 long | −5.2 up | −1.7 reaching | +74.1 driving | −40.1 two-point | (±0.05, −0.305, 0.527) | 0.0000 |
| 0.55 | +15.1 | **+15.0** crest | −21.4 out, down | −30.2 folded | −13.3 trailing | −37.5 with the back | (±0.05, −0.308, 0.523) | 0.0000 |
| 0.85 | −24.9 | +0.6 opening | −51.1 out | +41.5 down | +49.3 under | −27.9 seat returning | (±0.05, −0.307, 0.548) | 0.0000 |
| 1.00 | −8.7 | 0.0 | −34.0 | +28.3 | +35.6 | −18.3 sitting | (±0.05, −0.382, 0.576) | land |

Fists: IK miss 0.000 at u 0.55 (shoulder→target 0.314 against 0.342 reach), both sides; within 0.10 m of the early canter spot (the target is the last canter frame, which is the two-point). Knee 20–27°, shin −13 to −15 through the arc. Across touchdown every frame step is canter-sized (vx 0.005 vs 0.009, Back 2.3° vs 2.1°, hip 0.84° vs 0.62°); none falls on the touchdown frame. Grunt at u 0.345 (fore hoof 0.09 m, planted 0.04). Thud a few frames after the root lands, when the fore hoof bottoms at ~0.20 m (the land pose sits the forehand up; a planted hoof reads ~0.21 there, 0.11 at the canter).

## Board — one full `--ridecert`, `board_table.py`

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

Against the kept 21/23: worst |Δ| 0.05 s (`hk_adv_002` 83.19 → 83.14); every other row ≤ 0.03. No new rail. Style C's rail is `FENCE knock 3 by horse … jumping=true` in the log — in the air. `--playtest` PASS: clear 0 / refuse 4 / rail 4, knock on fence 3 in the air.

One incident: a probe edit left `bascule.gd` unparseable, `game_state.gd` failed to compile behind it and a probe ride hung. It was my own run (started 22:54:02, PIDs 31328/163280); those two PIDs were stopped, nothing else. Every ride after that ran under a `timeout`.

---

**25 Sep. True negative. `ride_ai.gd` byte-identical to the file I started from (sha256 `4fde6972…a4d5b8`). Board still 21/23. No full `--ridecert`, no playtest, no export — the gate to them was never met. Exe still 2.348.0.0.**

Headless only, one Godot at a time, every ride through `run_ridecert.py --ridecert-id=…`. No window, no `ride_ids.py`, `dist/Abbott.exe` not launched. horse.gd, ride_cert.gd, both course trees and `dist/ridecert_board.json` hash-identical to the start of the night. `dist/ridecert_godot.log` put back to the board log; `dist/ridecert_results.json` is the last 1/1. Every log below is in `dist/night_0925/`.

## Step 0 — reproduced

| id | faults | rails | jumped | time | teleported | come-again |
| --- | ---: | ---: | --- | ---: | --- | --- |
| hk_adv_001 | 2 | 0 | 12/12 | 91.59 | false | #7, #9 |
| hk_adv_003 | 3 | 0 | 12/12 | 93.99 | false | #6, #10 |

Segments match the brief (001 7:12.40 9:12.81; 003 6:11.78 10:12.58).

## What I rode — one hypothesis each, both ids, then discarded

| # | change to `_cc` | 001 | 003 | verdict |
| --- | --- | --- | --- | --- |
| H1 | hold the sit through `again` too (circle stays collected, 3.2 m) | 91.33, 0 rails | **105.49**, 0 rails (into #11 7.5 → 18.8) | discard |
| H2 | `again` rides 4 m beside the line, on the side he is on, not across it (teardrop) | **90.37**, 0 rails (#7 12.4 → 12.0) | **99.14**, 0 rails (into #6 11.8 → 17.4) | discard |
| H3 | H2 at 5 m, sat (the teardrop only fits collected) | 95.13, 0 rails | 108.45, 0 rails (into #11 → 18.0) | discard |

No rail in any of the six rounds; all finished, teleported=false. Each was reverted before the next.

What the logs said, in order:

- In the baseline, 001 #7 and 003 #10 are not slow in the circle. `again` is ridden at `rein=0` and he winds up to 5.52–5.55 m/s straight away from the fence, crossing the line diagonally, and exits 115–128° off. The turn home carries him 3–4 m past the line (`setup lat=3.96`, `3.88`) and he sets up a second time.
- H1 sat him — still exits `lat=0.02 ang=117.7`, still overshoots to x=10.8. Speed was not the fault; the leg crosses the line.
- H2 fixed that where the turn fits (001 #7 came out `lat=0.62` then `0.08`). At 003 #6 he ran `again` at 5.02, a 5.2 m circle does not turn inside 4 m, and the wide turn met fence 4's standards: shy, then a detour to along 21.
- H3 made the circle fit, and the planner that takes over at the exit then took a detour (`around`, along 16–20) anyway. Every change to a circle moves the next arrival; 003 #11, which has no come-again, went 7.5 → 18.8 s twice.

## Why it does not clear from the rider — the ceiling, measured

Sit samples are ~1 s. A clean run on the line from along 12 to takeoff is three `approach` samples in every segment. So what the rider can possibly give back after a circle is `after-exit − 3`:

| come-again | segment | circle | after exit | slack |
| --- | ---: | ---: | ---: | ---: |
| 001 #7 | 12.40 | 3 | 6 | ~3 s |
| 001 #9 | 12.81 | 4 | 6 | ~3 s |
| 003 #6 | 11.78 | 4 | 4 | ~1 s |
| 003 #10 | 12.58 | 3 | 6 | ~3 s |

With **zero** waste after every circle: 001 gains ≤ ~6 s against 7.6 needed, 003 ≤ ~4 s against 10.1. The circle itself is the part that must stay. The rest of 003's clock is #4 (10.1) and #5 (10.4): no come-again, he lands 14.8–16.7 m off the next line and crosses the ring — that is where the fences are, not how he rides.

## Why the next idea is a closed door

- Shorter than the circle: exiting while still across the fence, or not firing it — the rail the brief names.
- Less slack after the circle: needs a planner that shapes the exit into the approach — turn-fit scoring / arc-aware path checks / pure pursuit (all closed), or a second controller (not allowed). And it caps out under the need anyway.
- Faster between fences: sitting less on a related, dropping the sit on the turn onto the line, or speed in horse.gd — all revert conditions.
- Arriving so he does not need it: #7 and #10 are landings beside the next fence's plane (001 #7 lands along 3.3, 12.9 m off). That is fence placement — frozen, and its single / pair / triple / sweep movers are closed.

Nothing to export. 21/23 is still the game.

---

**24 Sep afternoon. Fresh horse finished 23/23. Style pair on every course. Pin still 21/23. Exe still 2.348.0.0. Not packed.**

Day-one horse is confidence 48, scope 40, rideability 44, timing 38, feel 36. Those numbers were set at the start of each fresh round and were not written into the pin (85/80/44/38/36). No hang, no timeout, no teleport. Nothing in `ride_ai.gd` was edited. The log line `conf=54 scope=44.5` is after a clear schools the horse; the round itself started at 48/40.

Fresh table, from `dist/ridecert_fresh.json` via `cert_tables.py`:

| id | faults | rails | refusals | jumped | time | teleported | finished |
| --- | ---: | ---: | --- | --- | ---: | --- | --- |
| hk_les_001 | 0 | 0 | — | 3/3 | 18.54 | False | yes |
| hk_les_002 | 0 | 0 | — | 3/3 | 16.53 | False | yes |
| hk_les_003 | 0 | 0 | — | 3/3 | 18.21 | False | yes |
| hk_les_004 | 0 | 0 | — | 3/3 | 17.95 | False | yes |
| hk_beg_035 | 0 | 0 | — | 8/8 | 67.28 | False | yes |
| hk_beg_039 | 0 | 0 | — | 8/8 | 70.73 | False | yes |
| hk_beg_004 | 0 | 0 | — | 8/8 | 70.32 | False | yes |
| hk_beg_034 | 0 | 0 | — | 8/8 | 63.43 | False | yes |
| hk_beg_007 | 0 | 0 | — | 8/8 | 65.54 | False | yes |
| hk_beg_033 | 0 | 0 | — | 8/8 | 59.87 | False | yes |
| hk_int_001 | 0 | 0 | — | 10/10 | 90.85 | False | yes |
| hk_int_002 | 0 | 0 | — | 10/10 | 80.3 | False | yes |
| hk_int_005 | 0 | 0 | — | 10/10 | 92.29 | False | yes |
| hk_int_006 | 0 | 0 | — | 10/10 | 79.02 | False | yes |
| hk_int_007 | 0 | 0 | — | 10/10 | 84.93 | False | yes |
| hk_int_009 | 0 | 0 | — | 10/10 | 85.0 | False | yes |
| hk_adv_001 | 2 | 0 | — | 12/12 | 91.6 | False | yes |
| hk_adv_002 | 0 | 0 | — | 12/12 | 83.14 | False | yes |
| hk_adv_003 | 3 | 0 | — | 12/12 | 94.01 | False | yes |
| hk_adv_005 | 0 | 0 | — | 12/12 | 78.91 | False | yes |
| hk_jo_beg_001 | 0 | 0 | — | 4/4 | 35.3 | False | yes |
| hk_jo_int_001 | 0 | 0 | — | 4/4 | 36.51 | False | yes |
| hk_jo_adv_001 | 0 | 0 | — | 4/4 | 35.82 | False | yes |

Style table, B = `refuse_early` on fence 1, C = `rail_late` on fence 3. From `dist/ridecert_style.json` and `dist/ridecert_style.log`. Twenty rows kept. Three are the horse, not a missing release. The window was not moved.

| id | B faults | B refused | B knocked | C faults | C rails | C fence | C air | C finished | keep |
| --- | ---: | --- | --- | ---: | ---: | --- | --- | --- | --- |
| hk_les_001 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_les_002 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_les_003 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_les_004 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_beg_035 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_beg_039 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_beg_004 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_beg_034 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_beg_007 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_beg_033 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_int_001 | 4 | 1 | — | 4 | 1 | 3 | no | yes | no |
| hk_int_002 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_int_005 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_int_006 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_int_007 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_int_009 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_adv_001 | 11 | 1 | 6,9 | 6 | 1 | 3 | yes | yes | yes |
| hk_adv_002 | 5 | 1 | — | 5 | 1 | 3 | yes | yes | yes |
| hk_adv_003 | 11 | 1 | — | 10 | 1 | 3 | yes | yes | yes |
| hk_adv_005 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_jo_beg_001 | 4 | 1 | — | 4 | 1 | 3 | yes | yes | yes |
| hk_jo_int_001 | 11 | 1 | 1 | 5 | 1 | 3 | yes | yes | no |
| hk_jo_adv_001 | 19 | 1 | 1,2 | 4 | 1 | 3 | yes | yes | no |

Left as the horse, from `dist/ridecert_style.log`:

- `hk_int_001` C: `FENCE knock 3 by horse at 8.3,-7.8 next=3 jumping=false` then `RIDEAI ASK n=3 ahead=1.39 lat=0.08 ang=1.6 charge=1.0`. The late ask happened. The pole was already down, on the ground.
- `hk_jo_int_001` B: `FENCE knock 1 by horse at -7.5,-20.2 next=1 jumping=false` then `RIDEAI ASK n=1 ahead=3.92 lat=0.04 ang=7.5 charge=0.32` and `RIDECERT refuse fence=1 why=early`. Early release fired. He had already hit the rail on the way in.
- `hk_jo_adv_001` B: `FENCE knock 1 by horse at -9.1,-18.0 next=1 jumping=false` then `RIDEAI ASK n=1 ahead=3.96 lat=0.12 ang=8.0 charge=0.32` and `RIDECERT refuse fence=1 why=early`. Same pattern. Fence 2 was a separate ground knock.

Pinned `--ridecert` after both jobs, twice. Both **21/23**. Worst time against the pre-afternoon board **0.06 s**. The two runs differ by at most **0.08 s**. No new rails. teleported=false. `hk_beg_035` A clear (67.28 and 67.29, 0 faults), B refuse fence 1 (69.87 and 69.88, 4 faults, 0 rails), C one rail (67.16 and 67.18, 4 faults, 1 rail).

`dist/Abbott.exe` stays **2.348.0.0**. Size 1738940632. Date created 2026-09-12 08:34:04. LastWrite 2026-09-24 11:44:00.

---

**24 Sep 2026. Packed once. `dist/Abbott.exe` 2.348.0.0.** Size 1738940632 bytes. Date created 2026-09-12 08:34:04. LastWrite 2026-09-24 11:44:00. Title and HUD: `THU SEP 24  ·  2.348.0.0`. Sand albedo `c2150e28cdfc0838` 388622 and wood albedo `691a1db7520c0a95` 305094 unchanged. Not launched.

**The mesh rider is live. Pass 7.**

Quaternius Casual (`game/assets/meshes/madison_casual.glb`, CC0) is on the existing seat pivots. Hips stay on the seat through halt, the posting rise, and two-point. Knees land on the roll, heels on the iron, both wrists on the withers. No second AnimationPlayer. The clip player is removed from her tree. The hip park is local, not a world-position write. No picture: a Godot window locks the desktop, so this was headless only.

Passes kept: import, seat, hunt clothes (navy coat, beige breeches, tall black boots, velvet cap, casual sneakers hidden), gloves and reins and crop, gait, walk mode on this same mesh, Michelle on the rail from this mesh (olive vest, tall boots, clipboard, no new sentences). Playtest PASS, clear 0 / refuse 4 / rail 4, knock on fence 3. `hk_les_001` clear, 3/3, 18.54 s, teleported=false. Stride words still Two. Wait. / One. Wait. / One. Early. / Early. / Wait. / Now.

Two full `--ridecert` runs after the root-motion fix. Both **21/23**. Worst time against the pre-mesh board **0.02 s**. Run A vs run B **0.02 s**. No new rails. teleported=false on every track. `hk_beg_035` style A clear, B refuse on fence 1, C one rail. The first full run, before that fix, ran ~0.2 s fast; that was the skeleton rebuild and the world-position park. It was not kept. `ride_ai.gd` was not opened.

Trot: the Walk clip (1.167 s) is seeked one cycle per stride so the two diagonal contacts land on the posting beats. `GAIT_SPEED`, turn rate, and the leave were not changed. Playtest still PASS. `hk_les_001` still 18.54 s, so the clip is not moving the body.

Packed once after that note, as the line at the top. Do not launch `dist/Abbott.exe`.

---

**24 Sep 2026. `hk_adv_001` #7 is an honest come-again. The circle was not edited. `hk_adv_003` was not touched.**
The 21/23 board is the game until someone is willing to move a fence past the leash.

Classification **B**. One instrumented ride of `hk_adv_001` (the round that reads 91.61 s, same faults, 0 rails, 12/12) logged the entry the board line did not carry. Then the print was taken back out. `ride_ai.gd` `_cc` is the code that shipped in 2.346. No second edit. Job 2 skipped.

Fence 7, from `dist/hk_adv_001_cc7.log`, between fence 6 at 38.53 s and fence 8 at the ask:

```
RIDEAI fence 6 -> 7 t=38.53 leave=leave
RIDEAI sit n=7 phase=land pos=-5.9,26.8 ahead=12.97 lat=12.88 ang=62.7 along=3.3 gait=3 v=3.09 rein=1
RIDEAI sit n=7 phase=land pos=-2.9,26.6 ahead=7.02 lat=9.94 ang=118.9 along=3.5 gait=3 v=3.09 rein=0
RIDEAI come again n=7 rein=1 pos=-1.9,26.0 along=4.1 on_line=8.91 ang=118.9 why=crooked
RIDEAI come again exit away n=7 age=0.45 herr=0.54 cap=false along=4.6 on_line=8.28 ang=149.2
RIDEAI sit n=7 phase=again pos=-1.1,25.2 ahead=1.88 lat=8.1 ang=137.5 along=4.9 gait=3 v=1.76 rein=-1
RIDEAI sit n=7 phase=again pos=1.0,23.3 ahead=-0.24 lat=6.0 ang=132.9 along=6.8 gait=3 v=3.88 rein=0
RIDEAI sit n=7 phase=again pos=4.6,20.1 ahead=-4.38 lat=2.42 ang=128.8 along=10.0 gait=3 v=5.55 rein=0
RIDEAI come again exit again n=7 along=12.0 on_line=0.43 ang=114.8 age=3.28 cap=false herr=2.0
RIDEAI ASK n=7 ahead=2.55 lat=0.22 ang=1.3 charge=1.0
```

He entered crooked: along 4.1 (inside 4.4), angle 118.9° (past 26°), 8.91 m off the line. Not a straight shot. Away ended on heading at 0.45 s, not the 5 s cap. Again ended because along reached 12.0 with on_line 0.43, age 3.28 s, cap false. At that exit he was still 114.8° off the fence (herr 2.0). The 11 s cap did not let him go. Driving on from the entry would have been a shoulder through the plane. The 12.4 s is the price of not knocking.

Board underneath is still the 21/23 pair from 23 Sep (`board_table.py`, times within 0.02 s, teleported false, style A/B/C honest). Full board was not re-run: the circle was reverted, not kept.

## What a person got — Job 3

`--playtest` PASS (clear 0 / refuse 4 / rail 4). Knock still fires. `hk_les_001` still clear, 3/3, 18.54 s, and the stride words are still Two. Wait. / One. Early. / Now. then one sentence. `prove_ship.py` PASS. Leave windows, `collect_pulse`, and the courses were not touched.

- Walk. C steps her off beside him on this course. She is a body, camera behind her, hidden until then so the ring does not hold two of her. Enter still mounts. The clock still starts at the flags. Fence numbers were already on the standards. There is no related-distance label on the ground, so none was added.
- Pause. The clock already stopped under the menu. Esc did not come back, and he kept coasting. Esc again resumes now, and the pause freezes the horse and the stride (`Engine.time_scale` 0) so the same stride is still there.
- Result. A clear inside the time still says clear, and the jump-off is still only then. Over the time the card says the time faults, not clear. A rail or a refusal names the fence. Show elimination still says three refusals, off course, or the time limit. Schooling still does not eliminate. Allowed time is still 80.
- Sound. Hoof hits, the snort, and walk-on / trot / canter / whoa are on disk and already bound. Left alone.

## Exe

`dist/Abbott.exe` **2.347.0.0**. One export. Size 1738411000 bytes. Date created 2026-09-12 08:34:04 (the export did not reset it). LastWrite 2026-09-24 07:49:23. Title and HUD read `THU SEP 24  ·  2.347.0.0`. Sand and wood albedo hashes unchanged.

---

Previous night, kept here so the triple is not tried again:

**23 Sep 2026. Packed `dist/Abbott.exe` 2.346.0.0. Board is still 21/23.**
Not a 23/23. The two Mini Prix that fail still fail on time only, 0 rails.

Both full `--ridecert` runs after the lesson words, `teleported=false`.
Same clears, same faults, same rails. Times differ by at most 0.02 s, which
`board_table.py` rounds to one table. Nothing that was clear picked up a rail
or moved by more than 0.1 s. Leave math was not touched.

`board_table.py` on both runs:

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

Raw times that the one-decimal table hides, run A → run B: `hk_adv_001`
91.61 → 91.59, `hk_adv_003` 93.99 → 94.00, `hk_adv_005` 78.92 → 78.91.
`hk_adv_002` is 83.14 on both, 0.02 s over the previous 83.12, still clear,
0 rails. Both runs are in `ridecert_board_runA.json` and
`ridecert_board_runB.json`.

## Exe that night — superseded by 2.347 above

`dist/Abbott.exe` was 2.346.0.0. Size 1738408472 bytes. Date created
2026-09-12 08:34:04. LastWrite 2026-09-24 01:29:50. Title and HUD read
`WED SEP 23  ·  2.346.0.0`.

The come-again at #7 was read the next morning and classified honest. See the top of this file.

---

The sections below are the earlier pass, then Job 1 and Job 2 from this night.
`--playtest` on that earlier pass was also PASS. `--ridecert` is real:
`Input.action_press` only, no `present(`, one `global_position = course.start_pos`
per round. **No rail anywhere on the board** — the only knock in a board run is
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

## Job 1 — rigid triple, 23 Sep 2026

`place_fence.search_triple` moves all three ends of a labeled chain as one
rigid body (rotation about the centroid, then one translation). Both distances
and both relative yaws are preserved. Same grid as `search_pair`: ±7 m at
0.5 m, ±35° at 5°. Same hard constraints. Nothing relaxed. Scored by a
headless `--ridecert-id` ride. `ride_ids.py` was not used.

Baseline reproduced before any write: `hk_adv_001` 91.61 s, faults 2, rails 0,
12/12, teleported false, come-agains at #7 and #9. Wall 98 s.

Chains already in the JSON:

- `hk_adv_001`: 3–4–5 and 9–10–11. #7 is in neither. Not invented.
- `hk_adv_003`: 1–2–3 only. #6 and #10 are in no chain. The 11–12 pair was
  not ridden again.

| chain | legal on the grid | ride | result |
| --- | --- | --- | --- |
| 001 9–10–11 | 1 (12615 tried, 8792 leash, 3820 end, 2 run-in) | #9 (−1.71, 12.08) #10 (−6.72, −1.71) #11 (−9.33, −8.68), gaps 14.665/7.451, run in +8.1 | **discard** 117.32 s, faults 13, rails 1, come-agains at 7, 9, 11. Put back byte-identical. |
| 001 3–4–5 | 0 (8029 leash, 3423 end, 775 run-in, 247 out-run, 141 out-clear) | not ridden | no legal body. Leash not loosened. |
| 001 #7 | not in a chain of three | not ridden | left |
| 003 #10, #6 | not in a chain of three | not ridden | left. 1–2–3 does not contain them, so it was not ridden. |

No keep. The other 21 were not re-ridden because no fence stayed moved.
`hk_adv_001.json` both trees byte-identical to the snapshot. Leave math not touched.

## Job 2 — the lesson says the window

Leave math not touched. `collect_pulse` still 0.95. Takeoff still 2.55.
`_try_leave` bands unchanged. No new Michelle keys.

`hk_les_001` headless, same keys as the cert, after the words:

- Two. Wait. / One. Wait. / One. Early. / Early. / Wait. / Now.
- Then one sentence: spot ("You found it. Don't chase the next." and the other short spot lines).
- Clear 0 faults, 3/3, 18.53 s, teleported false. Same clock as the board.

Fences 2 and 3 are a related line, so she never has two strides of straight approach. She hears "One." there, not "Two." That is the distance, not a missing call.

Early refusal, late rail, and chip already speak the ship lines (one sentence, true). Not rewritten. Takeoff marks were already on the sand at 2.55 in the lesson and absent in schooling and show. Left there. No charge bar.

Camera: last-stride FOV target 32.4 → 46. Look blend capped at 0.88 and aimed at the face of the fence (y 0.85), not past it into the dirt. Not a new camera.

Playtest after the keep: PASS clear 0 / refuse 4 / rail 4. Knock fired on fence 3.
