# Day 14 — a better Abbott

The game uses `abbott_v2.glb`. Switch back by setting `MESH` in `game/scripts/abbott_look.gd` to `res://assets/meshes/quaternius-WhiteHorse.glb`. That also turns the photo coat back on.

Before: `dist/day14/renders/v1/side.png` (and threequarter, head, rear). After the pale paint: `dist/day14/renders/v2g/`. Coat pass: `dist/day14/renders/coat3/sheet.png` puts the title photo, the pale horse, and the deep chestnut in one sheet. Face pass: `dist/day14/renders/face16/sheet.png` puts the title photo beside the head. Lesson 25.43 (T0 25.41), beginner 62.14, jump-off 33.45 (T0 33.45), 0 faults, teleported false, offers no then yes. Selftest 50/0. Save matched the snapshot. No free download beat v2. The bridle straps still need a windowed look, and so does the coat under the game lights.

Baseline stills: `dist/day14/renders/v1/side.png`, `threequarter.png`, `head.png`, `rear.png`. Strips: `dist/day14/renders/v1/strip_Walk`, `strip_Gallop`, `strip_Gallop_Jump`.

## Status

| phase | status | commit | gates | verdict |
| --- | --- | --- | --- | --- |
| H0 | done | b3ec4c5e | Blender stills and strips, no Godot | The current horse is a faceted gray model. Side, three-quarter, head and rear all show flat faces and no blaze. |
| H1 | green | a327461d | compile 0, selftest 50/0, rides, playtest pass, save matched | v2 is a smooth chestnut. Side, head and rear are clearly better than v1. The first paint was a pale tan. |
| coat | green | 07a08fb5 | compile 0, selftest 50/0, lesson 25.48, beginner 62.15, jump-off 33.45, 0 faults, save matched | The body is a deep red chestnut beside the title photo. The back and the legs are a shade darker than the barrel. The blaze is still jagged. |
| face | green | 9ef3cb8a | compile 0, selftest 50/0, lesson 25.43, beginner 62.14, jump-off 33.45, 0 faults, save matched | The blaze is a soft white stripe down the front of the face. The forehead is chestnut, and the dark patches around the eye are gone. Sheet: `dist/day14/renders/face16/sheet.png`. |
| socks | green | a788956e | compile 0, selftest 50/0, lesson 25.43, beginner 62.14, jump-off 33.45, 0 faults, save matched | Left hind and right fore: white runs to the hoof, and the hoof is dark. Sheet: `dist/day14/renders/sock1/sheet.png`. |
| H2 | trot mapped | cd1d6c47 | compile 0, selftest 50/0, lesson 25.42, beginner 62.15, jump-off 33.44, playtest clear 0 refuse 4 rail 4, save matched | Trot attempt 2 is two diagonal pairs with the other two feet up, and a suspension between them. It is mapped. Walk at phase 0.25 stays the fallback. Strip: `dist/day14/renders/trot2/strip_Trot`. |
| H3 | bits only | | | BitL and BitR sit at the mouth and the reins look for those names. The leather straps are in the file and were not clearly on the skin in the head still. |
| H4 | written | | no download that needs an account | Nothing free beats v2. See dist/DAY14_HORSE_OPTIONS.md. |
| H5 | note stripped, class best | | compile 0, selftest 51/0, playtest clear 0 refuse 4 rail 4, save matched | The card, the pause line, and the title show best_by_class for the current class. The line is hidden when that class has no record. The saved best_time is unchanged. |

## Decisions

- The two Godot processes from 4 Oct (114976 and 115652) were left running. They were not killed. Blender ran beside them because this day cannot wait them out, and `ride_ids.py` was not used.
- The source mesh has no UV map. The coat is painted in 3D (vertex color) and baked onto a new UV layout, which is the fallback the prompt allows when a blaze cannot be painted on the old UVs.
- Stall photos show a flaxen mane and a wide white blaze. The tail is darker than the mane. Socks follow the game: left hind and right fore.
- Walk footfalls on this rig are a four-beat (left hind, left fore, right hind, right fore). Gallop is a left-lead four-beat (right hind, left hind, right fore, left fore). Trot and Canter were keyed from those poses.
- The imported mesh has split vertices. Subdivision on them shrank each triangle and left gaps. Welding before the subdivision closed the body. The coat is per-face materials because the source UVs cannot hold a blaze. The 2K png is the paint record. Godot uses the glTF colors. The photo shader is off only while MESH ends with abbott_v2.glb.
- Trot attempt 1 (`dist/day14/renders/v2g/strip_Trot`) is not a clean two-beat: a third foot stays down and there is no real suspension. Attempt 2 lifts the off pair from the walk frames where that foot is highest. Frame 0 is left hind and right fore down, the other two up. Frame 8 is the other diagonal. Frames 4 and 12 are all four off the ground. It is mapped at phase 0. Walk at 0.25 stays the fallback if the clip is missing. Canter is unchanged. Strip: `dist/day14/renders/trot2/strip_Trot`.
- v2 stills: `dist/day14/renders/v2g/side.png`, `threequarter.png`, `head.png`, `rear.png`.
- The pale coat was linear (0.45, 0.17, 0.07), which reads as salmon under this exposure. The photo's cheek sits near sRGB (65, 54, 50). The coat is now a welded vertex color, darker along the topline and the legs, on one material so the shade does not break into patches. Sheet: `dist/day14/renders/coat3/sheet.png`. Barrel pixels about (105, 77, 67). Godot's windowed look is still unproven.
- The jagged blaze was a hard height cut through the face triangles, plus ear-weighted corners left white on coat faces. The blaze is now a soft weight down the front, the poll stays chestnut, and the ear tips darken on the same coat instead of a second material. Sheet: `dist/day14/renders/face16/sheet.png`.
- The dark band under each sock was the bottom of the cannon painted as hoof, while the real hoof stayed chestnut. The source material is named Hooves, so "hoof" never matched it. White now runs from the sock top to that hoof, on the left hind and the right fore only. Sheet: `dist/day14/renders/sock1/sheet.png`.

## NEEDS ERNIE

- How the horse looks inside Godot (materials, lighting, the ride camera) waits for a windowed run tonight. These stills are Blender only.
- "Best 5.86s" is still the saved overall record (`best_time` about 5.86, 0 faults, beginner). The card and the title used to print that on a lesson. They now print `best_by_class` for the current class, and the line is hidden when that class has none. `_record_round` was not changed.

## BLACKLIST

- none
