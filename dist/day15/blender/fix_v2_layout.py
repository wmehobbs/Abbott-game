"""Re-export abbott_v2 with the original Quaternius layout: the skinned meshes
are siblings of AnimalArmature (not its children), each carrying the armature's
world transform. Godot reads a child mesh's world-space vertices through the
armature's 100x scale and -90 X turn, which made the horse a 200 m giant lying
on its side. Same vertices, same skin, same actions. New file only."""
import sys
import bpy

argv = sys.argv[sys.argv.index("--") + 1:]
src, dst = argv[0], argv[1]
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.gltf(filepath=src)
arm = [o for o in bpy.context.scene.objects if o.type == "ARMATURE"][0]
root = arm.parent
meshes = [o for o in bpy.context.scene.objects if o.type == "MESH" and o.parent == arm]
for m in meshes:
    mw = m.matrix_world.copy()
    m.parent = root
    m.matrix_world = mw
    mods = [md for md in m.modifiers if md.type == "ARMATURE"]
    assert mods and mods[0].object == arm, "armature modifier lost on " + m.name
    print("UNPARENT", m.name, "parent now", m.parent.name if m.parent else None, "scale", tuple(round(s, 3) for s in m.matrix_world.to_scale()))
# Drop the importer's stray display sphere.
for o in list(bpy.context.scene.objects):
    if o.type == "MESH" and o.name.startswith("Icosphere"):
        bpy.data.objects.remove(o, do_unlink=True)
for o in bpy.context.scene.objects:
    o.select_set(True)
print("ACTIONS", sorted(a.name for a in bpy.data.actions))
bpy.ops.export_scene.gltf(
    filepath=dst,
    export_format="GLB",
    use_selection=True,
    export_yup=True,
    export_apply=False,
    export_animations=True,
    export_animation_mode="ACTIONS",
    export_skins=True,
    export_morph=False,
    export_lights=False,
    export_cameras=False,
)
print("EXPORTED", dst)
