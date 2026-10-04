extends Node
class_name RideCert

## Headless ride certificate. Real rider, no teleport unit-test.
## --playtest stays the fast teleport check.

const RideAIScript := preload("res://scripts/ride_ai.gd")
## Pinned horse and rider. The save file drifts to 100/100/100 after a few
## hundred rounds, which quietly makes every later track easier — the cert
## has to mean the same thing on a fresh install as on Ernie's laptop.
## Confidence 85 is the one lift: it makes _might_look a flat p = 0.
const CONFIDENCE := 85.0
const SCOPE := 80.0
const RIDEABILITY := 44.0
const TIMING := 38.0
const FEEL := 36.0
## Day-one defaults from game_state.gd. Not the pin. --ridecert-fresh only.
const FRESH_CONFIDENCE := 48.0
const FRESH_SCOPE := 40.0
const FRESH_RIDEABILITY := 44.0
const FRESH_TIMING := 38.0
const FRESH_FEEL := 36.0
const POS_JUMP := 3.0

var horse: Horse
var course: Course
var arena: Node
var ai: RideAI
var report: Dictionary = {
	"tracks": [],
	"style": [],
	"extra": [],
	"pass": false,
	"flower_look": "abbott_confidence=85 so _might_look is false (p=0)",
}
var teleported: bool = false
var teleport_why: String = ""
var last_pos: Vector3 = Vector3.ZERO
var have_pos: bool = false
var skip_pos: int = 0
var refused_nums: Array = []
var was_jumping: bool = false
var max_speed: float = 0.0
var round_id: String = ""
var _trace_path: String = ""
var _trace_acc: float = 0.0
var _trace_buf: Array = []
var _last_rails: int = 0
var _fresh: bool = false
var _style_all: bool = false
var rail_fences: Array = []
var rail_in_air: Array = []


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	process_physics_priority = 100
	await get_tree().process_frame
	await get_tree().create_timer(0.35).timeout
	arena = get_parent()
	horse = arena.get_node_or_null("Abbott")
	course = arena.get_node_or_null("Course")
	if horse == null or course == null:
		_fail("missing horse or course")
		return
	ai = RideAIScript.new()
	ai.name = "RideAI"
	arena.add_child(ai)
	ai.bind(horse, course)
	if not horse.refused.is_connected(_on_refused):
		horse.refused.connect(_on_refused)
	if not horse.jumped.is_connected(_on_jumped):
		horse.jumped.connect(_on_jumped)
	if not horse.rail_down.is_connected(_on_rail):
		horse.rail_down.connect(_on_rail)
	print("RIDECERT begin")
	GameState.indoor = false
	_fresh = _has_arg("--ridecert-fresh")
	_style_all = _has_arg("--ridecert-style")
	_bind_horse()

	var only := _id_filter()
	var tracks: Array = _iter_tracks()
	if only != "":
		var filtered: Array = []
		for t in tracks:
			if str(t["id"]) == only:
				filtered.append(t)
		if filtered.is_empty():
			_fail("unknown --ridecert-id " + only)
			return
		tracks = filtered
		print("RIDECERT filter ", only)
	if only == "" and tracks.size() != 23:
		print("RIDECERT WARN expected 23 tracks, got ", tracks.size())
	var how_many: int = _refusals_arg()
	if how_many != 0:
		await _run_refusal_round(tracks, how_many)
		return
	if _style_all:
		await _run_style_all(tracks)
		return
	if _has_arg("--ridecert-jumpoff"):
		await _run_show_jumpoff(tracks)
		return
	var all_clear := true
	for t in tracks:
		var row: Dictionary = await _run_round(t, "clear", 0)
		report["tracks"].append(row)
		if not bool(row.get("success", false)):
			all_clear = false
			print("RIDECERT track FAIL ", row.get("id"), " ", row)

	if only != "" or _fresh:
		var finished := 0
		for row in report["tracks"]:
			if bool(row.get("round_complete", false)) and not bool(row.get("teleported", false)):
				finished += 1
		if _fresh:
			report["pass"] = finished == tracks.size()
			report["clears"] = finished
			report["board"] = "fresh %d/%d finished" % [finished, tracks.size()]
		else:
			report["pass"] = all_clear
			report["clears"] = 1 if all_clear else 0
			report["board"] = "%d/%d" % [int(report["clears"]), tracks.size()]
		report["fresh"] = _fresh
		_write()
		print("RIDECERT done pass=", report["pass"], " board=", report["board"], " filter=", only, " fresh=", _fresh)
		await get_tree().create_timer(0.2).timeout
		get_tree().quit(0 if report["pass"] else 1)
		return

	# Style on hk_beg_035 only.
	var beg := {"class_id": "beginner", "seed": 0, "jump_off": false, "id": "hk_beg_035"}
	var s_clear: Dictionary = await _run_round(beg, "clear", 0)
	s_clear["style"] = "A_clear"
	report["style"].append(s_clear)
	var s_ref: Dictionary = await _run_round(beg, "refuse_early", 1)
	s_ref["style"] = "B_refuse"
	report["style"].append(s_ref)
	var s_rail: Dictionary = await _run_round(beg, "rail_late", 3)
	s_rail["style"] = "C_rail"
	report["style"].append(s_rail)

	var style_ok := (
		bool(s_clear.get("success", false))
		and bool(s_ref.get("success", false))
		and bool(s_rail.get("success", false))
	)

	# Early-finish extras if the board is green: rail on the two rollbacks.
	if all_clear:
		var extra_specs: Array = [
			{"class_id": "intermediate", "seed": 1, "jump_off": false, "id": "hk_int_002"},
			{"class_id": "advanced", "seed": 2, "jump_off": false, "id": "hk_adv_003"},
		]
		for t in extra_specs:
			var c: Dictionary = await _run_round(t, "clear", 0)
			c["extra"] = "clear"
			report["extra"].append(c)
			var r: Dictionary = await _run_round(t, "rail_late", 3)
			r["extra"] = "rail"
			report["extra"].append(r)

	report["pass"] = all_clear and style_ok
	report["clears"] = 0
	for row in report["tracks"]:
		if bool(row.get("success", false)):
			report["clears"] = int(report["clears"]) + 1
	report["board"] = "%d/%d" % [int(report["clears"]), tracks.size()]
	_write()
	print(
		"RIDECERT done pass=",
		report["pass"],
		" board=",
		report["board"],
		" style=",
		style_ok
	)
	await get_tree().create_timer(0.25).timeout
	get_tree().quit(0 if report["pass"] else 1)


func _pin_stats() -> void:
	GameState.abbott_confidence = CONFIDENCE
	GameState.abbott_scope = SCOPE
	GameState.abbott_rideability = RIDEABILITY
	GameState.madison_timing = TIMING
	GameState.madison_feel = FEEL


func _day_one() -> void:
	GameState.abbott_confidence = FRESH_CONFIDENCE
	GameState.abbott_scope = FRESH_SCOPE
	GameState.abbott_rideability = FRESH_RIDEABILITY
	GameState.madison_timing = FRESH_TIMING
	GameState.madison_feel = FRESH_FEEL


func _bind_horse() -> void:
	if _fresh:
		_day_one()
	else:
		_pin_stats()


func _has_arg(flag: String) -> bool:
	for a in OS.get_cmdline_user_args():
		if str(a) == flag:
			return true
	return false


func _run_show_jumpoff(tracks: Array) -> void:
	if _id_filter() == "" or tracks.size() != 1:
		_fail("jumpoff needs one --ridecert-id")
		return
	var spec: Dictionary = tracks[0] as Dictionary
	_pin_stats()
	var wall_first: float = 30.0 * 60.0
	var first: Dictionary = await _run_round(spec, "clear", 0, wall_first)
	report["tracks"].append(first)
	var offered: bool = GameState.can_offer_jump_off()
	print("RIDECERT offer ", offered)
	print("RIDECERT done round=first offer=", offered)
	if not offered:
		report["pass"] = true
		report["board"] = "first"
		_write()
		await get_tree().create_timer(0.2).timeout
		get_tree().quit(0)
		return
	if not GameState.begin_jump_off():
		_fail("begin_jump_off refused")
		return
	if horse:
		horse.jumping = false
		horse.jump_fence = null
	if course:
		course.build(false, GameState.course_seed)
	_place_at_start()
	var second_spec: Dictionary = {
		"class_id": spec["class_id"],
		"seed": spec["seed"],
		"jump_off": true,
		"id": spec["id"],
	}
	var wall_second: float = 30.0 * 60.0
	var second: Dictionary = await _run_round(second_spec, "clear", 0, wall_second)
	report["extra"].append(second)
	var needed: int = int(second.get("fences_needed", 0))
	print("RIDECERT jumpoff fences_needed=", needed)
	print("RIDECERT done round=jumpoff")
	report["pass"] = true
	report["board"] = "jumpoff"
	_write()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit(0)


func _place_at_start() -> void:
	if horse == null or course == null:
		return
	horse.global_position = course.start_pos
	horse.rotation = Vector3(0.0, course.start_yaw, 0.0)
	horse.velocity = Vector3.ZERO
	horse.speed = 0.0
	horse.gait = 0
	horse.jumping = false
	horse.jump_fence = null
	horse.refuse_cool = 0.0
	horse.land_recover = 0.0
	horse.set_mounted(true)
	horse.controllable = true
	if horse.cam:
		horse.cam.current = true


func _run_style_all(tracks: Array) -> void:
	_pin_stats()
	for t in tracks:
		var jo := bool(t["jump_off"])
		var need := 4 if jo else int(GameState.CLASS_INFO[str(t["class_id"])]["need"])
		var late := need if need < 3 else 3
		var b: Dictionary = await _run_round(t, "refuse_early", 1)
		b["style_fence"] = 1
		report["style"].append(b)
		var c: Dictionary = await _run_round(t, "rail_late", late)
		c["style_fence"] = late
		report["style"].append(c)
	report["pass"] = true
	report["board"] = "style %d" % tracks.size()
	_write()
	print("RIDECERT done pass=true board=", report["board"], " style_all=true")
	await get_tree().create_timer(0.2).timeout
	get_tree().quit(0)


func _iter_tracks() -> Array:
	var ship: Dictionary = ContentLibrary.load_ship()
	var out: Array = []
	for cid in ["lesson", "beginner", "intermediate", "advanced"]:
		var arr: Variant = ship.get(cid, [])
		if typeof(arr) != TYPE_ARRAY:
			continue
		var i := 0
		for id in arr:
			out.append({
				"class_id": cid,
				"seed": i,
				"jump_off": false,
				"id": str(id),
			})
			i += 1
	var jo: Variant = ship.get("jump_off", {})
	if typeof(jo) == TYPE_DICTIONARY:
		for cid in (jo as Dictionary).keys():
			out.append({
				"class_id": str(cid),
				"seed": 0,
				"jump_off": true,
				"id": str((jo as Dictionary)[cid]),
			})
	return out


func _id_filter() -> String:
	var args := OS.get_cmdline_user_args()
	for i in range(args.size()):
		var a := str(args[i])
		if a.begins_with("--ridecert-id="):
			return a.substr("--ridecert-id=".length())
		if a == "--ridecert-id" and i + 1 < args.size():
			return str(args[i + 1])
	return ""


func _run_round(spec: Dictionary, style: String, style_fence: int, wall_cap: float = -1.0) -> Dictionary:
	var id := str(spec["id"])
	round_id = id
	print(
		"RIDECERT round ",
		id,
		" class=",
		spec["class_id"],
		" seed=",
		spec["seed"],
		" jo=",
		spec["jump_off"],
		" style=",
		style
	)
	_setup(spec)
	await get_tree().process_frame
	await get_tree().physics_frame
	ai.style = style
	ai.style_fence = style_fence
	ai.reset_brain()
	ai.enabled = true
	teleported = false
	teleport_why = ""
	refused_nums = []
	rail_fences = []
	rail_in_air = []
	was_jumping = horse.jumping
	max_speed = 0.0
	skip_pos = 2
	have_pos = false
	_trace_begin(id, style)
	_last_rails = 0

	# Clear rounds keep _time_cap. A refusal round circles, so the new path
	# passes a longer wall cap. Old callers leave wall_cap at -1.
	var limit: float = _time_cap(str(spec["class_id"]), bool(spec["jump_off"]))
	if wall_cap > 0.0:
		limit = wall_cap
	var t0 := Time.get_ticks_msec()
	while not GameState.round_complete and not GameState.eliminated:
		await get_tree().process_frame
		if Time.get_ticks_msec() - t0 > int(limit * 1000.0):
			print("RIDECERT timeout ", id, " t=", GameState.format_official(GameState.time_sec))
			break
		if teleported:
			print("RIDECERT teleport ", id, " ", teleport_why)
			break

	ai.enabled = false
	ai._release_all()
	_trace_flush()
	var time_sec := GameState.last_time if GameState.round_complete else GameState.official_time(GameState.time_sec)
	var shown := GameState.official_text() if GameState.round_complete else GameState.format_official(GameState.time_sec)
	var faults := GameState.last_faults if GameState.round_complete else GameState.faults
	var needed := GameState.fences_needed()
	var jumped := GameState.fences_jumped
	# Body knocks never emit rail_down. The signal path can also name next_fence.
	# rail_nums is one entry per knock, the fence that fell.
	rail_fences = GameState.rail_nums.duplicate()
	var row := {
		"id": id,
		"class_id": spec["class_id"],
		"jump_off": spec["jump_off"],
		"style": style,
		"fences_needed": needed,
		"fences_jumped": jumped,
		"faults": faults,
		"time_sec": time_sec,
		"refused": refused_nums.duplicate(),
		"rails": GameState.rails_this_round,
		"rail_fences": rail_fences.duplicate(),
		"rail_in_air": rail_in_air.duplicate(),
		"confidence": GameState.abbott_confidence,
		"scope": GameState.abbott_scope,
		"teleported": teleported,
		"teleport_why": teleport_why,
		"max_speed": snapped(maxf(max_speed, ai.max_speed), 0.01),
		"inputs_pressed": ai.counts.duplicate(),
		"round_complete": GameState.round_complete,
		"eliminated": GameState.eliminated,
		"eliminate_reason": GameState.eliminate_reason,
		"loaded_id": _loaded_id(spec),
	}
	row["success"] = _success(row, style, needed)
	print(
		"RIDECERT ",
		id,
		" style=",
		style,
		" success=",
		row["success"],
		" faults=",
		faults,
		" refusal_faults=",
		_priced_refusals(),
		" rail_faults=",
		GameState.rails_this_round * 4,
		" time_faults=",
		GameState.time_faults,
		" jumped=",
		jumped,
		"/",
		needed,
		" t=",
		shown,
		" teleported=",
		teleported,
		" complete=",
		GameState.round_complete,
		" refused=",
		refused_nums,
		" rail_fences=",
		rail_fences,
		" rail_air=",
		rail_in_air,
		" conf=",
		snapped(GameState.abbott_confidence, 0.1),
		" scope=",
		snapped(GameState.abbott_scope, 0.1),
		" eliminated=",
		GameState.eliminated,
		" reason=",
		GameState.eliminate_reason,
		" ribbon=",
		GameState.last_ribbon
	)
	if GameState.round_complete:
		print("RIDECERT result ", GameState.result_line())
	return row


func _loaded_id(spec: Dictionary) -> String:
	var lib: Dictionary = ContentLibrary.ship_course(
		str(spec["class_id"]),
		bool(spec["jump_off"]),
		int(spec["seed"]),
		false
	)
	return str(lib.get("id", ""))


func _priced_refusals() -> int:
	# The sum note_refuse added. Show is 4, then 12. The third adds nothing.
	# Schooling and a lesson are 4 times the count. The adds stay in note_refuse.
	var n: int = GameState.refusals_this_round
	if GameState.is_show():
		if n <= 0:
			return 0
		if n == 1:
			return 4
		return 12
	return n * 4


func _refusals_arg() -> int:
	var prefix: String = "--ridecert-refusals="
	for a in OS.get_cmdline_user_args():
		var s: String = str(a)
		if s.begins_with(prefix):
			var tail: String = s.substr(prefix.length())
			if tail.is_valid_int():
				return int(tail)
			return -1
	return 0


func _run_refusal_round(tracks: Array, how_many: int) -> void:
	if how_many != 2 and how_many != 3:
		_fail("ridecert-refusals wants 2 or 3")
		return
	if _id_filter() == "" or tracks.size() != 1:
		_fail("ridecert-refusals needs one --ridecert-id")
		return
	var style_name: String = "refuse_twice"
	if how_many == 3:
		style_name = "refuse_three"
	_pin_stats()
	var spec: Dictionary = tracks[0] as Dictionary
	var wall: float = 3600.0
	var row: Dictionary = await _run_round(spec, style_name, 1, wall)
	report["style"].append(row)
	report["pass"] = true
	report["board"] = style_name
	_write()
	print("RIDECERT done pass=true board=", report["board"], " refusals=", how_many)
	await get_tree().create_timer(0.2).timeout
	get_tree().quit(0)


func _success(row: Dictionary, style: String, needed: int) -> bool:
	if bool(row["teleported"]):
		return false
	if str(row.get("loaded_id", "")) != str(row.get("id", "")):
		return false
	if not bool(row["round_complete"]):
		return false
	if bool(row["eliminated"]):
		return false
	var t := float(row["time_sec"])
	if style == "clear":
		if int(row["faults"]) != 0:
			return false
		if needed >= 8 and t <= 20.0:
			return false
		if needed < 8 and t <= 8.0:
			return false
		return int(row["fences_jumped"]) >= needed
	if style == "refuse_early":
		return int(row["faults"]) == 4 and (row["refused"] as Array).size() > 0
	if style == "rail_late":
		return int(row["faults"]) == 4 and int(row["rails"]) >= 1
	return false


func _time_cap(cid: String, jo: bool) -> float:
	# Wall seconds. Headless sim is faster than wall, but farm+Jolt still costs.
	if jo:
		return 90.0
	match cid:
		"lesson":
			return 70.0
		"beginner":
			return 110.0
		"intermediate":
			return 130.0
		_:
			return 150.0


func _setup(spec: Dictionary) -> void:
	ai.enabled = false
	ai._release_all()
	var cid := str(spec["class_id"])
	var jo := bool(spec["jump_off"])
	GameState.indoor = false
	GameState.class_id = cid
	GameState.course_seed = int(spec["seed"])
	GameState.jump_off = jo
	if cid == "lesson":
		GameState.session_kind = "lesson"
	elif _has_arg("--ridecert-show"):
		GameState.session_kind = "show"
	else:
		GameState.session_kind = "schooling"
	_bind_horse()
	GameState.set_mode("ride")
	if horse:
		horse.jumping = false
		horse.jump_fence = null
		horse.charge = 0.0
		horse.charging = false
		horse.collecting = false
	if course:
		course.build(false, GameState.course_seed)
	GameState.reset_round(jo)
	GameState.jump_off = jo
	_bind_horse()
	GameState.set_mode("ride")
	if horse and course:
		# Single allowed reset — start of a round only.
		horse.global_position = course.start_pos
		horse.rotation = Vector3(0.0, course.start_yaw, 0.0)
		horse.velocity = Vector3.ZERO
		horse.speed = 0.0
		horse.gait = 0
		horse.jumping = false
		horse.jump_fence = null
		horse.refuse_cool = 0.0
		horse.land_recover = 0.0
		horse.set_mounted(true)
		horse.controllable = true
		if horse.cam:
			horse.cam.current = true
	have_pos = false
	skip_pos = 2
	last_pos = Vector3.ZERO


func _physics_process(_delta: float) -> void:
	if horse == null or not is_instance_valid(horse):
		return
	if not ai or not ai.enabled:
		have_pos = false
		return
	max_speed = maxf(max_speed, horse.speed)
	if GameState.rails_this_round != _last_rails:
		print(
			"RIDECERT rail now=", GameState.rails_this_round,
			" next=", GameState.next_fence,
			" jumping=", horse.jumping,
			" phase=", ai.phase if ai else "",
			" pos=", snapped(horse.global_position.x, 0.1), ",", snapped(horse.global_position.z, 0.1)
		)
		_last_rails = GameState.rails_this_round
	_trace_acc += _delta
	if _trace_acc >= 1.0:
		_trace_acc = 0.0
		_trace_tick()
	var p: Vector3 = horse.global_position
	if skip_pos > 0:
		skip_pos -= 1
		last_pos = p
		have_pos = true
		was_jumping = horse.jumping
		return
	if have_pos:
		var d: float = p.distance_to(last_pos)
		if d > POS_JUMP:
			teleported = true
			teleport_why = "pos_jump %.2f m on %s" % [d, round_id]
	last_pos = p
	have_pos = true
	if horse.jumping and not was_jumping:
		if ai == null or not ai.released_jump_this_frame:
			teleported = true
			teleport_why = "jump without Space release on %s" % round_id
	was_jumping = horse.jumping


func _on_refused() -> void:
	refused_nums.append(GameState.next_fence)
	print("RIDECERT refuse fence=", GameState.next_fence, " why=", GameState.last_leave)


func _on_jumped() -> void:
	pass


func _on_rail() -> void:
	var n := GameState.next_fence
	var air := horse != null and horse.jumping
	rail_fences.append(n)
	rail_in_air.append(air)
	print("RIDECERT rail fence=", n, " air=", air)


func _trace_begin(id: String, style: String) -> void:
	_trace_buf = []
	_trace_acc = 0.0
	var dir := _out_dir().path_join("traces")
	DirAccess.make_dir_recursive_absolute(dir)
	_trace_path = dir.path_join("%s_%s.jsonl" % [id, style])


func _trace_tick() -> void:
	if horse == null or ai == null:
		return
	var g: Dictionary = ai.dbg
	var row := {
		"t": snapped(GameState.time_sec, 0.01),
		"x": snapped(horse.global_position.x, 0.01),
		"z": snapped(horse.global_position.z, 0.01),
		"yaw": snapped(horse.rotation.y, 0.01),
		"gait": horse.gait,
		"next": GameState.next_fence,
		"ahead": snapped(float(g.get("ahead", 0.0)), 0.01),
		"lat": snapped(float(g.get("on_line", g.get("lat", 0.0))), 0.01),
		"ang": snapped(float(g.get("ang", 0.0)), 0.1),
		"charge": snapped(float(g.get("charge", horse.charge)), 0.02),
		"leave": str(g.get("leave", GameState.last_leave)),
		"phase": str(g.get("phase", ai.phase)),
	}
	_trace_buf.append(row)


func _trace_flush() -> void:
	if _trace_path == "":
		return
	var f := FileAccess.open(_trace_path, FileAccess.WRITE)
	if f == null:
		return
	for row in _trace_buf:
		f.store_line(JSON.stringify(row))
	f.close()
	print("RIDECERT trace ", _trace_path, " n=", _trace_buf.size())


func _out_dir() -> String:
	var exe := OS.get_executable_path()
	var dir := exe.get_base_dir()
	var leaf := exe.get_file().to_lower()
	if dir == "" or leaf.begins_with("godot") or dir.contains("WinGet"):
		dir = ProjectSettings.globalize_path("res://").path_join("..").path_join("dist")
	return dir


func _write() -> void:
	var dir := _out_dir()
	DirAccess.make_dir_recursive_absolute(dir)
	var leaf := "ridecert_results.json"
	if _fresh:
		leaf = "ridecert_fresh_one.json" if _id_filter() != "" else "ridecert_fresh.json"
	elif _style_all:
		leaf = "ridecert_style.json"
	var path := dir.path_join(leaf)
	var f := FileAccess.open(path, FileAccess.WRITE)
	if f:
		f.store_string(JSON.stringify(report, "\t"))
		f.close()
		print("RIDECERT wrote ", path)
	var uf := FileAccess.open("user://ridecert_results.json", FileAccess.WRITE)
	if uf:
		uf.store_string(JSON.stringify(report, "\t"))
		uf.close()


func _fail(msg: String) -> void:
	report["pass"] = false
	report["error"] = msg
	_write()
	print("RIDECERT FAIL ", msg)
	get_tree().quit(1)
