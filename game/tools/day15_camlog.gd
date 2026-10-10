extends SceneTree
## Windowed: the auto rider rides hk_les_001; print the horse and the lens each
## frame around the first jump. Args after --: --shots-camlog. Quits itself.

var _frames := 0
var _horse: Node3D
var _cam: Camera3D
var _started := false
var _jumps := 0
var _was := false
var _t0 := 0


func _init() -> void:
	call_deferred("_boot")


func _boot() -> void:
	var gs: Node = root.get_node_or_null("GameState")
	gs.call("start_session", "lesson", "lesson")
	gs.set("course_seed", 0)
	gs.set("jump_off", false)
	gs.call("set_mode", "ride")
	change_scene_to_file("res://scenes/arena.tscn")
	process_frame.connect(_tick)


func _tick() -> void:
	_frames += 1
	if _frames == 12:
		var arena := current_scene
		_horse = arena.get_node_or_null("Abbott") as Node3D
		var course := arena.get_node_or_null("Course")
		var script := load("res://scripts/ride_ai.gd") as GDScript
		var ai = script.new()
		ai.name = "CamlogRider"
		arena.add_child(ai)
		ai.call("bind", _horse, course)
		ai.set("style", "clear")
		ai.call("reset_brain")
		ai.set("enabled", true)
		_cam = _horse.get("cam") as Camera3D
		_started = true
		_t0 = Time.get_ticks_msec()
	if not _started or _horse == null:
		return
	var j := bool(_horse.get("jumping"))
	if j and not _was:
		_jumps += 1
	_was = j
	var near := j or (_jumps >= 1 and float(_horse.get("land_recover")) > 1.8)
	if near and _jumps == 1:
		var hp := _horse.global_position
		var ip := (_horse as Node3D).get_global_transform_interpolated().origin
		var cp := _cam.global_position
		print("CAMLOG t=%d j=%s ju=%.2f horse=(%.2f,%.2f,%.2f) interp=(%.2f,%.2f,%.2f) cam=(%.2f,%.2f,%.2f) dist=%.2f fps=%d" % [Time.get_ticks_msec() - _t0, j, float(_horse.get("jump_t")) / maxf(float(_horse.get("jump_dur")), 0.01), hp.x, hp.y, hp.z, ip.x, ip.y, ip.z, cp.x, cp.y, cp.z, Vector2(cp.x - ip.x, cp.z - ip.z).length(), Engine.get_frames_per_second()])
	if _jumps >= 2 or Time.get_ticks_msec() - _t0 > 60000:
		quit(0)
