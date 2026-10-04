extends Control

var serif: FontFile
var serif_b: FontFile
var sans: FontFile


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	serif = load("res://assets/fonts/LibreBaskerville-Regular.ttf")
	serif_b = load("res://assets/fonts/LibreBaskerville-Bold.ttf")
	sans = load("res://assets/fonts/SourceSans3-Regular.ttf")
	set_anchors_preset(Control.PRESET_FULL_RECT)
	_build()
	if ResourceLoader.exists("res://assets/audio/ambient_outdoor.wav"):
		var a := AudioStreamPlayer.new()
		a.stream = load("res://assets/audio/ambient_outdoor.wav")
		if a.stream is AudioStreamWAV:
			var wav: AudioStreamWAV = (a.stream as AudioStreamWAV).duplicate()
			wav.loop_mode = AudioStreamWAV.LOOP_FORWARD
			a.stream = wav
		a.volume_db = -6.0
		a.autoplay = true
		add_child(a)
	if (
		"--playtest" in OS.get_cmdline_user_args()
		or "--hear" in OS.get_cmdline_user_args()
		or "--stride" in OS.get_cmdline_user_args()
		or "--leave-sweep" in OS.get_cmdline_user_args()
		or "--artshot" in OS.get_cmdline_user_args()
		or "--ridecert" in OS.get_cmdline_user_args()
	):
		GameState.set_mode("ride")
		get_tree().change_scene_to_file.call_deferred("res://scenes/arena.tscn")


func _build() -> void:
	var bg := TextureRect.new()
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	bg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	bg.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	var tex_path := "res://assets/photos/abbott_title.jpg"
	if ResourceLoader.exists(tex_path):
		bg.texture = load(tex_path)
	bg.modulate = Color(1, 1, 1)
	add_child(bg)

	var shade := ColorRect.new()
	shade.set_anchors_preset(Control.PRESET_FULL_RECT)
	shade.color = Color(0.02, 0.015, 0.01, 0.18)
	add_child(shade)

	var bottom := ColorRect.new()
	bottom.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	bottom.offset_top = -340
	bottom.color = Color(0.03, 0.025, 0.018, 0.72)
	add_child(bottom)

	var title := Label.new()
	title.text = "ABBOTT"
	title.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
	title.position = Vector2(72, -300)
	title.size = Vector2(900, 90)
	if serif_b:
		title.add_theme_font_override("font", serif_b)
	title.add_theme_font_size_override("font_size", 84)
	title.add_theme_color_override("font_color", Color(0.96, 0.93, 0.86))
	title.add_theme_color_override("font_outline_color", Color(0.05, 0.04, 0.03, 0.85))
	title.add_theme_constant_override("outline_size", 8)
	add_child(title)

	var stamp := Label.new()
	stamp.text = "SUN OCT 4  ·  2.348.0.0"
	stamp.set_anchors_preset(Control.PRESET_TOP_LEFT)
	stamp.position = Vector2(72, 36)
	stamp.size = Vector2(900, 40)
	if serif_b:
		stamp.add_theme_font_override("font", serif_b)
	stamp.add_theme_font_size_override("font_size", 28)
	stamp.add_theme_color_override("font_color", Color(0.98, 0.86, 0.32))
	stamp.add_theme_color_override("font_outline_color", Color(0.05, 0.04, 0.03, 0.95))
	stamp.add_theme_constant_override("outline_size", 8)
	add_child(stamp)

	var sub := Label.new()
	sub.text = "See a distance. Leave with him.  ·  Table A  ·  Hidden K Stables  ·  Pfafftown"
	sub.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
	sub.position = Vector2(76, -214)
	sub.size = Vector2(900, 40)
	if serif:
		sub.add_theme_font_override("font", serif)
	sub.add_theme_font_size_override("font_size", 22)
	sub.add_theme_color_override("font_color", Color(0.82, 0.74, 0.58))
	add_child(sub)

	var best := Label.new()
	best.text = GameState.best_line()
	best.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
	best.position = Vector2(76, -178)
	best.size = Vector2(900, 32)
	if sans:
		best.add_theme_font_override("font", sans)
	best.add_theme_font_size_override("font_size", 20)
	best.add_theme_color_override("font_color", Color(0.78, 0.72, 0.62))
	add_child(best)

	var note := Label.new()
	note.text = GameState.barn_note()
	note.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
	note.position = Vector2(76, -148)
	note.size = Vector2(1100, 28)
	if sans:
		note.add_theme_font_override("font", sans)
	note.add_theme_font_size_override("font_size", 18)
	note.add_theme_color_override("font_color", Color(0.80, 0.74, 0.60))
	add_child(note)

	var row := HBoxContainer.new()
	row.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
	row.position = Vector2(72, -112)
	row.add_theme_constant_override("separation", 14)
	add_child(row)
	_btn(row, "Lesson", _go_lesson)
	_btn(row, "Watch a round", _watch_round, 260.0)
	_btn(row, "School Abbott", func() -> void: _open_pick("schooling"))
	_btn(row, "Show day", func() -> void: _open_pick("show"))
	_btn(row, "Walk", _walk)
	_btn(row, "Quit", _quit)

	var help := Label.new()
	help.text = "W/S gait   A/D steer   Space half-halt (hold to collect, release to ask)   Shift halt"
	help.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
	help.position = Vector2(76, -48)
	help.size = Vector2(1200, 32)
	if sans:
		help.add_theme_font_override("font", sans)
	help.add_theme_font_size_override("font_size", 18)
	help.add_theme_color_override("font_color", Color(0.78, 0.72, 0.62))
	add_child(help)

	_build_pick()


var pick_kind: String = "schooling"
var pick_panel: Control


func _build_pick() -> void:
	pick_panel = Control.new()
	pick_panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	pick_panel.visible = false
	add_child(pick_panel)
	var dim := ColorRect.new()
	dim.set_anchors_preset(Control.PRESET_FULL_RECT)
	dim.color = Color(0.02, 0.015, 0.01, 0.72)
	pick_panel.add_child(dim)
	var box := VBoxContainer.new()
	box.name = "PickBox"
	box.position = Vector2(72, 220)
	box.add_theme_constant_override("separation", 12)
	pick_panel.add_child(box)


func _open_pick(kind: String) -> void:
	pick_kind = kind
	GameState.session_kind = kind
	var box: VBoxContainer = pick_panel.find_child("PickBox", true, false)
	for c in box.get_children():
		c.queue_free()
	var head := Label.new()
	head.text = "Hidden K Schooling Show  ·  Table A" if kind == "show" else "Schooling  ·  pick a height"
	if serif_b:
		head.add_theme_font_override("font", serif_b)
	head.add_theme_font_size_override("font_size", 36)
	head.add_theme_color_override("font_color", Color(0.96, 0.93, 0.86))
	box.add_child(head)
	var ids: PackedStringArray = PackedStringArray(["beginner", "intermediate", "advanced"])
	for idx in range(ids.size()):
		var cid: String = ids[idx]
		var i: Dictionary = GameState.CLASS_INFO[cid]
		var unlocked: bool = GameState.class_unlocked(cid)
		var label: String = String(i["show_name"] if kind == "show" else i["name"])
		var rec: String = GameState.class_best_line(cid)
		var t: String = "%s   ·   %s   ·   %s" % [label, String(i["height"]), rec]
		if not unlocked:
			t = "%s   ·   %s   ·   locked" % [label, String(i["height"])]
		var b := Button.new()
		b.text = t
		b.custom_minimum_size = Vector2(720, 52)
		b.disabled = not unlocked
		if sans:
			b.add_theme_font_override("font", sans)
		b.add_theme_font_size_override("font_size", 22)
		b.add_theme_color_override("font_color", Color(0.96, 0.93, 0.86))
		var sb := StyleBoxFlat.new()
		sb.bg_color = Color(0.10, 0.08, 0.05, 0.92)
		sb.border_color = Color(0.72, 0.58, 0.32)
		sb.set_border_width_all(1)
		sb.content_margin_left = 18
		b.add_theme_stylebox_override("normal", sb)
		var sbh := sb.duplicate()
		sbh.bg_color = Color(0.24, 0.17, 0.08, 0.95)
		b.add_theme_stylebox_override("hover", sbh)
		box.add_child(b)
		b.pressed.connect(_go_ride.bind(cid))
	var back := Button.new()
	back.text = "Back"
	back.custom_minimum_size = Vector2(220, 48)
	if sans:
		back.add_theme_font_override("font", sans)
	back.add_theme_font_size_override("font_size", 20)
	box.add_child(back)
	back.pressed.connect(func() -> void:
		pick_panel.visible = false
	)
	pick_panel.visible = true


func _go_lesson() -> void:
	_ui()
	if not GameState.start_session("lesson", "lesson"):
		return
	GameState.set_mode("ride")
	get_tree().change_scene_to_file("res://scenes/arena.tscn")


func _watch_round() -> void:
	_ui()
	GameState.demo_ride = true
	if not GameState.start_session("show", "beginner"):
		GameState.demo_ride = false
		return
	GameState.course_seed = 0
	GameState.jump_off = false
	GameState.set_mode("ride")
	get_tree().change_scene_to_file("res://scenes/arena.tscn")


func _go_ride(cid: String) -> void:
	_ui()
	if not GameState.start_session(pick_kind, cid):
		return
	GameState.set_mode("ride")
	get_tree().change_scene_to_file("res://scenes/arena.tscn")


func _btn(parent: Node, text: String, cb: Callable, wide: float = 200.0) -> void:
	var b := Button.new()
	b.text = text
	b.custom_minimum_size = Vector2(wide, 54)
	if sans:
		b.add_theme_font_override("font", sans)
	b.add_theme_font_size_override("font_size", 22)
	b.add_theme_color_override("font_color", Color(0.96, 0.93, 0.86))
	b.add_theme_color_override("font_hover_color", Color(1, 0.95, 0.8))
	var sb := StyleBoxFlat.new()
	sb.bg_color = Color(0.10, 0.08, 0.05, 0.88)
	sb.border_color = Color(0.72, 0.58, 0.32)
	sb.set_border_width_all(1)
	sb.content_margin_left = 20
	sb.content_margin_right = 20
	b.add_theme_stylebox_override("normal", sb)
	var sbh := sb.duplicate()
	sbh.bg_color = Color(0.24, 0.17, 0.08, 0.95)
	b.add_theme_stylebox_override("hover", sbh)
	b.add_theme_stylebox_override("pressed", sbh)
	parent.add_child(b)
	b.pressed.connect(func() -> void:
		_ui()
		cb.call()
	)


func _ui() -> void:
	if ResourceLoader.exists("res://assets/audio/ui.wav"):
		var p := AudioStreamPlayer.new()
		p.stream = load("res://assets/audio/ui.wav")
		add_child(p)
		p.play()


func _play() -> void:
	GameState.set_mode("ride")
	get_tree().change_scene_to_file("res://scenes/arena.tscn")


func _walk() -> void:
	GameState.set_mode("walk")
	get_tree().change_scene_to_file("res://scenes/arena.tscn")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") or (event is InputEventKey and event.pressed and event.physical_keycode == KEY_ESCAPE):
		get_tree().quit()


func _quit() -> void:
	get_tree().quit()
