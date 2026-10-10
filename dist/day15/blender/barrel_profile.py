import bpy, sys
argv = sys.argv[sys.argv.index("--")+1:]
K = float(argv[1])  # game metres per Blender unit
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.gltf(filepath=argv[0])
horse = [o for o in bpy.context.scene.objects if o.type == 'MESH' and o.name == 'Horse'][0]
dg = bpy.context.evaluated_depsgraph_get()
ev = horse.evaluated_get(dg)
me = ev.to_mesh()
mw = horse.matrix_world
pts = [mw @ v.co for v in me.vertices]
# Game frame: y up = blender z*K, z = blender y*K (head toward -z), x = -blender x*K
G = [(-p.x*K, p.z*K, p.y*K) for p in pts]
top = max(g[1] for g in G)
print("horse height(game)", round(top,3))
for zc in (0.05, 0.20, 0.32, 0.45, 0.60):
    band = [g for g in G if abs(g[2]-zc) < 0.06]
    if not band: continue
    ys = [g[1] for g in band]
    print(f"z={zc:+.2f}: top {max(ys):.3f} bottom {min([y for y in ys if y>0.5] or [0]):.3f}")
    for yc in [1.45,1.40,1.35,1.30,1.25,1.20,1.15,1.10,1.05,1.00,0.95,0.90,0.85,0.80]:
        b2=[abs(g[0]) for g in band if abs(g[1]-yc) < 0.025]
        if b2: print(f"   y={yc:.2f} halfwidth {max(b2):.3f}")
# withers: highest point between z -0.6 and -0.1
w = [g for g in G if -0.65 < g[2] < -0.05]
wt = max(w, key=lambda g: g[1])
print("withers top", tuple(round(x,3) for x in wt))
