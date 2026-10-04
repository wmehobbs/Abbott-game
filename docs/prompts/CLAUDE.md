# Claude — ride job only

You are Claude. You own the rider and the 23-track board. Hidden K, Pfafftown.
One horse, one barn, one skill: seeing a distance and leaving with him.
Indoor is scenery. Michelle is not this job. 25k / 48k piles are archive.
Do not raise quotas. Do not export `dist/Abbott.exe`.

Repo: `E:\Workspace\Madison`
Godot: `C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

## Gate

If a `Godot_v4.7.2` process is live, assume Cursor playtest or a pack. **Do not
taskkill. Do not run `ride_ids.py` until those PIDs exit** — it kills stray
headless Godots and will murder a pack. Sit. Then ask.

## Board (verify, do not type)

`dist/ridecert_board.json` === `runA` === `runB`. 21/23, twice, teleported=false,
no rail on the board. Style A/B/C on `hk_beg_035` honest. `--playtest` PASS.
`prove_ship` PASS.

| id | result | time / 80 | notes |
| --- | --- | --- | --- |
| hk_adv_002 | CLEAR | 83.12 | 3.1 s over; 0 time faults (`floor((t-80)/4)`) |
| hk_adv_005 | CLEAR | 78.92 | under |
| hk_adv_001 | fail 2 | 91.59 | 12/12, 0 rails. Clear needs **t < 84** (7.6 s) |
| hk_adv_003 | fail 3 | 94.00 | 12/12, 0 rails. Clear needs **t < 84** (10.1 s) |

Schooling clock is 80, not the JSON 65.6. Cert success is 0 faults.

**Ignore `dist/ridecert_logs/*.log` for the board.** 001 log is 95.18 / 1 rail.
003 log is 105.12. 002 log is a 93.64 fail. Those are stale `ride_ids` leftovers.
Segments come from `dist/ridecert_godot.log` around the `RIDECERT round hk_adv_00*`
lines that match 91.59 / 83.12 / 94.00 / 78.92.

Board segments **into** that fence:

- 001: `1:3.9 2:7.5 3:9.4 4:3.5 5:4.6 6:9.7 7:12.4 8:9.6 9:12.8 10:5.3 11:3.5 12:5.5`
  Come-agains at **#7** and **#9**.
- 003: `1:4.2 2:3.5 3:3.5 4:10.1 5:10.4 6:11.8 7:9.0 8:5.5 9:7.4 10:12.6 11:7.5 12:4.6`
  Come-agains at **#6** and **#10**.

STATUS.md’s `3:12.3` and `11:17.6` are the stale logs. Do not plan from them.

## This job

One-fence `ride_place` is out of legal moves on these two. Extend it to move a
**labeled pair** rigidly, then ride.

**Only pair tonight: `hk_adv_003` #11 and #12.**

What it actually is (not the 31 s story):

- #11 `(-4.40, -7.94)` yaw 3.12 — plank vertical, labeled 2-stride to #12, 10.8 m
- #12 `(-4.12, -18.74)` yaw 3.20 — plank vertical
- Gap 10.800, yaw delta 0.08, band 10.4–11.2. Already a distance.
- Board ride: into #11 **7.5 s** (no come-again), into #12 **4.6 s**. Cheap.
- The clock is the **12.6 s come-again into #10**. #10 has no legal solo
  placement (`place_fence.search` returns `[]` under the leash, and it is not
  labeled). Moving the out is the only legal way to change that rollback.

Killing #10’s come-again is maybe ~6 s. 003 needs 10.1 s to clear. This pair
alone may not be 23/23. A faster 003 with 0 rails and the 21 intact is a keep.
88 s is still a fail. Do not then relax a constraint to invent the rest.

Do **not** start `hk_adv_001` tonight. Both of its relateds are **chains of
three** (3–4–5 and 9–10–11). Moving two ends of one label walks the shared
fence out of the other band.

Do **not** call `place_fence.search` on #11. It returns `[]` because it is
labeled. That is why the tool must grow.

## How to move the pair

Translate + one extra yaw, applied to **both** ends. Distance stays in
10.4–11.2 (today 10.8). Relative yaw stays. Kind, height, spread, number,
label stay. Each end: ≤ 7 m from **its own** shipped pos, ≤ 40° from **its
own** shipped yaw. Do not move #10. Write both trees
(`game/content/courses/` and `content/courses/`), byte-identical.

Hard constraints — nothing relaxed (same as `place_fence.search`):

- prove’s 85° / 12 m and approach `dot >= 0.20` on 10→11 and 11→12
- `run >= 8` in, `>= 5` out
- `seg_clear` on the path out
- ring; landing on the sand; 6.6 m; corridor 3.9
- no unlabeled no-band line
- 7 m leash, 40° cap
- `prove_ship` green before every ride

`ride_ai._on_related_line` is geometry, not the JSON tag: gap 6.2–16.5, yaw
< 0.40, colinear > 0.88. Break that and he sits the land between elements.

## How to score

Godot wall time. Write, prove, ride. Keep only if faster by ≥ 0.2 s, **zero
rails**, round completes. Else put **both** fences back exactly. Same as
`ride_place.py` for one fence.

Score from the ride log you just wrote, then a full `--ridecert` twice if you
keep. Render with `python tools/content_factory/board_table.py`. Do not type
the table.

## When to revert / stop

- Slower, any rail, prove red, round incomplete
- Any of the 21 moves more than 0.1 s or picks up a rail
- Band lie
- **Stop if 21 regresses**

## Do not put back

old `_reapproach` timer; pure pursuit; steer past wing; commit rein on any
aim error; blunt arc path check; turn-fit scoring; deepen every plane 0.125;
sequential yaw+clash; ROOM-scored `--sweep`; relaxing prove / `seg_clear` /
40° / 7 m to invent candidates.

Leave windows TAKEOFF 2.55 untouched. Pin 85/80/44/38/36. `_cc` away then
again. Sit held on the turn onto the line. `_would_knock` thru =
`1.10 + spread*0.5`. Knock Area stays
`(width*0.9, height+0.15, 0.35+spread)`.

## 23/23 twice looks like

`board=23/23`, `pass=true`, runA === runB, 001 and 003 `time_sec < 84`,
0 rails, 12/12, `teleported=false`, style A/B/C honest, prove green,
playtest PASS. Then it is a cert. Do not export.

Grok has people. Cursor has trees in `farm.gd`. Stay off those files.
A fence you land past is not a distance.
