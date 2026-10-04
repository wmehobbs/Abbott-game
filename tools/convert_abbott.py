"""Build Abbott.glb from the CC0 Realtime Rancher OBJ (Lyndon Daniels, CC0)."""
from __future__ import annotations

import math
import os

import bpy
from mathutils import Vector, Matrix

ROOT = r"E:\Workspace\Madison"
OBJ = os.path.join(ROOT, "game", "assets", "meshes", "rancher", "horse", "LD_HorseRtime02.obj")
ABB = os.path.join(ROOT, "game", "assets", "meshes", "abbott_tex")
OUT_GLB = os.path.join(ROOT, "game", "assets", "meshes", "abbott.glb")
PREV = os.path.join(ROOT, "game", "assets", "meshes", "inspect")
os.makedirs(PREV, exist_ok=True)
WITHERS = 1.42


def look_at(obj, target):
    obj.rotation_euler = (target - obj.location).to_track_quat("-Z", "Y").to_euler()


def world_pos(obj, local=Vector((0, 0, 0))):
    return obj.matrix_world @ local


def aabb_of(objs):
    mins = Vector((1e9, 1e9, 1e9))
    maxs = Vector((-1e9, -1e9, -1e9))
    for o in objs:
        if o.type != "MESH":
            continue
        for v in o.data.vertices:
            w = o.matrix_world @ v.co
            mins.x, mins.y, mins.z = min(mins.x, w.x), min(mins.y, w.y), min(mins.z, w.z)
            maxs.x, maxs.y, maxs.z = max(maxs.x, w.x), max(maxs.y, w.y), max(maxs.z, w.z)
    return mins, maxs


def xform_mesh_world(obj, R: Matrix):
    """Bake R * world_pos into local verts, then reset obj transform."""
    mw = obj.matrix_world.copy()
    for v in obj.data.vertices:
        v.co = R @ (mw @ v.co)
    obj.data.update()
    obj.matrix_world = Matrix.Identity(4)


def set_image(mat, path):
    if mat is None or not os.path.exists(path):
        print("missing", path)
        return
    mat.use_nodes = True
    nt = mat.node_tree
    bsdf = next((n for n in nt.nodes if n.type == "BSDF_PRINCIPLED"), None)
    if bsdf is None:
        return
    for n in list(nt.nodes):
        if n.type == "TEX_IMAGE":
            nt.nodes.remove(n)
    tex = nt.nodes.new("ShaderNodeTexImage")
    tex.image = bpy.data.images.load(path)
    nt.links.new(tex.outputs["Color"], bsdf.inputs["Base Color"])
    bsdf.inputs["Roughness"].default_value = 0.44


def main():
    bpy.ops.wm.read_factory_settings(use_empty=True)
    bpy.ops.wm.obj_import(filepath=OBJ, forward_axis="NEGATIVE_Z", up_axis="Y")
    meshes = [o for o in bpy.data.objects if o.type == "MESH"]
    print("imported", [(o.name, tuple(round(x, 2) for x in o.location)) for o in meshes])

    # File is Z-up, head toward -Y. Map to Y-up, head -Z:
    # (x, y, z) -> (x, z, y) after (x,y,z)->(x,z,-y) then z flip? 
    # Rx(-90): (x,y,z)->(x,z,-y)  head y=-7 -> z=+7 (head +Z)
    # Ry(180): (x,y,z)->(-x,y,-z) head +Z -> -Z
    R = Matrix.Rotation(math.radians(180.0), 4, "Y") @ Matrix.Rotation(math.radians(-90.0), 4, "X")
    for o in meshes:
        xform_mesh_world(o, R)

    mins, maxs = aabb_of(meshes)
    print("rotated AABB", mins, maxs)
    eyes = [o for o in meshes if "sphere" in o.name.lower()]
    for e in eyes:
        c = Vector((0, 0, 0))
        for v in e.data.vertices:
            c += v.co
        c /= max(len(e.data.vertices), 1)
        print("eye center", e.name, c)

    height = maxs.y - mins.y
    scale = WITHERS / max(height * 0.78, 0.01)
    S = Matrix.Scale(scale, 4)
    for o in meshes:
        xform_mesh_world(o, S)

    mins, maxs = aabb_of(meshes)
    T = Matrix.Translation(Vector((-(mins.x + maxs.x) * 0.5, -mins.y, -(mins.z + maxs.z) * 0.5)))
    for o in meshes:
        xform_mesh_world(o, T)

    mins, maxs = aabb_of(meshes)
    print("final AABB", tuple(round(float(x), 3) for x in mins), tuple(round(float(x), 3) for x in maxs))
    eyes = [o for o in meshes if "sphere" in o.name.lower()]
    for e in eyes:
        c = Vector((0, 0, 0))
        for v in e.data.vertices:
            c += v.co
        c /= max(len(e.data.vertices), 1)
        print("eye final", e.name, tuple(round(float(x), 3) for x in c))

    # Triangulate
    for o in meshes:
        bpy.ops.object.select_all(action="DESELECT")
        o.select_set(True)
        bpy.context.view_layer.objects.active = o
        mod = o.modifiers.new("Tri", "TRIANGULATE")
        bpy.ops.object.modifier_apply(modifier=mod.name)
        bpy.ops.object.mode_set(mode="EDIT")
        bpy.ops.mesh.select_all(action="SELECT")
        bpy.ops.mesh.normals_make_consistent(inside=False)
        bpy.ops.object.mode_set(mode="OBJECT")

    coat = os.path.join(ABB, "abbott_coat.png")
    hair = os.path.join(ABB, "abbott_hair.png")
    eye = os.path.join(ABB, "abbott_eye.png")
    for mat in bpy.data.materials:
        n = mat.name.lower()
        if "hair" in n:
            set_image(mat, hair)
        elif "eye" in n:
            set_image(mat, eye)
        else:
            set_image(mat, coat)

    bpy.ops.object.empty_add(type="PLAIN_AXES", location=(0, 0, 0))
    root = bpy.context.object
    root.name = "Abbott"
    for o in meshes:
        o.parent = root

    # Preview lighting
    world = bpy.data.worlds.new("W")
    bpy.context.scene.world = world
    world.use_nodes = True
    bg = world.node_tree.nodes["Background"]
    bg.inputs[0].default_value = (0.55, 0.65, 0.75, 1)
    bg.inputs[1].default_value = 1.0
    sun = bpy.data.objects.new("Sun", bpy.data.lights.new("Sun", "SUN"))
    sun.data.energy = 8.0
    sun.rotation_euler = (math.radians(-48), math.radians(-28), 0)
    bpy.context.scene.collection.objects.link(sun)

    center = (mins + maxs) * 0.5
    cam_data = bpy.data.cameras.new("Cam")
    cam = bpy.data.objects.new("Cam", cam_data)
    bpy.context.scene.collection.objects.link(cam)
    bpy.context.scene.camera = cam
    cam_data.lens = 40
    scene = bpy.context.scene
    scene.render.engine = "BLENDER_EEVEE"
    scene.render.resolution_x = 1280
    scene.render.resolution_y = 720

    # Side: from +X, horse should be in profile, head toward -Z (left if camera looks -X... wait)
    cam.location = Vector((4.2, 1.1, 0.0))
    look_at(cam, Vector((0.0, 0.9, 0.0)))
    scene.render.filepath = os.path.join(PREV, "abbott_side.png")
    bpy.ops.render.render(write_still=True)

    # 3/4 toward the head
    cam.location = Vector((2.8, 1.3, -3.0))
    look_at(cam, Vector((0.0, 0.95, -0.3)))
    scene.render.filepath = os.path.join(PREV, "abbott_preview.png")
    bpy.ops.render.render(write_still=True)

    # Face
    cam.location = Vector((0.0, 1.25, -3.4))
    look_at(cam, Vector((0.0, 1.15, -1.0)))
    scene.render.filepath = os.path.join(PREV, "abbott_front.png")
    bpy.ops.render.render(write_still=True)

    bpy.ops.object.select_all(action="SELECT")
    bpy.ops.export_scene.gltf(
        filepath=OUT_GLB,
        export_format="GLB",
        export_apply=True,
        export_cameras=False,
        export_lights=False,
        export_yup=True,
    )
    print("EXPORTED", OUT_GLB, os.path.getsize(OUT_GLB))


if __name__ == "__main__":
    main()
