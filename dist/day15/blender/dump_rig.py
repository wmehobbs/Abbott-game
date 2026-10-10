import bpy, sys
argv = sys.argv[sys.argv.index("--")+1:]
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.gltf(filepath=argv[0])
for o in bpy.context.scene.objects:
    if o.type == 'ARMATURE':
        mw = o.matrix_world
        print("ARM", o.name, "scale", tuple(round(s,3) for s in mw.to_scale()))
        for b in o.data.bones:
            h = mw @ b.head_local; t = mw @ b.tail_local
            print("BONE", b.name, "parent=", b.parent.name if b.parent else None, "head", tuple(round(x,3) for x in h), "tail", tuple(round(x,3) for x in t))
    if o.type == 'MESH':
        print("MESH", o.name, "dims", tuple(round(x,3) for x in o.dimensions), "verts", len(o.data.vertices))
