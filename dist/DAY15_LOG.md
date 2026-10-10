# Day 15 — Claude, overnight (Oct 9–10)

Branch `day15-claude`, from `day14-horse`. Version stays 2.348.0.0. Nothing pushed, nothing exported.
Ernie went to bed at 00:42 and said: take it over, six hours, make it production quality, and make the rider look normal.

Madison's save: Ernie played at 20:43 on Oct 9, so the live save is the reference tonight: `dist/day15/save_snapshot.json` (a copy is in `dist/day15/save_backup_2026-10-10_0042.json`). It matched after every run below.

## Status

| step | status | commit | gates | verdict |
| --- | --- | --- | --- | --- |
| horse visible | done | (M1) | compile ok, selftest 51/0, playtest 0/4/4, les 25.43, beg 62.14 jo 33.45, save match | Abbott was invisible in the game. Fixed. |
| rider seat | done | (M1) | same | Madison sits in the saddle behind the withers, legs down his sides, feet in the irons, fists over the withers, helmet on. |

## What was wrong, and what changed

### Abbott was invisible in the game

Every in-game frame showed Madison, the saddle and a stick floating in the air. Cursor's `abbott_v2.glb` (Day 14) was checked only in Blender. In Godot its body was **100 times too big and lying on its side**: from 200 m up, giant chestnut shapes ringed the whole farm. Blender's exporter put the body's world-space vertices *under* the 100× armature, where Godot reads them in the skeleton's own units.

- `dist/day15/blender/glb_to_quaternius_layout.py` rewrites the file into the original Quaternius layout: vertices in armature units, the mesh node carrying the armature's 100× and −90° turn, and the inverse bind matrices rewritten to match. Same vertices, same skin, same clips, same paint.
- New file `game/assets/meshes/abbott_v2c.glb`. `abbott_v2.glb` is untouched. `MESH` in `abbott_look.gd` points at v2c; set it back to `quaternius-WhiteHorse.glb` to return to the old horse.
- His painted coat drew white, because Godot's glTF import leaves vertex colors off. `_use_painted_coat` turns them on. He is a deep chestnut with the blaze, flaxen mane and socks.
- Bones now sit where the old horse's did (head 1.64 m vs 1.63 m).

### Madison

Seen close up from both sides, front, rear, and through the gaits:

- **She sat on his loins.** The seat hung off the `Torso` bone, on the rise toward his croup. His back dips lowest at `Torso2`, just behind the withers: that is where a saddle goes. `SEAT_BONES` now starts with `Torso2`. She moved about 0.32 m forward.
- **She was sized by accident.** The seat inherited the skeleton's scale: 0.85 on the old mesh (a 1.43 m girl), 40 on v2c (a giant). `RIDER_SCALE = 0.85` now sets it on purpose. His back is 1.43 m up, a 14-hand horse, and a 1.43 m girl fits him.
- **Her legs were stretched and her whole body tilted as one block.** The old code copied the angles of an old stick-figure rider onto her bones, scaled her shin bones to as little as 35 percent to reach the stirrups, and pitched her legs with her torso. `rider_mesh.gd` now poses the skeleton directly in the seat's frame:
  - her seat bones sit on the saddle's deepest point;
  - the lean is shared by pelvis (half) and spine;
  - each leg hangs from the hip to a fixed ankle on his barrel at full length (knee about 104°, the knee pole forward and out on the knee roll), heel down 16°, toe out 14°;
  - her fists are on the reins a fist above the withers, elbows bent, thumbs up;
  - her head looks up the line;
  - in the air she folds 22° deeper and her fists go up the crest (a release);
  - the rising trot lifts her a hand's width.
- horse.gd's seat signals (lean, roll, lift, head) are unchanged; the rider reads them.
- **The stirrups hung 0.38 m out from his centre, in mid-air.** The saddle no longer draws them. The rider draws the leather from the bar to an iron under the ball of her foot.
- **The saddle stood 10 cm off his sides.** The flaps, knee rolls, girth and a new white square pad are draped on his measured barrel (`BARREL` in `person_look.gd`).
- **She had no helmet:** the cap was smaller than her hair. A velvet dome with a peak sits over the hair now.
- **Smaller fixes:** the crop hangs down and back across her thigh, not forward like a lance; the white stock is at her throat; her fingers are curled into fists under the gloves.

Pictures (not committed): `dist/day15/shots/rider1` (before, horse visible) and `rider3`, `rider4`, `rider6` (after).

### Checks

- `leg_tuck` in the selftest used to grep two lines of the old leg code. It now loads the arena and checks the posed rider:
  - the horse skeleton spans a horse (would have caught the giant);
  - the saddle is in the dip behind his withers;
  - each ankle hangs against his side below its knee;
  - the two legs match.
- New tools:
  - `game/tools/day15_probe.gd` and `dist/day15/run_probe.py`: windowed stills of horse and rider from any camera, at any gait or jump moment, in about 20 seconds;
  - `dist/day15/blender/*.py`: model inspection and the layout fix.

## Decisions

- The jump and leave math, the rules, `ride_ai.gd`, the course files and horse.gd's rider signals were not touched. The ride gate is the proof: lesson 25.43, beginner 62.14 and jump-off 33.45, the same faults and offers as before.
- `abbott_v2b.glb` was an intermediate (sibling layout, still world-space vertices) and was deleted. Only v2c is kept.

## NEEDS ERNIE

- The `photos_jpg/` folder at the repo root was deleted outside this session (it shows as deleted in git). Nothing tonight touched it, and the deletion is not committed.
