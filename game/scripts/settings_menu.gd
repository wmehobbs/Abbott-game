extends VBoxContainer
class_name SettingsMenu

## Sound, picture, and (from pause) the key list. Saves user://settings.cfg only in a real session.

signal back_pressed
signal rebind_asked(action: String)

var show_controls: bool = true


## Opens on the options home. Sound, picture, and controls are pages under it.
func _ready() -> void:
	add_theme_constant_override("separation", 8)
	show_page("home")


## Rebuilds one page and puts the focus on its first button, so a pad is never lost.
func show_page(page: String) -> void:
	for c in get_children():
		remove_child(c)
		c.free()
	match page:
		"sound":
			_sound()
		"picture":
			_picture()
		"controls":
			_controls()
		_:
			_home()
	var first := _first_button()
	if first and is_visible_in_tree():
		first.grab_focus()


## Sound, picture, controls when pause asked for them, and back.
func _home() -> void:
	_heading("Options")
	_action("Sound", func() -> void: show_page("sound"))
	_action("Picture", func() -> void: show_page("picture"))
	if show_controls:
		_action("Controls", func() -> void: show_page("controls"))
	_action("Back", func() -> void: back_pressed.emit())


## One slider per bus. The names are hers, not the bus names.
func _sound() -> void:
	_heading("Sound")
	_db("Master", "master_db")
	_db("Music", "music_db")
	_db("Hooves and fences", "sfx_db")
	_db("Barn", "ambience_db")
	_db("Voices", "voice_db")
	_db("Menu clicks", "ui_db")
	_action("Back", func() -> void: show_page("home"))


## Look, camera, the riding aid, and the picture. Quality is its own row under them.
func _picture() -> void:
	_heading("Picture")
	_slider("Look left and right", 0.03, 0.16, 0.01, "mouse_sensitivity", false)
	_check("Invert look", "invert_look")
	_check("Horse bob", "camera_bob")
	_slider("Camera motion", 0.0, 100.0, 5.0, "camera_motion", false)
	_check("Riding aid", "riding_aid")
	_check("Controller rumble", "rumble")
	_slider("Field of view", 42.0, 62.0, 1.0, "fov", false)
	_check("Fullscreen", "fullscreen")
	_check("VSync", "vsync")
	_slider("Sharpness", 0.5, 1.0, 0.05, "render_scale", false)
	_heading("Quality")
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 8)
	add_child(row)
	_quality(row, "Low")
	_quality(row, "Medium")
	_quality(row, "High")
	_check("Show Michelle's lines", "subtitles")
	_slider("HUD size", 0.8, 1.6, 0.1, "hud_scale", false)
	_action("Back", func() -> void: show_page("home"))


## One button per ride key, showing what it is bound to. Pressing one waits for a new key.
func _controls() -> void:
	_heading("Controls")
	var rows: Array = [
		["gait_up", "Gait up"],
		["gait_down", "Gait down"],
		["turn_left", "Steer left"],
		["turn_right", "Steer right"],
		["jump", "Half-halt / ask"],
		["halt", "Halt"],
		["walk_mode", "Walk on foot"],
		["mount", "Mount"],
		["pause", "Pause"],
	]
	for r in rows:
		var action: String = str(r[0])
		var label: String = str(r[1])
		var b := Button.new()
		b.text = "%s   ·   %s" % [label, GameState.key_name(action)]
		b.custom_minimum_size = Vector2(520, 44)
		b.add_theme_font_size_override("font_size", 18)
		_style(b)
		var act := action
		b.pressed.connect(func() -> void:
			b.text = "%s   ·   press a key" % label
			rebind_asked.emit(act)
		)
		add_child(b)
	_action("Back", func() -> void: show_page("home"))


## A bus slider, in decibels, written through as soon as it moves.
func _db(label: String, field: String) -> void:
	_slider(label, -24.0, 6.0, 1.0, field, true)


## A labelled slider. Audio ones apply the mix immediately. Every move is saved.
func _slider(label: String, lo: float, hi: float, step: float, field: String, audio: bool) -> void:
	var s := _settings()
	var lab := Label.new()
	lab.add_theme_font_size_override("font_size", 18)
	lab.add_theme_color_override("font_color", Color(0.93, 0.88, 0.76))
	var slider := HSlider.new()
	slider.min_value = lo
	slider.max_value = hi
	slider.step = step
	slider.custom_minimum_size = Vector2(360, 28)
	var value := lo
	if s:
		value = float(s.get(field))
	slider.value = clampf(value, lo, hi)
	lab.text = _slider_text(label, slider.value, audio)
	slider.value_changed.connect(func(v: float) -> void:
		var live := _settings()
		if live == null:
			return
		live.set(field, v)
		lab.text = _slider_text(label, v, audio)
		if audio:
			live.apply_audio()
		live.commit()
		_refresh_hud()
	)
	add_child(lab)
	add_child(slider)


## The line beside a slider: decibels, a percent, or the plain number.
func _slider_text(label: String, v: float, audio: bool) -> String:
	if audio:
		return "%s   %d dB" % [label, int(round(v))]
	if label == "Field of view":
		return "Field of view   %d" % int(round(v))
	if label == "Sharpness":
		return "Sharpness   %d%%" % int(round(v * 100.0))
	if label == "HUD size":
		return "HUD size   %d%%" % int(round(v * 100.0))
	return "%s   %0.2f" % [label, v]


## A yes or no. It saves as soon as it toggles.
func _check(label: String, field: String) -> void:
	var b := CheckButton.new()
	b.text = label
	b.custom_minimum_size = Vector2(360, 44)
	b.add_theme_font_size_override("font_size", 18)
	var s := _settings()
	b.button_pressed = bool(s.get(field)) if s else false
	b.toggled.connect(func(on: bool) -> void:
		var live := _settings()
		if live == null:
			return
		live.set(field, on)
		live.commit()
		_refresh_hud()
	)
	add_child(b)


## One quality button. The current one is warmer, and picking one rebuilds the page.
func _quality(row: HBoxContainer, name: String) -> void:
	var b := Button.new()
	b.name = name
	b.text = name
	b.custom_minimum_size = Vector2(120, 44)
	b.add_theme_font_size_override("font_size", 18)
	_style(b)
	var s := _settings()
	if s and s.quality == name:
		b.modulate = Color(1.0, 0.92, 0.7)
	var picked := name
	b.pressed.connect(func() -> void:
		var live := _settings()
		if live == null:
			return
		live.quality = picked
		live.commit()
		call_deferred("show_page", "picture")
	)
	row.add_child(b)


## The page title.
func _heading(text: String) -> void:
	var lab := Label.new()
	lab.text = text
	lab.add_theme_font_size_override("font_size", 32)
	lab.add_theme_color_override("font_color", Color(0.96, 0.93, 0.86))
	add_child(lab)


## A menu button. The click sound plays, then the page changes.
func _action(text: String, cb: Callable) -> void:
	var b := Button.new()
	b.name = text
	b.text = text
	b.custom_minimum_size = Vector2(360, 52)
	b.add_theme_font_size_override("font_size", 22)
	_style(b)
	b.pressed.connect(func() -> void:
		_click()
		cb.call()
	)
	add_child(b)


## The dark button with a brass edge, same as the rest of the menus.
func _style(b: Button) -> void:
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
	var sbh: StyleBoxFlat = sb.duplicate() as StyleBoxFlat
	sbh.bg_color = Color(0.22, 0.16, 0.08, 0.95)
	b.add_theme_stylebox_override("hover", sbh)


## The live settings. Never the ride save.
func _settings() -> PlayerSettings:
	return GameState.settings


## HUD size is read by whoever owns this menu. Walk up until someone applies it.
func _refresh_hud() -> void:
	var n: Node = self
	while n:
		if n.has_method("apply_hud_scale"):
			n.call("apply_hud_scale")
			return
		n = n.get_parent()


## The first button on the page, including one sitting in a row. A pad lands here.
func _first_button() -> Button:
	for c in get_children():
		if c is Button:
			return c
		if c is HBoxContainer:
			for h in c.get_children():
				if h is Button:
					return h
	return null


## The menu click, on the UI bus, and freed when it finishes.
func _click() -> void:
	if not ResourceLoader.exists("res://assets/audio/ui.wav"):
		return
	var p := AudioStreamPlayer.new()
	p.bus = "UI"
	p.stream = load("res://assets/audio/ui.wav")
	add_child(p)
	p.finished.connect(p.queue_free)
	p.play()
