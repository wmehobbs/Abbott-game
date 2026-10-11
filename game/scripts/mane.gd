extends Node

## Lessons and schooling: a loose mane down the off side of the crest.
## Show day hides it and the braids take its place. The roots ride the neck
## bones, so they follow the bend. The hair is hung with gravity each frame:
## the neck's rest pose is not the pose he stands in, and a direction baked
## there stands up off the crest once the neck lifts.

const COUNT := 26
const CHAIN := ["Neck1", "Neck2", "Neck3", "Head"]

var _horse: Node3D
var _groups: Array = []
var _loose := true


## Builds the locks once, on the crest at rest. One mesh per neck bone.
func build(horse: Node3D, sk: Skeleton3D, mesh_root: Node) -> void:
	_horse = horse
	var ids: Array[int] = []
	for n in CHAIN:
		var b := sk.find_bone(n)
		if b < 0:
			return
		ids.append(b)
	var body := _find_body(mesh_root)
	if body == null or body.mesh == null:
		return
	var sg := sk.global_transform
	var line: Array[Vector3] = []
	for b in ids:
		line.append(sg * sk.get_bone_global_rest(b).origin)
	var near := PackedVector3Array()
	var near_col := PackedColorArray()
	var lo := line[0]
	var hi := line[line.size() - 1]
	var box := AABB(lo, Vector3.ZERO).expand(hi).grow(0.45)
	for s in body.mesh.get_surface_count():
		var arr := body.mesh.surface_get_arrays(s)
		if arr.is_empty():
			continue
		var v: PackedVector3Array = arr[Mesh.ARRAY_VERTEX]
		var c: Variant = arr[Mesh.ARRAY_COLOR]
		var has_c: bool = c is PackedColorArray and (c as PackedColorArray).size() == v.size()
		for i in v.size():
			var w := body.global_transform * v[i]
			if box.has_point(w):
				near.append(w)
				near_col.append((c as PackedColorArray)[i] if has_c else Color(0.84, 0.78, 0.62))
	if near.is_empty():
		return
	var off_side := horse.global_transform.basis.x.normalized()
	var rng := RandomNumberGenerator.new()
	rng.seed = 17011
	var tint := Color(0, 0, 0)
	var placed: Array = []
	for k in COUNT:
		# Withers to a little behind the poll, same span as the braids.
		var t := lerpf(0.06, 0.86, float(k) / float(COUNT - 1)) * float(CHAIN.size() - 1)
		var seg := mini(int(t), CHAIN.size() - 2)
		var p := line[seg].lerp(line[seg + 1], t - float(seg))
		var along := (line[seg + 1] - line[seg]).normalized()
		var top := -INF
		var col := Color()
		for i in near.size():
			var w := near[i]
			if w.y > top and Vector2(w.x - p.x, w.z - p.z).length() <= 0.03:
				top = w.y
				col = near_col[i]
		if top == -INF:
			continue
		tint += col
		var crest := Vector3(p.x, top, p.z)
		# How far the neck reaches to the off side here. The hair lands on
		# that side, not past it and not down the middle of the neck.
		var reach := 0.0
		for i in near.size():
			var w := near[i]
			if absf(along.dot(w - crest)) > 0.06:
				continue
			reach = maxf(reach, off_side.dot(w - crest))
		if reach < 0.04:
			reach = 0.09
		var lateral := clampf(reach * rng.randf_range(0.62, 0.88), 0.045, 0.12)
		var drop := rng.randf_range(0.075, 0.125)
		var slide := rng.randf_range(-0.018, 0.022)
		var mid_l := lateral * rng.randf_range(0.52, 0.70)
		var mid_d := drop * rng.randf_range(0.16, 0.32)
		var mid_s := slide * rng.randf_range(0.2, 0.6)
		var fitted := _fit_length(lateral, drop, slide, mid_l, mid_d, mid_s)
		var shade := rng.randf_range(0.86, 1.0)
		placed.append({
			"seg": seg,
			"root": crest + off_side * 0.012,
			"lateral": fitted[0],
			"drop": fitted[1],
			"slide": fitted[2],
			"mid_l": fitted[3],
			"mid_d": fitted[4],
			"mid_s": fitted[5],
			"wide": rng.randf_range(0.0045, 0.009),
			"shade": shade,
		})
	if placed.is_empty():
		return
	tint = tint / float(placed.size())
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(tint.r * 0.92, tint.g * 0.90, tint.b * 0.86)
	mat.roughness = 0.8
	mat.vertex_color_use_as_albedo = true
	mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	for seg in range(CHAIN.size() - 1):
		var locks: Array = []
		for pk in placed:
			if int(pk["seg"]) == seg:
				locks.append(pk)
		if locks.is_empty():
			continue
		var att := BoneAttachment3D.new()
		att.name = "Mane" + str(CHAIN[seg])
		att.bone_name = CHAIN[seg]
		sk.add_child(att)
		var rest_w := sg * sk.get_bone_global_rest(ids[seg])
		var inv := rest_w.affine_inverse()
		for pk in locks:
			pk["local_root"] = inv * (pk["root"] as Vector3)
		var mi := MeshInstance3D.new()
		mi.name = "Locks"
		mi.material_override = mat
		mi.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		att.add_child(mi)
		_groups.append({"att": att, "mi": mi, "locks": locks})
	_sync()
	if _loose:
		_drape()


## Keeps the two-segment lock between 10 and 18 cm.
func _fit_length(lateral: float, drop: float, slide: float, mid_l: float, mid_d: float, mid_s: float) -> Array:
	var mid := Vector3(mid_l, mid_d, mid_s)
	var tip := Vector3(lateral, drop, slide)
	var total := mid.length() + (tip - mid).length()
	var s := 1.0
	if total > 0.18:
		s = 0.18 / total
	elif total < 0.10 and total > 0.0001:
		s = 0.10 / total
	return [lateral * s, drop * s, slide * s, mid_l * s, mid_d * s, mid_s * s]


func _process(_delta: float) -> void:
	_sync()
	if _loose:
		_drape()


## Roots stay on the crest. The rest of each lock hangs down the off side,
## in the world, so a raised or lowered neck does not turn it into a spike.
func _drape() -> void:
	if _horse == null or _groups.is_empty():
		return
	var basis := _horse.global_transform.basis
	var off := basis.x.normalized()
	var fwd := (-basis.z).normalized()
	var down := Vector3.DOWN
	for g in _groups:
		var att: BoneAttachment3D = g["att"]
		var mi: MeshInstance3D = g["mi"]
		if not is_instance_valid(att) or not is_instance_valid(mi) or not att.is_inside_tree():
			continue
		var inv := att.global_transform.affine_inverse()
		var locks: Array = g["locks"]
		var verts := PackedVector3Array()
		var normals := PackedVector3Array()
		var colors := PackedColorArray()
		var indices := PackedInt32Array()
		for lock in locks:
			var root_w: Vector3 = att.global_transform * (lock["local_root"] as Vector3)
			var mid_w := root_w + off * float(lock["mid_l"]) + down * float(lock["mid_d"]) + fwd * float(lock["mid_s"])
			var tip_w := root_w + off * float(lock["lateral"]) + down * float(lock["drop"]) + fwd * float(lock["slide"])
			var dir := tip_w - root_w
			if dir.length_squared() < 0.000001:
				dir = down
			dir = dir.normalized()
			var axis := fwd - dir * fwd.dot(dir)
			if axis.length_squared() < 0.0001:
				axis = off.cross(dir)
			axis = axis.normalized()
			var normal := dir.cross(axis).normalized()
			if normal.dot(off) < 0.0:
				normal = -normal
			var pts := [root_w, mid_w, tip_w]
			var wide := float(lock["wide"])
			var widths := [wide, wide * 0.55, 0.0012]
			var col := Color(float(lock["shade"]), float(lock["shade"]), float(lock["shade"]))
			var base := verts.size()
			var n_local := (inv.basis * normal).normalized()
			for i in 3:
				var hw := float(widths[i])
				# Width through the same transform as the points, so a bone
				# scale cannot turn a thin lock into a fin.
				verts.append(inv * (pts[i] - axis * hw))
				verts.append(inv * (pts[i] + axis * hw))
				normals.append(n_local)
				normals.append(n_local)
				colors.append(col)
				colors.append(col)
			for s in 2:
				var i0 := base + s * 2
				indices.append(i0)
				indices.append(i0 + 1)
				indices.append(i0 + 2)
				indices.append(i0 + 1)
				indices.append(i0 + 3)
				indices.append(i0 + 2)
		var arrays: Array = []
		arrays.resize(Mesh.ARRAY_MAX)
		arrays[Mesh.ARRAY_VERTEX] = verts
		arrays[Mesh.ARRAY_NORMAL] = normals
		arrays[Mesh.ARRAY_COLOR] = colors
		arrays[Mesh.ARRAY_INDEX] = indices
		var mesh := mi.mesh as ArrayMesh
		if mesh == null:
			mesh = ArrayMesh.new()
			mi.mesh = mesh
		mesh.clear_surfaces()
		if verts.size() >= 6:
			mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)


## Hidden on show day, when the braids are the mane.
func _sync() -> void:
	var gs := get_node_or_null("/root/GameState")
	_loose = gs == null or str(gs.get("session_kind")) != "show"
	for g in _groups:
		var att: Node3D = g["att"]
		if is_instance_valid(att) and att.visible != _loose:
			att.visible = _loose


func _find_body(n: Node) -> MeshInstance3D:
	if n is MeshInstance3D and str(n.name) == "Horse":
		return n
	for c in n.get_children():
		var f := _find_body(c)
		if f:
			return f
	return null
