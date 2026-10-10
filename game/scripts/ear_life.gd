extends SkeletonModifier3D

## His ears. Idle, Walk and Trot hold them still and pricked, so from the
## saddle he looked carved. A horse under saddle tips one back to listen to
## his rider every few seconds, now one, now both, and at the canter both go
## forward to the fence. Before the bascule, so a worried horse's pricked
## ears still go on top. Bone pose only.

const BACK := 38.0  # degrees an ear tips back to listen
const FORWARD := 10.0  # degrees both go forward at the canter and over a fence
const RISE := 0.22
const FALL := 0.35

var horse: Node = null
var _ears := PackedInt32Array()
var _t: Array[float] = [-1.0, -1.0]  # time into a flick, -1 when still
var _hold: Array[float] = [0.8, 0.8]
var _wait: Array[float] = [2.0, 3.5]
var _fwd := 0.0
var _rng := RandomNumberGenerator.new()


func _bind(sk: Skeleton3D) -> void:
	_ears.clear()
	for s in [".L", ".R"]:
		var b := sk.find_bone("Ear1" + s)
		if b < 0:
			_ears.clear()
			return
		_ears.append(b)
	_rng.seed = 0xEA25
	_wait = [_rng.randf_range(1.5, 4.0), _rng.randf_range(2.5, 6.0)]


func _process_modification_with_delta(delta: float) -> void:
	var sk := get_skeleton()
	if sk == null or horse == null or not is_instance_valid(horse):
		return
	if _ears.is_empty():
		_bind(sk)
		if _ears.is_empty():
			return
	var jumping := bool(horse.jumping)
	var gait := int(horse.gait)
	var listening := not jumping and gait <= 2
	_fwd = lerpf(_fwd, 1.0 if gait >= 3 or jumping else 0.0, 1.0 - pow(0.05, delta))
	for e in 2:
		var back := 0.0
		if _t[e] >= 0.0:
			_t[e] += delta
			var t := _t[e]
			var hold := _hold[e]
			if t < RISE:
				back = smoothstep(0.0, RISE, t)
			elif t < RISE + hold:
				back = 1.0
			elif t < RISE + hold + FALL:
				back = 1.0 - smoothstep(RISE + hold, RISE + hold + FALL, t)
			else:
				_t[e] = -1.0
				_wait[e] = _rng.randf_range(2.5, 7.0)
		elif listening:
			_wait[e] -= delta
			if _wait[e] <= 0.0:
				_start(e)
				# Now and then both at once.
				if _rng.randf() < 0.3 and _t[1 - e] < 0.0:
					_start(1 - e)
		_tip(sk, _ears[e], BACK * back * (1.0 - _fwd) - FORWARD * _fwd)


func _start(e: int) -> void:
	_t[e] = 0.0
	_hold[e] = _rng.randf_range(0.4, 1.2)


## As bascule._bend: skeleton space is Z up and -Y forward, so the turn is
## about X, and a positive angle tips the ear's tip back toward the rider.
func _tip(sk: Skeleton3D, bone: int, deg_back: float) -> void:
	if absf(deg_back) < 0.01:
		return
	var g := sk.get_bone_global_pose(bone).basis.orthonormalized()
	var axis := (g.inverse() * Vector3(1.0, 0.0, 0.0)).normalized()
	sk.set_bone_pose_rotation(bone, sk.get_bone_pose_rotation(bone) * Quaternion(axis, deg_to_rad(-deg_back)))
