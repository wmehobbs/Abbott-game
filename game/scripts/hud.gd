extends CanvasLayer
class_name HUD

signal pause_requested
signal mount_requested
signal quit_requested
signal resume_requested
signal walk_requested
signal retry_requested
signal jump_off_requested

var jump_off_btn: Button

var time_lab: Label
var fault_lab: Label
var gait_lab: Label
var next_lab: Label
var trainer_lab: Label
var hint: Label
var pause_panel: Control
var result_panel: Control
var options_panel: Control
var walk_hint: Label
var best_lab: Label
var pause_stats: Label
var font: FontFile
var font_b: FontFile
var sans: FontFile
var waiting_rebind: String = ""


func _ready() -> void:
	layer = 20
	process_mode = Node.PROCESS_MODE_ALWAYS
	font = load("res://assets/fonts/LibreBaskerville-Regular.ttf")
	font_b = load("res://assets/fonts/LibreBaskerville-Bold.ttf")
	sans = load("res://assets/fonts/SourceSans3-Regular.ttf")
	_build()
	GameState.faults_changed.connect(_on_faults)
	GameState.round_finished.connect(_on_finished)
	GameState.mode_changed.connect(_on_mode)


func _build() -> void:
	var root := Control.new()
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(root)

	var board := Panel.new()
	board.position = Vector2(28, 24)
	board.size = Vector2(420, 228)
	var sb := StyleBoxFlat.new()
	sb.bg_color = Color(0.07, 0.05, 0.03, 0.72)
	sb.border_color = Color(0.72, 0.58, 0.32, 0.85)
	sb.set_border_width_all(1)
	sb.corner_radius_top_left = 4
	sb.corner_radius_top_right = 4
	sb.corner_radius_bottom_left = 4
	sb.corner_radius_bottom_right = 4
	sb.content_margin_left = 16
	board.add_theme_stylebox_override("panel", sb)
	board.mouse_filter = Control.MOUSE_FILTER_IGNORE
	root.add_child(board)
	time_lab = _label(board, "0.00", 44, Vector2(16, 10), Color(0.96, 0.93, 0.86))
	fault_lab = _label(board, "Faults  0", 26, Vector2(16, 62), Color(0.92, 0.86, 0.72))
	gait_lab = _label(board, "Halt", 24, Vector2(16, 96), Color(0.85, 0.80, 0.70))
	next_lab = _label(board, "Next  1", 20, Vector2(16, 128), Color(0.80, 0.74, 0.60))
	best_lab = _label(board, GameState.class_title(), 18, Vector2(16, 158), Color(0.72, 0.66, 0.55))
	_label(board, "THU SEP 24  ·  2.348.0.0", 16, Vector2(16, 188), Color(0.98, 0.86, 0.32))

	trainer_lab = _label(root, "", 22, Vector2(48, 0), Color(0.96, 0.90, 0.72))
	trainer_lab.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
	trainer_lab.position = Vector2(48, -108)
	trainer_lab.size = Vector2(1400, 40)

	hint = _label(root, "", 18, Vector2(48, 0), Color(0.85, 0.82, 0.75, 0.85))
	hint.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
	hint.position = Vector2(48, -64)
	_set_ride_hint()

	walk_hint = _label(root, "Course walk  ·  WASD  ·  Enter to mount  ·  clock starts at the flags", 22, Vector2(48, 96), Color(0.93, 0.9, 0.82))
	walk_hint.visible = false

	_build_pause(root)
	_build_result(root)
	_build_options(root)


func _set_ride_hint() -> void:
	hint.text = "W/S gait   A/D steer   Space half-halt (hold to collect, release to ask)   Shift halt   C walk   Esc pause"


func _label(parent: Control, text: String, size: int, pos: Vector2, col: Color) -> Label:
	var l := Label.new()
	l.text = text
	l.position = pos
	l.modulate = col
	if font:
		l.add_theme_font_override("font", font if size >= 28 else (sans if sans else font))
	l.add_theme_font_size_override("font_size", size)
	l.add_theme_color_override("font_outline_color", Color(0.05, 0.04, 0.03, 0.8))
	l.add_theme_constant_override("outline_size", 6)
	parent.add_child(l)
	return l


func _build_pause(root: Control) -> void:
	pause_panel = Control.new()
	pause_panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	pause_panel.visible = false
	root.add_child(pause_panel)
	var dim := ColorRect.new()
	dim.color = Color(0.02, 0.02, 0.015, 0.62)
	dim.set_anchors_preset(Control.PRESET_FULL_RECT)
	pause_panel.add_child(dim)
	var box := VBoxContainer.new()
	box.position = Vector2(80, 160)
	box.add_theme_constant_override("separation", 14)
	pause_panel.add_child(box)
	_label(box, "Paused", 56, Vector2.ZERO, Color(0.96, 0.93, 0.86))
	pause_stats = Label.new()
	pause_stats.name = "PauseStats"
	if font:
		pause_stats.add_theme_font_override("font", font)
	pause_stats.add_theme_font_size_override("font_size", 24)
	pause_stats.modulate = Color(0.9, 0.84, 0.72)
	box.add_child(pause_stats)
	_btn(box, "Resume", resume_requested)
	_btn(box, "Retry", retry_requested)
	_btn(box, "Options", func() -> void: options_panel.visible = true)
	_btn(box, "Walk the course", walk_requested)
	_btn(box, "Quit to title", _quit_title)


func _build_result(root: Control) -> void:
	result_panel = Control.new()
	result_panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	result_panel.visible = false
	root.add_child(result_panel)
	var dim := ColorRect.new()
	dim.color = Color(0.02, 0.015, 0.01, 0.55)
	dim.set_anchors_preset(Control.PRESET_FULL_RECT)
	result_panel.add_child(dim)
	var box := VBoxContainer.new()
	box.name = "Box"
	box.position = Vector2(80, 200)
	box.add_theme_constant_override("separation", 14)
	result_panel.add_child(box)
	_label(box, "Round complete", 52, Vector2.ZERO, Color(0.96, 0.93, 0.86))
	var ribbon := ColorRect.new()
	ribbon.name = "Ribbon"
	ribbon.custom_minimum_size = Vector2(220, 14)
	ribbon.color = Color(0.18, 0.32, 0.72)
	ribbon.visible = false
	box.add_child(ribbon)
	var stats := Label.new()
	stats.name = "Stats"
	if font:
		stats.add_theme_font_override("font", font)
	stats.add_theme_font_size_override("font_size", 28)
	box.add_child(stats)
	jump_off_btn = _btn(box, "Stay for the jump-off", jump_off_requested)
	jump_off_btn.visible = false
	_btn(box, "Ride again", retry_requested)
	_btn(box, "Course walk", walk_requested)
	_btn(box, "Quit to title", _quit_title)


func _quit_title() -> void:
	Engine.time_scale = 1.0
	quit_requested.emit()


func _build_options(root: Control) -> void:
	options_panel = Control.new()
	options_panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	options_panel.visible = false
	root.add_child(options_panel)
	var dim := ColorRect.new()
	dim.color = Color(0.02, 0.02, 0.015, 0.82)
	dim.set_anchors_preset(Control.PRESET_FULL_RECT)
	options_panel.add_child(dim)
	var box := VBoxContainer.new()
	box.name = "BindBox"
	box.position = Vector2(80, 120)
	box.add_theme_constant_override("separation", 10)
	options_panel.add_child(box)
	_label(box, "Controls", 48, Vector2.ZERO, Color(0.96, 0.93, 0.86))
	_refresh_binds()
	_btn(box, "Back", func() -> void:
		waiting_rebind = ""
		options_panel.visible = false
	)


func _refresh_binds() -> void:
	var box: VBoxContainer = options_panel.find_child("BindBox", true, false)
	if box == null:
		return
	for c in box.get_children():
		if c is Button and String(c.text).begins_with("Bind"):
			c.queue_free()
	var rows := [
		["gait_up", "Gait up (W)"],
		["gait_down", "Gait down (S)"],
		["turn_left", "Steer left (A)"],
		["turn_right", "Steer right (D)"],
		["jump", "Half-halt / ask (Space)"],
		["halt", "Halt (Shift)"],
		["walk_mode", "Walk on foot (C)"],
		["mount", "Mount (Enter)"],
		["pause", "Pause (Esc)"],
	]
	for r in rows:
		var action: String = r[0]
		var label: String = r[1]
		var b := Button.new()
		b.text = "Bind  %s   ·   %s" % [label, GameState.key_name(action)]
		b.custom_minimum_size = Vector2(640, 44)
		if sans:
			b.add_theme_font_override("font", sans)
		b.add_theme_font_size_override("font_size", 18)
		_style_btn(b)
		var act := action
		b.pressed.connect(func() -> void:
			waiting_rebind = act
			b.text = "Bind  %s   ·   press a key…" % label
		)
		box.add_child(b)


func _unhandled_input(event: InputEvent) -> void:
	if pause_panel != null and pause_panel.visible and event.is_action_pressed("pause"):
		Engine.time_scale = 1.0
		resume_requested.emit()
		get_viewport().set_input_as_handled()
		return
	if waiting_rebind == "":
		return
	if event is InputEventKey and event.pressed:
		GameState.rebind(waiting_rebind, event.physical_keycode)
		waiting_rebind = ""
		_rebuild_option_buttons()
		get_viewport().set_input_as_handled()


func _rebuild_option_buttons() -> void:
	options_panel.queue_free()
	_build_options(get_child(0))
	options_panel.visible = true


func _btn(parent: Node, text: String, sig) -> Button:
	var b := Button.new()
	b.text = text
	b.custom_minimum_size = Vector2(360, 52)
	if sans:
		b.add_theme_font_override("font", sans)
	b.add_theme_font_size_override("font_size", 22)
	_style_btn(b)
	parent.add_child(b)
	if sig is Signal:
		b.pressed.connect(func() -> void: _click(); sig.emit())
	else:
		b.pressed.connect(func() -> void: _click(); sig.call())
	return b


func _style_btn(b: Button) -> void:
	b.add_theme_color_override("font_color", Color(0.95, 0.92, 0.85))
	b.add_theme_color_override("font_hover_color", Color(1, 0.95, 0.8))
	var sb := StyleBoxFlat.new()
	sb.bg_color = Color(0.12, 0.09, 0.06, 0.92)
	sb.border_color = Color(0.72, 0.58, 0.32)
	sb.set_border_width_all(1)
	sb.content_margin_left = 18
	sb.content_margin_right = 18
	sb.content_margin_top = 8
	sb.content_margin_bottom = 8
	b.add_theme_stylebox_override("normal", sb)
	var sbh := sb.duplicate()
	sbh.bg_color = Color(0.22, 0.16, 0.08, 0.95)
	b.add_theme_stylebox_override("hover", sbh)


func _click() -> void:
	if ResourceLoader.exists("res://assets/audio/ui.wav"):
		var p := AudioStreamPlayer.new()
		p.stream = load("res://assets/audio/ui.wav")
		add_child(p)
		p.play()
		p.finished.connect(p.queue_free)


func _process(_delta: float) -> void:
	if time_lab:
		var clock := "%0.2f" % GameState.time_sec
		if GameState.start_crossed:
			clock += "  /  %0.0f" % GameState.time_allowed()
		else:
			clock = "Walk to the start flags"
		if GameState.time_sec > GameState.time_allowed() and GameState.clock_running:
			var over := int(floor((GameState.time_sec - GameState.time_allowed()) / 4.0))
			if over > 0:
				clock += "  +%d" % over
		time_lab.text = clock
	if best_lab:
		best_lab.text = GameState.class_title()
	if next_lab:
		if GameState.mode == "ride" and not GameState.round_complete:
			next_lab.text = GameState.next_fence_line()
			next_lab.visible = true
		else:
			next_lab.visible = false
	if trainer_lab:
		trainer_lab.text = GameState.trainer_line
		trainer_lab.visible = GameState.trainer_line != ""
	if gait_lab:
		var h := _horse()
		if h:
			var g := h.gait_name()
			if h.collecting:
				g += "  ·  collected"
			gait_lab.text = g
	_sync_booth()


func _sync_booth() -> void:
	var n := get_tree().get_first_node_in_group("clock_face")
	if not (n is Label3D):
		return
	var lab := n as Label3D
	if GameState.start_crossed and GameState.clock_running:
		lab.text = "%0.1f" % GameState.time_sec
	elif GameState.round_complete:
		lab.text = "%0.1f" % GameState.time_sec
	else:
		lab.text = "TIME"


func _horse() -> Horse:
	var n := get_tree().get_first_node_in_group("abbott")
	if n is Horse:
		return n
	return null


func _on_faults(f: int) -> void:
	fault_lab.text = "Faults  %d" % f


func _on_finished(f: int, t: float) -> void:
	result_panel.visible = true
	var stats: Label = result_panel.find_child("Stats", true, false)
	if stats:
		var extra := ""
		if f < GameState.best_faults or (f == GameState.best_faults and is_equal_approx(t, GameState.best_time)):
			extra = "\nNew best."
		stats.text = "%s%s\n%s\n%s\n%s" % [GameState.result_line(), extra, GameState.class_title(), GameState.barn_note(), GameState.best_line()]
	if jump_off_btn:
		jump_off_btn.visible = GameState.can_offer_jump_off()
	var ribbon: ColorRect = result_panel.find_child("Ribbon", true, false)
	if ribbon:
		var name := GameState.last_ribbon
		ribbon.visible = name != ""
		match name:
			"Blue":
				ribbon.color = Color(0.16, 0.32, 0.78)
			"Red":
				ribbon.color = Color(0.72, 0.14, 0.16)
			"Yellow":
				ribbon.color = Color(0.86, 0.72, 0.18)
			"White":
				ribbon.color = Color(0.92, 0.90, 0.86)
			"Pink":
				ribbon.color = Color(0.86, 0.48, 0.58)
			_:
				ribbon.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_mode(m: String) -> void:
	walk_hint.visible = m == "walk"
	fault_lab.visible = m == "ride" or m == "results"
	gait_lab.visible = m == "ride"
	if m != "results":
		result_panel.visible = false


const WALK_DEFAULT := "Course walk  ·  WASD  ·  Enter to mount  ·  clock starts at the flags"


var _walk_course := ""


func set_walk_mode(on: bool, line: String = "") -> void:
	walk_hint.visible = on
	if on:
		_walk_course = line if line != "" else WALK_DEFAULT
		walk_hint.text = _walk_course
	hint.text = (
		"WASD walk   Enter to mount   clock starts at the flags   Esc pause"
		if on
		else "W/S gait   A/D steer   Space half-halt (hold to collect, release to ask)   Shift halt   C walk   Esc pause"
	)


## The course line, and under it the fence she is beside (empty: the course line alone).
func set_walk_near(near: String) -> void:
	walk_hint.text = _walk_course + ("\n" + near if near != "" else "")


func show_pause(on: bool) -> void:
	pause_panel.visible = on
	GameState.ui_paused = on
	Engine.time_scale = 0.0 if on else 1.0
	if on:
		result_panel.visible = false
		options_panel.visible = false
		if pause_stats:
			pause_stats.text = "%s\n%d faults   ·   %0.2fs\n%s" % [GameState.class_title(), GameState.faults, GameState.time_sec, GameState.best_line()]
