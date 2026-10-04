# What matters now

The 25k course pile under `content/courses/` is archive. Do not ship it. Do not raise quotas.

## Live board (20 files)

`content/courses/SHIP.json` and `game/content/courses/SHIP.json` — 4 lesson, 6 beginner, 6 intermediate, 4 advanced, 1 jump-off per class. Indoor is scenery, not a class.

Why each id: `tools/content_factory/SHIP_REAL.md`.

The JSON for those ids lives in `game/content/courses/` (the export slice) and still in `content/courses/` (do not delete the pile).

## Michelle

`game/content/rail/michelle_ship.json` — 336 lines, 16 per live speak() key. The 48k file stays at `content/rail/michelle.json` and is not in the export.

`Trainer.phrase` → ship → pile (dev checkout) → hardcoded.

## Saddle

`game/scripts/person_look.gd` `_english_saddle`. Last real photos: `tools/content_factory/artshots/r01`–`r06`. Cull notes: `artshots/CULL_NOTES.md`. Do not treat r07+ crops as evidence.

## Proof

`python tools/content_factory/prove_ship.py`  
Headless: Godot `--headless --path game -- --playtest`
