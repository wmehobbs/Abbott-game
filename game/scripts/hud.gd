extends CanvasLayer
class_name HUD

signal pause_requested
signal mount_requested
signal quit_requested
signal resume_requested
signal walk_requested
signal retry_requested
signal jump_off_requested
signal next_class_requested
signal lesson_skip_requested

var jump_off_btn: Button
var next_btn: Button
var lesson_card: PanelContainer
var lesson_lab: Label

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
var callout_lab: Label
var grade_lab: Label
var _grade_left: float = 0.0
var _shake: float = 0.0
var go_lab: Label
var capture_lab: Label
var _seen_callout: int = 0
var _callout_left: float = 0.0
var _go_left: float = 0.0
var _clock_was_on: bool = false
var _reins_t: float = 0.0
var _reins_fade: float = 1.0
var _reins_gone: bool = false
var _reins_latched: bool = false
var _pip_n: int = -1
var _reins_device: String = ""
var _result_f: int = 0
var _result_time: float = 0.0
var _result_age: float = -1.0
var _result_shown: bool = false
var _veil: ColorRect
var _scene_card: Label
var _veil_a: float = 0.0
var _veil_dir: float = 0.0
var _card_left: float = 0.0


func _ready() -> void:
	layer = 20
	process_mode = Node.PROCESS_MODE_ALWAYS
	font = load("res://assets/fonts/LibreBaskerville-Regular.ttf")
	font_b = load("res://assets/fonts/LibreBaskerville-Bold.ttf")
	sans = load("res://assets/fonts/SourceSans3-Regular.ttf")
	_build()
	_seen_callout = GameState.fault_callout_id
	GameState.faults_changed.connect(_on_faults)
	GameState.round_finished.connect(_on_finished)
	GameState.mode_changed.connect(_on_mode)


func _build() -> void:
	var root := Control.new()
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	root.theme = load("res://assets/ui/abbott_theme.tres")
	add_child(root)

	var board := Panel.new()
	board.name = "Scoreboard"
	board.position = Vector2(28, 24)
	board.size = Vector2(520, 236)
	var sb := StyleBoxFlat.new()
	sb.bg_color = Color(0.04, 0.03, 0.02, 0.9)
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
	time_lab = _label(board, "0.00", 56, Vector2(16, 8), Color(0.98, 0.96, 0.90))
	fault_lab = _label(board, "Faults  0", 30, Vector2(16, 70), Color(0.96, 0.93, 0.84))
	var pips := Control.new()
	pips.name = "FencePips"
	pips.position = Vector2(16, 112)
	pips.size = Vector2(480, 16)
	pips.mouse_filter = Control.MOUSE_FILTER_IGNORE
	board.add_child(pips)
	gait_lab = _label(board, "Halt", 24, Vector2(16, 134), Color(0.94, 0.90, 0.82))
	next_lab = _label(board, "Next  1", 22, Vector2(16, 166), Color(0.96, 0.93, 0.86))
	best_lab = _label(board, GameState.class_title(), 20, Vector2(16, 198), Color(0.93, 0.88, 0.76))

	trainer_lab = _label(root, "", 22, Vector2.ZERO, Color(0.96, 0.90, 0.72))
	trainer_lab.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	trainer_lab.offset_left = 48
	trainer_lab.offset_right = -48
	trainer_lab.offset_top = -118
	trainer_lab.offset_bottom = -78
	trainer_lab.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART

	var band := ColorRect.new()
	band.name = "HintBand"
	band.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	band.offset_left = 0
	band.offset_right = 0
	band.offset_top = -78
	band.offset_bottom = 0
	band.mouse_filter = Control.MOUSE_FILTER_IGNORE
	band.color = Color(0.04, 0.03, 0.02, 0.78)
	root.add_child(band)
	hint = _label(root, "", 18, Vector2.ZERO, Color(0.96, 0.93, 0.86, 0.95))
	hint.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	hint.offset_left = 48
	hint.offset_right = -48
	hint.offset_top = -72
	hint.offset_bottom = -36
	hint.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_set_ride_hint()

	walk_hint = _label(root, "Course walk  ·  WASD  ·  Enter to mount  ·  clock starts at the flags", 22, Vector2(48, 96), Color(0.93, 0.9, 0.82))
	walk_hint.visible = false

	_build_vignette(root)
	_build_reins(root)
	_build_watching(root)
	_build_callout(root)
	_build_pause(root)
	_build_result(root)
	_build_options(root)
	_build_lesson(root)
	_veil = ColorRect.new()
	_veil.name = "SceneFade"
	_veil.set_anchors_preset(Control.PRESET_FULL_RECT)
	_veil.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_veil.color = Color(0.02, 0.015, 0.01, 0.0)
	_veil.z_index = 30
	root.add_child(_veil)
	_scene_card = _label(root, "", 42, Vector2.ZERO, Color(0.96, 0.93, 0.86))
	_scene_card.name = "SceneCard"
	_scene_card.set_anchors_preset(Control.PRESET_CENTER_TOP)
	_scene_card.offset_left = -420
	_scene_card.offset_top = 120
	_scene_card.offset_right = 420
	_scene_card.offset_bottom = 190
	_scene_card.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_scene_card.z_index = 31
	_scene_card.visible = false
	apply_hud_scale()


func _set_ride_hint() -> void:
	if hint == null:
		return
	if GameState.mode == "walk":
		hint.text = (
			"Left stick walks   A to mount   clock starts at the flags   Start pause"
			if GameState.last_device == "pad"
			else "WASD walk   Enter to mount   clock starts at the flags   Esc pause"
		)
		return
	hint.text = GameState.control_line()


func _reins_copy() -> String:
	if GameState.last_device == "pad":
		return "The reins\n\nD-pad up  walk, then trot, then canter\nD-pad down  come back a gait\nLeft stick  steer\nHold A  half-halt. He collects.\nLet A go at the canter  ask him to leave\nB  halt\nY  get off and walk the course\nStart  pause\n\nThe clock starts when you pass the start flags.\nEarly is a refusal. Late is a rail.\nThis card fades once you move."
	return "The reins\n\nW  walk, then trot, then canter\nS  come back a gait\nA / D  steer\nHold Space  half-halt. He collects.\nLet Space go at the canter  ask him to leave\nShift  halt\nC  get off and walk the course\nEsc  pause\n\nThe clock starts when you pass the start flags.\nEarly is a refusal. Late is a rail.\nThis card fades once you move."


func _build_vignette(root: Control) -> void:
	var veil := ColorRect.new()
	veil.set_anchors_preset(Control.PRESET_FULL_RECT)
	veil.mouse_filter = Control.MOUSE_FILTER_IGNORE
	veil.color = Color(1, 1, 1, 1)
	var sh := Shader.new()
	sh.code = "shader_type canvas_item;\nrender_mode blend_mix, unshaded;\nvoid fragment() {\n\tvec2 p = UV * 2.0 - 1.0;\n\tp.x *= 1.2;\n\tfloat v = smoothstep(0.42, 1.35, dot(p, p));\n\tCOLOR = vec4(0.04, 0.025, 0.015, v * 0.38);\n}\n"
	var mat := ShaderMaterial.new()
	mat.shader = sh
	veil.material = mat
	root.add_child(veil)
	root.move_child(veil, 0)


func _build_reins(root: Control) -> void:
	var card := Panel.new()
	card.name = "Reins"
	card.set_anchors_preset(Control.PRESET_CENTER_RIGHT)
	card.offset_left = -560
	card.offset_top = -250
	card.offset_right = -36
	card.offset_bottom = 250
	card.mouse_filter = Control.MOUSE_FILTER_IGNORE
	card.visible = false
	var sb := StyleBoxFlat.new()
	sb.bg_color = Color(0.07, 0.05, 0.03, 0.82)
	sb.border_color = Color(0.72, 0.58, 0.32, 0.9)
	sb.set_border_width_all(1)
	sb.corner_radius_top_left = 6
	sb.corner_radius_top_right = 6
	sb.corner_radius_bottom_left = 6
	sb.corner_radius_bottom_right = 6
	sb.content_margin_left = 22
	sb.content_margin_top = 18
	sb.content_margin_right = 22
	sb.content_margin_bottom = 18
	card.add_theme_stylebox_override("panel", sb)
	root.add_child(card)
	var body := _label(card, "", 22, Vector2(22, 18), Color(0.96, 0.93, 0.86))
	body.name = "ReinsBody"
	body.size = Vector2(480, 460)
	body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	if sans:
		body.add_theme_font_override("font", sans)
	body.text = _reins_copy()


func _build_watching(root: Control) -> void:
	var lab := _label(root, "Watching  ·  she has the reins  ·  Esc to pause", 26, Vector2(0, 28), Color(0.96, 0.93, 0.86))
	lab.name = "Watching"
	lab.set_anchors_preset(Control.PRESET_CENTER_TOP)
	lab.offset_left = -420
	lab.offset_top = 28
	lab.offset_right = 420
	lab.offset_bottom = 72
	lab.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	lab.visible = false
	if font_b:
		lab.add_theme_font_override("font", font_b)


func _build_callout(root: Control) -> void:
	callout_lab = _label(root, "", 54, Vector2(0, 0), Color(0.96, 0.90, 0.78))
	callout_lab.name = "Callout"
	callout_lab.set_anchors_preset(Control.PRESET_CENTER)
	callout_lab.offset_left = -520
	callout_lab.offset_top = -80
	callout_lab.offset_right = 520
	callout_lab.offset_bottom = -8
	callout_lab.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	callout_lab.visible = false
	if font_b:
		callout_lab.add_theme_font_override("font", font_b)
	grade_lab = _label(root, "", 48, Vector2(0, 0), Color(0.96, 0.93, 0.86))
	grade_lab.name = "Grade"
	grade_lab.set_anchors_preset(Control.PRESET_CENTER)
	grade_lab.offset_left = -360
	grade_lab.offset_top = 24
	grade_lab.offset_right = 360
	grade_lab.offset_bottom = 90
	grade_lab.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	grade_lab.visible = false
	if font_b:
		grade_lab.add_theme_font_override("font", font_b)
	go_lab = _label(root, "Time", 64, Vector2(0, 0), Color(0.96, 0.93, 0.86))
	go_lab.name = "Go"
	go_lab.set_anchors_preset(Control.PRESET_CENTER)
	go_lab.offset_left = -240
	go_lab.offset_top = -160
	go_lab.offset_right = 240
	go_lab.offset_bottom = -80
	go_lab.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	go_lab.visible = false
	if font_b:
		go_lab.add_theme_font_override("font", font_b)
	capture_lab = _label(root, "Click the ring to ride", 28, Vector2(0, 0), Color(0.96, 0.93, 0.86))
	capture_lab.name = "Capture"
	capture_lab.set_anchors_preset(Control.PRESET_CENTER_BOTTOM)
	capture_lab.offset_left = -280
	capture_lab.offset_top = -150
	capture_lab.offset_right = 280
	capture_lab.offset_bottom = -100
	capture_lab.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	capture_lab.visible = false
	if font_b:
		capture_lab.add_theme_font_override("font", font_b)


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
	var box := _menu_column(pause_panel)
	box.name = "PauseBox"
	_label(box, "Paused", 56, Vector2.ZERO, Color(0.96, 0.93, 0.86))
	pause_stats = Label.new()
	pause_stats.name = "PauseStats"
	if font:
		pause_stats.add_theme_font_override("font", font)
	pause_stats.add_theme_font_size_override("font_size", 24)
	pause_stats.custom_minimum_size = Vector2(520, 108)
	pause_stats.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	pause_stats.modulate = Color(0.9, 0.84, 0.72)
	box.add_child(pause_stats)
	var reins := Label.new()
	reins.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	reins.custom_minimum_size = Vector2(640, 96)
	reins.text = GameState.control_line()
	if sans:
		reins.add_theme_font_override("font", sans)
	reins.add_theme_font_size_override("font_size", 20)
	reins.modulate = Color(0.86, 0.80, 0.68)
	box.add_child(reins)
	_btn(box, "Resume", resume_requested)
	_btn(box, "Restart round", retry_requested)
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
	var box := _menu_column(result_panel)
	box.name = "Box"
	_label(box, "Round complete", 52, Vector2.ZERO, Color(0.96, 0.93, 0.86))
	var ribbon := ColorRect.new()
	ribbon.name = "Ribbon"
	ribbon.custom_minimum_size = Vector2(22, 72)
	ribbon.color = Color(0.18, 0.32, 0.72)
	ribbon.visible = false
	box.add_child(ribbon)
	var ribbon_name := Label.new()
	ribbon_name.name = "RibbonName"
	ribbon_name.visible = false
	if font_b:
		ribbon_name.add_theme_font_override("font", font_b)
	ribbon_name.add_theme_font_size_override("font_size", 40)
	ribbon_name.add_theme_color_override("font_outline_color", Color(0.05, 0.04, 0.03, 0.8))
	ribbon_name.add_theme_constant_override("outline_size", 6)
	box.add_child(ribbon_name)
	var stats := Label.new()
	stats.name = "Stats"
	if font:
		stats.add_theme_font_override("font", font)
	stats.add_theme_font_size_override("font_size", 28)
	box.add_child(stats)
	jump_off_btn = _btn(box, "Stay for the jump-off", jump_off_requested)
	jump_off_btn.visible = false
	_btn(box, "Ride again", retry_requested).text = "Retry"
	next_btn = _btn(box, "Next class", next_class_requested)
	next_btn.text = "Next"
	next_btn.visible = false
	_btn(box, "Course walk", walk_requested).text = "Walk the course"
	_btn(box, "Back to the barn", _quit_title).text = "Menu"


func _quit_title() -> void:
	Engine.time_scale = 1.0
	quit_requested.emit()


func _build_lesson(root: Control) -> void:
	lesson_card = PanelContainer.new()
	lesson_card.name = "LessonCard"
	lesson_card.visible = false
	lesson_card.set_anchors_preset(Control.PRESET_CENTER_TOP)
	lesson_card.offset_left = -280
	lesson_card.offset_top = 16
	lesson_card.offset_right = 280
	lesson_card.offset_bottom = 132
	var sb := StyleBoxFlat.new()
	sb.bg_color = Color(0.07, 0.05, 0.03, 0.9)
	sb.border_color = Color(0.72, 0.58, 0.32, 0.9)
	sb.set_border_width_all(1)
	sb.set_corner_radius_all(6)
	sb.content_margin_left = 16
	sb.content_margin_right = 16
	sb.content_margin_top = 10
	sb.content_margin_bottom = 10
	lesson_card.add_theme_stylebox_override("panel", sb)
	root.add_child(lesson_card)
	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 6)
	lesson_card.add_child(box)
	lesson_lab = _label(box, "", 22, Vector2.ZERO, Color(0.96, 0.93, 0.86))
	lesson_lab.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	var skip := _btn(box, "Skip", lesson_skip_requested)
	skip.custom_minimum_size = Vector2(160, 44)


func show_lesson(line: String, on: bool) -> void:
	if lesson_card == null:
		return
	var menu := (
		(pause_panel != null and pause_panel.visible)
		or (result_panel != null and result_panel.visible)
		or (options_panel != null and options_panel.visible)
	)
	lesson_card.visible = on and line != "" and not menu
	if lesson_lab:
		lesson_lab.text = line


func _build_options(root: Control) -> void:
	options_panel = Control.new()
	options_panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	options_panel.visible = false
	root.add_child(options_panel)
	var dim := ColorRect.new()
	dim.color = Color(0.02, 0.02, 0.015, 0.82)
	dim.set_anchors_preset(Control.PRESET_FULL_RECT)
	options_panel.add_child(dim)
	var box := _menu_column(options_panel)
	box.name = "BindBox"
	var menu: SettingsMenu = SettingsMenu.new()
	menu.name = "SettingsMenu"
	menu.show_controls = true
	menu.back_pressed.connect(func() -> void:
		waiting_rebind = ""
		options_panel.visible = false
	)
	menu.rebind_asked.connect(func(action: String) -> void:
		waiting_rebind = action
	)
	box.add_child(menu)


func apply_hud_scale() -> void:
	var s := 1.0
	if GameState.settings:
		s = GameState.settings.hud_scale
	_size_lab(time_lab, int(round(56.0 * s)))
	_size_lab(fault_lab, int(round(30.0 * s)))
	_size_lab(gait_lab, int(round(24.0 * s)))
	_size_lab(next_lab, int(round(22.0 * s)))
	_size_lab(best_lab, int(round(20.0 * s)))
	_size_lab(hint, int(round(18.0 * s)))


func _size_lab(lab: Label, px: int) -> void:
	if lab:
		lab.add_theme_font_size_override("font_size", px)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and _pointer_is_free():
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_viewport().set_input_as_handled()
		return
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
		var menu: SettingsMenu = options_panel.find_child("SettingsMenu", true, false) as SettingsMenu
		if menu:
			menu.show_page("controls")
		options_panel.visible = true
		get_viewport().set_input_as_handled()


func _btn(parent: Node, text: String, sig) -> Button:
	var b := Button.new()
	b.name = text
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
		p.bus = "UI"
		p.stream = load("res://assets/audio/ui.wav")
		add_child(p)
		p.play()
		p.finished.connect(p.queue_free)


func _menu_column(panel: Control) -> VBoxContainer:
	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	center.mouse_filter = Control.MOUSE_FILTER_IGNORE
	panel.add_child(center)
	var card := PanelContainer.new()
	var sb := StyleBoxFlat.new()
	sb.bg_color = Color(0.07, 0.05, 0.03, 0.88)
	sb.border_color = Color(0.72, 0.58, 0.32, 0.9)
	sb.set_border_width_all(1)
	sb.set_corner_radius_all(6)
	sb.content_margin_left = 28
	sb.content_margin_right = 28
	sb.content_margin_top = 22
	sb.content_margin_bottom = 22
	card.add_theme_stylebox_override("panel", sb)
	center.add_child(card)
	var box := VBoxContainer.new()
	box.custom_minimum_size = Vector2(480, 0)
	box.add_theme_constant_override("separation", 12)
	card.add_child(box)
	return box


func _sync_board() -> void:
	var board := find_child("Scoreboard", true, false) as CanvasItem
	if board == null or pause_panel == null:
		return
	var menu := pause_panel.visible or result_panel.visible or options_panel.visible
	board.visible = not menu
	if hint:
		hint.visible = not menu
	var band := find_child("HintBand", true, false) as CanvasItem
	if band:
		band.visible = hint != null and hint.visible and hint.text != ""


func _fit_root() -> void:
	if get_child_count() < 1:
		return
	var root := get_child(0) as Control
	if root == null:
		return
	var sz := get_viewport().get_visible_rect().size
	if sz.x < 2.0 or sz.y < 2.0:
		return
	root.position = Vector2.ZERO
	root.size = sz


func shake_refuse() -> void:
	# Four pixels, a fifth of a second. The horse already stopped.
	_shake = 0.22


func _process(_delta: float) -> void:
	_fit_root()
	if _shake > 0.0 and get_child_count() > 0:
		_shake = maxf(0.0, _shake - _delta)
		var root := get_child(0) as Control
		if root:
			root.position.x = sin(_shake * 90.0) * 4.0
	_sync_board()
	_set_ride_hint()
	if time_lab:
		var clock := "%0.2f" % GameState.time_sec
		if GameState.start_crossed:
			clock += "  /  %0.0f" % GameState.time_allowed()
		elif GameState.demo_ride:
			clock = "She rides him to the flags"
		else:
			clock = "Ride to the start flags"
		if GameState.time_sec > GameState.time_allowed() and GameState.clock_running:
			var over := int(floor((GameState.time_sec - GameState.time_allowed()) / 4.0))
			if over > 0:
				clock += "  +%d" % over
		time_lab.text = clock
		# scoreboard_pips: the clock goes amber in the last 10 seconds.
		var late := GameState.start_crossed and GameState.time_sec >= GameState.time_allowed() - 10.0
		time_lab.modulate = Color(1.0, 0.72, 0.38) if late else Color(1, 1, 1)
	if best_lab:
		best_lab.text = GameState.class_title()
	if next_lab:
		if GameState.mode == "ride" and not GameState.round_complete:
			next_lab.text = GameState.next_fence_line()
			next_lab.visible = true
		else:
			next_lab.visible = false
	if trainer_lab:
		var line := GameState.trainer_line
		trainer_lab.text = line
		var subs := GameState.settings == null or GameState.settings.subtitles
		trainer_lab.visible = line != "" and subs
		var loud := (
			line.begins_with("Two")
			or line.begins_with("One")
			or line == "Come again."
			or line.begins_with("Now")
			or line.begins_with("Early")
			or line.begins_with("Wait")
			or line.begins_with("Too deep")
		)
		var px := 42 if loud else 22
		if GameState.settings:
			px = int(round(float(px) * GameState.settings.hud_scale))
		trainer_lab.add_theme_font_size_override("font_size", px)
		if loud and font_b:
			trainer_lab.add_theme_font_override("font", font_b)
		elif font:
			trainer_lab.add_theme_font_override("font", font)
		trainer_lab.position = Vector2(48, -156 if loud else -108)
	if gait_lab:
		var h := _horse()
		if h:
			var g := h.gait_name()
			if h.collecting:
				g += "  ·  collected"
			gait_lab.text = g
	_sync_booth()
	_sync_pips()
	_sync_callout(_delta)
	_sync_capture()
	_sync_reins(_delta)
	_sync_result(_delta)
	_sync_veil(_delta)
	var watching := find_child("Watching", true, false)
	if watching:
		watching.visible = (
			GameState.demo_ride
			and GameState.mode == "ride"
			and not GameState.round_complete
			and pause_panel != null
			and not pause_panel.visible
		)


# reins_fade: the card leaves after the first step or 6 seconds. Pause brings it back.
func reset_reins() -> void:
	_reins_t = 0.0
	_reins_fade = 1.0
	_reins_gone = false
	_reins_latched = true


func _sync_reins(delta: float) -> void:
	var body := find_child("ReinsBody", true, false) as Label
	if body != null and GameState.last_device != _reins_device:
		_reins_device = GameState.last_device
		body.text = _reins_copy()
	var reins := find_child("Reins", true, false) as Control
	if reins == null or pause_panel == null or result_panel == null:
		return
	var in_ride := (
		GameState.mode == "ride"
		and not GameState.demo_ride
		and not GameState.round_complete
		and not result_panel.visible
	)
	if not in_ride:
		_reins_t = 0.0
		_reins_fade = 1.0
		_reins_gone = false
		_reins_latched = false
		reins.visible = false
		reins.modulate.a = 1.0
		return
	if pause_panel.visible:
		reins.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
		reins.offset_left = 36.0
		reins.offset_top = -540.0
		reins.offset_right = 560.0
		reins.offset_bottom = -28.0
		reins.z_index = 8
		reins.visible = true
		reins.modulate.a = 1.0
		return
	reins.z_index = 0
	reins.set_anchors_preset(Control.PRESET_CENTER_RIGHT)
	reins.offset_left = -560.0
	reins.offset_top = -250.0
	reins.offset_right = -36.0
	reins.offset_bottom = 250.0
	if not GameState.start_crossed and GameState.time_sec < 0.05 and not _reins_latched:
		_reins_t = 0.0
		_reins_fade = 1.0
		_reins_gone = false
		_reins_latched = true
	if GameState.start_crossed or GameState.time_sec > 0.2:
		_reins_latched = false
	if not GameState.start_crossed:
		_reins_t += delta
		var h := _horse()
		if _reins_t >= 6.0 or (h != null and h.speed > 0.4):
			_reins_gone = true
	else:
		_reins_gone = true
	var want := 0.0 if _reins_gone else 1.0
	_reins_fade = move_toward(_reins_fade, want, delta / 0.45)
	reins.modulate.a = _reins_fade
	reins.visible = _reins_fade > 0.02


func _sync_pips() -> void:
	var row := find_child("FencePips", true, false) as Control
	if row == null:
		return
	var n := GameState.fences_needed()
	if n != _pip_n:
		_pip_n = n
		for c in row.get_children():
			row.remove_child(c)
			c.free()
		var gap := 8.0
		var w := 18.0
		if n > 10:
			w = maxf(8.0, (460.0 - gap * float(n - 1)) / float(maxi(n, 1)))
		for i in n:
			var pip := ColorRect.new()
			pip.position = Vector2(float(i) * (w + gap), 2.0)
			pip.size = Vector2(w, 10.0)
			pip.mouse_filter = Control.MOUSE_FILTER_IGNORE
			row.add_child(pip)
	var jumped := GameState.fences_jumped
	var i := 0
	for c in row.get_children():
		var pip := c as ColorRect
		if pip == null:
			continue
		i += 1
		if i <= jumped:
			pip.color = Color(0.95, 0.90, 0.72)
		elif i == GameState.next_fence and GameState.mode == "ride" and not GameState.round_complete:
			pip.color = Color(0.93, 0.72, 0.32)
		else:
			pip.color = Color(0.42, 0.36, 0.28, 0.9)


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


func _sync_callout(delta: float) -> void:
	if GameState.fault_callout_id != _seen_callout:
		_seen_callout = GameState.fault_callout_id
		_callout_left = 1.8
		if callout_lab:
			callout_lab.text = GameState.fault_callout
	if not GameState.start_crossed:
		_clock_was_on = false
	elif not _clock_was_on:
		_clock_was_on = true
		_go_left = 1.15
	if _callout_left > 0.0:
		_callout_left = maxf(0.0, _callout_left - delta)
	if _go_left > 0.0:
		_go_left = maxf(0.0, _go_left - delta)
	var blocked := (
		(result_panel != null and result_panel.visible)
		or (pause_panel != null and pause_panel.visible)
		or (options_panel != null and options_panel.visible)
	)
	if callout_lab:
		callout_lab.visible = _callout_left > 0.0 and not blocked
		if callout_lab.visible:
			var a := 1.0 if _callout_left > 0.35 else _callout_left / 0.35
			callout_lab.modulate = Color(0.98, 0.90, 0.72, a)
	if go_lab:
		go_lab.visible = _go_left > 0.0 and GameState.start_crossed and not blocked
		if go_lab.visible:
			var ga := 1.0 if _go_left > 0.3 else _go_left / 0.3
			go_lab.modulate = Color(0.96, 0.93, 0.86, ga)
	if _grade_left > 0.0:
		_grade_left = maxf(0.0, _grade_left - delta)
	if grade_lab:
		grade_lab.visible = _grade_left > 0.0 and not blocked
		if grade_lab.visible:
			var base := grade_lab.modulate
			var ga2 := 1.0 if _grade_left > 0.35 else _grade_left / 0.35
			grade_lab.modulate = Color(base.r, base.g, base.b, ga2)


func show_grade(word: String) -> void:
	if grade_lab == null:
		return
	var col := Color(0.96, 0.93, 0.86, 1.0)
	match word:
		"Right on":
			col = Color(0.62, 0.86, 0.48, 1.0)
		"Long spot":
			col = Color(0.95, 0.78, 0.38, 1.0)
		"Deep":
			col = Color(0.95, 0.58, 0.32, 1.0)
		"Chip":
			col = Color(0.90, 0.36, 0.30, 1.0)
		_:
			return
	grade_lab.text = word
	grade_lab.modulate = col
	_grade_left = 1.0
	grade_lab.visible = true


func _sync_capture() -> void:
	if capture_lab:
		capture_lab.visible = _pointer_is_free()


func _pointer_is_free() -> bool:
	for a in OS.get_cmdline_user_args():
		if str(a) == "--shots" or str(a).begins_with("--shots-out="):
			return false
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		return false
	if pause_panel != null and pause_panel.visible:
		return false
	if result_panel != null and result_panel.visible:
		return false
	if options_panel != null and options_panel.visible:
		return false
	return GameState.mode == "ride" or GameState.mode == "walk"


func _horse() -> Horse:
	var n := get_tree().get_first_node_in_group("abbott")
	if n is Horse:
		return n
	return null


func _on_faults(f: int) -> void:
	fault_lab.text = "Faults  %d" % f
	fault_lab.modulate = Color(0.96, 0.93, 0.86) if f == 0 else Color(0.93, 0.55, 0.38)


func _on_finished(f: int, t: float) -> void:
	result_panel.visible = true
	_result_f = f
	_result_time = t
	_result_age = 0.0
	_result_shown = false
	_clear_confetti()
	if f == 0 and not GameState.eliminated:
		_spawn_confetti()
	var stats: Label = result_panel.find_child("Stats", true, false)
	if stats:
		stats.text = "0.00\n0 faults"
	if jump_off_btn:
		jump_off_btn.visible = false
	if next_btn:
		next_btn.visible = false
	var ribbon: ColorRect = result_panel.find_child("Ribbon", true, false)
	var ribbon_name: Label = result_panel.find_child("RibbonName", true, false)
	if ribbon:
		ribbon.visible = false
	if ribbon_name:
		ribbon_name.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# result_count: time, then faults, then the ribbon. A clear round drops confetti.
func _sync_result(delta: float) -> void:
	if _result_age < 0.0 or result_panel == null or not result_panel.visible:
		return
	_result_age += delta
	var stats: Label = result_panel.find_child("Stats", true, false)
	var shown_t := _result_time * clampf(_result_age / 0.7, 0.0, 1.0)
	var shown_f := _result_f if _result_age >= 0.7 else 0
	if stats and not _result_shown:
		stats.text = "%0.2f\n%d faults" % [shown_t, shown_f]
	if _result_age >= 1.05 and not _result_shown:
		_result_shown = true
		_show_result_settled()
	_tick_confetti(delta)
	if _result_age > 2.4:
		_clear_confetti()
		_result_age = -1.0


func _show_result_settled() -> void:
	var stats: Label = result_panel.find_child("Stats", true, false)
	if stats:
		var extra := ""
		if _result_f < GameState.best_faults or (_result_f == GameState.best_faults and is_equal_approx(_result_time, GameState.best_time)):
			extra = "\nNew best."
		var rail := _rail_line()
		var allowed := "%0.0f" % GameState.time_allowed()
		stats.text = "%s%s\n%s\nTime allowed %ss\n%s\n%s%s" % [GameState.result_line(), extra, GameState.class_title(), allowed, GameState.barn_note(), GameState.best_line(), rail]
	if jump_off_btn:
		jump_off_btn.visible = GameState.can_offer_jump_off()
	if next_btn:
		next_btn.visible = _next_class_id() != ""
	var ribbon: ColorRect = result_panel.find_child("Ribbon", true, false)
	var ribbon_name: Label = result_panel.find_child("RibbonName", true, false)
	if ribbon:
		var name := GameState.last_ribbon
		var col := Color(0.18, 0.32, 0.72)
		match name:
			"Blue":
				col = Color(0.16, 0.32, 0.78)
			"Red":
				col = Color(0.72, 0.14, 0.16)
			"Yellow":
				col = Color(0.86, 0.72, 0.18)
			"White":
				col = Color(0.92, 0.90, 0.86)
			"Pink":
				col = Color(0.86, 0.48, 0.58)
			_:
				name = ""
		ribbon.visible = name != ""
		ribbon.color = col
		if ribbon_name:
			ribbon_name.visible = name != ""
			ribbon_name.text = "%s ribbon" % name
			ribbon_name.modulate = col


func _rail_line() -> String:
	if GameState.rail_nums.is_empty():
		return ""
	var bits: PackedStringArray = PackedStringArray()
	for n in GameState.rail_nums:
		bits.append(str(int(n)))
	return "\nRail down at fence %s." % ", ".join(bits)


func _spawn_confetti() -> void:
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	var colors: Array[Color] = [
		Color(0.72, 0.16, 0.18),
		Color(0.93, 0.78, 0.38),
		Color(0.95, 0.93, 0.86),
		Color(0.45, 0.62, 0.34),
	]
	for i in 28:
		var flake := ColorRect.new()
		flake.name = "Confetti"
		flake.mouse_filter = Control.MOUSE_FILTER_IGNORE
		flake.color = colors[i % colors.size()]
		flake.size = Vector2(7, 12)
		flake.position = Vector2(rng.randf_range(80, 1840), rng.randf_range(-40, 80))
		flake.set_meta("vy", rng.randf_range(180, 420))
		flake.set_meta("vx", rng.randf_range(-40, 40))
		result_panel.add_child(flake)


func _tick_confetti(delta: float) -> void:
	if result_panel == null:
		return
	for c in result_panel.get_children():
		if str(c.name) != "Confetti":
			continue
		var flake := c as ColorRect
		if flake == null:
			continue
		var vy := float(flake.get_meta("vy")) + 240.0 * delta
		flake.set_meta("vy", vy)
		flake.position += Vector2(float(flake.get_meta("vx")), vy) * delta


func _clear_confetti() -> void:
	if result_panel == null:
		return
	for c in result_panel.get_children():
		if str(c.name) == "Confetti":
			c.queue_free()


func _next_class_id() -> String:
	var order: PackedStringArray = PackedStringArray(["lesson", "beginner", "intermediate", "advanced"])
	var i := order.find(GameState.class_id)
	if i < 0:
		return ""
	for j in range(i + 1, order.size()):
		var cid: String = order[j]
		if GameState.class_unlocked(cid):
			return cid
	return ""


func _on_mode(m: String) -> void:
	walk_hint.visible = m == "walk"
	fault_lab.visible = m == "ride" or m == "results"
	gait_lab.visible = m == "ride"
	if m == "ride" or m == "walk":
		_kick_fade()
	if m != "results":
		result_panel.visible = false


# scene_fade: a short black fade, then the course name.
func _kick_fade() -> void:
	_veil_dir = 1.0
	_card_left = 1.1
	if _scene_card:
		_scene_card.text = GameState.class_title()


func _sync_veil(delta: float) -> void:
	if _veil == null:
		return
	if _veil_dir > 0.0:
		_veil_a = move_toward(_veil_a, 1.0, delta / 0.15)
		if _veil_a >= 1.0:
			_veil_dir = -1.0
	elif _veil_dir < 0.0:
		_veil_a = move_toward(_veil_a, 0.0, delta / 0.15)
		if _veil_a <= 0.0:
			_veil_dir = 0.0
	_veil.color = Color(0.02, 0.015, 0.01, _veil_a)
	if _card_left > 0.0:
		_card_left = maxf(0.0, _card_left - delta)
	if _scene_card:
		var show := _card_left > 0.15 and _veil_a < 0.45
		_scene_card.visible = show
		_scene_card.modulate.a = 1.0 if _card_left > 0.35 else _card_left / 0.35


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
		var resume := pause_panel.find_child("Resume", true, false) as Control
		if resume:
			resume.grab_focus()
