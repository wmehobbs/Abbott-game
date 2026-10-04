# Night log — Abbott 2.348.0.0

Headless only. Product version not bumped. `dist\Abbott.exe` not launched. Day 3 files were not overwritten.

The hear line, the 320 ship lines, the courses, and `ride_ai.gd` stay.

## Rows

| hypothesis | files | command | result | decision |
| --- | --- | --- | --- | --- |
| Come again on a lateral under 4 m, with no circle, is a lie | none | read `dist/day3/board.log` | 181 sentences. 138 clear-round jumps had no `RIDEAI come again`. 29 of those were under 4 m. Fence 7 of `hk_adv_001` is a circle at 13.86 m and a lie at 1.64 m. Fence 9 is a circle at 5.13 m. | lies exist. Raise only the lateral floor to 4.0. Remove the ahead-or-straight-run trick. |
| Lateral at least 4 m, still inside 0.8–11, once per approach | `game/scripts/horse.gd` one test | re-ride the 23 clear ids to `dist/night/<id>.clear.log` | 23 logs. Times within 0.3 s, no rail, no teleport. `hk_beg_033` fence 2 silent. `hk_adv_001` fences 7 and 9 still speak; fence 9 is the same call as lateral 5.13 and then a circle. A count at 2.42 m is not the same call as Come again (`hk_les_002`). The sentence still fires once lateral crosses 4 m, then she lines up and jumps. `hk_les_001` fence 2 says it at 6.79 m with no circle. | fail. Still speaks on a lie. Second try is 6.0, not a third number. |
| Lateral at least 6 m, same window, once per approach | `game/scripts/horse.gd` one number | re-ride `hk_les_001`, `hk_beg_033`, `hk_adv_001` to `dist/night/<id>.try6.log` | 6.0 is live: fence 9's count at 5.13 m is not followed by Come again. Fence 7 still speaks at 13.86 m and circles. Fence 9 still speaks later in that circle. `hk_les_001` fence 2 still speaks at 6.79 m and jumps with no circle. `hk_beg_033` fence 2 stays Early / Wait / Now. Times 18.53, 59.87, 91.60. No rail, no teleport. The other lie courses are the same shape, a wide first sample, so they were not ridden again on a number that already failed. | fail. Both tries speak on a lie. Put the morning test back. No board. |
| Morning test, ahead under 11 or the straight run under 11 | `game/scripts/horse.gd` restored | no board | The lateral floors are gone. Come again is the morning sentence again. | revert. Style list still runs. |

## Style rows

| hk_les_001 | 4 | yes | yes, list empty | 4 | yes | no | 2 | keep. Come again on straight fence 2. Morning bytes, no edit.
| hk_les_002 | 4 | yes | yes, list empty | 4 | yes | no | 2 | keep. Come again on straight fence 2. Morning bytes, no edit.
| hk_les_003 | 4 | yes | yes, list empty | 4 | yes | no | 2,3 | keep. Come again on straight fence 2,3. Morning bytes, no edit.
| hk_les_004 | 4 | yes | yes, list empty | 4 | yes | no | 2 | keep. Come again on straight fence 2. Morning bytes, no edit.
| hk_beg_035 | 4 | yes | yes, list empty | 4 | yes | no | 1,2,3,6,7,8 | keep. Come again on straight fence 1,2,3,6,7,8. Morning bytes, no edit.
| hk_beg_039 | 4 | yes | yes, list empty | 4 | yes | no | 1,3,4,5,6,7,8 | keep. Come again on straight fence 1,3,4,5,6,7,8. Morning bytes, no edit.
| hk_beg_004 | 4 | yes | yes, list empty | 4 | yes | no | 1,2,3,5,6,7,8 | keep. Come again on straight fence 1,2,3,5,6,7,8. Morning bytes, no edit.
| hk_beg_034 | 4 | yes | yes, list empty | 4 | yes | no | 1,2,3,6,7,8 | keep. Come again on straight fence 1,2,3,6,7,8. Morning bytes, no edit.
| hk_beg_007 | 4 | yes | yes, list empty | 4 | yes | no | 1,2,5,6,7,8 | keep. Come again on straight fence 1,2,5,6,7,8. Morning bytes, no edit.
| hk_beg_033 | 4 | yes | yes, list empty | 4 | yes | no | 1,4,5,6,7,8 | keep. Come again on straight fence 1,4,5,6,7,8. Morning bytes, no edit.
| hk_int_001 | 4 | yes | yes, list empty | 4 | yes | no | 1,4,5,6,7,8,9,10 | keep. Come again on straight fence 1,4,5,6,7,8,9,10. Morning bytes, no edit.
| hk_int_002 | 4 | yes | yes, list empty | 4 | yes | no | 1,2,3,6,7,8 | keep. Come again on straight fence 1,2,3,6,7,8. Morning bytes, no edit.
| hk_int_005 | 4 | yes | yes, list empty | 4 | yes | no | 1,2,3,5,6,7,8,9 | keep. Come again on straight fence 1,2,3,5,6,7,8,9. Morning bytes, no edit.
| hk_int_006 | 4 | yes | yes, list empty | 4 | yes | no | 1,2,3,6,7,8,9,10 | keep. Come again on straight fence 1,2,3,6,7,8,9,10. Morning bytes, no edit.
| hk_int_007 | 4 | yes | yes, list empty | 4 | yes | no | 1,2,5,6,7,8,9,10 | keep. Come again on straight fence 1,2,5,6,7,8,9,10. Morning bytes, no edit.
| hk_int_009 | 4 | yes | yes, list empty | 4 | yes | no | 1,2,5,6,7,8,9,10 | keep. Come again on straight fence 1,2,5,6,7,8,9,10. Morning bytes, no edit.
| hk_adv_001 | 11 | yes | yes, list empty | 10 | yes | no | 1,2,3,6,7,8,9,12 | keep. Come again on straight fence 1,2,3,6,7,8,9,12. Morning bytes, no edit.
| hk_adv_002 | 5 | yes | yes, list empty | 5 | yes | no | 1,2,5,6,7,8,9,10 | keep. Come again on straight fence 1,2,5,6,7,8,9,10. Morning bytes, no edit.
| hk_adv_003 | 11 | yes | yes, list empty | 10 | yes | no | 1,4,5,6,7,8,9,10,11 | keep. Come again on straight fence 1,4,5,6,7,8,9,10,11. Morning bytes, no edit.
| hk_adv_005 | 4 | yes | yes, list empty | 4 | yes | no | 1,2,3,6,7,8,9,12 | keep. Come again on straight fence 1,2,3,6,7,8,9,12. Morning bytes, no edit.
| hk_jo_beg_001 | 4 | yes | yes, list empty | 4 | yes | no | 1,2,3,4 | keep. Come again on straight fence 1,2,3,4. Morning bytes, no edit.
| hk_jo_int_001 | 11 | yes | yes, list empty | 5 | yes | no | 1,2,3,4 | keep. Come again on straight fence 1,2,3,4. Morning bytes, no edit.
| hk_jo_adv_001 | 19 | yes | yes, list empty | 4 | yes | no | 1,2,3,4 | keep. Come again on straight fence 1,2,3,4. Morning bytes, no edit.

Every rail round has `FENCE knock` on fence 3. `rail_fences` is empty on every result line. The body hit scores the fault through `note_rail` and marks the rail knocked, and `horse.gd` then skips `rail_down` because the rail is already down. The horse did not eat the knock. `ride_cert.gd` was not edited.

Five refuse or rail rounds scored more than one 4: `hk_adv_001` 11 and 10, with an extra ground knock on fence 6; `hk_adv_002` 5 and 5; `hk_adv_003` 11 and 10; `hk_jo_int_001` refuse 11; `hk_jo_adv_001` refuse 19, with ground knocks on fences 1 and 2. Each of those rounds still refused fence 1 and jumped it again, or knocked fence 3, and finished with `teleported=false`. Not edited.

## Close

23 style files in `dist/night/`. Come again was not kept: 4.0 and 6.0 both still spoke on a fence she jumped with no circle, and the morning test is back. No board. Files changed: `game/scripts/horse.gd` (restored), `dist/_day3_ride.py`, `dist/NIGHT_LOG.md`, `dist/NIGHT_MEASURE.md`, `dist/night/`. Blacklist: none. `dist\Abbott.exe` was not launched and not rewritten. Version stays 2.348.0.0.
