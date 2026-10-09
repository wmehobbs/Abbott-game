# Day 14 — a better Abbott

The game uses `abbott_v2.glb`. Switch back by setting `MESH` in `game/scripts/abbott_look.gd` to `res://assets/meshes/quaternius-WhiteHorse.glb`. That also turns the photo coat back on.

Before: `dist/day14/renders/v1/side.png` (and threequarter, head, rear). After the pale paint: `dist/day14/renders/v2g/`. Coat pass: `dist/day14/renders/coat3/sheet.png` puts the title photo, the pale horse, and the deep chestnut in one sheet. Lesson 25.48 (T0 25.41), beginner 62.15, jump-off 33.45 (T0 33.45), 0 faults, teleported false, offers no then yes. Selftest 50/0. Save matched the snapshot. No free download beat v2. The bridle straps still need a windowed look, and so does the coat under the game lights.

Baseline stills: `dist/day14/renders/v1/side.png`, `threequarter.png`, `head.png`, `rear.png`. Strips: `dist/day14/renders/v1/strip_Walk`, `strip_Gallop`, `strip_Gallop_Jump`.

## Status

| phase | status | commit | gates | verdict |
| --- | --- | --- | --- | --- |
| H0 | done | b3ec4c5e | Blender stills and strips, no Godot | The current horse is a faceted gray model. Side, three-quarter, head and rear all show flat faces and no blaze. |
| H1 | green | a327461d | compile 0, selftest 50/0, rides, playtest pass, save matched | v2 is a smooth chestnut. Side, head and rear are clearly better than v1. The first paint was a pale tan. |
| coat | green | | compile 0, selftest 50/0, lesson 25.48, beginner 62.15, jump-off 33.45, 0 faults, save matched | The body is a deep red chestnut beside the title photo. The back and the legs are a shade darker than the barrel. The blaze is still jagged. |
| H2 | canter mapped, trot not | | same rides | Canter strip reads one hind, then a diagonal pair, then the leading fore. Trot attempt 1 still has a third foot down. Trot stays on Walk. |
| H3 | bits only | | | BitL and BitR sit at the mouth and the reins look for those names. The leather straps are in the file and were not clearly on the skin in the head still. |
| H4 | written | | no download that needs an account | Nothing free beats v2. See dist/DAY14_HORSE_OPTIONS.md. |
| H5 | note stripped | | selftest pass=50 fail=0 | "Hidden K note N" was the end of the barn-note sentence. The card now stops before it. Best 5.86s is the saved record. NEEDS ERNIE. |

## Decisions

- The two Godot processes from 4 Oct (114976 and 115652) were left running. They were not killed. Blender ran beside them because this day cannot wait them out, and `ride_ids.py` was not used.
- The source mesh has no UV map. The coat is painted in 3D (vertex color) and baked onto a new UV layout, which is the fallback the prompt allows when a blaze cannot be painted on the old UVs.
- Stall photos show a flaxen mane and a wide white blaze. The tail is darker than the mane. Socks follow the game: left hind and right fore.
- Walk footfalls on this rig are a four-beat (left hind, left fore, right hind, right fore). Gallop is a left-lead four-beat (right hind, left hind, right fore, left fore). Trot and Canter were keyed from those poses.
- The imported mesh has split vertices. Subdivision on them shrank each triangle and left gaps. Welding before the subdivision closed the body. The coat is per-face materials because the source UVs cannot hold a blaze. The 2K png is the paint record. Godot uses the glTF colors. The photo shader is off only while MESH ends with abbott_v2.glb.
- Trot attempt 1 (`dist/day14/renders/v2g/strip_Trot`) is not a clean two-beat: a third foot stays down and there is no real suspension. It is in the file and not mapped. Canter attempt 1 reads as one hind, then a diagonal pair, then the leading fore. It is mapped. Gallop is the fallback. Phase 0 is the outside hind.
- v2 stills: `dist/day14/renders/v2g/side.png`, `threequarter.png`, `head.png`, `rear.png`.
- The pale coat was linear (0.45, 0.17, 0.07), which reads as salmon under this exposure. The photo's cheek sits near sRGB (65, 54, 50). The coat is now a welded vertex color, darker along the topline and the legs, on one material so the shade does not break into patches. Sheet: `dist/day14/renders/coat3/sheet.png`. Barrel pixels about (105, 77, 67). Godot's windowed look is still unproven.

## NEEDS ERNIE

- How the horse looks inside Godot (materials, lighting, the ride camera) waits for a windowed run tonight. These stills are Blender only.
- "Best 5.86s" is the saved best for the beginner class (`best_time` about 5.86, 0 faults). A full beginner round is about a minute. The record is written by the frozen round logic, so it was not changed.

## BLACKLIST

- none
