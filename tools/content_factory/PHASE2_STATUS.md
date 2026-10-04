# Phase 2 status — factory in the live ride

timestamp: 2026-09-16

## Gates

| Gate | Result |
| --- | --- |
| validate_content.py | **0** (304 courses still green; SHIP.json excluded from course schema) |
| playtest clear / refuse / rail | **PASS** (`dist/playtest_results.json`) |
| materials 8+ | **GREEN** (11 binds) |
| Michelle wired | **yes** — `Trainer.phrase` → `ContentLibrary.phrase`, hardcoded fallback |
| SHIP ids | **GREEN** — 3 / 5 / 5 / 4 + 1 jump-off per class |
| artshots | **GREEN** — 6 rounds; last three kept |
| casual GLB on Abbott | **no** |
| `horse.gd` physics | **untouched** |

## Material binds (11)

See `MATERIAL_MAP.md`. Live:

1. sand → `harvest/proc/sand_worked_dry`
2. grass → `harvest/proc/grass_piedmont`
3. leather → `harvest/brown_leather`
4. white boards → `harvest/proc/board_white`
5. kick wall → `harvest/proc/kick_dark`
6. oak / fence wood → `harvest/oak_wood_planks`
7. hunt wool fallback → `harvest/proc/wool_navy_coat`
8. steel / irons → `harvest/metal_plate`
9. quilted pad → `harvest/acg_fabric018`
10. gravel drive → `harvest/proc/gravel_drive`
11. pine bark → `harvest/pine_bark`

Old textures remain as `ResourceLoader` fallback. `arena_half` / ring size unchanged. Abbott `coat_albedo` not remapped.

## Michelle

`game/scripts/trainer.gd` asks `ContentLibrary.phrase(kind, session, class_id)` first.  
JSON at `game/content/rail/michelle.json` (`res://content/...`) so the export has it. Speak timing unchanged.

## SHIP courses

`content/courses/SHIP.json` and a copy under `game/content/courses/` (packed in the exe). Hardcoded `_specs_for` is still the fallback if JSON misses.

- lesson: `hk_les_001`, `hk_les_002`, `hk_les_003`
- beginner: `hk_beg_035`, `hk_beg_046`, `hk_beg_044`, `hk_beg_034`, `hk_beg_057`
- intermediate: `hk_int_001`, `hk_int_002`, `hk_int_005`, `hk_int_006`, `hk_int_007`
- advanced: `hk_adv_001`, `hk_adv_002`, `hk_adv_003`, `hk_adv_005`
- jump-off: `hk_jo_beg_001`, `hk_jo_int_001`, `hk_jo_adv_001`

Scorer: `tools/content_factory/score_courses.py`. Notes: `SHIP_REPORT.md`.  
HUD `next_fence_line` uses `ContentLibrary.fence_name` (e.g. brush oxer).

Playtest ran the SHIP beginner track (8 fences): clear 0, refuse 4, rail 4.

## Artshots (6 rounds)

Directory: `tools/content_factory/artshots/`

| Round | File | Change |
| --- | --- | --- |
| 1 | `r01_halt_side.png` | first harvest saddle; she floated |
| 2 | `r02_seat_side.png` | sat down −0.155 m |
| 3 | `r03_seat_side.png` | forward toward withers |
| 4 | `r04_seat_side.png` | larger tree (girth overscaled — reverted) |
| 5 | `r05_seat_side.png` | thin girth |
| 6 | `r06_seat_side.png` | shorter stirrup leathers (kept) |

Last three: `r04_seat_side.png`, `r05_seat_side.png`, `r06_seat_side.png`. Also live `artshot_seat_side.png`.  
`Body` / `Head` / `LLeg` / `RLeg` names unchanged. No Quaternius/Kenney mesh attached.

## Export

`dist/Abbott.exe` — product **2.151.0**. Creation time kept **2026-09-12 08:34:04**. Packed `res://content` (SHIP + Michelle + fence catalog only, not 304 courses).
