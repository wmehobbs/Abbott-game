extends SkeletonModifier3D

## A standing figure turns her head to follow Abbott round the ring: Michelle
## on the rail, the people in the stands. Neck and head only, eased, and no
## further than a person turns without moving her feet. A modifier, so the
## turn goes on top of whatever the figure's own animation is doing.
## With an AnimationPlayer (the crowd), she idles, and waves once when
## Madison finishes a clear round.

const REACH := 1.2  # radians either way
const NECK_SHARE := 0.35

var anim: AnimationPlayer
var _yaw := 0.0
var _neck := -1
var _head := -1
var _horse: Node3D
var _cheered := false
var _cheer_in := -1.0


## Neck and head. Those are the only bones this turn is allowed to move.
func bind(s: Skeleton3D) -> void:
	_neck = s.find_bone("Neck")
	_head = s.find_bone("Head")


## Idle, each figure starting on a different breath so the stands are not in step.
func start_idle(seed: int) -> void:
	if anim == null:
		return
	for clip in ["Idle", "Wave"]:
		if anim.has_animation(clip):
			anim.get_animation(clip).loop_mode = Animation.LOOP_LINEAR if clip == "Idle" else Animation.LOOP_NONE
	if anim.has_animation("Idle"):
		anim.play("Idle")
		# Not all in step: each starts somewhere else in the breath.
		anim.seek(fposmod(float(seed) * 0.73, anim.get_animation("Idle").length), true)
	anim.animation_finished.connect(func(n: StringName) -> void:
		if n == &"Wave" and anim.has_animation("Idle"):
			anim.play("Idle", 0.3))


## Eases her look toward Abbott, neck first, and waves once when the round is clear.
func _process_modification_with_delta(delta: float) -> void:
	var sk := get_skeleton()
	if sk == null or _head < 0:
		return
	_cheer(delta)
	if _horse == null or not is_instance_valid(_horse):
		_horse = get_tree().get_first_node_in_group("abbott") as Node3D
		if _horse == null:
			return
	var head_w := sk.to_global(sk.get_bone_global_pose(_head).origin)
	var to := _horse.global_position + Vector3(0.0, 1.4, 0.0) - head_w
	# Into the skeleton's frame, where she faces +Z.
	var d := (sk.global_transform.basis.orthonormalized().inverse() * to)
	var want := clampf(atan2(d.x, d.z), -REACH, REACH)
	_yaw = lerpf(_yaw, want, 1.0 - pow(0.05, delta))
	_turn(sk, _neck, _yaw * NECK_SHARE)
	_turn(sk, _head, _yaw * (1.0 - NECK_SHARE))


## Yaw on top of her own clip, about that bone's up axis.
func _turn(sk: Skeleton3D, bone: int, yaw: float) -> void:
	if bone < 0:
		return
	var axis := (sk.get_bone_global_rest(bone).basis.inverse() * Vector3.UP).normalized()
	sk.set_bone_pose_rotation(bone, sk.get_bone_pose_rotation(bone) * Quaternion(axis, yaw))


## One wave after a clear. Each figure waits a moment of her own, so the crowd is ragged.
func _cheer(delta: float) -> void:
	if anim == null or not anim.has_animation("Wave"):
		return
	var gs := get_node_or_null("/root/GameState")
	if gs == null:
		return
	var clear := bool(gs.get("round_complete")) and int(gs.get("last_faults")) == 0
	if not clear:
		_cheered = false
		_cheer_in = -1.0
		return
	if not _cheered and _cheer_in < 0.0:
		# A ragged crowd, not a drill team: each waits a moment of her own.
		_cheer_in = randf_range(0.1, 0.9)
	if _cheer_in >= 0.0:
		_cheer_in -= delta
		if _cheer_in < 0.0:
			_cheered = true
			anim.play("Wave", 0.2)
			# The first person to wave starts the one shared cheer. The farm
			# ignores the rest, so forty people do not each play a copy.
			_applaud()


## The farm owns the one player. Anyone else in the tree is ignored.
func _applaud() -> void:
	var n: Node = self
	while n:
		if n.has_method("applaud"):
			n.call("applaud")
			return
		n = n.get_parent()
