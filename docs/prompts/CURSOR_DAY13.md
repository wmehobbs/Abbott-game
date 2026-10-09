# Cursor, Day 13 overnight: polish Abbott until someone wants to play it (Ernie is asleep, windows allowed)

You are Cursor in E:\Workspace\Madison. The Godot 4.7.2 project is game/. Ernie has gone to bed and will not answer. Work all night at full speed. Verify each change, commit it, update the log, and start the next item in the same turn. Do not stop to ask questions. Do not end your turn while it is before MORNING. There is always a next item: if the task list runs out, the endless loop at the bottom never does.

ASSETS: ALLOWED
(If Ernie deleted or changed the line above, new third-party files are not allowed tonight. Skip every step marked [ASSET] and log it.)

MORNING = 07:00 local. Check Get-Date at the start of every item.

## Why, and what is wrong

Ernie is making this game for his daughter Madison, who rides her horse Abbott at Hidden K Stables. The rules, the leave mechanic, the classes, saves, menus, gamepad and audio buses are done (Day 12, read dist/DAY12_LOG.md). It is still not a game a stranger would choose to play. Claude reviewed the Day 12 final stills (dist/day12/shots/final_jpg/) and the telemetry. This is the honest list, worst first:

1. **The world reads as a placeholder.** The trees are tan discs stacked on black poles ("lollipops"). There are also dozens of tall thin light poles and pole-trees, so the skyline is a forest of sticks. The ring is a big empty sand rectangle with a rail around it: no judge's box, no stands, no people, no planters, no banners, no scoreboard. The sky is a flat pink haze that washes out all contrast.
2. **Abbott and Madison look rough up close.** The horse is the Quaternius low-poly mesh, flat-shaded with a photo coat smeared across big facets. The bridle is black rods floating off the face. Madison's lower legs stick straight out sideways instead of hanging down the horse's sides. From the ride camera she looks like a doll set on top.
3. **The camera and motion are not smooth.** Telemetry for hk_les_001: canter speed over animation speed is **2.94**, trot 0.90, walk 0.075. At the canter the legs cycle far slower than the ground moves, so he skates. The camera jerk p95 is 287,534 and there are 14 pops (Day 12 says the pops are the first half second). horse.gd moves the body in _physics_process and places the camera in _process. Check whether _place_cam reads global_transform (the raw physics tick, which steps) instead of get_global_transform_interpolated(). If it reads the raw tick, that is a judder source on any screen faster than 60 Hz.
4. **The controls are hard to learn and give no feedback.** The whole game is "hold Space, release at the right moment." Nothing on screen shows whether you are early, late or right, or why a fence went wrong. A big gray card of control text covers the horse at the start. The scoreboard type is small and gray. The footer hint is tiny gray text on sand.
5. **There is no juice.** Takeoff, landing, a clear round, a rail down and a refusal all feel about the same. There is no landing weight, no rumble, no sound layering, no screen transitions and no celebration for a clear.
6. **The title is a real photo of Abbott, and the game is low-poly.** The mismatch makes the 3D look worse when you click Lesson. Keep the photo, because it is Madison's horse, but the first 3D frame has to hold up.

Performance is not the problem. GPU p95 is about 2.9 ms on High. There is a lot of headroom for better visuals: spend up to 6.0 ms GPU p95 on High, measured the Day 12 way.

**The goal for tonight:** a stranger picks up a controller, understands the first lesson in 60 seconds, feels the horse respond, feels each jump land, and thinks the place looks pretty.

## Rule 1: running Godot

Godot, console build:
C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe

- Ernie is asleep. Game windows are allowed until MORNING minus 60 minutes, through dist/day12/run_shots.py (stills and perf) and any new windowed wrapper you write in dist/day13/ on the same pattern: timeout, `--audio-driver Dummy`, the game quits itself, the mouse is never captured. After 06:00, headless only. No Godot may be running at 07:00.
- Tests, playtest and ride cert stay headless through the existing wrappers. docs/ARCHITECTURE.md, under "How to run the checks", is the reference. Read it first.
- **One Godot at a time.** Before every launch, run Get-Process *Godot* -ErrorAction SilentlyContinue. Two old seat-probe Godots (PIDs 114976 and 115652, from 2026-10-04) may still be there. Leave them alone; they do not count. If any other Godot you did not start is running, wait. Never kill a Godot you did not start. Never run tools/content_factory/ride_ids.py. On a timeout, kill only your own PID.
- Never: the editor GUI (for new files, use `--headless --import`), exporting, any .exe in dist, a version bump (it stays 2.348.0.0), PowerShell `>` on Godot output, or a Windows setting.
- If a capture comes back black or identical to the previous one, log it, stop windowed runs for the night, and carry on with headless work.
- Do file work with small Python scripts in dist/day13/. Pillow is installed.

## Rule 2: protect Madison's save

The save is C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json. Its snapshot is dist/day12/save_snapshot.json. Before the first run, check that the two still match; if they do not, copy the live save to dist/day13/save_snapshot.json and use that copy. After every Godot run, compare the save byte for byte. If it changed, restore it at once and fix the cause before anything else. Every new mode gets the save() guard. Never commit a snapshot.

## Rule 3: what is frozen (unchanged from Day 12, plus three)

Do not edit:
- **The leave and jump math in horse.gd:**
  - TAKEOFF 2.55;
  - the early, deep, chip and ideal bands;
  - window_scale, refuse_scale and balance_need;
  - GAIT_SPEED, GAIT_ACCEL, GAIT_DECEL and GAIT_TURN;
  - the 3.35 stride divisor;
  - _try_leave;
  - the jump arc and timing in _process_jump;
  - the knock box (width\*0.9, height+0.15, 0.35+spread);
  - the collect and sit speed multipliers in _process_ride.
- **The rules in game_state.gd:**
  - Table A, time allowed, time_show and can_offer_jump_off;
  - _ribbon, _school_from_round and _record_round;
  - the unlock rules and note_refuse;
  - the confidence, scope, rideability and timing math.
- **These files and archives:**
  - ride_ai.gd;
  - course JSON in both trees, SHIP.json and michelle_ship.json;
  - content/ archives;
  - every existing file under game/assets (add new files beside them, never overwrite);
  - dist/Abbott\*.exe;
  - earlier dist/DAY\* files.
- **New tonight:**
  - Engine.time_scale (no hit-stop or slow motion that changes the clock);
  - physics ticks per second;
  - the fence positions and sizes the knock box reads.

Any change to how the horse moves must leave the ride gate inside 0.10 s. Presentation is free: animation playback speed, camera, HUD, sound, particles, rumble, materials, the world.

Free to change through the visual loop:
- farm.gd, mesh_kit.gd, fence.gd visuals, arena.gd dressing, person_look.gd, rider_mesh.gd and abbott_look.gd;
- the environment, lighting, shaders, hud.gd, title.gd and settings;
- the camera in horse.gd (_place_cam, _fov_base);
- the human-only steering ramp in _process_ride (the branch where _at_ai_reins() is false). The AI ramp stays 4.0, so the certs cannot move.

[ASSET] New third-party files are allowed tonight only under these terms:
- **Licence:** CC0 only, from Poly Haven (polyhaven.com: HDRIs, textures, models), Kenney (kenney.nl), Quaternius (quaternius.com) or ambientCG. Nothing else.
- **Where:**
  - put them under game/assets/cc0/<source>/;
  - add a line to game/assets/cc0/ATTRIBUTION.txt with the URL and licence;
  - keep textures at 2K or smaller;
  - add at most 150 MB in total tonight.
- **What they are for:** trees, bushes, grass clumps, flowers, an HDRI sky, arena dressing (stands, judge's box, planters, banners, benches, a scoreboard, jump-wing props) and ground and wood textures.
- **Not for:** replacing Abbott's horse mesh or Madison's rider mesh. Write any idea about those under NEEDS ERNIE.
- **How to get them:** download with a Python script in dist/day13/. Game code makes no network calls.

Player-facing text: short plain sentences, American English, no em dashes. Michelle's lines stay one sentence of 14 words or fewer.

## The visual loop (every visible change)

1. Pick the item. In dist/day13/backlog.csv, write one sentence on what "better" will look like.
2. Change it.
3. Capture the same shots (`run_shots.py --shots-out=dist/day12/shots/d13_<item>`). If a shot you need is missing, add it to the STILLS table and recapture a baseline first.
4. Build the before/after sheet with make_sheet.py and **open it and look**. Judge it as a player would, at the ride camera first. Write the verdict: better, same or worse, and why.
5. Better, and GPU p95 at or under 6.0 ms: gates, then commit. Same or worse: revert. At most 3 attempts per item; then close it with a note.
6. Look at the whole contact sheet at least once an hour. Many small "better" steps can add up to an incoherent look. Keep one palette: warm late-afternoon light, greens and creams, the Hidden K red.

The motion loop (camera, animation, feel) is the same, but judged with numbers as well as eyes:
- **The numbers:** extend --telemetry (dist/day12/telemetry_\*) and compare the summary CSVs before and after. Targets:
  - canter, trot and walk speed over animation speed each between 0.85 and 1.15;
  - camera pops after the first 0.5 s: 0;
  - camera jerk p95 at least 50 percent lower than baseline;
  - zero_blend_switches 0.
- **The eyes:** for motion, capture the 8-frame jump strip and a 12-frame canter strip (add one) so you can see whether the legs skate.

## Gates (as on Day 12)

- **Quick gate, every item:**
  - compile check: `python dist/day12/run_script.py res://tools/compile_check.gd <log>`;
  - selftest SUMMARY fail=0 (`python dist/_run_userarg.py --selftest`);
  - Madison's save matches;
  - no Godot of yours left running.
- **Play gate**, for anything that runs during a round: `python dist/_run_userarg.py --playtest` still reports clear 0, refuse 4, rail 4.
- **Ride gate**, for horse.gd, bascule.gd, the camera, input, the animation or the display:
  - run hk_les_001 and hk_beg_035, with `python tools/content_factory/run_ridecert.py --ridecert-fresh --ridecert-show --ridecert-jumpoff --ridecert-id <id>`;
  - copy dist/ridecert_fresh.log to dist/day13/<id>.<item>.log before the next id;
  - pass means the same faults, the same jump-off offer and result, teleported=false, and the time within 0.10 s of T0;
  - T0 on this tree: lesson 0 faults 25.42, no offer; beginner 0 faults 62.14, offer yes, jump-off 0 faults 33.45; hk_int_002 74.73, jump-off 40.87. Re-measure them in T0.
- Every new feature adds a selftest.

Commit only on green: `git commit -m "Day 13 <item>: <what changed>"`. Include dist/DAY13_LOG.md, the backlog and the dist/day13 scripts. Do not commit images or snapshots; add dist/day13/shots and the snapshot to .git/info/exclude.

If an item fails its gates twice or runs past 75 minutes, stash it (`git stash push -u -m "day13 <item>" -- game docs`), mark it STASHED with the reason, and move on.

## Keeping your place

After every item, update the table in dist/DAY13_LOG.md (item, status, commit, gates, GPU p95, verdict). Then re-read this file. If your context is summarized, this file, the log and the backlog are the truth. Decide small questions yourself and write the decision down. Anything that touches the frozen list, a deletion, the save, Abbott's or Madison's mesh, or the version goes under NEEDS ERNIE, and you move on.

At 05:45, start nothing new. Finish or stash the current item, then do the morning wrap.

## Tasks, in order

**M0. Baseline.**
- git status. Commit the uncommitted Day 12 dist logs and traces on day12-overnight as "Day 12 leftovers". Do not commit the .uid files unless the compile check needs them. Then `git switch -c day13-polish`.
- Re-measure the gates and the three rides into dist/DAY13_LOG.md as T0.
- Capture a full shot set to dist/day12/shots/d13_baseline and run telemetry on hk_les_001.
- Open the contact sheet. Write dist/day13/backlog.csv: rank, area (feel, ui, world, characters, juice, audio), shot, problem, cause (file:function), fix idea, status, attempts, verdict. Seed it from the six problems above, then add everything else you see, ranked by what a player sees most.

**M1. Smooth motion (feel first, it matters most).**
1. **Camera judder.** In _place_cam and anything that follows the horse in _process, read get_global_transform_interpolated() instead of global_transform / global_position. Check walker.gd and the walk camera too. Telemetry: jerk and pops must drop. Ride gate.
2. **Foot skate.** Scale animation playback so the leg cycle matches ground speed at every gait (anim_speed from speed / the clip's native speed, clamped, smoothed). Blend between gaits by speed so a trot-to-canter change does not snap. Target 0.85 to 1.15 at all gaits. Look at the 12-frame canter strip: hooves should plant, not slide. The ride gate must stay inside 0.10 s; animation must not feed back into motion.
3. **The ride camera.**
   - At the canter, a small vertical bob in phase with the stride, and a lean into turns (horizon roll up to 3 degrees);
   - On landing, a dip and recover (the _cam_land_h path exists; tune it so you feel it);
   - Collecting already narrows the FOV. Make the release-to-leave moment read with a short FOV push and a lift;
   - Add Options sliders for camera shake / motion (0 to 100 percent, default 70) so nobody gets sick;
   - Tune by eye with strips and by telemetry. No pops.
4. **Steering (human only).** Shorten the turn ramp so A/D feels like a horse answering rather than a boat: try 4.0 / 3.0. Add a small extra turn at the walk and trot. Make the stick analog with a response curve and keep the 0.25 deadzone. Buffer a gait tap pressed during a jump or landing and apply it on landing. Playtest plus ride gate, which proves the AI path is untouched.

**M2. Teach and tell (playability).**
1. **Leave feedback.** On release, show a short grade at the horse ("Long spot", "Right on", "Deep", "Chip") from the band _try_leave already computes. Read its result only; do not change it. Color-code it, fade it in about 1 s, and let Michelle's existing line follow.
2. **Riding aid**, an option, default ON for lessons and the first lesson, OFF for shows:
   - three stride dots on the ground in front of the next fence, lighting up as he covers each stride (count from the existing stride divisor, read-only);
   - while Space is held at the canter, a ring around the takeoff spot that turns green inside the ideal band.
   This is a visual only, no logic change. Playtest plus selftest.
3. **HUD pass.**
   - The control card fades out after the first move or 6 seconds, and Esc or Pause shows it again.
   - Scoreboard: bigger type and higher contrast, a fence counter with pips, and a clock that turns amber in the last 10 s of time allowed.
   - The footer hint sits on a soft dark band or goes after the first lesson.
   - Device-aware prompts (Day 12 T8) on every hint.
   - Check all six screen sizes (selftest layout).
4. **Results screen.**
   - Animate the time and faults counting up, then the ribbon.
   - For a clear: a short ribbon card, confetti in the ring and Michelle's line.
   - For a rail: name the fence and show a replay-style still of that fence (a camera snap at the knock is fine).
   - Buttons: Retry, Next, Walk the course, Menu.
5. **Transitions.** A 0.3 s fade between scenes and on retry, and a short "Fence 1" or course name card at the start.

**M3. The world (look).** One item at a time, with the visual loop:
1. **Sky and light.**
   - [ASSET] A CC0 late-afternoon HDRI from Poly Haven as the sky and ambient light; else retune the procedural sky.
   - Less haze. A warm sun around 35 degrees, so the shadows are long but the horse reads.
   - Tonemap filmic or AgX, then small contrast and saturation lifts. Day 12 tried ACES and warm fog and reverted both; start from AgX and judge the ride camera.
2. **Trees and skyline.**
   - [ASSET] Replace the disc-on-pole trees with CC0 low-poly trees (Quaternius or Kenney nature packs) in 3 to 5 varieties, randomly scaled and rotated, with a few MultiMesh bushes.
   - Cut the light poles to a handful at the ring corners.
   - The skyline should be tree masses and a far hill line, not sticks.
3. **The ground.**
   - Arena sand with hoof-print decals or darker track lines along the usual tracks, and a little roughness variation.
   - Outside the ring, grass with color variation and clumps (MultiMesh, distance-faded).
   - Remove the dark band between sand and rail, or make it a kickboard.
4. **Arena dressing**, so it feels like a show:
   - a judge's box or announcer stand;
   - two small bleachers with a few simple standing figures (person_look.gd already makes people, so reuse it);
   - flower planters at fence wings;
   - a Hidden K banner on the rail and a scoreboard sign at the in-gate.
   - Keep it outside the ride corridors; nothing inside the rail that the horse could hit.
5. **Fences.**
   - Wood and paint materials with roughness, and rail stripes in colors.
   - The yellow wing panel gets a cloth or wood texture. The ground lines (the yellow boards) get less saturated.
   - Fence numbers sit on small boards.
   - The current fence gets a subtle highlight ring on the ground (only with the riding aid).
6. **Post.**
   - SSAO, already on, tuned so the horse sits on the ground.
   - Subtle glow on bright sky only.
   - TAA or FSR2 at quality, judged against MSAA on the thin rails. Pick what is sharpest without shimmer; low settings keep a cheap path.
   - Sharpening if it helps.
   - GPU p95 must stay at or under 6.0 ms on High. Time Low as well.

**M4. Abbott and Madison (bug-level fixes only, no new meshes).**
1. **Abbott's shading.** Try smooth normals on the horse at runtime (SurfaceTool generate_normals, or a normal-smoothing pass in abbott_look.gd, not in the glb). Try a coat material with roughness, a slight sheen and a soft rim light, so he reads as a horse instead of folded paper. Judge halt_side, play_cam and head. If smoothing smears the photo coat worse, a clean solid chestnut with his white blaze and socks, done as a mask, beats a smeared photo. Day 12 said not to repaint the blaze, so keep its shape and position.
2. **The bridle.** Parent the tack to the head bone so it follows the face. The rods meet at the bit and the reins run from the bit to her hands. If that cannot be done in 3 attempts, hide the floating parts rather than show them broken.
3. **Madison's legs.** madison_casual.glb is rigged. In the riding pose, rotate the hip and knee bones so the thighs lie on the saddle and the lower legs hang down his sides, with heels under hips. Day 12 called this a rig problem. It is a bone-pose problem; try it through the skeleton, in rider_mesh.gd only. Keep the existing rider picture channels (the nods, shoulder, fold, sit, the knee shin shares); add to the base pose. Judge the ride camera, seat_side and halt_rear. Ride gate, which is unaffected by visuals but cheap to prove.

**M5. Juice and sound.**
- **Landing:** a hoof thud layered with a little sand spray (particles) and a camera dip (M1). Controller rumble: a short pulse on landing and a strong short buzz on a rail. Options get a rumble on/off toggle.
- **Rail down:** a wood clunk with the rail rolling, the scoreboard faults count bumping red, and Michelle's line.
- **Refusal:** a horse snort, the camera nudging back, and the HUD shaking 4 px.
- **Clear round:** a crowd applause clip (CC0, [ASSET] from Kenney or freesound CC0 only), the confetti from M2, and a ribbon sting.
- **Hooves:** footfalls timed to the animation's foot plant (after M1 #2) rather than a loop, with a small pitch and volume variation, and a soft breath at the canter.
- **Ambience:** birds, distant wind, and a crowd murmur only on show day.
- **Mix:** keep the Day 12 buses and duck. Write in the log what Ernie should listen for.

**M6. First minute.**
- Play the first lesson as a new player (fresh test save under user://selftest/, shots mode or a scripted walk-through).
- Each step has one instruction, the riding aid on and a celebration when done.
- Nothing on screen the player has not been taught yet.
- From the title, the first lesson must be reachable in 1 press for a new save.
- Capture the first-lesson shots and judge them.

**Endless loop (after M6, or whenever stuck):**
- capture the full set;
- open the contact sheet;
- pick the single worst-looking or worst-feeling thing a player sees in the first 2 minutes;
- add it to the backlog;
- fix it with the loop;
- repeat.

Prefer the ride camera, the first lesson and the title over the barn and the house.

## Morning wrap (05:45 to 06:45)

- Final full shot set to d13_final. Make make_sheet.py pairs of d13_baseline against d13_final for the ride camera, takeoff, landing, halt_side, title, results and the HUD.
- Final gates: the three rides, playtest, selftest and save match. Record them in the log.
- Top of dist/DAY13_LOG.md, a morning report in plain words:
  - what a player will notice, in order of impact;
  - the before/after sheet paths;
  - the gate numbers;
  - GPU p95 on High and Low;
  - what to play first and what to listen for;
  - NEEDS ERNIE;
  - STASHED.
- Prepend a short entry to dist/STATUS.md that points to it.
- Confirm no Godot of yours is running, and that the save matches the snapshot.
