# Grok Build — people only

You are Grok Build. You own the look of the people and the tack.
Craft bar: A Short Hike, then the sand at C. Ernie rode **2.345.0.0**
(look 1–46 packed 20 Sep 15:58). Sand and jumps read. The girl does not.

Repo: `E:\Workspace\Madison`
Godot: `C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe\Godot_v4.7.2-stable_win64_console.exe`

## Gate

If `Godot_v4.7.2` is live, Claude is riding or Cursor is playtesting.
Do not taskkill. Do not pack. Do not start a second export.

Do **not** edit `farm.gd`. Cursor owns `_pine_plant` / `_oak_plant` tonight.
Do **not** edit course JSON, `ride_ai.gd`, `ride_cert.gd`, leave windows,
`present(`, or the pin 85/80/44/38/36. Knock Area stays
`(width*0.9, height+0.15, 0.35+spread)` — width / height / spread / position
untouched. Playtest after each keep: clear 0 / refuse 4 / rail 4, knock
still fires on the rail round.

## What Ernie saw (photograph, not a theory)

1. Rider is **inside** the horse. Legs not visible on the outside.
2. **No saddle** from C.
3. Bridle front reads; **no reins** to the hands.
4. Madison is Playmobil. He wanted a person.
5. Michelle: hands in front of the vest, head a **round brown blob**.
6. Horse coat is fine enough. Front hooves in the dirt can wait.
7. Trees are Cursor tonight.

## Why the photograph is in the source

`person_look.gd` `mounted_madison`:

```
sit := seat + Vector3(0.0, -0.284, -0.130)
_english_saddle(host, sit)
```

Twenty-eight centimetres down, thirteen back. Thighs start at
`hip := Vector3(sx * 0.014, -0.050, -0.048)` — 1.4 cm off the centerline,
inside the barrel. The close-contact tree is a ~36 cm pad at that same
sunk point. From C: girl in the rib, no leather.

Reins already exist in `horse.gd` `_make_reins` / `_update_reins`
(`BitL`/`BitR` → `LGlove`/`RGlove`). Headstall is rods on the Head bone
in `abbott_look.gd` `_bridle`. If `_find_named` misses the markers, the
0.45 m cylinders sit on the horse origin and you get brow + bit and
nothing to the fists. Fix the bind. Do not invent a second bridle.

Michelle: `standing_trainer` → `_girl_head(..., photo_face=false)`.
Skull is a 9 cm brown sphere plus a hair cap. No plates. Forearms go to
`(sx * 0.04, 0.96, 0.18)` — clipboard in front. That is the blob.

## This job (order)

1. **Seat.** Lift the sit. Legs **outside** the barrel so a person sees
   boot and thigh from C. Knee on the roll, not in the gut. Irons under
   the ball. If she is in the horse, put her back. Do not change
   two-point logic except the numbers that place the mesh.
2. **Saddle.** On the back, flaps on the shoulder, girth under the barrel.
   Readable from C. Same `_english_saddle` — scale and place it to the
   horse, not to the sunk girl.
3. **Reins.** Bit ring to fist, both sides, every frame she is mounted.
   If `_update_reins` cannot see `BitL`/`BitR`, that is the bug.
4. **Madison from C.** Still Playmobil after the seat is honest. One pass
   that reads as a person — face, shoulders, coat as one shape — not more
   boxes on the coat. Photo plates already exist (`rider_front/side/back`,
   `madison_face.gdshader`). Use them. Sand is the bar.
5. **Michelle.** A face. Hands may hold the board. The head cannot stay a
   brown ball. She is still scenery. No new sentences.

Horse coat: skip. Indoor prism roof: skip. Trees: skip.

## Score

From C, and from the saddle camera. A loft inside the rib is not a seat.
A cone of boxes is not a girl. Append `tools/content_factory/LOOK_LOG.md`.
Playtest PASS, knock still fires. Pack **only** when Godot is down and
Claude is idle. Keep Date created 2026-09-12 08:34:04. Bump product
version (2.346). Do not overwrite sand / wood albedo.

Body / Head / LLeg / RLeg / LShin / RShin names kept.
A Short Hike. One horse, one barn.
