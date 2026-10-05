extends Node
class_name RiderMesh

## Quaternius Casual, dressed onto the hunt-seat pivots.
## horse.gd still owns Body / Head / LLeg / RLeg. This copies those angles
## onto the skeleton. No AnimationPlayer. No root motion.

const GLB := "res://assets/meshes/madison_casual.glb"
const FIT := 1.68 / 1.84
const NAVY := Color(0.07, 0.08, 0.12)
const BEIGE := Color(0.82, 0.74, 0.56)
const SKIN := Color(0.86, 0.72, 0.60)
const BOOT := Color(0.06, 0.05, 0.045)
const TAN := Color(0.55, 0.40, 0.24)
const HAIR := Color(0.22, 0.14, 0.10)

var visual: Node3D
var skel: Skeleton3D
var _parked := false
var _booted := false
var _reported := false
## Where her fists sit on his neck at the canter, in the withers frame. In the
## air the hand target rides that spot, so a neck that reaches takes them along.
var _hand_on_neck := {}
var _horse: Node = null
## Her shoulder gives with his unrest on the stride, so her elbow opens and
## closes while her fist stays on its target. Degrees per unit unrest, by gait.
const SHOULDER_GIVE := [0.0, 19.0, 19.0, 19.0]
## Standing there is no stride to give on, so a constant: her shoulders come
## forward with his unrest and the elbow bends, fist still on its target.
const SHOULDER_HALT := -40.0
var _give_w := 0.0
var _halt_w := 0.0
var _shoulder_base := {}


func silence(packed_root: Node) -> void:
	_silence(packed_root)


func setup(packed_root: Node3D) -> void:
	visual = packed_root
	skel = _find_skel(visual)
	if skel == null:
		push_warning("RiderMesh: no skeleton")
		return
	visual.scale = Vector3.ONE * FIT
	for i in skel.get_bone_count():
		skel.set_bone_enabled(i, true)
	_recolor()
	_hide_casual_feet()
	_cap()
	_coat_bits()
	_gloves()
	_crop()
	_boot_nodes()
	_tuck_fingers()


func _process(_delta: float) -> void:
	if skel == null:
		return
	var body := get_parent() as Node3D
	if body == null:
		return
	if not _parked:
		_sit_hips(body)
		_parked = true
	var hip_x := 3.5
	var shin_x := -5.0
	var leg := body.get_node_or_null("LLeg") as Node3D
	if leg:
		hip_x = leg.rotation_degrees.x
		var shin := leg.get_node_or_null("LShin") as Node3D
		if shin:
			shin_x = shin.rotation_degrees.x + hip_x
	# Mounted Casual is yawed 180 in person_look, so mesh +X (her left)
	# lies on the body's -X. The negative side sign puts the left
	# target back on her left.
	var neck: Variant = _neck_xf()
	var on_neck: float = _on_neck_weight()
	var give := _shoulder_give(_delta)
	for side in [["L", -1.0], ["R", 1.0]]:
		_give_shoulder(side[0], -side[1] * give, body)
		_pose_leg(side[0], side[1], hip_x, shin_x)
		# Fists just in front of the pommel, elbows soft. The old point sat
		# on her lap, a metre and a half short of the bit.
		var hand := Vector3(side[1] * 0.055, 0.30, -0.48)
		var pole := Vector3(side[1] * 0.20, 0.20, -0.06)
		var target := body.to_global(hand)
		if neck != null:
			if on_neck < 0.0:
				_hand_on_neck[side[0]] = (neck as Transform3D).affine_inverse() * target
			elif _hand_on_neck.has(side[0]):
				target = target.lerp((neck as Transform3D) * (_hand_on_neck[side[0]] as Vector3), on_neck)
		_ik2("UpperArm" + side[0], "LowerArm" + side[0], "Wrist" + side[0], target, body.to_global(pole))
	_pose_head(body)
	_place_boots(body)
	if not _reported:
		_reported = true
		print("RIDER mesh scale ", FIT, " bones ", skel.get_bone_count())


func _find_horse() -> Node:
	if _horse != null and is_instance_valid(_horse):
		return _horse
	var n: Node = get_parent()
	while n != null:
		if n is Horse:
			_horse = n
			return n
		n = n.get_parent()
	return null


func _shoulder_give(delta: float) -> float:
	var h := _find_horse()
	if h == null:
		return 0.0
	var g: int = h.gait
	var on: bool = g >= 1 and g <= 3 and not h.jumping and h.land_recover <= 0.0
	var halted: bool = g == 0 and not h.jumping and h.land_recover <= 0.0
	_give_w = move_toward(_give_w, 1.0 if on else 0.0, delta * 4.0)
	_halt_w = move_toward(_halt_w, 1.0 if halted else 0.0, delta * 4.0)
	if _give_w <= 0.0 and _halt_w <= 0.0:
		return 0.0
	var unrest := float(h.call("_hand_unrest"))
	var k: float = SHOULDER_GIVE[clampi(g, 0, 3)]
	return sin(float(h.stride_u) * TAU) * k * unrest * _give_w + SHOULDER_HALT * unrest * _halt_w


func _give_shoulder(tag: String, deg: float, body: Node3D) -> void:
	var si := skel.find_bone("Shoulder" + tag)
	if si < 0:
		return
	if not _shoulder_base.has(tag):
		_shoulder_base[tag] = skel.get_bone_pose(si)
	skel.set_bone_pose(si, _shoulder_base[tag])
	if absf(deg) < 0.0001:
		return
	var gp := skel.get_bone_global_pose(si)
	var axis: Vector3 = (skel.global_transform.basis.inverse() * body.global_transform.basis.y).normalized()
	skel.set_bone_global_pose(si, Transform3D(Basis(axis, deg_to_rad(deg)) * gp.basis, gp.origin))


func _neck_xf() -> Variant:
	var h: Node = _find_horse()
	if h == null or h.skel == null:
		return null
	# The withers, where the crest starts and where her fists already sit.
	# Neck1 pivots at its base, ahead of her hands, so anchoring to it swings
	# them up as the neck goes down — a lever, not a crest.
	var bas: Node = h.skel.get_node_or_null("Bascule")
	if bas == null or not bas.get("has_withers"):
		return null
	return bas.get("withers")


func _on_neck_weight() -> float:
	# -1: cantering, learn where the fists sit. 0..1: in the air, ride the crest.
	var h: Node = _find_horse()
	if h == null:
		return 0.0
	if not h.jumping:
		return -1.0 if h.gait == Horse.CANTER else 0.0
	var u: float = clampf(float(h.jump_t) / maxf(float(h.jump_dur), 0.01), 0.0, 1.0)
	return smoothstep(0.0, 0.15, u) * (1.0 - smoothstep(0.85, 1.0, u))


func _pose_leg(tag: String, sx: float, hip_x: float, shin_x: float) -> void:
	var ui := skel.find_bone("UpperLeg" + tag)
	var li := skel.find_bone("LowerLeg" + tag)
	var fi := skel.find_bone("Foot" + tag)
	if ui < 0 or li < 0 or fi < 0:
		return
	var pts := _spec(hip_x, shin_x, sx)
	var upper_b := _body_pos("UpperLeg" + tag)
	var want_knee: Vector3 = pts["knee"]
	var want_heel: Vector3 = pts["heel"]
	_aim(ui, li, _dir_to_skel(want_knee - upper_b))
	var full := _body_pos("LowerLeg" + tag).distance_to(upper_b)
	var s_thigh := clampf(upper_b.distance_to(want_knee) / maxf(full, 0.001), 0.45, 1.25)
	_scale_along(ui, li, s_thigh)
	var knee_b := _body_pos("LowerLeg" + tag)
	var shin_rest := skel.get_bone_global_rest(li).origin.distance_to(skel.get_bone_global_rest(fi).origin) * FIT
	var s_shin := clampf(knee_b.distance_to(want_heel) / maxf(shin_rest, 0.001), 0.35, 1.0)
	_aim(li, fi, _dir_to_skel(want_heel - knee_b))
	_scale_bone(li, s_shin)
	_place_foot_at(li, fi, want_heel)


func _spec(hip_x: float, shin_x: float, sx: float) -> Dictionary:
	var leg := Transform3D(Basis(Vector3(1, 0, 0), deg_to_rad(hip_x)), Vector3(sx * 0.122, -0.018, -0.012))
	var shin := Transform3D(Basis(Vector3(1, 0, 0), deg_to_rad(shin_x - hip_x)), Vector3(sx * 0.028, -0.148, -0.210))
	var knee: Vector3 = leg * Vector3(sx * 0.028, -0.148, -0.210)
	# The barrel is 33 cm wide. These used to land at 15 cm, inside him.
	knee.x = sx * 0.42
	# Sitting, the heel is on the iron, outside the skin. In the two-point
	# the hip opens and the body rises, so the shin reaches back down.
	var stand := clampf((hip_x - 14.0) / 16.0, 0.0, 1.0)
	var drop := lerpf(-0.32, -0.36, stand)
	var fwd := lerpf(0.130, -0.14, stand)
	var heel: Vector3 = leg * (shin * Vector3(sx * 0.010, drop, fwd))
	heel.x = sx * 0.45
	return {"knee": knee, "heel": heel}


func _ik2(upper: String, lower: String, end: String, target_world: Vector3, pole_world: Vector3) -> void:
	var ui := skel.find_bone(upper)
	var li := skel.find_bone(lower)
	var ei := skel.find_bone(end)
	if ui < 0 or li < 0 or ei < 0:
		return
	var a := skel.get_bone_global_rest(ui).origin.distance_to(skel.get_bone_global_rest(li).origin)
	var b := skel.get_bone_global_rest(li).origin.distance_to(skel.get_bone_global_rest(ei).origin)
	var origin: Vector3 = skel.get_bone_global_pose(ui).origin
	var target: Vector3 = skel.global_transform.affine_inverse() * target_world
	var pole: Vector3 = skel.global_transform.affine_inverse() * pole_world
	var diff := target - origin
	if diff.length() < 0.001:
		return
	var dist := clampf(diff.length(), absf(a - b) + 0.001, a + b - 0.001)
	var dir := diff.normalized()
	var cos_a := clampf((a * a + dist * dist - b * b) / (2.0 * a * dist), -1.0, 1.0)
	var sin_a := sqrt(maxf(0.0, 1.0 - cos_a * cos_a))
	var pole_v := pole - origin
	var side := pole_v - dir * pole_v.dot(dir)
	if side.length() < 0.0001:
		side = dir.cross(Vector3.UP)
	side = side.normalized()
	_aim(ui, li, (dir * cos_a + side * sin_a).normalized())
	var joint: Vector3 = skel.get_bone_global_pose(li).origin
	var out := target - joint
	if out.length() < 0.001:
		out = dir
	_aim(li, ei, out.normalized())


func _aim(bi: int, dir_ref: int, dir_skel: Vector3) -> void:
	var rest_g := skel.get_bone_global_rest(bi)
	var rest_dir: Vector3 = skel.get_bone_global_rest(dir_ref).origin - rest_g.origin
	if rest_dir.length() < 0.0001 or dir_skel.length() < 0.0001:
		return
	var q := Quaternion(rest_dir.normalized(), dir_skel.normalized())
	var current := skel.get_bone_global_pose(bi)
	skel.set_bone_global_pose(bi, Transform3D(Basis(q) * rest_g.basis, current.origin))


func _scale_along(bi: int, child: int, s: float) -> void:
	var pose := skel.get_bone_pose(bi)
	var q := pose.basis.get_rotation_quaternion()
	var offset: Vector3 = skel.get_bone_rest(child).origin
	if offset.length() < 0.0001:
		_scale_bone(bi, s)
		return
	var u := offset.normalized()
	var scl := Basis.IDENTITY
	scl.x += u * ((s - 1.0) * u.x)
	scl.y += u * ((s - 1.0) * u.y)
	scl.z += u * ((s - 1.0) * u.z)
	pose.basis = Basis(q) * scl
	skel.set_bone_pose(bi, pose)


func _scale_bone(bi: int, s: float) -> void:
	var pose := skel.get_bone_pose(bi)
	var q := pose.basis.get_rotation_quaternion()
	pose.basis = Basis(q).scaled(Vector3(s, s, s))
	skel.set_bone_pose(bi, pose)


func _place_foot_at(li: int, fi: int, heel_body: Vector3) -> void:
	var body := get_parent() as Node3D
	if body == null:
		return
	var rest_l := skel.get_bone_global_rest(li)
	var rest_f := skel.get_bone_global_rest(fi)
	var rel_basis: Basis = (rest_l.affine_inverse() * rest_f).basis
	rel_basis = Basis(Vector3(1, 0, 0), deg_to_rad(-20.0)) * rel_basis
	var posed := skel.get_bone_global_pose(li)
	var rot := Basis(posed.basis.get_rotation_quaternion()) * rel_basis
	var origin: Vector3 = skel.global_transform.affine_inverse() * body.to_global(heel_body)
	skel.set_bone_global_pose(fi, Transform3D(rot, origin))


func _pose_head(body: Node3D) -> void:
	var head := body.get_node_or_null("Head") as Node3D
	var hi := skel.find_bone("Head")
	if head == null or hi < 0:
		return
	var deg := -4.0 + (head.rotation_degrees.x - 12.0) * 0.45
	var rest := skel.get_bone_rest(hi)
	rest.basis = rest.basis * Basis(Vector3(1, 0, 0), deg_to_rad(deg))
	skel.set_bone_pose(hi, rest)


func _tuck_fingers() -> void:
	for i in skel.get_bone_count():
		var n := String(skel.get_bone_name(i))
		if n.begins_with("Index") or n.begins_with("Middle") or n.begins_with("Ring") or n.begins_with("Pinky") or n.begins_with("Thumb"):
			_scale_bone(i, 0.42)


func _dir_to_skel(dir_body: Vector3) -> Vector3:
	var body := get_parent() as Node3D
	var a: Vector3 = skel.global_transform.affine_inverse() * body.global_transform * Vector3.ZERO
	var b: Vector3 = skel.global_transform.affine_inverse() * body.global_transform * dir_body
	return (b - a).normalized()


func _body_pos(bone: String) -> Vector3:
	var body := get_parent() as Node3D
	var i := skel.find_bone(bone)
	return body.to_local(skel.to_global(skel.get_bone_global_pose(i).origin))


func _sit_hips(_body: Node3D) -> void:
	# Local only. global_position would walk up through the seat bone
	# and must not touch the physics root.
	var i := skel.find_bone("Hips")
	if i < 0:
		return
	var hip: Vector3 = _into_visual(skel, visual) * skel.get_bone_global_rest(i).origin
	# The basis carries the mount's 180 yaw as well as the scale, so the
	# turned mesh still sits its hips on the seat point.
	visual.position = -(visual.basis * hip)


func _recolor() -> void:
	var skin := _mat(SKIN, 0.55)
	var navy := _mat(NAVY, 0.72)
	var beige := _mat(BEIGE, 0.68)
	var hair := _mat(HAIR, 0.58)
	_paint("Cube037", navy)
	_paint("Cube037_1", navy)
	_paint("Casual_Legs", beige)
	_paint("Cube001", skin)
	_paint("Cube001_1", hair)
	_paint("Cube001_2", hair)
	_paint("Cube001_3", hair)


func _hide_casual_feet() -> void:
	for n in ["Cube070", "Cube070_1"]:
		var node := _find_named(visual, n)
		if node is Node3D:
			(node as Node3D).visible = false


func _paint(node_name: String, mat: Material) -> void:
	var n := _find_named(visual, node_name)
	if n is MeshInstance3D:
		var mi := n as MeshInstance3D
		for s in mi.mesh.get_surface_count():
			mi.set_surface_override_material(s, mat)


func _cap() -> void:
	var att := _attach("Head", "Cap")
	if att == null:
		return
	var velvet := _mat(Color(0.08, 0.07, 0.09), 0.78)
	var crown := MeshInstance3D.new()
	var cap := CylinderMesh.new()
	cap.top_radius = 0.09
	cap.bottom_radius = 0.10
	cap.height = 0.055
	crown.mesh = cap
	crown.material_override = velvet
	crown.position = Vector3(0, 0.20, 0.01)
	att.add_child(crown)
	var peak := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = Vector3(0.16, 0.012, 0.08)
	peak.mesh = box
	peak.material_override = velvet
	peak.position = Vector3(0, 0.175, -0.07)
	att.add_child(peak)


func _coat_bits() -> void:
	var navy := _mat(NAVY, 0.7)
	var stock := _mat(Color(0.93, 0.93, 0.90), 0.6)
	var gold := _mat(Color(0.78, 0.62, 0.28), 0.35)
	for sx in [-1.0, 1.0]:
		var tail := MeshInstance3D.new()
		var box := BoxMesh.new()
		box.size = Vector3(0.07, 0.26, 0.016)
		tail.mesh = box
		tail.material_override = navy
		tail.position = Vector3(sx * 0.055, -0.06, 0.10)
		tail.rotation_degrees = Vector3(8, 0, sx * -6)
		add_child(tail)
	var tie := MeshInstance3D.new()
	var tb := BoxMesh.new()
	tb.size = Vector3(0.09, 0.055, 0.028)
	tie.mesh = tb
	tie.material_override = stock
	tie.position = Vector3(0, 0.43, -0.06)
	add_child(tie)
	var pin := MeshInstance3D.new()
	var sp := SphereMesh.new()
	sp.radius = 0.008
	sp.height = 0.016
	pin.mesh = sp
	pin.material_override = gold
	pin.position = Vector3(0, 0.41, -0.075)
	add_child(pin)


func _gloves() -> void:
	_glove("WristL", "LGlove")
	_glove("WristR", "RGlove")


func _glove(bone: String, node_name: String) -> void:
	var att := _attach(bone, node_name)
	if att == null:
		return
	var g := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = Vector3(0.055, 0.04, 0.06)
	g.mesh = box
	g.material_override = _mat(Color(0.04, 0.04, 0.045), 0.45)
	g.position = Vector3(0, -0.02, -0.02)
	att.add_child(g)


func _crop() -> void:
	var att := _find_named(skel, "RGlove")
	if att == null:
		return
	var crop := MeshInstance3D.new()
	var cyl := CylinderMesh.new()
	cyl.top_radius = 0.006
	cyl.bottom_radius = 0.008
	cyl.height = 0.42
	crop.mesh = cyl
	crop.material_override = _mat(Color(0.12, 0.08, 0.05), 0.45)
	crop.position = Vector3(0.02, -0.02, -0.04)
	crop.rotation_degrees = Vector3(70, 0, 12)
	att.add_child(crop)


func _boot_nodes() -> void:
	for tag in ["L", "R"]:
		var root := Node3D.new()
		root.name = "Boot" + tag
		add_child(root)
		var shaft := MeshInstance3D.new()
		shaft.name = "Shaft"
		var cyl := CylinderMesh.new()
		cyl.top_radius = 0.042
		cyl.bottom_radius = 0.048
		cyl.height = 1.0
		shaft.mesh = cyl
		shaft.material_override = _mat(BOOT, 0.42)
		root.add_child(shaft)
		var cuff := MeshInstance3D.new()
		cuff.name = "Cuff"
		var top := CylinderMesh.new()
		top.top_radius = 0.052
		top.bottom_radius = 0.05
		top.height = 0.06
		cuff.mesh = top
		cuff.material_override = _mat(TAN, 0.5)
		root.add_child(cuff)
		var foot := MeshInstance3D.new()
		foot.name = "Foot"
		var box := BoxMesh.new()
		box.size = Vector3(0.07, 0.045, 0.18)
		foot.mesh = box
		foot.material_override = _mat(BOOT, 0.4)
		root.add_child(foot)
		var heel := MeshInstance3D.new()
		heel.name = "Heel"
		var hb := BoxMesh.new()
		hb.size = Vector3(0.05, 0.03, 0.04)
		heel.mesh = hb
		heel.material_override = _mat(BOOT, 0.4)
		root.add_child(heel)
	_booted = true


func _place_boots(body: Node3D) -> void:
	if not _booted:
		return
	for side in [["L", 1.0], ["R", -1.0]]:
		var tag: String = side[0]
		var root := get_node_or_null("Boot" + tag) as Node3D
		if root == null:
			continue
		var knee := _body_pos("LowerLeg" + tag)
		var heel := _body_pos("Foot" + tag)
		var span := heel - knee
		if span.length() < 0.05:
			continue
		var shaft := root.get_node("Shaft") as MeshInstance3D
		var mid := (knee + heel) * 0.5
		shaft.position = mid
		shaft.transform = Transform3D(_align_y(span).scaled(Vector3(1, span.length(), 1)), mid)
		var cuff := root.get_node("Cuff") as MeshInstance3D
		cuff.position = knee + span.normalized() * 0.04
		cuff.basis = _align_y(span)
		var foot := root.get_node("Foot") as MeshInstance3D
		foot.position = heel + Vector3(0, 0.02, -0.05)
		foot.rotation = Vector3.ZERO
		var hob := root.get_node("Heel") as MeshInstance3D
		hob.position = heel + Vector3(0, 0.015, 0.035)
		hob.rotation = Vector3.ZERO


func _align_y(dir: Vector3) -> Basis:
	var y := dir.normalized()
	var x := y.cross(Vector3(0, 0, -1))
	if x.length() < 0.001:
		x = y.cross(Vector3.RIGHT)
	x = x.normalized()
	var z := x.cross(y).normalized()
	return Basis(x, y, z)


func _attach(bone: String, node_name: String) -> BoneAttachment3D:
	if skel == null or skel.find_bone(bone) < 0:
		return null
	var att := BoneAttachment3D.new()
	att.name = node_name
	att.bone_name = bone
	skel.add_child(att)
	return att


static func make_standing(kind: String) -> Node3D:
	var root := Node3D.new()
	root.name = "Michelle" if kind == "trainer" else "Madison"
	if not ResourceLoader.exists(GLB):
		return root
	var packed: PackedScene = load(GLB)
	if packed == null:
		return root
	var vis: Node3D = packed.instantiate()
	vis.name = "Casual"
	_silence_static(vis)
	root.add_child(vis)
	vis.scale = Vector3.ONE * FIT
	var skel := _find_skel_static(vis)
	if skel == null:
		return root
	for i in skel.get_bone_count():
		skel.set_bone_enabled(i, true)
	var into := _into_visual(skel, vis)
	var feet: Array[Vector3] = []
	for bone in ["FootL", "FootR"]:
		var bi := skel.find_bone(bone)
		if bi >= 0:
			feet.append(into * skel.get_bone_global_rest(bi).origin)
	if feet.size() > 0:
		var low := feet[0].y
		for p in feet:
			low = minf(low, p.y)
		vis.position.y = -low * FIT
	_paint_standing(vis, kind)
	for n in ["Cube070", "Cube070_1"]:
		var node := _find_named_static(vis, n)
		if node is Node3D:
			(node as Node3D).visible = false
	if kind != "trainer":
		_cap_on(skel)
	_boots_standing(root, skel, vis, into)
	if kind == "trainer":
		_clipboard(root)
	return root


static func _into_visual(skel: Skeleton3D, vis: Node3D) -> Transform3D:
	var t := Transform3D.IDENTITY
	var n: Node = skel
	while n != null and n != vis:
		if n is Node3D:
			t = (n as Node3D).transform * t
		n = n.get_parent()
	return t


static func _paint_standing(vis: Node, kind: String) -> void:
	var skin := _mat_static(SKIN if kind != "trainer" else Color(0.80, 0.64, 0.52), 0.55)
	var hair := _mat_static(HAIR, 0.58)
	var top := _mat_static(NAVY, 0.72)
	var arms := top
	var pants := _mat_static(BEIGE, 0.68)
	if kind == "trainer":
		top = _mat_static(Color(0.22, 0.28, 0.18), 0.62)
		arms = _mat_static(Color(0.90, 0.88, 0.82), 0.6)
		pants = _mat_static(Color(0.42, 0.36, 0.26), 0.68)
	_paint_static(vis, "Cube037", arms)
	_paint_static(vis, "Cube037_1", top)
	_paint_static(vis, "Casual_Legs", pants)
	_paint_static(vis, "Cube001", skin)
	_paint_static(vis, "Cube001_1", hair)
	_paint_static(vis, "Cube001_2", hair)
	_paint_static(vis, "Cube001_3", hair)


static func _boots_standing(root: Node3D, skel: Skeleton3D, vis: Node3D, into: Transform3D) -> void:
	for tag in ["L", "R"]:
		var ki := skel.find_bone("LowerLeg" + tag)
		var fi := skel.find_bone("Foot" + tag)
		if ki < 0 or fi < 0:
			continue
		var knee := _stood(vis, into * skel.get_bone_global_rest(ki).origin)
		var heel := _stood(vis, into * skel.get_bone_global_rest(fi).origin)
		var span := heel - knee
		if span.length() < 0.05:
			continue
		var shaft := MeshInstance3D.new()
		var cyl := CylinderMesh.new()
		cyl.top_radius = 0.045
		cyl.bottom_radius = 0.05
		cyl.height = 1.0
		shaft.mesh = cyl
		shaft.material_override = _mat_static(BOOT, 0.42)
		shaft.transform = Transform3D(_align_y_static(span).scaled(Vector3(1, span.length(), 1)), (knee + heel) * 0.5)
		root.add_child(shaft)
		var foot := MeshInstance3D.new()
		var box := BoxMesh.new()
		box.size = Vector3(0.075, 0.05, 0.2)
		foot.mesh = box
		foot.material_override = _mat_static(BOOT, 0.4)
		foot.position = heel + Vector3(0, 0.02, -0.04)
		root.add_child(foot)


static func _stood(vis: Node3D, local: Vector3) -> Vector3:
	return vis.position + vis.scale * local


static func _clipboard(root: Node3D) -> void:
	var board := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = Vector3(0.16, 0.22, 0.012)
	board.mesh = box
	board.material_override = _mat_static(Color(0.86, 0.82, 0.72), 0.55)
	board.position = Vector3(0.12, 1.05, 0.16)
	board.rotation_degrees = Vector3(20, 12, -18)
	root.add_child(board)
	var paper := MeshInstance3D.new()
	var sheet := BoxMesh.new()
	sheet.size = Vector3(0.14, 0.18, 0.004)
	paper.mesh = sheet
	paper.material_override = _mat_static(Color(0.94, 0.93, 0.88), 0.72)
	paper.position = Vector3(0.12, 1.05, 0.168)
	paper.rotation_degrees = board.rotation_degrees
	root.add_child(paper)


static func _cap_on(skel: Skeleton3D) -> void:
	if skel.find_bone("Head") < 0:
		return
	var att := BoneAttachment3D.new()
	att.name = "Cap"
	att.bone_name = "Head"
	skel.add_child(att)
	var velvet := _mat_static(Color(0.08, 0.07, 0.09), 0.78)
	var crown := MeshInstance3D.new()
	var cap := CylinderMesh.new()
	cap.top_radius = 0.09
	cap.bottom_radius = 0.10
	cap.height = 0.055
	crown.mesh = cap
	crown.material_override = velvet
	crown.position = Vector3(0, 0.20, 0.01)
	att.add_child(crown)
	var peak := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = Vector3(0.16, 0.012, 0.08)
	peak.mesh = box
	peak.material_override = velvet
	peak.position = Vector3(0, 0.175, -0.07)
	att.add_child(peak)


static func _align_y_static(dir: Vector3) -> Basis:
	var y := dir.normalized()
	var x := y.cross(Vector3(0, 0, -1))
	if x.length() < 0.001:
		x = y.cross(Vector3.RIGHT)
	x = x.normalized()
	return Basis(x, y, x.cross(y).normalized())


static func _paint_static(vis: Node, node_name: String, mat: Material) -> void:
	var n := _find_named_static(vis, node_name)
	if n is MeshInstance3D:
		var mi := n as MeshInstance3D
		for s in mi.mesh.get_surface_count():
			mi.set_surface_override_material(s, mat)


static func _mat_static(c: Color, rough: float) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = c
	m.roughness = rough
	return m


static func _silence_static(n: Node) -> void:
	var doomed: Array[Node] = []
	_collect_players_static(n, doomed)
	for a in doomed:
		var p := a.get_parent()
		if p:
			p.remove_child(a)
		a.free()


static func _collect_players_static(n: Node, out: Array[Node]) -> void:
	if n is AnimationPlayer:
		out.append(n)
		return
	for c in n.get_children():
		_collect_players_static(c, out)


static func _find_skel_static(n: Node) -> Skeleton3D:
	if n is Skeleton3D:
		return n
	for c in n.get_children():
		var s := _find_skel_static(c)
		if s:
			return s
	return null


static func _find_named_static(n: Node, want: String) -> Node:
	if n.name == want:
		return n
	for c in n.get_children():
		var f := _find_named_static(c, want)
		if f:
			return f
	return null


func _mat(c: Color, rough: float) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = c
	m.roughness = rough
	return m


func _silence(n: Node) -> void:
	var doomed: Array[Node] = []
	_collect_players(n, doomed)
	for a in doomed:
		var p := a.get_parent()
		if p:
			p.remove_child(a)
		a.free()


func _collect_players(n: Node, out: Array[Node]) -> void:
	if n is AnimationPlayer:
		out.append(n)
		return
	for c in n.get_children():
		_collect_players(c, out)


func _find_skel(n: Node) -> Skeleton3D:
	if n is Skeleton3D:
		return n
	for c in n.get_children():
		var s := _find_skel(c)
		if s:
			return s
	return null


func _find_named(n: Node, want: String) -> Node:
	if n.name == want:
		return n
	for c in n.get_children():
		var f := _find_named(c, want)
		if f:
			return f
	return null
