# Diagonal proposals — do not apply

Brief for a later agent. Live board only. Kind / height / spread / number /
related band kept. No course JSON was written. `fix_board_lines.py` and
`patch_line_clashes.py` were not run.

Walked with `python tools/content_factory/walk_courses.py`.

Rule this file cares about: landing 15–17 m off the next fence's line,
with 2–7 m of run left on that line. Yaw the fence along the diagonal from
that landing to the standard, then slide 1.5 m toward the landing
(perpendicular to the current heading) so the crossing becomes a straight
approach.

Yaw is Godot: `atan2(dx, dz)`, degrees. Slide side is from the horse:
left = +lateral in the fence's local X.

The rider cannot use a re-walked Mini Prix until he can come again.

## Hits (15–17 m off, 2–7 m run)

| id | from | # | kind | h m | spread m | related | off m | run m | yaw now | yaw diag | delta | slide |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| hk_beg_035 | 1 | 2 | vertical | 0.606 | 0.0 | — | 16.5 | 6.1 | 4.0 | −65.7 | −69.7 | 1.5 m right |
| hk_beg_034 | 1 | 2 | vertical | 0.613 | 0.0 | — | 16.5 | 2.2 | 4.0 | −78.5 | −82.5 | 1.5 m right |
| hk_beg_007 | 1 | 2 | vertical | 0.607 | 0.0 | — | 15.6 | 2.8 | 4.0 | −75.9 | −79.9 | 1.5 m right |
| hk_beg_033 | 4 | 5 | oxer | 0.655 | 0.415 | — | 15.1 | 5.8 | 0.0 | 68.9 | +68.9 | 1.5 m left |
| hk_int_001 | 3 | 4 | flower | 0.775 | 0.0 | — | 15.3 | 2.1 | 4.0 | −78.0 | −82.0 | 1.5 m right |
| hk_int_001 | 5 | 6 | vertical | 0.835 | 0.0 | — | 15.5 | 5.6 | 4.0 | −66.2 | −70.2 | 1.5 m right |
| hk_int_002 | 2 | 3 | flower | 0.767 | 0.0 | — | 16.1 | 3.8 | 0.0 | 76.9 | +76.9 | 1.5 m left |
| hk_int_005 | 1 | 2 | vertical | 0.746 | 0.0 | — | 16.1 | 3.8 | 4.0 | −72.7 | −76.7 | 1.5 m right |
| hk_int_005 | 5 | 6 | vertical | 0.821 | 0.0 | — | 16.3 | 6.7 | 4.0 | −63.5 | −67.5 | 1.5 m right |
| hk_int_006 | 1 | 2 | oxer | 0.739 | 0.589 | — | 15.8 | 3.7 | 4.0 | −72.7 | −76.7 | 1.5 m right |
| hk_int_007 | 1 | 2 | oxer | 0.747 | 0.467 | — | 16.7 | 6.7 | 4.0 | −64.0 | −68.1 | 1.5 m right |
| hk_int_007 | 5 | 6 | vertical | 0.839 | 0.0 | — | 16.6 | 5.9 | 4.0 | −66.3 | −70.3 | 1.5 m right |
| hk_int_009 | 1 | 2 | vertical | 0.760 | 0.0 | — | 15.8 | 4.3 | 3.4 | −71.3 | −74.7 | 1.5 m right |
| hk_int_009 | 5 | 6 | oxer | 0.826 | 0.513 | — | 15.7 | 2.7 | 4.0 | −76.3 | −80.3 | 1.5 m right |
| hk_adv_002 | 1 | 2 | vertical | 0.875 | 0.0 | — | 15.7 | 4.4 | 3.4 | −70.9 | −74.4 | 1.5 m right |
| hk_adv_002 | 5 | 6 | vertical | 0.893 | 0.0 | — | 15.7 | 3.5 | 4.0 | −73.3 | −77.3 | 1.5 m right |
| hk_adv_002 | 6 | 7 | oxer | 0.919 | 0.659 | — | 15.1 | 5.8 | 0.0 | 68.9 | +68.9 | 1.5 m left |
| hk_adv_003 | 3 | 4 | vertical | 0.890 | 0.0 | — | 16.3 | 4.1 | 4.0 | −72.0 | −76.0 | 1.5 m right |
| hk_adv_003 | 4 | 5 | vertical | 0.881 | 0.0 | — | 15.8 | 5.5 | 0.0 | 70.7 | +70.7 | 1.5 m left |
| hk_adv_003 | 5 | 6 | oxer | 0.885 | 0.604 | — | 16.2 | 2.5 | 4.0 | −77.3 | −81.3 | 1.5 m right |
| hk_adv_005 | 2 | 3 | vertical | 0.882 | 0.0 | — | 16.1 | 4.8 | 0.0 | 73.5 | +73.5 | 1.5 m left |
| hk_adv_005 | 5 | 6 | oxer | 0.883 | 0.594 | — | 16.6 | 2.7 | 4.0 | −76.9 | −80.9 | 1.5 m right |
| hk_adv_005 | 6 | 7 | vertical | 0.904 | 0.0 | — | 16.1 | 6.1 | 0.0 | 69.4 | +69.4 | 1.5 m left |

Pattern: most of these are the long diagonal from a fence on one long side
to a fence on the other, still aimed down the long side (~0–4°). Yawing
~70–80° onto the diagonal is the whole move. The 1.5 m slide is only to
center the standard on that new line, not to eat the 16 m of off.

## Live ids with no hit in this band

Lesson (hk_les_001–004), hk_beg_039, hk_beg_004, hk_adv_001, and all three
jump-offs. They still have ROOM findings in the walk (other offs / short
run). Not this 15–17 × 2–7 window.

## Do not

Do not write these numbers into any course JSON tonight.
Do not run `fix_board_lines.py` or `patch_line_clashes.py`.
