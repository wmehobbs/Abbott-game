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
		var res: Resource = load("res://scripts/" + fn)
		if res == null:
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
