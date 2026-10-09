"""Fixed look-gate cameras for a horse glb. Headless Eevee only.

    blender -b --factory-startup -P blender_render.py -- <glb> <outdir>
        [--pose Action frame] [--strips Walk,Gallop] [--strip-frames 6]
        [--stills-only] [--strips-only] [--inspect]
"""
import json
import math
import os
import sys

import bpy
import mathutils

SAND = (0.76, 0.64, 0.46, 1.0)
SKY = (0.64, 0.72, 0.82, 1.0)
STILL_W, STILL_H = 960, 540
STRIP_W, STRIP_H = 800, 450


def argv_after() -> list:
    if "--" not in sys.argv:
        return []
    return sys.argv[sys.argv.index("--") + 1 :]


def flag(args: list, name: str, default=None):
    if name not in args:
        return default
    i = args.index(name)
    if i + 1 >= len(args) or args[i + 1].startswith("--"):
        return True
    return args[i + 1]


def engine_name() -> str:
    items = bpy.types.RenderSettings.bl_rna.properties["engine"].enum_items
    ids = [e.identifier for e in items]
    if "BLENDER_EEVEE" in ids:
        return "BLENDER_EEVEE"
    return "BLENDER_EEVEE_NEXT"


def mesh_bounds():
    mn = mathutils.Vector((1e9, 1e9, 1e9))
    mx = mathutils.Vector((-1e9, -1e9, -1e9))
    meshes = [o for o in bpy.context.scene.objects if o.type == "MESH"]
    for o in meshes:
        for c in o.bound_box:
            w = o.matrix_world @ mathutils.Vector(c)
            mn = mathutils.Vector(map(min, mn, w))
            mx = mathutils.Vector(map(max, mx, w))
    return mn, mx, meshes


def armature():
    arms = [o for o in bpy.context.scene.objects if o.type == "ARMATURE"]
    if not arms:
        return None
    arms.sort(key=lambda o: len(o.data.bones), reverse=True)
    return arms[0]


def set_action(arm, action):
    ad = arm.animation_data_create()
    ad.action = action
    slots = list(getattr(action, "slots", []) or [])
    if slots and hasattr(ad, "action_slot"):
        chosen = slots[0]
        for s in slots:
            ident = getattr(s, "identifier", "") or getattr(s, "name", "")
            if arm.name in str(ident) or "OBJECT" in str(ident):
                chosen = s
                break
        try:
            ad.action_slot = chosen
            print("SLOT", getattr(chosen, "identifier", chosen))
        except Exception as exc:
            print("SLOT_FAIL", exc)
    bpy.context.view_layer.update()


def pose_frame(arm, action_name: str, frame: float):
    action = bpy.data.actions.get(action_name)
    if action is None or arm is None:
        print("POSE missing", action_name)
        return
    set_action(arm, action)
    bpy.context.scene.frame_set(int(round(frame)))
    bpy.context.view_layer.update()


def bone_tail(arm, name: str):
    pb = arm.pose.bones.get(name)
    if pb is None:
        return None
    bone = arm.data.bones[name]
    world = arm.matrix_world @ pb.matrix
    return world @ mathutils.Vector((0.0, bone.length, 0.0))


def aim(obj, target):
    # Camera looks along local -Z. Local +Y is up, which is world +Z.
    direction = mathutils.Vector(target) - obj.location
    obj.rotation_euler = direction.to_track_quat("-Z", "Y").to_euler()


def add_camera(name, location, target, lens):
    cam = bpy.data.cameras.new(name)
    cam.lens = lens
    cam.clip_end = 200.0
    obj = bpy.data.objects.new(name, cam)
    bpy.context.scene.collection.objects.link(obj)
    obj.location = mathutils.Vector(location)
    aim(obj, target)
    return obj


def setup_world(mn, mx):
    sc = bpy.context.scene
    sc.render.engine = engine_name()
    sc.render.film_transparent = False
    sc.render.image_settings.file_format = "PNG"
    if hasattr(sc, "eevee"):
        ee = sc.eevee
        if hasattr(ee, "taa_render_samples"):
            ee.taa_render_samples = 2
        if hasattr(ee, "use_raytracing"):
            ee.use_raytracing = False
        if hasattr(ee, "use_shadows"):
            ee.use_shadows = True
    try:
        sc.view_settings.view_transform = "AgX"
    except Exception:
        pass
    sc.view_settings.exposure = 0.15

    world = bpy.data.worlds.new("sky")
    sc.world = world
    world.use_nodes = True
    bg = world.node_tree.nodes.get("Background")
    if bg:
        bg.inputs[0].default_value = SKY
        bg.inputs[1].default_value = 0.85

    sun_data = bpy.data.lights.new("sun", "SUN")
    sun_data.energy = 3.2
    sun_data.angle = math.radians(3.0)
    sun_data.use_shadow = True
    sun = bpy.data.objects.new("sun", sun_data)
    sc.collection.objects.link(sun)
    # Light travels downward at 35 degrees above the horizon.
    elev = math.radians(35.0)
    az = math.radians(48.0)
    travel = mathutils.Vector((
        math.cos(elev) * math.sin(az),
        -math.cos(elev) * math.cos(az),
        -math.sin(elev),
    ))
    sun.rotation_euler = travel.to_track_quat("-Z", "Z").to_euler()

    ground_z = mn.z - 0.02
    bpy.ops.mesh.primitive_plane_add(size=1.0, location=((mn.x + mx.x) * 0.5, (mn.y + mx.y) * 0.5, ground_z))
    plane = bpy.context.active_object
    span = max(mx.x - mn.x, mx.y - mn.y, 1.0)
    plane.scale = (span * 4.0, span * 4.0, 1.0)
    mat = bpy.data.materials.new("sand")
    mat.use_nodes = True
    principled = mat.node_tree.nodes.get("Principled BSDF")
    if principled:
        principled.inputs["Base Color"].default_value = SAND
        principled.inputs["Roughness"].default_value = 0.92
    plane.data.materials.append(mat)
    return sc


def cameras(arm, mn, mx):
    ctr = (mn + mx) * 0.5
    height = max(mx.z - mn.z, 0.01)
    ctr.z = mn.z + height * 0.46
    fwd = mathutils.Vector((0.0, -1.0, 0.0))
    head_pt = mathutils.Vector(ctr)
    if arm and arm.pose.bones.get("Head"):
        head_world = arm.matrix_world @ arm.pose.bones["Head"].head
        head_pt = mathutils.Vector(head_world)
        if arm.pose.bones.get("Tail1"):
            tail_world = arm.matrix_world @ arm.pose.bones["Tail1"].head
            fwd = head_pt - tail_world
            fwd.z = 0.0
            if fwd.length > 0.001:
                fwd.normalize()
    side = mathutils.Vector((0.0, 0.0, 1.0)).cross(fwd)
    if side.length < 0.001:
        side = mathutils.Vector((1.0, 0.0, 0.0))
    side.normalize()
    horiz = max(mx.x - mn.x, mx.y - mn.y, 0.01)
    dist = horiz * 2.6
    print("CAM fwd", tuple(round(v, 3) for v in fwd), "horiz", round(horiz, 3), "head", tuple(round(v, 3) for v in head_pt))
    cams = {
        "side": (ctr - side * dist + mathutils.Vector((0, 0, height * 0.08)), ctr, 38),
        "threequarter": (
            ctr + fwd * dist * 0.78 - side * dist * 0.62 + mathutils.Vector((0, 0, height * 0.22)),
            ctr,
            36,
        ),
        "head": (
            head_pt + fwd * horiz * 0.42 - side * horiz * 0.22 + mathutils.Vector((0, 0, horiz * 0.08)),
            head_pt + mathutils.Vector((0, 0, horiz * 0.02)),
            55,
        ),
        "rear": (
            ctr - fwd * dist * 0.85 + side * dist * 0.38 + mathutils.Vector((0, 0, height * 0.55)),
            ctr + mathutils.Vector((0, 0, height * 0.06)),
            34,
        ),
    }
    out = {}
    for name, (loc, target, lens) in cams.items():
        out[name] = add_camera(name, loc, target, lens)
    return out


def render_to(sc, cam, path, w, h):
    sc.camera = cam
    sc.render.resolution_x = w
    sc.render.resolution_y = h
    sc.render.resolution_percentage = 100
    sc.render.filepath = path
    bpy.ops.render.render(write_still=True)
    print("WROTE", path)


def action_fcurves(action):
    curves = list(getattr(action, "fcurves", []) or [])
    if curves:
        return curves
    layers = getattr(action, "layers", None)
    if not layers:
        return []
    found = []
    for layer in layers:
        for strip in getattr(layer, "strips", []) or []:
            bags = []
            if hasattr(strip, "channelbags"):
                bags = list(strip.channelbags)
            elif hasattr(strip, "channelbag"):
                slots = list(getattr(action, "slots", []) or [])
                for slot in slots:
                    try:
                        bags.append(strip.channelbag(slot))
                    except Exception:
                        pass
            for bag in bags:
                if bag:
                    found.extend(list(getattr(bag, "fcurves", []) or []))
    return found


def inspect(arm, mn, mx, meshes, outdir):
    print("BOUNDS", tuple(round(v, 3) for v in mn), tuple(round(v, 3) for v in mx))
    print("ENGINE", bpy.context.scene.render.engine)
    info = {"bounds_min": list(mn), "bounds_max": list(mx), "actions": {}, "bones": [], "meshes": []}
    if arm:
        info["bones"] = [b.name for b in arm.data.bones]
        print("BONES", len(info["bones"]))
        print("BONE_NAMES", ",".join(info["bones"]))
    for o in meshes:
        uv = None
        if o.data.uv_layers:
            uv = o.data.uv_layers.active.name if o.data.uv_layers.active else o.data.uv_layers[0].name
        mats = [m.name if m else "" for m in o.data.materials]
        edge_uses = {}
        for poly in o.data.polygons:
            for key in poly.edge_keys:
                edge_uses[key] = edge_uses.get(key, 0) + 1
        boundary = sum(1 for n in edge_uses.values() if n == 1)
        print("MESH", o.name, "polys", len(o.data.polygons), "verts", len(o.data.vertices), "uv", uv, "boundary", boundary, "mats", mats)
        info["meshes"].append({
            "name": o.name,
            "polys": len(o.data.polygons),
            "verts": len(o.data.vertices),
            "uv": uv,
            "materials": mats,
        })
    hoof_names = []
    if arm:
        hoof_names = [n for n in ("FF.L", "FF.R", "FFB.L", "FFB.R") if arm.data.bones.get(n)]
        print("HOOF_BONES", ",".join(hoof_names))
    for action in bpy.data.actions:
        curves = action_fcurves(action)
        print("ACTION", action.name, "frames", tuple(action.frame_range), "fcurves", len(curves))
        info["actions"][action.name] = {
            "start": action.frame_range[0],
            "end": action.frame_range[1],
            "fcurves": len(curves),
        }
    # Foot height along Walk and Gallop so the new clips can copy real extremes.
    if arm and hoof_names:
        for clip in ("Walk", "Gallop"):
            action = bpy.data.actions.get(clip)
            if action is None:
                continue
            start = int(math.floor(action.frame_range[0]))
            end = int(math.ceil(action.frame_range[1]))
            rows = []
            for frame in range(start, end + 1):
                pose_frame(arm, clip, frame)
                zs = {}
                for name in hoof_names:
                    tail = bone_tail(arm, name)
                    if tail:
                        zs[name] = round(tail.z, 4)
                rows.append({"frame": frame, "z": zs})
            info.setdefault("hooves", {})[clip] = rows
            # One line per frame: name=z, lowest first.
            for row in rows:
                ordered = sorted(row["z"].items(), key=lambda kv: kv[1])
                brief = " ".join("%s:%.3f" % (k, v) for k, v in ordered[:4])
                print("HOOF", clip, row["frame"], brief)
    path = os.path.join(outdir, "inspect.json")
    os.makedirs(outdir, exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        json.dump(info, f)
    print("INSPECT", path)
    return info


def main():
    args = argv_after()
    if len(args) < 2:
        print("NEED glb outdir")
        return 2
    src, outdir = args[0], args[1]
    os.makedirs(outdir, exist_ok=True)
    bpy.ops.wm.read_factory_settings(use_empty=True)
    bpy.ops.import_scene.gltf(filepath=src)
    mn, mx, meshes = mesh_bounds()
    arm = armature()
    inspect(arm, mn, mx, meshes, outdir)
    if "--inspect" in args and "--pose" not in args and "--strips" not in args and "--stills" not in args:
        # Still render when the caller asked for cameras. --inspect-only skips pictures.
        if "--inspect-only" in args:
            return 0
    setup_world(mn, mx)
    # Recompute bounds after the ground plane exists; cameras use the horse only.
    if arm:
        idle = bpy.data.actions.get("Idle")
        if idle:
            pose_frame(arm, "Idle", idle.frame_range[0])
    cams = cameras(arm, mn, mx)
    sc = bpy.context.scene
    pose = flag(args, "--pose")
    if pose and pose is not True:
        i = args.index("--pose")
        action_name = args[i + 1]
        frame = float(args[i + 2])
        pose_frame(arm, action_name, frame)
        render_to(sc, cams["side"], os.path.join(outdir, "pose_%s_%03d.png" % (action_name, int(frame))), STILL_W, STILL_H)
        return 0
    if "--strips-only" not in args:
        for name, cam in cams.items():
            render_to(sc, cam, os.path.join(outdir, name + ".png"), STILL_W, STILL_H)
    strips = flag(args, "--strips", "")
    nframes = int(flag(args, "--strip-frames", "6") or 6)
    if strips and strips is not True:
        for clip in [s.strip() for s in str(strips).split(",") if s.strip()]:
            action = bpy.data.actions.get(clip)
            if action is None:
                print("STRIP missing", clip)
                continue
            start, end = action.frame_range
            folder = os.path.join(outdir, "strip_" + clip)
            os.makedirs(folder, exist_ok=True)
            for i in range(nframes):
                if nframes == 1:
                    frame = start
                else:
                    frame = start + (end - start) * i / float(nframes - 1)
                pose_frame(arm, clip, frame)
                render_to(
                    sc,
                    cams["side"],
                    os.path.join(folder, "f%02d.png" % i),
                    STRIP_W,
                    STRIP_H,
                )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
