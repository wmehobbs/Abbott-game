import bpy, sys, mathutils
argv = sys.argv[sys.argv.index("--")+1:]
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.gltf(filepath=argv[0])
for o in bpy.context.scene.objects:
    mw = o.matrix_world
    loc, rot, scl = mw.decompose()
    print("OBJ", o.name, o.type, "parent=", o.parent.name if o.parent else None,
          "loc=", tuple(round(x,3) for x in loc), "scale=", tuple(round(x,3) for x in scl),
          "rotdeg=", tuple(round(x,1) for x in [a*57.2958 for a in rot.to_euler()]),
          "dims=", tuple(round(x,3) for x in o.dimensions))
    if o.type == 'MESH':
        vs=[mw @ v.co for v in o.data.vertices]
        mn=mathutils.Vector((min(v.x for v in vs),min(v.y for v in vs),min(v.z for v in vs)))
        mx=mathutils.Vector((max(v.x for v in vs),max(v.y for v in vs),max(v.z for v in vs)))
        print("   world bbox", tuple(round(x,3) for x in mn), tuple(round(x,3) for x in mx), "verts", len(vs),
              "mods", [m.type for m in o.modifiers], "vgroups", len(o.vertex_groups))
    if o.type == 'ARMATURE':
        for bn in ["Body","Torso","Head","Tail1","FrontLowerLeg.L","BackLowerLeg.L"]:
            b=o.data.bones.get(bn)
            if b: print("   bone", bn, "world head", tuple(round(x,3) for x in (mw @ b.head_local)))
