# Day 16 asset audit

Every file under `game/assets/`, except `.import` and `.uid`. Nothing was deleted, moved, or re-encoded.

A file is referenced when a `.gd`, `.tscn`, `.tres`, `.cfg` or `.json` file under `game/`, `content/` or `tools/` contains its `res://` path. A path built with `%02d`, `%d` or `%s` counts too: the numbers 0 to 99, and each quoted token in that same file. `mat_tex` and the sand loader turn an `_albedo` path into the `_normal` file beside it, so that normal counts as referenced. A bare file name counts only when that name occurs once under `game/assets/`. Shaders are not in that list. A file named only from a shader is in the note below, and still marked unreferenced. Nothing loads an `_rough` file by that rule.

Credit is a path or a file name found in an attribution file. Kenney's Nature Kit and the audio set are credited as folders: those files do not list each name. The horse and the rider are named in `meshes/ATTRIBUTION.txt`.

Files: 5398. Referenced: 3968. Unreferenced: 1430. No credit: 3808. Over 2048 px: 5. Over 5 MB: 3.

## Larger than 2048 px

- `assets/photos/IMG_3408.jpg` 4284 x 5712, 4.69 MB
- `assets/photos/IMG_3409.jpg` 4284 x 5712, 5.55 MB
- `assets/photos/abbott_title_drawn.jpg` 2560 x 1440, 457.7 KB
- `assets/textures/abbott_shader_face.jpg` 2227 x 5426, 825.1 KB
- `assets/textures/abbott_shader_stall.jpg` 1149 x 2499, 257.4 KB

## Larger than 5 MB

- `assets/cc0/polyhaven/kloofendal_48d_partly_cloudy_2k.hdr` 6.18 MB
- `assets/meshes/abbott.glb` 9.11 MB
- `assets/photos/IMG_3409.jpg` 5.55 MB

## Unreferenced

- `assets/ATTRIBUTION_HARVEST.md`
- `assets/audio/ATTRIBUTION.txt`
- `assets/audio/ambient_indoor.wav`
- `assets/cc0/kenney/ATTRIBUTION.txt`
- `assets/cc0/polyhaven/ATTRIBUTION.txt`
- `assets/meshes/ATTRIBUTION.txt`
- `assets/meshes/abbott_abbott_coat.png`
- `assets/meshes/abbott_abbott_eye.png`
- `assets/meshes/abbott_abbott_hair.png`
- `assets/meshes/abbott_v2.glb`
- `assets/meshes/inspect/whitehorse_uv_report.txt`
- `assets/photos/IMG_3408.jpg`
- `assets/photos/IMG_3409.jpg`
- `assets/photos/abbott_cinematic.jpg`
- `assets/textures/abbott_face_photo.jpg`
- `assets/textures/abbott_front_rgb.jpg`
- `assets/textures/abbott_side_rgb.jpg`
- `assets/textures/abbott_v2_coat.png`
- `assets/textures/abbott_wh_coat.png`
- `assets/textures/abbott_wh_eye.png`
- `assets/textures/abbott_wh_eye_black.png`
- `assets/textures/abbott_wh_hair.png`
- `assets/textures/abbott_wh_hoof.png`
- `assets/textures/abbott_wh_light.png`
- `assets/textures/abbott_wh_muzzle.png`
- `assets/textures/coat_normal.jpg`
- `assets/textures/coat_rough.jpg`
- `assets/textures/flower_box.jpg`
- `assets/textures/grass_rough.jpg`
- `assets/textures/harvest/proc/apron_dirt_rough.jpg`
- `assets/textures/harvest/proc/board_chalk_albedo.jpg`
- `assets/textures/harvest/proc/board_chalk_normal.jpg`
- `assets/textures/harvest/proc/board_chalk_rough.jpg`
- `assets/textures/harvest/proc/board_hunter_albedo.jpg`
- `assets/textures/harvest/proc/board_hunter_normal.jpg`
- `assets/textures/harvest/proc/board_hunter_rough.jpg`
- `assets/textures/harvest/proc/board_white_rough.jpg`
- `assets/textures/harvest/proc/boot_black_rough.jpg`
- `assets/textures/harvest/proc/brush_box_albedo.jpg`
- `assets/textures/harvest/proc/brush_box_normal.jpg`
- `assets/textures/harvest/proc/brush_box_rough.jpg`
- `assets/textures/harvest/proc/brush_dry_albedo.jpg`
- `assets/textures/harvest/proc/brush_dry_normal.jpg`
- `assets/textures/harvest/proc/brush_dry_rough.jpg`
- `assets/textures/harvest/proc/clover_patch_rough.jpg`
- `assets/textures/harvest/proc/cooler_navy_rough.jpg`
- `assets/textures/harvest/proc/duff_dry_albedo.jpg`
- `assets/textures/harvest/proc/duff_dry_normal.jpg`
- `assets/textures/harvest/proc/duff_dry_rough.jpg`
- `assets/textures/harvest/proc/fescue_late_albedo.jpg`
- `assets/textures/harvest/proc/fescue_late_normal.jpg`
- `assets/textures/harvest/proc/fescue_late_rough.jpg`
- `assets/textures/harvest/proc/flower_bloom_soil_albedo.jpg`
- `assets/textures/harvest/proc/flower_bloom_soil_normal.jpg`
- `assets/textures/harvest/proc/flower_bloom_soil_rough.jpg`
- `assets/textures/harvest/proc/flower_box_soil_rough.jpg`
- `assets/textures/harvest/proc/flower_soil_rough.jpg`
- `assets/textures/harvest/proc/grass_clover_rough.jpg`
- `assets/textures/harvest/proc/grass_dry_patch_albedo.jpg`
- `assets/textures/harvest/proc/grass_dry_patch_normal.jpg`
- `assets/textures/harvest/proc/grass_dry_patch_rough.jpg`
- `assets/textures/harvest/proc/grass_late_rust_albedo.jpg`
- `assets/textures/harvest/proc/grass_late_rust_normal.jpg`
- `assets/textures/harvest/proc/grass_late_rust_rough.jpg`
- `assets/textures/harvest/proc/grass_morning_albedo.jpg`
- `assets/textures/harvest/proc/grass_morning_normal.jpg`
- `assets/textures/harvest/proc/grass_morning_rough.jpg`
- `assets/textures/harvest/proc/grass_piedmont_normal.jpg`
- `assets/textures/harvest/proc/grass_piedmont_rough.jpg`
- `assets/textures/harvest/proc/grass_ring_edge_albedo.jpg`
- `assets/textures/harvest/proc/grass_ring_edge_normal.jpg`
- `assets/textures/harvest/proc/grass_ring_edge_rough.jpg`
- `assets/textures/harvest/proc/grass_shade_albedo.jpg`
- `assets/textures/harvest/proc/grass_shade_normal.jpg`
- `assets/textures/harvest/proc/grass_shade_rough.jpg`
- `assets/textures/harvest/proc/gravel_barn_yard_albedo.jpg`
- `assets/textures/harvest/proc/gravel_barn_yard_normal.jpg`
- `assets/textures/harvest/proc/gravel_barn_yard_rough.jpg`
- `assets/textures/harvest/proc/gravel_drive_rough.jpg`
- `assets/textures/harvest/proc/gravel_wet_albedo.jpg`
- `assets/textures/harvest/proc/gravel_wet_normal.jpg`
- `assets/textures/harvest/proc/gravel_wet_rough.jpg`
- `assets/textures/harvest/proc/hay_bale_rough.jpg`
- `assets/textures/harvest/proc/hay_dust_rough.jpg`
- `assets/textures/harvest/proc/hoof_cut_sand_albedo.jpg`
- `assets/textures/harvest/proc/hoof_cut_sand_normal.jpg`
- `assets/textures/harvest/proc/hoof_cut_sand_rough.jpg`
- `assets/textures/harvest/proc/hoof_wet_albedo.jpg`
- `assets/textures/harvest/proc/hoof_wet_normal.jpg`
- `assets/textures/harvest/proc/hoof_wet_rough.jpg`
- `assets/textures/harvest/proc/hydrant_metal_rough.jpg`
- `assets/textures/harvest/proc/iron_polish_albedo.jpg`
- `assets/textures/harvest/proc/iron_polish_normal.jpg`
- `assets/textures/harvest/proc/iron_polish_rough.jpg`
- `assets/textures/harvest/proc/kick_barn_albedo.jpg`
- `assets/textures/harvest/proc/kick_barn_normal.jpg`
- `assets/textures/harvest/proc/kick_barn_rough.jpg`
- `assets/textures/harvest/proc/kick_dark_rough.jpg`
- `assets/textures/harvest/proc/kick_scuff_albedo.jpg`
- `assets/textures/harvest/proc/kick_scuff_normal.jpg`
- `assets/textures/harvest/proc/kick_scuff_rough.jpg`
- `assets/textures/harvest/proc/leather_bridle_rough.jpg`
- `assets/textures/harvest/proc/leather_reins_albedo.jpg`
- `assets/textures/harvest/proc/leather_reins_normal.jpg`
- `assets/textures/harvest/proc/leather_reins_rough.jpg`
- `assets/textures/harvest/proc/leather_sweat_rough.jpg`
- `assets/textures/harvest/proc/natural_rail_albedo.jpg`
- `assets/textures/harvest/proc/natural_rail_normal.jpg`
- `assets/textures/harvest/proc/natural_rail_rough.jpg`
- `assets/textures/harvest/proc/navy_pole_albedo.jpg`
- `assets/textures/harvest/proc/navy_pole_normal.jpg`
- `assets/textures/harvest/proc/navy_pole_rough.jpg`
- `assets/textures/harvest/proc/oak_bark_rough.jpg`
- `assets/textures/harvest/proc/oak_fourboard_albedo.jpg`
- `assets/textures/harvest/proc/oak_fourboard_normal.jpg`
- `assets/textures/harvest/proc/oak_fourboard_rough.jpg`
- `assets/textures/harvest/proc/oak_leaf_late_albedo.jpg`
- `assets/textures/harvest/proc/oak_leaf_late_normal.jpg`
- `assets/textures/harvest/proc/oak_leaf_late_rough.jpg`
- `assets/textures/harvest/proc/oak_rust_albedo.jpg`
- `assets/textures/harvest/proc/oak_rust_normal.jpg`
- `assets/textures/harvest/proc/oak_rust_rough.jpg`
- `assets/textures/harvest/proc/pad_quilt_albedo.jpg`
- `assets/textures/harvest/proc/pad_quilt_normal.jpg`
- `assets/textures/harvest/proc/pad_quilt_rough.jpg`
- `assets/textures/harvest/proc/pine_bark_wet_albedo.jpg`
- `assets/textures/harvest/proc/pine_bark_wet_normal.jpg`
- `assets/textures/harvest/proc/pine_bark_wet_rough.jpg`
- `assets/textures/harvest/proc/pine_duff_wet_rough.jpg`
- `assets/textures/harvest/proc/pine_needle_shade_albedo.jpg`
- `assets/textures/harvest/proc/pine_needle_shade_normal.jpg`
- `assets/textures/harvest/proc/pine_needle_shade_rough.jpg`
- `assets/textures/harvest/proc/pine_needles_rough.jpg`
- `assets/textures/harvest/proc/plank_gate_albedo.jpg`
- `assets/textures/harvest/proc/plank_gate_normal.jpg`
- `assets/textures/harvest/proc/plank_gate_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_000_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_000_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_000_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_001_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_001_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_001_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_002_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_002_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_002_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_003_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_003_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_003_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_004_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_004_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_004_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_005_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_005_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_005_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_006_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_006_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_006_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_007_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_007_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_007_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_008_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_008_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_008_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_009_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_009_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_009_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_010_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_010_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_010_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_011_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_011_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_011_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_012_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_012_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_012_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_013_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_013_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_013_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_014_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_014_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_014_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_015_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_015_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_015_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_016_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_016_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_016_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_017_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_017_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_017_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_018_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_018_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_018_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_019_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_019_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_019_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_020_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_020_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_020_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_021_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_021_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_021_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_022_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_022_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_022_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_023_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_023_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_023_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_024_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_024_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_024_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_025_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_025_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_025_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_026_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_026_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_026_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_027_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_027_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_027_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_028_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_028_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_028_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_029_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_029_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_029_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_030_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_030_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_030_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_031_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_031_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_031_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_032_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_032_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_032_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_033_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_033_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_033_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_034_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_034_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_034_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_035_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_035_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_035_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_036_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_036_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_036_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_037_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_037_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_037_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_038_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_038_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_038_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_039_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_039_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_039_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_040_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_040_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_040_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_041_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_041_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_041_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_042_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_042_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_042_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_043_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_043_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_043_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_044_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_044_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_044_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_045_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_045_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_045_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_046_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_046_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_046_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_047_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_047_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_047_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_048_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_048_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_048_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_049_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_049_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_049_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_050_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_050_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_050_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_051_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_051_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_051_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_052_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_052_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_052_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_053_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_053_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_053_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_054_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_054_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_054_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_055_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_055_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_055_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_056_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_056_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_056_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_057_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_057_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_057_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_058_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_058_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_058_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_059_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_059_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_059_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_060_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_060_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_060_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_061_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_061_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_061_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_062_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_062_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_062_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_063_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_063_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_063_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_064_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_064_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_064_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_065_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_065_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_065_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_066_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_066_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_066_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_067_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_067_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_067_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_068_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_068_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_068_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_069_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_069_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_069_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_070_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_070_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_070_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_071_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_071_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_071_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_072_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_072_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_072_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_073_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_073_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_073_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_074_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_074_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_074_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_075_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_075_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_075_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_076_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_076_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_076_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_077_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_077_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_077_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_078_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_078_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_078_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_079_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_079_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_079_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_080_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_080_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_080_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_081_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_081_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_081_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_082_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_082_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_082_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_083_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_083_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_083_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_084_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_084_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_084_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_085_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_085_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_085_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_086_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_086_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_086_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_087_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_087_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_087_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_088_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_088_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_088_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_089_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_089_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_089_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_090_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_090_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_090_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_091_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_091_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_091_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_092_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_092_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_092_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_093_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_093_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_093_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_094_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_094_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_094_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_095_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_095_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_095_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_096_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_096_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_096_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_097_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_097_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_097_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_098_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_098_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_098_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_099_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_099_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_099_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_100_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_100_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_100_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_101_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_101_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_101_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_102_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_102_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_102_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_103_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_103_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_103_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_104_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_104_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_104_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_105_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_105_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_105_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_106_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_106_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_106_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_107_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_107_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_107_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_108_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_108_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_108_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_109_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_109_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_109_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_110_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_110_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_110_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_111_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_111_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_111_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_112_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_112_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_112_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_113_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_113_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_113_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_114_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_114_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_114_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_115_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_115_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_115_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_116_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_116_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_116_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_117_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_117_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_117_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_118_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_118_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_118_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_119_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_119_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_119_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_120_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_120_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_120_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_121_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_121_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_121_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_122_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_122_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_122_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_123_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_123_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_123_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_124_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_124_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_124_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_125_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_125_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_125_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_126_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_126_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_126_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_127_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_127_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_127_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_128_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_128_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_128_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_129_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_129_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_129_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_130_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_130_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_130_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_131_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_131_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_131_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_132_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_132_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_132_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_133_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_133_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_133_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_134_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_134_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_134_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_135_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_135_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_135_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_136_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_136_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_136_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_137_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_137_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_137_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_138_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_138_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_138_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_139_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_139_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_139_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_140_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_140_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_140_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_141_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_141_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_141_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_142_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_142_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_142_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_143_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_143_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_143_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_144_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_144_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_144_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_145_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_145_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_145_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_146_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_146_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_146_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_147_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_147_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_147_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_148_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_148_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_148_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_149_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_149_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_149_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_150_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_150_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_150_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_151_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_151_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_151_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_152_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_152_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_152_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_153_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_153_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_153_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_154_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_154_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_154_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_155_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_155_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_155_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_156_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_156_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_156_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_157_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_157_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_157_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_158_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_158_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_158_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_159_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_159_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_159_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_160_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_160_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_160_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_161_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_161_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_161_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_162_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_162_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_162_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_163_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_163_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_163_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_164_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_164_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_164_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_165_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_165_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_165_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_166_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_166_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_166_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_167_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_167_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_167_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_168_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_168_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_168_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_169_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_169_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_169_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_170_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_170_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_170_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_171_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_171_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_171_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_172_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_172_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_172_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_173_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_173_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_173_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_174_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_174_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_174_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_175_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_175_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_175_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_176_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_176_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_176_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_177_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_177_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_177_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_178_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_178_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_178_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_179_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_179_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_179_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_180_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_180_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_180_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_181_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_181_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_181_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_182_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_182_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_182_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_183_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_183_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_183_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_184_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_184_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_184_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_185_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_185_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_185_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_186_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_186_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_186_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_187_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_187_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_187_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_188_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_188_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_188_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_189_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_189_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_189_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_190_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_190_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_190_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_191_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_191_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_191_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_192_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_192_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_192_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_193_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_193_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_193_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_194_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_194_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_194_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_195_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_195_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_195_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_196_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_196_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_196_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_197_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_197_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_197_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_198_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_198_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_198_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_199_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_199_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_199_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_200_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_200_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_200_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_201_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_201_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_201_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_202_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_202_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_202_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_203_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_203_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_203_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_204_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_204_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_204_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_205_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_205_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_205_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_206_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_206_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_206_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_207_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_207_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_207_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_208_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_208_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_208_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_209_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_209_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_209_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_210_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_210_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_210_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_211_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_211_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_211_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_212_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_212_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_212_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_213_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_213_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_213_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_214_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_214_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_214_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_215_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_215_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_215_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_216_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_216_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_216_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_217_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_217_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_217_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_218_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_218_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_218_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_219_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_219_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_219_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_220_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_220_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_220_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_221_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_221_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_221_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_222_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_222_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_222_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_223_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_223_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_223_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_224_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_224_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_224_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_225_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_225_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_225_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_226_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_226_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_226_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_227_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_227_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_227_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_228_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_228_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_228_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_229_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_229_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_229_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_230_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_230_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_230_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_231_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_231_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_231_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_232_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_232_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_232_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_233_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_233_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_233_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_234_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_234_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_234_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_235_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_235_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_235_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_236_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_236_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_236_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_237_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_237_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_237_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_238_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_238_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_238_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_239_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_239_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_239_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_240_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_240_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_240_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_241_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_241_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_241_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_242_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_242_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_242_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_243_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_243_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_243_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_244_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_244_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_244_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_245_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_245_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_245_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_246_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_246_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_246_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_247_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_247_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_247_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_248_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_248_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_248_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_249_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_249_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_249_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_250_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_250_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_250_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_251_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_251_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_251_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_252_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_252_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_252_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_253_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_253_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_253_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_254_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_254_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_254_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_255_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_255_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_255_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_256_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_256_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_256_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_257_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_257_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_257_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_258_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_258_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_258_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_259_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_259_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_259_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_260_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_260_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_260_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_261_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_261_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_261_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_262_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_262_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_262_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_263_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_263_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_263_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_264_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_264_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_264_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_265_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_265_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_265_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_266_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_266_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_266_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_267_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_267_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_267_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_268_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_268_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_268_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_269_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_269_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_269_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_270_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_270_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_270_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_271_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_271_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_271_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_272_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_272_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_272_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_273_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_273_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_273_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_274_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_274_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_274_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_275_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_275_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_275_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_276_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_276_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_276_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_277_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_277_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_277_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_278_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_278_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_278_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_279_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_279_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_279_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_280_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_280_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_280_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_281_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_281_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_281_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_282_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_282_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_282_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_283_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_283_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_283_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_284_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_284_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_284_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_285_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_285_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_285_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_286_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_286_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_286_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_287_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_287_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_287_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_288_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_288_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_288_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_289_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_289_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_289_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_290_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_290_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_290_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_291_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_291_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_291_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_292_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_292_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_292_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_293_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_293_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_293_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_294_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_294_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_294_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_295_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_295_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_295_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_296_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_296_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_296_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_297_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_297_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_297_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_298_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_298_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_298_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_299_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_299_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_299_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_300_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_300_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_300_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_301_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_301_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_301_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_302_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_302_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_302_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_303_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_303_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_303_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_304_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_304_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_304_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_305_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_305_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_305_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_306_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_306_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_306_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_307_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_307_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_307_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_308_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_308_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_308_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_309_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_309_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_309_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_310_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_310_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_310_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_311_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_311_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_311_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_312_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_312_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_312_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_313_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_313_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_313_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_314_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_314_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_314_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_315_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_315_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_315_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_316_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_316_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_316_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_317_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_317_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_317_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_318_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_318_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_318_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_319_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_319_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_319_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_320_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_320_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_320_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_321_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_321_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_321_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_322_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_322_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_322_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_323_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_323_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_323_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_324_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_324_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_324_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_325_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_325_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_325_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_326_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_326_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_326_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_327_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_327_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_327_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_328_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_328_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_328_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_329_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_329_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_329_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_330_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_330_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_330_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_331_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_331_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_331_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_332_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_332_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_332_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_333_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_333_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_333_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_334_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_334_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_334_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_335_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_335_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_335_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_336_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_336_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_336_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_337_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_337_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_337_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_338_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_338_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_338_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_339_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_339_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_339_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_340_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_340_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_340_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_341_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_341_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_341_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_342_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_342_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_342_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_343_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_343_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_343_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_344_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_344_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_344_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_345_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_345_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_345_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_346_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_346_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_346_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_347_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_347_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_347_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_348_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_348_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_348_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_349_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_349_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_349_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_350_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_350_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_350_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_351_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_351_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_351_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_352_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_352_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_352_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_353_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_353_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_353_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_354_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_354_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_354_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_355_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_355_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_355_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_356_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_356_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_356_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_357_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_357_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_357_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_358_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_358_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_358_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_359_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_359_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_359_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_360_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_360_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_360_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_361_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_361_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_361_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_362_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_362_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_362_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_363_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_363_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_363_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_364_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_364_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_364_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_365_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_365_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_365_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_366_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_366_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_366_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_367_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_367_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_367_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_368_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_368_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_368_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_369_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_369_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_369_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_370_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_370_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_370_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_371_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_371_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_371_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_372_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_372_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_372_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_373_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_373_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_373_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_374_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_374_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_374_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_375_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_375_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_375_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_376_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_376_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_376_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_377_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_377_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_377_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_378_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_378_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_378_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_379_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_379_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_379_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_380_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_380_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_380_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_381_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_381_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_381_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_382_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_382_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_382_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_383_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_383_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_383_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_384_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_384_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_384_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_385_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_385_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_385_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_386_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_386_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_386_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_387_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_387_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_387_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_388_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_388_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_388_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_389_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_389_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_389_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_390_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_390_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_390_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_391_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_391_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_391_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_392_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_392_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_392_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_393_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_393_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_393_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_394_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_394_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_394_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_395_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_395_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_395_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_396_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_396_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_396_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_397_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_397_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_397_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_398_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_398_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_398_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_399_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_399_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_399_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_400_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_400_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_400_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_401_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_401_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_401_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_402_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_402_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_402_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_403_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_403_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_403_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_404_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_404_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_404_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_405_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_405_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_405_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_406_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_406_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_406_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_407_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_407_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_407_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_408_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_408_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_408_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_409_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_409_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_409_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_410_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_410_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_410_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_411_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_411_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_411_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_412_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_412_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_412_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_413_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_413_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_413_rough.jpg`
- `assets/textures/harvest/proc/rail_natural_rough.jpg`
- `assets/textures/harvest/proc/rail_white_scuff_albedo.jpg`
- `assets/textures/harvest/proc/rail_white_scuff_normal.jpg`
- `assets/textures/harvest/proc/rail_white_scuff_rough.jpg`
- `assets/textures/harvest/proc/rake_deep_albedo.jpg`
- `assets/textures/harvest/proc/rake_deep_normal.jpg`
- `assets/textures/harvest/proc/rake_deep_rough.jpg`
- `assets/textures/harvest/proc/salt_block_albedo.jpg`
- `assets/textures/harvest/proc/salt_block_normal.jpg`
- `assets/textures/harvest/proc/salt_block_rough.jpg`
- `assets/textures/harvest/proc/sand_hoof_albedo.jpg`
- `assets/textures/harvest/proc/sand_hoof_normal.jpg`
- `assets/textures/harvest/proc/sand_hoof_rough.jpg`
- `assets/textures/harvest/proc/sand_lip_rough.jpg`
- `assets/textures/harvest/proc/sand_rake_albedo.jpg`
- `assets/textures/harvest/proc/sand_rake_normal.jpg`
- `assets/textures/harvest/proc/sand_rake_rough.jpg`
- `assets/textures/harvest/proc/sand_track_albedo.jpg`
- `assets/textures/harvest/proc/sand_track_normal.jpg`
- `assets/textures/harvest/proc/sand_track_rough.jpg`
- `assets/textures/harvest/proc/sand_wet_center_albedo.jpg`
- `assets/textures/harvest/proc/sand_wet_center_normal.jpg`
- `assets/textures/harvest/proc/sand_wet_center_rough.jpg`
- `assets/textures/harvest/proc/sand_worked_dry_rough.jpg`
- `assets/textures/harvest/proc/sand_worked_wet_albedo.jpg`
- `assets/textures/harvest/proc/sand_worked_wet_normal.jpg`
- `assets/textures/harvest/proc/sand_worked_wet_rough.jpg`
- `assets/textures/harvest/proc/stall_bar_rough.jpg`
- `assets/textures/harvest/proc/straw_gold_rough.jpg`
- `assets/textures/harvest/proc/tack_trunk_albedo.jpg`
- `assets/textures/harvest/proc/tack_trunk_normal.jpg`
- `assets/textures/harvest/proc/tack_trunk_rough.jpg`
- `assets/textures/harvest/proc/velvet_cap_rough.jpg`
- `assets/textures/harvest/proc/wool_melton_albedo.jpg`
- `assets/textures/harvest/proc/wool_melton_normal.jpg`
- `assets/textures/harvest/proc/wool_melton_rough.jpg`
- `assets/textures/harvest/proc/wool_navy_coat_rough.jpg`
- `assets/textures/harvest/proc/wool_navy_weave_albedo.jpg`
- `assets/textures/harvest/proc/wool_navy_weave_normal.jpg`
- `assets/textures/harvest/proc/wool_navy_weave_rough.jpg`
- `assets/textures/leather_rough.jpg`
- `assets/textures/mane_albedo.jpg`
- `assets/textures/mane_normal.jpg`
- `assets/textures/mane_rough.jpg`
- `assets/textures/pole_ref.jpg`
- `assets/textures/saddle_ref.jpg`
- `assets/textures/sand_rough.jpg`
- `assets/textures/standard_ref.jpg`
- `assets/textures/wood_rough.jpg`
- `assets/ui/icon_256.png`
- `assets/ui/panel.jpg`
- `assets/ui/panel_blank.jpg`

## No credit

- `assets/ATTRIBUTION_HARVEST.md`
- `assets/audio/ATTRIBUTION.txt`
- `assets/cc0/kenney/ATTRIBUTION.txt`
- `assets/cc0/polyhaven/ATTRIBUTION.txt`
- `assets/fonts/LibreBaskerville-Bold.ttf`
- `assets/fonts/LibreBaskerville-Regular.ttf`
- `assets/fonts/SourceSans3-Regular.ttf`
- `assets/meshes/ATTRIBUTION.txt`
- `assets/meshes/abbott.glb`
- `assets/meshes/abbott_abbott_coat.png`
- `assets/meshes/abbott_abbott_eye.png`
- `assets/meshes/abbott_abbott_hair.png`
- `assets/meshes/abbott_v2d.glb`
- `assets/meshes/inspect/whitehorse_uv_report.txt`
- `assets/meshes/quaternius-WhiteHorse.glb`
- `assets/photos/IMG_3408.jpg`
- `assets/photos/IMG_3409.jpg`
- `assets/photos/abbott_cinematic.jpg`
- `assets/photos/abbott_title.jpg`
- `assets/photos/abbott_title_drawn.jpg`
- `assets/textures/abbott_face_photo.jpg`
- `assets/textures/abbott_front.png`
- `assets/textures/abbott_front_rgb.jpg`
- `assets/textures/abbott_shader_coat.jpg`
- `assets/textures/abbott_shader_face.jpg`
- `assets/textures/abbott_shader_stall.jpg`
- `assets/textures/abbott_side.png`
- `assets/textures/abbott_side_rgb.jpg`
- `assets/textures/abbott_v2_coat.png`
- `assets/textures/abbott_wh_coat.png`
- `assets/textures/abbott_wh_eye.png`
- `assets/textures/abbott_wh_eye_black.png`
- `assets/textures/abbott_wh_hair.png`
- `assets/textures/abbott_wh_hoof.png`
- `assets/textures/abbott_wh_light.png`
- `assets/textures/abbott_wh_muzzle.png`
- `assets/textures/coat_albedo.jpg`
- `assets/textures/coat_normal.jpg`
- `assets/textures/coat_rough.jpg`
- `assets/textures/flower_box.jpg`
- `assets/textures/harvest/acg_bark001_wet_000_dry_001_normal.jpg`
- `assets/textures/harvest/acg_bark001_wet_000_dry_001_rough.jpg`
- `assets/textures/harvest/acg_bark001_wet_000_dry_001_shade_002_normal.jpg`
- `assets/textures/harvest/acg_bark001_wet_000_dry_001_shade_002_rake_003_normal.jpg`
- `assets/textures/harvest/acg_bark001_wet_000_dry_001_shade_002_rake_003_rough.jpg`
- `assets/textures/harvest/acg_bark001_wet_000_dry_001_shade_002_rough.jpg`
- `assets/textures/harvest/acg_bark001_wet_000_dry_001_shade_642_normal.jpg`
- `assets/textures/harvest/acg_bark001_wet_000_dry_001_shade_642_rough.jpg`
- `assets/textures/harvest/acg_bark001_wet_000_dry_321_late_004_normal.jpg`
- `assets/textures/harvest/acg_bark001_wet_000_dry_321_late_004_rough.jpg`
- `assets/textures/harvest/acg_bark001_wet_000_dry_321_normal.jpg`
- `assets/textures/harvest/acg_bark001_wet_000_dry_321_rough.jpg`
- `assets/textures/harvest/acg_bark001_wet_000_dry_641_normal.jpg`
- `assets/textures/harvest/acg_bark001_wet_000_dry_641_rough.jpg`
- `assets/textures/harvest/acg_bark001_wet_000_normal.jpg`
- `assets/textures/harvest/acg_bark001_wet_000_rough.jpg`
- `assets/textures/harvest/acg_bark001_wet_160_normal.jpg`
- `assets/textures/harvest/acg_bark001_wet_160_rake_003_dry_006_normal.jpg`
- `assets/textures/harvest/acg_bark001_wet_160_rake_003_dry_006_rough.jpg`
- `assets/textures/harvest/acg_bark001_wet_160_rake_003_normal.jpg`
- `assets/textures/harvest/acg_bark001_wet_160_rake_003_rough.jpg`
- `assets/textures/harvest/acg_bark001_wet_160_rough.jpg`
- `assets/textures/harvest/acg_bark001_wet_160_wet_005_normal.jpg`
- `assets/textures/harvest/acg_bark001_wet_160_wet_005_rough.jpg`
- `assets/textures/harvest/acg_bark001_wet_320_normal.jpg`
- `assets/textures/harvest/acg_bark001_wet_320_rough.jpg`
- `assets/textures/harvest/acg_bark001_wet_320_shade_007_normal.jpg`
- `assets/textures/harvest/acg_bark001_wet_320_shade_007_rough.jpg`
- `assets/textures/harvest/acg_bark001_wet_640_normal.jpg`
- `assets/textures/harvest/acg_bark001_wet_640_rough.jpg`
- `assets/textures/harvest/acg_bark002_dry_001_late_009_normal.jpg`
- `assets/textures/harvest/acg_bark002_dry_001_late_009_rough.jpg`
- `assets/textures/harvest/acg_bark002_dry_001_normal.jpg`
- `assets/textures/harvest/acg_bark002_dry_001_rake_003_dry_006_dry_011_normal.jpg`
- `assets/textures/harvest/acg_bark002_dry_001_rake_003_dry_006_dry_011_rough.jpg`
- `assets/textures/harvest/acg_bark002_dry_001_rake_003_dry_006_normal.jpg`
- `assets/textures/harvest/acg_bark002_dry_001_rake_003_dry_006_rough.jpg`
- `assets/textures/harvest/acg_bark002_dry_001_rake_003_normal.jpg`
- `assets/textures/harvest/acg_bark002_dry_001_rake_003_rough.jpg`
- `assets/textures/harvest/acg_bark002_dry_001_rake_003_wet_010_normal.jpg`
- `assets/textures/harvest/acg_bark002_dry_001_rake_003_wet_010_rough.jpg`
- `assets/textures/harvest/acg_bark002_dry_001_rough.jpg`
- `assets/textures/harvest/acg_bark002_dry_001_wet_005_normal.jpg`
- `assets/textures/harvest/acg_bark002_dry_001_wet_005_rough.jpg`
- `assets/textures/harvest/acg_bark002_dry_001_wet_005_shade_012_normal.jpg`
- `assets/textures/harvest/acg_bark002_dry_001_wet_005_shade_012_rough.jpg`
- `assets/textures/harvest/acg_bark002_late_004_normal.jpg`
- `assets/textures/harvest/acg_bark002_late_004_rake_013_normal.jpg`
- `assets/textures/harvest/acg_bark002_late_004_rake_013_rough.jpg`
- `assets/textures/harvest/acg_bark002_late_004_rough.jpg`
- `assets/textures/harvest/acg_bark002_rake_008_normal.jpg`
- `assets/textures/harvest/acg_bark002_rake_008_rough.jpg`
- `assets/textures/harvest/acg_bark002_shade_002_late_014_normal.jpg`
- `assets/textures/harvest/acg_bark002_shade_002_late_014_rough.jpg`
- `assets/textures/harvest/acg_bark002_shade_002_normal.jpg`
- `assets/textures/harvest/acg_bark002_shade_002_rough.jpg`
- `assets/textures/harvest/acg_bark002_shade_002_shade_007_normal.jpg`
- `assets/textures/harvest/acg_bark002_shade_002_shade_007_rough.jpg`
- `assets/textures/harvest/acg_bark002_shade_002_shade_007_wet_015_normal.jpg`
- `assets/textures/harvest/acg_bark002_shade_002_shade_007_wet_015_rough.jpg`
- `assets/textures/harvest/acg_bark006_dry_016_normal.jpg`
- `assets/textures/harvest/acg_bark006_dry_016_rough.jpg`
- `assets/textures/harvest/acg_bark006_late_004_late_009_normal.jpg`
- `assets/textures/harvest/acg_bark006_late_004_late_009_rake_018_normal.jpg`
- `assets/textures/harvest/acg_bark006_late_004_late_009_rake_018_rough.jpg`
- `assets/textures/harvest/acg_bark006_late_004_late_009_rough.jpg`
- `assets/textures/harvest/acg_bark006_late_004_normal.jpg`
- `assets/textures/harvest/acg_bark006_late_004_rough.jpg`
- `assets/textures/harvest/acg_bark006_late_004_shade_017_normal.jpg`
- `assets/textures/harvest/acg_bark006_late_004_shade_017_rough.jpg`
- `assets/textures/harvest/acg_bark006_rake_008_late_019_normal.jpg`
- `assets/textures/harvest/acg_bark006_rake_008_late_019_rough.jpg`
- `assets/textures/harvest/acg_bark006_rake_008_normal.jpg`
- `assets/textures/harvest/acg_bark006_rake_008_rough.jpg`
- `assets/textures/harvest/acg_bark006_shade_002_normal.jpg`
- `assets/textures/harvest/acg_bark006_shade_002_rough.jpg`
- `assets/textures/harvest/acg_bark006_shade_002_wet_005_dry_011_normal.jpg`
- `assets/textures/harvest/acg_bark006_shade_002_wet_005_dry_011_rough.jpg`
- `assets/textures/harvest/acg_bark006_shade_002_wet_005_dry_011_shade_022_normal.jpg`
- `assets/textures/harvest/acg_bark006_shade_002_wet_005_dry_011_shade_022_rough.jpg`
- `assets/textures/harvest/acg_bark006_shade_002_wet_005_dry_021_normal.jpg`
- `assets/textures/harvest/acg_bark006_shade_002_wet_005_dry_021_rough.jpg`
- `assets/textures/harvest/acg_bark006_shade_002_wet_005_normal.jpg`
- `assets/textures/harvest/acg_bark006_shade_002_wet_005_rough.jpg`
- `assets/textures/harvest/acg_bark006_shade_002_wet_010_normal.jpg`
- `assets/textures/harvest/acg_bark006_shade_002_wet_010_rake_023_normal.jpg`
- `assets/textures/harvest/acg_bark006_shade_002_wet_010_rake_023_rough.jpg`
- `assets/textures/harvest/acg_bark006_shade_002_wet_010_rough.jpg`
- `assets/textures/harvest/acg_bark006_shade_002_wet_020_normal.jpg`
- `assets/textures/harvest/acg_bark006_shade_002_wet_020_rough.jpg`
- `assets/textures/harvest/acg_bark007_dry_006_normal.jpg`
- `assets/textures/harvest/acg_bark007_dry_006_rake_013_dry_026_normal.jpg`
- `assets/textures/harvest/acg_bark007_dry_006_rake_013_dry_026_rough.jpg`
- `assets/textures/harvest/acg_bark007_dry_006_rake_013_normal.jpg`
- `assets/textures/harvest/acg_bark007_dry_006_rake_013_rough.jpg`
- `assets/textures/harvest/acg_bark007_dry_006_rough.jpg`
- `assets/textures/harvest/acg_bark007_dry_006_wet_025_normal.jpg`
- `assets/textures/harvest/acg_bark007_dry_006_wet_025_rough.jpg`
- `assets/textures/harvest/acg_bark007_late_024_normal.jpg`
- `assets/textures/harvest/acg_bark007_late_024_rough.jpg`
- `assets/textures/harvest/acg_bark007_rake_003_late_014_normal.jpg`
- `assets/textures/harvest/acg_bark007_rake_003_late_014_rake_028_normal.jpg`
- `assets/textures/harvest/acg_bark007_rake_003_late_014_rake_028_rough.jpg`
- `assets/textures/harvest/acg_bark007_rake_003_late_014_rough.jpg`
- `assets/textures/harvest/acg_bark007_rake_003_normal.jpg`
- `assets/textures/harvest/acg_bark007_rake_003_rough.jpg`
- `assets/textures/harvest/acg_bark007_rake_003_shade_007_late_029_normal.jpg`
- `assets/textures/harvest/acg_bark007_rake_003_shade_007_late_029_rough.jpg`
- `assets/textures/harvest/acg_bark007_rake_003_shade_007_normal.jpg`
- `assets/textures/harvest/acg_bark007_rake_003_shade_007_rough.jpg`
- `assets/textures/harvest/acg_bark007_rake_003_shade_007_wet_015_normal.jpg`
- `assets/textures/harvest/acg_bark007_rake_003_shade_007_wet_015_rough.jpg`
- `assets/textures/harvest/acg_bark007_rake_003_shade_007_wet_015_wet_030_normal.jpg`
- `assets/textures/harvest/acg_bark007_rake_003_shade_007_wet_015_wet_030_rough.jpg`
- `assets/textures/harvest/acg_bark007_rake_003_shade_027_normal.jpg`
- `assets/textures/harvest/acg_bark007_rake_003_shade_027_rough.jpg`
- `assets/textures/harvest/acg_bark007_shade_012_dry_031_normal.jpg`
- `assets/textures/harvest/acg_bark007_shade_012_dry_031_rough.jpg`
- `assets/textures/harvest/acg_bark007_shade_012_normal.jpg`
- `assets/textures/harvest/acg_bark007_shade_012_rough.jpg`
- `assets/textures/harvest/acg_bark012_dry_016_normal.jpg`
- `assets/textures/harvest/acg_bark012_dry_016_rake_033_normal.jpg`
- `assets/textures/harvest/acg_bark012_dry_016_rake_033_rough.jpg`
- `assets/textures/harvest/acg_bark012_dry_016_rough.jpg`
- `assets/textures/harvest/acg_bark012_late_004_late_009_normal.jpg`
- `assets/textures/harvest/acg_bark012_late_004_late_009_rake_018_dry_036_normal.jpg`
- `assets/textures/harvest/acg_bark012_late_004_late_009_rake_018_dry_036_rough.jpg`
- `assets/textures/harvest/acg_bark012_late_004_late_009_rake_018_normal.jpg`
- `assets/textures/harvest/acg_bark012_late_004_late_009_rake_018_rough.jpg`
- `assets/textures/harvest/acg_bark012_late_004_late_009_rough.jpg`
- `assets/textures/harvest/acg_bark012_late_004_late_009_wet_035_normal.jpg`
- `assets/textures/harvest/acg_bark012_late_004_late_009_wet_035_rough.jpg`
- `assets/textures/harvest/acg_bark012_late_004_late_034_normal.jpg`
- `assets/textures/harvest/acg_bark012_late_004_late_034_rough.jpg`
- `assets/textures/harvest/acg_bark012_late_004_normal.jpg`
- `assets/textures/harvest/acg_bark012_late_004_rough.jpg`
- `assets/textures/harvest/acg_bark012_late_004_shade_017_normal.jpg`
- `assets/textures/harvest/acg_bark012_late_004_shade_017_rough.jpg`
- `assets/textures/harvest/acg_bark012_late_004_shade_017_shade_037_normal.jpg`
- `assets/textures/harvest/acg_bark012_late_004_shade_017_shade_037_rough.jpg`
- `assets/textures/harvest/acg_bark012_rake_008_late_019_late_039_normal.jpg`
- `assets/textures/harvest/acg_bark012_rake_008_late_019_late_039_rough.jpg`
- `assets/textures/harvest/acg_bark012_rake_008_late_019_normal.jpg`
- `assets/textures/harvest/acg_bark012_rake_008_late_019_rough.jpg`
- `assets/textures/harvest/acg_bark012_rake_008_normal.jpg`
- `assets/textures/harvest/acg_bark012_rake_008_rake_038_normal.jpg`
- `assets/textures/harvest/acg_bark012_rake_008_rake_038_rough.jpg`
- `assets/textures/harvest/acg_bark012_rake_008_rough.jpg`
- `assets/textures/harvest/acg_bark012_shade_032_normal.jpg`
- `assets/textures/harvest/acg_bark012_shade_032_rough.jpg`
- `assets/textures/harvest/acg_fabric001_wet_005_dry_011_normal.jpg`
- `assets/textures/harvest/acg_fabric001_wet_005_dry_011_rough.jpg`
- `assets/textures/harvest/acg_fabric001_wet_005_dry_011_shade_022_normal.jpg`
- `assets/textures/harvest/acg_fabric001_wet_005_dry_011_shade_022_rake_043_normal.jpg`
- `assets/textures/harvest/acg_fabric001_wet_005_dry_011_shade_022_rake_043_rough.jpg`
- `assets/textures/harvest/acg_fabric001_wet_005_dry_011_shade_022_rough.jpg`
- `assets/textures/harvest/acg_fabric001_wet_005_dry_011_shade_042_normal.jpg`
- `assets/textures/harvest/acg_fabric001_wet_005_dry_011_shade_042_rough.jpg`
- `assets/textures/harvest/acg_fabric001_wet_005_dry_021_late_044_normal.jpg`
- `assets/textures/harvest/acg_fabric001_wet_005_dry_021_late_044_rough.jpg`
- `assets/textures/harvest/acg_fabric001_wet_005_dry_021_normal.jpg`
- `assets/textures/harvest/acg_fabric001_wet_005_dry_021_rough.jpg`
- `assets/textures/harvest/acg_fabric001_wet_005_dry_041_normal.jpg`
- `assets/textures/harvest/acg_fabric001_wet_005_dry_041_rough.jpg`
- `assets/textures/harvest/acg_fabric001_wet_005_normal.jpg`
- `assets/textures/harvest/acg_fabric001_wet_005_rough.jpg`
- `assets/textures/harvest/acg_fabric001_wet_010_normal.jpg`
- `assets/textures/harvest/acg_fabric001_wet_010_rake_023_dry_046_normal.jpg`
- `assets/textures/harvest/acg_fabric001_wet_010_rake_023_dry_046_rough.jpg`
- `assets/textures/harvest/acg_fabric001_wet_010_rake_023_normal.jpg`
- `assets/textures/harvest/acg_fabric001_wet_010_rake_023_rough.jpg`
- `assets/textures/harvest/acg_fabric001_wet_010_rough.jpg`
- `assets/textures/harvest/acg_fabric001_wet_010_wet_045_normal.jpg`
- `assets/textures/harvest/acg_fabric001_wet_010_wet_045_rough.jpg`
- `assets/textures/harvest/acg_fabric001_wet_020_normal.jpg`
- `assets/textures/harvest/acg_fabric001_wet_020_rough.jpg`
- `assets/textures/harvest/acg_fabric001_wet_020_shade_047_normal.jpg`
- `assets/textures/harvest/acg_fabric001_wet_020_shade_047_rough.jpg`
- `assets/textures/harvest/acg_fabric001_wet_040_normal.jpg`
- `assets/textures/harvest/acg_fabric001_wet_040_rough.jpg`
- `assets/textures/harvest/acg_fabric004_dry_006_late_049_normal.jpg`
- `assets/textures/harvest/acg_fabric004_dry_006_late_049_rough.jpg`
- `assets/textures/harvest/acg_fabric004_dry_006_normal.jpg`
- `assets/textures/harvest/acg_fabric004_dry_006_rake_013_dry_026_dry_051_normal.jpg`
- `assets/textures/harvest/acg_fabric004_dry_006_rake_013_dry_026_dry_051_rough.jpg`
- `assets/textures/harvest/acg_fabric004_dry_006_rake_013_dry_026_normal.jpg`
- `assets/textures/harvest/acg_fabric004_dry_006_rake_013_dry_026_rough.jpg`
- `assets/textures/harvest/acg_fabric004_dry_006_rake_013_normal.jpg`
- `assets/textures/harvest/acg_fabric004_dry_006_rake_013_rough.jpg`
- `assets/textures/harvest/acg_fabric004_dry_006_rake_013_wet_050_normal.jpg`
- `assets/textures/harvest/acg_fabric004_dry_006_rake_013_wet_050_rough.jpg`
- `assets/textures/harvest/acg_fabric004_dry_006_rough.jpg`
- `assets/textures/harvest/acg_fabric004_dry_006_wet_025_normal.jpg`
- `assets/textures/harvest/acg_fabric004_dry_006_wet_025_rough.jpg`
- `assets/textures/harvest/acg_fabric004_dry_006_wet_025_shade_052_normal.jpg`
- `assets/textures/harvest/acg_fabric004_dry_006_wet_025_shade_052_rough.jpg`
- `assets/textures/harvest/acg_fabric004_late_024_normal.jpg`
- `assets/textures/harvest/acg_fabric004_late_024_rake_053_normal.jpg`
- `assets/textures/harvest/acg_fabric004_late_024_rake_053_rough.jpg`
- `assets/textures/harvest/acg_fabric004_late_024_rough.jpg`
- `assets/textures/harvest/acg_fabric004_rake_048_normal.jpg`
- `assets/textures/harvest/acg_fabric004_rake_048_rough.jpg`
- `assets/textures/harvest/acg_fabric004_shade_012_late_054_normal.jpg`
- `assets/textures/harvest/acg_fabric004_shade_012_late_054_rough.jpg`
- `assets/textures/harvest/acg_fabric004_shade_012_normal.jpg`
- `assets/textures/harvest/acg_fabric004_shade_012_rough.jpg`
- `assets/textures/harvest/acg_fabric004_shade_012_shade_027_normal.jpg`
- `assets/textures/harvest/acg_fabric004_shade_012_shade_027_rough.jpg`
- `assets/textures/harvest/acg_fabric004_shade_012_shade_027_wet_055_normal.jpg`
- `assets/textures/harvest/acg_fabric004_shade_012_shade_027_wet_055_rough.jpg`
- `assets/textures/harvest/acg_fabric018_dry_056_normal.jpg`
- `assets/textures/harvest/acg_fabric018_dry_056_rough.jpg`
- `assets/textures/harvest/acg_fabric018_late_014_late_029_normal.jpg`
- `assets/textures/harvest/acg_fabric018_late_014_late_029_rake_058_normal.jpg`
- `assets/textures/harvest/acg_fabric018_late_014_late_029_rake_058_rough.jpg`
- `assets/textures/harvest/acg_fabric018_late_014_late_029_rough.jpg`
- `assets/textures/harvest/acg_fabric018_late_014_normal.jpg`
- `assets/textures/harvest/acg_fabric018_late_014_rough.jpg`
- `assets/textures/harvest/acg_fabric018_late_014_shade_057_normal.jpg`
- `assets/textures/harvest/acg_fabric018_late_014_shade_057_rough.jpg`
- `assets/textures/harvest/acg_fabric018_rake_028_late_059_normal.jpg`
- `assets/textures/harvest/acg_fabric018_rake_028_late_059_rough.jpg`
- `assets/textures/harvest/acg_fabric018_rake_028_normal.jpg`
- `assets/textures/harvest/acg_fabric018_rake_028_rough.jpg`
- `assets/textures/harvest/acg_fabric018_shade_007_normal.jpg`
- `assets/textures/harvest/acg_fabric018_shade_007_rough.jpg`
- `assets/textures/harvest/acg_fabric018_shade_007_wet_015_dry_031_normal.jpg`
- `assets/textures/harvest/acg_fabric018_shade_007_wet_015_dry_031_rough.jpg`
- `assets/textures/harvest/acg_fabric018_shade_007_wet_015_dry_031_shade_062_normal.jpg`
- `assets/textures/harvest/acg_fabric018_shade_007_wet_015_dry_031_shade_062_rough.jpg`
- `assets/textures/harvest/acg_fabric018_shade_007_wet_015_dry_061_normal.jpg`
- `assets/textures/harvest/acg_fabric018_shade_007_wet_015_dry_061_rough.jpg`
- `assets/textures/harvest/acg_fabric018_shade_007_wet_015_normal.jpg`
- `assets/textures/harvest/acg_fabric018_shade_007_wet_015_rough.jpg`
- `assets/textures/harvest/acg_fabric018_shade_007_wet_030_normal.jpg`
- `assets/textures/harvest/acg_fabric018_shade_007_wet_030_rake_063_normal.jpg`
- `assets/textures/harvest/acg_fabric018_shade_007_wet_030_rake_063_rough.jpg`
- `assets/textures/harvest/acg_fabric018_shade_007_wet_030_rough.jpg`
- `assets/textures/harvest/acg_fabric018_shade_007_wet_060_normal.jpg`
- `assets/textures/harvest/acg_fabric018_shade_007_wet_060_rough.jpg`
- `assets/textures/harvest/acg_fabric046_dry_016_normal.jpg`
- `assets/textures/harvest/acg_fabric046_dry_016_rake_033_dry_066_normal.jpg`
- `assets/textures/harvest/acg_fabric046_dry_016_rake_033_dry_066_rough.jpg`
- `assets/textures/harvest/acg_fabric046_dry_016_rake_033_normal.jpg`
- `assets/textures/harvest/acg_fabric046_dry_016_rake_033_rough.jpg`
- `assets/textures/harvest/acg_fabric046_dry_016_rough.jpg`
- `assets/textures/harvest/acg_fabric046_dry_016_wet_065_normal.jpg`
- `assets/textures/harvest/acg_fabric046_dry_016_wet_065_rough.jpg`
- `assets/textures/harvest/acg_fabric046_late_064_normal.jpg`
- `assets/textures/harvest/acg_fabric046_late_064_rough.jpg`
- `assets/textures/harvest/acg_fabric046_rake_008_late_034_normal.jpg`
- `assets/textures/harvest/acg_fabric046_rake_008_late_034_rake_068_normal.jpg`
- `assets/textures/harvest/acg_fabric046_rake_008_late_034_rake_068_rough.jpg`
- `assets/textures/harvest/acg_fabric046_rake_008_late_034_rough.jpg`
- `assets/textures/harvest/acg_fabric046_rake_008_normal.jpg`
- `assets/textures/harvest/acg_fabric046_rake_008_rough.jpg`
- `assets/textures/harvest/acg_fabric046_rake_008_shade_017_late_069_normal.jpg`
- `assets/textures/harvest/acg_fabric046_rake_008_shade_017_late_069_rough.jpg`
- `assets/textures/harvest/acg_fabric046_rake_008_shade_017_normal.jpg`
- `assets/textures/harvest/acg_fabric046_rake_008_shade_017_rough.jpg`
- `assets/textures/harvest/acg_fabric046_rake_008_shade_017_wet_035_normal.jpg`
- `assets/textures/harvest/acg_fabric046_rake_008_shade_017_wet_035_rough.jpg`
- `assets/textures/harvest/acg_fabric046_rake_008_shade_017_wet_035_wet_070_normal.jpg`
- `assets/textures/harvest/acg_fabric046_rake_008_shade_017_wet_035_wet_070_rough.jpg`
- `assets/textures/harvest/acg_fabric046_rake_008_shade_067_normal.jpg`
- `assets/textures/harvest/acg_fabric046_rake_008_shade_067_rough.jpg`
- `assets/textures/harvest/acg_fabric046_shade_032_dry_071_normal.jpg`
- `assets/textures/harvest/acg_fabric046_shade_032_dry_071_rough.jpg`
- `assets/textures/harvest/acg_fabric046_shade_032_normal.jpg`
- `assets/textures/harvest/acg_fabric046_shade_032_rough.jpg`
- `assets/textures/harvest/acg_grass001_dry_036_normal.jpg`
- `assets/textures/harvest/acg_grass001_dry_036_rake_073_normal.jpg`
- `assets/textures/harvest/acg_grass001_dry_036_rake_073_rough.jpg`
- `assets/textures/harvest/acg_grass001_dry_036_rough.jpg`
- `assets/textures/harvest/acg_grass001_late_009_late_019_normal.jpg`
- `assets/textures/harvest/acg_grass001_late_009_late_019_rake_038_dry_076_normal.jpg`
- `assets/textures/harvest/acg_grass001_late_009_late_019_rake_038_dry_076_rough.jpg`
- `assets/textures/harvest/acg_grass001_late_009_late_019_rake_038_normal.jpg`
- `assets/textures/harvest/acg_grass001_late_009_late_019_rake_038_rough.jpg`
- `assets/textures/harvest/acg_grass001_late_009_late_019_rough.jpg`
- `assets/textures/harvest/acg_grass001_late_009_late_019_wet_075_normal.jpg`
- `assets/textures/harvest/acg_grass001_late_009_late_019_wet_075_rough.jpg`
- `assets/textures/harvest/acg_grass001_late_009_late_074_normal.jpg`
- `assets/textures/harvest/acg_grass001_late_009_late_074_rough.jpg`
- `assets/textures/harvest/acg_grass001_late_009_normal.jpg`
- `assets/textures/harvest/acg_grass001_late_009_rough.jpg`
- `assets/textures/harvest/acg_grass001_late_009_shade_037_normal.jpg`
- `assets/textures/harvest/acg_grass001_late_009_shade_037_rough.jpg`
- `assets/textures/harvest/acg_grass001_late_009_shade_037_shade_077_normal.jpg`
- `assets/textures/harvest/acg_grass001_late_009_shade_037_shade_077_rough.jpg`
- `assets/textures/harvest/acg_grass001_rake_018_late_039_late_079_normal.jpg`
- `assets/textures/harvest/acg_grass001_rake_018_late_039_late_079_rough.jpg`
- `assets/textures/harvest/acg_grass001_rake_018_late_039_normal.jpg`
- `assets/textures/harvest/acg_grass001_rake_018_late_039_rough.jpg`
- `assets/textures/harvest/acg_grass001_rake_018_normal.jpg`
- `assets/textures/harvest/acg_grass001_rake_018_rake_078_normal.jpg`
- `assets/textures/harvest/acg_grass001_rake_018_rake_078_rough.jpg`
- `assets/textures/harvest/acg_grass001_rake_018_rough.jpg`
- `assets/textures/harvest/acg_grass001_shade_072_normal.jpg`
- `assets/textures/harvest/acg_grass001_shade_072_rough.jpg`
- `assets/textures/harvest/acg_grass002_wet_010_dry_021_normal.jpg`
- `assets/textures/harvest/acg_grass002_wet_010_dry_021_rough.jpg`
- `assets/textures/harvest/acg_grass002_wet_010_dry_021_shade_042_normal.jpg`
- `assets/textures/harvest/acg_grass002_wet_010_dry_021_shade_042_rake_083_normal.jpg`
- `assets/textures/harvest/acg_grass002_wet_010_dry_021_shade_042_rake_083_rough.jpg`
- `assets/textures/harvest/acg_grass002_wet_010_dry_021_shade_042_rough.jpg`
- `assets/textures/harvest/acg_grass002_wet_010_dry_021_shade_082_normal.jpg`
- `assets/textures/harvest/acg_grass002_wet_010_dry_021_shade_082_rough.jpg`
- `assets/textures/harvest/acg_grass002_wet_010_dry_041_late_084_normal.jpg`
- `assets/textures/harvest/acg_grass002_wet_010_dry_041_late_084_rough.jpg`
- `assets/textures/harvest/acg_grass002_wet_010_dry_041_normal.jpg`
- `assets/textures/harvest/acg_grass002_wet_010_dry_041_rough.jpg`
- `assets/textures/harvest/acg_grass002_wet_010_dry_081_normal.jpg`
- `assets/textures/harvest/acg_grass002_wet_010_dry_081_rough.jpg`
- `assets/textures/harvest/acg_grass002_wet_010_normal.jpg`
- `assets/textures/harvest/acg_grass002_wet_010_rough.jpg`
- `assets/textures/harvest/acg_grass002_wet_020_normal.jpg`
- `assets/textures/harvest/acg_grass002_wet_020_rake_043_dry_086_normal.jpg`
- `assets/textures/harvest/acg_grass002_wet_020_rake_043_dry_086_rough.jpg`
- `assets/textures/harvest/acg_grass002_wet_020_rake_043_normal.jpg`
- `assets/textures/harvest/acg_grass002_wet_020_rake_043_rough.jpg`
- `assets/textures/harvest/acg_grass002_wet_020_rough.jpg`
- `assets/textures/harvest/acg_grass002_wet_020_wet_085_normal.jpg`
- `assets/textures/harvest/acg_grass002_wet_020_wet_085_rough.jpg`
- `assets/textures/harvest/acg_grass002_wet_040_normal.jpg`
- `assets/textures/harvest/acg_grass002_wet_040_rough.jpg`
- `assets/textures/harvest/acg_grass002_wet_040_shade_087_normal.jpg`
- `assets/textures/harvest/acg_grass002_wet_040_shade_087_rough.jpg`
- `assets/textures/harvest/acg_grass002_wet_080_normal.jpg`
- `assets/textures/harvest/acg_grass002_wet_080_rough.jpg`
- `assets/textures/harvest/acg_grass004_dry_011_late_089_normal.jpg`
- `assets/textures/harvest/acg_grass004_dry_011_late_089_rough.jpg`
- `assets/textures/harvest/acg_grass004_dry_011_normal.jpg`
- `assets/textures/harvest/acg_grass004_dry_011_rake_023_dry_046_dry_091_normal.jpg`
- `assets/textures/harvest/acg_grass004_dry_011_rake_023_dry_046_dry_091_rough.jpg`
- `assets/textures/harvest/acg_grass004_dry_011_rake_023_dry_046_normal.jpg`
- `assets/textures/harvest/acg_grass004_dry_011_rake_023_dry_046_rough.jpg`
- `assets/textures/harvest/acg_grass004_dry_011_rake_023_normal.jpg`
- `assets/textures/harvest/acg_grass004_dry_011_rake_023_rough.jpg`
- `assets/textures/harvest/acg_grass004_dry_011_rake_023_wet_090_normal.jpg`
- `assets/textures/harvest/acg_grass004_dry_011_rake_023_wet_090_rough.jpg`
- `assets/textures/harvest/acg_grass004_dry_011_rough.jpg`
- `assets/textures/harvest/acg_grass004_dry_011_wet_045_normal.jpg`
- `assets/textures/harvest/acg_grass004_dry_011_wet_045_rough.jpg`
- `assets/textures/harvest/acg_grass004_dry_011_wet_045_shade_092_normal.jpg`
- `assets/textures/harvest/acg_grass004_dry_011_wet_045_shade_092_rough.jpg`
- `assets/textures/harvest/acg_grass004_late_044_normal.jpg`
- `assets/textures/harvest/acg_grass004_late_044_rake_093_normal.jpg`
- `assets/textures/harvest/acg_grass004_late_044_rake_093_rough.jpg`
- `assets/textures/harvest/acg_grass004_late_044_rough.jpg`
- `assets/textures/harvest/acg_grass004_rake_088_normal.jpg`
- `assets/textures/harvest/acg_grass004_rake_088_rough.jpg`
- `assets/textures/harvest/acg_grass004_shade_022_late_094_normal.jpg`
- `assets/textures/harvest/acg_grass004_shade_022_late_094_rough.jpg`
- `assets/textures/harvest/acg_grass004_shade_022_normal.jpg`
- `assets/textures/harvest/acg_grass004_shade_022_rough.jpg`
- `assets/textures/harvest/acg_grass004_shade_022_shade_047_normal.jpg`
- `assets/textures/harvest/acg_grass004_shade_022_shade_047_rough.jpg`
- `assets/textures/harvest/acg_grass004_shade_022_shade_047_wet_095_normal.jpg`
- `assets/textures/harvest/acg_grass004_shade_022_shade_047_wet_095_rough.jpg`
- `assets/textures/harvest/acg_grass005_dry_096_normal.jpg`
- `assets/textures/harvest/acg_grass005_dry_096_rough.jpg`
- `assets/textures/harvest/acg_grass005_late_024_late_049_normal.jpg`
- `assets/textures/harvest/acg_grass005_late_024_late_049_rake_098_normal.jpg`
- `assets/textures/harvest/acg_grass005_late_024_late_049_rake_098_rough.jpg`
- `assets/textures/harvest/acg_grass005_late_024_late_049_rough.jpg`
- `assets/textures/harvest/acg_grass005_late_024_normal.jpg`
- `assets/textures/harvest/acg_grass005_late_024_rough.jpg`
- `assets/textures/harvest/acg_grass005_late_024_shade_097_normal.jpg`
- `assets/textures/harvest/acg_grass005_late_024_shade_097_rough.jpg`
- `assets/textures/harvest/acg_grass005_rake_048_late_099_normal.jpg`
- `assets/textures/harvest/acg_grass005_rake_048_late_099_rough.jpg`
- `assets/textures/harvest/acg_grass005_rake_048_normal.jpg`
- `assets/textures/harvest/acg_grass005_rake_048_rough.jpg`
- `assets/textures/harvest/acg_grass005_shade_012_normal.jpg`
- `assets/textures/harvest/acg_grass005_shade_012_rough.jpg`
- `assets/textures/harvest/acg_grass005_shade_012_wet_025_dry_051_normal.jpg`
- `assets/textures/harvest/acg_grass005_shade_012_wet_025_dry_051_rough.jpg`
- `assets/textures/harvest/acg_grass005_shade_012_wet_025_dry_051_shade_102_normal.jpg`
- `assets/textures/harvest/acg_grass005_shade_012_wet_025_dry_051_shade_102_rough.jpg`
- `assets/textures/harvest/acg_grass005_shade_012_wet_025_dry_101_normal.jpg`
- `assets/textures/harvest/acg_grass005_shade_012_wet_025_dry_101_rough.jpg`
- `assets/textures/harvest/acg_grass005_shade_012_wet_025_normal.jpg`
- `assets/textures/harvest/acg_grass005_shade_012_wet_025_rough.jpg`
- `assets/textures/harvest/acg_grass005_shade_012_wet_050_normal.jpg`
- `assets/textures/harvest/acg_grass005_shade_012_wet_050_rake_103_normal.jpg`
- `assets/textures/harvest/acg_grass005_shade_012_wet_050_rake_103_rough.jpg`
- `assets/textures/harvest/acg_grass005_shade_012_wet_050_rough.jpg`
- `assets/textures/harvest/acg_grass005_shade_012_wet_100_normal.jpg`
- `assets/textures/harvest/acg_grass005_shade_012_wet_100_rough.jpg`
- `assets/textures/harvest/acg_grass006_dry_026_normal.jpg`
- `assets/textures/harvest/acg_grass006_dry_026_rake_053_dry_106_normal.jpg`
- `assets/textures/harvest/acg_grass006_dry_026_rake_053_dry_106_rough.jpg`
- `assets/textures/harvest/acg_grass006_dry_026_rake_053_normal.jpg`
- `assets/textures/harvest/acg_grass006_dry_026_rake_053_rough.jpg`
- `assets/textures/harvest/acg_grass006_dry_026_rough.jpg`
- `assets/textures/harvest/acg_grass006_dry_026_wet_105_normal.jpg`
- `assets/textures/harvest/acg_grass006_dry_026_wet_105_rough.jpg`
- `assets/textures/harvest/acg_grass006_late_104_normal.jpg`
- `assets/textures/harvest/acg_grass006_late_104_rough.jpg`
- `assets/textures/harvest/acg_grass006_rake_013_late_054_normal.jpg`
- `assets/textures/harvest/acg_grass006_rake_013_late_054_rake_108_normal.jpg`
- `assets/textures/harvest/acg_grass006_rake_013_late_054_rake_108_rough.jpg`
- `assets/textures/harvest/acg_grass006_rake_013_late_054_rough.jpg`
- `assets/textures/harvest/acg_grass006_rake_013_normal.jpg`
- `assets/textures/harvest/acg_grass006_rake_013_rough.jpg`
- `assets/textures/harvest/acg_grass006_rake_013_shade_027_late_109_normal.jpg`
- `assets/textures/harvest/acg_grass006_rake_013_shade_027_late_109_rough.jpg`
- `assets/textures/harvest/acg_grass006_rake_013_shade_027_normal.jpg`
- `assets/textures/harvest/acg_grass006_rake_013_shade_027_rough.jpg`
- `assets/textures/harvest/acg_grass006_rake_013_shade_027_wet_055_normal.jpg`
- `assets/textures/harvest/acg_grass006_rake_013_shade_027_wet_055_rough.jpg`
- `assets/textures/harvest/acg_grass006_rake_013_shade_027_wet_055_wet_110_normal.jpg`
- `assets/textures/harvest/acg_grass006_rake_013_shade_027_wet_055_wet_110_rough.jpg`
- `assets/textures/harvest/acg_grass006_rake_013_shade_107_normal.jpg`
- `assets/textures/harvest/acg_grass006_rake_013_shade_107_rough.jpg`
- `assets/textures/harvest/acg_grass006_shade_052_dry_111_normal.jpg`
- `assets/textures/harvest/acg_grass006_shade_052_dry_111_rough.jpg`
- `assets/textures/harvest/acg_grass006_shade_052_normal.jpg`
- `assets/textures/harvest/acg_grass006_shade_052_rough.jpg`
- `assets/textures/harvest/acg_grass007_dry_056_normal.jpg`
- `assets/textures/harvest/acg_grass007_dry_056_rake_113_normal.jpg`
- `assets/textures/harvest/acg_grass007_dry_056_rake_113_rough.jpg`
- `assets/textures/harvest/acg_grass007_dry_056_rough.jpg`
- `assets/textures/harvest/acg_grass007_late_014_late_029_normal.jpg`
- `assets/textures/harvest/acg_grass007_late_014_late_029_rake_058_dry_116_normal.jpg`
- `assets/textures/harvest/acg_grass007_late_014_late_029_rake_058_dry_116_rough.jpg`
- `assets/textures/harvest/acg_grass007_late_014_late_029_rake_058_normal.jpg`
- `assets/textures/harvest/acg_grass007_late_014_late_029_rake_058_rough.jpg`
- `assets/textures/harvest/acg_grass007_late_014_late_029_rough.jpg`
- `assets/textures/harvest/acg_grass007_late_014_late_029_wet_115_normal.jpg`
- `assets/textures/harvest/acg_grass007_late_014_late_029_wet_115_rough.jpg`
- `assets/textures/harvest/acg_grass007_late_014_late_114_normal.jpg`
- `assets/textures/harvest/acg_grass007_late_014_late_114_rough.jpg`
- `assets/textures/harvest/acg_grass007_late_014_normal.jpg`
- `assets/textures/harvest/acg_grass007_late_014_rough.jpg`
- `assets/textures/harvest/acg_grass007_late_014_shade_057_normal.jpg`
- `assets/textures/harvest/acg_grass007_late_014_shade_057_rough.jpg`
- `assets/textures/harvest/acg_grass007_late_014_shade_057_shade_117_normal.jpg`
- `assets/textures/harvest/acg_grass007_late_014_shade_057_shade_117_rough.jpg`
- `assets/textures/harvest/acg_grass007_rake_028_late_059_late_119_normal.jpg`
- `assets/textures/harvest/acg_grass007_rake_028_late_059_late_119_rough.jpg`
- `assets/textures/harvest/acg_grass007_rake_028_late_059_normal.jpg`
- `assets/textures/harvest/acg_grass007_rake_028_late_059_rough.jpg`
- `assets/textures/harvest/acg_grass007_rake_028_normal.jpg`
- `assets/textures/harvest/acg_grass007_rake_028_rake_118_normal.jpg`
- `assets/textures/harvest/acg_grass007_rake_028_rake_118_rough.jpg`
- `assets/textures/harvest/acg_grass007_rake_028_rough.jpg`
- `assets/textures/harvest/acg_grass007_shade_112_normal.jpg`
- `assets/textures/harvest/acg_grass007_shade_112_rough.jpg`
- `assets/textures/harvest/acg_gravel015_wet_015_dry_031_normal.jpg`
- `assets/textures/harvest/acg_gravel015_wet_015_dry_031_rough.jpg`
- `assets/textures/harvest/acg_gravel015_wet_015_dry_031_shade_062_normal.jpg`
- `assets/textures/harvest/acg_gravel015_wet_015_dry_031_shade_062_rake_123_normal.jpg`
- `assets/textures/harvest/acg_gravel015_wet_015_dry_031_shade_062_rake_123_rough.jpg`
- `assets/textures/harvest/acg_gravel015_wet_015_dry_031_shade_062_rough.jpg`
- `assets/textures/harvest/acg_gravel015_wet_015_dry_031_shade_122_normal.jpg`
- `assets/textures/harvest/acg_gravel015_wet_015_dry_031_shade_122_rough.jpg`
- `assets/textures/harvest/acg_gravel015_wet_015_dry_061_late_124_normal.jpg`
- `assets/textures/harvest/acg_gravel015_wet_015_dry_061_late_124_rough.jpg`
- `assets/textures/harvest/acg_gravel015_wet_015_dry_061_normal.jpg`
- `assets/textures/harvest/acg_gravel015_wet_015_dry_061_rough.jpg`
- `assets/textures/harvest/acg_gravel015_wet_015_dry_121_normal.jpg`
- `assets/textures/harvest/acg_gravel015_wet_015_dry_121_rough.jpg`
- `assets/textures/harvest/acg_gravel015_wet_015_normal.jpg`
- `assets/textures/harvest/acg_gravel015_wet_015_rough.jpg`
- `assets/textures/harvest/acg_gravel015_wet_030_normal.jpg`
- `assets/textures/harvest/acg_gravel015_wet_030_rake_063_dry_126_normal.jpg`
- `assets/textures/harvest/acg_gravel015_wet_030_rake_063_dry_126_rough.jpg`
- `assets/textures/harvest/acg_gravel015_wet_030_rake_063_normal.jpg`
- `assets/textures/harvest/acg_gravel015_wet_030_rake_063_rough.jpg`
- `assets/textures/harvest/acg_gravel015_wet_030_rough.jpg`
- `assets/textures/harvest/acg_gravel015_wet_030_wet_125_normal.jpg`
- `assets/textures/harvest/acg_gravel015_wet_030_wet_125_rough.jpg`
- `assets/textures/harvest/acg_gravel015_wet_060_normal.jpg`
- `assets/textures/harvest/acg_gravel015_wet_060_rough.jpg`
- `assets/textures/harvest/acg_gravel015_wet_060_shade_127_normal.jpg`
- `assets/textures/harvest/acg_gravel015_wet_060_shade_127_rough.jpg`
- `assets/textures/harvest/acg_gravel015_wet_120_normal.jpg`
- `assets/textures/harvest/acg_gravel015_wet_120_rough.jpg`
- `assets/textures/harvest/acg_gravel020_dry_016_late_129_normal.jpg`
- `assets/textures/harvest/acg_gravel020_dry_016_late_129_rough.jpg`
- `assets/textures/harvest/acg_gravel020_dry_016_normal.jpg`
- `assets/textures/harvest/acg_gravel020_dry_016_rake_033_dry_066_dry_131_normal.jpg`
- `assets/textures/harvest/acg_gravel020_dry_016_rake_033_dry_066_dry_131_rough.jpg`
- `assets/textures/harvest/acg_gravel020_dry_016_rake_033_dry_066_normal.jpg`
- `assets/textures/harvest/acg_gravel020_dry_016_rake_033_dry_066_rough.jpg`
- `assets/textures/harvest/acg_gravel020_dry_016_rake_033_normal.jpg`
- `assets/textures/harvest/acg_gravel020_dry_016_rake_033_rough.jpg`
- `assets/textures/harvest/acg_gravel020_dry_016_rake_033_wet_130_normal.jpg`
- `assets/textures/harvest/acg_gravel020_dry_016_rake_033_wet_130_rough.jpg`
- `assets/textures/harvest/acg_gravel020_dry_016_rough.jpg`
- `assets/textures/harvest/acg_gravel020_dry_016_wet_065_normal.jpg`
- `assets/textures/harvest/acg_gravel020_dry_016_wet_065_rough.jpg`
- `assets/textures/harvest/acg_gravel020_dry_016_wet_065_shade_132_normal.jpg`
- `assets/textures/harvest/acg_gravel020_dry_016_wet_065_shade_132_rough.jpg`
- `assets/textures/harvest/acg_gravel020_late_064_normal.jpg`
- `assets/textures/harvest/acg_gravel020_late_064_rake_133_normal.jpg`
- `assets/textures/harvest/acg_gravel020_late_064_rake_133_rough.jpg`
- `assets/textures/harvest/acg_gravel020_late_064_rough.jpg`
- `assets/textures/harvest/acg_gravel020_rake_128_normal.jpg`
- `assets/textures/harvest/acg_gravel020_rake_128_rough.jpg`
- `assets/textures/harvest/acg_gravel020_shade_032_late_134_normal.jpg`
- `assets/textures/harvest/acg_gravel020_shade_032_late_134_rough.jpg`
- `assets/textures/harvest/acg_gravel020_shade_032_normal.jpg`
- `assets/textures/harvest/acg_gravel020_shade_032_rough.jpg`
- `assets/textures/harvest/acg_gravel020_shade_032_shade_067_normal.jpg`
- `assets/textures/harvest/acg_gravel020_shade_032_shade_067_rough.jpg`
- `assets/textures/harvest/acg_gravel020_shade_032_shade_067_wet_135_normal.jpg`
- `assets/textures/harvest/acg_gravel020_shade_032_shade_067_wet_135_rough.jpg`
- `assets/textures/harvest/acg_gravel023_dry_136_normal.jpg`
- `assets/textures/harvest/acg_gravel023_dry_136_rough.jpg`
- `assets/textures/harvest/acg_gravel023_late_034_late_069_normal.jpg`
- `assets/textures/harvest/acg_gravel023_late_034_late_069_rake_138_normal.jpg`
- `assets/textures/harvest/acg_gravel023_late_034_late_069_rake_138_rough.jpg`
- `assets/textures/harvest/acg_gravel023_late_034_late_069_rough.jpg`
- `assets/textures/harvest/acg_gravel023_late_034_normal.jpg`
- `assets/textures/harvest/acg_gravel023_late_034_rough.jpg`
- `assets/textures/harvest/acg_gravel023_late_034_shade_137_normal.jpg`
- `assets/textures/harvest/acg_gravel023_late_034_shade_137_rough.jpg`
- `assets/textures/harvest/acg_gravel023_rake_068_late_139_normal.jpg`
- `assets/textures/harvest/acg_gravel023_rake_068_late_139_rough.jpg`
- `assets/textures/harvest/acg_gravel023_rake_068_normal.jpg`
- `assets/textures/harvest/acg_gravel023_rake_068_rough.jpg`
- `assets/textures/harvest/acg_gravel023_shade_017_normal.jpg`
- `assets/textures/harvest/acg_gravel023_shade_017_rough.jpg`
- `assets/textures/harvest/acg_gravel023_shade_017_wet_035_dry_071_normal.jpg`
- `assets/textures/harvest/acg_gravel023_shade_017_wet_035_dry_071_rough.jpg`
- `assets/textures/harvest/acg_gravel023_shade_017_wet_035_dry_071_shade_142_normal.jpg`
- `assets/textures/harvest/acg_gravel023_shade_017_wet_035_dry_071_shade_142_rough.jpg`
- `assets/textures/harvest/acg_gravel023_shade_017_wet_035_dry_141_normal.jpg`
- `assets/textures/harvest/acg_gravel023_shade_017_wet_035_dry_141_rough.jpg`
- `assets/textures/harvest/acg_gravel023_shade_017_wet_035_normal.jpg`
- `assets/textures/harvest/acg_gravel023_shade_017_wet_035_rough.jpg`
- `assets/textures/harvest/acg_gravel023_shade_017_wet_070_normal.jpg`
- `assets/textures/harvest/acg_gravel023_shade_017_wet_070_rake_143_normal.jpg`
- `assets/textures/harvest/acg_gravel023_shade_017_wet_070_rake_143_rough.jpg`
- `assets/textures/harvest/acg_gravel023_shade_017_wet_070_rough.jpg`
- `assets/textures/harvest/acg_gravel023_shade_017_wet_140_normal.jpg`
- `assets/textures/harvest/acg_gravel023_shade_017_wet_140_rough.jpg`
- `assets/textures/harvest/acg_ground003_dry_036_normal.jpg`
- `assets/textures/harvest/acg_ground003_dry_036_rake_073_dry_146_normal.jpg`
- `assets/textures/harvest/acg_ground003_dry_036_rake_073_dry_146_rough.jpg`
- `assets/textures/harvest/acg_ground003_dry_036_rake_073_normal.jpg`
- `assets/textures/harvest/acg_ground003_dry_036_rake_073_rough.jpg`
- `assets/textures/harvest/acg_ground003_dry_036_rough.jpg`
- `assets/textures/harvest/acg_ground003_dry_036_wet_145_normal.jpg`
- `assets/textures/harvest/acg_ground003_dry_036_wet_145_rough.jpg`
- `assets/textures/harvest/acg_ground003_late_144_normal.jpg`
- `assets/textures/harvest/acg_ground003_late_144_rough.jpg`
- `assets/textures/harvest/acg_ground003_rake_018_late_074_normal.jpg`
- `assets/textures/harvest/acg_ground003_rake_018_late_074_rake_148_normal.jpg`
- `assets/textures/harvest/acg_ground003_rake_018_late_074_rake_148_rough.jpg`
- `assets/textures/harvest/acg_ground003_rake_018_late_074_rough.jpg`
- `assets/textures/harvest/acg_ground003_rake_018_normal.jpg`
- `assets/textures/harvest/acg_ground003_rake_018_rough.jpg`
- `assets/textures/harvest/acg_ground003_rake_018_shade_037_late_149_normal.jpg`
- `assets/textures/harvest/acg_ground003_rake_018_shade_037_late_149_rough.jpg`
- `assets/textures/harvest/acg_ground003_rake_018_shade_037_normal.jpg`
- `assets/textures/harvest/acg_ground003_rake_018_shade_037_rough.jpg`
- `assets/textures/harvest/acg_ground003_rake_018_shade_037_wet_075_normal.jpg`
- `assets/textures/harvest/acg_ground003_rake_018_shade_037_wet_075_rough.jpg`
- `assets/textures/harvest/acg_ground003_rake_018_shade_037_wet_075_wet_150_normal.jpg`
- `assets/textures/harvest/acg_ground003_rake_018_shade_037_wet_075_wet_150_rough.jpg`
- `assets/textures/harvest/acg_ground003_rake_018_shade_147_normal.jpg`
- `assets/textures/harvest/acg_ground003_rake_018_shade_147_rough.jpg`
- `assets/textures/harvest/acg_ground003_shade_072_dry_151_normal.jpg`
- `assets/textures/harvest/acg_ground003_shade_072_dry_151_rough.jpg`
- `assets/textures/harvest/acg_ground003_shade_072_normal.jpg`
- `assets/textures/harvest/acg_ground003_shade_072_rough.jpg`
- `assets/textures/harvest/acg_ground004_dry_076_normal.jpg`
- `assets/textures/harvest/acg_ground004_dry_076_rake_153_normal.jpg`
- `assets/textures/harvest/acg_ground004_dry_076_rake_153_rough.jpg`
- `assets/textures/harvest/acg_ground004_dry_076_rough.jpg`
- `assets/textures/harvest/acg_ground004_late_019_late_039_normal.jpg`
- `assets/textures/harvest/acg_ground004_late_019_late_039_rake_078_dry_156_normal.jpg`
- `assets/textures/harvest/acg_ground004_late_019_late_039_rake_078_dry_156_rough.jpg`
- `assets/textures/harvest/acg_ground004_late_019_late_039_rake_078_normal.jpg`
- `assets/textures/harvest/acg_ground004_late_019_late_039_rake_078_rough.jpg`
- `assets/textures/harvest/acg_ground004_late_019_late_039_rough.jpg`
- `assets/textures/harvest/acg_ground004_late_019_late_039_wet_155_normal.jpg`
- `assets/textures/harvest/acg_ground004_late_019_late_039_wet_155_rough.jpg`
- `assets/textures/harvest/acg_ground004_late_019_late_154_normal.jpg`
- `assets/textures/harvest/acg_ground004_late_019_late_154_rough.jpg`
- `assets/textures/harvest/acg_ground004_late_019_normal.jpg`
- `assets/textures/harvest/acg_ground004_late_019_rough.jpg`
- `assets/textures/harvest/acg_ground004_late_019_shade_077_normal.jpg`
- `assets/textures/harvest/acg_ground004_late_019_shade_077_rough.jpg`
- `assets/textures/harvest/acg_ground004_late_019_shade_077_shade_157_normal.jpg`
- `assets/textures/harvest/acg_ground004_late_019_shade_077_shade_157_rough.jpg`
- `assets/textures/harvest/acg_ground004_rake_038_late_079_late_159_normal.jpg`
- `assets/textures/harvest/acg_ground004_rake_038_late_079_late_159_rough.jpg`
- `assets/textures/harvest/acg_ground004_rake_038_late_079_normal.jpg`
- `assets/textures/harvest/acg_ground004_rake_038_late_079_rough.jpg`
- `assets/textures/harvest/acg_ground004_rake_038_normal.jpg`
- `assets/textures/harvest/acg_ground004_rake_038_rake_158_normal.jpg`
- `assets/textures/harvest/acg_ground004_rake_038_rake_158_rough.jpg`
- `assets/textures/harvest/acg_ground004_rake_038_rough.jpg`
- `assets/textures/harvest/acg_ground004_shade_152_normal.jpg`
- `assets/textures/harvest/acg_ground004_shade_152_rough.jpg`
- `assets/textures/harvest/acg_ground023_wet_020_dry_041_normal.jpg`
- `assets/textures/harvest/acg_ground023_wet_020_dry_041_rough.jpg`
- `assets/textures/harvest/acg_ground023_wet_020_dry_041_shade_082_normal.jpg`
- `assets/textures/harvest/acg_ground023_wet_020_dry_041_shade_082_rake_163_normal.jpg`
- `assets/textures/harvest/acg_ground023_wet_020_dry_041_shade_082_rake_163_rough.jpg`
- `assets/textures/harvest/acg_ground023_wet_020_dry_041_shade_082_rough.jpg`
- `assets/textures/harvest/acg_ground023_wet_020_dry_041_shade_162_normal.jpg`
- `assets/textures/harvest/acg_ground023_wet_020_dry_041_shade_162_rough.jpg`
- `assets/textures/harvest/acg_ground023_wet_020_dry_081_late_164_normal.jpg`
- `assets/textures/harvest/acg_ground023_wet_020_dry_081_late_164_rough.jpg`
- `assets/textures/harvest/acg_ground023_wet_020_dry_081_normal.jpg`
- `assets/textures/harvest/acg_ground023_wet_020_dry_081_rough.jpg`
- `assets/textures/harvest/acg_ground023_wet_020_dry_161_normal.jpg`
- `assets/textures/harvest/acg_ground023_wet_020_dry_161_rough.jpg`
- `assets/textures/harvest/acg_ground023_wet_020_normal.jpg`
- `assets/textures/harvest/acg_ground023_wet_020_rough.jpg`
- `assets/textures/harvest/acg_ground023_wet_040_normal.jpg`
- `assets/textures/harvest/acg_ground023_wet_040_rake_083_dry_166_normal.jpg`
- `assets/textures/harvest/acg_ground023_wet_040_rake_083_dry_166_rough.jpg`
- `assets/textures/harvest/acg_ground023_wet_040_rake_083_normal.jpg`
- `assets/textures/harvest/acg_ground023_wet_040_rake_083_rough.jpg`
- `assets/textures/harvest/acg_ground023_wet_040_rough.jpg`
- `assets/textures/harvest/acg_ground023_wet_040_wet_165_normal.jpg`
- `assets/textures/harvest/acg_ground023_wet_040_wet_165_rough.jpg`
- `assets/textures/harvest/acg_ground023_wet_080_normal.jpg`
- `assets/textures/harvest/acg_ground023_wet_080_rough.jpg`
- `assets/textures/harvest/acg_ground023_wet_080_shade_167_normal.jpg`
- `assets/textures/harvest/acg_ground023_wet_080_shade_167_rough.jpg`
- `assets/textures/harvest/acg_ground023_wet_160_normal.jpg`
- `assets/textures/harvest/acg_ground023_wet_160_rough.jpg`
- `assets/textures/harvest/acg_ground032_dry_021_late_169_normal.jpg`
- `assets/textures/harvest/acg_ground032_dry_021_late_169_rough.jpg`
- `assets/textures/harvest/acg_ground032_dry_021_normal.jpg`
- `assets/textures/harvest/acg_ground032_dry_021_rake_043_dry_086_dry_171_normal.jpg`
- `assets/textures/harvest/acg_ground032_dry_021_rake_043_dry_086_dry_171_rough.jpg`
- `assets/textures/harvest/acg_ground032_dry_021_rake_043_dry_086_normal.jpg`
- `assets/textures/harvest/acg_ground032_dry_021_rake_043_dry_086_rough.jpg`
- `assets/textures/harvest/acg_ground032_dry_021_rake_043_normal.jpg`
- `assets/textures/harvest/acg_ground032_dry_021_rake_043_rough.jpg`
- `assets/textures/harvest/acg_ground032_dry_021_rake_043_wet_170_normal.jpg`
- `assets/textures/harvest/acg_ground032_dry_021_rake_043_wet_170_rough.jpg`
- `assets/textures/harvest/acg_ground032_dry_021_rough.jpg`
- `assets/textures/harvest/acg_ground032_dry_021_wet_085_normal.jpg`
- `assets/textures/harvest/acg_ground032_dry_021_wet_085_rough.jpg`
- `assets/textures/harvest/acg_ground032_dry_021_wet_085_shade_172_normal.jpg`
- `assets/textures/harvest/acg_ground032_dry_021_wet_085_shade_172_rough.jpg`
- `assets/textures/harvest/acg_ground032_late_084_normal.jpg`
- `assets/textures/harvest/acg_ground032_late_084_rake_173_normal.jpg`
- `assets/textures/harvest/acg_ground032_late_084_rake_173_rough.jpg`
- `assets/textures/harvest/acg_ground032_late_084_rough.jpg`
- `assets/textures/harvest/acg_ground032_rake_168_normal.jpg`
- `assets/textures/harvest/acg_ground032_rake_168_rough.jpg`
- `assets/textures/harvest/acg_ground032_shade_042_late_174_normal.jpg`
- `assets/textures/harvest/acg_ground032_shade_042_late_174_rough.jpg`
- `assets/textures/harvest/acg_ground032_shade_042_normal.jpg`
- `assets/textures/harvest/acg_ground032_shade_042_rough.jpg`
- `assets/textures/harvest/acg_ground032_shade_042_shade_087_normal.jpg`
- `assets/textures/harvest/acg_ground032_shade_042_shade_087_rough.jpg`
- `assets/textures/harvest/acg_ground032_shade_042_shade_087_wet_175_normal.jpg`
- `assets/textures/harvest/acg_ground032_shade_042_shade_087_wet_175_rough.jpg`
- `assets/textures/harvest/acg_ground033_dry_176_normal.jpg`
- `assets/textures/harvest/acg_ground033_dry_176_rough.jpg`
- `assets/textures/harvest/acg_ground033_late_044_late_089_normal.jpg`
- `assets/textures/harvest/acg_ground033_late_044_late_089_rake_178_normal.jpg`
- `assets/textures/harvest/acg_ground033_late_044_late_089_rake_178_rough.jpg`
- `assets/textures/harvest/acg_ground033_late_044_late_089_rough.jpg`
- `assets/textures/harvest/acg_ground033_late_044_normal.jpg`
- `assets/textures/harvest/acg_ground033_late_044_rough.jpg`
- `assets/textures/harvest/acg_ground033_late_044_shade_177_normal.jpg`
- `assets/textures/harvest/acg_ground033_late_044_shade_177_rough.jpg`
- `assets/textures/harvest/acg_ground033_rake_088_late_179_normal.jpg`
- `assets/textures/harvest/acg_ground033_rake_088_late_179_rough.jpg`
- `assets/textures/harvest/acg_ground033_rake_088_normal.jpg`
- `assets/textures/harvest/acg_ground033_rake_088_rough.jpg`
- `assets/textures/harvest/acg_ground033_shade_022_normal.jpg`
- `assets/textures/harvest/acg_ground033_shade_022_rough.jpg`
- `assets/textures/harvest/acg_ground033_shade_022_wet_045_dry_091_normal.jpg`
- `assets/textures/harvest/acg_ground033_shade_022_wet_045_dry_091_rough.jpg`
- `assets/textures/harvest/acg_ground033_shade_022_wet_045_dry_091_shade_182_normal.jpg`
- `assets/textures/harvest/acg_ground033_shade_022_wet_045_dry_091_shade_182_rough.jpg`
- `assets/textures/harvest/acg_ground033_shade_022_wet_045_dry_181_normal.jpg`
- `assets/textures/harvest/acg_ground033_shade_022_wet_045_dry_181_rough.jpg`
- `assets/textures/harvest/acg_ground033_shade_022_wet_045_normal.jpg`
- `assets/textures/harvest/acg_ground033_shade_022_wet_045_rough.jpg`
- `assets/textures/harvest/acg_ground033_shade_022_wet_090_normal.jpg`
- `assets/textures/harvest/acg_ground033_shade_022_wet_090_rake_183_normal.jpg`
- `assets/textures/harvest/acg_ground033_shade_022_wet_090_rake_183_rough.jpg`
- `assets/textures/harvest/acg_ground033_shade_022_wet_090_rough.jpg`
- `assets/textures/harvest/acg_ground033_shade_022_wet_180_normal.jpg`
- `assets/textures/harvest/acg_ground033_shade_022_wet_180_rough.jpg`
- `assets/textures/harvest/acg_ground037_dry_046_normal.jpg`
- `assets/textures/harvest/acg_ground037_dry_046_rake_093_dry_186_normal.jpg`
- `assets/textures/harvest/acg_ground037_dry_046_rake_093_dry_186_rough.jpg`
- `assets/textures/harvest/acg_ground037_dry_046_rake_093_normal.jpg`
- `assets/textures/harvest/acg_ground037_dry_046_rake_093_rough.jpg`
- `assets/textures/harvest/acg_ground037_dry_046_rough.jpg`
- `assets/textures/harvest/acg_ground037_dry_046_wet_185_normal.jpg`
- `assets/textures/harvest/acg_ground037_dry_046_wet_185_rough.jpg`
- `assets/textures/harvest/acg_ground037_late_184_normal.jpg`
- `assets/textures/harvest/acg_ground037_late_184_rough.jpg`
- `assets/textures/harvest/acg_ground037_rake_023_late_094_normal.jpg`
- `assets/textures/harvest/acg_ground037_rake_023_late_094_rake_188_normal.jpg`
- `assets/textures/harvest/acg_ground037_rake_023_late_094_rake_188_rough.jpg`
- `assets/textures/harvest/acg_ground037_rake_023_late_094_rough.jpg`
- `assets/textures/harvest/acg_ground037_rake_023_normal.jpg`
- `assets/textures/harvest/acg_ground037_rake_023_rough.jpg`
- `assets/textures/harvest/acg_ground037_rake_023_shade_047_late_189_normal.jpg`
- `assets/textures/harvest/acg_ground037_rake_023_shade_047_late_189_rough.jpg`
- `assets/textures/harvest/acg_ground037_rake_023_shade_047_normal.jpg`
- `assets/textures/harvest/acg_ground037_rake_023_shade_047_rough.jpg`
- `assets/textures/harvest/acg_ground037_rake_023_shade_047_wet_095_normal.jpg`
- `assets/textures/harvest/acg_ground037_rake_023_shade_047_wet_095_rough.jpg`
- `assets/textures/harvest/acg_ground037_rake_023_shade_047_wet_095_wet_190_normal.jpg`
- `assets/textures/harvest/acg_ground037_rake_023_shade_047_wet_095_wet_190_rough.jpg`
- `assets/textures/harvest/acg_ground037_rake_023_shade_187_normal.jpg`
- `assets/textures/harvest/acg_ground037_rake_023_shade_187_rough.jpg`
- `assets/textures/harvest/acg_ground037_shade_092_dry_191_normal.jpg`
- `assets/textures/harvest/acg_ground037_shade_092_dry_191_rough.jpg`
- `assets/textures/harvest/acg_ground037_shade_092_normal.jpg`
- `assets/textures/harvest/acg_ground037_shade_092_rough.jpg`
- `assets/textures/harvest/acg_leather011_dry_096_normal.jpg`
- `assets/textures/harvest/acg_leather011_dry_096_rake_193_normal.jpg`
- `assets/textures/harvest/acg_leather011_dry_096_rake_193_rough.jpg`
- `assets/textures/harvest/acg_leather011_dry_096_rough.jpg`
- `assets/textures/harvest/acg_leather011_late_024_late_049_normal.jpg`
- `assets/textures/harvest/acg_leather011_late_024_late_049_rake_098_dry_196_normal.jpg`
- `assets/textures/harvest/acg_leather011_late_024_late_049_rake_098_dry_196_rough.jpg`
- `assets/textures/harvest/acg_leather011_late_024_late_049_rake_098_normal.jpg`
- `assets/textures/harvest/acg_leather011_late_024_late_049_rake_098_rough.jpg`
- `assets/textures/harvest/acg_leather011_late_024_late_049_rough.jpg`
- `assets/textures/harvest/acg_leather011_late_024_late_049_wet_195_normal.jpg`
- `assets/textures/harvest/acg_leather011_late_024_late_049_wet_195_rough.jpg`
- `assets/textures/harvest/acg_leather011_late_024_late_194_normal.jpg`
- `assets/textures/harvest/acg_leather011_late_024_late_194_rough.jpg`
- `assets/textures/harvest/acg_leather011_late_024_normal.jpg`
- `assets/textures/harvest/acg_leather011_late_024_rough.jpg`
- `assets/textures/harvest/acg_leather011_late_024_shade_097_normal.jpg`
- `assets/textures/harvest/acg_leather011_late_024_shade_097_rough.jpg`
- `assets/textures/harvest/acg_leather011_late_024_shade_097_shade_197_normal.jpg`
- `assets/textures/harvest/acg_leather011_late_024_shade_097_shade_197_rough.jpg`
- `assets/textures/harvest/acg_leather011_rake_048_late_099_late_199_normal.jpg`
- `assets/textures/harvest/acg_leather011_rake_048_late_099_late_199_rough.jpg`
- `assets/textures/harvest/acg_leather011_rake_048_late_099_normal.jpg`
- `assets/textures/harvest/acg_leather011_rake_048_late_099_rough.jpg`
- `assets/textures/harvest/acg_leather011_rake_048_normal.jpg`
- `assets/textures/harvest/acg_leather011_rake_048_rake_198_normal.jpg`
- `assets/textures/harvest/acg_leather011_rake_048_rake_198_rough.jpg`
- `assets/textures/harvest/acg_leather011_rake_048_rough.jpg`
- `assets/textures/harvest/acg_leather011_shade_192_normal.jpg`
- `assets/textures/harvest/acg_leather011_shade_192_rough.jpg`
- `assets/textures/harvest/acg_leather021_wet_025_dry_051_normal.jpg`
- `assets/textures/harvest/acg_leather021_wet_025_dry_051_rough.jpg`
- `assets/textures/harvest/acg_leather021_wet_025_dry_051_shade_102_normal.jpg`
- `assets/textures/harvest/acg_leather021_wet_025_dry_051_shade_102_rake_203_normal.jpg`
- `assets/textures/harvest/acg_leather021_wet_025_dry_051_shade_102_rake_203_rough.jpg`
- `assets/textures/harvest/acg_leather021_wet_025_dry_051_shade_102_rough.jpg`
- `assets/textures/harvest/acg_leather021_wet_025_dry_051_shade_202_normal.jpg`
- `assets/textures/harvest/acg_leather021_wet_025_dry_051_shade_202_rough.jpg`
- `assets/textures/harvest/acg_leather021_wet_025_dry_101_late_204_normal.jpg`
- `assets/textures/harvest/acg_leather021_wet_025_dry_101_late_204_rough.jpg`
- `assets/textures/harvest/acg_leather021_wet_025_dry_101_normal.jpg`
- `assets/textures/harvest/acg_leather021_wet_025_dry_101_rough.jpg`
- `assets/textures/harvest/acg_leather021_wet_025_dry_201_normal.jpg`
- `assets/textures/harvest/acg_leather021_wet_025_dry_201_rough.jpg`
- `assets/textures/harvest/acg_leather021_wet_025_normal.jpg`
- `assets/textures/harvest/acg_leather021_wet_025_rough.jpg`
- `assets/textures/harvest/acg_leather021_wet_050_normal.jpg`
- `assets/textures/harvest/acg_leather021_wet_050_rake_103_dry_206_normal.jpg`
- `assets/textures/harvest/acg_leather021_wet_050_rake_103_dry_206_rough.jpg`
- `assets/textures/harvest/acg_leather021_wet_050_rake_103_normal.jpg`
- `assets/textures/harvest/acg_leather021_wet_050_rake_103_rough.jpg`
- `assets/textures/harvest/acg_leather021_wet_050_rough.jpg`
- `assets/textures/harvest/acg_leather021_wet_050_wet_205_normal.jpg`
- `assets/textures/harvest/acg_leather021_wet_050_wet_205_rough.jpg`
- `assets/textures/harvest/acg_leather021_wet_100_normal.jpg`
- `assets/textures/harvest/acg_leather021_wet_100_rough.jpg`
- `assets/textures/harvest/acg_leather021_wet_100_shade_207_normal.jpg`
- `assets/textures/harvest/acg_leather021_wet_100_shade_207_rough.jpg`
- `assets/textures/harvest/acg_leather021_wet_200_normal.jpg`
- `assets/textures/harvest/acg_leather021_wet_200_rough.jpg`
- `assets/textures/harvest/acg_leather038_dry_026_late_209_normal.jpg`
- `assets/textures/harvest/acg_leather038_dry_026_late_209_rough.jpg`
- `assets/textures/harvest/acg_leather038_dry_026_normal.jpg`
- `assets/textures/harvest/acg_leather038_dry_026_rake_053_dry_106_dry_211_normal.jpg`
- `assets/textures/harvest/acg_leather038_dry_026_rake_053_dry_106_dry_211_rough.jpg`
- `assets/textures/harvest/acg_leather038_dry_026_rake_053_dry_106_normal.jpg`
- `assets/textures/harvest/acg_leather038_dry_026_rake_053_dry_106_rough.jpg`
- `assets/textures/harvest/acg_leather038_dry_026_rake_053_normal.jpg`
- `assets/textures/harvest/acg_leather038_dry_026_rake_053_rough.jpg`
- `assets/textures/harvest/acg_leather038_dry_026_rake_053_wet_210_normal.jpg`
- `assets/textures/harvest/acg_leather038_dry_026_rake_053_wet_210_rough.jpg`
- `assets/textures/harvest/acg_leather038_dry_026_rough.jpg`
- `assets/textures/harvest/acg_leather038_dry_026_wet_105_normal.jpg`
- `assets/textures/harvest/acg_leather038_dry_026_wet_105_rough.jpg`
- `assets/textures/harvest/acg_leather038_dry_026_wet_105_shade_212_normal.jpg`
- `assets/textures/harvest/acg_leather038_dry_026_wet_105_shade_212_rough.jpg`
- `assets/textures/harvest/acg_leather038_late_104_normal.jpg`
- `assets/textures/harvest/acg_leather038_late_104_rake_213_normal.jpg`
- `assets/textures/harvest/acg_leather038_late_104_rake_213_rough.jpg`
- `assets/textures/harvest/acg_leather038_late_104_rough.jpg`
- `assets/textures/harvest/acg_leather038_rake_208_normal.jpg`
- `assets/textures/harvest/acg_leather038_rake_208_rough.jpg`
- `assets/textures/harvest/acg_leather038_shade_052_late_214_normal.jpg`
- `assets/textures/harvest/acg_leather038_shade_052_late_214_rough.jpg`
- `assets/textures/harvest/acg_leather038_shade_052_normal.jpg`
- `assets/textures/harvest/acg_leather038_shade_052_rough.jpg`
- `assets/textures/harvest/acg_leather038_shade_052_shade_107_normal.jpg`
- `assets/textures/harvest/acg_leather038_shade_052_shade_107_rough.jpg`
- `assets/textures/harvest/acg_leather038_shade_052_shade_107_wet_215_normal.jpg`
- `assets/textures/harvest/acg_leather038_shade_052_shade_107_wet_215_rough.jpg`
- `assets/textures/harvest/acg_leather039_dry_216_normal.jpg`
- `assets/textures/harvest/acg_leather039_dry_216_rough.jpg`
- `assets/textures/harvest/acg_leather039_late_054_late_109_normal.jpg`
- `assets/textures/harvest/acg_leather039_late_054_late_109_rake_218_normal.jpg`
- `assets/textures/harvest/acg_leather039_late_054_late_109_rake_218_rough.jpg`
- `assets/textures/harvest/acg_leather039_late_054_late_109_rough.jpg`
- `assets/textures/harvest/acg_leather039_late_054_normal.jpg`
- `assets/textures/harvest/acg_leather039_late_054_rough.jpg`
- `assets/textures/harvest/acg_leather039_late_054_shade_217_normal.jpg`
- `assets/textures/harvest/acg_leather039_late_054_shade_217_rough.jpg`
- `assets/textures/harvest/acg_leather039_rake_108_late_219_normal.jpg`
- `assets/textures/harvest/acg_leather039_rake_108_late_219_rough.jpg`
- `assets/textures/harvest/acg_leather039_rake_108_normal.jpg`
- `assets/textures/harvest/acg_leather039_rake_108_rough.jpg`
- `assets/textures/harvest/acg_leather039_shade_027_normal.jpg`
- `assets/textures/harvest/acg_leather039_shade_027_rough.jpg`
- `assets/textures/harvest/acg_leather039_shade_027_wet_055_dry_111_normal.jpg`
- `assets/textures/harvest/acg_leather039_shade_027_wet_055_dry_111_rough.jpg`
- `assets/textures/harvest/acg_leather039_shade_027_wet_055_dry_111_shade_222_normal.jpg`
- `assets/textures/harvest/acg_leather039_shade_027_wet_055_dry_111_shade_222_rough.jpg`
- `assets/textures/harvest/acg_leather039_shade_027_wet_055_dry_221_normal.jpg`
- `assets/textures/harvest/acg_leather039_shade_027_wet_055_dry_221_rough.jpg`
- `assets/textures/harvest/acg_leather039_shade_027_wet_055_normal.jpg`
- `assets/textures/harvest/acg_leather039_shade_027_wet_055_rough.jpg`
- `assets/textures/harvest/acg_leather039_shade_027_wet_110_normal.jpg`
- `assets/textures/harvest/acg_leather039_shade_027_wet_110_rake_223_normal.jpg`
- `assets/textures/harvest/acg_leather039_shade_027_wet_110_rake_223_rough.jpg`
- `assets/textures/harvest/acg_leather039_shade_027_wet_110_rough.jpg`
- `assets/textures/harvest/acg_leather039_shade_027_wet_220_normal.jpg`
- `assets/textures/harvest/acg_leather039_shade_027_wet_220_rough.jpg`
- `assets/textures/harvest/acg_metal001_dry_056_normal.jpg`
- `assets/textures/harvest/acg_metal001_dry_056_rake_113_dry_226_normal.jpg`
- `assets/textures/harvest/acg_metal001_dry_056_rake_113_dry_226_rough.jpg`
- `assets/textures/harvest/acg_metal001_dry_056_rake_113_normal.jpg`
- `assets/textures/harvest/acg_metal001_dry_056_rake_113_rough.jpg`
- `assets/textures/harvest/acg_metal001_dry_056_rough.jpg`
- `assets/textures/harvest/acg_metal001_dry_056_wet_225_normal.jpg`
- `assets/textures/harvest/acg_metal001_dry_056_wet_225_rough.jpg`
- `assets/textures/harvest/acg_metal001_late_224_normal.jpg`
- `assets/textures/harvest/acg_metal001_late_224_rough.jpg`
- `assets/textures/harvest/acg_metal001_rake_028_late_114_normal.jpg`
- `assets/textures/harvest/acg_metal001_rake_028_late_114_rake_228_normal.jpg`
- `assets/textures/harvest/acg_metal001_rake_028_late_114_rake_228_rough.jpg`
- `assets/textures/harvest/acg_metal001_rake_028_late_114_rough.jpg`
- `assets/textures/harvest/acg_metal001_rake_028_normal.jpg`
- `assets/textures/harvest/acg_metal001_rake_028_rough.jpg`
- `assets/textures/harvest/acg_metal001_rake_028_shade_057_late_229_normal.jpg`
- `assets/textures/harvest/acg_metal001_rake_028_shade_057_late_229_rough.jpg`
- `assets/textures/harvest/acg_metal001_rake_028_shade_057_normal.jpg`
- `assets/textures/harvest/acg_metal001_rake_028_shade_057_rough.jpg`
- `assets/textures/harvest/acg_metal001_rake_028_shade_057_wet_115_normal.jpg`
- `assets/textures/harvest/acg_metal001_rake_028_shade_057_wet_115_rough.jpg`
- `assets/textures/harvest/acg_metal001_rake_028_shade_057_wet_115_wet_230_normal.jpg`
- `assets/textures/harvest/acg_metal001_rake_028_shade_057_wet_115_wet_230_rough.jpg`
- `assets/textures/harvest/acg_metal001_rake_028_shade_227_normal.jpg`
- `assets/textures/harvest/acg_metal001_rake_028_shade_227_rough.jpg`
- `assets/textures/harvest/acg_metal001_shade_112_dry_231_normal.jpg`
- `assets/textures/harvest/acg_metal001_shade_112_dry_231_rough.jpg`
- `assets/textures/harvest/acg_metal001_shade_112_normal.jpg`
- `assets/textures/harvest/acg_metal001_shade_112_rough.jpg`
- `assets/textures/harvest/acg_metal009_dry_116_normal.jpg`
- `assets/textures/harvest/acg_metal009_dry_116_rake_233_normal.jpg`
- `assets/textures/harvest/acg_metal009_dry_116_rake_233_rough.jpg`
- `assets/textures/harvest/acg_metal009_dry_116_rough.jpg`
- `assets/textures/harvest/acg_metal009_late_029_late_059_normal.jpg`
- `assets/textures/harvest/acg_metal009_late_029_late_059_rake_118_dry_236_normal.jpg`
- `assets/textures/harvest/acg_metal009_late_029_late_059_rake_118_dry_236_rough.jpg`
- `assets/textures/harvest/acg_metal009_late_029_late_059_rake_118_normal.jpg`
- `assets/textures/harvest/acg_metal009_late_029_late_059_rake_118_rough.jpg`
- `assets/textures/harvest/acg_metal009_late_029_late_059_rough.jpg`
- `assets/textures/harvest/acg_metal009_late_029_late_059_wet_235_normal.jpg`
- `assets/textures/harvest/acg_metal009_late_029_late_059_wet_235_rough.jpg`
- `assets/textures/harvest/acg_metal009_late_029_late_234_normal.jpg`
- `assets/textures/harvest/acg_metal009_late_029_late_234_rough.jpg`
- `assets/textures/harvest/acg_metal009_late_029_normal.jpg`
- `assets/textures/harvest/acg_metal009_late_029_rough.jpg`
- `assets/textures/harvest/acg_metal009_late_029_shade_117_normal.jpg`
- `assets/textures/harvest/acg_metal009_late_029_shade_117_rough.jpg`
- `assets/textures/harvest/acg_metal009_late_029_shade_117_shade_237_normal.jpg`
- `assets/textures/harvest/acg_metal009_late_029_shade_117_shade_237_rough.jpg`
- `assets/textures/harvest/acg_metal009_rake_058_late_119_late_239_normal.jpg`
- `assets/textures/harvest/acg_metal009_rake_058_late_119_late_239_rough.jpg`
- `assets/textures/harvest/acg_metal009_rake_058_late_119_normal.jpg`
- `assets/textures/harvest/acg_metal009_rake_058_late_119_rough.jpg`
- `assets/textures/harvest/acg_metal009_rake_058_normal.jpg`
- `assets/textures/harvest/acg_metal009_rake_058_rake_238_normal.jpg`
- `assets/textures/harvest/acg_metal009_rake_058_rake_238_rough.jpg`
- `assets/textures/harvest/acg_metal009_rake_058_rough.jpg`
- `assets/textures/harvest/acg_metal009_shade_232_normal.jpg`
- `assets/textures/harvest/acg_metal009_shade_232_rough.jpg`
- `assets/textures/harvest/acg_metal032_wet_030_dry_061_normal.jpg`
- `assets/textures/harvest/acg_metal032_wet_030_dry_061_rough.jpg`
- `assets/textures/harvest/acg_metal032_wet_030_dry_061_shade_122_normal.jpg`
- `assets/textures/harvest/acg_metal032_wet_030_dry_061_shade_122_rake_243_normal.jpg`
- `assets/textures/harvest/acg_metal032_wet_030_dry_061_shade_122_rake_243_rough.jpg`
- `assets/textures/harvest/acg_metal032_wet_030_dry_061_shade_122_rough.jpg`
- `assets/textures/harvest/acg_metal032_wet_030_dry_061_shade_242_normal.jpg`
- `assets/textures/harvest/acg_metal032_wet_030_dry_061_shade_242_rough.jpg`
- `assets/textures/harvest/acg_metal032_wet_030_dry_121_late_244_normal.jpg`
- `assets/textures/harvest/acg_metal032_wet_030_dry_121_late_244_rough.jpg`
- `assets/textures/harvest/acg_metal032_wet_030_dry_121_normal.jpg`
- `assets/textures/harvest/acg_metal032_wet_030_dry_121_rough.jpg`
- `assets/textures/harvest/acg_metal032_wet_030_dry_241_normal.jpg`
- `assets/textures/harvest/acg_metal032_wet_030_dry_241_rough.jpg`
- `assets/textures/harvest/acg_metal032_wet_030_normal.jpg`
- `assets/textures/harvest/acg_metal032_wet_030_rough.jpg`
- `assets/textures/harvest/acg_metal032_wet_060_normal.jpg`
- `assets/textures/harvest/acg_metal032_wet_060_rake_123_dry_246_normal.jpg`
- `assets/textures/harvest/acg_metal032_wet_060_rake_123_dry_246_rough.jpg`
- `assets/textures/harvest/acg_metal032_wet_060_rake_123_normal.jpg`
- `assets/textures/harvest/acg_metal032_wet_060_rake_123_rough.jpg`
- `assets/textures/harvest/acg_metal032_wet_060_rough.jpg`
- `assets/textures/harvest/acg_metal032_wet_060_wet_245_normal.jpg`
- `assets/textures/harvest/acg_metal032_wet_060_wet_245_rough.jpg`
- `assets/textures/harvest/acg_metal032_wet_120_normal.jpg`
- `assets/textures/harvest/acg_metal032_wet_120_rough.jpg`
- `assets/textures/harvest/acg_metal032_wet_120_shade_247_normal.jpg`
- `assets/textures/harvest/acg_metal032_wet_120_shade_247_rough.jpg`
- `assets/textures/harvest/acg_metal032_wet_240_normal.jpg`
- `assets/textures/harvest/acg_metal032_wet_240_rough.jpg`
- `assets/textures/harvest/acg_moss001_dry_031_late_249_normal.jpg`
- `assets/textures/harvest/acg_moss001_dry_031_late_249_rough.jpg`
- `assets/textures/harvest/acg_moss001_dry_031_normal.jpg`
- `assets/textures/harvest/acg_moss001_dry_031_rake_063_dry_126_dry_251_normal.jpg`
- `assets/textures/harvest/acg_moss001_dry_031_rake_063_dry_126_dry_251_rough.jpg`
- `assets/textures/harvest/acg_moss001_dry_031_rake_063_dry_126_normal.jpg`
- `assets/textures/harvest/acg_moss001_dry_031_rake_063_dry_126_rough.jpg`
- `assets/textures/harvest/acg_moss001_dry_031_rake_063_normal.jpg`
- `assets/textures/harvest/acg_moss001_dry_031_rake_063_rough.jpg`
- `assets/textures/harvest/acg_moss001_dry_031_rake_063_wet_250_normal.jpg`
- `assets/textures/harvest/acg_moss001_dry_031_rake_063_wet_250_rough.jpg`
- `assets/textures/harvest/acg_moss001_dry_031_rough.jpg`
- `assets/textures/harvest/acg_moss001_dry_031_wet_125_normal.jpg`
- `assets/textures/harvest/acg_moss001_dry_031_wet_125_rough.jpg`
- `assets/textures/harvest/acg_moss001_dry_031_wet_125_shade_252_normal.jpg`
- `assets/textures/harvest/acg_moss001_dry_031_wet_125_shade_252_rough.jpg`
- `assets/textures/harvest/acg_moss001_late_124_normal.jpg`
- `assets/textures/harvest/acg_moss001_late_124_rake_253_normal.jpg`
- `assets/textures/harvest/acg_moss001_late_124_rake_253_rough.jpg`
- `assets/textures/harvest/acg_moss001_late_124_rough.jpg`
- `assets/textures/harvest/acg_moss001_rake_248_normal.jpg`
- `assets/textures/harvest/acg_moss001_rake_248_rough.jpg`
- `assets/textures/harvest/acg_moss001_shade_062_late_254_normal.jpg`
- `assets/textures/harvest/acg_moss001_shade_062_late_254_rough.jpg`
- `assets/textures/harvest/acg_moss001_shade_062_normal.jpg`
- `assets/textures/harvest/acg_moss001_shade_062_rough.jpg`
- `assets/textures/harvest/acg_moss001_shade_062_shade_127_normal.jpg`
- `assets/textures/harvest/acg_moss001_shade_062_shade_127_rough.jpg`
- `assets/textures/harvest/acg_moss001_shade_062_shade_127_wet_255_normal.jpg`
- `assets/textures/harvest/acg_moss001_shade_062_shade_127_wet_255_rough.jpg`
- `assets/textures/harvest/acg_pine_needles001_dry_256_normal.jpg`
- `assets/textures/harvest/acg_pine_needles001_dry_256_rough.jpg`
- `assets/textures/harvest/acg_pine_needles001_late_064_late_129_normal.jpg`
- `assets/textures/harvest/acg_pine_needles001_late_064_late_129_rake_258_normal.jpg`
- `assets/textures/harvest/acg_pine_needles001_late_064_late_129_rake_258_rough.jpg`
- `assets/textures/harvest/acg_pine_needles001_late_064_late_129_rough.jpg`
- `assets/textures/harvest/acg_pine_needles001_late_064_normal.jpg`
- `assets/textures/harvest/acg_pine_needles001_late_064_rough.jpg`
- `assets/textures/harvest/acg_pine_needles001_late_064_shade_257_normal.jpg`
- `assets/textures/harvest/acg_pine_needles001_late_064_shade_257_rough.jpg`
- `assets/textures/harvest/acg_pine_needles001_rake_128_late_259_normal.jpg`
- `assets/textures/harvest/acg_pine_needles001_rake_128_late_259_rough.jpg`
- `assets/textures/harvest/acg_pine_needles001_rake_128_normal.jpg`
- `assets/textures/harvest/acg_pine_needles001_rake_128_rough.jpg`
- `assets/textures/harvest/acg_pine_needles001_shade_032_normal.jpg`
- `assets/textures/harvest/acg_pine_needles001_shade_032_rough.jpg`
- `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_dry_131_normal.jpg`
- `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_dry_131_rough.jpg`
- `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_dry_131_shade_262_normal.jpg`
- `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_dry_131_shade_262_rough.jpg`
- `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_dry_261_normal.jpg`
- `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_dry_261_rough.jpg`
- `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_normal.jpg`
- `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_rough.jpg`
- `assets/textures/harvest/acg_pine_needles001_shade_032_wet_130_normal.jpg`
- `assets/textures/harvest/acg_pine_needles001_shade_032_wet_130_rake_263_normal.jpg`
- `assets/textures/harvest/acg_pine_needles001_shade_032_wet_130_rake_263_rough.jpg`
- `assets/textures/harvest/acg_pine_needles001_shade_032_wet_130_rough.jpg`
- `assets/textures/harvest/acg_pine_needles001_shade_032_wet_260_normal.jpg`
- `assets/textures/harvest/acg_pine_needles001_shade_032_wet_260_rough.jpg`
- `assets/textures/harvest/acg_planks012_dry_066_normal.jpg`
- `assets/textures/harvest/acg_planks012_dry_066_rake_133_dry_266_normal.jpg`
- `assets/textures/harvest/acg_planks012_dry_066_rake_133_dry_266_rough.jpg`
- `assets/textures/harvest/acg_planks012_dry_066_rake_133_normal.jpg`
- `assets/textures/harvest/acg_planks012_dry_066_rake_133_rough.jpg`
- `assets/textures/harvest/acg_planks012_dry_066_rough.jpg`
- `assets/textures/harvest/acg_planks012_dry_066_wet_265_normal.jpg`
- `assets/textures/harvest/acg_planks012_dry_066_wet_265_rough.jpg`
- `assets/textures/harvest/acg_planks012_late_264_normal.jpg`
- `assets/textures/harvest/acg_planks012_late_264_rough.jpg`
- `assets/textures/harvest/acg_planks012_rake_033_late_134_normal.jpg`
- `assets/textures/harvest/acg_planks012_rake_033_late_134_rake_268_normal.jpg`
- `assets/textures/harvest/acg_planks012_rake_033_late_134_rake_268_rough.jpg`
- `assets/textures/harvest/acg_planks012_rake_033_late_134_rough.jpg`
- `assets/textures/harvest/acg_planks012_rake_033_normal.jpg`
- `assets/textures/harvest/acg_planks012_rake_033_rough.jpg`
- `assets/textures/harvest/acg_planks012_rake_033_shade_067_late_269_normal.jpg`
- `assets/textures/harvest/acg_planks012_rake_033_shade_067_late_269_rough.jpg`
- `assets/textures/harvest/acg_planks012_rake_033_shade_067_normal.jpg`
- `assets/textures/harvest/acg_planks012_rake_033_shade_067_rough.jpg`
- `assets/textures/harvest/acg_planks012_rake_033_shade_067_wet_135_normal.jpg`
- `assets/textures/harvest/acg_planks012_rake_033_shade_067_wet_135_rough.jpg`
- `assets/textures/harvest/acg_planks012_rake_033_shade_067_wet_135_wet_270_normal.jpg`
- `assets/textures/harvest/acg_planks012_rake_033_shade_067_wet_135_wet_270_rough.jpg`
- `assets/textures/harvest/acg_planks012_rake_033_shade_267_normal.jpg`
- `assets/textures/harvest/acg_planks012_rake_033_shade_267_rough.jpg`
- `assets/textures/harvest/acg_planks012_shade_132_dry_271_normal.jpg`
- `assets/textures/harvest/acg_planks012_shade_132_dry_271_rough.jpg`
- `assets/textures/harvest/acg_planks012_shade_132_normal.jpg`
- `assets/textures/harvest/acg_planks012_shade_132_rough.jpg`
- `assets/textures/harvest/acg_planks013_dry_136_normal.jpg`
- `assets/textures/harvest/acg_planks013_dry_136_rake_273_normal.jpg`
- `assets/textures/harvest/acg_planks013_dry_136_rake_273_rough.jpg`
- `assets/textures/harvest/acg_planks013_dry_136_rough.jpg`
- `assets/textures/harvest/acg_planks013_late_034_late_069_normal.jpg`
- `assets/textures/harvest/acg_planks013_late_034_late_069_rake_138_dry_276_normal.jpg`
- `assets/textures/harvest/acg_planks013_late_034_late_069_rake_138_dry_276_rough.jpg`
- `assets/textures/harvest/acg_planks013_late_034_late_069_rake_138_normal.jpg`
- `assets/textures/harvest/acg_planks013_late_034_late_069_rake_138_rough.jpg`
- `assets/textures/harvest/acg_planks013_late_034_late_069_rough.jpg`
- `assets/textures/harvest/acg_planks013_late_034_late_069_wet_275_normal.jpg`
- `assets/textures/harvest/acg_planks013_late_034_late_069_wet_275_rough.jpg`
- `assets/textures/harvest/acg_planks013_late_034_late_274_normal.jpg`
- `assets/textures/harvest/acg_planks013_late_034_late_274_rough.jpg`
- `assets/textures/harvest/acg_planks013_late_034_normal.jpg`
- `assets/textures/harvest/acg_planks013_late_034_rough.jpg`
- `assets/textures/harvest/acg_planks013_late_034_shade_137_normal.jpg`
- `assets/textures/harvest/acg_planks013_late_034_shade_137_rough.jpg`
- `assets/textures/harvest/acg_planks013_late_034_shade_137_shade_277_normal.jpg`
- `assets/textures/harvest/acg_planks013_late_034_shade_137_shade_277_rough.jpg`
- `assets/textures/harvest/acg_planks013_rake_068_late_139_late_279_normal.jpg`
- `assets/textures/harvest/acg_planks013_rake_068_late_139_late_279_rough.jpg`
- `assets/textures/harvest/acg_planks013_rake_068_late_139_normal.jpg`
- `assets/textures/harvest/acg_planks013_rake_068_late_139_rough.jpg`
- `assets/textures/harvest/acg_planks013_rake_068_normal.jpg`
- `assets/textures/harvest/acg_planks013_rake_068_rake_278_normal.jpg`
- `assets/textures/harvest/acg_planks013_rake_068_rake_278_rough.jpg`
- `assets/textures/harvest/acg_planks013_rake_068_rough.jpg`
- `assets/textures/harvest/acg_planks013_shade_272_normal.jpg`
- `assets/textures/harvest/acg_planks013_shade_272_rough.jpg`
- `assets/textures/harvest/acg_planks017_wet_070_dry_141_normal.jpg`
- `assets/textures/harvest/acg_planks017_wet_070_dry_141_rough.jpg`
- `assets/textures/harvest/acg_planks017_wet_070_dry_141_shade_282_normal.jpg`
- `assets/textures/harvest/acg_planks017_wet_070_dry_141_shade_282_rough.jpg`
- `assets/textures/harvest/acg_planks017_wet_070_dry_281_normal.jpg`
- `assets/textures/harvest/acg_planks017_wet_070_dry_281_rough.jpg`
- `assets/textures/harvest/acg_planks017_wet_070_normal.jpg`
- `assets/textures/harvest/acg_planks017_wet_070_rough.jpg`
- `assets/textures/harvest/acg_planks017_wet_140_normal.jpg`
- `assets/textures/harvest/acg_planks017_wet_140_rake_283_normal.jpg`
- `assets/textures/harvest/acg_planks017_wet_140_rake_283_rough.jpg`
- `assets/textures/harvest/acg_planks017_wet_140_rough.jpg`
- `assets/textures/harvest/acg_planks017_wet_280_normal.jpg`
- `assets/textures/harvest/acg_planks017_wet_280_rough.jpg`
- `assets/textures/harvest/acg_soil001_dry_071_normal.jpg`
- `assets/textures/harvest/acg_soil001_dry_071_rake_143_dry_286_normal.jpg`
- `assets/textures/harvest/acg_soil001_dry_071_rake_143_dry_286_rough.jpg`
- `assets/textures/harvest/acg_soil001_dry_071_rake_143_normal.jpg`
- `assets/textures/harvest/acg_soil001_dry_071_rake_143_rough.jpg`
- `assets/textures/harvest/acg_soil001_dry_071_rough.jpg`
- `assets/textures/harvest/acg_soil001_dry_071_wet_285_normal.jpg`
- `assets/textures/harvest/acg_soil001_dry_071_wet_285_rough.jpg`
- `assets/textures/harvest/acg_soil001_late_284_normal.jpg`
- `assets/textures/harvest/acg_soil001_late_284_rough.jpg`
- `assets/textures/harvest/acg_soil001_shade_142_normal.jpg`
- `assets/textures/harvest/acg_soil001_shade_142_rough.jpg`
- `assets/textures/harvest/acg_soil001_shade_142_shade_287_normal.jpg`
- `assets/textures/harvest/acg_soil001_shade_142_shade_287_rough.jpg`
- `assets/textures/harvest/acg_wood001_late_144_late_289_normal.jpg`
- `assets/textures/harvest/acg_wood001_late_144_late_289_rough.jpg`
- `assets/textures/harvest/acg_wood001_late_144_normal.jpg`
- `assets/textures/harvest/acg_wood001_late_144_rough.jpg`
- `assets/textures/harvest/acg_wood001_rake_288_normal.jpg`
- `assets/textures/harvest/acg_wood001_rake_288_rough.jpg`
- `assets/textures/harvest/acg_wood001_shade_072_normal.jpg`
- `assets/textures/harvest/acg_wood001_shade_072_rough.jpg`
- `assets/textures/harvest/acg_wood001_shade_072_wet_145_dry_291_normal.jpg`
- `assets/textures/harvest/acg_wood001_shade_072_wet_145_dry_291_rough.jpg`
- `assets/textures/harvest/acg_wood001_shade_072_wet_145_normal.jpg`
- `assets/textures/harvest/acg_wood001_shade_072_wet_145_rough.jpg`
- `assets/textures/harvest/acg_wood001_shade_072_wet_290_normal.jpg`
- `assets/textures/harvest/acg_wood001_shade_072_wet_290_rough.jpg`
- `assets/textures/harvest/acg_wood048_dry_146_normal.jpg`
- `assets/textures/harvest/acg_wood048_dry_146_rake_293_normal.jpg`
- `assets/textures/harvest/acg_wood048_dry_146_rake_293_rough.jpg`
- `assets/textures/harvest/acg_wood048_dry_146_rough.jpg`
- `assets/textures/harvest/acg_wood048_rake_073_late_294_normal.jpg`
- `assets/textures/harvest/acg_wood048_rake_073_late_294_rough.jpg`
- `assets/textures/harvest/acg_wood048_rake_073_normal.jpg`
- `assets/textures/harvest/acg_wood048_rake_073_rough.jpg`
- `assets/textures/harvest/acg_wood048_rake_073_shade_147_normal.jpg`
- `assets/textures/harvest/acg_wood048_rake_073_shade_147_rough.jpg`
- `assets/textures/harvest/acg_wood048_rake_073_shade_147_wet_295_normal.jpg`
- `assets/textures/harvest/acg_wood048_rake_073_shade_147_wet_295_rough.jpg`
- `assets/textures/harvest/acg_wood048_shade_292_normal.jpg`
- `assets/textures/harvest/acg_wood048_shade_292_rough.jpg`
- `assets/textures/harvest/acg_wood051_dry_296_normal.jpg`
- `assets/textures/harvest/acg_wood051_dry_296_rough.jpg`
- `assets/textures/harvest/acg_wood051_late_074_late_149_normal.jpg`
- `assets/textures/harvest/acg_wood051_late_074_late_149_rake_298_normal.jpg`
- `assets/textures/harvest/acg_wood051_late_074_late_149_rake_298_rough.jpg`
- `assets/textures/harvest/acg_wood051_late_074_late_149_rough.jpg`
- `assets/textures/harvest/acg_wood051_late_074_normal.jpg`
- `assets/textures/harvest/acg_wood051_late_074_rough.jpg`
- `assets/textures/harvest/acg_wood051_late_074_shade_297_normal.jpg`
- `assets/textures/harvest/acg_wood051_late_074_shade_297_rough.jpg`
- `assets/textures/harvest/acg_wood051_rake_148_late_299_normal.jpg`
- `assets/textures/harvest/acg_wood051_rake_148_late_299_rough.jpg`
- `assets/textures/harvest/acg_wood051_rake_148_normal.jpg`
- `assets/textures/harvest/acg_wood051_rake_148_rough.jpg`
- `assets/textures/harvest/acg_woodchips001_wet_075_dry_151_normal.jpg`
- `assets/textures/harvest/acg_woodchips001_wet_075_dry_151_rough.jpg`
- `assets/textures/harvest/acg_woodchips001_wet_075_dry_151_shade_302_normal.jpg`
- `assets/textures/harvest/acg_woodchips001_wet_075_dry_151_shade_302_rough.jpg`
- `assets/textures/harvest/acg_woodchips001_wet_075_dry_301_normal.jpg`
- `assets/textures/harvest/acg_woodchips001_wet_075_dry_301_rough.jpg`
- `assets/textures/harvest/acg_woodchips001_wet_075_normal.jpg`
- `assets/textures/harvest/acg_woodchips001_wet_075_rough.jpg`
- `assets/textures/harvest/acg_woodchips001_wet_150_normal.jpg`
- `assets/textures/harvest/acg_woodchips001_wet_150_rake_303_normal.jpg`
- `assets/textures/harvest/acg_woodchips001_wet_150_rake_303_rough.jpg`
- `assets/textures/harvest/acg_woodchips001_wet_150_rough.jpg`
- `assets/textures/harvest/acg_woodchips001_wet_300_normal.jpg`
- `assets/textures/harvest/acg_woodchips001_wet_300_rough.jpg`
- `assets/textures/harvest/aerial_grass_rock_dry_076_normal.jpg`
- `assets/textures/harvest/aerial_grass_rock_dry_076_rake_153_dry_306_normal.jpg`
- `assets/textures/harvest/aerial_grass_rock_dry_076_rake_153_dry_306_rough.jpg`
- `assets/textures/harvest/aerial_grass_rock_dry_076_rake_153_normal.jpg`
- `assets/textures/harvest/aerial_grass_rock_dry_076_rake_153_rough.jpg`
- `assets/textures/harvest/aerial_grass_rock_dry_076_rough.jpg`
- `assets/textures/harvest/aerial_grass_rock_dry_076_wet_305_normal.jpg`
- `assets/textures/harvest/aerial_grass_rock_dry_076_wet_305_rough.jpg`
- `assets/textures/harvest/aerial_grass_rock_late_304_normal.jpg`
- `assets/textures/harvest/aerial_grass_rock_late_304_rough.jpg`
- `assets/textures/harvest/aerial_grass_rock_shade_152_normal.jpg`
- `assets/textures/harvest/aerial_grass_rock_shade_152_rough.jpg`
- `assets/textures/harvest/aerial_grass_rock_shade_152_shade_307_normal.jpg`
- `assets/textures/harvest/aerial_grass_rock_shade_152_shade_307_rough.jpg`
- `assets/textures/harvest/bark_bluegum_late_154_late_309_normal.jpg`
- `assets/textures/harvest/bark_bluegum_late_154_late_309_rough.jpg`
- `assets/textures/harvest/bark_bluegum_late_154_normal.jpg`
- `assets/textures/harvest/bark_bluegum_late_154_rough.jpg`
- `assets/textures/harvest/bark_bluegum_rake_308_normal.jpg`
- `assets/textures/harvest/bark_bluegum_rake_308_rough.jpg`
- `assets/textures/harvest/bark_bluegum_shade_077_normal.jpg`
- `assets/textures/harvest/bark_bluegum_shade_077_rough.jpg`
- `assets/textures/harvest/bark_bluegum_shade_077_wet_155_dry_311_normal.jpg`
- `assets/textures/harvest/bark_bluegum_shade_077_wet_155_dry_311_rough.jpg`
- `assets/textures/harvest/bark_bluegum_shade_077_wet_155_normal.jpg`
- `assets/textures/harvest/bark_bluegum_shade_077_wet_155_rough.jpg`
- `assets/textures/harvest/bark_bluegum_shade_077_wet_310_normal.jpg`
- `assets/textures/harvest/bark_bluegum_shade_077_wet_310_rough.jpg`
- `assets/textures/harvest/bark_brown_01_dry_156_normal.jpg`
- `assets/textures/harvest/bark_brown_01_dry_156_rake_313_normal.jpg`
- `assets/textures/harvest/bark_brown_01_dry_156_rake_313_rough.jpg`
- `assets/textures/harvest/bark_brown_01_dry_156_rough.jpg`
- `assets/textures/harvest/bark_brown_01_rake_078_late_314_normal.jpg`
- `assets/textures/harvest/bark_brown_01_rake_078_late_314_rough.jpg`
- `assets/textures/harvest/bark_brown_01_rake_078_normal.jpg`
- `assets/textures/harvest/bark_brown_01_rake_078_rough.jpg`
- `assets/textures/harvest/bark_brown_01_rake_078_shade_157_normal.jpg`
- `assets/textures/harvest/bark_brown_01_rake_078_shade_157_rough.jpg`
- `assets/textures/harvest/bark_brown_01_rake_078_shade_157_wet_315_normal.jpg`
- `assets/textures/harvest/bark_brown_01_rake_078_shade_157_wet_315_rough.jpg`
- `assets/textures/harvest/bark_brown_01_shade_312_normal.jpg`
- `assets/textures/harvest/bark_brown_01_shade_312_rough.jpg`
- `assets/textures/harvest/bark_platanus_dry_316_normal.jpg`
- `assets/textures/harvest/bark_platanus_dry_316_rough.jpg`
- `assets/textures/harvest/bark_platanus_late_079_late_159_normal.jpg`
- `assets/textures/harvest/bark_platanus_late_079_late_159_rake_318_normal.jpg`
- `assets/textures/harvest/bark_platanus_late_079_late_159_rake_318_rough.jpg`
- `assets/textures/harvest/bark_platanus_late_079_late_159_rough.jpg`
- `assets/textures/harvest/bark_platanus_late_079_normal.jpg`
- `assets/textures/harvest/bark_platanus_late_079_rough.jpg`
- `assets/textures/harvest/bark_platanus_late_079_shade_317_normal.jpg`
- `assets/textures/harvest/bark_platanus_late_079_shade_317_rough.jpg`
- `assets/textures/harvest/bark_platanus_rake_158_late_319_normal.jpg`
- `assets/textures/harvest/bark_platanus_rake_158_late_319_rough.jpg`
- `assets/textures/harvest/bark_platanus_rake_158_normal.jpg`
- `assets/textures/harvest/bark_platanus_rake_158_rough.jpg`
- `assets/textures/harvest/bark_willow_02_wet_080_dry_161_normal.jpg`
- `assets/textures/harvest/bark_willow_02_wet_080_dry_161_rough.jpg`
- `assets/textures/harvest/bark_willow_02_wet_080_dry_161_shade_322_normal.jpg`
- `assets/textures/harvest/bark_willow_02_wet_080_dry_161_shade_322_rough.jpg`
- `assets/textures/harvest/bark_willow_02_wet_080_dry_321_normal.jpg`
- `assets/textures/harvest/bark_willow_02_wet_080_dry_321_rough.jpg`
- `assets/textures/harvest/bark_willow_02_wet_080_normal.jpg`
- `assets/textures/harvest/bark_willow_02_wet_080_rough.jpg`
- `assets/textures/harvest/bark_willow_02_wet_160_normal.jpg`
- `assets/textures/harvest/bark_willow_02_wet_160_rake_323_normal.jpg`
- `assets/textures/harvest/bark_willow_02_wet_160_rake_323_rough.jpg`
- `assets/textures/harvest/bark_willow_02_wet_160_rough.jpg`
- `assets/textures/harvest/bark_willow_02_wet_320_normal.jpg`
- `assets/textures/harvest/bark_willow_02_wet_320_rough.jpg`
- `assets/textures/harvest/bark_willow_dry_081_normal.jpg`
- `assets/textures/harvest/bark_willow_dry_081_rake_163_dry_326_normal.jpg`
- `assets/textures/harvest/bark_willow_dry_081_rake_163_dry_326_rough.jpg`
- `assets/textures/harvest/bark_willow_dry_081_rake_163_normal.jpg`
- `assets/textures/harvest/bark_willow_dry_081_rake_163_rough.jpg`
- `assets/textures/harvest/bark_willow_dry_081_rough.jpg`
- `assets/textures/harvest/bark_willow_dry_081_wet_325_normal.jpg`
- `assets/textures/harvest/bark_willow_dry_081_wet_325_rough.jpg`
- `assets/textures/harvest/bark_willow_late_324_normal.jpg`
- `assets/textures/harvest/bark_willow_late_324_rough.jpg`
- `assets/textures/harvest/bark_willow_shade_162_normal.jpg`
- `assets/textures/harvest/bark_willow_shade_162_rough.jpg`
- `assets/textures/harvest/bark_willow_shade_162_shade_327_normal.jpg`
- `assets/textures/harvest/bark_willow_shade_162_shade_327_rough.jpg`
- `assets/textures/harvest/baseball_playground_late_164_late_329_normal.jpg`
- `assets/textures/harvest/baseball_playground_late_164_late_329_rough.jpg`
- `assets/textures/harvest/baseball_playground_late_164_normal.jpg`
- `assets/textures/harvest/baseball_playground_late_164_rough.jpg`
- `assets/textures/harvest/baseball_playground_rake_328_normal.jpg`
- `assets/textures/harvest/baseball_playground_rake_328_rough.jpg`
- `assets/textures/harvest/baseball_playground_shade_082_normal.jpg`
- `assets/textures/harvest/baseball_playground_shade_082_rough.jpg`
- `assets/textures/harvest/baseball_playground_shade_082_wet_165_dry_331_normal.jpg`
- `assets/textures/harvest/baseball_playground_shade_082_wet_165_dry_331_rough.jpg`
- `assets/textures/harvest/baseball_playground_shade_082_wet_165_normal.jpg`
- `assets/textures/harvest/baseball_playground_shade_082_wet_165_rough.jpg`
- `assets/textures/harvest/baseball_playground_shade_082_wet_330_normal.jpg`
- `assets/textures/harvest/baseball_playground_shade_082_wet_330_rough.jpg`
- `assets/textures/harvest/bicolour_gravel_dry_166_normal.jpg`
- `assets/textures/harvest/bicolour_gravel_dry_166_rake_333_normal.jpg`
- `assets/textures/harvest/bicolour_gravel_dry_166_rake_333_rough.jpg`
- `assets/textures/harvest/bicolour_gravel_dry_166_rough.jpg`
- `assets/textures/harvest/bicolour_gravel_rake_083_late_334_normal.jpg`
- `assets/textures/harvest/bicolour_gravel_rake_083_late_334_rough.jpg`
- `assets/textures/harvest/bicolour_gravel_rake_083_normal.jpg`
- `assets/textures/harvest/bicolour_gravel_rake_083_rough.jpg`
- `assets/textures/harvest/bicolour_gravel_rake_083_shade_167_normal.jpg`
- `assets/textures/harvest/bicolour_gravel_rake_083_shade_167_rough.jpg`
- `assets/textures/harvest/bicolour_gravel_rake_083_shade_167_wet_335_normal.jpg`
- `assets/textures/harvest/bicolour_gravel_rake_083_shade_167_wet_335_rough.jpg`
- `assets/textures/harvest/bicolour_gravel_shade_332_normal.jpg`
- `assets/textures/harvest/bicolour_gravel_shade_332_rough.jpg`
- `assets/textures/harvest/brown_leather_dry_336_normal.jpg`
- `assets/textures/harvest/brown_leather_dry_336_rough.jpg`
- `assets/textures/harvest/brown_leather_late_084_late_169_normal.jpg`
- `assets/textures/harvest/brown_leather_late_084_late_169_rake_338_normal.jpg`
- `assets/textures/harvest/brown_leather_late_084_late_169_rake_338_rough.jpg`
- `assets/textures/harvest/brown_leather_late_084_late_169_rough.jpg`
- `assets/textures/harvest/brown_leather_late_084_normal.jpg`
- `assets/textures/harvest/brown_leather_late_084_rough.jpg`
- `assets/textures/harvest/brown_leather_late_084_shade_337_normal.jpg`
- `assets/textures/harvest/brown_leather_late_084_shade_337_rough.jpg`
- `assets/textures/harvest/brown_leather_rake_168_late_339_normal.jpg`
- `assets/textures/harvest/brown_leather_rake_168_late_339_rough.jpg`
- `assets/textures/harvest/brown_leather_rake_168_normal.jpg`
- `assets/textures/harvest/brown_leather_rake_168_rough.jpg`
- `assets/textures/harvest/brown_mud_03_wet_085_dry_171_normal.jpg`
- `assets/textures/harvest/brown_mud_03_wet_085_dry_171_rough.jpg`
- `assets/textures/harvest/brown_mud_03_wet_085_dry_171_shade_342_normal.jpg`
- `assets/textures/harvest/brown_mud_03_wet_085_dry_171_shade_342_rough.jpg`
- `assets/textures/harvest/brown_mud_03_wet_085_dry_341_normal.jpg`
- `assets/textures/harvest/brown_mud_03_wet_085_dry_341_rough.jpg`
- `assets/textures/harvest/brown_mud_03_wet_085_normal.jpg`
- `assets/textures/harvest/brown_mud_03_wet_085_rough.jpg`
- `assets/textures/harvest/brown_mud_03_wet_170_normal.jpg`
- `assets/textures/harvest/brown_mud_03_wet_170_rake_343_normal.jpg`
- `assets/textures/harvest/brown_mud_03_wet_170_rake_343_rough.jpg`
- `assets/textures/harvest/brown_mud_03_wet_170_rough.jpg`
- `assets/textures/harvest/brown_mud_03_wet_340_normal.jpg`
- `assets/textures/harvest/brown_mud_03_wet_340_rough.jpg`
- `assets/textures/harvest/brown_mud_dry_086_normal.jpg`
- `assets/textures/harvest/brown_mud_dry_086_rake_173_dry_346_normal.jpg`
- `assets/textures/harvest/brown_mud_dry_086_rake_173_dry_346_rough.jpg`
- `assets/textures/harvest/brown_mud_dry_086_rake_173_normal.jpg`
- `assets/textures/harvest/brown_mud_dry_086_rake_173_rough.jpg`
- `assets/textures/harvest/brown_mud_dry_086_rough.jpg`
- `assets/textures/harvest/brown_mud_dry_086_wet_345_normal.jpg`
- `assets/textures/harvest/brown_mud_dry_086_wet_345_rough.jpg`
- `assets/textures/harvest/brown_mud_dry_late_174_normal.jpg`
- `assets/textures/harvest/brown_mud_dry_late_174_rake_348_normal.jpg`
- `assets/textures/harvest/brown_mud_dry_late_174_rake_348_rough.jpg`
- `assets/textures/harvest/brown_mud_dry_late_174_rough.jpg`
- `assets/textures/harvest/brown_mud_dry_shade_087_late_349_normal.jpg`
- `assets/textures/harvest/brown_mud_dry_shade_087_late_349_rough.jpg`
- `assets/textures/harvest/brown_mud_dry_shade_087_normal.jpg`
- `assets/textures/harvest/brown_mud_dry_shade_087_rough.jpg`
- `assets/textures/harvest/brown_mud_dry_shade_087_wet_175_normal.jpg`
- `assets/textures/harvest/brown_mud_dry_shade_087_wet_175_rough.jpg`
- `assets/textures/harvest/brown_mud_dry_shade_087_wet_175_wet_350_normal.jpg`
- `assets/textures/harvest/brown_mud_dry_shade_087_wet_175_wet_350_rough.jpg`
- `assets/textures/harvest/brown_mud_dry_shade_347_normal.jpg`
- `assets/textures/harvest/brown_mud_dry_shade_347_rough.jpg`
- `assets/textures/harvest/brown_mud_late_344_normal.jpg`
- `assets/textures/harvest/brown_mud_late_344_rough.jpg`
- `assets/textures/harvest/brown_mud_leaves_dry_176_normal.jpg`
- `assets/textures/harvest/brown_mud_leaves_dry_176_rough.jpg`
- `assets/textures/harvest/brown_mud_leaves_dry_176_shade_352_normal.jpg`
- `assets/textures/harvest/brown_mud_leaves_dry_176_shade_352_rough.jpg`
- `assets/textures/harvest/brown_mud_leaves_dry_351_normal.jpg`
- `assets/textures/harvest/brown_mud_leaves_dry_351_rough.jpg`
- `assets/textures/harvest/brown_mud_leaves_rake_088_normal.jpg`
- `assets/textures/harvest/brown_mud_leaves_rake_088_rake_353_normal.jpg`
- `assets/textures/harvest/brown_mud_leaves_rake_088_rake_353_rough.jpg`
- `assets/textures/harvest/brown_mud_leaves_rake_088_rough.jpg`
- `assets/textures/harvest/brown_mud_leaves_rake_088_shade_177_late_354_normal.jpg`
- `assets/textures/harvest/brown_mud_leaves_rake_088_shade_177_late_354_rough.jpg`
- `assets/textures/harvest/brown_mud_leaves_rake_088_shade_177_normal.jpg`
- `assets/textures/harvest/brown_mud_leaves_rake_088_shade_177_rough.jpg`
- `assets/textures/harvest/brown_mud_shade_172_normal.jpg`
- `assets/textures/harvest/brown_mud_shade_172_rough.jpg`
- `assets/textures/harvest/brown_mud_shade_172_wet_355_normal.jpg`
- `assets/textures/harvest/brown_mud_shade_172_wet_355_rough.jpg`
- `assets/textures/harvest/brown_planks_03_dry_356_normal.jpg`
- `assets/textures/harvest/brown_planks_03_dry_356_rough.jpg`
- `assets/textures/harvest/brown_planks_03_late_089_late_179_normal.jpg`
- `assets/textures/harvest/brown_planks_03_late_089_late_179_rake_358_normal.jpg`
- `assets/textures/harvest/brown_planks_03_late_089_late_179_rake_358_rough.jpg`
- `assets/textures/harvest/brown_planks_03_late_089_late_179_rough.jpg`
- `assets/textures/harvest/brown_planks_03_late_089_normal.jpg`
- `assets/textures/harvest/brown_planks_03_late_089_rough.jpg`
- `assets/textures/harvest/brown_planks_03_late_089_shade_357_normal.jpg`
- `assets/textures/harvest/brown_planks_03_late_089_shade_357_rough.jpg`
- `assets/textures/harvest/brown_planks_03_rake_178_late_359_normal.jpg`
- `assets/textures/harvest/brown_planks_03_rake_178_late_359_rough.jpg`
- `assets/textures/harvest/brown_planks_03_rake_178_normal.jpg`
- `assets/textures/harvest/brown_planks_03_rake_178_rough.jpg`
- `assets/textures/harvest/brown_planks_04_wet_090_dry_181_normal.jpg`
- `assets/textures/harvest/brown_planks_04_wet_090_dry_181_rough.jpg`
- `assets/textures/harvest/brown_planks_04_wet_090_dry_181_shade_362_normal.jpg`
- `assets/textures/harvest/brown_planks_04_wet_090_dry_181_shade_362_rough.jpg`
- `assets/textures/harvest/brown_planks_04_wet_090_dry_361_normal.jpg`
- `assets/textures/harvest/brown_planks_04_wet_090_dry_361_rough.jpg`
- `assets/textures/harvest/brown_planks_04_wet_090_normal.jpg`
- `assets/textures/harvest/brown_planks_04_wet_090_rough.jpg`
- `assets/textures/harvest/brown_planks_04_wet_180_normal.jpg`
- `assets/textures/harvest/brown_planks_04_wet_180_rake_363_normal.jpg`
- `assets/textures/harvest/brown_planks_04_wet_180_rake_363_rough.jpg`
- `assets/textures/harvest/brown_planks_04_wet_180_rough.jpg`
- `assets/textures/harvest/brown_planks_04_wet_360_normal.jpg`
- `assets/textures/harvest/brown_planks_04_wet_360_rough.jpg`
- `assets/textures/harvest/chinese_cedar_bark_dry_091_normal.jpg`
- `assets/textures/harvest/chinese_cedar_bark_dry_091_rake_183_dry_366_normal.jpg`
- `assets/textures/harvest/chinese_cedar_bark_dry_091_rake_183_dry_366_rough.jpg`
- `assets/textures/harvest/chinese_cedar_bark_dry_091_rake_183_normal.jpg`
- `assets/textures/harvest/chinese_cedar_bark_dry_091_rake_183_rough.jpg`
- `assets/textures/harvest/chinese_cedar_bark_dry_091_rough.jpg`
- `assets/textures/harvest/chinese_cedar_bark_dry_091_wet_365_normal.jpg`
- `assets/textures/harvest/chinese_cedar_bark_dry_091_wet_365_rough.jpg`
- `assets/textures/harvest/chinese_cedar_bark_late_364_normal.jpg`
- `assets/textures/harvest/chinese_cedar_bark_late_364_rough.jpg`
- `assets/textures/harvest/chinese_cedar_bark_shade_182_normal.jpg`
- `assets/textures/harvest/chinese_cedar_bark_shade_182_rough.jpg`
- `assets/textures/harvest/chinese_cedar_bark_shade_182_shade_367_normal.jpg`
- `assets/textures/harvest/chinese_cedar_bark_shade_182_shade_367_rough.jpg`
- `assets/textures/harvest/coated_pine_late_184_late_369_normal.jpg`
- `assets/textures/harvest/coated_pine_late_184_late_369_rough.jpg`
- `assets/textures/harvest/coated_pine_late_184_normal.jpg`
- `assets/textures/harvest/coated_pine_late_184_rough.jpg`
- `assets/textures/harvest/coated_pine_rake_368_normal.jpg`
- `assets/textures/harvest/coated_pine_rake_368_rough.jpg`
- `assets/textures/harvest/coated_pine_shade_092_normal.jpg`
- `assets/textures/harvest/coated_pine_shade_092_rough.jpg`
- `assets/textures/harvest/coated_pine_shade_092_wet_185_dry_371_normal.jpg`
- `assets/textures/harvest/coated_pine_shade_092_wet_185_dry_371_rough.jpg`
- `assets/textures/harvest/coated_pine_shade_092_wet_185_normal.jpg`
- `assets/textures/harvest/coated_pine_shade_092_wet_185_rough.jpg`
- `assets/textures/harvest/coated_pine_shade_092_wet_370_normal.jpg`
- `assets/textures/harvest/coated_pine_shade_092_wet_370_rough.jpg`
- `assets/textures/harvest/damp_sand_dry_186_normal.jpg`
- `assets/textures/harvest/damp_sand_dry_186_rake_373_normal.jpg`
- `assets/textures/harvest/damp_sand_dry_186_rake_373_rough.jpg`
- `assets/textures/harvest/damp_sand_dry_186_rough.jpg`
- `assets/textures/harvest/damp_sand_rake_093_late_374_normal.jpg`
- `assets/textures/harvest/damp_sand_rake_093_late_374_rough.jpg`
- `assets/textures/harvest/damp_sand_rake_093_normal.jpg`
- `assets/textures/harvest/damp_sand_rake_093_rough.jpg`
- `assets/textures/harvest/damp_sand_rake_093_shade_187_normal.jpg`
- `assets/textures/harvest/damp_sand_rake_093_shade_187_rough.jpg`
- `assets/textures/harvest/damp_sand_rake_093_shade_187_wet_375_normal.jpg`
- `assets/textures/harvest/damp_sand_rake_093_shade_187_wet_375_rough.jpg`
- `assets/textures/harvest/damp_sand_shade_372_normal.jpg`
- `assets/textures/harvest/damp_sand_shade_372_rough.jpg`
- `assets/textures/harvest/dark_planks_dry_376_normal.jpg`
- `assets/textures/harvest/dark_planks_dry_376_rough.jpg`
- `assets/textures/harvest/dark_planks_late_094_late_189_normal.jpg`
- `assets/textures/harvest/dark_planks_late_094_late_189_rake_378_normal.jpg`
- `assets/textures/harvest/dark_planks_late_094_late_189_rake_378_rough.jpg`
- `assets/textures/harvest/dark_planks_late_094_late_189_rough.jpg`
- `assets/textures/harvest/dark_planks_late_094_normal.jpg`
- `assets/textures/harvest/dark_planks_late_094_rough.jpg`
- `assets/textures/harvest/dark_planks_late_094_shade_377_normal.jpg`
- `assets/textures/harvest/dark_planks_late_094_shade_377_rough.jpg`
- `assets/textures/harvest/dark_planks_rake_188_late_379_normal.jpg`
- `assets/textures/harvest/dark_planks_rake_188_late_379_rough.jpg`
- `assets/textures/harvest/dark_planks_rake_188_normal.jpg`
- `assets/textures/harvest/dark_planks_rake_188_rough.jpg`
- `assets/textures/harvest/dark_wood_wet_095_dry_191_normal.jpg`
- `assets/textures/harvest/dark_wood_wet_095_dry_191_rough.jpg`
- `assets/textures/harvest/dark_wood_wet_095_dry_191_shade_382_normal.jpg`
- `assets/textures/harvest/dark_wood_wet_095_dry_191_shade_382_rough.jpg`
- `assets/textures/harvest/dark_wood_wet_095_dry_381_normal.jpg`
- `assets/textures/harvest/dark_wood_wet_095_dry_381_rough.jpg`
- `assets/textures/harvest/dark_wood_wet_095_normal.jpg`
- `assets/textures/harvest/dark_wood_wet_095_rough.jpg`
- `assets/textures/harvest/dark_wood_wet_190_normal.jpg`
- `assets/textures/harvest/dark_wood_wet_190_rake_383_normal.jpg`
- `assets/textures/harvest/dark_wood_wet_190_rake_383_rough.jpg`
- `assets/textures/harvest/dark_wood_wet_190_rough.jpg`
- `assets/textures/harvest/dark_wood_wet_380_normal.jpg`
- `assets/textures/harvest/dark_wood_wet_380_rough.jpg`
- `assets/textures/harvest/denim_fabric_skip_dry_096_normal.jpg`
- `assets/textures/harvest/denim_fabric_skip_dry_096_rake_193_dry_386_normal.jpg`
- `assets/textures/harvest/denim_fabric_skip_dry_096_rake_193_dry_386_rough.jpg`
- `assets/textures/harvest/denim_fabric_skip_dry_096_rake_193_normal.jpg`
- `assets/textures/harvest/denim_fabric_skip_dry_096_rake_193_rough.jpg`
- `assets/textures/harvest/denim_fabric_skip_dry_096_rough.jpg`
- `assets/textures/harvest/denim_fabric_skip_dry_096_wet_385_normal.jpg`
- `assets/textures/harvest/denim_fabric_skip_dry_096_wet_385_rough.jpg`
- `assets/textures/harvest/denim_fabric_skip_late_384_normal.jpg`
- `assets/textures/harvest/denim_fabric_skip_late_384_rough.jpg`
- `assets/textures/harvest/denim_fabric_skip_shade_192_normal.jpg`
- `assets/textures/harvest/denim_fabric_skip_shade_192_rough.jpg`
- `assets/textures/harvest/denim_fabric_skip_shade_192_shade_387_normal.jpg`
- `assets/textures/harvest/denim_fabric_skip_shade_192_shade_387_rough.jpg`
- `assets/textures/harvest/dirt_floor_late_389_normal.jpg`
- `assets/textures/harvest/dirt_floor_late_389_rough.jpg`
- `assets/textures/harvest/dirt_floor_rake_098_dry_196_dry_391_normal.jpg`
- `assets/textures/harvest/dirt_floor_rake_098_dry_196_dry_391_rough.jpg`
- `assets/textures/harvest/dirt_floor_rake_098_dry_196_normal.jpg`
- `assets/textures/harvest/dirt_floor_rake_098_dry_196_rough.jpg`
- `assets/textures/harvest/dirt_floor_rake_098_normal.jpg`
- `assets/textures/harvest/dirt_floor_rake_098_rough.jpg`
- `assets/textures/harvest/dirt_floor_rake_098_wet_390_normal.jpg`
- `assets/textures/harvest/dirt_floor_rake_098_wet_390_rough.jpg`
- `assets/textures/harvest/dirt_floor_wet_195_normal.jpg`
- `assets/textures/harvest/dirt_floor_wet_195_rough.jpg`
- `assets/textures/harvest/dirt_floor_wet_195_shade_392_normal.jpg`
- `assets/textures/harvest/dirt_floor_wet_195_shade_392_rough.jpg`
- `assets/textures/harvest/dirt_late_194_normal.jpg`
- `assets/textures/harvest/dirt_late_194_rake_393_normal.jpg`
- `assets/textures/harvest/dirt_late_194_rake_393_rough.jpg`
- `assets/textures/harvest/dirt_late_194_rough.jpg`
- `assets/textures/harvest/dirt_rake_388_normal.jpg`
- `assets/textures/harvest/dirt_rake_388_rough.jpg`
- `assets/textures/harvest/dirt_shade_097_late_394_normal.jpg`
- `assets/textures/harvest/dirt_shade_097_late_394_rough.jpg`
- `assets/textures/harvest/dirt_shade_097_normal.jpg`
- `assets/textures/harvest/dirt_shade_097_rough.jpg`
- `assets/textures/harvest/dirt_shade_097_shade_197_normal.jpg`
- `assets/textures/harvest/dirt_shade_097_shade_197_rough.jpg`
- `assets/textures/harvest/dirt_shade_097_shade_197_wet_395_normal.jpg`
- `assets/textures/harvest/dirt_shade_097_shade_197_wet_395_rough.jpg`
- `assets/textures/harvest/distressed_painted_planks_dry_396_normal.jpg`
- `assets/textures/harvest/distressed_painted_planks_dry_396_rough.jpg`
- `assets/textures/harvest/distressed_painted_planks_late_099_late_199_normal.jpg`
- `assets/textures/harvest/distressed_painted_planks_late_099_late_199_rake_398_normal.jpg`
- `assets/textures/harvest/distressed_painted_planks_late_099_late_199_rake_398_rough.jpg`
- `assets/textures/harvest/distressed_painted_planks_late_099_late_199_rough.jpg`
- `assets/textures/harvest/distressed_painted_planks_late_099_normal.jpg`
- `assets/textures/harvest/distressed_painted_planks_late_099_rough.jpg`
- `assets/textures/harvest/distressed_painted_planks_late_099_shade_397_normal.jpg`
- `assets/textures/harvest/distressed_painted_planks_late_099_shade_397_rough.jpg`
- `assets/textures/harvest/distressed_painted_planks_rake_198_late_399_normal.jpg`
- `assets/textures/harvest/distressed_painted_planks_rake_198_late_399_rough.jpg`
- `assets/textures/harvest/distressed_painted_planks_rake_198_normal.jpg`
- `assets/textures/harvest/distressed_painted_planks_rake_198_rough.jpg`
- `assets/textures/harvest/dry_ground_01_wet_100_dry_201_normal.jpg`
- `assets/textures/harvest/dry_ground_01_wet_100_dry_201_rough.jpg`
- `assets/textures/harvest/dry_ground_01_wet_100_dry_201_shade_402_normal.jpg`
- `assets/textures/harvest/dry_ground_01_wet_100_dry_201_shade_402_rough.jpg`
- `assets/textures/harvest/dry_ground_01_wet_100_dry_401_normal.jpg`
- `assets/textures/harvest/dry_ground_01_wet_100_dry_401_rough.jpg`
- `assets/textures/harvest/dry_ground_01_wet_100_normal.jpg`
- `assets/textures/harvest/dry_ground_01_wet_100_rough.jpg`
- `assets/textures/harvest/dry_ground_01_wet_200_normal.jpg`
- `assets/textures/harvest/dry_ground_01_wet_200_rake_403_normal.jpg`
- `assets/textures/harvest/dry_ground_01_wet_200_rake_403_rough.jpg`
- `assets/textures/harvest/dry_ground_01_wet_200_rough.jpg`
- `assets/textures/harvest/dry_ground_01_wet_400_normal.jpg`
- `assets/textures/harvest/dry_ground_01_wet_400_rough.jpg`
- `assets/textures/harvest/fabric_leather_01_dry_101_normal.jpg`
- `assets/textures/harvest/fabric_leather_01_dry_101_rake_203_dry_406_normal.jpg`
- `assets/textures/harvest/fabric_leather_01_dry_101_rake_203_dry_406_rough.jpg`
- `assets/textures/harvest/fabric_leather_01_dry_101_rake_203_normal.jpg`
- `assets/textures/harvest/fabric_leather_01_dry_101_rake_203_rough.jpg`
- `assets/textures/harvest/fabric_leather_01_dry_101_rough.jpg`
- `assets/textures/harvest/fabric_leather_01_dry_101_wet_405_normal.jpg`
- `assets/textures/harvest/fabric_leather_01_dry_101_wet_405_rough.jpg`
- `assets/textures/harvest/fabric_leather_01_late_404_normal.jpg`
- `assets/textures/harvest/fabric_leather_01_late_404_rough.jpg`
- `assets/textures/harvest/fabric_leather_01_shade_202_normal.jpg`
- `assets/textures/harvest/fabric_leather_01_shade_202_rough.jpg`
- `assets/textures/harvest/fabric_leather_01_shade_202_shade_407_normal.jpg`
- `assets/textures/harvest/fabric_leather_01_shade_202_shade_407_rough.jpg`
- `assets/textures/harvest/fabric_leather_02_late_204_late_409_normal.jpg`
- `assets/textures/harvest/fabric_leather_02_late_204_late_409_rough.jpg`
- `assets/textures/harvest/fabric_leather_02_late_204_normal.jpg`
- `assets/textures/harvest/fabric_leather_02_late_204_rough.jpg`
- `assets/textures/harvest/fabric_leather_02_rake_408_normal.jpg`
- `assets/textures/harvest/fabric_leather_02_rake_408_rough.jpg`
- `assets/textures/harvest/fabric_leather_02_shade_102_normal.jpg`
- `assets/textures/harvest/fabric_leather_02_shade_102_rough.jpg`
- `assets/textures/harvest/fabric_leather_02_shade_102_wet_205_dry_411_normal.jpg`
- `assets/textures/harvest/fabric_leather_02_shade_102_wet_205_dry_411_rough.jpg`
- `assets/textures/harvest/fabric_leather_02_shade_102_wet_205_normal.jpg`
- `assets/textures/harvest/fabric_leather_02_shade_102_wet_205_rough.jpg`
- `assets/textures/harvest/fabric_leather_02_shade_102_wet_410_normal.jpg`
- `assets/textures/harvest/fabric_leather_02_shade_102_wet_410_rough.jpg`
- `assets/textures/harvest/farm_soil_dry_206_normal.jpg`
- `assets/textures/harvest/farm_soil_dry_206_rake_413_normal.jpg`
- `assets/textures/harvest/farm_soil_dry_206_rake_413_rough.jpg`
- `assets/textures/harvest/farm_soil_dry_206_rough.jpg`
- `assets/textures/harvest/farm_soil_rake_103_late_414_normal.jpg`
- `assets/textures/harvest/farm_soil_rake_103_late_414_rough.jpg`
- `assets/textures/harvest/farm_soil_rake_103_normal.jpg`
- `assets/textures/harvest/farm_soil_rake_103_rough.jpg`
- `assets/textures/harvest/farm_soil_rake_103_shade_207_normal.jpg`
- `assets/textures/harvest/farm_soil_rake_103_shade_207_rough.jpg`
- `assets/textures/harvest/farm_soil_rake_103_shade_207_wet_415_normal.jpg`
- `assets/textures/harvest/farm_soil_rake_103_shade_207_wet_415_rough.jpg`
- `assets/textures/harvest/farm_soil_shade_412_normal.jpg`
- `assets/textures/harvest/farm_soil_shade_412_rough.jpg`
- `assets/textures/harvest/flower_scattered_dirt_dry_416_normal.jpg`
- `assets/textures/harvest/flower_scattered_dirt_dry_416_rough.jpg`
- `assets/textures/harvest/flower_scattered_dirt_late_104_late_209_normal.jpg`
- `assets/textures/harvest/flower_scattered_dirt_late_104_late_209_rake_418_normal.jpg`
- `assets/textures/harvest/flower_scattered_dirt_late_104_late_209_rake_418_rough.jpg`
- `assets/textures/harvest/flower_scattered_dirt_late_104_late_209_rough.jpg`
- `assets/textures/harvest/flower_scattered_dirt_late_104_normal.jpg`
- `assets/textures/harvest/flower_scattered_dirt_late_104_rough.jpg`
- `assets/textures/harvest/flower_scattered_dirt_late_104_shade_417_normal.jpg`
- `assets/textures/harvest/flower_scattered_dirt_late_104_shade_417_rough.jpg`
- `assets/textures/harvest/flower_scattered_dirt_rake_208_late_419_normal.jpg`
- `assets/textures/harvest/flower_scattered_dirt_rake_208_late_419_rough.jpg`
- `assets/textures/harvest/flower_scattered_dirt_rake_208_normal.jpg`
- `assets/textures/harvest/flower_scattered_dirt_rake_208_rough.jpg`
- `assets/textures/harvest/forest_floor_02_wet_105_dry_211_normal.jpg`
- `assets/textures/harvest/forest_floor_02_wet_105_dry_211_rough.jpg`
- `assets/textures/harvest/forest_floor_02_wet_105_dry_211_shade_422_normal.jpg`
- `assets/textures/harvest/forest_floor_02_wet_105_dry_211_shade_422_rough.jpg`
- `assets/textures/harvest/forest_floor_02_wet_105_dry_421_normal.jpg`
- `assets/textures/harvest/forest_floor_02_wet_105_dry_421_rough.jpg`
- `assets/textures/harvest/forest_floor_02_wet_105_normal.jpg`
- `assets/textures/harvest/forest_floor_02_wet_105_rough.jpg`
- `assets/textures/harvest/forest_floor_02_wet_210_normal.jpg`
- `assets/textures/harvest/forest_floor_02_wet_210_rake_423_normal.jpg`
- `assets/textures/harvest/forest_floor_02_wet_210_rake_423_rough.jpg`
- `assets/textures/harvest/forest_floor_02_wet_210_rough.jpg`
- `assets/textures/harvest/forest_floor_02_wet_420_normal.jpg`
- `assets/textures/harvest/forest_floor_02_wet_420_rough.jpg`
- `assets/textures/harvest/forest_floor_dry_106_normal.jpg`
- `assets/textures/harvest/forest_floor_dry_106_rake_213_dry_426_normal.jpg`
- `assets/textures/harvest/forest_floor_dry_106_rake_213_dry_426_rough.jpg`
- `assets/textures/harvest/forest_floor_dry_106_rake_213_normal.jpg`
- `assets/textures/harvest/forest_floor_dry_106_rake_213_rough.jpg`
- `assets/textures/harvest/forest_floor_dry_106_rough.jpg`
- `assets/textures/harvest/forest_floor_dry_106_wet_425_normal.jpg`
- `assets/textures/harvest/forest_floor_dry_106_wet_425_rough.jpg`
- `assets/textures/harvest/forest_floor_late_424_normal.jpg`
- `assets/textures/harvest/forest_floor_late_424_rough.jpg`
- `assets/textures/harvest/forest_floor_shade_212_normal.jpg`
- `assets/textures/harvest/forest_floor_shade_212_rough.jpg`
- `assets/textures/harvest/forest_floor_shade_212_shade_427_normal.jpg`
- `assets/textures/harvest/forest_floor_shade_212_shade_427_rough.jpg`
- `assets/textures/harvest/forest_ground_04_late_214_late_429_normal.jpg`
- `assets/textures/harvest/forest_ground_04_late_214_late_429_rough.jpg`
- `assets/textures/harvest/forest_ground_04_late_214_normal.jpg`
- `assets/textures/harvest/forest_ground_04_late_214_rough.jpg`
- `assets/textures/harvest/forest_ground_04_rake_428_normal.jpg`
- `assets/textures/harvest/forest_ground_04_rake_428_rough.jpg`
- `assets/textures/harvest/forest_ground_04_shade_107_normal.jpg`
- `assets/textures/harvest/forest_ground_04_shade_107_rough.jpg`
- `assets/textures/harvest/forest_ground_04_shade_107_wet_215_dry_431_normal.jpg`
- `assets/textures/harvest/forest_ground_04_shade_107_wet_215_dry_431_rough.jpg`
- `assets/textures/harvest/forest_ground_04_shade_107_wet_215_normal.jpg`
- `assets/textures/harvest/forest_ground_04_shade_107_wet_215_rough.jpg`
- `assets/textures/harvest/forest_ground_04_shade_107_wet_430_normal.jpg`
- `assets/textures/harvest/forest_ground_04_shade_107_wet_430_rough.jpg`
- `assets/textures/harvest/forest_ground_05_dry_216_normal.jpg`
- `assets/textures/harvest/forest_ground_05_dry_216_rake_433_normal.jpg`
- `assets/textures/harvest/forest_ground_05_dry_216_rake_433_rough.jpg`
- `assets/textures/harvest/forest_ground_05_dry_216_rough.jpg`
- `assets/textures/harvest/forest_ground_05_rake_108_late_434_normal.jpg`
- `assets/textures/harvest/forest_ground_05_rake_108_late_434_rough.jpg`
- `assets/textures/harvest/forest_ground_05_rake_108_normal.jpg`
- `assets/textures/harvest/forest_ground_05_rake_108_rough.jpg`
- `assets/textures/harvest/forest_ground_05_rake_108_shade_217_normal.jpg`
- `assets/textures/harvest/forest_ground_05_rake_108_shade_217_rough.jpg`
- `assets/textures/harvest/forest_ground_05_rake_108_shade_217_wet_435_normal.jpg`
- `assets/textures/harvest/forest_ground_05_rake_108_shade_217_wet_435_rough.jpg`
- `assets/textures/harvest/forest_ground_05_shade_432_normal.jpg`
- `assets/textures/harvest/forest_ground_05_shade_432_rough.jpg`
- `assets/textures/harvest/forest_leaves_02_dry_436_normal.jpg`
- `assets/textures/harvest/forest_leaves_02_dry_436_rough.jpg`
- `assets/textures/harvest/forest_leaves_02_late_109_late_219_normal.jpg`
- `assets/textures/harvest/forest_leaves_02_late_109_late_219_rake_438_normal.jpg`
- `assets/textures/harvest/forest_leaves_02_late_109_late_219_rake_438_rough.jpg`
- `assets/textures/harvest/forest_leaves_02_late_109_late_219_rough.jpg`
- `assets/textures/harvest/forest_leaves_02_late_109_normal.jpg`
- `assets/textures/harvest/forest_leaves_02_late_109_rough.jpg`
- `assets/textures/harvest/forest_leaves_02_late_109_shade_437_normal.jpg`
- `assets/textures/harvest/forest_leaves_02_late_109_shade_437_rough.jpg`
- `assets/textures/harvest/forest_leaves_02_rake_218_late_439_normal.jpg`
- `assets/textures/harvest/forest_leaves_02_rake_218_late_439_rough.jpg`
- `assets/textures/harvest/forest_leaves_02_rake_218_normal.jpg`
- `assets/textures/harvest/forest_leaves_02_rake_218_rough.jpg`
- `assets/textures/harvest/forest_leaves_03_wet_110_dry_221_normal.jpg`
- `assets/textures/harvest/forest_leaves_03_wet_110_dry_221_rough.jpg`
- `assets/textures/harvest/forest_leaves_03_wet_110_dry_221_shade_442_normal.jpg`
- `assets/textures/harvest/forest_leaves_03_wet_110_dry_221_shade_442_rough.jpg`
- `assets/textures/harvest/forest_leaves_03_wet_110_dry_441_normal.jpg`
- `assets/textures/harvest/forest_leaves_03_wet_110_dry_441_rough.jpg`
- `assets/textures/harvest/forest_leaves_03_wet_110_normal.jpg`
- `assets/textures/harvest/forest_leaves_03_wet_110_rough.jpg`
- `assets/textures/harvest/forest_leaves_03_wet_220_normal.jpg`
- `assets/textures/harvest/forest_leaves_03_wet_220_rake_443_normal.jpg`
- `assets/textures/harvest/forest_leaves_03_wet_220_rake_443_rough.jpg`
- `assets/textures/harvest/forest_leaves_03_wet_220_rough.jpg`
- `assets/textures/harvest/forest_leaves_03_wet_440_normal.jpg`
- `assets/textures/harvest/forest_leaves_03_wet_440_rough.jpg`
- `assets/textures/harvest/forest_leaves_04_dry_111_normal.jpg`
- `assets/textures/harvest/forest_leaves_04_dry_111_rake_223_dry_446_normal.jpg`
- `assets/textures/harvest/forest_leaves_04_dry_111_rake_223_dry_446_rough.jpg`
- `assets/textures/harvest/forest_leaves_04_dry_111_rake_223_normal.jpg`
- `assets/textures/harvest/forest_leaves_04_dry_111_rake_223_rough.jpg`
- `assets/textures/harvest/forest_leaves_04_dry_111_rough.jpg`
- `assets/textures/harvest/forest_leaves_04_dry_111_wet_445_normal.jpg`
- `assets/textures/harvest/forest_leaves_04_dry_111_wet_445_rough.jpg`
- `assets/textures/harvest/forest_leaves_04_late_444_normal.jpg`
- `assets/textures/harvest/forest_leaves_04_late_444_rough.jpg`
- `assets/textures/harvest/forest_leaves_04_shade_222_normal.jpg`
- `assets/textures/harvest/forest_leaves_04_shade_222_rough.jpg`
- `assets/textures/harvest/forest_leaves_04_shade_222_shade_447_normal.jpg`
- `assets/textures/harvest/forest_leaves_04_shade_222_shade_447_rough.jpg`
- `assets/textures/harvest/grass_path_2_late_224_late_449_normal.jpg`
- `assets/textures/harvest/grass_path_2_late_224_late_449_rough.jpg`
- `assets/textures/harvest/grass_path_2_late_224_normal.jpg`
- `assets/textures/harvest/grass_path_2_late_224_rough.jpg`
- `assets/textures/harvest/grass_path_2_rake_448_normal.jpg`
- `assets/textures/harvest/grass_path_2_rake_448_rough.jpg`
- `assets/textures/harvest/grass_path_2_shade_112_normal.jpg`
- `assets/textures/harvest/grass_path_2_shade_112_rough.jpg`
- `assets/textures/harvest/grass_path_2_shade_112_wet_225_dry_451_normal.jpg`
- `assets/textures/harvest/grass_path_2_shade_112_wet_225_dry_451_rough.jpg`
- `assets/textures/harvest/grass_path_2_shade_112_wet_225_normal.jpg`
- `assets/textures/harvest/grass_path_2_shade_112_wet_225_rough.jpg`
- `assets/textures/harvest/grass_path_2_shade_112_wet_450_normal.jpg`
- `assets/textures/harvest/grass_path_2_shade_112_wet_450_rough.jpg`
- `assets/textures/harvest/grass_path_3_dry_226_normal.jpg`
- `assets/textures/harvest/grass_path_3_dry_226_rake_453_normal.jpg`
- `assets/textures/harvest/grass_path_3_dry_226_rake_453_rough.jpg`
- `assets/textures/harvest/grass_path_3_dry_226_rough.jpg`
- `assets/textures/harvest/grass_path_3_rake_113_late_454_normal.jpg`
- `assets/textures/harvest/grass_path_3_rake_113_late_454_rough.jpg`
- `assets/textures/harvest/grass_path_3_rake_113_normal.jpg`
- `assets/textures/harvest/grass_path_3_rake_113_rough.jpg`
- `assets/textures/harvest/grass_path_3_rake_113_shade_227_normal.jpg`
- `assets/textures/harvest/grass_path_3_rake_113_shade_227_rough.jpg`
- `assets/textures/harvest/grass_path_3_rake_113_shade_227_wet_455_normal.jpg`
- `assets/textures/harvest/grass_path_3_rake_113_shade_227_wet_455_rough.jpg`
- `assets/textures/harvest/grass_path_3_shade_452_normal.jpg`
- `assets/textures/harvest/grass_path_3_shade_452_rough.jpg`
- `assets/textures/harvest/gravel_dry_456_normal.jpg`
- `assets/textures/harvest/gravel_dry_456_rough.jpg`
- `assets/textures/harvest/gravel_floor_late_229_normal.jpg`
- `assets/textures/harvest/gravel_floor_late_229_rake_458_normal.jpg`
- `assets/textures/harvest/gravel_floor_late_229_rake_458_rough.jpg`
- `assets/textures/harvest/gravel_floor_late_229_rough.jpg`
- `assets/textures/harvest/gravel_floor_shade_457_normal.jpg`
- `assets/textures/harvest/gravel_floor_shade_457_rough.jpg`
- `assets/textures/harvest/gravel_floor_wet_115_late_459_normal.jpg`
- `assets/textures/harvest/gravel_floor_wet_115_late_459_rough.jpg`
- `assets/textures/harvest/gravel_floor_wet_115_normal.jpg`
- `assets/textures/harvest/gravel_floor_wet_115_rough.jpg`
- `assets/textures/harvest/gravel_floor_wet_115_wet_230_normal.jpg`
- `assets/textures/harvest/gravel_floor_wet_115_wet_230_rough.jpg`
- `assets/textures/harvest/gravel_floor_wet_115_wet_230_wet_460_normal.jpg`
- `assets/textures/harvest/gravel_floor_wet_115_wet_230_wet_460_rough.jpg`
- `assets/textures/harvest/gravel_late_114_dry_231_normal.jpg`
- `assets/textures/harvest/gravel_late_114_dry_231_rough.jpg`
- `assets/textures/harvest/gravel_late_114_dry_231_shade_462_normal.jpg`
- `assets/textures/harvest/gravel_late_114_dry_231_shade_462_rough.jpg`
- `assets/textures/harvest/gravel_late_114_dry_461_normal.jpg`
- `assets/textures/harvest/gravel_late_114_dry_461_rough.jpg`
- `assets/textures/harvest/gravel_late_114_normal.jpg`
- `assets/textures/harvest/gravel_late_114_rough.jpg`
- `assets/textures/harvest/gravel_rake_228_normal.jpg`
- `assets/textures/harvest/gravel_rake_228_rake_463_normal.jpg`
- `assets/textures/harvest/gravel_rake_228_rake_463_rough.jpg`
- `assets/textures/harvest/gravel_rake_228_rough.jpg`
- `assets/textures/harvest/gravel_road_dry_116_normal.jpg`
- `assets/textures/harvest/gravel_road_dry_116_rake_233_dry_466_normal.jpg`
- `assets/textures/harvest/gravel_road_dry_116_rake_233_dry_466_rough.jpg`
- `assets/textures/harvest/gravel_road_dry_116_rake_233_normal.jpg`
- `assets/textures/harvest/gravel_road_dry_116_rake_233_rough.jpg`
- `assets/textures/harvest/gravel_road_dry_116_rough.jpg`
- `assets/textures/harvest/gravel_road_dry_116_wet_465_normal.jpg`
- `assets/textures/harvest/gravel_road_dry_116_wet_465_rough.jpg`
- `assets/textures/harvest/gravel_road_late_464_normal.jpg`
- `assets/textures/harvest/gravel_road_late_464_rough.jpg`
- `assets/textures/harvest/gravel_road_shade_232_normal.jpg`
- `assets/textures/harvest/gravel_road_shade_232_rough.jpg`
- `assets/textures/harvest/gravel_road_shade_232_shade_467_normal.jpg`
- `assets/textures/harvest/gravel_road_shade_232_shade_467_rough.jpg`
- `assets/textures/harvest/gravelly_sand_late_234_late_469_normal.jpg`
- `assets/textures/harvest/gravelly_sand_late_234_late_469_rough.jpg`
- `assets/textures/harvest/gravelly_sand_late_234_normal.jpg`
- `assets/textures/harvest/gravelly_sand_late_234_rough.jpg`
- `assets/textures/harvest/gravelly_sand_rake_468_normal.jpg`
- `assets/textures/harvest/gravelly_sand_rake_468_rough.jpg`
- `assets/textures/harvest/gravelly_sand_shade_117_normal.jpg`
- `assets/textures/harvest/gravelly_sand_shade_117_rough.jpg`
- `assets/textures/harvest/gravelly_sand_shade_117_wet_235_dry_471_normal.jpg`
- `assets/textures/harvest/gravelly_sand_shade_117_wet_235_dry_471_rough.jpg`
- `assets/textures/harvest/gravelly_sand_shade_117_wet_235_normal.jpg`
- `assets/textures/harvest/gravelly_sand_shade_117_wet_235_rough.jpg`
- `assets/textures/harvest/gravelly_sand_shade_117_wet_470_normal.jpg`
- `assets/textures/harvest/gravelly_sand_shade_117_wet_470_rough.jpg`
- `assets/textures/harvest/ground_grey_dry_236_normal.jpg`
- `assets/textures/harvest/ground_grey_dry_236_rake_473_normal.jpg`
- `assets/textures/harvest/ground_grey_dry_236_rake_473_rough.jpg`
- `assets/textures/harvest/ground_grey_dry_236_rough.jpg`
- `assets/textures/harvest/ground_grey_rake_118_late_474_normal.jpg`
- `assets/textures/harvest/ground_grey_rake_118_late_474_rough.jpg`
- `assets/textures/harvest/ground_grey_rake_118_normal.jpg`
- `assets/textures/harvest/ground_grey_rake_118_rough.jpg`
- `assets/textures/harvest/ground_grey_rake_118_shade_237_normal.jpg`
- `assets/textures/harvest/ground_grey_rake_118_shade_237_rough.jpg`
- `assets/textures/harvest/ground_grey_rake_118_shade_237_wet_475_normal.jpg`
- `assets/textures/harvest/ground_grey_rake_118_shade_237_wet_475_rough.jpg`
- `assets/textures/harvest/ground_grey_shade_472_normal.jpg`
- `assets/textures/harvest/ground_grey_shade_472_rough.jpg`
- `assets/textures/harvest/jolcham_oak_bark_dry_476_normal.jpg`
- `assets/textures/harvest/jolcham_oak_bark_dry_476_rough.jpg`
- `assets/textures/harvest/jolcham_oak_bark_late_119_late_239_normal.jpg`
- `assets/textures/harvest/jolcham_oak_bark_late_119_late_239_rake_478_normal.jpg`
- `assets/textures/harvest/jolcham_oak_bark_late_119_late_239_rake_478_rough.jpg`
- `assets/textures/harvest/jolcham_oak_bark_late_119_late_239_rough.jpg`
- `assets/textures/harvest/jolcham_oak_bark_late_119_normal.jpg`
- `assets/textures/harvest/jolcham_oak_bark_late_119_rough.jpg`
- `assets/textures/harvest/jolcham_oak_bark_late_119_shade_477_normal.jpg`
- `assets/textures/harvest/jolcham_oak_bark_late_119_shade_477_rough.jpg`
- `assets/textures/harvest/jolcham_oak_bark_rake_238_late_479_normal.jpg`
- `assets/textures/harvest/jolcham_oak_bark_rake_238_late_479_rough.jpg`
- `assets/textures/harvest/jolcham_oak_bark_rake_238_normal.jpg`
- `assets/textures/harvest/jolcham_oak_bark_rake_238_rough.jpg`
- `assets/textures/harvest/knotted_pine_bark_wet_120_dry_241_normal.jpg`
- `assets/textures/harvest/knotted_pine_bark_wet_120_dry_241_rough.jpg`
- `assets/textures/harvest/knotted_pine_bark_wet_120_dry_241_shade_482_normal.jpg`
- `assets/textures/harvest/knotted_pine_bark_wet_120_dry_241_shade_482_rough.jpg`
- `assets/textures/harvest/knotted_pine_bark_wet_120_dry_481_normal.jpg`
- `assets/textures/harvest/knotted_pine_bark_wet_120_dry_481_rough.jpg`
- `assets/textures/harvest/knotted_pine_bark_wet_120_normal.jpg`
- `assets/textures/harvest/knotted_pine_bark_wet_120_rough.jpg`
- `assets/textures/harvest/knotted_pine_bark_wet_240_normal.jpg`
- `assets/textures/harvest/knotted_pine_bark_wet_240_rake_483_normal.jpg`
- `assets/textures/harvest/knotted_pine_bark_wet_240_rake_483_rough.jpg`
- `assets/textures/harvest/knotted_pine_bark_wet_240_rough.jpg`
- `assets/textures/harvest/knotted_pine_bark_wet_480_normal.jpg`
- `assets/textures/harvest/knotted_pine_bark_wet_480_rough.jpg`
- `assets/textures/harvest/leafy_grass_dry_121_normal.jpg`
- `assets/textures/harvest/leafy_grass_dry_121_rake_243_dry_486_normal.jpg`
- `assets/textures/harvest/leafy_grass_dry_121_rake_243_dry_486_rough.jpg`
- `assets/textures/harvest/leafy_grass_dry_121_rake_243_normal.jpg`
- `assets/textures/harvest/leafy_grass_dry_121_rake_243_rough.jpg`
- `assets/textures/harvest/leafy_grass_dry_121_rough.jpg`
- `assets/textures/harvest/leafy_grass_dry_121_wet_485_normal.jpg`
- `assets/textures/harvest/leafy_grass_dry_121_wet_485_rough.jpg`
- `assets/textures/harvest/leafy_grass_late_484_normal.jpg`
- `assets/textures/harvest/leafy_grass_late_484_rough.jpg`
- `assets/textures/harvest/leafy_grass_shade_242_normal.jpg`
- `assets/textures/harvest/leafy_grass_shade_242_rough.jpg`
- `assets/textures/harvest/leafy_grass_shade_242_shade_487_normal.jpg`
- `assets/textures/harvest/leafy_grass_shade_242_shade_487_rough.jpg`
- `assets/textures/harvest/leather_red_02_late_244_late_489_normal.jpg`
- `assets/textures/harvest/leather_red_02_late_244_late_489_rough.jpg`
- `assets/textures/harvest/leather_red_02_late_244_normal.jpg`
- `assets/textures/harvest/leather_red_02_late_244_rough.jpg`
- `assets/textures/harvest/leather_red_02_rake_488_normal.jpg`
- `assets/textures/harvest/leather_red_02_rake_488_rough.jpg`
- `assets/textures/harvest/leather_red_02_shade_122_normal.jpg`
- `assets/textures/harvest/leather_red_02_shade_122_rough.jpg`
- `assets/textures/harvest/leather_red_02_shade_122_wet_245_dry_491_normal.jpg`
- `assets/textures/harvest/leather_red_02_shade_122_wet_245_dry_491_rough.jpg`
- `assets/textures/harvest/leather_red_02_shade_122_wet_245_normal.jpg`
- `assets/textures/harvest/leather_red_02_shade_122_wet_245_rough.jpg`
- `assets/textures/harvest/leather_red_02_shade_122_wet_490_normal.jpg`
- `assets/textures/harvest/leather_red_02_shade_122_wet_490_rough.jpg`
- `assets/textures/harvest/leather_white_dry_246_normal.jpg`
- `assets/textures/harvest/leather_white_dry_246_rake_493_normal.jpg`
- `assets/textures/harvest/leather_white_dry_246_rake_493_rough.jpg`
- `assets/textures/harvest/leather_white_dry_246_rough.jpg`
- `assets/textures/harvest/leather_white_rake_123_late_494_normal.jpg`
- `assets/textures/harvest/leather_white_rake_123_late_494_rough.jpg`
- `assets/textures/harvest/leather_white_rake_123_normal.jpg`
- `assets/textures/harvest/leather_white_rake_123_rough.jpg`
- `assets/textures/harvest/leather_white_rake_123_shade_247_normal.jpg`
- `assets/textures/harvest/leather_white_rake_123_shade_247_rough.jpg`
- `assets/textures/harvest/leather_white_rake_123_shade_247_wet_495_normal.jpg`
- `assets/textures/harvest/leather_white_rake_123_shade_247_wet_495_rough.jpg`
- `assets/textures/harvest/leather_white_shade_492_normal.jpg`
- `assets/textures/harvest/leather_white_shade_492_rough.jpg`
- `assets/textures/harvest/leaves_forest_ground_dry_496_normal.jpg`
- `assets/textures/harvest/leaves_forest_ground_dry_496_rough.jpg`
- `assets/textures/harvest/leaves_forest_ground_late_124_late_249_normal.jpg`
- `assets/textures/harvest/leaves_forest_ground_late_124_late_249_rake_498_normal.jpg`
- `assets/textures/harvest/leaves_forest_ground_late_124_late_249_rake_498_rough.jpg`
- `assets/textures/harvest/leaves_forest_ground_late_124_late_249_rough.jpg`
- `assets/textures/harvest/leaves_forest_ground_late_124_normal.jpg`
- `assets/textures/harvest/leaves_forest_ground_late_124_rough.jpg`
- `assets/textures/harvest/leaves_forest_ground_late_124_shade_497_normal.jpg`
- `assets/textures/harvest/leaves_forest_ground_late_124_shade_497_rough.jpg`
- `assets/textures/harvest/leaves_forest_ground_rake_248_late_499_normal.jpg`
- `assets/textures/harvest/leaves_forest_ground_rake_248_late_499_rough.jpg`
- `assets/textures/harvest/leaves_forest_ground_rake_248_normal.jpg`
- `assets/textures/harvest/leaves_forest_ground_rake_248_rough.jpg`
- `assets/textures/harvest/metal_plate_02_wet_125_dry_251_normal.jpg`
- `assets/textures/harvest/metal_plate_02_wet_125_dry_251_rough.jpg`
- `assets/textures/harvest/metal_plate_02_wet_125_dry_251_shade_502_normal.jpg`
- `assets/textures/harvest/metal_plate_02_wet_125_dry_251_shade_502_rough.jpg`
- `assets/textures/harvest/metal_plate_02_wet_125_dry_501_normal.jpg`
- `assets/textures/harvest/metal_plate_02_wet_125_dry_501_rough.jpg`
- `assets/textures/harvest/metal_plate_02_wet_125_normal.jpg`
- `assets/textures/harvest/metal_plate_02_wet_125_rough.jpg`
- `assets/textures/harvest/metal_plate_02_wet_250_normal.jpg`
- `assets/textures/harvest/metal_plate_02_wet_250_rake_503_normal.jpg`
- `assets/textures/harvest/metal_plate_02_wet_250_rake_503_rough.jpg`
- `assets/textures/harvest/metal_plate_02_wet_250_rough.jpg`
- `assets/textures/harvest/metal_plate_02_wet_500_normal.jpg`
- `assets/textures/harvest/metal_plate_02_wet_500_rough.jpg`
- `assets/textures/harvest/metal_plate_03_dry_126_normal.jpg`
- `assets/textures/harvest/metal_plate_03_dry_126_rake_253_dry_506_normal.jpg`
- `assets/textures/harvest/metal_plate_03_dry_126_rake_253_dry_506_rough.jpg`
- `assets/textures/harvest/metal_plate_03_dry_126_rake_253_normal.jpg`
- `assets/textures/harvest/metal_plate_03_dry_126_rake_253_rough.jpg`
- `assets/textures/harvest/metal_plate_03_dry_126_rough.jpg`
- `assets/textures/harvest/metal_plate_03_dry_126_wet_505_normal.jpg`
- `assets/textures/harvest/metal_plate_03_dry_126_wet_505_rough.jpg`
- `assets/textures/harvest/metal_plate_03_late_504_normal.jpg`
- `assets/textures/harvest/metal_plate_03_late_504_rough.jpg`
- `assets/textures/harvest/metal_plate_03_shade_252_normal.jpg`
- `assets/textures/harvest/metal_plate_03_shade_252_rough.jpg`
- `assets/textures/harvest/metal_plate_03_shade_252_shade_507_normal.jpg`
- `assets/textures/harvest/metal_plate_03_shade_252_shade_507_rough.jpg`
- `assets/textures/harvest/metal_plate_late_254_late_509_normal.jpg`
- `assets/textures/harvest/metal_plate_late_254_late_509_rough.jpg`
- `assets/textures/harvest/metal_plate_late_254_normal.jpg`
- `assets/textures/harvest/metal_plate_late_254_rough.jpg`
- `assets/textures/harvest/metal_plate_rake_508_normal.jpg`
- `assets/textures/harvest/metal_plate_rake_508_rough.jpg`
- `assets/textures/harvest/metal_plate_shade_127_normal.jpg`
- `assets/textures/harvest/metal_plate_shade_127_rough.jpg`
- `assets/textures/harvest/metal_plate_shade_127_wet_255_dry_511_normal.jpg`
- `assets/textures/harvest/metal_plate_shade_127_wet_255_dry_511_rough.jpg`
- `assets/textures/harvest/metal_plate_shade_127_wet_255_normal.jpg`
- `assets/textures/harvest/metal_plate_shade_127_wet_255_rough.jpg`
- `assets/textures/harvest/metal_plate_shade_127_wet_510_normal.jpg`
- `assets/textures/harvest/metal_plate_shade_127_wet_510_rough.jpg`
- `assets/textures/harvest/muddy_tracks_dry_256_normal.jpg`
- `assets/textures/harvest/muddy_tracks_dry_256_rake_513_normal.jpg`
- `assets/textures/harvest/muddy_tracks_dry_256_rake_513_rough.jpg`
- `assets/textures/harvest/muddy_tracks_dry_256_rough.jpg`
- `assets/textures/harvest/muddy_tracks_rake_128_late_514_normal.jpg`
- `assets/textures/harvest/muddy_tracks_rake_128_late_514_rough.jpg`
- `assets/textures/harvest/muddy_tracks_rake_128_normal.jpg`
- `assets/textures/harvest/muddy_tracks_rake_128_rough.jpg`
- `assets/textures/harvest/muddy_tracks_rake_128_shade_257_normal.jpg`
- `assets/textures/harvest/muddy_tracks_rake_128_shade_257_rough.jpg`
- `assets/textures/harvest/muddy_tracks_rake_128_shade_257_wet_515_normal.jpg`
- `assets/textures/harvest/muddy_tracks_rake_128_shade_257_wet_515_rough.jpg`
- `assets/textures/harvest/muddy_tracks_shade_512_normal.jpg`
- `assets/textures/harvest/muddy_tracks_shade_512_rough.jpg`
- `assets/textures/harvest/oak_wood_planks_dry_516_normal.jpg`
- `assets/textures/harvest/oak_wood_planks_dry_516_rough.jpg`
- `assets/textures/harvest/oak_wood_planks_late_129_late_259_normal.jpg`
- `assets/textures/harvest/oak_wood_planks_late_129_late_259_rake_518_normal.jpg`
- `assets/textures/harvest/oak_wood_planks_late_129_late_259_rake_518_rough.jpg`
- `assets/textures/harvest/oak_wood_planks_late_129_late_259_rough.jpg`
- `assets/textures/harvest/oak_wood_planks_late_129_normal.jpg`
- `assets/textures/harvest/oak_wood_planks_late_129_rough.jpg`
- `assets/textures/harvest/oak_wood_planks_late_129_shade_517_normal.jpg`
- `assets/textures/harvest/oak_wood_planks_late_129_shade_517_rough.jpg`
- `assets/textures/harvest/oak_wood_planks_rake_258_late_519_normal.jpg`
- `assets/textures/harvest/oak_wood_planks_rake_258_late_519_rough.jpg`
- `assets/textures/harvest/oak_wood_planks_rake_258_normal.jpg`
- `assets/textures/harvest/oak_wood_planks_rake_258_rough.jpg`
- `assets/textures/harvest/park_dirt_wet_130_dry_261_normal.jpg`
- `assets/textures/harvest/park_dirt_wet_130_dry_261_rough.jpg`
- `assets/textures/harvest/park_dirt_wet_130_dry_261_shade_522_normal.jpg`
- `assets/textures/harvest/park_dirt_wet_130_dry_261_shade_522_rough.jpg`
- `assets/textures/harvest/park_dirt_wet_130_dry_521_normal.jpg`
- `assets/textures/harvest/park_dirt_wet_130_dry_521_rough.jpg`
- `assets/textures/harvest/park_dirt_wet_130_normal.jpg`
- `assets/textures/harvest/park_dirt_wet_130_rough.jpg`
- `assets/textures/harvest/park_dirt_wet_260_normal.jpg`
- `assets/textures/harvest/park_dirt_wet_260_rake_523_normal.jpg`
- `assets/textures/harvest/park_dirt_wet_260_rake_523_rough.jpg`
- `assets/textures/harvest/park_dirt_wet_260_rough.jpg`
- `assets/textures/harvest/park_dirt_wet_520_normal.jpg`
- `assets/textures/harvest/park_dirt_wet_520_rough.jpg`
- `assets/textures/harvest/park_sand_dry_131_normal.jpg`
- `assets/textures/harvest/park_sand_dry_131_rake_263_dry_526_normal.jpg`
- `assets/textures/harvest/park_sand_dry_131_rake_263_dry_526_rough.jpg`
- `assets/textures/harvest/park_sand_dry_131_rake_263_normal.jpg`
- `assets/textures/harvest/park_sand_dry_131_rake_263_rough.jpg`
- `assets/textures/harvest/park_sand_dry_131_rough.jpg`
- `assets/textures/harvest/park_sand_dry_131_wet_525_normal.jpg`
- `assets/textures/harvest/park_sand_dry_131_wet_525_rough.jpg`
- `assets/textures/harvest/park_sand_late_524_normal.jpg`
- `assets/textures/harvest/park_sand_late_524_rough.jpg`
- `assets/textures/harvest/park_sand_shade_262_normal.jpg`
- `assets/textures/harvest/park_sand_shade_262_rough.jpg`
- `assets/textures/harvest/park_sand_shade_262_shade_527_normal.jpg`
- `assets/textures/harvest/park_sand_shade_262_shade_527_rough.jpg`
- `assets/textures/harvest/pebbles_late_264_late_529_normal.jpg`
- `assets/textures/harvest/pebbles_late_264_late_529_rough.jpg`
- `assets/textures/harvest/pebbles_late_264_normal.jpg`
- `assets/textures/harvest/pebbles_late_264_rough.jpg`
- `assets/textures/harvest/pebbles_rake_528_normal.jpg`
- `assets/textures/harvest/pebbles_rake_528_rough.jpg`
- `assets/textures/harvest/pebbles_shade_132_normal.jpg`
- `assets/textures/harvest/pebbles_shade_132_rough.jpg`
- `assets/textures/harvest/pebbles_shade_132_wet_265_dry_531_normal.jpg`
- `assets/textures/harvest/pebbles_shade_132_wet_265_dry_531_rough.jpg`
- `assets/textures/harvest/pebbles_shade_132_wet_265_normal.jpg`
- `assets/textures/harvest/pebbles_shade_132_wet_265_rough.jpg`
- `assets/textures/harvest/pebbles_shade_132_wet_530_normal.jpg`
- `assets/textures/harvest/pebbles_shade_132_wet_530_rough.jpg`
- `assets/textures/harvest/pine_bark_dry_266_normal.jpg`
- `assets/textures/harvest/pine_bark_dry_266_rake_533_normal.jpg`
- `assets/textures/harvest/pine_bark_dry_266_rake_533_rough.jpg`
- `assets/textures/harvest/pine_bark_dry_266_rough.jpg`
- `assets/textures/harvest/pine_bark_rake_133_late_534_normal.jpg`
- `assets/textures/harvest/pine_bark_rake_133_late_534_rough.jpg`
- `assets/textures/harvest/pine_bark_rake_133_normal.jpg`
- `assets/textures/harvest/pine_bark_rake_133_rough.jpg`
- `assets/textures/harvest/pine_bark_rake_133_shade_267_normal.jpg`
- `assets/textures/harvest/pine_bark_rake_133_shade_267_rough.jpg`
- `assets/textures/harvest/pine_bark_rake_133_shade_267_wet_535_normal.jpg`
- `assets/textures/harvest/pine_bark_rake_133_shade_267_wet_535_rough.jpg`
- `assets/textures/harvest/pine_bark_shade_532_normal.jpg`
- `assets/textures/harvest/pine_bark_shade_532_rough.jpg`
- `assets/textures/harvest/playground_sand_dry_536_normal.jpg`
- `assets/textures/harvest/playground_sand_dry_536_rough.jpg`
- `assets/textures/harvest/playground_sand_late_134_late_269_normal.jpg`
- `assets/textures/harvest/playground_sand_late_134_late_269_rake_538_normal.jpg`
- `assets/textures/harvest/playground_sand_late_134_late_269_rake_538_rough.jpg`
- `assets/textures/harvest/playground_sand_late_134_late_269_rough.jpg`
- `assets/textures/harvest/playground_sand_late_134_normal.jpg`
- `assets/textures/harvest/playground_sand_late_134_rough.jpg`
- `assets/textures/harvest/playground_sand_late_134_shade_537_normal.jpg`
- `assets/textures/harvest/playground_sand_late_134_shade_537_rough.jpg`
- `assets/textures/harvest/playground_sand_rake_268_late_539_normal.jpg`
- `assets/textures/harvest/playground_sand_rake_268_late_539_rough.jpg`
- `assets/textures/harvest/playground_sand_rake_268_normal.jpg`
- `assets/textures/harvest/playground_sand_rake_268_rough.jpg`
- `assets/textures/harvest/poly_wool_herringbone_wet_135_dry_271_normal.jpg`
- `assets/textures/harvest/poly_wool_herringbone_wet_135_dry_271_rough.jpg`
- `assets/textures/harvest/poly_wool_herringbone_wet_135_dry_271_shade_542_normal.jpg`
- `assets/textures/harvest/poly_wool_herringbone_wet_135_dry_271_shade_542_rough.jpg`
- `assets/textures/harvest/poly_wool_herringbone_wet_135_dry_541_normal.jpg`
- `assets/textures/harvest/poly_wool_herringbone_wet_135_dry_541_rough.jpg`
- `assets/textures/harvest/poly_wool_herringbone_wet_135_normal.jpg`
- `assets/textures/harvest/poly_wool_herringbone_wet_135_rough.jpg`
- `assets/textures/harvest/poly_wool_herringbone_wet_270_normal.jpg`
- `assets/textures/harvest/poly_wool_herringbone_wet_270_rake_543_normal.jpg`
- `assets/textures/harvest/poly_wool_herringbone_wet_270_rake_543_rough.jpg`
- `assets/textures/harvest/poly_wool_herringbone_wet_270_rough.jpg`
- `assets/textures/harvest/poly_wool_herringbone_wet_540_normal.jpg`
- `assets/textures/harvest/poly_wool_herringbone_wet_540_rough.jpg`
- `assets/textures/harvest/proc/apron_dirt_albedo.jpg`
- `assets/textures/harvest/proc/apron_dirt_normal.jpg`
- `assets/textures/harvest/proc/apron_dirt_rough.jpg`
- `assets/textures/harvest/proc/board_chalk_albedo.jpg`
- `assets/textures/harvest/proc/board_chalk_normal.jpg`
- `assets/textures/harvest/proc/board_chalk_rough.jpg`
- `assets/textures/harvest/proc/board_hunter_albedo.jpg`
- `assets/textures/harvest/proc/board_hunter_normal.jpg`
- `assets/textures/harvest/proc/board_hunter_rough.jpg`
- `assets/textures/harvest/proc/board_white_albedo.jpg`
- `assets/textures/harvest/proc/board_white_normal.jpg`
- `assets/textures/harvest/proc/board_white_rough.jpg`
- `assets/textures/harvest/proc/boot_black_albedo.jpg`
- `assets/textures/harvest/proc/boot_black_normal.jpg`
- `assets/textures/harvest/proc/boot_black_rough.jpg`
- `assets/textures/harvest/proc/brush_box_albedo.jpg`
- `assets/textures/harvest/proc/brush_box_normal.jpg`
- `assets/textures/harvest/proc/brush_box_rough.jpg`
- `assets/textures/harvest/proc/brush_dry_albedo.jpg`
- `assets/textures/harvest/proc/brush_dry_normal.jpg`
- `assets/textures/harvest/proc/brush_dry_rough.jpg`
- `assets/textures/harvest/proc/clover_patch_albedo.jpg`
- `assets/textures/harvest/proc/clover_patch_normal.jpg`
- `assets/textures/harvest/proc/clover_patch_rough.jpg`
- `assets/textures/harvest/proc/cooler_navy_albedo.jpg`
- `assets/textures/harvest/proc/cooler_navy_normal.jpg`
- `assets/textures/harvest/proc/cooler_navy_rough.jpg`
- `assets/textures/harvest/proc/duff_dry_albedo.jpg`
- `assets/textures/harvest/proc/duff_dry_normal.jpg`
- `assets/textures/harvest/proc/duff_dry_rough.jpg`
- `assets/textures/harvest/proc/fescue_late_albedo.jpg`
- `assets/textures/harvest/proc/fescue_late_normal.jpg`
- `assets/textures/harvest/proc/fescue_late_rough.jpg`
- `assets/textures/harvest/proc/flower_bloom_soil_albedo.jpg`
- `assets/textures/harvest/proc/flower_bloom_soil_normal.jpg`
- `assets/textures/harvest/proc/flower_bloom_soil_rough.jpg`
- `assets/textures/harvest/proc/flower_box_soil_albedo.jpg`
- `assets/textures/harvest/proc/flower_box_soil_normal.jpg`
- `assets/textures/harvest/proc/flower_box_soil_rough.jpg`
- `assets/textures/harvest/proc/flower_soil_albedo.jpg`
- `assets/textures/harvest/proc/flower_soil_normal.jpg`
- `assets/textures/harvest/proc/flower_soil_rough.jpg`
- `assets/textures/harvest/proc/grass_clover_albedo.jpg`
- `assets/textures/harvest/proc/grass_clover_normal.jpg`
- `assets/textures/harvest/proc/grass_clover_rough.jpg`
- `assets/textures/harvest/proc/grass_dry_patch_albedo.jpg`
- `assets/textures/harvest/proc/grass_dry_patch_normal.jpg`
- `assets/textures/harvest/proc/grass_dry_patch_rough.jpg`
- `assets/textures/harvest/proc/grass_late_rust_albedo.jpg`
- `assets/textures/harvest/proc/grass_late_rust_normal.jpg`
- `assets/textures/harvest/proc/grass_late_rust_rough.jpg`
- `assets/textures/harvest/proc/grass_morning_albedo.jpg`
- `assets/textures/harvest/proc/grass_morning_normal.jpg`
- `assets/textures/harvest/proc/grass_morning_rough.jpg`
- `assets/textures/harvest/proc/grass_piedmont_albedo.jpg`
- `assets/textures/harvest/proc/grass_piedmont_normal.jpg`
- `assets/textures/harvest/proc/grass_piedmont_rough.jpg`
- `assets/textures/harvest/proc/grass_ring_edge_albedo.jpg`
- `assets/textures/harvest/proc/grass_ring_edge_normal.jpg`
- `assets/textures/harvest/proc/grass_ring_edge_rough.jpg`
- `assets/textures/harvest/proc/grass_shade_albedo.jpg`
- `assets/textures/harvest/proc/grass_shade_normal.jpg`
- `assets/textures/harvest/proc/grass_shade_rough.jpg`
- `assets/textures/harvest/proc/gravel_barn_yard_albedo.jpg`
- `assets/textures/harvest/proc/gravel_barn_yard_normal.jpg`
- `assets/textures/harvest/proc/gravel_barn_yard_rough.jpg`
- `assets/textures/harvest/proc/gravel_drive_albedo.jpg`
- `assets/textures/harvest/proc/gravel_drive_normal.jpg`
- `assets/textures/harvest/proc/gravel_drive_rough.jpg`
- `assets/textures/harvest/proc/gravel_wet_albedo.jpg`
- `assets/textures/harvest/proc/gravel_wet_normal.jpg`
- `assets/textures/harvest/proc/gravel_wet_rough.jpg`
- `assets/textures/harvest/proc/hay_bale_albedo.jpg`
- `assets/textures/harvest/proc/hay_bale_normal.jpg`
- `assets/textures/harvest/proc/hay_bale_rough.jpg`
- `assets/textures/harvest/proc/hay_dust_albedo.jpg`
- `assets/textures/harvest/proc/hay_dust_normal.jpg`
- `assets/textures/harvest/proc/hay_dust_rough.jpg`
- `assets/textures/harvest/proc/hoof_cut_sand_albedo.jpg`
- `assets/textures/harvest/proc/hoof_cut_sand_normal.jpg`
- `assets/textures/harvest/proc/hoof_cut_sand_rough.jpg`
- `assets/textures/harvest/proc/hoof_wet_albedo.jpg`
- `assets/textures/harvest/proc/hoof_wet_normal.jpg`
- `assets/textures/harvest/proc/hoof_wet_rough.jpg`
- `assets/textures/harvest/proc/hydrant_metal_albedo.jpg`
- `assets/textures/harvest/proc/hydrant_metal_normal.jpg`
- `assets/textures/harvest/proc/hydrant_metal_rough.jpg`
- `assets/textures/harvest/proc/iron_polish_albedo.jpg`
- `assets/textures/harvest/proc/iron_polish_normal.jpg`
- `assets/textures/harvest/proc/iron_polish_rough.jpg`
- `assets/textures/harvest/proc/kick_barn_albedo.jpg`
- `assets/textures/harvest/proc/kick_barn_normal.jpg`
- `assets/textures/harvest/proc/kick_barn_rough.jpg`
- `assets/textures/harvest/proc/kick_dark_albedo.jpg`
- `assets/textures/harvest/proc/kick_dark_normal.jpg`
- `assets/textures/harvest/proc/kick_dark_rough.jpg`
- `assets/textures/harvest/proc/kick_scuff_albedo.jpg`
- `assets/textures/harvest/proc/kick_scuff_normal.jpg`
- `assets/textures/harvest/proc/kick_scuff_rough.jpg`
- `assets/textures/harvest/proc/leather_bridle_albedo.jpg`
- `assets/textures/harvest/proc/leather_bridle_normal.jpg`
- `assets/textures/harvest/proc/leather_bridle_rough.jpg`
- `assets/textures/harvest/proc/leather_reins_albedo.jpg`
- `assets/textures/harvest/proc/leather_reins_normal.jpg`
- `assets/textures/harvest/proc/leather_reins_rough.jpg`
- `assets/textures/harvest/proc/leather_sweat_albedo.jpg`
- `assets/textures/harvest/proc/leather_sweat_normal.jpg`
- `assets/textures/harvest/proc/leather_sweat_rough.jpg`
- `assets/textures/harvest/proc/natural_rail_albedo.jpg`
- `assets/textures/harvest/proc/natural_rail_normal.jpg`
- `assets/textures/harvest/proc/natural_rail_rough.jpg`
- `assets/textures/harvest/proc/navy_pole_albedo.jpg`
- `assets/textures/harvest/proc/navy_pole_normal.jpg`
- `assets/textures/harvest/proc/navy_pole_rough.jpg`
- `assets/textures/harvest/proc/oak_fourboard_albedo.jpg`
- `assets/textures/harvest/proc/oak_fourboard_normal.jpg`
- `assets/textures/harvest/proc/oak_fourboard_rough.jpg`
- `assets/textures/harvest/proc/oak_leaf_late_albedo.jpg`
- `assets/textures/harvest/proc/oak_leaf_late_normal.jpg`
- `assets/textures/harvest/proc/oak_leaf_late_rough.jpg`
- `assets/textures/harvest/proc/oak_rust_albedo.jpg`
- `assets/textures/harvest/proc/oak_rust_normal.jpg`
- `assets/textures/harvest/proc/oak_rust_rough.jpg`
- `assets/textures/harvest/proc/pad_quilt_albedo.jpg`
- `assets/textures/harvest/proc/pad_quilt_normal.jpg`
- `assets/textures/harvest/proc/pad_quilt_rough.jpg`
- `assets/textures/harvest/proc/pine_bark_wet_albedo.jpg`
- `assets/textures/harvest/proc/pine_bark_wet_normal.jpg`
- `assets/textures/harvest/proc/pine_bark_wet_rough.jpg`
- `assets/textures/harvest/proc/pine_duff_wet_albedo.jpg`
- `assets/textures/harvest/proc/pine_duff_wet_normal.jpg`
- `assets/textures/harvest/proc/pine_duff_wet_rough.jpg`
- `assets/textures/harvest/proc/pine_needle_shade_albedo.jpg`
- `assets/textures/harvest/proc/pine_needle_shade_normal.jpg`
- `assets/textures/harvest/proc/pine_needle_shade_rough.jpg`
- `assets/textures/harvest/proc/pine_needles_albedo.jpg`
- `assets/textures/harvest/proc/pine_needles_normal.jpg`
- `assets/textures/harvest/proc/pine_needles_rough.jpg`
- `assets/textures/harvest/proc/plank_gate_albedo.jpg`
- `assets/textures/harvest/proc/plank_gate_normal.jpg`
- `assets/textures/harvest/proc/plank_gate_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_000_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_000_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_000_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_001_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_001_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_001_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_002_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_002_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_002_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_003_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_003_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_003_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_004_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_004_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_004_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_005_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_005_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_005_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_006_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_006_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_006_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_007_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_007_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_007_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_008_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_008_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_008_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_009_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_009_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_009_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_010_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_010_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_010_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_011_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_011_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_011_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_012_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_012_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_012_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_013_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_013_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_013_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_014_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_014_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_014_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_015_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_015_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_015_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_016_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_016_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_016_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_017_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_017_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_017_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_018_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_018_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_018_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_019_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_019_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_019_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_020_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_020_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_020_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_021_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_021_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_021_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_022_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_022_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_022_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_023_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_023_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_023_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_024_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_024_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_024_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_025_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_025_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_025_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_026_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_026_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_026_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_027_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_027_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_027_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_028_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_028_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_028_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_029_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_029_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_029_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_030_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_030_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_030_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_031_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_031_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_031_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_032_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_032_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_032_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_033_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_033_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_033_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_034_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_034_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_034_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_035_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_035_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_035_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_036_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_036_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_036_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_037_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_037_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_037_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_038_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_038_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_038_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_039_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_039_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_039_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_040_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_040_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_040_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_041_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_041_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_041_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_042_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_042_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_042_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_043_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_043_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_043_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_044_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_044_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_044_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_045_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_045_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_045_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_046_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_046_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_046_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_047_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_047_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_047_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_048_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_048_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_048_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_049_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_049_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_049_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_050_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_050_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_050_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_051_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_051_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_051_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_052_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_052_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_052_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_053_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_053_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_053_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_054_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_054_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_054_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_055_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_055_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_055_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_056_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_056_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_056_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_057_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_057_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_057_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_058_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_058_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_058_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_059_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_059_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_059_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_060_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_060_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_060_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_061_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_061_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_061_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_062_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_062_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_062_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_063_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_063_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_063_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_064_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_064_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_064_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_065_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_065_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_065_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_066_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_066_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_066_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_067_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_067_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_067_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_068_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_068_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_068_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_069_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_069_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_069_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_070_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_070_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_070_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_071_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_071_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_071_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_072_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_072_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_072_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_073_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_073_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_073_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_074_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_074_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_074_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_075_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_075_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_075_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_076_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_076_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_076_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_077_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_077_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_077_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_078_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_078_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_078_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_079_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_079_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_079_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_080_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_080_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_080_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_081_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_081_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_081_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_082_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_082_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_082_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_083_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_083_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_083_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_084_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_084_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_084_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_085_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_085_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_085_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_086_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_086_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_086_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_087_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_087_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_087_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_088_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_088_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_088_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_089_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_089_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_089_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_090_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_090_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_090_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_091_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_091_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_091_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_092_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_092_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_092_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_093_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_093_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_093_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_094_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_094_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_094_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_095_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_095_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_095_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_096_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_096_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_096_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_097_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_097_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_097_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_098_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_098_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_098_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_099_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_099_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_099_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_100_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_100_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_100_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_101_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_101_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_101_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_102_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_102_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_102_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_103_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_103_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_103_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_104_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_104_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_104_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_105_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_105_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_105_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_106_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_106_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_106_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_107_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_107_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_107_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_108_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_108_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_108_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_109_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_109_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_109_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_110_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_110_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_110_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_111_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_111_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_111_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_112_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_112_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_112_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_113_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_113_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_113_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_114_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_114_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_114_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_115_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_115_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_115_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_116_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_116_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_116_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_117_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_117_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_117_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_118_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_118_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_118_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_119_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_119_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_119_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_120_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_120_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_120_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_121_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_121_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_121_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_122_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_122_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_122_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_123_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_123_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_123_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_124_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_124_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_124_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_125_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_125_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_125_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_126_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_126_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_126_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_127_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_127_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_127_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_128_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_128_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_128_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_129_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_129_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_129_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_130_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_130_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_130_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_131_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_131_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_131_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_132_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_132_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_132_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_133_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_133_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_133_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_134_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_134_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_134_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_135_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_135_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_135_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_136_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_136_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_136_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_137_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_137_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_137_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_138_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_138_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_138_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_139_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_139_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_139_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_140_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_140_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_140_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_141_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_141_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_141_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_142_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_142_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_142_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_143_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_143_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_143_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_144_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_144_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_144_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_145_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_145_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_145_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_146_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_146_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_146_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_147_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_147_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_147_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_148_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_148_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_148_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_149_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_149_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_149_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_150_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_150_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_150_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_151_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_151_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_151_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_152_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_152_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_152_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_153_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_153_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_153_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_154_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_154_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_154_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_155_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_155_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_155_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_156_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_156_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_156_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_157_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_157_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_157_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_158_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_158_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_158_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_159_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_159_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_159_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_160_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_160_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_160_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_161_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_161_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_161_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_162_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_162_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_162_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_163_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_163_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_163_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_164_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_164_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_164_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_165_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_165_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_165_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_166_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_166_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_166_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_167_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_167_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_167_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_168_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_168_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_168_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_169_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_169_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_169_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_170_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_170_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_170_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_171_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_171_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_171_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_172_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_172_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_172_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_173_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_173_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_173_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_174_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_174_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_174_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_175_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_175_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_175_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_176_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_176_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_176_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_177_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_177_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_177_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_178_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_178_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_178_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_179_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_179_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_179_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_180_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_180_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_180_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_181_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_181_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_181_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_182_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_182_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_182_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_183_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_183_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_183_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_184_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_184_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_184_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_185_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_185_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_185_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_186_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_186_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_186_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_187_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_187_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_187_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_188_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_188_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_188_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_189_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_189_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_189_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_190_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_190_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_190_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_191_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_191_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_191_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_192_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_192_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_192_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_193_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_193_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_193_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_194_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_194_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_194_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_195_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_195_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_195_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_196_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_196_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_196_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_197_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_197_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_197_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_198_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_198_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_198_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_199_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_199_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_199_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_200_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_200_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_200_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_201_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_201_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_201_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_202_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_202_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_202_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_203_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_203_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_203_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_204_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_204_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_204_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_205_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_205_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_205_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_206_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_206_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_206_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_207_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_207_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_207_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_208_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_208_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_208_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_209_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_209_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_209_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_210_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_210_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_210_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_211_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_211_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_211_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_212_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_212_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_212_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_213_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_213_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_213_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_214_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_214_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_214_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_215_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_215_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_215_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_216_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_216_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_216_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_217_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_217_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_217_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_218_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_218_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_218_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_219_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_219_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_219_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_220_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_220_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_220_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_221_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_221_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_221_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_222_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_222_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_222_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_223_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_223_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_223_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_224_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_224_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_224_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_225_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_225_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_225_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_226_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_226_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_226_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_227_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_227_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_227_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_228_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_228_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_228_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_229_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_229_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_229_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_230_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_230_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_230_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_231_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_231_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_231_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_232_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_232_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_232_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_233_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_233_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_233_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_234_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_234_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_234_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_235_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_235_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_235_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_236_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_236_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_236_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_237_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_237_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_237_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_238_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_238_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_238_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_239_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_239_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_239_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_240_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_240_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_240_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_241_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_241_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_241_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_242_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_242_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_242_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_243_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_243_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_243_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_244_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_244_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_244_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_245_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_245_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_245_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_246_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_246_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_246_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_247_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_247_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_247_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_248_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_248_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_248_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_249_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_249_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_249_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_250_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_250_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_250_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_251_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_251_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_251_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_252_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_252_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_252_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_253_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_253_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_253_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_254_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_254_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_254_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_255_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_255_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_255_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_256_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_256_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_256_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_257_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_257_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_257_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_258_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_258_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_258_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_259_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_259_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_259_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_260_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_260_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_260_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_261_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_261_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_261_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_262_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_262_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_262_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_263_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_263_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_263_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_264_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_264_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_264_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_265_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_265_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_265_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_266_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_266_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_266_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_267_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_267_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_267_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_268_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_268_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_268_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_269_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_269_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_269_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_270_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_270_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_270_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_271_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_271_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_271_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_272_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_272_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_272_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_273_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_273_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_273_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_274_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_274_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_274_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_275_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_275_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_275_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_276_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_276_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_276_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_277_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_277_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_277_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_278_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_278_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_278_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_279_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_279_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_279_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_280_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_280_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_280_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_281_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_281_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_281_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_282_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_282_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_282_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_283_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_283_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_283_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_284_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_284_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_284_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_285_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_285_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_285_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_286_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_286_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_286_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_287_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_287_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_287_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_288_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_288_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_288_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_289_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_289_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_289_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_290_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_290_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_290_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_291_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_291_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_291_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_292_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_292_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_292_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_293_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_293_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_293_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_294_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_294_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_294_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_295_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_295_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_295_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_296_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_296_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_296_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_297_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_297_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_297_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_298_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_298_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_298_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_299_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_299_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_299_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_300_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_300_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_300_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_301_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_301_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_301_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_302_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_302_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_302_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_303_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_303_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_303_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_304_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_304_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_304_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_305_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_305_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_305_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_306_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_306_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_306_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_307_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_307_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_307_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_308_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_308_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_308_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_309_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_309_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_309_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_310_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_310_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_310_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_311_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_311_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_311_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_312_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_312_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_312_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_313_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_313_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_313_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_314_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_314_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_314_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_315_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_315_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_315_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_316_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_316_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_316_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_317_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_317_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_317_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_318_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_318_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_318_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_319_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_319_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_319_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_320_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_320_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_320_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_321_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_321_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_321_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_322_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_322_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_322_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_323_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_323_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_323_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_324_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_324_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_324_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_325_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_325_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_325_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_326_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_326_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_326_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_327_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_327_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_327_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_328_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_328_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_328_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_329_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_329_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_329_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_330_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_330_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_330_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_331_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_331_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_331_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_332_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_332_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_332_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_333_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_333_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_333_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_334_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_334_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_334_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_335_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_335_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_335_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_336_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_336_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_336_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_337_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_337_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_337_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_338_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_338_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_338_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_339_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_339_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_339_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_340_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_340_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_340_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_341_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_341_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_341_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_342_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_342_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_342_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_343_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_343_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_343_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_344_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_344_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_344_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_345_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_345_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_345_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_346_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_346_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_346_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_347_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_347_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_347_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_348_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_348_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_348_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_349_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_349_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_349_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_350_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_350_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_350_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_351_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_351_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_351_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_352_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_352_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_352_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_353_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_353_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_353_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_354_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_354_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_354_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_355_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_355_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_355_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_356_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_356_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_356_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_357_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_357_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_357_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_358_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_358_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_358_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_359_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_359_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_359_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_360_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_360_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_360_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_361_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_361_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_361_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_362_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_362_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_362_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_363_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_363_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_363_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_364_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_364_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_364_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_365_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_365_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_365_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_366_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_366_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_366_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_367_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_367_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_367_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_368_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_368_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_368_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_369_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_369_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_369_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_370_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_370_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_370_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_371_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_371_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_371_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_372_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_372_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_372_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_373_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_373_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_373_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_374_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_374_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_374_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_375_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_375_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_375_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_376_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_376_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_376_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_377_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_377_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_377_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_378_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_378_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_378_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_379_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_379_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_379_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_380_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_380_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_380_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_381_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_381_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_381_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_382_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_382_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_382_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_383_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_383_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_383_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_384_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_384_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_384_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_385_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_385_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_385_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_386_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_386_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_386_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_387_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_387_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_387_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_388_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_388_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_388_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_389_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_389_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_389_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_390_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_390_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_390_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_391_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_391_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_391_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_392_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_392_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_392_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_393_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_393_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_393_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_394_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_394_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_394_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_395_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_395_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_395_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_396_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_396_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_396_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_397_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_397_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_397_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_398_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_398_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_398_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_399_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_399_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_399_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_400_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_400_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_400_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_401_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_401_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_401_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_402_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_402_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_402_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_403_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_403_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_403_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_404_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_404_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_404_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_405_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_405_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_405_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_406_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_406_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_406_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_407_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_407_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_407_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_408_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_408_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_408_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_409_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_409_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_409_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_410_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_410_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_410_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_411_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_411_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_411_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_412_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_412_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_412_rough.jpg`
- `assets/textures/harvest/proc/proc_extra_413_albedo.jpg`
- `assets/textures/harvest/proc/proc_extra_413_normal.jpg`
- `assets/textures/harvest/proc/proc_extra_413_rough.jpg`
- `assets/textures/harvest/proc/rail_natural_albedo.jpg`
- `assets/textures/harvest/proc/rail_natural_normal.jpg`
- `assets/textures/harvest/proc/rail_natural_rough.jpg`
- `assets/textures/harvest/proc/rail_white_scuff_albedo.jpg`
- `assets/textures/harvest/proc/rail_white_scuff_normal.jpg`
- `assets/textures/harvest/proc/rail_white_scuff_rough.jpg`
- `assets/textures/harvest/proc/rake_deep_albedo.jpg`
- `assets/textures/harvest/proc/rake_deep_normal.jpg`
- `assets/textures/harvest/proc/rake_deep_rough.jpg`
- `assets/textures/harvest/proc/salt_block_albedo.jpg`
- `assets/textures/harvest/proc/salt_block_normal.jpg`
- `assets/textures/harvest/proc/salt_block_rough.jpg`
- `assets/textures/harvest/proc/sand_hoof_albedo.jpg`
- `assets/textures/harvest/proc/sand_hoof_normal.jpg`
- `assets/textures/harvest/proc/sand_hoof_rough.jpg`
- `assets/textures/harvest/proc/sand_lip_albedo.jpg`
- `assets/textures/harvest/proc/sand_lip_normal.jpg`
- `assets/textures/harvest/proc/sand_lip_rough.jpg`
- `assets/textures/harvest/proc/sand_rake_albedo.jpg`
- `assets/textures/harvest/proc/sand_rake_normal.jpg`
- `assets/textures/harvest/proc/sand_rake_rough.jpg`
- `assets/textures/harvest/proc/sand_track_albedo.jpg`
- `assets/textures/harvest/proc/sand_track_normal.jpg`
- `assets/textures/harvest/proc/sand_track_rough.jpg`
- `assets/textures/harvest/proc/sand_wet_center_albedo.jpg`
- `assets/textures/harvest/proc/sand_wet_center_normal.jpg`
- `assets/textures/harvest/proc/sand_wet_center_rough.jpg`
- `assets/textures/harvest/proc/sand_worked_dry_albedo.jpg`
- `assets/textures/harvest/proc/sand_worked_dry_normal.jpg`
- `assets/textures/harvest/proc/sand_worked_dry_rough.jpg`
- `assets/textures/harvest/proc/sand_worked_wet_albedo.jpg`
- `assets/textures/harvest/proc/sand_worked_wet_normal.jpg`
- `assets/textures/harvest/proc/sand_worked_wet_rough.jpg`
- `assets/textures/harvest/proc/stall_bar_albedo.jpg`
- `assets/textures/harvest/proc/stall_bar_normal.jpg`
- `assets/textures/harvest/proc/stall_bar_rough.jpg`
- `assets/textures/harvest/proc/straw_gold_albedo.jpg`
- `assets/textures/harvest/proc/straw_gold_normal.jpg`
- `assets/textures/harvest/proc/straw_gold_rough.jpg`
- `assets/textures/harvest/proc/tack_trunk_albedo.jpg`
- `assets/textures/harvest/proc/tack_trunk_normal.jpg`
- `assets/textures/harvest/proc/tack_trunk_rough.jpg`
- `assets/textures/harvest/proc/velvet_cap_albedo.jpg`
- `assets/textures/harvest/proc/velvet_cap_normal.jpg`
- `assets/textures/harvest/proc/velvet_cap_rough.jpg`
- `assets/textures/harvest/proc/wool_melton_albedo.jpg`
- `assets/textures/harvest/proc/wool_melton_normal.jpg`
- `assets/textures/harvest/proc/wool_melton_rough.jpg`
- `assets/textures/harvest/proc/wool_navy_coat_albedo.jpg`
- `assets/textures/harvest/proc/wool_navy_coat_normal.jpg`
- `assets/textures/harvest/proc/wool_navy_coat_rough.jpg`
- `assets/textures/harvest/proc/wool_navy_weave_albedo.jpg`
- `assets/textures/harvest/proc/wool_navy_weave_normal.jpg`
- `assets/textures/harvest/proc/wool_navy_weave_rough.jpg`
- `assets/textures/harvest/raked_dirt_dry_136_normal.jpg`
- `assets/textures/harvest/raked_dirt_dry_136_rake_273_dry_546_normal.jpg`
- `assets/textures/harvest/raked_dirt_dry_136_rake_273_dry_546_rough.jpg`
- `assets/textures/harvest/raked_dirt_dry_136_rake_273_normal.jpg`
- `assets/textures/harvest/raked_dirt_dry_136_rake_273_rough.jpg`
- `assets/textures/harvest/raked_dirt_dry_136_rough.jpg`
- `assets/textures/harvest/raked_dirt_dry_136_wet_545_normal.jpg`
- `assets/textures/harvest/raked_dirt_dry_136_wet_545_rough.jpg`
- `assets/textures/harvest/raked_dirt_late_544_normal.jpg`
- `assets/textures/harvest/raked_dirt_late_544_rough.jpg`
- `assets/textures/harvest/raked_dirt_shade_272_normal.jpg`
- `assets/textures/harvest/raked_dirt_shade_272_rough.jpg`
- `assets/textures/harvest/raked_dirt_shade_272_shade_547_normal.jpg`
- `assets/textures/harvest/raked_dirt_shade_272_shade_547_rough.jpg`
- `assets/textures/harvest/raw_plank_wall_late_274_late_549_normal.jpg`
- `assets/textures/harvest/raw_plank_wall_late_274_late_549_rough.jpg`
- `assets/textures/harvest/raw_plank_wall_late_274_normal.jpg`
- `assets/textures/harvest/raw_plank_wall_late_274_rough.jpg`
- `assets/textures/harvest/raw_plank_wall_rake_548_normal.jpg`
- `assets/textures/harvest/raw_plank_wall_rake_548_rough.jpg`
- `assets/textures/harvest/raw_plank_wall_shade_137_normal.jpg`
- `assets/textures/harvest/raw_plank_wall_shade_137_rough.jpg`
- `assets/textures/harvest/raw_plank_wall_shade_137_wet_275_dry_551_normal.jpg`
- `assets/textures/harvest/raw_plank_wall_shade_137_wet_275_dry_551_rough.jpg`
- `assets/textures/harvest/raw_plank_wall_shade_137_wet_275_normal.jpg`
- `assets/textures/harvest/raw_plank_wall_shade_137_wet_275_rough.jpg`
- `assets/textures/harvest/raw_plank_wall_shade_137_wet_550_normal.jpg`
- `assets/textures/harvest/raw_plank_wall_shade_137_wet_550_rough.jpg`
- `assets/textures/harvest/raw_planks_dry_276_normal.jpg`
- `assets/textures/harvest/raw_planks_dry_276_rake_553_normal.jpg`
- `assets/textures/harvest/raw_planks_dry_276_rake_553_rough.jpg`
- `assets/textures/harvest/raw_planks_dry_276_rough.jpg`
- `assets/textures/harvest/raw_planks_rake_138_late_554_normal.jpg`
- `assets/textures/harvest/raw_planks_rake_138_late_554_rough.jpg`
- `assets/textures/harvest/raw_planks_rake_138_normal.jpg`
- `assets/textures/harvest/raw_planks_rake_138_rough.jpg`
- `assets/textures/harvest/raw_planks_rake_138_shade_277_normal.jpg`
- `assets/textures/harvest/raw_planks_rake_138_shade_277_rough.jpg`
- `assets/textures/harvest/raw_planks_rake_138_shade_277_wet_555_normal.jpg`
- `assets/textures/harvest/raw_planks_rake_138_shade_277_wet_555_rough.jpg`
- `assets/textures/harvest/raw_planks_shade_552_normal.jpg`
- `assets/textures/harvest/raw_planks_shade_552_rough.jpg`
- `assets/textures/harvest/rock_path_02_dry_556_normal.jpg`
- `assets/textures/harvest/rock_path_02_dry_556_rough.jpg`
- `assets/textures/harvest/rock_path_02_late_139_late_279_normal.jpg`
- `assets/textures/harvest/rock_path_02_late_139_late_279_rake_558_normal.jpg`
- `assets/textures/harvest/rock_path_02_late_139_late_279_rake_558_rough.jpg`
- `assets/textures/harvest/rock_path_02_late_139_late_279_rough.jpg`
- `assets/textures/harvest/rock_path_02_late_139_normal.jpg`
- `assets/textures/harvest/rock_path_02_late_139_rough.jpg`
- `assets/textures/harvest/rock_path_02_late_139_shade_557_normal.jpg`
- `assets/textures/harvest/rock_path_02_late_139_shade_557_rough.jpg`
- `assets/textures/harvest/rock_path_02_rake_278_late_559_normal.jpg`
- `assets/textures/harvest/rock_path_02_rake_278_late_559_rough.jpg`
- `assets/textures/harvest/rock_path_02_rake_278_normal.jpg`
- `assets/textures/harvest/rock_path_02_rake_278_rough.jpg`
- `assets/textures/harvest/rock_path_wet_140_dry_281_normal.jpg`
- `assets/textures/harvest/rock_path_wet_140_dry_281_rough.jpg`
- `assets/textures/harvest/rock_path_wet_140_dry_281_shade_562_normal.jpg`
- `assets/textures/harvest/rock_path_wet_140_dry_281_shade_562_rough.jpg`
- `assets/textures/harvest/rock_path_wet_140_dry_561_normal.jpg`
- `assets/textures/harvest/rock_path_wet_140_dry_561_rough.jpg`
- `assets/textures/harvest/rock_path_wet_140_normal.jpg`
- `assets/textures/harvest/rock_path_wet_140_rough.jpg`
- `assets/textures/harvest/rock_path_wet_280_normal.jpg`
- `assets/textures/harvest/rock_path_wet_280_rake_563_normal.jpg`
- `assets/textures/harvest/rock_path_wet_280_rake_563_rough.jpg`
- `assets/textures/harvest/rock_path_wet_280_rough.jpg`
- `assets/textures/harvest/rock_path_wet_560_normal.jpg`
- `assets/textures/harvest/rock_path_wet_560_rough.jpg`
- `assets/textures/harvest/rusty_metal_03_dry_141_normal.jpg`
- `assets/textures/harvest/rusty_metal_03_dry_141_rake_283_dry_566_normal.jpg`
- `assets/textures/harvest/rusty_metal_03_dry_141_rake_283_dry_566_rough.jpg`
- `assets/textures/harvest/rusty_metal_03_dry_141_rake_283_normal.jpg`
- `assets/textures/harvest/rusty_metal_03_dry_141_rake_283_rough.jpg`
- `assets/textures/harvest/rusty_metal_03_dry_141_rough.jpg`
- `assets/textures/harvest/rusty_metal_03_dry_141_wet_565_normal.jpg`
- `assets/textures/harvest/rusty_metal_03_dry_141_wet_565_rough.jpg`
- `assets/textures/harvest/rusty_metal_03_late_564_normal.jpg`
- `assets/textures/harvest/rusty_metal_03_late_564_rough.jpg`
- `assets/textures/harvest/rusty_metal_03_shade_282_normal.jpg`
- `assets/textures/harvest/rusty_metal_03_shade_282_rough.jpg`
- `assets/textures/harvest/rusty_metal_03_shade_282_shade_567_normal.jpg`
- `assets/textures/harvest/rusty_metal_03_shade_282_shade_567_rough.jpg`
- `assets/textures/harvest/rusty_metal_04_late_284_late_569_normal.jpg`
- `assets/textures/harvest/rusty_metal_04_late_284_late_569_rough.jpg`
- `assets/textures/harvest/rusty_metal_04_late_284_normal.jpg`
- `assets/textures/harvest/rusty_metal_04_late_284_rough.jpg`
- `assets/textures/harvest/rusty_metal_04_rake_568_normal.jpg`
- `assets/textures/harvest/rusty_metal_04_rake_568_rough.jpg`
- `assets/textures/harvest/rusty_metal_04_shade_142_normal.jpg`
- `assets/textures/harvest/rusty_metal_04_shade_142_rough.jpg`
- `assets/textures/harvest/rusty_metal_04_shade_142_wet_285_dry_571_normal.jpg`
- `assets/textures/harvest/rusty_metal_04_shade_142_wet_285_dry_571_rough.jpg`
- `assets/textures/harvest/rusty_metal_04_shade_142_wet_285_normal.jpg`
- `assets/textures/harvest/rusty_metal_04_shade_142_wet_285_rough.jpg`
- `assets/textures/harvest/rusty_metal_04_shade_142_wet_570_normal.jpg`
- `assets/textures/harvest/rusty_metal_04_shade_142_wet_570_rough.jpg`
- `assets/textures/harvest/rusty_metal_dry_286_normal.jpg`
- `assets/textures/harvest/rusty_metal_dry_286_rake_573_normal.jpg`
- `assets/textures/harvest/rusty_metal_dry_286_rake_573_rough.jpg`
- `assets/textures/harvest/rusty_metal_dry_286_rough.jpg`
- `assets/textures/harvest/rusty_metal_rake_143_late_574_normal.jpg`
- `assets/textures/harvest/rusty_metal_rake_143_late_574_rough.jpg`
- `assets/textures/harvest/rusty_metal_rake_143_normal.jpg`
- `assets/textures/harvest/rusty_metal_rake_143_rough.jpg`
- `assets/textures/harvest/rusty_metal_rake_143_shade_287_normal.jpg`
- `assets/textures/harvest/rusty_metal_rake_143_shade_287_rough.jpg`
- `assets/textures/harvest/rusty_metal_rake_143_shade_287_wet_575_normal.jpg`
- `assets/textures/harvest/rusty_metal_rake_143_shade_287_wet_575_rough.jpg`
- `assets/textures/harvest/rusty_metal_shade_572_normal.jpg`
- `assets/textures/harvest/rusty_metal_shade_572_rough.jpg`
- `assets/textures/harvest/sand_01_dry_576_normal.jpg`
- `assets/textures/harvest/sand_01_dry_576_rough.jpg`
- `assets/textures/harvest/sand_01_late_144_late_289_normal.jpg`
- `assets/textures/harvest/sand_01_late_144_late_289_rake_578_normal.jpg`
- `assets/textures/harvest/sand_01_late_144_late_289_rake_578_rough.jpg`
- `assets/textures/harvest/sand_01_late_144_late_289_rough.jpg`
- `assets/textures/harvest/sand_01_late_144_normal.jpg`
- `assets/textures/harvest/sand_01_late_144_rough.jpg`
- `assets/textures/harvest/sand_01_late_144_shade_577_normal.jpg`
- `assets/textures/harvest/sand_01_late_144_shade_577_rough.jpg`
- `assets/textures/harvest/sand_01_rake_288_late_579_normal.jpg`
- `assets/textures/harvest/sand_01_rake_288_late_579_rough.jpg`
- `assets/textures/harvest/sand_01_rake_288_normal.jpg`
- `assets/textures/harvest/sand_01_rake_288_rough.jpg`
- `assets/textures/harvest/sand_02_wet_145_dry_291_normal.jpg`
- `assets/textures/harvest/sand_02_wet_145_dry_291_rough.jpg`
- `assets/textures/harvest/sand_02_wet_145_dry_291_shade_582_normal.jpg`
- `assets/textures/harvest/sand_02_wet_145_dry_291_shade_582_rough.jpg`
- `assets/textures/harvest/sand_02_wet_145_dry_581_normal.jpg`
- `assets/textures/harvest/sand_02_wet_145_dry_581_rough.jpg`
- `assets/textures/harvest/sand_02_wet_145_normal.jpg`
- `assets/textures/harvest/sand_02_wet_145_rough.jpg`
- `assets/textures/harvest/sand_02_wet_290_normal.jpg`
- `assets/textures/harvest/sand_02_wet_290_rake_583_normal.jpg`
- `assets/textures/harvest/sand_02_wet_290_rake_583_rough.jpg`
- `assets/textures/harvest/sand_02_wet_290_rough.jpg`
- `assets/textures/harvest/sand_02_wet_580_normal.jpg`
- `assets/textures/harvest/sand_02_wet_580_rough.jpg`
- `assets/textures/harvest/sandy_gravel_dry_146_normal.jpg`
- `assets/textures/harvest/sandy_gravel_dry_146_rake_293_dry_586_normal.jpg`
- `assets/textures/harvest/sandy_gravel_dry_146_rake_293_dry_586_rough.jpg`
- `assets/textures/harvest/sandy_gravel_dry_146_rake_293_normal.jpg`
- `assets/textures/harvest/sandy_gravel_dry_146_rake_293_rough.jpg`
- `assets/textures/harvest/sandy_gravel_dry_146_rough.jpg`
- `assets/textures/harvest/sandy_gravel_dry_146_wet_585_normal.jpg`
- `assets/textures/harvest/sandy_gravel_dry_146_wet_585_rough.jpg`
- `assets/textures/harvest/sandy_gravel_late_584_normal.jpg`
- `assets/textures/harvest/sandy_gravel_late_584_rough.jpg`
- `assets/textures/harvest/sandy_gravel_shade_292_normal.jpg`
- `assets/textures/harvest/sandy_gravel_shade_292_rough.jpg`
- `assets/textures/harvest/sandy_gravel_shade_292_shade_587_normal.jpg`
- `assets/textures/harvest/sandy_gravel_shade_292_shade_587_rough.jpg`
- `assets/textures/harvest/sparse_grass_late_294_late_589_normal.jpg`
- `assets/textures/harvest/sparse_grass_late_294_late_589_rough.jpg`
- `assets/textures/harvest/sparse_grass_late_294_normal.jpg`
- `assets/textures/harvest/sparse_grass_late_294_rough.jpg`
- `assets/textures/harvest/sparse_grass_rake_588_normal.jpg`
- `assets/textures/harvest/sparse_grass_rake_588_rough.jpg`
- `assets/textures/harvest/sparse_grass_shade_147_normal.jpg`
- `assets/textures/harvest/sparse_grass_shade_147_rough.jpg`
- `assets/textures/harvest/sparse_grass_shade_147_wet_295_dry_591_normal.jpg`
- `assets/textures/harvest/sparse_grass_shade_147_wet_295_dry_591_rough.jpg`
- `assets/textures/harvest/sparse_grass_shade_147_wet_295_normal.jpg`
- `assets/textures/harvest/sparse_grass_shade_147_wet_295_rough.jpg`
- `assets/textures/harvest/sparse_grass_shade_147_wet_590_normal.jpg`
- `assets/textures/harvest/sparse_grass_shade_147_wet_590_rough.jpg`
- `assets/textures/harvest/stony_dirt_path_dry_296_normal.jpg`
- `assets/textures/harvest/stony_dirt_path_dry_296_rake_593_normal.jpg`
- `assets/textures/harvest/stony_dirt_path_dry_296_rake_593_rough.jpg`
- `assets/textures/harvest/stony_dirt_path_dry_296_rough.jpg`
- `assets/textures/harvest/stony_dirt_path_rake_148_late_594_normal.jpg`
- `assets/textures/harvest/stony_dirt_path_rake_148_late_594_rough.jpg`
- `assets/textures/harvest/stony_dirt_path_rake_148_normal.jpg`
- `assets/textures/harvest/stony_dirt_path_rake_148_rough.jpg`
- `assets/textures/harvest/stony_dirt_path_rake_148_shade_297_normal.jpg`
- `assets/textures/harvest/stony_dirt_path_rake_148_shade_297_rough.jpg`
- `assets/textures/harvest/stony_dirt_path_rake_148_shade_297_wet_595_normal.jpg`
- `assets/textures/harvest/stony_dirt_path_rake_148_shade_297_wet_595_rough.jpg`
- `assets/textures/harvest/stony_dirt_path_shade_592_normal.jpg`
- `assets/textures/harvest/stony_dirt_path_shade_592_rough.jpg`
- `assets/textures/harvest/weathered_planks_dry_596_normal.jpg`
- `assets/textures/harvest/weathered_planks_dry_596_rough.jpg`
- `assets/textures/harvest/weathered_planks_late_149_late_299_normal.jpg`
- `assets/textures/harvest/weathered_planks_late_149_late_299_rake_598_normal.jpg`
- `assets/textures/harvest/weathered_planks_late_149_late_299_rake_598_rough.jpg`
- `assets/textures/harvest/weathered_planks_late_149_late_299_rough.jpg`
- `assets/textures/harvest/weathered_planks_late_149_normal.jpg`
- `assets/textures/harvest/weathered_planks_late_149_rough.jpg`
- `assets/textures/harvest/weathered_planks_late_149_shade_597_normal.jpg`
- `assets/textures/harvest/weathered_planks_late_149_shade_597_rough.jpg`
- `assets/textures/harvest/weathered_planks_rake_298_late_599_normal.jpg`
- `assets/textures/harvest/weathered_planks_rake_298_late_599_rough.jpg`
- `assets/textures/harvest/weathered_planks_rake_298_normal.jpg`
- `assets/textures/harvest/weathered_planks_rake_298_rough.jpg`
- `assets/textures/harvest/white_planks_clean_wet_150_dry_301_normal.jpg`
- `assets/textures/harvest/white_planks_clean_wet_150_dry_301_rough.jpg`
- `assets/textures/harvest/white_planks_clean_wet_150_dry_301_shade_602_normal.jpg`
- `assets/textures/harvest/white_planks_clean_wet_150_dry_301_shade_602_rough.jpg`
- `assets/textures/harvest/white_planks_clean_wet_150_dry_601_normal.jpg`
- `assets/textures/harvest/white_planks_clean_wet_150_dry_601_rough.jpg`
- `assets/textures/harvest/white_planks_clean_wet_150_normal.jpg`
- `assets/textures/harvest/white_planks_clean_wet_150_rough.jpg`
- `assets/textures/harvest/white_planks_clean_wet_300_normal.jpg`
- `assets/textures/harvest/white_planks_clean_wet_300_rake_603_normal.jpg`
- `assets/textures/harvest/white_planks_clean_wet_300_rake_603_rough.jpg`
- `assets/textures/harvest/white_planks_clean_wet_300_rough.jpg`
- `assets/textures/harvest/white_planks_clean_wet_600_normal.jpg`
- `assets/textures/harvest/white_planks_clean_wet_600_rough.jpg`
- `assets/textures/harvest/withered_grass_dry_151_normal.jpg`
- `assets/textures/harvest/withered_grass_dry_151_rake_303_dry_606_normal.jpg`
- `assets/textures/harvest/withered_grass_dry_151_rake_303_dry_606_rough.jpg`
- `assets/textures/harvest/withered_grass_dry_151_rake_303_normal.jpg`
- `assets/textures/harvest/withered_grass_dry_151_rake_303_rough.jpg`
- `assets/textures/harvest/withered_grass_dry_151_rough.jpg`
- `assets/textures/harvest/withered_grass_dry_151_wet_605_normal.jpg`
- `assets/textures/harvest/withered_grass_dry_151_wet_605_rough.jpg`
- `assets/textures/harvest/withered_grass_late_604_normal.jpg`
- `assets/textures/harvest/withered_grass_late_604_rough.jpg`
- `assets/textures/harvest/withered_grass_shade_302_normal.jpg`
- `assets/textures/harvest/withered_grass_shade_302_rough.jpg`
- `assets/textures/harvest/withered_grass_shade_302_shade_607_normal.jpg`
- `assets/textures/harvest/withered_grass_shade_302_shade_607_rough.jpg`
- `assets/textures/harvest/wood_chips_late_304_late_609_normal.jpg`
- `assets/textures/harvest/wood_chips_late_304_late_609_rough.jpg`
- `assets/textures/harvest/wood_chips_late_304_normal.jpg`
- `assets/textures/harvest/wood_chips_late_304_rough.jpg`
- `assets/textures/harvest/wood_chips_rake_608_normal.jpg`
- `assets/textures/harvest/wood_chips_rake_608_rough.jpg`
- `assets/textures/harvest/wood_chips_shade_152_normal.jpg`
- `assets/textures/harvest/wood_chips_shade_152_rough.jpg`
- `assets/textures/harvest/wood_chips_shade_152_wet_305_dry_611_normal.jpg`
- `assets/textures/harvest/wood_chips_shade_152_wet_305_dry_611_rough.jpg`
- `assets/textures/harvest/wood_chips_shade_152_wet_305_normal.jpg`
- `assets/textures/harvest/wood_chips_shade_152_wet_305_rough.jpg`
- `assets/textures/harvest/wood_chips_shade_152_wet_610_normal.jpg`
- `assets/textures/harvest/wood_chips_shade_152_wet_610_rough.jpg`
- `assets/textures/harvest/wood_floor_deck_dry_306_normal.jpg`
- `assets/textures/harvest/wood_floor_deck_dry_306_rake_613_normal.jpg`
- `assets/textures/harvest/wood_floor_deck_dry_306_rake_613_rough.jpg`
- `assets/textures/harvest/wood_floor_deck_dry_306_rough.jpg`
- `assets/textures/harvest/wood_floor_deck_rake_153_late_614_normal.jpg`
- `assets/textures/harvest/wood_floor_deck_rake_153_late_614_rough.jpg`
- `assets/textures/harvest/wood_floor_deck_rake_153_normal.jpg`
- `assets/textures/harvest/wood_floor_deck_rake_153_rough.jpg`
- `assets/textures/harvest/wood_floor_deck_rake_153_shade_307_normal.jpg`
- `assets/textures/harvest/wood_floor_deck_rake_153_shade_307_rough.jpg`
- `assets/textures/harvest/wood_floor_deck_rake_153_shade_307_wet_615_normal.jpg`
- `assets/textures/harvest/wood_floor_deck_rake_153_shade_307_wet_615_rough.jpg`
- `assets/textures/harvest/wood_floor_deck_shade_612_normal.jpg`
- `assets/textures/harvest/wood_floor_deck_shade_612_rough.jpg`
- `assets/textures/harvest/wood_planks_dry_616_normal.jpg`
- `assets/textures/harvest/wood_planks_dry_616_rough.jpg`
- `assets/textures/harvest/wood_planks_late_154_late_309_normal.jpg`
- `assets/textures/harvest/wood_planks_late_154_late_309_rake_618_normal.jpg`
- `assets/textures/harvest/wood_planks_late_154_late_309_rake_618_rough.jpg`
- `assets/textures/harvest/wood_planks_late_154_late_309_rough.jpg`
- `assets/textures/harvest/wood_planks_late_154_normal.jpg`
- `assets/textures/harvest/wood_planks_late_154_rough.jpg`
- `assets/textures/harvest/wood_planks_late_154_shade_617_normal.jpg`
- `assets/textures/harvest/wood_planks_late_154_shade_617_rough.jpg`
- `assets/textures/harvest/wood_planks_rake_308_late_619_normal.jpg`
- `assets/textures/harvest/wood_planks_rake_308_late_619_rough.jpg`
- `assets/textures/harvest/wood_planks_rake_308_normal.jpg`
- `assets/textures/harvest/wood_planks_rake_308_rough.jpg`
- `assets/textures/harvest/wood_table_wet_155_dry_311_normal.jpg`
- `assets/textures/harvest/wood_table_wet_155_dry_311_rough.jpg`
- `assets/textures/harvest/wood_table_wet_155_dry_311_shade_622_normal.jpg`
- `assets/textures/harvest/wood_table_wet_155_dry_311_shade_622_rough.jpg`
- `assets/textures/harvest/wood_table_wet_155_dry_621_normal.jpg`
- `assets/textures/harvest/wood_table_wet_155_dry_621_rough.jpg`
- `assets/textures/harvest/wood_table_wet_155_normal.jpg`
- `assets/textures/harvest/wood_table_wet_155_rough.jpg`
- `assets/textures/harvest/wood_table_wet_310_normal.jpg`
- `assets/textures/harvest/wood_table_wet_310_rake_623_normal.jpg`
- `assets/textures/harvest/wood_table_wet_310_rake_623_rough.jpg`
- `assets/textures/harvest/wood_table_wet_310_rough.jpg`
- `assets/textures/harvest/wood_table_wet_620_normal.jpg`
- `assets/textures/harvest/wood_table_wet_620_rough.jpg`
- `assets/textures/harvest/wooden_gate_dry_156_normal.jpg`
- `assets/textures/harvest/wooden_gate_dry_156_rake_313_dry_626_normal.jpg`
- `assets/textures/harvest/wooden_gate_dry_156_rake_313_dry_626_rough.jpg`
- `assets/textures/harvest/wooden_gate_dry_156_rake_313_normal.jpg`
- `assets/textures/harvest/wooden_gate_dry_156_rake_313_rough.jpg`
- `assets/textures/harvest/wooden_gate_dry_156_rough.jpg`
- `assets/textures/harvest/wooden_gate_dry_156_wet_625_normal.jpg`
- `assets/textures/harvest/wooden_gate_dry_156_wet_625_rough.jpg`
- `assets/textures/harvest/wooden_gate_late_624_normal.jpg`
- `assets/textures/harvest/wooden_gate_late_624_rough.jpg`
- `assets/textures/harvest/wooden_gate_shade_312_normal.jpg`
- `assets/textures/harvest/wooden_gate_shade_312_rough.jpg`
- `assets/textures/harvest/wooden_gate_shade_312_shade_627_normal.jpg`
- `assets/textures/harvest/wooden_gate_shade_312_shade_627_rough.jpg`
- `assets/textures/harvest/wool_boucle_late_314_late_629_normal.jpg`
- `assets/textures/harvest/wool_boucle_late_314_late_629_rough.jpg`
- `assets/textures/harvest/wool_boucle_late_314_normal.jpg`
- `assets/textures/harvest/wool_boucle_late_314_rough.jpg`
- `assets/textures/harvest/wool_boucle_rake_628_normal.jpg`
- `assets/textures/harvest/wool_boucle_rake_628_rough.jpg`
- `assets/textures/harvest/wool_boucle_shade_157_normal.jpg`
- `assets/textures/harvest/wool_boucle_shade_157_rough.jpg`
- `assets/textures/harvest/wool_boucle_shade_157_wet_315_dry_631_normal.jpg`
- `assets/textures/harvest/wool_boucle_shade_157_wet_315_dry_631_rough.jpg`
- `assets/textures/harvest/wool_boucle_shade_157_wet_315_normal.jpg`
- `assets/textures/harvest/wool_boucle_shade_157_wet_315_rough.jpg`
- `assets/textures/harvest/wool_boucle_shade_157_wet_630_normal.jpg`
- `assets/textures/harvest/wool_boucle_shade_157_wet_630_rough.jpg`
- `assets/textures/harvest/worn_planks_02_dry_316_normal.jpg`
- `assets/textures/harvest/worn_planks_02_dry_316_rake_633_normal.jpg`
- `assets/textures/harvest/worn_planks_02_dry_316_rake_633_rough.jpg`
- `assets/textures/harvest/worn_planks_02_dry_316_rough.jpg`
- `assets/textures/harvest/worn_planks_02_rake_158_late_634_normal.jpg`
- `assets/textures/harvest/worn_planks_02_rake_158_late_634_rough.jpg`
- `assets/textures/harvest/worn_planks_02_rake_158_normal.jpg`
- `assets/textures/harvest/worn_planks_02_rake_158_rough.jpg`
- `assets/textures/harvest/worn_planks_02_rake_158_shade_317_normal.jpg`
- `assets/textures/harvest/worn_planks_02_rake_158_shade_317_rough.jpg`
- `assets/textures/harvest/worn_planks_02_rake_158_shade_317_wet_635_normal.jpg`
- `assets/textures/harvest/worn_planks_02_rake_158_shade_317_wet_635_rough.jpg`
- `assets/textures/harvest/worn_planks_02_shade_632_normal.jpg`
- `assets/textures/harvest/worn_planks_02_shade_632_rough.jpg`
- `assets/textures/harvest/worn_planks_dry_636_normal.jpg`
- `assets/textures/harvest/worn_planks_dry_636_rough.jpg`
- `assets/textures/harvest/worn_planks_late_159_late_319_normal.jpg`
- `assets/textures/harvest/worn_planks_late_159_late_319_rake_638_normal.jpg`
- `assets/textures/harvest/worn_planks_late_159_late_319_rake_638_rough.jpg`
- `assets/textures/harvest/worn_planks_late_159_late_319_rough.jpg`
- `assets/textures/harvest/worn_planks_late_159_normal.jpg`
- `assets/textures/harvest/worn_planks_late_159_rough.jpg`
- `assets/textures/harvest/worn_planks_late_159_shade_637_normal.jpg`
- `assets/textures/harvest/worn_planks_late_159_shade_637_rough.jpg`
- `assets/textures/harvest/worn_planks_rake_318_late_639_normal.jpg`
- `assets/textures/harvest/worn_planks_rake_318_late_639_rough.jpg`
- `assets/textures/harvest/worn_planks_rake_318_normal.jpg`
- `assets/textures/harvest/worn_planks_rake_318_rough.jpg`
- `assets/textures/mane_albedo.jpg`
- `assets/textures/mane_normal.jpg`
- `assets/textures/mane_rough.jpg`
- `assets/textures/pole_navy_albedo.jpg`
- `assets/textures/pole_red_albedo.jpg`
- `assets/textures/pole_ref.jpg`
- `assets/textures/pole_white_albedo.jpg`
- `assets/textures/pole_white_normal.jpg`
- `assets/textures/rider_back.jpg`
- `assets/textures/rider_face_front.jpg`
- `assets/textures/rider_face_side.jpg`
- `assets/textures/rider_front.jpg`
- `assets/textures/rider_side.jpg`
- `assets/textures/saddle_ref.jpg`
- `assets/textures/sky.jpg`
- `assets/textures/standard_ref.jpg`
- `assets/ui/abbott_theme.tres`
- `assets/ui/icon.png`
- `assets/ui/icon_256.png`
- `assets/ui/panel.jpg`
- `assets/ui/panel_blank.jpg`

## Every file

| file | size | referenced | credit | pixels | flags |
| --- | ---: | --- | --- | --- | --- |
| `assets/ATTRIBUTION_HARVEST.md` | 281735 | no | no |  | unreferenced, no credit |
| `assets/audio/ATTRIBUTION.txt` | 302 | no | no |  | unreferenced, no credit |
| `assets/audio/ambient_indoor.wav` | 1940444 | no | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  | unreferenced |
| `assets/audio/ambient_outdoor.wav` | 1940444 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/hoof/hit_01.wav` | 26504 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/hoof/hit_02.wav` | 26504 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/hoof/hit_03.wav` | 26504 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/hoof/hit_04.wav` | 26504 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/hoof/hit_05.wav` | 26504 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/hoof/hit_06.wav` | 26504 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/hoof/hit_07.wav` | 26504 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/hoof/hit_08.wav` | 11534 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/hoof/hit_09.wav` | 26504 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/hoof/hit_10.wav` | 26504 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/hoof/hit_11.wav` | 26504 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/hoof/hit_12.wav` | 26504 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/hoof_canter.wav` | 238184 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/hoof_trot.wav` | 273464 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/hoof_walk.wav` | 322856 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/horse/blow.wav` | 123522 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/horse/grunt.wav` | 52964 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/horse/neigh.wav` | 176444 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/horse/nicker.wav` | 114704 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/horse/snort.wav` | 97064 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/jump.wav` | 39734 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/land.wav` | 17860 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/rail.wav` | 61782 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/refuse.wav` | 35324 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/rider/and_up.wav` | 160956 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/rider/canter.wav` | 154604 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/rider/come_on.wav` | 154604 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/rider/easy.wav` | 150372 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/rider/good_boy.wav` | 160956 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/rider/steady.wav` | 156722 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/rider/trot.wav` | 148254 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/rider/walk_on.wav` | 169422 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/rider/whoa.wav` | 146138 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/audio/ui.wav` | 7100 | yes | game/assets/audio/ATTRIBUTION.txt (the set, files not listed) |  |  |
| `assets/cc0/kenney/ATTRIBUTION.txt` | 70 | no | no |  | unreferenced, no credit |
| `assets/cc0/kenney/plant_bushLarge.glb` | 6436 | yes | game/assets/cc0/kenney/ATTRIBUTION.txt (the Nature Kit, files not listed) |  |  |
| `assets/cc0/kenney/tree_default.glb` | 9428 | yes | game/assets/cc0/kenney/ATTRIBUTION.txt (the Nature Kit, files not listed) |  |  |
| `assets/cc0/kenney/tree_oak.glb` | 14644 | yes | game/assets/cc0/kenney/ATTRIBUTION.txt (the Nature Kit, files not listed) |  |  |
| `assets/cc0/kenney/tree_pineDefaultA.glb` | 17220 | yes | game/assets/cc0/kenney/ATTRIBUTION.txt (the Nature Kit, files not listed) |  |  |
| `assets/cc0/kenney/tree_simple.glb` | 6500 | yes | game/assets/cc0/kenney/ATTRIBUTION.txt (the Nature Kit, files not listed) |  |  |
| `assets/cc0/kenney/tree_tall.glb` | 7000 | yes | game/assets/cc0/kenney/ATTRIBUTION.txt (the Nature Kit, files not listed) |  |  |
| `assets/cc0/polyhaven/ATTRIBUTION.txt` | 133 | no | no |  | unreferenced, no credit |
| `assets/cc0/polyhaven/kloofendal_48d_partly_cloudy_2k.hdr` | 6480797 | yes | game/assets/cc0/polyhaven/ATTRIBUTION.txt | 2048 x 1024 | over 5 MB |
| `assets/fonts/LibreBaskerville-Bold.ttf` | 154332 | yes | no |  | no credit |
| `assets/fonts/LibreBaskerville-Regular.ttf` | 156008 | yes | no |  | no credit |
| `assets/fonts/SourceSans3-Regular.ttf` | 646340 | yes | no |  | no credit |
| `assets/meshes/ATTRIBUTION.txt` | 611 | no | no |  | unreferenced, no credit |
| `assets/meshes/abbott.glb` | 9557560 | yes | no |  | over 5 MB, no credit |
| `assets/meshes/abbott_abbott_coat.png` | 3903434 | no | no | 2048 x 2048 | unreferenced, no credit |
| `assets/meshes/abbott_abbott_eye.png` | 165188 | no | no | 400 x 400 | unreferenced, no credit |
| `assets/meshes/abbott_abbott_hair.png` | 4761138 | no | no | 2048 x 2048 | unreferenced, no credit |
| `assets/meshes/abbott_v2.glb` | 1874208 | no | game/assets/meshes/ATTRIBUTION.txt |  | unreferenced |
| `assets/meshes/abbott_v2d.glb` | 1876336 | yes | no |  | no credit |
| `assets/meshes/inspect/whitehorse_uv_report.txt` | 7393 | no | no |  | unreferenced, no credit |
| `assets/meshes/madison_casual.glb` | 2628300 | yes | game/assets/meshes/ATTRIBUTION.txt |  |  |
| `assets/meshes/quaternius-WhiteHorse.glb` | 1109444 | yes | no |  | no credit |
| `assets/photos/IMG_3408.jpg` | 4921265 | no | no | 4284 x 5712 | over 2048 px, unreferenced, no credit |
| `assets/photos/IMG_3409.jpg` | 5821007 | no | no | 4284 x 5712 | over 2048 px, over 5 MB, unreferenced, no credit |
| `assets/photos/abbott_cinematic.jpg` | 210552 | no | no | 1360 x 752 | unreferenced, no credit |
| `assets/photos/abbott_title.jpg` | 632885 | yes | no | 1440 x 1920 | no credit |
| `assets/photos/abbott_title_drawn.jpg` | 468664 | yes | no | 2560 x 1440 | over 2048 px, no credit |
| `assets/textures/abbott_face_photo.jpg` | 306795 | no | no | 1024 x 1365 | unreferenced, no credit |
| `assets/textures/abbott_front.png` | 611874 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/abbott_front_rgb.jpg` | 131231 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/abbott_shader_coat.jpg` | 12911 | yes | no | 512 x 512 | no credit |
| `assets/textures/abbott_shader_face.jpg` | 844939 | yes | no | 2227 x 5426 | over 2048 px, no credit |
| `assets/textures/abbott_shader_stall.jpg` | 263542 | yes | no | 1149 x 2499 | over 2048 px, no credit |
| `assets/textures/abbott_side.png` | 431653 | yes | no | 1280 x 720 | no credit |
| `assets/textures/abbott_side_rgb.jpg` | 89822 | no | no | 1280 x 720 | unreferenced, no credit |
| `assets/textures/abbott_v2_coat.png` | 270883 | no | no | 2048 x 2048 | unreferenced, no credit |
| `assets/textures/abbott_wh_coat.png` | 1739759 | no | no | 2048 x 2048 | unreferenced, no credit |
| `assets/textures/abbott_wh_eye.png` | 82108 | no | no | 2048 x 2048 | unreferenced, no credit |
| `assets/textures/abbott_wh_eye_black.png` | 122763 | no | no | 2048 x 2048 | unreferenced, no credit |
| `assets/textures/abbott_wh_hair.png` | 1360068 | no | no | 2048 x 2048 | unreferenced, no credit |
| `assets/textures/abbott_wh_hoof.png` | 78304 | no | no | 2048 x 2048 | unreferenced, no credit |
| `assets/textures/abbott_wh_light.png` | 1342984 | no | no | 2048 x 2048 | unreferenced, no credit |
| `assets/textures/abbott_wh_muzzle.png` | 1254133 | no | no | 2048 x 2048 | unreferenced, no credit |
| `assets/textures/coat_albedo.jpg` | 442060 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/coat_normal.jpg` | 223038 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/coat_rough.jpg` | 106027 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/flower_box.jpg` | 267618 | no | no | 1280 x 720 | unreferenced, no credit |
| `assets/textures/grass_albedo.jpg` | 525393 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/grass_normal.jpg` | 304197 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/grass_rough.jpg` | 141861 | no | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 | unreferenced |
| `assets/textures/harvest/acg_bark001_albedo.jpg` | 336328 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_normal.jpg` | 525862 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_rough.jpg` | 266993 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_wet_000_albedo.jpg` | 290748 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_wet_000_dry_001_albedo.jpg` | 294286 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_wet_000_dry_001_normal.jpg` | 525862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_000_dry_001_rough.jpg` | 266993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_000_dry_001_shade_002_albedo.jpg` | 245238 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_wet_000_dry_001_shade_002_normal.jpg` | 525862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_000_dry_001_shade_002_rake_003_albedo.jpg` | 249065 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_wet_000_dry_001_shade_002_rake_003_normal.jpg` | 525862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_000_dry_001_shade_002_rake_003_rough.jpg` | 266993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_000_dry_001_shade_002_rough.jpg` | 266993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_000_dry_001_shade_642_albedo.jpg` | 245238 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_wet_000_dry_001_shade_642_normal.jpg` | 525862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_000_dry_001_shade_642_rough.jpg` | 266993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_000_dry_321_albedo.jpg` | 294286 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_wet_000_dry_321_late_004_albedo.jpg` | 298006 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_wet_000_dry_321_late_004_normal.jpg` | 525862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_000_dry_321_late_004_rough.jpg` | 266993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_000_dry_321_normal.jpg` | 525862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_000_dry_321_rough.jpg` | 266993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_000_dry_641_albedo.jpg` | 294286 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_wet_000_dry_641_normal.jpg` | 525862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_000_dry_641_rough.jpg` | 266993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_000_normal.jpg` | 525862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_000_rough.jpg` | 266993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_160_albedo.jpg` | 290748 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_wet_160_normal.jpg` | 525862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_160_rake_003_albedo.jpg` | 296712 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_wet_160_rake_003_dry_006_albedo.jpg` | 300464 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_wet_160_rake_003_dry_006_normal.jpg` | 525862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_160_rake_003_dry_006_rough.jpg` | 266993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_160_rake_003_normal.jpg` | 525862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_160_rake_003_rough.jpg` | 266993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_160_rough.jpg` | 266993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_160_wet_005_albedo.jpg` | 269772 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_wet_160_wet_005_normal.jpg` | 525862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_160_wet_005_rough.jpg` | 266993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_320_albedo.jpg` | 290748 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_wet_320_normal.jpg` | 525862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_320_rough.jpg` | 266993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_320_shade_007_albedo.jpg` | 239930 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_wet_320_shade_007_normal.jpg` | 525862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_320_shade_007_rough.jpg` | 266993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_640_albedo.jpg` | 290748 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark001_wet_640_normal.jpg` | 525862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark001_wet_640_rough.jpg` | 266993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_albedo.jpg` | 418778 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_dry_001_albedo.jpg` | 401255 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_dry_001_late_009_albedo.jpg` | 395968 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_dry_001_late_009_normal.jpg` | 677531 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_dry_001_late_009_rough.jpg` | 327131 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_dry_001_normal.jpg` | 677531 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_dry_001_rake_003_albedo.jpg` | 405886 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_dry_001_rake_003_dry_006_albedo.jpg` | 407918 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_dry_001_rake_003_dry_006_dry_011_albedo.jpg` | 409401 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_dry_001_rake_003_dry_006_dry_011_normal.jpg` | 677531 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_dry_001_rake_003_dry_006_dry_011_rough.jpg` | 327131 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_dry_001_rake_003_dry_006_normal.jpg` | 677531 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_dry_001_rake_003_dry_006_rough.jpg` | 327131 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_dry_001_rake_003_normal.jpg` | 677531 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_dry_001_rake_003_rough.jpg` | 327131 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_dry_001_rake_003_wet_010_albedo.jpg` | 372756 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_dry_001_rake_003_wet_010_normal.jpg` | 677531 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_dry_001_rake_003_wet_010_rough.jpg` | 327131 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_dry_001_rough.jpg` | 327131 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_dry_001_wet_005_albedo.jpg` | 368235 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_dry_001_wet_005_normal.jpg` | 677531 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_dry_001_wet_005_rough.jpg` | 327131 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_dry_001_wet_005_shade_012_albedo.jpg` | 304048 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_dry_001_wet_005_shade_012_normal.jpg` | 677531 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_dry_001_wet_005_shade_012_rough.jpg` | 327131 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_late_004_albedo.jpg` | 384544 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_late_004_normal.jpg` | 677531 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_late_004_rake_013_albedo.jpg` | 387358 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_late_004_rake_013_normal.jpg` | 677531 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_late_004_rake_013_rough.jpg` | 327131 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_late_004_rough.jpg` | 327131 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_normal.jpg` | 677531 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_rake_008_albedo.jpg` | 405687 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_rake_008_normal.jpg` | 677531 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_rake_008_rough.jpg` | 327131 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_rough.jpg` | 327131 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_shade_002_albedo.jpg` | 254818 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_shade_002_late_014_albedo.jpg` | 250531 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_shade_002_late_014_normal.jpg` | 677531 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_shade_002_late_014_rough.jpg` | 327131 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_shade_002_normal.jpg` | 677531 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_shade_002_rough.jpg` | 327131 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_shade_002_shade_007_albedo.jpg` | 207435 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_shade_002_shade_007_normal.jpg` | 677531 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_shade_002_shade_007_rough.jpg` | 327131 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_shade_002_shade_007_wet_015_albedo.jpg` | 188904 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark002_shade_002_shade_007_wet_015_normal.jpg` | 677531 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark002_shade_002_shade_007_wet_015_rough.jpg` | 327131 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_albedo.jpg` | 568345 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_dry_016_albedo.jpg` | 538307 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_dry_016_normal.jpg` | 586009 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_dry_016_rough.jpg` | 266838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_late_004_albedo.jpg` | 506351 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_late_004_late_009_albedo.jpg` | 487829 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_late_004_late_009_normal.jpg` | 586009 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_late_004_late_009_rake_018_albedo.jpg` | 490311 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_late_004_late_009_rake_018_normal.jpg` | 586009 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_late_004_late_009_rake_018_rough.jpg` | 266838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_late_004_late_009_rough.jpg` | 266838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_late_004_normal.jpg` | 586009 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_late_004_rough.jpg` | 266838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_late_004_shade_017_albedo.jpg` | 424800 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_late_004_shade_017_normal.jpg` | 586009 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_late_004_shade_017_rough.jpg` | 266838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_normal.jpg` | 586009 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_rake_008_albedo.jpg` | 544546 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_rake_008_late_019_albedo.jpg` | 528778 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_rake_008_late_019_normal.jpg` | 586009 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_rake_008_late_019_rough.jpg` | 266838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_rake_008_normal.jpg` | 586009 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_rake_008_rough.jpg` | 266838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_rough.jpg` | 266838 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_shade_002_albedo.jpg` | 357815 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_shade_002_normal.jpg` | 586009 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_shade_002_rough.jpg` | 266838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_shade_002_wet_005_albedo.jpg` | 326968 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_shade_002_wet_005_dry_011_albedo.jpg` | 327524 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_shade_002_wet_005_dry_011_normal.jpg` | 586009 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_shade_002_wet_005_dry_011_rough.jpg` | 266838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_shade_002_wet_005_dry_011_shade_022_albedo.jpg` | 270920 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_shade_002_wet_005_dry_011_shade_022_normal.jpg` | 586009 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_shade_002_wet_005_dry_011_shade_022_rough.jpg` | 266838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_shade_002_wet_005_dry_021_albedo.jpg` | 327524 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_shade_002_wet_005_dry_021_normal.jpg` | 586009 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_shade_002_wet_005_dry_021_rough.jpg` | 266838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_shade_002_wet_005_normal.jpg` | 586009 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_shade_002_wet_005_rough.jpg` | 266838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_shade_002_wet_010_albedo.jpg` | 326968 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_shade_002_wet_010_normal.jpg` | 586009 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_shade_002_wet_010_rake_023_albedo.jpg` | 329098 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_shade_002_wet_010_rake_023_normal.jpg` | 586009 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_shade_002_wet_010_rake_023_rough.jpg` | 266838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_shade_002_wet_010_rough.jpg` | 266838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_shade_002_wet_020_albedo.jpg` | 326968 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark006_shade_002_wet_020_normal.jpg` | 586009 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark006_shade_002_wet_020_rough.jpg` | 266838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_albedo.jpg` | 570880 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_dry_006_albedo.jpg` | 543691 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_dry_006_normal.jpg` | 680618 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_dry_006_rake_013_albedo.jpg` | 547491 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_dry_006_rake_013_dry_026_albedo.jpg` | 545087 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_dry_006_rake_013_dry_026_normal.jpg` | 680618 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_dry_006_rake_013_dry_026_rough.jpg` | 278044 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_dry_006_rake_013_normal.jpg` | 680618 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_dry_006_rake_013_rough.jpg` | 278044 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_dry_006_rough.jpg` | 278044 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_dry_006_wet_025_albedo.jpg` | 485862 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_dry_006_wet_025_normal.jpg` | 680618 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_dry_006_wet_025_rough.jpg` | 278044 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_late_024_albedo.jpg` | 512216 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_late_024_normal.jpg` | 680618 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_late_024_rough.jpg` | 278044 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_normal.jpg` | 680618 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_rake_003_albedo.jpg` | 551147 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_rake_003_late_014_albedo.jpg` | 533692 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_rake_003_late_014_normal.jpg` | 680618 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_rake_003_late_014_rake_028_albedo.jpg` | 536645 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_rake_003_late_014_rake_028_normal.jpg` | 680618 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_rake_003_late_014_rake_028_rough.jpg` | 278044 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_rake_003_late_014_rough.jpg` | 278044 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_rake_003_normal.jpg` | 680618 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_rake_003_rough.jpg` | 278044 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_rake_003_shade_007_albedo.jpg` | 455380 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_rake_003_shade_007_late_029_albedo.jpg` | 444751 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_rake_003_shade_007_late_029_normal.jpg` | 680618 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_rake_003_shade_007_late_029_rough.jpg` | 278044 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_rake_003_shade_007_normal.jpg` | 680618 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_rake_003_shade_007_rough.jpg` | 278044 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_rake_003_shade_007_wet_015_albedo.jpg` | 410046 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_rake_003_shade_007_wet_015_normal.jpg` | 680618 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_rake_003_shade_007_wet_015_rough.jpg` | 278044 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_rake_003_shade_007_wet_015_wet_030_albedo.jpg` | 371685 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_rake_003_shade_007_wet_015_wet_030_normal.jpg` | 680618 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_rake_003_shade_007_wet_015_wet_030_rough.jpg` | 278044 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_rake_003_shade_027_albedo.jpg` | 455380 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_rake_003_shade_027_normal.jpg` | 680618 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_rake_003_shade_027_rough.jpg` | 278044 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_rough.jpg` | 278044 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_shade_012_albedo.jpg` | 363349 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_shade_012_dry_031_albedo.jpg` | 364022 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark007_shade_012_dry_031_normal.jpg` | 680618 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_shade_012_dry_031_rough.jpg` | 278044 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_shade_012_normal.jpg` | 680618 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark007_shade_012_rough.jpg` | 278044 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_albedo.jpg` | 531980 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_dry_016_albedo.jpg` | 509727 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_dry_016_normal.jpg` | 653097 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_dry_016_rake_033_albedo.jpg` | 513855 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_dry_016_rake_033_normal.jpg` | 653097 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_dry_016_rake_033_rough.jpg` | 375158 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_dry_016_rough.jpg` | 375158 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_late_004_albedo.jpg` | 482100 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_late_004_late_009_albedo.jpg` | 468156 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_late_004_late_009_normal.jpg` | 653097 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_late_004_late_009_rake_018_albedo.jpg` | 470704 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_late_004_late_009_rake_018_dry_036_albedo.jpg` | 469958 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_late_004_late_009_rake_018_dry_036_normal.jpg` | 653097 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_late_004_late_009_rake_018_dry_036_rough.jpg` | 375158 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_late_004_late_009_rake_018_normal.jpg` | 653097 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_late_004_late_009_rake_018_rough.jpg` | 375158 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_late_004_late_009_rough.jpg` | 375158 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_late_004_late_009_wet_035_albedo.jpg` | 422450 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_late_004_late_009_wet_035_normal.jpg` | 653097 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_late_004_late_009_wet_035_rough.jpg` | 375158 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_late_004_late_034_albedo.jpg` | 468156 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_late_004_late_034_normal.jpg` | 653097 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_late_004_late_034_rough.jpg` | 375158 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_late_004_normal.jpg` | 653097 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_late_004_rough.jpg` | 375158 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_late_004_shade_017_albedo.jpg` | 402101 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_late_004_shade_017_normal.jpg` | 653097 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_late_004_shade_017_rough.jpg` | 375158 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_late_004_shade_017_shade_037_albedo.jpg` | 328824 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_late_004_shade_017_shade_037_normal.jpg` | 653097 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_late_004_shade_017_shade_037_rough.jpg` | 375158 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_normal.jpg` | 653097 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_rake_008_albedo.jpg` | 515320 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_rake_008_late_019_albedo.jpg` | 504025 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_rake_008_late_019_late_039_albedo.jpg` | 488987 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_rake_008_late_019_late_039_normal.jpg` | 653097 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_rake_008_late_019_late_039_rough.jpg` | 375158 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_rake_008_late_019_normal.jpg` | 653097 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_rake_008_late_019_rough.jpg` | 375158 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_rake_008_normal.jpg` | 653097 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_rake_008_rake_038_albedo.jpg` | 519997 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_rake_008_rake_038_normal.jpg` | 653097 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_rake_008_rake_038_rough.jpg` | 375158 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_rake_008_rough.jpg` | 375158 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_rough.jpg` | 375158 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_shade_032_albedo.jpg` | 331596 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_bark012_shade_032_normal.jpg` | 653097 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_bark012_shade_032_rough.jpg` | 375158 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_albedo.jpg` | 305179 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_normal.jpg` | 314862 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_rough.jpg` | 154418 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_wet_005_albedo.jpg` | 262629 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_011_albedo.jpg` | 262978 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_011_normal.jpg` | 314862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_011_rough.jpg` | 154418 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_011_shade_022_albedo.jpg` | 207480 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_011_shade_022_normal.jpg` | 314862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_011_shade_022_rake_043_albedo.jpg` | 208712 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_011_shade_022_rake_043_normal.jpg` | 314862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_011_shade_022_rake_043_rough.jpg` | 154418 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_011_shade_022_rough.jpg` | 154418 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_011_shade_042_albedo.jpg` | 207480 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_011_shade_042_normal.jpg` | 314862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_011_shade_042_rough.jpg` | 154418 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_021_albedo.jpg` | 262978 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_021_late_044_albedo.jpg` | 253821 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_021_late_044_normal.jpg` | 314862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_021_late_044_rough.jpg` | 154418 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_021_normal.jpg` | 314862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_021_rough.jpg` | 154418 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_041_albedo.jpg` | 262978 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_041_normal.jpg` | 314862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_005_dry_041_rough.jpg` | 154418 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_005_normal.jpg` | 314862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_005_rough.jpg` | 154418 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_010_albedo.jpg` | 262629 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_wet_010_normal.jpg` | 314862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_010_rake_023_albedo.jpg` | 263876 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_wet_010_rake_023_dry_046_albedo.jpg` | 264016 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_wet_010_rake_023_dry_046_normal.jpg` | 314862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_010_rake_023_dry_046_rough.jpg` | 154418 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_010_rake_023_normal.jpg` | 314862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_010_rake_023_rough.jpg` | 154418 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_010_rough.jpg` | 154418 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_010_wet_045_albedo.jpg` | 238137 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_wet_010_wet_045_normal.jpg` | 314862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_010_wet_045_rough.jpg` | 154418 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_020_albedo.jpg` | 262629 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_wet_020_normal.jpg` | 314862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_020_rough.jpg` | 154418 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_020_shade_047_albedo.jpg` | 209608 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_wet_020_shade_047_normal.jpg` | 314862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_020_shade_047_rough.jpg` | 154418 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_040_albedo.jpg` | 262629 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric001_wet_040_normal.jpg` | 314862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric001_wet_040_rough.jpg` | 154418 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_albedo.jpg` | 53420 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_dry_006_albedo.jpg` | 56782 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_dry_006_late_049_albedo.jpg` | 58967 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_dry_006_late_049_normal.jpg` | 134464 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_dry_006_late_049_rough.jpg` | 165303 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_dry_006_normal.jpg` | 134464 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_dry_006_rake_013_albedo.jpg` | 63255 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_dry_006_rake_013_dry_026_albedo.jpg` | 66640 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_dry_006_rake_013_dry_026_dry_051_albedo.jpg` | 70178 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_dry_006_rake_013_dry_026_dry_051_normal.jpg` | 134464 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_dry_006_rake_013_dry_026_dry_051_rough.jpg` | 165303 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_dry_006_rake_013_dry_026_normal.jpg` | 134464 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_dry_006_rake_013_dry_026_rough.jpg` | 165303 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_dry_006_rake_013_normal.jpg` | 134464 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_dry_006_rake_013_rough.jpg` | 165303 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_dry_006_rake_013_wet_050_albedo.jpg` | 59723 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_dry_006_rake_013_wet_050_normal.jpg` | 134464 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_dry_006_rake_013_wet_050_rough.jpg` | 165303 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_dry_006_rough.jpg` | 165303 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_dry_006_wet_025_albedo.jpg` | 55029 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_dry_006_wet_025_normal.jpg` | 134464 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_dry_006_wet_025_rough.jpg` | 165303 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_dry_006_wet_025_shade_052_albedo.jpg` | 41321 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_dry_006_wet_025_shade_052_normal.jpg` | 134464 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_dry_006_wet_025_shade_052_rough.jpg` | 165303 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_late_024_albedo.jpg` | 56780 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_late_024_normal.jpg` | 134464 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_late_024_rake_053_albedo.jpg` | 63558 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_late_024_rake_053_normal.jpg` | 134464 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_late_024_rake_053_rough.jpg` | 165303 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_late_024_rough.jpg` | 165303 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_normal.jpg` | 134464 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_rake_048_albedo.jpg` | 59105 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_rake_048_normal.jpg` | 134464 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_rake_048_rough.jpg` | 165303 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_rough.jpg` | 165303 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_shade_012_albedo.jpg` | 43293 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_shade_012_late_054_albedo.jpg` | 42268 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_shade_012_late_054_normal.jpg` | 134464 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_shade_012_late_054_rough.jpg` | 165303 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_shade_012_normal.jpg` | 134464 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_shade_012_rough.jpg` | 165303 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_shade_012_shade_027_albedo.jpg` | 33014 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_shade_012_shade_027_normal.jpg` | 134464 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_shade_012_shade_027_rough.jpg` | 165303 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_shade_012_shade_027_wet_055_albedo.jpg` | 31298 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric004_shade_012_shade_027_wet_055_normal.jpg` | 134464 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric004_shade_012_shade_027_wet_055_rough.jpg` | 165303 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_albedo.jpg` | 239780 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_dry_056_albedo.jpg` | 232919 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_dry_056_normal.jpg` | 274332 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_dry_056_rough.jpg` | 145407 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_late_014_albedo.jpg` | 224955 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_late_014_late_029_albedo.jpg` | 221094 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_late_014_late_029_normal.jpg` | 274332 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_late_014_late_029_rake_058_albedo.jpg` | 223117 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_late_014_late_029_rake_058_normal.jpg` | 274332 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_late_014_late_029_rake_058_rough.jpg` | 145407 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_late_014_late_029_rough.jpg` | 145407 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_late_014_normal.jpg` | 274332 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_late_014_rough.jpg` | 145407 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_late_014_shade_057_albedo.jpg` | 182299 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_late_014_shade_057_normal.jpg` | 274332 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_late_014_shade_057_rough.jpg` | 145407 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_normal.jpg` | 274332 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_rake_028_albedo.jpg` | 235989 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_rake_028_late_059_albedo.jpg` | 233306 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_rake_028_late_059_normal.jpg` | 274332 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_rake_028_late_059_rough.jpg` | 145407 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_rake_028_normal.jpg` | 274332 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_rake_028_rough.jpg` | 145407 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_rough.jpg` | 145407 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_shade_007_albedo.jpg` | 150949 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_shade_007_normal.jpg` | 274332 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_shade_007_rough.jpg` | 145407 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_015_albedo.jpg` | 138817 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_015_dry_031_albedo.jpg` | 141221 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_015_dry_031_normal.jpg` | 274332 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_015_dry_031_rough.jpg` | 145407 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_015_dry_031_shade_062_albedo.jpg` | 110715 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_015_dry_031_shade_062_normal.jpg` | 274332 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_015_dry_031_shade_062_rough.jpg` | 145407 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_015_dry_061_albedo.jpg` | 141221 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_015_dry_061_normal.jpg` | 274332 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_015_dry_061_rough.jpg` | 145407 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_015_normal.jpg` | 274332 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_015_rough.jpg` | 145407 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_030_albedo.jpg` | 138817 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_030_normal.jpg` | 274332 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_030_rake_063_albedo.jpg` | 141424 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_030_rake_063_normal.jpg` | 274332 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_030_rake_063_rough.jpg` | 145407 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_030_rough.jpg` | 145407 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_060_albedo.jpg` | 138817 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_060_normal.jpg` | 274332 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric018_shade_007_wet_060_rough.jpg` | 145407 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_albedo.jpg` | 247618 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_dry_016_albedo.jpg` | 235168 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_dry_016_normal.jpg` | 293764 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_dry_016_rake_033_albedo.jpg` | 236489 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_dry_016_rake_033_dry_066_albedo.jpg` | 236328 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_dry_016_rake_033_dry_066_normal.jpg` | 293764 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_dry_016_rake_033_dry_066_rough.jpg` | 161703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_dry_016_rake_033_normal.jpg` | 293764 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_dry_016_rake_033_rough.jpg` | 161703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_dry_016_rough.jpg` | 161703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_dry_016_wet_065_albedo.jpg` | 212931 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_dry_016_wet_065_normal.jpg` | 293764 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_dry_016_wet_065_rough.jpg` | 161703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_late_064_albedo.jpg` | 218778 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_late_064_normal.jpg` | 293764 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_late_064_rough.jpg` | 161703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_normal.jpg` | 293764 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_rake_008_albedo.jpg` | 238938 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_rake_008_late_034_albedo.jpg` | 227958 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_rake_008_late_034_normal.jpg` | 293764 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_rake_008_late_034_rake_068_albedo.jpg` | 230330 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_rake_008_late_034_rake_068_normal.jpg` | 293764 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_rake_008_late_034_rake_068_rough.jpg` | 161703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_rake_008_late_034_rough.jpg` | 161703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_rake_008_normal.jpg` | 293764 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_rake_008_rough.jpg` | 161703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_rake_008_shade_017_albedo.jpg` | 187970 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_rake_008_shade_017_late_069_albedo.jpg` | 180914 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_rake_008_shade_017_late_069_normal.jpg` | 293764 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_rake_008_shade_017_late_069_rough.jpg` | 161703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_rake_008_shade_017_normal.jpg` | 293764 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_rake_008_shade_017_rough.jpg` | 161703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_rake_008_shade_017_wet_035_albedo.jpg` | 170450 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_rake_008_shade_017_wet_035_normal.jpg` | 293764 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_rake_008_shade_017_wet_035_rough.jpg` | 161703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_rake_008_shade_017_wet_035_wet_070_albedo.jpg` | 158705 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_rake_008_shade_017_wet_035_wet_070_normal.jpg` | 293764 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_rake_008_shade_017_wet_035_wet_070_rough.jpg` | 161703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_rake_008_shade_067_albedo.jpg` | 187970 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_rake_008_shade_067_normal.jpg` | 293764 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_rake_008_shade_067_rough.jpg` | 161703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_rough.jpg` | 161703 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_shade_032_albedo.jpg` | 151635 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_shade_032_dry_071_albedo.jpg` | 152326 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_fabric046_shade_032_dry_071_normal.jpg` | 293764 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_shade_032_dry_071_rough.jpg` | 161703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_shade_032_normal.jpg` | 293764 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_fabric046_shade_032_rough.jpg` | 161703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_albedo.jpg` | 437255 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_dry_036_albedo.jpg` | 401459 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_dry_036_normal.jpg` | 602443 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_dry_036_rake_073_albedo.jpg` | 402173 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_dry_036_rake_073_normal.jpg` | 602443 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_dry_036_rake_073_rough.jpg` | 499573 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_dry_036_rough.jpg` | 499573 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_late_009_albedo.jpg` | 370152 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_late_009_late_019_albedo.jpg` | 356137 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_late_009_late_019_normal.jpg` | 602443 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_late_009_late_019_rake_038_albedo.jpg` | 358137 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_late_009_late_019_rake_038_dry_076_albedo.jpg` | 358265 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_late_009_late_019_rake_038_dry_076_normal.jpg` | 602443 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_late_009_late_019_rake_038_dry_076_rough.jpg` | 499573 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_late_009_late_019_rake_038_normal.jpg` | 602443 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_late_009_late_019_rake_038_rough.jpg` | 499573 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_late_009_late_019_rough.jpg` | 499573 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_late_009_late_019_wet_075_albedo.jpg` | 325440 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_late_009_late_019_wet_075_normal.jpg` | 602443 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_late_009_late_019_wet_075_rough.jpg` | 499573 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_late_009_late_074_albedo.jpg` | 356137 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_late_009_late_074_normal.jpg` | 602443 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_late_009_late_074_rough.jpg` | 499573 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_late_009_normal.jpg` | 602443 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_late_009_rough.jpg` | 499573 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_late_009_shade_037_albedo.jpg` | 300181 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_late_009_shade_037_normal.jpg` | 602443 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_late_009_shade_037_rough.jpg` | 499573 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_late_009_shade_037_shade_077_albedo.jpg` | 237464 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_late_009_shade_037_shade_077_normal.jpg` | 602443 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_late_009_shade_037_shade_077_rough.jpg` | 499573 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_normal.jpg` | 602443 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_rake_018_albedo.jpg` | 407157 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_rake_018_late_039_albedo.jpg` | 383459 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_rake_018_late_039_late_079_albedo.jpg` | 370604 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_rake_018_late_039_late_079_normal.jpg` | 602443 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_rake_018_late_039_late_079_rough.jpg` | 499573 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_rake_018_late_039_normal.jpg` | 602443 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_rake_018_late_039_rough.jpg` | 499573 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_rake_018_normal.jpg` | 602443 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_rake_018_rake_078_albedo.jpg` | 407846 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_rake_018_rake_078_normal.jpg` | 602443 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_rake_018_rake_078_rough.jpg` | 499573 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_rake_018_rough.jpg` | 499573 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_rough.jpg` | 499573 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_shade_072_albedo.jpg` | 248618 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass001_shade_072_normal.jpg` | 602443 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass001_shade_072_rough.jpg` | 499573 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_albedo.jpg` | 428268 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_normal.jpg` | 599306 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_rough.jpg` | 521932 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_wet_010_albedo.jpg` | 352106 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_wet_010_dry_021_albedo.jpg` | 350305 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_wet_010_dry_021_normal.jpg` | 599306 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_010_dry_021_rough.jpg` | 521932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_010_dry_021_shade_042_albedo.jpg` | 284185 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_wet_010_dry_021_shade_042_normal.jpg` | 599306 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_010_dry_021_shade_042_rake_083_albedo.jpg` | 285562 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_wet_010_dry_021_shade_042_rake_083_normal.jpg` | 599306 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_010_dry_021_shade_042_rake_083_rough.jpg` | 521932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_010_dry_021_shade_042_rough.jpg` | 521932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_010_dry_021_shade_082_albedo.jpg` | 284185 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_wet_010_dry_021_shade_082_normal.jpg` | 599306 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_010_dry_021_shade_082_rough.jpg` | 521932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_010_dry_041_albedo.jpg` | 350305 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_wet_010_dry_041_late_084_albedo.jpg` | 334402 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_wet_010_dry_041_late_084_normal.jpg` | 599306 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_010_dry_041_late_084_rough.jpg` | 521932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_010_dry_041_normal.jpg` | 599306 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_010_dry_041_rough.jpg` | 521932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_010_dry_081_albedo.jpg` | 350305 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_wet_010_dry_081_normal.jpg` | 599306 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_010_dry_081_rough.jpg` | 521932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_010_normal.jpg` | 599306 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_010_rough.jpg` | 521932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_020_albedo.jpg` | 352106 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_wet_020_normal.jpg` | 599306 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_020_rake_043_albedo.jpg` | 352358 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_wet_020_rake_043_dry_086_albedo.jpg` | 351256 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_wet_020_rake_043_dry_086_normal.jpg` | 599306 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_020_rake_043_dry_086_rough.jpg` | 521932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_020_rake_043_normal.jpg` | 599306 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_020_rake_043_rough.jpg` | 521932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_020_rough.jpg` | 521932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_020_wet_085_albedo.jpg` | 320867 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_wet_020_wet_085_normal.jpg` | 599306 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_020_wet_085_rough.jpg` | 521932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_040_albedo.jpg` | 352106 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_wet_040_normal.jpg` | 599306 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_040_rough.jpg` | 521932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_040_shade_087_albedo.jpg` | 284595 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_wet_040_shade_087_normal.jpg` | 599306 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_040_shade_087_rough.jpg` | 521932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_080_albedo.jpg` | 352106 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass002_wet_080_normal.jpg` | 599306 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass002_wet_080_rough.jpg` | 521932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_albedo.jpg` | 580748 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_dry_011_albedo.jpg` | 520083 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_dry_011_late_089_albedo.jpg` | 491165 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_dry_011_late_089_normal.jpg` | 602637 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_dry_011_late_089_rough.jpg` | 531080 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_dry_011_normal.jpg` | 602637 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_dry_011_rake_023_albedo.jpg` | 518779 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_dry_011_rake_023_dry_046_albedo.jpg` | 516939 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_dry_011_rake_023_dry_046_dry_091_albedo.jpg` | 516089 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_dry_011_rake_023_dry_046_dry_091_normal.jpg` | 602637 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_dry_011_rake_023_dry_046_dry_091_rough.jpg` | 531080 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_dry_011_rake_023_dry_046_normal.jpg` | 602637 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_dry_011_rake_023_dry_046_rough.jpg` | 531080 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_dry_011_rake_023_normal.jpg` | 602637 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_dry_011_rake_023_rough.jpg` | 531080 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_dry_011_rake_023_wet_090_albedo.jpg` | 463951 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_dry_011_rake_023_wet_090_normal.jpg` | 602637 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_dry_011_rake_023_wet_090_rough.jpg` | 531080 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_dry_011_rough.jpg` | 531080 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_dry_011_wet_045_albedo.jpg` | 463189 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_dry_011_wet_045_normal.jpg` | 602637 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_dry_011_wet_045_rough.jpg` | 531080 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_dry_011_wet_045_shade_092_albedo.jpg` | 376415 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_dry_011_wet_045_shade_092_normal.jpg` | 602637 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_dry_011_wet_045_shade_092_rough.jpg` | 531080 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_late_044_albedo.jpg` | 477540 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_late_044_normal.jpg` | 602637 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_late_044_rake_093_albedo.jpg` | 479306 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_late_044_rake_093_normal.jpg` | 602637 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_late_044_rake_093_rough.jpg` | 531080 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_late_044_rough.jpg` | 531080 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_normal.jpg` | 602637 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_rake_088_albedo.jpg` | 527838 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_rake_088_normal.jpg` | 602637 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_rake_088_rough.jpg` | 531080 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_rough.jpg` | 531080 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_shade_022_albedo.jpg` | 339050 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_shade_022_late_094_albedo.jpg` | 317313 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_shade_022_late_094_normal.jpg` | 602637 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_shade_022_late_094_rough.jpg` | 531080 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_shade_022_normal.jpg` | 602637 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_shade_022_rough.jpg` | 531080 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_shade_022_shade_047_albedo.jpg` | 270794 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_shade_022_shade_047_normal.jpg` | 602637 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_shade_022_shade_047_rough.jpg` | 531080 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_shade_022_shade_047_wet_095_albedo.jpg` | 247807 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass004_shade_022_shade_047_wet_095_normal.jpg` | 602637 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass004_shade_022_shade_047_wet_095_rough.jpg` | 531080 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_albedo.jpg` | 512293 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_dry_096_albedo.jpg` | 460586 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_dry_096_normal.jpg` | 485356 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_dry_096_rough.jpg` | 530775 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_late_024_albedo.jpg` | 424748 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_late_024_late_049_albedo.jpg` | 407901 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_late_024_late_049_normal.jpg` | 485356 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_late_024_late_049_rake_098_albedo.jpg` | 410047 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_late_024_late_049_rake_098_normal.jpg` | 485356 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_late_024_late_049_rake_098_rough.jpg` | 530775 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_late_024_late_049_rough.jpg` | 530775 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_late_024_normal.jpg` | 485356 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_late_024_rough.jpg` | 530775 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_late_024_shade_097_albedo.jpg` | 349004 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_late_024_shade_097_normal.jpg` | 485356 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_late_024_shade_097_rough.jpg` | 530775 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_normal.jpg` | 485356 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_rake_048_albedo.jpg` | 467329 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_rake_048_late_099_albedo.jpg` | 440852 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_rake_048_late_099_normal.jpg` | 485356 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_rake_048_late_099_rough.jpg` | 530775 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_rake_048_normal.jpg` | 485356 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_rake_048_rough.jpg` | 530775 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_rough.jpg` | 530775 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_shade_012_albedo.jpg` | 288280 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_shade_012_normal.jpg` | 485356 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_shade_012_rough.jpg` | 530775 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_shade_012_wet_025_albedo.jpg` | 261588 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_shade_012_wet_025_dry_051_albedo.jpg` | 260960 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_shade_012_wet_025_dry_051_normal.jpg` | 485356 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_shade_012_wet_025_dry_051_rough.jpg` | 530775 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_shade_012_wet_025_dry_051_shade_102_albedo.jpg` | 205308 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_shade_012_wet_025_dry_051_shade_102_normal.jpg` | 485356 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_shade_012_wet_025_dry_051_shade_102_rough.jpg` | 530775 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_shade_012_wet_025_dry_101_albedo.jpg` | 260960 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_shade_012_wet_025_dry_101_normal.jpg` | 485356 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_shade_012_wet_025_dry_101_rough.jpg` | 530775 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_shade_012_wet_025_normal.jpg` | 485356 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_shade_012_wet_025_rough.jpg` | 530775 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_shade_012_wet_050_albedo.jpg` | 261588 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_shade_012_wet_050_normal.jpg` | 485356 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_shade_012_wet_050_rake_103_albedo.jpg` | 263088 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_shade_012_wet_050_rake_103_normal.jpg` | 485356 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_shade_012_wet_050_rake_103_rough.jpg` | 530775 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_shade_012_wet_050_rough.jpg` | 530775 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_shade_012_wet_100_albedo.jpg` | 261588 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass005_shade_012_wet_100_normal.jpg` | 485356 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass005_shade_012_wet_100_rough.jpg` | 530775 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_albedo.jpg` | 496653 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_dry_026_albedo.jpg` | 448782 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_dry_026_normal.jpg` | 508185 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_dry_026_rake_053_albedo.jpg` | 447853 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_dry_026_rake_053_dry_106_albedo.jpg` | 446045 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_dry_026_rake_053_dry_106_normal.jpg` | 508185 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_dry_026_rake_053_dry_106_rough.jpg` | 452473 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_dry_026_rake_053_normal.jpg` | 508185 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_dry_026_rake_053_rough.jpg` | 452473 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_dry_026_rough.jpg` | 452473 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_dry_026_wet_105_albedo.jpg` | 404060 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_dry_026_wet_105_normal.jpg` | 508185 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_dry_026_wet_105_rough.jpg` | 452473 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_late_104_albedo.jpg` | 413425 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_late_104_normal.jpg` | 508185 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_late_104_rough.jpg` | 452473 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_normal.jpg` | 508185 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_rake_013_albedo.jpg` | 455078 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_rake_013_late_054_albedo.jpg` | 426495 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_rake_013_late_054_normal.jpg` | 508185 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_rake_013_late_054_rake_108_albedo.jpg` | 428248 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_rake_013_late_054_rake_108_normal.jpg` | 508185 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_rake_013_late_054_rake_108_rough.jpg` | 452473 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_rake_013_late_054_rough.jpg` | 452473 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_rake_013_normal.jpg` | 508185 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_rake_013_rough.jpg` | 452473 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_rake_013_shade_027_albedo.jpg` | 364489 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_rake_013_shade_027_late_109_albedo.jpg` | 349298 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_rake_013_shade_027_late_109_normal.jpg` | 508185 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_rake_013_shade_027_late_109_rough.jpg` | 452473 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_rake_013_shade_027_normal.jpg` | 508185 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_rake_013_shade_027_rough.jpg` | 452473 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_rake_013_shade_027_wet_055_albedo.jpg` | 330499 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_rake_013_shade_027_wet_055_normal.jpg` | 508185 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_rake_013_shade_027_wet_055_rough.jpg` | 452473 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_rake_013_shade_027_wet_055_wet_110_albedo.jpg` | 301868 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_rake_013_shade_027_wet_055_wet_110_normal.jpg` | 508185 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_rake_013_shade_027_wet_055_wet_110_rough.jpg` | 452473 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_rake_013_shade_107_albedo.jpg` | 364489 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_rake_013_shade_107_normal.jpg` | 508185 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_rake_013_shade_107_rough.jpg` | 452473 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_rough.jpg` | 452473 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_shade_052_albedo.jpg` | 285264 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_shade_052_dry_111_albedo.jpg` | 283241 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass006_shade_052_dry_111_normal.jpg` | 508185 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_shade_052_dry_111_rough.jpg` | 452473 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_shade_052_normal.jpg` | 508185 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass006_shade_052_rough.jpg` | 452473 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_albedo.jpg` | 453168 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_dry_056_albedo.jpg` | 409617 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_dry_056_normal.jpg` | 511680 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_dry_056_rake_113_albedo.jpg` | 408860 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_dry_056_rake_113_normal.jpg` | 511680 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_dry_056_rake_113_rough.jpg` | 323862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_dry_056_rough.jpg` | 323862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_late_014_albedo.jpg` | 376901 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_late_014_late_029_albedo.jpg` | 359979 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_late_014_late_029_normal.jpg` | 511680 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_late_014_late_029_rake_058_albedo.jpg` | 361831 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_late_014_late_029_rake_058_dry_116_albedo.jpg` | 361978 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_late_014_late_029_rake_058_dry_116_normal.jpg` | 511680 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_late_014_late_029_rake_058_dry_116_rough.jpg` | 323862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_late_014_late_029_rake_058_normal.jpg` | 511680 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_late_014_late_029_rake_058_rough.jpg` | 323862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_late_014_late_029_rough.jpg` | 323862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_late_014_late_029_wet_115_albedo.jpg` | 328767 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_late_014_late_029_wet_115_normal.jpg` | 511680 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_late_014_late_029_wet_115_rough.jpg` | 323862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_late_014_late_114_albedo.jpg` | 359979 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_late_014_late_114_normal.jpg` | 511680 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_late_014_late_114_rough.jpg` | 323862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_late_014_normal.jpg` | 511680 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_late_014_rough.jpg` | 323862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_late_014_shade_057_albedo.jpg` | 306951 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_late_014_shade_057_normal.jpg` | 511680 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_late_014_shade_057_rough.jpg` | 323862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_late_014_shade_057_shade_117_albedo.jpg` | 245657 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_late_014_shade_057_shade_117_normal.jpg` | 511680 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_late_014_shade_057_shade_117_rough.jpg` | 323862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_normal.jpg` | 511680 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_rake_028_albedo.jpg` | 415430 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_rake_028_late_059_albedo.jpg` | 387468 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_rake_028_late_059_late_119_albedo.jpg` | 372751 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_rake_028_late_059_late_119_normal.jpg` | 511680 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_rake_028_late_059_late_119_rough.jpg` | 323862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_rake_028_late_059_normal.jpg` | 511680 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_rake_028_late_059_rough.jpg` | 323862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_rake_028_normal.jpg` | 511680 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_rake_028_rake_118_albedo.jpg` | 415061 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_rake_028_rake_118_normal.jpg` | 511680 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_rake_028_rake_118_rough.jpg` | 323862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_rake_028_rough.jpg` | 323862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_rough.jpg` | 323862 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_shade_112_albedo.jpg` | 261005 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_grass007_shade_112_normal.jpg` | 511680 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_grass007_shade_112_rough.jpg` | 323862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_albedo.jpg` | 638070 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_normal.jpg` | 717816 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_rough.jpg` | 316732 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_wet_015_albedo.jpg` | 543166 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_031_albedo.jpg` | 545108 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_031_normal.jpg` | 717816 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_031_rough.jpg` | 316732 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_031_shade_062_albedo.jpg` | 452456 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_031_shade_062_normal.jpg` | 717816 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_031_shade_062_rake_123_albedo.jpg` | 455933 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_031_shade_062_rake_123_normal.jpg` | 717816 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_031_shade_062_rake_123_rough.jpg` | 316732 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_031_shade_062_rough.jpg` | 316732 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_031_shade_122_albedo.jpg` | 452456 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_031_shade_122_normal.jpg` | 717816 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_031_shade_122_rough.jpg` | 316732 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_061_albedo.jpg` | 545108 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_061_late_124_albedo.jpg` | 536906 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_061_late_124_normal.jpg` | 717816 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_061_late_124_rough.jpg` | 316732 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_061_normal.jpg` | 717816 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_061_rough.jpg` | 316732 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_121_albedo.jpg` | 545108 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_121_normal.jpg` | 717816 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_015_dry_121_rough.jpg` | 316732 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_015_normal.jpg` | 717816 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_015_rough.jpg` | 316732 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_030_albedo.jpg` | 543166 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_wet_030_normal.jpg` | 717816 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_030_rake_063_albedo.jpg` | 547764 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_wet_030_rake_063_dry_126_albedo.jpg` | 550051 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_wet_030_rake_063_dry_126_normal.jpg` | 717816 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_030_rake_063_dry_126_rough.jpg` | 316732 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_030_rake_063_normal.jpg` | 717816 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_030_rake_063_rough.jpg` | 316732 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_030_rough.jpg` | 316732 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_030_wet_125_albedo.jpg` | 486101 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_wet_030_wet_125_normal.jpg` | 717816 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_030_wet_125_rough.jpg` | 316732 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_060_albedo.jpg` | 543166 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_wet_060_normal.jpg` | 717816 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_060_rough.jpg` | 316732 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_060_shade_127_albedo.jpg` | 450565 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_wet_060_shade_127_normal.jpg` | 717816 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_060_shade_127_rough.jpg` | 316732 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_120_albedo.jpg` | 543166 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel015_wet_120_normal.jpg` | 717816 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel015_wet_120_rough.jpg` | 316732 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_albedo.jpg` | 433980 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_dry_016_albedo.jpg` | 422650 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_dry_016_late_129_albedo.jpg` | 419119 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_dry_016_late_129_normal.jpg` | 587034 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_dry_016_late_129_rough.jpg` | 273320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_dry_016_normal.jpg` | 587034 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_dry_016_rake_033_albedo.jpg` | 430731 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_dry_016_rake_033_dry_066_albedo.jpg` | 432695 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_dry_016_rake_033_dry_066_dry_131_albedo.jpg` | 429997 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_dry_016_rake_033_dry_066_dry_131_normal.jpg` | 587034 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_dry_016_rake_033_dry_066_dry_131_rough.jpg` | 273320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_dry_016_rake_033_dry_066_normal.jpg` | 587034 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_dry_016_rake_033_dry_066_rough.jpg` | 273320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_dry_016_rake_033_normal.jpg` | 587034 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_dry_016_rake_033_rough.jpg` | 273320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_dry_016_rake_033_wet_130_albedo.jpg` | 396015 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_dry_016_rake_033_wet_130_normal.jpg` | 587034 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_dry_016_rake_033_wet_130_rough.jpg` | 273320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_dry_016_rough.jpg` | 273320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_dry_016_wet_065_albedo.jpg` | 389705 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_dry_016_wet_065_normal.jpg` | 587034 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_dry_016_wet_065_rough.jpg` | 273320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_dry_016_wet_065_shade_132_albedo.jpg` | 327091 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_dry_016_wet_065_shade_132_normal.jpg` | 587034 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_dry_016_wet_065_shade_132_rough.jpg` | 273320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_late_064_albedo.jpg` | 413459 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_late_064_normal.jpg` | 587034 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_late_064_rake_133_albedo.jpg` | 417189 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_late_064_rake_133_normal.jpg` | 587034 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_late_064_rake_133_rough.jpg` | 273320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_late_064_rough.jpg` | 273320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_normal.jpg` | 587034 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_rake_128_albedo.jpg` | 427705 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_rake_128_normal.jpg` | 587034 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_rake_128_rough.jpg` | 273320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_rough.jpg` | 273320 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_shade_032_albedo.jpg` | 271926 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_shade_032_late_134_albedo.jpg` | 271113 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_shade_032_late_134_normal.jpg` | 587034 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_shade_032_late_134_rough.jpg` | 273320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_shade_032_normal.jpg` | 587034 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_shade_032_rough.jpg` | 273320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_shade_032_shade_067_albedo.jpg` | 227379 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_shade_032_shade_067_normal.jpg` | 587034 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_shade_032_shade_067_rough.jpg` | 273320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_shade_032_shade_067_wet_135_albedo.jpg` | 210098 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel020_shade_032_shade_067_wet_135_normal.jpg` | 587034 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel020_shade_032_shade_067_wet_135_rough.jpg` | 273320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_albedo.jpg` | 127921 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_dry_136_albedo.jpg` | 62837 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_dry_136_normal.jpg` | 676341 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_dry_136_rough.jpg` | 222871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_late_034_albedo.jpg` | 74272 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_late_034_late_069_albedo.jpg` | 58102 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_late_034_late_069_normal.jpg` | 676341 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_late_034_late_069_rake_138_albedo.jpg` | 65001 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_late_034_late_069_rake_138_normal.jpg` | 676341 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_late_034_late_069_rake_138_rough.jpg` | 222871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_late_034_late_069_rough.jpg` | 222871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_late_034_normal.jpg` | 676341 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_late_034_rough.jpg` | 222871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_late_034_shade_137_albedo.jpg` | 55475 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_late_034_shade_137_normal.jpg` | 676341 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_late_034_shade_137_rough.jpg` | 222871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_normal.jpg` | 676341 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_rake_068_albedo.jpg` | 123626 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_rake_068_late_139_albedo.jpg` | 103326 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_rake_068_late_139_normal.jpg` | 676341 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_rake_068_late_139_rough.jpg` | 222871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_rake_068_normal.jpg` | 676341 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_rake_068_rough.jpg` | 222871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_rough.jpg` | 222871 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_shade_017_albedo.jpg` | 70534 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_shade_017_normal.jpg` | 676341 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_shade_017_rough.jpg` | 222871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_035_albedo.jpg` | 67351 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_035_dry_071_albedo.jpg` | 67790 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_035_dry_071_normal.jpg` | 676341 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_035_dry_071_rough.jpg` | 222871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_035_dry_071_shade_142_albedo.jpg` | 53276 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_035_dry_071_shade_142_normal.jpg` | 676341 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_035_dry_071_shade_142_rough.jpg` | 222871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_035_dry_141_albedo.jpg` | 67790 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_035_dry_141_normal.jpg` | 676341 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_035_dry_141_rough.jpg` | 222871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_035_normal.jpg` | 676341 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_035_rough.jpg` | 222871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_070_albedo.jpg` | 67351 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_070_normal.jpg` | 676341 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_070_rake_143_albedo.jpg` | 69544 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_070_rake_143_normal.jpg` | 676341 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_070_rake_143_rough.jpg` | 222871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_070_rough.jpg` | 222871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_140_albedo.jpg` | 67351 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_140_normal.jpg` | 676341 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_gravel023_shade_017_wet_140_rough.jpg` | 222871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_albedo.jpg` | 655950 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_dry_036_albedo.jpg` | 593832 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_dry_036_normal.jpg` | 664772 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_dry_036_rake_073_albedo.jpg` | 594175 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_dry_036_rake_073_dry_146_albedo.jpg` | 590933 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_dry_036_rake_073_dry_146_normal.jpg` | 664772 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_dry_036_rake_073_dry_146_rough.jpg` | 428280 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_dry_036_rake_073_normal.jpg` | 664772 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_dry_036_rake_073_rough.jpg` | 428280 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_dry_036_rough.jpg` | 428280 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_dry_036_wet_145_albedo.jpg` | 526822 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_dry_036_wet_145_normal.jpg` | 664772 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_dry_036_wet_145_rough.jpg` | 428280 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_late_144_albedo.jpg` | 548146 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_late_144_normal.jpg` | 664772 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_late_144_rough.jpg` | 428280 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_normal.jpg` | 664772 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_rake_018_albedo.jpg` | 603272 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_rake_018_late_074_albedo.jpg` | 571730 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_rake_018_late_074_normal.jpg` | 664772 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_rake_018_late_074_rake_148_albedo.jpg` | 574350 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_rake_018_late_074_rake_148_normal.jpg` | 664772 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_rake_018_late_074_rake_148_rough.jpg` | 428280 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_rake_018_late_074_rough.jpg` | 428280 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_rake_018_normal.jpg` | 664772 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_rake_018_rough.jpg` | 428280 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_rake_018_shade_037_albedo.jpg` | 490045 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_rake_018_shade_037_late_149_albedo.jpg` | 469775 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_rake_018_shade_037_late_149_normal.jpg` | 664772 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_rake_018_shade_037_late_149_rough.jpg` | 428280 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_rake_018_shade_037_normal.jpg` | 664772 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_rake_018_shade_037_rough.jpg` | 428280 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_rake_018_shade_037_wet_075_albedo.jpg` | 437825 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_rake_018_shade_037_wet_075_normal.jpg` | 664772 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_rake_018_shade_037_wet_075_rough.jpg` | 428280 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_rake_018_shade_037_wet_075_wet_150_albedo.jpg` | 397496 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_rake_018_shade_037_wet_075_wet_150_normal.jpg` | 664772 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_rake_018_shade_037_wet_075_wet_150_rough.jpg` | 428280 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_rake_018_shade_147_albedo.jpg` | 490045 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_rake_018_shade_147_normal.jpg` | 664772 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_rake_018_shade_147_rough.jpg` | 428280 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_rough.jpg` | 428280 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_shade_072_albedo.jpg` | 404841 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_shade_072_dry_151_albedo.jpg` | 403389 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground003_shade_072_dry_151_normal.jpg` | 664772 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_shade_072_dry_151_rough.jpg` | 428280 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_shade_072_normal.jpg` | 664772 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground003_shade_072_rough.jpg` | 428280 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_albedo.jpg` | 505484 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_dry_076_albedo.jpg` | 479165 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_dry_076_normal.jpg` | 626982 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_dry_076_rake_153_albedo.jpg` | 482950 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_dry_076_rake_153_normal.jpg` | 626982 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_dry_076_rake_153_rough.jpg` | 344245 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_dry_076_rough.jpg` | 344245 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_late_019_albedo.jpg` | 449918 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_late_019_late_039_albedo.jpg` | 405474 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_late_019_late_039_normal.jpg` | 626982 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_late_019_late_039_rake_078_albedo.jpg` | 406541 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_late_019_late_039_rake_078_dry_156_albedo.jpg` | 375634 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_late_019_late_039_rake_078_dry_156_normal.jpg` | 626982 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_late_019_late_039_rake_078_dry_156_rough.jpg` | 344245 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_late_019_late_039_rake_078_normal.jpg` | 626982 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_late_019_late_039_rake_078_rough.jpg` | 344245 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_late_019_late_039_rough.jpg` | 344245 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_late_019_late_039_wet_155_albedo.jpg` | 366407 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_late_019_late_039_wet_155_normal.jpg` | 626982 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_late_019_late_039_wet_155_rough.jpg` | 344245 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_late_019_late_154_albedo.jpg` | 405474 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_late_019_late_154_normal.jpg` | 626982 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_late_019_late_154_rough.jpg` | 344245 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_late_019_normal.jpg` | 626982 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_late_019_rough.jpg` | 344245 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_late_019_shade_077_albedo.jpg` | 375588 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_late_019_shade_077_normal.jpg` | 626982 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_late_019_shade_077_rough.jpg` | 344245 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_late_019_shade_077_shade_157_albedo.jpg` | 307794 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_late_019_shade_077_shade_157_normal.jpg` | 626982 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_late_019_shade_077_shade_157_rough.jpg` | 344245 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_normal.jpg` | 626982 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_rake_038_albedo.jpg` | 487746 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_rake_038_late_079_albedo.jpg` | 469792 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_rake_038_late_079_late_159_albedo.jpg` | 419207 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_rake_038_late_079_late_159_normal.jpg` | 626982 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_rake_038_late_079_late_159_rough.jpg` | 344245 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_rake_038_late_079_normal.jpg` | 626982 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_rake_038_late_079_rough.jpg` | 344245 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_rake_038_normal.jpg` | 626982 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_rake_038_rake_158_albedo.jpg` | 491722 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_rake_038_rake_158_normal.jpg` | 626982 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_rake_038_rake_158_rough.jpg` | 344245 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_rake_038_rough.jpg` | 344245 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_rough.jpg` | 344245 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_shade_152_albedo.jpg` | 309578 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground004_shade_152_normal.jpg` | 626982 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground004_shade_152_rough.jpg` | 344245 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_albedo.jpg` | 574419 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_normal.jpg` | 695465 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_rough.jpg` | 395395 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_wet_020_albedo.jpg` | 495810 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_wet_020_dry_041_albedo.jpg` | 497235 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_wet_020_dry_041_normal.jpg` | 695465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_020_dry_041_rough.jpg` | 395395 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_020_dry_041_shade_082_albedo.jpg` | 412020 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_wet_020_dry_041_shade_082_normal.jpg` | 695465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_020_dry_041_shade_082_rake_163_albedo.jpg` | 414727 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_wet_020_dry_041_shade_082_rake_163_normal.jpg` | 695465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_020_dry_041_shade_082_rake_163_rough.jpg` | 395395 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_020_dry_041_shade_082_rough.jpg` | 395395 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_020_dry_041_shade_162_albedo.jpg` | 412020 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_wet_020_dry_041_shade_162_normal.jpg` | 695465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_020_dry_041_shade_162_rough.jpg` | 395395 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_020_dry_081_albedo.jpg` | 497235 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_wet_020_dry_081_late_164_albedo.jpg` | 486122 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_wet_020_dry_081_late_164_normal.jpg` | 695465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_020_dry_081_late_164_rough.jpg` | 395395 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_020_dry_081_normal.jpg` | 695465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_020_dry_081_rough.jpg` | 395395 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_020_dry_161_albedo.jpg` | 497235 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_wet_020_dry_161_normal.jpg` | 695465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_020_dry_161_rough.jpg` | 395395 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_020_normal.jpg` | 695465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_020_rough.jpg` | 395395 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_040_albedo.jpg` | 495810 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_wet_040_normal.jpg` | 695465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_040_rake_083_albedo.jpg` | 499643 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_wet_040_rake_083_dry_166_albedo.jpg` | 501127 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_wet_040_rake_083_dry_166_normal.jpg` | 695465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_040_rake_083_dry_166_rough.jpg` | 395395 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_040_rake_083_normal.jpg` | 695465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_040_rake_083_rough.jpg` | 395395 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_040_rough.jpg` | 395395 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_040_wet_165_albedo.jpg` | 448971 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_wet_040_wet_165_normal.jpg` | 695465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_040_wet_165_rough.jpg` | 395395 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_080_albedo.jpg` | 495810 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_wet_080_normal.jpg` | 695465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_080_rough.jpg` | 395395 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_080_shade_167_albedo.jpg` | 410367 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_wet_080_shade_167_normal.jpg` | 695465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_080_shade_167_rough.jpg` | 395395 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_160_albedo.jpg` | 495810 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground023_wet_160_normal.jpg` | 695465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground023_wet_160_rough.jpg` | 395395 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_albedo.jpg` | 405065 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_dry_021_albedo.jpg` | 383989 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_dry_021_late_169_albedo.jpg` | 357083 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_dry_021_late_169_normal.jpg` | 603858 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_dry_021_late_169_rough.jpg` | 250391 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_dry_021_normal.jpg` | 603858 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_dry_021_rake_043_albedo.jpg` | 387823 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_dry_021_rake_043_dry_086_albedo.jpg` | 384624 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_dry_021_rake_043_dry_086_dry_171_albedo.jpg` | 373470 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_dry_021_rake_043_dry_086_dry_171_normal.jpg` | 603858 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_dry_021_rake_043_dry_086_dry_171_rough.jpg` | 250391 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_dry_021_rake_043_dry_086_normal.jpg` | 603858 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_dry_021_rake_043_dry_086_rough.jpg` | 250391 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_dry_021_rake_043_normal.jpg` | 603858 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_dry_021_rake_043_rough.jpg` | 250391 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_dry_021_rake_043_wet_170_albedo.jpg` | 356299 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_dry_021_rake_043_wet_170_normal.jpg` | 603858 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_dry_021_rake_043_wet_170_rough.jpg` | 250391 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_dry_021_rough.jpg` | 250391 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_dry_021_wet_085_albedo.jpg` | 352575 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_dry_021_wet_085_normal.jpg` | 603858 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_dry_021_wet_085_rough.jpg` | 250391 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_dry_021_wet_085_shade_172_albedo.jpg` | 290794 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_dry_021_wet_085_shade_172_normal.jpg` | 603858 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_dry_021_wet_085_shade_172_rough.jpg` | 250391 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_late_084_albedo.jpg` | 365272 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_late_084_normal.jpg` | 603858 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_late_084_rake_173_albedo.jpg` | 368177 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_late_084_rake_173_normal.jpg` | 603858 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_late_084_rake_173_rough.jpg` | 250391 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_late_084_rough.jpg` | 250391 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_normal.jpg` | 603858 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_rake_168_albedo.jpg` | 393719 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_rake_168_normal.jpg` | 603858 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_rake_168_rough.jpg` | 250391 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_rough.jpg` | 250391 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_shade_042_albedo.jpg` | 278564 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_shade_042_late_174_albedo.jpg` | 275060 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_shade_042_late_174_normal.jpg` | 603858 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_shade_042_late_174_rough.jpg` | 250391 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_shade_042_normal.jpg` | 603858 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_shade_042_rough.jpg` | 250391 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_shade_042_shade_087_albedo.jpg` | 229881 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_shade_042_shade_087_normal.jpg` | 603858 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_shade_042_shade_087_rough.jpg` | 250391 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_shade_042_shade_087_wet_175_albedo.jpg` | 211064 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground032_shade_042_shade_087_wet_175_normal.jpg` | 603858 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground032_shade_042_shade_087_wet_175_rough.jpg` | 250391 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_albedo.jpg` | 237787 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_dry_176_albedo.jpg` | 31714 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_dry_176_normal.jpg` | 214790 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_dry_176_rough.jpg` | 249916 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_late_044_albedo.jpg` | 109016 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_late_044_late_089_albedo.jpg` | 83032 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_late_044_late_089_normal.jpg` | 214790 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_late_044_late_089_rake_178_albedo.jpg` | 84176 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_late_044_late_089_rake_178_normal.jpg` | 214790 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_late_044_late_089_rake_178_rough.jpg` | 249916 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_late_044_late_089_rough.jpg` | 249916 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_late_044_normal.jpg` | 214790 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_late_044_rough.jpg` | 249916 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_late_044_shade_177_albedo.jpg` | 77889 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_late_044_shade_177_normal.jpg` | 214790 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_late_044_shade_177_rough.jpg` | 249916 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_normal.jpg` | 214790 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_rake_088_albedo.jpg` | 228043 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_rake_088_late_179_albedo.jpg` | 173668 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_rake_088_late_179_normal.jpg` | 214790 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_rake_088_late_179_rough.jpg` | 249916 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_rake_088_normal.jpg` | 214790 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_rake_088_rough.jpg` | 249916 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_rough.jpg` | 249916 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_shade_022_albedo.jpg` | 111108 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_shade_022_normal.jpg` | 214790 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_shade_022_rough.jpg` | 249916 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_shade_022_wet_045_albedo.jpg` | 107015 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_shade_022_wet_045_dry_091_albedo.jpg` | 107032 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_shade_022_wet_045_dry_091_normal.jpg` | 214790 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_shade_022_wet_045_dry_091_rough.jpg` | 249916 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_shade_022_wet_045_dry_091_shade_182_albedo.jpg` | 79773 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_shade_022_wet_045_dry_091_shade_182_normal.jpg` | 214790 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_shade_022_wet_045_dry_091_shade_182_rough.jpg` | 249916 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_shade_022_wet_045_dry_181_albedo.jpg` | 107032 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_shade_022_wet_045_dry_181_normal.jpg` | 214790 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_shade_022_wet_045_dry_181_rough.jpg` | 249916 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_shade_022_wet_045_normal.jpg` | 214790 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_shade_022_wet_045_rough.jpg` | 249916 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_shade_022_wet_090_albedo.jpg` | 107015 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_shade_022_wet_090_normal.jpg` | 214790 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_shade_022_wet_090_rake_183_albedo.jpg` | 110897 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_shade_022_wet_090_rake_183_normal.jpg` | 214790 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_shade_022_wet_090_rake_183_rough.jpg` | 249916 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_shade_022_wet_090_rough.jpg` | 249916 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_shade_022_wet_180_albedo.jpg` | 107015 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground033_shade_022_wet_180_normal.jpg` | 214790 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground033_shade_022_wet_180_rough.jpg` | 249916 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_albedo.jpg` | 705564 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_dry_046_albedo.jpg` | 624108 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_dry_046_normal.jpg` | 660862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_dry_046_rake_093_albedo.jpg` | 622590 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_dry_046_rake_093_dry_186_albedo.jpg` | 611516 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_dry_046_rake_093_dry_186_normal.jpg` | 660862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_dry_046_rake_093_dry_186_rough.jpg` | 357205 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_dry_046_rake_093_normal.jpg` | 660862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_dry_046_rake_093_rough.jpg` | 357205 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_dry_046_rough.jpg` | 357205 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_dry_046_wet_185_albedo.jpg` | 545025 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_dry_046_wet_185_normal.jpg` | 660862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_dry_046_wet_185_rough.jpg` | 357205 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_late_184_albedo.jpg` | 573238 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_late_184_normal.jpg` | 660862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_late_184_rough.jpg` | 357205 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_normal.jpg` | 660862 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_rake_023_albedo.jpg` | 641287 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_rake_023_late_094_albedo.jpg` | 593352 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_rake_023_late_094_normal.jpg` | 660862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_rake_023_late_094_rake_188_albedo.jpg` | 595084 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_rake_023_late_094_rake_188_normal.jpg` | 660862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_rake_023_late_094_rake_188_rough.jpg` | 357205 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_rake_023_late_094_rough.jpg` | 357205 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_rake_023_normal.jpg` | 660862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_rake_023_rough.jpg` | 357205 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_rake_023_shade_047_albedo.jpg` | 511353 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_rake_023_shade_047_late_189_albedo.jpg` | 488145 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_rake_023_shade_047_late_189_normal.jpg` | 660862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_rake_023_shade_047_late_189_rough.jpg` | 357205 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_rake_023_shade_047_normal.jpg` | 660862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_rake_023_shade_047_rough.jpg` | 357205 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_rake_023_shade_047_wet_095_albedo.jpg` | 448125 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_rake_023_shade_047_wet_095_normal.jpg` | 660862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_rake_023_shade_047_wet_095_rough.jpg` | 357205 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_rake_023_shade_047_wet_095_wet_190_albedo.jpg` | 402516 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_rake_023_shade_047_wet_095_wet_190_normal.jpg` | 660862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_rake_023_shade_047_wet_095_wet_190_rough.jpg` | 357205 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_rake_023_shade_187_albedo.jpg` | 511353 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_rake_023_shade_187_normal.jpg` | 660862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_rake_023_shade_187_rough.jpg` | 357205 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_rough.jpg` | 357205 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_shade_092_albedo.jpg` | 449822 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_shade_092_dry_191_albedo.jpg` | 448134 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_ground037_shade_092_dry_191_normal.jpg` | 660862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_shade_092_dry_191_rough.jpg` | 357205 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_shade_092_normal.jpg` | 660862 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_ground037_shade_092_rough.jpg` | 357205 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_albedo.jpg` | 115743 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_dry_096_albedo.jpg` | 111410 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_dry_096_normal.jpg` | 209553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_dry_096_rake_193_albedo.jpg` | 112388 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_dry_096_rake_193_normal.jpg` | 209553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_dry_096_rake_193_rough.jpg` | 205736 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_dry_096_rough.jpg` | 205736 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_late_024_albedo.jpg` | 104144 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_late_024_late_049_albedo.jpg` | 100917 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_late_024_late_049_normal.jpg` | 209553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_late_024_late_049_rake_098_albedo.jpg` | 101974 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_late_024_late_049_rake_098_dry_196_albedo.jpg` | 101932 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_late_024_late_049_rake_098_dry_196_normal.jpg` | 209553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_late_024_late_049_rake_098_dry_196_rough.jpg` | 205736 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_late_024_late_049_rake_098_normal.jpg` | 209553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_late_024_late_049_rake_098_rough.jpg` | 205736 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_late_024_late_049_rough.jpg` | 205736 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_late_024_late_049_wet_195_albedo.jpg` | 89470 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_late_024_late_049_wet_195_normal.jpg` | 209553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_late_024_late_049_wet_195_rough.jpg` | 205736 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_late_024_late_194_albedo.jpg` | 100917 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_late_024_late_194_normal.jpg` | 209553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_late_024_late_194_rough.jpg` | 205736 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_late_024_normal.jpg` | 209553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_late_024_rough.jpg` | 205736 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_late_024_shade_097_albedo.jpg` | 78973 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_late_024_shade_097_normal.jpg` | 209553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_late_024_shade_097_rough.jpg` | 205736 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_late_024_shade_097_shade_197_albedo.jpg` | 49269 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_late_024_shade_097_shade_197_normal.jpg` | 209553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_late_024_shade_097_shade_197_rough.jpg` | 205736 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_normal.jpg` | 209553 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_rake_048_albedo.jpg` | 111476 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_rake_048_late_099_albedo.jpg` | 106149 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_rake_048_late_099_late_199_albedo.jpg` | 101854 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_rake_048_late_099_late_199_normal.jpg` | 209553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_rake_048_late_099_late_199_rough.jpg` | 205736 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_rake_048_late_099_normal.jpg` | 209553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_rake_048_late_099_rough.jpg` | 205736 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_rake_048_normal.jpg` | 209553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_rake_048_rake_198_albedo.jpg` | 109618 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_rake_048_rake_198_normal.jpg` | 209553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_rake_048_rake_198_rough.jpg` | 205736 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_rake_048_rough.jpg` | 205736 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_rough.jpg` | 205736 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_shade_192_albedo.jpg` | 78129 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather011_shade_192_normal.jpg` | 209553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather011_shade_192_rough.jpg` | 205736 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_albedo.jpg` | 229741 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_normal.jpg` | 303840 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_rough.jpg` | 371797 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_wet_025_albedo.jpg` | 202330 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_wet_025_dry_051_albedo.jpg` | 202392 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_wet_025_dry_051_normal.jpg` | 303840 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_025_dry_051_rough.jpg` | 371797 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_025_dry_051_shade_102_albedo.jpg` | 166243 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_wet_025_dry_051_shade_102_normal.jpg` | 303840 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_025_dry_051_shade_102_rake_203_albedo.jpg` | 167355 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_wet_025_dry_051_shade_102_rake_203_normal.jpg` | 303840 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_025_dry_051_shade_102_rake_203_rough.jpg` | 371797 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_025_dry_051_shade_102_rough.jpg` | 371797 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_025_dry_051_shade_202_albedo.jpg` | 166243 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_wet_025_dry_051_shade_202_normal.jpg` | 303840 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_025_dry_051_shade_202_rough.jpg` | 371797 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_025_dry_101_albedo.jpg` | 202392 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_wet_025_dry_101_late_204_albedo.jpg` | 199109 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_wet_025_dry_101_late_204_normal.jpg` | 303840 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_025_dry_101_late_204_rough.jpg` | 371797 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_025_dry_101_normal.jpg` | 303840 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_025_dry_101_rough.jpg` | 371797 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_025_dry_201_albedo.jpg` | 202392 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_wet_025_dry_201_normal.jpg` | 303840 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_025_dry_201_rough.jpg` | 371797 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_025_normal.jpg` | 303840 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_025_rough.jpg` | 371797 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_050_albedo.jpg` | 202330 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_wet_050_normal.jpg` | 303840 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_050_rake_103_albedo.jpg` | 203136 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_wet_050_rake_103_dry_206_albedo.jpg` | 204747 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_wet_050_rake_103_dry_206_normal.jpg` | 303840 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_050_rake_103_dry_206_rough.jpg` | 371797 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_050_rake_103_normal.jpg` | 303840 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_050_rake_103_rough.jpg` | 371797 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_050_rough.jpg` | 371797 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_050_wet_205_albedo.jpg` | 186705 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_wet_050_wet_205_normal.jpg` | 303840 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_050_wet_205_rough.jpg` | 371797 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_100_albedo.jpg` | 202330 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_wet_100_normal.jpg` | 303840 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_100_rough.jpg` | 371797 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_100_shade_207_albedo.jpg` | 162530 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_wet_100_shade_207_normal.jpg` | 303840 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_100_shade_207_rough.jpg` | 371797 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_200_albedo.jpg` | 202330 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather021_wet_200_normal.jpg` | 303840 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather021_wet_200_rough.jpg` | 371797 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_albedo.jpg` | 244867 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_dry_026_albedo.jpg` | 235702 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_dry_026_late_209_albedo.jpg` | 182822 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_dry_026_late_209_normal.jpg` | 118873 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_dry_026_late_209_rough.jpg` | 277308 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_dry_026_normal.jpg` | 118873 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_dry_026_rake_053_albedo.jpg` | 236741 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_dry_026_rake_053_dry_106_albedo.jpg` | 208945 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_dry_026_rake_053_dry_106_dry_211_albedo.jpg` | 192721 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_dry_026_rake_053_dry_106_dry_211_normal.jpg` | 118873 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_dry_026_rake_053_dry_106_dry_211_rough.jpg` | 277308 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_dry_026_rake_053_dry_106_normal.jpg` | 118873 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_dry_026_rake_053_dry_106_rough.jpg` | 277308 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_dry_026_rake_053_normal.jpg` | 118873 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_dry_026_rake_053_rough.jpg` | 277308 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_dry_026_rake_053_wet_210_albedo.jpg` | 208901 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_dry_026_rake_053_wet_210_normal.jpg` | 118873 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_dry_026_rake_053_wet_210_rough.jpg` | 277308 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_dry_026_rough.jpg` | 277308 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_dry_026_wet_105_albedo.jpg` | 214569 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_dry_026_wet_105_normal.jpg` | 118873 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_dry_026_wet_105_rough.jpg` | 277308 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_dry_026_wet_105_shade_212_albedo.jpg` | 164176 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_dry_026_wet_105_shade_212_normal.jpg` | 118873 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_dry_026_wet_105_shade_212_rough.jpg` | 277308 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_late_104_albedo.jpg` | 164192 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_late_104_normal.jpg` | 118873 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_late_104_rake_213_albedo.jpg` | 165983 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_late_104_rake_213_normal.jpg` | 118873 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_late_104_rake_213_rough.jpg` | 277308 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_late_104_rough.jpg` | 277308 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_normal.jpg` | 118873 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_rake_208_albedo.jpg` | 241805 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_rake_208_normal.jpg` | 118873 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_rake_208_rough.jpg` | 277308 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_rough.jpg` | 277308 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_shade_052_albedo.jpg` | 132983 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_shade_052_late_214_albedo.jpg` | 129282 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_shade_052_late_214_normal.jpg` | 118873 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_shade_052_late_214_rough.jpg` | 277308 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_shade_052_normal.jpg` | 118873 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_shade_052_rough.jpg` | 277308 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_shade_052_shade_107_albedo.jpg` | 97523 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_shade_052_shade_107_normal.jpg` | 118873 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_shade_052_shade_107_rough.jpg` | 277308 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_shade_052_shade_107_wet_215_albedo.jpg` | 91639 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather038_shade_052_shade_107_wet_215_normal.jpg` | 118873 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather038_shade_052_shade_107_wet_215_rough.jpg` | 277308 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_albedo.jpg` | 223240 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_dry_216_albedo.jpg` | 191785 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_dry_216_normal.jpg` | 263124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_dry_216_rough.jpg` | 399614 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_late_054_albedo.jpg` | 127390 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_late_054_late_109_albedo.jpg` | 99546 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_late_054_late_109_normal.jpg` | 263124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_late_054_late_109_rake_218_albedo.jpg` | 101032 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_late_054_late_109_rake_218_normal.jpg` | 263124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_late_054_late_109_rake_218_rough.jpg` | 399614 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_late_054_late_109_rough.jpg` | 399614 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_late_054_normal.jpg` | 263124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_late_054_rough.jpg` | 399614 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_late_054_shade_217_albedo.jpg` | 86604 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_late_054_shade_217_normal.jpg` | 263124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_late_054_shade_217_rough.jpg` | 399614 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_normal.jpg` | 263124 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_rake_108_albedo.jpg` | 206845 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_rake_108_late_219_albedo.jpg` | 162663 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_rake_108_late_219_normal.jpg` | 263124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_rake_108_late_219_rough.jpg` | 399614 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_rake_108_normal.jpg` | 263124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_rake_108_rough.jpg` | 399614 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_rough.jpg` | 399614 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_shade_027_albedo.jpg` | 116524 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_shade_027_normal.jpg` | 263124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_shade_027_rough.jpg` | 399614 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_shade_027_wet_055_albedo.jpg` | 112031 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_shade_027_wet_055_dry_111_albedo.jpg` | 115828 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_shade_027_wet_055_dry_111_normal.jpg` | 263124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_shade_027_wet_055_dry_111_rough.jpg` | 399614 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_shade_027_wet_055_dry_111_shade_222_albedo.jpg` | 73615 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_shade_027_wet_055_dry_111_shade_222_normal.jpg` | 263124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_shade_027_wet_055_dry_111_shade_222_rough.jpg` | 399614 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_shade_027_wet_055_dry_221_albedo.jpg` | 115828 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_shade_027_wet_055_dry_221_normal.jpg` | 263124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_shade_027_wet_055_dry_221_rough.jpg` | 399614 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_shade_027_wet_055_normal.jpg` | 263124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_shade_027_wet_055_rough.jpg` | 399614 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_shade_027_wet_110_albedo.jpg` | 112031 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_shade_027_wet_110_normal.jpg` | 263124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_shade_027_wet_110_rake_223_albedo.jpg` | 115601 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_shade_027_wet_110_rake_223_normal.jpg` | 263124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_shade_027_wet_110_rake_223_rough.jpg` | 399614 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_shade_027_wet_110_rough.jpg` | 399614 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_shade_027_wet_220_albedo.jpg` | 112031 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_leather039_shade_027_wet_220_normal.jpg` | 263124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_leather039_shade_027_wet_220_rough.jpg` | 399614 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_albedo.jpg` | 260857 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_dry_056_albedo.jpg` | 252573 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_dry_056_normal.jpg` | 55098 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_dry_056_rake_113_albedo.jpg` | 255814 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_dry_056_rake_113_dry_226_albedo.jpg` | 257595 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_dry_056_rake_113_dry_226_normal.jpg` | 55098 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_dry_056_rake_113_dry_226_rough.jpg` | 178615 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_dry_056_rake_113_normal.jpg` | 55098 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_dry_056_rake_113_rough.jpg` | 178615 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_dry_056_rough.jpg` | 178615 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_dry_056_wet_225_albedo.jpg` | 231764 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_dry_056_wet_225_normal.jpg` | 55098 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_dry_056_wet_225_rough.jpg` | 178615 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_late_224_albedo.jpg` | 246437 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_late_224_normal.jpg` | 55098 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_late_224_rough.jpg` | 178615 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_normal.jpg` | 55098 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_rake_028_albedo.jpg` | 255102 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_rake_028_late_114_albedo.jpg` | 255290 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_rake_028_late_114_normal.jpg` | 55098 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_rake_028_late_114_rake_228_albedo.jpg` | 257630 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_rake_028_late_114_rake_228_normal.jpg` | 55098 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_rake_028_late_114_rake_228_rough.jpg` | 178615 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_rake_028_late_114_rough.jpg` | 178615 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_rake_028_normal.jpg` | 55098 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_rake_028_rough.jpg` | 178615 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_rake_028_shade_057_albedo.jpg` | 209340 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_rake_028_shade_057_late_229_albedo.jpg` | 206193 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_rake_028_shade_057_late_229_normal.jpg` | 55098 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_rake_028_shade_057_late_229_rough.jpg` | 178615 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_rake_028_shade_057_normal.jpg` | 55098 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_rake_028_shade_057_rough.jpg` | 178615 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_rake_028_shade_057_wet_115_albedo.jpg` | 193274 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_rake_028_shade_057_wet_115_normal.jpg` | 55098 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_rake_028_shade_057_wet_115_rough.jpg` | 178615 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_rake_028_shade_057_wet_115_wet_230_albedo.jpg` | 179361 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_rake_028_shade_057_wet_115_wet_230_normal.jpg` | 55098 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_rake_028_shade_057_wet_115_wet_230_rough.jpg` | 178615 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_rake_028_shade_227_albedo.jpg` | 209340 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_rake_028_shade_227_normal.jpg` | 55098 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_rake_028_shade_227_rough.jpg` | 178615 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_rough.jpg` | 178615 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_shade_112_albedo.jpg` | 160838 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_shade_112_dry_231_albedo.jpg` | 162517 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal001_shade_112_dry_231_normal.jpg` | 55098 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_shade_112_dry_231_rough.jpg` | 178615 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_shade_112_normal.jpg` | 55098 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal001_shade_112_rough.jpg` | 178615 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_albedo.jpg` | 135018 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_dry_116_albedo.jpg` | 129339 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_dry_116_normal.jpg` | 93488 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_dry_116_rake_233_albedo.jpg` | 131980 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_dry_116_rake_233_normal.jpg` | 93488 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_dry_116_rake_233_rough.jpg` | 208179 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_dry_116_rough.jpg` | 208179 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_late_029_albedo.jpg` | 124040 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_late_029_late_059_albedo.jpg` | 120242 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_late_029_late_059_normal.jpg` | 93488 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_late_029_late_059_rake_118_albedo.jpg` | 121371 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_late_029_late_059_rake_118_dry_236_albedo.jpg` | 121701 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_late_029_late_059_rake_118_dry_236_normal.jpg` | 93488 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_late_029_late_059_rake_118_dry_236_rough.jpg` | 208179 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_late_029_late_059_rake_118_normal.jpg` | 93488 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_late_029_late_059_rake_118_rough.jpg` | 208179 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_late_029_late_059_rough.jpg` | 208179 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_late_029_late_059_wet_235_albedo.jpg` | 107920 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_late_029_late_059_wet_235_normal.jpg` | 93488 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_late_029_late_059_wet_235_rough.jpg` | 208179 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_late_029_late_234_albedo.jpg` | 120242 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_late_029_late_234_normal.jpg` | 93488 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_late_029_late_234_rough.jpg` | 208179 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_late_029_normal.jpg` | 93488 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_late_029_rough.jpg` | 208179 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_late_029_shade_117_albedo.jpg` | 96542 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_late_029_shade_117_normal.jpg` | 93488 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_late_029_shade_117_rough.jpg` | 208179 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_late_029_shade_117_shade_237_albedo.jpg` | 80630 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_late_029_shade_117_shade_237_normal.jpg` | 93488 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_late_029_shade_117_shade_237_rough.jpg` | 208179 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_normal.jpg` | 93488 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_rake_058_albedo.jpg` | 130055 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_rake_058_late_119_albedo.jpg` | 126595 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_rake_058_late_119_late_239_albedo.jpg` | 121881 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_rake_058_late_119_late_239_normal.jpg` | 93488 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_rake_058_late_119_late_239_rough.jpg` | 208179 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_rake_058_late_119_normal.jpg` | 93488 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_rake_058_late_119_rough.jpg` | 208179 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_rake_058_normal.jpg` | 93488 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_rake_058_rake_238_albedo.jpg` | 132430 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_rake_058_rake_238_normal.jpg` | 93488 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_rake_058_rake_238_rough.jpg` | 208179 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_rake_058_rough.jpg` | 208179 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_rough.jpg` | 208179 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_shade_232_albedo.jpg` | 96941 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal009_shade_232_normal.jpg` | 93488 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal009_shade_232_rough.jpg` | 208179 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_albedo.jpg` | 105377 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_normal.jpg` | 6442 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_rough.jpg` | 110521 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_wet_030_albedo.jpg` | 83363 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_wet_030_dry_061_albedo.jpg` | 83483 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_wet_030_dry_061_normal.jpg` | 6442 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_030_dry_061_rough.jpg` | 110521 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_030_dry_061_shade_122_albedo.jpg` | 60163 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_wet_030_dry_061_shade_122_normal.jpg` | 6442 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_030_dry_061_shade_122_rake_243_albedo.jpg` | 61184 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_wet_030_dry_061_shade_122_rake_243_normal.jpg` | 6442 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_030_dry_061_shade_122_rake_243_rough.jpg` | 110521 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_030_dry_061_shade_122_rough.jpg` | 110521 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_030_dry_061_shade_242_albedo.jpg` | 60163 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_wet_030_dry_061_shade_242_normal.jpg` | 6442 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_030_dry_061_shade_242_rough.jpg` | 110521 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_030_dry_121_albedo.jpg` | 83483 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_wet_030_dry_121_late_244_albedo.jpg` | 81586 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_wet_030_dry_121_late_244_normal.jpg` | 6442 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_030_dry_121_late_244_rough.jpg` | 110521 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_030_dry_121_normal.jpg` | 6442 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_030_dry_121_rough.jpg` | 110521 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_030_dry_241_albedo.jpg` | 83483 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_wet_030_dry_241_normal.jpg` | 6442 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_030_dry_241_rough.jpg` | 110521 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_030_normal.jpg` | 6442 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_030_rough.jpg` | 110521 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_060_albedo.jpg` | 83363 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_wet_060_normal.jpg` | 6442 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_060_rake_123_albedo.jpg` | 85898 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_wet_060_rake_123_dry_246_albedo.jpg` | 87018 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_wet_060_rake_123_dry_246_normal.jpg` | 6442 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_060_rake_123_dry_246_rough.jpg` | 110521 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_060_rake_123_normal.jpg` | 6442 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_060_rake_123_rough.jpg` | 110521 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_060_rough.jpg` | 110521 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_060_wet_245_albedo.jpg` | 81696 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_wet_060_wet_245_normal.jpg` | 6442 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_060_wet_245_rough.jpg` | 110521 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_120_albedo.jpg` | 83363 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_wet_120_normal.jpg` | 6442 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_120_rough.jpg` | 110521 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_120_shade_247_albedo.jpg` | 65425 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_wet_120_shade_247_normal.jpg` | 6442 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_120_shade_247_rough.jpg` | 110521 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_240_albedo.jpg` | 83363 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_metal032_wet_240_normal.jpg` | 6442 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_metal032_wet_240_rough.jpg` | 110521 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_albedo.jpg` | 690443 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_dry_031_albedo.jpg` | 623986 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_dry_031_late_249_albedo.jpg` | 583602 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_dry_031_late_249_normal.jpg` | 727273 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_dry_031_late_249_rough.jpg` | 451657 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_dry_031_normal.jpg` | 727273 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_dry_031_rake_063_albedo.jpg` | 624334 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_dry_031_rake_063_dry_126_albedo.jpg` | 617376 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_dry_031_rake_063_dry_126_dry_251_albedo.jpg` | 601670 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_dry_031_rake_063_dry_126_dry_251_normal.jpg` | 727273 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_dry_031_rake_063_dry_126_dry_251_rough.jpg` | 451657 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_dry_031_rake_063_dry_126_normal.jpg` | 727273 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_dry_031_rake_063_dry_126_rough.jpg` | 451657 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_dry_031_rake_063_normal.jpg` | 727273 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_dry_031_rake_063_rough.jpg` | 451657 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_dry_031_rake_063_wet_250_albedo.jpg` | 564810 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_dry_031_rake_063_wet_250_normal.jpg` | 727273 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_dry_031_rake_063_wet_250_rough.jpg` | 451657 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_dry_031_rough.jpg` | 451657 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_dry_031_wet_125_albedo.jpg` | 560782 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_dry_031_wet_125_normal.jpg` | 727273 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_dry_031_wet_125_rough.jpg` | 451657 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_dry_031_wet_125_shade_252_albedo.jpg` | 467029 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_dry_031_wet_125_shade_252_normal.jpg` | 727273 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_dry_031_wet_125_shade_252_rough.jpg` | 451657 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_late_124_albedo.jpg` | 587276 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_late_124_normal.jpg` | 727273 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_late_124_rake_253_albedo.jpg` | 590583 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_late_124_rake_253_normal.jpg` | 727273 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_late_124_rake_253_rough.jpg` | 451657 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_late_124_rough.jpg` | 451657 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_normal.jpg` | 727273 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_rake_248_albedo.jpg` | 643742 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_rake_248_normal.jpg` | 727273 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_rake_248_rough.jpg` | 451657 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_rough.jpg` | 451657 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_shade_062_albedo.jpg` | 449695 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_shade_062_late_254_albedo.jpg` | 434904 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_shade_062_late_254_normal.jpg` | 727273 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_shade_062_late_254_rough.jpg` | 451657 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_shade_062_normal.jpg` | 727273 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_shade_062_rough.jpg` | 451657 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_shade_062_shade_127_albedo.jpg` | 375392 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_shade_062_shade_127_normal.jpg` | 727273 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_shade_062_shade_127_rough.jpg` | 451657 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_shade_062_shade_127_wet_255_albedo.jpg` | 345304 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_moss001_shade_062_shade_127_wet_255_normal.jpg` | 727273 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_moss001_shade_062_shade_127_wet_255_rough.jpg` | 451657 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_albedo.jpg` | 108389 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_dry_256_albedo.jpg` | 103517 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_dry_256_normal.jpg` | 150030 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_dry_256_rough.jpg` | 75714 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_late_064_albedo.jpg` | 100208 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_late_064_late_129_albedo.jpg` | 99800 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_late_064_late_129_normal.jpg` | 150030 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_late_064_late_129_rake_258_albedo.jpg` | 100163 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_late_064_late_129_rake_258_normal.jpg` | 150030 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_late_064_late_129_rake_258_rough.jpg` | 75714 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_late_064_late_129_rough.jpg` | 75714 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_late_064_normal.jpg` | 150030 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_late_064_rough.jpg` | 75714 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_late_064_shade_257_albedo.jpg` | 80565 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_late_064_shade_257_normal.jpg` | 150030 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_late_064_shade_257_rough.jpg` | 75714 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_normal.jpg` | 150030 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_rake_128_albedo.jpg` | 103563 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_rake_128_late_259_albedo.jpg` | 104251 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_rake_128_late_259_normal.jpg` | 150030 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_rake_128_late_259_rough.jpg` | 75714 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_rake_128_normal.jpg` | 150030 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_rake_128_rough.jpg` | 75714 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_rough.jpg` | 75714 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_shade_032_albedo.jpg` | 75323 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_shade_032_normal.jpg` | 150030 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_shade_032_rough.jpg` | 75714 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_albedo.jpg` | 67817 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_dry_131_albedo.jpg` | 68138 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_dry_131_normal.jpg` | 150030 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_dry_131_rough.jpg` | 75714 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_dry_131_shade_262_albedo.jpg` | 52461 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_dry_131_shade_262_normal.jpg` | 150030 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_dry_131_shade_262_rough.jpg` | 75714 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_dry_261_albedo.jpg` | 68138 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_dry_261_normal.jpg` | 150030 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_dry_261_rough.jpg` | 75714 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_normal.jpg` | 150030 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_065_rough.jpg` | 75714 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_130_albedo.jpg` | 67817 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_130_normal.jpg` | 150030 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_130_rake_263_albedo.jpg` | 68405 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_130_rake_263_normal.jpg` | 150030 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_130_rake_263_rough.jpg` | 75714 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_130_rough.jpg` | 75714 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_260_albedo.jpg` | 67817 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_260_normal.jpg` | 150030 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_pine_needles001_shade_032_wet_260_rough.jpg` | 75714 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_albedo.jpg` | 295766 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_dry_066_albedo.jpg` | 285217 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_dry_066_normal.jpg` | 424217 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_dry_066_rake_133_albedo.jpg` | 287749 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_dry_066_rake_133_dry_266_albedo.jpg` | 288408 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_dry_066_rake_133_dry_266_normal.jpg` | 424217 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_dry_066_rake_133_dry_266_rough.jpg` | 338265 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_dry_066_rake_133_normal.jpg` | 424217 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_dry_066_rake_133_rough.jpg` | 338265 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_dry_066_rough.jpg` | 338265 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_dry_066_wet_265_albedo.jpg` | 263557 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_dry_066_wet_265_normal.jpg` | 424217 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_dry_066_wet_265_rough.jpg` | 338265 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_late_264_albedo.jpg` | 273886 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_late_264_normal.jpg` | 424217 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_late_264_rough.jpg` | 338265 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_normal.jpg` | 424217 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_rake_033_albedo.jpg` | 288055 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_rake_033_late_134_albedo.jpg` | 282802 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_rake_033_late_134_normal.jpg` | 424217 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_rake_033_late_134_rake_268_albedo.jpg` | 284230 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_rake_033_late_134_rake_268_normal.jpg` | 424217 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_rake_033_late_134_rake_268_rough.jpg` | 338265 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_rake_033_late_134_rough.jpg` | 338265 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_rake_033_normal.jpg` | 424217 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_rake_033_rough.jpg` | 338265 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_rake_033_shade_067_albedo.jpg` | 235840 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_rake_033_shade_067_late_269_albedo.jpg` | 229891 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_rake_033_shade_067_late_269_normal.jpg` | 424217 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_rake_033_shade_067_late_269_rough.jpg` | 338265 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_rake_033_shade_067_normal.jpg` | 424217 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_rake_033_shade_067_rough.jpg` | 338265 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_rake_033_shade_067_wet_135_albedo.jpg` | 216561 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_rake_033_shade_067_wet_135_normal.jpg` | 424217 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_rake_033_shade_067_wet_135_rough.jpg` | 338265 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_rake_033_shade_067_wet_135_wet_270_albedo.jpg` | 199513 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_rake_033_shade_067_wet_135_wet_270_normal.jpg` | 424217 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_rake_033_shade_067_wet_135_wet_270_rough.jpg` | 338265 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_rake_033_shade_267_albedo.jpg` | 235840 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_rake_033_shade_267_normal.jpg` | 424217 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_rake_033_shade_267_rough.jpg` | 338265 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_rough.jpg` | 338265 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_shade_132_albedo.jpg` | 184886 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_shade_132_dry_271_albedo.jpg` | 186320 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks012_shade_132_dry_271_normal.jpg` | 424217 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_shade_132_dry_271_rough.jpg` | 338265 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_shade_132_normal.jpg` | 424217 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks012_shade_132_rough.jpg` | 338265 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_albedo.jpg` | 316131 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_dry_136_albedo.jpg` | 304687 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_dry_136_normal.jpg` | 446670 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_dry_136_rake_273_albedo.jpg` | 307429 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_dry_136_rake_273_normal.jpg` | 446670 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_dry_136_rake_273_rough.jpg` | 336022 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_dry_136_rough.jpg` | 336022 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_late_034_albedo.jpg` | 292464 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_late_034_late_069_albedo.jpg` | 284467 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_late_034_late_069_normal.jpg` | 446670 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_late_034_late_069_rake_138_albedo.jpg` | 286385 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_late_034_late_069_rake_138_dry_276_albedo.jpg` | 286815 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_late_034_late_069_rake_138_dry_276_normal.jpg` | 446670 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_late_034_late_069_rake_138_dry_276_rough.jpg` | 336022 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_late_034_late_069_rake_138_normal.jpg` | 446670 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_late_034_late_069_rake_138_rough.jpg` | 336022 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_late_034_late_069_rough.jpg` | 336022 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_late_034_late_069_wet_275_albedo.jpg` | 259391 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_late_034_late_069_wet_275_normal.jpg` | 446670 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_late_034_late_069_wet_275_rough.jpg` | 336022 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_late_034_late_274_albedo.jpg` | 284467 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_late_034_late_274_normal.jpg` | 446670 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_late_034_late_274_rough.jpg` | 336022 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_late_034_normal.jpg` | 446670 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_late_034_rough.jpg` | 336022 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_late_034_shade_137_albedo.jpg` | 238293 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_late_034_shade_137_normal.jpg` | 446670 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_late_034_shade_137_rough.jpg` | 336022 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_late_034_shade_137_shade_277_albedo.jpg` | 190216 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_late_034_shade_137_shade_277_normal.jpg` | 446670 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_late_034_shade_137_shade_277_rough.jpg` | 336022 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_normal.jpg` | 446670 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_rake_068_albedo.jpg` | 307619 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_rake_068_late_139_albedo.jpg` | 302056 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_rake_068_late_139_late_279_albedo.jpg` | 293356 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_rake_068_late_139_late_279_normal.jpg` | 446670 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_rake_068_late_139_late_279_rough.jpg` | 336022 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_rake_068_late_139_normal.jpg` | 446670 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_rake_068_late_139_rough.jpg` | 336022 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_rake_068_normal.jpg` | 446670 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_rake_068_rake_278_albedo.jpg` | 310707 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_rake_068_rake_278_normal.jpg` | 446670 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_rake_068_rake_278_rough.jpg` | 336022 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_rake_068_rough.jpg` | 336022 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_rough.jpg` | 336022 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_shade_272_albedo.jpg` | 196549 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks013_shade_272_normal.jpg` | 446670 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks013_shade_272_rough.jpg` | 336022 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks017_albedo.jpg` | 285143 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks017_normal.jpg` | 436237 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks017_rough.jpg` | 344817 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks017_wet_070_albedo.jpg` | 241828 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks017_wet_070_dry_141_albedo.jpg` | 242026 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks017_wet_070_dry_141_normal.jpg` | 436237 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks017_wet_070_dry_141_rough.jpg` | 344817 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks017_wet_070_dry_141_shade_282_albedo.jpg` | 192205 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks017_wet_070_dry_141_shade_282_normal.jpg` | 436237 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks017_wet_070_dry_141_shade_282_rough.jpg` | 344817 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks017_wet_070_dry_281_albedo.jpg` | 242026 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks017_wet_070_dry_281_normal.jpg` | 436237 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks017_wet_070_dry_281_rough.jpg` | 344817 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks017_wet_070_normal.jpg` | 436237 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks017_wet_070_rough.jpg` | 344817 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks017_wet_140_albedo.jpg` | 241828 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks017_wet_140_normal.jpg` | 436237 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks017_wet_140_rake_283_albedo.jpg` | 243969 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks017_wet_140_rake_283_normal.jpg` | 436237 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks017_wet_140_rake_283_rough.jpg` | 344817 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks017_wet_140_rough.jpg` | 344817 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks017_wet_280_albedo.jpg` | 241828 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_planks017_wet_280_normal.jpg` | 436237 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_planks017_wet_280_rough.jpg` | 344817 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_soil001_albedo.jpg` | 641615 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_soil001_dry_071_albedo.jpg` | 611203 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_soil001_dry_071_normal.jpg` | 634189 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_soil001_dry_071_rake_143_albedo.jpg` | 615407 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_soil001_dry_071_rake_143_dry_286_albedo.jpg` | 616740 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_soil001_dry_071_rake_143_dry_286_normal.jpg` | 634189 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_soil001_dry_071_rake_143_dry_286_rough.jpg` | 326433 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_soil001_dry_071_rake_143_normal.jpg` | 634189 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_soil001_dry_071_rake_143_rough.jpg` | 326433 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_soil001_dry_071_rough.jpg` | 326433 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_soil001_dry_071_wet_285_albedo.jpg` | 540897 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_soil001_dry_071_wet_285_normal.jpg` | 634189 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_soil001_dry_071_wet_285_rough.jpg` | 326433 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_soil001_late_284_albedo.jpg` | 577451 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_soil001_late_284_normal.jpg` | 634189 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_soil001_late_284_rough.jpg` | 326433 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_soil001_normal.jpg` | 634189 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_soil001_rough.jpg` | 326433 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_soil001_shade_142_albedo.jpg` | 441377 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_soil001_shade_142_normal.jpg` | 634189 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_soil001_shade_142_rough.jpg` | 326433 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_soil001_shade_142_shade_287_albedo.jpg` | 367258 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_soil001_shade_142_shade_287_normal.jpg` | 634189 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_soil001_shade_142_shade_287_rough.jpg` | 326433 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood001_albedo.jpg` | 212722 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood001_late_144_albedo.jpg` | 192808 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood001_late_144_late_289_albedo.jpg` | 186121 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood001_late_144_late_289_normal.jpg` | 409776 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood001_late_144_late_289_rough.jpg` | 221676 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood001_late_144_normal.jpg` | 409776 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood001_late_144_rough.jpg` | 221676 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood001_normal.jpg` | 409776 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood001_rake_288_albedo.jpg` | 208995 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood001_rake_288_normal.jpg` | 409776 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood001_rake_288_rough.jpg` | 221676 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood001_rough.jpg` | 221676 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood001_shade_072_albedo.jpg` | 126985 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood001_shade_072_normal.jpg` | 409776 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood001_shade_072_rough.jpg` | 221676 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood001_shade_072_wet_145_albedo.jpg` | 119498 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood001_shade_072_wet_145_dry_291_albedo.jpg` | 121902 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood001_shade_072_wet_145_dry_291_normal.jpg` | 409776 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood001_shade_072_wet_145_dry_291_rough.jpg` | 221676 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood001_shade_072_wet_145_normal.jpg` | 409776 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood001_shade_072_wet_145_rough.jpg` | 221676 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood001_shade_072_wet_290_albedo.jpg` | 119498 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood001_shade_072_wet_290_normal.jpg` | 409776 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood001_shade_072_wet_290_rough.jpg` | 221676 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood048_albedo.jpg` | 304755 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood048_dry_146_albedo.jpg` | 295301 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood048_dry_146_normal.jpg` | 266314 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood048_dry_146_rake_293_albedo.jpg` | 298936 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood048_dry_146_rake_293_normal.jpg` | 266314 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood048_dry_146_rake_293_rough.jpg` | 325602 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood048_dry_146_rough.jpg` | 325602 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood048_normal.jpg` | 266314 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood048_rake_073_albedo.jpg` | 298412 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood048_rake_073_late_294_albedo.jpg` | 292993 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood048_rake_073_late_294_normal.jpg` | 266314 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood048_rake_073_late_294_rough.jpg` | 325602 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood048_rake_073_normal.jpg` | 266314 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood048_rake_073_rough.jpg` | 325602 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood048_rake_073_shade_147_albedo.jpg` | 246216 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood048_rake_073_shade_147_normal.jpg` | 266314 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood048_rake_073_shade_147_rough.jpg` | 325602 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood048_rake_073_shade_147_wet_295_albedo.jpg` | 226678 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood048_rake_073_shade_147_wet_295_normal.jpg` | 266314 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood048_rake_073_shade_147_wet_295_rough.jpg` | 325602 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood048_rough.jpg` | 325602 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood048_shade_292_albedo.jpg` | 198093 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood048_shade_292_normal.jpg` | 266314 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood048_shade_292_rough.jpg` | 325602 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood051_albedo.jpg` | 179288 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood051_dry_296_albedo.jpg` | 173236 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood051_dry_296_normal.jpg` | 266706 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood051_dry_296_rough.jpg` | 325801 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood051_late_074_albedo.jpg` | 166819 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood051_late_074_late_149_albedo.jpg` | 161991 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood051_late_074_late_149_normal.jpg` | 266706 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood051_late_074_late_149_rake_298_albedo.jpg` | 164511 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood051_late_074_late_149_rake_298_normal.jpg` | 266706 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood051_late_074_late_149_rake_298_rough.jpg` | 325801 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood051_late_074_late_149_rough.jpg` | 325801 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood051_late_074_normal.jpg` | 266706 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood051_late_074_rough.jpg` | 325801 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood051_late_074_shade_297_albedo.jpg` | 128831 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood051_late_074_shade_297_normal.jpg` | 266706 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood051_late_074_shade_297_rough.jpg` | 325801 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood051_normal.jpg` | 266706 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood051_rake_148_albedo.jpg` | 174986 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood051_rake_148_late_299_albedo.jpg` | 171636 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_wood051_rake_148_late_299_normal.jpg` | 266706 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood051_rake_148_late_299_rough.jpg` | 325801 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood051_rake_148_normal.jpg` | 266706 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood051_rake_148_rough.jpg` | 325801 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_wood051_rough.jpg` | 325801 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_woodchips001_albedo.jpg` | 491145 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_woodchips001_normal.jpg` | 716745 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_woodchips001_rough.jpg` | 403002 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_woodchips001_wet_075_albedo.jpg` | 428627 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_woodchips001_wet_075_dry_151_albedo.jpg` | 431240 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_woodchips001_wet_075_dry_151_normal.jpg` | 716745 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_woodchips001_wet_075_dry_151_rough.jpg` | 403002 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_woodchips001_wet_075_dry_151_shade_302_albedo.jpg` | 363665 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_woodchips001_wet_075_dry_151_shade_302_normal.jpg` | 716745 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_woodchips001_wet_075_dry_151_shade_302_rough.jpg` | 403002 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_woodchips001_wet_075_dry_301_albedo.jpg` | 431240 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_woodchips001_wet_075_dry_301_normal.jpg` | 716745 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_woodchips001_wet_075_dry_301_rough.jpg` | 403002 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_woodchips001_wet_075_normal.jpg` | 716745 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_woodchips001_wet_075_rough.jpg` | 403002 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_woodchips001_wet_150_albedo.jpg` | 428627 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_woodchips001_wet_150_normal.jpg` | 716745 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_woodchips001_wet_150_rake_303_albedo.jpg` | 433507 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_woodchips001_wet_150_rake_303_normal.jpg` | 716745 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_woodchips001_wet_150_rake_303_rough.jpg` | 403002 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_woodchips001_wet_150_rough.jpg` | 403002 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_woodchips001_wet_300_albedo.jpg` | 428627 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/acg_woodchips001_wet_300_normal.jpg` | 716745 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/acg_woodchips001_wet_300_rough.jpg` | 403002 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/aerial_grass_rock_albedo.jpg` | 499344 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/aerial_grass_rock_dry_076_albedo.jpg` | 440569 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/aerial_grass_rock_dry_076_normal.jpg` | 435526 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/aerial_grass_rock_dry_076_rake_153_albedo.jpg` | 433767 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/aerial_grass_rock_dry_076_rake_153_dry_306_albedo.jpg` | 429051 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/aerial_grass_rock_dry_076_rake_153_dry_306_normal.jpg` | 435526 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/aerial_grass_rock_dry_076_rake_153_dry_306_rough.jpg` | 309932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/aerial_grass_rock_dry_076_rake_153_normal.jpg` | 435526 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/aerial_grass_rock_dry_076_rake_153_rough.jpg` | 309932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/aerial_grass_rock_dry_076_rough.jpg` | 309932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/aerial_grass_rock_dry_076_wet_305_albedo.jpg` | 388157 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/aerial_grass_rock_dry_076_wet_305_normal.jpg` | 435526 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/aerial_grass_rock_dry_076_wet_305_rough.jpg` | 309932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/aerial_grass_rock_late_304_albedo.jpg` | 389305 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/aerial_grass_rock_late_304_normal.jpg` | 435526 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/aerial_grass_rock_late_304_rough.jpg` | 309932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/aerial_grass_rock_normal.jpg` | 435526 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/aerial_grass_rock_rough.jpg` | 309932 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/aerial_grass_rock_shade_152_albedo.jpg` | 271535 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/aerial_grass_rock_shade_152_normal.jpg` | 435526 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/aerial_grass_rock_shade_152_rough.jpg` | 309932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/aerial_grass_rock_shade_152_shade_307_albedo.jpg` | 207757 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/aerial_grass_rock_shade_152_shade_307_normal.jpg` | 435526 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/aerial_grass_rock_shade_152_shade_307_rough.jpg` | 309932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_bluegum_albedo.jpg` | 375153 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_bluegum_late_154_albedo.jpg` | 348013 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_bluegum_late_154_late_309_albedo.jpg` | 338969 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_bluegum_late_154_late_309_normal.jpg` | 478275 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_bluegum_late_154_late_309_rough.jpg` | 98027 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_bluegum_late_154_normal.jpg` | 478275 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_bluegum_late_154_rough.jpg` | 98027 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_bluegum_normal.jpg` | 478275 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_bluegum_rake_308_albedo.jpg` | 367126 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_bluegum_rake_308_normal.jpg` | 478275 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_bluegum_rake_308_rough.jpg` | 98027 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_bluegum_rough.jpg` | 98027 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_bluegum_shade_077_albedo.jpg` | 218764 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_bluegum_shade_077_normal.jpg` | 478275 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_bluegum_shade_077_rough.jpg` | 98027 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_bluegum_shade_077_wet_155_albedo.jpg` | 201392 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_bluegum_shade_077_wet_155_dry_311_albedo.jpg` | 201937 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_bluegum_shade_077_wet_155_dry_311_normal.jpg` | 478275 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_bluegum_shade_077_wet_155_dry_311_rough.jpg` | 98027 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_bluegum_shade_077_wet_155_normal.jpg` | 478275 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_bluegum_shade_077_wet_155_rough.jpg` | 98027 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_bluegum_shade_077_wet_310_albedo.jpg` | 201392 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_bluegum_shade_077_wet_310_normal.jpg` | 478275 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_bluegum_shade_077_wet_310_rough.jpg` | 98027 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_brown_01_albedo.jpg` | 506081 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_brown_01_dry_156_albedo.jpg` | 488720 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_brown_01_dry_156_normal.jpg` | 583296 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_brown_01_dry_156_rake_313_albedo.jpg` | 492901 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_brown_01_dry_156_rake_313_normal.jpg` | 583296 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_brown_01_dry_156_rake_313_rough.jpg` | 167513 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_brown_01_dry_156_rough.jpg` | 167513 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_brown_01_normal.jpg` | 583296 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_brown_01_rake_078_albedo.jpg` | 493574 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_brown_01_rake_078_late_314_albedo.jpg` | 483900 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_brown_01_rake_078_late_314_normal.jpg` | 583296 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_brown_01_rake_078_late_314_rough.jpg` | 167513 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_brown_01_rake_078_normal.jpg` | 583296 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_brown_01_rake_078_rough.jpg` | 167513 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_brown_01_rake_078_shade_157_albedo.jpg` | 405820 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_brown_01_rake_078_shade_157_normal.jpg` | 583296 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_brown_01_rake_078_shade_157_rough.jpg` | 167513 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_brown_01_rake_078_shade_157_wet_315_albedo.jpg` | 367597 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_brown_01_rake_078_shade_157_wet_315_normal.jpg` | 583296 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_brown_01_rake_078_shade_157_wet_315_rough.jpg` | 167513 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_brown_01_rough.jpg` | 167513 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_brown_01_shade_312_albedo.jpg` | 292949 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_brown_01_shade_312_normal.jpg` | 583296 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_brown_01_shade_312_rough.jpg` | 167513 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_platanus_albedo.jpg` | 398104 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_platanus_dry_316_albedo.jpg` | 385413 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_platanus_dry_316_normal.jpg` | 567223 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_platanus_dry_316_rough.jpg` | 126562 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_platanus_late_079_albedo.jpg` | 370064 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_platanus_late_079_late_159_albedo.jpg` | 360941 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_platanus_late_079_late_159_normal.jpg` | 567223 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_platanus_late_079_late_159_rake_318_albedo.jpg` | 362927 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_platanus_late_079_late_159_rake_318_normal.jpg` | 567223 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_platanus_late_079_late_159_rake_318_rough.jpg` | 126562 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_platanus_late_079_late_159_rough.jpg` | 126562 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_platanus_late_079_normal.jpg` | 567223 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_platanus_late_079_rough.jpg` | 126562 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_platanus_late_079_shade_317_albedo.jpg` | 308048 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_platanus_late_079_shade_317_normal.jpg` | 567223 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_platanus_late_079_shade_317_rough.jpg` | 126562 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_platanus_normal.jpg` | 567223 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_platanus_rake_158_albedo.jpg` | 389316 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_platanus_rake_158_late_319_albedo.jpg` | 383401 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_platanus_rake_158_late_319_normal.jpg` | 567223 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_platanus_rake_158_late_319_rough.jpg` | 126562 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_platanus_rake_158_normal.jpg` | 567223 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_platanus_rake_158_rough.jpg` | 126562 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_platanus_rough.jpg` | 126562 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_02_albedo.jpg` | 463009 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_02_normal.jpg` | 611990 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_02_rough.jpg` | 182692 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_02_wet_080_albedo.jpg` | 406416 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_02_wet_080_dry_161_albedo.jpg` | 409817 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_02_wet_080_dry_161_normal.jpg` | 611990 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_02_wet_080_dry_161_rough.jpg` | 182692 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_02_wet_080_dry_161_shade_322_albedo.jpg` | 341351 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_02_wet_080_dry_161_shade_322_normal.jpg` | 611990 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_02_wet_080_dry_161_shade_322_rough.jpg` | 182692 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_02_wet_080_dry_321_albedo.jpg` | 409817 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_02_wet_080_dry_321_normal.jpg` | 611990 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_02_wet_080_dry_321_rough.jpg` | 182692 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_02_wet_080_normal.jpg` | 611990 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_02_wet_080_rough.jpg` | 182692 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_02_wet_160_albedo.jpg` | 406416 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_02_wet_160_normal.jpg` | 611990 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_02_wet_160_rake_323_albedo.jpg` | 411659 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_02_wet_160_rake_323_normal.jpg` | 611990 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_02_wet_160_rake_323_rough.jpg` | 182692 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_02_wet_160_rough.jpg` | 182692 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_02_wet_320_albedo.jpg` | 406416 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_02_wet_320_normal.jpg` | 611990 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_02_wet_320_rough.jpg` | 182692 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_albedo.jpg` | 326799 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_dry_081_albedo.jpg` | 317399 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_dry_081_normal.jpg` | 659421 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_dry_081_rake_163_albedo.jpg` | 320051 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_dry_081_rake_163_dry_326_albedo.jpg` | 321157 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_dry_081_rake_163_dry_326_normal.jpg` | 659421 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_dry_081_rake_163_dry_326_rough.jpg` | 101556 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_dry_081_rake_163_normal.jpg` | 659421 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_dry_081_rake_163_rough.jpg` | 101556 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_dry_081_rough.jpg` | 101556 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_dry_081_wet_325_albedo.jpg` | 290900 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_dry_081_wet_325_normal.jpg` | 659421 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_dry_081_wet_325_rough.jpg` | 101556 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_late_324_albedo.jpg` | 302496 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_late_324_normal.jpg` | 659421 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_late_324_rough.jpg` | 101556 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_normal.jpg` | 659421 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_rough.jpg` | 101556 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_shade_162_albedo.jpg` | 187846 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_shade_162_normal.jpg` | 659421 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_shade_162_rough.jpg` | 101556 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_shade_162_shade_327_albedo.jpg` | 143506 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bark_willow_shade_162_shade_327_normal.jpg` | 659421 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bark_willow_shade_162_shade_327_rough.jpg` | 101556 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/baseball_playground_albedo.jpg` | 248819 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/baseball_playground_late_164_albedo.jpg` | 223667 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/baseball_playground_late_164_late_329_albedo.jpg` | 217654 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/baseball_playground_late_164_late_329_normal.jpg` | 414174 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/baseball_playground_late_164_late_329_rough.jpg` | 301437 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/baseball_playground_late_164_normal.jpg` | 414174 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/baseball_playground_late_164_rough.jpg` | 301437 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/baseball_playground_normal.jpg` | 414174 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/baseball_playground_rake_328_albedo.jpg` | 241946 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/baseball_playground_rake_328_normal.jpg` | 414174 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/baseball_playground_rake_328_rough.jpg` | 301437 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/baseball_playground_rough.jpg` | 301437 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/baseball_playground_shade_082_albedo.jpg` | 135899 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/baseball_playground_shade_082_normal.jpg` | 414174 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/baseball_playground_shade_082_rough.jpg` | 301437 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/baseball_playground_shade_082_wet_165_albedo.jpg` | 121072 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/baseball_playground_shade_082_wet_165_dry_331_albedo.jpg` | 120815 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/baseball_playground_shade_082_wet_165_dry_331_normal.jpg` | 414174 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/baseball_playground_shade_082_wet_165_dry_331_rough.jpg` | 301437 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/baseball_playground_shade_082_wet_165_normal.jpg` | 414174 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/baseball_playground_shade_082_wet_165_rough.jpg` | 301437 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/baseball_playground_shade_082_wet_330_albedo.jpg` | 121072 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/baseball_playground_shade_082_wet_330_normal.jpg` | 414174 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/baseball_playground_shade_082_wet_330_rough.jpg` | 301437 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bicolour_gravel_albedo.jpg` | 660327 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bicolour_gravel_dry_166_albedo.jpg` | 637279 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bicolour_gravel_dry_166_normal.jpg` | 608132 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bicolour_gravel_dry_166_rake_333_albedo.jpg` | 644719 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bicolour_gravel_dry_166_rake_333_normal.jpg` | 608132 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bicolour_gravel_dry_166_rake_333_rough.jpg` | 428642 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bicolour_gravel_dry_166_rough.jpg` | 428642 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bicolour_gravel_normal.jpg` | 608132 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bicolour_gravel_rake_083_albedo.jpg` | 647870 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bicolour_gravel_rake_083_late_334_albedo.jpg` | 645925 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bicolour_gravel_rake_083_late_334_normal.jpg` | 608132 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bicolour_gravel_rake_083_late_334_rough.jpg` | 428642 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bicolour_gravel_rake_083_normal.jpg` | 608132 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bicolour_gravel_rake_083_rough.jpg` | 428642 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bicolour_gravel_rake_083_shade_167_albedo.jpg` | 546703 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bicolour_gravel_rake_083_shade_167_normal.jpg` | 608132 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bicolour_gravel_rake_083_shade_167_rough.jpg` | 428642 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bicolour_gravel_rake_083_shade_167_wet_335_albedo.jpg` | 490680 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bicolour_gravel_rake_083_shade_167_wet_335_normal.jpg` | 608132 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bicolour_gravel_rake_083_shade_167_wet_335_rough.jpg` | 428642 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bicolour_gravel_rough.jpg` | 428642 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bicolour_gravel_shade_332_albedo.jpg` | 459546 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/bicolour_gravel_shade_332_normal.jpg` | 608132 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/bicolour_gravel_shade_332_rough.jpg` | 428642 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_leather_albedo.jpg` | 343182 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_leather_dry_336_albedo.jpg` | 332275 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_leather_dry_336_normal.jpg` | 401905 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_leather_dry_336_rough.jpg` | 596986 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_leather_late_084_albedo.jpg` | 313091 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_leather_late_084_late_169_albedo.jpg` | 303894 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_leather_late_084_late_169_normal.jpg` | 401905 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_leather_late_084_late_169_rake_338_albedo.jpg` | 305142 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_leather_late_084_late_169_rake_338_normal.jpg` | 401905 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_leather_late_084_late_169_rake_338_rough.jpg` | 596986 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_leather_late_084_late_169_rough.jpg` | 596986 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_leather_late_084_normal.jpg` | 401905 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_leather_late_084_rough.jpg` | 596986 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_leather_late_084_shade_337_albedo.jpg` | 261816 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_leather_late_084_shade_337_normal.jpg` | 401905 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_leather_late_084_shade_337_rough.jpg` | 596986 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_leather_normal.jpg` | 401905 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_leather_rake_168_albedo.jpg` | 334424 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_leather_rake_168_late_339_albedo.jpg` | 324933 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_leather_rake_168_late_339_normal.jpg` | 401905 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_leather_rake_168_late_339_rough.jpg` | 596986 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_leather_rake_168_normal.jpg` | 401905 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_leather_rake_168_rough.jpg` | 596986 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_leather_rough.jpg` | 596986 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_03_albedo.jpg` | 412828 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_03_normal.jpg` | 590599 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_03_rough.jpg` | 330745 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_03_wet_085_albedo.jpg` | 357992 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_03_wet_085_dry_171_albedo.jpg` | 362797 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_03_wet_085_dry_171_normal.jpg` | 590599 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_03_wet_085_dry_171_rough.jpg` | 330745 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_03_wet_085_dry_171_shade_342_albedo.jpg` | 301727 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_03_wet_085_dry_171_shade_342_normal.jpg` | 590599 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_03_wet_085_dry_171_shade_342_rough.jpg` | 330745 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_03_wet_085_dry_341_albedo.jpg` | 362797 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_03_wet_085_dry_341_normal.jpg` | 590599 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_03_wet_085_dry_341_rough.jpg` | 330745 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_03_wet_085_normal.jpg` | 590599 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_03_wet_085_rough.jpg` | 330745 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_03_wet_170_albedo.jpg` | 357992 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_03_wet_170_normal.jpg` | 590599 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_03_wet_170_rake_343_albedo.jpg` | 364974 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_03_wet_170_rake_343_normal.jpg` | 590599 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_03_wet_170_rake_343_rough.jpg` | 330745 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_03_wet_170_rough.jpg` | 330745 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_03_wet_340_albedo.jpg` | 357992 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_03_wet_340_normal.jpg` | 590599 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_03_wet_340_rough.jpg` | 330745 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_albedo.jpg` | 411663 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_dry_086_albedo.jpg` | 395612 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_dry_086_normal.jpg` | 503324 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_086_rake_173_albedo.jpg` | 401400 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_dry_086_rake_173_dry_346_albedo.jpg` | 403025 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_dry_086_rake_173_dry_346_normal.jpg` | 503324 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_086_rake_173_dry_346_rough.jpg` | 290106 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_086_rake_173_normal.jpg` | 503324 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_086_rake_173_rough.jpg` | 290106 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_086_rough.jpg` | 290106 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_086_wet_345_albedo.jpg` | 362451 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_dry_086_wet_345_normal.jpg` | 503324 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_086_wet_345_rough.jpg` | 290106 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_albedo.jpg` | 659548 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_dry_late_174_albedo.jpg` | 588528 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_dry_late_174_normal.jpg` | 714977 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_late_174_rake_348_albedo.jpg` | 593773 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_dry_late_174_rake_348_normal.jpg` | 714977 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_late_174_rake_348_rough.jpg` | 336798 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_late_174_rough.jpg` | 336798 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_normal.jpg` | 714977 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_dry_rough.jpg` | 336798 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_dry_shade_087_albedo.jpg` | 450165 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_dry_shade_087_late_349_albedo.jpg` | 440340 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_dry_shade_087_late_349_normal.jpg` | 714977 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_shade_087_late_349_rough.jpg` | 336798 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_shade_087_normal.jpg` | 714977 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_shade_087_rough.jpg` | 336798 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_shade_087_wet_175_albedo.jpg` | 409495 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_dry_shade_087_wet_175_normal.jpg` | 714977 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_shade_087_wet_175_rough.jpg` | 336798 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_shade_087_wet_175_wet_350_albedo.jpg` | 373844 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_dry_shade_087_wet_175_wet_350_normal.jpg` | 714977 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_shade_087_wet_175_wet_350_rough.jpg` | 336798 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_shade_347_albedo.jpg` | 450165 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_dry_shade_347_normal.jpg` | 714977 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_dry_shade_347_rough.jpg` | 336798 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_late_344_albedo.jpg` | 382393 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_late_344_normal.jpg` | 503324 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_late_344_rough.jpg` | 290106 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_leaves_albedo.jpg` | 611569 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_leaves_dry_176_albedo.jpg` | 571520 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_leaves_dry_176_normal.jpg` | 682210 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_leaves_dry_176_rough.jpg` | 298822 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_leaves_dry_176_shade_352_albedo.jpg` | 463029 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_leaves_dry_176_shade_352_normal.jpg` | 682210 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_leaves_dry_176_shade_352_rough.jpg` | 298822 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_leaves_dry_351_albedo.jpg` | 571520 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_leaves_dry_351_normal.jpg` | 682210 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_leaves_dry_351_rough.jpg` | 298822 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_leaves_normal.jpg` | 682210 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_leaves_rake_088_albedo.jpg` | 578686 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_leaves_rake_088_normal.jpg` | 682210 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_leaves_rake_088_rake_353_albedo.jpg` | 579293 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_leaves_rake_088_rake_353_normal.jpg` | 682210 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_leaves_rake_088_rake_353_rough.jpg` | 298822 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_leaves_rake_088_rough.jpg` | 298822 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_leaves_rake_088_shade_177_albedo.jpg` | 474500 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_leaves_rake_088_shade_177_late_354_albedo.jpg` | 456058 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_leaves_rake_088_shade_177_late_354_normal.jpg` | 682210 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_leaves_rake_088_shade_177_late_354_rough.jpg` | 298822 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_leaves_rake_088_shade_177_normal.jpg` | 682210 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_leaves_rake_088_shade_177_rough.jpg` | 298822 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_leaves_rough.jpg` | 298822 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_normal.jpg` | 503324 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_rough.jpg` | 290106 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_shade_172_albedo.jpg` | 247588 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_shade_172_normal.jpg` | 503324 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_shade_172_rough.jpg` | 290106 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_shade_172_wet_355_albedo.jpg` | 228711 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_mud_shade_172_wet_355_normal.jpg` | 503324 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_mud_shade_172_wet_355_rough.jpg` | 290106 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_03_albedo.jpg` | 428461 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_03_dry_356_albedo.jpg` | 417686 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_03_dry_356_normal.jpg` | 234747 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_03_dry_356_rough.jpg` | 186115 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_03_late_089_albedo.jpg` | 402155 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_03_late_089_late_179_albedo.jpg` | 391884 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_03_late_089_late_179_normal.jpg` | 234747 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_03_late_089_late_179_rake_358_albedo.jpg` | 394157 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_03_late_089_late_179_rake_358_normal.jpg` | 234747 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_03_late_089_late_179_rake_358_rough.jpg` | 186115 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_03_late_089_late_179_rough.jpg` | 186115 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_03_late_089_normal.jpg` | 234747 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_03_late_089_rough.jpg` | 186115 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_03_late_089_shade_357_albedo.jpg` | 335732 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_03_late_089_shade_357_normal.jpg` | 234747 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_03_late_089_shade_357_rough.jpg` | 186115 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_03_normal.jpg` | 234747 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_03_rake_178_albedo.jpg` | 421172 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_03_rake_178_late_359_albedo.jpg` | 418839 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_03_rake_178_late_359_normal.jpg` | 234747 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_03_rake_178_late_359_rough.jpg` | 186115 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_03_rake_178_normal.jpg` | 234747 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_03_rake_178_rough.jpg` | 186115 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_03_rough.jpg` | 186115 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_04_albedo.jpg` | 221638 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_04_normal.jpg` | 279237 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_04_rough.jpg` | 75130 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_04_wet_090_albedo.jpg` | 190998 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_04_wet_090_dry_181_albedo.jpg` | 191125 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_04_wet_090_dry_181_normal.jpg` | 279237 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_04_wet_090_dry_181_rough.jpg` | 75130 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_04_wet_090_dry_181_shade_362_albedo.jpg` | 149156 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_04_wet_090_dry_181_shade_362_normal.jpg` | 279237 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_04_wet_090_dry_181_shade_362_rough.jpg` | 75130 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_04_wet_090_dry_361_albedo.jpg` | 191125 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_04_wet_090_dry_361_normal.jpg` | 279237 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_04_wet_090_dry_361_rough.jpg` | 75130 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_04_wet_090_normal.jpg` | 279237 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_04_wet_090_rough.jpg` | 75130 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_04_wet_180_albedo.jpg` | 190998 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_04_wet_180_normal.jpg` | 279237 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_04_wet_180_rake_363_albedo.jpg` | 193109 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_04_wet_180_rake_363_normal.jpg` | 279237 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_04_wet_180_rake_363_rough.jpg` | 75130 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_04_wet_180_rough.jpg` | 75130 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_04_wet_360_albedo.jpg` | 190998 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/brown_planks_04_wet_360_normal.jpg` | 279237 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/brown_planks_04_wet_360_rough.jpg` | 75130 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/chinese_cedar_bark_albedo.jpg` | 288668 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/chinese_cedar_bark_dry_091_albedo.jpg` | 279052 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/chinese_cedar_bark_dry_091_normal.jpg` | 377068 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/chinese_cedar_bark_dry_091_rake_183_albedo.jpg` | 281234 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/chinese_cedar_bark_dry_091_rake_183_dry_366_albedo.jpg` | 281825 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/chinese_cedar_bark_dry_091_rake_183_dry_366_normal.jpg` | 377068 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/chinese_cedar_bark_dry_091_rake_183_dry_366_rough.jpg` | 48683 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/chinese_cedar_bark_dry_091_rake_183_normal.jpg` | 377068 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/chinese_cedar_bark_dry_091_rake_183_rough.jpg` | 48683 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/chinese_cedar_bark_dry_091_rough.jpg` | 48683 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/chinese_cedar_bark_dry_091_wet_365_albedo.jpg` | 254385 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/chinese_cedar_bark_dry_091_wet_365_normal.jpg` | 377068 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/chinese_cedar_bark_dry_091_wet_365_rough.jpg` | 48683 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/chinese_cedar_bark_late_364_albedo.jpg` | 265955 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/chinese_cedar_bark_late_364_normal.jpg` | 377068 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/chinese_cedar_bark_late_364_rough.jpg` | 48683 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/chinese_cedar_bark_normal.jpg` | 377068 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/chinese_cedar_bark_rough.jpg` | 48683 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/chinese_cedar_bark_shade_182_albedo.jpg` | 171394 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/chinese_cedar_bark_shade_182_normal.jpg` | 377068 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/chinese_cedar_bark_shade_182_rough.jpg` | 48683 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/chinese_cedar_bark_shade_182_shade_367_albedo.jpg` | 134322 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/chinese_cedar_bark_shade_182_shade_367_normal.jpg` | 377068 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/chinese_cedar_bark_shade_182_shade_367_rough.jpg` | 48683 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/coated_pine_albedo.jpg` | 251356 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/coated_pine_late_184_albedo.jpg` | 227405 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/coated_pine_late_184_late_369_albedo.jpg` | 221109 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/coated_pine_late_184_late_369_normal.jpg` | 87845 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/coated_pine_late_184_late_369_rough.jpg` | 192611 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/coated_pine_late_184_normal.jpg` | 87845 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/coated_pine_late_184_rough.jpg` | 192611 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/coated_pine_normal.jpg` | 87845 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/coated_pine_rake_368_albedo.jpg` | 241794 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/coated_pine_rake_368_normal.jpg` | 87845 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/coated_pine_rake_368_rough.jpg` | 192611 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/coated_pine_rough.jpg` | 192611 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/coated_pine_shade_092_albedo.jpg` | 150052 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/coated_pine_shade_092_normal.jpg` | 87845 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/coated_pine_shade_092_rough.jpg` | 192611 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/coated_pine_shade_092_wet_185_albedo.jpg` | 138150 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/coated_pine_shade_092_wet_185_dry_371_albedo.jpg` | 138864 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/coated_pine_shade_092_wet_185_dry_371_normal.jpg` | 87845 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/coated_pine_shade_092_wet_185_dry_371_rough.jpg` | 192611 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/coated_pine_shade_092_wet_185_normal.jpg` | 87845 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/coated_pine_shade_092_wet_185_rough.jpg` | 192611 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/coated_pine_shade_092_wet_370_albedo.jpg` | 138150 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/coated_pine_shade_092_wet_370_normal.jpg` | 87845 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/coated_pine_shade_092_wet_370_rough.jpg` | 192611 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/damp_sand_albedo.jpg` | 452556 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/damp_sand_dry_186_albedo.jpg` | 428686 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/damp_sand_dry_186_normal.jpg` | 525465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/damp_sand_dry_186_rake_373_albedo.jpg` | 428887 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/damp_sand_dry_186_rake_373_normal.jpg` | 525465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/damp_sand_dry_186_rake_373_rough.jpg` | 149773 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/damp_sand_dry_186_rough.jpg` | 149773 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/damp_sand_normal.jpg` | 525465 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/damp_sand_rake_093_albedo.jpg` | 433083 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/damp_sand_rake_093_late_374_albedo.jpg` | 414867 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/damp_sand_rake_093_late_374_normal.jpg` | 525465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/damp_sand_rake_093_late_374_rough.jpg` | 149773 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/damp_sand_rake_093_normal.jpg` | 525465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/damp_sand_rake_093_rough.jpg` | 149773 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/damp_sand_rake_093_shade_187_albedo.jpg` | 346275 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/damp_sand_rake_093_shade_187_normal.jpg` | 525465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/damp_sand_rake_093_shade_187_rough.jpg` | 149773 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/damp_sand_rake_093_shade_187_wet_375_albedo.jpg` | 313896 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/damp_sand_rake_093_shade_187_wet_375_normal.jpg` | 525465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/damp_sand_rake_093_shade_187_wet_375_rough.jpg` | 149773 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/damp_sand_rough.jpg` | 149773 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/damp_sand_shade_372_albedo.jpg` | 249231 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/damp_sand_shade_372_normal.jpg` | 525465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/damp_sand_shade_372_rough.jpg` | 149773 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_planks_albedo.jpg` | 278163 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_planks_dry_376_albedo.jpg` | 270400 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_planks_dry_376_normal.jpg` | 194058 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_planks_dry_376_rough.jpg` | 100819 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_planks_late_094_albedo.jpg` | 259396 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_planks_late_094_late_189_albedo.jpg` | 252970 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_planks_late_094_late_189_normal.jpg` | 194058 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_planks_late_094_late_189_rake_378_albedo.jpg` | 254980 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_planks_late_094_late_189_rake_378_normal.jpg` | 194058 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_planks_late_094_late_189_rake_378_rough.jpg` | 100819 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_planks_late_094_late_189_rough.jpg` | 100819 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_planks_late_094_normal.jpg` | 194058 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_planks_late_094_rough.jpg` | 100819 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_planks_late_094_shade_377_albedo.jpg` | 213950 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_planks_late_094_shade_377_normal.jpg` | 194058 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_planks_late_094_shade_377_rough.jpg` | 100819 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_planks_normal.jpg` | 194058 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_planks_rake_188_albedo.jpg` | 273771 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_planks_rake_188_late_379_albedo.jpg` | 269213 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_planks_rake_188_late_379_normal.jpg` | 194058 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_planks_rake_188_late_379_rough.jpg` | 100819 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_planks_rake_188_normal.jpg` | 194058 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_planks_rake_188_rough.jpg` | 100819 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_planks_rough.jpg` | 100819 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_wood_albedo.jpg` | 277824 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_wood_normal.jpg` | 77268 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_wood_rough.jpg` | 244320 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_wood_wet_095_albedo.jpg` | 238767 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_wood_wet_095_dry_191_albedo.jpg` | 239095 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_wood_wet_095_dry_191_normal.jpg` | 77268 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_wood_wet_095_dry_191_rough.jpg` | 244320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_wood_wet_095_dry_191_shade_382_albedo.jpg` | 190538 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_wood_wet_095_dry_191_shade_382_normal.jpg` | 77268 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_wood_wet_095_dry_191_shade_382_rough.jpg` | 244320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_wood_wet_095_dry_381_albedo.jpg` | 239095 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_wood_wet_095_dry_381_normal.jpg` | 77268 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_wood_wet_095_dry_381_rough.jpg` | 244320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_wood_wet_095_normal.jpg` | 77268 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_wood_wet_095_rough.jpg` | 244320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_wood_wet_190_albedo.jpg` | 238767 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_wood_wet_190_normal.jpg` | 77268 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_wood_wet_190_rake_383_albedo.jpg` | 240981 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_wood_wet_190_rake_383_normal.jpg` | 77268 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_wood_wet_190_rake_383_rough.jpg` | 244320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_wood_wet_190_rough.jpg` | 244320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_wood_wet_380_albedo.jpg` | 238767 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dark_wood_wet_380_normal.jpg` | 77268 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dark_wood_wet_380_rough.jpg` | 244320 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/denim_fabric_skip_albedo.jpg` | 397714 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/denim_fabric_skip_dry_096_albedo.jpg` | 383522 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/denim_fabric_skip_dry_096_normal.jpg` | 383465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/denim_fabric_skip_dry_096_rake_193_albedo.jpg` | 385896 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/denim_fabric_skip_dry_096_rake_193_dry_386_albedo.jpg` | 386362 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/denim_fabric_skip_dry_096_rake_193_dry_386_normal.jpg` | 383465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/denim_fabric_skip_dry_096_rake_193_dry_386_rough.jpg` | 438363 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/denim_fabric_skip_dry_096_rake_193_normal.jpg` | 383465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/denim_fabric_skip_dry_096_rake_193_rough.jpg` | 438363 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/denim_fabric_skip_dry_096_rough.jpg` | 438363 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/denim_fabric_skip_dry_096_wet_385_albedo.jpg` | 351643 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/denim_fabric_skip_dry_096_wet_385_normal.jpg` | 383465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/denim_fabric_skip_dry_096_wet_385_rough.jpg` | 438363 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/denim_fabric_skip_late_384_albedo.jpg` | 363632 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/denim_fabric_skip_late_384_normal.jpg` | 383465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/denim_fabric_skip_late_384_rough.jpg` | 438363 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/denim_fabric_skip_normal.jpg` | 383465 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/denim_fabric_skip_rough.jpg` | 438363 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/denim_fabric_skip_shade_192_albedo.jpg` | 230010 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/denim_fabric_skip_shade_192_normal.jpg` | 383465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/denim_fabric_skip_shade_192_rough.jpg` | 438363 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/denim_fabric_skip_shade_192_shade_387_albedo.jpg` | 187396 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/denim_fabric_skip_shade_192_shade_387_normal.jpg` | 383465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/denim_fabric_skip_shade_192_shade_387_rough.jpg` | 438363 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_albedo.jpg` | 333414 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_floor_albedo.jpg` | 462442 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_floor_late_389_albedo.jpg` | 403428 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_floor_late_389_normal.jpg` | 484251 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_floor_late_389_rough.jpg` | 103555 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_floor_normal.jpg` | 484251 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_floor_rake_098_albedo.jpg` | 443394 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_floor_rake_098_dry_196_albedo.jpg` | 441216 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_floor_rake_098_dry_196_dry_391_albedo.jpg` | 432874 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_floor_rake_098_dry_196_dry_391_normal.jpg` | 484251 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_floor_rake_098_dry_196_dry_391_rough.jpg` | 103555 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_floor_rake_098_dry_196_normal.jpg` | 484251 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_floor_rake_098_dry_196_rough.jpg` | 103555 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_floor_rake_098_normal.jpg` | 484251 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_floor_rake_098_rough.jpg` | 103555 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_floor_rake_098_wet_390_albedo.jpg` | 398545 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_floor_rake_098_wet_390_normal.jpg` | 484251 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_floor_rake_098_wet_390_rough.jpg` | 103555 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_floor_rough.jpg` | 103555 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_floor_wet_195_albedo.jpg` | 393054 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_floor_wet_195_normal.jpg` | 484251 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_floor_wet_195_rough.jpg` | 103555 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_floor_wet_195_shade_392_albedo.jpg` | 322166 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_floor_wet_195_shade_392_normal.jpg` | 484251 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_floor_wet_195_shade_392_rough.jpg` | 103555 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_late_194_albedo.jpg` | 299968 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_late_194_normal.jpg` | 506896 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_late_194_rake_393_albedo.jpg` | 302828 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_late_194_rake_393_normal.jpg` | 506896 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_late_194_rake_393_rough.jpg` | 76195 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_late_194_rough.jpg` | 76195 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_normal.jpg` | 506896 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_rake_388_albedo.jpg` | 323746 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_rake_388_normal.jpg` | 506896 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_rake_388_rough.jpg` | 76195 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_rough.jpg` | 76195 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_shade_097_albedo.jpg` | 178116 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_shade_097_late_394_albedo.jpg` | 173086 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_shade_097_late_394_normal.jpg` | 506896 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_shade_097_late_394_rough.jpg` | 76195 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_shade_097_normal.jpg` | 506896 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_shade_097_rough.jpg` | 76195 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_shade_097_shade_197_albedo.jpg` | 141764 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_shade_097_shade_197_normal.jpg` | 506896 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_shade_097_shade_197_rough.jpg` | 76195 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_shade_097_shade_197_wet_395_albedo.jpg` | 133132 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dirt_shade_097_shade_197_wet_395_normal.jpg` | 506896 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dirt_shade_097_shade_197_wet_395_rough.jpg` | 76195 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/distressed_painted_planks_albedo.jpg` | 112278 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/distressed_painted_planks_dry_396_albedo.jpg` | 108218 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/distressed_painted_planks_dry_396_normal.jpg` | 124229 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/distressed_painted_planks_dry_396_rough.jpg` | 116194 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/distressed_painted_planks_late_099_albedo.jpg` | 100624 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/distressed_painted_planks_late_099_late_199_albedo.jpg` | 97316 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/distressed_painted_planks_late_099_late_199_normal.jpg` | 124229 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/distressed_painted_planks_late_099_late_199_rake_398_albedo.jpg` | 99739 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/distressed_painted_planks_late_099_late_199_rake_398_normal.jpg` | 124229 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/distressed_painted_planks_late_099_late_199_rake_398_rough.jpg` | 116194 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/distressed_painted_planks_late_099_late_199_rough.jpg` | 116194 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/distressed_painted_planks_late_099_normal.jpg` | 124229 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/distressed_painted_planks_late_099_rough.jpg` | 116194 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/distressed_painted_planks_late_099_shade_397_albedo.jpg` | 77056 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/distressed_painted_planks_late_099_shade_397_normal.jpg` | 124229 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/distressed_painted_planks_late_099_shade_397_rough.jpg` | 116194 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/distressed_painted_planks_normal.jpg` | 124229 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/distressed_painted_planks_rake_198_albedo.jpg` | 109175 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/distressed_painted_planks_rake_198_late_399_albedo.jpg` | 105030 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/distressed_painted_planks_rake_198_late_399_normal.jpg` | 124229 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/distressed_painted_planks_rake_198_late_399_rough.jpg` | 116194 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/distressed_painted_planks_rake_198_normal.jpg` | 124229 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/distressed_painted_planks_rake_198_rough.jpg` | 116194 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/distressed_painted_planks_rough.jpg` | 116194 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dry_ground_01_albedo.jpg` | 463155 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dry_ground_01_normal.jpg` | 287539 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dry_ground_01_rough.jpg` | 288074 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dry_ground_01_wet_100_albedo.jpg` | 406546 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dry_ground_01_wet_100_dry_201_albedo.jpg` | 411543 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dry_ground_01_wet_100_dry_201_normal.jpg` | 287539 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dry_ground_01_wet_100_dry_201_rough.jpg` | 288074 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dry_ground_01_wet_100_dry_201_shade_402_albedo.jpg` | 343462 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dry_ground_01_wet_100_dry_201_shade_402_normal.jpg` | 287539 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dry_ground_01_wet_100_dry_201_shade_402_rough.jpg` | 288074 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dry_ground_01_wet_100_dry_401_albedo.jpg` | 411543 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dry_ground_01_wet_100_dry_401_normal.jpg` | 287539 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dry_ground_01_wet_100_dry_401_rough.jpg` | 288074 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dry_ground_01_wet_100_normal.jpg` | 287539 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dry_ground_01_wet_100_rough.jpg` | 288074 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dry_ground_01_wet_200_albedo.jpg` | 406546 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dry_ground_01_wet_200_normal.jpg` | 287539 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dry_ground_01_wet_200_rake_403_albedo.jpg` | 413837 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dry_ground_01_wet_200_rake_403_normal.jpg` | 287539 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dry_ground_01_wet_200_rake_403_rough.jpg` | 288074 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dry_ground_01_wet_200_rough.jpg` | 288074 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dry_ground_01_wet_400_albedo.jpg` | 406546 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/dry_ground_01_wet_400_normal.jpg` | 287539 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/dry_ground_01_wet_400_rough.jpg` | 288074 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_01_albedo.jpg` | 376476 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_01_dry_101_albedo.jpg` | 361679 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_01_dry_101_normal.jpg` | 304313 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_01_dry_101_rake_203_albedo.jpg` | 363975 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_01_dry_101_rake_203_dry_406_albedo.jpg` | 364358 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_01_dry_101_rake_203_dry_406_normal.jpg` | 304313 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_01_dry_101_rake_203_dry_406_rough.jpg` | 494264 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_01_dry_101_rake_203_normal.jpg` | 304313 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_01_dry_101_rake_203_rough.jpg` | 494264 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_01_dry_101_rough.jpg` | 494264 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_01_dry_101_wet_405_albedo.jpg` | 322806 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_01_dry_101_wet_405_normal.jpg` | 304313 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_01_dry_101_wet_405_rough.jpg` | 494264 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_01_late_404_albedo.jpg` | 336357 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_01_late_404_normal.jpg` | 304313 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_01_late_404_rough.jpg` | 494264 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_01_normal.jpg` | 304313 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_01_rough.jpg` | 494264 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_01_shade_202_albedo.jpg` | 189499 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_01_shade_202_normal.jpg` | 304313 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_01_shade_202_rough.jpg` | 494264 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_01_shade_202_shade_407_albedo.jpg` | 141962 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_01_shade_202_shade_407_normal.jpg` | 304313 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_01_shade_202_shade_407_rough.jpg` | 494264 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_02_albedo.jpg` | 430373 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_02_late_204_albedo.jpg` | 384796 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_02_late_204_late_409_albedo.jpg` | 372977 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_02_late_204_late_409_normal.jpg` | 191136 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_02_late_204_late_409_rough.jpg` | 549644 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_02_late_204_normal.jpg` | 191136 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_02_late_204_rough.jpg` | 549644 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_02_normal.jpg` | 191136 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_02_rake_408_albedo.jpg` | 418787 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_02_rake_408_normal.jpg` | 191136 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_02_rake_408_rough.jpg` | 549644 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_02_rough.jpg` | 549644 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_02_shade_102_albedo.jpg` | 223601 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_02_shade_102_normal.jpg` | 191136 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_02_shade_102_rough.jpg` | 549644 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_02_shade_102_wet_205_albedo.jpg` | 205094 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_02_shade_102_wet_205_dry_411_albedo.jpg` | 204969 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_02_shade_102_wet_205_dry_411_normal.jpg` | 191136 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_02_shade_102_wet_205_dry_411_rough.jpg` | 549644 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_02_shade_102_wet_205_normal.jpg` | 191136 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_02_shade_102_wet_205_rough.jpg` | 549644 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_02_shade_102_wet_410_albedo.jpg` | 205094 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/fabric_leather_02_shade_102_wet_410_normal.jpg` | 191136 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/fabric_leather_02_shade_102_wet_410_rough.jpg` | 549644 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/farm_soil_albedo.jpg` | 331131 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/farm_soil_dry_206_albedo.jpg` | 313284 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/farm_soil_dry_206_normal.jpg` | 718032 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/farm_soil_dry_206_rake_413_albedo.jpg` | 314905 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/farm_soil_dry_206_rake_413_normal.jpg` | 718032 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/farm_soil_dry_206_rake_413_rough.jpg` | 77624 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/farm_soil_dry_206_rough.jpg` | 77624 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/farm_soil_normal.jpg` | 718032 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/farm_soil_rake_103_albedo.jpg` | 316337 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/farm_soil_rake_103_late_414_albedo.jpg` | 310806 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/farm_soil_rake_103_late_414_normal.jpg` | 718032 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/farm_soil_rake_103_late_414_rough.jpg` | 77624 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/farm_soil_rake_103_normal.jpg` | 718032 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/farm_soil_rake_103_rough.jpg` | 77624 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/farm_soil_rake_103_shade_207_albedo.jpg` | 256904 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/farm_soil_rake_103_shade_207_normal.jpg` | 718032 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/farm_soil_rake_103_shade_207_rough.jpg` | 77624 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/farm_soil_rake_103_shade_207_wet_415_albedo.jpg` | 235081 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/farm_soil_rake_103_shade_207_wet_415_normal.jpg` | 718032 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/farm_soil_rake_103_shade_207_wet_415_rough.jpg` | 77624 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/farm_soil_rough.jpg` | 77624 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/farm_soil_shade_412_albedo.jpg` | 191244 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/farm_soil_shade_412_normal.jpg` | 718032 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/farm_soil_shade_412_rough.jpg` | 77624 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/flower_scattered_dirt_albedo.jpg` | 466869 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/flower_scattered_dirt_dry_416_albedo.jpg` | 439156 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/flower_scattered_dirt_dry_416_normal.jpg` | 516323 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/flower_scattered_dirt_dry_416_rough.jpg` | 96652 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/flower_scattered_dirt_late_104_albedo.jpg` | 401635 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/flower_scattered_dirt_late_104_late_209_albedo.jpg` | 382668 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/flower_scattered_dirt_late_104_late_209_normal.jpg` | 516323 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/flower_scattered_dirt_late_104_late_209_rake_418_albedo.jpg` | 384493 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/flower_scattered_dirt_late_104_late_209_rake_418_normal.jpg` | 516323 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/flower_scattered_dirt_late_104_late_209_rake_418_rough.jpg` | 96652 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/flower_scattered_dirt_late_104_late_209_rough.jpg` | 96652 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/flower_scattered_dirt_late_104_normal.jpg` | 516323 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/flower_scattered_dirt_late_104_rough.jpg` | 96652 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/flower_scattered_dirt_late_104_shade_417_albedo.jpg` | 327531 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/flower_scattered_dirt_late_104_shade_417_normal.jpg` | 516323 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/flower_scattered_dirt_late_104_shade_417_rough.jpg` | 96652 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/flower_scattered_dirt_normal.jpg` | 516323 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/flower_scattered_dirt_rake_208_albedo.jpg` | 444453 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/flower_scattered_dirt_rake_208_late_419_albedo.jpg` | 417476 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/flower_scattered_dirt_rake_208_late_419_normal.jpg` | 516323 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/flower_scattered_dirt_rake_208_late_419_rough.jpg` | 96652 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/flower_scattered_dirt_rake_208_normal.jpg` | 516323 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/flower_scattered_dirt_rake_208_rough.jpg` | 96652 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/flower_scattered_dirt_rough.jpg` | 96652 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_02_albedo.jpg` | 570141 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_02_normal.jpg` | 666202 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_02_rough.jpg` | 217923 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_02_wet_105_albedo.jpg` | 462753 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_02_wet_105_dry_211_albedo.jpg` | 459392 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_02_wet_105_dry_211_normal.jpg` | 666202 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_02_wet_105_dry_211_rough.jpg` | 217923 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_02_wet_105_dry_211_shade_422_albedo.jpg` | 374810 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_02_wet_105_dry_211_shade_422_normal.jpg` | 666202 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_02_wet_105_dry_211_shade_422_rough.jpg` | 217923 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_02_wet_105_dry_421_albedo.jpg` | 459392 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_02_wet_105_dry_421_normal.jpg` | 666202 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_02_wet_105_dry_421_rough.jpg` | 217923 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_02_wet_105_normal.jpg` | 666202 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_02_wet_105_rough.jpg` | 217923 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_02_wet_210_albedo.jpg` | 462753 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_02_wet_210_normal.jpg` | 666202 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_02_wet_210_rake_423_albedo.jpg` | 461919 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_02_wet_210_rake_423_normal.jpg` | 666202 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_02_wet_210_rake_423_rough.jpg` | 217923 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_02_wet_210_rough.jpg` | 217923 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_02_wet_420_albedo.jpg` | 462753 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_02_wet_420_normal.jpg` | 666202 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_02_wet_420_rough.jpg` | 217923 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_albedo.jpg` | 683683 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_dry_106_albedo.jpg` | 619567 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_dry_106_normal.jpg` | 614111 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_dry_106_rake_213_albedo.jpg` | 619347 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_dry_106_rake_213_dry_426_albedo.jpg` | 610331 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_dry_106_rake_213_dry_426_normal.jpg` | 614111 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_dry_106_rake_213_dry_426_rough.jpg` | 368606 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_dry_106_rake_213_normal.jpg` | 614111 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_dry_106_rake_213_rough.jpg` | 368606 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_dry_106_rough.jpg` | 368606 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_dry_106_wet_425_albedo.jpg` | 547038 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_dry_106_wet_425_normal.jpg` | 614111 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_dry_106_wet_425_rough.jpg` | 368606 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_late_424_albedo.jpg` | 576826 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_late_424_normal.jpg` | 614111 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_late_424_rough.jpg` | 368606 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_normal.jpg` | 614111 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_rough.jpg` | 368606 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_shade_212_albedo.jpg` | 461279 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_shade_212_normal.jpg` | 614111 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_shade_212_rough.jpg` | 368606 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_shade_212_shade_427_albedo.jpg` | 382022 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_floor_shade_212_shade_427_normal.jpg` | 614111 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_floor_shade_212_shade_427_rough.jpg` | 368606 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_04_albedo.jpg` | 588529 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_04_late_214_albedo.jpg` | 501563 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_04_late_214_late_429_albedo.jpg` | 493263 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_04_late_214_late_429_normal.jpg` | 585742 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_04_late_214_late_429_rough.jpg` | 282554 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_04_late_214_normal.jpg` | 585742 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_04_late_214_rough.jpg` | 282554 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_04_normal.jpg` | 585742 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_04_rake_428_albedo.jpg` | 555781 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_04_rake_428_normal.jpg` | 585742 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_04_rake_428_rough.jpg` | 282554 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_04_rough.jpg` | 282554 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_04_shade_107_albedo.jpg` | 371790 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_04_shade_107_normal.jpg` | 585742 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_04_shade_107_rough.jpg` | 282554 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_04_shade_107_wet_215_albedo.jpg` | 337862 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_04_shade_107_wet_215_dry_431_albedo.jpg` | 337119 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_04_shade_107_wet_215_dry_431_normal.jpg` | 585742 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_04_shade_107_wet_215_dry_431_rough.jpg` | 282554 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_04_shade_107_wet_215_normal.jpg` | 585742 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_04_shade_107_wet_215_rough.jpg` | 282554 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_04_shade_107_wet_430_albedo.jpg` | 337862 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_04_shade_107_wet_430_normal.jpg` | 585742 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_04_shade_107_wet_430_rough.jpg` | 282554 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_05_albedo.jpg` | 292062 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_05_dry_216_albedo.jpg` | 278379 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_05_dry_216_normal.jpg` | 482462 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_05_dry_216_rake_433_albedo.jpg` | 278927 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_05_dry_216_rake_433_normal.jpg` | 482462 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_05_dry_216_rake_433_rough.jpg` | 85543 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_05_dry_216_rough.jpg` | 85543 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_05_normal.jpg` | 482462 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_05_rake_108_albedo.jpg` | 282157 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_05_rake_108_late_434_albedo.jpg` | 268796 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_05_rake_108_late_434_normal.jpg` | 482462 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_05_rake_108_late_434_rough.jpg` | 85543 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_05_rake_108_normal.jpg` | 482462 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_05_rake_108_rough.jpg` | 85543 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_05_rake_108_shade_217_albedo.jpg` | 223869 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_05_rake_108_shade_217_normal.jpg` | 482462 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_05_rake_108_shade_217_rough.jpg` | 85543 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_05_rake_108_shade_217_wet_435_albedo.jpg` | 204524 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_05_rake_108_shade_217_wet_435_normal.jpg` | 482462 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_05_rake_108_shade_217_wet_435_rough.jpg` | 85543 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_05_rough.jpg` | 85543 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_05_shade_432_albedo.jpg` | 161604 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_ground_05_shade_432_normal.jpg` | 482462 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_ground_05_shade_432_rough.jpg` | 85543 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_02_albedo.jpg` | 498160 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_02_dry_436_albedo.jpg` | 484128 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_02_dry_436_normal.jpg` | 641502 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_02_dry_436_rough.jpg` | 223434 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_02_late_109_albedo.jpg` | 462218 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_02_late_109_late_219_albedo.jpg` | 444962 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_02_late_109_late_219_normal.jpg` | 641502 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_02_late_109_late_219_rake_438_albedo.jpg` | 447436 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_02_late_109_late_219_rake_438_normal.jpg` | 641502 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_02_late_109_late_219_rake_438_rough.jpg` | 223434 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_02_late_109_late_219_rough.jpg` | 223434 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_02_late_109_normal.jpg` | 641502 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_02_late_109_rough.jpg` | 223434 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_02_late_109_shade_437_albedo.jpg` | 389964 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_02_late_109_shade_437_normal.jpg` | 641502 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_02_late_109_shade_437_rough.jpg` | 223434 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_02_normal.jpg` | 641502 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_02_rake_218_albedo.jpg` | 483125 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_02_rake_218_late_439_albedo.jpg` | 477786 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_02_rake_218_late_439_normal.jpg` | 641502 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_02_rake_218_late_439_rough.jpg` | 223434 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_02_rake_218_normal.jpg` | 641502 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_02_rake_218_rough.jpg` | 223434 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_02_rough.jpg` | 223434 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_03_albedo.jpg` | 495739 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_03_normal.jpg` | 640568 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_03_rough.jpg` | 414381 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_03_wet_110_albedo.jpg` | 418901 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_03_wet_110_dry_221_albedo.jpg` | 415912 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_03_wet_110_dry_221_normal.jpg` | 640568 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_03_wet_110_dry_221_rough.jpg` | 414381 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_03_wet_110_dry_221_shade_442_albedo.jpg` | 351888 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_03_wet_110_dry_221_shade_442_normal.jpg` | 640568 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_03_wet_110_dry_221_shade_442_rough.jpg` | 414381 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_03_wet_110_dry_441_albedo.jpg` | 415912 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_03_wet_110_dry_441_normal.jpg` | 640568 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_03_wet_110_dry_441_rough.jpg` | 414381 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_03_wet_110_normal.jpg` | 640568 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_03_wet_110_rough.jpg` | 414381 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_03_wet_220_albedo.jpg` | 418901 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_03_wet_220_normal.jpg` | 640568 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_03_wet_220_rake_443_albedo.jpg` | 418141 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_03_wet_220_rake_443_normal.jpg` | 640568 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_03_wet_220_rake_443_rough.jpg` | 414381 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_03_wet_220_rough.jpg` | 414381 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_03_wet_440_albedo.jpg` | 418901 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_03_wet_440_normal.jpg` | 640568 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_03_wet_440_rough.jpg` | 414381 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_04_albedo.jpg` | 481343 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_04_dry_111_albedo.jpg` | 467682 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_04_dry_111_normal.jpg` | 643180 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_04_dry_111_rake_223_albedo.jpg` | 470666 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_04_dry_111_rake_223_dry_446_albedo.jpg` | 471519 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_04_dry_111_rake_223_dry_446_normal.jpg` | 643180 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_04_dry_111_rake_223_dry_446_rough.jpg` | 383209 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_04_dry_111_rake_223_normal.jpg` | 643180 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_04_dry_111_rake_223_rough.jpg` | 383209 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_04_dry_111_rough.jpg` | 383209 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_04_dry_111_wet_445_albedo.jpg` | 435547 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_04_dry_111_wet_445_normal.jpg` | 643180 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_04_dry_111_wet_445_rough.jpg` | 383209 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_04_late_444_albedo.jpg` | 449325 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_04_late_444_normal.jpg` | 643180 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_04_late_444_rough.jpg` | 383209 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_04_normal.jpg` | 643180 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_04_rough.jpg` | 383209 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_04_shade_222_albedo.jpg` | 396347 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_04_shade_222_normal.jpg` | 643180 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_04_shade_222_rough.jpg` | 383209 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_04_shade_222_shade_447_albedo.jpg` | 328488 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/forest_leaves_04_shade_222_shade_447_normal.jpg` | 643180 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/forest_leaves_04_shade_222_shade_447_rough.jpg` | 383209 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_2_albedo.jpg` | 540106 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_2_late_224_albedo.jpg` | 479413 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_2_late_224_late_449_albedo.jpg` | 452707 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_2_late_224_late_449_normal.jpg` | 430110 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_2_late_224_late_449_rough.jpg` | 284285 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_2_late_224_normal.jpg` | 430110 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_2_late_224_rough.jpg` | 284285 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_2_normal.jpg` | 430110 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_2_rake_448_albedo.jpg` | 517873 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_2_rake_448_normal.jpg` | 430110 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_2_rake_448_rough.jpg` | 284285 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_2_rough.jpg` | 284285 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_2_shade_112_albedo.jpg` | 339133 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_2_shade_112_normal.jpg` | 430110 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_2_shade_112_rough.jpg` | 284285 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_2_shade_112_wet_225_albedo.jpg` | 310783 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_2_shade_112_wet_225_dry_451_albedo.jpg` | 311815 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_2_shade_112_wet_225_dry_451_normal.jpg` | 430110 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_2_shade_112_wet_225_dry_451_rough.jpg` | 284285 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_2_shade_112_wet_225_normal.jpg` | 430110 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_2_shade_112_wet_225_rough.jpg` | 284285 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_2_shade_112_wet_450_albedo.jpg` | 310783 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_2_shade_112_wet_450_normal.jpg` | 430110 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_2_shade_112_wet_450_rough.jpg` | 284285 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_3_albedo.jpg` | 490044 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_3_dry_226_albedo.jpg` | 465406 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_3_dry_226_normal.jpg` | 415410 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_3_dry_226_rake_453_albedo.jpg` | 469182 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_3_dry_226_rake_453_normal.jpg` | 415410 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_3_dry_226_rake_453_rough.jpg` | 510072 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_3_dry_226_rough.jpg` | 510072 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_3_normal.jpg` | 415410 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_3_rake_113_albedo.jpg` | 471098 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_3_rake_113_late_454_albedo.jpg` | 463224 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_3_rake_113_late_454_normal.jpg` | 415410 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_3_rake_113_late_454_rough.jpg` | 510072 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_3_rake_113_normal.jpg` | 415410 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_3_rake_113_rough.jpg` | 510072 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_3_rake_113_shade_227_albedo.jpg` | 392938 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_3_rake_113_shade_227_normal.jpg` | 415410 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_3_rake_113_shade_227_rough.jpg` | 510072 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_3_rake_113_shade_227_wet_455_albedo.jpg` | 358130 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_3_rake_113_shade_227_wet_455_normal.jpg` | 415410 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_3_rake_113_shade_227_wet_455_rough.jpg` | 510072 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_3_rough.jpg` | 510072 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_3_shade_452_albedo.jpg` | 299843 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/grass_path_3_shade_452_normal.jpg` | 415410 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/grass_path_3_shade_452_rough.jpg` | 510072 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_albedo.jpg` | 437808 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_dry_456_albedo.jpg` | 416494 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_dry_456_normal.jpg` | 708993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_dry_456_rough.jpg` | 147035 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_floor_albedo.jpg` | 693528 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_floor_late_229_albedo.jpg` | 578763 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_floor_late_229_normal.jpg` | 701139 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_floor_late_229_rake_458_albedo.jpg` | 581198 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_floor_late_229_rake_458_normal.jpg` | 701139 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_floor_late_229_rake_458_rough.jpg` | 334216 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_floor_late_229_rough.jpg` | 334216 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_floor_normal.jpg` | 701139 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_floor_rough.jpg` | 334216 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_floor_shade_457_albedo.jpg` | 450033 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_floor_shade_457_normal.jpg` | 701139 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_floor_shade_457_rough.jpg` | 334216 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_floor_wet_115_albedo.jpg` | 571630 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_floor_wet_115_late_459_albedo.jpg` | 552182 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_floor_wet_115_late_459_normal.jpg` | 701139 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_floor_wet_115_late_459_rough.jpg` | 334216 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_floor_wet_115_normal.jpg` | 701139 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_floor_wet_115_rough.jpg` | 334216 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_floor_wet_115_wet_230_albedo.jpg` | 507693 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_floor_wet_115_wet_230_normal.jpg` | 701139 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_floor_wet_115_wet_230_rough.jpg` | 334216 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_floor_wet_115_wet_230_wet_460_albedo.jpg` | 460586 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_floor_wet_115_wet_230_wet_460_normal.jpg` | 701139 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_floor_wet_115_wet_230_wet_460_rough.jpg` | 334216 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_late_114_albedo.jpg` | 392703 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_late_114_dry_231_albedo.jpg` | 393374 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_late_114_dry_231_normal.jpg` | 708993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_late_114_dry_231_rough.jpg` | 147035 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_late_114_dry_231_shade_462_albedo.jpg` | 328260 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_late_114_dry_231_shade_462_normal.jpg` | 708993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_late_114_dry_231_shade_462_rough.jpg` | 147035 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_late_114_dry_461_albedo.jpg` | 393374 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_late_114_dry_461_normal.jpg` | 708993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_late_114_dry_461_rough.jpg` | 147035 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_late_114_normal.jpg` | 708993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_late_114_rough.jpg` | 147035 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_normal.jpg` | 708993 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_rake_228_albedo.jpg` | 421395 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_rake_228_normal.jpg` | 708993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_rake_228_rake_463_albedo.jpg` | 423017 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_rake_228_rake_463_normal.jpg` | 708993 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_rake_228_rake_463_rough.jpg` | 147035 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_rake_228_rough.jpg` | 147035 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_road_albedo.jpg` | 294418 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_road_dry_116_albedo.jpg` | 280818 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_road_dry_116_normal.jpg` | 370653 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_road_dry_116_rake_233_albedo.jpg` | 281371 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_road_dry_116_rake_233_dry_466_albedo.jpg` | 280674 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_road_dry_116_rake_233_dry_466_normal.jpg` | 370653 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_road_dry_116_rake_233_dry_466_rough.jpg` | 129461 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_road_dry_116_rake_233_normal.jpg` | 370653 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_road_dry_116_rake_233_rough.jpg` | 129461 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_road_dry_116_rough.jpg` | 129461 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_road_dry_116_wet_465_albedo.jpg` | 255699 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_road_dry_116_wet_465_normal.jpg` | 370653 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_road_dry_116_wet_465_rough.jpg` | 129461 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_road_late_464_albedo.jpg` | 259466 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_road_late_464_normal.jpg` | 370653 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_road_late_464_rough.jpg` | 129461 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_road_normal.jpg` | 370653 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_road_rough.jpg` | 129461 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_road_shade_232_albedo.jpg` | 162881 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_road_shade_232_normal.jpg` | 370653 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_road_shade_232_rough.jpg` | 129461 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_road_shade_232_shade_467_albedo.jpg` | 118420 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravel_road_shade_232_shade_467_normal.jpg` | 370653 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_road_shade_232_shade_467_rough.jpg` | 129461 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravel_rough.jpg` | 147035 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravelly_sand_albedo.jpg` | 542875 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravelly_sand_late_234_albedo.jpg` | 464445 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravelly_sand_late_234_late_469_albedo.jpg` | 447590 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravelly_sand_late_234_late_469_normal.jpg` | 613620 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravelly_sand_late_234_late_469_rough.jpg` | 125430 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravelly_sand_late_234_normal.jpg` | 613620 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravelly_sand_late_234_rough.jpg` | 125430 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravelly_sand_normal.jpg` | 613620 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravelly_sand_rake_468_albedo.jpg` | 515209 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravelly_sand_rake_468_normal.jpg` | 613620 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravelly_sand_rake_468_rough.jpg` | 125430 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravelly_sand_rough.jpg` | 125430 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravelly_sand_shade_117_albedo.jpg` | 324270 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravelly_sand_shade_117_normal.jpg` | 613620 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravelly_sand_shade_117_rough.jpg` | 125430 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravelly_sand_shade_117_wet_235_albedo.jpg` | 296981 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravelly_sand_shade_117_wet_235_dry_471_albedo.jpg` | 296878 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravelly_sand_shade_117_wet_235_dry_471_normal.jpg` | 613620 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravelly_sand_shade_117_wet_235_dry_471_rough.jpg` | 125430 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravelly_sand_shade_117_wet_235_normal.jpg` | 613620 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravelly_sand_shade_117_wet_235_rough.jpg` | 125430 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravelly_sand_shade_117_wet_470_albedo.jpg` | 296981 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/gravelly_sand_shade_117_wet_470_normal.jpg` | 613620 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/gravelly_sand_shade_117_wet_470_rough.jpg` | 125430 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/ground_grey_albedo.jpg` | 492168 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/ground_grey_dry_236_albedo.jpg` | 480799 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/ground_grey_dry_236_normal.jpg` | 470063 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/ground_grey_dry_236_rake_473_albedo.jpg` | 484779 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/ground_grey_dry_236_rake_473_normal.jpg` | 470063 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/ground_grey_dry_236_rake_473_rough.jpg` | 447374 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/ground_grey_dry_236_rough.jpg` | 447374 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/ground_grey_normal.jpg` | 470063 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/ground_grey_rake_118_albedo.jpg` | 480154 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/ground_grey_rake_118_late_474_albedo.jpg` | 468389 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/ground_grey_rake_118_late_474_normal.jpg` | 470063 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/ground_grey_rake_118_late_474_rough.jpg` | 447374 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/ground_grey_rake_118_normal.jpg` | 470063 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/ground_grey_rake_118_rough.jpg` | 447374 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/ground_grey_rake_118_shade_237_albedo.jpg` | 409407 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/ground_grey_rake_118_shade_237_normal.jpg` | 470063 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/ground_grey_rake_118_shade_237_rough.jpg` | 447374 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/ground_grey_rake_118_shade_237_wet_475_albedo.jpg` | 366052 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/ground_grey_rake_118_shade_237_wet_475_normal.jpg` | 470063 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/ground_grey_rake_118_shade_237_wet_475_rough.jpg` | 447374 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/ground_grey_rough.jpg` | 447374 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/ground_grey_shade_472_albedo.jpg` | 385999 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/ground_grey_shade_472_normal.jpg` | 470063 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/ground_grey_shade_472_rough.jpg` | 447374 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/jolcham_oak_bark_albedo.jpg` | 433188 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/jolcham_oak_bark_dry_476_albedo.jpg` | 418887 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/jolcham_oak_bark_dry_476_normal.jpg` | 610699 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/jolcham_oak_bark_dry_476_rough.jpg` | 127301 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/jolcham_oak_bark_late_119_albedo.jpg` | 402838 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/jolcham_oak_bark_late_119_late_239_albedo.jpg` | 394134 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/jolcham_oak_bark_late_119_late_239_normal.jpg` | 610699 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/jolcham_oak_bark_late_119_late_239_rake_478_albedo.jpg` | 396599 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/jolcham_oak_bark_late_119_late_239_rake_478_normal.jpg` | 610699 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/jolcham_oak_bark_late_119_late_239_rake_478_rough.jpg` | 127301 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/jolcham_oak_bark_late_119_late_239_rough.jpg` | 127301 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/jolcham_oak_bark_late_119_normal.jpg` | 610699 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/jolcham_oak_bark_late_119_rough.jpg` | 127301 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/jolcham_oak_bark_late_119_shade_477_albedo.jpg` | 337399 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/jolcham_oak_bark_late_119_shade_477_normal.jpg` | 610699 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/jolcham_oak_bark_late_119_shade_477_rough.jpg` | 127301 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/jolcham_oak_bark_normal.jpg` | 610699 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/jolcham_oak_bark_rake_238_albedo.jpg` | 422828 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/jolcham_oak_bark_rake_238_late_479_albedo.jpg` | 418961 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/jolcham_oak_bark_rake_238_late_479_normal.jpg` | 610699 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/jolcham_oak_bark_rake_238_late_479_rough.jpg` | 127301 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/jolcham_oak_bark_rake_238_normal.jpg` | 610699 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/jolcham_oak_bark_rake_238_rough.jpg` | 127301 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/jolcham_oak_bark_rough.jpg` | 127301 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/knotted_pine_bark_albedo.jpg` | 332756 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/knotted_pine_bark_normal.jpg` | 618268 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/knotted_pine_bark_rough.jpg` | 206476 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/knotted_pine_bark_wet_120_albedo.jpg` | 289329 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/knotted_pine_bark_wet_120_dry_241_albedo.jpg` | 289993 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/knotted_pine_bark_wet_120_dry_241_normal.jpg` | 618268 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/knotted_pine_bark_wet_120_dry_241_rough.jpg` | 206476 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/knotted_pine_bark_wet_120_dry_241_shade_482_albedo.jpg` | 235452 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/knotted_pine_bark_wet_120_dry_241_shade_482_normal.jpg` | 618268 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/knotted_pine_bark_wet_120_dry_241_shade_482_rough.jpg` | 206476 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/knotted_pine_bark_wet_120_dry_481_albedo.jpg` | 289993 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/knotted_pine_bark_wet_120_dry_481_normal.jpg` | 618268 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/knotted_pine_bark_wet_120_dry_481_rough.jpg` | 206476 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/knotted_pine_bark_wet_120_normal.jpg` | 618268 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/knotted_pine_bark_wet_120_rough.jpg` | 206476 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/knotted_pine_bark_wet_240_albedo.jpg` | 289329 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/knotted_pine_bark_wet_240_normal.jpg` | 618268 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/knotted_pine_bark_wet_240_rake_483_albedo.jpg` | 291430 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/knotted_pine_bark_wet_240_rake_483_normal.jpg` | 618268 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/knotted_pine_bark_wet_240_rake_483_rough.jpg` | 206476 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/knotted_pine_bark_wet_240_rough.jpg` | 206476 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/knotted_pine_bark_wet_480_albedo.jpg` | 289329 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/knotted_pine_bark_wet_480_normal.jpg` | 618268 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/knotted_pine_bark_wet_480_rough.jpg` | 206476 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leafy_grass_albedo.jpg` | 592591 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leafy_grass_dry_121_albedo.jpg` | 551583 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leafy_grass_dry_121_normal.jpg` | 664340 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leafy_grass_dry_121_rake_243_albedo.jpg` | 552382 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leafy_grass_dry_121_rake_243_dry_486_albedo.jpg` | 544682 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leafy_grass_dry_121_rake_243_dry_486_normal.jpg` | 664340 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leafy_grass_dry_121_rake_243_dry_486_rough.jpg` | 185690 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leafy_grass_dry_121_rake_243_normal.jpg` | 664340 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leafy_grass_dry_121_rake_243_rough.jpg` | 185690 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leafy_grass_dry_121_rough.jpg` | 185690 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leafy_grass_dry_121_wet_485_albedo.jpg` | 490068 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leafy_grass_dry_121_wet_485_normal.jpg` | 664340 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leafy_grass_dry_121_wet_485_rough.jpg` | 185690 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leafy_grass_late_484_albedo.jpg` | 507720 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leafy_grass_late_484_normal.jpg` | 664340 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leafy_grass_late_484_rough.jpg` | 185690 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leafy_grass_normal.jpg` | 664340 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leafy_grass_rough.jpg` | 185690 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leafy_grass_shade_242_albedo.jpg` | 360671 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leafy_grass_shade_242_normal.jpg` | 664340 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leafy_grass_shade_242_rough.jpg` | 185690 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leafy_grass_shade_242_shade_487_albedo.jpg` | 291603 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leafy_grass_shade_242_shade_487_normal.jpg` | 664340 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leafy_grass_shade_242_shade_487_rough.jpg` | 185690 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_red_02_albedo.jpg` | 464915 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_red_02_late_244_albedo.jpg` | 421112 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_red_02_late_244_late_489_albedo.jpg` | 407041 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_red_02_late_244_late_489_normal.jpg` | 401830 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_red_02_late_244_late_489_rough.jpg` | 466802 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_red_02_late_244_normal.jpg` | 401830 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_red_02_late_244_rough.jpg` | 466802 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_red_02_normal.jpg` | 401830 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_red_02_rake_488_albedo.jpg` | 454155 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_red_02_rake_488_normal.jpg` | 401830 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_red_02_rake_488_rough.jpg` | 466802 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_red_02_rough.jpg` | 466802 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_red_02_shade_122_albedo.jpg` | 271692 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_red_02_shade_122_normal.jpg` | 401830 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_red_02_shade_122_rough.jpg` | 466802 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_red_02_shade_122_wet_245_albedo.jpg` | 248236 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_red_02_shade_122_wet_245_dry_491_albedo.jpg` | 247978 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_red_02_shade_122_wet_245_dry_491_normal.jpg` | 401830 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_red_02_shade_122_wet_245_dry_491_rough.jpg` | 466802 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_red_02_shade_122_wet_245_normal.jpg` | 401830 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_red_02_shade_122_wet_245_rough.jpg` | 466802 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_red_02_shade_122_wet_490_albedo.jpg` | 248236 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_red_02_shade_122_wet_490_normal.jpg` | 401830 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_red_02_shade_122_wet_490_rough.jpg` | 466802 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_white_albedo.jpg` | 316220 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_white_dry_246_albedo.jpg` | 305682 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_white_dry_246_normal.jpg` | 174952 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_white_dry_246_rake_493_albedo.jpg` | 306262 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_white_dry_246_rake_493_normal.jpg` | 174952 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_white_dry_246_rake_493_rough.jpg` | 320729 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_white_dry_246_rough.jpg` | 320729 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_white_normal.jpg` | 174952 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_white_rake_123_albedo.jpg` | 307872 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_white_rake_123_late_494_albedo.jpg` | 297912 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_white_rake_123_late_494_normal.jpg` | 174952 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_white_rake_123_late_494_rough.jpg` | 320729 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_white_rake_123_normal.jpg` | 174952 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_white_rake_123_rough.jpg` | 320729 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_white_rake_123_shade_247_albedo.jpg` | 247822 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_white_rake_123_shade_247_normal.jpg` | 174952 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_white_rake_123_shade_247_rough.jpg` | 320729 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_white_rake_123_shade_247_wet_495_albedo.jpg` | 230867 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_white_rake_123_shade_247_wet_495_normal.jpg` | 174952 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_white_rake_123_shade_247_wet_495_rough.jpg` | 320729 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_white_rough.jpg` | 320729 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_white_shade_492_albedo.jpg` | 160789 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leather_white_shade_492_normal.jpg` | 174952 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leather_white_shade_492_rough.jpg` | 320729 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leaves_forest_ground_albedo.jpg` | 521616 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leaves_forest_ground_dry_496_albedo.jpg` | 503005 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leaves_forest_ground_dry_496_normal.jpg` | 636040 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leaves_forest_ground_dry_496_rough.jpg` | 196124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leaves_forest_ground_late_124_albedo.jpg` | 478823 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leaves_forest_ground_late_124_late_249_albedo.jpg` | 467426 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leaves_forest_ground_late_124_late_249_normal.jpg` | 636040 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leaves_forest_ground_late_124_late_249_rake_498_albedo.jpg` | 470761 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leaves_forest_ground_late_124_late_249_rake_498_normal.jpg` | 636040 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leaves_forest_ground_late_124_late_249_rake_498_rough.jpg` | 196124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leaves_forest_ground_late_124_late_249_rough.jpg` | 196124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leaves_forest_ground_late_124_normal.jpg` | 636040 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leaves_forest_ground_late_124_rough.jpg` | 196124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leaves_forest_ground_late_124_shade_497_albedo.jpg` | 401303 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leaves_forest_ground_late_124_shade_497_normal.jpg` | 636040 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leaves_forest_ground_late_124_shade_497_rough.jpg` | 196124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leaves_forest_ground_normal.jpg` | 636040 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leaves_forest_ground_rake_248_albedo.jpg` | 507898 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leaves_forest_ground_rake_248_late_499_albedo.jpg` | 498856 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/leaves_forest_ground_rake_248_late_499_normal.jpg` | 636040 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leaves_forest_ground_rake_248_late_499_rough.jpg` | 196124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leaves_forest_ground_rake_248_normal.jpg` | 636040 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leaves_forest_ground_rake_248_rough.jpg` | 196124 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/leaves_forest_ground_rough.jpg` | 196124 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_02_albedo.jpg` | 236289 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_02_normal.jpg` | 57947 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_02_rough.jpg` | 488201 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_02_wet_125_albedo.jpg` | 202383 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_02_wet_125_dry_251_albedo.jpg` | 204238 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_02_wet_125_dry_251_normal.jpg` | 57947 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_02_wet_125_dry_251_rough.jpg` | 488201 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_02_wet_125_dry_251_shade_502_albedo.jpg` | 165772 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_02_wet_125_dry_251_shade_502_normal.jpg` | 57947 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_02_wet_125_dry_251_shade_502_rough.jpg` | 488201 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_02_wet_125_dry_501_albedo.jpg` | 204238 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_02_wet_125_dry_501_normal.jpg` | 57947 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_02_wet_125_dry_501_rough.jpg` | 488201 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_02_wet_125_normal.jpg` | 57947 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_02_wet_125_rough.jpg` | 488201 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_02_wet_250_albedo.jpg` | 202383 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_02_wet_250_normal.jpg` | 57947 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_02_wet_250_rake_503_albedo.jpg` | 204580 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_02_wet_250_rake_503_normal.jpg` | 57947 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_02_wet_250_rake_503_rough.jpg` | 488201 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_02_wet_250_rough.jpg` | 488201 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_02_wet_500_albedo.jpg` | 202383 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_02_wet_500_normal.jpg` | 57947 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_02_wet_500_rough.jpg` | 488201 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_03_albedo.jpg` | 348688 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_03_dry_126_albedo.jpg` | 330953 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_03_dry_126_normal.jpg` | 202278 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_03_dry_126_rake_253_albedo.jpg` | 329697 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_03_dry_126_rake_253_dry_506_albedo.jpg` | 327268 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_03_dry_126_rake_253_dry_506_normal.jpg` | 202278 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_03_dry_126_rake_253_dry_506_rough.jpg` | 111778 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_03_dry_126_rake_253_normal.jpg` | 202278 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_03_dry_126_rake_253_rough.jpg` | 111778 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_03_dry_126_rough.jpg` | 111778 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_03_dry_126_wet_505_albedo.jpg` | 298758 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_03_dry_126_wet_505_normal.jpg` | 202278 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_03_dry_126_wet_505_rough.jpg` | 111778 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_03_late_504_albedo.jpg` | 299941 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_03_late_504_normal.jpg` | 202278 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_03_late_504_rough.jpg` | 111778 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_03_normal.jpg` | 202278 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_03_rough.jpg` | 111778 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_03_shade_252_albedo.jpg` | 201969 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_03_shade_252_normal.jpg` | 202278 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_03_shade_252_rough.jpg` | 111778 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_03_shade_252_shade_507_albedo.jpg` | 155714 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_03_shade_252_shade_507_normal.jpg` | 202278 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_03_shade_252_shade_507_rough.jpg` | 111778 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_albedo.jpg` | 253384 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_late_254_albedo.jpg` | 231354 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_late_254_late_509_albedo.jpg` | 224758 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_late_254_late_509_normal.jpg` | 263060 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_late_254_late_509_rough.jpg` | 399457 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_late_254_normal.jpg` | 263060 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_late_254_rough.jpg` | 399457 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_normal.jpg` | 263060 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_rake_508_albedo.jpg` | 247162 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_rake_508_normal.jpg` | 263060 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_rake_508_rough.jpg` | 399457 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_rough.jpg` | 399457 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_shade_127_albedo.jpg` | 157455 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_shade_127_normal.jpg` | 263060 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_shade_127_rough.jpg` | 399457 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_shade_127_wet_255_albedo.jpg` | 144601 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_shade_127_wet_255_dry_511_albedo.jpg` | 145122 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_shade_127_wet_255_dry_511_normal.jpg` | 263060 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_shade_127_wet_255_dry_511_rough.jpg` | 399457 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_shade_127_wet_255_normal.jpg` | 263060 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_shade_127_wet_255_rough.jpg` | 399457 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_shade_127_wet_510_albedo.jpg` | 144601 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/metal_plate_shade_127_wet_510_normal.jpg` | 263060 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/metal_plate_shade_127_wet_510_rough.jpg` | 399457 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/muddy_tracks_albedo.jpg` | 271699 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/muddy_tracks_dry_256_albedo.jpg` | 264538 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/muddy_tracks_dry_256_normal.jpg` | 584288 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/muddy_tracks_dry_256_rake_513_albedo.jpg` | 266675 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/muddy_tracks_dry_256_rake_513_normal.jpg` | 584288 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/muddy_tracks_dry_256_rake_513_rough.jpg` | 373374 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/muddy_tracks_dry_256_rough.jpg` | 373374 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/muddy_tracks_normal.jpg` | 584288 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/muddy_tracks_rake_128_albedo.jpg` | 265985 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/muddy_tracks_rake_128_late_514_albedo.jpg` | 258883 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/muddy_tracks_rake_128_late_514_normal.jpg` | 584288 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/muddy_tracks_rake_128_late_514_rough.jpg` | 373374 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/muddy_tracks_rake_128_normal.jpg` | 584288 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/muddy_tracks_rake_128_rough.jpg` | 373374 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/muddy_tracks_rake_128_shade_257_albedo.jpg` | 213067 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/muddy_tracks_rake_128_shade_257_normal.jpg` | 584288 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/muddy_tracks_rake_128_shade_257_rough.jpg` | 373374 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/muddy_tracks_rake_128_shade_257_wet_515_albedo.jpg` | 196643 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/muddy_tracks_rake_128_shade_257_wet_515_normal.jpg` | 584288 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/muddy_tracks_rake_128_shade_257_wet_515_rough.jpg` | 373374 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/muddy_tracks_rough.jpg` | 373374 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/muddy_tracks_shade_512_albedo.jpg` | 152323 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/muddy_tracks_shade_512_normal.jpg` | 584288 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/muddy_tracks_shade_512_rough.jpg` | 373374 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/oak_wood_planks_albedo.jpg` | 254488 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/oak_wood_planks_dry_516_albedo.jpg` | 244612 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/oak_wood_planks_dry_516_normal.jpg` | 71627 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/oak_wood_planks_dry_516_rough.jpg` | 447286 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/oak_wood_planks_late_129_albedo.jpg` | 233524 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/oak_wood_planks_late_129_late_259_albedo.jpg` | 225575 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/oak_wood_planks_late_129_late_259_normal.jpg` | 71627 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/oak_wood_planks_late_129_late_259_rake_518_albedo.jpg` | 227601 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/oak_wood_planks_late_129_late_259_rake_518_normal.jpg` | 71627 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/oak_wood_planks_late_129_late_259_rake_518_rough.jpg` | 447286 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/oak_wood_planks_late_129_late_259_rough.jpg` | 447286 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/oak_wood_planks_late_129_normal.jpg` | 71627 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/oak_wood_planks_late_129_rough.jpg` | 447286 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/oak_wood_planks_late_129_shade_517_albedo.jpg` | 188015 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/oak_wood_planks_late_129_shade_517_normal.jpg` | 71627 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/oak_wood_planks_late_129_shade_517_rough.jpg` | 447286 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/oak_wood_planks_normal.jpg` | 71627 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/oak_wood_planks_rake_258_albedo.jpg` | 247757 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/oak_wood_planks_rake_258_late_519_albedo.jpg` | 240123 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/oak_wood_planks_rake_258_late_519_normal.jpg` | 71627 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/oak_wood_planks_rake_258_late_519_rough.jpg` | 447286 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/oak_wood_planks_rake_258_normal.jpg` | 71627 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/oak_wood_planks_rake_258_rough.jpg` | 447286 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/oak_wood_planks_rough.jpg` | 447286 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_dirt_albedo.jpg` | 588751 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_dirt_normal.jpg` | 465677 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_dirt_rough.jpg` | 389703 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_dirt_wet_130_albedo.jpg` | 482202 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_dirt_wet_130_dry_261_albedo.jpg` | 479588 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_dirt_wet_130_dry_261_normal.jpg` | 465677 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_dirt_wet_130_dry_261_rough.jpg` | 389703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_dirt_wet_130_dry_261_shade_522_albedo.jpg` | 386219 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_dirt_wet_130_dry_261_shade_522_normal.jpg` | 465677 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_dirt_wet_130_dry_261_shade_522_rough.jpg` | 389703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_dirt_wet_130_dry_521_albedo.jpg` | 479588 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_dirt_wet_130_dry_521_normal.jpg` | 465677 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_dirt_wet_130_dry_521_rough.jpg` | 389703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_dirt_wet_130_normal.jpg` | 465677 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_dirt_wet_130_rough.jpg` | 389703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_dirt_wet_260_albedo.jpg` | 482202 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_dirt_wet_260_normal.jpg` | 465677 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_dirt_wet_260_rake_523_albedo.jpg` | 481801 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_dirt_wet_260_rake_523_normal.jpg` | 465677 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_dirt_wet_260_rake_523_rough.jpg` | 389703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_dirt_wet_260_rough.jpg` | 389703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_dirt_wet_520_albedo.jpg` | 482202 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_dirt_wet_520_normal.jpg` | 465677 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_dirt_wet_520_rough.jpg` | 389703 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_sand_albedo.jpg` | 330990 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_sand_dry_131_albedo.jpg` | 320001 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_sand_dry_131_normal.jpg` | 448130 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_sand_dry_131_rake_263_albedo.jpg` | 321812 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_sand_dry_131_rake_263_dry_526_albedo.jpg` | 322528 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_sand_dry_131_rake_263_dry_526_normal.jpg` | 448130 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_sand_dry_131_rake_263_dry_526_rough.jpg` | 160799 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_sand_dry_131_rake_263_normal.jpg` | 448130 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_sand_dry_131_rake_263_rough.jpg` | 160799 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_sand_dry_131_rough.jpg` | 160799 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_sand_dry_131_wet_525_albedo.jpg` | 294344 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_sand_dry_131_wet_525_normal.jpg` | 448130 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_sand_dry_131_wet_525_rough.jpg` | 160799 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_sand_late_524_albedo.jpg` | 300324 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_sand_late_524_normal.jpg` | 448130 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_sand_late_524_rough.jpg` | 160799 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_sand_normal.jpg` | 448130 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_sand_rough.jpg` | 160799 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_sand_shade_262_albedo.jpg` | 178106 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_sand_shade_262_normal.jpg` | 448130 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_sand_shade_262_rough.jpg` | 160799 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_sand_shade_262_shade_527_albedo.jpg` | 137377 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/park_sand_shade_262_shade_527_normal.jpg` | 448130 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/park_sand_shade_262_shade_527_rough.jpg` | 160799 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pebbles_albedo.jpg` | 579736 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pebbles_late_264_albedo.jpg` | 518144 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pebbles_late_264_late_529_albedo.jpg` | 506325 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pebbles_late_264_late_529_normal.jpg` | 616206 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pebbles_late_264_late_529_rough.jpg` | 284747 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pebbles_late_264_normal.jpg` | 616206 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pebbles_late_264_rough.jpg` | 284747 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pebbles_normal.jpg` | 616206 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pebbles_rake_528_albedo.jpg` | 556304 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pebbles_rake_528_normal.jpg` | 616206 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pebbles_rake_528_rough.jpg` | 284747 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pebbles_rough.jpg` | 284747 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pebbles_shade_132_albedo.jpg` | 366461 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pebbles_shade_132_normal.jpg` | 616206 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pebbles_shade_132_rough.jpg` | 284747 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pebbles_shade_132_wet_265_albedo.jpg` | 335247 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pebbles_shade_132_wet_265_dry_531_albedo.jpg` | 335839 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pebbles_shade_132_wet_265_dry_531_normal.jpg` | 616206 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pebbles_shade_132_wet_265_dry_531_rough.jpg` | 284747 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pebbles_shade_132_wet_265_normal.jpg` | 616206 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pebbles_shade_132_wet_265_rough.jpg` | 284747 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pebbles_shade_132_wet_530_albedo.jpg` | 335247 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pebbles_shade_132_wet_530_normal.jpg` | 616206 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pebbles_shade_132_wet_530_rough.jpg` | 284747 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pine_bark_albedo.jpg` | 330989 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pine_bark_dry_266_albedo.jpg` | 318599 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pine_bark_dry_266_normal.jpg` | 497537 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pine_bark_dry_266_rake_533_albedo.jpg` | 321148 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pine_bark_dry_266_rake_533_normal.jpg` | 497537 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pine_bark_dry_266_rake_533_rough.jpg` | 192543 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pine_bark_dry_266_rough.jpg` | 192543 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pine_bark_normal.jpg` | 497537 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pine_bark_rake_133_albedo.jpg` | 322379 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pine_bark_rake_133_late_534_albedo.jpg` | 313889 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pine_bark_rake_133_late_534_normal.jpg` | 497537 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pine_bark_rake_133_late_534_rough.jpg` | 192543 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pine_bark_rake_133_normal.jpg` | 497537 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pine_bark_rake_133_rough.jpg` | 192543 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pine_bark_rake_133_shade_267_albedo.jpg` | 259852 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pine_bark_rake_133_shade_267_normal.jpg` | 497537 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pine_bark_rake_133_shade_267_rough.jpg` | 192543 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pine_bark_rake_133_shade_267_wet_535_albedo.jpg` | 239336 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pine_bark_rake_133_shade_267_wet_535_normal.jpg` | 497537 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pine_bark_rake_133_shade_267_wet_535_rough.jpg` | 192543 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pine_bark_rough.jpg` | 192543 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pine_bark_shade_532_albedo.jpg` | 197317 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/pine_bark_shade_532_normal.jpg` | 497537 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/pine_bark_shade_532_rough.jpg` | 192543 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/playground_sand_albedo.jpg` | 462085 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/playground_sand_dry_536_albedo.jpg` | 436462 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/playground_sand_dry_536_normal.jpg` | 563423 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/playground_sand_dry_536_rough.jpg` | 61190 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/playground_sand_late_134_albedo.jpg` | 400483 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/playground_sand_late_134_late_269_albedo.jpg` | 392303 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/playground_sand_late_134_late_269_normal.jpg` | 563423 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/playground_sand_late_134_late_269_rake_538_albedo.jpg` | 395088 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/playground_sand_late_134_late_269_rake_538_normal.jpg` | 563423 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/playground_sand_late_134_late_269_rake_538_rough.jpg` | 61190 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/playground_sand_late_134_late_269_rough.jpg` | 61190 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/playground_sand_late_134_normal.jpg` | 563423 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/playground_sand_late_134_rough.jpg` | 61190 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/playground_sand_late_134_shade_537_albedo.jpg` | 333483 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/playground_sand_late_134_shade_537_normal.jpg` | 563423 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/playground_sand_late_134_shade_537_rough.jpg` | 61190 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/playground_sand_normal.jpg` | 563423 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/playground_sand_rake_268_albedo.jpg` | 441662 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/playground_sand_rake_268_late_539_albedo.jpg` | 424679 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/playground_sand_rake_268_late_539_normal.jpg` | 563423 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/playground_sand_rake_268_late_539_rough.jpg` | 61190 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/playground_sand_rake_268_normal.jpg` | 563423 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/playground_sand_rake_268_rough.jpg` | 61190 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/playground_sand_rough.jpg` | 61190 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/poly_wool_herringbone_albedo.jpg` | 397714 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/poly_wool_herringbone_normal.jpg` | 383465 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/poly_wool_herringbone_rough.jpg` | 438363 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/poly_wool_herringbone_wet_135_albedo.jpg` | 347412 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/poly_wool_herringbone_wet_135_dry_271_albedo.jpg` | 347638 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/poly_wool_herringbone_wet_135_dry_271_normal.jpg` | 383465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/poly_wool_herringbone_wet_135_dry_271_rough.jpg` | 438363 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/poly_wool_herringbone_wet_135_dry_271_shade_542_albedo.jpg` | 288399 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/poly_wool_herringbone_wet_135_dry_271_shade_542_normal.jpg` | 383465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/poly_wool_herringbone_wet_135_dry_271_shade_542_rough.jpg` | 438363 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/poly_wool_herringbone_wet_135_dry_541_albedo.jpg` | 347638 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/poly_wool_herringbone_wet_135_dry_541_normal.jpg` | 383465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/poly_wool_herringbone_wet_135_dry_541_rough.jpg` | 438363 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/poly_wool_herringbone_wet_135_normal.jpg` | 383465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/poly_wool_herringbone_wet_135_rough.jpg` | 438363 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/poly_wool_herringbone_wet_270_albedo.jpg` | 347412 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/poly_wool_herringbone_wet_270_normal.jpg` | 383465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/poly_wool_herringbone_wet_270_rake_543_albedo.jpg` | 349417 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/poly_wool_herringbone_wet_270_rake_543_normal.jpg` | 383465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/poly_wool_herringbone_wet_270_rake_543_rough.jpg` | 438363 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/poly_wool_herringbone_wet_270_rough.jpg` | 438363 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/poly_wool_herringbone_wet_540_albedo.jpg` | 347412 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/poly_wool_herringbone_wet_540_normal.jpg` | 383465 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/poly_wool_herringbone_wet_540_rough.jpg` | 438363 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/apron_dirt_albedo.jpg` | 297944 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/apron_dirt_normal.jpg` | 126618 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/apron_dirt_rough.jpg` | 88079 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/board_chalk_albedo.jpg` | 163594 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/board_chalk_normal.jpg` | 45477 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/board_chalk_rough.jpg` | 66496 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/board_hunter_albedo.jpg` | 163722 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/board_hunter_normal.jpg` | 47245 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/board_hunter_rough.jpg` | 62021 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/board_white_albedo.jpg` | 100792 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/board_white_normal.jpg` | 43034 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/board_white_rough.jpg` | 44865 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/boot_black_albedo.jpg` | 6695 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/boot_black_normal.jpg` | 7516 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/boot_black_rough.jpg` | 6427 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/brush_box_albedo.jpg` | 300037 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/brush_box_normal.jpg` | 124535 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/brush_box_rough.jpg` | 116031 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/brush_dry_albedo.jpg` | 229151 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/brush_dry_normal.jpg` | 95987 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/brush_dry_rough.jpg` | 89075 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/clover_patch_albedo.jpg` | 540023 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/clover_patch_normal.jpg` | 297512 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/clover_patch_rough.jpg` | 237117 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/cooler_navy_albedo.jpg` | 193108 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/cooler_navy_normal.jpg` | 34238 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/cooler_navy_rough.jpg` | 70595 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/duff_dry_albedo.jpg` | 505110 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/duff_dry_normal.jpg` | 309284 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/duff_dry_rough.jpg` | 209341 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/fescue_late_albedo.jpg` | 478910 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/fescue_late_normal.jpg` | 215974 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/fescue_late_rough.jpg` | 189302 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/flower_bloom_soil_albedo.jpg` | 434760 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/flower_bloom_soil_normal.jpg` | 242200 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/flower_bloom_soil_rough.jpg` | 173035 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/flower_box_soil_albedo.jpg` | 407468 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/flower_box_soil_normal.jpg` | 216680 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/flower_box_soil_rough.jpg` | 152007 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/flower_soil_albedo.jpg` | 405612 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/flower_soil_normal.jpg` | 219438 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/flower_soil_rough.jpg` | 154754 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_clover_albedo.jpg` | 545715 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/grass_clover_normal.jpg` | 306367 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/grass_clover_rough.jpg` | 252674 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_dry_patch_albedo.jpg` | 494638 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_dry_patch_normal.jpg` | 236065 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_dry_patch_rough.jpg` | 201558 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_late_rust_albedo.jpg` | 550726 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_late_rust_normal.jpg` | 267241 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_late_rust_rough.jpg` | 233567 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_morning_albedo.jpg` | 549212 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_morning_normal.jpg` | 309775 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_morning_rough.jpg` | 253174 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_piedmont_albedo.jpg` | 547688 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/grass_piedmont_normal.jpg` | 325802 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_piedmont_rough.jpg` | 256788 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_ring_edge_albedo.jpg` | 504219 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_ring_edge_normal.jpg` | 252476 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_ring_edge_rough.jpg` | 201833 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_shade_albedo.jpg` | 509027 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_shade_normal.jpg` | 235856 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/grass_shade_rough.jpg` | 194863 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/gravel_barn_yard_albedo.jpg` | 463816 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/gravel_barn_yard_normal.jpg` | 347379 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/gravel_barn_yard_rough.jpg` | 244272 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/gravel_drive_albedo.jpg` | 463612 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/gravel_drive_normal.jpg` | 347467 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/gravel_drive_rough.jpg` | 259211 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/gravel_wet_albedo.jpg` | 422526 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/gravel_wet_normal.jpg` | 254868 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/gravel_wet_rough.jpg` | 197591 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/hay_bale_albedo.jpg` | 518035 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/hay_bale_normal.jpg` | 294906 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/hay_bale_rough.jpg` | 223121 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/hay_dust_albedo.jpg` | 539495 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/hay_dust_normal.jpg` | 267814 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/hay_dust_rough.jpg` | 213910 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/hoof_cut_sand_albedo.jpg` | 471424 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/hoof_cut_sand_normal.jpg` | 314490 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/hoof_cut_sand_rough.jpg` | 217249 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/hoof_wet_albedo.jpg` | 447963 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/hoof_wet_normal.jpg` | 263990 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/hoof_wet_rough.jpg` | 198530 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/hydrant_metal_albedo.jpg` | 229594 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/hydrant_metal_normal.jpg` | 122079 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/hydrant_metal_rough.jpg` | 87364 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/iron_polish_albedo.jpg` | 427893 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/iron_polish_normal.jpg` | 254136 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/iron_polish_rough.jpg` | 154234 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/kick_barn_albedo.jpg` | 123106 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/kick_barn_normal.jpg` | 44831 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/kick_barn_rough.jpg` | 45174 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/kick_dark_albedo.jpg` | 139346 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/kick_dark_normal.jpg` | 52159 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/kick_dark_rough.jpg` | 50141 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/kick_scuff_albedo.jpg` | 139748 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/kick_scuff_normal.jpg` | 60590 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/kick_scuff_rough.jpg` | 48896 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/leather_bridle_albedo.jpg` | 296583 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/leather_bridle_normal.jpg` | 74786 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/leather_bridle_rough.jpg` | 79991 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/leather_reins_albedo.jpg` | 96243 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/leather_reins_normal.jpg` | 18202 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/leather_reins_rough.jpg` | 22559 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/leather_sweat_albedo.jpg` | 145024 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/leather_sweat_normal.jpg` | 36021 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/leather_sweat_rough.jpg` | 48004 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/natural_rail_albedo.jpg` | 276859 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/natural_rail_normal.jpg` | 147714 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/natural_rail_rough.jpg` | 127518 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/navy_pole_albedo.jpg` | 83902 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/navy_pole_normal.jpg` | 23587 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/navy_pole_rough.jpg` | 27755 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/oak_bark_albedo.jpg` | 495459 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/proc/oak_bark_normal.jpg` | 370327 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/proc/oak_bark_rough.jpg` | 260584 | no | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 | unreferenced |
| `assets/textures/harvest/proc/oak_fourboard_albedo.jpg` | 276986 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/oak_fourboard_normal.jpg` | 147638 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/oak_fourboard_rough.jpg` | 133048 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/oak_leaf_late_albedo.jpg` | 469912 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/oak_leaf_late_normal.jpg` | 280013 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/oak_leaf_late_rough.jpg` | 199538 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/oak_rust_albedo.jpg` | 450984 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/oak_rust_normal.jpg` | 300604 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/oak_rust_rough.jpg` | 204381 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/pad_quilt_albedo.jpg` | 408079 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/pad_quilt_normal.jpg` | 129589 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/pad_quilt_rough.jpg` | 174878 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/pine_bark_wet_albedo.jpg` | 262873 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/pine_bark_wet_normal.jpg` | 122456 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/pine_bark_wet_rough.jpg` | 92521 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/pine_duff_wet_albedo.jpg` | 418699 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/pine_duff_wet_normal.jpg` | 232327 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/pine_duff_wet_rough.jpg` | 171125 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/pine_needle_shade_albedo.jpg` | 433169 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/pine_needle_shade_normal.jpg` | 255981 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/pine_needle_shade_rough.jpg` | 179933 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/pine_needles_albedo.jpg` | 481420 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/pine_needles_normal.jpg` | 306804 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/pine_needles_rough.jpg` | 202245 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/plank_gate_albedo.jpg` | 235556 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/plank_gate_normal.jpg` | 99966 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/plank_gate_rough.jpg` | 89287 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_000_albedo.jpg` | 471032 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_000_normal.jpg` | 240187 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_000_rough.jpg` | 245470 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_001_albedo.jpg` | 355072 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_001_normal.jpg` | 177388 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_001_rough.jpg` | 243622 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_002_albedo.jpg` | 528166 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_002_normal.jpg` | 314000 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_002_rough.jpg` | 311262 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_003_albedo.jpg` | 346408 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_003_normal.jpg` | 136305 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_003_rough.jpg` | 153594 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_004_albedo.jpg` | 280830 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_004_normal.jpg` | 143357 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_004_rough.jpg` | 162331 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_005_albedo.jpg` | 448496 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_005_normal.jpg` | 211409 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_005_rough.jpg` | 237875 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_006_albedo.jpg` | 339120 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_006_normal.jpg` | 156108 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_006_rough.jpg` | 179919 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_007_albedo.jpg` | 537236 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_007_normal.jpg` | 326413 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_007_rough.jpg` | 327512 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_008_albedo.jpg` | 386303 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_008_normal.jpg` | 180461 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_008_rough.jpg` | 202067 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_009_albedo.jpg` | 253609 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_009_normal.jpg` | 117740 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_009_rough.jpg` | 137220 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_010_albedo.jpg` | 463076 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_010_normal.jpg` | 228246 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_010_rough.jpg` | 247176 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_011_albedo.jpg` | 353287 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_011_normal.jpg` | 176082 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_011_rough.jpg` | 242175 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_012_albedo.jpg` | 502327 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_012_normal.jpg` | 279798 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_012_rough.jpg` | 283856 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_013_albedo.jpg` | 350458 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_013_normal.jpg` | 141215 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_013_rough.jpg` | 170825 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_014_albedo.jpg` | 268059 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_014_normal.jpg` | 136124 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_014_rough.jpg` | 159724 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_015_albedo.jpg` | 455083 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_015_normal.jpg` | 217220 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_015_rough.jpg` | 230480 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_016_albedo.jpg` | 373543 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_016_normal.jpg` | 202638 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_016_rough.jpg` | 255420 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_017_albedo.jpg` | 523165 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_017_normal.jpg` | 307088 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_017_rough.jpg` | 305726 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_018_albedo.jpg` | 339164 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_018_normal.jpg` | 130671 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_018_rough.jpg` | 149759 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_019_albedo.jpg` | 272493 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_019_normal.jpg` | 125491 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_019_rough.jpg` | 148417 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_020_albedo.jpg` | 456788 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_020_normal.jpg` | 220310 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_020_rough.jpg` | 244729 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_021_albedo.jpg` | 339722 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_021_normal.jpg` | 156745 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_021_rough.jpg` | 182186 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_022_albedo.jpg` | 532719 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_022_normal.jpg` | 320479 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_022_rough.jpg` | 318601 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_023_albedo.jpg` | 368715 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_023_normal.jpg` | 162362 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_023_rough.jpg` | 183878 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_024_albedo.jpg` | 268799 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_024_normal.jpg` | 136825 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_024_rough.jpg` | 151488 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_025_albedo.jpg` | 457284 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_025_normal.jpg` | 220052 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_025_rough.jpg` | 243038 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_026_albedo.jpg` | 352690 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_026_normal.jpg` | 175384 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_026_rough.jpg` | 240246 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_027_albedo.jpg` | 485150 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_027_normal.jpg` | 262334 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_027_rough.jpg` | 270896 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_028_albedo.jpg` | 394644 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_028_normal.jpg` | 184571 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_028_rough.jpg` | 221843 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_029_albedo.jpg` | 267329 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_029_normal.jpg` | 133077 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_029_rough.jpg` | 155165 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_030_albedo.jpg` | 449817 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_030_normal.jpg` | 209623 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_030_rough.jpg` | 226593 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_031_albedo.jpg` | 353546 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_031_normal.jpg` | 176199 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_031_rough.jpg` | 241743 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_032_albedo.jpg` | 526800 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_032_normal.jpg` | 310440 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_032_rough.jpg` | 308984 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_033_albedo.jpg` | 331781 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_033_normal.jpg` | 127744 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_033_rough.jpg` | 148984 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_034_albedo.jpg` | 290328 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_034_normal.jpg` | 124406 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_034_rough.jpg` | 147382 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_035_albedo.jpg` | 479179 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_035_normal.jpg` | 253783 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_035_rough.jpg` | 280611 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_036_albedo.jpg` | 355768 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_036_normal.jpg` | 176249 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_036_rough.jpg` | 199397 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_037_albedo.jpg` | 528037 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_037_normal.jpg` | 313906 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_037_rough.jpg` | 311261 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_038_albedo.jpg` | 362105 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_038_normal.jpg` | 156133 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_038_rough.jpg` | 178731 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_039_albedo.jpg` | 252635 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_039_normal.jpg` | 113981 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_039_rough.jpg` | 135058 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_040_albedo.jpg` | 463066 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_040_normal.jpg` | 231482 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_040_rough.jpg` | 251639 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_041_albedo.jpg` | 352813 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_041_normal.jpg` | 175410 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_041_rough.jpg` | 240961 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_042_albedo.jpg` | 532727 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_042_normal.jpg` | 319678 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_042_rough.jpg` | 305340 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_043_albedo.jpg` | 376460 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_043_normal.jpg` | 169995 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_043_rough.jpg` | 195440 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_044_albedo.jpg` | 279945 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_044_normal.jpg` | 146044 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_044_rough.jpg` | 164319 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_045_albedo.jpg` | 443499 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_045_normal.jpg` | 202145 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_045_rough.jpg` | 222630 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_046_albedo.jpg` | 352918 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_046_normal.jpg` | 175362 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_046_rough.jpg` | 240846 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_047_albedo.jpg` | 510938 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_047_normal.jpg` | 291769 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_047_rough.jpg` | 295940 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_048_albedo.jpg` | 343992 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_048_normal.jpg` | 144480 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_048_rough.jpg` | 159463 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_049_albedo.jpg` | 268166 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_049_normal.jpg` | 136279 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_049_rough.jpg` | 160103 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_050_albedo.jpg` | 473936 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_050_normal.jpg` | 245159 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_050_rough.jpg` | 262604 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_051_albedo.jpg` | 338448 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_051_normal.jpg` | 155426 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_051_rough.jpg` | 177529 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_052_albedo.jpg` | 530800 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_052_normal.jpg` | 315294 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_052_rough.jpg` | 312471 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_053_albedo.jpg` | 356479 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_053_normal.jpg` | 149940 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_053_rough.jpg` | 174508 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_054_albedo.jpg` | 252217 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_054_normal.jpg` | 112884 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_054_rough.jpg` | 134168 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_055_albedo.jpg` | 444718 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_055_normal.jpg` | 204192 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_055_rough.jpg` | 233405 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_056_albedo.jpg` | 374953 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_056_normal.jpg` | 203080 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_056_rough.jpg` | 256619 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_057_albedo.jpg` | 527637 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_057_normal.jpg` | 310781 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_057_rough.jpg` | 299834 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_058_albedo.jpg` | 368617 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_058_normal.jpg` | 162485 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_058_rough.jpg` | 184283 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_059_albedo.jpg` | 267681 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_059_normal.jpg` | 128408 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_059_rough.jpg` | 149944 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_060_albedo.jpg` | 446200 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_060_normal.jpg` | 208666 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_060_rough.jpg` | 228618 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_061_albedo.jpg` | 353000 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_061_normal.jpg` | 175652 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_061_rough.jpg` | 240742 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_062_albedo.jpg` | 506618 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_062_normal.jpg` | 283368 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_062_rough.jpg` | 290552 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_063_albedo.jpg` | 370017 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_063_normal.jpg` | 158763 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_063_rough.jpg` | 172931 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_064_albedo.jpg` | 281453 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_064_normal.jpg` | 152394 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_064_rough.jpg` | 169554 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_065_albedo.jpg` | 468639 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_065_normal.jpg` | 236524 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_065_rough.jpg` | 252936 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_066_albedo.jpg` | 339579 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_066_normal.jpg` | 156922 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_066_rough.jpg` | 183563 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_067_albedo.jpg` | 517759 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_067_normal.jpg` | 299488 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_067_rough.jpg` | 300663 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_068_albedo.jpg` | 362431 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_068_normal.jpg` | 159765 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_068_rough.jpg` | 183538 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_069_albedo.jpg` | 256778 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_069_normal.jpg` | 111727 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_069_rough.jpg` | 133467 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_070_albedo.jpg` | 479070 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_070_normal.jpg` | 253703 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_070_rough.jpg` | 280597 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_071_albedo.jpg` | 354283 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_071_normal.jpg` | 176732 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_071_rough.jpg` | 242143 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_072_albedo.jpg` | 528258 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_072_normal.jpg` | 309783 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_072_rough.jpg` | 302077 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_073_albedo.jpg` | 362031 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_073_normal.jpg` | 155834 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_073_rough.jpg` | 178283 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_074_albedo.jpg` | 268000 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_074_normal.jpg` | 126711 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_074_rough.jpg` | 148405 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_075_albedo.jpg` | 426420 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_075_normal.jpg` | 187486 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_075_rough.jpg` | 213121 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_076_albedo.jpg` | 371279 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_076_normal.jpg` | 196292 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_076_rough.jpg` | 253923 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_077_albedo.jpg` | 537471 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_077_normal.jpg` | 326568 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_077_rough.jpg` | 327684 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_078_albedo.jpg` | 360540 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_078_normal.jpg` | 150126 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_078_rough.jpg` | 164094 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_079_albedo.jpg` | 267717 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_079_normal.jpg` | 130407 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_079_rough.jpg` | 151781 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_080_albedo.jpg` | 475840 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_080_normal.jpg` | 245706 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_080_rough.jpg` | 259529 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_081_albedo.jpg` | 338991 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_081_normal.jpg` | 155708 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_081_rough.jpg` | 179701 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_082_albedo.jpg` | 511189 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_082_normal.jpg` | 291753 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_082_rough.jpg` | 295875 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_083_albedo.jpg` | 350198 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_083_normal.jpg` | 140798 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_083_rough.jpg` | 170144 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_084_albedo.jpg` | 266867 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_084_normal.jpg` | 137070 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_084_rough.jpg` | 152620 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_085_albedo.jpg` | 473823 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_085_normal.jpg` | 245121 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_085_rough.jpg` | 262510 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_086_albedo.jpg` | 353045 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_086_normal.jpg` | 175219 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_086_rough.jpg` | 240749 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_087_albedo.jpg` | 515075 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_087_normal.jpg` | 292641 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_087_rough.jpg` | 289457 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_088_albedo.jpg` | 369715 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_088_normal.jpg` | 166708 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_088_rough.jpg` | 185687 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_089_albedo.jpg` | 272548 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_089_normal.jpg` | 125426 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_089_rough.jpg` | 148186 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_090_albedo.jpg` | 418190 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_090_normal.jpg` | 180370 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_090_rough.jpg` | 207578 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_091_albedo.jpg` | 353592 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_091_normal.jpg` | 176106 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_091_rough.jpg` | 241905 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_092_albedo.jpg` | 540232 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_092_normal.jpg` | 328173 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_092_rough.jpg` | 324906 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_093_albedo.jpg` | 352975 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_093_normal.jpg` | 142832 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_093_rough.jpg` | 158519 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_094_albedo.jpg` | 267759 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_094_normal.jpg` | 128512 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_094_rough.jpg` | 150096 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_095_albedo.jpg` | 457152 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_095_normal.jpg` | 219896 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_095_rough.jpg` | 242847 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_096_albedo.jpg` | 359000 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_096_normal.jpg` | 181420 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_096_rough.jpg` | 196653 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_097_albedo.jpg` | 506474 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_097_normal.jpg` | 283371 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_097_rough.jpg` | 290437 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_098_albedo.jpg` | 387338 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_098_normal.jpg` | 177800 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_098_rough.jpg` | 219582 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_099_albedo.jpg` | 254361 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_099_normal.jpg` | 120783 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_099_rough.jpg` | 139187 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_100_albedo.jpg` | 479262 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_100_normal.jpg` | 249768 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_100_rough.jpg` | 262744 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_101_albedo.jpg` | 354275 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_101_normal.jpg` | 176583 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_101_rough.jpg` | 242776 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_102_albedo.jpg` | 506030 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_102_normal.jpg` | 282743 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_102_rough.jpg` | 284480 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_103_albedo.jpg` | 348864 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_103_normal.jpg` | 144237 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_103_rough.jpg` | 171405 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_104_albedo.jpg` | 304894 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_104_normal.jpg` | 148618 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_104_rough.jpg` | 165887 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_105_albedo.jpg` | 459859 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_105_normal.jpg` | 225370 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_105_rough.jpg` | 234697 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_106_albedo.jpg` | 354342 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_106_normal.jpg` | 176641 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_106_rough.jpg` | 242646 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_107_albedo.jpg` | 527944 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_107_normal.jpg` | 313833 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_107_rough.jpg` | 311176 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_108_albedo.jpg` | 356704 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_108_normal.jpg` | 147577 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_108_rough.jpg` | 162484 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_109_albedo.jpg` | 267916 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_109_normal.jpg` | 126526 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_109_rough.jpg` | 148665 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_110_albedo.jpg` | 449074 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_110_normal.jpg` | 211978 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_110_rough.jpg` | 238391 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_111_albedo.jpg` | 338766 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_111_normal.jpg` | 155566 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_111_rough.jpg` | 180200 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_112_albedo.jpg` | 545783 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_112_normal.jpg` | 336524 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_112_rough.jpg` | 334272 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_113_albedo.jpg` | 376364 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_113_normal.jpg` | 169918 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_113_rough.jpg` | 195131 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_114_albedo.jpg` | 253568 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_114_normal.jpg` | 117742 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_114_rough.jpg` | 137229 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_115_albedo.jpg` | 462994 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_115_normal.jpg` | 228074 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_115_rough.jpg` | 247346 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_116_albedo.jpg` | 370952 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_116_normal.jpg` | 196237 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_116_rough.jpg` | 253583 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_117_albedo.jpg` | 495599 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_117_normal.jpg` | 272520 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_117_rough.jpg` | 277609 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_118_albedo.jpg` | 349953 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_118_normal.jpg` | 141046 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_118_rough.jpg` | 170380 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_119_albedo.jpg` | 268193 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_119_normal.jpg` | 136311 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_119_rough.jpg` | 160128 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_120_albedo.jpg` | 466620 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_120_normal.jpg` | 233528 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_120_rough.jpg` | 241617 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_121_albedo.jpg` | 352937 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_121_normal.jpg` | 175358 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_121_rough.jpg` | 240859 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_122_albedo.jpg` | 523226 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_122_normal.jpg` | 307193 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_122_rough.jpg` | 305695 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_123_albedo.jpg` | 339148 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_123_normal.jpg` | 131139 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_123_rough.jpg` | 150238 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_124_albedo.jpg` | 285649 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_124_normal.jpg` | 142991 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_124_rough.jpg` | 162215 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_125_albedo.jpg` | 444413 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_125_normal.jpg` | 203957 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_125_rough.jpg` | 233087 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_126_albedo.jpg` | 339520 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_126_normal.jpg` | 156677 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_126_rough.jpg` | 181538 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_127_albedo.jpg` | 532773 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_127_normal.jpg` | 320418 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_127_rough.jpg` | 318743 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_128_albedo.jpg` | 379773 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_128_normal.jpg` | 175439 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_128_rough.jpg` | 192888 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_129_albedo.jpg` | 254723 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_129_normal.jpg` | 116145 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_129_rough.jpg` | 136420 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_130_albedo.jpg` | 457185 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_130_normal.jpg` | 220010 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_130_rough.jpg` | 242865 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_131_albedo.jpg` | 353139 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_131_normal.jpg` | 175620 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_131_rough.jpg` | 241296 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_132_albedo.jpg` | 491774 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_132_normal.jpg` | 269985 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_132_rough.jpg` | 277552 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_133_albedo.jpg` | 387196 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_133_normal.jpg` | 177966 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_133_rough.jpg` | 219517 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_134_albedo.jpg` | 266994 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_134_normal.jpg` | 132964 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_134_rough.jpg` | 154688 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_135_albedo.jpg` | 449840 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_135_normal.jpg` | 209750 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_135_rough.jpg` | 226640 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_136_albedo.jpg` | 375310 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_136_normal.jpg` | 203377 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_136_rough.jpg` | 256738 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_137_albedo.jpg` | 517898 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_137_normal.jpg` | 299563 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_137_rough.jpg` | 300769 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_138_albedo.jpg` | 331404 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_138_normal.jpg` | 127611 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_138_rough.jpg` | 149113 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_139_albedo.jpg` | 290519 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_139_normal.jpg` | 124542 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_139_rough.jpg` | 147454 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_140_albedo.jpg` | 488791 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_140_normal.jpg` | 264845 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_140_rough.jpg` | 287071 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_141_albedo.jpg` | 339218 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_141_normal.jpg` | 157087 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_141_rough.jpg` | 184371 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_142_albedo.jpg` | 527793 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_142_normal.jpg` | 314044 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_142_rough.jpg` | 311177 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_143_albedo.jpg` | 362394 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_143_normal.jpg` | 155989 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_143_rough.jpg` | 178763 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_144_albedo.jpg` | 268604 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_144_normal.jpg` | 136177 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_144_rough.jpg` | 151389 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_145_albedo.jpg` | 449075 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_145_normal.jpg` | 211938 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_145_rough.jpg` | 238622 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_146_albedo.jpg` | 352662 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_146_normal.jpg` | 175213 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_146_rough.jpg` | 240298 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_147_albedo.jpg` | 532697 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_147_normal.jpg` | 319757 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_147_rough.jpg` | 305484 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_148_albedo.jpg` | 384865 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_148_normal.jpg` | 177491 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_148_rough.jpg` | 201774 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_149_albedo.jpg` | 267928 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_149_normal.jpg` | 130525 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_149_rough.jpg` | 151932 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_150_albedo.jpg` | 443443 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_150_normal.jpg` | 201988 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_150_rough.jpg` | 222631 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_151_albedo.jpg` | 353532 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_151_normal.jpg` | 175834 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_151_rough.jpg` | 242212 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_152_albedo.jpg` | 520402 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_152_normal.jpg` | 302999 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_152_rough.jpg` | 304536 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_153_albedo.jpg` | 328507 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_153_normal.jpg` | 123698 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_153_rough.jpg` | 145619 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_154_albedo.jpg` | 268089 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_154_normal.jpg` | 136122 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_154_rough.jpg` | 160264 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_155_albedo.jpg` | 473742 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_155_normal.jpg` | 244832 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_155_rough.jpg` | 262160 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_156_albedo.jpg` | 354855 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_156_normal.jpg` | 175411 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_156_rough.jpg` | 194987 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_157_albedo.jpg` | 523306 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_157_normal.jpg` | 307278 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_157_rough.jpg` | 305792 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_158_albedo.jpg` | 356611 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_158_normal.jpg` | 149743 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_158_rough.jpg` | 174793 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_159_albedo.jpg` | 251448 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_159_normal.jpg` | 112257 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_159_rough.jpg` | 133837 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_160_albedo.jpg` | 458958 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_160_normal.jpg` | 224943 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_160_rough.jpg` | 247196 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_161_albedo.jpg` | 354042 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_161_normal.jpg` | 176469 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_161_rough.jpg` | 242726 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_162_albedo.jpg` | 527677 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_162_normal.jpg` | 310972 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_162_rough.jpg` | 299945 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_163_albedo.jpg` | 368634 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_163_normal.jpg` | 162481 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_163_rough.jpg` | 183815 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_164_albedo.jpg` | 280372 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_164_normal.jpg` | 144434 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_164_rough.jpg` | 163144 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_165_albedo.jpg` | 435428 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_165_normal.jpg` | 194552 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_165_rough.jpg` | 218429 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_166_albedo.jpg` | 352866 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_166_normal.jpg` | 175347 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_166_rough.jpg` | 240788 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_167_albedo.jpg` | 506621 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_167_normal.jpg` | 283312 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_167_rough.jpg` | 290462 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_168_albedo.jpg` | 378522 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_168_normal.jpg` | 168201 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_168_rough.jpg` | 178345 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_169_albedo.jpg` | 266877 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_169_normal.jpg` | 132873 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_169_rough.jpg` | 154723 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_170_albedo.jpg` | 468691 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_170_normal.jpg` | 236473 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_170_rough.jpg` | 252871 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_171_albedo.jpg` | 339220 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_171_normal.jpg` | 156855 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_171_rough.jpg` | 183758 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_172_albedo.jpg` | 525361 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_172_normal.jpg` | 308064 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_172_rough.jpg` | 307391 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_173_albedo.jpg` | 348963 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_173_normal.jpg` | 144209 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_173_rough.jpg` | 171347 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_174_albedo.jpg` | 256865 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_174_normal.jpg` | 111811 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_174_rough.jpg` | 133381 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_175_albedo.jpg` | 479076 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_175_normal.jpg` | 253634 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_175_rough.jpg` | 280370 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_176_albedo.jpg` | 376101 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_176_normal.jpg` | 203695 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_176_rough.jpg` | 258235 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_177_albedo.jpg` | 521888 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_177_normal.jpg` | 301969 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_177_rough.jpg` | 294612 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_178_albedo.jpg` | 361954 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_178_normal.jpg` | 156180 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_178_rough.jpg` | 178729 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_179_albedo.jpg` | 267850 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_179_normal.jpg` | 126565 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_179_rough.jpg` | 148733 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_180_albedo.jpg` | 437969 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_180_normal.jpg` | 202295 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_180_rough.jpg` | 223708 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_181_albedo.jpg` | 353164 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_181_normal.jpg` | 175901 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_181_rough.jpg` | 241490 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_182_albedo.jpg` | 537536 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_182_normal.jpg` | 326680 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_182_rough.jpg` | 327627 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_183_albedo.jpg` | 360309 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_183_normal.jpg` | 149821 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_183_rough.jpg` | 163449 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_184_albedo.jpg` | 282586 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_184_normal.jpg` | 150627 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_184_rough.jpg` | 167394 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_185_albedo.jpg` | 462789 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_185_normal.jpg` | 227911 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_185_rough.jpg` | 247124 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_186_albedo.jpg` | 339160 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_186_normal.jpg` | 155992 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_186_rough.jpg` | 179905 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_187_albedo.jpg` | 511059 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_187_normal.jpg` | 291605 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_187_rough.jpg` | 295901 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_188_albedo.jpg` | 362553 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_188_normal.jpg` | 155727 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_188_rough.jpg` | 181102 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_189_albedo.jpg` | 255649 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_189_normal.jpg` | 123601 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_189_rough.jpg` | 141563 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_190_albedo.jpg` | 473639 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_190_normal.jpg` | 244976 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_190_rough.jpg` | 262605 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_191_albedo.jpg` | 353088 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_191_normal.jpg` | 175595 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_191_rough.jpg` | 240940 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_192_albedo.jpg` | 521279 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_192_normal.jpg` | 301033 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_192_rough.jpg` | 297299 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_193_albedo.jpg` | 356508 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_193_normal.jpg` | 150103 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_193_rough.jpg` | 174761 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_194_albedo.jpg` | 272353 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_194_normal.jpg` | 125322 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_194_rough.jpg` | 148012 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_195_albedo.jpg` | 418296 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_195_normal.jpg` | 180316 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_195_rough.jpg` | 207162 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_196_albedo.jpg` | 371604 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_196_normal.jpg` | 196655 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_196_rough.jpg` | 254540 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_197_albedo.jpg` | 532552 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_197_normal.jpg` | 320308 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_197_rough.jpg` | 318711 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_198_albedo.jpg` | 352982 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_198_normal.jpg` | 142697 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_198_rough.jpg` | 158283 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_199_albedo.jpg` | 267804 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_199_normal.jpg` | 128536 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_199_rough.jpg` | 149962 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_200_albedo.jpg` | 470268 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_200_normal.jpg` | 238688 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_200_rough.jpg` | 255611 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_201_albedo.jpg` | 338832 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_201_normal.jpg` | 156023 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_201_rough.jpg` | 180311 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_202_albedo.jpg` | 506567 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_202_normal.jpg` | 283241 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_202_rough.jpg` | 290526 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_203_albedo.jpg` | 387295 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_203_normal.jpg` | 177912 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_203_rough.jpg` | 220180 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_204_albedo.jpg` | 265930 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_204_normal.jpg` | 134902 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_204_rough.jpg` | 151075 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_205_albedo.jpg` | 468620 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_205_normal.jpg` | 236277 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_205_rough.jpg` | 252874 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_206_albedo.jpg` | 353912 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_206_normal.jpg` | 176304 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_206_rough.jpg` | 241891 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_207_albedo.jpg` | 506124 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_207_normal.jpg` | 282928 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_207_rough.jpg` | 284376 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_208_albedo.jpg` | 363911 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_208_normal.jpg` | 163210 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_208_rough.jpg` | 183865 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_209_albedo.jpg` | 290670 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_209_normal.jpg` | 124688 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_209_rough.jpg` | 147571 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_210_albedo.jpg` | 459841 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_210_normal.jpg` | 225563 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_210_rough.jpg` | 234764 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_211_albedo.jpg` | 354666 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_211_normal.jpg` | 177041 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_211_rough.jpg` | 243521 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_212_albedo.jpg` | 535544 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_212_normal.jpg` | 321811 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_212_rough.jpg` | 317852 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_213_albedo.jpg` | 346795 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_213_normal.jpg` | 136573 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_213_rough.jpg` | 153995 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_214_albedo.jpg` | 268072 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_214_normal.jpg` | 126666 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_214_rough.jpg` | 148653 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_215_albedo.jpg` | 449274 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_215_normal.jpg` | 211975 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_215_rough.jpg` | 238586 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_216_albedo.jpg` | 359171 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_216_normal.jpg` | 181908 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_216_rough.jpg` | 194736 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_217_albedo.jpg` | 537465 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_217_normal.jpg` | 326274 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_217_rough.jpg` | 327654 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_218_albedo.jpg` | 376337 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_218_normal.jpg` | 170000 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_218_rough.jpg` | 195680 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_219_albedo.jpg` | 253597 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_219_normal.jpg` | 117775 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_219_rough.jpg` | 137314 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_220_albedo.jpg` | 474165 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_220_normal.jpg` | 242114 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_220_rough.jpg` | 257812 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_221_albedo.jpg` | 352905 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_221_normal.jpg` | 175238 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_221_rough.jpg` | 240680 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_222_albedo.jpg` | 495720 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_222_normal.jpg` | 272821 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_222_rough.jpg` | 277551 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_223_albedo.jpg` | 349571 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_223_normal.jpg` | 140402 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_223_rough.jpg` | 169704 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_224_albedo.jpg` | 281972 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_224_normal.jpg` | 154483 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_224_rough.jpg` | 173337 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_225_albedo.jpg` | 455186 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_225_normal.jpg` | 217596 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_225_rough.jpg` | 230542 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_226_albedo.jpg` | 353441 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_226_normal.jpg` | 175930 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_226_rough.jpg` | 242257 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_227_albedo.jpg` | 523197 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_227_normal.jpg` | 307160 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_227_rough.jpg` | 305876 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_228_albedo.jpg` | 350603 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_228_normal.jpg` | 144357 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_228_rough.jpg` | 160370 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_229_albedo.jpg` | 272428 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_229_normal.jpg` | 125465 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_229_rough.jpg` | 148064 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_230_albedo.jpg` | 444536 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_230_normal.jpg` | 204053 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_230_rough.jpg` | 233369 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_231_albedo.jpg` | 339377 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_231_normal.jpg` | 156272 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_231_rough.jpg` | 182718 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_232_albedo.jpg` | 541551 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_232_normal.jpg` | 330919 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_232_rough.jpg` | 326110 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_233_albedo.jpg` | 368377 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_233_normal.jpg` | 162358 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_233_rough.jpg` | 183498 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_234_albedo.jpg` | 253908 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_234_normal.jpg` | 115720 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_234_rough.jpg` | 136061 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_235_albedo.jpg` | 457000 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_235_normal.jpg` | 219854 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_235_rough.jpg` | 242752 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_236_albedo.jpg` | 371123 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_236_normal.jpg` | 196250 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_236_rough.jpg` | 253915 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_237_albedo.jpg` | 484822 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_237_normal.jpg` | 262140 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_237_rough.jpg` | 270632 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_238_albedo.jpg` | 387092 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_238_normal.jpg` | 177696 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_238_rough.jpg` | 219548 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_239_albedo.jpg` | 267371 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_239_normal.jpg` | 133334 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_239_rough.jpg` | 155353 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_240_albedo.jpg` | 461958 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_240_normal.jpg` | 226200 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_240_rough.jpg` | 237886 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_241_albedo.jpg` | 354576 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_241_normal.jpg` | 177125 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_241_rough.jpg` | 243487 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_242_albedo.jpg` | 517911 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_242_normal.jpg` | 299475 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_242_rough.jpg` | 300776 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_243_albedo.jpg` | 331716 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_243_normal.jpg` | 127612 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_243_rough.jpg` | 148822 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_244_albedo.jpg` | 301983 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_244_normal.jpg` | 142652 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_244_rough.jpg` | 162260 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_245_albedo.jpg` | 479073 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_245_normal.jpg` | 253653 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_245_rough.jpg` | 281005 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_246_albedo.jpg` | 339267 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_246_normal.jpg` | 157350 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_246_rough.jpg` | 185410 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_247_albedo.jpg` | 528091 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_247_normal.jpg` | 313880 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_247_rough.jpg` | 311351 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_248_albedo.jpg` | 374453 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_248_normal.jpg` | 170085 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_248_rough.jpg` | 187830 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_249_albedo.jpg` | 252849 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_249_normal.jpg` | 114027 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_249_rough.jpg` | 135232 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_250_albedo.jpg` | 449139 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_250_normal.jpg` | 211982 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_250_rough.jpg` | 238725 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_251_albedo.jpg` | 352868 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_251_normal.jpg` | 175369 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_251_rough.jpg` | 240742 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_252_albedo.jpg` | 538392 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_252_normal.jpg` | 324770 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_252_rough.jpg` | 311038 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_253_albedo.jpg` | 376459 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_253_normal.jpg` | 170109 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_253_rough.jpg` | 196040 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_254_albedo.jpg` | 268022 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_254_normal.jpg` | 130754 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_254_rough.jpg` | 151898 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_255_albedo.jpg` | 443394 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_255_normal.jpg` | 202075 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_255_rough.jpg` | 222421 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_256_albedo.jpg` | 374950 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_256_normal.jpg` | 202951 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_256_rough.jpg` | 256244 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_257_albedo.jpg` | 511030 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_257_normal.jpg` | 291785 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_257_rough.jpg` | 295923 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_258_albedo.jpg` | 328114 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_258_normal.jpg` | 123373 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_258_rough.jpg` | 145554 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_259_albedo.jpg` | 268131 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_259_normal.jpg` | 136197 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_259_rough.jpg` | 160168 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_260_albedo.jpg` | 483956 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_260_normal.jpg` | 257307 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_260_rough.jpg` | 270968 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_261_albedo.jpg` | 338560 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_261_normal.jpg` | 155423 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_261_rough.jpg` | 179768 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_262_albedo.jpg` | 523292 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_262_normal.jpg` | 307095 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_262_rough.jpg` | 305801 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_263_albedo.jpg` | 356468 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_263_normal.jpg` | 149963 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_263_rough.jpg` | 174703 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_264_albedo.jpg` | 268921 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_264_normal.jpg` | 135748 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_264_rough.jpg` | 150863 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_265_albedo.jpg` | 444261 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_265_normal.jpg` | 203745 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_265_rough.jpg` | 233253 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_266_albedo.jpg` | 353531 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_266_normal.jpg` | 175964 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_266_rough.jpg` | 241998 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_267_albedo.jpg` | 527655 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_267_normal.jpg` | 310879 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_267_rough.jpg` | 299828 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_268_albedo.jpg` | 377922 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_268_normal.jpg` | 171739 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_268_rough.jpg` | 192373 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_269_albedo.jpg` | 267637 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_269_normal.jpg` | 128365 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_269_rough.jpg` | 149891 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_270_albedo.jpg` | 435149 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_270_normal.jpg` | 194451 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_270_rough.jpg` | 218449 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_271_albedo.jpg` | 352867 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_271_normal.jpg` | 175261 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_271_rough.jpg` | 240901 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_272_albedo.jpg` | 515697 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_272_normal.jpg` | 295279 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_272_rough.jpg` | 299645 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_273_albedo.jpg` | 370059 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_273_normal.jpg` | 158860 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_273_rough.jpg` | 172737 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_274_albedo.jpg` | 267297 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_274_normal.jpg` | 133167 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_274_rough.jpg` | 155272 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_275_albedo.jpg` | 468538 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_275_normal.jpg` | 236636 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_275_rough.jpg` | 253072 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_276_albedo.jpg` | 355624 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_276_normal.jpg` | 176010 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_276_rough.jpg` | 197924 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_277_albedo.jpg` | 517903 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_277_normal.jpg` | 299525 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_277_rough.jpg` | 300734 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_278_albedo.jpg` | 348704 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_278_normal.jpg` | 144621 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_278_rough.jpg` | 171600 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_279_albedo.jpg` | 257687 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_279_normal.jpg` | 112136 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_279_rough.jpg` | 133985 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_280_albedo.jpg` | 490537 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_280_normal.jpg` | 268180 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_280_rough.jpg` | 287705 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_281_albedo.jpg` | 354446 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_281_normal.jpg` | 176778 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_281_rough.jpg` | 242651 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_282_albedo.jpg` | 521971 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_282_normal.jpg` | 302095 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_282_rough.jpg` | 294825 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_283_albedo.jpg` | 362221 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_283_normal.jpg` | 156497 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_283_rough.jpg` | 178813 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_284_albedo.jpg` | 281113 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_284_normal.jpg` | 143564 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_284_rough.jpg` | 162720 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_285_albedo.jpg` | 426332 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_285_normal.jpg` | 187366 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_285_rough.jpg` | 212832 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_286_albedo.jpg` | 353601 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_286_normal.jpg` | 176206 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_286_rough.jpg` | 242519 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_287_albedo.jpg` | 537284 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_287_normal.jpg` | 326442 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_287_rough.jpg` | 327571 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_288_albedo.jpg` | 369747 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_288_normal.jpg` | 161604 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_288_rough.jpg` | 170121 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_289_albedo.jpg` | 267806 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_289_normal.jpg` | 130518 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_289_rough.jpg` | 151831 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_290_albedo.jpg` | 462927 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_290_normal.jpg` | 228218 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_290_rough.jpg` | 246927 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_291_albedo.jpg` | 338932 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_291_normal.jpg` | 155906 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_291_rough.jpg` | 179372 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_292_albedo.jpg` | 518421 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_292_normal.jpg` | 300407 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_292_rough.jpg` | 302761 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_293_albedo.jpg` | 349249 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_293_normal.jpg` | 140478 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_293_rough.jpg` | 169465 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_294_albedo.jpg` | 255395 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_294_normal.jpg` | 123403 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_294_rough.jpg` | 141196 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_295_albedo.jpg` | 473685 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_295_normal.jpg` | 244949 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_295_rough.jpg` | 262090 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_296_albedo.jpg` | 373891 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_296_normal.jpg` | 202715 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_296_rough.jpg` | 255517 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_297_albedo.jpg` | 515201 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_297_normal.jpg` | 292810 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_297_rough.jpg` | 289694 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_298_albedo.jpg` | 356724 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_298_normal.jpg` | 149686 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_298_rough.jpg` | 174341 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_299_albedo.jpg` | 272487 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_299_normal.jpg` | 125522 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_299_rough.jpg` | 148136 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_300_albedo.jpg` | 430792 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_300_normal.jpg` | 196048 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_300_rough.jpg` | 219243 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_301_albedo.jpg` | 353995 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_301_normal.jpg` | 176598 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_301_rough.jpg` | 242966 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_302_albedo.jpg` | 532754 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_302_normal.jpg` | 320496 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_302_rough.jpg` | 318537 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_303_albedo.jpg` | 352995 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_303_normal.jpg` | 142626 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_303_rough.jpg` | 158388 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_304_albedo.jpg` | 283172 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_304_normal.jpg` | 149635 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_304_rough.jpg` | 166370 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_305_albedo.jpg` | 457035 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_305_normal.jpg` | 219582 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_305_rough.jpg` | 242481 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_306_albedo.jpg` | 339170 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_306_normal.jpg` | 155895 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_306_rough.jpg` | 179962 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_307_albedo.jpg` | 506524 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_307_normal.jpg` | 283346 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_307_rough.jpg` | 290490 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_308_albedo.jpg` | 394285 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_308_normal.jpg` | 184289 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_308_rough.jpg` | 221546 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_309_albedo.jpg` | 254340 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_309_normal.jpg` | 120810 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_309_rough.jpg` | 139407 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_310_albedo.jpg` | 468636 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_310_normal.jpg` | 236383 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_310_rough.jpg` | 253024 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_311_albedo.jpg` | 353607 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_311_normal.jpg` | 176217 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_311_rough.jpg` | 242104 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_312_albedo.jpg` | 512272 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_312_normal.jpg` | 291434 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_312_rough.jpg` | 291911 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_313_albedo.jpg` | 349039 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_313_normal.jpg` | 144156 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_313_rough.jpg` | 171445 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_314_albedo.jpg` | 290512 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_314_normal.jpg` | 124377 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_314_rough.jpg` | 147708 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_315_albedo.jpg` | 459958 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_315_normal.jpg` | 225501 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_315_rough.jpg` | 234522 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_316_albedo.jpg` | 372713 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_316_normal.jpg` | 197682 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_316_rough.jpg` | 255754 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_317_albedo.jpg` | 528084 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_317_normal.jpg` | 313871 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_317_rough.jpg` | 311310 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_318_albedo.jpg` | 346822 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_318_normal.jpg` | 136648 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_318_rough.jpg` | 153963 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_319_albedo.jpg` | 268021 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_319_normal.jpg` | 126555 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_319_rough.jpg` | 148427 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_320_albedo.jpg` | 463181 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_320_normal.jpg` | 231787 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_320_rough.jpg` | 251826 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_321_albedo.jpg` | 339112 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_321_normal.jpg` | 156035 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_321_rough.jpg` | 179763 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_322_albedo.jpg` | 537572 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_322_normal.jpg` | 326376 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_322_rough.jpg` | 327427 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_323_albedo.jpg` | 376118 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_323_normal.jpg` | 170245 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_323_rough.jpg` | 195871 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_324_albedo.jpg` | 265847 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_324_normal.jpg` | 132973 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_324_rough.jpg` | 149800 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_325_albedo.jpg` | 462951 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_325_normal.jpg` | 228017 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_325_rough.jpg` | 247294 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_326_albedo.jpg` | 353518 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_326_normal.jpg` | 176120 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_326_rough.jpg` | 242428 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_327_albedo.jpg` | 495567 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_327_normal.jpg` | 272689 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_327_rough.jpg` | 277223 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_328_albedo.jpg` | 365230 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_328_normal.jpg` | 161299 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_328_rough.jpg` | 183021 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_329_albedo.jpg` | 268169 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_329_normal.jpg` | 136211 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_329_rough.jpg` | 160119 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_330_albedo.jpg` | 455165 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_330_normal.jpg` | 217533 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_330_rough.jpg` | 230634 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_331_albedo.jpg` | 353329 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_331_normal.jpg` | 175936 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_331_rough.jpg` | 242147 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_332_albedo.jpg` | 530654 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_332_normal.jpg` | 315385 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_332_rough.jpg` | 312283 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_333_albedo.jpg` | 339525 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_333_normal.jpg` | 131072 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_333_rough.jpg` | 150363 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_334_albedo.jpg` | 272563 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_334_normal.jpg` | 125443 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_334_rough.jpg` | 148065 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_335_albedo.jpg` | 445049 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_335_normal.jpg` | 204319 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_335_rough.jpg` | 233625 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_336_albedo.jpg` | 359624 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_336_normal.jpg` | 182462 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_336_rough.jpg` | 196918 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_337_albedo.jpg` | 532774 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_337_normal.jpg` | 320633 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_337_rough.jpg` | 318593 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_338_albedo.jpg` | 368649 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_338_normal.jpg` | 162398 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_338_rough.jpg` | 183754 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_339_albedo.jpg` | 254379 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_339_normal.jpg` | 115956 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_339_rough.jpg` | 136397 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_340_albedo.jpg` | 468426 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_340_normal.jpg` | 234538 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_340_rough.jpg` | 253276 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_341_albedo.jpg` | 352889 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_341_normal.jpg` | 175130 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_341_rough.jpg` | 240515 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_342_albedo.jpg` | 485223 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_342_normal.jpg` | 262594 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_342_rough.jpg` | 270931 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_343_albedo.jpg` | 386934 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_343_normal.jpg` | 177821 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_343_rough.jpg` | 219451 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_344_albedo.jpg` | 281806 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_344_normal.jpg` | 152456 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_344_rough.jpg` | 169764 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_345_albedo.jpg` | 449711 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_345_normal.jpg` | 209586 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_345_rough.jpg` | 226668 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_346_albedo.jpg` | 354085 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_346_normal.jpg` | 176398 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_346_rough.jpg` | 242502 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_347_albedo.jpg` | 517847 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_347_normal.jpg` | 299631 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_347_rough.jpg` | 300840 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_348_albedo.jpg` | 344521 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_348_normal.jpg` | 141815 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_348_rough.jpg` | 159625 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_349_albedo.jpg` | 290455 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_349_normal.jpg` | 124469 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_349_rough.jpg` | 147429 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_350_albedo.jpg` | 479112 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_350_normal.jpg` | 253695 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_350_rough.jpg` | 280350 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_351_albedo.jpg` | 339355 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_351_normal.jpg` | 157240 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_351_rough.jpg` | 185112 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_352_albedo.jpg` | 536978 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_352_normal.jpg` | 324388 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_352_rough.jpg` | 319134 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_353_albedo.jpg` | 362425 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_353_normal.jpg` | 156343 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_353_rough.jpg` | 178790 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_354_albedo.jpg` | 252996 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_354_normal.jpg` | 114077 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_354_rough.jpg` | 135123 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_355_albedo.jpg` | 449282 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_355_normal.jpg` | 212166 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_355_rough.jpg` | 239065 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_356_albedo.jpg` | 371053 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_356_normal.jpg` | 196167 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_356_rough.jpg` | 253725 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_357_albedo.jpg` | 532733 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_357_normal.jpg` | 319616 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_357_rough.jpg` | 305494 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_358_albedo.jpg` | 376214 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_358_normal.jpg` | 169815 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_358_rough.jpg` | 195506 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_359_albedo.jpg` | 267930 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_359_normal.jpg` | 130417 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_359_rough.jpg` | 151710 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_360_albedo.jpg` | 455904 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_360_normal.jpg` | 219672 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_360_rough.jpg` | 234412 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_361_albedo.jpg` | 353030 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_361_normal.jpg` | 175635 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_361_rough.jpg` | 241114 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_362_albedo.jpg` | 510920 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_362_normal.jpg` | 291765 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_362_rough.jpg` | 295810 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_363_albedo.jpg` | 328229 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_363_normal.jpg` | 123393 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_363_rough.jpg` | 145481 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_364_albedo.jpg` | 279392 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_364_normal.jpg` | 150363 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_364_rough.jpg` | 170902 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_365_albedo.jpg` | 473560 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_365_normal.jpg` | 244917 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_365_rough.jpg` | 262278 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_366_albedo.jpg` | 338763 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_366_normal.jpg` | 155649 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_366_rough.jpg` | 179586 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_367_albedo.jpg` | 523254 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_367_normal.jpg` | 307062 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_367_rough.jpg` | 305683 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_368_albedo.jpg` | 370155 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_368_normal.jpg` | 166946 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_368_rough.jpg` | 185584 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_369_albedo.jpg` | 251674 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_369_normal.jpg` | 112526 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_369_rough.jpg` | 133963 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_370_albedo.jpg` | 444955 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_370_normal.jpg` | 204434 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_370_rough.jpg` | 233705 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_371_albedo.jpg` | 353566 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_371_normal.jpg` | 175990 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_371_rough.jpg` | 241912 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_372_albedo.jpg` | 533336 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_372_normal.jpg` | 316287 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_372_rough.jpg` | 305510 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_373_albedo.jpg` | 368789 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_373_normal.jpg` | 162447 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_373_rough.jpg` | 183861 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_374_albedo.jpg` | 267786 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_374_normal.jpg` | 128513 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_374_rough.jpg` | 150073 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_375_albedo.jpg` | 435364 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_375_normal.jpg` | 194453 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_375_rough.jpg` | 218362 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_376_albedo.jpg` | 375065 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_376_normal.jpg` | 203094 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_376_rough.jpg` | 256695 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_377_albedo.jpg` | 506451 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_377_normal.jpg` | 283519 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_377_rough.jpg` | 290474 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_378_albedo.jpg` | 370218 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_378_normal.jpg` | 158894 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_378_rough.jpg` | 172513 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_379_albedo.jpg` | 267519 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_379_normal.jpg` | 133440 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_379_rough.jpg` | 155574 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_380_albedo.jpg` | 479101 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_380_normal.jpg` | 249297 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_380_rough.jpg` | 262521 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_381_albedo.jpg` | 339562 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_381_normal.jpg` | 156511 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_381_rough.jpg` | 184115 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_382_albedo.jpg` | 517831 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_382_normal.jpg` | 299399 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_382_rough.jpg` | 300733 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_383_albedo.jpg` | 349235 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_383_normal.jpg` | 144438 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_383_rough.jpg` | 171681 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_384_albedo.jpg` | 272764 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_384_normal.jpg` | 135654 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_384_rough.jpg` | 150813 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_385_albedo.jpg` | 479105 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_385_normal.jpg` | 253691 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_385_rough.jpg` | 280631 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_386_albedo.jpg` | 354906 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_386_normal.jpg` | 177465 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_386_rough.jpg` | 243871 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_387_albedo.jpg` | 521973 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_387_normal.jpg` | 302070 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_387_rough.jpg` | 294795 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_388_albedo.jpg` | 372211 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_388_normal.jpg` | 166255 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_388_rough.jpg` | 186574 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_389_albedo.jpg` | 267964 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_389_normal.jpg` | 126541 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_389_rough.jpg` | 148762 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_390_albedo.jpg` | 426396 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_390_normal.jpg` | 187438 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_390_rough.jpg` | 212912 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_391_albedo.jpg` | 353584 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_391_normal.jpg` | 176142 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_391_rough.jpg` | 242373 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_392_albedo.jpg` | 546070 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_392_normal.jpg` | 336587 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_392_rough.jpg` | 334632 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_393_albedo.jpg` | 360413 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_393_normal.jpg` | 150146 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_393_rough.jpg` | 163915 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_394_albedo.jpg` | 267787 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_394_normal.jpg` | 130446 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_394_rough.jpg` | 151784 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_395_albedo.jpg` | 462889 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_395_normal.jpg` | 227959 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_395_rough.jpg` | 247011 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_396_albedo.jpg` | 354978 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_396_normal.jpg` | 175379 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_396_rough.jpg` | 195086 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_397_albedo.jpg` | 510983 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_397_normal.jpg` | 291592 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_397_rough.jpg` | 295788 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_398_albedo.jpg` | 349353 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_398_normal.jpg` | 140567 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_398_rough.jpg` | 169698 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_399_albedo.jpg` | 255381 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_399_normal.jpg` | 123592 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_399_rough.jpg` | 141343 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_400_albedo.jpg` | 485773 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_400_normal.jpg` | 260379 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_400_rough.jpg` | 272716 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_401_albedo.jpg` | 352850 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_401_normal.jpg` | 175413 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_401_rough.jpg` | 240842 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_402_albedo.jpg` | 515036 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_402_normal.jpg` | 292637 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_402_rough.jpg` | 289611 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_403_albedo.jpg` | 356558 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_403_normal.jpg` | 150167 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_403_rough.jpg` | 174575 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_404_albedo.jpg` | 285636 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_404_normal.jpg` | 142998 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_404_rough.jpg` | 162213 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_405_albedo.jpg` | 418432 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_405_normal.jpg` | 180555 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_405_rough.jpg` | 207795 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_406_albedo.jpg` | 353398 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_406_normal.jpg` | 175934 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_406_rough.jpg` | 241702 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_407_albedo.jpg` | 532961 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_407_normal.jpg` | 320597 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_407_rough.jpg` | 318575 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_408_albedo.jpg` | 364158 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_408_normal.jpg` | 156401 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_408_rough.jpg` | 166894 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_409_albedo.jpg` | 267814 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_409_normal.jpg` | 128675 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_409_rough.jpg` | 150158 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_410_albedo.jpg` | 457233 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_410_normal.jpg` | 220040 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_410_rough.jpg` | 242896 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_411_albedo.jpg` | 339004 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_411_normal.jpg` | 155738 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_411_rough.jpg` | 179836 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_412_albedo.jpg` | 514120 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_412_normal.jpg` | 292149 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_412_rough.jpg` | 297400 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_413_albedo.jpg` | 387232 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_413_normal.jpg` | 178000 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/proc_extra_413_rough.jpg` | 219546 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/rail_natural_albedo.jpg` | 276804 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/rail_natural_normal.jpg` | 147667 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/rail_natural_rough.jpg` | 133025 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/rail_white_scuff_albedo.jpg` | 162639 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/rail_white_scuff_normal.jpg` | 47544 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/rail_white_scuff_rough.jpg` | 64303 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/rake_deep_albedo.jpg` | 494200 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/rake_deep_normal.jpg` | 373497 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/rake_deep_rough.jpg` | 232364 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/salt_block_albedo.jpg` | 157887 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/salt_block_normal.jpg` | 29518 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/salt_block_rough.jpg` | 71597 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_hoof_albedo.jpg` | 465780 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_hoof_normal.jpg` | 304005 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_hoof_rough.jpg` | 213273 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_lip_albedo.jpg` | 380903 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/sand_lip_normal.jpg` | 167254 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/sand_lip_rough.jpg` | 130474 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_rake_albedo.jpg` | 494158 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_rake_normal.jpg` | 367919 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_rake_rough.jpg` | 230249 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_track_albedo.jpg` | 501509 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_track_normal.jpg` | 348516 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_track_rough.jpg` | 234677 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_wet_center_albedo.jpg` | 353272 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_wet_center_normal.jpg` | 126708 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_wet_center_rough.jpg` | 117791 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_worked_dry_albedo.jpg` | 465385 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/sand_worked_dry_normal.jpg` | 284153 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/sand_worked_dry_rough.jpg` | 206009 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_worked_wet_albedo.jpg` | 424432 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_worked_wet_normal.jpg` | 184923 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/sand_worked_wet_rough.jpg` | 159002 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/stall_bar_albedo.jpg` | 152588 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/stall_bar_normal.jpg` | 45765 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/stall_bar_rough.jpg` | 57029 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/straw_gold_albedo.jpg` | 511831 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/straw_gold_normal.jpg` | 275758 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/straw_gold_rough.jpg` | 212921 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/tack_trunk_albedo.jpg` | 159682 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/tack_trunk_normal.jpg` | 61156 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/tack_trunk_rough.jpg` | 63161 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/velvet_cap_albedo.jpg` | 45844 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/velvet_cap_normal.jpg` | 13920 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/velvet_cap_rough.jpg` | 7781 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/wool_melton_albedo.jpg` | 165249 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/wool_melton_normal.jpg` | 31990 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/wool_melton_rough.jpg` | 57704 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/wool_navy_coat_albedo.jpg` | 158001 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/wool_navy_coat_normal.jpg` | 33382 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/proc/wool_navy_coat_rough.jpg` | 55465 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/wool_navy_weave_albedo.jpg` | 202875 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/wool_navy_weave_normal.jpg` | 48916 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/proc/wool_navy_weave_rough.jpg` | 77976 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/harvest/raked_dirt_albedo.jpg` | 327351 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raked_dirt_dry_136_albedo.jpg` | 315289 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raked_dirt_dry_136_normal.jpg` | 522740 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raked_dirt_dry_136_rake_273_albedo.jpg` | 316925 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raked_dirt_dry_136_rake_273_dry_546_albedo.jpg` | 317126 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raked_dirt_dry_136_rake_273_dry_546_normal.jpg` | 522740 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raked_dirt_dry_136_rake_273_dry_546_rough.jpg` | 43281 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raked_dirt_dry_136_rake_273_normal.jpg` | 522740 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raked_dirt_dry_136_rake_273_rough.jpg` | 43281 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raked_dirt_dry_136_rough.jpg` | 43281 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raked_dirt_dry_136_wet_545_albedo.jpg` | 288782 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raked_dirt_dry_136_wet_545_normal.jpg` | 522740 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raked_dirt_dry_136_wet_545_rough.jpg` | 43281 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raked_dirt_late_544_albedo.jpg` | 296572 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raked_dirt_late_544_normal.jpg` | 522740 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raked_dirt_late_544_rough.jpg` | 43281 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raked_dirt_normal.jpg` | 522740 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raked_dirt_rough.jpg` | 43281 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raked_dirt_shade_272_albedo.jpg` | 177508 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raked_dirt_shade_272_normal.jpg` | 522740 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raked_dirt_shade_272_rough.jpg` | 43281 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raked_dirt_shade_272_shade_547_albedo.jpg` | 142747 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raked_dirt_shade_272_shade_547_normal.jpg` | 522740 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raked_dirt_shade_272_shade_547_rough.jpg` | 43281 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_plank_wall_albedo.jpg` | 241579 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_plank_wall_late_274_albedo.jpg` | 222972 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_plank_wall_late_274_late_549_albedo.jpg` | 213334 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_plank_wall_late_274_late_549_normal.jpg` | 240339 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_plank_wall_late_274_late_549_rough.jpg` | 130426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_plank_wall_late_274_normal.jpg` | 240339 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_plank_wall_late_274_rough.jpg` | 130426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_plank_wall_normal.jpg` | 240339 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_plank_wall_rake_548_albedo.jpg` | 235297 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_plank_wall_rake_548_normal.jpg` | 240339 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_plank_wall_rake_548_rough.jpg` | 130426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_plank_wall_rough.jpg` | 130426 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_plank_wall_shade_137_albedo.jpg` | 155047 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_plank_wall_shade_137_normal.jpg` | 240339 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_plank_wall_shade_137_rough.jpg` | 130426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_plank_wall_shade_137_wet_275_albedo.jpg` | 143143 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_plank_wall_shade_137_wet_275_dry_551_albedo.jpg` | 144975 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_plank_wall_shade_137_wet_275_dry_551_normal.jpg` | 240339 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_plank_wall_shade_137_wet_275_dry_551_rough.jpg` | 130426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_plank_wall_shade_137_wet_275_normal.jpg` | 240339 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_plank_wall_shade_137_wet_275_rough.jpg` | 130426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_plank_wall_shade_137_wet_550_albedo.jpg` | 143143 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_plank_wall_shade_137_wet_550_normal.jpg` | 240339 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_plank_wall_shade_137_wet_550_rough.jpg` | 130426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_planks_albedo.jpg` | 241579 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_planks_dry_276_albedo.jpg` | 232558 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_planks_dry_276_normal.jpg` | 240339 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_planks_dry_276_rake_553_albedo.jpg` | 235100 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_planks_dry_276_rake_553_normal.jpg` | 240339 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_planks_dry_276_rake_553_rough.jpg` | 130426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_planks_dry_276_rough.jpg` | 130426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_planks_normal.jpg` | 240339 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_planks_rake_138_albedo.jpg` | 235297 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_planks_rake_138_late_554_albedo.jpg` | 230307 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_planks_rake_138_late_554_normal.jpg` | 240339 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_planks_rake_138_late_554_rough.jpg` | 130426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_planks_rake_138_normal.jpg` | 240339 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_planks_rake_138_rough.jpg` | 130426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_planks_rake_138_shade_277_albedo.jpg` | 187920 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_planks_rake_138_shade_277_normal.jpg` | 240339 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_planks_rake_138_shade_277_rough.jpg` | 130426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_planks_rake_138_shade_277_wet_555_albedo.jpg` | 173428 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_planks_rake_138_shade_277_wet_555_normal.jpg` | 240339 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_planks_rake_138_shade_277_wet_555_rough.jpg` | 130426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_planks_rough.jpg` | 130426 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_planks_shade_552_albedo.jpg` | 155047 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/raw_planks_shade_552_normal.jpg` | 240339 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/raw_planks_shade_552_rough.jpg` | 130426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_02_albedo.jpg` | 492056 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_02_dry_556_albedo.jpg` | 473478 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_02_dry_556_normal.jpg` | 646448 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_02_dry_556_rough.jpg` | 375014 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_02_late_139_albedo.jpg` | 446129 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_02_late_139_late_279_albedo.jpg` | 432719 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_02_late_139_late_279_normal.jpg` | 646448 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_02_late_139_late_279_rake_558_albedo.jpg` | 435065 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_02_late_139_late_279_rake_558_normal.jpg` | 646448 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_02_late_139_late_279_rake_558_rough.jpg` | 375014 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_02_late_139_late_279_rough.jpg` | 375014 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_02_late_139_normal.jpg` | 646448 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_02_late_139_rough.jpg` | 375014 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_02_late_139_shade_557_albedo.jpg` | 371255 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_02_late_139_shade_557_normal.jpg` | 646448 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_02_late_139_shade_557_rough.jpg` | 375014 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_02_normal.jpg` | 646448 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_02_rake_278_albedo.jpg` | 478340 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_02_rake_278_late_559_albedo.jpg` | 465112 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_02_rake_278_late_559_normal.jpg` | 646448 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_02_rake_278_late_559_rough.jpg` | 375014 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_02_rake_278_normal.jpg` | 646448 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_02_rake_278_rough.jpg` | 375014 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_02_rough.jpg` | 375014 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_albedo.jpg` | 448810 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_normal.jpg` | 562405 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_rough.jpg` | 238409 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_wet_140_albedo.jpg` | 387696 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_wet_140_dry_281_albedo.jpg` | 387822 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_wet_140_dry_281_normal.jpg` | 562405 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_wet_140_dry_281_rough.jpg` | 238409 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_wet_140_dry_281_shade_562_albedo.jpg` | 319225 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_wet_140_dry_281_shade_562_normal.jpg` | 562405 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_wet_140_dry_281_shade_562_rough.jpg` | 238409 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_wet_140_dry_561_albedo.jpg` | 387822 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_wet_140_dry_561_normal.jpg` | 562405 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_wet_140_dry_561_rough.jpg` | 238409 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_wet_140_normal.jpg` | 562405 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_wet_140_rough.jpg` | 238409 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_wet_280_albedo.jpg` | 387696 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_wet_280_normal.jpg` | 562405 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_wet_280_rake_563_albedo.jpg` | 389857 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_wet_280_rake_563_normal.jpg` | 562405 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_wet_280_rake_563_rough.jpg` | 238409 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_wet_280_rough.jpg` | 238409 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_wet_560_albedo.jpg` | 387696 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rock_path_wet_560_normal.jpg` | 562405 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rock_path_wet_560_rough.jpg` | 238409 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_03_albedo.jpg` | 299307 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_03_dry_141_albedo.jpg` | 288239 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_03_dry_141_normal.jpg` | 147070 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_03_dry_141_rake_283_albedo.jpg` | 290190 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_03_dry_141_rake_283_dry_566_albedo.jpg` | 290690 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_03_dry_141_rake_283_dry_566_normal.jpg` | 147070 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_03_dry_141_rake_283_dry_566_rough.jpg` | 144715 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_03_dry_141_rake_283_normal.jpg` | 147070 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_03_dry_141_rake_283_rough.jpg` | 144715 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_03_dry_141_rough.jpg` | 144715 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_03_dry_141_wet_565_albedo.jpg` | 265388 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_03_dry_141_wet_565_normal.jpg` | 147070 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_03_dry_141_wet_565_rough.jpg` | 144715 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_03_late_564_albedo.jpg` | 273994 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_03_late_564_normal.jpg` | 147070 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_03_late_564_rough.jpg` | 144715 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_03_normal.jpg` | 147070 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_03_rough.jpg` | 144715 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_03_shade_282_albedo.jpg` | 188431 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_03_shade_282_normal.jpg` | 147070 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_03_shade_282_rough.jpg` | 144715 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_03_shade_282_shade_567_albedo.jpg` | 147000 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_03_shade_282_shade_567_normal.jpg` | 147070 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_03_shade_282_shade_567_rough.jpg` | 144715 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_04_albedo.jpg` | 401291 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_04_late_284_albedo.jpg` | 360750 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_04_late_284_late_569_albedo.jpg` | 354353 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_04_late_284_late_569_normal.jpg` | 319595 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_04_late_284_late_569_rough.jpg` | 329810 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_04_late_284_normal.jpg` | 319595 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_04_late_284_rough.jpg` | 329810 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_04_normal.jpg` | 319595 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_04_rake_568_albedo.jpg` | 384187 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_04_rake_568_normal.jpg` | 319595 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_04_rake_568_rough.jpg` | 329810 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_04_rough.jpg` | 329810 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_04_shade_142_albedo.jpg` | 243600 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_04_shade_142_normal.jpg` | 319595 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_04_shade_142_rough.jpg` | 329810 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_04_shade_142_wet_285_albedo.jpg` | 224106 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_04_shade_142_wet_285_dry_571_albedo.jpg` | 225012 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_04_shade_142_wet_285_dry_571_normal.jpg` | 319595 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_04_shade_142_wet_285_dry_571_rough.jpg` | 329810 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_04_shade_142_wet_285_normal.jpg` | 319595 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_04_shade_142_wet_285_rough.jpg` | 329810 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_04_shade_142_wet_570_albedo.jpg` | 224106 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_04_shade_142_wet_570_normal.jpg` | 319595 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_04_shade_142_wet_570_rough.jpg` | 329810 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_albedo.jpg` | 366675 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_dry_286_albedo.jpg` | 352504 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_dry_286_normal.jpg` | 225667 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_dry_286_rake_573_albedo.jpg` | 355423 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_dry_286_rake_573_normal.jpg` | 225667 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_dry_286_rake_573_rough.jpg` | 182870 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_dry_286_rough.jpg` | 182870 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_normal.jpg` | 225667 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_rake_143_albedo.jpg` | 355672 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_rake_143_late_574_albedo.jpg` | 342167 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_rake_143_late_574_normal.jpg` | 225667 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_rake_143_late_574_rough.jpg` | 182870 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_rake_143_normal.jpg` | 225667 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_rake_143_rough.jpg` | 182870 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_rake_143_shade_287_albedo.jpg` | 285600 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_rake_143_shade_287_normal.jpg` | 225667 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_rake_143_shade_287_rough.jpg` | 182870 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_rake_143_shade_287_wet_575_albedo.jpg` | 262863 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_rake_143_shade_287_wet_575_normal.jpg` | 225667 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_rake_143_shade_287_wet_575_rough.jpg` | 182870 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_rough.jpg` | 182870 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_shade_572_albedo.jpg` | 198100 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/rusty_metal_shade_572_normal.jpg` | 225667 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/rusty_metal_shade_572_rough.jpg` | 182870 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_01_albedo.jpg` | 379382 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_01_dry_576_albedo.jpg` | 361150 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_01_dry_576_normal.jpg` | 427871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_01_dry_576_rough.jpg` | 153349 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_01_late_144_albedo.jpg` | 338779 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_01_late_144_late_289_albedo.jpg` | 294131 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_01_late_144_late_289_normal.jpg` | 427871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_01_late_144_late_289_rake_578_albedo.jpg` | 296107 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_01_late_144_late_289_rake_578_normal.jpg` | 427871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_01_late_144_late_289_rake_578_rough.jpg` | 153349 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_01_late_144_late_289_rough.jpg` | 153349 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_01_late_144_normal.jpg` | 427871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_01_late_144_rough.jpg` | 153349 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_01_late_144_shade_577_albedo.jpg` | 280516 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_01_late_144_shade_577_normal.jpg` | 427871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_01_late_144_shade_577_rough.jpg` | 153349 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_01_normal.jpg` | 427871 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_01_rake_288_albedo.jpg` | 364785 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_01_rake_288_late_579_albedo.jpg` | 353604 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_01_rake_288_late_579_normal.jpg` | 427871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_01_rake_288_late_579_rough.jpg` | 153349 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_01_rake_288_normal.jpg` | 427871 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_01_rake_288_rough.jpg` | 153349 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_01_rough.jpg` | 153349 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_02_albedo.jpg` | 497056 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_02_normal.jpg` | 458166 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_02_rough.jpg` | 88048 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_02_wet_145_albedo.jpg` | 420809 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_02_wet_145_dry_291_albedo.jpg` | 421094 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_02_wet_145_dry_291_normal.jpg` | 458166 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_02_wet_145_dry_291_rough.jpg` | 88048 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_02_wet_145_dry_291_shade_582_albedo.jpg` | 340894 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_02_wet_145_dry_291_shade_582_normal.jpg` | 458166 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_02_wet_145_dry_291_shade_582_rough.jpg` | 88048 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_02_wet_145_dry_581_albedo.jpg` | 421094 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_02_wet_145_dry_581_normal.jpg` | 458166 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_02_wet_145_dry_581_rough.jpg` | 88048 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_02_wet_145_normal.jpg` | 458166 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_02_wet_145_rough.jpg` | 88048 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_02_wet_290_albedo.jpg` | 420809 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_02_wet_290_normal.jpg` | 458166 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_02_wet_290_rake_583_albedo.jpg` | 423262 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_02_wet_290_rake_583_normal.jpg` | 458166 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_02_wet_290_rake_583_rough.jpg` | 88048 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_02_wet_290_rough.jpg` | 88048 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_02_wet_580_albedo.jpg` | 420809 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sand_02_wet_580_normal.jpg` | 458166 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sand_02_wet_580_rough.jpg` | 88048 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sandy_gravel_albedo.jpg` | 393920 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sandy_gravel_dry_146_albedo.jpg` | 341235 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sandy_gravel_dry_146_normal.jpg` | 473706 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sandy_gravel_dry_146_rake_293_albedo.jpg` | 340215 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sandy_gravel_dry_146_rake_293_dry_586_albedo.jpg` | 302578 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sandy_gravel_dry_146_rake_293_dry_586_normal.jpg` | 473706 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sandy_gravel_dry_146_rake_293_dry_586_rough.jpg` | 102814 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sandy_gravel_dry_146_rake_293_normal.jpg` | 473706 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sandy_gravel_dry_146_rake_293_rough.jpg` | 102814 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sandy_gravel_dry_146_rough.jpg` | 102814 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sandy_gravel_dry_146_wet_585_albedo.jpg` | 307428 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sandy_gravel_dry_146_wet_585_normal.jpg` | 473706 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sandy_gravel_dry_146_wet_585_rough.jpg` | 102814 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sandy_gravel_late_584_albedo.jpg` | 251879 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sandy_gravel_late_584_normal.jpg` | 473706 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sandy_gravel_late_584_rough.jpg` | 102814 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sandy_gravel_normal.jpg` | 473706 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sandy_gravel_rough.jpg` | 102814 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sandy_gravel_shade_292_albedo.jpg` | 207460 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sandy_gravel_shade_292_normal.jpg` | 473706 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sandy_gravel_shade_292_rough.jpg` | 102814 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sandy_gravel_shade_292_shade_587_albedo.jpg` | 154993 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sandy_gravel_shade_292_shade_587_normal.jpg` | 473706 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sandy_gravel_shade_292_shade_587_rough.jpg` | 102814 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sparse_grass_albedo.jpg` | 478272 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sparse_grass_late_294_albedo.jpg` | 392337 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sparse_grass_late_294_late_589_albedo.jpg` | 374939 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sparse_grass_late_294_late_589_normal.jpg` | 646859 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sparse_grass_late_294_late_589_rough.jpg` | 169798 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sparse_grass_late_294_normal.jpg` | 646859 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sparse_grass_late_294_rough.jpg` | 169798 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sparse_grass_normal.jpg` | 646859 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sparse_grass_rake_588_albedo.jpg` | 437300 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sparse_grass_rake_588_normal.jpg` | 646859 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sparse_grass_rake_588_rough.jpg` | 169798 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sparse_grass_rough.jpg` | 169798 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sparse_grass_shade_147_albedo.jpg` | 260643 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sparse_grass_shade_147_normal.jpg` | 646859 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sparse_grass_shade_147_rough.jpg` | 169798 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sparse_grass_shade_147_wet_295_albedo.jpg` | 237134 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sparse_grass_shade_147_wet_295_dry_591_albedo.jpg` | 235470 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sparse_grass_shade_147_wet_295_dry_591_normal.jpg` | 646859 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sparse_grass_shade_147_wet_295_dry_591_rough.jpg` | 169798 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sparse_grass_shade_147_wet_295_normal.jpg` | 646859 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sparse_grass_shade_147_wet_295_rough.jpg` | 169798 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sparse_grass_shade_147_wet_590_albedo.jpg` | 237134 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/sparse_grass_shade_147_wet_590_normal.jpg` | 646859 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/sparse_grass_shade_147_wet_590_rough.jpg` | 169798 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/stony_dirt_path_albedo.jpg` | 657232 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/stony_dirt_path_dry_296_albedo.jpg` | 601400 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/stony_dirt_path_dry_296_normal.jpg` | 635399 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/stony_dirt_path_dry_296_rake_593_albedo.jpg` | 600455 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/stony_dirt_path_dry_296_rake_593_normal.jpg` | 635399 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/stony_dirt_path_dry_296_rake_593_rough.jpg` | 148932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/stony_dirt_path_dry_296_rough.jpg` | 148932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/stony_dirt_path_normal.jpg` | 635399 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/stony_dirt_path_rake_148_albedo.jpg` | 608233 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/stony_dirt_path_rake_148_late_594_albedo.jpg` | 592241 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/stony_dirt_path_rake_148_late_594_normal.jpg` | 635399 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/stony_dirt_path_rake_148_late_594_rough.jpg` | 148932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/stony_dirt_path_rake_148_normal.jpg` | 635399 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/stony_dirt_path_rake_148_rough.jpg` | 148932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/stony_dirt_path_rake_148_shade_297_albedo.jpg` | 503072 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/stony_dirt_path_rake_148_shade_297_normal.jpg` | 635399 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/stony_dirt_path_rake_148_shade_297_rough.jpg` | 148932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/stony_dirt_path_rake_148_shade_297_wet_595_albedo.jpg` | 449438 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/stony_dirt_path_rake_148_shade_297_wet_595_normal.jpg` | 635399 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/stony_dirt_path_rake_148_shade_297_wet_595_rough.jpg` | 148932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/stony_dirt_path_rough.jpg` | 148932 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/stony_dirt_path_shade_592_albedo.jpg` | 418872 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/stony_dirt_path_shade_592_normal.jpg` | 635399 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/stony_dirt_path_shade_592_rough.jpg` | 148932 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/weathered_planks_albedo.jpg` | 208200 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/weathered_planks_dry_596_albedo.jpg` | 201464 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/weathered_planks_dry_596_normal.jpg` | 202089 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/weathered_planks_dry_596_rough.jpg` | 53232 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/weathered_planks_late_149_albedo.jpg` | 192715 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/weathered_planks_late_149_late_299_albedo.jpg` | 188469 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/weathered_planks_late_149_late_299_normal.jpg` | 202089 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/weathered_planks_late_149_late_299_rake_598_albedo.jpg` | 190137 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/weathered_planks_late_149_late_299_rake_598_normal.jpg` | 202089 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/weathered_planks_late_149_late_299_rake_598_rough.jpg` | 53232 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/weathered_planks_late_149_late_299_rough.jpg` | 53232 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/weathered_planks_late_149_normal.jpg` | 202089 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/weathered_planks_late_149_rough.jpg` | 53232 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/weathered_planks_late_149_shade_597_albedo.jpg` | 148957 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/weathered_planks_late_149_shade_597_normal.jpg` | 202089 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/weathered_planks_late_149_shade_597_rough.jpg` | 53232 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/weathered_planks_normal.jpg` | 202089 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/weathered_planks_rake_298_albedo.jpg` | 203679 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/weathered_planks_rake_298_late_599_albedo.jpg` | 199131 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/weathered_planks_rake_298_late_599_normal.jpg` | 202089 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/weathered_planks_rake_298_late_599_rough.jpg` | 53232 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/weathered_planks_rake_298_normal.jpg` | 202089 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/weathered_planks_rake_298_rough.jpg` | 53232 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/weathered_planks_rough.jpg` | 53232 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/white_planks_clean_albedo.jpg` | 146132 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/white_planks_clean_normal.jpg` | 120373 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/white_planks_clean_rough.jpg` | 149423 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/white_planks_clean_wet_150_albedo.jpg` | 125734 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/white_planks_clean_wet_150_dry_301_albedo.jpg` | 127443 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/white_planks_clean_wet_150_dry_301_normal.jpg` | 120373 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/white_planks_clean_wet_150_dry_301_rough.jpg` | 149423 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/white_planks_clean_wet_150_dry_301_shade_602_albedo.jpg` | 98559 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/white_planks_clean_wet_150_dry_301_shade_602_normal.jpg` | 120373 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/white_planks_clean_wet_150_dry_301_shade_602_rough.jpg` | 149423 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/white_planks_clean_wet_150_dry_601_albedo.jpg` | 127443 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/white_planks_clean_wet_150_dry_601_normal.jpg` | 120373 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/white_planks_clean_wet_150_dry_601_rough.jpg` | 149423 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/white_planks_clean_wet_150_normal.jpg` | 120373 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/white_planks_clean_wet_150_rough.jpg` | 149423 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/white_planks_clean_wet_300_albedo.jpg` | 125734 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/white_planks_clean_wet_300_normal.jpg` | 120373 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/white_planks_clean_wet_300_rake_603_albedo.jpg` | 130998 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/white_planks_clean_wet_300_rake_603_normal.jpg` | 120373 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/white_planks_clean_wet_300_rake_603_rough.jpg` | 149423 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/white_planks_clean_wet_300_rough.jpg` | 149423 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/white_planks_clean_wet_600_albedo.jpg` | 125734 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/white_planks_clean_wet_600_normal.jpg` | 120373 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/white_planks_clean_wet_600_rough.jpg` | 149423 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/withered_grass_albedo.jpg` | 601976 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/withered_grass_dry_151_albedo.jpg` | 552218 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/withered_grass_dry_151_normal.jpg` | 658646 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/withered_grass_dry_151_rake_303_albedo.jpg` | 553341 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/withered_grass_dry_151_rake_303_dry_606_albedo.jpg` | 538890 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/withered_grass_dry_151_rake_303_dry_606_normal.jpg` | 658646 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/withered_grass_dry_151_rake_303_dry_606_rough.jpg` | 429553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/withered_grass_dry_151_rake_303_normal.jpg` | 658646 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/withered_grass_dry_151_rake_303_rough.jpg` | 429553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/withered_grass_dry_151_rough.jpg` | 429553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/withered_grass_dry_151_wet_605_albedo.jpg` | 490130 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/withered_grass_dry_151_wet_605_normal.jpg` | 658646 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/withered_grass_dry_151_wet_605_rough.jpg` | 429553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/withered_grass_late_604_albedo.jpg` | 515499 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/withered_grass_late_604_normal.jpg` | 658646 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/withered_grass_late_604_rough.jpg` | 429553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/withered_grass_normal.jpg` | 658646 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/withered_grass_rough.jpg` | 429553 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/withered_grass_shade_302_albedo.jpg` | 398676 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/withered_grass_shade_302_normal.jpg` | 658646 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/withered_grass_shade_302_rough.jpg` | 429553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/withered_grass_shade_302_shade_607_albedo.jpg` | 332263 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/withered_grass_shade_302_shade_607_normal.jpg` | 658646 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/withered_grass_shade_302_shade_607_rough.jpg` | 429553 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_chips_albedo.jpg` | 523583 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_chips_late_304_albedo.jpg` | 476324 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_chips_late_304_late_609_albedo.jpg` | 463440 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_chips_late_304_late_609_normal.jpg` | 682789 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_chips_late_304_late_609_rough.jpg` | 100040 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_chips_late_304_normal.jpg` | 682789 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_chips_late_304_rough.jpg` | 100040 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_chips_normal.jpg` | 682789 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_chips_rake_608_albedo.jpg` | 509481 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_chips_rake_608_normal.jpg` | 682789 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_chips_rake_608_rough.jpg` | 100040 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_chips_rough.jpg` | 100040 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_chips_shade_152_albedo.jpg` | 315653 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_chips_shade_152_normal.jpg` | 682789 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_chips_shade_152_rough.jpg` | 100040 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_chips_shade_152_wet_305_albedo.jpg` | 290131 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_chips_shade_152_wet_305_dry_611_albedo.jpg` | 290180 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_chips_shade_152_wet_305_dry_611_normal.jpg` | 682789 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_chips_shade_152_wet_305_dry_611_rough.jpg` | 100040 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_chips_shade_152_wet_305_normal.jpg` | 682789 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_chips_shade_152_wet_305_rough.jpg` | 100040 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_chips_shade_152_wet_610_albedo.jpg` | 290131 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_chips_shade_152_wet_610_normal.jpg` | 682789 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_chips_shade_152_wet_610_rough.jpg` | 100040 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_floor_deck_albedo.jpg` | 366384 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_floor_deck_dry_306_albedo.jpg` | 351917 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_floor_deck_dry_306_normal.jpg` | 195975 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_floor_deck_dry_306_rake_613_albedo.jpg` | 353696 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_floor_deck_dry_306_rake_613_normal.jpg` | 195975 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_floor_deck_dry_306_rake_613_rough.jpg` | 304838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_floor_deck_dry_306_rough.jpg` | 304838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_floor_deck_normal.jpg` | 195975 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_floor_deck_rake_153_albedo.jpg` | 353693 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_floor_deck_rake_153_late_614_albedo.jpg` | 341706 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_floor_deck_rake_153_late_614_normal.jpg` | 195975 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_floor_deck_rake_153_late_614_rough.jpg` | 304838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_floor_deck_rake_153_normal.jpg` | 195975 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_floor_deck_rake_153_rough.jpg` | 304838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_floor_deck_rake_153_shade_307_albedo.jpg` | 276739 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_floor_deck_rake_153_shade_307_normal.jpg` | 195975 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_floor_deck_rake_153_shade_307_rough.jpg` | 304838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_floor_deck_rake_153_shade_307_wet_615_albedo.jpg` | 252204 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_floor_deck_rake_153_shade_307_wet_615_normal.jpg` | 195975 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_floor_deck_rake_153_shade_307_wet_615_rough.jpg` | 304838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_floor_deck_rough.jpg` | 304838 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_floor_deck_shade_612_albedo.jpg` | 211692 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_floor_deck_shade_612_normal.jpg` | 195975 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_floor_deck_shade_612_rough.jpg` | 304838 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_planks_albedo.jpg` | 212821 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_planks_dry_616_albedo.jpg` | 204663 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_planks_dry_616_normal.jpg` | 187411 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_planks_dry_616_rough.jpg` | 95209 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_planks_late_154_albedo.jpg` | 193989 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_planks_late_154_late_309_albedo.jpg` | 189489 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_planks_late_154_late_309_normal.jpg` | 187411 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_planks_late_154_late_309_rake_618_albedo.jpg` | 191005 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_planks_late_154_late_309_rake_618_normal.jpg` | 187411 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_planks_late_154_late_309_rake_618_rough.jpg` | 95209 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_planks_late_154_late_309_rough.jpg` | 95209 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_planks_late_154_normal.jpg` | 187411 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_planks_late_154_rough.jpg` | 95209 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_planks_late_154_shade_617_albedo.jpg` | 153158 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_planks_late_154_shade_617_normal.jpg` | 187411 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_planks_late_154_shade_617_rough.jpg` | 95209 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_planks_normal.jpg` | 187411 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_planks_rake_308_albedo.jpg` | 206554 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_planks_rake_308_late_619_albedo.jpg` | 200279 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_planks_rake_308_late_619_normal.jpg` | 187411 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_planks_rake_308_late_619_rough.jpg` | 95209 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_planks_rake_308_normal.jpg` | 187411 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_planks_rake_308_rough.jpg` | 95209 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_planks_rough.jpg` | 95209 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_table_albedo.jpg` | 416655 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_table_normal.jpg` | 188517 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_table_rough.jpg` | 278561 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_table_wet_155_albedo.jpg` | 361621 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_table_wet_155_dry_311_albedo.jpg` | 362349 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_table_wet_155_dry_311_normal.jpg` | 188517 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_table_wet_155_dry_311_rough.jpg` | 278561 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_table_wet_155_dry_311_shade_622_albedo.jpg` | 294446 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_table_wet_155_dry_311_shade_622_normal.jpg` | 188517 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_table_wet_155_dry_311_shade_622_rough.jpg` | 278561 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_table_wet_155_dry_621_albedo.jpg` | 362349 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_table_wet_155_dry_621_normal.jpg` | 188517 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_table_wet_155_dry_621_rough.jpg` | 278561 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_table_wet_155_normal.jpg` | 188517 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_table_wet_155_rough.jpg` | 278561 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_table_wet_310_albedo.jpg` | 361621 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_table_wet_310_normal.jpg` | 188517 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_table_wet_310_rake_623_albedo.jpg` | 364235 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_table_wet_310_rake_623_normal.jpg` | 188517 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_table_wet_310_rake_623_rough.jpg` | 278561 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_table_wet_310_rough.jpg` | 278561 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_table_wet_620_albedo.jpg` | 361621 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wood_table_wet_620_normal.jpg` | 188517 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wood_table_wet_620_rough.jpg` | 278561 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wooden_gate_albedo.jpg` | 225245 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wooden_gate_dry_156_albedo.jpg` | 217195 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wooden_gate_dry_156_normal.jpg` | 174026 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wooden_gate_dry_156_rake_313_albedo.jpg` | 218683 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wooden_gate_dry_156_rake_313_dry_626_albedo.jpg` | 219064 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wooden_gate_dry_156_rake_313_dry_626_normal.jpg` | 174026 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wooden_gate_dry_156_rake_313_dry_626_rough.jpg` | 316946 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wooden_gate_dry_156_rake_313_normal.jpg` | 174026 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wooden_gate_dry_156_rake_313_rough.jpg` | 316946 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wooden_gate_dry_156_rough.jpg` | 316946 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wooden_gate_dry_156_wet_625_albedo.jpg` | 198132 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wooden_gate_dry_156_wet_625_normal.jpg` | 174026 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wooden_gate_dry_156_wet_625_rough.jpg` | 316946 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wooden_gate_late_624_albedo.jpg` | 204769 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wooden_gate_late_624_normal.jpg` | 174026 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wooden_gate_late_624_rough.jpg` | 316946 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wooden_gate_normal.jpg` | 174026 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wooden_gate_rough.jpg` | 316946 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wooden_gate_shade_312_albedo.jpg` | 135983 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wooden_gate_shade_312_normal.jpg` | 174026 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wooden_gate_shade_312_rough.jpg` | 316946 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wooden_gate_shade_312_shade_627_albedo.jpg` | 104825 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wooden_gate_shade_312_shade_627_normal.jpg` | 174026 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wooden_gate_shade_312_shade_627_rough.jpg` | 316946 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wool_boucle_albedo.jpg` | 478664 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wool_boucle_late_314_albedo.jpg` | 454740 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wool_boucle_late_314_late_629_albedo.jpg` | 445070 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wool_boucle_late_314_late_629_normal.jpg` | 398426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wool_boucle_late_314_late_629_rough.jpg` | 559507 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wool_boucle_late_314_normal.jpg` | 398426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wool_boucle_late_314_rough.jpg` | 559507 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wool_boucle_normal.jpg` | 398426 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wool_boucle_rake_628_albedo.jpg` | 474314 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wool_boucle_rake_628_normal.jpg` | 398426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wool_boucle_rake_628_rough.jpg` | 559507 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wool_boucle_rough.jpg` | 559507 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wool_boucle_shade_157_albedo.jpg` | 307734 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wool_boucle_shade_157_normal.jpg` | 398426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wool_boucle_shade_157_rough.jpg` | 559507 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wool_boucle_shade_157_wet_315_albedo.jpg` | 284457 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wool_boucle_shade_157_wet_315_dry_631_albedo.jpg` | 287376 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wool_boucle_shade_157_wet_315_dry_631_normal.jpg` | 398426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wool_boucle_shade_157_wet_315_dry_631_rough.jpg` | 559507 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wool_boucle_shade_157_wet_315_normal.jpg` | 398426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wool_boucle_shade_157_wet_315_rough.jpg` | 559507 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wool_boucle_shade_157_wet_630_albedo.jpg` | 284457 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/wool_boucle_shade_157_wet_630_normal.jpg` | 398426 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/wool_boucle_shade_157_wet_630_rough.jpg` | 559507 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_02_albedo.jpg` | 187471 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_02_dry_316_albedo.jpg` | 180016 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_02_dry_316_normal.jpg` | 227310 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_02_dry_316_rake_633_albedo.jpg` | 182009 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_02_dry_316_rake_633_normal.jpg` | 227310 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_02_dry_316_rake_633_rough.jpg` | 75255 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_02_dry_316_rough.jpg` | 75255 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_02_normal.jpg` | 227310 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_02_rake_158_albedo.jpg` | 181327 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_02_rake_158_late_634_albedo.jpg` | 175618 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_02_rake_158_late_634_normal.jpg` | 227310 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_02_rake_158_late_634_rough.jpg` | 75255 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_02_rake_158_normal.jpg` | 227310 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_02_rake_158_rough.jpg` | 75255 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_02_rake_158_shade_317_albedo.jpg` | 143936 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_02_rake_158_shade_317_normal.jpg` | 227310 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_02_rake_158_shade_317_rough.jpg` | 75255 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_02_rake_158_shade_317_wet_635_albedo.jpg` | 133979 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_02_rake_158_shade_317_wet_635_normal.jpg` | 227310 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_02_rake_158_shade_317_wet_635_rough.jpg` | 75255 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_02_rough.jpg` | 75255 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_02_shade_632_albedo.jpg` | 122490 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_02_shade_632_normal.jpg` | 227310 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_02_shade_632_rough.jpg` | 75255 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_albedo.jpg` | 400397 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_dry_636_albedo.jpg` | 386422 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_dry_636_normal.jpg` | 95510 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_dry_636_rough.jpg` | 420546 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_late_159_albedo.jpg` | 367499 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_late_159_late_319_albedo.jpg` | 357819 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_late_159_late_319_normal.jpg` | 95510 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_late_159_late_319_rake_638_albedo.jpg` | 359787 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_late_159_late_319_rake_638_normal.jpg` | 95510 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_late_159_late_319_rake_638_rough.jpg` | 420546 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_late_159_late_319_rough.jpg` | 420546 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_late_159_normal.jpg` | 95510 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_late_159_rough.jpg` | 420546 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_late_159_shade_637_albedo.jpg` | 301998 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_late_159_shade_637_normal.jpg` | 95510 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_late_159_shade_637_rough.jpg` | 420546 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_normal.jpg` | 95510 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_rake_318_albedo.jpg` | 390276 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_rake_318_late_639_albedo.jpg` | 380873 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/harvest/worn_planks_rake_318_late_639_normal.jpg` | 95510 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_rake_318_late_639_rough.jpg` | 420546 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_rake_318_normal.jpg` | 95510 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_rake_318_rough.jpg` | 420546 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/harvest/worn_planks_rough.jpg` | 420546 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/leather_albedo.jpg` | 360119 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/leather_normal.jpg` | 162582 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/leather_rough.jpg` | 71920 | no | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 | unreferenced |
| `assets/textures/mane_albedo.jpg` | 419214 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/mane_normal.jpg` | 271268 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/mane_rough.jpg` | 115939 | no | no | 1024 x 1024 | unreferenced, no credit |
| `assets/textures/pole_navy_albedo.jpg` | 10169 | yes | no | 1024 x 128 | no credit |
| `assets/textures/pole_red_albedo.jpg` | 10056 | yes | no | 1024 x 128 | no credit |
| `assets/textures/pole_ref.jpg` | 167847 | no | no | 1280 x 720 | unreferenced, no credit |
| `assets/textures/pole_white_albedo.jpg` | 11048 | yes | no | 1024 x 128 | no credit |
| `assets/textures/pole_white_normal.jpg` | 2052 | yes | no | 1024 x 128 | no credit |
| `assets/textures/rider_back.jpg` | 121504 | yes | no | 864 x 1152 | no credit |
| `assets/textures/rider_face_front.jpg` | 142639 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/rider_face_side.jpg` | 107860 | yes | no | 1024 x 1024 | no credit |
| `assets/textures/rider_front.jpg` | 115386 | yes | no | 864 x 1152 | no credit |
| `assets/textures/rider_side.jpg` | 108827 | yes | no | 864 x 1152 | no credit |
| `assets/textures/saddle_ref.jpg` | 166368 | no | no | 1280 x 720 | unreferenced, no credit |
| `assets/textures/sand_albedo.jpg` | 388622 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/sand_normal.jpg` | 177723 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/sand_rough.jpg` | 79432 | no | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 | unreferenced |
| `assets/textures/sky.jpg` | 141521 | yes | no | 1280 x 720 | no credit |
| `assets/textures/standard_ref.jpg` | 219307 | no | no | 864 x 1152 | unreferenced, no credit |
| `assets/textures/wood_albedo.jpg` | 305094 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/wood_normal.jpg` | 161726 | yes | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 |  |
| `assets/textures/wood_rough.jpg` | 92699 | no | game/assets/ATTRIBUTION_HARVEST.md | 1024 x 1024 | unreferenced |
| `assets/ui/abbott_theme.tres` | 1295 | yes | no |  | no credit |
| `assets/ui/icon.png` | 357353 | yes | no | 512 x 512 | no credit |
| `assets/ui/icon_256.png` | 96650 | no | no | 256 x 256 | unreferenced, no credit |
| `assets/ui/panel.jpg` | 154868 | no | no | 1280 x 720 | unreferenced, no credit |
| `assets/ui/panel_blank.jpg` | 11927 | no | no | 1024 x 512 | unreferenced, no credit |
