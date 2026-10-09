extends Node

## Fixed cameras and ride moments for dist/day12/shots. Same table every run.
## Mouse stays visible. This mode must not write the player save.

const STILLS: Array[Dictionary] = [
	{"name": "halt_side", "kind": "horse", "from": Vector3(3.6, 1.22, 0.10), "look": Vector3(0.0, 1.15, 0.0)},
	{"name": "seat_side", "kind": "horse", "from": Vector3(3.15, 1.28, 0.18), "look": Vector3(0.0, 1.28, 0.12)},
	{"name": "halt_rear", "kind": "horse", "from": Vector3(0.4, 1.45, -4.2), "look": Vector3(0.0, 1.15, 0.15)},
	{"name": "walk_side", "kind": "horse", "from": Vector3(3.7, 0.72, 0.35), "look": Vector3(0.0, 0.42, 0.0), "walk": 0.35},
	{"name": "head", "kind": "horse", "from": Vector3(0.85, 1.42, -1.55), "look": Vector3(0.05, 1.62, -0.35)},
	{"name": "trainer", "kind": "world", "from": Vector3(13.0, 1.55, -8.0), "look": Vector3(16.2, 1.45, -8.0)},
	{"name": "barn", "kind": "world", "from": Vector3(-22.0, 9.0, 6.0), "look": Vector3(-78.0, 4.2, -48.0)},
	{"name": "house", "kind": "world", "from": Vector3(22.0, 8.0, -10.0), "look": Vector3(62.0, 4.0, -52.0)},
	{"name": "sky", "kind": "world", "from": Vector3(-8.0, 7.0, -36.0), "look": Vector3(0.0, 16.0, 8.0)},
]

var _out: String = ""
var _cam: Camera3D
var _horse: Horse
var _course: Course
var _hud: CanvasLayer
var _ai: RideAI
var _got: Dictionary = {}
var _ride_started_msec: int = 0
var _perf_until_msec: int = 0
var _perf: PackedStringArray = PackedStringArray()
var _landed_msec: int = 0
var _was_jumping: bool = false
var _strip_frames: Array[Image] = []
var _strip_done: bool = false
var _menu_step: int = 0
var _hud_wait: int = 0


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	_out = _out_dir()
	if _out == "":
		print("SHOTS missing --shots-out")
		get_tree().quit(2)
		return
	DirAccess.make_dir_recursive_absolute(_out)
	var marker := _out.path_join("shots.open")
	var on_title := str(get_tree().current_scene.scene_file_path).ends_with("title.tscn")
	if on_title and FileAccess.file_exists(marker):
		print("SHOTS refuse overwrite ", _out)
		get_tree().quit(2)
		return
	if on_title:
		var stamp := FileAccess.open(marker, FileAccess.WRITE)
		if stamp:
			stamp.store_line("open")
			stamp.close()
	call_deferred("_boot")


func _process(_delta: float) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if _perf_until_msec > 0 and Time.get_ticks_msec() < _perf_until_msec and _horse != null:
		var rid := get_viewport().get_viewport_rid()
		var gpu := RenderingServer.viewport_get_measured_render_time_gpu(rid)
		var cpu := RenderingServer.viewport_get_measured_render_time_cpu(rid)
		_perf.append("%d,%.2f,%.3f,%.3f" % [Time.get_ticks_msec() - _ride_started_msec, Engine.get_frames_per_second(), gpu, cpu])


func _boot() -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	var path := str(get_tree().current_scene.scene_file_path)
	if path.ends_with("title.tscn"):
		await _capture_title()
	else:
		await _capture_arena()


func _capture_title() -> void:
	await get_tree().create_timer(0.4).timeout
	await get_tree().process_frame
	_save("title")
	var title := get_parent()
	if title.has_method("_open_season"):
		title.call("_open_season")
		await get_tree().process_frame
		await get_tree().process_frame
		_save("season")
		if title.has_method("_close_season"):
			title.call("_close_season")
	if not GameState.start_session("lesson", "lesson"):
		print("SHOTS lesson failed")
		get_tree().quit(1)
		return
	GameState.course_seed = 0
	GameState.jump_off = false
	GameState.set_mode("ride")
	get_tree().change_scene_to_file("res://scenes/arena.tscn")


func _capture_arena() -> void:
	if _low_quality():
		GameState.settings.quality = "Low"
		GameState.settings.vsync = false
		GameState.settings.apply_display()
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	var rid := get_viewport().get_viewport_rid()
	RenderingServer.viewport_set_measure_render_time(rid, true)
	var arena := get_parent()
	_horse = arena.get_node_or_null("Abbott")
	_course = arena.get_node_or_null("Course")
	_hud = arena.get_node_or_null("HUD")
	if _horse == null or _course == null:
		print("SHOTS missing horse or course")
		get_tree().quit(1)
		return
	_cam = Camera3D.new()
	_cam.name = "ShotsCam"
	_cam.fov = 48.0
	_cam.near = 0.12
	_cam.far = 400.0
	arena.add_child(_cam)
	_set_hud(false)
	_pose_horse(Vector3(0, 0, -8), PI)
	_horse.gait = 1
	_horse.speed = Horse.GAIT_SPEED[1]
	if _horse.cam:
		_horse.cam.current = true
	await get_tree().create_timer(0.35).timeout
	_save("play_cam")
	await _capture_lesson_lines()
	_horse.set_physics_process(false)
	for row in STILLS:
		if bool(row.get("walk", false)):
			_freeze_walk(float(row["walk"]))
		else:
			_horse.gait = 0
			_horse._play_named("Idle", 1.0, true, true)
		if str(row["kind"]) == "horse":
			_shot_horse(str(row["name"]), row["from"], row["look"])
		else:
			_shot_world(str(row["name"]), row["from"], row["look"])
		await get_tree().process_frame
		await get_tree().process_frame
		_save(str(row["name"]))
	_shot_in_gate()
	await get_tree().process_frame
	await get_tree().process_frame
	_save("in_gate")
	_shot_fence()
	await get_tree().process_frame
	await get_tree().process_frame
	_save("fence")
	await _capture_canter_strip()
	_begin_ride()
	var limit := Time.get_ticks_msec() + 150000
	while Time.get_ticks_msec() < limit and not _got.has("results"):
		await get_tree().process_frame
		_watch_ride()
		if GameState.round_complete and _hud and _hud.get("result_panel"):
			await get_tree().create_timer(0.3).timeout
			_set_hud(true)
			_save("results")
			_got["results"] = true
	_write_perf()
	print("SHOTS done ", _got.size())
	get_tree().quit(0)


func _capture_lesson_lines() -> void:
	if _hud == null or not _hud.has_method("show_lesson"):
		return
	# The arena hides the card every frame unless the lesson is the live one.
	# Pause holds that, and this does not save.
	var arena := get_parent()
	arena.set("paused", true)
	var script: GDScript = load("res://scripts/first_lesson.gd") as GDScript
	var guide: RefCounted = script.new() as RefCounted
	_set_hud(true)
	if _horse.cam:
		_horse.cam.current = true
	guide.set("step", 0)
	_hud.call("show_lesson", str(guide.call("line")), true)
	await get_tree().process_frame
	await get_tree().process_frame
	_save("lesson_walk")
	guide.set("step", 6)
	_hud.call("show_lesson", str(guide.call("line")), true)
	await get_tree().process_frame
	await get_tree().process_frame
	_save("lesson_pole")
	_hud.call("show_lesson", "", false)
	arena.set("paused", false)


func _capture_canter_strip() -> void:
	# Twelve frames of one canter stride, camera fixed, body moving.
	# Physics stays off. This is a picture of the legs, not a ride.
	_horse.gait = Horse.CANTER
	_horse.speed = Horse.GAIT_SPEED[Horse.CANTER]
	_horse._play_named("Gallop", 1.0, true, true)
	var origin := _horse.global_position
	var yaw := _horse.rotation.y
	var basis := Basis(Vector3.UP, yaw)
	var forward := -basis.z
	var side := basis.x
	var stride := Horse.GAIT_SPEED[Horse.CANTER] / maxf(Horse.STRIDE_HZ[Horse.CANTER], 0.01)
	var clip_len := 1.0
	if _horse.anim and _horse.anim.has_animation("Gallop"):
		clip_len = _horse.anim.get_animation("Gallop").length
	var mid := origin + forward * stride * 0.5
	for i in 12:
		var u := float(i) / 12.0
		_horse.global_position = origin + forward * stride * u
		_horse.rotation = Vector3(0.0, yaw, 0.0)
		if _horse.anim:
			var phase := fposmod(0.115 + u, 1.0)
			_horse.anim.speed_scale = Horse.STRIDE_HZ[Horse.CANTER] * clip_len
			_horse.anim.seek(clip_len * phase, true)
		_use_cam(mid + side * 4.4 + Vector3(0.0, 1.05, 0.0), mid + Vector3(0.0, 0.72, 0.0))
		await get_tree().process_frame
		await get_tree().process_frame
		_save("canter_%02d" % i)
	_horse.global_position = origin
	_horse.rotation = Vector3(0.0, yaw, 0.0)


func _begin_ride() -> void:
	_pose_horse(_course.start_pos, _course.start_yaw)
	_horse.set_physics_process(true)
	_horse.controllable = true
	_horse.gait = 0
	_horse.speed = 0.0
	if _horse.cam:
		_horse.cam.current = true
	_set_hud(true)
	var script := load("res://scripts/ride_ai.gd") as GDScript
	var ai: RideAI = script.new() as RideAI
	ai.name = "ShotsRider"
	get_parent().add_child(ai)
	ai.bind(_horse, _course)
	ai.style = "clear"
	ai.reset_brain()
	ai.enabled = true
	_ai = ai
	_ride_started_msec = Time.get_ticks_msec()
	_perf_until_msec = _ride_started_msec + 10000


func _watch_ride() -> void:
	if _horse == null:
		return
	var ahead := _ahead()
	if not _got.has("three_strides") and _hud_wait == 0 and _horse.gait == Horse.CANTER and ahead < 12.8 and ahead > 10.0:
		_horse.cam.current = true
		_set_hud(false)
		_hud_wait = 1
	elif _hud_wait == 1:
		_save("three_strides")
		_set_hud(true)
		_hud_wait = 2
	elif _hud_wait == 2:
		_save("hud_mid")
		if _hud:
			_hud.show_pause(true)
		_hud_wait = 0
		_menu_step = 1
	elif _menu_step == 1 and _hud:
		_save("pause")
		var pause: Control = _hud.get("pause_panel")
		if pause:
			pause.visible = false
		var opt: Control = _hud.get("options_panel")
		if opt:
			opt.visible = true
		_menu_step = 2
	elif _menu_step == 2 and _hud:
		_save("options")
		var opt2: Control = _hud.get("options_panel")
		if opt2:
			opt2.visible = false
		_hud.show_pause(false)
		_menu_step = 3
	if not _got.has("last_stride") and ahead < 6.2 and ahead > 4.2 and _horse.gait == Horse.CANTER:
		_set_hud(false)
		_save("last_stride")
		_set_hud(true)
		_got["last_stride"] = true
	var jumping := _horse.jumping
	if jumping and not _was_jumping and not _got.has("takeoff"):
		_set_hud(false)
		_save("takeoff")
		_strip_frames.clear()
		_grab_strip()
	var ju := _horse.jump_t / maxf(_horse.jump_dur, 0.01)
	if jumping and not _got.has("apex") and ju >= 0.42:
		_save("apex")
	if jumping and _got.has("takeoff") and not _strip_done:
		_grab_strip()
	if _was_jumping and not jumping and not _got.has("landing"):
		_write_strip()
		_save("landing")
		_landed_msec = Time.get_ticks_msec()
	if _got.has("landing") and not _got.has("turn_after") and _landed_msec > 0 and Time.get_ticks_msec() - _landed_msec > 800:
		_save("turn_after")
		_got["turn_after"] = true
		_set_hud(true)
	_was_jumping = jumping


func _ahead() -> float:
	if _course == null or _course.fences.is_empty() or _horse == null:
		return 99.0
	var fence: JumpFence = _course.fences[0]
	var to := fence.global_position - _horse.global_position
	to.y = 0.0
	var approach := -_horse.global_transform.basis.z
	approach.y = 0.0
	if approach.length() < 0.001:
		return 99.0
	return to.dot(approach.normalized())


func _pose_horse(pos: Vector3, yaw: float) -> void:
	_horse.global_position = pos
	_horse.rotation = Vector3(0, yaw, 0)
	_horse.velocity = Vector3.ZERO
	_horse.speed = 0.0


func _freeze_walk(u: float) -> void:
	_horse.gait = 1
	_horse._play_named("Walk", 1.0, true, true)
	if _horse.anim and _horse.anim.has_animation("Walk"):
		_horse.anim.seek(u * _horse.anim.get_animation("Walk").length, true)


func _shot_horse(name: String, local_from: Vector3, local_look: Vector3) -> void:
	var basis := _horse.global_transform.basis
	var origin := _horse.global_position
	_use_cam(origin + basis * local_from, origin + basis * local_look)


func _shot_world(name: String, from: Vector3, look: Vector3) -> void:
	_use_cam(from, look)


func _shot_in_gate() -> void:
	var basis := Basis(Vector3.UP, _course.start_yaw)
	var forward := -basis.z
	var from := _course.start_pos - forward * 2.2 + Vector3(0, 2.4, 0)
	var look := _course.start_pos + forward * 22.0 + Vector3(0, 1.1, 0)
	_use_cam(from, look)


func _shot_fence() -> void:
	if _course.fences.is_empty():
		return
	var fence: JumpFence = _course.fences[0]
	var basis := fence.global_transform.basis
	var from := fence.global_position - basis.z * 4.2 + basis.x * 2.4 + Vector3(0, 1.45, 0)
	_use_cam(from, fence.global_position + Vector3(0, 0.85, 0))


func _use_cam(from: Vector3, look: Vector3) -> void:
	if _horse and _horse.cam:
		_horse.cam.current = false
	_cam.global_position = from
	if look.distance_to(from) > 0.08:
		_cam.look_at(look, Vector3.UP)
	_cam.current = true


func _set_hud(on: bool) -> void:
	if _hud:
		_hud.visible = on


func _grab_strip() -> void:
	if _strip_frames.size() >= 48:
		return
	var img := get_viewport().get_texture().get_image()
	if img:
		_strip_frames.append(img.duplicate())


func _write_strip() -> void:
	if _strip_done or _strip_frames.is_empty():
		_strip_done = true
		return
	var n := _strip_frames.size()
	for i in 8:
		var idx := int(round(float(i) * float(n - 1) / 7.0))
		var path := _out.path_join("jump_%02d.png" % i)
		_strip_frames[idx].save_png(path)
		print("SHOTS jump_%02d" % i)
	_strip_done = true
	_strip_frames.clear()


func _save(name: String) -> void:
	if _got.has(name):
		return
	var img := get_viewport().get_texture().get_image()
	if img == null:
		print("SHOTS empty ", name)
		return
	var path := _out.path_join("%s.png" % name)
	img.save_png(path)
	_got[name] = true
	print("SHOTS ", name)


func _write_perf() -> void:
	var path := _out.path_join("perf.csv")
	var f := FileAccess.open(path, FileAccess.WRITE)
	if f == null:
		return
	f.store_line("ms,fps,gpu_ms,cpu_ms")
	for row in _perf:
		f.store_line(row)
	f.close()


func _low_quality() -> bool:
	for a in OS.get_cmdline_user_args():
		if str(a) == "--shots-quality=low":
			return true
	return false


func _out_dir() -> String:
	for a in OS.get_cmdline_user_args():
		var s := str(a)
		if s.begins_with("--shots-out="):
			return s.substr(12)
	return ""


func _dir_has_png(dir: String) -> bool:
	var da := DirAccess.open(dir)
	if da == null:
		return false
	da.list_dir_begin()
	var fn := da.get_next()
	while fn != "":
		if fn.ends_with(".png"):
			return true
		fn = da.get_next()
	return false
