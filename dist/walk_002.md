# She walks this course

## Step 0 — what the walk says now

`hud.gd`, the walk label as built:

```
	walk_hint = _label(root, "Course walk  ·  WASD  ·  Enter to mount  ·  clock starts at the flags", 22, Vector2(48, 96), Color(0.93, 0.9, 0.82))
```

`hud.gd` `set_walk_mode`:

```
func set_walk_mode(on: bool) -> void:
	walk_hint.visible = on
	hint.text = (
		"WASD walk   Enter to mount   clock starts at the flags   Esc pause"
		if on
		else "W/S gait   A/D steer   Space half-halt (hold to collect, release to ask)   Shift halt   C walk   Esc pause"
	)
```

`arena.gd` `_enter_walk` sets the mode to "walk", stops the clock, dismounts, hands the camera to the walker, and calls `hud.set_walk_mode(true)`. **Nothing in the walk names the course.** The walk label reads "Course walk  ·  WASD  ·  Enter to mount  ·  clock starts at the flags", and the bottom hint reads the controls.

hk_les_001 `walk_text` (generator text, from `tools/content_factory/fix_unique_text.py`; nothing reads it):

> Hidden K walk twenty-two thousand seven hundred hk_les_001 twenty-seven in the outdoor ring on first hk_les_001 school for lesson. Height poles to 2'3", hk_les_001 3 fences, pattern lesson single then line, hk_les_001 side right. Fence one of walk twenty-two hk_les_001 thousand seven hundred twenty-seven is a white hk_les_001 vertical at minus one point one by hk_les_001 minus nineteen point one. Walk twenty-two thousand hk_les_001 seven hundred twenty-seven meat is a labeled hk_les_001 related. Sit after the in of walk hk_les_001 twenty-two thousand seven hundred twenty-seven. Last hk_les_001.

hk_les_001 `notes` (a sentence a person can say):

> Same three as the lesson. Walk him in. Don't chase the line.

hk_les_001 `name` / `height_label`: "Tuesday poles" / "poles to 2'3"".

The **23 ids** in `game/content/courses/SHIP.json`:

| class | id |
| --- | --- |
| lesson | hk_les_001 |
| lesson | hk_les_002 |
| lesson | hk_les_003 |
| lesson | hk_les_004 |
| beginner | hk_beg_035 |
| beginner | hk_beg_039 |
| beginner | hk_beg_004 |
| beginner | hk_beg_034 |
| beginner | hk_beg_007 |
| beginner | hk_beg_033 |
| intermediate | hk_int_001 |
| intermediate | hk_int_002 |
| intermediate | hk_int_005 |
| intermediate | hk_int_006 |
| intermediate | hk_int_007 |
| intermediate | hk_int_009 |
| advanced | hk_adv_001 |
| advanced | hk_adv_002 |
| advanced | hk_adv_003 |
| advanced | hk_adv_005 |
| jump_off/beginner | hk_jo_beg_001 |
| jump_off/intermediate | hk_jo_int_001 |
| jump_off/advanced | hk_jo_adv_001 |

## The line

One function, `ContentLibrary.walk_line(course: Dictionary) -> String`, in `content_library.gd`. It returns `"{name}. {height_label}. {notes}"`, or `""` if any of the three is missing. Nothing else is appended: no `walk_text`, no `michelle_brief`, no id, no serial.

- **`course.gd`:** `Course` keeps the ship dictionary it already loads for the round (`var loaded: Dictionary`, set in `_specs_for` from the same `ContentLibrary.ship_course(...)` call that places the fences). That is one field; no fence, start or finish changes. `course.gd` is not on the brief's list of editable files. It is named here because it is the only way to hand the walk the round's own dictionary without loading a second one.
- **`hud.gd`:** `set_walk_mode(on, line = "")`. On the walk, the top label (`walk_hint`) shows the line, or the old "Course walk  ·  WASD…" text if the line is empty (the built-in fallback course). The bottom hint keeps the controls.
- **`arena.gd`:** `_enter_walk` builds the line from `course.loaded`, passes it to the HUD, and calls `GameState.speak_soft(line)` once. `_enter_ride` is unchanged: a lesson still says `lesson_start` and does not repeat the line. A cert round starts in ride mode, and `_enter_walk` is never called.
- **Unchanged:** the course files (fences, names, height labels, notes, `walk_text`, `michelle_brief`). `fix_unique_text.py` and `make_courses_mega.py` were not run.

## All 23, through that function (headless, a throwaway script deleted after)

| id | line | check |
| --- | --- | --- |
| hk_les_001 | Tuesday poles. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line. | ok |
| hk_les_002 | Single then the line. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line. | ok |
| hk_les_003 | Right-hand two-stride. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line. | ok |
| hk_les_004 | Center line. poles to 2'3". Left-hand line. Straight and quiet. He'll tell you. | ok |
| hk_beg_035 | Welcome Stake, outside. 2'3". Welcome Stake track. School it quiet. Don't make a show of it. | ok |
| hk_beg_039 | Left-hand related. 2'3". Outside track. Find the canter and leave him alone to the first. | ok |
| hk_beg_004 | One related. 2'3". One related. Don't move on the in. Sit to the out. | ok |
| hk_beg_034 | Diagonal and home. 2'3". Outside track. Find the canter and leave him alone to the first. | ok |
| hk_beg_007 | Flower off the right. 2'3". Flower off the right. Straight. He looks if you do. | ok |
| hk_beg_033 | Crossrails, the other lead. 2'3". Long approaches. Half-halt, last stride, then ask. | ok |
| hk_int_001 | Classic, outside. 2'6". Classic. Keep the outside track. He canters this ring. | ok |
| hk_int_002 | Related and a rollback. 2'6". One rollback. Sit, turn, and wait — don't chase the leave. | ok |
| hk_int_005 | One-stride in the middle. 2'6". Ten fences. One related. Don't cut the corners. | ok |
| hk_int_006 | Diagonal Classic. 2'6". Ten fences. One related. Don't cut the corners. | ok |
| hk_int_007 | Inside rollback. 2'6". Classic. Keep the outside track. He canters this ring. | ok |
| hk_int_009 | Schooling Jumpers, home. 2'6". Classic. Keep the outside track. He canters this ring. | ok |
| hk_adv_001 | Mini Prix, related first. 3'0". Open jumpers. Eyes up. Leave with him. | ok |
| hk_adv_002 | Three-stride down the right. 3'0". Mini Prix. Keep the canter. He has the scope if you wait. | ok |
| hk_adv_003 | Rollback Mini Prix. 3'0". One-stride and home. Don't chip the in. | ok |
| hk_adv_005 | Open Jumpers, long day. 3'0". Twelve. Related early. Don't get busy after the first leave. | ok |
| hk_jo_beg_001 | Jump-off, four. 2'3". Four fences. Don't chase him. The clock is already running. | ok |
| hk_jo_int_001 | Jump-off, Classic. 2'6". Jump-off. Leave the first, then wait. Don't throw the rest away. | ok |
| hk_jo_adv_001 | Jump-off, Mini Prix. 3'0". Inside turns. Sit. He knows the way home. | ok |

`WALKLINE count=23 distinct=23`. **All 23 pass.** No line contains its id, "thousand" or "meat", and each contains its name, height_label and notes. The four lesson lines are four different strings (hk_les_001–003 share their notes sentence but not their names; hk_les_004 has its own notes). The three jump-offs say their own notes.

## The one walk boot (headless, a throwaway script deleted after)

It sets `start_session("lesson", "lesson")`, `course_seed = 0` and mode "walk", then loads the real `res://scenes/arena.tscn` (so `arena._ready → _enter_walk`) and prints on frame 30:

```
MICHELLE soft | Tuesday poles. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line.
WALKBOOT mode=walk course=hk_les_001
WALKBOOT walk_hint visible=true | Tuesday poles. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line.
WALKBOOT hint | WASD walk   Enter to mount   clock starts at the flags   Esc pause
WALKBOOT trainer_line | Tuesday poles. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line.
WALKBOOT function | Tuesday poles. poles to 2'3". Same three as the lesson. Walk him in. Don't chase the line.
```

The walk label, Michelle's line and the function's line are the same string, and the course is hk_les_001, matching its row above. The controls stay on the bottom hint. The boot script was deleted before any timed ride.


## Three clocks (the walk words in, no probe in the tree)

```
RIDECERT hk_les_001 style=clear success=true faults=0 jumped=3/3 t=18.53 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=91.0 scope=84.5
RIDECERT hk_adv_001 style=clear success=false faults=2 jumped=12/12 t=91.6 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
RIDECERT hk_adv_003 style=clear success=false faults=3 jumped=12/12 t=93.98 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=82.5
```

All inside the keep: 18.53 (0, 0), 91.60 (2, 0), 93.98 (3, 0); teleported=false, complete. The pin confidence is 91.0. The hk_les_001 cert log has no walk line in it ("Tuesday poles" appears 0 times). Its first trainer lines are the approach counts, "Two. Wait." and "One. Wait.": a cert round starts in ride mode, never enters the walk, and loads the same course.

## Style, once, `--ridecert-style --ridecert-id=hk_beg_035` (probe on the refusal only, stripped after)

```
PROBE32 refuse t=0.25 conf=85.0 gait=0 neck1=+11.72 tail1=-0.31 ear=+7.77 clip=Idle FFB=0.053/0.053 helmet=+6.89 head_x=+14.22 elbowL=129.98 elbowR=134.20 hip_x=+23.09 unrest=0.180
PROBE32 refuse t=0.80 conf=85.0 gait=0 neck1=+6.60 tail1=-0.16 ear=+6.48 clip=Idle FFB=0.053/0.053 helmet=+10.51 head_x=+6.19 elbowL=127.98 elbowR=132.06 hip_x=+17.18 unrest=0.180
RIDECERT hk_beg_035 style=refuse_early success=true faults=4 jumped=8/8 t=69.87 teleported=false complete=true refused=[1] rail_fences=[] rail_air=[] conf=83.0 scope=82.5
FENCE knock 3 by horse at 9.0,-2.5 next=3 jumping=true
RIDECERT hk_beg_035 style=rail_late success=true faults=4 jumped=8/8 t=67.17 teleported=false complete=true refused=[] rail_fences=[] rail_air=[] conf=86.5 scope=81.0
```

- **B:** refused fence 1, 0 rails, Idle, hinds 0.053 / 0.053, Neck1 +11.72, Tail1 −0.31, 69.87. Her helmet heads for the pin's halt (+10.51 at 0.80 s).
- **C:** one rail, the knock on fence 3 with `jumping=true`, in the air, 67.17.
- **Style does not enter the walk:** there is no walk line in its log.

## Board — one full `--ridecert`, `board_table.py`

`RIDECERT done pass=false board=21/23 style=true`, 26 rounds in the log (copied to scratch before the playtest). The wrapper kept `dist/ridecert_board.json`, with `GODOT_EXIT 1` because the board is not 23/23.

| id | result | faults | jumped | time_s | allowed | why |
| --- | --- | --- | --- | --- | --- | --- |
| hk_les_001 | CLEAR | 0 | 3/3 | 18.5 | — | — |
| hk_les_002 | CLEAR | 0 | 3/3 | 16.5 | — | — |
| hk_les_003 | CLEAR | 0 | 3/3 | 18.2 | — | — |
| hk_les_004 | CLEAR | 0 | 3/3 | 17.9 | — | — |
| hk_beg_035 | CLEAR | 0 | 8/8 | 67.3 | 100 | — |
| hk_beg_039 | CLEAR | 0 | 8/8 | 70.7 | 100 | — |
| hk_beg_004 | CLEAR | 0 | 8/8 | 70.3 | 100 | — |
| hk_beg_034 | CLEAR | 0 | 8/8 | 63.4 | 100 | — |
| hk_beg_007 | CLEAR | 0 | 8/8 | 65.5 | 100 | — |
| hk_beg_033 | CLEAR | 0 | 8/8 | 59.9 | 100 | — |
| hk_int_001 | CLEAR | 0 | 10/10 | 90.8 | 90 | — |
| hk_int_002 | CLEAR | 0 | 10/10 | 80.3 | 90 | — |
| hk_int_005 | CLEAR | 0 | 10/10 | 92.3 | 90 | — |
| hk_int_006 | CLEAR | 0 | 10/10 | 79.0 | 90 | — |
| hk_int_007 | CLEAR | 0 | 10/10 | 84.9 | 90 | — |
| hk_int_009 | CLEAR | 0 | 10/10 | 85.0 | 90 | — |
| hk_adv_001 | fail | 2 | 12/12 | 91.6 | 80 | 2 time faults (allowed 80 s) |
| hk_adv_002 | CLEAR | 0 | 12/12 | 83.1 | 80 | — |
| hk_adv_003 | fail | 3 | 12/12 | 94.0 | 80 | 3 time faults (allowed 80 s) |
| hk_adv_005 | CLEAR | 0 | 12/12 | 78.9 | 80 | — |
| hk_jo_beg_001 | CLEAR | 0 | 4/4 | 35.3 | 42 | — |
| hk_jo_int_001 | CLEAR | 0 | 4/4 | 36.5 | 38 | — |
| hk_jo_adv_001 | CLEAR | 0 | 4/4 | 35.8 | 34 | — |

board 21/23  pass=False
style A_clear PASS faults=0 refused=[] rails=0 t=67.3 teleported=False
style B_refuse PASS faults=4 refused=[1] rails=0 t=69.9 teleported=False
style C_rail PASS faults=4 refused=[] rails=1 t=67.2 teleported=False
teleported rounds: 0

Against the knee board, compared log to log: 25 id/style rows, faults and rails identical, 0 teleported, same 21/23. Worst |Δ| **0.04 s** (`hk_int_002`, 80.30 → 80.34). hk_int_007 is 84.93. No walk line appears anywhere in the board log. The walk words stay.

## Playtest — headless `--playtest`, this run, after the board log was copied

```
PLAYTEST begin fences=8
PLAYTEST clear faults=0 complete=true
PLAYTEST refuse faults=4
PLAYTEST rail faults=4
PLAYTEST done pass=true
```
