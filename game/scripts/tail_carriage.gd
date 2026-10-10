extends SkeletonModifier3D

## His tail. The canter and gallop clips carry it straight out behind like a
## flag; a horse's tail lifts at the dock and the hair flows down from it. And
## Idle swings it side to side every 3.3 s like a metronome. On top of the
## clip, before the bascule (so a worried horse still lifts it): at the canter
## the tail is let part way back down toward its hang and bounces a little
## with the stride; standing, the metronome is mostly let go and he swishes
## now and then instead, at no fixed beat; and it follows the bend of a turn a
## beat late. Bone pose only.

const BONES := ["Tail1", "Tail2", "Tail3", "Tail4", "Tail5", "Tail6", "Tail7"]
## How far toward the hang at each gait. The dock keeps more of the clip.
const DROP_CANTER := 0.55
const DROP_JUMP := 0.30
const DROP_HALT := 0.75
const DOCK_SHARE := 0.45
const BOUNCE := 5.0  # degrees at the end of the tail, at the canter
const TURN_SWING := 16.0  # degrees with a full turn
const SWISH := 30.0  # degrees at the end of the tail
const SWISH_DUR := 1.1

var horse: Node = null
## The tail as it is drawn, dock to tip, in degrees below his level. Reading
## the skeleton from outside its update sees the clip before this modifier.
var hang_deg := 0.0
var _bones := PackedInt32Array()
var _rest: Array[Quaternion] = []
var _drop := 0.0
var _canter := 0.0
var _turn := 0.0
var _swish_t := -1.0
var _swish_in := 3.0
var _swish_side := 1.0
var _rng := RandomNumberGenerator.new()


## Finds the tail bones and keeps the clip's rest, so the hang has a pose to return toward.
func _bind(sk: Skeleton3D) -> void:
	_bones.clear()
	_rest.clear()
	for n in BONES:
		var b := sk.find_bone(n)
		if b < 0:
			break
		_bones.append(b)
		_rest.append(sk.get_bone_rest(b).basis.get_rotation_quaternion())
	_rng.seed = 0x7A11
	_swish_in = _rng.randf_range(2.0, 5.0)


## Lets the tail down from the flag of the clip, swishes at the halt, and follows a turn a beat late.
func _process_modification_with_delta(delta: float) -> void:
	var sk := get_skeleton()
	if sk == null or horse == null or not is_instance_valid(horse):
		return
	if _bones.is_empty():
		_bind(sk)
		if _bones.is_empty():
			return
	var gait := int(horse.gait)
	var jumping := bool(horse.jumping)
	var standing := gait == 0 and not jumping and float(horse.speed) < 0.3
	var want := 0.0
	if jumping:
		want = DROP_JUMP
	elif gait >= 3:
		want = DROP_CANTER
	elif standing:
		want = DROP_HALT
	_drop = lerpf(_drop, want, 1.0 - pow(0.03, delta))
	_canter = lerpf(_canter, 1.0 if gait >= 3 and not jumping else 0.0, 1.0 - pow(0.03, delta))
	_turn = lerpf(_turn, clampf(float(horse.last_turn), -1.0, 1.0), 1.0 - pow(0.12, delta))
	_swish_step(delta, standing)
	var stride := float(horse.stride_u)
	# His left-right in the skeleton's frame. A bone swings sideways about the
	# axis across it and his left-right, so the dock (pointing back) turns and
	# the hanging hair (pointing down) swings; it lifts about his left-right.
	var inv := sk.global_transform.basis.orthonormalized().inverse()
	var side_sk: Vector3 = (inv * (horse as Node3D).global_transform.basis.orthonormalized().x).normalized()
	var n := _bones.size()
	for i in n:
		var b := _bones[i]
		var q := sk.get_bone_pose_rotation(b)
		var k := _drop * (DOCK_SHARE if i == 0 else 1.0)
		if k > 0.001:
			q = q.slerp(_rest[i], k)
		var share := float(i + 1) / float(n) * 2.0 / float(n)
		var gr := sk.get_bone_global_rest(b).basis.orthonormalized()
		var rb := gr.inverse()
		var swing := 0.0
		var lift := 0.0
		# With the bend: in a left turn his tail curves left, like his neck.
		swing += -_turn * TURN_SWING * share
		# The swish runs down the tail: each bone a beat behind the one above.
		swing += _swish_at(float(i) * 0.07) * SWISH * share
		if _canter > 0.01:
			lift += sin(stride * TAU - float(i) * 0.55) * BOUNCE * _canter * share
		if absf(swing) > 0.01:
			var across := gr.y.normalized().cross(side_sk)
			if across.length() > 0.2:
				q = q * Quaternion((rb * across).normalized(), deg_to_rad(swing))
		if absf(lift) > 0.01:
			q = q * Quaternion((rb * side_sk).normalized(), deg_to_rad(lift))
		sk.set_bone_pose_rotation(b, q)
	var dock := sk.get_bone_global_pose(_bones[0]).origin
	var tip := sk.get_bone_global_pose(_bones[n - 1]).origin
	var d := (horse as Node3D).global_transform.basis.orthonormalized().inverse() * (sk.global_transform.basis * (tip - dock))
	hang_deg = rad_to_deg(asin(clampf(-d.normalized().y, -1.0, 1.0)))


## A swish: out to one side and back once, about a second and a half.
func _swish_step(delta: float, standing: bool) -> void:
	if _swish_t >= 0.0:
		_swish_t += delta
		if _swish_t >= SWISH_DUR + 0.5:
			_swish_t = -1.0
			_swish_in = _rng.randf_range(4.0, 9.0)
		return
	if not standing:
		_swish_in = maxf(_swish_in, 1.5)
		return
	_swish_in -= delta
	if _swish_in <= 0.0:
		_swish_t = 0.0
		_swish_side = -1.0 if _rng.randf() < 0.5 else 1.0


## Where the swish is, lag seconds behind its start. -1..1, 0 when still.
func _swish_at(lag: float) -> float:
	if _swish_t < 0.0:
		return 0.0
	var u := clampf((_swish_t - lag) / SWISH_DUR, 0.0, 1.0)
	return _swish_side * sin(u * PI) * (1.0 - 0.35 * u)
