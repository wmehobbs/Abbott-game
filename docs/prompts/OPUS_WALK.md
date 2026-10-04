# Opus — overnight, she walks this course

You are in `E:\Workspace\Madison`. This is the overnight job.
Work until the board and the playtest are written, or until
the walk line is a written negative. Do not stop after the
four lessons. Do not go to bed with a Godot still riding and
the table unwritten. If you finish, write `dist/STATUS.md`
and stop. Do not invent a rider channel after that.

Ernie is asleep. A Godot window locks the desktop. Never
open one. `--headless` is the first argument after the
console exe:

`C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Rides through `python tools/content_factory/run_ridecert.py`.
No windowed exe, no editor, no F5, no `--artshot`, no
`ride_ids.py`, no `dist\Abbott.exe`. One Godot. Timeouts:
one id 8 minutes, a style id 15 minutes, the full board
70 minutes. No `RIDECERT round` in 2 minutes is a compile
error: kill only that process. If the wrapper dies for
low memory, the Godot it already started is still the
ride. Wait for it. Do not start a second board. Do not
kill Godot to free RAM. Copy each `RIDECERT hk_…` line
out before the next id. The log is opened with `"w"`.

A probe is inserted once and stripped before a timed
ride. Do not leave one in the tree.

## What she walks into

The walk is a real mode. `C` and the title's walk put
`GameState.mode` on `"walk"`, `arena.gd` calls
`_enter_walk`, and the hint says how to walk. It does
not say which course this is.

Each ship course already has a `name`, a `height_label`,
and a `notes` sentence a person can say. `hk_les_001`
is "Tuesday poles" and "Same three as the lesson. Walk
him in. Don't chase the line." `hk_adv_002` notes are
"Mini Prix. Keep the canter. He has the scope if you
wait."

`walk_text` and `michelle_brief` are not that. They are
generator salad: "Walk twenty-two thousand seven hundred
twenty-seven" with the course id spliced in every few
words, from `tools/content_factory/fix_unique_text.py`.
Nothing in the ride reads them. Do not rewrite them. Do
not run `fix_unique_text.py` or `make_courses_mega.py`.
Do not edit a course file. A fence, a `notes` string, a
name, and a height label stay as they are on disk.

## What stays

The picture in `dist/STATUS.md` stays. Do not retune it.

- the halt, the nod, the elbows, the hips, the knee
  shares, the fold, the hands
- `horse.gd`, `bascule.gd`, `rider_mesh.gd`, `ride_ai.gd`
- the rein, the five landings, the tail hair, the late fist
- the crest, the hoof, the pastern, the beat, the camera
- `_school_from_round`, `result_line`, the pin, `_day_one`
- both course trees, including `walk_text`

You may change the walk's words: `arena.gd` `_enter_walk`,
`hud.gd` `set_walk_mode` / `walk_hint`, and a function
that builds one line from a course dictionary. You may
not change how the horse moves.

A keep, after the words are in and the probe is gone:

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, round complete. The knee board is
the floor: 21/23, `hk_int_007` 84.95. Outside a window,
revert the walk words. The picture stays.

## Step 0 — what the walk says now

No new sentence until this is in `dist/walk_002.md`.

Quote `set_walk_mode` and the `walk_hint` string. Quote
`walk_text` and `notes` for `hk_les_001` only, so the
salad and the real sentence are both on the page. List
the 23 ids in `game/content/courses/SHIP.json`. You
are not done when the four lessons are listed.

## The line

One function. Input is the course dictionary already
loaded for the round. Output is one string:

`{name}. {height_label}. {notes}`

That is the whole line. Do not append `walk_text`. Do
not append `michelle_brief`. Do not append the course
id. Do not number the serial in words.

On entering the walk, that line is what she sees in
`walk_hint`, and Michelle says it once
(`GameState.speak_soft`). The control hint can stay
on the other label. Entering the ride still says
`lesson_start` on a lesson, and does not repeat the
walk line. A cert round starts in ride mode. It must
not speak the walk line, and it must not load a
different course.

## All 23, before any clock

Print the line for every id in `SHIP.json`, headless,
through that same function. One table in
`dist/walk_002.md`:

| id | line |

A line fails if it contains the course id, the word
"thousand", or the word "meat", or if `name`,
`height_label`, or `notes` is missing from it. The
four lesson lines are four different strings. The
three jump-offs say what their own `notes` say.

Then one headless boot that actually enters the walk
on `hk_les_001` and prints the hint and the Michelle
line. It has to match the table row. Strip that boot
path before any timed ride. If the walk hint and the
function disagree, the walk is wrong. Fix the walk.
Do not fork a second sentence.

If you cannot show the line without editing a course
file or moving a fence, write the negative and stop.
Do not run a board.

## The pin is still the pin

Three clocks. Then style:

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear. B refused fence 1, 0 rails, Idle, hinds
0.053. C one rail on fence 3 in the air. Copy the
knock line. Style does not enter the walk.

One full `python tools/content_factory/run_ridecert.py`.
Render with `python tools/content_factory/board_table.py`.
The 21 within 0.1 s of the knee board, no new rail,
`teleported=false`. Headless `--playtest` after the
board line is copied: clear 0 / refuse 4 / rail 4.

If the board moves, revert the walk words.

## Write it

`dist/walk_002.md` holds the step-0 quotes, the 23
lines, the one walk boot, the three clocks, the style
lines, and the board.

Top of `dist/STATUS.md`: the walk line, that
`walk_text` was not rewritten, and the clocks from
the tree you left. A job that rewrites the generator
is not this job. A job that only reprints
`dist/lesson_003.md` is not this job.
