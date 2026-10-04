# Opus — he gets quieter

You are in `E:\Workspace\Madison`. This is a long job. Do not stop
after the first channel, and do not write `dist/STATUS.md` and quit
until both horses have been ridden, a clear has changed the picture,
and the three clocks still hold.

A day-one horse and the cert horse do not look different. Confidence
and scope change how he turns and how high he jumps, and whether he
spooks at a flower. They do not change his neck, his ears, his tail,
or her hands. The game is that he gets quieter when she rides him
well. She should see it. The cert must not.

The rein stays a straight rod. The five fences whose landings are
slower than a straight approach stay a written negative. Do not
reopen either. Do not edit `ride_ai.gd`. Do not move a fence. Do not
export. Do not launch `dist\Abbott.exe`.

## Silent

Ernie is at the machine. A Godot window locks the desktop.
`--headless` is the first argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`. No
windowed exe, no editor, no F5, no `--artshot`, no `ride_ids.py`.
One Godot. Timeouts: one id 8 minutes, a fresh id 12 minutes, a
style id 15 minutes, the full board 70 minutes. No `RIDECERT round`
in 2 minutes is a compile error: kill only that process. If the
wrapper dies for memory, wait for the ride that is already going.
Do not start a second board.

A probe is inserted once and stripped before a timed ride. Do not
leave one in the tree.

## The two horses

The cert pin, every round, in `ride_cert.gd` `_pin_stats`: confidence
85, scope 80, rideability 44, timing 38, feel 36. Do not change those
constants. Do not change `_day_one`: confidence 48, scope 40,
rideability 44, timing 38, feel 36.

`--ridecert-id=hk_les_001` rides the pin.
`--ridecert-fresh --ridecert-id=hk_les_001` rides day-one. The cert
overwrites the save at the start of the round, on purpose. A second
fresh ride is day-one again, not the schooled horse. Do not "fix"
that.

What you may not change, because it moves the clock or the refuse:

- `refuse_scale`, `turn_scale`, `scope_bonus`, `balance_need`,
  `charge_need`
- `_might_look` and its probability
- leave windows, `TAKEOFF`, `collect_pulse`, `GAIT_SPEED`,
  `STRIDE_HZ`, `land_recover` 2.72
- the jump crest, the chip, the pastern, the hoof plant, the beat
  gate, `_place_cam`
- `_school_from_round`'s numbers

The picture reads those stats. It does not write them.

A keep:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`. The pin ride prints confidence starting at 85,
not at whatever the save has. If a fresh ride leaks into the next
pin ride, that is a revert, the same leak the pin was added to stop.

## Step 0 — what the stats do now

No pose code until this is in `dist/horse_feel.md`.

From the source, one line each for confidence, scope, rideability,
timing, and feel: the function that reads it, and whether any bone
or the camera reads it. Then one headless pin `hk_les_001` and one
headless fresh `hk_les_001`. On a settled canter stride, both rides,
print:

- Neck1 angle against rest
- tail (find the bone; `Tail1` is in the skeleton, do not invent one)
- ear, or "no ear bone" if you cannot find one
- her hand travel over that stride, metres, in the withers frame
- poll height relative to the withers

If the two rides match, that is the gap. Write the numbers. A channel
you did not print is not a channel you built.

## The picture

Day-one carries his head up and his tail up. The pin horse is rounder
in the neck and quieter in the tail. Her hands at the canter move
more when feel is low and less when feel is high, and they stay on
the neck. The jump crest does not change with confidence. A spook
is the picture he already has for a refusal, and you do not make him
spook more often.

Build it in the pose, in `bascule.gd` or `horse.gd`'s visual path,
not in the physics. The hoof plant still wins: a striking hoof stays
at 0.053. Fists on a jump stay within 0.02 m of the withers. At the
canter, low feel may move them more than that, and they still come
back to the neck. Do not put the rein somewhere new.

Minimum, on a settled canter, fresh versus pin, after the change:

- Neck1 differs by at least 8°
- the tail differs by at least 8°
- hand travel over one stride differs by at least 2 cm

If there is no ear bone, say so and use the two you have. If a
channel cannot move without lifting a hoof off 0.053 or moving the
crest, that channel is a negative. The others still have to meet
the minimum.

Three clocks after this is in. They are the pin. The fresh picture
is a separate ride and does not have to hit 18.54.

## A clear changes him

`_school_from_round` already adds, on a clear with no refusal: about
+6 confidence, +3 scope, +4 rideability, +4 timing, +3 feel. Do not
change the formula.

Ride `--ridecert-fresh --ridecert-id=hk_beg_035`. Read the stats it
actually writes at the end (the result json, not a hand calculation).
Then, in one headless scene that is not the cert, set those end
stats, canter for two seconds, and print the same channels. Against
the day-one canter:

- the neck is lower
- the tail is quieter
- the hands travel less

A refusal moves the other way. You do not have to ride one if the
formula is in the source and the pose is monotone in confidence.
Print the pose at day-one, at day-one after a clear, and at day-one
after a refusal (`c -= 3.5` per refusal, and the rest of that
function). Three rows. If the clear and the refusal look the same,
the picture is not reading the stats. Fix it or write the negative.

The scene goes away when the numbers are in. It does not stay as a
second way to start a round.

## The pin is still the pin

Three clocks again. Then style:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear, B refused fence 1 with 0 rails and no jump clip, C one rail
on fence 3 in the air. The pin horse on B does not carry the day-one
head set. Fresh is not this run.

One full `python tools/content_factory/run_ridecert.py`. Render with
`python tools/content_factory/board_table.py`. The 21 within 0.1 s,
no new rail, `teleported=false`. Headless `--playtest`: clear 0 /
refuse 4 / rail 4.

If the board moves, revert the picture. The landing camera, the
pastern, and the straight rein stay.

## Write it

Top of `dist/STATUS.md`: the two canter rows (day-one and pin), the
three rows after a clear and after a refusal, and the three clocks.
Copy them from the rides, not from the formula. A horse that schools
in the save and looks the same is not this job.
