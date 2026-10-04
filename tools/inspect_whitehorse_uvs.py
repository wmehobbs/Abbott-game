"""Headless inspect of Quaternius WhiteHorse: materials, UVs, bones, clips."""
import bpy
import os
from mathutils import Vector

ROOT = r"E:\Workspace\Madison"
GLB = os.path.join(ROOT, "game", "assets", "meshes", "quaternius-WhiteHorse.glb")
OUT = os.path.join(ROOT, "game", "assets", "meshes", "inspect")
os.makedirs(OUT, exist_ok=True)

bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.gltf(filepath=GLB)

lines = []
for obj in bpy.data.objects:
    parent = obj.parent.name if obj.parent else None
    loc = tuple(round(x, 5) for x in obj.location)
    lines.append("OBJ %s type=%s parent=%s loc=%s" % (obj.name, obj.type, parent, loc))
    if obj.type == "ARMATURE":
        for b in obj.data.bones:
            h = obj.matrix_world @ b.head_local
            t = obj.matrix_world @ b.tail_local
            lines.append(
                "  BONE %s head=%s tail=%s"
                % (b.name, tuple(round(x, 5) for x in h), tuple(round(x, 5) for x in t))
            )
    if obj.type != "MESH":
        continue
    me = obj.data
    uv_names = [uv.name for uv in me.uv_layers]
    mats = [s.material.name if s.material else None for s in obj.material_slots]
    bb = [obj.matrix_world @ Vector(c) for c in obj.bound_box]
    xs, ys, zs = [v.x for v in bb], [v.y for v in bb], [v.z for v in bb]
    lines.append(
        "  MESH verts=%d loops=%d polys=%d uvs=%s mats=%s"
        % (len(me.vertices), len(me.loops), len(me.polygons), uv_names, mats)
    )
    lines.append(
        "  AABB (%.4f,%.4f,%.4f)-(%.4f,%.4f,%.4f)"
        % (min(xs), min(ys), min(zs), max(xs), max(ys), max(zs))
    )
    if me.uv_layers:
        uvs = me.uv_layers.active.data
        us = [d.uv.x for d in uvs]
        vs = [d.uv.y for d in uvs]
        lines.append(
            "  UV range u=(%.4f,%.4f) v=(%.4f,%.4f)" % (min(us), max(us), min(vs), max(vs))
        )
        # Sample UVs of extreme verts
        coords = [obj.matrix_world @ v.co for v in me.vertices]
        # loop->vert map
        step = max(1, len(me.loops) // 12)
        samples = []
        for li in range(0, len(me.loops), step):
            loop = me.loops[li]
            w = obj.matrix_world @ me.vertices[loop.vertex_index].co
            uv = me.uv_layers.active.data[loop.index].uv
            samples.append(
                "    sample world=(%.4f,%.4f,%.4f) uv=(%.4f,%.4f)"
                % (w.x, w.y, w.z, uv.x, uv.y)
            )
        lines.extend(samples[:16])
    for pi, p in enumerate(me.polygons):
        pass
    # material usage
    counts = {}
    for p in me.polygons:
        counts[p.material_index] = counts.get(p.material_index, 0) + 1
    lines.append("  mat_poly_counts=%s" % counts)

lines.append("ACTIONS %s" % [a.name for a in bpy.data.actions])
lines.append("MATS %s" % [m.name for m in bpy.data.materials])

rep = os.path.join(OUT, "whitehorse_uv_report.txt")
with open(rep, "w", encoding="utf-8") as f:
    f.write("\n".join(lines) + "\n")
print("\n".join(lines))
print("WROTE", rep)
