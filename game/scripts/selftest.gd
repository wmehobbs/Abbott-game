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
	await _layout()
	await _gamepad()
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
