# Grok Build — next day, headless, she can hear it

You are Grok Build in `E:\Workspace\Madison`. Ernie is at the machine and will not watch you. A Godot window locks the desktop. The game stays closed. Tokens are cheap. Another fence move is not.

Product stays **2.348.0.0**. Do not bump it. Do not export. Do not launch `dist\Abbott.exe`. Its last write is 24 September. Leave it.

Godot, console build only:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

Yesterday is done. Read `dist/DAY_LOG.md` and `dist/DAY_MEASURE.md` before you edit. Do not overwrite them. This day writes `dist/DAY2_LOG.md` and `dist/DAY2_MEASURE.md`.

## What yesterday settled

Coaching stays. Schooling and show hear Two / One / word while `madison_timing < 55`. The cert horse is pinned at 38, so she heard it. Speech did not move the horse. The board is still **21/23**. Every morning clear still clears. Largest move on a clear was `hk_beg_004` **+0.05 s**. `hk_adv_001` is **91.61 s**. `hk_adv_003` is **93.99 s**. No new rail. No teleport.

Three legal placements were ridden and put back. Both course files match `dist/course_backup/`. `hk_adv_003` fence 9 went to 100.95 s. Fence 6 went to 96.41 s and moved the circle onto fence 7. `hk_adv_001` fence 7 went to 85.88 s and knocked fence 6. Nothing else on those two courses has a legal spot that keeps a labeled distance. **Do not run `place_fence.py`. Do not edit a course file. Do not edit `ride_ai.gd`.**

The canter stride is 3.246 m. The spoken divisor stays 3.35. That 0.104 m gap was inside the gate. Leave it. Flowers at confidence 48 do not look. The ideal band with charge under `balance_need` is a spot, not a chip. Leave the leave math alone.

## Silent

`--headless` is the first argument after the exe. If it is not, do not run the command.

Rides go through `python tools/content_factory/run_ridecert.py`. It already passes `--headless` and `CREATE_NO_WINDOW` and writes UTF-8. Use it. Do not redirect Godot through PowerShell.

Playtest:

`Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game -- --playtest`

One Godot. If any Godot is already running, do not start another and do not taskkill it. Python only until it exits. Write `WAIT` in `dist/DAY2_LOG.md`.

Forbidden all day: `dist\Abbott.exe`, the editor, F5, F6, `--artshot`, `--artshot-rider`, a second Godot, export, pack, a version bump.

If a window appears, close it, write the command under `BLACKLIST` in `dist/DAY2_LOG.md`, and do not retry it.

## The hole

`GameState.speak` holds `trainer_until` for **3.8 s** and sets `last_leave`. `speak_soft` then returns without speaking when `trainer_until > 1.4` and `last_leave` is set. The print is after that return, so a swallowed count is not in the log.

A leave sentence lasts 3.8 s. Canter is 5.55 m/s. A one-stride related is about 7.5 m of ground, jump included, which is on the order of two seconds from one leave to the next Two. The count into the next fence lands inside the hold. Yesterday's coaching can be silent on every fence after the first, which is where she needs it.

The other hole is when the teacher stops. A clear adds **+4** to `madison_timing`. Day one is **38**. The hear line goes quiet at **55**. Four clear lessons land on 54. The fifth clear, the first good crossrail, silences schooling and show. Now is 1.28 m at beginner, 1.10 m at intermediate, 0.97 m at advanced. She loses the count before the window gets narrow. Do not change the +4. Change who still gets to hear it.

On a come-again the count is already silent: `_lesson_count` clears the word when `lateral > 1.6`. That is `hk_adv_001` fences 7 and 9 (run a few meters, offset 9–16 m) and `hk_adv_003` fences 6 and 10. A person gets no word on the fences that are not a straight line. The AI already circles. Do not make the circle faster.

## Frozen

Do not edit:

- TAKEOFF, early / late / ideal, `window_scale`, `refuse_scale`, `balance_need`, `GAIT_SPEED`, `GAIT_TURN`, `STRIDE_HZ`, the 3.35 divisor
- `_school_from_round` deltas
- The knock box `(width*0.9, height+0.15, 0.35+spread)`
- Any course JSON, either tree
- `ride_ai.gd`, `person_look.gd`, `abbott_look.gd`, `rider_mesh.gd`, `farm.gd`
- `NEAR_FENCE_M` 4, `AT_FENCE_M` 1.5, `LINE_CORRIDOR_M` 2
- The 25k archive, quotas, `content/rail/michelle.json` (the 48k pile)
- Sand and wood albedo
- `LESSON_BEATS.json`

No new horse, class, fence kind, indoor class, Jev, or LLM.

## Budget

Yesterday's coaching board is the baseline. Do not spend 70 minutes re-riding it before an edit. The times are in `dist/DAY_MEASURE.md`.

You may run **one** full `python tools/content_factory/run_ridecert.py`, and only after the swallow fix is in. Single-id rides are the ordinary proof. Playtest is the compile check.

Do not ask Ernie. Decide from the log. No measured reason, no edit. Append `dist/DAY2_LOG.md` after every keep and every revert, before the next edit.

Comparison rule, same as yesterday: every id that cleared still clears, no new rail, no teleport, no clear moves more than **0.1 s**. The two clock courses may move 0.3 s and must not gain a rail.

## Phase 0 — gate, short

1. `Get-Process *Godot*`. If one is live, Python only.
2. Headless `--playtest`. Clear 0, refuse 4, rail 4, knock fires, `pass=true`. If it fails, fix that and stop feature work until it passes.
3. From yesterday's logs (`dist/ridecert_hk_beg_033_coaching.log` and `dist/ridecert_godot.coaching.log`), count `MICHELLE soft` lines per course and, where the log has a fence number nearby, per fence. Write the counts in `dist/DAY2_MEASURE.md`. If `hk_beg_033` already shows a Two or a One on at least six of its eight fences, the swallow is not the bug. Skip phase 1 and write why.

## Phase 1 — the count may speak over a sentence that has had its turn

Only if phase 0 shows the count dying after a leave.

In `speak_soft`, a stride line may speak even when `trainer_until > 1.4`. A stride line is one that starts with `Two. ` or `One. `, or is exactly `Wait.`, `Early.`, `Now.`, or `Too deep.`. Walk lines and everything else still yield. Do not shorten the 3.8 s hold. Do not clear `last_leave`. When a soft line is dropped, print `MICHELLE soft dropped |` plus the line, so the next log shows the swallow instead of hiding it.

This still must not press a key or change speed, charge, gait, or the ask.

Proof, in order:

1. Playtest. Clear 0 / refuse 4 / rail 4. Knock fires.
2. `run_ridecert.py --ridecert-id hk_les_001` and `--ridecert-id hk_beg_033`. Both clear, `teleported=false`, within 0.3 s of yesterday (18.54 s and 59.87 s). The beginner log shows a Two or a One on more fences than phase 0 counted. The lesson still shows Two / One / Now.
3. One full `run_ridecert.py`. Compare to the coaching table in `dist/DAY_MEASURE.md`. Same 0.1 s rule. Copy the new board to `dist/day2_board.json` before anything else overwrites `dist/ridecert_board.json`. If any clear breaks, revert `speak_soft` and stop. Do not tune around it.

## Phase 2 — a new height still hears the count

Python only, first. Simulate `_school_from_round` from day-one stats (48 / 40 / 44 / 38 / 36). Write a table in `dist/DAY2_MEASURE.md`: timing after each clear lesson, then after each clear beginner, intermediate, and advanced round. State the round on which timing crosses 55. Do not change the deltas.

Then change the hear line in `_lesson_count`, and nowhere else. Lesson always hears it. Schooling and show hear it while `madison_timing < 55` **or** `int(GameState.clears.get(GameState.class_id, 0)) < 2`. Two clears at 2'3" may silence Crossrails. Zero clears at 2'6" still hears it. Same words. Same `speak_soft`.

The cert pins timing at 38 and does not post clears between fences, so a board run still hears it for the same reason as yesterday. If phase 1's full board already passed, do not run another. Proof is:

- A headless probe, new user arg `--hear` beside `--playtest`, that prints the hear flag at timing 38, at timing 60 with beginner clears 0, at timing 60 with beginner clears 2, and at timing 60 with intermediate clears 0. Expected: hear, hear, silent, hear. Then quit. No arena ride.
- Playtest still passes.
- `--ridecert-id hk_beg_033` still clear, within 0.1 s of the phase 1 time, count still in the log.

If the probe is wrong, revert the hear line. If the single id moves more than 0.1 s or gains a fault, revert. You do not get a second full board for this.

## Phase 3 — Come again, only on the fences that are not a line

Only after phase 1 is kept. Read yesterday's segment note. The count is silent when `lateral > 1.6`, which is the come-again.

Add one soft sentence, `Come again.`, from `_lesson_count` or a neighbor in `horse.gd`. It may fire only when all of these are true: canter, not jumping, hear is on, the next fence is in front, `lateral > 1.6`, and there is not room to see a Two (the straight run to the plane is under 8 m, or she is already inside 6 m and still not lined). It uses the same stride bypass as phase 1, so a leave sentence cannot eat it. It must not fire on a straight approach.

Do not edit `ride_ai.gd`. Do not move a fence. Do not change how the circle is ridden.

Proof:

- `hk_les_001` and `hk_beg_033`: the log contains **zero** `Come again.` Both still clear, within 0.1 s of the phase 1 times.
- `hk_adv_001`: the log contains `Come again.` on the approach to fence 7 or fence 9, faults still time-only, no rail, time within 0.3 s of 91.61 s.
- If the lesson or the beginner says it, revert. If the Mini Prix gains a rail, revert. No full board.

If you cannot state the predicate from `ahead` and `lateral` already computed in that function, skip this phase. A nag on a straight line is worse than silence.

## Phase 4 — she can tell what just happened

`game/content/rail/michelle_ship.json` only. Not the 48k pile.

Yesterday's weak ids, the ones that give a correction and never name the event:

- early: `early_06`, `early_08`, `early_11`, `early_15`
- deep: `deep_14`
- chip: `chip_08`, `chip_15`
- spot: `spot_13`
- straight: `straight_15`
- looked: `looked_10`

Remove those objects from their key's array. Do not write a new sentence. Do not reorder the rest. Each of those keys must still have at least 8 lines. Leave, wrong, and halt stay as they are.

Then score the other 192 lines (rail, refuse, off course, time, clear, ribbon, steady, walk, pat, and the rest) the same way: a rider who hears only that sentence cannot tell what just happened. Append the weak ids to `dist/DAY2_MEASURE.md`. Remove a line only when its key still has at least 8 that name the event. Cap removals in this second pass at 24. If a key would drop under 8, leave it and write the ids.

Playtest. No ride cert. Which sentence she picks does not move the horse. If playtest fails, put the JSON back.

## Phase 5 — fill what is left

If the phases above are kept or skipped, do not invent a feature. Append to `dist/DAY2_MEASURE.md`:

- Soft-line counts per fence on `hk_beg_033` before and after phase 1
- The career table from phase 2
- Whether `Come again.` showed on the two Mini Prix fences and stayed off the lesson
- The Michelle ids removed, and the ones you left because the key would have gone thin

## Stop

Stop, close `dist/DAY2_LOG.md`, and do not start another Godot, when any of these is true:

- Phase 1 is kept or reverted, phase 2's probe matches or was reverted, phase 3 was kept, reverted, or skipped, and phase 4's playtest passed
- The one full board has finished and a later edit would need a second one
- A window appeared
- You are about to edit a course, `ride_ai.gd`, a leave band, a school delta, or the knock box

The last lines are: playtest result, board score against yesterday's coaching table, files changed, commands blacklisted, and that `dist\Abbott.exe` was not launched and not rewritten.
