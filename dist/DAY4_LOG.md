# Day 4 log — Abbott 2.348.0.0

Headless only. Product version not bumped. `dist\Abbott.exe` not launched. Night files were not overwritten. Style stays as the night left it.

## Rows

| hypothesis | files | command | result | decision |
| --- | --- | --- | --- | --- |
| A lie is Come again, then a COUNT under 1.6 m on that fence, with no circle between them | none | read `dist/day3/board.log` | 181 sentences. 159 are that lie. `hk_les_001` fence 2 speaks at 10.80 m / 6.79 m and the next count is 0.41 m, no circle. Fence 7 of `hk_adv_001` circles at 13.86 m, then a 1.64 m wobble lines up. Fence 9 circles at ahead 3.98 m, lateral 5.13 m. | Not another lateral. Try 1 remembers the first wide ahead and speaks after 3 m of closing, still at least 4 m off, ahead still over 2 m. The lineup no longer clears the latch. |
| Close 3 m, still at least 4 m off, ahead still over 2 m | `game/scripts/horse.gd` | 23 clears to `dist/day4/<id>.log` | Times within 0.3 s. No new rail. No teleport. `hk_beg_033` fence 2 is Early / Wait / Now. `hk_adv_001` fence 7 speaks and then circles; the 1.64 m wobble does not speak. `hk_les_001` fence 2 still speaks after the 0.41 m lineup, on the next wide swing. Fence 9's 5.13 m circle does not speak. Other lies that still speak: les 002/003/004 fence 2; beg 035 fences 2, 3, 8; beg 039 fences 3, 4, 5, 8; beg 004 fences 2, 3, 5, 6, 8; beg 034 fences 3, 6; beg 007 fences 5, 6, 8; beg 033 fences 4, 5, 6; int 001 fences 5, 6, 9, 10; int 002 fences 2, 3, 7; int 005 fences 2, 5, 6; int 006 fences 2, 3, 6, 7, 9, 10; int 007 fences 2, 6, 9, 10; int 009 fences 2, 5, 9, 10; adv 001 fences 2, 3, 6, 12; adv 002 fences 2, 6, 7, 8, 10; adv 003 fences 4, 5, 7, 11; adv 005 fences 2, 3, 6; jo beg fences 2, 3; jo int fences 2, 3; jo adv fences 2, 3. Circles that went silent: beg 035 fence 6, beg 039 fence 6, int 001 fence 7, int 005 fences 7 and 9, int 007 fence 7, int 009 fence 7, adv 003 fence 10. | Fail. Closing distance becomes 5 m. The 4 m floor and the 2 m plane stay. Not a third distance. |
| Close 5 m, still at least 4 m off, ahead still over 2 m | `game/scripts/horse.gd` | 23 clears to `dist/day4/<id>.try5.log` | Times within 0.3 s. No new rail. No teleport. `hk_beg_033` fence 2 is One. Wait / One. Early / Early / Wait / Now. No Come again. No Two. `hk_adv_001` fence 7 speaks at 7.03 m / 13.86 m and then circles; the 1.64 m wobble does not speak. `hk_les_001` fence 2 still speaks: silent at 10.80 m / 6.79 m, Two. Wait. at 0.41 m, then Come again on the next wide tick at 10.41 m / 1.75 m. Fence 9 counts 3.98 m / 5.13 m and circles with no Come again. Other lies that still speak: les 002/003/004 fence 2; beg 035 fences 2, 3, 8; beg 039 fences 3, 4, 5; beg 004 fences 2, 3, 5; beg 034 fences 3, 6; beg 007 fences 5, 6, 8; beg 033 fences 4, 5, 6; int 001 fences 5, 6, 10; int 002 fences 2, 3, 7; int 005 fences 2, 5, 6; int 006 fences 2, 3, 6, 9, 10; int 007 fences 2, 6; int 009 fences 2, 5, 9; adv 001 fences 2, 3, 6, 12; adv 002 fences 2, 7, 8, 10; adv 003 fences 4, 5, 7, 11; adv 005 fences 2, 3, 6; jo beg fence 2; jo int fences 2, 3; jo adv fences 2, 3. Circles that went silent: beg 035 fence 6, beg 039 fence 6, int 001 fence 7, int 005 fences 7 and 9, int 007 fence 7, int 009 fence 7, adv 001 fence 9, adv 003 fence 10. | Fail. Morning Come again restored. No third try. No board. |

## Close

Neither try was kept. No board. Morning bytes are back in `game/scripts/horse.gd`: Come again on the wide tick inside 11 m, and lining up clears the latch. `come_wide_fence`, `come_wide_ahead`, and `COME_CLOSE` are gone.

Files changed: `game/scripts/horse.gd` (reverted), `dist/_day3_ride.py` (`--day4`, `--day4-try5`, blacklist appends here), `dist/_day4_measure.py`, `dist/_day4_check.py`, `dist/DAY4_MEASURE.md`, `dist/DAY4_LOG.md`, `dist/day4/` (23 `.log`, 23 `.try5.log`).

Blacklist: none. No window.

`dist\Abbott.exe` was not launched and was not rewritten. Last write 24 September 2026, 11:44. Version stays 2.348.0.0.

