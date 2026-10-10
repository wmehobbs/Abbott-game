extends SceneTree
## Time each piece of the HUD's per-frame work. Args: --shots-hudtime.

var _frames := 0


func _init() -> void:
	call_deferred("_boot")


func _boot() -> void:
	var gs: Node = root.get_node_or_null("GameState")
	gs.call("start_session", "lesson", "lesson")
	gs.set("course_seed", 0)
	gs.call("set_mode", "ride")
	change_scene_to_file("res://scenes/arena.tscn")
	process_frame.connect(_tick)


func _t(label: String, f: Callable, n: int = 200) -> void:
	var t0 := Time.get_ticks_usec()
	for i in n:
		f.call()
	print("HUDTIME %-22s %8.1f us/call" % [label, float(Time.get_ticks_usec() - t0) / float(n)])


func _tick() -> void:
	_frames += 1
	if _frames != 30:
		return
	var gs: Node = root.get_node_or_null("GameState")
	var hud: Node = current_scene.get_node_or_null("HUD")
	_t("process(total)", func(): hud.call("_process", 0.016))
	_t("_fit_root", func(): hud.call("_fit_root"))
	_t("_sync_board", func(): hud.call("_sync_board"))
	_t("_set_ride_hint", func(): hud.call("_set_ride_hint"))
	_t("_sync_booth", func(): hud.call("_sync_booth"))
	_t("_sync_pips", func(): hud.call("_sync_pips"))
	_t("_sync_callout", func(): hud.call("_sync_callout", 0.016))
	_t("_sync_capture", func(): hud.call("_sync_capture"))
	_t("_sync_reins", func(): hud.call("_sync_reins", 0.016))
	_t("_sync_veil", func(): hud.call("_sync_veil", 0.016))
	_t("gs.class_title", func(): gs.call("class_title"))
	_t("gs.next_fence_line", func(): gs.call("next_fence_line"))
	_t("gs.time_allowed", func(): gs.call("time_allowed"))
	_t("gs.fences_needed", func(): gs.call("fences_needed"))
	quit(0)
