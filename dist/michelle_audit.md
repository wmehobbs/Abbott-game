# Michelle ship — keys that name the thing

File `game\content\rail\michelle_ship.json` is 5525 lines, 336 speech rows. Prompt said 336 lines; this is the file on disk.

| key | lines | weak |
| --- | ---: | ---: |
| early | 16 | 8 |
| deep | 16 | 6 |
| chip | 16 | 7 |
| spot | 16 | 12 |
| leave | 16 | 1 |
| straight | 16 | 1 |
| looked | 16 | 4 |
| wrong | 16 | 10 |
| halt | 16 | 0 |

## Weak ids — stem miss

A stem miss is not the same as a sentence that fails to name the event. The judgment list below is the one the day uses. Stem miss means the sentence does not contain the stem for that key.

- `early_04` (early, 5 words): Wait. He wasn't there yet.
- `early_06` (early, 5 words): Hold. Last stride, then leave.
- `early_08` (early, 7 words): Sit quiet. Let the last one come.
- `early_09` (early, 6 words): You jumped first. He wasn't ready.
- `early_11` (early, 5 words): Wait for him. Then ask.
- `early_13` (early, 6 words): Don't launch. The stride is later.
- `early_14` (early, 6 words): You left before the canter finished.
- `early_15` (early, 5 words): Half-halt, wait, then the leave.
- `deep_03` (deep, 8 words): You got there late. Ride the last one.
- `deep_07` (deep, 6 words): You waited too long. Ask sooner.
- `deep_10` (deep, 7 words): Late to the spot. Make the stride.
- `deep_11` (deep, 8 words): Don't bury him. Leave on the last one.
- `deep_14` (deep, 5 words): Make the last canter stride.
- `deep_16` (deep, 7 words): He left from the bottom. Ride up.
- `chip_05` (chip, 9 words): He put in a short one. Ride the canter.
- `chip_07` (chip, 6 words): Half stride. That's how rails happen.
- `chip_08` (chip, 5 words): Don't pick. Leave or wait.
- `chip_10` (chip, 7 words): Short stride in front. Don't do that.
- `chip_12` (chip, 7 words): You got there on a half. Don't.
- `chip_13` (chip, 7 words): He added a short one. Ride forward.
- `chip_15` (chip, 7 words): Don't squeeze a stride that isn't there.
- `spot_02` (spot, 4 words): Yes. That's the leave.
- `spot_04` (spot, 6 words): You saw it. Leave like that.
- `spot_05` (spot, 6 words): That's the one. Don't fuss after.
- `spot_06` (spot, 5 words): Right stride. Pat him later.
- `spot_07` (spot, 4 words): That leave was true.
- `spot_08` (spot, 6 words): You waited, then asked. That's it.
- `spot_10` (spot, 5 words): That's the distance. Keep it.
- `spot_11` (spot, 5 words): Quiet leave. That's the one.
- `spot_12` (spot, 7 words): You found it. Don't chase the next.
- `spot_13` (spot, 6 words): Good. Last stride, then the ask.
- `spot_14` (spot, 6 words): That's seeing it. Do it again.
- `spot_15` (spot, 6 words): True leave. He jumped with you.
- `leave_03` (leave, 7 words): Don't wait once the stride is there.
- `straight_15` (straight, 6 words): Eyes up. Middle of the poles.
- `looked_04` (looked, 6 words): He saw it. You stay straight.
- `looked_07` (looked, 7 words): He noticed the box. You ignore it.
- `looked_10` (looked, 6 words): Keep your eyes up. He'll follow.
- `looked_13` (looked, 6 words): He peeked. Leg on, eyes up.
- `wrong_01` (wrong, 5 words): That's not the next fence.
- `wrong_03` (wrong, 7 words): Not that one. Look at the numbers.
- `wrong_04` (wrong, 6 words): Off the track. That's not next.
- `wrong_06` (wrong, 6 words): That's not the order. Come again.
- `wrong_08` (wrong, 7 words): Not next. Eyes up, find the number.
- `wrong_09` (wrong, 6 words): That's a different fence. Come back.
- `wrong_11` (wrong, 7 words): Not the line. Find the next number.
- `wrong_13` (wrong, 7 words): That's not it. Walk, then find one.
- `wrong_15` (wrong, 6 words): Check the numbers. That wasn't next.
- `wrong_16` (wrong, 6 words): Come back. That's not the track.

## Chip lines that say hold then release

None.

## Judgment — lines that do not name the event

A line names the event when a rider can tell what just happened: early or too soon, deep or late, a chip or a half stride, the spot or the distance, a look, the wrong fence. Stem-miss lines that still say that are not weak.

- `early_06` Hold. Last stride, then leave.
- `early_08` Sit quiet. Let the last one come.
- `early_11` Wait for him. Then ask.
- `early_15` Half-halt, wait, then the leave.
- `deep_14` Make the last canter stride.
- `chip_08` Don't pick. Leave or wait.
- `chip_15` Don't squeeze a stride that isn't there.
- `spot_05` That's the one. Don't fuss after.
- `spot_12` You found it. Don't chase the next.
- `leave_03` Don't wait once the stride is there.
- `looked_10` Keep your eyes up. He'll follow.

No line was replaced. None of these is false, and the ship file has no second sentence that names the event more clearly without adding words. Chip lines do not say to hold and then release. `early_06` and `early_15` say hold, then leave. That is an early line, not a chip line.

## Other keys in the file (not audited)

- clear: 16
- jump_off: 16
- lesson_start: 16
- off_course: 16
- pat: 16
- rail: 16
- refuse: 16
- ribbon: 16
- steady: 16
- three: 16
- time: 16
- walk_out: 16
