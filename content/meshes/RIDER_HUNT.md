# Phase G — Rider + saddle mesh hunt

Date: 2026-09-16 (mega pass)  
Status: hunt only. **Not wired into the live ride.** Still no English close-contact saddle GLB on disk. Printables "saddle" hits are hunting-tree or guitar saddles, or NC-SA. Sketchfab CC-BY still wants a login. Primitive close-contact in `person_look.gd` stays live.

Madison is still procedural primitives in `game/scripts/person_look.gd`.  
The live seat contract in `horse.gd` is:

```
Rider
  Body
    Head
    LLeg
      LShin
    RLeg
      RShin
```

`horse.gd` `_bind_rider()` looks up `Rider/Body`, then `Body/Head`, `Body/LLeg`, `Body/RLeg`. Pitch/roll and hunt-seat hip/shin live there. **Do not replace that path. Do not edit `horse.gd`, `abbott_look.gd`, or `person_look.gd` in this pass.**

A later import should wrap a GLB so those node names still exist, or drive the existing pivots from a Mixamo/Quaternius skeleton. Do not parent a random mesh onto Abbott and hope.

Madison height in the live kit: **1.68 m**. Prefer keepers in meters.

Downloads live in `content/meshes/raw/<slug>/`. Ranked shortlist: `CANDIDATES.json`.

---

## Keepers (import later)

These are on disk, CC0, glTF/GLB, humanoid, young-female-ish. None of them wear a navy hunt coat / beige breeches / field boots / hunt cap. They are **bases**, not Madison.

### 1. `quaternius_modular_casual` — rider pick

- File: `content/meshes/raw/quaternius_modular_casual/Casual.glb`
- Author: Quaternius
- License: CC0 1.0
- Page: https://quaternius.com/packs/ultimatemodularwomen.html
- Fetched: Cinevva CDN mirror of the official pack (`Casual.glb`, 2.6 MB)
- Format: GLB, skinned, 9 meshes / ~13k position verts
- BBox (Y): about **1.84 m** tall — closest match to Madison 1.68 m
- Rig: `CharacterArmature` with Hips / Torso / Neck / Head / UpperLegL / LowerLegL / FootL (and R)
- Why it fits: meters-scale young woman, modular body/head/legs/feet, CC0, Godot-ready GLB
- Why it is not Madison yet: casual clothes, not hunt-seat; no cap; T-pose/idle not two-point

### 2. `quaternius_casual_female` — animated sister

- File: `content/meshes/raw/quaternius_casual_female/Casual_Female.glb` (1.8 MB)
- Author: Quaternius · CC0 1.0
- Page: https://quaternius.com/packs/ultimateanimatedcharacters.html
- ~9k verts, 17 clips including `Idle`, `Walk`, `Run`, `Jump`, `SitDown`
- BBox is inflated by animation (Y span ~10 units). Rest pose needs a scale check in Godot. Same author as #1, so a later pass can pick one scale.
- Why it fits: same girl family, has a sit and a jump
- Why not: still not hunt-seat; jump is a platform jump, not two-point

### 3. `kenney_female_a` — low-poly sit

- File: `content/meshes/raw/kenney_female_a/character-female-a.glb` (273 KB)
- Author: Kenney · CC0 1.0
- Page: https://kenney.nl/assets/mini-characters
- ~1.6k verts, 32 clips including **`sit`**, idle, walk, jump
- Node names already close: `root`, `leg-left`, `leg-right`, `torso`, `head`
- BBox ~2×2×2. Stylized mini-character, not photoreal
- Why it fits: legal, tiny, has sit; easy to dummy-parent under `Rider/Body`
- Why not: blocky Kenney look, not Hidden K

### 4. `kenney_female_b` (quota raise)

- File: `content/meshes/raw/kenney_female_b/character-female-b.glb` (252 KB)
- Same pack/license as #3, second skin

**Shared-scale pair:** use **Quaternius modular Casual** as the rider base. There is **no English close-contact saddle GLB** in this harvest at that scale. Do not fake one by reskinning the Western bedroll.

---

## Saddle — honest result

A shippable **close-contact / jumping English saddle** (pad, girth, irons) as glTF/GLB with CC0 or CC-BY and a **direct download** was not found tonight.

Poly Haven models (521): no saddle. Kenney/Quaternius CDN: no `saddle.glb`. OpenGameArt’s only 3D saddle is Western with a bedroll. Sketchfab has CC-BY English-ish saddles that need a logged-in download. Printables has a CC-BY 4.0 “Horse Saddle (Accurate)” STL; the site returned 403 without a browser session.

Do not import a Western, Tuareg, side-saddle museum scan, or LEGO saddle and call it Hidden K.

### Saddle candidates for a human later (not imported)

| Rank | Name | License | Why |
| --- | --- | --- | --- |
| 1 | [YaredGmGm “Saddle”](https://sketchfab.com/3d-models/saddle-e03a431c3c2a44ec9b9dced31b9cc066) | CC-BY | 7.7k tris, generic riding saddle, GLB after Sketchfab login |
| 2 | [bryopsida “Saddle”](https://sketchfab.com/3d-models/saddle-88f15df698b44b7191f4e93ceff79859) | CC-BY | 16.2k tris, student model, login |
| 3 | [Printables “Horse Saddle (Accurate)”](https://www.printables.com/model/411449-horse-saddle-accurate) | CC-BY 4.0 | STL, claimed accurate; convert to GLB later. 403 tonight |
| 4 | [Ayan horse + saddle](https://sketchfab.com/3d-models/animated-rigged-horse-with-saddle-b08743c2c4734fb98a4e0a2f5767c318) | CC-BY | Extract saddle only; do not replace Abbott |
| 5 | [RAMM saddle cloth](https://sketchfab.com/3d-models/saddle-cloth-da0e7edecad44a8c9ef1162c5736a2b9) | CC0 | Historic **side-saddle** cloth, 1.7M tris. Wrong tack, too heavy |

---

## Rejected (with reason)

At least eight. These were considered and refused.

1. **OpenGameArt “Saddle with Bedroll”** (Ouren / Wolfgang Wozniak, CC-BY 3.0) — downloaded `saddle_1.blend`. Western bedroll, not close-contact English. Not GLB.
2. **VRoid Studio CC0 `base_female`** — downloaded `Base_Female.vrm`. Legal CC0, anime proportion. Not hunt-seat.
3. **KayKit Adventurers Knight.glb** (Kay Lousberg, CC0) — fantasy knight. Banned class.
4. **Quaternius Knight_Golden_Female.glb** — fantasy knight.
5. **Quaternius Soldier_Female.glb** — military, not hunt coat.
6. **Mixamo raw FBX in this repo** — Adobe Mixamo ToS allows use **in a game**, forbids redistributing raw character/animation files as a pack. Do not commit Mixamo FBX here. See retarget notes below.
7. **Unity / Fab “Horse Animset Pro”** and other marketplace dumps — paid ARR.
8. **Sketchfab ARR / Standard license saddles** (e.g. Europac3d scan for sale) — not CC0/CC-BY free.
9. **Jockey / race kits** — wrong seat, wrong silhouette.
10. **Tuareg saddle (Virtual Museums of Małopolska, CC0)** — museum scan, not English jumping.
11. **RAMM 1680–1750 side-saddle cloth (CC0)** — historic, wrong century and seat.
12. **The Models Resource Animal Crossing horses** — Nintendo copyright.
13. **ArtStation Genesis 8 “stylized horse riders”** — paid, Daz/Marvelous.
14. **CC-BY-NC saddles** (LEGO-compatible, motorbike scan, “eastern tribes”) — no commercial ship.
15. **LPC 2D horse-riding sprites** — 2D, not a mesh.
16. **Poly Haven `horse_statue_01` / `horse_head`** — sculpture, not tack.
17. **2D paperdoll “rider” on OpenGameArt** — dirtbike, 2D.

---

## Mixamo riding clips — notes only, do not retarget tonight

Mixamo (Adobe) animations are royalty-free **inside a finished game**. They are **not** a license to drop raw FBX into `content/meshes/raw` for redistribution.

Public Mixamo library is humanoid biped. There is no first-class Hidden K pack (walk-trot-canter-two-point on a horse). Useful searches on mixamo.com after a human logs in:

- Sitting / Sitting Idle — closest to a quiet seat
- Idle / Breathing Idle
- Jump / Jumping — not two-point; will look like a standing jump
- Walking / Running — locomotion on foot, not posting trot

There is generally **no** hunt-seat posting trot or canter lead-change in Mixamo. Third-party “horse riding Mixamo” videos are usually a humanoid sitting pose parented to a horse, not a real riding set.

### Retarget later (do not do it in this pass)

1. Keep `horse.gd` looking for `Rider/Body/{Head,LLeg,RLeg}`.
2. Import the Quaternius Casual GLB as a **child visual**, or map:
   - `Hips`/`Torso` → `Body` pitch/roll already applied by `_update_rider`
   - `Head` → `Body/Head`
   - `UpperLegL`/`LowerLegL` → `LLeg` / `LShin`
   - `UpperLegR`/`LowerLegR` → `RLeg` / `RShin`
3. Scale Quaternius modular Casual (~1.84 m) toward Madison 1.68 m (`scale ≈ 0.91`).
4. Do **not** retarget onto Abbott’s horse skeleton. Horse motion stays in `horse.gd`.
5. If Mixamo is used: download **with skin** onto the Quaternius/Kenney humanoid in Mixamo’s auto-rigger, export FBX for the project (not as a redistributable pack), then retarget in Godot AnimationPlayer. Hunt-seat two-point will still need hand-keyed overlays (hip close, heel down, eyes up).

---

## Live seat reminder

`PersonLook.mounted_madison()` already builds hunt-seat: navy coat, beige breeches, field boot, hunt cap, closed hip, knee at the roll. Until a GLB can wear that kit and still expose `Body/Head/LLeg/RLeg`, leave the primitives.

---

## How a later agent should import

1. Copy a keeper GLB under `game/assets/meshes/` **without** overwriting `abbott.glb`.
2. Add an optional loader next to `content_library.gd`, behind a flag, default off.
3. Instance the GLB under `Rider`, then either hide the primitive meshes or swap materials. Keep the pivot names.
4. English saddle: wait until a CC-BY Sketchfab login or a converted Printables STL exists. Do not use the OGA Western blend.
