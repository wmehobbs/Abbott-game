# Abbott — Boutique Riding School

Date: 2026-09-11  
Status: approved to build (Madison first; other horses/kids later)

## Product

A short, crafted jumping school at Hidden K Stables, Pfafftown. You play Madison. You ride Abbott. The game is seeing a distance and leaving the ground with him.

Other horses and other kids are deferred. One barn only.

Comparable craft: *A Short Hike* — one place, done well. Not a career sim.

## Player loop

1. **Lesson** — trainer on the rail. Poles to a single fence to a related line. Takeoff marks visible. After each leave: one true sentence.
2. **Schooling** — 2'3" / 2'6" / 3'0" course. No ribbon. Abbott remembers the ride.
3. **Show day** — Welcome Stake, Classic, Hidden K Mini Prix. Table A. Jump-off if clear inside the time.

## Ride

- W/S gait ladder. A/D steer. Shift halt. Space = half-halt (hold to collect, release to ask).
- No charge bar. Teaching stripes only in the lesson.
- Canter stride is the clock (~3.35 m). Takeoff spot ~2.55 m from the base.
- Early ask → refusal. Deep / chip → rail. Straight + last stride + ask → clean.
- Crooked to a looky fence (flower, low confidence) → he can stop.
- Abbott's confidence / scope / rideability change slowly from how she rode. She should feel them, not read a stat screen.

## Rules

**Schooling and lesson:** 4 faults per rail or stop. No elimination. Clock starts at the flags. Fences in order. Wrong fence is a warning, not a score.

**Show (Table A):**

- Rail: 4
- First disobedience: 4
- Second: 8
- Third: elimination
- Off course (leave over the wrong number): elimination
- Time faults: 1 per 4 seconds over the time allowed
- Time limit: 2× allowed → elimination
- Clock starts at the start flags, not on mount
- Finish only if every fence was jumped in order
- Clear and inside the time → optional jump-off (4 fences, tighter time)

## Tonight vs later

**Shipped in this pass:** truthful rounds, stride-based leave, trainer lines, lesson track, HUD without a charge bar, playtest for clear / refuse / rail. Hidden K farm rebuild (100×250 ring, white boards, 10×40 mirrors, pines, barn, house, indoor). White hunter standards. Hunt-seat rider. Windows build at `dist/Abbott.exe`.

**Later:** photo-real materials and a real rider mesh. Other horses and kids in the aisle and the class. Then a skill ladder that matches the barn: lesson → schooling show → Pony Club → college teams (WFU / Salem) → open / championship heights. Olympic is the far end of that ladder, not v1.

## Tech

Stay on Godot 4.7 + Jolt. Do not rewrite the engine, the Abbott mesh, or the audio bed.
