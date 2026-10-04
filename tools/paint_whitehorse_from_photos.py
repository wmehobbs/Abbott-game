"""Unwrap WhiteHorse, paint Abbott's photos onto those UVs, render proofs.

UV space is Godot/glTF local: X right, Y up, Z toward the head.
Blender after glTF import is Z-up: (bx, by, bz) -> (bx, bz, -by).
Keep this function identical to abbott_look.gd.
"""
from __future__ import annotations

import math
import os
from mathutils import Vector

import bpy
import numpy as np

ROOT = r"E:\Workspace\Madison"
GLB = os.path.join(ROOT, "game", "assets", "meshes", "quaternius-WhiteHorse.glb")
PHOTOS = os.path.join(ROOT, "tools", "abbott_paint")
TEX = os.path.join(ROOT, "game", "assets", "textures")
PREV = os.path.join(ROOT, "tools", "abbott_paint", "preview")
os.makedirs(TEX, exist_ok=True)
os.makedirs(PREV, exist_ok=True)

SIZE = 2048


def clamp01(x: float) -> float:
    return 0.0 if x < 0.0 else 1.0 if x > 1.0 else x


def uv_for(kind: str, x: float, y: float, z: float) -> tuple[float, float]:
    # Mesh-local GLB / Godot ARRAY_VERTEX (must match abbott_look.gd):
    # x right ±0.007, y 0 hooves / -0.048 ears, z -0.035 muzzle / +0.022 tail.
    if kind in ("muzzle", "light", "eye", "eye_black"):
        u = (x + 0.0036) / 0.0072
        v = (y + 0.0484) / 0.0152
        return clamp01(u), clamp01(v)
    if kind == "hair":
        if z < -0.018:
            u = (x + 0.0024) / 0.0048
            v = (y + 0.0460) / 0.0140
            return clamp01(u), clamp01(v)
        u = math.atan2(x, -y - 0.024) / math.tau + 0.5
        v = (z + 0.030) / 0.053
        return clamp01(u), clamp01(v)
    if kind == "hoof":
        u = (x + 0.0056) / 0.0112
        v = (z + 0.018) / 0.037
        return clamp01(u), clamp01(v)
    if z < -0.017:
        u = (x + 0.0071) / 0.0142
        v = 0.02 + 0.38 * clamp01((y + 0.0482) / 0.020)
        return clamp01(u), clamp01(v)
    u = math.atan2(x, -y - 0.016) / math.tau + 0.5
    v = 0.46 + 0.52 * clamp01((z + 0.018) / 0.041)
    return clamp01(u), clamp01(v)


def kind_of(mat_name: str) -> str:
    key = (mat_name or "").lower()
    if "eye_black" in key:
        return "eye_black"
    if "eye" in key:
        return "eye"
    if "hoof" in key:
        return "hoof"
    if "muzzle" in key:
        return "muzzle"
    if "hair" in key:
        return "hair"
    if "light" in key:
        return "light"
    return "coat"


def load_rgba(path: str) -> np.ndarray:
    im = bpy.data.images.load(path)
    w, h = im.size
    px = np.array(im.pixels[:], dtype=np.float32).reshape(h, w, im.channels)
    if px.shape[2] == 3:
        a = np.ones((h, w, 1), dtype=np.float32)
        px = np.concatenate([px, a], axis=2)
    # Blender images are bottom-up.
    return np.flipud(px)


def sample_img(img: np.ndarray, u: float, v: float) -> np.ndarray:
    h, w = img.shape[:2]
    x = clamp01(u) * (w - 1)
    y = clamp01(v) * (h - 1)
    x0, y0 = int(x), int(y)
    x1, y1 = min(x0 + 1, w - 1), min(y0 + 1, h - 1)
    tx, ty = x - x0, y - y0
    c = (
        img[y0, x0] * (1 - tx) * (1 - ty)
        + img[y0, x1] * tx * (1 - ty)
        + img[y1, x0] * (1 - tx) * ty
        + img[y1, x1] * tx * ty
    )
    return c


def chestnut_tile(rump: np.ndarray) -> np.ndarray:
    h, w = rump.shape[:2]
    # Lower-left of IMG_9535 is the sunlit croup — no tree, no grass.
    crop = rump[int(h * 0.62) : int(h * 0.97), 0 : int(w * 0.30)]
    rgb = np.clip(crop[:, :, :3], 0, 1)
    r, g, b = rgb[:, :, 0], rgb[:, :, 1], rgb[:, :, 2]
    keep = (r > g + 0.015) & (r > b + 0.07) & (g < 0.38) & (b < 0.26) & (r < 0.52) & (r > 0.12)
    if keep.mean() < 0.12:
        keep = (r > b + 0.04) & (g < 0.42)
    ys, xs = np.where(keep)
    y0, y1 = int(np.percentile(ys, 8)), int(np.percentile(ys, 92))
    x0, x1 = int(np.percentile(xs, 8)), int(np.percentile(xs, 92))
    block = rgb[y0:y1, x0:x1]
    # Grade toward the stall-light dark chestnut, keep photo grain.
    target = np.array([0.33, 0.16, 0.09], dtype=np.float32)
    mean = block.mean(axis=(0, 1))
    grain = block / np.maximum(mean, 0.05)
    block = np.clip(target * (0.62 + 0.38 * grain), 0, 1)
    tile = np.zeros((256, 256, 3), dtype=np.float32)
    bh, bw = max(1, block.shape[0]), max(1, block.shape[1])
    yy, xx = np.mgrid[0:256, 0:256]
    tile = block[yy % bh, xx % bw]
    print("CHESTNUT tile mean", tile.mean(axis=(0, 1)), "block", block.shape, "keep", float(keep.mean()))
    return tile


def rasterize(obj, images: dict[str, np.ndarray], face, stall, tile, hind) -> None:
    me = obj.data
    uv = me.uv_layers.new(name="AbbottUV")
    kinds = {}
    acc = {k: np.zeros((SIZE, SIZE, 4), dtype=np.float32) for k in images}
    wgt = {k: np.zeros((SIZE, SIZE), dtype=np.float32) for k in images}

    for p in me.polygons:
        mat = me.materials[p.material_index] if p.material_index < len(me.materials) else None
        kind = kind_of(mat.name if mat else "")
        kinds[p.material_index] = kind
        loops = list(p.loop_indices)
        if len(loops) < 3:
            continue
        # Fan triangulate.
        for t in range(1, len(loops) - 1):
            lis = (loops[0], loops[t], loops[t + 1])
            gpts = []
            uvs = []
            for li in lis:
                loop = me.loops[li]
                c = me.vertices[loop.vertex_index].co
                gx, gy, gz = float(c.x), float(c.y), float(c.z)
                uu, vv = uv_for(kind, gx, gy, gz)
                uv.data[li].uv = (uu, 1.0 - vv)
                gpts.append((gx, gy, gz))
                uvs.append((uu, vv))
            _splat(acc[kind], wgt[kind], uvs, gpts, kind, face, stall, tile, hind)

    for kind, img in acc.items():
        ww = np.maximum(wgt[kind], 1e-5)
        rgb = img[:, :, :3] / ww[:, :, None]
        a = np.clip(img[:, :, 3] / ww, 0, 1)
        empty = wgt[kind] < 1e-4
        if kind in ("coat", "hair", "light", "muzzle"):
            # Fill holes with the real rump tile, not a flat lerp.
            yy, xx = np.mgrid[0:SIZE, 0:SIZE]
            tu = xx / (SIZE - 1)
            tv = yy / (SIZE - 1)
            fill = tile[(yy * 3) % tile.shape[0], (xx * 3) % tile.shape[1]]
            if kind == "hair":
                flax = np.array([0.91, 0.82, 0.62], dtype=np.float32)
                dark = np.array([0.09, 0.06, 0.04], dtype=np.float32)
                fill = np.where((tv < 0.45)[:, :, None], flax, dark)
            rgb = np.where(empty[:, :, None], fill, rgb)
            a = np.where(empty, 1.0, np.maximum(a, 0.85))
        elif kind == "hoof":
            rgb = np.where(empty[:, :, None], np.array([0.12, 0.08, 0.05]), rgb)
            a = np.where(empty, 1.0, a)
        else:
            rgb = np.where(empty[:, :, None], np.array([0.05, 0.04, 0.03]), rgb)
            a = np.where(empty, 1.0, a)
        out = np.dstack([np.clip(rgb, 0, 1), np.clip(a, 0, 1)])
        images[kind] = out
        _save_png(out, os.path.join(TEX, "abbott_wh_%s.png" % kind))


def _splat(acc, wgt, uvs, gpts, kind, face, stall, tile, hind) -> None:
    pts = np.asarray(uvs, dtype=np.float32)
    px = pts * np.array([SIZE - 1, SIZE - 1], dtype=np.float32)
    minx = max(0, int(np.floor(px[:, 0].min())))
    maxx = min(SIZE - 1, int(np.ceil(px[:, 0].max())))
    miny = max(0, int(np.floor(px[:, 1].min())))
    maxy = min(SIZE - 1, int(np.ceil(px[:, 1].max())))
    if maxx < minx or maxy < miny:
        return
    a, b, c = px
    area = (b[0] - a[0]) * (c[1] - a[1]) - (c[0] - a[0]) * (b[1] - a[1])
    if abs(area) < 1e-6:
        return
    xs = np.arange(minx, maxx + 1, dtype=np.float32) + 0.5
    ys = np.arange(miny, maxy + 1, dtype=np.float32) + 0.5
    xx, yy = np.meshgrid(xs, ys)
    w0 = ((b[0] - xx) * (c[1] - yy) - (c[0] - xx) * (b[1] - yy)) / area
    w1 = ((c[0] - xx) * (a[1] - yy) - (a[0] - xx) * (c[1] - yy)) / area
    w2 = 1.0 - w0 - w1
    inside = (w0 >= -0.01) & (w1 >= -0.01) & (w2 >= -0.01)
    if not np.any(inside):
        return
    g = np.asarray(gpts, dtype=np.float32)
    gx = g[0, 0] * w0 + g[1, 0] * w1 + g[2, 0] * w2
    gy = g[0, 1] * w0 + g[1, 1] * w1 + g[2, 1] * w2
    gz = g[0, 2] * w0 + g[1, 2] * w1 + g[2, 2] * w2
    iy, ix = np.where(inside)
    for k in range(iy.size):
        col, wt = _shade(kind, float(gx[iy[k], ix[k]]), float(gy[iy[k], ix[k]]), float(gz[iy[k], ix[k]]), face, stall, tile, hind)
        y = miny + int(iy[k])
        x = minx + int(ix[k])
        acc[y, x, :3] += col * wt
        acc[y, x, 3] += wt
        wgt[y, x] += wt


def _shade(kind, x, y, z, face, stall, tile, hind):
    coat = tile[int(abs(y * 900 + z * 400)) % tile.shape[0], int(abs(x * 1400 + z * 300)) % tile.shape[1]]
    fu = clamp01((x + 0.0036) / 0.0072)
    fv = clamp01((y + 0.0484) / 0.0152)
    face_s = sample_img(face, fu, fv)
    su = clamp01((x + 0.0040) / 0.0095)
    sv = clamp01((y + 0.0470) / 0.0220)
    stall_s = sample_img(stall, su, sv)

    if kind in ("muzzle", "light", "eye", "eye_black"):
        if face_s[3] > 0.12:
            return face_s[:3], 1.0
        return coat, 0.4

    if kind == "hair":
        flax = np.array([0.92, 0.83, 0.62], dtype=np.float32)
        dark = np.array([0.08, 0.05, 0.04], dtype=np.float32)
        if y < -0.040 and face_s[3] > 0.10:
            return face_s[:3], 1.0
        if z < -0.018 and face_s[3] > 0.15:
            return face_s[:3], 1.0
        if stall_s[3] > 0.15 and -0.018 < z < 0.008:
            return stall_s[:3] * 0.55 + dark * 0.45, 0.95
        if z < -0.016:
            return flax, 1.0
        if z < 0.006:
            return dark * 0.70 + flax * 0.30, 1.0
        return dark, 1.0

    if kind == "hoof":
        return np.array([0.13, 0.08, 0.05], dtype=np.float32), 1.0

    left_hind = x > 0.0030 and z > 0.011 and y > -0.012
    if left_hind:
        hs = sample_img(hind, 0.16, clamp01((y + 0.018) / 0.020))
        if hs[0] > 0.40 and hs[1] > 0.38:
            return hs[:3], 1.0
        white = np.array([0.93, 0.90, 0.84], dtype=np.float32)
        return white * 0.88 + coat * 0.12, 1.0

    if x > 0.0016 and -0.016 < z < 0.004 and -0.034 < y < -0.022 and stall_s[3] > 0.2:
        if stall_s[0] > 0.55 and stall_s[1] > 0.50:
            return stall_s[:3], 0.9

    if z < -0.017 and face_s[3] > 0.12:
        return face_s[:3], 1.0

    return coat, 1.0


def _save_png(arr: np.ndarray, path: str) -> None:
    h, w = arr.shape[:2]
    img = bpy.data.images.new(os.path.basename(path), width=w, height=h, alpha=True)
    img.pixels = np.flipud(arr).reshape(-1).tolist()
    img.filepath_raw = path
    img.file_format = "PNG"
    img.save()
    print("WROTE", path)


def assign_materials(obj, images: dict[str, np.ndarray]) -> None:
    for mat in obj.data.materials:
        kind = kind_of(mat.name)
        path = os.path.join(TEX, "abbott_wh_%s.png" % kind)
        mat.use_nodes = True
        nt = mat.node_tree
        nt.nodes.clear()
        out = nt.nodes.new("ShaderNodeOutputMaterial")
        bsdf = nt.nodes.new("ShaderNodeBsdfPrincipled")
        tex = nt.nodes.new("ShaderNodeTexImage")
        tex.image = bpy.data.images.load(path)
        nt.links.new(tex.outputs["Color"], bsdf.inputs["Base Color"])
        nt.links.new(bsdf.outputs["BSDF"], out.inputs["Surface"])
        bsdf.inputs["Roughness"].default_value = 0.58 if kind == "coat" else 0.72
        if kind in ("eye", "eye_black"):
            bsdf.inputs["Roughness"].default_value = 0.22


def render_previews(obj) -> None:
    scene = bpy.context.scene
    try:
        scene.render.engine = "BLENDER_EEVEE_NEXT"
    except Exception:
        scene.render.engine = "BLENDER_EEVEE"
    scene.render.resolution_x = 960
    scene.render.resolution_y = 720
    scene.render.film_transparent = False
    world = bpy.data.worlds.new("W")
    scene.world = world
    world.use_nodes = True
    bg = world.node_tree.nodes["Background"]
    bg.inputs[0].default_value = (0.62, 0.68, 0.58, 1)
    bg.inputs[1].default_value = 0.9
    sun = bpy.data.objects.new("Sun", bpy.data.lights.new("Sun", "SUN"))
    sun.data.energy = 4.5
    sun.rotation_euler = (math.radians(-42), math.radians(-28), 0)
    scene.collection.objects.link(sun)
    cam_d = bpy.data.cameras.new("Cam")
    cam = bpy.data.objects.new("Cam", cam_d)
    scene.collection.objects.link(cam)
    scene.camera = cam
    cam_d.lens = 50
    bb = [obj.matrix_world @ Vector(c) for c in obj.bound_box]
    mins = Vector((min(v.x for v in bb), min(v.y for v in bb), min(v.z for v in bb)))
    maxs = Vector((max(v.x for v in bb), max(v.y for v in bb), max(v.z for v in bb)))
    center = (mins + maxs) * 0.5
    size = (maxs - mins).length

    def look(loc):
        cam.location = loc
        d = center - loc
        cam.rotation_euler = d.to_track_quat("-Z", "Y").to_euler()

    look(center + Vector((size * 0.15, -size * 1.15, size * 0.12)))
    scene.render.filepath = os.path.join(PREV, "front.png")
    bpy.ops.render.render(write_still=True)
    look(center + Vector((size * 1.05, size * 0.05, size * 0.22)))
    scene.render.filepath = os.path.join(PREV, "side.png")
    bpy.ops.render.render(write_still=True)
    look(center + Vector((size * 0.75, -size * 0.75, size * 0.28)))
    scene.render.filepath = os.path.join(PREV, "three_quarter.png")
    bpy.ops.render.render(write_still=True)
    print("PREVIEWS", PREV)


def main() -> None:
    bpy.ops.wm.read_factory_settings(use_empty=True)
    bpy.ops.import_scene.gltf(filepath=GLB)
    horse = next(o for o in bpy.data.objects if o.type == "MESH" and o.name.startswith("Horse"))
    print("HORSE", horse.name, "verts", len(horse.data.vertices))

    face = load_rgba(os.path.join(PHOTOS, "abbott_photo_face.png"))
    stall = load_rgba(os.path.join(PHOTOS, "abbott_photo_stall.png"))
    rump = load_rgba(os.path.join(PHOTOS, "abbott_photo_rump.png"))
    hind = load_rgba(os.path.join(PHOTOS, "abbott_photo_lefthind.png"))
    tile = chestnut_tile(rump)
    print("TILE mean", tile.mean(axis=(0, 1)), "face", face.shape, "stall", stall.shape)

    images = {k: None for k in ("coat", "hair", "muzzle", "light", "hoof", "eye", "eye_black")}
    rasterize(horse, images, face, stall, tile, hind)
    assign_materials(horse, images)
    render_previews(horse)
    print("PAINT DONE")


if __name__ == "__main__":
    main()
