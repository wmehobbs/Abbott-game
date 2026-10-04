# Abbott (Madison folder) Jev recommendations

**Scan date:** 2026-09-26 (America/New_York)  
**Tree:** `E:\Workspace\Madison` on GenstrataPC (read-only)  
**Product:** Abbott v2.348.0.0, Godot 4.7 + Jolt, GDScript  
**Status:** Code reading only. No latency measured against TypeSafe on this tree. No game files edited.

Ernie already knows System One: LLM proposes, Jev decides, code executes. Site test: replace parsing generative prose into a typed decision you already needed. Not for search, writing prose, math, string facts, spatial pathfinding. Confidence = escalate signal, not certificate. Fail-closed. Prefer cloud TypeSafe for high-stakes until A/B.

StarCraft demo pattern applies: **code builds legal menus; Jev Choice among them; code executes.** No spatial magic.

---

## 1. Game summary

Abbott is a short, crafted jumping school. Madison rides Abbott in one outdoor ring at Hidden K. The skill is seeing a distance and leaving the ground with him. Lesson, schooling, and Table A show day. Abbott's confidence / scope / rideability and Madison's timing / feel drift slowly from how rounds went. Michelle on the rail says one true sentence after a leave. No LLM, agent, or TypeSafe hook exists in `game/scripts/` today.

---

## 2. Inventory of current (and planned) judgments

### 2.1 Runtime judgments that already fire

| # | Judgment | Where | Mechanism today |
| --- | --- | --- | --- |
| A | Leave outcome (early / deep / chip / spot / looked / refuse / wrong) | `horse.gd` `_try_leave`, `_leave_word`, `_might_look`, `_wrong_fence` | Exact meters and angles vs `TAKEOFF` 2.55, `window_scale()`, `refuse_scale()` |
| B | Which Michelle sentence for a speak key | `trainer.gd` `phrase` → `content_library.gd` `phrase` | Filter candidates by key/session/class_id; **`randi() % hits`** |
| C | Soft praise key after clean leave | `horse.gd` `_try_leave` (lesson vs schooling/show random `leave`/`straight`) | Hardcoded + RNG |
| D | Barn note on title and result card | `game_state.gd` `barn_note` → ContentLibrary | Band filters on conf/ride/timing; **random among hits** |
| E | Flower look (stop at flower when soft) | `horse._might_look` | Formula + `randf()` |
| F | Post-round stat school | `game_state._school_from_round` | Fixed deltas from faults / refusals / rails |
| G | Class unlock | `class_unlocked` | Counters on rounds_posted / clears |
| H | Ribbon color | `_ribbon` | Fault buckets |
| I | Table A faults / elimination / time | `note_refuse`, `note_rail`, `eliminate`, `finish_round` | Rules tables |
| J | Difficulty feel from stats | `window_scale`, `refuse_scale`, `scope_bonus`, `turn_scale`, `balance_need` | Formulas |
| K | Next course id from SHIP | `content_library.ship_course` `_pick_id` | Seed modulo |
| L | RideAI phase / ask / come-again | `ride_ai.gd` | Geometry for `--ridecert` / harness only |

### 2.2 Content / offline judgments

| # | Place | Notes |
| --- | --- | --- |
| M | `score_courses.py` | Heuristic SHIP cull (cousin score, pattern mix). Dev tool, not play loop |
| N | `make_rail.py` / michelle piles | Offline generation of short lines. Writing stays offline |
| O | `LESSON_BEATS.json` | Planned lesson beat graph (success_key / fail_keys). Not wired to live `Trainer.phrase` path yet |
| P | Deferred design | Other horses/kids in aisle; Pony Club → college ladder. Spec: later |

### 2.3 Not present

NPC free dialog trees, quest givers, enemy tactics, content moderation, player intent classify from chat, companion mood sim, procedural event director, LLM narrative. Do not invent insert points for systems that do not exist.

---

## 3. Ranked Jev insert points

### Wire soon

#### Soon-1. Michelle phrase Choice (highest fit)

| | |
| --- | --- |
| **Where** | After `ContentLibrary._phrase_from` builds `hits[]`, before `randi()`; call site stays `GameState.speak(kind)` / `Trainer.phrase` |
| **Question** | **Choice** |
| **State shape** | Compact facts only, e.g. `{ "key": "early", "session": "schooling", "class_id": "intermediate", "leave": "early", "ahead_m": 3.9, "faults": 4, "refusals": 1, "abbott_confidence": 48, "abbott_rideability": 44, "madison_timing": 38, "fence_kind": "oxer", "fence_num": 5 }` plus **candidate texts already filtered by code** (ids + text, max ~16) |
| **Criteria** | Map each candidate id → short description of when that line fits (or null + rely on text). Instructions: pick the one true sentence Michelle would say now; prefer specificity over generic; never invent a new sentence |
| **What stays in code** | Filter by key/session/class; hard length cap; speak HUD timing; fail → hardcoded `Trainer` match arms or first hit |
| **Fail-closed** | If HTTP fail, timeout, empty answers, or Choice `confidence` below threshold: keep current `randi()` or first hit. **Never block the leave.** Never generate prose |
| **Latency / cost** | Fires **after leave / refuse / round events**, not per frame. Docs claim ~100ms class; **unmeasured here**. One call per speak; optional speculative batch of unused keys is waste. Cache last answer per (key + coarse band) if spam |
| **Why first** | Exact site test: you already have a closed menu of lines; random is a stand-in for judgment. StarCraft-shaped. Reversible behind feature flag |

#### Soon-2. Barn note Choice (same adapter)

| | |
| --- | --- |
| **Where** | `ContentLibrary.barn_note` after band filter builds `hits[]` |
| **Question** | **Choice** among matching note ids |
| **State** | `{ "session", "abbott_confidence", "abbott_rideability", "madison_timing", "madison_feel", "last_faults", "last_leave", "lesson_done", "candidates": [...] }` |
| **Criteria** | Option → when this note is the honest barn read |
| **Code keeps** | Numeric band filters (do not ask Jev to compare floats); title/result display |
| **Fail-closed** | Fall back to hardcoded `GameState.barn_note` ladder or random among hits |
| **Latency** | Title screen and result panel only. Cheap |

#### Optional soon harness (not required for first PR)

Thin `TypesafeJev` GDScript or small local HTTP helper + `--jev-harness` headless that feeds recorded speak states from playtest logs and prints Choice vs random. Measure p50/p95 before wiring live speak.

---

### Later

#### Later-1. Soft leave speak-key Choice

Today clean leaves randomly pick `leave` vs `straight` (and lesson forces spot/leave). **Choice** over `{spot, leave, straight, pat, steady}` with state from that fence (ideal flag, charge, lateral, session). Only after Soon-1 adapter exists. Still fail to current RNG.

#### Later-2. Schooling recommendation Choice (between rounds)

On title or after result: **Choice** over legal unlocked sessions/classes/course ids from SHIP (code builds menu from `class_unlocked` + SHIP). State = horse/rider stats + last round summary. Not auto-start; propose one highlight or default button. Escalates: low confidence → show all buttons unchanged.

#### Later-3. Lesson beat reaction (when LESSON_BEATS wires)

**Choice** which fail_key coaching line, or **Noul** "did she meet this beat's success?" only if beat success is ambiguous. Prefer keeping success = exact speak key from leave code. Do not replace pole/single/line geometry.

#### Later-4. Offline SHIP / rail cull assist (dev tooling)

`score_courses.py` is already heuristic math. Optional **Score** "rides like a Hidden K hunter track" for human review of borderline ids. Never in the play loop. Never sole gate for cert (ride wall time remains truth).

#### Later-5. Future aisle companions (only when that content exists)

When other kids/horses exist: **Score** mood / **Choice** short rail reaction from authored lines. Same menu pattern. Do not start this now.

---

### Never (for Abbott as it is)

| Area | Why |
| --- | --- |
| Leave windows / early-deep-chip math | Exact meters; code already owns truth |
| Table A faults, elimination, time faults | Rules tables |
| `_school_from_round` deltas | Arithmetic |
| Unlock / ribbon | Counters |
| `window_scale` / `refuse_scale` / `scope_bonus` / `turn_scale` | Formulas from floats |
| `ride_ai.gd` steer / ask / come-again / related-line geometry | Spatial; StarCraft anti-pattern |
| Physics, animation, bascule, camera, audio timing | Not decisions |
| Path of walker / farm layout | Geometry |
| Writing new Michelle sentences at runtime | Generation; jaggedness item 11 |
| Replacing michelle_ship with LLM chat | Breaks "one true sentence" craft |
| Per-frame Jev in `_physics_process` | Latency and cost wrong for 60 Hz ride |
| Pure RNG loot (N/A) / pixel combat frames (N/A) | Not in this game |

---

## 4. Top 5 inserts (brief for briefing)

1. **Michelle phrase Choice** among filtered candidates (wire soon)
2. **Barn note Choice** among band-matching notes (wire soon)
3. **Soft leave speak-key Choice** leave/straight/spot/pat (later)
4. **Schooling recommendation Choice** among unlocked SHIP options (later)
5. **Lesson beat coaching Choice** when beats wire (later)

Honorable offline: course cull Score for humans. Never: leave geometry, RideAI, fault math.

---

## 5. Adapter sketch (conceptual; Cursor builds)

```
GameState.speak(kind)
  -> candidates = ContentLibrary.filtered_hits(kind, session, class_id)
  -> if flag off or candidates.size() <= 1: pick as today
  -> else TypesafeJev.choice(state_facts, candidates, criteria)
       on ok + confidence >= T: use chosen text
       else: randi / hardcoded fallback
```

Env: `TYPESAFE_API_KEY` (never commit). Endpoint: `POST https://api.typesafe.ai/v1/systemone`. Model: `jev-latest`. Feature flag e.g. `GameState.jev_rail_enabled` or env `ABBOTT_JEV_RAIL=1`.

Godot note: HTTP is async. Speak must not stall physics. Pattern: show nothing extra, or keep previous line, or use sync only in harness / result card. Prefer **queue speak**: start request on leave; if answer arrives before `trainer_until`, swap text once; else keep fallback already shown.

---

## 6. Honesty on confidence and measurement

- Do not invent latency or dollar numbers. Measure on Ernie's key with a tiny harness.
- Confidence low → escalate to random/hardcoded, not "smarter LLM rewrite."
- A/B: log (state hash, candidates, choice, confidence, fallback?) to `user://` or dist traces; compare feel in lesson only first.
- Local OpenJev is CC BY-NC; Laya Apache for commercial on-prem experiments; prefer cloud TypeSafe until A/B for anything near ship.

---

## 7. Blocked / unread areas

| Area | Note |
| --- | --- |
| Full `content/rail/michelle.json` (~16MB) and `barn_notes.json` (~730KB) | Sampled schema + ship slice; not every line read |
| `content/courses/SCORES.jsonl` (~5.5MB) and 25k archive courses | Archive per README_NOW; SHIP 20 ids are live |
| `dist/Abbott.exe` binary / `.pck` | Not disassembled; STATUS says unverified re-pack |
| `.godot/imported` texture flood | Skipped (assets, not logic) |
| Live TypeSafe call from this scan | Not run (read-only + no key use required) |
| `abbott_book.html`, photo HEICs | Flavor / reference; not judgment logic |

---

## 8. Suggested first PR shape

1. Feature-flagged HTTP adapter (Choice only)
2. Wire Michelle phrase pick only
3. Headless harness: 20 canned states from known keys; print fallback rate + latency
4. Do not touch `horse._try_leave`, leave windows, RideAI, farm, course JSON, or export
5. Keep michelle_ship as the only candidate source for ship builds
