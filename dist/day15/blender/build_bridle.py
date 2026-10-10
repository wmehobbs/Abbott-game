"""Give abbott_v2 a real bridle, fitted to his head, and export it with the
skinned meshes as siblings of the armature (the layout glb_to_quaternius_layout
expects). Straps: crownpiece and throatlatch behind the ears, browband, two
cheekpieces to the bit, a cavesson noseband, and bit rings at the mouth.
Every strap point is cast onto his coat and lifted off it, and the bridle is
weighted 100% to the Head bone, so it moves with his head.

usage: blender -b --factory-startup -P build_bridle.py -- <src v2.glb> <dst.glb>
"""
import math
import sys

import bmesh
import bpy
import mathutils
from mathutils.bvhtree import BVHTree

argv = sys.argv[sys.argv.index("--") + 1:]
src, dst = argv[0], argv[1]
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.gltf(filepath=src)
sc = bpy.context.scene
arm = [o for o in sc.objects if o.type == "ARMATURE"][0]
root = arm.parent
horse = [o for o in sc.objects if o.type == "MESH" and o.name == "Horse"][0]
old = [o for o in sc.objects if o.type == "MESH" and o.name == "Bridle"]
for o in list(sc.objects):
    if o.type == "MESH" and o.name.startswith("Icosphere"):
        bpy.data.objects.remove(o, do_unlink=True)

dg = bpy.context.evaluated_depsgraph_get()
ev = horse.evaluated_get(dg)
me = ev.to_mesh()
mw = horse.matrix_world
verts = [mw @ v.co for v in me.vertices]
polys = [list(p.vertices) for p in me.polygons]
bvh = BVHTree.FromPolygons(verts, polys)

# Head vertices, from the Head bone's weights on the source mesh.
gi = horse.vertex_groups["Head"].index
head_v = []
for v in horse.data.vertices:
    for g in v.groups:
        if g.group == gi and g.weight > 0.6:
            head_v.append(mw @ v.co)
tip = min(head_v, key=lambda p: p.y)
poll = max(head_v, key=lambda p: p.z)
axis = (tip - poll).normalized()
print("HEAD tip", tuple(round(x, 3) for x in tip), "poll", tuple(round(x, 3) for x in poll), "verts", len(head_v))

# Mouth corners: Cursor's bit rings sit there.
if old:
    ov = [old[0].matrix_world @ v.co for v in old[0].data.vertices]
    lft = [p for p in ov if p.x > 0.05]
    rgt = [p for p in ov if p.x < -0.05]
    lo_l = min(lft, key=lambda p: p.z)
    lo_r = min(rgt, key=lambda p: p.z)
    bit_l = mathutils.Vector((max(p.x for p in lft) * 0.92, lo_l.y, lo_l.z + 0.05))
    bit_r = mathutils.Vector((min(p.x for p in rgt) * 0.92, lo_r.y, lo_r.z + 0.05))
else:
    bit_l = tip + mathutils.Vector((0.15, 0.25, 0.05))
    bit_r = tip + mathutils.Vector((-0.15, 0.25, 0.05))
print("BIT", tuple(round(x, 3) for x in bit_l), tuple(round(x, 3) for x in bit_r))

LIFT = 0.022


def surf(p, toward_out):
    """The coat point outside p along toward_out, lifted off the coat."""
    o = p + toward_out * 3.0
    hit = bvh.ray_cast(o, -toward_out, 6.0)
    if hit[0] is None:
        loc, nrm, _, _ = bvh.find_nearest(p)
        return loc + nrm * LIFT, nrm
    loc, nrm = hit[0], hit[1]
    if nrm.dot(toward_out) < 0:
        nrm = -nrm
    return loc + nrm * LIFT, nrm


def ring(center, normal, n=28, a0=0.0, a1=2 * math.pi):
    u = normal.cross(mathutils.Vector((1, 0, 0)))
    if u.length < 1e-4:
        u = normal.cross(mathutils.Vector((0, 1, 0)))
    u.normalize()
    v = normal.cross(u).normalized()
    pts = []
    for i in range(n + 1):
        a = a0 + (a1 - a0) * i / n
        d = (u * math.cos(a) + v * math.sin(a)).normalized()
        pts.append(surf(center, d))
    return pts, u, v


def line(a, b, n=16):
    """Along the coat from a to b."""
    pts = []
    for i in range(n + 1):
        p = a.lerp(b, i / n)
        loc, nrm, _, _ = bvh.find_nearest(p)
        out = (p - loc)
        if out.length < 1e-5 or out.dot(nrm) < 0:
            out = nrm
        pts.append((loc + nrm * LIFT, nrm))
    return pts


bm = bmesh.new()


def ribbon(pts, width, thick, closed=False):
    if len(pts) < 2:
        return
    rows = []
    k = len(pts)
    for i in range(k):
        p, nrm = pts[i]
        a = pts[i - 1][0] if (i > 0 or closed) else pts[i][0]
        b = pts[(i + 1) % k][0] if (i < k - 1 or closed) else pts[i][0]
        t = (b - a)
        if t.length < 1e-6:
            t = mathutils.Vector((0, 1, 0))
        t.normalize()
        side = t.cross(nrm).normalized()
        w = side * (width * 0.5)
        rows.append([bm.verts.new(p + w), bm.verts.new(p - w), bm.verts.new(p - w - nrm * thick), bm.verts.new(p + w - nrm * thick)])
    last = k if closed else k - 1
    for i in range(last):
        r0, r1 = rows[i], rows[(i + 1) % k]
        for j in range(4):
            j2 = (j + 1) % 4
            try:
                bm.faces.new((r0[j], r0[j2], r1[j2], r1[j]))
            except ValueError:
                pass


def torus_at(c, axis_v, r_major, r_minor, seg=16, ring_seg=6):
    axis_v = axis_v.normalized()
    u = axis_v.cross(mathutils.Vector((0, 0, 1)))
    if u.length < 1e-4:
        u = axis_v.cross(mathutils.Vector((1, 0, 0)))
    u.normalize()
    v = axis_v.cross(u).normalized()
    grid = []
    for i in range(seg):
        a = 2 * math.pi * i / seg
        cdir = u * math.cos(a) + v * math.sin(a)
        rowv = []
        for j in range(ring_seg):
            b = 2 * math.pi * j / ring_seg
            p = c + cdir * (r_major + r_minor * math.cos(b)) + axis_v * (r_minor * math.sin(b))
            rowv.append(bm.verts.new(p))
        grid.append(rowv)
    for i in range(seg):
        for j in range(ring_seg):
            a = grid[i][j]
            b = grid[(i + 1) % seg][j]
            c2 = grid[(i + 1) % seg][(j + 1) % ring_seg]
            d = grid[i][(j + 1) % ring_seg]
            bm.faces.new((a, b, c2, d))


def bone_head(name):
    b = arm.data.bones[name]
    return arm.matrix_world @ b.head_local


ear_mid = (bone_head("Ear1.L") + bone_head("Ear1.R")) * 0.5
muzzle = tip + mathutils.Vector((0, 0.10, 0.02))
# The head's long axis, from between the ears (down at the skull's middle)
# to the muzzle.
skull = ear_mid + mathutils.Vector((0, 0, -0.30))
hax = (muzzle - skull).normalized()
hlen = (muzzle - skull).length
print("EARS", tuple(round(x, 3) for x in ear_mid), "axis", tuple(round(x, 3) for x in hax))


def section(center, normal, n=72):
    """A smooth loop around his head in the plane (center, normal), lifted off
    the coat. Concave dips (eyes, jaw groove) are bridged, not followed."""
    u = normal.cross(mathutils.Vector((1, 0, 0)))
    if u.length < 1e-4:
        u = normal.cross(mathutils.Vector((0, 1, 0)))
    u.normalize()
    v = normal.cross(u).normalized()
    rad = []
    for i in range(n):
        a = 2 * math.pi * i / n
        d = u * math.cos(a) + v * math.sin(a)
        hit = bvh.ray_cast(center + d * 3.0, -d, 6.0)
        r = (hit[0] - center).length if hit[0] is not None else 0.3
        rad.append(r)
    # Bridge dips: the max over a small window, then smooth.
    big = [max(rad[(i + k) % n] for k in range(-3, 4)) for i in range(n)]
    sm = [sum(big[(i + k) % n] for k in range(-3, 4)) / 7.0 for i in range(n)]
    pts = []
    for i in range(n):
        a = 2 * math.pi * i / n
        d = u * math.cos(a) + v * math.sin(a)
        pts.append((center + d * (sm[i] + LIFT), d))
    return pts


bm_rows = []


def band(pts, width, thick, normal, closed=True):
    """A flat strap along pts; width lies along the plane normal, thickness
    toward the head."""
    k = len(pts)
    rows = []
    for p, out in pts:
        w = normal * (width * 0.5)
        rows.append([bm.verts.new(p + w), bm.verts.new(p - w), bm.verts.new(p - w - out * thick), bm.verts.new(p + w - out * thick)])
    last = k if closed else k - 1
    for i in range(last):
        r0, r1 = rows[i], rows[(i + 1) % k]
        for j in range(4):
            j2 = (j + 1) % 4
            bm.faces.new((r0[j], r0[j2], r1[j2], r1[j]))


def strap(a, b, width, thick, n=24):
    """A strap over his coat from a to b, pushed out from the head's axis."""
    raw = []
    for i in range(n + 1):
        p = a.lerp(b, i / n)
        # Outward from the axis line.
        t = (p - skull).dot(hax)
        c = skull + hax * t
        out = (p - c)
        out = out.normalized() if out.length > 1e-5 else mathutils.Vector((1, 0, 0))
        hit = bvh.ray_cast(c + out * 3.0, -out, 6.0)
        q = hit[0] if hit[0] is not None else p
        raw.append((q, out))
    pts = []
    for i in range(len(raw)):
        lo, hi = max(0, i - 2), min(len(raw) - 1, i + 2)
        q = sum((raw[j][0] for j in range(lo, hi + 1)), mathutils.Vector()) / (hi - lo + 1)
        o = sum((raw[j][1] for j in range(lo, hi + 1)), mathutils.Vector()).normalized()
        pts.append((q + o * LIFT, o))
    rows = []
    for i, (p, out) in enumerate(pts):
        a2 = pts[max(0, i - 1)][0]
        b2 = pts[min(len(pts) - 1, i + 1)][0]
        tng = (b2 - a2).normalized()
        side = tng.cross(out).normalized() * (width * 0.5)
        rows.append([bm.verts.new(p + side), bm.verts.new(p - side), bm.verts.new(p - side - out * thick), bm.verts.new(p + side - out * thick)])
    for i in range(len(rows) - 1):
        for j in range(4):
            j2 = (j + 1) % 4
            bm.faces.new((rows[i][j], rows[i][j2], rows[i + 1][j2], rows[i + 1][j]))


W = 0.075     # strap width, Blender units (x 0.399 in the game: 3 cm)
T = 0.020
# Crownpiece and throatlatch: just behind the ears, tipped back with the neck.
# Upright behind the ears; its lower end leans forward toward the jaw.
crown_n = mathutils.Vector((0, -1.0, 0.35)).normalized()
crown_c = skull + mathutils.Vector((0, 0.10, 0.0))
crown = section(crown_c, crown_n)
band(crown, W, T, crown_n)
# Browband: in front of the ears, over the forehead only.
brow_c = skull + hax * (hlen * 0.10)
brow = section(brow_c, hax)
up = mathutils.Vector((0, 0, 1))
arc = [q for q in brow if q[1].dot(up) > 0.30]
arc.sort(key=lambda q: q[0].x)
band(arc, W * 0.8, T, hax, closed=False)
# Cavesson noseband, a little over halfway down the face.
nose_c = skull + hax * (hlen * 0.60)
nose = section(nose_c, hax)
band(nose, W * 1.2, T * 1.2, hax)
for sx, bit in ((1.0, bit_l), (-1.0, bit_r)):
    # Off the crownpiece at eye height on this side, straight down to the bit.
    want = mathutils.Vector((sx, 0.0, 0.75)).normalized()
    top = max(crown, key=lambda q: q[1].dot(want))[0]
    strap(top, bit + mathutils.Vector((0, 0.05, 0.06)), W, T)
    torus_at(bit, mathutils.Vector((1, 0, 0)), 0.085, 0.016)

bm.normal_update()
mesh = bpy.data.meshes.new("Bridle2")
bm.to_mesh(mesh)
bm.free()
mesh.validate()
obj = bpy.data.objects.new("Bridle", mesh)
sc.collection.objects.link(obj)
leather = bpy.data.materials.new("BridleLeather")
leather.use_nodes = True
bsdf = leather.node_tree.nodes["Principled BSDF"]
bsdf.inputs["Base Color"].default_value = (0.032, 0.017, 0.010, 1)
bsdf.inputs["Roughness"].default_value = 0.45
obj.data.materials.append(leather)
for p in obj.data.polygons:
    p.use_smooth = True
# Skin to the Head bone, then the old pieces go.
vg = obj.vertex_groups.new(name="Head")
vg.add(list(range(len(obj.data.vertices))), 1.0, "REPLACE")
md = obj.modifiers.new("Armature", "ARMATURE")
md.object = arm
obj.parent = root
for o in old:
    bpy.data.objects.remove(o, do_unlink=True)

# Bit markers for the reins, on the Head bone at the rings.
for nm, bit in (("BitL", bit_l), ("BitR", bit_r)):
    for o in list(sc.objects):
        if o.name == nm:
            bpy.data.objects.remove(o, do_unlink=True)
    e = bpy.data.objects.new(nm, None)
    sc.collection.objects.link(e)
    e.parent = arm
    e.parent_type = "BONE"
    e.parent_bone = "Head"
    e.matrix_world = mathutils.Matrix.Translation(bit)
    print("MARKER", nm, tuple(round(x, 3) for x in e.matrix_world.translation))

# Skinned meshes as siblings of the armature, keeping their world transform.
for m in [o for o in sc.objects if o.type == "MESH" and o.parent == arm]:
    m_w = m.matrix_world.copy()
    m.parent = root
    m.matrix_world = m_w
for o in sc.objects:
    o.select_set(True)
bpy.ops.export_scene.gltf(
    filepath=dst, export_format="GLB", use_selection=True, export_yup=True,
    export_apply=False, export_animations=True, export_animation_mode="ACTIONS",
    export_skins=True, export_morph=False, export_lights=False, export_cameras=False,
)
print("EXPORTED", dst)
