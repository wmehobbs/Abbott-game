# Cursor prompt: Abbott thin Jev rail (Michelle + barn note)

Paste into Cursor with workspace `E:\Workspace\Madison`. Ernie owns other lanes; stay off their files unless this task names them.

## Goal

Add a **thin TypeSafe System One (Jev) adapter** and wire **1 to 2 first harnesses** behind a feature flag:

1. Michelle phrase pick among already-filtered candidates (replace `randi()` in `ContentLibrary._phrase_from` / call path)
2. Optional second: barn note pick among band-filtered candidates (`ContentLibrary.barn_note`)

Do **not** rewrite the game. Do **not** change leave geometry, RideAI, farm trees, course JSON, or export.

## Product context (do not reopen)

Abbott: Madison rides Abbott at Hidden K. Lesson / schooling / show / walk. Michelle says one true sentence after a leave. Candidates already live in `game/content/rail/michelle_ship.json` (ship) with fallback pile and hardcoded `Trainer.phrase`.

Jev is a decision engine (Choice / Score / Noul), not a chatbot. Pattern: code builds legal menus, Jev Choice among them, code executes. Fail-closed. Confidence is escalate signal, not certificate.

## Absolute constraints

- Prefer **small diffs**. No engine rewrite. No new narrative system. No runtime LLM prose generation.
- **Read-only-safe for WIP:** do not edit `farm.gd` plant functions, `person_look.gd`, `abbott_look.gd`, leave windows in `horse.gd` (`TAKEOFF` 2.55, early/deep/chip bands), `ride_ai.gd`, course JSON under `content/courses` or `game/content/courses`, or pack `dist/Abbott.exe`.
- Do not invent latency, cost, or probability numbers. If you report numbers, they must come from a harness you ran, or say **unmeasured**.
- API key only via env **`TYPESAFE_API_KEY`**. Never commit keys. Never paste keys into logs, comments, or saves.
- Endpoint: `POST https://api.typesafe.ai/v1/systemone` with `Authorization: Bearer …`. Model alias: `jev-latest`.
- No em dashes in player-facing strings you add.

## Insert order

1. **Adapter** `game/scripts/typesafe_jev.gd` (or similar): HTTP POST helper; `choice(state, criteria_map, instructions) -> {ok, choice, confidence, probabilities, error}`; timeout; parse answers map. No Score/Noul required for v1.
2. **Feature flag:** e.g. env `ABBOTT_JEV_RAIL=1` and/or `GameState` bool default **off**. When off, behavior bit-identical to today.
3. **Harness 1:** Michelle. In `ContentLibrary.phrase` / `_phrase_from`: after `hits` built, if flag on and `hits.size() > 1`, call Choice with candidate id→text as criteria (or id→null and put texts in state). On failure / low confidence: existing `randi()` or first hit.
4. **Harness 2 (optional same PR if small):** same for `barn_note` hits.
5. **Measure:** headless or editor tool that fires N canned states; print p50/p95 latency if measurable, fallback rate, and chosen ids. Do not claim marketing latency.

## Fail-closed behavior

- Network error, timeout, non-200, missing answer, unknown choice id, or confidence below a constant threshold → **fallback to current random/hardcoded path**.
- Never block `_physics_process` or leave resolution waiting on HTTP. Prefer: show fallback line immediately; if async reply arrives before trainer line expires, optionally replace once. Result-card / title barn note may await briefly with timeout.
- Never ask Jev to write a new sentence. Never concatenate Choices to invent dialogue.
- Never ask Jev to decide early/deep/chip from meters. Those stay in `horse._try_leave`.

## State shape (example; keep small)

```json
{
  "key": "early",
  "session": "schooling",
  "class_id": "intermediate",
  "abbott_confidence": 48,
  "abbott_rideability": 44,
  "madison_timing": 38,
  "faults": 4,
  "refusals": 1,
  "last_leave": "early",
  "fence_kind": "oxer",
  "fence_num": 5
}
```

Pass **candidate list** as Choice criteria keys (stable ids from michelle_ship) with descriptions = the line text or a one-line "when to use". Instructions: pick the one true Michelle sentence for this leave; prefer specific over generic; options are exhaustive.

## What stays in code

- Filtering by speak `key`, session, class_id
- Band filters for barn notes (numeric ranges)
- Table A, unlocks, `_school_from_round`, window/refuse/scope formulas
- All spatial / RideAI / animation / audio

## Out of scope (do not start)

- Rewriting michelle_ship content
- Wiring LESSON_BEATS
- Schooling recommendation UI
- Local OpenJev / Laya packaging (cloud TypeSafe only for this pass)
- Per-frame calls
- Sprawl: no generic "AI director", no second HTTP stack, no SDK vendoring unless Godot genuinely needs a tiny client you write

## Done when

- Flag off: playtest / speak path unchanged
- Flag on: Michelle (and optional barn note) picks via Choice when candidates > 1
- Failures fall back silently
- Harness or log proves at least a few live calls OR clearly documents why calls were dry-run
- Diff touches adapter + content_library (and maybe game_state speak plumbing) only, plus a short note under `docs/` if Ernie wants it
- No keys in repo; README or docs note `TYPESAFE_API_KEY` and `ABBOTT_JEV_RAIL`

## Reference scan (box; do not copy into Madison unless asked)

`/workspace/madison-jev-scan-2026-09-26/JEV_RECOMMENDATIONS.md`
