# Day 15 — Claude, overnight (Oct 9–10)

Branch `day15-claude`, from `day14-horse`. Version stays 2.348.0.0. Nothing pushed, nothing exported.
Ernie went to bed at 00:42 and said: take it over, six hours, make it production quality, and make the rider look normal.

Madison's save: Ernie played at 20:43 on Oct 9, so the live save is the reference tonight: `dist/day15/save_snapshot.json` (a copy is in `dist/day15/save_backup_2026-10-10_0042.json`). It matched after every run below.

## Status

| step | status | commit | gates | verdict |
| --- | --- | --- | --- | --- |
| horse visible | done | (M1) | compile ok, selftest 51/0, playtest 0/4/4, les 25.43, beg 62.14 jo 33.45, save match | Abbott was invisible in the game. Fixed. |
| rider seat | done | (M1) | same | Madison sits in the saddle behind the withers, legs down his sides, feet in the irons, fists over the withers, helmet on. |
| bridle | done | (M2) | compile ok, selftest 51/0, playtest 0/4/4, les 25.42, beg 62.15 jo 33.44, save match | A real bridle fitted to his head, in `abbott_v2d.glb`. |
| trees | done | (M2) | same | No brown canopies, no disc trees. Four greens. |
| aid marks | done | (M2) | same | Stride dots and the takeoff ring are flat chalk marks on the sand. |
| jump lens | done | (M2) | same | He stays in the frame over the fence. |
| hooves | done | (M2) | same | The hoof plant and pastern limits are in metres, so they work on the v2 skeleton. |
| look | done | (M2) | same | Softer vignette. Neck reaches further over the top of a jump. |
| on foot | done | (M2) | same | Walking Madison wears the helmet; her and Michelle's boots ride the leg bones. |
| frame rate | done | (M3) | see M3 | 35–40 fps to 70–95 fps on the same ride. The HUD was reading a file every frame. |
| sharper | done | (M3) | see M3 | SMAA instead of FXAA on High and Medium. |
| even legs | done | (M4) | compile ok, selftest 52/0 | Both knees level and forward; her thighs wrap him from behind instead of splaying. |
| fences | done | (M5) | see M5 | Brush is a hedge and flower boxes are beds of blooms, one mesh each. 104 fps median. |
| coat | done | (M5) | see M5 | A groomed gloss and soft rim on his coat. |
| window | done | (M5) | see M5 | Opens at 1600×900. F11 or Alt+Enter for full screen, remembered. |
| saddle, fists | done | (M6) | compile ok, selftest 52/0 | Broad low cantle, no gullet strip; fingers curl into the gloves. |
| lens | done | (M7) | selftest 52/0, playtest 0/4/4, les 25.43, beg 62.14 jo 33.45, save match | The ride camera is no longer interpolated twice; the warning is gone. |

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

### Second pass (M2)

- **The bridle:** Cursor's v2 "bridle" was only two bit rings and two short bars at the mouth. `dist/day15/blender/build_bridle.py` builds one on his head and weights it to the Head bone:
  - a crownpiece and throatlatch behind the ears;
  - a browband;
  - two cheekpieces to the bit;
  - a cavesson noseband;
  - loose rings at the mouth corners, with new BitL and BitR markers at the rings so the reins start at the bit.

  Every strap is fitted as a smooth loop around his measured head, off the coat. The result goes through the same layout fix, and the game loads `abbott_v2d.glb`.
- **Trees:** Kenney's `tree_default` lists its bark before its leaves, and the farm painted by surface order, so a third of the trees had brown canopies. Trees are now painted by material name, in four greens. The three hand-built yard oaks (the last disc trees) are Kenney oaks.
- **Aid marks:** the lesson stride dots were 32 cm yellow balls in the air. They are flat discs on the sand, and the takeoff ring is flattened with them.
- **Jump lens:** over a fence the camera aimed at the top rail alone, looked down past the horse, and he flew out of the top of the frame. Half the aim now stays a stride ahead of him. A frame-by-frame log of a real jump (`game/tools/day15_camlog.gd`) shows the lens 4.6 to 5.0 m behind him the whole way, rising with him. The old strip only looked frozen because the stills harness runs at a few frames a second.
- **Hooves:** `bascule.gd` compared a hoof's lift and the pastern limit in skeleton units. Those are 0.85 m on the old mesh and 40 m on v2, so on v2 every hoof counted as "down" and the pastern had no limit. Both are converted to metres now.
- **Look:** the vignette starts further out and is half as dark. Over the top of a jump the neck stretches 10° more.
- **On foot:** walking Madison had no helmet, and her (and Michelle's) boots floated off the legs because they were placed from Blender coordinates. The helmet and the boots are shared code now, attached to the head, shin and foot bones.

### Smoother and sharper (M3)

- **Why it was not smooth:** with the GPU at about 2.5 ms a frame, the game ran at 30–40 fps (1600×900, windowed). Turning systems off one at a time pointed at the HUD, and timing its pieces found it: `GameState.next_fence_line()`, called every frame for "Fence 1 of 3 · white vertical", read and parsed `fences/catalog.json` from disk each call (11.6 ms).
  - `ContentLibrary.fence_name` now reads the catalog once.
  - The HUD frame went from 12,300 µs to 35 µs.
  - The same ride now runs at 70–95 fps. Walk mode used the same reader for its fence lines, so it is faster too.
- **The HUD also re-did layout work every frame:** it re-set the root size (a full re-layout), re-anchored the reins card (re-shaping its text), re-applied Michelle's caption font, and ran six recursive `find_child` searches. Each is now done only when something changes, and the lookups are cached.
- **Draw calls:** the farm drew 2,400 meshes and a course 1,100 (flower heads, stems, bolts), nearly all casting shadows into four cascades: 2,000–8,000 draw calls a frame. `MeshKit.tune_small` runs once after the farm and each course are built:
  - under 25 cm: no shadow, fade out past 45 m;
  - under 50 cm: no shadow, fade past 80 m;
  - under 1 m: fade past 140 m.

  Draw calls fell to about 1,100–3,400. The fades dither, so nothing pops.
- **Sharper:** FXAA blurred the whole picture about 13 percent (mean edge strength on the ride view); SMAA blurs about 7. High and Medium now use SMAA over their MSAA; Low keeps FXAA.
- **New check:** `hud_frame_cost` in the selftest times the HUD frame and the fence line in the arena, so a file read per frame cannot come back unnoticed.
- **New tools:** `game/tools/day15_perf.gd` (frame rate with each system off), `day15_hudtime.gd` (cost of each HUD piece), `day15_camlog.gd` (lens and horse per frame, plus draw calls).

### Even legs (M4)

- The glb's hip joints are not mirror images (its rest pose is turned a little), which put her left knee 2.4 cm higher and 3.3 cm further back than her right. Both hips now come from one mirrored offset.
- From the ride camera her right thigh splayed out sideways. The knee pole leans forward instead of out, so the knees sit level at 0.22 m off his centre line and her thighs wrap him.

### Fences, coat, window (M5)

- **Fences:** the brush fill was 22 sticks with a ball on top, and the flower boxes and wing planters were dozens of separate stems, leaves and petal parts (a course was 1,100 meshes). From the saddle they read as lollipops.
  - The brush is now three rows of small packed clumps: a hedge.
  - The flower boxes and planters are a bed of leaves with blooms on top (white, yellow, orange, red, pink).
  - Each fill is one mesh with its colour in the vertices (`MeshKit.clumps`).
  - The riding test runs at a median of 104 fps (56 to 126) with vsync off; 1,980 draw calls median.
- **Coat:** roughness 0.58 to 0.42 and a soft rim, so his coat reads as groomed.
- **Window:**
  - The game opened a 1920×1080 window, which runs under the taskbar on a 1080p screen. It opens at 1600×900; the interface still lays out for 1920×1080 and scales.
  - F11 or Alt+Enter toggles full screen, and the choice is kept in `settings.cfg` (never the ride save).

### Saddle, fists, lens (M6, M7)

- **Saddle:** the cantle narrowed into a tube that rose behind her with a ball on the end, like a lever. The seat is a dish now, the cantle broad and low, the pommel a hand up. The gullet strip that sat on top of his withers is gone.
- **Hands:** the gloves are rounded fists, and the fingers curl toward the palm (the first curl went up the back of the hand), a size smaller so they stay inside the glove.
- **Lens:** the ride camera inherited physics interpolation from the horse and is placed every frame from the horse's already-interpolated pose. That interpolated it twice and logged a warning every ride. The camera's own interpolation is off now; the warning is gone. At about 100 fps the lens sits 4.6–5.0 m behind him.
- **Probe strip mode:** holding a clip at a phase did not stick with how the horse's player is driven, so a `strip` pose plays the gait forward with real steps. The trot (Cursor's) is a proper two-beat with a moment of suspension; the canter nods naturally.

## Decisions

- The jump and leave math, the rules, `ride_ai.gd`, the course files and horse.gd's rider signals were not touched. The ride gate is the proof: lesson 25.43, beginner 62.14 and jump-off 33.45, the same faults and offers as before.
- `abbott_v2b.glb` was an intermediate (sibling layout, still world-space vertices) and was deleted. Only v2c is kept.

## NEEDS ERNIE

- The `photos_jpg/` folder at the repo root was deleted outside this session (it shows as deleted in git). Nothing tonight touched it, and the deletion is not committed.
