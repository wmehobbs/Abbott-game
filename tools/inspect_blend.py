"""List objects/armatures in the rancher .blend."""
import bpy
import os

path = r"E:\Workspace\Madison\game\assets\meshes\rancher_horse.blend"
bpy.ops.wm.open_mainfile(filepath=path)
print("=== OBJECTS ===")
for o in bpy.data.objects:
    print(f"{o.name:40} type={o.type:10} loc={tuple(round(x,3) for x in o.location)} parent={o.parent.name if o.parent else None}")
print("=== ARMATURES ===")
for a in bpy.data.armatures:
    print("armature", a.name, "bones", len(a.bones))
    for b in list(a.bones)[:40]:
        print("  bone", b.name, "head", tuple(round(x,3) for x in b.head_local), "tail", tuple(round(x,3) for x in b.tail_local))
print("=== ACTIONS ===")
for a in bpy.data.actions:
    print("action", a.name, "fcurves", len(a.fcurves))
print("=== MESHES ===")
for m in bpy.data.meshes:
    print("mesh", m.name, "verts", len(m.vertices), "faces", len(m.polygons))
