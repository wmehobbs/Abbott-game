"""Build abbott_v2 from the Quaternius horse. Headless. Same bones, same size.

Smooth the body, paint a chestnut coat (no UVs on the source, so vertex
colors are baked onto a new UV layout), add Trot and Canter, add a bridle.
"""
import math
import os
import sys

import bpy
import mathutils
import numpy as np

FEET = ("FF.L", "FF.R", "FFB.L", "FFB.R")
HEAD_BONES = {
    "Neck1", "Neck2", "Neck3", "Head", "Jaw",
    "Ear1.L", "Ear2.L", "Ear3.L", "Ear4.L",
    "Ear1.R", "Ear2.R", "Ear3.R", "Ear4.R",
}
CHAINS = {
    "LH": ["BackShoulder.L", "BackLeg.L", "BackUpperLeg.L", "BackLowerLeg.L", "IKBackLeg.L", "FFB.L", "PoleTargetBack.L"],
    "RH": ["BackShoulder.R", "BackLeg.R", "BackUpperLeg.R", "BackLowerLeg.R", "IKBackLeg.R", "FFB.R", "PoleTargetBack.R"],
    "LF": ["FrontShoulder.L", "FrontUpperLeg.L", "FrontLowerLeg.L", "IKFrontLeg.L", "FF.L", "PoleTarget.L"],
    "RF": ["FrontShoulder.R", "FrontUpperLeg.R", "FrontLowerLeg.R", "IKFrontLeg.R", "FF.R", "PoleTarget.R"],
}
# Linear. The photo's coat is near sRGB (70, 45, 30), not the old pale tan.
CHESTNUT = np.array([0.085, 0.028, 0.013], np.float32)
TOPLINE = np.array([0.032, 0.010, 0.005], np.float32)
LEG = np.array([0.042, 0.013, 0.006], np.float32)
BELLY = np.array([0.11, 0.040, 0.020], np.float32)
WHITE = np.array([0.93, 0.90, 0.84], np.float32)
PINK = np.array([0.90, 0.68, 0.62], np.float32)
FLAX = np.array([0.90, 0.84, 0.66], np.float32)
TAIL = np.array([0.24, 0.12, 0.06], np.float32)
HOOF = np.array([0.09, 0.05, 0.03], np.float32)
EYE = np.array([0.03, 0.02, 0.015], np.float32)
EAR = np.array([0.22, 0.09, 0.04], np.float32)


def argv_after():
    if "--" not in sys.argv:
        return []
    return sys.argv[sys.argv.index("--") + 1 :]


def armature():
    arms = [o for o in bpy.context.scene.objects if o.type == "ARMATURE"]
    arms.sort(key=lambda o: len(o.data.bones), reverse=True)
    return arms[0]


def horse_mesh(arm):
    best = None
    best_n = -1
    for o in bpy.context.scene.objects:
        if o.type != "MESH":
            continue
        if len(o.data.polygons) > best_n:
            best = o
            best_n = len(o.data.polygons)
    return best


def set_action(arm, action):
    ad = arm.animation_data_create()
    ad.action = action
    slots = list(getattr(action, "slots", []) or [])
    if slots and hasattr(ad, "action_slot"):
        ad.action_slot = slots[0]


def pose_frame(arm, name, frame):
    action = bpy.data.actions.get(name)
    if action is None:
        raise RuntimeError("missing action " + name)
    set_action(arm, action)
    bpy.context.scene.frame_set(int(frame))
    bpy.context.view_layer.update()


def capture_basis(arm):
    return {pb.name: pb.matrix_basis.copy() for pb in arm.pose.bones}


def apply_basis(arm, pose):
    for name, mat in pose.items():
        pb = arm.pose.bones.get(name)
        if pb:
            pb.matrix_basis = mat.copy()
    bpy.context.view_layer.update()


def copy_pose(pose):
    return {k: v.copy() for k, v in pose.items()}


def overwrite_chain(dst, src, chain):
    for name in chain:
        if name in src:
            dst[name] = src[name].copy()


def foot_z(arm):
    out = {}
    for name in FEET:
        pb = arm.pose.bones.get(name)
        if pb is None:
            continue
        bone = arm.data.bones[name]
        tail = arm.matrix_world @ pb.matrix @ mathutils.Vector((0.0, bone.length, 0.0))
        out[name] = tail.z
    return out


def begin_action(arm, name):
    old = bpy.data.actions.get(name)
    if old:
        bpy.data.actions.remove(old)
    if arm.animation_data:
        arm.animation_data_clear()
    action = bpy.data.actions.new(name)
    action.use_fake_user = True
    ad = arm.animation_data_create()
    slot = None
    if hasattr(action, "slots"):
        slot = action.slots.new("OBJECT", arm.name)
        if hasattr(action, "layers") and len(list(action.layers)) == 0:
            layer = action.layers.new("Layer")
            try:
                layer.strips.new(type="KEYFRAME")
            except TypeError:
                layer.strips.new(type="KEYFRAME", name="Keys")
    ad.action = action
    if slot is not None and hasattr(ad, "action_slot"):
        ad.action_slot = slot
    return action


def key_all(arm, frame):
    for pb in arm.pose.bones:
        pb.keyframe_insert(data_path="location", frame=frame)
        if pb.rotation_mode == "QUATERNION":
            pb.keyframe_insert(data_path="rotation_quaternion", frame=frame)
        else:
            pb.keyframe_insert(data_path="rotation_euler", frame=frame)
        pb.keyframe_insert(data_path="scale", frame=frame)


def nod(arm, amount):
    for name, scale in (("Neck1", 1.0), ("Neck2", 0.75), ("Head", 0.45)):
        pb = arm.pose.bones.get(name)
        if pb is None:
            continue
        delta = mathutils.Euler((amount * scale, 0.0, 0.0), "XYZ").to_quaternion()
        if pb.rotation_mode == "QUATERNION":
            pb.rotation_quaternion = delta @ pb.rotation_quaternion
        else:
            pb.rotation_euler.x += amount * scale


def steady_head(pose, idle):
    for name in HEAD_BONES:
        if name in idle:
            pose[name] = idle[name].copy()


def build_gaits(arm):
    ncon = sum(len(pb.constraints) for pb in arm.pose.bones)
    print("CONSTRAINTS", ncon)
    walk = {}
    for frame in range(0, 29):
        pose_frame(arm, "Walk", frame)
        walk[frame] = capture_basis(arm)
    gallop = {}
    for frame in range(0, 15):
        pose_frame(arm, "Gallop", frame)
        gallop[frame] = capture_basis(arm)
    pose_frame(arm, "Idle", 0)
    idle = capture_basis(arm)

    # Trot: two-beat diagonals. Walk frame 9 is left hind + right fore, but the
    # right hind is still low. The airborne legs come from the frames where
    # that foot is highest, so a third foot is not on the ground.
    contact_a = copy_pose(walk[9])
    overwrite_chain(contact_a, walk[13], CHAINS["RH"])
    overwrite_chain(contact_a, walk[5], CHAINS["LF"])
    contact_b = copy_pose(walk[23])
    overwrite_chain(contact_b, walk[26], CHAINS["LH"])
    overwrite_chain(contact_b, walk[20], CHAINS["RF"])
    suspend = copy_pose(walk[9])
    overwrite_chain(suspend, walk[26], CHAINS["LH"])
    overwrite_chain(suspend, walk[13], CHAINS["RH"])
    overwrite_chain(suspend, walk[5], CHAINS["LF"])
    overwrite_chain(suspend, walk[20], CHAINS["RF"])
    for pose in (contact_a, contact_b, suspend):
        steady_head(pose, idle)

    # Canter, left lead, matching this gallop (left fore lands last).
    # 1 outside hind, 2 inside hind + outside fore, 3 inside fore, suspension.
    beat1 = copy_pose(gallop[6])
    beat2 = copy_pose(gallop[9])
    overwrite_chain(beat2, gallop[12], CHAINS["RF"])
    overwrite_chain(beat2, gallop[0], CHAINS["RH"])
    overwrite_chain(beat2, gallop[6], CHAINS["LF"])
    beat3 = copy_pose(gallop[0])
    overwrite_chain(beat3, gallop[6], CHAINS["RF"])
    air = copy_pose(gallop[5])
    nods = {0: 0.06, 4: -0.04, 9: -0.16, 13: 0.14}

    def stamp(pose, frame, nod_amt=None):
        apply_basis(arm, pose)
        if nod_amt:
            nod(arm, nod_amt)
            bpy.context.view_layer.update()
        key_all(arm, frame)
        zs = foot_z(arm)
        order = " ".join("%s:%.3f" % (k, v) for k, v in sorted(zs.items(), key=lambda kv: kv[1]))
        print("GAIT_FRAME", frame, order)

    action = begin_action(arm, "Trot")
    for frame, pose in ((0, contact_a), (4, suspend), (8, contact_b), (12, suspend), (16, contact_a)):
        stamp(pose, frame)
    print("ACTION_KEYS Trot", action.frame_range[:], "fcurves", len(list(getattr(action, "fcurves", []) or [])))

    action = begin_action(arm, "Canter")
    for frame, pose in ((0, beat1), (4, beat2), (9, beat3), (13, air), (16, beat1)):
        stamp(pose, frame, nods.get(frame))
    print("ACTION_KEYS Canter", action.frame_range[:], "fcurves", len(list(getattr(action, "fcurves", []) or [])))


def smooth_body(obj):
    bpy.context.view_layer.objects.active = obj
    obj.select_set(True)
    before = len(obj.data.vertices)
    bpy.ops.object.mode_set(mode="EDIT")
    bpy.ops.mesh.select_all(action="SELECT")
    try:
        bpy.ops.mesh.remove_doubles(threshold=1e-4)
    except Exception:
        bpy.ops.mesh.merge_by_distance(threshold=1e-4)
    bpy.ops.object.mode_set(mode="OBJECT")
    print("WELDED", before, "->", len(obj.data.vertices))
    arm_name = None
    for mod in obj.modifiers:
        if mod.type == "ARMATURE":
            arm_name = mod.name
    sub = obj.modifiers.new("BodySubd", "SUBSURF")
    sub.levels = 1
    sub.render_levels = 1
    if arm_name:
        while obj.modifiers.find("BodySubd") > obj.modifiers.find(arm_name):
            bpy.ops.object.modifier_move_up(modifier="BodySubd")
    bpy.ops.object.modifier_apply(modifier="BodySubd")
    print("SUBDIV", len(obj.data.polygons), "polys", "mods", [m.name for m in obj.modifiers])
    mesh = obj.data
    for edge in mesh.edges:
        edge.use_edge_sharp = False
    mesh.polygons.foreach_set("use_smooth", [True] * len(mesh.polygons))
    try:
        bpy.ops.object.mode_set(mode="EDIT")
        bpy.ops.mesh.customdata_custom_splitnormals_clear()
        bpy.ops.object.mode_set(mode="OBJECT")
        print("NORMALS cleared")
    except Exception as exc:
        print("NORMALS", exc)
        try:
            bpy.ops.object.mode_set(mode="OBJECT")
        except Exception:
            pass
    mesh.update()
    center = mathutils.Vector((0.0, 0.0, 0.0))
    for vert in mesh.vertices:
        center += vert.co
    center /= max(len(mesh.vertices), 1)
    inward = 0
    for poly in mesh.polygons:
        if poly.normal.dot(poly.center - center) < 0.0:
            inward += 1
    print("INWARD", inward, "of", len(mesh.polygons))
    if inward > len(mesh.polygons) * 0.15:
        bpy.ops.object.mode_set(mode="EDIT")
        bpy.ops.mesh.select_all(action="SELECT")
        bpy.ops.mesh.normals_make_consistent(inside=False)
        bpy.ops.object.mode_set(mode="OBJECT")
        print("NORMALS made consistent")


def uv_median(mesh):
    uv = mesh.uv_layers.active.data
    areas = []
    for poly in mesh.polygons:
        ids = poly.loop_indices
        if len(ids) < 3:
            continue
        a = uv[ids[0]].uv
        b = uv[ids[1]].uv
        c = uv[ids[2]].uv
        areas.append(abs((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y)))
    if not areas:
        return 0.0
    areas.sort()
    return areas[len(areas) // 2]


def ensure_uvs(obj):
    mesh = obj.data
    bpy.context.view_layer.objects.active = obj
    if not mesh.uv_layers:
        mesh.uv_layers.new(name="UVMap")
    attempts = (
        ("smart", lambda: bpy.ops.uv.smart_project(angle_limit=1.047, island_margin=0.03)),
        ("cube", lambda: bpy.ops.uv.cube_project(cube_size=1.0, scale_to_bounds=True)),
    )
    for name, op in attempts:
        bpy.ops.object.mode_set(mode="EDIT")
        bpy.ops.mesh.select_all(action="SELECT")
        try:
            op()
        except Exception as exc:
            print("UV_OP", name, exc)
        bpy.ops.object.mode_set(mode="OBJECT")
        med = uv_median(mesh)
        print("UV_MED", name, med)
        if med > 1e-5:
            return True
    print("UV_MED failed, box fallback")
    box_uv(obj)
    print("UV_MED box", uv_median(mesh))
    return uv_median(mesh) > 1e-5


def box_uv(obj):
    mesh = obj.data
    uv = mesh.uv_layers.active.data
    xs = [v.co.x for v in mesh.vertices]
    ys = [v.co.y for v in mesh.vertices]
    zs = [v.co.z for v in mesh.vertices]
    span = max(max(xs) - min(xs), max(ys) - min(ys), max(zs) - min(zs), 1e-4)
    for poly in mesh.polygons:
        n = poly.normal
        if abs(n.z) >= abs(n.x) and abs(n.z) >= abs(n.y):
            axes = (0, 1)
        elif abs(n.x) >= abs(n.y):
            axes = (1, 2)
        else:
            axes = (0, 2)
        for li in poly.loop_indices:
            co = mesh.vertices[mesh.loops[li].vertex_index].co
            uv[li].uv.x = (co[axes[0]] / span) * 0.5 + 0.25
            uv[li].uv.y = (co[axes[1]] / span) * 0.5 + 0.25


def dominant_group(obj, vi):
    best = ""
    best_w = 0.0
    for g in obj.vertex_groups:
        try:
            w = g.weight(vi)
        except RuntimeError:
            continue
        if w > best_w:
            best = g.name
            best_w = w
    return best


MUZZLE_WORLD = []


def smooth_face(mesh, colors, tags, groups, worlds):
    """Average the face coat so the blaze edge is a soft band, not a row of teeth."""
    n = len(mesh.vertices)
    acc = np.zeros((n, 3), np.float32)
    cnt = np.zeros(n, np.float32)
    head = set()
    for li, tag in enumerate(tags):
        if tag != "coat":
            continue
        vi = mesh.loops[li].vertex_index
        w = worlds[vi]
        # Include ear-weighted verts that sit on the forehead. Those were the teeth.
        if w.z > 3.15 and w.y < -1.55 and abs(w.x) < 0.45:
            acc[vi] += colors[li]
            cnt[vi] += 1.0
            head.add(vi)
    if not head:
        return
    col = np.zeros((n, 3), np.float32)
    for vi in head:
        col[vi] = acc[vi] / cnt[vi]
    ids = np.array(sorted(head), np.int32)
    pts = np.array(
        [[worlds[int(i)].x, worlds[int(i)].y, worlds[int(i)].z] for i in ids],
        np.float32,
    )
    neighbors = [[] for _ in range(n)]
    for i, vi in enumerate(ids):
        dist = np.linalg.norm(pts - pts[i], axis=1)
        close = np.flatnonzero((dist > 1e-6) & (dist < 0.07))
        neighbors[int(vi)] = [int(ids[j]) for j in close]
    print("FACE_NEAR", round(float(np.mean([len(neighbors[int(i)]) for i in ids])), 1))
    for _ in range(4):
        nxt = col.copy()
        for vi in head:
            total = col[vi]
            count = 1.0
            for nb in neighbors[vi]:
                total = total + col[nb]
                count += 1.0
            nxt[vi] = total / count
        col = nxt
    for li, tag in enumerate(tags):
        if tag != "coat":
            continue
        vi = mesh.loops[li].vertex_index
        if vi in head:
            colors[li] = col[vi]
    print("FACE_SMOOTH", len(head))


def paint(obj, arm):
    global MUZZLE_WORLD
    mesh = obj.data
    ensure_uvs(obj)
    MUZZLE_WORLD = []
    mat_counts = {}
    for poly in mesh.polygons:
        name = ""
        if poly.material_index < len(mesh.materials) and mesh.materials[poly.material_index]:
            name = mesh.materials[poly.material_index].name.lower()
        mat_counts[name] = mat_counts.get(name, 0) + 1
        if "muzzle" in name:
            for vi in poly.vertices:
                MUZZLE_WORLD.append(obj.matrix_world @ mesh.vertices[vi].co)
    print("SRC_MATS", mat_counts, "muzzle_verts", len(MUZZLE_WORLD))
    groups = [dominant_group(obj, v.index) for v in mesh.vertices]
    worlds = [obj.matrix_world @ v.co for v in mesh.vertices]
    head_w = [w for w, g in zip(worlds, groups) if g in ("Head", "Jaw", "Neck3")]
    if head_w:
        print(
            "HEAD_WORLD x", round(min(p.x for p in head_w), 3), round(max(p.x for p in head_w), 3),
            "y", round(min(p.y for p in head_w), 3), round(max(p.y for p in head_w), 3),
            "z", round(min(p.z for p in head_w), 3), round(max(p.z for p in head_w), 3),
            "n", len(head_w),
        )

    zmin = min(v.co.z for v in mesh.vertices)
    zmax = max(v.co.z for v in mesh.vertices)
    sock_top = {}
    for bone_name in ("BackLowerLeg.L", "FrontLowerLeg.R"):
        zs = [worlds[i].z for i, g in enumerate(groups) if g == bone_name]
        if zs:
            lo, hi = min(zs), max(zs)
            sock_top[bone_name] = lo + 0.70 * (hi - lo)
            print("SOCK", bone_name, "top", round(sock_top[bone_name], 3), "lo", round(lo, 3), "n", len(zs))
    body_z = [worlds[i].z for i, g in enumerate(groups) if g in ("Torso", "Torso2", "Torso3", "Back", "Body")]
    topline_z = float(np.quantile(body_z, 0.85)) if body_z else 3.2
    belly_z = float(np.quantile(body_z, 0.15)) if body_z else 1.5
    print("TOPLINE_Z", round(topline_z, 3), "BELLY_Z", round(belly_z, 3))

    colors = np.zeros((len(mesh.loops), 3), np.float32)
    tags = ["coat"] * len(mesh.loops)
    for poly in mesh.polygons:
        mat = ""
        if poly.material_index < len(mesh.materials) and mesh.materials[poly.material_index]:
            mat = mesh.materials[poly.material_index].name.lower()
        for li in poly.loop_indices:
            vi = mesh.loops[li].vertex_index
            g = groups[vi]
            co = mesh.vertices[vi].co
            wpos = worlds[vi]
            # Darker along the back only. The head is the highest point on the
            # horse, so a height shade painted the face the same dark as the topline.
            col = CHESTNUT.copy()
            if g in ("Torso", "Torso2", "Torso3", "Back", "Body", ""):
                span = max(topline_z - belly_z, 1e-4)
                u = max(0.0, min(1.0, (wpos.z - belly_z) / span))
                shade = max(0.0, (u - 0.55) / 0.45) ** 1.3
                col = CHESTNUT * (1.0 - 0.62 * shade) + TOPLINE * (0.62 * shade)
                if 0.20 < u < 0.50 and abs(wpos.x) < 0.35:
                    col = col * 0.88 + BELLY * 0.12
            if g.startswith(("FrontUpper", "FrontLower", "BackUpper", "BackLower", "BackLeg")):
                col = CHESTNUT * 0.28 + LEG * 0.72
            # Soft blaze down the front of the face. Width and height both fade
            # across several vertices. A hard z cut sliced triangles into teeth.
            blaze_t = 0.0
            if g in ("Head", "Jaw") and wpos.y < -2.35 and 3.15 < wpos.z < 4.30:
                zn = max(0.0, min(1.0, (wpos.z - 3.25) / 0.90))
                half = 0.10 + 0.07 * zn
                nx = abs(wpos.x) / half
                edge = max(0.0, min(1.0, (1.35 - nx) / 0.90))
                edge = edge * edge * (3.0 - 2.0 * edge)
                front = max(0.0, min(1.0, (-2.35 - wpos.y) / 0.55))
                top = max(0.0, min(1.0, (4.22 - wpos.z) / 0.22))
                blaze_t = edge * front * top
            # White from the sock top down to the hoof. The old lower cut left a
            # dark band on the pastern, and the hoof material is named Hooves.
            is_sock = g in sock_top and wpos.z <= sock_top[g]
            tag = "coat"
            # Ear weights cover the poll. Darken the ear tip on the coat so the
            # base does not change material along a triangle edge.
            if g.startswith("Ear") and wpos.z > 4.40:
                t = max(0.0, min(1.0, (wpos.z - 4.40) / 0.30))
                t = t * t * (3.0 - 2.0 * t)
                col = col * (1.0 - t) + EAR * t
            elif mat.startswith("eye"):
                col = EYE
                tag = "eye"
            elif "hoove" in mat or "hoof" in mat:
                col = HOOF
                tag = "hoof"
            elif g.startswith("Tail"):
                col = TAIL
                tag = "tail"
            elif "hair" in mat and wpos.z > 3.55 and wpos.y > -2.15 and not g.startswith(("Head", "Ear", "Jaw")):
                # Neck crest only. Hair cards on the poll painted as light triangles.
                col = FLAX
                tag = "mane"
            elif "muzzle" in mat:
                col = PINK * (1.0 - blaze_t) + WHITE * blaze_t
            elif is_sock:
                col = WHITE
                tag = "sock"
            elif blaze_t > 0.0:
                col = col * (1.0 - blaze_t) + WHITE * blaze_t
            colors[li] = col
            tags[li] = tag

    print("COLOR_MEAN", [round(float(v), 3) for v in colors.mean(0)])
    palette = {
        # Linear colors. 0.45 was a pale tan under this exposure. The photo's
        # coat sits near sRGB (70, 45, 30).
        "coat": (1.0, 1.0, 1.0, 1.0),
        "blaze": (0.93, 0.90, 0.84, 1.0),
        "sock": (0.94, 0.92, 0.88, 1.0),
        "mane": (0.72, 0.62, 0.40, 1.0),
        "tail": (0.06, 0.022, 0.012, 1.0),
        "ear": (0.045, 0.014, 0.007, 1.0),
        "muzzle": (0.90, 0.68, 0.62, 1.0),
        "hoof": (0.09, 0.05, 0.03, 1.0),
        "eye": (0.03, 0.02, 0.015, 1.0),
    }
    mesh.materials.clear()
    slot = {}
    for poly in mesh.polygons:
        counts = {}
        for li in poly.loop_indices:
            counts[tags[li]] = counts.get(tags[li], 0) + 1
        tag = max(counts, key=counts.get)
        if tag not in slot:
            mat = bpy.data.materials.new("Abbott_" + tag)
            mat.use_nodes = True
            bsdf = next(n for n in mat.node_tree.nodes if n.type == "BSDF_PRINCIPLED")
            bsdf.inputs["Base Color"].default_value = palette.get(tag, palette["coat"])
            if tag == "coat":
                vc = mat.node_tree.nodes.new("ShaderNodeVertexColor")
                vc.layer_name = "Col"
                mat.node_tree.links.new(vc.outputs["Color"], bsdf.inputs["Base Color"])
            rough = 0.58
            if tag == "eye":
                rough = 0.15
            elif tag == "hoof":
                rough = 0.4
            bsdf.inputs["Roughness"].default_value = rough
            mesh.materials.append(mat)
            slot[tag] = len(mesh.materials) - 1
        poly.material_index = slot[tag]
    print("FACE_MATS", {k: sum(1 for p in mesh.polygons if p.material_index == slot[k]) for k in slot})
    # One welded color layer. Coat reads it. Other materials stay their own color,
    # so those corners are white and do not tint the glTF import.
    while len(mesh.color_attributes):
        mesh.color_attributes.remove(mesh.color_attributes[0])
    attr = mesh.color_attributes.new(name="Col", type="FLOAT_COLOR", domain="CORNER")
    flat = np.ones((len(mesh.loops), 4), np.float32)
    # Coat faces read this layer. A corner tagged ear or mane on a coat face
    # used to stay at the default white, which drew the jagged forehead.
    # Other materials keep white corners so they are not tinted on import.
    coat_slot = slot.get("coat")
    if coat_slot is not None:
        for poly in mesh.polygons:
            if poly.material_index != coat_slot:
                continue
            for li in poly.loop_indices:
                flat[li, 0:3] = colors[li]
    attr.data.foreach_set("color", flat.ravel())

    uv = mesh.uv_layers.active.data
    w = h = 2048
    buf = np.zeros((h, w, 4), np.float32)
    for poly in mesh.polygons:
        ids = list(poly.loop_indices)
        if len(ids) < 3:
            continue
        for a, b, c in ((0, 1, 2),) if len(ids) == 3 else tuple((0, i, i + 1) for i in range(1, len(ids) - 1)):
            ia, ib, ic = ids[a], ids[b], ids[c]
            pts = np.array([
                [uv[ia].uv.x * (w - 1), uv[ia].uv.y * (h - 1)],
                [uv[ib].uv.x * (w - 1), uv[ib].uv.y * (h - 1)],
                [uv[ic].uv.x * (w - 1), uv[ic].uv.y * (h - 1)],
            ], np.float32)
            cols = np.stack([colors[ia], colors[ib], colors[ic]])
            raster(buf, pts, cols)
    dilate(buf, 4)
    empty = buf[:, :, 3] < 0.5
    buf[empty, 0] = float(CHESTNUT[0])
    buf[empty, 1] = float(CHESTNUT[1])
    buf[empty, 2] = float(CHESTNUT[2])
    buf[empty, 3] = 1.0
    filled = int(np.count_nonzero(buf[:, :, 3] > 0.5))
    print("PAINT_FILL", filled, "of", w * h)
    img = bpy.data.images.new("abbott_v2_coat", width=w, height=h, alpha=False)
    img.colorspace_settings.name = "Non-Color"
    flat = np.ascontiguousarray(buf, dtype=np.float32).reshape(-1)
    img.pixels.foreach_set(flat)
    img.update()
    return img


def raster(buf, pts, cols):
    h, w, _ = buf.shape
    v0 = pts[1] - pts[0]
    v1 = pts[2] - pts[0]
    den = float(v0[0] * v1[1] - v1[0] * v0[1])
    if abs(den) < 1e-5:
        return
    minx = max(int(math.floor(float(pts[:, 0].min()))) - 1, 0)
    maxx = min(int(math.ceil(float(pts[:, 0].max()))) + 1, w - 1)
    miny = max(int(math.floor(float(pts[:, 1].min()))) - 1, 0)
    maxy = min(int(math.ceil(float(pts[:, 1].max()))) + 1, h - 1)
    if minx > maxx or miny > maxy:
        return
    xs = np.arange(minx, maxx + 1, dtype=np.float32) + 0.5
    ys = np.arange(miny, maxy + 1, dtype=np.float32) + 0.5
    gx, gy = np.meshgrid(xs, ys)
    vx = gx - float(pts[0, 0])
    vy = gy - float(pts[0, 1])
    w1 = (vx * float(v1[1]) - float(v1[0]) * vy) / den
    w2 = (float(v0[0]) * vy - vx * float(v0[1])) / den
    w0 = 1.0 - w1 - w2
    mask = (w0 >= -0.02) & (w1 >= -0.02) & (w2 >= -0.02)
    if not np.any(mask):
        return
    rgb = (
        w0[..., None] * cols[0]
        + w1[..., None] * cols[1]
        + w2[..., None] * cols[2]
    )
    view = buf[miny : maxy + 1, minx : maxx + 1]
    view[mask, :3] = np.clip(rgb[mask], 0.0, 1.0)
    view[mask, 3] = 1.0


def edge(a, b, c):
    return (c[..., 0] - a[0]) * (b[1] - a[1]) - (c[..., 1] - a[1]) * (b[0] - a[0])


def dilate(buf, times):
    mask = buf[:, :, 3] > 0.5
    for _ in range(times):
        color = buf.copy()
        grown = mask.copy()
        for dy, dx in ((0, 1), (0, -1), (1, 0), (-1, 0)):
            src = np.roll(np.roll(buf, dy, axis=0), dx, axis=1)
            sm = np.roll(np.roll(mask, dy, axis=0), dx, axis=1)
            take = (~mask) & sm
            color[take] = src[take]
            grown |= sm
        buf[:] = color
        mask = grown


def assign_coat(obj, img):
    # Face materials already carry the coat. The png is the same paint on disk.
    return


def cylinder(p0, p1, radius):
    d = p1 - p0
    length = d.length
    if length < 1e-4:
        return None
    bpy.ops.mesh.primitive_cylinder_add(vertices=8, radius=radius, depth=length, location=(p0 + p1) * 0.5)
    obj = bpy.context.active_object
    obj.rotation_euler = d.to_track_quat("Z", "Y").to_euler()
    return obj


def add_bridle(obj, arm):
    if len(MUZZLE_WORLD) < 8:
        print("BRIDLE no muzzle")
        return None
    pts = np.array([[p.x, p.y, p.z] for p in MUZZLE_WORLD], np.float32)
    # Horse faces -Y. Mouth is the front (low Y) and lower part of the muzzle.
    y_cut = float(np.quantile(pts[:, 1], 0.40))
    front = pts[pts[:, 1] <= y_cut]
    if len(front) < 4:
        front = pts
    z_cut = float(np.median(front[:, 2]))
    mouth = front[front[:, 2] <= z_cut + 0.02]
    if len(mouth) < 4:
        mouth = front
    left = mouth[int(np.argmax(mouth[:, 0]))]
    right = mouth[int(np.argmin(mouth[:, 0]))]
    bit_l = mathutils.Vector((float(left[0]), float(left[1]), float(np.quantile(mouth[:, 2], 0.55))))
    bit_r = mathutils.Vector((float(right[0]), float(right[1]), float(bit_l.z)))
    bone = arm.data.bones["Head"]
    rest_m = arm.matrix_world @ bone.matrix_local
    poll = rest_m.to_translation().copy()
    poll.z += 0.12
    width = max((bit_l - bit_r).length, 0.2)
    mid = (bit_l + bit_r) * 0.5
    up = mathutils.Vector((0.0, 0.0, 1.0))
    side = (bit_l - bit_r).normalized()
    brow = poll.lerp(mid, 0.45)
    brow_l = brow + side * (width * 0.42) + up * 0.06
    brow_r = brow - side * (width * 0.42) + up * 0.06
    nose = poll.lerp(mid, 0.78)
    nose_l = nose + side * (width * 0.46)
    nose_r = nose - side * (width * 0.46)
    crown_l = poll + side * (width * 0.28) + up * 0.04
    crown_r = poll - side * (width * 0.28) + up * 0.04
    rad = max(width * 0.06, 0.035)
    print("BRIDLE width", round(width, 3), "poll", tuple(round(c, 3) for c in poll), "mid", tuple(round(c, 3) for c in mid))
    parts = []
    pairs = [
        (crown_l, crown_r),
        (brow_l, brow_r),
        (nose_l, nose_r),
        (crown_l, brow_l),
        (crown_r, brow_r),
        (brow_l, bit_l),
        (brow_r, bit_r),
        (nose_l, bit_l),
        (nose_r, bit_r),
    ]
    for a, b in pairs:
        part = cylinder(a, b, rad)
        if part:
            parts.append(part)
    ring_r = max(width * 0.14, 0.05)
    for loc in (bit_l, bit_r):
        bpy.ops.mesh.primitive_torus_add(
            major_radius=ring_r,
            minor_radius=rad * 0.55,
            location=loc,
            major_segments=16,
            minor_segments=8,
        )
        parts.append(bpy.context.active_object)
    for part in parts:
        part.select_set(True)
    bpy.context.view_layer.objects.active = parts[0]
    bpy.ops.object.join()
    bridle = bpy.context.active_object
    bridle.name = "Bridle"
    world = bridle.matrix_world.copy()
    bridle.parent = arm
    bpy.context.view_layer.update()
    bridle.matrix_world = world
    print("BRIDLE scale", tuple(round(v, 3) for v in bridle.matrix_world.to_scale()))
    leather = bpy.data.materials.new("BridleLeather")
    leather.use_nodes = True
    bsdf = next(n for n in leather.node_tree.nodes if n.type == "BSDF_PRINCIPLED")
    bsdf.inputs["Base Color"].default_value = (0.36, 0.18, 0.09, 1.0)
    bsdf.inputs["Roughness"].default_value = 0.5
    bridle.data.materials.append(leather)
    vg = bridle.vertex_groups.new(name="Head")
    vg.add(list(range(len(bridle.data.vertices))), 1.0, "REPLACE")
    jaw = bridle.vertex_groups.new(name="Jaw")
    # Front half of the bridle follows the jaw a little.
    jaw_ids = []
    center = sum((v.co for v in bridle.data.vertices), mathutils.Vector()) / len(bridle.data.vertices)
    for v in bridle.data.vertices:
        if (v.co - center).length > width * 0.2:
            jaw_ids.append(v.index)
    if jaw_ids:
        jaw.add(jaw_ids, 0.35, "REPLACE")
        vg.add(jaw_ids, 0.65, "REPLACE")
    mod = bridle.modifiers.new("Arm", "ARMATURE")
    mod.object = arm
    for name, loc in (("BitL", bit_l), ("BitR", bit_r)):
        empty = bpy.data.objects.new(name, None)
        empty.empty_display_type = "SPHERE"
        empty.empty_display_size = rad * 1.4
        bpy.context.scene.collection.objects.link(empty)
        empty.matrix_world = mathutils.Matrix.Translation(loc)
        world = empty.matrix_world.copy()
        empty.parent = arm
        empty.parent_type = "BONE"
        empty.parent_bone = "Head"
        empty.matrix_parent_inverse = rest_m.inverted()
        empty.matrix_world = world
        bpy.context.view_layer.update()
        got = empty.matrix_world.translation
        print("BIT", name, "want", tuple(round(c, 3) for c in loc), "got", tuple(round(c, 3) for c in got))
    print("BRIDLE parts joined", len(bridle.data.polygons))
    return bridle


def export(path, arm):
    for o in bpy.context.scene.objects:
        o.select_set(False)
    arm.select_set(True)
    for o in bpy.context.scene.objects:
        if o.name == "Icosphere":
            continue
        if o.type == "MESH" or o.type == "EMPTY":
            o.select_set(True)
    bpy.context.view_layer.objects.active = arm
    bpy.ops.export_scene.gltf(
        filepath=path,
        export_format="GLB",
        use_selection=True,
        export_yup=True,
        export_apply=False,
        export_animations=True,
        export_animation_mode="ACTIONS",
        export_skins=True,
        export_morph=False,
        export_lights=False,
        export_cameras=False,
    )
    print("EXPORTED", path, os.path.getsize(path))


def main():
    args = argv_after()
    src, out_glb, coat_png = args[0], args[1], args[2]
    bpy.ops.wm.read_factory_settings(use_empty=True)
    bpy.ops.import_scene.gltf(filepath=src)
    arm = armature()
    obj = horse_mesh(arm)
    print("HORSE", obj.name, len(obj.data.polygons))
    build_gaits(arm)
    smooth_body(obj)
    img = paint(obj, arm)
    os.makedirs(os.path.dirname(coat_png), exist_ok=True)
    img.filepath_raw = coat_png
    img.file_format = "PNG"
    img.save()
    print("COAT", coat_png)
    assign_coat(obj, img)
    add_bridle(obj, arm)
    for o in list(bpy.context.scene.objects):
        if o.name == "Icosphere":
            print("DROP Icosphere")
            bpy.data.objects.remove(o, do_unlink=True)
            continue
        if o.type != "MESH":
            continue
        dims = o.dimensions
        print("DIM", o.name, tuple(round(v, 3) for v in dims))
        if max(dims) > 40.0:
            print("DROP huge", o.name)
            bpy.data.objects.remove(o, do_unlink=True)
    if arm.animation_data:
        arm.animation_data.action = None
    bpy.context.scene.frame_set(0)
    export(out_glb, arm)
    names = sorted(a.name for a in bpy.data.actions)
    print("ACTIONS_OUT", ",".join(names))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
