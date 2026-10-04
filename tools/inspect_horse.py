"""Inspect the CC0 Realtime Rancher horse and emit UV + preview renders."""
import bpy
import os
import math
from mathutils import Vector

ROOT = r"E:\Workspace\Madison"
MESH = os.path.join(ROOT, "game", "assets", "meshes")
OUT = os.path.join(MESH, "inspect")
os.makedirs(OUT, exist_ok=True)

bpy.ops.wm.read_factory_settings(use_empty=True)

obj_path = os.path.join(MESH, "rancher", "horse", "LD_HorseRtime02.obj")
blend_path = os.path.join(MESH, "LD_HorseRtime02.blend")  # 20MB rancher blend saved as rancher_blend

# Import OBJ
bpy.ops.wm.obj_import(filepath=obj_path, forward_axis="NEGATIVE_Z", up_axis="Y")

report = []
for obj in bpy.data.objects:
    if obj.type != "MESH":
        continue
    bb = [obj.matrix_world @ Vector(c) for c in obj.bound_box]
    xs = [v.x for v in bb]
    ys = [v.y for v in bb]
    zs = [v.z for v in bb]
    report.append(
        f"{obj.name} verts={len(obj.data.vertices)} faces={len(obj.data.polygons)} "
        f"mats={[s.material.name if s.material else None for s in obj.material_slots]} "
        f"dim=({max(xs)-min(xs):.3f}, {max(ys)-min(ys):.3f}, {max(zs)-min(zs):.3f}) "
        f"min=({min(xs):.3f},{min(ys):.3f},{min(zs):.3f}) max=({max(xs):.3f},{max(ys):.3f},{max(zs):.3f})"
    )
    if obj.data.uv_layers:
        report.append(f"  uv_layers={[l.name for l in obj.data.uv_layers]}")

# Load textures onto materials if missing
tex_dir = os.path.join(MESH, "rancher", "horse")
coat = os.path.join(tex_dir, "HorseMain2k00.png")
hair = os.path.join(tex_dir, "Hair12Main2k.png")
eye = os.path.join(tex_dir, "eye_texture.png")

for mat in bpy.data.materials:
    mat.use_nodes = True
    nt = mat.node_tree
    bsdf = nt.nodes.get("Principled BSDF")
    if bsdf is None:
        continue
    img_path = None
    name = mat.name.lower()
    if "hair" in name:
        img_path = hair
    elif "eye" in name:
        img_path = eye
    else:
        img_path = coat
    if img_path and os.path.exists(img_path):
        tex = nt.nodes.new("ShaderNodeTexImage")
        tex.image = bpy.data.images.load(img_path)
        nt.links.new(tex.outputs["Color"], bsdf.inputs["Base Color"])

# World light
world = bpy.data.worlds.new("World")
bpy.context.scene.world = world
world.use_nodes = True
bg = world.node_tree.nodes["Background"]
bg.inputs[0].default_value = (0.55, 0.62, 0.7, 1)
bg.inputs[1].default_value = 0.8

sun = bpy.data.objects.new("Sun", bpy.data.lights.new("Sun", "SUN"))
sun.data.energy = 4.0
sun.rotation_euler = (math.radians(-42), math.radians(-35), 0)
bpy.context.scene.collection.objects.link(sun)

# Camera
cam_data = bpy.data.cameras.new("Cam")
cam = bpy.data.objects.new("Cam", cam_data)
bpy.context.scene.collection.objects.link(cam)
bpy.context.scene.camera = cam
cam_data.lens = 50

meshes = [o for o in bpy.data.objects if o.type == "MESH"]
# world AABB
mins = Vector((1e9, 1e9, 1e9))
maxs = Vector((-1e9, -1e9, -1e9))
for o in meshes:
    for c in o.bound_box:
        v = o.matrix_world @ Vector(c)
        mins.x, mins.y, mins.z = min(mins.x, v.x), min(mins.y, v.y), min(mins.z, v.z)
        maxs.x, maxs.y, maxs.z = max(maxs.x, v.x), max(maxs.y, v.y), max(maxs.z, v.z)
center = (mins + maxs) * 0.5
size = (maxs - mins).length
report.append(f"AABB min={tuple(mins)} max={tuple(maxs)} center={tuple(center)} size={size:.3f}")
rep_path = os.path.join(OUT, "report.txt")
with open(rep_path, "w", encoding="utf-8") as f:
    f.write("\n".join(report) + "\n")
print("\n".join(report))


def look_at(obj, target):
    direction = target - obj.location
    obj.rotation_euler = direction.to_track_quat("-Z", "Y").to_euler()


cam.location = center + Vector((size * 0.9, size * 0.35, size * 0.7))
look_at(cam, center)

scene = bpy.context.scene
scene.render.engine = "BLENDER_EEVEE"
scene.render.resolution_x = 1280
scene.render.resolution_y = 720
scene.render.filepath = os.path.join(OUT, "preview_side.png")
bpy.ops.render.render(write_still=True)

# Front
cam.location = center + Vector((0.0, size * 0.2, size * 1.3))
look_at(cam, center)
scene.render.filepath = os.path.join(OUT, "preview_front.png")
bpy.ops.render.render(write_still=True)

# 3/4
cam.location = center + Vector((size * 0.75, size * 0.3, size * 0.85))
look_at(cam, center)
scene.render.filepath = os.path.join(OUT, "preview_34.png")
bpy.ops.render.render(write_still=True)

# UV layout of largest mesh
big = max(meshes, key=lambda o: len(o.data.vertices))
bpy.context.view_layer.objects.active = big
big.select_set(True)
uv_path = os.path.join(OUT, "uv_layout.png")
try:
    bpy.ops.uv.export_layout(filepath=uv_path, size=(2048, 2048), opacity=0.4, export_all=True)
    report.append(f"uv_layout={uv_path}")
except Exception as e:
    report.append(f"uv_layout failed: {e}")

# Dump a few UV coords of vertices near the nose / head to locate face in UV
# Head is typically min Y or max Y depending on orientation
verts = list(big.data.vertices)
# find highest and most forward verts
report.append(f"active mesh {big.name}")

rep_path = os.path.join(OUT, "report.txt")
with open(rep_path, "w", encoding="utf-8") as f:
    f.write("\n".join(report) + "\n")
print("\n".join(report))
print("WROTE", rep_path)
