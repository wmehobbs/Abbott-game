# Opus — score the look, then stop

You are in `E:\Workspace\Madison`. The jump look is in `_place_cam`,
which is where it belonged. `_camera` is the stick. Leave it.

While he is over `jump_fence`, the look goes to that fence's top rail
and starts back toward the canter look on the way down. The 6° step
at the landing is the camera's existing 0.66 m drop, reading larger
because the look is now on the rail instead of a stride past it.
Camera position stays. Do not chase that angle. Do not edit
`bascule.gd`. Do not touch the rein. Do not export.

## Silent

One Godot. If one is running, it is the three clocks or the playtest.
Do not taskkill it. Do not start another. Wait until
`dist/ridecert_godot.log` has finished the id it is on, and read the
logs of `hk_les_001`, `hk_adv_001`, and `hk_adv_003`. Headless only.
Do not launch `dist\Abbott.exe`.

## The keep

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, rounds complete. Headless `--playtest`: clear 0 /
refuse 4 / rail 4.

If a clock is outside the window, revert `_place_cam` to the look
from before this job (the extra 1.86 m along his heading while
jumping). The beat gate, the pastern, and the straight rein stay.

If they hold, append the three times and the u 0.55 look distance to
the top rail to `dist/STATUS.md`. Then stop. No full board. No second
camera. No rein.
