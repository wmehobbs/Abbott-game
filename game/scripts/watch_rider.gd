extends Node

## A standing figure turns her head to follow Abbott round the ring: Michelle
## on the rail, the people in the stands. Neck and head only, eased, and no
## further than a person turns without moving her feet.

const REACH := 1.2  # radians either way
const NECK_SHARE := 0.35

var skel: Skeleton3D
var _yaw := 0.0
var _neck := -1
var _head := -1
var _horse: Node3D


func bind(s: Skeleton3D) -> void:
	skel = s
	_neck = skel.find_bone("Neck")
	_head = skel.find_bone("Head")


func _process(delta: float) -> void:
	if skel == null or _head < 0:
		return
	if _horse == null or not is_instance_valid(_horse):
		_horse = get_tree().get_first_node_in_group("abbott") as Node3D
		if _horse == null:
			return
	var head_w := skel.to_global(skel.get_bone_global_rest(_head).origin)
	var to := _horse.global_position + Vector3(0.0, 1.4, 0.0) - head_w
	# Into the skeleton's frame, where she faces +Z.
	var d := (skel.global_transform.basis.orthonormalized().inverse() * to)
	var want := clampf(atan2(d.x, d.z), -REACH, REACH)
	_yaw = lerpf(_yaw, want, 1.0 - pow(0.05, delta))
	_turn(_neck, _yaw * NECK_SHARE)
	_turn(_head, _yaw * (1.0 - NECK_SHARE))


func _turn(bone: int, yaw: float) -> void:
	if bone < 0:
		return
	var rest := skel.get_bone_rest(bone)
	var axis := (skel.get_bone_global_rest(bone).basis.inverse() * Vector3.UP).normalized()
	skel.set_bone_pose_rotation(bone, (rest.basis * Basis(axis, yaw)).get_rotation_quaternion())
