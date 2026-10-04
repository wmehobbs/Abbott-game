# Madison / Abbott Jev scan (2026-09-26)

Read-only inventory of `E:\Workspace\Madison` on GenstrataPC. Deliverables live only on this box. No edits to the game tree.

## What the project is

Folder name is **Madison**. Shipped product name is **Abbott** (Godot `config/name="Abbott"`, version `2.348.0.0`).

You play **Madison**. You ride **Abbott**. One outdoor ring at **Hidden K Stables, Pfafftown, NC**. Craft bar: *A Short Hike*. Not a career sim. Pony Club / college / other horses come later.

| Field | Value |
| --- | --- |
| Engine | Godot **4.7** + **Jolt** physics |
| Language | **GDScript** (20 live scripts under `game/scripts/`) |
| Genre | Boutique equestrian jumping school / Table A show |
| Main scenes | `game/scenes/title.tscn`, `game/scenes/arena.tscn` |
| Autoload | `GameState` (`game/scripts/game_state.gd`) |
| Export | `dist/Abbott.exe` (STATUS: unverified re-pack; do not treat as ship cert) |
| LLM / Jev today | **None** in game scripts (no typesafe / jev / openai hooks) |

## Sessions

- **Lesson** poles to single to two-stride; takeoff marks; Michelle one sentence after leave
- **Schooling** Crossrails 2'3" / Schooling Jumpers 2'6" / Open Jumpers 3'0"
- **Show day** Welcome Stake / Classic / Hidden K Mini Prix; Table A; jump-off if clear
- **Walk** on foot, no clock

## Architecture (short)

```
title.gd  --> start_session --> arena.tscn
arena.gd  --> Farm + Course + Horse(Abbott) + Walker + HUD
             (+ RideAI only under --ridecert / playtest harnesses)
GameState --> faults, clock, stats, speak(), barn_note(), save
Trainer   --> phrase(kind) --> ContentLibrary Michelle JSON --> hardcoded fallback
horse.gd  --> leave geometry (early / deep / chip / spot / looked) + speak triggers
ride_ai.gd --> headless cert rider (geometry / phases); not player AI NPC
```

Content library (optional JSON): `content/` (factory pile) and `game/content/` (ship slice). Live Michelle board: `game/content/rail/michelle_ship.json` (336 lines, 16 per speak key). Archive pile: `content/rail/michelle.json` (~48k). Courses ship board: 20 ids in `SHIP.json`.

## Where judgments already exist

| Place | Today | Typed? |
| --- | --- | --- |
| Leave outcome | Distance/angle windows in `horse._try_leave` | Yes (code) |
| Michelle line | Filter by `key` + session + class, then **random** among hits | Soft (pick among prose) |
| Barn note | Band filter on confidence / rideability / timing, then **random** | Soft |
| Soft leave praise | Random among `leave` / `straight` after clean | Soft |
| Flower look | RNG from confidence formula | Code + RNG |
| Stat school | `_school_from_round` arithmetic | Code |
| Unlock / ribbon / Table A | Counters and rules | Code |
| RideAI ask / come-again | Geometry phases | Code (spatial) |
| Course pick from SHIP | Seed modulo among ids | Code |
| Offline course score | `tools/content_factory/score_courses.py` heuristics | Dev tool |

## Files in this folder

- `JEV_RECOMMENDATIONS.md` full ranked inserts for Ernie
- `CURSOR_PROMPT.md` paste-ready thin adapter + 1 to 2 harnesses

## Expertise used (box)

`/workspace/jev-expertise/` mental-model, 02-primitives, 15-starcraft, 05-limitations, 17-gauntletscore pattern of ranked inserts.
