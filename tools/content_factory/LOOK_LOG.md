# Hidden K look log

Headless look pass. Claude owns the ride. Cull against r01–r06 only.
Body / Head / LLeg / RLeg names kept. No lockbox files opened.

## Pass 1 — close-contact tree

Playtest PASS (clear 0 / refuse 4 / rail 4).

What a person would see: the hanging-sack girth from r04 is gone. In its
place a leather strap under the barrel, three billets a side, a suede
dish between pommel and a higher cantle lip, quilted pad split at the
gullet, lofted sweat flap and saddle flap instead of door boxes, round
knee rolls, irons still under the ball.

Files: `game/scripts/person_look.gd` `_english_saddle` / `_saddle_flap`.

## Pass 2 — hunt coat

Playtest PASS (clear 0 / refuse 4 / rail 4).

What a person would see: the hip loaf is gone. Waist nips. Two lofted tails
hang past the cantle, split by a vent. Stock ties at the throat with a gold
pin, not a white slab. Still navy wool, still hunt seat.

Files: `game/scripts/person_look.gd` `_seated_torso` / `_coat_tail`.

## Pass 3 — face off the helmet

Playtest PASS (clear 0 / refuse 4 / rail 4).

What a person would see: the velvet peak sits on the crown, not over her
eyes. Face plates crop visor and studio, keep brows to chin of the same
girl. Softer jaw, not a hard plate. Same helmet, same bun, same pin.

Files: `game/scripts/person_look.gd` `_girl_head` / `_face_mat`,
`game/shaders/madison_face.gdshader`.

## Pass 4 — fists on the withers

Playtest PASS (clear 0 / refuse 4 / rail 4).

What a person would see: black gloves close into fists on the crest,
knuckles in a row, thumbs wrapped. Crop still in the right hand. The
two-point itself is untouched (horse.gd).

Files: `game/scripts/person_look.gd` `_glove`.

## Pass 5 — Michelle on the rail

Playtest PASS (clear 0 / refuse 4 / rail 4).

What a person would see: the crate vest is gone. Olive wool opens on a
white shirt, clipboard with a pencil, tall field boots to the knee. She
is still scenery. No new sentences.

Files: `game/scripts/person_look.gd` `_standing_figure`.

## Pass 6 — liver chestnut

Playtest PASS (clear 0 / refuse 4 / rail 4).

What a person would see: he is a dark liver chestnut, not a copper toy.
Blaze is a white strip you can read from the gate, star at the poll,
flaxen mane and tail almost white. Clips unchanged.

Files: `game/shaders/abbott_whitehorse.gdshader`, `game/scripts/abbott_look.gd` fallback.

## Pass 7 — English headstall

Playtest PASS (clear 0 / refuse 4 / rail 4).

What a person would see: brow, flash, cheek, and bit rings read from the
gate. Leather is thicker on the head bones only. Live reins untouched.

Files: `game/scripts/abbott_look.gd` `_bridle`.

## Pass 8 — worked oval

Playtest PASS (clear 0 / refuse 4 / rail 4).

What a person would see: the sand is an oval, not a rectangle of dirt.
A darker wet hoop where they school, raked, a little shine in the late
gold. Grass still stops at the apron.

Files: `game/shaders/sand.gdshader`.

## Pass 9 — house on a yard

Playtest PASS (clear 0 / refuse 4 / rail 4).

What a person would see: three September oaks sit with the house. Duff
at the roots. The keepout had left the yard a green sheet; the house
now has shade.

Files: `game/scripts/farm.gd` `_house` / `_yard_oak`.

## Pass 10 — hitch that looks used

Playtest PASS (clear 0 / refuse 4 / rail 4).

What a person would see: two posts outside the Dutch door, rings, a lead
and empty halter on the left, fly mask hanging on the right, dirt worn
where a horse stands. Not a clean prop.

Files: `game/scripts/farm.gd` `_barn`.

## Pass 11 — indoor letters

Playtest PASS (clear 0 / refuse 4 / rail 4).

What a person would see: the covered ring has A C E B K F H M on the
kick. Lamps and kick were already there. Still scenery, not a class.

Files: `game/scripts/farm.gd` `_indoor`.

## Pass 12 — roofs that are not plastic

Playtest PASS (clear 0 / refuse 4 / rail 4). First try collided with
Claude's Godot restart; second try green.

What a person would see: barn, indoor, and house roofs take harvest rust
and dark plank instead of a flat color. Same prisms. Not a second barn.

Files: `game/scripts/mesh_kit.gd` `barn_roof` / `house_roof`, `farm.gd`.

## Pass 13 — fieldstone footers

Playtest PASS (clear 0 / refuse 4 / rail 4).

What a person would see: barn footer, house foundation, and the farm-sign
posts sit on harvest gravel/stone, not a grey slab.

Files: `game/scripts/mesh_kit.gd` `fieldstone`, `farm.gd`.

## Phase C — DIAGONALS.md

Proposals only. 23 landings in the 15–17 m off / 2–7 m run window. Yaw
along the diagonal (~70°) plus a 1.5 m slide. No course JSON written.

## Export 2.343.0.0

`dist/Abbott.exe` packed after pass 9. Date created kept 2026-09-12 08:34:04.
Playtest was PASS. Claude's Godot was not touched.

## Export 2.344.0.0

Packed after pass 13 (hitch, indoor letters, harvest roofs, fieldstone).
Date created kept 2026-09-12 08:34:04. Two earlier pack attempts died
mid-savepack when Claude's Godot restarted; the 2.343 exe was left
untouched those times. This pack finished. Playtest was PASS. Claude's
Godot was not killed.

## Pass 14 — pines that are needles

Playtest PASS (clear 0 / refuse 4 / rail 4).
Export skipped, Claude Godot live.

What a person would see from the gate: the stacked bowls are gone. Each
pine tapers, forks once, and wears short irregular whorls plus two
clumps. Some layers missing. Same count. Off the sand.

Files: `game/scripts/farm.gd` `_pine_plant` / `_trees` / `_pine_at`.

## Pass 15 — pine late gold

Playtest PASS (clear 0 / refuse 4 / rail 4). First try died mid-round when
Claude's Godot restarted; second try green.
Export skipped, Claude Godot live.

What a person would see: needles are dark with russet tips in the honey
sun, undersides almost black. Not summer lime discs.

Files: `game/shaders/pine.gdshader`.

## Pass 16 — oaks that branch

Playtest PASS (clear 0 / refuse 4 / rail 4).
Export skipped, Claude Godot live.

What a person would see: drive and yard oaks are flattened irregular
crowns, three volumes that do not share a center, and a low limb with
leaves on it. Not balloon spheres. Duff stays. Off the sand.

Files: `game/scripts/farm.gd` `_oak_plant` / `_trees` / `_shade_trees` / `_yard_oak`.

## Pass 17 — September rust

Playtest PASS (clear 0 / refuse 4 / rail 4).
Export skipped, Claude Godot live.

What a person would see: oaks go copper and rust in the honey sun, not
summer lime. Shade volumes stay darker.

Files: `game/shaders/hardwood.gdshader`, `game/scripts/mesh_kit.gd`.

## Pass 18 — thigh on the roll

Playtest PASS (clear 0 / refuse 4 / rail 4).
Export skipped, Claude Godot live.

What a person would see: her thigh wraps the barrel and the knee sits
on the suede roll. Hip is closed in the mesh. She does not post
(horse.gd untouched). LLeg / RLeg names kept.

Files: `game/scripts/person_look.gd` mounted legs.

## Pass 19 — field boot

Playtest PASS (clear 0 / refuse 4 / rail 4). First try died when Claude's
Godot restarted; second try green.
Export skipped, Claude Godot live.

What a person would see: a calf in a field boot, heel under the iron,
zip up the shaft, spur on the heel — not a mid-calf blob. LShin / RShin
names kept.

Files: `game/scripts/person_look.gd` mounted shin.

## Pass 20 — hunt wool

Playtest PASS (clear 0 / refuse 4 / rail 4).
Export skipped, Claude Godot live.

What a person would see: the coat is dull navy twill, not plastic. Tight
weave, almost no sheen.

Files: `game/shaders/person.gdshader`, `game/scripts/mesh_kit.gd` hunt_wool.

## Pass 21 — mouth is skin

Playtest PASS (clear 0 / refuse 4 / rail 4).
Export skipped, Claude Godot live.

What a person would see: visor stays off the crop. Jaw is not a dark
plate. Same girl, same photos.

Files: `game/scripts/person_look.gd` `_face_mat`, `game/shaders/madison_face.gdshader`.

## Pass 22 — used cups

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires on the rail
round. Collision untouched.

What a person would see: hunter cups are dull bronze, not chrome toys.
Pins stay steel.

Files: `game/scripts/fence.gd` `_standard` cup material only.

## Pass 23 — denser brush

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires. Box size
unchanged.

What a person would see: the brush box is a mass of leaves and twigs,
September rust in it, not a few green balls.

Files: `game/scripts/fence.gd` `_brush` fill only.

## Export skipped, Claude Godot live

Product version still 2.344.0.0 in the last packed exe. Date created
2026-09-12 08:34:04. Did not pack; did not kill Godot.

## Trees

Pines are no longer four stacked bowls. Oaks are no longer balloon
spheres. From the gate: tapered trunks, one fork, irregular needle
whorls, flattened crowns that branch, September rust. Count still 110
plus windbreak and three yard oaks. Keepout unchanged.

## Pass 24 — hunter standards

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
Export skipped until pack window (check Godot at ship).

What a person would see from C: two-post wings with a lower wood panel
and a cap rail, not a door with an X. Cups stay bronze on the jump
post. Feet stay. Width / height / spread unchanged.

Files: `game/scripts/fence.gd` `_standard` wing builders only.

## Pass 25 — hunter gate

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.

What a person would see from C: a gate with stiles, a little sag in the
slats, a latch bar and catch. Same footprint. Not a crate of thirteen
sticks.

Files: `game/scripts/fence.gd` `_hunter_gate`.

## Pass 26 — coop is a slope

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.

What a person would see from C: a sloped coop face toward the approach,
not a card standing on three boxes.

Files: `game/scripts/fence.gd` `_plank_filler`.

## Pass 27 — flower box plants

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires. Box size
unchanged.

What a person would see from C: stems and flattened heads in rust, white,
and gold. Not a pile of spheres.

Files: `game/scripts/fence.gd` `_flower_box`.

## Pass 28 — wing planter plants

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires. Box size
unchanged.

What a person would see: wing boxes have stems and gold/white heads, not
sphere blooms.

Files: `game/scripts/fence.gd` `_wing_planter`.

## Pass 29 — natural poles

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires. Capsule,
mass, freeze, layers untouched.

What a person would see from C: poles taper a little, like wood, not
chrome tubes.

Files: `game/scripts/fence.gd` `_rail` CylinderMesh radii only.

## Pass 30 — number from the last stride

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
set_current Label3D logic unchanged.

What a person would see: a bigger plate under a hood, number still
readable from the last stride.

Files: `game/scripts/fence.gd` NumPlate / NumHood size only.

## Pass 31 — tails as one shape

Playtest PASS (clear 0 / refuse 4 / rail 4).

What a person would see from the in-gate: hunt tails hang as one navy
shape past the cantle, vent still splits them up close. Hip already
closed.

Files: `game/scripts/person_look.gd` TailSkirt / `_coat_tail`.

## Pass 32 — shoulders that are a person

Playtest PASS (clear 0 / refuse 4 / rail 4).
Export skipped, Claude Godot live.

What a person would see from the in-gate: a navy yoke across the
shoulders, not two balls on a loft. Deltoids smaller. Names kept.

Files: `game/scripts/person_look.gd` Yoke / Shoulder / Deltoid.

## Pass 33 — stock, vest, belt from a long lens

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
Export skipped, Claude Godot live.

What a person would see from the in-gate: one white stock, a canary
vest, a dark belt. The twelve small boxes are gone.

Files: `game/scripts/person_look.gd` Stock / Vest / Belt.

## Pass 34 — hunt cap reads velvet from C

Playtest PASS (clear 0 / refuse 4 / rail 4).
Export skipped, Claude Godot live.

What a person would see from the in-gate: the cap is velvet, not a
matte button. Peak still off the eyes. Crown already a head.

Files: `game/scripts/person_look.gd` Helmet / HelmBand / Peak use MeshKit.velvet().

## Pass 35 — used-wood standards

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
Knock Area size/position untouched. Export skipped, Claude Godot live.

What a person would see from C: oak posts with a square cap and wooden
feet. Ball cap and tape squares are gone. Wings still two-post with a
panel. Cups still bronze on a pin.

Files: `game/scripts/fence.gd` `_standard` posts / cap / feet only.

## Pass 36 — clock booth desk is planks

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
Export skipped, Claude Godot live.

What a person would see from C: the clock-booth desk is dark planks, not
a flat brown slab.

Attribution: `MeshKit.wood_kick()` → harvest `dark_planks` (Rob Tuytel,
Poly Haven, CC0 1.0) via `game/assets/ATTRIBUTION_HARVEST.md`. Did not
overwrite sand_albedo.jpg / wood_albedo.jpg.

Files: `game/scripts/farm.gd` ClockBooth DeskTop.

## Pass 37 — flags hang

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
Export skipped, Claude Godot live.

What a person would see from C: a red cloth on a wand, a little sag,
not a plastic card glued to the post.

Files: `game/scripts/fence.gd` `_flag` only.

Remaining from C (honest): ClockBooth Board is still a flat navy slab.
Brush fill is still a sphere mass (not reopened). Flower heads are still
flattened spheres on stems.

## Pass 38 — clock booth board is planks

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
Export skipped, Claude Godot live.

What a person would see from the clock booth: the scoreboard is dark
planks, not a plastic navy card. Same Rob Tuytel plate as pass 36, not
a new harvest.

Files: `game/scripts/farm.gd` ClockBooth Board.

Remaining from C: GateSign is still a flat navy slab. Brush fill is still
a sphere mass (not reopened). Flower heads are still flattened spheres
on stems.

## Pass 39 — Hidden K sign is painted wood

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
Export skipped, Claude Godot live.

What a person would see from C: the Hidden K board is navy-painted
planks, not a plastic card. Label3D "HIDDEN K" unchanged.

Attribution: harvest `dark_planks` (Rob Tuytel, Poly Haven, CC0 1.0).
Did not overwrite sand_albedo.jpg / wood_albedo.jpg.

Files: `game/scripts/farm.gd` GateSign.

## Pass 40 — rail boxes are plants

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
Export skipped, Claude Godot live.

What a person would see from C: the rail boxes have stems and flattened
September heads, not a row of spheres. Box size unchanged. Tree count
unchanged. No porch cat.

Files: `game/scripts/farm.gd` `_rail_flowers`.

Remaining from C (honest): `_brush` fill is still a sphere mass (not
reopened). Fence flower heads are still flattened spheres on stems.

## Pass 41 — brush is cut branches

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
First playtest died after the clear round when Claude Godot came up
(1:22:54 PM). Retry without revert: PASS. Knock Area untouched.
Box size unchanged (width*0.82 × 0.46 × 0.50).
Export skipped, Claude Godot live.

What a person would see from C: a box of forked stems and flattened
sprays with September rust in it. Not a ball pit of 160 spheres.

Files: `game/scripts/fence.gd` `_brush` fill only.

## Pass 42 — flower-box heads

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
Export skipped, Claude Godot live.

What a person would see from C: daisy, mum, and zinnia faces in rust,
white, and gold. Not pancakes. Box footprint unchanged.

Files: `game/scripts/fence.gd` `_flower_box` / `_bloom_head`.

## Pass 43 — wing-planter heads

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
Export skipped, Claude Godot live.

What a person would see from C: the wing boxes have the same faces.
Same footprint as pass 28.

Files: `game/scripts/fence.gd` `_wing_planter`.

## Pass 44 — Abbott from C, skipped

No shader pass. Pass 6 already made him a dark liver chestnut, not a
copper toy. Coat mix is dark (0.09, 0.035, 0.018) to copper
(0.38, 0.12, 0.045). Blaze still paints. Flaxen mixes to white 0.86.
AnimalArmature scale 100 stays flattened. No clip retarget.

Playtest not required (no edit). Export skipped, Claude Godot live.

## Pass 45 — indoor has knees

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
Export skipped, Claude Godot live.

What a person would see from the yard: the covered ring has knee braces
and a fascia. Open sides, kick, letters stay. Not a crate with a lid.

Files: `game/scripts/farm.gd` `_indoor` braces / fascia only.

## Pass 46 — rail boxes have faces

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
Export skipped, Claude Godot live (1:27:50 PM). Sixteen look passes
still not in 2.344.0.0.

What a person would see from C: the long-side boxes have daisy faces
like the fences. Box size unchanged. No porch mum. No new trees.

Files: `game/scripts/farm.gd` `_rail_flowers` heads only.

Remaining: pack when Claude's Godot is down. Indoor still a prism roof
on posts — braces help from the yard. Brush is cut branches. Flowers
have faces.

## Pack — look 1–46 in the exe

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
No other Godot running. Packed.

`dist/Abbott.exe` product version 2.345.0.0. Date created kept
2026-09-12 08:34:04. LastWrite 2026-09-20 15:58:20. Size 1738406648
bytes.

## Pass 47 — on the back, legs outside

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.

What a person would see from C: she sits on the back, not in the rib.
Thighs on the flaps. Knee on the roll. Saddle tree on the withers,
girth under the barrel. Irons still under the ball. Two-point numbers
in horse.gd untouched.

Files: `game/scripts/person_look.gd` sit, hip/knee, `_english_saddle` girth.

## Pass 48 — reins bit to fist

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.

What a person would see from C: leather from the bit ring to the glove,
both sides, while she is mounted. Bind re-finds BitL/BitR and LGlove/RGlove
each frame if they were missed at ready. No second bridle.

Files: `game/scripts/horse.gd` `_update_reins`, `person_look.gd` LGlove/RGlove.

## Pass 49 — Madison is a person from C

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
First try died after the clear round when Claude Godot came up
(10:26 PM). Retry without revert: PASS.

What a person would see from C: the coat is one navy shape at the
shoulders, not two balls on a loft. Photo plates still on the face.
No new boxes on the coat.

Files: `game/scripts/person_look.gd` `_seated_torso` / Shoulder / Arm.

## Pass 50 — Michelle has a face

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
First try died after knock when Claude Godot was live. Retry without
revert: PASS. Export skipped, Claude Godot live.

What a person would see from C: eyes, nose, mouth. Hair sits behind
the head, not a wrapping brown ball. Cap peak off the face. Hands still
hold the board. She is scenery. No new sentences.

Files: `game/scripts/person_look.gd` `_girl_head` unhelmeted hair/cap.

## Cursor — trees are plants (not packed)

Ernie from C: pines were triangles, oaks amateur. `_pine_plant` was
seven tapered cylinders. Rewrote `_pine_plant` / `_oak_plant` only.
Branches make the taper. Leaf on the limb. Count 110, keepout, duff
unchanged. Knock untouched. People left for Grok. Not packed.
Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.

## Saddle camera holds

No 51st prop pass. `person_look.gd` not touched. Horse coat not touched.

Passes 47–50 and the tree rewrite are still the meshes a rider has. Seat is the Torso bone lifted to the back, not the rib. Thighs sit outside the barrel, knee on the roll, boot, heel, iron. Saddle is leather on the back, girth under the barrel. Reins are rods from the bit rings to the gloves. Her face is the plate under the cap, peak above the brows. Pines and oaks are branches and leaves, not cones. That is the view from behind the cantle. saddle camera holds

## Pack 2.346.0.0

One export. Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires.
`dist/Abbott.exe` product version 2.346.0.0. Date created still
2026-09-12 08:34:04. Sand and wood albedo hashes unchanged.

## Rider mesh — Quaternius Casual on the existing pivots

No saddle picture. A Godot window locks the desktop, so this pass is headless
only. Judged from bone positions against the primitive seat, then playtest
and `hk_les_001`.

The GLB is the standing girl, about 1.84 m. She is scaled to the 1.68 m kit
(0.913) and the hip bone is parked on the seat origin. The thigh is shortened
along the bone so the knee joint lands on the roll; the girth of the thigh is
not squashed. The shin is scaled to the heel. Mesh left is +X, which is her
left when she faces the horse. Pivot names were not renamed. Angles still
come from `LLeg` / `LShin`. No second AnimationPlayer. The hip stays at the
seat through halt, the posting rise, and two-point, so the skeleton is not
moving the physics root.

What the numbers say from the saddle: hips on the seat. Knees outside
(±0.15 m) and forward on the roll (halt about y -0.14, z -0.24). Heels on
the iron (y -0.49), behind the knee. On the posting rise the knee comes up
to about y -0.02 and the heel stays down. Two-point knee about y -0.05.
Both wrists on the withers (y 0.09, z -0.22). Gloves are `LGlove` / `RGlove`.
Crop stays on the right glove. Fingers are tucked into the gloves.

Clothes, from the materials, not from a picture: shirt and arms navy, breeches
the kit beige, casual sneakers hidden, tall black boots with a tan cuff from
the knee to the heel, velvet cap on the head bone with the peak toward the
ears of the horse, stock and two tails on the coat. The photo face is not on
this head. Skin is the kit tone (0.86, 0.72, 0.60). The mesh head is the face.

From C: the same mesh stands on the sand, both feet solved to y 0, shoes
hidden, cap on. Enter still mounts through the old path. The mounted rider
hides when she steps off. Michelle is this mesh on the rail in an olive vest,
tan breeches, tall boots, and a clipboard. No new sentences. Her seat on the
horse is a different instance, so the standing pose does not move the saddle.

Playtest PASS (clear 0 / refuse 4 / rail 4). Knock still fires on fence 3.
`hk_les_001` clear, 3/3, 18.49 s (was 18.54), teleported=false. Stride words
still Two. Wait. / One. Wait. / One. Early. / Early. / Wait. / Now. then one
sentence. Not packed.

Files: `game/scripts/rider_mesh.gd`, `game/scripts/person_look.gd` (mount was
already the mesh; standing Madison and Michelle now use it), `game/scripts/walker.gd`.

The first full cert ran about 0.2 s fast. That was the per-frame skeleton
rebuild and a world-position hip park. Both came out. Two full certs after
that are 21/23, within 0.02 s of the pre-mesh board and of each other, no new
rails, teleported false, style A/B/C honest.

Trot seeks one Walk cycle (1.167 s) per stride so the two diagonal contacts
land on the posting beats. Horse speed, turn rate, and the leave were not
changed. `hk_les_001` stayed 18.54 s. Not packed. Exe remains 2.347.0.0.

