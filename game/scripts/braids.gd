extends Node

## Show day: his mane is braided, a row of button braids down the crest on
## the off side, the way hunters are shown. Lessons and schooling keep it
## loose. Each braid rides its neck bone through an attachment, so it follows
## the drawn neck (the bascule's bend included), and takes its colour from the
## painted mane under it.

const COUNT := 12
const KNOT_R := 0.020
const CHAIN := ["Neck1", "Neck2", "Neck3", "Head"]

var _atts: Array[BoneAttachment3D] = []


func build(horse: Node3D, sk: Skeleton3D, mesh_root: Node) -> void:
	var ids: Array[int] = []
	for n in CHAIN:
		var b := sk.find_bone(n)
		if b < 0:
			return
		ids.append(b)
	var body := _find_body(mesh_root)
	if body == null or body.mesh == null:
		return
	# Everything at rest (the bind pose): the bone line and the body's skin.
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
	var mesh := SphereMesh.new()
	mesh.radius = KNOT_R
	mesh.height = KNOT_R * 2.0
	mesh.radial_segments = 10
	mesh.rings = 5
	var mat := StandardMaterial3D.new()
	mat.roughness = 0.72
	var tint := Color(0, 0, 0)
	var placed: Array = []
	for k in COUNT:
		# From just in front of the withers to a hand behind the poll.
		var t := lerpf(0.06, 0.86, float(k) / float(COUNT - 1)) * float(CHAIN.size() - 1)
		var seg := mini(int(t), CHAIN.size() - 2)
		var p := line[seg].lerp(line[seg + 1], t - float(seg))
		# The crest: the top of his body in a thin column over the bone line.
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
		var along := (line[seg + 1] - line[seg]).normalized()
		var up := (Vector3.UP - along * Vector3.UP.dot(along)).normalized()
		var side := up.cross(along).normalized()
		var at := Vector3(p.x, top, p.z) + off_side * 0.020 - up * 0.004
		# A button braid: rounder across, a little long down the crest.
		var basis := Basis(side * 0.95, up * 0.80, along * 1.25)
		placed.append([seg, Transform3D(basis, at)])
	if placed.is_empty():
		return
	tint = tint / float(placed.size())
	mat.albedo_color = Color(tint.r * 0.92, tint.g * 0.90, tint.b * 0.86)
	for seg in range(CHAIN.size() - 1):
		var att := BoneAttachment3D.new()
		att.name = "Braids" + str(CHAIN[seg])
		att.bone_name = CHAIN[seg]
		sk.add_child(att)
		_atts.append(att)
		var rest_w := sg * sk.get_bone_global_rest(ids[seg])
		for pk in placed:
			if int(pk[0]) != seg:
				continue
			var knot := MeshInstance3D.new()
			knot.name = "Braid"
			knot.mesh = mesh
			knot.material_override = mat
			knot.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
			att.add_child(knot)
			# Relative to the bone at rest, so it moves as the skin over it does.
			knot.transform = rest_w.affine_inverse() * (pk[1] as Transform3D)
	_sync()


func _process(_delta: float) -> void:
	_sync()


func _sync() -> void:
	var gs := get_node_or_null("/root/GameState")
	var show := gs != null and str(gs.get("session_kind")) == "show"
	for att in _atts:
		if is_instance_valid(att) and att.visible != show:
			att.visible = show


func _find_body(n: Node) -> MeshInstance3D:
	if n is MeshInstance3D and str(n.name) == "Horse":
		return n
	for c in n.get_children():
		var f := _find_body(c)
		if f:
			return f
	return null
