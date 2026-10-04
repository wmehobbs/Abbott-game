# Day 2 measure — Abbott 2.348.0.0

Yesterday's files were not overwritten. The coaching board in `dist/DAY_MEASURE.md` is the baseline. No full board was run, because the swallow fix was not earned.

## Soft lines already in yesterday's logs

A fence counts if a `MICHELLE soft` line on the approach to it starts with `Two. ` or `One. `. The approach is the soft lines before that fence's `RIDEAI fence N ->` line.

`hk_beg_033`, single-id log `dist/ridecert_hk_beg_033_coaching.log`, and the same course inside `dist/ridecert_godot.coaching.log`. Both say 7 of 8.

| fence | single-id | board |
| --- | --- | --- |
| 1 | Two, One | Two, One |
| 2 | Early, Wait, Now. No Two or One | same |
| 3 | One | Two, One |
| 4 | Two, One | Two, One |
| 5 | One | One |
| 6 | One | One |
| 7 | Two, One | Two, One |
| 8 | Two, One | Two, One |

Fence 2 is the one-stride off fence 1 (7.29 m). The leave sentence can still cover Two and One there. It does not cover them on the other seven fences. Six of eight was the line for skipping the swallow fix. Phase 1 is skipped.

On the coaching board, every lesson fence has a Two or a One (3/3 on all four lessons). Beginner courses other than `hk_beg_033` are 8/8. The misses elsewhere are single fences: `hk_int_001` fence 3, `hk_adv_001` fence 4, `hk_adv_002` fences 3 and 12, `hk_adv_003` fence 3, `hk_adv_005` fences 5 and 10, `hk_jo_adv_001` fence 2. Those fences still say Early / Wait / Now. The count is not dying after fence 1.

## Career, day-one stats, clears only

`_school_from_round` from confidence 48, scope 40, rideability 44, timing 38, feel 36. Every round is a clear: timing +4, and scope also takes the no-rail +1.5. The deltas were not changed. Twenty clears, in class order, four lessons then six beginner, six intermediate, four advanced.

Timing crosses 55 on clear 5, the first Crossrails (`beginner`) round: 54 to 58. Four clear lessons land on 54. The +4 was not touched.

| n | class | clear in that class | timing |
| --- | ---: | ---: | ---: |
| 1 | lesson | 1 | 42 |
| 2 | lesson | 2 | 46 |
| 3 | lesson | 3 | 50 |
| 4 | lesson | 4 | 54 |
| 5 | beginner, Crossrails 2'3" | 1 | 58 |
| 6 | beginner | 2 | 62 |
| 7 | beginner | 3 | 66 |
| 8 | beginner | 4 | 70 |
| 9 | beginner | 5 | 74 |
| 10 | beginner | 6 | 78 |
| 11 | intermediate, Schooling Jumpers 2'6" | 1 | 82 |
| 12 | intermediate | 2 | 86 |
| 13 | intermediate | 3 | 90 |
| 14 | intermediate | 4 | 94 |
| 15 | intermediate | 5 | 98 |
| 16 | intermediate | 6 | 100 |
| 17 | advanced, Open Jumpers 3'0" | 1 | 100 |
| 18 | advanced | 2 | 100 |
| 19 | advanced | 3 | 100 |
| 20 | advanced | 4 | 100 |

Under the old hear line, schooling and show go quiet at 58, which is one clear Crossrails round, while Now at 2'6" is 1.10 m and at 3'0" is 0.97 m. Confidence reaches 100 on the fifth Crossrails clear. Scope and rideability reach 100 on the fourth Schooling Jumpers clear.

The hear line now is lesson, or timing under 55, or fewer than two clears at this class. The +4 was not changed. Probe in `dist/hear_day.log`: hear, hear, silent, hear. `HEAR done pass=true`. At timing 60 with two beginner clears, Crossrails is silent. At timing 60 with intermediate clears still 0, Schooling Jumpers still hears, even if Crossrails already has two.

## Soft lines on hk_beg_033 after the hear line

Phase 1 was skipped, so there is no swallow-fix log. The proof ride after the hear line is `dist/ridecert_godot.log`, `hk_beg_033`, t=59.86, faults 0, teleported false. Yesterday's board was 59.87. The single-id coaching ride was 59.88. Same 7 of 8.

| fence | before phase 1 | this proof ride |
| --- | --- | --- |
| 1 | Two, One | Two, One |
| 2 | Early, Wait, Now. No Two or One | same |
| 3 | One, or Two and One on the board | Two, One |
| 4 | Two, One | Two, One |
| 5 | One | One |
| 6 | One | One |
| 7 | Two, One | Two, One |
| 8 | Two, One | Two, One |

## Come again

Not added. Phase 1 was not kept, and the sentence was allowed only after that keep. It did not show on `hk_adv_001` fences 7 or 9, because that ride was not run. It stayed off the lesson and off `hk_beg_033` because the words were never put in. `ride_ai.gd` was not edited.

## Michelle, ship file, this day

`game/content/rail/michelle_ship.json` only. 336 lines in, 320 left. No new sentence. The rest were not reordered. Leave, wrong, and halt are still 16.

Yesterday's ten, removed. Each of those keys still has at least 12.

| key | was | now | removed |
| --- | ---: | ---: | --- |
| early | 16 | 12 | early_06, early_08, early_11, early_15 |
| deep | 16 | 15 | deep_14 |
| chip | 16 | 14 | chip_08, chip_15 |
| spot | 16 | 15 | spot_13 |
| straight | 16 | 15 | straight_15 |
| looked | 16 | 15 | looked_10 |

The other 192, scored the same way. A line is weak when the sentence never names the event. Six were removed. The cap was 24. No key would have gone under 8, so none of these was left for thinness.

| id | sentence | why it does not name the event |
| --- | --- | --- |
| rail_14 | He left late and paid for it. | No rail, down, hit, or four. |
| refuse_06 | Whoa. Don't turn away angry. | Whoa is halt. No stop, refusal, or same fence. |
| off_course_12 | That's elimination. Come get him. | Three refusals and time are also elimination. No off course, wrong fence, order, or track. |
| lesson_start_08 | Don't run to the first fence. | No walk, no lesson, no start. |
| jump_off_10 | Don't run. The time is already tight. | No jump-off and no four. |
| ribbon_08 | Don't wave it. Pat him. | "It" never says ribbon, color, or pinned. |

Left on purpose, because the sentence does name it: rail_10 "That's four" is a rail. Refuse lines that say stop, refused, said no, or same fence. Off-course lines that say off course, wrong fence, the order, left the track, or missed the number. Jump-off lines that say jump-off or four, including "Four. Keep the canter you had." Three, time, clear, steady, and walk out name themselves in every line. Pat names the pat, including pat_15 "Hand on his neck." Those keys stayed at 15 or 16.

Playtest after the cut: clear faults 0, refuse faults 4, rail faults 4, knock fired on fence 3 while jumping, `pass=true`. No ride cert.
