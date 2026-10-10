extends SceneTree
## Windowed: auto rider on hk_les_001. Turn each per-frame script off in turn
## and print the average process time for each stage. Args: --shots-perf.

var _frames := 0
var _horse: Node3D
var _stage := 0
var _acc := 0.0
var _n := 0
var _off: Node = null
var _names := ["baseline", "RiderMesh", "HUD", "Course", "Abbott(process)", "AnimationPlayer", "Bascule", "baseline2"]


func _init() -> void:
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	call_deferred("_boot")


func _boot() -> void:
	var gs: Node = root.get_node_or_null("GameState")
	gs.call("start_session", "lesson", "lesson")
	gs.set("course_seed", 0)
	gs.call("set_mode", "ride")
	change_scene_to_file("res://scenes/arena.tscn")
	process_frame.connect(_tick)


func _target(i: int) -> Node:
	var arena := current_scene
	match i:
		1: return _horse.find_child("RiderMesh", true, false)
		2: return arena.get_node_or_null("HUD")
		3: return arena.get_node_or_null("Course")
		4: return _horse
		5: return _horse.find_child("AnimationPlayer", true, false)
		6: return _horse.find_child("Bascule", true, false)
	return null


func _tick() -> void:
	_frames += 1
	if _frames == 12:
		var arena := current_scene
		_horse = arena.get_node_or_null("Abbott") as Node3D
		var script := load("res://scripts/ride_ai.gd") as GDScript
		var ai = script.new()
		arena.add_child(ai)
		ai.call("bind", _horse, arena.get_node_or_null("Course"))
		ai.set("style", "clear")
		ai.call("reset_brain")
		ai.set("enabled", true)
	if _frames < 90:
		return
	_acc += Performance.get_monitor(Performance.TIME_PROCESS) * 1000.0
	_n += 1
	if _n >= 120:
		print("STAGE %s process_ms=%.2f fps=%d" % [_names[_stage], _acc / _n, Engine.get_frames_per_second()])
		if _off:
			if _off is AnimationPlayer:
				(_off as AnimationPlayer).active = true
			elif _off is SkeletonModifier3D:
				(_off as SkeletonModifier3D).active = true
			else:
				_off.set_process(true)
		_off = null
		_stage += 1
		_acc = 0.0
		_n = 0
		if _stage >= _names.size():
			quit(0)
			return
		_off = _target(_stage)
		if _off is AnimationPlayer:
			(_off as AnimationPlayer).active = false
		elif _off is SkeletonModifier3D:
			(_off as SkeletonModifier3D).active = false
		elif _off:
			_off.set_process(false)
