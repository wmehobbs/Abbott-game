# Cursor — trees only

You are Cursor in `E:\Workspace\Madison`. Ernie is on other projects.
Grok has the people. Claude has the clock. You have the trees.

## Gate

If `Godot_v4.7.2` is live, do not start `--playtest` or pack. Do not taskkill.
`ride_ids.py` is Claude’s — do not run it.

Do **not** edit `person_look.gd`, `abbott_look.gd`, `horse.gd`, `ride_ai.gd`,
course JSON, or `dist/Abbott.exe`. Knock Area stays
`(width*0.9, height+0.15, 0.35+spread)`.

## Photograph

Ernie: sand is amazing, jumps read, **trees look like triangles / amateur**.
Oaks were balloons, then flattened spheres. Pines are seven tapered
cylinders in `_pine_plant` — from C those are cones.

## This job

Rewrite only:

- `game/scripts/farm.gd` `_pine_plant`
- `game/scripts/farm.gd` `_oak_plant`

Helpers in that file are fine. Do not change `_trees` count (110),
`_in_keepout`, windbreak / shade / yard call sites, or ring size.

Pines: **branches** make the taper. Needle masses sit on the boughs
(flattened, irregular). No stacked cones. Same September rust shader
(`MeshKit.pine_material()`).

Oaks: **limbs** first, leaf on the limbs. Not three spheres on a pole.
Same hardwood shaders. Duff and flare may stay.

Keepout unchanged. Off the sand. Same seed so the grove does not jump.

## Score

From C. A cone is not a pine. A pancake on a stick is not an oak.
Sand is the bar — do not invent a second harvest. Playtest when Godot
is down: `--headless --path game -- --playtest` must stay
clear 0 / refuse 4 / rail 4. Knock still fires.

Do not pack. Grok packs people when Claude is idle.

`_pine_plant` / `_oak_plant` were rewritten 20 Sep night (this window).
If that diff is in `farm.gd`, **stop**. Do not open a people rewrite
and do not start `ride_place`. Sit. Wait for Ernie.
