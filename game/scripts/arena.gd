extends Node3D

const FarmScript := preload("res://scripts/farm.gd")
const PlaytestScript := preload("res://scripts/playtest.gd")
const StrideScript := preload("res://tools/stride_measure.gd")
const LeaveSweepScript := preload("res://tools/leave_sweep.gd")
const ArtShotScript := preload("res://scripts/artshot.gd")
const RideCertScript := preload("res://scripts/ride_cert.gd")
const HearProbeScript := preload("res://tools/hear_probe.gd")
const RideAIScript := preload("res://scripts/ride_ai.gd")

var horse: Horse
var walker: Walker
var course: Course
var hud: HUD
var farm: Node3D
var paused: bool = false
var _walk_near := ""
var demo_ai: RideAI
var _demo_wait: bool = false


func _ready() -> void:
	if "--hear" in OS.get_cmdline_user_args():
		var probe := HearProbeScript.new()
		probe.name = "HearProbe"
		add_child(probe)
		return
	_world()
	course = Course.new()
	course.name = "Course"
	add_child(course)
	course.build(false, GameState.course_seed)
	horse = Horse.new()
	horse.name = "Abbott"
	add_child(horse)
	_place_horse()
	walker = Walker.new()
	walker.name = "Walker"
	add_child(walker)
	walker.global_position = course.start_pos + Vector3(2.5, 0, -2.0)
	hud = HUD.new()
	hud.name = "HUD"
	add_child(hud)
	hud.pause_requested.connect(_toggle_pause)
	hud.mount_requested.connect(_start_ride)
	hud.quit_requested.connect(_quit_title)
	hud.resume_requested.connect(_unpause)
	hud.walk_requested.connect(_enter_walk_from_ui)
	hud.retry_requested.connect(_retry)
	hud.jump_off_requested.connect(_start_jump_off)
	GameState.reset_round()
	if GameState.mode == "walk":
		_enter_walk()
	else:
		GameState.set_mode("ride")
		_enter_ride()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if "--playtest" in OS.get_cmdline_user_args():
		var pt := PlaytestScript.new()
		pt.name = "Playtest"
		add_child(pt)
	if "--stride" in OS.get_cmdline_user_args():
		var sm := StrideScript.new()
		sm.name = "StrideMeasure"
		add_child(sm)
	if "--leave-sweep" in OS.get_cmdline_user_args():
		var ls := LeaveSweepScript.new()
		ls.name = "LeaveSweep"
		add_child(ls)
	if "--ridecert" in OS.get_cmdline_user_args():
		var rc := RideCertScript.new()
		rc.name = "RideCert"
		add_child(rc)
	if "--artshot" in OS.get_cmdline_user_args():
		var shot := ArtShotScript.new()
		shot.name = "ArtShot"
		add_child(shot)
	if GameState.demo_ride:
		_arm_demo()


func _place_horse() -> void:
	horse.global_position = course.start_pos
	horse.rotation.y = course.start_yaw
	horse.speed = 0.0
	horse.gait = 0


func _world() -> void:
	farm = FarmScript.new()
	farm.name = "HiddenK"
	add_child(farm)
	farm.build()


func _process(delta: float) -> void:
	if paused:
		return
	if GameState.clock_running and GameState.mode == "ride":
		GameState.time_sec += delta
	GameState.tick(delta)
	if Input.is_action_just_pressed("pause"):
		_toggle_pause()
	if GameState.mode == "walk":
		_walk_near_tick()
		if Input.is_action_just_pressed("mount"):
			_start_ride()
	if GameState.mode == "ride":
		if Input.is_action_just_pressed("walk_mode"):
			_enter_walk()
	if GameState.demo_ride and not _demo_wait and GameState.round_complete and GameState.can_offer_jump_off():
		_demo_wait = true
		_take_demo_jump_off()


func _walk_near_tick() -> void:
	# Said once when she arrives beside a fence, not every frame.
	if course == null or walker == null:
		return
	var near := ContentLibrary.near_line(course.loaded, walker.global_position, -walker.global_transform.basis.z)
	if near == _walk_near:
		return
	_walk_near = near
	hud.set_walk_near(near)
	if near != "":
		GameState.speak_soft(near)


func _enter_walk_from_ui() -> void:
	_unpause()
	hud.result_panel.visible = false
	_enter_walk()


func _enter_walk() -> void:
	GameState.set_mode("walk")
	GameState.clock_running = false
	horse.set_mounted(false)
	horse.controllable = false
	walker.active = true
	walker.cam.current = true
	var line := ContentLibrary.walk_line(course.loaded) if course else ""
	_walk_near = ""
	hud.set_walk_mode(true, line)
	if line != "":
		GameState.speak_soft(line)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _enter_ride() -> void:
	GameState.set_mode("ride")
	GameState.reset_round()
	walker.active = false
	horse.set_mounted(true)
	horse.controllable = true
	horse.cam.current = true
	_place_horse()
	hud.set_walk_mode(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameState.clock_running = false
	GameState.start_crossed = false
	if GameState.session_kind == "lesson":
		GameState.speak("lesson_start")


func _start_jump_off() -> void:
	_unpause()
	if hud and hud.result_panel:
		hud.result_panel.visible = false
	if not GameState.begin_jump_off():
		return
	if horse:
		horse.jumping = false
		horse.jump_fence = null
	if course:
		course.build(false, GameState.course_seed)
	walker.active = false
	horse.set_mounted(true)
	horse.controllable = true
	horse.cam.current = true
	_place_horse()
	hud.set_walk_mode(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _start_ride() -> void:
	_unpause()
	_enter_ride()


func _retry() -> void:
	_unpause()
	if hud and hud.result_panel:
		hud.result_panel.visible = false
	if horse:
		horse.jumping = false
		horse.jump_fence = null
	if course:
		course.build(false, GameState.course_seed)
	_enter_ride()


func _toggle_pause() -> void:
	paused = not paused
	horse.controllable = (not paused) and GameState.mode == "ride"
	walker.active = (not paused) and GameState.mode == "walk"
	hud.show_pause(paused)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if paused else Input.MOUSE_MODE_CAPTURED)


func _unpause() -> void:
	paused = false
	hud.show_pause(false)
	horse.controllable = GameState.mode == "ride"
	walker.active = GameState.mode == "walk"
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _quit_title() -> void:
	_release_demo()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://scenes/title.tscn")


func _exit_tree() -> void:
	_release_demo()


func _arm_demo() -> void:
	if horse == null or course == null:
		return
	if demo_ai == null:
		demo_ai = RideAIScript.new()
		demo_ai.name = "DemoRider"
		add_child(demo_ai)
	demo_ai.bind(horse, course)
	demo_ai.style = "clear"
	demo_ai.reset_brain()
	demo_ai.enabled = true
	horse.controllable = true


func _take_demo_jump_off() -> void:
	await get_tree().create_timer(2.0).timeout
	if not is_inside_tree() or not GameState.demo_ride:
		return
	if not GameState.can_offer_jump_off():
		_demo_wait = false
		return
	_start_jump_off()
	GameState.set_mode("ride")
	_arm_demo()
	_demo_wait = false


func _release_demo() -> void:
	if demo_ai and is_instance_valid(demo_ai):
		demo_ai.enabled = false
		demo_ai._release_all()
	GameState.demo_ride = false
