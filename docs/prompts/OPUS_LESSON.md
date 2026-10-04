# Opus — the lesson she sits

You are in `E:\Workspace\Madison`. The rider picture is
in the files. This job is the game a person starts.
Do not stop after the course list. Do not stop after
the first ride. Work until the lesson, the horse she
brings home, and the card have each been printed, and
each one is either already true or kept.

A new game starts at confidence 48, scope 40,
rideability 44, timing 38, feel 36. That is day-one.
The picture reads those numbers. The pin on the board
is the schooled horse, confidence 85. Do not change
`_pin_stats` or `_day_one`.

The design of the lesson is: trainer on the rail,
poles to a single fence to a related line, takeoff
marks in the lesson only, one true sentence after
each leave. Schooling and the show come after.

Do not chase 23/23. Do not edit `ride_ai.gd`. Do not
move a fence. Do not edit the shin shares, the fold,
the trot plus, or the roll. Do not export in this
job. Do not launch `dist\Abbott.exe`. The exe on
disk is still `THU SEP 24 · 2.348.0.0`. Leave it.
A window locks the desktop.

## Silent

Ernie is at the machine. `--headless` is the first
argument after the console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`.
No window, no editor, no F5, no `--artshot`, no
`ride_ids.py`. One Godot. One id 8 minutes, a style
id 15, the full board 70. No `RIDECERT round` in 2
minutes is a compile error: kill only that process.
If the wrapper dies for memory, wait for the Godot
that is already riding. Do not start a second board.
The log is opened with `"w"`. Copy each `RIDECERT`
line and each `MICHELLE` line into `dist/lesson_003.md`
before the next id.

## Step 0 — the four lessons, before any code

`game/content/courses/SHIP.json` lists the lesson as
`hk_les_001` through `hk_les_004`. Read each course
JSON. For every fence: number, kind, height. Name
any related line (the stride count between two
fences, from the file, not from a guess).

Then one headless pin ride:

`python tools/content_factory/run_ridecert.py --ridecert-id=hk_les_001`

Copy every `MICHELLE` line and the `RIDECERT` line.
The words on that course were Two. Wait. / One.
Wait. / One. Early. / Early. / Wait. / Now. then
one sentence. Write what this ride actually said.

The lesson is already the design when all four
courses are short (not a 12-fence prix), the first
fence is not a 3' oxer, a related line is present
on at least one of them, and the ride above ends
with one true sentence after the leaves. Write
that. Do not move a fence to make it prettier.

If a course is a prix wearing a lesson name, write
the fence list and stop that phase. The board rides
these ids. You do not edit them.

## Phase 1 — the horse she brings home

Only if step 0 did not have to stop.

A person does not ride the pin. They ride day-one,
and a clear is supposed to quiet him. One fresh
ride:

`python tools/content_factory/run_ridecert.py --ridecert-fresh --ridecert-id=hk_les_001`

Before the first fence and after the round, print
confidence, Neck1, and Tail1. The picture job
already measured a clear moving Neck1 from about
−5° toward −8° and the tail down with it. If this
ride does that, the school is already in the
picture. Write the numbers. Do not change
`_school_from_round`.

If the clear leaves him as worried as the start
(Neck1 still within 2° of the start, tail still
within 2°), one look at `_school_from_round`. The
deltas are arithmetic and they stay the rules.
The bug would be the picture not reading the
stats the school wrote. Fix the read, not the
deltas. One attempt. If you cannot show 3° of
neck or tail between the start and the end of a
clear without editing the deltas, write the
degrees and revert.

The next pin `hk_les_001` must still finish at
confidence 91.0, not near 50. If the fresh ride
leaked, revert.

Three clocks if you changed code:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. Outside a
window, revert. The knee board is the floor:
21/23, worst move 0.04 s on `hk_beg_034`,
`hk_int_007` at 84.95. Do not run a full board
unless you kept code.

## Phase 2 — the card

`game_state.gd` `result_line` is the card. From
the source, write the sentence it would show for:

- a lesson clear
- a show clear inside the time
- a show round with time faults and no rail
- a rail on fence 3
- a refusal on fence 1
- elimination, three refusals

A card lies if a clear with time faults says
Clear, or a lesson says jump-off, or a rail does
not name the fence. If none of those lies are in
the function, the card is already true. Write
the six sentences. Do not reword a true card.

If one lie is in the function, fix that branch
only. One attempt. Then the three clocks, and
one full board only if the card change could
touch a round. A string change does not. Do not
run the board for a string.

## Write it

`dist/lesson_003.md` holds the four course lists,
the Michelle lines, the fresh horse before and
after, and the six card sentences.

Top of `dist/STATUS.md`: what the lesson is, what
the clear does to him, and what the card says.
The knee paragraph stays under it. A job that
moves a fence is not this job. A job that edits
`ride_ai.gd` is not this job. A job that packs
`dist\Abbott.exe` is not this job.
