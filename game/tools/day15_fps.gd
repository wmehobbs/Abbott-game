extends SceneTree
## Windowed, vsync off: stand in the arena and measure the frame. Args after
## --: --shots-fps --kind=lesson|show. Prints FPS and CPU/GPU ms. Quits itself.

var _kind := "lesson"
var _t0 := 0
var _frames := 0
var _cpu := 0.0
var _gpu := 0.0
var _n := 0


func _init() -> void:
	for a in OS.get_cmdline_user_args():
		if str(a).begins_with("--kind="):
			_kind = str(a).substr(7)
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	call_deferred("_boot")


func _boot() -> void:
	var gs: Node = root.get_node_or_null("GameState")
	gs.call("start_session", _kind, "lesson")
	gs.set("course_seed", 0)
	gs.call("set_mode", "ride")
	change_scene_to_file("res://scenes/arena.tscn")
	_t0 = Time.get_ticks_msec()
	process_frame.connect(_tick)


func _tick() -> void:
	var t := Time.get_ticks_msec() - _t0
	var vp := root.get_viewport().get_viewport_rid()
	RenderingServer.viewport_set_measure_render_time(vp, true)
	if t < 3000:
		return
	if t < 9000:
		_frames += 1
		_cpu += RenderingServer.viewport_get_measured_render_time_cpu(vp) + RenderingServer.get_frame_setup_time_cpu()
		_gpu += RenderingServer.viewport_get_measured_render_time_gpu(vp)
		_n += 1
		return
	print("FPS kind=%s fps=%.0f render_cpu_ms=%.2f gpu_ms=%.2f frame_ms=%.2f" % [_kind, _frames / 6.0, _cpu / maxf(_n, 1), _gpu / maxf(_n, 1), 6000.0 / maxf(_frames, 1)])
	quit(0)
