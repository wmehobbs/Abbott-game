extends SceneTree


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var packed: PackedScene = load("res://assets/meshes/abbott.glb")
	var inst: Node = packed.instantiate()
	root.add_child(inst)
	var skel := _find_skel(inst)
	var names := ["Shoulder_L", "Elbow_L", "Hip_L", "Hock_L", "Stifle_L", "Cannon_L", "Neck"]
	for name in names:
		var i := skel.find_bone(name)
		if i < 0:
			print("SWING missing ", name)
			continue
		var rest := skel.get_bone_rest(i)
		var b := rest.basis
		print("SWING ", name, " origin=", rest.origin)
		print("  rest X=", b.x, " Y=", b.y, " Z=", b.z)
	var hi := skel.find_bone("Hoof_L")
	var hhi := skel.find_bone("HindCannon_L")
	skel.reset_bone_poses()
	print("HOOF rest ", skel.get_bone_global_pose(hi).origin)
	print("HIND rest ", skel.get_bone_global_pose(hhi).origin)
	_try(skel, "Shoulder_L", Vector3.RIGHT, 0.6, hi, "shoulder X")
	_try(skel, "Shoulder_L", Vector3.FORWARD, 0.6, hi, "shoulder Z")
	_try(skel, "Shoulder_L", Vector3.UP, 0.6, hi, "shoulder Y")
	_try(skel, "Hip_L", Vector3.RIGHT, 0.6, hhi, "hip X")
	_try(skel, "Hip_L", Vector3.FORWARD, 0.6, hhi, "hip Z")
	_try(skel, "Hip_L", Vector3.UP, 0.6, hhi, "hip Y")
	quit(0)


func _try(skel: Skeleton3D, bone: String, axis: Vector3, rad: float, tip: int, label: String) -> void:
	skel.reset_bone_poses()
	var i := skel.find_bone(bone)
	var rest_q := skel.get_bone_rest(i).basis.get_rotation_quaternion()
	skel.set_bone_pose_rotation(i, rest_q * Quaternion(axis, rad))
	print(label, " tip=", skel.get_bone_global_pose(tip).origin)


func _find_skel(n: Node) -> Skeleton3D:
	if n is Skeleton3D:
		return n
	for c in n.get_children():
		var s := _find_skel(c)
		if s:
			return s
	return null
