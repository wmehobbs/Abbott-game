extends Node

const SAVE_PATH := "user://abbott_save.json"
const SAVE_VERSION := 1
const TrainerLines := preload("res://scripts/trainer.gd")

var indoor: bool = false
var mode: String = "title"
var faults: int = 0
var time_sec: float = 0.0
var clock_running: bool = false
var round_complete: bool = false
var best_faults: int = 999
var best_time: float = 9999.0
var last_faults: int = 0
var last_time: float = 0.0
var official_cents: int = -1
var course_seed: int = 1
var start_crossed: bool = false
var fences_jumped: int = 0
var next_fence: int = 1
var time_faults_applied: bool = false
var time_faults: int = 0
var refusals_this_round: int = 0
var rails_this_round: int = 0
var rail_nums: Array[int] = []
var refuse_nums: Array[int] = []
var ui_paused: bool = false
var last_ribbon: String = ""
var eliminated: bool = false
var eliminate_reason: String = ""
var trainer_line: String = ""
var trainer_until: float = 0.0
var last_leave: String = ""
## Shown once on the glass when a fault is added. The numbers stay in note_rail and note_refuse.
var fault_callout: String = ""
var fault_callout_id: int = 0
var lesson_done: bool = false
## Fresh saves walk the first lesson. A save that already has progress skips it.
var tutorial_done: bool = false
var jump_off: bool = false
## Title "Watch a round". Not the player's horse. Cert flags still win in save().
var demo_ride: bool = false

## lesson | schooling | show
var session_kind: String = "schooling"
## lesson | beginner | intermediate | advanced
var class_id: String = "beginner"

var abbott_confidence: float = 48.0
var abbott_scope: float = 40.0
var abbott_rideability: float = 44.0
var madison_timing: float = 38.0
var madison_feel: float = 36.0
var rounds_posted: Dictionary = {"lesson": 0, "beginner": 0, "intermediate": 0, "advanced": 0}
var clears: Dictionary = {"lesson": 0, "beginner": 0, "intermediate": 0, "advanced": 0}
var best_by_class: Dictionary = {}
var show_best: Dictionary = {}
var show_ribbons: Array = []

signal round_finished(faults: int, time_sec: float)
signal faults_changed(faults: int)
signal mode_changed(mode: String)
signal bindings_changed

const CLASS_INFO := {
	"lesson": {
		"name": "Lesson",
		"show_name": "Lesson",
		"height": "poles to 2'3\"",
		"time_school": 180.0,
		"time_show": 180.0,
		"need": 3,
	},
	"beginner": {
		"name": "Crossrails",
		"show_name": "Welcome Stake",
		"height": "2'3\"",
		"time_school": 100.0,
		"time_show": 95.0,
		"need": 8,
	},
	"intermediate": {
		"name": "Schooling Jumpers",
		"show_name": "Classic",
		"height": "2'6\"",
		"time_school": 90.0,
		"time_show": 85.0,
		"need": 10,
	},
	"advanced": {
		"name": "Open Jumpers",
		"show_name": "Hidden K Mini Prix",
		"height": "3'0\"",
		"time_school": 80.0,
		"time_show": 75.0,
		"need": 12,
	},
}

const DEFAULT_BINDINGS := {
	"gait_up": [KEY_W, KEY_UP],
	"gait_down": [KEY_S, KEY_DOWN],
	"turn_left": [KEY_A, KEY_LEFT],
	"turn_right": [KEY_D, KEY_RIGHT],
	"halt": [KEY_SHIFT],
	"jump": [KEY_SPACE],
	"walk_mode": [KEY_C],
	"mount": [KEY_ENTER],
	"pause": [KEY_ESCAPE],
}

var bindings: Dictionary = {}
## "key" or "pad". Prompts name the buttons for the last device she used.
var last_device: String = "key"
## Volumes and picture. Not the ride save. Certs and tests leave the defaults in place.
var settings: PlayerSettings


func _ready() -> void:
	settings = PlayerSettings.new()
	settings.name = "Settings"
	add_child(settings)
	if _skip_save_reason() == "":
		settings.load_from()
		settings.apply_audio()
	bindings = DEFAULT_BINDINGS.duplicate(true)
	load_save()
	_bind_input()
	randomize()


var _duck: float = 0.0
## Test seam. Off in play. When true, the mix ducks as if a voice line is playing.
var voice_hold: bool = false


func tick(delta: float) -> void:
	_mix_voice(delta)
	if trainer_until > 0.0:
		trainer_until -= delta
		if trainer_until <= 0.0:
			trainer_line = ""
	if clock_running and not eliminated and not round_complete:
		if session_kind == "show" and time_sec > time_limit():
			eliminate("time")


func info() -> Dictionary:
	return CLASS_INFO.get(class_id, CLASS_INFO["beginner"])


func class_title() -> String:
	var i: Dictionary = info()
	if jump_off:
		return "Jump-off  ·  Table A  ·  %s" % i.height
	if session_kind == "lesson":
		return "Lesson  ·  Hidden K  ·  %s" % i.height
	if session_kind == "show":
		return "%s  ·  Table A  ·  %s" % [i.show_name, i.height]
	return "Schooling  ·  %s  ·  %s" % [i.name, i.height]


func next_fence_line() -> String:
	if round_complete or mode != "ride":
		return ""
	var kind := ""
	var h := 0.6
	var sp := 0.0
	var tree := Engine.get_main_loop() as SceneTree
	if tree:
		for n in tree.get_nodes_in_group("fences"):
			if n is JumpFence and is_instance_valid(n) and (n as JumpFence).number == next_fence:
				var jf: JumpFence = n
				kind = jf.kind
				h = jf.height
				sp = jf.spread
				break
	var label := ContentLibrary.fence_name(kind, h, sp)
	if label == "" or kind == "":
		if kind == "oxer":
			label = "oxer"
		elif kind == "flower":
			label = "flower"
		elif kind == "":
			label = ""
		else:
			label = "vertical"
	if next_fence > fences_needed():
		return "Ride through the finish"
	var place := "Fence %d of %d" % [next_fence, fences_needed()]
	if jump_off:
		place = "Jump-off  ·  %s" % place
	if label == "":
		return place
	return "%s  ·  %s" % [place, label]


func time_allowed() -> float:
	var i: Dictionary = info()
	var t := float(i.time_show if session_kind == "show" else i.time_school)
	if jump_off:
		return maxf(28.0, t * 0.42)
	return t


func time_limit() -> float:
	return time_allowed() * 2.0


func fences_needed() -> int:
	if jump_off:
		return 4
	return int(info().need)


func can_offer_jump_off() -> bool:
	return (
		session_kind == "show"
		and not jump_off
		and not eliminated
		and last_faults == 0
		and time_faults == 0
		and last_time <= float(info().time_show) + 0.05
	)


func begin_jump_off() -> bool:
	if not can_offer_jump_off():
		return false
	jump_off = true
	reset_round(true)
	speak("jump_off")
	return true


func is_show() -> bool:
	return session_kind == "show"


func class_unlocked(id: String) -> bool:
	if id == "lesson" or id == "beginner":
		return true
	if id == "intermediate":
		return int(rounds_posted.get("beginner", 0)) > 0
	if id == "advanced":
		if session_kind == "show":
			return int(clears.get("intermediate", 0)) > 0
		return int(rounds_posted.get("intermediate", 0)) > 0
	return false


func window_scale() -> float:
	match class_id:
		"lesson":
			return 1.24
		"beginner":
			return 1.16
		"advanced":
			return 0.88
		_:
			return 1.0


func refuse_scale() -> float:
	return 1.0 + clampf(abbott_confidence, 0.0, 100.0) / 180.0


func scope_bonus() -> float:
	return clampf(abbott_scope, 0.0, 100.0) * 0.0024


func turn_scale() -> float:
	return 0.88 + clampf(abbott_rideability, 0.0, 100.0) / 400.0


func balance_need() -> float:
	var n := 0.18
	if class_id == "lesson" or class_id == "beginner":
		n = 0.12
	elif class_id == "advanced":
		n = 0.24
	n -= clampf(madison_feel, 0.0, 100.0) * 0.0005
	return clampf(n, 0.08, 0.28)


func charge_need() -> float:
	return balance_need()


func speak(kind: String) -> void:
	last_leave = kind
	var line := TrainerLines.phrase(kind)
	if line == "":
		return
	trainer_line = line
	trainer_until = 3.8
	if session_kind == "lesson":
		print("MICHELLE ", kind, " | ", line)


func _stride_line(line: String) -> bool:
	if line.begins_with("Two. ") or line.begins_with("One. "):
		return true
	return line == "Wait." or line == "Early." or line == "Now." or line == "Too deep."


func speak_soft(line: String) -> bool:
	if line == "":
		return false
	# A stride word may talk over the leave sentence. The 3.8 s hold stays,
	# and last_leave stays. Walk lines still yield.
	var over := trainer_until > 1.4 and last_leave != ""
	if over and not _stride_line(line) and line != "Come again.":
		return false
	trainer_line = line
	if not over:
		trainer_until = 1.25
	print("MICHELLE soft | ", line)
	return true


func barn_note() -> String:
	var lib := ContentLibrary.barn_note(session_kind, abbott_confidence, abbott_rideability, madison_timing)
	if lib != "":
		return lib
	if session_kind == "lesson" or not lesson_done:
		return "Lesson first. Walk him, pick up the canter, and wait for the last stride."
	if abbott_confidence < 30.0:
		return "Abbott is looky. Walk him, then a quiet canter. Don't chase the fences."
	if abbott_confidence < 50.0:
		return "He's a little fresh. Make the last canter stride, then ask."
	if abbott_rideability > 70.0 and abbott_confidence > 65.0:
		return "He's with you. Don't over-ride him — let him jump."
	if madison_timing < 40.0:
		return "Half-halt to the last stride, then let him go. He'll tell you."
	return "Quiet day at Hidden K. School what you need, or go in the show."


func _bind_input() -> void:
	for action in DEFAULT_BINDINGS.keys():
		if not InputMap.has_action(action):
			InputMap.add_action(action)
		InputMap.action_erase_events(action)
		for k in bindings.get(action, DEFAULT_BINDINGS[action]):
			var ev := InputEventKey.new()
			ev.physical_keycode = int(k)
			InputMap.action_add_event(action, ev)
	_axis("look_x")
	_axis("look_y")
	_axis("steer")
	_pad("jump", JOY_BUTTON_A)
	_pad("halt", JOY_BUTTON_B)
	_pad("pause", JOY_BUTTON_START)
	_pad("mount", JOY_BUTTON_X)
	_pad("walk_mode", JOY_BUTTON_Y)
	_pad("gait_up", JOY_BUTTON_DPAD_UP)
	_pad("gait_down", JOY_BUTTON_DPAD_DOWN)
	_pad("turn_left", JOY_BUTTON_DPAD_LEFT)
	_pad("turn_right", JOY_BUTTON_DPAD_RIGHT)
	_pad_axis("steer", JOY_AXIS_LEFT_X)
	_pad_axis("gait_stick", JOY_AXIS_LEFT_Y)
	_pad_axis("look_x", JOY_AXIS_RIGHT_X)
	_pad_axis("look_y", JOY_AXIS_RIGHT_Y)
	bindings_changed.emit()


func _axis(name: String) -> void:
	if not InputMap.has_action(name):
		InputMap.add_action(name)


func _pad(action: String, button: int) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)
	var ev := InputEventJoypadButton.new()
	ev.button_index = button
	if not InputMap.action_has_event(action, ev):
		InputMap.action_add_event(action, ev)


func _pad_axis(action: String, axis: int) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)
	var ev := InputEventJoypadMotion.new()
	ev.axis = axis
	if not InputMap.action_has_event(action, ev):
		InputMap.action_add_event(action, ev)
	InputMap.action_set_deadzone(action, 0.25)


func _mix_voice(delta: float) -> void:
	var voice := voice_hold
	var tree := get_tree()
	if tree:
		for n in tree.get_nodes_in_group("voice"):
			if n is AudioStreamPlayer and (n as AudioStreamPlayer).playing:
				voice = true
			elif n is AudioStreamPlayer3D and (n as AudioStreamPlayer3D).playing:
				voice = true
	var target := 1.0 if voice else 0.0
	_duck = move_toward(_duck, target, delta / 0.12)
	var drop := -6.0 * _duck
	var music_base := 0.0
	var amb_base := 0.0
	if settings:
		music_base = settings.music_db
		amb_base = settings.ambience_db
	_set_mix_bus("Music", music_base + drop)
	_set_mix_bus("Ambience", amb_base + drop)


func _set_mix_bus(bus_name: String, db: float) -> void:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx >= 0:
		AudioServer.set_bus_volume_db(idx, db)


func control_line() -> String:
	if last_device == "pad":
		return "D-pad up/down gait   Left stick steers   Hold A to collect, release at the canter to ask   B halt   Y walk   Start pause"
	return "W/S gait   A/D steer   Hold Space to collect, release at the canter to ask   Shift halt   C walk   Esc pause"


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		# F11 or Alt+Enter: full screen and back, remembered in settings.cfg.
		var k := event as InputEventKey
		if k.physical_keycode == KEY_F11 or (k.physical_keycode == KEY_ENTER and k.alt_pressed):
			_toggle_fullscreen()
			get_viewport().set_input_as_handled()
			return
	if event is InputEventKey and event.pressed:
		last_device = "key"
	elif event is InputEventJoypadButton and event.pressed:
		last_device = "pad"
	elif event is InputEventJoypadMotion and absf(event.axis_value) > 0.25:
		last_device = "pad"


func _toggle_fullscreen() -> void:
	if settings == null or DisplayServer.get_name() == "headless":
		return
	settings.fullscreen = not settings.fullscreen
	settings.apply_display()
	if _skip_save_reason() == "":
		settings.save_to()


func rebind(action: String, keycode: int) -> void:
	if not DEFAULT_BINDINGS.has(action):
		return
	bindings[action] = [keycode]
	_bind_input()
	save()


func reset_round(keep_jump_off: bool = false) -> void:
	if not keep_jump_off:
		jump_off = false
	faults = 0
	time_sec = 0.0
	clock_running = false
	round_complete = false
	start_crossed = false
	fences_jumped = 0
	next_fence = 1
	time_faults_applied = false
	time_faults = 0
	refusals_this_round = 0
	rails_this_round = 0
	rail_nums.clear()
	refuse_nums.clear()
	last_ribbon = ""
	official_cents = -1
	eliminated = false
	eliminate_reason = ""
	trainer_line = ""
	trainer_until = 0.0
	last_leave = ""
	faults_changed.emit(0)


func start_clock() -> void:
	if round_complete or eliminated:
		return
	if start_crossed:
		return
	start_crossed = true
	clock_running = true


func _callout(line: String) -> void:
	fault_callout = line
	fault_callout_id += 1


func add_faults(n: int) -> void:
	if round_complete or eliminated:
		return
	faults += n
	faults_changed.emit(faults)


func note_jumped(num: int) -> void:
	if eliminated or round_complete:
		return
	if num != next_fence:
		if is_show():
			eliminate("off_course")
		else:
			speak("wrong")
		return
	fences_jumped += 1
	next_fence += 1


func note_refuse() -> void:
	if eliminated or round_complete:
		return
	refusals_this_round += 1
	refuse_nums.append(next_fence)
	if is_show():
		if refusals_this_round == 1:
			_callout("Refusal  ·  4 faults")
			add_faults(4)
		elif refusals_this_round == 2:
			_callout("Second refusal  ·  8 faults")
			add_faults(8)
		else:
			_callout("Eliminated  ·  three refusals")
			eliminate("three")
			return
	else:
		_callout("Refusal  ·  4 faults")
		add_faults(4)
	if last_leave == "" or last_leave == "refuse":
		speak("refuse")


func note_rail(fence_number: int) -> void:
	if eliminated or round_complete:
		return
	rails_this_round += 1
	rail_nums.append(fence_number)
	_callout("Rail  ·  4 faults")
	add_faults(4)
	if last_leave != "chip" and last_leave != "deep":
		speak("rail")


func eliminate(reason: String) -> void:
	if eliminated or round_complete:
		return
	eliminated = true
	eliminate_reason = reason
	speak(reason)
	finish_round()


func can_finish() -> bool:
	if eliminated:
		return false
	if not start_crossed:
		return false
	return next_fence > fences_needed()


func official_time(t: float) -> float:
	return float(floor(t * 100.0)) / 100.0


func format_official(t: float) -> String:
	var n: int = int(float(floor(t * 100.0)))
	if n < 0:
		n = 0
	return "%d.%02d" % [int(n / 100), n % 100]


func official_text() -> String:
	if official_cents < 0:
		return format_official(last_time)
	return "%d.%02d" % [int(official_cents / 100), official_cents % 100]


func finish_round() -> void:
	if round_complete:
		return
	var cents_f: float = float(floor(time_sec * 100.0))
	official_cents = int(cents_f)
	if official_cents < 0:
		official_cents = 0
	var official: float = cents_f / 100.0
	if not time_faults_applied and not eliminated and session_kind != "lesson":
		if official > time_allowed():
			var extra := int(floor((official - time_allowed()) / 4.0))
			time_faults = extra
			if extra > 0:
				add_faults(extra)
		time_faults_applied = true
	round_complete = true
	clock_running = false
	time_sec = official
	last_faults = faults
	last_time = official
	# A watched round shows the result and can offer. It does not school the horse
	# or move the card. Cert flags are not a demo; demo_ride stays false there.
	if not demo_ride:
		if session_kind == "lesson" and not eliminated:
			lesson_done = true
		# A lesson round done: the next lesson start is the next lesson on the card.
		# Only lessons move it. A cert sets its own seed from the spec before it builds.
		if session_kind == "lesson":
			course_seed += 1
		_school_from_round()
		_record_round()
	save()
	round_finished.emit(faults, official)
	mode = "results"
	mode_changed.emit(mode)
	if not eliminated and last_faults == 0:
		speak("clear")
	elif session_kind == "show" and last_ribbon != "":
		speak("ribbon")


func _school_from_round() -> void:
	var c := abbott_confidence
	var sc := abbott_scope
	var r := abbott_rideability
	var t := madison_timing
	var f := madison_feel
	if eliminated:
		c -= 3.0
		r -= 1.0
	elif last_faults == 0:
		c += 6.0
		sc += 3.0
		r += 4.0
		t += 4.0
		f += 3.0
	elif last_faults <= 4:
		c += 1.5
		sc += 1.0
		r += 1.5
		t += 2.0
		f += 1.0
	else:
		c -= 2.0
		t += 0.5
	c -= float(refusals_this_round) * 3.5
	r -= float(refusals_this_round) * 1.5
	if rails_this_round == 0 and last_faults <= 4 and not eliminated:
		sc += 1.5
	abbott_confidence = clampf(c, 5.0, 100.0)
	abbott_scope = clampf(sc, 5.0, 100.0)
	abbott_rideability = clampf(r, 5.0, 100.0)
	madison_timing = clampf(t, 5.0, 100.0)
	madison_feel = clampf(f, 5.0, 100.0)


func _record_round() -> void:
	var id := class_id
	rounds_posted[id] = int(rounds_posted.get(id, 0)) + 1
	if last_faults == 0 and not eliminated:
		clears[id] = int(clears.get(id, 0)) + 1
	if eliminated:
		return
	var rec: Dictionary = best_by_class.get(id, {"faults": 999, "time": 9999.0})
	if last_faults < int(rec.faults) or (last_faults == int(rec.faults) and last_time < float(rec.time)):
		best_by_class[id] = {"faults": last_faults, "time": last_time}
	if last_faults < best_faults or (last_faults == best_faults and last_time < best_time):
		best_faults = last_faults
		best_time = last_time
	if session_kind == "show":
		var sb: Dictionary = show_best.get(id, {"faults": 999, "time": 9999.0})
		var improved := last_faults < int(sb.faults) or (last_faults == int(sb.faults) and last_time < float(sb.time))
		if improved:
			show_best[id] = {"faults": last_faults, "time": last_time}
		last_ribbon = _ribbon(last_faults, improved and last_faults == 0)
		if last_ribbon != "":
			show_ribbons.append({
				"class": id,
				"ribbon": last_ribbon,
				"faults": last_faults,
				"time": last_time,
			})
			if show_ribbons.size() > 24:
				show_ribbons = show_ribbons.slice(show_ribbons.size() - 24)


func _ribbon(f: int, first_clear: bool) -> String:
	if f == 0:
		return "Blue" if first_clear else "Red"
	if f == 4:
		return "Yellow"
	if f <= 8:
		return "White"
	return "Pink"


func set_mode(m: String) -> void:
	mode = m
	mode_changed.emit(m)


func start_session(kind: String, cid: String) -> bool:
	if kind == "lesson":
		cid = "lesson"
	if not CLASS_INFO.has(cid):
		return false
	session_kind = kind
	class_id = cid
	jump_off = false
	if kind != "lesson" and not class_unlocked(cid):
		return false
	return true


func load_save() -> void:
	if not FileAccess.file_exists(SAVE_PATH) and not FileAccess.file_exists(SAVE_PATH + ".bak"):
		return
	var d := read_save_migrated(SAVE_PATH)
	if not _save_usable(d):
		push_warning("Abbott save missing or bad. Using defaults.")
		return
	_apply_save(d)


func read_save_migrated(path: String) -> Dictionary:
	var data := _read_save(path)
	if not _save_usable(data):
		push_warning("Abbott save unreadable at %s. Using defaults." % path)
		return _save_defaults()
	return _migrate_save(data)


func _apply_save(d: Dictionary) -> void:
	best_faults = int(d.get("best_faults", 999))
	best_time = float(d.get("best_time", 9999.0))
	abbott_confidence = float(d.get("abbott_confidence", abbott_confidence))
	abbott_scope = float(d.get("abbott_scope", abbott_scope))
	abbott_rideability = float(d.get("abbott_rideability", abbott_rideability))
	madison_timing = float(d.get("madison_timing", madison_timing))
	madison_feel = float(d.get("madison_feel", madison_feel))
	lesson_done = bool(d.get("lesson_done", false))
	tutorial_done = bool(d.get("tutorial_done", false))
	course_seed = int(d.get("course_seed", course_seed))
	var rp: Variant = d.get("rounds_posted", {})
	if typeof(rp) == TYPE_DICTIONARY:
		rounds_posted = rp
	var cl: Variant = d.get("clears", {})
	if typeof(cl) == TYPE_DICTIONARY:
		clears = cl
	var bb: Variant = d.get("best_by_class", {})
	if typeof(bb) == TYPE_DICTIONARY:
		best_by_class = bb
	var sb: Variant = d.get("show_best", {})
	if typeof(sb) == TYPE_DICTIONARY:
		show_best = sb
	var rb: Variant = d.get("show_ribbons", [])
	if typeof(rb) == TYPE_ARRAY:
		show_ribbons = rb
	var b: Variant = d.get("bindings", {})
	if typeof(b) == TYPE_DICTIONARY:
		for k in b:
			bindings[str(k)] = b[k]


func _save_defaults() -> Dictionary:
	return {
		"save_version": SAVE_VERSION,
		"best_faults": 999,
		"best_time": 9999.0,
		"bindings": {},
		"abbott_confidence": 48.0,
		"abbott_scope": 40.0,
		"abbott_rideability": 44.0,
		"madison_timing": 38.0,
		"madison_feel": 36.0,
		"lesson_done": false,
		"course_seed": 1,
		"rounds_posted": {"lesson": 0, "beginner": 0, "intermediate": 0, "advanced": 0},
		"clears": {"lesson": 0, "beginner": 0, "intermediate": 0, "advanced": 0},
		"best_by_class": {},
		"show_best": {},
		"show_ribbons": [],
	}


func _save_usable(data: Dictionary) -> bool:
	if data.is_empty():
		return false
	for k in ["best_faults", "best_time", "course_seed", "lesson_done", "abbott_confidence"]:
		if not data.has(k):
			return false
	return true


func _parse_save_file(path: String) -> Dictionary:
	if not FileAccess.file_exists(path):
		return {}
	var f := FileAccess.open(path, FileAccess.READ)
	if f == null:
		push_warning("Abbott save could not be opened: %s" % path)
		return {}
	var parsed: Variant = JSON.parse_string(f.get_as_text())
	f.close()
	if typeof(parsed) != TYPE_DICTIONARY:
		push_warning("Abbott save is not valid JSON: %s" % path)
		return {}
	return parsed


func _read_save(path: String) -> Dictionary:
	var direct := _parse_save_file(path)
	if _save_usable(direct):
		return direct
	if FileAccess.file_exists(path):
		push_warning("Abbott save rejected. Trying the backup.")
	var bak := _parse_save_file(path + ".bak")
	if _save_usable(bak):
		return bak
	return {}


func _migrate_save(data: Dictionary) -> Dictionary:
	var out: Dictionary = data.duplicate(true) as Dictionary
	var had_tutorial := out.has("tutorial_done")
	var defaults := _save_defaults()
	for k in defaults.keys():
		if not out.has(k):
			out[k] = defaults[k]
	if not had_tutorial:
		out["tutorial_done"] = _save_has_progress(out)
	else:
		out["tutorial_done"] = bool(out.get("tutorial_done", false))
	out["save_version"] = SAVE_VERSION
	return out


func _save_has_progress(data: Dictionary) -> bool:
	if bool(data.get("lesson_done", false)):
		return true
	if int(data.get("best_faults", 999)) < 900:
		return true
	var posted: Variant = data.get("rounds_posted", {})
	if typeof(posted) == TYPE_DICTIONARY:
		for k in posted:
			if int(posted[k]) > 0:
				return true
	var bests: Variant = data.get("best_by_class", {})
	if typeof(bests) == TYPE_DICTIONARY and (bests as Dictionary).size() > 0:
		return true
	return false


func season_rows() -> Array:
	## The ladder in SHIP order. Locked, open, and done come from the unlock rules already in class_unlocked.
	var out: Array = []
	var ship: Dictionary = ContentLibrary.load_ship()
	var lessons: Variant = ship.get("lesson", [])
	if typeof(lessons) == TYPE_ARRAY:
		var posted := int(rounds_posted.get("lesson", 0))
		var i := 0
		for raw in lessons:
			var cid := str(raw)
			var course: Dictionary = ContentLibrary.load_course(cid)
			var name := str(course.get("name", "Lesson %d" % (i + 1)))
			var state := "done" if posted > i else "open"
			out.append({
				"id": cid,
				"kind": "lesson",
				"class_id": "lesson",
				"seed": i,
				"title": "Lesson %d  ·  %s" % [i + 1, name],
				"state": state,
				"detail": _season_best("lesson", false) if state == "done" else "",
			})
			i += 1
	var kind_was := session_kind
	var blocks: Array = [
		["schooling", "name"],
		["show", "show_name"],
	]
	for block in blocks:
		var kind: String = str(block[0])
		var name_key: String = str(block[1])
		session_kind = kind
		for class_id in ["beginner", "intermediate", "advanced"]:
			var info: Dictionary = CLASS_INFO[class_id]
			var open := class_unlocked(class_id)
			var ridden := false
			if kind == "show":
				ridden = show_best.has(class_id)
			else:
				ridden = best_by_class.has(class_id)
			var state := "locked"
			if open and ridden:
				state = "done"
			elif open:
				state = "open"
			var detail := ""
			if state == "done":
				detail = _season_best(class_id, kind == "show")
			out.append({
				"id": class_id,
				"kind": kind,
				"class_id": class_id,
				"seed": course_seed,
				"title": "%s  ·  %s" % [str(info[name_key]), str(info["height"])],
				"state": state,
				"detail": detail,
			})
	session_kind = kind_was
	return out


func _season_best(id: String, show: bool) -> String:
	var pile: Dictionary = show_best if show else best_by_class
	var rec: Variant = pile.get(id, null)
	var text := ""
	if typeof(rec) == TYPE_DICTIONARY:
		text = "%d faults  ·  %0.1fs" % [int(rec.get("faults", 0)), float(rec.get("time", 0.0))]
	if show:
		var rib := ""
		for item in show_ribbons:
			if typeof(item) == TYPE_DICTIONARY and str(item.get("class", "")) == id:
				rib = str(item.get("ribbon", ""))
		if rib != "":
			text = rib if text == "" else "%s  ·  %s" % [text, rib]
	return text


func _skip_save_reason() -> String:
	# Watch a round is not her ride. Certs, playtests, shots, and selftests are not either.
	if demo_ride:
		return "demo"
	for a in OS.get_cmdline_user_args():
		var arg := str(a)
		if arg == "--playtest" or arg.begins_with("--ridecert") or arg.begins_with("--shots") or arg == "--selftest" or arg.begins_with("--selftest-") or arg == "--telemetry" or arg.begins_with("--telemetry"):
			return "arg"
	return ""


func save() -> void:
	if _skip_save_reason() != "":
		return
	_write_save_file(SAVE_PATH)


func _write_save_file(path: String) -> void:
	var d := _save_defaults()
	d["save_version"] = SAVE_VERSION
	d["best_faults"] = best_faults
	d["best_time"] = best_time
	d["bindings"] = bindings
	d["abbott_confidence"] = abbott_confidence
	d["abbott_scope"] = abbott_scope
	d["abbott_rideability"] = abbott_rideability
	d["madison_timing"] = madison_timing
	d["madison_feel"] = madison_feel
	d["lesson_done"] = lesson_done
	d["tutorial_done"] = tutorial_done
	d["course_seed"] = course_seed
	d["rounds_posted"] = rounds_posted
	d["clears"] = clears
	d["best_by_class"] = best_by_class
	d["show_best"] = show_best
	d["show_ribbons"] = show_ribbons
	var tmp := path + ".tmp"
	var f := FileAccess.open(tmp, FileAccess.WRITE)
	if f == null:
		push_warning("Abbott save could not start the temp file.")
		return
	f.store_string(JSON.stringify(d, "\t"))
	f.close()
	var bak := path + ".bak"
	var path_os := ProjectSettings.globalize_path(path)
	var tmp_os := ProjectSettings.globalize_path(tmp)
	var bak_os := ProjectSettings.globalize_path(bak)
	if FileAccess.file_exists(path):
		if FileAccess.file_exists(bak):
			DirAccess.remove_absolute(bak_os)
		var kept: Error = DirAccess.rename_absolute(path_os, bak_os)
		if kept != OK:
			push_warning("Abbott save could not keep the previous file.")
	var put: Error = DirAccess.rename_absolute(tmp_os, path_os)
	if put != OK:
		if FileAccess.file_exists(path):
			DirAccess.remove_absolute(path_os)
		put = DirAccess.rename_absolute(tmp_os, path_os)
	if put != OK:
		push_warning("Abbott save replace failed. The backup is still there.")


func has_best() -> bool:
	return best_faults < 900


func best_line() -> String:
	if not has_best():
		return "No round saved yet"
	return "Best  ·  %d faults  ·  %0.2fs" % [best_faults, best_time]


func class_best_line(id: String) -> String:
	var rec: Variant = best_by_class.get(id, null)
	if typeof(rec) != TYPE_DICTIONARY:
		return "—"
	return "%d f  ·  %0.1fs" % [int(rec.faults), float(rec.time)]


## The Best line for the class being ridden. Empty when that class has no record.
func class_best_display() -> String:
	var rec: Variant = best_by_class.get(class_id, null)
	if typeof(rec) != TYPE_DICTIONARY:
		return ""
	return "Best  ·  %d faults  ·  %0.2fs" % [int(rec.get("faults", 0)), float(rec.get("time", 0.0))]


func result_line() -> String:
	if eliminated:
		var why := "Eliminated."
		if eliminate_reason == "three":
			why = "Eliminated  ·  three refusals."
		elif eliminate_reason == "off_course":
			why = "Eliminated  ·  off course."
		elif eliminate_reason == "time":
			why = "Eliminated  ·  time limit."
		return "%s  %ss" % [why, official_text()]
	var extra := ""
	if session_kind == "show" and last_ribbon != "":
		extra = "\n%s ribbon." % last_ribbon
	if last_faults == 0 and time_faults == 0:
		var clear := "Jump-off clear." if jump_off else "Clear."
		if can_offer_jump_off():
			clear += "  Stay for the jump-off."
		elif session_kind == "show" and not jump_off:
			clear += "  Over the time allowed."
		return "%s  %ss%s" % [clear, official_text(), extra]
	var bits: PackedStringArray = []
	bits.append("%d faults" % last_faults)
	bits.append("%ss" % official_text())
	if time_faults > 0:
		bits.append("%d time fault%s" % [time_faults, "" if time_faults == 1 else "s"])
	if rail_nums.size() > 0:
		bits.append("rail %s" % _num_list(rail_nums))
	if refuse_nums.size() > 0:
		bits.append("refusal %s" % _num_list(refuse_nums))
	return "%s%s" % ["   ·   ".join(bits), extra]


func _num_list(nums: Array[int]) -> String:
	var parts: PackedStringArray = []
	for n in nums:
		parts.append(str(n))
	return ", ".join(parts)


func key_name(action: String) -> String:
	var keys: Array = bindings.get(action, [])
	if keys.is_empty():
		return "—"
	return OS.get_keycode_string(int(keys[0]))
