extends Node
class_name RiderMesh

## Quaternius Casual, posed as a hunt-seat rider on Abbott.
## horse.gd still drives the seat signals on the Body / Head pivots: the lean
## (Body pitch), the turn (Body roll), the seat's lift (Body position) and the
## head. This reads them and poses the skeleton directly in the seat's frame:
## seat bones in the saddle, the lean shared by pelvis and spine, each leg hung
## from the hip to its iron at full length (no stretched bones), the iron under
## the ball of the foot, and the fists on the reins above the withers.
## No AnimationPlayer. No root motion.

const GLB := "res://assets/meshes/madison_casual.glb"
const FIT := 1.68 / 1.84
const NAVY := Color(0.07, 0.08, 0.12)
const BEIGE := Color(0.82, 0.74, 0.56)
const SKIN := Color(0.86, 0.72, 0.60)
const BOOT := Color(0.06, 0.05, 0.045)
const TAN := Color(0.55, 0.40, 0.24)
const HAIR := Color(0.22, 0.14, 0.10)

## The seat frame: origin at the deepest point of the saddle, -Z toward his
## head, +X to his right, in metres. Abbott's barrel at the saddle is 0.21 m
## half-wide from 0.2 m to 0.45 m below his back, and his belly is 0.6 m down.
## Her ankle hangs on that barrel under her hip. The knee rides the knee roll.
const ANKLE := Vector3(0.250, -0.505, 0.010)
const KNEE_POLE := Vector3(0.42, -0.06, -1.00)
const TOE_OUT := 14.0
const HEEL_DOWN := 16.0
## Stirrup bar, under the front of the skirt.
const BAR := Vector3(0.120, -0.045, -0.150)
## Fists a hand's width apart, a fist above the withers, just past the pommel.
const HAND := Vector3(0.060, 0.150, -0.220)
const ELBOW_POLE := Vector3(0.20, -0.36, 0.34)
## The pelvis takes half the lean; the spine the rest, chest last.
const PELVIS_SHARE := 0.5
const SPINE := [["Abdomen", 0.20], ["Torso", 0.16], ["Chest", 0.14]]

var visual: Node3D
var skel: Skeleton3D
var _booted := false
var _reported := false
var _horse: Node = null
var _q0 := Basis(Vector3.UP, PI)
var _k := 0.776
var _rest := {}
var _contact := Vector3.ZERO
var _ankle_rest := {}
var _hip_off := Vector3.ZERO
var _stir := {}
var _crop_mi: MeshInstance3D
## Last solved leg points per side, seat frame: knee, ankle, fwd, up, ball.
var _leg := {}
var _life := 0.0
var _post_k := 0.0
var _pat_t := -1.0
var _patted := false


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
	_cache_rest()
	_recolor()
	_hide_casual_feet()
	_cap()
	_coat_bits()
	_gloves()
	_crop()
	_boot_nodes()
	_stirrups()
	_curl_fingers()


func _cache_rest() -> void:
	for i in skel.get_bone_count():
		_rest[String(skel.get_bone_name(i))] = skel.get_bone_global_rest(i)
	var hl: Vector3 = (_rest["UpperLegL"] as Transform3D).origin
	var hr: Vector3 = (_rest["UpperLegR"] as Transform3D).origin
	# Seat bones: under and a touch behind the hip joints. She faces +Z in the glb.
	_contact = (hl + hr) * 0.5 + Vector3(0.0, -0.075, -0.02)
	# The glb's hips are not mirror images (its rest pose is turned a little),
	# which put one knee 2 cm higher and 3 cm back. One mirrored offset.
	var ol := hl - _contact
	var orr := hr - _contact
	_hip_off = Vector3((ol.x - orr.x) * 0.5, (ol.y + orr.y) * 0.5, (ol.z + orr.z) * 0.5)
	for tag in ["L", "R"]:
		var f: Vector3 = (_rest["Foot" + tag] as Transform3D).origin
		# The shin bone ends at the ankle, 5 cm above the foot bone's head.
		_ankle_rest[tag] = f + Vector3(0.0, 0.053, 0.003)


func _ro(bone: String) -> Vector3:
	return (_rest[bone] as Transform3D).origin


func _rb(bone: String) -> Basis:
	return (_rest[bone] as Transform3D).basis


func _process(delta: float) -> void:
	if skel == null or _rest.is_empty():
		return
	# Off his back (walking the course) the mounted rider is hidden: no pose.
	if visual == null or not visual.is_visible_in_tree():
		return
	var body := get_parent() as Node3D
	if body == null:
		return
	var root := body.get_parent() as Node3D
	if root == null:
		return
	var rg := root.global_transform
	var S := Transform3D(rg.basis.orthonormalized(), rg.origin)
	var V := skel.global_transform
	_k = V.basis.get_scale().x
	var unit := rg.basis.get_scale().x
	# horse.gd's seat signals, read off the pivots it already drives.
	var lean := -body.rotation_degrees.x
	# In the air he tips nose-up under her. She folds to stay with his neck.
	lean += 22.0 * _on_neck_weight()
	var roll := body.rotation_degrees.z
	var lift := body.position * unit
	# Rising trot: horse.gd lifts the seat a few centimetres. A posting seat
	# rises a hand's width and comes forward over the pommel.
	var hz := _find_horse()
	# Eased, so a change of gait mid-rise does not drop her in one frame.
	var trotting := hz != null and int(hz.gait) == 2 and not bool(hz.jumping)
	_post_k = move_toward(_post_k, 1.0 if trotting else 0.0, delta * 3.0)
	lift.y *= lerpf(1.0, 2.2, _post_k)
	lift.z *= lerpf(1.0, 2.0, _post_k)
	# A refusal: he stops under her and her weight goes on up his neck, then
	# she sits back as he settles (check_w rises in 0.18 s, gone by 1.2 s).
	var stop := float(hz.check_w) if hz != null else 0.0
	lean += 20.0 * stop
	# Standing, she is not a statue: a slow breath and a look round now and
	# then. Eased in when he stands, out when he moves off.
	var halted := hz != null and int(hz.gait) == 0 and not bool(hz.jumping) and float(hz.speed) < 0.3
	_life = move_toward(_life, 1.0 if halted else 0.0, delta * 1.2)
	var t := float(Time.get_ticks_msec()) / 1000.0
	lean += 0.8 * sin(t * TAU * 0.24) * _life
	var glance := deg_to_rad(9.0 * sin(t * 0.31) + 4.0 * sin(t * 0.73 + 1.3)) * _life
	# After a clear round, once he walks or stands: three pats on his neck.
	var gs := get_node_or_null("/root/GameState")
	var clear := gs != null and bool(gs.get("round_complete")) and int(gs.get("last_faults")) == 0
	if not clear:
		_patted = false
	elif _pat_t < 0.0 and not _patted and hz != null and int(hz.gait) <= 1:
		_pat_t = 0.0
	var pat := 0.0
	if _pat_t >= 0.0:
		_pat_t += delta
		pat = smoothstep(0.0, 0.35, _pat_t) * (1.0 - smoothstep(2.1, 2.5, _pat_t))
		if _pat_t > 2.5:
			_pat_t = -1.0
			_patted = true
	var head_x := 12.0
	var hp := body.get_node_or_null("Head") as Node3D
	if hp:
		head_x = hp.rotation_degrees.x

	# Pelvis and spine, built down the chain in the seat frame.
	var c_seat := Vector3(0.0, lift.y, lift.z)
	var r_roll := Basis(Vector3(0, 0, 1), deg_to_rad(roll * 0.7))
	var r_pel := r_roll * Basis(Vector3.RIGHT, -deg_to_rad(lean * PELVIS_SHARE))
	var o_body := _ro("Body")
	var p_body := c_seat + r_pel * (_q0 * ((o_body - _contact) * _k))
	_set_global("Body", r_pel * _q0 * _rb("Body"), p_body, S, V)
	var p_hips := p_body + r_pel * (_q0 * ((_ro("Hips") - o_body) * _k))
	_set_global("Hips", r_pel * _q0 * _rb("Hips"), p_hips, S, V)
	var prev_name := "Hips"
	var prev_p := p_hips
	var prev_r := r_pel
	for row in SPINE:
		var bn: String = row[0]
		var r: Basis = prev_r * Basis(Vector3.RIGHT, -deg_to_rad(lean * float(row[1])))
		var p: Vector3 = prev_p + prev_r * (_q0 * ((_ro(bn) - _ro(prev_name)) * _k))
		_set_global(bn, r * _q0 * _rb(bn), p, S, V)
		prev_name = bn
		prev_p = p
		prev_r = r
	var p_chest := prev_p
	var r_chest := prev_r
	# Eyes up the line: the face tips down a little more when he worries her.
	var face_down := 8.0 - 0.6 * (head_x - lean)
	var lift_head := face_down - lean
	var r_neck := r_chest * Basis(Vector3.UP, glance * 0.4) * Basis(Vector3.RIGHT, -deg_to_rad(lift_head * 0.45))
	var p_neck := p_chest + r_chest * (_q0 * ((_ro("Neck") - _ro("Chest")) * _k))
	_set_global("Neck", r_neck * _q0 * _rb("Neck"), p_neck, S, V)
	var r_head := r_neck * Basis(Vector3.UP, glance * 0.6) * Basis(Vector3.RIGHT, -deg_to_rad(lift_head * 0.55))
	var p_head := p_neck + r_neck * (_q0 * ((_ro("Head") - _ro("Neck")) * _k))
	_set_global("Head", r_head * _q0 * _rb("Head"), p_head, S, V)

	# Legs: hip to the iron at full length, knee forward and out on the roll.
	for side in [["L", -1.0], ["R", 1.0]]:
		var tag: String = side[0]
		var sx: float = side[1]
		var off := Vector3(_hip_off.x if tag == "L" else -_hip_off.x, _hip_off.y, _hip_off.z)
		var hip := c_seat + r_pel * (_q0 * (off * _k))
		var ankle_t := Vector3(sx * ANKLE.x, ANKLE.y, ANKLE.z)
		var pole := Vector3(sx * KNEE_POLE.x, KNEE_POLE.y, KNEE_POLE.z)
		var a := (_ro("LowerLeg" + tag) - _ro("UpperLeg" + tag)).length() * _k
		var b := ((_ankle_rest[tag] as Vector3) - _ro("LowerLeg" + tag)).length() * _k
		var ik := _two_bone(hip, ankle_t, pole, a, b)
		var knee: Vector3 = ik[0]
		var ankle: Vector3 = ik[1]
		var lat := (knee - hip).cross(ankle - knee).normalized()
		_set_limb("UpperLeg" + tag, _ro("LowerLeg" + tag), hip, knee, lat, Vector3.RIGHT, S, V)
		_set_limb("LowerLeg" + tag, _ankle_rest[tag], knee, ankle, lat, Vector3.RIGHT, S, V)
		_set_foot(tag, sx, ankle, S, V)
		(_leg[tag] as Dictionary)["knee"] = knee

	# Arms: shoulder to the fist on the rein, elbow down and back at the hip.
	var on_neck := _on_neck_weight()
	for side in [["L", -1.0], ["R", 1.0]]:
		var tag: String = side[0]
		var sx: float = side[1]
		var shoulder := p_chest + r_chest * (_q0 * ((_ro("UpperArm" + tag) - _ro("Chest")) * _k))
		var hand := Vector3(sx * HAND.x, HAND.y, HAND.z)
		# In the air the fists go up the crest with his neck: a release.
		hand += Vector3(0.0, -0.06, -0.22) * on_neck
		# Two-point folds the arm forward with the shoulders.
		hand += Vector3(0.0, -0.05, -0.08) * clampf((lean - 15.0) / 30.0, 0.0, 1.0)
		# Thrown forward at a stop, the fists go down his neck.
		hand += Vector3(0.0, -0.05, -0.10) * stop
		if tag == "R" and pat > 0.0:
			# Down onto the side of his neck and three soft pats.
			var bob := maxf(0.0, sin(_pat_t * TAU * 1.6)) * 0.045
			hand = hand.lerp(Vector3(0.15, -0.02 + bob, -0.40), pat)
		var pole := shoulder + Vector3(sx * ELBOW_POLE.x, ELBOW_POLE.y, ELBOW_POLE.z)
		var a := (_ro("LowerArm" + tag) - _ro("UpperArm" + tag)).length() * _k
		var b := (_ro("Wrist" + tag) - _ro("LowerArm" + tag)).length() * _k
		var ik := _two_bone(shoulder, hand, pole, a, b)
		var elbow: Vector3 = ik[0]
		var wrist: Vector3 = ik[1]
		var lat := (elbow - shoulder).cross(wrist - elbow).normalized()
		var rest_lat := Vector3(0, -1, 0) if tag == "L" else Vector3(0, 1, 0)
		_set_limb("UpperArm" + tag, _ro("LowerArm" + tag), shoulder, elbow, lat, rest_lat, S, V)
		_set_limb("LowerArm" + tag, _ro("Wrist" + tag), elbow, wrist, lat, rest_lat, S, V)
		_set_hand(tag, sx, wrist, S, V)

	_place_boots(S)
	_place_stirrups(S)
	_place_crop(S)
	if not _reported:
		_reported = true
		print("RIDER mesh scale ", FIT, " bones ", skel.get_bone_count(), " k ", snappedf(_k, 0.001))


func _set_global(bone: String, basis_seat: Basis, origin_seat: Vector3, S: Transform3D, V: Transform3D) -> void:
	var bi := skel.find_bone(bone)
	if bi < 0:
		return
	var vb := V.basis.orthonormalized()
	var b := (vb.inverse() * (S.basis * basis_seat)).orthonormalized()
	var o := V.affine_inverse() * (S * origin_seat)
	skel.set_bone_global_pose(bi, Transform3D(b, o))


func _frame(d: Vector3, l: Vector3) -> Basis:
	var y := d.normalized()
	var x := (l - y * l.dot(y))
	if x.length() < 0.0001:
		x = y.cross(Vector3.FORWARD)
	x = x.normalized()
	var z := x.cross(y).normalized()
	return Basis(x, y, z)


## Turn a bone so its rest direction lies along from->to and its rest bend
## axis lies along lat. Rest vectors are skeleton space; pose is seat frame.
func _set_limb(bone: String, child_rest: Vector3, from: Vector3, to: Vector3, lat: Vector3, rest_lat_skel: Vector3, S: Transform3D, V: Transform3D) -> void:
	var rest_dir := _q0 * (child_rest - _ro(bone)).normalized()
	var rest_lat := _q0 * rest_lat_skel
	var r := _frame(to - from, lat) * _frame(rest_dir, rest_lat).inverse()
	_set_global(bone, r * _q0 * _rb(bone), from, S, V)


func _two_bone(root: Vector3, target: Vector3, pole: Vector3, a: float, b: float) -> Array:
	var diff := target - root
	var d := clampf(diff.length(), absf(a - b) + 0.001, a + b - 0.001)
	var dir := diff.normalized()
	var cos_a := clampf((a * a + d * d - b * b) / (2.0 * a * d), -1.0, 1.0)
	var sin_a := sqrt(maxf(0.0, 1.0 - cos_a * cos_a))
	var pv := pole - root
	var n := pv - dir * pv.dot(dir)
	if n.length() < 0.0001:
		n = dir.cross(Vector3.RIGHT)
	n = n.normalized()
	return [root + dir * (a * cos_a) + n * (a * sin_a), root + dir * d]


func _set_foot(tag: String, sx: float, ankle: Vector3, S: Transform3D, V: Transform3D) -> void:
	var turn := Basis(Vector3.UP, -sx * deg_to_rad(TOE_OUT)) * Basis(Vector3.RIGHT, deg_to_rad(HEEL_DOWN))
	var fwd := turn * Vector3(0, 0, -1)
	var up := turn * Vector3.UP
	var r := _frame(fwd, up) * _frame(_q0 * Vector3(0, 0, 1), Vector3.UP).inverse()
	var head := ankle + r * (_q0 * (((_rest["Foot" + tag] as Transform3D).origin - (_ankle_rest[tag] as Vector3)) * _k))
	_set_global("Foot" + tag, r * _q0 * _rb("Foot" + tag), head, S, V)
	_leg[tag] = {"ankle": ankle, "fwd": fwd, "up": up, "heel": head, "ball": head + fwd * 0.085 - up * 0.012}


func _set_hand(tag: String, sx: float, wrist: Vector3, S: Transform3D, V: Transform3D) -> void:
	# Knuckles toward his mouth, thumbs up, palms facing: a fist on each rein.
	var dir := Vector3(-sx * 0.10, -0.38, -1.0).normalized()
	var palm := Vector3(-sx, 0.0, 0.0)
	var rest_dir := _q0 * (Vector3(1, 0, 0) if tag == "L" else Vector3(-1, 0, 0))
	var rest_palm := _q0 * Vector3(0, -1, 0)
	var r := _frame(dir, palm) * _frame(rest_dir, rest_palm).inverse()
	_set_global("Wrist" + tag, r * _q0 * _rb("Wrist" + tag), wrist, S, V)


func _curl_fingers() -> void:
	for i in skel.get_bone_count():
		var n := String(skel.get_bone_name(i))
		if not (n.begins_with("Index") or n.begins_with("Middle") or n.begins_with("Ring") or n.begins_with("Pinky") or n.begins_with("Thumb")):
			continue
		var rg := skel.get_bone_global_rest(i)
		var left := rg.origin.x > 0.0
		# Toward the palm. The first guess curled them up the back of the hand.
		var axis_skel := Vector3(0, 0, 1) if left else Vector3(0, 0, -1)
		var amount := 0.35 if n.begins_with("Thumb") else 1.30
		var axis := (rg.basis.inverse() * axis_skel).normalized()
		var rl := skel.get_bone_rest(i)
		skel.set_bone_pose_rotation(i, (rl.basis * Basis(axis, amount)).get_rotation_quaternion())
		# A little smaller, so the fist stays inside the glove.
		skel.set_bone_pose_scale(i, Vector3.ONE * 0.85)


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


func _on_neck_weight() -> float:
	# 0 on the flat. Through the arc the fists ride up the crest and come home.
	var h: Node = _find_horse()
	if h == null or not h.jumping:
		return 0.0
	var u: float = clampf(float(h.jump_t) / maxf(float(h.jump_dur), 0.01), 0.0, 1.0)
	return smoothstep(0.0, 0.18, u) * (1.0 - smoothstep(0.78, 1.0, u))


func _seat_to_world(S: Transform3D, p: Vector3) -> Vector3:
	return S * p


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
	_helmet_static(skel)


func _coat_bits() -> void:
	# On the bones now, so they lean with her chest and hips, not the old pivot.
	var navy := _mat(NAVY, 0.7)
	var stock := _mat(Color(0.93, 0.93, 0.90), 0.6)
	var gold := _mat(Color(0.78, 0.62, 0.28), 0.35)
	var hips := _attach("Hips", "CoatTails")
	if hips:
		var hb := _rb("Hips")
		for sx in [-1.0, 1.0]:
			var tail := MeshInstance3D.new()
			var box := BoxMesh.new()
			box.size = Vector3(0.075, 0.28, 0.018)
			tail.mesh = box
			tail.material_override = navy
			# Behind her (-Z in the glb), hanging over the cantle.
			var p := Vector3(sx * 0.06, -0.10, -0.115)
			tail.position = hb.inverse() * p
			tail.basis = hb.inverse() * Basis.from_euler(Vector3(deg_to_rad(-14.0), 0.0, deg_to_rad(sx * 6.0)))
			hips.add_child(tail)
	var chest := _attach("Chest", "Stock")
	if chest:
		var cb := _rb("Chest")
		var neck_up := _ro("Neck") - _ro("Chest")
		var tie := MeshInstance3D.new()
		var tb := BoxMesh.new()
		tb.size = Vector3(0.060, 0.042, 0.026)
		tie.mesh = tb
		tie.material_override = stock
		tie.position = cb.inverse() * (neck_up * 0.92 + Vector3(0.0, 0.0, 0.100))
		chest.add_child(tie)
		var pin := MeshInstance3D.new()
		var sp := SphereMesh.new()
		sp.radius = 0.008
		sp.height = 0.016
		pin.mesh = sp
		pin.material_override = gold
		pin.position = cb.inverse() * (neck_up * 0.80 + Vector3(0.0, 0.0, 0.114))
		chest.add_child(pin)


func _gloves() -> void:
	_glove("WristL", "LGlove")
	_glove("WristR", "RGlove")


func _glove(bone: String, node_name: String) -> void:
	var att := _attach(bone, node_name)
	if att == null:
		return
	var g := MeshInstance3D.new()
	# A rounded fist in a glove, not a box: along the hand, flattened a little.
	var sm := SphereMesh.new()
	sm.radius = 0.5
	sm.height = 1.0
	sm.radial_segments = 12
	sm.rings = 6
	g.mesh = sm
	g.material_override = _mat(Color(0.04, 0.04, 0.045), 0.45)
	var dir := 1.0 if bone.ends_with("L") else -1.0
	var inv := _rb(bone).inverse()
	g.transform = Transform3D(inv * Basis.from_scale(Vector3(0.085, 0.055, 0.068)), inv * Vector3(dir * 0.045, -0.010, 0.0))
	att.add_child(g)


func _crop() -> void:
	var crop := MeshInstance3D.new()
	crop.name = "Crop"
	var cyl := CylinderMesh.new()
	cyl.top_radius = 0.0045
	cyl.bottom_radius = 0.007
	cyl.height = 1.0
	crop.mesh = cyl
	crop.material_override = _mat(Color(0.12, 0.08, 0.05), 0.45)
	add_child(crop)
	_crop_mi = crop


func _place_crop(S: Transform3D) -> void:
	if _crop_mi == null:
		return
	var glove := _find_named(skel, "RGlove") as Node3D
	if glove == null:
		return
	# Held in the right fist, the shaft down and back across her thigh.
	var top := glove.global_position
	var dir := (S.basis * Vector3(0.10, -0.78, 0.62)).normalized()
	var length := 0.42 * 0.85
	_crop_mi.global_transform = Transform3D(_align_y(dir) * Basis.from_scale(Vector3(1.0, length, 1.0)), top + dir * (length * 0.5 - 0.03))


func _boot_nodes() -> void:
	for tag in ["L", "R"]:
		var root := Node3D.new()
		root.name = "Boot" + tag
		add_child(root)
		var shaft := MeshInstance3D.new()
		shaft.name = "Shaft"
		var cyl := CylinderMesh.new()
		cyl.top_radius = 0.046
		cyl.bottom_radius = 0.036
		cyl.height = 1.0
		shaft.mesh = cyl
		shaft.material_override = _mat(BOOT, 0.38)
		root.add_child(shaft)
		var cuff := MeshInstance3D.new()
		cuff.name = "Cuff"
		var top := CylinderMesh.new()
		top.top_radius = 0.050
		top.bottom_radius = 0.048
		top.height = 0.035
		cuff.mesh = top
		cuff.material_override = _mat(TAN, 0.5)
		root.add_child(cuff)
		var foot := MeshInstance3D.new()
		foot.name = "Foot"
		var box := BoxMesh.new()
		box.size = Vector3(0.068, 0.05, 0.19)
		foot.mesh = box
		foot.material_override = _mat(BOOT, 0.36)
		root.add_child(foot)
		var heel := MeshInstance3D.new()
		heel.name = "Heel"
		var hb := BoxMesh.new()
		hb.size = Vector3(0.056, 0.035, 0.05)
		heel.mesh = hb
		heel.material_override = _mat(BOOT, 0.4)
		root.add_child(heel)
	_booted = true


func _place_boots(S: Transform3D) -> void:
	if not _booted:
		return
	for tag in ["L", "R"]:
		var root := get_node_or_null("Boot" + tag) as Node3D
		if root == null or not _leg.has(tag):
			continue
		var leg: Dictionary = _leg[tag]
		var knee_w := S * (leg["knee"] as Vector3)
		var ankle_w := S * (leg["ankle"] as Vector3)
		var fwd_w := (S.basis * (leg["fwd"] as Vector3)).normalized()
		var up_w := (S.basis * (leg["up"] as Vector3)).normalized()
		var top := knee_w.lerp(ankle_w, 0.12)
		var bottom := ankle_w - up_w * 0.02
		var span := bottom - top
		var shaft := root.get_node("Shaft") as MeshInstance3D
		shaft.global_transform = Transform3D(_align_y(span) * Basis.from_scale(Vector3(1.0, span.length(), 1.0)), (top + bottom) * 0.5)
		var cuff := root.get_node("Cuff") as MeshInstance3D
		cuff.global_transform = Transform3D(_align_y(span), top + span.normalized() * 0.012)
		var side := fwd_w.cross(up_w).normalized()
		var fb := Basis(side, up_w, -fwd_w)
		var foot := root.get_node("Foot") as MeshInstance3D
		foot.global_transform = Transform3D(fb, ankle_w + fwd_w * 0.050 - up_w * 0.048)
		var heel := root.get_node("Heel") as MeshInstance3D
		heel.global_transform = Transform3D(fb, ankle_w - fwd_w * 0.040 - up_w * 0.075)


func _stirrups() -> void:
	var strap := _mat(Color(0.16, 0.09, 0.05), 0.5)
	var steel := MeshKit.steel()
	var rubber := _mat(Color(0.08, 0.08, 0.08), 0.72)
	for tag in ["L", "R"]:
		var leather := MeshInstance3D.new()
		leather.name = "Leather" + tag
		var lb := BoxMesh.new()
		lb.size = Vector3(0.022, 1.0, 0.005)
		leather.mesh = lb
		leather.material_override = strap
		add_child(leather)
		var iron := MeshInstance3D.new()
		iron.name = "Iron" + tag
		var tm := TorusMesh.new()
		tm.inner_radius = 0.040
		tm.outer_radius = 0.049
		iron.mesh = tm
		iron.material_override = steel
		add_child(iron)
		var tread := MeshInstance3D.new()
		tread.name = "Tread" + tag
		var tb := BoxMesh.new()
		tb.size = Vector3(0.088, 0.010, 0.036)
		tread.mesh = tb
		tread.material_override = rubber
		add_child(tread)
		_stir[tag] = {"leather": leather, "iron": iron, "tread": tread}


func _place_stirrups(S: Transform3D) -> void:
	for side in [["L", -1.0], ["R", 1.0]]:
		var tag: String = side[0]
		var sx: float = side[1]
		if not _stir.has(tag) or not _leg.has(tag):
			continue
		var parts: Dictionary = _stir[tag]
		var leg: Dictionary = _leg[tag]
		var up_w := S.basis.y.normalized()
		var fwd_w := (S.basis * (leg["fwd"] as Vector3)).normalized()
		var flat := (fwd_w - up_w * fwd_w.dot(up_w)).normalized()
		# The tread is under the ball of her foot; the ring stands around it.
		var tread_p := S * (leg["ball"] as Vector3) - up_w * 0.030
		var ring_c := tread_p + up_w * 0.050
		var eye := ring_c + up_w * 0.050
		var bar := S * Vector3(sx * BAR.x, BAR.y, BAR.z)
		var span := bar - eye
		(parts["leather"] as MeshInstance3D).global_transform = Transform3D(_align_y(span) * Basis.from_scale(Vector3(1.0, span.length(), 1.0)), (bar + eye) * 0.5)
		var side_w := flat.cross(up_w).normalized()
		(parts["iron"] as MeshInstance3D).global_transform = Transform3D(Basis(side_w, flat, up_w) * Basis.from_scale(Vector3(1.0, 1.0, 1.18)), ring_c)
		(parts["tread"] as MeshInstance3D).global_transform = Transform3D(Basis(side_w, up_w, -flat), tread_p)


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


static func make_standing(kind: String, keep_anim: bool = false) -> Node3D:
	var root := Node3D.new()
	root.name = "Michelle" if kind == "trainer" else "Madison"
	if not ResourceLoader.exists(GLB):
		return root
	var packed: PackedScene = load(GLB)
	if packed == null:
		return root
	var vis: Node3D = packed.instantiate()
	vis.name = "Casual"
	# Walking Madison and the crowd keep the glb's own clips; the rest stand still.
	if not keep_anim and not kind.begins_with("spectator"):
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
	# Riders wear boots over the glb's shoes; the crowd keeps its own shoes.
	for n in ["Cube070", "Cube070_1"]:
		var node := _find_named_static(vis, n)
		if node is Node3D:
			(node as Node3D).visible = kind.begins_with("spectator")
	var spectator := kind.begins_with("spectator")
	if kind != "trainer" and not spectator:
		_helmet_static(skel)
	if not spectator:
		_boots_on_bones(skel)
	if kind == "trainer":
		_clipboard(root)
	if kind == "trainer" or spectator:
		# Michelle and the people in the stands follow him round the ring: a
		# modifier on her skeleton, so it turns her head on top of her idle.
		var watch: Node = load("res://scripts/watch_rider.gd").new()
		watch.name = "WatchRider"
		skel.add_child(watch)
		watch.call("bind", skel)
		if spectator:
			watch.set("anim", vis.find_child("AnimationPlayer", true, false))
			watch.call("start_idle", int(kind.substr(9)) if kind.length() > 9 else 0)
	return root


static func _helmet_static(skel: Skeleton3D) -> void:
	# A velvet riding helmet over the hair: a dome to just above her brows and
	# a short peak. Offsets are from the head bone: the hair is 0.23 wide,
	# 0.29 deep and tops out 0.26 above it; her brow is 0.13 in front of it.
	var hi := skel.find_bone("Head")
	if hi < 0:
		return
	var att := BoneAttachment3D.new()
	att.name = "Cap"
	att.bone_name = "Head"
	skel.add_child(att)
	var hb := skel.get_bone_global_rest(hi).basis
	var velvet := _mat_static(Color(0.05, 0.05, 0.07), 0.82)
	var dome := MeshInstance3D.new()
	dome.name = "Dome"
	var sm := SphereMesh.new()
	sm.radius = 1.0
	sm.height = 1.0
	sm.is_hemisphere = true
	sm.radial_segments = 20
	sm.rings = 8
	dome.mesh = sm
	dome.material_override = velvet
	dome.transform = Transform3D(hb.inverse() * Basis.from_scale(Vector3(0.130, 0.176, 0.162)), hb.inverse() * Vector3(0.0, 0.098, 0.006))
	att.add_child(dome)
	var peak := MeshInstance3D.new()
	peak.name = "Peak"
	var box := BoxMesh.new()
	box.size = Vector3(0.150, 0.010, 0.060)
	peak.mesh = box
	peak.material_override = velvet
	peak.transform = Transform3D(hb.inverse() * Basis(Vector3.RIGHT, deg_to_rad(14.0)), hb.inverse() * Vector3(0.0, 0.102, 0.160))
	att.add_child(peak)
	var button := MeshInstance3D.new()
	var bs := SphereMesh.new()
	bs.radius = 0.012
	bs.height = 0.016
	button.mesh = bs
	button.material_override = velvet
	button.position = hb.inverse() * Vector3(0.0, 0.272, 0.006)
	att.add_child(button)


static func _boots_on_bones(skel: Skeleton3D) -> void:
	# Tall boots on her own leg and foot bones, so they stay on the leg in any
	# pose. The shin runs from the knee to the ankle, 5 cm above the foot bone.
	var leather := _mat_static(BOOT, 0.38)
	var tan := _mat_static(TAN, 0.5)
	for tag in ["L", "R"]:
		var li := skel.find_bone("LowerLeg" + tag)
		var fi := skel.find_bone("Foot" + tag)
		if li < 0 or fi < 0:
			continue
		var lr := skel.get_bone_global_rest(li)
		var fr := skel.get_bone_global_rest(fi)
		var ankle := fr.origin + Vector3(0.0, 0.053, 0.003)
		var shin := BoneAttachment3D.new()
		shin.name = "BootShin" + tag
		shin.bone_name = "LowerLeg" + tag
		skel.add_child(shin)
		var top := lr.origin.lerp(ankle, 0.12)
		var bottom := ankle + Vector3(0.0, -0.02, 0.0)
		var span := bottom - top
		var shaft := MeshInstance3D.new()
		shaft.name = "Shaft"
		var cyl := CylinderMesh.new()
		cyl.top_radius = 0.050
		cyl.bottom_radius = 0.040
		cyl.height = 1.0
		shaft.mesh = cyl
		shaft.material_override = leather
		var inv := lr.basis.inverse()
		shaft.transform = Transform3D(inv * _align_y_static(span) * Basis.from_scale(Vector3(1.0, span.length(), 1.0)), inv * ((top + bottom) * 0.5 - lr.origin))
		shin.add_child(shaft)
		var cuff := MeshInstance3D.new()
		cuff.name = "Cuff"
		var cm := CylinderMesh.new()
		cm.top_radius = 0.054
		cm.bottom_radius = 0.052
		cm.height = 0.035
		cuff.mesh = cm
		cuff.material_override = tan
		cuff.transform = Transform3D(inv * _align_y_static(span), inv * (top + span.normalized() * 0.012 - lr.origin))
		shin.add_child(cuff)
		var foot := BoneAttachment3D.new()
		foot.name = "BootFoot" + tag
		foot.bone_name = "Foot" + tag
		skel.add_child(foot)
		var finv := fr.basis.inverse()
		var sole := MeshInstance3D.new()
		sole.name = "Foot"
		var fb := BoxMesh.new()
		fb.size = Vector3(0.078, 0.055, 0.21)
		sole.mesh = fb
		sole.material_override = leather
		# Ahead of the heel along her +Z, a little up off the sole line.
		sole.transform = Transform3D(finv, finv * Vector3(0.0, 0.015, 0.06))
		foot.add_child(sole)
		var heel := MeshInstance3D.new()
		heel.name = "Heel"
		var hb2 := BoxMesh.new()
		hb2.size = Vector3(0.062, 0.035, 0.055)
		heel.mesh = hb2
		heel.material_override = leather
		heel.transform = Transform3D(finv, finv * Vector3(0.0, -0.008, -0.03))
		foot.add_child(heel)


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
	elif kind.begins_with("spectator"):
		# Parents and barn friends in everyday clothes, not six Michelles.
		var shirts: Array[Color] = [Color(0.20, 0.32, 0.55), Color(0.62, 0.18, 0.16), Color(0.86, 0.84, 0.76), Color(0.36, 0.38, 0.40), Color(0.28, 0.45, 0.30), Color(0.70, 0.52, 0.22)]
		var trousers: Array[Color] = [Color(0.16, 0.20, 0.30), Color(0.30, 0.26, 0.20), Color(0.55, 0.50, 0.42)]
		var hairs: Array[Color] = [Color(0.22, 0.14, 0.10), Color(0.45, 0.32, 0.18), Color(0.12, 0.10, 0.09), Color(0.70, 0.58, 0.36)]
		var n := int(kind.substr(9)) if kind.length() > 9 else 0
		top = _mat_static(shirts[n % shirts.size()], 0.7)
		arms = top
		pants = _mat_static(trousers[n % trousers.size()], 0.72)
		hair = _mat_static(hairs[(n * 7 + 1) % hairs.size()], 0.6)
		skin = _mat_static([SKIN, Color(0.74, 0.56, 0.42), Color(0.55, 0.38, 0.27), Color(0.90, 0.76, 0.66)][(n * 3) % 4], 0.55)
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
