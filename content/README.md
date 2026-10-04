# Hidden K content library

Data for a later coding pass. The live game still builds one track in `game/scripts/course.gd` (`_specs_for`) and one Michelle sentence in `game/scripts/trainer.gd` (`Trainer.phrase`). Do not switch those over until a human is looking.

This folder is next to `game/`, not inside `res://`. `game/scripts/content_library.gd` is a thin optional stub that can read JSON from `user://content`, `res://../content` (dev checkout), or `res://content` if someone copies the library in.

## Courses

`content/courses/<class_id>/<id>.json`  
Jump-offs: `content/courses/jump_off/<class_id>/<id>.json`  
Index: `content/courses/INDEX.json`

Replace `Course._specs_for` like this:

1. Pick a row from the index (`class` + `jump_off` + `session_kinds` contains the current session).
2. `ContentLibrary.load_course(id)` → dictionary.
3. `ContentLibrary.specs_from_course(course)` → the array `_build_outdoor` already expects: `kind`, `h`, `sp`, `pos`, `yaw`.
4. Set `start_pos`, `start_yaw`, and finish from the JSON (`finish_z` is the out-gate line). Show vs schooling times are `time_allowed_show` / `time_allowed_school`.

Ring facts are already in the JSON. Validator lives at `tools/content_factory/validate_content.py`. Do not invent a fourth fence kind.

## Michelle

`content/rail/michelle.json` — tagged variants, max 14 words, one sentence.

Replace `Trainer.phrase(kind)` with:

`ContentLibrary.phrase(kind, GameState.session_kind, GameState.class_id)`

If that returns empty, keep the hardcoded line. Result-card notes: `content/rail/barn_notes.json`, keyed by confidence / rideability / timing bands the way `GameState.barn_note` already branches.

## Fences / HUD

`content/fences/catalog.json` maps `vertical | oxer | flower` plus a filler (`brush`, `plank`, `gate`, `flower box`) to a quiet hunter name. HUD later: `Next  4  ·  brush oxer`. `ContentLibrary.fence_name(kind, height, spread)`.

## Textures

Harvested plates: `game/assets/textures/harvest/`  
Procedural variants: `game/assets/textures/harvest/proc/`  
Attribution: `game/assets/ATTRIBUTION_HARVEST.md`  
Do not overwrite `sand_albedo.jpg`, `wood_albedo.jpg`, or anything already in `game/assets/textures/`.

## Rider / saddle meshes (not live)

Hunt notes: `content/meshes/RIDER_HUNT.md`. Ranked list: `content/meshes/CANDIDATES.json`. Raw GLBs: `content/meshes/raw/`.

The live seat is still `PersonLook.mounted_madison()` plus `horse.gd` nodes `Rider/Body/{Head,LLeg,RLeg}`. Do not attach a hunted mesh to Abbott until a later pass wraps those names. There is no English close-contact saddle GLB in this harvest.

Factory scripts (rerun, don't rewrite the ride):

```
python tools/content_factory/harvest.py
python tools/content_factory/convert_harvest.py
python tools/content_factory/make_plates.py
python tools/content_factory/make_courses.py
python tools/content_factory/make_rail.py
python tools/content_factory/make_fences.py
python tools/content_factory/validate_content.py
```

`validate_content.py` exits 0 only when every quota is green. Status: `tools/content_factory/STATUS.md`.
