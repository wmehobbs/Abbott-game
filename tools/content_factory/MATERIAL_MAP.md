# Live material → harvest plate

Fallback is always the previous `game/assets/textures/*.jpg` if the harvest file is missing.

| Live bind | Function / call site | Harvest path (preferred) | Fallback |
| --- | --- | --- | --- |
| Sand ring | `MeshKit.sand_material()` · farm outdoor + indoor | `harvest/proc/sand_worked_dry_*` | `raked_dirt` → `playground_sand` → `sand_*.jpg` |
| Grass sod | `MeshKit.grass_material()` | `harvest/proc/grass_piedmont_*` | `withered_grass` → `leafy_grass` → `grass_*.jpg` |
| Leather tack | `MeshKit.leather()` · saddle, boots, reins | `harvest/brown_leather_*` | `fabric_leather_02` → `acg_leather021` → `leather_bridle` → `leather_*.jpg` |
| White hunter boards | `MeshKit.wood_white()` · farm `_boards`, indoor rails, start flags | `harvest/proc/board_white_*` | `white_planks_clean` → `wood_albedo.jpg` |
| Kick wall | `MeshKit.wood_kick()` · outdoor + indoor kick | `harvest/proc/kick_dark_*` | `dark_planks` → `dark_wood` → `wood_albedo.jpg` |
| Oak / fence wood | `MeshKit.wood_oak()` · fence standards, board caps | `harvest/oak_wood_planks_*` | `worn_planks` → `rail_natural` → `wood_albedo.jpg` |
| Hunt wool / coat fallback | `MeshKit.hunt_wool()` · person_look kit fallback | `harvest/proc/wool_navy_coat_*` | `poly_wool_herringbone` → `wool_boucle` |
| Metal irons / cups | `MeshKit.steel()` | `harvest/metal_plate_*` | `rusty_metal_03` → `acg_metal032` → untextured steel |
| Quilted pad | `MeshKit.pad_fabric()` · saddle pad | `harvest/acg_fabric018_*` | `acg_fabric004` → `wool_boucle` → leather |
| Gravel drive | `MeshKit.gravel()` · barn yard, house drive | `harvest/proc/gravel_drive_*` | `gravel` → `sandy_gravel` → `sand_albedo.jpg` |
| Pine bark | `MeshKit.pine_bark()` · farm pines | `harvest/pine_bark_*` | `knotted_pine_bark` → `oak_bark` → `wood_albedo.jpg` |
| Straw bedding | `MeshKit.straw()` · aisle stalls | `harvest/proc/straw_gold_*` | `hay_bale` → `wood_chips` → `sand_*.jpg` |
| Hay bales | `MeshKit.hay()` · aisle / door flake | `harvest/proc/hay_bale_*` | `hay_dust` → `wood_chips` → `sand_*.jpg` |
| Flower soil | `MeshKit.flower_soil()` · in-gate boxes | `harvest/proc/flower_soil_*` | `flower_box_soil` → `farm_soil` → `sand_*.jpg` |
| Apron dirt | `MeshKit.apron_dirt()` · ring collar | `harvest/proc/apron_dirt_*` | `raked_dirt` → `park_dirt` → `sand_*.jpg` |
| Sand lip | `MeshKit.sand_lip()` · ring lip | `harvest/proc/sand_lip_*` | `sand_worked_dry` → `playground_sand` → `sand_*.jpg` |
| Boot black | `MeshKit.boot_leather()` · Madison field boots | `harvest/proc/boot_black_*` | `brown_leather` → `leather_bridle` → `leather_*.jpg` |
| Cooler wool | `MeshKit.cooler_wool()` · aisle cooler rug | `harvest/proc/cooler_navy_*` | `wool_navy_coat` → `wool_boucle` |
| Pine duff | `MeshKit.pine_duff()` · under the pines | `harvest/proc/pine_duff_wet_*` | `pine_needles` → `forest_floor` → `wood_*.jpg` |
| Clover | `MeshKit.clover()` · in-gate leaf | `harvest/proc/clover_patch_*` | `grass_clover` → `leafy_grass` → `grass_*.jpg` |
| Stall steel | `MeshKit.stall_steel()` · stall bars | `harvest/proc/stall_bar_*` | `metal_plate` → `acg_metal001` |
| Hydrant | `MeshKit.hydrant()` · barn yard hydrant | `harvest/proc/hydrant_metal_*` | `rusty_metal` → `metal_plate` |
| Velvet cap | `MeshKit.velvet()` · hunt cap fallback | `harvest/proc/velvet_cap_*` | `wool_navy_coat` → `wool_boucle` |
| Sweat leather | `MeshKit.leather_sweat()` · dark girth / billets | `harvest/proc/leather_sweat_*` | `leather_bridle` → `brown_leather` |

Not remapped (on purpose):

- Abbott `coat_albedo.jpg` — chestnut horse, not hunt wool
- Person photo kit (`rider_front.jpg` etc.) — Madison's face/coat photos stay primary
- `arena_half` / `RING_W` / `RING_D` unchanged
- No new gables or wings
