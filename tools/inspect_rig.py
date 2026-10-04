"""Print objects/armatures in source blends."""
import bpy
import sys

path = sys.argv[sys.argv.index("--") + 1]
bpy.ops.wm.open_mainfile(filepath=path)
print("FILE", path)
print("=== OBJECTS ===")
for o in bpy.data.objects:
    print(f"{o.name:40} type={o.type:10} parent={o.parent.name if o.parent else None}")
print("=== ARMATURES ===")
for a in bpy.data.armatures:
    print("armature", a.name, "bones", len(a.bones))
    for b in list(a.bones)[:60]:
        print("  ", b.name)
print("=== ACTIONS ===")
for a in bpy.data.actions:
    print("action", a.name, "fcurves", len(a.fcurves))
print("=== MESHES ===")
for m in bpy.data.meshes:
    print("mesh", m.name, "verts", len(m.vertices), "faces", len(m.polygons))
