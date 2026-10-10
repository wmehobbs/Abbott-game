extends Control

var serif: FontFile
var serif_b: FontFile
var sans: FontFile


## Fonts, the theme, and the card. A self-test or a shot stays here. A headless ride goes straight to the arena.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	serif = load("res://assets/fonts/LibreBaskerville-Regular.ttf")
	serif_b = load("res://assets/fonts/LibreBaskerville-Bold.ttf")
	sans = load("res://assets/fonts/SourceSans3-Regular.ttf")
	theme = load("res://assets/ui/abbott_theme.tres")
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
		a.bus = "Ambience"
		a.autoplay = true
		add_child(a)
	if _selftest_requested() and get_tree().current_scene == self:
		var test_script: GDScript = load("res://scripts/selftest.gd") as GDScript
		var test: Node = test_script.new() as Node
		test.name = "Selftest"
		add_child(test)
		return
	if _shots_requested():
		var shot_script: GDScript = load("res://scripts/shots.gd") as GDScript
		var shots: Node = shot_script.new() as Node
		shots.name = "Shots"
		add_child(shots)
		return
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


## The card: her best line, the barn note, and the way in. Lesson is the gold button.
func _build() -> void:
	var bg := TextureRect.new()
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	bg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	bg.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	# Abbott in ink and watercolour, drawn from his stall photo (the photo is
	# kept beside it), on paper, his whole head to the height of the screen.
	var tex_path := "res://assets/photos/abbott_title_drawn.jpg"
	if not ResourceLoader.exists(tex_path):
		tex_path = "res://assets/photos/abbott_title.jpg"
	if ResourceLoader.exists(tex_path):
		bg.texture = load(tex_path)
	# Fine pen lines shimmer when drawn smaller than the image without
	# mipmaps, most of all through the slow push-in.
	bg.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
	bg.modulate = Color(1, 1, 1)
	add_child(bg)
	# A slow push-in on him and back, so the first screen breathes. Off when
	# the player has turned camera motion down.
	var calm := GameState.settings != null and GameState.settings.camera_motion < 10.0
	if not calm:
		bg.resized.connect(func() -> void: bg.pivot_offset = bg.size * 0.5)
		var tw := create_tween().set_loops()
		tw.tween_property(bg, "scale", Vector2.ONE * 1.07, 26.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tw.tween_property(bg, "scale", Vector2.ONE, 26.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	var shade := ColorRect.new()
	shade.set_anchors_preset(Control.PRESET_FULL_RECT)
	# A light hand: the drawing is on pale paper, not a dark photo.
	shade.color = Color(0.02, 0.015, 0.01, 0.06)
	add_child(shade)

	var bottom := ColorRect.new()
	bottom.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	bottom.offset_top = -400
	# Nearly solid, warm dark brown: see-through grey went muddy over the paper.
	bottom.color = Color(0.085, 0.062, 0.042, 0.93)
	add_child(bottom)

	var stack := VBoxContainer.new()
	stack.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	stack.offset_left = 64
	stack.offset_right = -48
	stack.offset_top = -380
	stack.offset_bottom = -24
	stack.add_theme_constant_override("separation", 6)
	add_child(stack)

	var title := Label.new()
	title.text = "ABBOTT"
	title.custom_minimum_size = Vector2(0, 96)
	if serif_b:
		title.add_theme_font_override("font", serif_b)
	title.add_theme_font_size_override("font_size", 84)
	title.add_theme_color_override("font_color", Color(0.96, 0.93, 0.86))
	title.add_theme_color_override("font_outline_color", Color(0.05, 0.04, 0.03, 0.85))
	title.add_theme_constant_override("outline_size", 8)
	stack.add_child(title)

	var stamp := Label.new()
	stamp.text = "Hidden K Stables"
	stamp.set_anchors_preset(Control.PRESET_TOP_LEFT)
	stamp.position = Vector2(72, 36)
	stamp.size = Vector2(900, 40)
	if serif_b:
		stamp.add_theme_font_override("font", serif_b)
	stamp.add_theme_font_size_override("font_size", 28)
	# Printed on the paper in the drawing's sepia ink.
	stamp.add_theme_color_override("font_color", Color(0.29, 0.20, 0.12))
	add_child(stamp)
	var ver := Label.new()
	ver.text = "2.348.0.0"
	ver.set_anchors_preset(Control.PRESET_TOP_LEFT)
	ver.position = Vector2(72, 72)
	ver.size = Vector2(400, 28)
	if sans:
		ver.add_theme_font_override("font", sans)
	ver.add_theme_font_size_override("font_size", 16)
	ver.add_theme_color_override("font_color", Color(0.40, 0.31, 0.22, 0.85))
	add_child(ver)

	var sub := Label.new()
	sub.text = "See a distance. Leave with him.  ·  Table A  ·  Hidden K Stables  ·  Pfafftown"
	if serif:
		sub.add_theme_font_override("font", serif)
	sub.add_theme_font_size_override("font_size", 22)
	sub.add_theme_color_override("font_color", Color(0.82, 0.74, 0.58))
	stack.add_child(sub)

	var best := Label.new()
	best.name = "BestLine"
	best.text = GameState.class_best_display()
	best.visible = best.text != ""
	if sans:
		best.add_theme_font_override("font", sans)
	best.add_theme_font_size_override("font_size", 24)
	best.add_theme_color_override("font_color", Color(0.92, 0.87, 0.76))
	stack.add_child(best)

	var note := Label.new()
	note.text = GameState.barn_note()
	note.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	if sans:
		note.add_theme_font_override("font", sans)
	note.add_theme_font_size_override("font_size", 22)
	note.add_theme_color_override("font_color", Color(0.88, 0.82, 0.70))
	stack.add_child(note)

	var row := HFlowContainer.new()
	row.add_theme_constant_override("h_separation", 12)
	row.add_theme_constant_override("v_separation", 10)
	stack.add_child(row)
	_btn(row, "Lesson", _go_lesson)
	_btn(row, "Watch a round", _watch_round, 240.0)
	_btn(row, "School Abbott", func() -> void: _open_pick("schooling"))
	_btn(row, "Show day", func() -> void: _open_pick("show"))
	_btn(row, "Walk", _walk)
	_btn(row, "Season", _open_season)
	_btn(row, "Options", _open_options)
	_btn(row, "Quit", _quit)
	var lesson: Button = row.get_child(0) as Button
	if lesson:
		# The way in: a gold button, so a new rider knows where to start.
		var gold := StyleBoxFlat.new()
		gold.bg_color = Color(0.66, 0.50, 0.22, 0.96)
		gold.border_color = Color(0.94, 0.82, 0.52)
		gold.set_border_width_all(2)
		gold.content_margin_left = 20
		gold.content_margin_right = 20
		var gold_hi := gold.duplicate() as StyleBoxFlat
		gold_hi.bg_color = Color(0.76, 0.59, 0.27, 1.0)
		lesson.add_theme_stylebox_override("normal", gold)
		lesson.add_theme_stylebox_override("hover", gold_hi)
		lesson.add_theme_stylebox_override("pressed", gold_hi)
		lesson.add_theme_stylebox_override("focus", gold_hi)
		# Dark lettering: cream on this gold was under 3.5:1, dark is over 6.
		for c in ["font_color", "font_focus_color", "font_hover_color", "font_pressed_color", "font_hover_pressed_color"]:
			lesson.add_theme_color_override(c, Color(0.12, 0.08, 0.03))
		if sans:
			var heavy := FontVariation.new()
			heavy.base_font = sans
			heavy.variation_embolden = 0.6
			lesson.add_theme_font_override("font", heavy)
		lesson.grab_focus()

	var help := Label.new()
	help.name = "Help"
	help.text = GameState.control_line()
	help.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	if sans:
		help.add_theme_font_override("font", sans)
	help.add_theme_font_size_override("font_size", 20)
	help.add_theme_color_override("font_color", Color(0.86, 0.80, 0.68))
	stack.add_child(help)

	_build_pick()
	_build_season()
	_build_options()
	if GameState._skip_save_reason() == "":
		GameState.settings.apply_display()


var pick_kind: String = "schooling"
var pick_panel: Control
var opt_panel: Control
var season_panel: Control


## Sound and picture over the title. Controls stay on the pause menu, not here.
func _build_options() -> void:
	opt_panel = Control.new()
	opt_panel.name = "TitleOptions"
	opt_panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	opt_panel.visible = false
	add_child(opt_panel)
	var dim := ColorRect.new()
	dim.set_anchors_preset(Control.PRESET_FULL_RECT)
	dim.color = Color(0.02, 0.015, 0.01, 0.72)
	dim.mouse_filter = Control.MOUSE_FILTER_STOP
	opt_panel.add_child(dim)
	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	opt_panel.add_child(center)
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
	var menu: SettingsMenu = SettingsMenu.new()
	menu.name = "SettingsMenu"
	menu.show_controls = false
	menu.back_pressed.connect(_close_options)
	card.add_child(menu)


## Shows the options card and takes the title buttons off, so a pad cannot press through it.
func _open_options() -> void:
	opt_panel.visible = true
	_title_buttons(false)
	var menu: SettingsMenu = opt_panel.find_child("SettingsMenu", true, false) as SettingsMenu
	if menu:
		menu.show_page("home")


## Back to the title, with Lesson focused again.
func _close_options() -> void:
	opt_panel.visible = false
	_title_buttons(true)
	var lesson: Button = find_child("Lesson", true, false) as Button
	if lesson:
		lesson.grab_focus()


## Enables or disables the title buttons. Buttons inside a card are left alone.
func _title_buttons(on: bool) -> void:
	for n in find_children("*", "Button", true, false):
		var b: Button = n as Button
		if b == null or (opt_panel != null and opt_panel.is_ancestor_of(b)):
			continue
		if season_panel != null and season_panel.is_ancestor_of(b):
			continue
		b.disabled = not on


## The season card, empty until it is opened. It scrolls, because the classes do not fit.
func _build_season() -> void:
	season_panel = Control.new()
	season_panel.name = "SeasonPanel"
	season_panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	season_panel.visible = false
	add_child(season_panel)
	var dim := ColorRect.new()
	dim.set_anchors_preset(Control.PRESET_FULL_RECT)
	dim.color = Color(0.02, 0.015, 0.01, 0.72)
	dim.mouse_filter = Control.MOUSE_FILTER_STOP
	season_panel.add_child(dim)
	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	season_panel.add_child(center)
	var card := PanelContainer.new()
	var sb := StyleBoxFlat.new()
	sb.bg_color = Color(0.07, 0.05, 0.03, 0.9)
	sb.border_color = Color(0.72, 0.58, 0.32, 0.9)
	sb.set_border_width_all(1)
	sb.set_corner_radius_all(6)
	sb.content_margin_left = 18
	sb.content_margin_right = 18
	sb.content_margin_top = 14
	sb.content_margin_bottom = 14
	card.add_theme_stylebox_override("panel", sb)
	center.add_child(card)
	var scroll := ScrollContainer.new()
	scroll.custom_minimum_size = Vector2(760, 480)
	card.add_child(scroll)
	var box := VBoxContainer.new()
	box.name = "SeasonBox"
	box.add_theme_constant_override("separation", 8)
	scroll.add_child(box)


## Fills the season from her record and focuses the first class she can ride.
func _open_season() -> void:
	_fill_season()
	season_panel.visible = true
	_title_buttons(false)
	var box: Node = season_panel.find_child("SeasonBox", true, false)
	if box:
		for c in box.get_children():
			if c is Button and not (c as Button).disabled:
				(c as Button).grab_focus()
				break


## Closes the season card and puts the focus back on Lesson.
func _close_season() -> void:
	season_panel.visible = false
	_title_buttons(true)
	var lesson: Button = find_child("Lesson", true, false) as Button
	if lesson:
		lesson.grab_focus()


## One row per class: lessons, schooling, show day. A locked row cannot be pressed.
func _fill_season() -> void:
	var box: VBoxContainer = season_panel.find_child("SeasonBox", true, false)
	if box == null:
		return
	for c in box.get_children():
		c.free()
	var head := Label.new()
	head.text = "Season"
	if serif_b:
		head.add_theme_font_override("font", serif_b)
	head.add_theme_font_size_override("font_size", 36)
	head.add_theme_color_override("font_color", Color(0.96, 0.93, 0.86))
	box.add_child(head)
	var rows: Array = GameState.season_rows()
	var last_kind := ""
	for row in rows:
		var kind := str(row.get("kind", ""))
		if kind != last_kind:
			last_kind = kind
			var section := Label.new()
			section.text = "Lessons" if kind == "lesson" else ("Show day" if kind == "show" else "Schooling")
			if sans:
				section.add_theme_font_override("font", sans)
			section.add_theme_font_size_override("font_size", 18)
			section.add_theme_color_override("font_color", Color(0.82, 0.74, 0.58))
			box.add_child(section)
		var state := str(row.get("state", "locked"))
		var detail := str(row.get("detail", ""))
		var text := "%s   ·   %s" % [str(row.get("title", "")), state]
		if detail != "":
			text = "%s   ·   %s" % [text, detail]
		var b := Button.new()
		b.text = text
		b.disabled = state == "locked"
		b.custom_minimum_size = Vector2(720, 44)
		if sans:
			b.add_theme_font_override("font", sans)
		b.add_theme_font_size_override("font_size", 18)
		var captured: Dictionary = (row as Dictionary).duplicate()
		b.pressed.connect(_start_season.bind(captured))
		box.add_child(b)
	var back := Button.new()
	back.name = "SeasonBack"
	back.text = "Back"
	back.custom_minimum_size = Vector2(220, 48)
	if sans:
		back.add_theme_font_override("font", sans)
	back.add_theme_font_size_override("font_size", 20)
	back.pressed.connect(_close_season)
	box.add_child(back)


## Starts the class on that row and goes to the arena. A locked row does nothing.
func _start_season(row: Dictionary) -> void:
	if str(row.get("state", "")) == "locked":
		return
	var kind := str(row.get("kind", ""))
	var cid := str(row.get("class_id", ""))
	_ui()
	if kind == "lesson":
		if not GameState.start_session("lesson", "lesson"):
			return
		GameState.course_seed = int(row.get("seed", 0))
	else:
		var session := "show" if kind == "show" else "schooling"
		if not GameState.start_session(session, cid):
			return
	GameState.set_mode("ride")
	get_tree().change_scene_to_file("res://scenes/arena.tscn")


## The height card, hidden until School or Show day asks for it.
func _build_pick() -> void:
	pick_panel = Control.new()
	pick_panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	pick_panel.visible = false
	add_child(pick_panel)
	var dim := ColorRect.new()
	dim.set_anchors_preset(Control.PRESET_FULL_RECT)
	dim.color = Color(0.02, 0.015, 0.01, 0.72)
	pick_panel.add_child(dim)
	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	pick_panel.add_child(center)
	var box := VBoxContainer.new()
	box.name = "PickBox"
	box.add_theme_constant_override("separation", 12)
	center.add_child(box)


## Lists the classes for schooling or for show day. A locked one is shown, and it cannot be pressed.
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


## A lesson, then the arena. If the session will not start, she stays on the title.
func _go_lesson() -> void:
	_ui()
	if not GameState.start_session("lesson", "lesson"):
		return
	GameState.set_mode("ride")
	get_tree().change_scene_to_file("res://scenes/arena.tscn")


## Watch a round: a beginner show at the first course, ridden for her. Not her save.
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


## The class she picked, then the arena. A locked class leaves her on the card.
func _go_ride(cid: String) -> void:
	_ui()
	if not GameState.start_session(pick_kind, cid):
		return
	GameState.set_mode("ride")
	get_tree().change_scene_to_file("res://scenes/arena.tscn")


## A title button. The click plays, then it does the thing.
func _btn(parent: Node, text: String, cb: Callable, wide: float = 200.0) -> void:
	var b := Button.new()
	b.name = text
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


## True only for the self-test arg. The game then stays on this scene and runs the checks.
func _selftest_requested() -> bool:
	for a in OS.get_cmdline_user_args():
		if str(a) == "--selftest":
			return true
	return false


## True for the still-camera pass. That one is for people, and it must not write her save.
func _shots_requested() -> bool:
	for a in OS.get_cmdline_user_args():
		if str(a) == "--shots" or str(a).begins_with("--shots-out="):
			return true
	return false


## The menu click, on the UI bus.
func _ui() -> void:
	if ResourceLoader.exists("res://assets/audio/ui.wav"):
		var p := AudioStreamPlayer.new()
		p.bus = "UI"
		p.stream = load("res://assets/audio/ui.wav")
		add_child(p)
		p.play()


## Opens the arena in ride mode. Nothing here starts a class.
func _play() -> void:
	GameState.set_mode("ride")
	get_tree().change_scene_to_file("res://scenes/arena.tscn")


## Into the arena on foot, to walk the course before she mounts.
func _walk() -> void:
	GameState.set_mode("walk")
	get_tree().change_scene_to_file("res://scenes/arena.tscn")


## Escape or the pause key leaves the game from the title.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") or (event is InputEventKey and event.pressed and event.physical_keycode == KEY_ESCAPE):
		get_tree().quit()


## The Quit button.
func _quit() -> void:
	get_tree().quit()
