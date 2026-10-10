import bpy, sys, mathutils
argv = sys.argv[sys.argv.index("--")+1:]
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.gltf(filepath=argv[0])
sc = bpy.context.scene
for o in list(sc.objects):
    if o.type == 'MESH' and o.name.startswith('Icosphere'):
        bpy.data.objects.remove(o, do_unlink=True)
br = [o for o in sc.objects if o.type == 'MESH' and o.name.startswith('Bridle')][0]
red = bpy.data.materials.new("red"); red.use_nodes = True
red.node_tree.nodes["Principled BSDF"].inputs["Base Color"].default_value = (1, 0.05, 0.05, 1)
br.data.materials.clear(); br.data.materials.append(red)
vs = [br.matrix_world @ v.co for v in br.data.vertices]
c = sum(vs, mathutils.Vector()) / len(vs)
print("BRIDLE centre", tuple(round(x, 3) for x in c))
cam = bpy.data.cameras.new("c"); co = bpy.data.objects.new("c", cam); sc.collection.objects.link(co); sc.camera = co
cam.lens = 60
for name, off in (("side", mathutils.Vector((2.6, 0.3, 0.3))), ("front", mathutils.Vector((0.4, -2.6, 0.5))), ("top", mathutils.Vector((0.8, 1.2, 2.0)))):
    co.location = c + off
    co.rotation_euler = (c - co.location).to_track_quat('-Z', 'Y').to_euler()
    sun = bpy.data.lights.get("s") or bpy.data.lights.new("s", "SUN"); sun.energy = 3
    if not sc.objects.get("s"):
        so = bpy.data.objects.new("s", sun); sc.collection.objects.link(so); so.rotation_euler = (0.8, 0.2, 0.6)
    w = bpy.data.worlds.new("w"); sc.world = w; w.color = (0.5, 0.6, 0.7)
    sc.render.engine = 'BLENDER_EEVEE'
    sc.render.resolution_x = 640; sc.render.resolution_y = 480
    sc.render.filepath = argv[1] + "_" + name + ".png"
    bpy.ops.render.render(write_still=True)
