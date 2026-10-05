extends CharacterBody3D
class_name Horse

signal gait_changed(gait: int)
signal jumped
signal refused
signal rail_down

const GAIT_NAMES: Array[String] = ["Halt", "Walk", "Trot", "Canter"]
const GAIT_SPEED: Array[float] = [0.0, 1.45, 2.80, 5.55]
const GAIT_TURN: Array[float] = [1.8, 2.40, 1.62, 1.08]
const GAIT_ACCEL: Array[float] = [7.4, 2.5, 2.8, 2.3]
const GAIT_DECEL: Array[float] = [8.2, 3.4, 3.8, 3.0]
## Full stride cycles per second. Walk 4 beats, trot 2, canter 3.
## Walk clip is 1.167s with two diagonal contacts. Trot seeks one cycle per stride.
const STRIDE_HZ: Array[float] = [0.0, 0.857, 1.24, 1.71]
const BEATS: Array[int] = [0, 4, 2, 3]
const CANTER := 3
## The land. A standing hoof bone reads 0.053 m with the sole on the sand; that
## is contact. The old land pose held the forehand up 0.16 rad for all of
## land_recover and the fore feet floated 15–25 cm over the sand.
const LAND_X := -0.01
const HOOF_CONTACT := 0.053
## Her two-point and her arc read his unrest: head_x per unit of _hand_unrest().
const FOLD_HEAD := 30.0
## The sit after a landing reads it in her seat: hip_x per unit of _hand_unrest().
const SIT_HIP := 10.0
## She folds more over a worried horse: rider pitch per unit of _hand_unrest().
const FOLD_PITCH := 18.0
## Her legs hang on her body, so the fold swings the heel off the iron. The lower
## leg comes back under her by this much shin_x per unit of _hand_unrest().
const FOLD_SHIN := 20.0
const CUE := ["whoa", "walk_on", "trot", "canter"]

var gait: int = 0
var speed: float = 0.0
var charge: float = 0.0
var charging: bool = false
var collecting: bool = false
var jumping: bool = false
var jump_t: float = 0.0
var jump_dur: float = 0.62
var jump_start: Vector3
var jump_land: Vector3
var jump_apex: float = 0.0
## Where along the flight the fence is. The arc peaks just before this.
var jump_fence_u: float = 0.55
var jump_fence: JumpFence = null
var will_rail: bool = false
var phase: float = 0.0
var cam_pitch: float = 0.0
var cam_yaw: float = 0.0
const CAM_RIGHT := 2.05
const CAM_BACK := 4.55
const CAM_HEIGHT := 2.62
const CAM_LOOK_Y := 1.22
const CAM_MIN_Y := 2.18
var refuse_cool: float = 0.0
var mounted: bool = true
var controllable: bool = true
var stick_gait_armed: bool = true
var visual: Node3D
var rider: Node3D
var dust: GPUParticles3D
var rein_l: MeshInstance3D
var rein_r: MeshInstance3D
var bit_l: Node3D
var bit_r: Node3D
var glove_l: Node3D
var glove_r: Node3D
var stride_u: float = 0.0
var last_beat: int = -1
## The gait the beat index was last counted in. When the count per stride
## changes (4, 2, 3) floor(stride_u * beats) jumps on the change frame and
## sounded a footfall mid-stride, while the clip was still blending in.
var _beat_gait: int = -1
## Time in this gait. Its clip blends in over 0.18 s (_play_named); a
## footfall that sounds inside that belongs to neither clip.
var _gait_age: float = 0.0
var skel: Skeleton3D
var anim: AnimationPlayer
var gait_clip: String = ""
var seat_bone: String = ""

var spring: SpringArm3D = null
@onready var cam: Camera3D
var hoof_pool: Array[AudioStreamPlayer3D] = []
var hoof_i: int = 0
var hoof_hits: Array[AudioStream] = []
var sfx: AudioStreamPlayer3D
var voice_horse: AudioStreamPlayer3D
var voice_rider: AudioStreamPlayer
var streams := {}
var rider_lines := {}
var cue_cool: float = 0.0
var last_stride_n: int = -1
var lesson_word: String = ""
## Fence already given one silent COUNT. Clears when she lines up or the fence changes.
var count_silent_fence: int = -1
## Fence already given one Come again. Same approach rule as the silent count.
var come_again_fence: int = -1
var last_turn: float = 0.0
var land_recover: float = 0.0
var rider_body: Node3D
var rider_head: Node3D
var rider_lleg: Node3D
var rider_rleg: Node3D
var cam_look: Vector3 = Vector3.ZERO
var cam_look_ready: bool = false
## Chase boom trails his yaw by a fraction so a turn does not whip the lens.
var _rig_yaw: float = 0.0
var _rig_ready: bool = false
## The top rail of the fence he last jumped: the look hands back from it
## over the start of land_recover instead of cutting to the canter look.
var _look_rail: Vector3 = Vector3.ZERO
var _look_rail_set: bool = false
var _cam_land_h: float = 0.0
var _cam_land_ly: float = 0.0
var _cam_was_jumping: bool = false
var _cam_col: float = 0.0
## Mouse look holds. The stick still springs home. A spring on the same
## frame as the mouse undoes the pixel and the lens chatters.
var _mouse_look: float = 0.0
var collect_pulse: float = 0.0
var halt_sit: float = 0.0
var last_stride: float = 0.0
## 0 nothing waiting, 1 grunt waiting for the leave, 2 in the air, 3 thud
## waiting for the fore feet. Same players, same files, on time.
var _air_sound: int = 0
var _land_wait: float = 0.0
var _fore_y: float = 0.0
## The check. A refusal is not a jump: he plants, sits, the forehand comes up
## and the hind legs come under him (bascule.gd reads check_w), then he stands.
var check_w: float = 0.0
var _check_t: float = -1.0
var _check_x0: float = 0.0


func _ready() -> void:
	physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_ON
	add_to_group("abbott")
	collision_layer = 1
	collision_mask = 2
	var cap := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = Vector3(0.62, 1.42, 2.20)
	cap.shape = shape
	cap.position = Vector3(0, 0.72, 0.02)
	add_child(cap)
	var built := AbbottLook.build(self)
	visual = built.get("visual")
	rider = built.get("rider")
	dust = get_node_or_null("Dust")
	_bind_rig()
	_make_reins()
	if skel:
		for n in AbbottLook.SEAT_BONES:
			if skel.find_bone(n) >= 0:
				seat_bone = n
				break
	print("HORSE mesh=WhiteHorse anim=", anim != null, " seat=", seat_bone, " rider_parent=", rider.get_parent().name if rider else "")
	if rider:
		_bind_rider()
	_make_camera()
	_make_audio()
	floor_snap_length = 0.4
	motion_mode = CharacterBody3D.MOTION_MODE_GROUNDED


func _make_camera() -> void:
	# No SpringArm. A downward pitch on a 4.4 m arm put the lens at y≈0.12,
	# inside the sand — Ernie only saw the head, flashing as the clamp fought
	# the arm. Sit high on a fixed boom and look at the withers.
	cam = Camera3D.new()
	cam.name = "Cam"
	cam.fov = 52.0
	cam.near = 0.20
	cam.far = 420.0
	add_child(cam)
	cam.current = mounted
	_place_cam()


func _make_audio() -> void:
	for i in range(1, 13):
		var s := _load_stream("res://assets/audio/hoof/hit_%02d.wav" % i)
		if s:
			hoof_hits.append(s)
	if hoof_hits.is_empty():
		for k in ["hoof_walk", "hoof_trot", "hoof_canter"]:
			var s := _load_stream("res://assets/audio/%s.wav" % k)
			if s:
				hoof_hits.append(s)
	for i in range(4):
		var p := AudioStreamPlayer3D.new()
		p.unit_size = 7.0
		p.max_distance = 36.0
		p.attenuation_model = AudioStreamPlayer3D.ATTENUATION_INVERSE_DISTANCE
		p.position = Vector3(0.0, 0.05, 0.15)
		add_child(p)
		hoof_pool.append(p)
	sfx = AudioStreamPlayer3D.new()
	sfx.unit_size = 10.0
	add_child(sfx)
	voice_horse = AudioStreamPlayer3D.new()
	voice_horse.unit_size = 9.0
	voice_horse.max_distance = 28.0
	voice_horse.position = Vector3(0, 1.35, -0.9)
	add_child(voice_horse)
	voice_rider = AudioStreamPlayer.new()
	voice_rider.volume_db = -2.0
	add_child(voice_rider)
	streams = {
		"jump": _load_stream("res://assets/audio/jump.wav"),
		"land": _load_stream("res://assets/audio/land.wav"),
		"refuse": _load_stream("res://assets/audio/refuse.wav"),
		"rail": _load_stream("res://assets/audio/rail.wav"),
		"snort": _load_stream("res://assets/audio/horse/snort.wav"),
		"blow": _load_stream("res://assets/audio/horse/blow.wav"),
		"nicker": _load_stream("res://assets/audio/horse/nicker.wav"),
		"grunt": _load_stream("res://assets/audio/horse/grunt.wav"),
		"neigh": _load_stream("res://assets/audio/horse/neigh.wav"),
	}
	for k in ["walk_on", "trot", "canter", "whoa", "easy", "good_boy", "come_on", "steady", "and_up"]:
		rider_lines[k] = _load_stream("res://assets/audio/rider/%s.wav" % k)


func _load_stream(p: String) -> AudioStream:
	if ResourceLoader.exists(p):
		return load(p)
	return null


func set_mounted(on: bool) -> void:
	var was := mounted
	mounted = on
	if rider:
		rider.visible = on
	if cam:
		cam.current = on
	if on and not was:
		_horse_voice("nicker")
		_rider_cue("walk_on")


func _process(delta: float) -> void:
	if mounted and controllable and not jumping:
		_camera(delta)
	_place_cam()
	_update_reins()
	_update_rider(delta)


func _physics_process(delta: float) -> void:
	refuse_cool = max(0.0, refuse_cool - delta)
	cue_cool = max(0.0, cue_cool - delta)
	if not controllable:
		_apply_gravity(delta)
		move_and_slide()
		_animate(delta, 0.0)
		return
	if jumping:
		_process_jump(delta)
		_animate(delta, 1.0)
		return
	_process_ride(delta)


func _process_ride(delta: float) -> void:
	_gait_input()
	if Input.is_action_just_pressed("halt"):
		_set_gait(0)

	land_recover = maxf(0.0, land_recover - delta)

	# Space is a half-halt. The first sit is a pulse — he comes back, then
	# stays collected while you hold. Release at canter only asks if a fence
	# is in the takeoff window — it is not a pop-jump.
	if Input.is_action_just_pressed("jump") and GameState.mode == "ride" and gait >= 1 and refuse_cool <= 0.0:
		# A half-halt is a stride, not a paragraph. The old 1.82 s sit held him
		# under 2 m/s for three strides, so rebalancing for a corner cost more
		# than the corner did and the Mini Prix clock could not be made.
		collect_pulse = 0.95
	halt_sit = maxf(0.0, halt_sit - delta)
	if Input.is_action_pressed("jump") and GameState.mode == "ride" and gait >= 1 and refuse_cool <= 0.0:
		collecting = true
		if gait == CANTER:
			charging = true
			charge = min(1.0, charge + delta / 0.42)
		else:
			charging = false
	elif charging:
		collecting = false
		charging = false
		_try_leave()
		charge = 0.0
	else:
		collecting = false
		charge = max(0.0, charge - delta * 2.2)

	var turn := 0.0
	if Input.is_action_pressed("turn_left"):
		turn += 1.0
	if Input.is_action_pressed("turn_right"):
		turn -= 1.0
	var stick_x := Input.get_joy_axis(0, JOY_AXIS_LEFT_X)
	if absf(stick_x) > 0.25:
		turn -= stick_x
	turn = clampf(turn, -1.0, 1.0)
	# The auto rider keeps the old ramp. A person gets a slower bend and a
	# slower release, so the turn comes on like a horse instead of a hinge.
	var ramp := 4.0
	if not _at_ai_reins():
		ramp = 2.6 if absf(turn) + 0.05 >= absf(last_turn) else 1.8
	last_turn = move_toward(last_turn, turn, ramp * delta)
	var turn_rate: float = GAIT_TURN[gait] * GameState.turn_scale()
	if gait == 0:
		turn_rate = 1.4
	if collecting:
		turn_rate *= 1.14
	rotate_y(turn * turn_rate * delta)

	var target: float = GAIT_SPEED[gait]
	if collecting:
		if gait == CANTER:
			target *= 0.70
		elif gait == 2:
			target *= 0.84
		elif gait == 1:
			target *= 0.88
	collect_pulse = maxf(0.0, collect_pulse - delta)
	# The sit and the landing are the same muscle. Take the stronger of them —
	# multiplied together they put him at 0.8 m/s, which is a walk, not a horse
	# coming back to you.
	var sit := 1.0
	if collect_pulse > 0.0:
		sit = minf(sit, 0.36 if collect_pulse > 0.50 else 0.62)
	if land_recover > 0.0:
		sit = minf(sit, 0.58 if land_recover > 0.50 else 0.80)
	if halt_sit > 0.0:
		sit = minf(sit, 0.55)
	target *= sit
	if gait == CANTER and absf(last_turn) > 0.45:
		target *= 0.96
	var accel: float = GAIT_ACCEL[gait]
	if speed > target:
		accel = GAIT_DECEL[gait]
	if gait == 0 and speed > 0.8:
		accel = 5.2
	if collect_pulse > 0.0 and speed > target:
		accel = maxf(accel, 8.6)
	if halt_sit > 0.0 and speed > target:
		accel = maxf(accel, 6.0)
	speed = move_toward(speed, target, accel * delta)
	var fwd := -transform.basis.z
	fwd.y = 0.0
	if fwd.length() > 0.001:
		fwd = fwd.normalized()
	velocity.x = fwd.x * speed
	velocity.z = fwd.z * speed
	_apply_gravity(delta)
	move_and_slide()

	_animate(delta, speed)
	_lesson_count()
	_hoof_audio(speed, delta)
	if dust:
		dust.emitting = speed > 1.1 and is_on_floor()
	_update_last_stride()


func _gait_input() -> void:
	if Input.is_action_just_pressed("gait_up"):
		_set_gait(mini(CANTER, gait + 1))
	if Input.is_action_just_pressed("gait_down"):
		_set_gait(maxi(0, gait - 1))
	# Left stick Y: tap, not hold. Up = gait up.
	var sy := -Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)
	if absf(sy) < 0.45:
		stick_gait_armed = true
	elif stick_gait_armed:
		stick_gait_armed = false
		if sy > 0.45:
			_set_gait(mini(CANTER, gait + 1))
		elif sy < -0.45:
			_set_gait(maxi(0, gait - 1))


func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= 22.0 * delta
	elif velocity.y < 0.0:
		velocity.y = 0.0


func _at_ai_reins() -> bool:
	var p := get_parent()
	if p == null:
		return false
	for n in ["RideAI", "DemoRider"]:
		var ai := p.get_node_or_null(n)
		if ai != null and bool(ai.get("enabled")):
			return true
	return false


func _place_cam() -> void:
	if cam == null:
		return
	var dt := maxf(get_process_delta_time(), 0.001)
	var horse_yaw := global_rotation.y
	if not _rig_ready:
		_rig_yaw = horse_yaw
		_rig_ready = true
	else:
		var dy := wrapf(horse_yaw - _rig_yaw, -PI, PI)
		_rig_yaw += dy * (1.0 - pow(0.0015, dt))
		_rig_yaw = wrapf(_rig_yaw, -PI, PI)
	var yaw := deg_to_rad(cam_yaw)
	var halted := gait == 0 and speed < 0.35 and not jumping
	# The half-halt's lens (0.40 in, 0.20 up, look 0.16 up) eases in and out
	# too: applied in one frame it moved the camera 0.43 m as he sat after a land.
	var col_k := 1.0 - pow(0.02, maxf(get_process_delta_time(), 0.001))
	_cam_col = lerpf(_cam_col, 1.0 if collecting else 0.0, col_k)
	var back := CAM_BACK - 0.40 * _cam_col
	if halted:
		back += 0.42
	if halt_sit > 0.0:
		back += 0.52
	var local := Vector3(
		CAM_RIGHT * cos(yaw) + back * sin(yaw),
		0.0,
		-CAM_RIGHT * sin(yaw) + back * cos(yaw)
	)
	var boom := Transform3D(Basis(Vector3.UP, _rig_yaw), global_position)
	var world: Vector3 = boom * local
	var height := CAM_HEIGHT
	var look_y := CAM_LOOK_Y
	height += 0.20 * _cam_col
	look_y += 0.16 * _cam_col
	if jumping:
		height += 0.22
		look_y += 0.18
	# The recover's sit (−0.62 / −0.42) eases in and out instead of landing in
	# one frame, and it takes up the jump's own +0.22 / +0.18 as jumping comes
	# and goes, so the lens height is continuous through take-off, land, a
	# related line that jumps again inside the recover, and the recover's end.
	if jumping != _cam_was_jumping:
		_cam_was_jumping = jumping
		_cam_land_h += -0.22 if jumping else 0.22
		_cam_land_ly += -0.18 if jumping else 0.18
	var cam_k := 1.0 - pow(0.02, maxf(get_process_delta_time(), 0.001))
	_cam_land_h = lerpf(_cam_land_h, -0.62 if land_recover > 0.0 else 0.0, cam_k)
	_cam_land_ly = lerpf(_cam_land_ly, -0.42 if land_recover > 0.0 else 0.0, cam_k)
	height += _cam_land_h
	look_y += _cam_land_ly
	if halted:
		height -= 0.12
		look_y -= 0.08
	if halt_sit > 0.0:
		height -= 0.12
		look_y -= 0.08
	world.y = global_position.y + height + cam_pitch * 0.014
	world.y = maxf(world.y, global_position.y + CAM_MIN_Y)
	cam.global_position = world
	var look := global_position + Vector3(0.0, look_y, 0.0)
	# A stride ahead — you ride to the next spot, not the withers.
	look -= transform.basis.z * (1.88 + speed * 0.92 + last_stride * 1.08)
	if jumping and jump_fence == null:
		look -= transform.basis.z * 1.86
		look.y += jump_apex * 0.22
	if absf(last_turn) > 0.08:
		look += transform.basis.x * last_turn * -0.38
	if gait >= 2 and not jumping:
		var nf := _fence_by_number(GameState.next_fence)
		if nf:
			var to := nf.global_position - global_position
			to.y = 0.0
			var ahead := to.dot(-transform.basis.z)
			if ahead > 2.2 and ahead < 24.0:
				# Cap under 1. The old blend ran past 1.5 and put the look in
				# the dirt short of a fence that is only 2.5 m ahead. Aim at
				# the face of the fence so the top rail and the ground line
				# both stay in the frame. Not a second camera.
				var k := 0.48 + last_stride * 0.36
				if gait == CANTER:
					k += 0.08
				k = minf(k, 0.88)
				# Ease onto the fence as it comes into the window, instead of
				# the look jumping the moment it is 24 m ahead.
				k *= smoothstep(24.0, 10.0, ahead)
				look = look.lerp(nf.global_position + Vector3(0.0, 0.85, 0.0), k)
	if jumping and jump_fence:
		# Over the fence he is jumping, not a stride past it: from the aim he
		# had on the last stride (the face, capped 0.88) up onto the top rail.
		var ju := clampf(jump_t / maxf(jump_dur, 0.01), 0.0, 1.0)
		var fp := jump_fence.global_position
		var rail := fp + Vector3(0.0, jump_fence.height, 0.0)
		var face_look := look.lerp(fp + Vector3(0.0, 0.85, 0.0), 0.88)
		var on_rail := face_look.lerp(rail, smoothstep(0.0, 0.25, ju))
		# Coming down, start giving the look back: 60 % of the way by the land.
		look = on_rail.lerp(look, 0.60 * smoothstep(0.60, 1.0, ju))
		_look_rail = look
		_look_rail_set = true
	elif _look_rail_set:
		# The rest over the first second of the recover — a hand-back, not a cut.
		var back_t := clampf((2.72 - land_recover) / 1.00, 0.0, 1.0) if land_recover > 0.0 else 1.0
		look = _look_rail.lerp(look, smoothstep(0.0, 1.0, back_t))
		if back_t >= 1.0:
			_look_rail_set = false
	if not cam_look_ready:
		cam_look = look
		cam_look_ready = true
	else:
		cam_look = cam_look.lerp(look, 1.0 - pow(0.12, maxf(get_process_delta_time(), 0.016)))
	if world.distance_to(cam_look) > 0.35:
		cam.look_at(cam_look, Vector3.UP)
	var want_fov := 48.5 if collecting else 52.0
	if jumping:
		want_fov = 50.0
	if last_stride > 0.16:
		# 32.4 was a telescope: a fence one stride out filled the glass and
		# the standards left the frame. 46 still comes in from 52. It does
		# not drop the lens.
		want_fov = lerpf(want_fov, 46.0, last_stride)
	cam.fov = lerpf(cam.fov, want_fov, 1.0 - pow(0.12, maxf(get_process_delta_time(), 0.016)))


func _camera(delta: float) -> void:
	_mouse_look = maxf(0.0, _mouse_look - delta)
	var look_x := Input.get_joy_axis(0, JOY_AXIS_RIGHT_X)
	var look_y := Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)
	if absf(look_x) > 0.12 or absf(look_y) > 0.12:
		cam_yaw -= look_x * 90.0 * delta
		cam_pitch = clampf(cam_pitch - look_y * 70.0 * delta, -14.0, 10.0)
		_mouse_look = 0.0
	elif _mouse_look <= 0.0:
		cam_yaw = lerp(cam_yaw, 0.0, 1.0 - pow(0.08, delta))
		cam_pitch = lerp(cam_pitch, 0.0, 1.0 - pow(0.12, delta))
	cam_yaw = clampf(cam_yaw, -70.0, 70.0)
	cam_pitch = clampf(cam_pitch, -14.0, 10.0)


func _input(event: InputEvent) -> void:
	if not controllable:
		return
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		cam_yaw -= event.relative.x * 0.07
		cam_pitch = clampf(cam_pitch - event.relative.y * 0.06, -14.0, 10.0)
		_mouse_look = 0.45
		cam_yaw = clampf(cam_yaw, -70.0, 70.0)


func _leave_word(ahead: float) -> String:
	# Same bands as _try_leave. Read only — the show window is not retuned.
	# An ask outside 0.50–5.4 does not register, so that distance is Wait,
	# not Early. Early is the refusal band. Now is the ideal. The short
	# side of the spot is Too deep, which is the late / chip.
	const TAKEOFF := 2.55
	var ws := GameState.window_scale()
	var early := ahead > TAKEOFF + 1.05 * ws
	var late := ahead < TAKEOFF - 0.80 * ws
	var ideal := absf(ahead - TAKEOFF) <= 0.55 * ws
	if ahead > 5.4:
		return "Wait."
	if early:
		return "Early."
	if late:
		return "Too deep."
	if ideal:
		return "Now."
	if ahead > TAKEOFF:
		return "Wait."
	return "Too deep."


func _straight_run(fence: JumpFence) -> float:
	# Meters along the fence normal to its plane. Under 8 there is no room for a Two.
	var to := fence.global_position - global_position
	to.y = 0.0
	var normal := fence.takeoff_dir()
	normal.y = 0.0
	if normal.length() < 0.001:
		return 99.0
	return to.dot(normal.normalized())


func _lesson_count() -> void:
	# Lesson always hears the count. Schooling and show hear it while timing
	# is under 55, or until she has two clears at this height. The +4 is unchanged.
	var hear := (
		GameState.session_kind == "lesson"
		or GameState.madison_timing < 55.0
		or int(GameState.clears.get(GameState.class_id, 0)) < 2
	)
	if not hear or gait != CANTER or jumping:
		last_stride_n = -1
		lesson_word = ""
		return
	var fence := _fence_by_number(GameState.next_fence)
	if fence == null:
		return
	var to := fence.global_position - global_position
	to.y = 0.0
	var approach := -transform.basis.z
	approach.y = 0.0
	if approach.length() < 0.001:
		return
	approach = approach.normalized()
	var ahead := to.dot(approach)
	var lateral := absf(to.cross(Vector3.UP).dot(approach))
	# Two strides out is 2.55 + 2*3.35. Farther than that is not the leave.
	if ahead < 0.8 or ahead > 11.0:
		last_stride_n = -1
		lesson_word = ""
		return
	if lateral > 1.6:
		last_stride_n = -1
		lesson_word = ""
		if count_silent_fence != GameState.next_fence:
			count_silent_fence = GameState.next_fence
			print(
				"COUNT fence=%d ahead=%.2f lateral=%.2f stride=-1 word=silent kept=false"
				% [GameState.next_fence, ahead, lateral]
			)
		var straight_run := _straight_run(fence)
		if (ahead < 11.0 or straight_run < 11.0) and come_again_fence != GameState.next_fence:
			come_again_fence = GameState.next_fence
			GameState.speak_soft("Come again.")
		return
	count_silent_fence = -1
	come_again_fence = -1
	var n := clampi(int(round((ahead - 2.55) / 3.35)), 0, 6)
	if n > 2:
		last_stride_n = -1
		lesson_word = ""
		return
	var word := _leave_word(ahead)
	if n == last_stride_n and word == lesson_word:
		return
	last_stride_n = n
	lesson_word = word
	var named := word
	if n == 2:
		named = "Two. " + word
	elif n == 1:
		named = "One. " + word
	var kept := GameState.speak_soft(named)
	print(
		"COUNT fence=%d ahead=%.2f lateral=%.2f stride=%d word=%s kept=%s"
		% [GameState.next_fence, ahead, lateral, n, named, "true" if kept else "false"]
	)


func _set_gait(g: int) -> void:
	g = clampi(g, 0, CANTER)
	if g == gait:
		return
	var prev := gait
	gait = g
	gait_changed.emit(gait)
	if cue_cool <= 0.0 and mounted:
		_rider_cue(CUE[gait])
		cue_cool = 0.85
	if gait == 0 and prev >= 1:
		halt_sit = 2.05
	if prev >= 2 and gait == 0:
		_horse_voice("blow")
		if randf() < 0.40:
			GameState.speak("halt")


func present(fence: JumpFence, kind: String) -> void:
	if fence == null or jumping:
		return
	refuse_cool = 0.0
	if kind == "refuse":
		_do_refuse(fence, "refuse")
		return
	gait = CANTER
	speed = GAIT_SPEED[CANTER]
	charge = 0.20 if kind == "rail" else 0.72
	_begin_jump(fence, charge, kind == "rail")


func _try_jump() -> void:
	_try_leave()


func _try_leave() -> void:
	if GameState.mode != "ride" or jumping or refuse_cool > 0.0:
		return
	if gait != CANTER:
		return
	var official := _fence_by_number(GameState.next_fence)
	var nearest := _nearest_fence()
	if nearest != null and official != null and nearest != official:
		if _in_front_of(nearest):
			_wrong_fence(nearest)
			return
	var fence := official if official != null else nearest
	if fence == null:
		return
	var to := fence.global_position - global_position
	to.y = 0.0
	var approach := -transform.basis.z
	approach.y = 0.0
	approach = approach.normalized()
	var ahead := to.dot(approach)
	var lateral := absf(to.cross(Vector3.UP).dot(approach))
	var takeoff_side := fence.takeoff_dir()
	var ang := absf(approach.angle_to(takeoff_side))
	const TAKEOFF := 2.55
	var ws := GameState.window_scale()
	var rs := GameState.refuse_scale()
	var lined := lateral < 1.20 * rs and ang < deg_to_rad(28.0 * rs)
	if not lined:
		if ahead > 0.4 and ahead < 4.0 and lateral < 1.8:
			_do_refuse(fence, "looked")
		return
	if ahead > 5.4 or ahead < 0.50:
		return
	var early := ahead > TAKEOFF + 1.05 * ws
	var late := ahead < TAKEOFF - 0.80 * ws
	var ideal := absf(ahead - TAKEOFF) <= 0.55 * ws
	if early:
		_do_refuse(fence, "early")
		return
	if _might_look(fence, ideal):
		_do_refuse(fence, "looked")
		return
	if late:
		GameState.speak("deep")
		_begin_jump(fence, charge, true)
		return
	if not ideal and charge < GameState.balance_need():
		GameState.speak("chip")
		_begin_jump(fence, charge, true)
		return
	if GameState.session_kind == "lesson":
		GameState.speak("spot" if ideal else "leave")
	elif ideal and randf() < 0.45:
		GameState.speak("leave")
	elif randf() < 0.35:
		GameState.speak("straight")
	_begin_jump(fence, charge, false)


func _update_last_stride() -> void:
	last_stride = 0.0
	if jumping or gait != CANTER:
		return
	var fence := _fence_by_number(GameState.next_fence)
	if fence == null:
		return
	var to := fence.global_position - global_position
	to.y = 0.0
	var approach := -transform.basis.z
	approach.y = 0.0
	if approach.length() < 0.001:
		return
	approach = approach.normalized()
	var ahead := to.dot(approach)
	var lateral := absf(to.cross(Vector3.UP).dot(approach))
	if ahead < 2.15 or ahead > 13.2 or lateral > 1.7:
		return
	last_stride = clampf((13.2 - ahead) / 10.6, 0.0, 1.0)


func _in_front_of(fence: JumpFence) -> bool:
	var to := fence.global_position - global_position
	to.y = 0.0
	var approach := -transform.basis.z
	approach.y = 0.0
	if approach.length() < 0.001:
		return false
	approach = approach.normalized()
	var ahead := to.dot(approach)
	return ahead > 0.6 and ahead < 4.6


func _might_look(fence: JumpFence, ideal: bool) -> bool:
	if fence.kind != "flower":
		return false
	if GameState.session_kind == "lesson":
		return false
	if ideal and GameState.abbott_confidence > 40.0:
		return false
	var p := clampf((48.0 - GameState.abbott_confidence) / 140.0, 0.0, 0.32)
	return randf() < p


func _wrong_fence(fence: JumpFence) -> void:
	if GameState.is_show():
		GameState.eliminate("off_course")
		_do_refuse(fence, "off_course")
		return
	GameState.speak("wrong")
	refuse_cool = 1.1
	speed = 0.0
	_set_gait(0)


func _fence_by_number(num: int) -> JumpFence:
	for n in get_tree().get_nodes_in_group("fences"):
		if n is JumpFence and is_instance_valid(n) and (n as JumpFence).number == num:
			return n
	return null


func _begin_schooling_jump() -> void:
	if jumping or gait != CANTER:
		return
	jumping = true
	jump_t = 0.0
	jump_fence = null
	will_rail = false
	jump_start = global_position
	var dir := -transform.basis.z
	dir.y = 0.0
	dir = dir.normalized()
	jump_land = jump_start + dir * 4.2
	jump_land.y = 0.0
	jump_apex = 0.55
	jump_fence_u = 0.55
	jump_dur = clampf(4.2 / 5.2, 0.70, 1.05)
	_play_named("Gallop_Jump", 1.0, false, true)
	_play_sfx("jump")
	_horse_voice("grunt")
	jumped.emit()


func _begin_jump(fence: JumpFence, ch: float, rail: bool) -> void:
	jumping = true
	jump_t = 0.0
	jump_fence = fence
	will_rail = rail
	jump_start = global_position
	var dir := -transform.basis.z
	dir.y = 0
	dir = dir.normalized()
	# Takeoff is a stride out. Land a stride past the rail, not on it.
	# The old flight ended at the fence, so the hop finished in front of it.
	var along := fence.global_position - jump_start
	along.y = 0.0
	var to_fence := maxf(along.dot(dir), 1.2)
	var past := 1.55 + fence.spread * 0.65
	var land_d := to_fence + past
	jump_land = jump_start + dir * land_d
	jump_land.y = 0.0
	jump_fence_u = clampf(to_fence / land_d, 0.40, 0.72)
	jump_apex = fence.height + (0.18 if rail else 0.38) + ch * 0.22 + GameState.scope_bonus()
	jump_dur = clampf(land_d / 5.2 + fence.spread * 0.06, 0.70, 1.10)
	_play_named("Gallop_Jump", _clip_length("Gallop_Jump") / max(jump_dur, 0.01), false, true)
	_play_sfx("jump")
	_horse_voice("grunt")
	if not rail and randf() < 0.45:
		_rider_cue("and_up")
	jumped.emit()


func _process_jump(delta: float) -> void:
	jump_t += delta
	var u := clampf(jump_t / jump_dur, 0.0, 1.0)
	var p := jump_start.lerp(jump_land, u)
	# Off the ground with the clip, then a ballistic arc. The peak is the
	# middle of the flight, just before the fence, and he lands beyond it.
	var t := clampf((u - 0.30) / 0.70, 0.0, 1.0)
	p.y = 4.0 * t * (1.0 - t) * jump_apex
	global_position = p
	velocity = Vector3.ZERO
	if jump_fence and u > jump_fence_u - 0.08 and u < jump_fence_u + 0.08:
		if will_rail or jump_apex < jump_fence.height + 0.10:
			if not jump_fence.knocked:
				jump_fence.knock("late" if will_rail else "short")
				rail_down.emit()
				_play_sfx("rail")
	if u >= 1.0:
		jumping = false
		global_position.y = 0.0
		speed = GAIT_SPEED[CANTER] * 0.70
		velocity = -transform.basis.z * speed
		_play_sfx("land")
		if jump_fence:
			GameState.note_jumped(jump_fence.number)
			if not jump_fence.knocked:
				jump_fence.cleared = true
				if randf() < 0.35:
					_rider_cue("good_boy")
		if dust:
			dust.restart()
			dust.emitting = true
		jump_fence = null
		will_rail = false
		gait = CANTER
		land_recover = 2.72
		_play_named("Gallop", 1.0, true, false)


func _do_refuse(fence: JumpFence, why: String = "refuse") -> void:
	refuse_cool = 1.6
	speed = 0.0
	velocity = Vector3.ZERO
	_set_gait(0)
	if why != "off_course":
		GameState.speak(why)
	fence.refuse()
	_play_sfx("refuse")
	_horse_voice("snort")
	_rider_cue("easy")
	refused.emit()
	global_position += transform.basis.z * 0.45
	# Not a one-frame tilt: the check eases in from where he was (_animate).
	_check_t = 0.0
	_check_x0 = visual.rotation.x if visual else 0.0
	land_recover = 0.55


func _nearest_fence() -> JumpFence:
	var best: JumpFence = null
	var best_d := 7.5
	var approach := -transform.basis.z
	approach.y = 0.0
	if approach.length() < 0.001:
		approach = Vector3.FORWARD
	approach = approach.normalized()
	for n in get_tree().get_nodes_in_group("fences"):
		if not (n is JumpFence) or not is_instance_valid(n) or n.is_queued_for_deletion():
			continue
		var f: JumpFence = n
		var to := f.global_position - global_position
		to.y = 0.0
		var ahead := to.dot(approach)
		if ahead < 0.3:
			continue
		var d := to.length()
		if d < best_d:
			best_d = d
			best = f
	return best


func _bind_rig() -> void:
	if visual == null:
		return
	skel = _find_skel(visual)
	anim = _find_anim(visual)
	if skel:
		# The back bends on top of the clip, after it poses. Not a second player.
		var bas: SkeletonModifier3D = preload("res://scripts/bascule.gd").new()
		bas.name = "Bascule"
		bas.set("horse", self)
		skel.add_child(bas)
	if anim == null:
		return
	anim.active = true
	for n in ["Idle", "Walk", "Gallop"]:
		if anim.has_animation(n):
			anim.get_animation(n).loop_mode = Animation.LOOP_LINEAR
	for n in ["Gallop_Jump", "Jump_toIdle"]:
		if anim.has_animation(n):
			anim.get_animation(n).loop_mode = Animation.LOOP_NONE
	_play_named("Idle", 1.0, true, true)


func _find_skel(n: Node) -> Skeleton3D:
	if n is Skeleton3D:
		return n
	for c in n.get_children():
		var s := _find_skel(c)
		if s:
			return s
	return null


func _find_anim(n: Node) -> AnimationPlayer:
	if n is AnimationPlayer:
		return n
	for c in n.get_children():
		var a := _find_anim(c)
		if a:
			return a
	return null


func _clip_length(name: String) -> float:
	if anim and anim.has_animation(name):
		return anim.get_animation(name).length
	return 1.45


func _play_named(name: String, speed: float, loop: bool, restart: bool) -> void:
	if anim == null or not anim.has_animation(name):
		return
	var a: Animation = anim.get_animation(name)
	a.loop_mode = Animation.LOOP_LINEAR if loop else Animation.LOOP_NONE
	var blend := 0.05 if restart or name == "Gallop_Jump" else 0.18
	if restart or anim.current_animation != name or not anim.is_playing():
		anim.play(name, blend)
		if restart:
			anim.seek(0.0)
	anim.speed_scale = speed
	gait_clip = name


func _animate(delta: float, _spd: float) -> void:
	if visual == null:
		return
	visual.position.y = 0.0
	_air_sounds(delta)
	if jumping:
		var u := clampf(jump_t / maxf(jump_dur, 0.01), 0.0, 1.0)
		# Forehand up off the hocks, round over the fence, reach for the
		# landing. Flat again before the hooves look for the sand.
		# Negative is forehand down. It stays positive until he is in the air.
		var nose := 0.0
		if u < 0.30:
			nose = lerpf(0.02, 0.16, u / 0.30)
		elif u < 0.62:
			nose = lerpf(0.16, 0.05, (u - 0.30) / 0.32)
		elif u < 0.86:
			nose = lerpf(0.05, -0.10, (u - 0.62) / 0.24)
		else:
			nose = lerpf(-0.10, LAND_X, (u - 0.86) / 0.14)
		visual.rotation.x = nose
		visual.rotation.z = last_turn * 0.05
		# Gallop_Jump leaves at 0.18 of itself, crests at 0.52 and has the fore
		# feet down at 0.80. The root leaves at 0.30, crests at 0.65, lands at 1.
		# Hold the clip to the root, the way the trot holds Walk to the post.
		if anim and gait_clip == "Gallop_Jump":
			var f := 0.0
			var rate := 0.0
			if u < 0.30:
				f = lerpf(0.0, 0.18, u / 0.30)
				rate = 0.18 / 0.30
			elif u < 0.65:
				f = lerpf(0.18, 0.52, (u - 0.30) / 0.35)
				rate = 0.34 / 0.35
			else:
				f = lerpf(0.52, 0.82, (u - 0.65) / 0.35)
				rate = 0.30 / 0.35
			var clip_len := _clip_length("Gallop_Jump")
			anim.speed_scale = clip_len * rate / maxf(jump_dur, 0.01)
			anim.seek(clip_len * f, true)
		return
	var settle := 1.0 - pow(0.08, delta)
	# A sit is the forehand up. These were written negative — forehand down —
	# and the half-halt nose-dived him 0.3 rad with the fore feet 15 cm in the sand.
	var want_x := 0.03 if collecting else 0.0
	if collect_pulse > 0.0:
		want_x = 0.06
	if land_recover > 0.0:
		# Land on the fore feet, then level off over 0.4 s — not sit up for 2.7.
		want_x = lerpf(LAND_X, 0.0, smoothstep(0.0, 1.0, clampf((2.72 - land_recover) / 0.40, 0.0, 1.0)))
	if gait == 0 and not jumping:
		want_x = 0.05 if halt_sit > 0.0 else -0.040
	var rock_z := last_turn * (0.07 if gait >= 2 else 0.04)
	if gait == 1:
		rock_z += sin(stride_u * TAU * 2.0) * 0.016
		visual.position.y = sin(stride_u * TAU * 2.0) * 0.008
		want_x += sin(stride_u * TAU) * 0.012
	elif gait == CANTER:
		rock_z += sin(stride_u * TAU) * 0.036
		# The clip already has the canter. The old extra 9 cm and 6° on the
		# whole mesh threw her out of the saddle on top of that.
		# stride_u stood still in the air. Let the bob come back over a quarter
		# second so the landing frame does not pop.
		var bob_in := 1.0
		if land_recover > 0.0:
			bob_in = clampf((2.72 - land_recover) / 0.25, 0.0, 1.0)
		visual.position.y = sin(stride_u * TAU) * 0.032 * bob_in
		want_x += sin(stride_u * TAU) * 0.040
	elif gait == 2:
		visual.position.y = absf(sin(stride_u * TAU)) * 0.012
	else:
		visual.position.y = 0.0
	if _check_t >= 0.0 and not jumping:
		# Forehand up over a fifth of a second, held, then down to standing.
		_check_t += delta
		var rise := smoothstep(0.0, 0.18, _check_t)
		var fall := smoothstep(0.45, 1.20, _check_t)
		check_w = rise * (1.0 - fall)
		visual.rotation.x = lerpf(_check_x0, lerpf(0.14, want_x, fall), rise)
		if _check_t >= 1.20:
			_check_t = -1.0
			check_w = 0.0
	else:
		check_w = 0.0
		visual.rotation.x = lerpf(visual.rotation.x, want_x, settle)
	visual.rotation.z = lerpf(visual.rotation.z, rock_z, settle)
	if gait == 0:
		stride_u = 0.0
		last_beat = -1
		_beat_gait = 0
		_play_named("Idle", 1.0, true, false)
		return
	var hz: float = STRIDE_HZ[gait]
	if collecting and gait == CANTER:
		hz *= 1.06
	stride_u = fmod(stride_u + delta * hz, 1.0)
	var beats: int = BEATS[gait]
	if beats > 0:
		var beat := int(floor(stride_u * float(beats))) % beats
		_gait_age += delta
		if gait != _beat_gait:
			# A new gait starts counting where it is; the first sound is its
			# next true beat once the clip has blended in, not the change frame.
			_beat_gait = gait
			_gait_age = 0.0
			last_beat = beat
		elif beat != last_beat:
			last_beat = beat
			if _gait_age >= 0.18:
				_hoof_strike(beat, beats)
	# Each clip is held to the beat, so the hoof a footfall belongs to is the
	# one on the sand when it sounds. The offsets are where the clip's own
	# touchdowns fall: Walk 0.235 (four), the trot's post 0.25 (two), Gallop
	# 0.115 (three of its four). Free-running, they drifted off the beat.
	match gait:
		1:
			_play_named("Walk", 1.0, true, false)
			_hold_to_beat("Walk", 0.235, hz)
		2:
			# Two contacts per stride. The post sits down at stride_u 0 and 0.5,
			# which are the diagonal pairs in this clip (quarter-cycle phase).
			# At rate 0 the blend in never finished and he trotted half in Idle.
			_play_named("Walk", 1.0, true, false)
			_hold_to_beat("Walk", 0.25, hz)
		3:
			_play_named("Gallop", 1.0, true, false)
			_hold_to_beat("Gallop", 0.115, hz)
		_:
			_play_named("Idle", 1.0, true, false)


func _hold_to_beat(clip: String, phase0: float, hz: float) -> void:
	if anim == null or anim.current_animation != clip:
		return
	var clip_len := _clip_length(clip)
	anim.speed_scale = hz * clip_len
	anim.seek(fposmod(clip_len * (phase0 + stride_u), clip_len), true)


func _air_sounds(delta: float) -> void:
	# The grunt starts on the ask and the thud when the root touches y 0. The
	# grunt belongs to the fore feet leaving (the last one clears the sand at
	# u 0.34, clip 0.16) and the thud to them coming down, which is after.
	# Stop what the ask and the touchdown started, before it is heard, and
	# play the same file again when it is true.
	if jumping:
		var u := clampf(jump_t / maxf(jump_dur, 0.01), 0.0, 1.0)
		if _air_sound == 0 or _air_sound == 3:
			if voice_horse:
				voice_horse.stop()
			_air_sound = 1
		if _air_sound == 1 and u >= 0.34:
			_air_sound = 2
			_horse_voice("grunt")
		return
	if _air_sound == 1 or _air_sound == 2:
		_air_sound = 0
		if sfx and sfx.stream == streams.get("land"):
			sfx.stop()
			_air_sound = 3
			_land_wait = 0.0
			_fore_y = _fore_low()
	if _air_sound == 3:
		# The thud is a fore hoof on the sand: within 2 cm of contact height.
		var y := _fore_low()
		if y <= HOOF_CONTACT + 0.02 or _land_wait > 0.30:
			_play_sfx("land")
			_air_sound = 0
		_land_wait += delta
		_fore_y = y


func _fore_low() -> float:
	if skel == null:
		return 0.0
	var y := 1.0e9
	for n in ["FF.L", "FF.R"]:
		var i := skel.find_bone(n)
		if i >= 0:
			y = minf(y, skel.to_global(skel.get_bone_global_pose(i).origin).y)
	return y if y < 1.0e8 else 0.0


func _hoof_audio(_spd: float, _delta: float) -> void:
	# Footfalls fire from _animate / _hoof_strike so the sound matches the beat.
	pass


func _hoof_strike(beat: int, beats: int) -> void:
	if hoof_hits.is_empty() or hoof_pool.is_empty():
		return
	var p: AudioStreamPlayer3D = hoof_pool[hoof_i % hoof_pool.size()]
	hoof_i += 1
	p.stream = hoof_hits[randi() % hoof_hits.size()]
	# Hind vs fore, slightly different weight. Canter last beat is the lead.
	var w := 0.0
	if beats == 4:
		w = -1.5 if beat == 0 or beat == 2 else 0.0
	elif beats == 3:
		w = 1.5 if beat == 2 else -0.8
	p.volume_db = w + randf_range(-0.4, 1.2)
	p.pitch_scale = randf_range(0.96, 1.05)
	p.play()


func _play_sfx(key: String) -> void:
	var st: AudioStream = streams.get(key)
	if st == null:
		return
	sfx.stream = st
	sfx.play()


func _horse_voice(key: String) -> void:
	if voice_horse == null:
		return
	var st: AudioStream = streams.get(key)
	if st == null:
		return
	voice_horse.stream = st
	voice_horse.pitch_scale = randf_range(0.96, 1.04)
	voice_horse.play()


func _rider_cue(key: String) -> void:
	if voice_rider == null or not mounted:
		return
	var st: AudioStream = rider_lines.get(key)
	if st == null:
		return
	voice_rider.stream = st
	voice_rider.play()


func _bind_rider() -> void:
	if rider == null:
		return
	rider_body = rider.get_node_or_null("Body")
	if rider_body:
		rider_head = rider_body.get_node_or_null("Head")
		rider_lleg = rider_body.get_node_or_null("LLeg")
		rider_rleg = rider_body.get_node_or_null("RLeg")


func _set_leg(n: Node3D, hip_x: float, shin_x: float, k: float) -> void:
	if n == null:
		return
	n.rotation_degrees.x = lerpf(n.rotation_degrees.x, hip_x, k)
	var shin: Node3D = n.get_node_or_null("LShin")
	if shin == null:
		shin = n.get_node_or_null("RShin")
	if shin:
		# Counter the hip so the lower leg stays quiet and the heel stays down.
		shin.rotation_degrees.x = lerpf(shin.rotation_degrees.x, shin_x - hip_x, k)


func _update_rider(delta: float) -> void:
	if rider_body == null and rider:
		_bind_rider()
	if rider_body == null:
		return
	# Following seat: a little in front of the vertical, thigh on the flap,
	# heel down. The old -27° fold parked her on his neck at the canter.
	var pitch := -13.0
	var rest := Vector3(0.0, -0.008, 0.016)
	var hip_x := 14.0
	var shin_x := -8.0
	var head_x := 18.0
	if gait == 0 and not jumping and land_recover <= 0.0:
		pitch = -6.0
		rest = Vector3(0.0, -0.004, 0.028)
		hip_x = 12.0
		shin_x = -10.0
		head_x = 14.0
		# Standing, her head still reads him: a worried horse or a green seat
		# and she looks down at his neck. Constant, not a nod.
		head_x -= 8.0 * _hand_unrest()
		# And her seat closes a little with it: the hip, the shin still countered.
		hip_x += 9.0 * _hand_unrest()
	if collecting:
		pitch = -6.0
		rest = Vector3(0.0, -0.006, 0.022)
		hip_x = 16.0
		shin_x = -10.0
		head_x = 12.0
	if collect_pulse > 0.10:
		pitch = 3.0
		rest = Vector3(0.0, 0.008, 0.034)
		hip_x = 16.0
		shin_x = -10.0
		head_x = 2.0
	if land_recover > 0.0:
		pitch = 2.0
		rest = Vector3(0.0, -0.010, 0.072)
		hip_x = 20.0
		shin_x = -18.0
		head_x = 6.0
		# When she actually sits the land, she still reads him. The head takes
		# the arc's share, so the land does not step it; the seat closes a little.
		if not jumping and last_stride <= 0.20:
			head_x -= FOLD_HEAD * _hand_unrest()
			hip_x += SIT_HIP * _hand_unrest()
			pitch -= FOLD_PITCH * _hand_unrest()
			shin_x += FOLD_SHIN * _hand_unrest()
	if last_stride > 0.20 and not jumping:
		var s := last_stride
		pitch = lerpf(pitch, -42.0, s)
		rest = rest.lerp(Vector3(0.0, 0.118, -0.042), s)
		hip_x = lerpf(hip_x, 28.0, s)
		shin_x = lerpf(shin_x, -16.0, s)
		head_x = lerpf(head_x, 28.0, s)
		# Standing into the two-point she still reads him: one share of the
		# unrest, in as she stands, held through the arc below.
		if gait >= 1:
			head_x -= FOLD_HEAD * _hand_unrest() * s
			hip_x += SIT_HIP * _hand_unrest() * s
			pitch -= FOLD_PITCH * _hand_unrest() * s
			shin_x += FOLD_SHIN * _hand_unrest() * s
	if jumping:
		# One fold through the arc, not three snaps: out of the two-point she
		# left in, closed with his back over the top, the seat coming home as
		# he opens, and on the land exactly the land_recover pose below.
		var u := clampf(jump_t / maxf(jump_dur, 0.01), 0.0, 1.0)
		var keys := [
			[0.00, -42.0, Vector3(0.0, 0.118, -0.042), 28.0, -16.0, 28.0],
			[0.20, -40.0, Vector3(0.0, 0.105, -0.035), 26.0, -14.0, 24.0],
			[0.55, -34.0, Vector3(0.0, 0.085, -0.020), 22.0, -12.0, 18.0],
			[0.85, -14.0, Vector3(0.0, 0.030, 0.030), 18.0, -15.0, 10.0],
			[1.00, 2.0, Vector3(0.0, -0.010, 0.072), 20.0, -18.0, 6.0],
		]
		for i in range(keys.size() - 1):
			var a: Array = keys[i]
			var b: Array = keys[i + 1]
			if u <= b[0] or i == keys.size() - 2:
				var t := smoothstep(0.0, 1.0, clampf((u - a[0]) / (b[0] - a[0]), 0.0, 1.0))
				pitch = lerpf(a[1], b[1], t)
				rest = (a[2] as Vector3).lerp(b[2], t)
				hip_x = lerpf(a[3], b[3], t)
				shin_x = lerpf(a[4], b[4], t)
				head_x = lerpf(a[5], b[5], t)
				break
		head_x -= FOLD_HEAD * _hand_unrest()
		# Her seat closes with it, the sit's own share, so the land does not step it.
		hip_x += SIT_HIP * _hand_unrest()
		pitch -= FOLD_PITCH * _hand_unrest()
		shin_x += FOLD_SHIN * _hand_unrest()
	elif land_recover <= 0.0 and gait >= 1:
		match gait:
			1:
				var w := sin(stride_u * TAU)
				pitch += w * 1.1
				rest.y += w * 0.008
				hip_x += w * 1.8
				shin_x -= w * 0.8
				head_x -= w * 1.2
				# A worried horse still moves her. The walk's share stays small
				# enough that she nods with him instead of pecking.
				var walk_unrest := _hand_unrest()
				pitch += w * 3.0 * walk_unrest
				rest.y += w * 0.012 * walk_unrest
				head_x -= w * 8.0 * walk_unrest
				hip_x += w * 3.0 * walk_unrest
				shin_x -= w * 1.2 * walk_unrest
			2:
				# Rising trot: the hip opens and the seat leaves the saddle a
				# few inches. The torso stays quiet.
				var post := maxf(0.0, sin(stride_u * TAU))
				var sit := maxf(0.0, -sin(stride_u * TAU))
				pitch += -post * 6.0 + sit * 2.0
				rest.y += post * 0.055 - sit * 0.010
				rest.z -= post * 0.022 - sit * 0.006
				hip_x += post * 10.0 + sit * 2.0
				shin_x -= post * 3.0 + sit * 1.0
				head_x += post * 2.4 - sit * 1.0
				var trot_unrest := _hand_unrest()
				var swing := sin(stride_u * TAU)
				pitch += swing * 3.0 * trot_unrest
				rest.y += swing * 0.016 * trot_unrest
				head_x += swing * 6.0 * trot_unrest
				hip_x += swing * 3.0 * trot_unrest
				shin_x -= (post * 3.0 + sit * 1.0) * 0.5 * trot_unrest
			3:
				var rock := sin(stride_u * TAU)
				var sit := maxf(0.0, -rock)
				pitch += rock * (1.4 if collecting else 2.8) - sit * 1.6
				rest.y += rock * 0.016 - sit * 0.010
				var unrest := _hand_unrest()
				pitch += rock * 3.5 * unrest
				rest.y += rock * 0.010 * unrest
				rest.z += rock * 0.012 * unrest
				head_x -= rock * 8.0 * unrest
				rest.z += rock * 0.010
				hip_x += rock * 2.4 + sit * 1.6
				hip_x += rock * 3.0 * unrest
				shin_x -= rock * 1.2 + sit * 0.8
				shin_x -= (rock * 1.2 + sit * 0.8) * 1.0 * unrest
				head_x -= rock * 1.2
				head_x += 4.0
	var roll := last_turn * (4.2 if gait >= 2 else 2.4)
	var k := 1.0 - pow(0.10, delta)
	rider_body.rotation_degrees.x = lerpf(rider_body.rotation_degrees.x, pitch, k)
	rider_body.rotation_degrees.z = lerpf(rider_body.rotation_degrees.z, roll, k)
	rider_body.position = rider_body.position.lerp(rest, k)
	_set_leg(rider_lleg, hip_x, shin_x, k)
	_set_leg(rider_rleg, hip_x, shin_x, k)
	if rider_head:
		rider_head.rotation_degrees.x = lerpf(rider_head.rotation_degrees.x, head_x, k)


func _hand_unrest() -> float:
	var tension := clampf((70.0 - GameState.abbott_confidence) / 40.0, 0.0, 1.0)
	var green := clampf((60.0 - GameState.madison_feel) / 40.0, 0.0, 1.0)
	return clampf(0.7 * tension + 0.3 * green, 0.0, 1.0)


func _make_reins() -> void:
	var leather := MeshKit.leather(Color(0.34, 0.18, 0.10), 0.40)
	rein_l = MeshKit.mesh_instance(MeshKit.cyl(0.0092, 0.45, -1.0, 6), leather, "ReinL")
	rein_r = MeshKit.mesh_instance(MeshKit.cyl(0.0092, 0.45, -1.0, 6), leather, "ReinR")
	rein_l.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	rein_r.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(rein_l)
	add_child(rein_r)
	bit_l = _find_named(self, "BitL") as Node3D
	bit_r = _find_named(self, "BitR") as Node3D
	glove_l = _find_named(self, "LGlove") as Node3D
	glove_r = _find_named(self, "RGlove") as Node3D


func _update_reins() -> void:
	var show := mounted and rider != null and rider.visible
	if rein_l:
		rein_l.visible = show
	if rein_r:
		rein_r.visible = show
	if not show:
		return
	if bit_l == null or not is_instance_valid(bit_l):
		bit_l = _find_named(self, "BitL") as Node3D
	if bit_r == null or not is_instance_valid(bit_r):
		bit_r = _find_named(self, "BitR") as Node3D
	if glove_l == null or not is_instance_valid(glove_l):
		glove_l = _find_named(self, "LGlove") as Node3D
	if glove_r == null or not is_instance_valid(glove_r):
		glove_r = _find_named(self, "RGlove") as Node3D
	if bit_l and glove_l:
		MeshKit.place_rod_global(rein_l, bit_l.global_position, glove_l.global_position)
	if bit_r and glove_r:
		MeshKit.place_rod_global(rein_r, bit_r.global_position, glove_r.global_position)


func _find_named(n: Node, want: String) -> Node:
	if n.name == want:
		return n
	for c in n.get_children():
		var f := _find_named(c, want)
		if f:
			return f
	return null


func gait_name() -> String:
	return GAIT_NAMES[gait]


func facing() -> Vector3:
	var f := -transform.basis.z
	f.y = 0.0
	return f.normalized()
