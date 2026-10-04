"""Rig Abbott, skin him, bake walk/trot/canter/jump, export GLB.

Mesh: CC0 Realtime Rancher (Lyndon Daniels). Coat: Abbott textures.
Armature is authored in Blender Z-up, head +Y so glTF yup is Godot Y-up, head -Z.
"""
from __future__ import annotations

import math
import os

import bpy
from mathutils import Vector, Matrix, Euler

ROOT = r"E:\Workspace\Madison"
OBJ = os.path.join(ROOT, "tools", "source_meshes", "rancher", "horse", "LD_HorseRtime02.obj")
ABB = os.path.join(ROOT, "tools", "source_meshes", "abbott_tex")
OUT_GLB = os.path.join(ROOT, "game", "assets", "meshes", "abbott.glb")
PREV = os.path.join(ROOT, "game", "assets", "meshes", "inspect")
os.makedirs(PREV, exist_ok=True)
WITHERS = 1.42
FPS = 24
CYCLE = 24  # 1.0s at 24fps


def xform_mesh_world(obj, R: Matrix):
    mw = obj.matrix_world.copy()
    for v in obj.data.vertices:
        v.co = R @ (mw @ v.co)
    obj.data.update()
    obj.matrix_world = Matrix.Identity(4)


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


def centroid(obj):
    c = Vector((0, 0, 0))
    for v in obj.data.vertices:
        c += v.co
    return c / max(len(obj.data.vertices), 1)


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


def add_bone(eb, name, parent, head, tail):
    b = eb.new(name)
    b.head = Vector(head)
    b.tail = Vector(tail)
    b.use_deform = name != "Root"
    if parent:
        b.parent = eb[parent]
        b.use_connect = False
    return b


def prepare_mesh():
    bpy.ops.wm.read_factory_settings(use_empty=True)
    bpy.ops.wm.obj_import(filepath=OBJ, forward_axis="NEGATIVE_Z", up_axis="Y")
    meshes = [o for o in bpy.data.objects if o.type == "MESH"]

    # Same bake as convert_abbott: intended Y-up, head -Z, feet y=0.
    R = Matrix.Rotation(math.radians(180.0), 4, "Y") @ Matrix.Rotation(math.radians(-90.0), 4, "X")
    for o in meshes:
        xform_mesh_world(o, R)
    mins, maxs = aabb_of(meshes)
    height = maxs.y - mins.y
    scale = WITHERS / max(height * 0.78, 0.01)
    S = Matrix.Scale(scale, 4)
    for o in meshes:
        xform_mesh_world(o, S)
    mins, maxs = aabb_of(meshes)
    T = Matrix.Translation(Vector((-(mins.x + maxs.x) * 0.5, -mins.y, -(mins.z + maxs.z) * 0.5)))
    for o in meshes:
        xform_mesh_world(o, T)

    # Height was on Y. Put height on Blender Z, head toward +Y, for export_yup.
    Rx = Matrix.Rotation(math.radians(90.0), 4, "X")
    for o in meshes:
        xform_mesh_world(o, Rx)

    mins, maxs = aabb_of(meshes)
    print("rig AABB", tuple(round(float(x), 3) for x in mins), tuple(round(float(x), 3) for x in maxs))
    for o in meshes:
        print("  mesh", o.name, "centroid", tuple(round(float(x), 3) for x in centroid(o)))

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
    return meshes, mins, maxs


def build_armature():
    arm_data = bpy.data.armatures.new("AbbottArm")
    arm = bpy.data.objects.new("AbbottArm", arm_data)
    bpy.context.collection.objects.link(arm)
    arm.show_in_front = True
    bpy.context.view_layer.objects.active = arm
    bpy.ops.object.mode_set(mode="EDIT")
    eb = arm_data.edit_bones

    # Blender: +Y head, +Z up, +X left of horse.
    add_bone(eb, "Root", None, (0, 0.0, 0.0), (0, 0.0, 0.12))
    add_bone(eb, "Body", "Root", (0, -0.02, 0.70), (0, 0.12, 0.78))
    add_bone(eb, "Chest", "Body", (0, 0.28, 0.88), (0, 0.50, 0.94))
    add_bone(eb, "Neck", "Chest", (0, 0.62, 1.10), (0, 0.88, 1.28))
    add_bone(eb, "Head", "Neck", (0, 0.92, 1.32), (0, 1.18, 1.48))
    add_bone(eb, "Tail", "Body", (0, -0.55, 0.92), (0, -0.88, 0.78))
    add_bone(eb, "TailTip", "Tail", (0, -0.88, 0.78), (0, -1.12, 0.58))

    # Fore. Shoulder in the chest, cannon down to the sand.
    for side, x in (("L", 0.18), ("R", -0.18)):
        add_bone(eb, f"Shoulder_{side}", "Chest", (x, 0.48, 0.98), (x, 0.50, 0.70))
        add_bone(eb, f"Elbow_{side}", f"Shoulder_{side}", (x, 0.50, 0.70), (x, 0.48, 0.40))
        add_bone(eb, f"Cannon_{side}", f"Elbow_{side}", (x, 0.48, 0.40), (x, 0.46, 0.12))
        add_bone(eb, f"Hoof_{side}", f"Cannon_{side}", (x, 0.46, 0.12), (x, 0.42, 0.02))
        add_bone(eb, f"Hip_{side}", "Body", (x, -0.38, 0.95), (x, -0.36, 0.62))
        add_bone(eb, f"Stifle_{side}", f"Hip_{side}", (x, -0.36, 0.62), (x, -0.48, 0.40))
        add_bone(eb, f"Hock_{side}", f"Stifle_{side}", (x, -0.48, 0.40), (x, -0.42, 0.16))
        add_bone(eb, f"HindCannon_{side}", f"Hock_{side}", (x, -0.42, 0.16), (x, -0.40, 0.02))

    bpy.ops.object.mode_set(mode="OBJECT")
    return arm


def _ensure_mod(obj, arm):
    if obj.modifiers.get("Armature") is None:
        mod = obj.modifiers.new("Armature", "ARMATURE")
        mod.object = arm
    obj.parent = arm


def paint_body(obj):
    """Weight legs by position so they actually swing. Auto-weights glue them to Body."""
    bones = [
        "Body", "Chest", "Neck", "Head", "Tail", "TailTip",
        "Shoulder_L", "Elbow_L", "Cannon_L", "Hoof_L",
        "Shoulder_R", "Elbow_R", "Cannon_R", "Hoof_R",
        "Hip_L", "Stifle_L", "Hock_L", "HindCannon_L",
        "Hip_R", "Stifle_R", "Hock_R", "HindCannon_R",
    ]
    idx = list(range(len(obj.data.vertices)))
    for name in bones:
        vg = obj.vertex_groups.get(name) or obj.vertex_groups.new(name=name)
        vg.remove(idx)
    for i, v in enumerate(obj.data.vertices):
        x, y, z = float(v.co.x), float(v.co.y), float(v.co.z)
        side = "L" if x >= 0.0 else "R"
        w: dict[str, float] = {}
        if y < -0.62 and z > 0.45:
            w["Tail"] = 0.7
            w["TailTip"] = 0.3 if y < -0.85 else 0.0
        elif y > 0.92 and z > 1.18:
            w["Head"] = 1.0
        elif y > 0.58 and z > 1.02:
            w["Neck"] = 0.85
            w["Head"] = 0.15 if y > 0.78 else 0.0
        elif abs(x) > 0.11 and z < 0.98 and y > 0.18:
            if z < 0.11:
                w[f"Hoof_{side}"] = 1.0
            elif z < 0.38:
                w[f"Cannon_{side}"] = 1.0
            elif z < 0.68:
                w[f"Elbow_{side}"] = 1.0
            else:
                w[f"Shoulder_{side}"] = 1.0
        elif abs(x) > 0.10 and z < 0.98 and y < -0.10:
            if z < 0.12:
                w[f"HindCannon_{side}"] = 1.0
            elif z < 0.36:
                w[f"Hock_{side}"] = 1.0
            elif z < 0.62:
                w[f"Stifle_{side}"] = 1.0
            else:
                w[f"Hip_{side}"] = 1.0
        elif y > 0.22:
            w["Chest"] = 0.75
            w["Body"] = 0.25
        else:
            w["Body"] = 1.0
        tot = sum(w.values()) or 1.0
        for bone, wt in w.items():
            if wt <= 0.0:
                continue
            vg = obj.vertex_groups.get(bone) or obj.vertex_groups.new(name=bone)
            vg.add([i], wt / tot, "REPLACE")


def skin(arm, meshes):
    body = [o for o in meshes if o.name.startswith("Plane")]
    hair = [o for o in meshes if "Bezier" in o.name or "Curve" in o.name]
    eyes = [o for o in meshes if "Sphere" in o.name]
    rest = [o for o in meshes if o not in body and o not in hair and o not in eyes]

    bpy.ops.object.select_all(action="DESELECT")
    for o in body + rest:
        o.select_set(True)
    arm.select_set(True)
    bpy.context.view_layer.objects.active = arm
    bpy.ops.object.parent_set(type="ARMATURE_NAME")
    for o in body:
        paint_body(o)
        _ensure_mod(o, arm)
    for o in rest:
        _ensure_mod(o, arm)

    def assign_all(obj, bone):
        vg = obj.vertex_groups.get(bone) or obj.vertex_groups.new(name=bone)
        vg.add(list(range(len(obj.data.vertices))), 1.0, "REPLACE")
        _ensure_mod(obj, arm)

    for o in eyes:
        assign_all(o, "Head")
    for o in hair:
        c = centroid(o)
        assign_all(o, "Head" if c.y > 0.2 else "Tail")


def eul(x_deg, y_deg=0.0, z_deg=0.0):
    return Euler((math.radians(x_deg), math.radians(y_deg), math.radians(z_deg)), "XYZ")


def set_eul(pose, name, x, y=0.0, z=0.0):
    pb = pose.bones.get(name)
    if pb is None:
        return
    pb.rotation_mode = "XYZ"
    pb.rotation_euler = eul(x, y, z)


def swing(phase, amp, lift_amp):
    """phase 0 = plant. Returns (swing_deg, lift_deg) for a leg."""
    # Stance 0–0.45, swing 0.45–1.0
    if phase < 0.45:
        u = phase / 0.45
        sw = amp * (0.35 - u)  # from slightly forward through back
        lf = -2.0 * math.sin(u * math.pi)  # slight compression
        return sw, lf
    u = (phase - 0.45) / 0.55
    sw = amp * (-0.65 + 1.5 * u)  # back to forward
    lf = lift_amp * math.sin(u * math.pi)
    return sw, lf


def pose_gait(pose, t, gait):
    """t in [0,1) one stride. gait: walk/trot/canter/idle/jump."""
    for pb in pose.bones:
        pb.rotation_mode = "XYZ"
        pb.rotation_euler = eul(0)
        if pb.name == "Body":
            pb.location = Vector((0, 0, 0))

    if gait == "idle":
        set_eul(pose, "Body", 1.2 * math.sin(t * math.tau), 0, 0.6 * math.sin(t * math.tau * 0.5))
        set_eul(pose, "Neck", 2.0 * math.sin(t * math.tau + 0.4))
        set_eul(pose, "Head", -1.5 * math.sin(t * math.tau + 0.4))
        set_eul(pose, "Tail", 8.0 * math.sin(t * math.tau), 0, 6.0 * math.sin(t * math.tau * 2))
        return

    if gait == "jump":
        pose_jump(pose, t)
        return

    if gait == "walk":
        # LH, LF, RH, RF
        phases = {
            "L_hind": t,
            "L_fore": (t + 0.75) % 1.0,
            "R_hind": (t + 0.50) % 1.0,
            "R_fore": (t + 0.25) % 1.0,
        }
        amp_f, amp_h, lift_f, lift_h = 28.0, 26.0, 42.0, 38.0
        body_pitch = 3.0 * math.sin(t * math.tau)
        body_roll = 4.0 * math.sin(t * math.tau * 2.0)
        bob = 1.5
    elif gait == "trot":
        phases = {
            "L_hind": t,
            "R_fore": t,
            "R_hind": (t + 0.50) % 1.0,
            "L_fore": (t + 0.50) % 1.0,
        }
        amp_f, amp_h, lift_f, lift_h = 28.0, 24.0, 38.0, 34.0
        body_pitch = 6.0 * math.sin(t * math.tau * 2.0)
        body_roll = 2.0 * math.sin(t * math.tau * 2.0)
        bob = 4.0
    else:  # canter, right lead
        phases = {
            "L_hind": t,
            "R_hind": (t + 0.22) % 1.0,
            "L_fore": (t + 0.22) % 1.0,
            "R_fore": (t + 0.48) % 1.0,
        }
        amp_f, amp_h, lift_f, lift_h = 32.0, 30.0, 48.0, 42.0
        body_pitch = 8.0 * math.sin(t * math.tau)
        body_roll = 3.0 * math.sin(t * math.tau)
        bob = 5.0

    set_eul(pose, "Body", body_pitch, 0, body_roll)
    set_eul(pose, "Chest", body_pitch * 0.4)
    set_eul(pose, "Neck", -body_pitch * 0.6 + 4.0)
    set_eul(pose, "Head", body_pitch * 0.3 - 2.0)
    set_eul(pose, "Tail", 12.0 * math.sin(t * math.tau + 0.5), 0, 10.0 * math.sin(t * math.tau * 2))
    pb = pose.bones.get("Body")
    if pb:
        pb.location = Vector((0, 0, 0.012 * bob * abs(math.sin(t * math.pi * (2 if gait != "walk" else 2)))))

    for side, key_f, key_h in (("L", "L_fore", "L_hind"), ("R", "R_fore", "R_hind")):
        sw, lf = swing(phases[key_f], amp_f, lift_f)
        set_eul(pose, f"Shoulder_{side}", sw)
        set_eul(pose, f"Elbow_{side}", 8.0 + lf * 1.1)
        set_eul(pose, f"Cannon_{side}", -sw * 0.25 - lf * 0.2)
        set_eul(pose, f"Hoof_{side}", -4.0 - lf * 0.15)
        sw, lf = swing(phases[key_h], amp_h, lift_h)
        set_eul(pose, f"Hip_{side}", sw)
        set_eul(pose, f"Stifle_{side}", 10.0 + lf * 1.2)
        set_eul(pose, f"Hock_{side}", -6.0 - lf * 0.9)
        set_eul(pose, f"HindCannon_{side}", lf * 0.2)


def pose_jump(pose, t):
    """White-horse cyclic jump: coil, hind push, tucked bascule, fronts land first."""
    set_eul(pose, "Tail", 18.0 * math.sin(min(t, 1.0) * math.pi), 0, 8.0)
    if t < 0.20:
        u = t / 0.20
        set_eul(pose, "Body", 10.0 * u)
        set_eul(pose, "Chest", 4.0 * u)
        set_eul(pose, "Neck", -4.0 * u)
        set_eul(pose, "Head", -6.0 * u)
        for s in "LR":
            set_eul(pose, f"Hip_{s}", 22.0 * u)
            set_eul(pose, f"Stifle_{s}", 32.0 * u)
            set_eul(pose, f"Hock_{s}", -26.0 * u)
            set_eul(pose, f"Shoulder_{s}", 10.0 + 18.0 * u)
            set_eul(pose, f"Elbow_{s}", 16.0 + 28.0 * u)
            set_eul(pose, f"Cannon_{s}", 8.0 * u)
        return
    if t < 0.38:
        u = (t - 0.20) / 0.18
        set_eul(pose, "Body", 10.0 - 28.0 * u)
        set_eul(pose, "Chest", 4.0 - 14.0 * u)
        set_eul(pose, "Neck", -4.0 + 8.0 * u)
        set_eul(pose, "Head", -6.0 - 4.0 * u)
        for s in "LR":
            set_eul(pose, f"Hip_{s}", 22.0 - 55.0 * u)
            set_eul(pose, f"Stifle_{s}", 32.0 - 8.0 * u)
            set_eul(pose, f"Hock_{s}", -26.0 + 10.0 * u)
            set_eul(pose, f"HindCannon_{s}", 8.0 * u)
            set_eul(pose, f"Shoulder_{s}", 28.0 + 22.0 * u)
            set_eul(pose, f"Elbow_{s}", 44.0 + 40.0 * u)
            set_eul(pose, f"Cannon_{s}", 8.0 + 28.0 * u)
            set_eul(pose, f"Hoof_{s}", 18.0 * u)
        return
    if t < 0.55:
        u = (t - 0.38) / 0.17
        set_eul(pose, "Body", -18.0 - 4.0 * u)
        set_eul(pose, "Chest", -10.0)
        set_eul(pose, "Neck", 4.0 + 6.0 * u)
        set_eul(pose, "Head", -10.0)
        for s in "LR":
            set_eul(pose, f"Shoulder_{s}", 50.0)
            set_eul(pose, f"Elbow_{s}", 84.0)
            set_eul(pose, f"Cannon_{s}", 36.0)
            set_eul(pose, f"Hoof_{s}", 22.0)
            set_eul(pose, f"Hip_{s}", -18.0 + 8.0 * u)
            set_eul(pose, f"Stifle_{s}", 48.0)
            set_eul(pose, f"Hock_{s}", -36.0)
            set_eul(pose, f"HindCannon_{s}", 16.0)
        return
    if t < 0.78:
        u = (t - 0.55) / 0.23
        set_eul(pose, "Body", -22.0 + 14.0 * u)
        set_eul(pose, "Chest", -10.0 + 6.0 * u)
        set_eul(pose, "Neck", 10.0 + 4.0 * u)
        set_eul(pose, "Head", -10.0 + 6.0 * u)
        for s in "LR":
            set_eul(pose, f"Shoulder_{s}", 50.0 - 70.0 * u)
            set_eul(pose, f"Elbow_{s}", 84.0 - 60.0 * u)
            set_eul(pose, f"Cannon_{s}", 36.0 - 28.0 * u)
            set_eul(pose, f"Hoof_{s}", 22.0 - 18.0 * u)
            set_eul(pose, f"Hip_{s}", -10.0 + 6.0 * u)
            set_eul(pose, f"Stifle_{s}", 48.0 - 10.0 * u)
            set_eul(pose, f"Hock_{s}", -36.0 + 8.0 * u)
        return
    u = (t - 0.78) / 0.22
    set_eul(pose, "Body", -8.0 + 8.0 * u)
    set_eul(pose, "Chest", -4.0 + 4.0 * u)
    set_eul(pose, "Neck", 14.0 - 14.0 * u)
    set_eul(pose, "Head", -4.0 * (1.0 - u))
    for s in "LR":
        set_eul(pose, f"Shoulder_{s}", -20.0 * (1.0 - u))
        set_eul(pose, f"Elbow_{s}", 24.0 * (1.0 - u))
        set_eul(pose, f"Cannon_{s}", 8.0 * (1.0 - u))
        set_eul(pose, f"Hip_{s}", -4.0 + 16.0 * u)
        set_eul(pose, f"Stifle_{s}", 38.0 * (1.0 - u) + 12.0 * u)
        set_eul(pose, f"Hock_{s}", -28.0 * (1.0 - u))


def bake_action(arm, name, gait, frames, loop=True):
    pose = arm.pose
    act = bpy.data.actions.new(name)
    if not arm.animation_data:
        arm.animation_data_create()
    arm.animation_data.action = act
    scene = bpy.context.scene
    scene.render.fps = FPS
    scene.frame_start = 1
    scene.frame_end = frames
    for i in range(frames):
        t = i / float(frames if not loop else frames)
        if not loop:
            t = i / float(max(frames - 1, 1))
        pose_gait(pose, t, gait)
        scene.frame_set(i + 1)
        for pb in pose.bones:
            pb.keyframe_insert("rotation_euler", frame=i + 1)
            if pb.name == "Body":
                pb.keyframe_insert("location", frame=i + 1)
    print("baked", name, "frames", frames)
    return act


def main():
    meshes, mins, maxs = prepare_mesh()
    arm = build_armature()
    skin(arm, meshes)

    bake_action(arm, "Idle", "idle", 48, loop=True)
    bake_action(arm, "Walk", "walk", CYCLE, loop=True)
    bake_action(arm, "Trot", "trot", CYCLE, loop=True)
    bake_action(arm, "Canter", "canter", CYCLE, loop=True)
    bake_action(arm, "Jump", "jump", 28, loop=False)

    bpy.ops.object.select_all(action="DESELECT")
    arm.select_set(True)
    for o in meshes:
        o.select_set(True)
    bpy.context.view_layer.objects.active = arm
    bpy.ops.export_scene.gltf(
        filepath=OUT_GLB,
        export_format="GLB",
        export_apply=True,
        export_cameras=False,
        export_lights=False,
        export_yup=True,
        export_skins=True,
        export_def_bones=True,
        export_animations=True,
        export_animation_mode="ACTIONS",
        export_nla_strips=False,
        export_force_sampling=True,
        export_frame_range=False,
    )
    print("EXPORTED", OUT_GLB, os.path.getsize(OUT_GLB))


if __name__ == "__main__":
    main()
