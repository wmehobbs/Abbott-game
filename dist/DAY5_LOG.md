# Day 5 log — Abbott 2.348.0.0

Headless only. Product version not bumped. `dist\Abbott.exe` not launched. Night files and day-4 files were not overwritten. Come again was not edited.

Playtest: clear faults 0, refuse faults 4, rail faults 4. The rail round printed one `FENCE knock`, fence 3. Rail faults stayed 4, so `note_rail` stored that one pole.

| id | style | night faults | new faults | rail_fences |
| --- | --- | --- | --- | --- |
| hk_les_001 | refuse_early | 4 | 4 | [] |
| hk_les_001 | rail_late | 4 | 4 | [3] |
| hk_les_002 | refuse_early | 4 | 4 | [] |
| hk_les_002 | rail_late | 4 | 4 | [3] |
| hk_les_003 | refuse_early | 4 | 4 | [] |
| hk_les_003 | rail_late | 4 | 4 | [3] |
| hk_les_004 | refuse_early | 4 | 4 | [] |
| hk_les_004 | rail_late | 4 | 4 | [3] |
| hk_beg_035 | refuse_early | 4 | 4 | [] |
| hk_beg_035 | rail_late | 4 | 4 | [3] |
| hk_beg_039 | refuse_early | 4 | 4 | [] |
| hk_beg_039 | rail_late | 4 | 4 | [3] |
| hk_beg_004 | refuse_early | 4 | 4 | [] |
| hk_beg_004 | rail_late | 4 | 4 | [3] |
| hk_beg_034 | refuse_early | 4 | 4 | [] |
| hk_beg_034 | rail_late | 4 | 4 | [3] |
| hk_beg_007 | refuse_early | 4 | 4 | [] |
| hk_beg_007 | rail_late | 4 | 4 | [3] |
| hk_beg_033 | refuse_early | 4 | 4 | [] |
| hk_beg_033 | rail_late | 4 | 4 | [3] |
| hk_int_001 | refuse_early | 4 | 4 | [] |
| hk_int_001 | rail_late | 4 | 4 | [3] |
| hk_int_002 | refuse_early | 4 | 4 | [] |
| hk_int_002 | rail_late | 4 | 4 | [3] |
| hk_int_005 | refuse_early | 4 | 4 | [] |
| hk_int_005 | rail_late | 4 | 4 | [3] |
| hk_int_006 | refuse_early | 4 | 4 | [] |
| hk_int_006 | rail_late | 4 | 4 | [3] |
| hk_int_007 | refuse_early | 4 | 4 | [] |
| hk_int_007 | rail_late | 4 | 4 | [3] |
| hk_int_009 | refuse_early | 4 | 4 | [] |
| hk_int_009 | rail_late | 4 | 4 | [3] |
| hk_adv_001 | refuse_early | 11 | 11 | [6] |
| hk_adv_001 | rail_late | 10 | 10 | [3, 6] |
| hk_adv_002 | refuse_early | 5 | 5 | [] |
| hk_adv_002 | rail_late | 5 | 5 | [3] |
| hk_adv_003 | refuse_early | 11 | 11 | [] |
| hk_adv_003 | rail_late | 10 | 10 | [3] |
| hk_adv_005 | refuse_early | 4 | 4 | [] |
| hk_adv_005 | rail_late | 4 | 4 | [3] |
| hk_jo_beg_001 | refuse_early | 4 | 4 | [] |
| hk_jo_beg_001 | rail_late | 4 | 4 | [3] |
| hk_jo_int_001 | refuse_early | 11 | 11 | [1] |
| hk_jo_int_001 | rail_late | 5 | 5 | [3] |
| hk_jo_adv_001 | refuse_early | 19 | 19 | [1, 2] |
| hk_jo_adv_001 | rail_late | 4 | 4 | [3] |

## Close

Two names differed in the night logs. Both were fence 6 on `hk_adv_001`, stored as next fence 9. The new lists match `FENCE knock` on all 23. Refuse is `[6]`, faults 11. The rail round is `[3, 6]`, faults 10. `hk_jo_adv_001` refuse is `[1, 2]`, faults 19. No fault total moved.

Files changed: `game/scripts/game_state.gd` (`note_rail` stores the fence's own number), `game/scripts/fence.gd` (`knock` passes that number), `game/scripts/ride_cert.gd` (the result row copies `rail_nums`), `dist/_day5_ride.py`, `dist/DAY5_MEASURE.md`, `dist/DAY5_LOG.md`, `dist/day5/` (23 style logs and the playtest).

Blacklist: none. No window.

`dist\Abbott.exe` was not launched and was not rewritten. Last write 24 September 2026, 11:44. Version stays 2.348.0.0.
