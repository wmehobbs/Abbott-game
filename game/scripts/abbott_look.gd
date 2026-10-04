class_name AbbottLook
extends RefCounted

## Quaternius CC0 WhiteHorse. Clips: Idle, Walk, Gallop, Gallop_Jump, Jump_toIdle.
## Madison is parented to the Torso bone (behind the withers, ahead of the hips).

const People := preload("res://scripts/person_look.gd")
const MESH := "res://assets/meshes/quaternius-WhiteHorse.glb"
const TARGET_LENGTH := 2.25
const SHADER := "res://shaders/abbott_whitehorse.gdshader"
const TEX_FACE := "res://assets/textures/abbott_shader_face.jpg"
const TEX_STALL := "res://assets/textures/abbott_shader_stall.jpg"
const TEX_COAT := "res://assets/textures/abbott_shader_coat.jpg"
## Prefer the mid-back. Torso2 is the withers/shoulders. Neck* is forbidden.
const SEAT_BONES: Array[String] = ["Torso", "Torso2", "Back"]
const NAVY := Color(0.06, 0.07, 0.10)
const BEIGE := Color(0.80, 0.72, 0.54)
const SKIN := Color(0.86, 0.70, 0.58)
const LEATHER := Color(0.22, 0.11, 0.07)


static func build(host: Node3D) -> Dictionary:
	var visual := Node3D.new()
	visual.name = "Visual"
	host.add_child(visual)

	var inst: Node3D = null
	if ResourceLoader.exists(MESH):
		var packed: PackedScene = load(MESH)
		inst = packed.instantiate() as Node3D
		inst.name = "Mesh"
		visual.add_child(inst)
		_fit_horse(inst)
		_paint_whitehorse(inst)
	else:
		push_warning("WhiteHorse mesh missing")

	var skel := _find_skel(visual)
	var rider: Node3D = _mount_on_spine(host, skel, inst if inst else visual)
	_bridle(skel, inst if inst else visual)
	_dust(host)
	return {visual = visual, rider = rider, skel = skel}


static func _fit_horse(root: Node3D) -> void:
	root.position = Vector3.ZERO
	root.scale = Vector3.ONE
	# Quaternius/Blender leaves AnimalArmature at scale 100 and -90° X.
	# The 100× turns a 2.25 m horse into a barn sitting in the ring, and
	# fighting it with a 0.0085 root scale is what pulled tail and legs off.
	_flatten_blender_armature(root)
	var skel := _find_skel(root)
	if skel:
		var head_i := skel.find_bone("Head")
		var tail_i := skel.find_bone("Tail1")
		if head_i >= 0 and tail_i >= 0:
			var head := (skel.global_transform * skel.get_bone_global_rest(head_i)).origin
			var tail := (skel.global_transform * skel.get_bone_global_rest(tail_i)).origin
			if head.z > tail.z:
				root.rotation_degrees.y = 180.0
	var aabb := _aabb(root)
	var length := aabb.size.z
	if length < aabb.size.x:
		length = aabb.size.x
	if length > 0.05:
		var s := TARGET_LENGTH / length
		if s < 0.4 or s > 2.5:
			push_warning("FIT unexpected scale %s on length %s" % [s, length])
		root.scale = Vector3(s, s, s)
		aabb = _aabb(root)
	root.position.y -= aabb.position.y
	print("FIT length=", aabb.size.z, " height=", aabb.size.y, " scale=", root.scale)


static func _flatten_blender_armature(n: Node) -> void:
	if n is Node3D and n.name == "AnimalArmature":
		var arm := n as Node3D
		if not arm.scale.is_equal_approx(Vector3.ONE):
			print("FIT flatten armature scale=", arm.scale, " keep_rot=", arm.rotation_degrees)
			arm.scale = Vector3.ONE
		return
	for c in n.get_children():
		_flatten_blender_armature(c)


static func _paint_whitehorse(root: Node) -> void:
	_paint_node(root)


static func _paint_node(n: Node) -> void:
	if n is MeshInstance3D:
		_paint_mesh(n as MeshInstance3D)
	for c in n.get_children():
		_paint_node(c)


static func _paint_mesh(mi: MeshInstance3D) -> void:
	var src := mi.mesh
	if src == null:
		return
	# Do not replace the skinned mesh. Rebuilding ArrayMesh broke Walk.
	mi.extra_cull_margin = 2.0
	mi.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	mi.sorting_offset = 0.0
	for s in src.get_surface_count():
		var mat := src.surface_get_material(s)
		if mat == null:
			mat = mi.get_active_material(s)
		var kind := _surface_kind(_mat_name(mat, s), s)
		mi.set_surface_override_material(s, _abbott_tex_mat(kind, _bind_scale(src)))


static func _mat_name(mat: Material, surface: int) -> String:
	if mat == null:
		return "surf%d" % surface
	if mat.resource_name != "":
		return mat.resource_name
	var path := str(mat.resource_path)
	if path != "":
		return path.get_file()
	return "surf%d" % surface


static func _dom_bone(skel: Skeleton3D, bones, weights, vi: int, stride: int) -> String:
	if bones == null or skel == null:
		return ""
	var best_i := 0
	var best_w := -1.0
	for k in stride:
		var idx := vi * stride + k
		if idx >= bones.size():
			break
		var w := 0.0
		if weights != null and idx < weights.size():
			w = float(weights[idx])
		if w > best_w:
			best_w = w
			best_i = int(bones[idx])
	if best_i < 0 or best_i >= skel.get_bone_count():
		return ""
	return skel.get_bone_name(best_i)


static func _surface_kind(mname: String, surface: int) -> String:
	var key := mname.to_lower()
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
	if "main" in key:
		return "coat"
	match surface:
		1:
			return "hair"
		2:
			return "muzzle"
		3:
			return "hoof"
		4:
			return "light"
		5:
			return "eye_black"
		6:
			return "eye"
		_:
			return "coat"


static func _bind_scale(mesh: Mesh) -> float:
	var z := mesh.get_aabb().size.z
	if z < 0.001:
		return 1.0
	return z / 0.048239


static func _abbott_tex_mat(kind: String, bind_s: float = 1.0) -> Material:
	if not ResourceLoader.exists(SHADER):
		var fb := StandardMaterial3D.new()
		fb.albedo_color = _fallback_albedo(kind)
		fb.transparency = BaseMaterial3D.TRANSPARENCY_DISABLED
		return fb
	var m := ShaderMaterial.new()
	m.shader = load(SHADER)
	m.render_priority = 0
	if ResourceLoader.exists(TEX_FACE):
		m.set_shader_parameter("face_tex", load(TEX_FACE))
	if ResourceLoader.exists(TEX_STALL):
		m.set_shader_parameter("stall_tex", load(TEX_STALL))
	if ResourceLoader.exists(TEX_COAT):
		m.set_shader_parameter("coat_tex", load(TEX_COAT))
	var part := 0
	match kind:
		"hair":
			part = 1
		"muzzle":
			part = 2
		"hoof":
			part = 3
		"eye":
			part = 4
		"eye_black":
			part = 5
	m.set_shader_parameter("part", part)
	m.set_shader_parameter("bind_s", maxf(bind_s, 0.01))
	return m


static func _fallback_albedo(kind: String) -> Color:
	match kind:
		"eye_black":
			return Color(0.04, 0.03, 0.03)
		"eye":
			return Color(0.08, 0.06, 0.05)
		"hoof":
			return Color(0.13, 0.09, 0.05)
		"muzzle":
			return Color(0.86, 0.64, 0.58)
		"hair":
			return Color(0.92, 0.86, 0.72)
		"light":
			return Color(0.95, 0.92, 0.87)
		_:
			return Color(0.28, 0.10, 0.05)


static func _mount_on_spine(host: Node3D, skel: Skeleton3D, mesh_root: Node) -> Node3D:
	if skel == null:
		push_warning("WhiteHorse skeleton missing; cannot parent Madison to a bone")
		return People.mounted_madison(host, Vector3.ZERO)
	var bone := _seat_bone(skel)
	if bone == "":
		push_warning("WhiteHorse has no Torso/Torso2/Back bone")
		return People.mounted_madison(host, Vector3.ZERO)
	var att := BoneAttachment3D.new()
	att.name = "SeatAttach"
	att.bone_name = bone
	skel.add_child(att)
	var seat := Node3D.new()
	seat.name = "Seat"
	att.add_child(seat)
	var i := skel.find_bone(bone)
	var bone_xf := skel.global_transform * skel.get_bone_global_pose(i)
	var around := bone_xf.origin
	var back_y := _back_y_near(mesh_root, around, 0.18)
	var origin := Vector3(around.x, back_y, around.z)
	var fwd := -host.global_transform.basis.z
	fwd.y = 0.0
	if fwd.length() < 0.001:
		fwd = Vector3(0, 0, -1)
	else:
		fwd = fwd.normalized()
	seat.look_at_from_position(origin, origin + fwd, Vector3.UP)
	print("SEAT bone=", bone, " bone_pos=", around, " back_y=", back_y, " seat=", origin)
	return People.mounted_madison(seat, Vector3.ZERO)


static func _bridle(skel: Skeleton3D, mesh_root: Node) -> void:
	if skel == null or skel.find_bone("Head") < 0:
		return
	var att := BoneAttachment3D.new()
	att.name = "BridleAttach"
	att.bone_name = "Head"
	skel.add_child(att)
	var leather := MeshKit.leather(Color(0.36, 0.20, 0.11), 0.40)
	var navy := MeshKit.mat_color(NAVY, 0.38)
	var steel := MeshKit.steel()
	var box := _bone_local_aabb(skel, mesh_root, "Head")
	var muz := _muzzle_local_aabb(skel, mesh_root)
	if box.size.length() < 0.08 or box.size.y > 1.1:
		box = AABB(Vector3(-0.16, 0.07, -0.22), Vector3(0.32, 0.45, 0.43))
	if muz.size.length() < 0.04:
		muz = AABB(Vector3(-0.08, 0.43, -0.17), Vector3(0.15, 0.09, 0.19))
	var cx := (box.position.x + box.end.x) * 0.5
	# Head local: +Y toward the muzzle, +Z toward the poll/top, ±X width.
	var crown := Vector3(cx, box.position.y + box.size.y * 0.16, box.position.z + box.size.z * 0.58)
	var brow := Vector3(cx, box.position.y + box.size.y * 0.28, box.position.z + box.size.z * 0.82)
	var nose := Vector3(cx, box.position.y + box.size.y * 0.70, box.position.z + box.size.z * 0.46)
	var bitp := Vector3(cx, muz.position.y + muz.size.y * 0.52, muz.position.z + muz.size.z * 0.42)
	var hx := box.size.x * 0.46
	var mx := maxf(muz.size.x * 0.58, 0.055)
	MeshKit.add_rod(att, leather, "Crown", crown + Vector3(-hx, 0.0, 0.0), crown + Vector3(hx, 0.0, 0.0), 0.0140)
	MeshKit.add_rod(att, leather, "Brow", brow + Vector3(-hx * 0.92, 0.0, 0.0), brow + Vector3(hx * 0.92, 0.0, 0.0), 0.0160)
	MeshKit.add_rod(att, navy, "BrowPad", brow + Vector3(-hx * 0.72, 0.0, 0.018), brow + Vector3(hx * 0.72, 0.0, 0.018), 0.0120)
	MeshKit.add_rod(att, leather, "Nose", nose + Vector3(-hx * 0.74, 0.0, 0.0), nose + Vector3(hx * 0.74, 0.0, 0.0), 0.0130)
	MeshKit.add_rod(att, navy, "Flash", nose + Vector3(-hx * 0.48, 0.018, -0.008), nose + Vector3(hx * 0.48, 0.018, -0.008), 0.0090)
	var gold := MeshKit.mat_color(Color(0.78, 0.62, 0.28), 0.28, 0.72)
	MeshKit.add_child_mi(att, MeshKit.sphere(0.0048, 6, 6), gold, "BrowStud", brow + Vector3(-hx * 0.22, 0.0, 0.012))
	MeshKit.add_child_mi(att, MeshKit.sphere(0.0048, 6, 6), gold, "BrowStud2", brow + Vector3(hx * 0.22, 0.0, 0.012))
	MeshKit.add_child_mi(att, MeshKit.sphere(0.0052, 6, 6), gold, "BrowStudC", brow + Vector3(0.0, 0.002, 0.014))
	MeshKit.add_child_mi(att, MeshKit.box(Vector3(0.018, 0.014, 0.010)), steel, "FlashBuckle", nose + Vector3(0.0, 0.022, 0.004))
	MeshKit.add_rod(att, steel, "Bit", bitp + Vector3(-mx, 0.0, 0.0), bitp + Vector3(mx, 0.0, 0.0), 0.007)
	var throat := Vector3(cx, box.position.y + box.size.y * 0.36, box.position.z + box.size.z * 0.18)
	for sx in [-1.0, 1.0]:
		var cheek_top := brow + Vector3(sx * hx * 0.88, 0.02, -0.02)
		var ring := bitp + Vector3(sx * mx, 0.0, 0.0)
		MeshKit.add_rod(att, leather, "Cheek", cheek_top, ring, 0.0090)
		MeshKit.add_rod(att, leather, "Keep", cheek_top + Vector3(0.0, 0.04, 0.0), nose + Vector3(sx * hx * 0.70, 0.0, 0.0), 0.0050)
		MeshKit.add_rod(att, leather, "Throat", crown + Vector3(sx * hx * 0.35, 0.04, -0.04), throat + Vector3(sx * 0.03, 0.10, -0.02), 0.0060)
		MeshKit.add_child_mi(att, MeshKit.torus(0.018, 0.032), steel, "BitRing", ring, Vector3(0.0, 0.0, 1.20))
		MeshKit.add_child_mi(att, MeshKit.box(Vector3(0.012, 0.016, 0.008)), leather, "Keeper", cheek_top + Vector3(0.0, 0.01, 0.0))
		var rose := brow + Vector3(sx * hx * 0.88, 0.0, 0.012)
		MeshKit.add_child_mi(att, MeshKit.cyl(0.018, 0.010, 0.018, 10), navy, "Rosette", rose, Vector3(1.20, 0.0, 0.0))
		MeshKit.add_child_mi(att, MeshKit.sphere(0.005, 6, 6), MeshKit.mat_color(Color(0.78, 0.62, 0.28), 0.32, 0.86), "RosePin", rose + Vector3(0.0, 0.0, 0.006))
		var mark := Marker3D.new()
		mark.name = "BitL" if sx < 0.0 else "BitR"
		mark.position = ring
		att.add_child(mark)
	print("TACK place crown=", crown, " brow=", brow, " nose=", nose, " bit=", bitp)


static func _bone_local_aabb(skel: Skeleton3D, root: Node, bone: String) -> AABB:
	var i := skel.find_bone(bone)
	if i < 0:
		return AABB()
	var xf_inv := (skel.global_transform * skel.get_bone_global_rest(i)).affine_inverse()
	var box := AABB()
	var first := true
	var stack: Array[Node] = [root]
	while not stack.is_empty():
		var cur: Node = stack.pop_back()
		if cur is MeshInstance3D:
			var mi := cur as MeshInstance3D
			if mi.mesh:
				for s in mi.mesh.get_surface_count():
					var arr := mi.mesh.surface_get_arrays(s)
					var verts: PackedVector3Array = arr[Mesh.ARRAY_VERTEX]
					var bones = arr[Mesh.ARRAY_BONES]
					var weights = arr[Mesh.ARRAY_WEIGHTS]
					if bones == null:
						continue
					var stride := 4
					if bones.size() >= verts.size() * 8:
						stride = 8
					for vi in verts.size():
						var best_w := -1.0
						var best_b := -1
						for k in stride:
							var idx := vi * stride + k
							if idx >= bones.size():
								break
							var w := 0.0
							if weights != null and idx < weights.size():
								w = float(weights[idx])
							if w > best_w:
								best_w = w
								best_b = int(bones[idx])
						if best_b != i or best_w < 0.35:
							continue
						var local: Vector3 = xf_inv * (mi.global_transform * verts[vi])
						if first:
							box = AABB(local, Vector3.ZERO)
							first = false
						else:
							box = box.expand(local)
		for c in cur.get_children():
			stack.append(c)
	return box


static func _muzzle_local_aabb(skel: Skeleton3D, root: Node) -> AABB:
	var i := skel.find_bone("Head")
	if i < 0:
		return AABB()
	var xf_inv := (skel.global_transform * skel.get_bone_global_rest(i)).affine_inverse()
	var box := AABB()
	var first := true
	var stack: Array[Node] = [root]
	while not stack.is_empty():
		var cur: Node = stack.pop_back()
		if cur is MeshInstance3D:
			var mi := cur as MeshInstance3D
			if mi.mesh and mi.mesh.get_surface_count() > 2:
				var arr := mi.mesh.surface_get_arrays(2)
				if not arr.is_empty():
					var verts: PackedVector3Array = arr[Mesh.ARRAY_VERTEX]
					for v in verts:
						var local: Vector3 = xf_inv * (mi.global_transform * v)
						if first:
							box = AABB(local, Vector3.ZERO)
							first = false
						else:
							box = box.expand(local)
		for c in cur.get_children():
			stack.append(c)
	return box


static func _seat_bone(skel: Skeleton3D) -> String:
	for n in SEAT_BONES:
		var i := skel.find_bone(n)
		if i < 0:
			continue
		if n.begins_with("Neck") or n.begins_with("Head"):
			continue
		return n
	return ""


static func _back_y_near(n: Node, around: Vector3, radius: float) -> float:
	var best := around.y
	if n is MeshInstance3D:
		var mi := n as MeshInstance3D
		if mi.mesh:
			for s in mi.mesh.get_surface_count():
				var arr := mi.mesh.surface_get_arrays(s)
				if arr.is_empty():
					continue
				var verts: PackedVector3Array = arr[Mesh.ARRAY_VERTEX]
				for v in verts:
					var w := mi.global_transform * v
					if Vector2(w.x - around.x, w.z - around.z).length() <= radius:
						best = maxf(best, w.y)
	for c in n.get_children():
		best = maxf(best, _back_y_near(c, around, radius))
	return best


static func _aabb(n: Node) -> AABB:
	var box := AABB()
	var first := true
	if n is MeshInstance3D:
		var vi := n as MeshInstance3D
		var local := vi.get_aabb()
		var xf := vi.global_transform
		for i in 8:
			var c := local.position + local.size * Vector3(float(i & 1), float((i >> 1) & 1), float((i >> 2) & 1))
			var w := xf * c
			if first:
				box = AABB(w, Vector3.ZERO)
				first = false
			else:
				box = box.expand(w)
	for c in n.get_children():
		var child := _aabb(c)
		if child.size != Vector3.ZERO:
			if first:
				box = child
				first = false
			else:
				box = box.merge(child)
	return box


static func _find_skel(n: Node) -> Skeleton3D:
	if n is Skeleton3D:
		return n
	for c in n.get_children():
		var s := _find_skel(c)
		if s:
			return s
	return null


static func _dust(host: Node3D) -> void:
	var dust := GPUParticles3D.new()
	dust.name = "Dust"
	dust.position = Vector3(0, 0.05, 0.15)
	dust.amount = 168
	dust.lifetime = 1.42
	dust.one_shot = true
	dust.explosiveness = 0.90
	dust.emitting = false
	var proc := ParticleProcessMaterial.new()
	proc.direction = Vector3(0, 1, 0.42)
	proc.spread = 70.0
	proc.initial_velocity_min = 0.28
	proc.initial_velocity_max = 1.72
	proc.gravity = Vector3(0, -1.42, 0)
	proc.scale_min = 0.12
	proc.scale_max = 0.48
	proc.color = Color(0.70, 0.58, 0.40, 0.58)
	dust.process_material = proc
	var dq := QuadMesh.new()
	dq.size = Vector2(0.25, 0.25)
	dust.draw_pass_1 = dq
	host.add_child(dust)
