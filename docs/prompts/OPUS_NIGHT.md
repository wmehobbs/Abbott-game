# Opus — the two clocks

You are in `E:\Workspace\Madison`. Hidden K, Pfafftown. One horse, one ring.
The game is seeing a distance and leaving with him. Craft bar is a short,
finished place. Not a career sim. Not another prop.

Read `dist/STATUS.md` and `dist/RIDE_CERT.md` before you edit anything.
Then re-measure. If a number below disagrees with the log you just wrote,
the log wins.

## Silent

Ernie is at the machine for the next two hours, in other windows. A Godot
window or `dist\Abbott.exe` locks the desktop: mouse dead, keyboard dead,
his work stopped. That is a failed run even if the ride is right. He does
not want a window every five minutes. Headless only, the whole evening.

One binary. `--headless` is the first argument after it. If it is not, do
not run the command.

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides go through `python tools/content_factory/run_ridecert.py`, which
already passes `--headless` and creates no window. A single id is
`python tools/content_factory/run_ridecert.py --ridecert-id=hk_adv_001`.
Playtest, when you get there, is the same exe, `--headless` first, then
`--path game -- --playtest`. Stdout is the evidence. Read the log.

Do not run:

- `Godot_v4.7.2-stable_win64.exe` (the one with a window)
- Godot with no `--headless`, the editor, a debug window, F5, F6
- `dist\Abbott.exe`, `Start-Process` on it, or "just to see"
- `--artshot`, `--artshot-rider`, or any screenshot pass
- `ride_ids.py` — it taskkills every Godot on the machine

One Godot at a time. If one is already running, sit. Do not start a second.
If a window appears anyway, close it and do not retry that command. Write
the command in `dist/STATUS.md` so it is not run again.

## Gate

If a `Godot_v4.7.2` process is live, someone is riding or packing. Do not
taskkill. Sit until those PIDs exit.

## The board you are inheriting

Pinned horse, every round: confidence 85, scope 80, rideability 44,
timing 38, feel 36. Do not change the pin. Cert success is 0 faults.
Schooling time allowed is 80. Time faults are `floor((t - 80) / 4)`, so a
clear is **t < 84**. Both failures jump 12/12 with **zero rails**. They lose
on the clock alone.

Last measured pin board, 24 Sep, twice, `teleported=false`:

| id | result | time | needs |
| --- | --- | ---: | --- |
| hk_adv_002 | CLEAR | 83.1 | already under |
| hk_adv_005 | CLEAR | 78.9 | already under |
| hk_adv_001 | 2 time faults | 91.6 | **7.6 s** |
| hk_adv_003 | 3 time faults | 94.0 | **10.1 s** |

The other 19 are clears. Style on `hk_beg_035` is honest: A clear, B a
refusal at fence 1, C one rail at fence 3. `--playtest` is clear 0 /
refuse 4 / rail 4. `prove_ship.py` passes.

**Ignore `dist/ridecert_logs/*.log`.** Those are stale `ride_ids` leftovers
and they disagree with the board. Segments come from the log of the run
you just rode.

Last board segments, time **into** that fence:

- `hk_adv_001`: `1:3.9 2:7.5 3:9.4 4:3.5 5:4.6 6:9.7 7:12.4 8:9.6 9:12.8 10:5.3 11:3.5 12:5.5`
  Come-agains at **#7** and **#9**.
- `hk_adv_003`: `1:4.2 2:3.5 3:3.5 4:10.1 5:10.4 6:11.8 7:9.0 8:5.5 9:7.4 10:12.6 11:7.5 12:4.6`
  Come-agains at **#6** and **#10**.

## What is already closed

Do not open these. They were built, ridden, and rejected. A faster geometry
score made the horse slower. Detail is in `dist/RIDE_CERT.md`.

- Single-fence `ride_place` / `place_fence.search` on the slow fences.
  `hk_adv_001` #7's only legal candidate was 5 s faster **and rolled a pole**.
  `hk_adv_003` #6 and #7 were four candidates deep, all slower.
- Rigid pair, `hk_adv_003` #11+#12. Gap held at 10.800. All four legal, all
  slower (107–116 s).
- Rigid triple, `hk_adv_001` 9–10–11. One legal pose. Ridden: 117 s, 1 rail.
  Chain 3–4–5 had zero legal poses. Leash was not loosened.
- ROOM-scored `--sweep`. Converged, prove green, ride worse (002 and 005
  went from the high 80s to 108 s).
- Moving a fence you land past, deepening every knock plane, turn-fit
  scoring, arc-aware path checks, pure pursuit, the old `_reapproach = 2.2`
  timer, steering past the wing, committing the rein on any large aim error.

Course JSON is frozen. Both trees (`game/content/courses/` and
`content/courses/`) stay byte-identical to what is on disk now. Kind,
height, spread, number, labels, bands, leash, 40° cap, prove rules: not
yours tonight.

## The one fact you do not get to relitigate

`hk_adv_001` #7 was instrumented and classified. He entered the come-again
crooked: along 4.1 m (inside 4.4), angle 118.9° (past 26°), 8.91 m off the
line. Not a straight shot. Away ended on heading at 0.45 s. Again ended
because along reached 12.0 with on_line 0.43, and he was **still 114.8° off
the fence**. He then got straight and jumped it clean. The 12.4 s is the
price of not putting a shoulder through the plane.

Driving on from that entry is a rail. Deleting the come-again is a rail.
Exiting the circle earlier while he is still across the fence is a rail.
The circle is the correct ride **given the arrival**. The time has to come
from arriving so he does not need it, or from a shorter circle that still
delivers him straight. Measure both. Do not guess.

Same shape on the other three slow segments. Read them the same way before
you change a number.

## This job

Get `hk_adv_001` and `hk_adv_003` under 84 seconds, 12/12, zero rails,
`teleported=false`, without slowing a clear, without adding a rail anywhere,
and without moving a fence.

You may edit **`game/scripts/ride_ai.gd` only** until that is true.
He already has the keys a person has: gait, steer, half-halt, ask, halt,
and the come-again. Same keys. No teleport. No `present(`. No second
controller. No path that ignores a standard.

You may not edit, until the final board below is green:

- `horse.gd` — leave windows, `TAKEOFF` 2.55, `collect_pulse`, `GAIT_SPEED`,
  turn rate, `land_recover`, the jump parabola, the knock test
- `ride_cert.gd` — the pin
- `game_state.gd` — faults, allowed time, elimination
- course JSON, `place_fence.py`, `ride_place.py`
- `farm.gd`, `person_look.gd`, `abbott_look.gd`, `rider_mesh.gd`, Michelle,
  audio, shaders, meshes
- `playtest.gd`, `arena.gd`

A faster horse is not a faster ride. A wider leave is not a distance.
A come-again that never fires is a shoulder through a pole.

## How a change is allowed to survive

0. Before any edit, ride `hk_adv_001` and `hk_adv_003` once each with
   `--ridecert-id`. Write down faults, rails, time, come-again fences.
   If they are not the clock-only fails above, stop and say what the tree
   actually does. Do not "fix" a board you have not reproduced.

1. Change the rider. Ride **only** those two ids. Keep the edit only if
   both rounds still finish, rails stay 0, and the slower of the two
   improvements is real (at least 0.2 s on the one you meant to help, and
   the other is not slower by more than 0.1 s and gains no rail). Otherwise
   put `ride_ai.gd` back.

2. Do not stack a second idea on a revert. One hypothesis, one ride, keep
   or discard. A log line you added to see the arrival comes back out
   before the cert.

3. When **both** are under 84 with 0 rails, run the full `--ridecert`
   **twice**. Render with `python tools/content_factory/board_table.py`.
   Do not type the table. Then `--playtest` and `prove_ship.py`.

## When to revert

- Any rail on 001 or 003, including a rail you then "rode off"
- A round that does not finish, a timeout, a teleport, a hang
- Any of the 21 moves more than 0.1 s, or picks up a rail, or loses a clear
- Style B no longer refuses fence 1, or style C no longer knocks one rail
  in the air, on `hk_beg_035`
- Playtest is not clear 0 / refuse 4 / rail 4
- You bought the time by sitting less on a related line, dropping a gait,
  cutting a corner through a standard, or raising speed anywhere in
  `horse.gd`

If the two clocks will not come in under those rules, revert `ride_ai.gd`
until it is byte-identical to the file you started from, and write the
proof in `dist/STATUS.md`: what you rode, the times, where he still
came again, and why the next idea would be one of the closed doors.
A true negative is a finished night. A railed 22/23 is not.

## Do not put back

old `_reapproach` timer; pure pursuit onto the line; steer past the wing;
commit the rein on any aim error; blunt arc path check; turn-fit scoring
of detours; deepen every knock plane; ROOM-scored sweep; relaxing prove,
`seg_clear`, the 40° cap, or the 7 m leash; skipping a fence; editing the
scorer; changing the pin to the fresh-horse numbers. The fresh horse also
fails these two on time. He is not a solution.

Leave the come-again as a committed circle: away, then back up the line.
`_would_knock` stays `thru = 1.10 + spread * 0.5`. Knock volume stays
`(width * 0.9, height + 0.15, 0.35 + spread)`. Sit stays held while there
is still a turn onto the line. He still shies off a standard that is
straight ahead. He still does not take the unchecked shortcut to the setup.

## 23/23 twice looks like

`board=23/23`, `pass=true`, the two full runs agree within 0.1 s, 001 and
003 `time_sec < 84`, 0 rails, 12/12, `teleported=false` on every round,
style A/B/C honest, prove green, playtest PASS. Append that table to
`dist/STATUS.md` from `board_table.py`, not from memory.

Then, and only then, one export, after every ride is finished and no Godot
is running. Same console exe, `--headless` first:

`--headless --path E:\Workspace\Madison\game --export-release "Windows Desktop" E:\Workspace\Madison\dist\Abbott.exe`

Bump the product version by one patch from whatever `dist/Abbott.exe` is
now (last packed was 2.348.0.0). Date created stays 2026-09-12 08:34:04.
Do not launch the exe. Do not export at all if the board is not 23/23 twice.

If you do not have 23/23 twice, do not export. Do not touch the look.
Do not plant a tree, rewrite a face, or add a sentence for Michelle.
The round sings when both Mini Prix are clears a person could believe,
ridden with the same hands he has now.

Grok has people. Cursor has trees. Stay off those files.
A fence you land past is not a distance. A metric that slows the horse
is not a metric. A circle you delete is a rail.
