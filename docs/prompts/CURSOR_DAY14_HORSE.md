# Cursor, Day 14: a better Abbott (daytime, headless, Ernie is at work)

You are Cursor in E:\Workspace\Madison. The Godot 4.7.2 project is game/. Ernie is at his desk working on other things and will not answer. Work through the phases below in order, verifying, committing and logging as you go. Do not stop to ask questions. When a phase is done, start the next one in the same turn.

## The hard rule for today: no windows

Ernie is using this computer. **No Godot window of any kind:** no run_shots.py, no --shots, no --artshot, no editor. Godot runs only headless through the existing wrappers (docs/ARCHITECTURE.md, "How to run the checks"). One Godot at a time. The seat-probe PIDs 114976 and 115652 are old; leave them alone. Never kill a Godot you did not start, and never run ride_ids.py.

Your eyes today are **Blender in background mode**, which renders to a file and opens no window:

`"C:\Program Files\Blender Foundation\Blender 5.2\blender.exe" -b --factory-startup -P <script.py> -- <args>`

`dist/day14/blender_render.py` is a working starter. It imports a glb, prints the bounds, actions, bone count and polygon count, and renders one Eevee still in about 14 seconds. Extend it. Keep the house quiet:
- run one Blender at a time, never together with a Godot;
- start it at below-normal priority (Python subprocess with `creationflags=subprocess.BELOW_NORMAL_PRIORITY_CLASS | subprocess.CREATE_NO_WINDOW`);
- use Eevee, not Cycles;
- render at 1280 px wide or smaller;
- give it a 5-minute timeout.

If Blender ever opens a window, stop using it, log the exact command under BLACKLIST, and continue with headless-only work.

Madison's save: compare `C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json` with `dist/day12/save_snapshot.json` after every Godot run (Rule 2 of docs/prompts/CURSOR_DAY13.md). Do not commit images or snapshots.

## Why

Last night (docs/prompts/CURSOR_DAY13.md, dist/DAY13_LOG.md) made the world much better. Now **the horse is the weakest thing on screen.** Abbott is `game/assets/meshes/quaternius-WhiteHorse.glb`, a CC0 low-poly horse from "Realtime Rancher's 3D Model Pack" (Lyndon Daniels):
- 2,182 polygons, 50 bones, flat facets;
- a photo coat smeared across the face (abbott_look.gd, game/shaders/coat.gdshader);
- black tack rods that float off his head;
- only these clips: Idle, Idle_2, Idle_Headlow, Walk, Gallop, Gallop_Jump, Jump_toIdle, Eating and a few attacks.

**There is no trot and no canter.** horse.gd plays Walk sped up for the trot and Gallop for the canter (around horse.gd:1440-1456). A rider sees that at once.

The real Abbott is a chestnut with a wide white blaze. See game/assets/photos/abbott_title.jpg, IMG_3408.jpg, IMG_3409.jpg and game/assets/textures/abbott_side.png and abbott_front.png. Read them before painting anything.

## What depends on the model (do not break it)

- horse.gd plays clips by name: "Idle", "Walk", "Gallop", "Gallop_Jump" (_play_named, about line 1077; the list at about line 1270).
- horse.gd, abbott_look.gd and rider_mesh.gd find bones by name:
  - Head (18 uses), Back (8), Neck1 (4), Torso, Torso2, Torso3, Tail1, Tail, Jaw and Body;
  - the eight leg bones FrontUpperLeg/FrontLowerLeg/BackUpperLeg/BackLowerLeg .L/.R.
  - About 35 find_bone / BoneAttachment3D sites hang the saddle, Madison's seat, the reins and the bit on those bones.
- The scale and the ground height are tuned: the jump arc, the knock box and the camera all assume today's horse size. Bounds in Blender are X ±0.95, Y −3.47..2.23, Z −1.0..4.75 before the import scale in abbott_look.gd.

**Any new or improved model must keep the bone names above, the clip names above and the same overall size and hoof height.** Do it in Blender by renaming bones and actions, and by scaling the model. Do not touch the GDScript lookups.

## Frozen (same as Day 13)

Do not edit:
- the jump and leave math in horse.gd, the rules in game_state.gd, ride_ai.gd;
- course files, SHIP.json and michelle_ship.json;
- Engine.time_scale and physics ticks;
- the version, 2.348.0.0.

**Never overwrite an existing file under game/assets.** Each new model goes in as a new file, for example `game/assets/meshes/abbott_v2.glb`. abbott_look.gd picks the model through one constant, so going back is one line. Do not delete the old model.

## Licences

**Free:** CC0 or CC-BY only. Record each in `game/assets/meshes/ATTRIBUTION.txt` with the URL, author and licence. You cannot log in, sign up or pay for anything. Skip anything that needs an account or a payment.

## Gates

- **Quick gate, after every change to game/:**
  - compile check;
  - selftest SUMMARY fail=0;
  - the save matches.
  - For a new glb, run `--headless --import` first (one headless Godot) so the .import file exists.
- **Ride gate, when the horse model or the animation mapping changes:**
  - hk_les_001 and hk_beg_035, same flags and pass rule as Day 13;
  - T0: lesson 25.41, beginner 62.14 and jump-off 33.45;
  - same faults, same jump-off offer and result, teleported=false, time within 0.10 s.
  - The model does not drive motion, so the times should not move. If they move, something is wrong.
- **Play gate:** playtest clear 0, refuse 4, rail 4.
- **The look gate (Blender):** the same fixed camera set for every candidate, rendered with dist/day14/blender_render.py into dist/day14/renders/<candidate>/. Build side-by-side sheets against the current horse with Pillow and open them. Write a one-line verdict.
- **What the look gate cannot prove:** how the horse looks inside Godot (materials, lighting, the ride camera). That check waits for a windowed run tonight. Say so in the log, and do not claim it.

Commit on green to a new branch, `git switch -c day14-horse` from day13-polish: `Day 14 <phase>: <what changed>`. Keep `dist/DAY14_LOG.md` with a status table (phase, status, commit, gates, verdict), a Decisions section, NEEDS ERNIE and BLACKLIST. Re-read this file after every phase.

## Phases

**H0. Eyes.**
- Commit any uncommitted Day 13 leftovers on day13-polish, then branch.
- Extend blender_render.py into a fixed camera set, all with one sun at about 35 degrees, a sand-colored ground plane and a soft sky color:
  1. side at the halt;
  2. three-quarter front;
  3. head close (the Day 12 `head` angle);
  4. high rear, about where the ride camera sits;
  5. a 6-frame strip of each clip (Walk, the trot and canter once they exist, Gallop, Gallop_Jump).
- Add a `--pose <action> <frame>` argument.
- Render the current horse as the baseline. Look at it.

**H1. Quick win on today's model (same rig, so no code risk).** Make `abbott_v2.glb` in Blender from the current glb:
1. **Smooth it.** Add a Subdivision Surface modifier at level 1 above the Armature modifier and apply it, so the skin weights carry over. Then use smooth shading with an auto-smooth or weighted-normal pass, so the legs and hooves keep their edges and the barrel and neck go round. Check that every clip still deforms cleanly with no spikes or torn seams: render the strips.
2. **Paint a clean coat.** Make a new texture, `abbott_v2_coat.png` at 2K, on the model's UVs. Bake or paint it in Blender with Python:
   - solid chestnut with a subtle darker topline and lighter belly;
   - a wide white blaze that matches the photos;
   - his white socks, as they are in the game today;
   - a dark mane and tail, if the photos show that; else what the game uses now;
   - dark hooves and a dark eye.
   No photo projection. If the UVs are too broken to paint a clean blaze, paint the blaze as vertex color (the game already uses vertex color for the blaze) and say so.
3. **Export** with the same bone names, actions and scale. Point abbott_look.gd at it behind the one constant. Turn off the old photo projection only for v2.
4. **Run the gates.** In the Blender look gate, v2 should be clearly better in the side, head and rear views. Ride gate.

**H2. The missing gaits.**
- **Author two new clips in Blender on the same rig:**
  - **Trot:** two-beat diagonal pairs, a moment of suspension, the head steady.
  - **Canter:** three-beat. The outside hind, then the inside hind with the outside fore together, then the inside fore, then suspension. The head and neck nod once per stride.
- Key them from the existing Walk and Gallop poses: copy the leg bones' extreme poses and retime them. Each is one loop with matched first and last frames. Name them "Trot" and "Canter".
- Use real horse timing as the guide. A working trot is about 1.4 strides per second and a working canter about 1.6. horse.gd's playback rate already scales each clip to ground speed (Day 13 M1).
- Render 12-frame strips and check the footfall order frame by frame. Write the order you see in the log. If a clip looks wrong after 3 attempts, leave it out and log why.
- **Mapping:** only when the clips exist, change horse.gd's clip choice so trot plays "Trot" and canter plays "Canter". Keep "Gallop" as the fallback when a clip is missing, so v1 still works. That mapping is presentation, not the frozen math. Keep the blend times and _hold_to_beat behaviour, adjusted only if a clip's length differs. Run telemetry: zero_blend_switches 0, speed over animation speed 0.85 to 1.15. Ride gate and playtest.

**H3. Tack that sits on the head.**
- Model a simple bridle in Blender as part of v2, weighted to the Head and Jaw bones: a crownpiece, browband, noseband, cheekpieces and the bit rings at the corners of the mouth.
- Name the bit ring empties or bones so horse.gd's reins can find them. Read how _make_reins finds the bit today and match it, or add one small lookup with the old path as fallback.
- Render the head close-up and the high rear view. Last night's floating rods should be gone, and the reins should run to the bit.

**H4. Free models that might beat v2 (no money, ever).** Ernie will not pay for anything: no purchases, no paid tiers, no commissions. Do not list paid models.
- **Where to look:** free rigged horses that download without an account, on Poly Pizza, OpenGameArt, Quaternius, Kenney and the Smithsonian or other CC0 scan archives. CC0 or CC-BY only.
- **What to look for:** a stylized or semi-realistic look that fits the new world, 5k to 40k polygons, a skinned rig, and ideally walk, trot, canter, gallop and jump animations.
- **Test each one:** import it in Blender, render the camera set and add it to the comparison sheet against v2.
- **Wire it in only if** it clearly beats v2, and you can rename its bones and clips onto ours and scale it to our size in Blender. Then it becomes `abbott_v3.glb` behind the same constant, with the same gates.
- **Borrowing movement:** a free model with good trot or canter clips but the wrong look can still help. Retarget its clips onto our rig in Blender, if the leg chains line up.
- **Write dist/DAY14_HORSE_OPTIONS.md:** what you found (URL, licence, polygon count, bones, clips), what you tried and the verdict. If nothing free beats v2, say so plainly. Then v2 is the horse, and the remaining time goes into improving it.

**H5. The text Ernie noticed (headless).** "Hidden K note 1170." shows on the results card, and "Hidden K note 1276." on the title. A "Best 5.86s" also shows next to a 29-second lesson. Find where each comes from and write the cause in the log.
- If the "note" text is debug or generated text in a script, remove it from the player-facing line.
- If it comes from a frozen file (course JSON, michelle_ship.json or the record logic), do not edit it. Write it under NEEDS ERNIE.
- Selftest.

**When the phases are done:** improve v2 further, one change at a time with the Blender look gate. Then the mane and tail shape, the eye, the hoof shape and muscle definition through normal-map baking from a sculpted copy. Stop when a change is no longer clearly better.

## End of the session

Write a short report at the top of dist/DAY14_LOG.md:
- which model the game now uses and how to switch back (the one constant);
- the before/after sheet paths;
- the gate numbers;
- what still needs a windowed look tonight;
- what free models were tried and the verdict;
- NEEDS ERNIE.

Prepend two lines to dist/STATUS.md. Confirm that no Godot or Blender of yours is running and that the save matches.
