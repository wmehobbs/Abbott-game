extends SkeletonModifier3D

## The bascule. Gallop_Jump turns Back, Torso, Torso2 and Torso3 as one plank —
## the same seesaw as the old visual tilt. This bends them on top of the clip:
## forehand up at the leave, back round over the top, neck out and down, then
## opening, and nothing left by the land so the canter does not inherit it.
## Bone pose only. The root never moves.

var horse: Node = null
## The withers as they are drawn, after the bend. rider_mesh anchors her fists
## here; reading the skeleton from _process sees the clip before the bend.
var withers := Transform3D()
var has_withers := false

## The hoof bones are IK roots, not children of the legs. The clip's IK
## targets sit up to 16 cm off the cannon tips and the bends here moved the
## cannons further, so the pastern stretched. Each hoof is put back on its own
## cannon; on the ground the leg reaches for the sand, not the hoof.
const CONTACT := 0.053
## What is left when the leg is already straight, the pastern takes — no more.
const PASTERN := 0.03
## hoof, its IK root, the two leg bones above it
const LEGS := [
	["FF.L", "IKFrontLeg.L", "FrontUpperLeg.L", "FrontLowerLeg.L"],
	["FF.R", "IKFrontLeg.R", "FrontUpperLeg.R", "FrontLowerLeg.R"],
	["FFB.L", "IKBackLeg.L", "BackUpperLeg.L", "BackLowerLeg.L"],
	["FFB.R", "IKBackLeg.R", "BackUpperLeg.R", "BackLowerLeg.R"],
]


## He gets quieter. A green, worried horse carries his head and his tail up
## and his ears pricked forward; confidence settles them. Read from the stats, never written, and
## only on the ground: it is gone by a third of the way into a jump, so the
## crest is the same at any confidence, and it comes back over the first half
## second of the recover.
const WORRY_NECK := 18.0
const WORRY_TAIL := -18.0
const WORRY_EAR := -34.0


func _worry_w(u: float) -> float:
	var t := clampf((70.0 - float(GameState.abbott_confidence)) / 40.0, 0.0, 1.0)
	if t <= 0.0:
		return 0.0
	var lr: float = horse.land_recover
	var back := clampf((2.72 - lr) / 0.50, 0.0, 1.0) if lr > 0.0 else 1.0
	var air := (1.0 - smoothstep(0.0, 0.30, u)) if horse.jumping else 1.0
	return t * back * air


func _worry(sk: Skeleton3D, w: float) -> void:
	if w <= 0.0005:
		return
	_bend(sk, "Neck1", WORRY_NECK * w)
	_bend(sk, "Tail1", WORRY_TAIL * w)
	for s in [".L", ".R"]:
		_bend(sk, "Ear1" + s, WORRY_EAR * w)


func _process_modification_with_delta(_delta: float) -> void:
	var sk := get_skeleton()
	if sk == null or horse == null or not is_instance_valid(horse):
		return
	if not horse.jumping:
		_worry(sk, _worry_w(0.0))
		# The check after a refusal: head up, hind legs under him, on Idle.
		var c: float = horse.check_w
		if c > 0.0:
			_bend(sk, "Neck1", 12.0 * c)
			for s in [".L", ".R"]:
				_bend(sk, "BackLowerLeg" + s, 18.0 * c)
				_bend(sk, "FrontLowerLeg" + s, 8.0 * c)
		if c > 0.0:
			# A check sits on the hocks: the hinds stay down, the forehand comes up.
			_legs(sk, true, false, c)
		else:
			_legs(sk, true, true, 0.0)
		_keep_withers(sk)
		return
	var u := clampf(horse.jump_t / maxf(horse.jump_dur, 0.01), 0.0, 1.0)
	# up: neck lifts into the leave. round: the crest. open: reaching for the sand.
	var up := smoothstep(0.0, 0.20, u) * (1.0 - smoothstep(0.20, 0.45, u))
	var round := smoothstep(0.20, 0.55, u) * (1.0 - smoothstep(0.55, 1.0, u))
	var open := smoothstep(0.55, 0.85, u) * (1.0 - smoothstep(0.85, 1.0, u))
	_worry(sk, _worry_w(u))
	if horse.will_rail:
		# A chip is flat. He gets there under himself and goes up, not over:
		# no crest in the back, the neck a little up, the fore legs hanging
		# instead of folded, and nothing left for the land.
		_bend(sk, "Neck1", 10.0 * up + 6.0 * round)
		for s in [".L", ".R"]:
			_bend(sk, "FrontLowerLeg" + s, 6.0 * round + 8.0 * open)
			_bend(sk, "BackLowerLeg" + s, -6.0 * round + 12.0 * open)
		_legs(sk, false, true, 0.0, smoothstep(0.90, 1.0, u))
		_keep_withers(sk)
		return
	# Degrees, tip up positive. Each child inherits its parent's bend, so the
	# back rounds between the loins and the withers, not at one pivot.
	# A round back and a folded forearm. The old bend left him flat, both
	# ends leaving together, which reads as a hop.
	_bend(sk, "Torso", 20.0 * round)
	_bend(sk, "Torso2", -8.0 * round)
	_bend(sk, "Torso3", -16.0 * round + 4.0 * open)
	_bend(sk, "Neck1", 14.0 * up - 32.0 * round - 8.0 * open)
	for s in [".L", ".R"]:
		_bend(sk, "FrontUpperLeg" + s, -18.0 * round + 6.0 * open)
		_bend(sk, "FrontLowerLeg" + s, -50.0 * round + 10.0 * open)
		_bend(sk, "BackLowerLeg" + s, -10.0 * round + 16.0 * open)
	_legs(sk, false, true, 0.0, smoothstep(0.90, 1.0, u))
	_keep_withers(sk)


func _legs(sk: Skeleton3D, ground: bool, plant_fore: bool, hind_w: float, reach: float = 0.0) -> void:
	# In the air the hoof rides its cannon. On the ground a hoof the clip has
	# down is on the sand, no hoof is under it, and in a check the hinds are
	# down whatever stride the clip was blending out of — the leg bends to get
	# there, and the hoof stays on the end of it. Coming down to the land the
	# legs reach for the sand over the last tenth, so u 1.00 is already there.
	var up_scale := sk.global_transform.basis.get_scale().z
	for k in LEGS.size():
		var hi := sk.find_bone(LEGS[k][0])
		var ri := sk.find_bone(LEGS[k][1])
		var ui := sk.find_bone(LEGS[k][2])
		var li := sk.find_bone(LEGS[k][3])
		if hi < 0 or ri < 0 or ui < 0 or li < 0:
			continue
		var off := sk.get_bone_global_rest(li).affine_inverse() * sk.get_bone_global_rest(hi)
		var hoof := sk.get_bone_global_pose(li) * off
		var r := 1.0 if ground else reach
		if r > 0.0:
			var hind := k >= 2
			var rel := sk.get_bone_global_pose(hi).origin.z - sk.get_bone_global_rest(hi).origin.z
			var w := 1.0 - smoothstep(0.02, 0.05, rel)
			if not hind and not plant_fore:
				w = 0.0
			var y := sk.to_global(hoof.origin).y
			var want := lerpf(y, CONTACT + maxf(rel, 0.0) * up_scale, w)
			if hind and hind_w > 0.0:
				want = lerpf(want, CONTACT, hind_w)
			want = lerpf(y, maxf(want, CONTACT), r)
			if absf(want - y) > 0.001:
				var tw := sk.to_global(hoof.origin)
				tw.y = want
				var goal := sk.to_local(tw)
				_reach(sk, ui, li, off.origin, goal)
				hoof = sk.get_bone_global_pose(li) * off
				hoof.origin += (goal - hoof.origin).limit_length(PASTERN)
		sk.set_bone_global_pose(ri, hoof * sk.get_bone_pose(hi).affine_inverse())


func _reach(sk: Skeleton3D, ui: int, li: int, tip_off: Vector3, target: Vector3) -> void:
	# Two-bone reach, the knee kept in the plane it is already bent in.
	var up_g := sk.get_bone_global_pose(ui)
	var lo_g := sk.get_bone_global_pose(li)
	var a_pt := up_g.origin
	var b_pt := lo_g.origin
	var tip := lo_g * tip_off
	var la := a_pt.distance_to(b_pt)
	var lb := b_pt.distance_to(tip)
	var to_t := target - a_pt
	if to_t.length() < 0.001 or la < 0.001 or lb < 0.001:
		return
	var d := clampf(to_t.length(), absf(la - lb) + 0.001, la + lb - 0.001)
	var n := (b_pt - a_pt).cross(tip - a_pt)
	if n.length() < 1.0e-6:
		n = Vector3(1.0, 0.0, 0.0)
	n = n.normalized()
	var cos_a := clampf((la * la + d * d - lb * lb) / (2.0 * la * d), -1.0, 1.0)
	var knee := a_pt + to_t.normalized().rotated(n, -acos(cos_a)) * la
	var q1 := Quaternion((b_pt - a_pt).normalized(), (knee - a_pt).normalized())
	sk.set_bone_global_pose(ui, Transform3D(Basis(q1) * up_g.basis, a_pt))
	lo_g = sk.get_bone_global_pose(li)
	tip = lo_g * tip_off
	var q2 := Quaternion((tip - lo_g.origin).normalized(), (target - lo_g.origin).normalized())
	sk.set_bone_global_pose(li, Transform3D(Basis(q2) * lo_g.basis, lo_g.origin))


func _keep_withers(sk: Skeleton3D) -> void:
	var i := sk.find_bone("Torso3")
	if i >= 0:
		withers = sk.global_transform * sk.get_bone_global_pose(i)
		has_withers = true


func _bend(sk: Skeleton3D, bone: String, deg_up: float) -> void:
	if absf(deg_up) < 0.01:
		return
	var i := sk.find_bone(bone)
	if i < 0:
		return
	# Skeleton space is Z up, -Y forward, so the sagittal axis is X and a
	# negative turn about it lifts a forward-pointing tip.
	var g := sk.get_bone_global_pose(i).basis.orthonormalized()
	var axis := (g.inverse() * Vector3(1.0, 0.0, 0.0)).normalized()
	var q := sk.get_bone_pose_rotation(i) * Quaternion(axis, deg_to_rad(-deg_up))
	sk.set_bone_pose_rotation(i, q)
