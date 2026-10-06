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
| T8 | done | this commit | selftest 15/0, playtest 0/4/4, les 25.43, beg 62.14 jo 33.44 | D-pad gait, stick steer, prompts follow the last device. |

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

## NEEDS ERNIE

- Madison's legs stick straight out to the sides in the ride camera and from behind. That is the rig, not a one-line pose tweak. Backlog item 4 is closed for tonight.
- Abbott's face photo is smeared across the flat planes of the head. A new coat pass will not fix the mesh. Do not repaint the blaze.
- The bridle is a set of dark rods that float off the face. That is the same mesh limit. Backlog item 13 is closed for tonight.

## STASHED

## BLACKLIST

## Morning report

Filled at T19.
