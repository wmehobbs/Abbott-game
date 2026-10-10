extends Node

## Runs inside the real boot so GameState is already loaded.
## Writes only under user://selftest/. Never the player save.

var _pass_n: int = 0
var _fail_n: int = 0

const ACTIONS: Array[String] = [
	"gait_up", "gait_down", "turn_left", "turn_right",
	"halt", "jump", "walk_mode", "mount", "pause",
	"look_x", "look_y", "steer", "gait_stick",
]


func _ready() -> void:
	call_deferred("_run")


func _run() -> void:
	var before := _save_bytes()
	_scripts()
	_actions()
	_demo_skips_save(before)
	_round_trip()
	_bak_recovers()
	_garbage_defaults()
	_old_save_migrates()
	_madison_snapshot()
	_courses()
	_telemetry_guard()
	_camera_follow()
	_ground_cycle()
	_human_steer()
	_leave_grade()
	_riding_aid()
	_reins_fade()
	_scoreboard()
	_hint_band()
	_result_count()
	_scene_fade()
	_sky_agx()
	_cc0_trees()
	_kick_wood()
	_bleachers()
	await _leg_tuck()
	_bridle_fit()
	_coat_clean()
	_barn_note_player()
	_land_feel()
	_banner()
	_score_sign()
	_rail_bands()
	_ground_quiet()
	_current_ring()
	_grass_clumps()
	_refuse_shake()
	_refuse_cam()
	_view_snap()
	_settings()
	await _layout()
	await _gamepad()
	await _buses()
	await _pause_round()
	_result_lines()
	_class_best_display()
	_season()
	await _first_lesson()
	_sharp()
	await _scene("res://scenes/title.tscn", "title_scene")
	await _scene("res://scenes/arena.tscn", "arena_scene")
	var after := _save_bytes()
	if before != after:
		_fail("player_save_untouched", "abbott_save.json changed")
		_restore(before)
	else:
		_ok("player_save_untouched")
	print("SELFTEST SUMMARY pass=%d fail=%d" % [_pass_n, _fail_n])
	get_tree().quit(0 if _fail_n == 0 else 1)


func _scripts() -> void:
	var dir := DirAccess.open("res://scripts")
	if dir == null:
		_fail("scripts_load", "res://scripts missing")
		return
	var names: PackedStringArray = dir.get_files()
	var n := 0
	for raw in names:
		var fn := str(raw)
		if not fn.ends_with(".gd"):
			continue
		n += 1
		var res: GDScript = load("res://scripts/" + fn) as GDScript
		if res == null or not res.can_instantiate():
			_fail("scripts_load", fn + " did not load")
			return
	if n < 10:
		_fail("scripts_load", "only %d scripts" % n)
		return
	_ok("scripts_load")


func _actions() -> void:
	for action in ACTIONS:
		if not InputMap.has_action(action):
			_fail("input_actions", action + " missing")
			return
	_ok("input_actions")


func _demo_skips_save(before: PackedByteArray) -> void:
	var was := GameState.demo_ride
	GameState.demo_ride = true
	var reason := GameState._skip_save_reason()
	GameState.save()
	GameState.demo_ride = was
	if reason != "demo":
		_fail("demo_ride_skips_save", "reason=" + reason)
		return
	if _save_bytes() != before:
		_fail("demo_ride_skips_save", "file changed")
		_restore(before)
		return
	_ok("demo_ride_skips_save")


func _round_trip() -> void:
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path("user://selftest"))
	var path := "user://selftest/roundtrip.json"
	GameState._write_save_file(path)
	if not FileAccess.file_exists(path):
		_fail("save_round_trip", "file missing")
		return
	var text := FileAccess.get_file_as_string(path)
	var parsed: Variant = JSON.parse_string(text)
	if typeof(parsed) != TYPE_DICTIONARY:
		_fail("save_round_trip", "not json")
		return
	var data: Dictionary = parsed
	if int(data.get("best_faults", -1)) != GameState.best_faults:
		_fail("save_round_trip", "best_faults")
		return
	if int(data.get("course_seed", -999)) != GameState.course_seed:
		_fail("save_round_trip", "course_seed")
		return
	_ok("save_round_trip")


func _write_raw(path: String, text: String) -> void:
	var f := FileAccess.open(path, FileAccess.WRITE)
	if f == null:
		return
	f.store_string(text)
	f.close()


func _bak_recovers() -> void:
	var path := "user://selftest/trunc.json"
	var marker := "{\"best_faults\":7,\"best_time\":8.0,\"course_seed\":3,\"lesson_done\":false,\"abbott_confidence\":9}"
	_write_raw(path, marker)
	GameState._write_save_file(path)
	_write_raw(path, "{")
	var loaded: Dictionary = GameState.read_save_migrated(path)
	if int(loaded.get("best_faults", -1)) != 7:
		_fail("truncated_recovers_from_bak", "best_faults=" + str(loaded.get("best_faults", -1)))
		return
	_ok("truncated_recovers_from_bak")


func _garbage_defaults() -> void:
	var path := "user://selftest/garbage.json"
	_write_raw(path, "this is not json")
	var bak := path + ".bak"
	if FileAccess.file_exists(bak):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(bak))
	var loaded: Dictionary = GameState.read_save_migrated(path)
	if int(loaded.get("best_faults", -1)) != 999:
		_fail("garbage_uses_defaults", "best_faults")
		return
	if int(loaded.get("course_seed", -1)) != 1:
		_fail("garbage_uses_defaults", "course_seed")
		return
	_ok("garbage_uses_defaults")


func _old_save_migrates() -> void:
	var path := "user://selftest/old.json"
	var old := "{\"best_faults\":4,\"best_time\":12.5,\"course_seed\":2,\"lesson_done\":true,\"abbott_confidence\":50}"
	_write_raw(path, old)
	var bak := path + ".bak"
	if FileAccess.file_exists(bak):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(bak))
	var loaded: Dictionary = GameState.read_save_migrated(path)
	if int(loaded.get("save_version", 0)) != 1:
		_fail("old_save_migrates", "version")
		return
	if int(loaded.get("best_faults", -1)) != 4:
		_fail("old_save_migrates", "best_faults")
		return
	if not is_equal_approx(float(loaded.get("madison_feel", -1)), 36.0):
		_fail("old_save_migrates", "madison_feel")
		return
	if not bool(loaded.get("tutorial_done", false)):
		_fail("old_save_migrates", "tutorial_done")
		return
	_ok("old_save_migrates")


func _madison_snapshot() -> void:
	var src := "E:/Workspace/Madison/dist/day12/save_snapshot.json"
	if not FileAccess.file_exists(src):
		_fail("madison_snapshot", "snapshot missing")
		return
	var text := FileAccess.get_file_as_string(src)
	var parsed: Variant = JSON.parse_string(text)
	if typeof(parsed) != TYPE_DICTIONARY:
		_fail("madison_snapshot", "snapshot is not json")
		return
	var path := "user://selftest/madison_copy.json"
	_write_raw(path, text)
	var bak := path + ".bak"
	if FileAccess.file_exists(bak):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(bak))
	var loaded: Dictionary = GameState.read_save_migrated(path)
	var original: Dictionary = parsed
	for k in original.keys():
		if str(JSON.stringify(loaded.get(k))) != str(JSON.stringify(original[k])):
			_fail("madison_snapshot", str(k))
			return
	if int(loaded.get("best_faults", -1)) != GameState.best_faults:
		_fail("madison_snapshot", "memory best_faults")
		return
	if int(loaded.get("course_seed", -1)) != GameState.course_seed:
		_fail("madison_snapshot", "memory course_seed")
		return
	if not bool(loaded.get("tutorial_done", false)):
		_fail("madison_snapshot", "tutorial_done")
		return
	_ok("madison_snapshot")


func _courses() -> void:
	var ship_text := FileAccess.get_file_as_string("res://content/courses/SHIP.json")
	var ship: Variant = JSON.parse_string(ship_text)
	if typeof(ship) != TYPE_DICTIONARY:
		_fail("ship_courses", "no SHIP")
		return
	var ids: Array[String] = []
	_collect_ids(ship, ids)
	if ids.is_empty():
		_fail("ship_courses", "no ids")
		return
	for id in ids:
		var rec: Dictionary = ContentLibrary.load_course(id)
		if rec.is_empty():
			_fail("ship_courses", id + " missing")
			return
		var specs: Array = ContentLibrary.specs_from_course(rec)
		if specs.is_empty():
			_fail("ship_courses", id + " no fences")
			return
	_ok("ship_courses")


func _collect_ids(node: Variant, ids: Array[String]) -> void:
	if typeof(node) == TYPE_STRING:
		var s: String = str(node)
		if s.begins_with("hk_"):
			ids.append(s)
		return
	if typeof(node) == TYPE_ARRAY:
		for item in node:
			_collect_ids(item, ids)
		return
	if typeof(node) == TYPE_DICTIONARY:
		var d: Dictionary = node
		for k in d.keys():
			_collect_ids(d[k], ids)


func _scene(path: String, name: String) -> void:
	var packed: PackedScene = load(path) as PackedScene
	if packed == null:
		_fail(name, "missing")
		return
	var node: Node = packed.instantiate()
	get_tree().root.add_child(node)
	await get_tree().process_frame
	await get_tree().process_frame
	node.free()
	_ok(name)


func _save_bytes() -> PackedByteArray:
	if not FileAccess.file_exists(GameState.SAVE_PATH):
		return PackedByteArray()
	return FileAccess.get_file_as_bytes(GameState.SAVE_PATH)


func _restore(before: PackedByteArray) -> void:
	if before.is_empty():
		return
	var f := FileAccess.open(GameState.SAVE_PATH, FileAccess.WRITE)
	if f == null:
		return
	f.store_buffer(before)
	f.close()


func _layout() -> void:
	var sizes: Array[Vector2i] = [
		Vector2i(1280, 720),
		Vector2i(1920, 1080),
		Vector2i(2560, 1440),
		Vector2i(3840, 2160),
		Vector2i(1280, 800),
		Vector2i(2560, 1080),
	]
	for sz in sizes:
		var why := await _layout_title(sz)
		if why != "":
			_fail("layout", "%dx%d title: %s" % [sz.x, sz.y, why])
			return
		why = await _layout_hud(sz)
		if why != "":
			_fail("layout", "%dx%d hud: %s" % [sz.x, sz.y, why])
			return
	_ok("layout")


func _layout_title(sz: Vector2i) -> String:
	var vp := SubViewport.new()
	vp.size = sz
	vp.disable_3d = true
	vp.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	add_child(vp)
	var packed: PackedScene = load("res://scenes/title.tscn") as PackedScene
	var title: Node = packed.instantiate()
	vp.add_child(title)
	await get_tree().process_frame
	await get_tree().process_frame
	var why := await _audit_screen(vp, sz, title)
	title.free()
	vp.free()
	return why


func _layout_hud(sz: Vector2i) -> String:
	var vp := SubViewport.new()
	vp.size = sz
	vp.disable_3d = true
	vp.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	add_child(vp)
	var script: GDScript = load("res://scripts/hud.gd") as GDScript
	if script == null or not script.can_instantiate():
		vp.free()
		return "hud script did not compile"
	var hud: Node = script.new()
	vp.add_child(hud)
	await get_tree().process_frame
	await get_tree().process_frame
	hud.call("show_pause", true)
	await get_tree().process_frame
	var why := await _audit_screen(vp, sz, hud)
	if why == "":
		var options := hud.get("options_panel") as Control
		var pause := hud.get("pause_panel") as Control
		if options:
			options.visible = true
		if pause:
			pause.visible = false
		await get_tree().process_frame
		var first := _first_button(options)
		if first:
			first.grab_focus()
		why = await _audit_screen(vp, sz, hud)
	if why == "":
		var options2 := hud.get("options_panel") as Control
		var result := hud.get("result_panel") as Control
		if options2:
			options2.visible = false
		if result:
			result.visible = true
		await get_tree().process_frame
		var ride := result.find_child("Ride again", true, false) as Control if result else null
		if ride:
			ride.grab_focus()
		why = await _audit_screen(vp, sz, hud)
	Engine.time_scale = 1.0
	GameState.ui_paused = false
	hud.free()
	vp.free()
	return why


func _audit_screen(vp: SubViewport, sz: Vector2i, root: Node) -> String:
	var buttons: Array[Button] = []
	var labels: Array[Label] = []
	_collect_ui(root, buttons, labels)
	for lab in labels:
		if not lab.is_visible_in_tree() or lab.text == "":
			continue
		var r := lab.get_global_rect()
		if r.position.x < -8.0 or r.position.y < -8.0 or r.end.x > float(sz.x) + 8.0 or r.end.y > float(sz.y) + 8.0:
			return "label outside: " + lab.text.substr(0, 24)
		var need := lab.get_minimum_size()
		if lab.autowrap_mode == TextServer.AUTOWRAP_OFF and r.size.x + 2.0 < need.x:
			return "label clipped: " + lab.text.substr(0, 24)
	var rects: Array[Rect2] = []
	var live: Array[Button] = []
	for b in buttons:
		if not b.is_visible_in_tree():
			continue
		var r2 := b.get_global_rect()
		if r2.size.x < 2.0:
			continue
		if r2.position.x < -2 or r2.position.y < -2 or r2.end.x > sz.x + 2 or r2.end.y > sz.y + 2:
			return "button outside: " + b.text
		for prev in rects:
			var hit := prev.intersection(r2)
			if hit.size.x > 4.0 and hit.size.y > 4.0:
				return "buttons overlap: " + b.text
		rects.append(r2)
		live.append(b)
	if live.is_empty():
		return "no buttons"
	if vp.gui_get_focus_owner() == null:
		return "nothing focused"
	return await _reach_buttons(vp, live)


func _collect_ui(n: Node, buttons: Array[Button], labels: Array[Label]) -> void:
	if n is Button:
		buttons.append(n)
	elif n is Label:
		labels.append(n)
	for c in n.get_children():
		_collect_ui(c, buttons, labels)


func _first_button(root: Node) -> Button:
	if root == null:
		return null
	if root is Button and (root as CanvasItem).is_visible_in_tree():
		return root
	for c in root.get_children():
		var found := _first_button(c)
		if found:
			return found
	return null


func _reach_buttons(vp: SubViewport, buttons: Array[Button]) -> String:
	var start := vp.gui_get_focus_owner() as Control
	if start == null:
		return "nothing focused"
	var seen: Array[Control] = [start]
	var queue: Array[Control] = [start]
	var dirs: Array[String] = ["ui_up", "ui_down", "ui_left", "ui_right"]
	var guard := 0
	while queue.size() > 0 and guard < 64:
		guard += 1
		var cur: Control = queue.pop_front()
		for action in dirs:
			cur.grab_focus()
			var ev := InputEventAction.new()
			ev.action = action
			ev.pressed = true
			vp.push_input(ev)
			var up := InputEventAction.new()
			up.action = action
			up.pressed = false
			vp.push_input(up)
			await get_tree().process_frame
			var nxt := vp.gui_get_focus_owner() as Control
			if nxt != null and not seen.has(nxt):
				seen.append(nxt)
				queue.append(nxt)
	for b in buttons:
		if not seen.has(b):
			return "cannot reach " + b.text
	return ""


func _buses() -> void:
	if GameState.settings:
		GameState.settings.music_db = 0.0
		GameState.settings.ambience_db = 0.0
		GameState.settings.master_db = 0.0
		GameState.settings.apply_audio()
	GameState._duck = 0.0
	GameState.voice_hold = false
	var horse := Horse.new()
	add_child(horse)
	await get_tree().process_frame
	var why := _bus_walk(horse)
	horse.free()
	if why != "":
		_fail("audio_buses", why)
		return
	var music := AudioServer.get_bus_index("Music")
	var amb := AudioServer.get_bus_index("Ambience")
	if music < 0 or amb < 0:
		_fail("audio_buses", "bus missing")
		return
	AudioServer.set_bus_volume_db(music, 0.0)
	AudioServer.set_bus_volume_db(amb, 0.0)
	GameState._duck = 0.0
	GameState.voice_hold = true
	for _i in 12:
		GameState.tick(0.05)
	var ducked := AudioServer.get_bus_volume_db(music)
	var ducked_amb := AudioServer.get_bus_volume_db(amb)
	GameState.voice_hold = false
	for _i in 16:
		GameState.tick(0.05)
	var back := AudioServer.get_bus_volume_db(music)
	var back_amb := AudioServer.get_bus_volume_db(amb)
	if ducked > -5.5 or ducked_amb > -5.5:
		_fail("audio_buses", "duck music %.2f amb %.2f" % [ducked, ducked_amb])
		return
	if absf(back) > 0.4 or absf(back_amb) > 0.4:
		_fail("audio_buses", "restore music %.2f amb %.2f" % [back, back_amb])
		return
	_ok("audio_buses")


func _bus_walk(n: Node) -> String:
	if n is AudioStreamPlayer or n is AudioStreamPlayer3D:
		var bus := ""
		if n is AudioStreamPlayer:
			bus = (n as AudioStreamPlayer).bus
		else:
			bus = (n as AudioStreamPlayer3D).bus
		if bus == "" or bus == "Master":
			return str(n.name) + " is on " + bus
	for c in n.get_children():
		var why := _bus_walk(c)
		if why != "":
			return why
	return ""


func _gamepad() -> void:
	for action in GameState.DEFAULT_BINDINGS.keys():
		var has_key := false
		var has_pad := false
		for ev in InputMap.action_get_events(str(action)):
			if ev is InputEventKey:
				has_key = true
			if ev is InputEventJoypadButton:
				has_pad = true
		if not has_key or not has_pad:
			_fail("gamepad_actions", "%s key=%s pad=%s" % [action, has_key, has_pad])
			return
	for action in ["steer", "look_x", "look_y", "gait_stick"]:
		var has_axis := false
		for ev in InputMap.action_get_events(action):
			if ev is InputEventJoypadMotion:
				has_axis = true
		if not has_axis:
			_fail("gamepad_actions", action + " has no stick")
			return
	var horse := Horse.new()
	add_child(horse)
	await get_tree().process_frame
	var was_mode := GameState.mode
	GameState.mode = "ride"
	horse.gait = 0
	Input.action_press("gait_up")
	horse._physics_process(0.05)
	Input.action_release("gait_up")
	if horse.gait != 1:
		var stuck := horse.gait
		GameState.mode = was_mode
		horse.free()
		_fail("gamepad_actions", "gait stayed %d" % stuck)
		return
	var yaw0 := horse.rotation.y
	Input.action_press("turn_left")
	horse._physics_process(0.2)
	Input.action_release("turn_left")
	if absf(horse.rotation.y - yaw0) < 0.001 and absf(horse.last_turn) < 0.001:
		GameState.mode = was_mode
		horse.free()
		_fail("gamepad_actions", "steer did not move")
		return
	horse.gait = Horse.CANTER
	Input.action_press("jump")
	horse._physics_process(0.05)
	var held: bool = horse.collecting
	Input.action_release("jump")
	GameState.mode = was_mode
	horse.free()
	if not held:
		_fail("gamepad_actions", "collect did not hold")
		return
	_ok("gamepad_actions")


func _settings() -> void:
	var cfg_path := "user://settings.cfg"
	var had := FileAccess.file_exists(cfg_path)
	var before := PackedByteArray()
	if had:
		before = FileAccess.get_file_as_bytes(cfg_path)
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path("user://selftest"))
	var path := "user://selftest/settings.cfg"
	var s := PlayerSettings.new()
	s.fov = 90.0
	s.master_db = -8.0
	s.music_db = -4.0
	s.mouse_sensitivity = 0.11
	s.invert_look = true
	s.camera_bob = false
	s.quality = "Low"
	s.render_scale = 0.75
	s.subtitles = false
	s.hud_scale = 1.2
	s.save_to(path)
	var t := PlayerSettings.new()
	t.load_from(path)
	if absf(t.fov - 62.0) > 0.01 or absf(t.master_db - (-8.0)) > 0.01 or t.quality != "Low":
		_fail("settings", "round trip fov %.2f quality %s" % [t.fov, t.quality])
		return
	if t.subtitles or t.camera_bob or not t.invert_look:
		_fail("settings", "round trip flags")
		return
	if absf(t.mouse_sensitivity - 0.11) > 0.001 or absf(t.render_scale - 0.75) > 0.001 or absf(t.hud_scale - 1.2) > 0.001:
		_fail("settings", "round trip feel")
		return
	if absf(t.camera_motion - 70.0) > 0.01:
		_fail("settings", "camera motion default %.1f" % t.camera_motion)
		return
	if t.msaa_level() != Viewport.MSAA_DISABLED:
		_fail("settings", "low quality kept full msaa")
		return
	t.quality = "Medium"
	if t.msaa_level() != Viewport.MSAA_2X:
		_fail("settings", "medium quality msaa")
		return
	t.quality = "High"
	if t.msaa_level() != Viewport.MSAA_4X:
		_fail("settings", "high quality msaa")
		return
	var junk := FileAccess.open(path, FileAccess.WRITE)
	if junk == null:
		_fail("settings", "could not write a bad file")
		return
	junk.store_string("this is not a config")
	junk.close()
	var bad := PlayerSettings.new()
	bad.fov = 44.0
	bad.load_from(path)
	if absf(bad.fov - 52.0) > 0.01 or bad.quality != "High":
		_fail("settings", "corrupt file kept fov %.2f" % bad.fov)
		return
	var missing := PlayerSettings.new()
	missing.fov = 44.0
	missing.load_from("user://selftest/no_such_settings.cfg")
	if absf(missing.fov - 52.0) > 0.01:
		_fail("settings", "missing file kept fov %.2f" % missing.fov)
		return
	var live := GameState.settings
	var why := ""
	live.music_db = -4.0
	live.ambience_db = -2.0
	live.apply_audio()
	GameState._duck = 0.0
	GameState.voice_hold = true
	for _i in 12:
		GameState.tick(0.05)
	var music := AudioServer.get_bus_index("Music")
	var amb := AudioServer.get_bus_index("Ambience")
	var ducked := AudioServer.get_bus_volume_db(music)
	var ducked_amb := AudioServer.get_bus_volume_db(amb)
	GameState.voice_hold = false
	for _i in 16:
		GameState.tick(0.05)
	var back := AudioServer.get_bus_volume_db(music)
	var back_amb := AudioServer.get_bus_volume_db(amb)
	if ducked < -10.5 or ducked > -9.5 or ducked_amb < -8.5 or ducked_amb > -7.5:
		why = "duck on top music %.2f amb %.2f" % [ducked, ducked_amb]
	elif absf(back - (-4.0)) > 0.4 or absf(back_amb - (-2.0)) > 0.4:
		why = "restore music %.2f amb %.2f" % [back, back_amb]
	live.music_db = 0.0
	live.ambience_db = 0.0
	live.master_db = 0.0
	live.fov = 52.0
	live.mouse_sensitivity = 0.07
	live.invert_look = false
	live.camera_bob = true
	live.quality = "High"
	live.subtitles = true
	live.hud_scale = 1.0
	live.apply_audio()
	GameState._duck = 0.0
	GameState.voice_hold = false
	if why == "":
		var horse := Horse.new()
		live.fov = 58.0
		live.mouse_sensitivity = 0.10
		live.invert_look = true
		if absf(horse._fov_base() - 58.0) > 0.01 or absf(horse._look_yaw() - 0.10) > 0.001 or horse._look_invert() > 0.0:
			why = "look did not follow the setting"
		live.fov = 52.0
		live.mouse_sensitivity = 0.07
		live.invert_look = false
		horse.free()
	var now := FileAccess.file_exists(cfg_path)
	if why == "" and had != now:
		why = "user settings.cfg appeared"
	if why == "" and had and FileAccess.get_file_as_bytes(cfg_path) != before:
		why = "user settings.cfg changed"
	if why != "":
		_fail("settings", why)
		return
	_ok("settings")


func _pause_round() -> void:
	var packed: PackedScene = load("res://scenes/arena.tscn") as PackedScene
	if packed == null:
		_fail("pause", "arena missing")
		return
	var arena: Node = packed.instantiate()
	add_child(arena)
	await get_tree().process_frame
	await get_tree().process_frame
	var best0 := GameState.best_faults
	var why := ""
	var hud: Node = arena.get("hud")
	if hud == null or hud.find_child("Restart round", true, false) == null:
		why = "restart button missing"
	if why == "":
		GameState.set_mode("ride")
		arena.set("paused", true)
		GameState.clock_running = true
		GameState.time_sec = 12.5
		GameState.faults = 4
		arena.call("_process", 0.5)
		if absf(GameState.time_sec - 12.5) > 0.001:
			why = "clock moved while paused"
	if why == "":
		arena.call("_retry")
		if GameState.faults != 0 or GameState.time_sec > 0.05 or GameState.round_complete:
			why = "restart left faults %d time %.2f" % [GameState.faults, GameState.time_sec]
	if why == "":
		var horse: Node3D = arena.get("horse") as Node3D
		var course: Node = arena.get("course") as Node
		if horse == null or course == null:
			why = "restart lost the horse"
		else:
			var start: Vector3 = course.get("start_pos") as Vector3
			if horse.global_position.distance_to(start) > 0.2:
				why = "horse not at the start"
	if why == "":
		arena.set("paused", false)
		Engine.time_scale = 1.0
		GameState.set_mode("ride")
		GameState.clock_running = true
		var t0 := GameState.time_sec
		arena.call("_process", 0.25)
		if GameState.time_sec < t0 + 0.2:
			why = "clock did not run after resume"
	GameState.faults = 4
	GameState.time_sec = 9.0
	GameState.round_complete = false
	if why == "" and (GameState.round_complete or GameState.best_faults != best0):
		why = "partial round was recorded"
	Engine.time_scale = 1.0
	GameState.ui_paused = false
	GameState.clock_running = false
	arena.free()
	if why != "":
		_fail("pause", why)
		return
	_ok("pause")


func _result_lines() -> void:
	var was_elim := GameState.eliminated
	var was_reason := GameState.eliminate_reason
	var was_faults := GameState.last_faults
	var was_time_f := GameState.time_faults
	var was_jump := GameState.jump_off
	var was_cents := GameState.official_cents
	var was_kind := GameState.session_kind
	var was_class := GameState.class_id
	var was_rails: Array[int] = []
	for n in GameState.rail_nums:
		was_rails.append(int(n))
	var was_refuse: Array[int] = []
	for n2 in GameState.refuse_nums:
		was_refuse.append(int(n2))
	var was_posted: Dictionary = GameState.rounds_posted.duplicate(true)
	var why := ""
	GameState.official_cents = 2500
	GameState.session_kind = "schooling"
	GameState.eliminated = false
	GameState.jump_off = false
	GameState.time_faults = 0
	GameState.last_faults = 0
	GameState.rail_nums.clear()
	GameState.refuse_nums.clear()
	if not GameState.result_line().begins_with("Clear."):
		why = "clear: " + GameState.result_line()
	if why == "":
		GameState.last_faults = 4
		GameState.rail_nums.append(3)
		if not GameState.result_line().contains("rail 3"):
			why = "rail: " + GameState.result_line()
	if why == "":
		GameState.rail_nums.clear()
		GameState.refuse_nums.append(2)
		if not GameState.result_line().contains("refusal 2"):
			why = "refusal: " + GameState.result_line()
	if why == "":
		GameState.eliminated = true
		GameState.eliminate_reason = "three"
		if not GameState.result_line().contains("three refusals"):
			why = "elim: " + GameState.result_line()
	if why == "":
		GameState.eliminated = false
		GameState.last_faults = 1
		GameState.time_faults = 1
		GameState.refuse_nums.clear()
		if not GameState.result_line().contains("1 time fault"):
			why = "time: " + GameState.result_line()
	if why == "":
		GameState.last_faults = 0
		GameState.time_faults = 0
		GameState.jump_off = true
		if not GameState.result_line().begins_with("Jump-off clear."):
			why = "jumpoff: " + GameState.result_line()
	var card: HUD = HUD.new()
	GameState.class_id = "lesson"
	if why == "" and card._next_class_id() != "beginner":
		why = "next after lesson"
	GameState.class_id = "beginner"
	GameState.rounds_posted = {}
	if why == "" and card._next_class_id() != "":
		why = "locked class was offered"
	GameState.rounds_posted = {"beginner": 1}
	if why == "" and card._next_class_id() != "intermediate":
		why = "next after a posted beginner round"
	card.free()
	GameState.eliminated = was_elim
	GameState.eliminate_reason = was_reason
	GameState.last_faults = was_faults
	GameState.time_faults = was_time_f
	GameState.jump_off = was_jump
	GameState.official_cents = was_cents
	GameState.session_kind = was_kind
	GameState.class_id = was_class
	GameState.rail_nums.clear()
	for n3 in was_rails:
		GameState.rail_nums.append(n3)
	GameState.refuse_nums.clear()
	for n4 in was_refuse:
		GameState.refuse_nums.append(n4)
	GameState.rounds_posted = was_posted
	if why != "":
		_fail("results", why)
		return
	_ok("results")


func _class_best_display() -> void:
	var was_id := GameState.class_id
	var was_time := GameState.best_time
	var was_faults := GameState.best_faults
	var was_bests: Dictionary = GameState.best_by_class.duplicate(true)
	var why := ""
	GameState.best_faults = 0
	GameState.best_time = 5.86
	GameState.class_id = "lesson"
	GameState.best_by_class = {"beginner": {"faults": 0, "time": 5.86}}
	if GameState.class_best_display() != "":
		why = "a lesson showed the beginner record"
	if why == "" and not GameState.best_line().contains("5.86"):
		why = "the saved record line moved"
	if why == "":
		GameState.best_by_class["lesson"] = {"faults": 4, "time": 25.41}
		var line := GameState.class_best_display()
		if not line.contains("25.41") or line.contains("5.86"):
			why = "lesson best was " + line
		if why == "" and GameState.best_time != 5.86:
			why = "display wrote best_time"
	GameState.class_id = was_id
	GameState.best_time = was_time
	GameState.best_faults = was_faults
	GameState.best_by_class = was_bests
	if why != "":
		_fail("class_best_display", why)
		return
	_ok("class_best_display")


func _season() -> void:
	var kind := GameState.session_kind
	var posted: Dictionary = GameState.rounds_posted.duplicate(true)
	var clears: Dictionary = GameState.clears.duplicate(true)
	var bests: Dictionary = GameState.best_by_class.duplicate(true)
	var show_best: Dictionary = GameState.show_best.duplicate(true)
	var ribbons: Array = GameState.show_ribbons.duplicate()
	var why := ""
	GameState.session_kind = "schooling"
	GameState.rounds_posted = {"lesson": 0, "beginner": 0, "intermediate": 0, "advanced": 0}
	GameState.clears = {"lesson": 0, "beginner": 0, "intermediate": 0, "advanced": 0}
	GameState.best_by_class = {}
	GameState.show_best = {}
	GameState.show_ribbons = []
	var fresh: Dictionary = GameState._save_defaults()
	if bool(GameState._migrate_save(fresh).get("tutorial_done", true)):
		why = "fresh save was sent to the tutorial flag"
	var rows: Array = GameState.season_rows()
	if why == "" and not _season_ok(rows, "fresh"):
		why = "fresh ladder"
	if why == "":
		GameState.rounds_posted["beginner"] = 1
		GameState.best_by_class["beginner"] = {"faults": 0, "time": 60.0}
		if not _season_state(GameState.season_rows(), "schooling", "beginner", "done"):
			why = "beginner was not marked done"
		if why == "" and not _season_state(GameState.season_rows(), "schooling", "intermediate", "open"):
			why = "intermediate stayed locked"
		if why == "" and not _season_state(GameState.season_rows(), "schooling", "advanced", "locked"):
			why = "advanced opened early"
	if why == "":
		GameState.rounds_posted["intermediate"] = 1
		GameState.best_by_class["intermediate"] = {"faults": 4, "time": 70.0}
		if not _season_state(GameState.season_rows(), "schooling", "advanced", "open"):
			why = "schooling advanced stayed locked"
		if why == "" and not _season_state(GameState.season_rows(), "show", "advanced", "locked"):
			why = "show advanced opened without a clear"
	if why == "":
		GameState.clears["intermediate"] = 1
		GameState.show_best["intermediate"] = {"faults": 0, "time": 80.0}
		GameState.show_ribbons = [{"class": "intermediate", "ribbon": "Blue", "faults": 0, "time": 80.0}]
		var done: Array = GameState.season_rows()
		if not _season_state(done, "show", "advanced", "open"):
			why = "show advanced stayed locked"
		if why == "" and not _season_state(done, "show", "intermediate", "done"):
			why = "show intermediate was not done"
		if why == "" and not _season_covers(done):
			why = "a class was left off the ladder"
	GameState.session_kind = kind
	GameState.rounds_posted = posted
	GameState.clears = clears
	GameState.best_by_class = bests
	GameState.show_best = show_best
	GameState.show_ribbons = ribbons
	if why != "":
		_fail("season", why)
		return
	_ok("season")


func _season_ok(rows: Array, _tag: String) -> bool:
	if rows.size() != 10:
		return false
	return _season_state(rows, "lesson", "hk_les_001", "open") and _season_state(rows, "schooling", "beginner", "open") and _season_state(rows, "schooling", "intermediate", "locked") and _season_state(rows, "show", "beginner", "open") and _season_state(rows, "show", "advanced", "locked")


func _season_state(rows: Array, kind: String, id: String, state: String) -> bool:
	for row in rows:
		if str(row.get("kind", "")) == kind and str(row.get("id", "")) == id:
			return str(row.get("state", "")) == state
	return false


func _season_covers(rows: Array) -> bool:
	var ship: Dictionary = ContentLibrary.load_ship()
	var lessons: Variant = ship.get("lesson", [])
	if typeof(lessons) != TYPE_ARRAY:
		return false
	for raw in lessons:
		if not _season_state(rows, "lesson", str(raw), "open") and not _season_state(rows, "lesson", str(raw), "done"):
			return false
	for cid in ["beginner", "intermediate", "advanced"]:
		for kind in ["schooling", "show"]:
			var hit := false
			for row in rows:
				if str(row.get("kind", "")) == kind and str(row.get("id", "")) == cid:
					hit = true
			if not hit:
				return false
	return true


func _first_lesson() -> void:
	var was_done := GameState.tutorial_done
	var was_kind := GameState.session_kind
	var was_jumps := GameState.fences_jumped
	var was_device := GameState.last_device
	var why := ""
	GameState.tutorial_done = false
	GameState.session_kind = "lesson"
	GameState.fences_jumped = 0
	GameState.last_device = "key"
	var guide := FirstLesson.new()
	guide.try_start()
	if guide.active:
		why = "selftest started the lesson"
	guide.active = true
	guide.step = 0
	var horse := Horse.new()
	add_child(horse)
	await get_tree().process_frame
	horse.gait = 1
	guide.tick(horse)
	if why == "" and guide.step != 1:
		why = "walk did not advance"
	horse.gait = 2
	guide.tick(horse)
	if why == "" and guide.step != 2:
		why = "trot did not advance"
	horse.gait = Horse.CANTER
	guide.tick(horse)
	if why == "" and guide.step != 3:
		why = "canter did not advance"
	horse.last_turn = 0.4
	guide.tick(horse)
	if why == "" and guide.step != 4:
		why = "steer did not advance"
	horse.gait = 0
	horse.last_turn = 0.0
	guide.tick(horse)
	if why == "" and guide.step != 5:
		why = "whoa did not advance"
	horse.collecting = true
	guide.tick(horse)
	if why == "" and guide.step != 5:
		why = "half-halt finished on the hold"
	horse.collecting = false
	guide.tick(horse)
	if why == "" and guide.step != 6:
		why = "half-halt did not advance"
	GameState.fences_jumped = 1
	guide.tick(horse)
	if why == "" and guide.step != 7:
		why = "pole did not advance"
	GameState.fences_jumped = 2
	guide.tick(horse)
	if why == "" and (guide.active or not GameState.tutorial_done):
		why = "lesson did not finish"
	if why == "":
		for s in range(8):
			guide.step = s
			guide.active = true
			var words := guide.line().split(" ", false)
			if words.size() > 14 or guide.line().contains("—"):
				why = "line too long: " + guide.line()
				break
		GameState.last_device = "pad"
		guide.step = 0
		if guide.line() != "Press D-pad up to walk.":
			why = "pad line"
	if why == "":
		var again := FirstLesson.new()
		again.active = true
		again.skip()
		if again.active or not GameState.tutorial_done:
			why = "skip did not end the lesson"
	horse.free()
	GameState.tutorial_done = was_done
	GameState.session_kind = was_kind
	GameState.fences_jumped = was_jumps
	GameState.last_device = was_device
	if why != "":
		_fail("first_lesson", why)
		return
	_ok("first_lesson")


func _sharp() -> void:
	var mode := str(ProjectSettings.get_setting("display/window/stretch/mode", ""))
	var aspect := str(ProjectSettings.get_setting("display/window/stretch/aspect", ""))
	if mode != "canvas_items" or aspect != "expand":
		_fail("sharp", "%s %s" % [mode, aspect])
		return
	_ok("sharp")


func _riding_aid() -> void:
	var horse := FileAccess.get_file_as_string("res://scripts/horse.gd")
	var settings := FileAccess.get_file_as_string("res://scripts/settings.gd")
	if not horse.contains("func _sync_aid") or not horse.contains("3.35"):
		_fail("riding_aid", "stride dots are missing")
		return
	if not horse.contains("session_kind == \"lesson\""):
		_fail("riding_aid", "shows would get the dots")
		return
	if not settings.contains("riding_aid: bool = true"):
		_fail("riding_aid", "the option does not default on")
		return
	_ok("riding_aid")


func _land_feel() -> void:
	var horse := FileAccess.get_file_as_string("res://scripts/horse.gd")
	var settings := FileAccess.get_file_as_string("res://scripts/settings.gd")
	if not horse.contains("func _land_feel") or not horse.contains("LandSpray"):
		_fail("land_feel", "landing does not throw sand")
		return
	if not settings.contains("var rumble"):
		_fail("land_feel", "rumble has no switch")
		return
	_ok("land_feel")


func _coat_clean() -> void:
	var sh := FileAccess.get_file_as_string("res://shaders/coat.gdshader")
	if not sh.contains("coat_clean") or not sh.contains("side_strength = 0.0"):
		_fail("coat_clean", "the photo coat is still painted on")
		return
	if not sh.contains("coat_flat") or not sh.contains("vec3 base = chestnut"):
		_fail("coat_clean", "the head photo is still stretched on")
		return
	_ok("coat_clean")


func _barn_note_player() -> void:
	var shown := ContentLibrary._player_note("Welcome Stake. Outside track. First fence quiet. Hidden K note 1170.")
	if shown.contains("Hidden K note") or shown != "Welcome Stake. Outside track. First fence quiet.":
		_fail("barn_note", shown)
		return
	var quiet := ContentLibrary._player_note("Walk him first. Then a quiet canter.")
	if quiet != "Walk him first. Then a quiet canter.":
		_fail("barn_note", quiet)
		return
	_ok("barn_note")


func _bridle_fit() -> void:
	var look := FileAccess.get_file_as_string("res://scripts/abbott_look.gd")
	if not look.contains("BridleFit") or not look.contains("_hide_meshes"):
		_fail("bridle_fit", "the floating straps are still drawn")
		return
	_ok("bridle_fit")


func _leg_tuck() -> void:
	# A real seat, read off the posed rider in the arena: the horse's skeleton
	# spans a horse (the v2 export once shrank it to 3 cm under a 200 m mesh),
	# the saddle is in the dip behind his withers, and each ankle hangs against
	# his side below its knee, the two sides alike.
	var packed: PackedScene = load("res://scenes/arena.tscn") as PackedScene
	var arena: Node = packed.instantiate()
	get_tree().root.add_child(arena)
	for i in 4:
		await get_tree().process_frame
	var horse := arena.get_node_or_null("Abbott") as Node3D
	var why := ""
	if horse == null:
		why = "no horse"
	else:
		var sk := horse.get("skel") as Skeleton3D
		if sk == null:
			why = "no horse skeleton"
		else:
			var head := sk.to_global(sk.get_bone_global_pose(sk.find_bone("Head")).origin)
			var tail := sk.to_global(sk.get_bone_global_pose(sk.find_bone("Tail1")).origin)
			var span := head.distance_to(tail)
			if span < 1.0 or span > 2.5:
				why = "horse skeleton spans %.2f m" % span
		var seat := horse.find_child("Seat", true, false) as Node3D
		if why == "" and seat != null:
			var z := horse.to_local(seat.global_position).z
			if z < -0.15 or z > 0.10:
				why = "saddle at z %.2f, not behind the withers" % z
		var rm := horse.find_child("RiderMesh", true, false)
		if why == "" and rm != null:
			var leg: Dictionary = rm.get("_leg")
			if not leg.has("L") or not leg.has("R"):
				why = "legs not posed"
			else:
				for tag in ["L", "R"]:
					var a: Vector3 = (leg[tag] as Dictionary)["ankle"]
					var k: Vector3 = (leg[tag] as Dictionary)["knee"]
					if absf(a.x) < 0.21 or absf(a.x) > 0.31:
						why = "%s ankle %.2f m off his centre line" % [tag, absf(a.x)]
					elif a.y > k.y - 0.2:
						why = "%s ankle not below the knee" % tag
				var al: Vector3 = (leg["L"] as Dictionary)["ankle"]
				var ar: Vector3 = (leg["R"] as Dictionary)["ankle"]
				if why == "" and (absf(al.x + ar.x) > 0.02 or absf(al.y - ar.y) > 0.02):
					why = "the two legs differ"
	arena.queue_free()
	await get_tree().process_frame
	if why != "":
		_fail("leg_tuck", why)
		return
	_ok("leg_tuck")


func _refuse_cam() -> void:
	var horse := FileAccess.get_file_as_string("res://scripts/horse.gd")
	if not horse.contains("var _cam_back") or not horse.contains("_cam_back = 0.48"):
		_fail("refuse_cam", "a refusal does not pull the lens")
		return
	_ok("refuse_cam")


func _view_snap() -> void:
	var horse := FileAccess.get_file_as_string("res://scripts/horse.gd")
	if not horse.contains("absf(dy) > 0.9") or not horse.contains("cam_look_ready = false"):
		_fail("view_snap", "a place leaves the lens in the ring")
		return
	if not horse.contains("distance_to(interp.origin) > 1.0") or not horse.contains("distance_to(look) > 8.0"):
		_fail("view_snap", "a place leaves the look on the old spot")
		return
	_ok("view_snap")


func _refuse_shake() -> void:
	var hud := FileAccess.get_file_as_string("res://scripts/hud.gd")
	var arena := FileAccess.get_file_as_string("res://scripts/arena.gd")
	if not hud.contains("func shake_refuse") or not hud.contains("* 4.0"):
		_fail("refuse_shake", "a refusal does not shake the card")
		return
	if not arena.contains("shake_refuse"):
		_fail("refuse_shake", "the refusal is not wired")
		return
	_ok("refuse_shake")


func _grass_clumps() -> void:
	var farm := FileAccess.get_file_as_string("res://scripts/farm.gd")
	if not farm.contains("GrassClumps") or not farm.contains("func _grass_clumps"):
		_fail("grass_clumps", "the lawn has no tufts")
		return
	_ok("grass_clumps")


func _current_ring() -> void:
	var fence := FileAccess.get_file_as_string("res://scripts/fence.gd")
	if not fence.contains("CurrentRing") or not fence.contains("session_kind == \"lesson\""):
		_fail("current_ring", "the current fence has no lesson ring")
		return
	_ok("current_ring")


func _ground_quiet() -> void:
	var fence := FileAccess.get_file_as_string("res://scripts/fence.gd")
	var i := fence.find("func _ground_line")
	if i < 0:
		_fail("ground_quiet", "the ground lines are gone")
		return
	var body := fence.substr(i, 420)
	if not body.contains("0.70, 0.66, 0.58"):
		_fail("ground_quiet", "the ground lines are still bright")
		return
	_ok("ground_quiet")


func _rail_bands() -> void:
	var fence := FileAccess.get_file_as_string("res://scripts/fence.gd")
	if not fence.contains("func _rail_band") or not fence.contains("RailBand"):
		_fail("rail_bands", "the rails have no painted bands")
		return
	if fence.contains("cyl.top_radius = 0.046") == false:
		_fail("rail_bands", "the rail radius changed")
		return
	_ok("rail_bands")


func _score_sign() -> void:
	var farm := FileAccess.get_file_as_string("res://scripts/farm.gd")
	if not farm.contains("ScoreSign") or not farm.contains("TIME    FAULTS"):
		_fail("score_sign", "the in-gate has no scoreboard")
		return
	_ok("score_sign")


func _banner() -> void:
	var farm := FileAccess.get_file_as_string("res://scripts/farm.gd")
	if not farm.contains("HiddenKBanner") or not farm.contains("HIDDEN K"):
		_fail("banner", "the far rail has no Hidden K sign")
		return
	_ok("banner")


func _bleachers() -> void:
	var farm := FileAccess.get_file_as_string("res://scripts/farm.gd")
	if not farm.contains("func _bleachers") or not farm.contains("Bleacher"):
		_fail("bleachers", "the far rail has no stands")
		return
	_ok("bleachers")


func _kick_wood() -> void:
	var kit := FileAccess.get_file_as_string("res://scripts/mesh_kit.gd")
	var i := kit.find("func wood_kick")
	if i < 0:
		_fail("kick_wood", "the kickboard material is gone")
		return
	var body := kit.substr(i, 320)
	if body.contains("kick_dark"):
		_fail("kick_wood", "the kickboard is still the black plank")
		return
	if not body.contains("0.58, 0.40, 0.24"):
		_fail("kick_wood", "the kickboard is not a wood color")
		return
	_ok("kick_wood")


func _cc0_trees() -> void:
	var farm := FileAccess.get_file_as_string("res://scripts/farm.gd")
	if not farm.contains("tree_oak.glb") or not farm.contains("tree_pineDefaultA.glb"):
		_fail("cc0_trees", "the disc trees are still the skyline")
		return
	if farm.contains("-10.0, 12.0"):
		_fail("cc0_trees", "the light poles are still a row")
		return
	_ok("cc0_trees")


func _sky_agx() -> void:
	var farm := FileAccess.get_file_as_string("res://scripts/farm.gd")
	if not farm.contains("TONE_MAPPER_AGX"):
		_fail("sky_agx", "the tonemap is not AgX")
		return
	if not farm.contains("fog_density = 0.0007"):
		_fail("sky_agx", "the haze is still thick")
		return
	if not farm.contains("kloofendal_48d_partly_cloudy_2k.hdr"):
		_fail("sky_agx", "the late-day sky is missing")
		return
	_ok("sky_agx")


func _scene_fade() -> void:
	var hud := FileAccess.get_file_as_string("res://scripts/hud.gd")
	if not hud.contains("scene_fade") or not hud.contains("SceneFade"):
		_fail("scene_fade", "scenes do not fade")
		return
	if not hud.contains("SceneCard"):
		_fail("scene_fade", "the course card is missing")
		return
	_ok("scene_fade")


func _result_count() -> void:
	var hud := FileAccess.get_file_as_string("res://scripts/hud.gd")
	if not hud.contains("result_count") or not hud.contains("Confetti"):
		_fail("result_count", "the result does not count up")
		return
	if not hud.contains("Rail down at fence"):
		_fail("result_count", "a rail is not named")
		return
	_ok("result_count")


func _hint_band() -> void:
	var hud := FileAccess.get_file_as_string("res://scripts/hud.gd")
	if not hud.contains("HintBand"):
		_fail("hint_band", "the footer has no band")
		return
	if not hud.contains("Left stick  steer"):
		_fail("hint_band", "the card ignores a controller")
		return
	_ok("hint_band")


func _scoreboard() -> void:
	var hud := FileAccess.get_file_as_string("res://scripts/hud.gd")
	if not hud.contains("FencePips") or not hud.contains("scoreboard_pips"):
		_fail("scoreboard", "the fence pips are missing")
		return
	if not hud.contains("time_allowed() - 10.0"):
		_fail("scoreboard", "the clock does not turn amber")
		return
	_ok("scoreboard")


func _reins_fade() -> void:
	var hud := FileAccess.get_file_as_string("res://scripts/hud.gd")
	if not hud.contains("reins_fade") or not hud.contains("_reins_gone"):
		_fail("reins_fade", "the card does not fade")
		return
	if not hud.contains("6.0"):
		_fail("reins_fade", "the card has no time limit")
		return
	if not hud.contains("reset_reins") or not hud.contains("PRESET_BOTTOM_LEFT"):
		_fail("reins_fade", "pause does not bring the card back")
		return
	_ok("reins_fade")


func _leave_grade() -> void:
	var horse := FileAccess.get_file_as_string("res://scripts/horse.gd")
	var hud := FileAccess.get_file_as_string("res://scripts/hud.gd")
	if not horse.contains("_show_leave_grade") or not hud.contains("func show_grade"):
		_fail("leave_grade", "the release grade is missing")
		return
	for word in ["Long spot", "Right on", "Deep", "Chip"]:
		if not hud.contains(word):
			_fail("leave_grade", "missing " + word)
			return
	_ok("leave_grade")


func _human_steer() -> void:
	var text := FileAccess.get_file_as_string("res://scripts/horse.gd")
	if not text.contains("human_ramp 4.0 / 3.0") or not text.contains("_gait_buf"):
		_fail("human_steer", "the person ramp or the gait buffer is missing")
		return
	_ok("human_steer")


func _ground_cycle() -> void:
	var text := FileAccess.get_file_as_string("res://scripts/horse.gd")
	if not text.contains("ground_cycle"):
		_fail("ground_cycle", "leg cycle is not tied to ground speed")
		return
	_ok("ground_cycle")


func _camera_follow() -> void:
	var horse := FileAccess.get_file_as_string("res://scripts/horse.gd")
	var walker := FileAccess.get_file_as_string("res://scripts/walker.gd")
	if not horse.contains("get_global_transform_interpolated()"):
		_fail("camera_follow", "ride camera still reads the raw physics tick")
		return
	if not walker.contains("get_global_transform_interpolated()"):
		_fail("camera_follow", "walk camera still reads the raw physics tick")
		return
	_ok("camera_follow")


func _telemetry_guard() -> void:
	var text := FileAccess.get_file_as_string("res://scripts/game_state.gd")
	if not text.contains("--telemetry"):
		_fail("telemetry_guard", "save() does not skip --telemetry")
		return
	if _telemetry_wanted_here():
		_fail("telemetry_guard", "selftest must not enable telemetry")
		return
	_ok("telemetry_guard")


func _telemetry_wanted_here() -> bool:
	for a in OS.get_cmdline_user_args():
		var arg := str(a)
		if arg == "--telemetry" or arg.begins_with("--telemetry"):
			return true
	return false


func _ok(name: String) -> void:
	_pass_n += 1
	print("SELFTEST PASS " + name)


func _fail(name: String, reason: String) -> void:
	_fail_n += 1
	print("SELFTEST FAIL " + name + ": " + reason)
