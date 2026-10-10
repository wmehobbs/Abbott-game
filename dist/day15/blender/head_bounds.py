import bpy, sys
argv = sys.argv[sys.argv.index("--")+1:]
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.gltf(filepath=argv[0])
for o in bpy.context.scene.objects:
    if o.type == 'MESH' and o.name in ("Cube001", "Cube001_3", "Cube037", "Cube037_1"):
        vs = [o.matrix_world @ v.co for v in o.data.vertices]
        mn = [min(v[i] for v in vs) for i in range(3)]; mx = [max(v[i] for v in vs) for i in range(3)]
        # skeleton space (glTF): x, z, -y
        print("BOUNDS", o.name, "skel min", (round(mn[0],3), round(mn[2],3), round(-mx[1],3)), "max", (round(mx[0],3), round(mx[2],3), round(-mn[1],3)))
