# Day measure — Abbott 2.348.0.0

Numbers below are from this morning's run, not from the prompt.

## Baseline board

Command: `python tools/content_factory/run_ridecert.py`

Log: `dist/ridecert_godot.log`. Saved copy: `dist/day_baseline_board.json`.

`RIDECERT done pass=false board=21/23 style=true`. Teleported rounds: 0. Godot exit 1 because two courses lost on time, not because the ride crashed.

| id | result | faults | jumped | time_s | allowed | why |
| --- | --- | --- | --- | --- | --- | --- |
| hk_les_001 | CLEAR | 0 | 3/3 | 18.53 | — | — |
| hk_les_002 | CLEAR | 0 | 3/3 | 16.53 | — | — |
| hk_les_003 | CLEAR | 0 | 3/3 | 18.21 | — | — |
| hk_les_004 | CLEAR | 0 | 3/3 | 17.95 | — | — |
| hk_beg_035 | CLEAR | 0 | 8/8 | 67.29 | 100 | — |
| hk_beg_039 | CLEAR | 0 | 8/8 | 70.74 | 100 | — |
| hk_beg_004 | CLEAR | 0 | 8/8 | 70.31 | 100 | — |
| hk_beg_034 | CLEAR | 0 | 8/8 | 63.44 | 100 | — |
| hk_beg_007 | CLEAR | 0 | 8/8 | 65.53 | 100 | — |
| hk_beg_033 | CLEAR | 0 | 8/8 | 59.87 | 100 | — |
| hk_int_001 | CLEAR | 0 | 10/10 | 90.84 | 90 | — |
| hk_int_002 | CLEAR | 0 | 10/10 | 80.30 | 90 | — |
| hk_int_005 | CLEAR | 0 | 10/10 | 92.27 | 90 | — |
| hk_int_006 | CLEAR | 0 | 10/10 | 79.03 | 90 | — |
| hk_int_007 | CLEAR | 0 | 10/10 | 84.94 | 90 | — |
| hk_int_009 | CLEAR | 0 | 10/10 | 85.00 | 90 | — |
| hk_adv_001 | fail | 2 | 12/12 | 91.61 | 80 | 2 time faults, 0 rails |
| hk_adv_002 | CLEAR | 0 | 12/12 | 83.13 | 80 | — |
| hk_adv_003 | fail | 3 | 12/12 | 94.01 | 80 | 3 time faults, 0 rails |
| hk_adv_005 | CLEAR | 0 | 12/12 | 78.93 | 80 | — |
| hk_jo_beg_001 | CLEAR | 0 | 4/4 | 35.32 | 42 | — |
| hk_jo_int_001 | CLEAR | 0 | 4/4 | 36.50 | 38 | — |
| hk_jo_adv_001 | CLEAR | 0 | 4/4 | 35.81 | 34 | — |

Style on the beginner clear round: clear 0 faults, refuse 4, rail 4. No teleports.

`hk_beg_033` is on the ship list. It is the shortest beginner clear at 59.87 s.

## Coaching hole

Confirmed, then changed. Before the edit, `game/scripts/horse.gd` `_lesson_count` returned immediately unless `session_kind == "lesson"` (and unless canter, and unless already jumping). That was the old line 533. Schooling and show never got Two / One.

The hear line is now: lesson always, schooling and show only while `madison_timing < 55`. The divisor is still 3.35. The words are still Wait, Early, Now, Too deep. `speak_soft` still drops a line when `trainer_until > 1.4` and `last_leave` is set, and the print is after that return, so a swallowed line is not in the log.

## Stride ledger

See `dist/stride_ledger.md`. Every labeled related's ground/strides is outside 3.05–3.45 m, because a related distance includes the jump. Medians: 1 stride 7.45 m, 2 strides 10.80 m, 3 strides 15.06 m. The step from 1 to 2 is 3.350 m. The step from 2 to 3 is 4.260 m. That band is the question, not a license to move a fence.

## Slow Mini Prix segments

From this run's log. Both failures jumped 12/12 with 0 rails.

`hk_adv_001` 91.61 s. Come-again on fences 7 and 9. Slow pieces: 7→8 12.38 s, 9→10 12.81 s.

`hk_adv_003` 94.01 s. Come-again on fences 6 and 10. Slow pieces: 6→7 11.80 s, 10→11 12.58 s.

`hk_adv_002` and `hk_adv_005` cleared (83.13 s and 78.93 s). They are not candidates.

## Canter stride

Command: Godot console `--headless --path E:\Workspace\Madison\game -- --stride`. Log `dist/stride_day.log`.

Straight canter on the sand, lane x=−1.0, clearance 5.72 m, 8 seconds after no warmup (speed was already 5.55).

| quantity | value |
| --- | ---: |
| speed mean / min / max | 5.550 / 5.550 / 5.550 m/s |
| footfalls | 42 |
| complete stride cycles | 13 |
| exact cycles (wraps plus the partial) | 13.680 |
| distance | 44.400 m |
| meters, distance / complete cycles | 3.415 |
| meters, distance / exact cycles | 3.246 |
| meters, distance / (footfalls/3) | 3.171 |
| 3.246 − 3.35 | −0.104 |

13.680 cycles in 8.000 s is 1.710 Hz, the canter `STRIDE_HZ`. The footfall quotient is one beat high (42 versus 41.0), so it shortens the stride. The stride the horse covers is 3.246 m. That is 0.104 m off the spoken 3.35, inside the 0.15 m gate. The divisor in `_lesson_count` stays 3.35. `horse.gd` was not edited.

## Leave sweep

Command: `--headless --leave-sweep`. Log `dist/leave_sweep_day.log`. 106 releases. Charge set to 0.05, which is under `balance_need` 0.101. Lesson fence is `hk_les_001` fence 1, a vertical. Beginner fence is `hk_beg_033` fence 1, a vertical, session schooling.

Ideal is `|ahead − 2.55| ≤ 0.55·window_scale`. Early is `ahead > 2.55 + 1.05·window_scale`. Late is `ahead < 2.55 − 0.80·window_scale`. Ask outside 0.50–5.4 does not register.

| class | window | Now from | Now to | Now width |
| --- | ---: | ---: | ---: | ---: |
| lesson | 1.24 | 1.87 m | 3.23 m | 1.36 m |
| beginner | 1.16 | 1.91 m | 3.19 m | 1.28 m |
| intermediate | 1.00 | 2.00 m | 3.10 m | 1.10 m |
| advanced | 0.88 | 2.07 m | 3.03 m | 0.97 m |

Now gets narrower at 3'0". That is the window scale, and it was not retuned.

Lesson, charge 0.05:

| ahead | key | rail |
| --- | --- | --- |
| 0.4 | rail (body in the box; the ask itself does not register under 0.50) | no |
| 0.5–1.5 | deep | yes |
| 1.6–1.8 | chip | yes |
| 1.9–3.2 | spot | no |
| 3.3–3.8 | chip | yes |
| 3.9–5.4 | early | refusal |
| 5.5–5.6 | none | no |

The ideal band on the lesson fence, with charge below `balance_need`, is spot and no rail. It does not take the chip path. Chip is the shoulder on either side of Now. Phase 3 does not apply. No Michelle line was reordered.

## Day-one rides

`--ridecert-fresh` uses confidence 48, scope 40, rideability 44, timing 38, feel 36. Logs: `dist/fresh_hk_les_001.log`, `dist/fresh_hk_beg_033.log`.

| id | faults | time_s | rails | teleported | looked | pinned time |
| --- | ---: | ---: | ---: | --- | --- | ---: |
| hk_les_001 | 0 | 18.53 | 0 | false | no | 18.53 |
| hk_beg_033 | 0 | 59.87 | 0 | false | no | 59.87 |

Both cleared 3/3 and 8/8. Times match the pinned board to the hundredth. No looked refusal. Flower look at confidence 48 is already 0. Flowers were not touched.

Beginner ideal releases said leave, straight, or none, and did not ask for a rail. No looked refusal.

## Coaching proof, single courses

Playtest after the hear-line edit: `dist/playtest_day.log`, `PLAYTEST done pass=true`. Clear faults 0, refuse faults 4, rail faults 4, `FENCE knock` fired. Godot exit 0. No window (`MainWindowHandle` 0 on both the console process and its child).

Pinned rides, cert timing 38, so the count is allowed to speak:

| id | morning | this ride | faults | jumped | teleported | count in the log |
| --- | ---: | ---: | ---: | --- | --- | --- |
| hk_les_001 | 18.53 | 18.54 | 0 | 3/3 | false | Two. / One. / Now. |
| hk_beg_033 | 59.87 | 59.88 | 0 | 8/8 | false | Two. / One. / Now. |

Both inside 0.3 s. Logs: `dist/ridecert_hk_les_001_coaching.log`, `dist/ridecert_hk_beg_033_coaching.log`.

## Coaching board

Command: `python tools/content_factory/run_ridecert.py`. Log copy: `dist/ridecert_godot.coaching.log`. Morning file `dist/day_baseline_board.json` was not overwritten. New board is `dist/ridecert_board.json`. `RIDECERT done pass=false board=21/23 style=true`. Godot exit 1 is the two time faults. No window.

Every morning clear still clears. No new rail. No teleport. The largest move on a morning clear is +0.05 s (`hk_beg_004`). The two clock courses may move 0.3 s; they moved 0.00 s and −0.02 s and did not gain a rail. Style is still clear 0, refuse 4, rail 4 (the style rail is the one rail the morning round already had). Coaching stays.

| id | morning | coaching | dt |
| --- | ---: | ---: | ---: |
| hk_les_001 | 18.53 | 18.54 | +0.01 |
| hk_les_002 | 16.53 | 16.54 | +0.01 |
| hk_les_003 | 18.21 | 18.21 | 0.00 |
| hk_les_004 | 17.95 | 17.95 | 0.00 |
| hk_beg_035 | 67.29 | 67.29 | 0.00 |
| hk_beg_039 | 70.74 | 70.74 | 0.00 |
| hk_beg_004 | 70.31 | 70.36 | +0.05 |
| hk_beg_034 | 63.44 | 63.44 | 0.00 |
| hk_beg_007 | 65.53 | 65.54 | +0.01 |
| hk_beg_033 | 59.87 | 59.87 | 0.00 |
| hk_int_001 | 90.84 | 90.86 | +0.02 |
| hk_int_002 | 80.30 | 80.30 | 0.00 |
| hk_int_005 | 92.27 | 92.29 | +0.02 |
| hk_int_006 | 79.03 | 79.03 | 0.00 |
| hk_int_007 | 84.94 | 84.94 | 0.00 |
| hk_int_009 | 85.00 | 85.00 | 0.00 |
| hk_adv_001 | 91.61 | 91.61 | 0.00 |
| hk_adv_002 | 83.13 | 83.12 | −0.01 |
| hk_adv_003 | 94.01 | 93.99 | −0.02 |
| hk_adv_005 | 78.93 | 78.93 | 0.00 |
| hk_jo_beg_001 | 35.32 | 35.31 | −0.01 |
| hk_jo_int_001 | 36.50 | 36.51 | +0.01 |
| hk_jo_adv_001 | 35.81 | 35.82 | +0.01 |

## Ship relateds against the measured canter

Measured canter stride is 3.246 m (`dist/stride_day.log`, exact cycles). Implied stride here is ground distance divided by the labeled stride count. The ground distance includes the jump, so a 1-stride related near 7.45 m reads as 7.45 m per stride. Sorted by how far that number sits from 3.246. All 45 are outside 3.05–3.45. That is the same fact as the ledger, not a reason to move a fence.

| course | leg | strides | ground_m | implied_m | from 3.246 |
| --- | --- | ---: | ---: | ---: | ---: |
| hk_beg_004 | 3->4 | 1 | 7.54 | 7.539 | +4.293 |
| hk_adv_002 | 2->3 | 1 | 7.49 | 7.485 | +4.239 |
| hk_adv_001 | 10->11 | 1 | 7.45 | 7.450 | +4.204 |
| hk_adv_005 | 9->10 | 1 | 7.45 | 7.450 | +4.204 |
| hk_adv_005 | 10->11 | 1 | 7.45 | 7.450 | +4.204 |
| hk_adv_002 | 11->12 | 1 | 7.45 | 7.450 | +4.204 |
| hk_int_002 | 8->9 | 1 | 7.45 | 7.450 | +4.204 |
| hk_adv_001 | 3->4 | 1 | 7.45 | 7.450 | +4.204 |
| hk_adv_003 | 2->3 | 1 | 7.45 | 7.450 | +4.204 |
| hk_adv_005 | 3->4 | 1 | 7.45 | 7.450 | +4.204 |
| hk_adv_005 | 4->5 | 1 | 7.45 | 7.450 | +4.204 |
| hk_int_001 | 2->3 | 1 | 7.45 | 7.450 | +4.204 |
| hk_int_006 | 3->4 | 1 | 7.45 | 7.450 | +4.204 |
| hk_adv_003 | 1->2 | 1 | 7.41 | 7.411 | +4.165 |
| hk_beg_033 | 1->2 | 1 | 7.29 | 7.293 | +4.047 |
| hk_les_003 | 2->3 | 2 | 10.92 | 5.458 | +2.212 |
| hk_beg_035 | 3->4 | 2 | 10.90 | 5.452 | +2.206 |
| hk_beg_034 | 3->4 | 2 | 10.85 | 5.424 | +2.178 |
| hk_les_002 | 2->3 | 2 | 10.81 | 5.407 | +2.161 |
| hk_int_005 | 3->4 | 2 | 10.80 | 5.400 | +2.154 |
| hk_int_009 | 3->4 | 2 | 10.80 | 5.400 | +2.154 |
| hk_adv_002 | 3->4 | 2 | 10.80 | 5.400 | +2.154 |
| hk_int_007 | 3->4 | 2 | 10.80 | 5.400 | +2.154 |
| hk_int_007 | 2->3 | 2 | 10.80 | 5.400 | +2.154 |
| hk_int_005 | 2->3 | 2 | 10.80 | 5.400 | +2.154 |
| hk_beg_035 | 4->5 | 2 | 10.80 | 5.400 | +2.154 |
| hk_beg_033 | 2->3 | 2 | 10.80 | 5.400 | +2.154 |
| hk_int_001 | 1->2 | 2 | 10.80 | 5.400 | +2.154 |
| hk_int_002 | 4->5 | 2 | 10.80 | 5.400 | +2.154 |
| hk_adv_001 | 4->5 | 2 | 10.80 | 5.400 | +2.154 |
| hk_beg_034 | 4->5 | 2 | 10.80 | 5.400 | +2.154 |
| hk_int_006 | 4->5 | 2 | 10.80 | 5.400 | +2.154 |
| hk_adv_002 | 10->11 | 2 | 10.80 | 5.400 | +2.154 |
| hk_adv_003 | 11->12 | 2 | 10.80 | 5.400 | +2.154 |
| hk_les_004 | 2->3 | 2 | 10.78 | 5.388 | +2.142 |
| hk_beg_007 | 3->4 | 2 | 10.76 | 5.380 | +2.134 |
| hk_int_002 | 3->4 | 2 | 10.76 | 5.378 | +2.132 |
| hk_les_001 | 2->3 | 2 | 10.73 | 5.363 | +2.117 |
| hk_beg_039 | 1->2 | 2 | 10.71 | 5.357 | +2.111 |
| hk_int_002 | 6->7 | 2 | 10.71 | 5.356 | +2.110 |
| hk_beg_007 | 2->3 | 2 | 10.43 | 5.213 | +1.967 |
| hk_beg_033 | 5->6 | 3 | 15.08 | 5.028 | +1.782 |
| hk_beg_007 | 5->6 | 3 | 15.06 | 5.020 | +1.774 |
| hk_adv_001 | 9->10 | 3 | 14.66 | 4.888 | +1.642 |
| hk_int_009 | 2->3 | 3 | 14.55 | 4.849 | +1.603 |

The step from a 1 to a 2 is 3.350 m of ground, and from a 2 to a 3 is 4.260 m. The canter itself is 3.246 m. The extra meters are the jump, which the label does not subtract.

## Michelle, ship file only

`game/content/rail/michelle_ship.json`. 336 lines. The nine keys below are 16 lines each. A line is weak when a rider who hears only that sentence cannot tell what just happened. No sentence was added, and none was replaced. Two short sentences are the file's ordinary shape. That is not a reason to rewrite one.

| key | lines | weak | weak ids |
| --- | ---: | ---: | --- |
| early | 16 | 4 | early_06, early_08, early_11, early_15 |
| deep | 16 | 1 | deep_14 |
| chip | 16 | 2 | chip_08, chip_15 |
| spot | 16 | 1 | spot_13 |
| leave | 16 | 0 | — |
| straight | 16 | 1 | straight_15 |
| looked | 16 | 1 | looked_10 |
| wrong | 16 | 0 | — |
| halt | 16 | 0 | — |

None of the nine keys is vague as a set. Early is the thinnest: four lines say hold, sit, or wait, and never say she was early. The other twelve say early, too soon, or that he was not there yet. Deep, chip, spot, straight, and looked each have one or two lines that give the correction and skip the name. Leave, wrong, and halt name the event every time. Whoa counts as halt. "Not the next fence" counts as the wrong fence. "He saw it" and "he noticed the box" count as a look. "Bury" on deep_11 counts as deep.

The other 192 lines are rail, refuse, off course, three, time, lesson start, jump-off, clear, ribbon, steady, walk out, and pat. They were not in the nine-key pass.

## What a rider feels

Halt is 0 m/s. Walk is 1.45 m/s, trot is 2.80, canter is 5.55. Turn rate at those gaits is 1.8, 2.40, 1.62, and 1.08 radians per second, times `turn_scale` (0.88 + rideability / 400). Canter is 1.71 strides a second, three beats. The measured canter stride on the sand is 3.246 m. The spoken count still divides by 3.35, and that 0.104 m gap is inside the day's 0.15 m gate, so the divisor was left alone.

Space is a half-halt, not a pop jump. The press starts a 0.95 s sit. Holding Space at the canter collects him (canter target drops to 70 percent) and fills `charge` at `delta / 0.42`. Releasing Space while that charge is running calls the leave and then clears the charge. An ask closer than 0.50 m or farther than 5.4 m does not register.

The count is spoken at the canter, not while he is already in the air, when the next fence is between 0.8 m and 11 m ahead and inside 1.6 m of the line, and the rounded stride count is 0, 1, or 2. Two and One are prefixed onto the same word the leave would use. A lesson always hears it. Schooling and show hear it only while timing is under 55. The cert pin is 38, and so is day one, so both hear it. `speak_soft` only. It does not press a key and it does not change speed, charge, gait, or the ask.

Early is an ask farther out than 2.55 + 1.05 times the window. He refuses. Now is the ideal band, 2.55 ± 0.55 times the window, and it does not take a rail. Too deep is an ask closer than 2.55 − 0.80 times the window: she hears deep, and he jumps with a rail. Chip is the shoulder, not the ideal: the ask is outside Now, charge is under `balance_need`, she says chip, and he jumps with a rail. On the lesson fence, with charge under `balance_need`, the ideal band was spot and no rail. The window is 1.24 in a lesson, 1.16 at beginner, 1.00 at intermediate, 0.88 at advanced. Now gets narrower at 3'0". That was not retuned.

## Come-again geometry, not moved

Read from the morning log and from `place_fence` search. Nothing was written to a course file. Search was read-only. A fence that is an end of a labeled related cannot move alone.

`hk_adv_001` come-again at 7: from 6 the run is +3.2 m and the offset is 14.1 m. A person cannot count that. Fence 7 is free. The only spot inside the leash and the yaw cap is (9.40, 29.50), yaw +0.698, run 12.6 m, offset still 11.0 m. Fence 9 is the start of a 3-stride to 10, and 10 is a 1-stride to 11. The only rigid 9–10 candidate puts 10→11 at 9.25 m, outside the 7.0–7.8 m band. Not usable. Fence 8's best spot is the spot it already occupies.

`hk_adv_003` come-again at 6: from 5 the run is +2.5 m and the offset is 16.2 m. Fence 6 is free. Best spot (−1.60, 19.50), yaw −0.524, run 10.3 m, offset 5.3 m. Come-again at 10: fence 10 itself has no legal spot. Fence 9 is free, and its best spot (−0.10, 13.00), yaw +2.618, leaves about 8 m of run and 2 m of offset into 10, against 2.5 m and 8.9 m now.

Three moves were ridden after the coaching board was kept. All three were put back. Both course files match the backup taken before any move, in `game/content/courses/advanced/` and in `content/courses/advanced/`.

| move | fence | where it went | ride | against  | decision |
| --- | --- | --- | ---: | --- | --- |
| 1 | hk_adv_003 #9 | (−0.10, 13.00), yaw +2.618, 6.81 m | 100.95 s, 5 time faults, 0 rails, 12/12 | coaching 93.99 s, 3 time faults | revert. 10→11 became 16.24 s and 11→12 became 13.35 s |
| 2 | hk_adv_003 #6 | (−1.60, 19.50), yaw −0.524, 6.84 m | 96.41 s, 4 time faults, 0 rails, 12/12 | 93.99 s | revert. The come-again moved from 6 to 7. Fence 10 was unchanged. Course stopped. |
| 3 | hk_adv_001 #7 | (9.40, 29.50), yaw +0.698, 2.47 m | 85.88 s, faults 5, rails 1, 12/12 | coaching 91.61 s, 0 rails | revert. Faster, and he knocked fence 6 during the come-again to 9. A rail is not a keep. |

Not ridden, and not a fourth move: hk_adv_001 fence 6 has no legal spot, fence 8's best spot is where it already stands, fence 9 can only move as a pair with 10 and that pair stretches 10→11 to 9.25 m (the 1-stride band is 7.0–7.8). hk_adv_003 fence 10 and fence 5 have no legal spot. `ride_ai.gd` was not edited. The fresh day-one rides had no come-again on a straight line with room, and no release outside the window.
