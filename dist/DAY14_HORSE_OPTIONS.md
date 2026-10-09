# Free horses, Day 14

Nothing here costs money. No paid models, no paid tiers, no commission.

v2 is `game/assets/meshes/abbott_v2.glb`, painted and smoothed from the horse we already ship. A free model replaces it only if a Blender still is clearly better and the bones and clips can be renamed onto ours.

## What was found

| model | url | licence | account | clips | verdict |
| --- | --- | --- | --- | --- | --- |
| Quaternius Ultimate Animated Animals, Horse | https://quaternius.com/packs/ultimateanimatedanimals.html | CC0 | no | Walk, Gallop, Jump, attacks, idles. No trot, no canter. | This is the horse v2 was built from (`quaternius-WhiteHorse.glb`). It does not beat v2. |
| Poly Pizza Horse, Quaternius 2021 | https://poly.pizza/m/qvTrSG9pZF | CC0 | no | Same pack. | Same animal. Not downloaded again. |
| Poly Pizza Horse, Quaternius 2023 | https://poly.pizza/m/D3hAeqeDBE | CC0 | no | Same family. | Not a different rig. |
| OpenGameArt Rigged Horse | https://opengameart.org/content/rigged-horse | CC0 (Lyndon's mesh) | no | A rig on the static ranch horse. No trot or canter clips. | The mesh we already had, without the painted coat. |
| Kenney, Smithsonian CC0 scans | searched | | | | No rigged horse with a trot or canter that downloads without an account. |

A BlendSwap file called "Horse Rigged All Gaits" is CC0 and lists walk, trot, canter and gallop. The download asks for an account, so it was not taken.

## Verdict

Nothing free that can be downloaded without an account beats v2. The only rigged horses on those sites are the Quaternius horse we already smoothed and painted, or the same mesh without clips. No second mesh was wired in as `abbott_v3.glb`. No clips were retargeted, because none of those files contain a trot or a canter we do not already have.

Trot and Canter on v2 were keyed here from Walk and Gallop. The trot is not mapped yet. See `dist/DAY14_LOG.md`.
