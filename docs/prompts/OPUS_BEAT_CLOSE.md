# Opus — score the beat, then stop

You are in `E:\Workspace\Madison`. The rein is reverted. `horse.gd`
`_update_reins` is one straight rod from bit to glove again. Leave it.
Two bends cleared every sample in the search and missed the drawn
rein by a landing: one sample touched the neck instead of clearing it
by 1 cm. That is the end of fixed points on the rein. Do not add a
segment. Do not lift her fists. Do not edit `bascule.gd`.

What is in the tree, and unverified, is the gait-change beat. A new
gait takes the beat index silently, and `_hoof_strike` waits 0.18 s
so the first sound is a real footfall after the blend. `STRIDE_HZ`
and `GAIT_SPEED` were not to be touched.

## Silent

One Godot. If one is running, that is the three clocks. Do not
taskkill it. Do not start another. Wait until `dist/ridecert_godot.log`
has `RIDECERT done` for `hk_adv_003`, and read the two rides before
it (`hk_les_001`, `hk_adv_001`) from their logs. Headless only. Do
not launch `dist\Abbott.exe`.

## The keep

| id | keep |
| --- | --- |
| hk_les_001 | 18.50–18.60, 0 faults, 0 rails |
| hk_adv_001 | 91.51–91.67, 2 faults, 0 rails |
| hk_adv_003 | 93.91–94.07, 3 faults, 0 rails |

`teleported=false`, rounds complete. If any id is outside that,
revert only the beat-gate (`_beat_gait`, `_gait_age`, the silent
take of `last_beat`). The pastern, the crest, and the straight rein
stay. Write the three times and stop.

If they hold: one style course, headless,

`python tools/content_factory/run_ridecert.py --ridecert-style --ridecert-id=hk_beg_035`

A clear, B refused fence 1 with 0 rails, C one rail on fence 3 in
the air. Then `--playtest`: clear 0 / refuse 4 / rail 4. No full
board. This change does not move the horse.

Append the three times and the style line to the top of
`dist/STATUS.md`. Then stop. Do not open the rein again. Do not
export.
