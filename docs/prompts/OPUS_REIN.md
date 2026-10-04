# Opus — the rein follows the neck

You are in `E:\Workspace\Madison`. The pastern is kept. The board is
21/23. Do not edit `ride_ai.gd`. Do not move a fence. Do not export.
Do not launch `dist\Abbott.exe`. Do not touch the hoof placement in
`bascule.gd`.

The rein was a true negative under the last rules, and the rules were
the problem. One crest point cannot clear the posed neck mesh without
0.214 m of extra rein. Held to a hand of slack, the best point is
still 4.7 cm inside. A point moved every frame still needs 9.5–12.5 cm
extra at the jump. The old length test was also wrong: the straight
rein is already 1.635 m on a canter sample, because the gallop clip
nods the head. "Within 10 cm of 1.357" is withdrawn.

A rein lies along a neck. Two bends on the same rein are allowed.
Her fists stay where they are.

## Silent

Ernie is at the machine. Headless only. `--headless` is the first
argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`. No
windowed exe, no editor, no F5, no `--artshot`, no `ride_ids.py`.
One Godot. Timeouts: one id 8 minutes, a style id 15 minutes, the
full board 70 minutes. No `RIDECERT round` in 2 minutes means a
compile error: kill only that process. If the wrapper dies for
memory and Godot is still riding, wait for `RIDECERT done`. Do not
start a second board. Copy `ridecert_results.json` onto
`ridecert_board.json` only after that line is in the log.

## What you may build

`_make_reins` / `_update_reins` in `horse.gd` only, plus markers those
functions own. One rein a side. Three segments: bit ring, a point
along the neck, a second point closer to the withers, then the glove
that already exists. Same leather, same thickness. Not a second
bridle, not a new bit, not a pair of draw reins.

The two points ride neck bones (`Neck1`, `Neck2`, `Neck3`, or the
ones you measure). They may slide along the bone as the neck bends.
They may not move her fists. Fists stay within 0.02 m of the withers
spot you already have, through the canter, the jump, the land, and
the refusal.

Clearance is the signed distance to the posed neck mesh, the same
reconstruction as this morning (vertices skinned from the posed
skeleton). Every sample at least 1 cm outside the mesh:

- canter, including the nodded frame where the straight rein is long
- clear jump u 0.20, 0.55, 0.85, 1.00
- chip at u 0.55
- land at 0.15 s and 0.40 s
- refusal at 0.10, 0.25, 0.50 s

Length, per sample, against that sample's own straight rod from bit
to glove: the three segments together may be at most 0.13 m longer.
That is the jump's measured minimum detour, and it is the budget.
A bend that folds back so a segment runs toward the bit is slack,
whatever the length says. The bit stays the bit. The glove stays the
glove.

If two bends still leave any sample inside the mesh inside that
budget, revert the rein code. Write the worst clearance and the
extra length it would have taken. Do not add a fourth segment. Do
not lift her hands. That is the end of the rein.

## The clock

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`. Crest at u 0.55 stays round +15.0, Neck1 −21.4,
fore cannon −30.2. Chip stays round 0.0. Fore hooves at the thud
within 2 cm of 0.053. Pastern gap stays within 3 cm. If a ride moves
any of those, the rein is not the cause: revert it.

Three clocks after the rein is in. Style only if a segment crosses
the neck on the chip or the refusal:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear, B refused fence 1, 0 rails, no `Gallop_Jump`, C one rail on
fence 3 in the air.

## If the rein is in, or if you reverted it

One thing from last night is still open, and it is not the rein.
The first beat after a gait change lands in the clip blend: the
walk's first beat has all four hooves down, the first trot beat only
gets a fore hoof to 0.076, and the first canter beat is all in the
air. The steady strides are already right. Fix the blend so the
striking hoof of that first beat is at contact height and another
hoof is up, without changing `STRIDE_HZ`, `GAIT_SPEED`, or the
pastern. Three clocks again. If it will not hold, revert the blend
and keep the steady strides.

## Board

One full `python tools/content_factory/run_ridecert.py` only if you
kept the rein or the blend. Render with
`python tools/content_factory/board_table.py`. The 21 within 0.1 s,
no new rail, `teleported=false`, style A/B/C honest. Headless
`--playtest`: clear 0 / refuse 4 / rail 4. If the board moves, revert
what this prompt added. The pastern stays.

Write the clearance table and the three clocks at the top of
`dist/STATUS.md`. A rein inside the neck is not a rein. A fist that
moved to clear it is not a seat.
