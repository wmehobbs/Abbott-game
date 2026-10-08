# Day 12 morning

Written 2026-10-08 before 07:00. The final picture set was captured at 02:33 local, after the picture list was already closed. No window after that set.

## 1. Branch and commits

Branch `day12-overnight`. Nothing pushed.

- bc5ef6c8 Day 12 T0: record the ride baseline and the vision check.
- 7a9ea865 Day 12 T1: add a fixed shot list and the first visual backlog.
- 3307d813 Day 12 T2: add a selftest that runs inside the real boot.
- a8e03b41 Day 12 T3: keep a backup before replacing the save.
- d7b401c0 Day 12 T4: shrink the start and finish letters so they sit on the flags.
- 7ee935f4 Day 12 T4: drop the extra shadow oval under the horse.
- 27fbb233 Day 12 T4: turn the sky so the panorama seam leaves the approach.
- 1846feb2 Day 12 T4: make the schooling sign a small rail sign.
- db0b15dd Day 12 T4: close the face, bridle, and blown-sky notes for Ernie.
- 9f9db59a Day 12 T6: record camera and gait telemetry without changing the ride.
- d1c62666 Day 12 T7: put the menus on a card and check them at six screen sizes.
- e2188895 Day 12 T8: add a gamepad path that keeps the keyboard bindings.
- 1a570129 Day 12 T9: route sound onto buses and duck the bed under a voice.
- 265df28f Day 12 T10: remember options and make pause and the result card clearer.
- d012b059 Day 12 T10: note the options commit in the log.
- d2ffd5ec Day 12: add the season ladder, a first lesson, and native-size rendering.
- 7e754639 Day 12: list unused assets and map the code.
- c293bfd4 Day 12: note the unused-list and map commit in the log.
- e3431d62 Day 12: capture the new screens and time Low picture quality.
- ff384f25 Day 12: note the screen-capture commit in the log.
- 7c9ee385 Day 12 T16: make the brush flower heads clumps instead of cards.
- 41bb9a32 Day 12: note the flower-head commit in the log.
- 3e78028a Day 12 T16: drop the glowing yellow fence number plate.
- 7f6c5c39 Day 12: note the number-plate commit in the log.
- 5d012b71 Day 12 T16: dull the orange tree discs to a tan canopy.
- 3e3d86bb Day 12: note the tree-canopy commit in the log.
- b7cebd7f Day 12 T16: keep the dust low so the belly specks are gone.
- e1879b33 Day 12: note the dust commit in the log.

T5 has no commit. The lighting tries were reverted. This morning report is the next commit. Its hash is noted in the follow-up.

## 2. What Madison would notice

The title has a Season button beside the ones she already uses. It lists the lessons, then schooling, then the show, each locked, open, or done. Her save shows the lessons and the open schooling rows as done, with the best she already has. Show day is below the fold.

A brand-new save gets Michelle's first lesson: walk, trot, canter, steer, whoa, half-halt, a pole, then the next fence. Skip is on the card. Her existing save is marked done, so she is not sent through it.

The picture uses the monitor's real size. Options, pause, and the result card are readable. Flower heads are clumps. The current fence number is red on a wood plate. The trees are tan instead of glowing orange, and they are still stacked discs. The blue-grey specks under the belly are gone. Low picture quality is faster. The default stays High.

## 3. Sheets to open first

- `dist/day12/shots/baseline_vs_final.jpg` (31 pairs)
- `dist/day12/shots/t16_flowers_pair.jpg`
- `dist/day12/shots/t16_plate_pair.jpg`
- `dist/day12/shots/t16_trees_pair.jpg`
- `dist/day12/shots/t16_dust_pair.jpg`
- Stills, 1280 px: `dist/day12/shots/final_jpg/` especially `title.jpg`, `play_cam.jpg`, `walk_side.jpg`, `season.jpg`, `options.jpg`, `pause.jpg`, `results.jpg`, `lesson_walk.jpg`, `lesson_pole.jpg`

Images are not committed.

## 4. Morning look, about 10 minutes

1. Start the game with the sound on and ride a few fences. Listen for hooves, the outdoor bed, and a voice line ducking the music.
2. On the title, press Season. Scroll. Confirm the lessons and schooling rows match her save, and that a locked row does not start.
3. Leave her save alone. If you want the first lesson, use a throwaway save, not `abbott_save.json`. Press Skip, then ride one fence yourself.
4. Open Options, Picture, and switch High and Low. Leave it on High.
5. Pause a round. Press Restart round. Confirm the clock and the faults clear and Abbott is back at the flags.
6. Finish a short lesson and read the result card: the line, the time, and the time allowed.

## 5. Numbers

Rides, T0 then T19. Same faults, same offer, teleported false, time within 0.10 s.

| id | T0 | T19 |
| --- | --- | --- |
| hk_les_001 | 0 faults, 25.42, offer no | 0 faults, 25.43, offer no |
| hk_beg_035 | 0 faults, 62.14, offer yes, jump-off 0 faults 33.45 | 0 faults, 62.14, offer yes, jump-off 0 faults 33.44 |
| hk_int_002 | 0 faults, 74.75, offer yes, jump-off 1 time fault 40.88, White | 0 faults, 74.73, offer yes, jump-off 1 time fault 40.87, White |

GPU, VSync off. Baseline p95 3.007 ms. Tonight's High p95 2.92 ms. Low p95 1.995 ms. Flower pass 2.941, plate 2.876, trees 2.892, dust 2.906. All inside 15 percent of 3.007. Default stays High.

Telemetry was recorded at T6 and not rerun. Lesson 2382 frames, beginner plus jump-off 8450 frames. After the first half second the camera does not pop. Horizon roll is 0.

Playtest stayed clear 0, refuse 4, rail 4 through the picture changes. Morning gate: compile printed COMPILE ok, selftest pass=22 fail=0.

## 6. STASHED and BLOCKED

STASHED: nothing.

BLOCKED: nothing. T5 lighting was tried and reverted on purpose.

## 7. NEEDS ERNIE

- Madison's legs stick straight out. That is the rig.
- Abbott's face photo is smeared on the flat head. Do not repaint the blaze.
- The bridle is dark rods that float off the face. Same mesh limit.
- Unused files are listed in `dist/day12/unused_assets.csv`. Nothing was deleted. The harvest textures still packed are about 466 MB, plus a few photos, loose coat maps, and `ambient_indoor.wav`. Say which can go.
- The trees are still stacked coins on poles. Color is tan. A thicker clump was the same shape and was put back. A real tree needs a model. The backlog says this cannot be fixed without one.

## 8. BLACKLIST

Empty. No command was blacklisted.

## 9. Confirmation

Madison's save matched all night, including after the final shots, the three ride checks, compile, and selftest. SHA256 `DCAF7E223063BC97406AE83CA2C714CF15CC6D1EB60925518B1AC0249DE5B4A8`. No `.exe` was touched. Version is 2.348.0.0. Nothing was pushed. The only Godot processes left are the two seat probes, PIDs 114976 and 115652. This night did not start them and did not kill them.

# Day 12

VISION: YES. The September play-camera shot is a sand ring filling the frame, a white rail and a dark kick board across the back, and a scoreboard that still says walk to the start flags. The horse is only a dark edge at the left.

Started 2026-10-06 00:23 local. Morning is 07:00. Windowed runs stop at 05:45.

## Status

| task | status | commit | gates | notes |
| --- | --- | --- | --- | --- |
| T0 | done | bc5ef6c8 | compile ok, playtest 0/4/4, three rides RIDECERT done, save match | Baseline times differ from Day 11. See DAY12_MEASURE.md. |
| T1 | done | 7a9ea865 | compile ok, save match, no script error, 31 shots | Official set is dist/day12/shots/baseline. Images are not committed. |
| T2 | done | 3307d813 | compile ok, SELFTEST SUMMARY pass=8 fail=0, save match | --selftest runs in the real boot. Writes only user://selftest/. |
| T3 | done | a8e03b41 | compile ok, selftest pass=12 fail=0, playtest 0/4/4, save match | Save writes tmp, keeps bak, then replaces. Old saves migrate. |
| T4 | done | d7b401c0, 7ee935f4, 27fbb233, 1846feb2, db0b15dd | playtest 0/4/4, shade rides match T0, selftest 12/0 | Letters, shadow oval, sky seam, schooling sign. Face, legs, bridle need Ernie. |
| T5 | done | none | looked, then reverted | Lighting attempts made the picture orange, darker, or the same. Left the T4 sky. |
| T6 | done | 9f9db59a | selftest 13/0, playtest 0/4/4, rides match T0 with telemetry on | Camera does not pop after the start. No camera edit. |
| T7 | done | d1c62666 | selftest 14/0, compile ok, playtest 0/4/4, GPU p95 2.909 | Menus sit on a card. Title buttons wrap. Layout checked at six sizes. |
| T8 | done | e2188895 | selftest 15/0, playtest 0/4/4, les 25.43, beg 62.14 jo 33.44 | D-pad gait, stick steer, prompts follow the last device. |
| T9 | done | 1a570129 | selftest 16/0, playtest 0/4/4, les 25.43, beg 62.15 jo 33.44 | Buses exist. Voice ducks Music and Ambience by 6 dB. Listen in the morning. |
| T10 | done | 265df28f | selftest 19/0, playtest 0/4/4, les 25.43, beg 62.14 jo 33.44 | Options persist in settings.cfg. Pause clock holds. Result card names the round. No window today. |
| T13 | done | d2ffd5ec | selftest 22/0, playtest 0/4/4, les 25.42, beg 62.13 jo 33.45 | Season ladder on the title. Existing Lesson, Watch, School, Show, Walk, Options, and Quit stay. |
| T14 | done | d2ffd5ec | same gates | First lesson only when tutorial_done is false. Madison's save migrates to done. Skip stays. |
| T15 | done | d2ffd5ec | same gates | Stretch is canvas_items and expand. The 3D view uses the window size. No new screenshots. |
| unused | done | 7e754639 | no Godot | Spreadsheet of game/assets. Nothing deleted. |
| map | done | 7e754639 | no Godot | docs/ARCHITECTURE.md says who owns what, what is frozen, and how to run the checks. |
| screens | done | e3431d62 | compile ok, selftest 22/0, save match, windowed shots | Options, pause, results, Season, and two lesson lines are readable. Ride camera still shows the ring. Low GPU p95 1.995 vs High 2.92. Default stays High. |
| T16 flowers | kept | 7c9ee385 | compile ok, playtest 0/4/4, GPU p95 2.941, save match | Brush heads are clumps, not flat cards. The yellow wing panel is still flat. |
| T16 plate | kept | 3e78028a | compile ok, playtest 0/4/4, GPU p95 2.876, save match | The current fence number is red on a wood plate. The glowing yellow square is gone. |
| T16 trees | kept | 5d012b71 | compile ok, playtest 0/4/4, GPU p95 2.892, save match | Canopy is dull tan instead of glowing orange. The discs are still coins on poles. Shape try reverted. Closed. |
| T16 dust | kept | b7cebd7f | compile ok, playtest 0/4/4, GPU p95 2.906, save match | The speck puff under the belly is a short low sand puff. The approach lens stays. |
| T19 | done | see morning report | compile ok, selftest 22/0, les 25.43, beg 62.14 jo 33.44, int 74.73 jo 40.87, save match | Final stills at 02:33 local. Sheets are not committed. |

## Decisions

- Seat-probe Godot PIDs 114976 and 115652 have been up since 2026-10-04 21:47 with working sets under 4 MB. This night did not start them and did not kill them. New runs still launch. One new Godot at a time besides those two.
- `--ridecert-fresh` logs to `dist/ridecert_fresh.log`. T0 copies are `dist/day12/<id>.T0.log`.
- Save snapshot is `dist/day12/save_snapshot.json` and is not committed. It matched after compile, playtest, all three rides, and every shots run.
- The first two shot captures were parked as baseline_v1 and baseline_cam1. The jump strip in v1 continued onto the next fence, and the head and in-gate cameras missed. The official baseline is the third capture.
- Shots mode hides the "Click the ring to ride" line so the HUD shot matches a ride with the mouse captured.
- GPU time on the baseline ride is the performance number. FPS stayed near 9 while GPU time stayed near 2.8 ms, so the window may have been in the background.
- T4 attempt 1: the start and finish words were Label3D font 68 with no pixel size, so they filled the sky. They are now font 48, pixel size 0.003, sitting at the flags. Sheet: dist/day12/shots/t4_in_pair.jpg.
- T4 shade: removed the extra oval under the belly. One horse-shaped sun shadow remains. Lesson 25.43 (T0 25.42), beginner 62.14 and jump-off 33.45, both 0 faults, same offer. Blue specks under the walk are a different bug.
- T4 sky: rotated the panorama by 1.6 radians so the hard seam leaves the rear view and the approach. The sky photo is unchanged. GPU p95 2.976 ms.
- T4 banner: the schooling words are a small sign at the rail. The first try was still huge because the shot camera stands two meters from it. Second try, pixel size 0.0015, sits at shoulder height. GPU p95 2.948 ms.
- T5: one lighting pass with eyes. Warm fog went orange. ACES washed the sky. SSIL did not open the black shadow and cost GPU time. Shadow bias did not help. All reverted. Do not chase it again tonight.
- T6: `--telemetry` writes `dist/day12/telemetry_<id>.csv` at exit, so the round clock is not paying for disk. It is off unless that arg is set, and save() skips it. The ride camera roll is 0. The 14 "pops" are the first half second while the horse is placed at the start.
- T7: pause, results, and options sit in the center on a dark card. The scoreboard hides while a menu is open. Title buttons are in a flow so they wrap on a short screen. Layout selftest covers 1280x720, 1920x1080, 2560x1440, 3840x2160, 1280x800, and 2560x1080.
- T8: the keyboard bindings are unchanged. D-pad up and down change gait. D-pad left and right steer, and the left stick still steers with a 0.25 deadzone. Prompts say W or A depending on the last device.
- T9: hooves, fences, and Abbott's sounds are on SFX. The outdoor bed is on Ambience. Madison's lines and the click are on Voice and UI. Michelle's lines are text, so there is no Voice clip for her yet. A Voice line ducks Music and Ambience by 6 dB and brings them back. Morning: listen to a round with the sound on.
- 2026-10-07 daytime: Ernie is at the desk. No game window. Headless only. The two seat-probe Godots are still up and were not killed.
- T10: Options on the title and in pause. Sound, picture, and keys save to user://settings.cfg, never the ride save. Certs and selftest do not load or write that file, so the ride stays on the defaults (field of view 52, mouse 0.07). A voice duck sits 6 dB under the saved music and barn levels. Pause stops the round clock. Restart round clears faults, the clock, and puts Abbott at the flags. The result card shows the line, the time allowed, and Next class only when that class is already unlocked. Low picture quality drops MSAA, SSAO, and glow. The GPU check for that waits until a window is allowed. No options screenshot today.
- T13: Season sits with the other title buttons. It lists the four lessons, then schooling and the show, in ship order. Locked, open, and done come from class_unlocked. A done row shows the best faults and time already stored. Choosing a lesson sets that course seed and starts it. A locked row does not start.
- T14: A brand-new save gets Michelle's first lesson: walk, trot, canter, steer, whoa, half-halt, the first pole, and the next fence. Skip ends it and marks tutorial_done. An existing save that already has a round is marked done on load, so Madison is not sent through it. Certs, playtest, and selftest never start it.
- T15: The window no longer draws a 1920x1080 picture and scales it. Stretch mode is canvas_items, aspect expand, base size still 1920x1080. Layout still passed at the six sizes. Ride times matched T0. No new screenshots. Low picture quality is still not timed on the GPU.
- Unused list: `dist/day12/unused_assets.csv` from `python dist/day12/unused_assets.py`. Text under `game/` and `content/` (a file's own `.import` does not count). 5385 files, 1,767,830,216 bytes. 5287 files (1,724,549,802 bytes) have no pointer. 1736 of those (499,709,017 bytes) are not on the export exclude list, so a pack would still include them. 1673 of the packed files are under `assets/textures/harvest`, about 466 MB. Nothing was deleted.
- The map for the next person is `docs/ARCHITECTURE.md`.
- Screens, after 1am, windows allowed: `dist/day12/shots/screens_b`. Season, Options, pause, and the result card are readable. The first lesson card says "Press W to walk." and "Canter the first pole." Skip is on the card. The arena was clearing that card every frame, so the shot holds pause and does not save. The ride camera and the title still show the ring after native-size rendering. No frame came back black.
- Low picture quality, same capture, VSync off. Tonight's High GPU p95 is 2.92 ms (the old baseline was 3.007). Low GPU p95 is 1.995 ms, median 1.80. The ride still reads. The default stays High. Median FPS on the High run was 6, so the window may have been behind another window. GPU time is the number that counts.
- T16 flowers, attempt 1: the brush fill used flat cards for flower heads. They are small clumps now. The close fence reads as stems and heads. GPU p95 2.941, inside 15 percent of 3.007. Playtest clear 0, refuse 4, rail 4. Knock box was not touched.
- T16 plate, attempt 2: the yellow square on the approach was the current-fence number, lit and glowing. It is a wood plate now. The current number stays red. The approach shot no longer has that yellow card. GPU p95 2.876. Playtest still 0/4/4.
- T16 trees, attempt 1: the oak shader was painting the discs bright orange. They are a dull tan now. From the ride camera they are still stacked coins on poles. GPU p95 2.892. Playtest still 0/4/4. Attempt 2 thickened the clumps. They were still lollipops, so that scale change was reverted. A real tree needs a model. Closed.
- T16 dust: the blue-grey streaks under the belly were the rising dust. It is a short puff near the sand now. The side view is clean. GPU p95 2.906. Playtest still 0/4/4. The approach already shows the ears and the next fence, so the lens stays.

## NEEDS ERNIE

- Madison's legs stick straight out to the sides in the ride camera and from behind. That is the rig, not a one-line pose tweak. Backlog item 4 is closed for tonight.
- Abbott's face photo is smeared across the flat planes of the head. A new coat pass will not fix the mesh. Do not repaint the blaze.
- The bridle is a set of dark rods that float off the face. That is the same mesh limit. Backlog item 13 is closed for tonight.
- Unused files are listed, not removed. The proposal is the harvest textures that are still packed (about 466 MB), plus a few photos, loose coat maps, and `ambient_indoor.wav`. Say which of those can go before anyone deletes them.
- The trees are still stacked coins on poles. The orange was dulled to tan. A thicker clump was the same lollipop and was put back. A real tree needs a model.

## STASHED

## BLACKLIST

## Morning report

Written at the top of this file.
