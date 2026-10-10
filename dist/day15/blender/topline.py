import bpy, sys
argv = sys.argv[sys.argv.index("--")+1:]
K = float(argv[1])
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.gltf(filepath=argv[0])
horse = [o for o in bpy.context.scene.objects if o.type == 'MESH' and o.name == 'Horse'][0]
me = horse.evaluated_get(bpy.context.evaluated_depsgraph_get()).to_mesh()
mw = horse.matrix_world
G = [(-p.x*K, p.z*K, p.y*K) for p in (mw @ v.co for v in me.vertices)]
print("TOPLINE (z, top y, belly y)")
z = -0.9
while z <= 0.9:
    band = [g for g in G if abs(g[2]-z) < 0.04 and abs(g[0]) < 0.06]
    side = [g for g in G if abs(g[2]-z) < 0.04]
    if band:
        tops = max(g[1] for g in band)
        lows = [g[1] for g in band if g[1] > 0.55]
        print(f"z={z:+.2f} top={tops:.3f} belly={min(lows) if lows else 0:.3f}")
    z += 0.1
for zc in (-0.15, -0.05, 0.0):
    band = [g for g in G if abs(g[2]-zc) < 0.05]
    row = []
    for yc in [1.35,1.30,1.25,1.20,1.15,1.10,1.05,1.00,0.95,0.90,0.85]:
        b2=[abs(g[0]) for g in band if abs(g[1]-yc) < 0.025]
        row.append(f"{yc:.2f}:{max(b2):.3f}" if b2 else f"{yc:.2f}:-")
    print(f"WIDTH z={zc:+.2f} ", " ".join(row))
