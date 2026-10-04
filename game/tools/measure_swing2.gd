extends SceneTree


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var packed: PackedScene = load("res://assets/meshes/abbott.glb")
	var inst: Node = packed.instantiate()
	root.add_child(inst)
	var skel := _find_skel(inst)
	var hi := skel.find_bone("Hoof_L")
	var hhi := skel.find_bone("HindCannon_L")
	for a in [-0.7, -0.4, 0.0, 0.4, 0.7]:
		skel.reset_bone_poses()
		_rot(skel, "Shoulder_L", a)
		print("front shoulder ", a, " hoof=", skel.get_bone_global_pose(hi).origin)
	for a in [-0.7, -0.4, 0.0, 0.4, 0.7]:
		skel.reset_bone_poses()
		_rot(skel, "Hip_L", a)
		print("hind hip ", a, " tip=", skel.get_bone_global_pose(hhi).origin)
	skel.reset_bone_poses()
	_rot(skel, "Shoulder_L", -0.55)
	_rot(skel, "Elbow_L", 0.45)
	_rot(skel, "Cannon_L", 0.2)
	print("front retract combo hoof=", skel.get_bone_global_pose(hi).origin)
	skel.reset_bone_poses()
	_rot(skel, "Hip_L", -0.5)
	_rot(skel, "Stifle_L", 0.35)
	_rot(skel, "Hock_L", 0.45)
	print("hind retract combo tip=", skel.get_bone_global_pose(hhi).origin)
	quit(0)


func _rot(skel: Skeleton3D, bone: String, rad: float) -> void:
	var i := skel.find_bone(bone)
	var rest_q := skel.get_bone_rest(i).basis.get_rotation_quaternion()
	skel.set_bone_pose_rotation(i, rest_q * Quaternion(Vector3.RIGHT, rad))


func _find_skel(n: Node) -> Skeleton3D:
	if n is Skeleton3D:
		return n
	for c in n.get_children():
		var s := _find_skel(c)
		if s:
			return s
	return null
