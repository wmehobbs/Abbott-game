extends Node
class_name Playtest

## Runs three full rounds in the exported game and writes a report next to the exe.

var horse: Horse
var course: Course
var arena: Node
var report: Dictionary = {"rounds": []}
var shot_i: int = 0
var resets: int = 0


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	await get_tree().process_frame
	await get_tree().create_timer(0.4).timeout
	arena = get_parent()
	horse = arena.get_node_or_null("Abbott")
	course = arena.get_node_or_null("Course")
	if horse == null or course == null:
		_fail("missing horse or course")
		return
	print("PLAYTEST begin fences=", course.fences.size())
	horse.gait = 1
	horse.speed = Horse.GAIT_SPEED[1]
	horse.controllable = true
	var w := 0.0
	while w < 0.85:
		await get_tree().process_frame
		w += get_process_delta_time()
	horse.cam_yaw = 20.0
	horse.cam_pitch = 0.0
	await get_tree().process_frame
	await _shot("start")
	horse.cam_yaw = 0.0
	var ok1 := await _round_clear()
	var ok2 := await _round_refuse()
	var ok3 := await _round_rail()
	report["pass"] = ok1 and ok2 and ok3
	_write()
	print("PLAYTEST done pass=", report["pass"])
	await get_tree().create_timer(0.4).timeout
	get_tree().quit(0 if report["pass"] else 1)


func _round_clear() -> bool:
	await _reset_ride()
	await get_tree().create_timer(0.2).timeout
	for f in course.fences:
		await _jump_fence(f, "perfect")
	await _finish_line()
	await _shot("round1_score")
	var ok: bool = GameState.round_complete and GameState.last_faults == 0
	report["rounds"].append({
		"name": "clear",
		"complete": GameState.round_complete,
		"faults": GameState.last_faults,
		"time": snapped(GameState.last_time, 0.01),
		"jumped": GameState.fences_jumped,
		"ok": ok,
	})
	print("PLAYTEST clear faults=", GameState.last_faults, " complete=", GameState.round_complete)
	return ok


func _round_refuse() -> bool:
	await _reset_ride()
	await get_tree().create_timer(0.2).timeout
	var first: bool = true
	for f in course.fences:
		if first:
			await _jump_fence(f, "refuse")
			await _jump_fence(f, "perfect")
			first = false
		else:
			await _jump_fence(f, "perfect")
	await _finish_line()
	await _shot("round2_refuse")
	var ok: bool = GameState.round_complete and GameState.last_faults == 4
	report["rounds"].append({
		"name": "refuse",
		"complete": GameState.round_complete,
		"faults": GameState.last_faults,
		"time": snapped(GameState.last_time, 0.01),
		"ok": ok,
	})
	print("PLAYTEST refuse faults=", GameState.last_faults)
	return ok


func _round_rail() -> bool:
	await _reset_ride()
	await get_tree().create_timer(0.2).timeout
	var i := 0
	for f in course.fences:
		if i == 2:
			await _jump_fence(f, "rail")
		else:
			await _jump_fence(f, "perfect")
		i += 1
	await _finish_line()
	await _shot("round3_rail")
	var ok: bool = GameState.round_complete and GameState.last_faults == 4
	report["rounds"].append({
		"name": "rail",
		"complete": GameState.round_complete,
		"faults": GameState.last_faults,
		"time": snapped(GameState.last_time, 0.01),
		"ok": ok,
	})
	print("PLAYTEST rail faults=", GameState.last_faults)
	return ok


func _reset_ride() -> void:
	course.reset_flags()
	GameState.reset_round()
	GameState.set_mode("ride")
	horse = arena.get_node("Abbott")
	course = arena.get_node("Course")
	horse.jumping = false
	horse.jump_fence = null
	horse.global_position = course.start_pos
	horse.rotation = Vector3(0, course.start_yaw, 0)
	horse.gait = 1
	horse.speed = 0.0
	horse.controllable = true
	horse.set_mounted(true)
	GameState.start_clock()
	resets += 1


func _jump_fence(f: JumpFence, kind: String) -> void:
	if not is_instance_valid(f):
		return
	var dir: Vector3 = f.takeoff_dir()
	dir.y = 0.0
	dir = dir.normalized()
	var dist := 2.55
	if kind == "refuse":
		dist = 4.4
	elif kind == "rail":
		dist = 1.2
	var pos: Vector3 = f.global_position - dir * dist
	pos.y = 0.0
	horse.global_position = pos
	var look := f.global_position
	look.y = horse.global_position.y
	if look.distance_to(horse.global_position) > 0.2:
		horse.look_at(look, Vector3.UP)
	horse.rotation.x = 0.0
	horse.rotation.z = 0.0
	horse.present(f, kind)
	var t := 0.0
	while horse.jumping and t < 2.5:
		await get_tree().process_frame
		t += get_process_delta_time()
	await get_tree().create_timer(0.12).timeout


func _finish_line() -> void:
	if course.finish_area:
		horse.global_position = course.finish_area.global_position + Vector3(0, 0, 0.4)
		horse.gait = 1
		horse.speed = 1.4
		await get_tree().create_timer(0.35).timeout
	if not GameState.round_complete and GameState.can_finish():
		GameState.finish_round()
	elif not GameState.round_complete and GameState.fences_jumped >= GameState.fences_needed():
		GameState.start_crossed = true
		GameState.finish_round()
	await get_tree().create_timer(0.2).timeout


func _out_dir() -> String:
	var exe := OS.get_executable_path()
	var dir := exe.get_base_dir()
	var leaf := exe.get_file().to_lower()
	if dir == "" or leaf.begins_with("godot") or dir.contains("WinGet"):
		dir = ProjectSettings.globalize_path("res://").path_join("..").path_join("dist")
	return dir


func _shot(name: String) -> void:
	if DisplayServer.get_name() == "headless":
		return
	await get_tree().process_frame
	var vp := get_viewport()
	if vp == null or vp.get_texture() == null:
		return
	var img := vp.get_texture().get_image()
	if img:
		var path := _out_dir().path_join("playtest_%s.png" % name)
		img.save_png(path)
		print("PLAYTEST shot ", path)
	shot_i += 1


func _write() -> void:
	var dir := _out_dir()
	var path := dir.path_join("playtest_results.json")
	var f := FileAccess.open(path, FileAccess.WRITE)
	if f:
		f.store_string(JSON.stringify(report, "\t"))
		f.close()
		print("PLAYTEST wrote ", path)
	var uf := FileAccess.open("user://playtest_results.json", FileAccess.WRITE)
	if uf:
		uf.store_string(JSON.stringify(report, "\t"))
		uf.close()


func _fail(msg: String) -> void:
	report["pass"] = false
	report["error"] = msg
	_write()
	print("PLAYTEST FAIL ", msg)
	get_tree().quit(1)
