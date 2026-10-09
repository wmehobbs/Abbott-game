# Day 14 — a better Abbott

The game still uses `quaternius-WhiteHorse.glb` until H1 is wired. Switch back later by the one constant `MESH` in `game/scripts/abbott_look.gd`.

Baseline stills: `dist/day14/renders/v1/side.png`, `threequarter.png`, `head.png`, `rear.png`. Strips: `dist/day14/renders/v1/strip_Walk`, `strip_Gallop`, `strip_Gallop_Jump`.

## Status

| phase | status | commit | gates | verdict |
| --- | --- | --- | --- | --- |
| H0 | done | pending | Blender stills and strips, no Godot | The current horse is a faceted gray model. Side, three-quarter, head and rear all show flat faces and no blaze. |
| H1 | running | | | |
| H2 | | | | |
| H3 | | | | |
| H4 | | | | Free models only. Nothing that costs money. |
| H5 | | | | |

## Decisions

- The two Godot processes from 4 Oct (114976 and 115652) were left running. They were not killed. Blender ran beside them because this day cannot wait them out, and `ride_ids.py` was not used.
- The source mesh has no UV map. The coat is painted in 3D (vertex color) and baked onto a new UV layout, which is the fallback the prompt allows when a blaze cannot be painted on the old UVs.
- Stall photos show a flaxen mane and a wide white blaze. The tail is darker than the mane. Socks follow the game: left hind and right fore.
- Walk footfalls on this rig are a four-beat (left hind, left fore, right hind, right fore). Gallop is a left-lead four-beat (right hind, left hind, right fore, left fore). Trot and canter are built from those poses.

## NEEDS ERNIE

- How the horse looks inside Godot (materials, lighting, the ride camera) waits for a windowed run tonight. These stills are Blender only.

## BLACKLIST

- none
