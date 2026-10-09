extends Node
class_name PlayerSettings

## user://settings.cfg. Never the ride save. Tests pass their own path.

const PATH := "user://settings.cfg"
const BUSES: Array[String] = ["Master", "Music", "SFX", "Ambience", "Voice", "UI"]

var master_db: float = 0.0
var music_db: float = 0.0
var sfx_db: float = 0.0
var ambience_db: float = 0.0
var voice_db: float = 0.0
var ui_db: float = 0.0
var mouse_sensitivity: float = 0.07
var invert_look: bool = false
var camera_bob: bool = true
var camera_motion: float = 70.0
var riding_aid: bool = true
var fov: float = 52.0
var fullscreen: bool = false
var vsync: bool = true
var render_scale: float = 1.0
var quality: String = "High"
var subtitles: bool = true
var hud_scale: float = 1.0


func load_from(path: String = PATH) -> void:
	_defaults()
	if not FileAccess.file_exists(path):
		return
	var cfg := ConfigFile.new()
	if cfg.load(path) != OK:
		push_warning("settings unreadable, using defaults")
		return
	master_db = clampf(float(cfg.get_value("audio", "master_db", master_db)), -40.0, 6.0)
	music_db = clampf(float(cfg.get_value("audio", "music_db", music_db)), -40.0, 6.0)
	sfx_db = clampf(float(cfg.get_value("audio", "sfx_db", sfx_db)), -40.0, 6.0)
	ambience_db = clampf(float(cfg.get_value("audio", "ambience_db", ambience_db)), -40.0, 6.0)
	voice_db = clampf(float(cfg.get_value("audio", "voice_db", voice_db)), -40.0, 6.0)
	ui_db = clampf(float(cfg.get_value("audio", "ui_db", ui_db)), -40.0, 6.0)
	mouse_sensitivity = clampf(float(cfg.get_value("feel", "mouse_sensitivity", mouse_sensitivity)), 0.03, 0.16)
	invert_look = bool(cfg.get_value("feel", "invert_look", invert_look))
	camera_bob = bool(cfg.get_value("feel", "camera_bob", camera_bob))
	camera_motion = clampf(float(cfg.get_value("feel", "camera_motion", camera_motion)), 0.0, 100.0)
	riding_aid = bool(cfg.get_value("feel", "riding_aid", riding_aid))
	fov = clampf(float(cfg.get_value("picture", "fov", fov)), 42.0, 62.0)
	fullscreen = bool(cfg.get_value("picture", "fullscreen", fullscreen))
	vsync = bool(cfg.get_value("picture", "vsync", vsync))
	render_scale = clampf(float(cfg.get_value("picture", "render_scale", render_scale)), 0.5, 1.0)
	var q := str(cfg.get_value("picture", "quality", quality))
	quality = q if q in ["Low", "Medium", "High"] else "High"
	subtitles = bool(cfg.get_value("text", "subtitles", subtitles))
	hud_scale = clampf(float(cfg.get_value("text", "hud_scale", hud_scale)), 0.8, 1.6)


func save_to(path: String = PATH) -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("audio", "master_db", master_db)
	cfg.set_value("audio", "music_db", music_db)
	cfg.set_value("audio", "sfx_db", sfx_db)
	cfg.set_value("audio", "ambience_db", ambience_db)
	cfg.set_value("audio", "voice_db", voice_db)
	cfg.set_value("audio", "ui_db", ui_db)
	cfg.set_value("feel", "mouse_sensitivity", mouse_sensitivity)
	cfg.set_value("feel", "invert_look", invert_look)
	cfg.set_value("feel", "camera_bob", camera_bob)
	cfg.set_value("feel", "camera_motion", camera_motion)
	cfg.set_value("feel", "riding_aid", riding_aid)
	cfg.set_value("picture", "fov", fov)
	cfg.set_value("picture", "fullscreen", fullscreen)
	cfg.set_value("picture", "vsync", vsync)
	cfg.set_value("picture", "render_scale", render_scale)
	cfg.set_value("picture", "quality", quality)
	cfg.set_value("text", "subtitles", subtitles)
	cfg.set_value("text", "hud_scale", hud_scale)
	cfg.save(path)


func commit() -> void:
	# Tests and certs never write user://settings.cfg. The ride save is a different file.
	if GameState._skip_save_reason() != "":
		return
	save_to(PATH)
	apply_audio()
	apply_display()


func apply_audio() -> void:
	_set_bus("Master", master_db)
	_set_bus("Music", music_db)
	_set_bus("SFX", sfx_db)
	_set_bus("Ambience", ambience_db)
	_set_bus("Voice", voice_db)
	_set_bus("UI", ui_db)


func msaa_level() -> Viewport.MSAA:
	if quality == "Low":
		return Viewport.MSAA_DISABLED
	if quality == "Medium":
		return Viewport.MSAA_2X
	return Viewport.MSAA_4X


func apply_display() -> void:
	if DisplayServer.get_name() == "headless":
		return
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if vsync else DisplayServer.VSYNC_DISABLED)
	var tree: SceneTree = Engine.get_main_loop() as SceneTree
	if tree == null or tree.root == null:
		return
	var vp := tree.root.get_viewport()
	if vp:
		vp.scaling_3d_scale = render_scale
		vp.msaa_3d = msaa_level()
	var env := _find_class(tree.root, "WorldEnvironment") as WorldEnvironment
	if env and env.environment:
		var on := quality != "Low"
		env.environment.ssao_enabled = on
		env.environment.glow_enabled = on
	var sun := _find_class(tree.root, "DirectionalLight3D") as DirectionalLight3D
	if sun:
		sun.directional_shadow_max_distance = 70.0 if quality == "Low" else 140.0


func _find_class(n: Node, kind: String) -> Node:
	if n != null and n.get_class() == kind:
		return n
	if n == null:
		return null
	for c in n.get_children():
		var hit := _find_class(c, kind)
		if hit:
			return hit
	return null


func _set_bus(bus_name: String, db: float) -> void:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx >= 0:
		AudioServer.set_bus_volume_db(idx, db)


func _defaults() -> void:
	master_db = 0.0
	music_db = 0.0
	sfx_db = 0.0
	ambience_db = 0.0
	voice_db = 0.0
	ui_db = 0.0
	mouse_sensitivity = 0.07
	invert_look = false
	camera_bob = true
	camera_motion = 70.0
	riding_aid = true
	fov = 52.0
	fullscreen = false
	vsync = true
	render_scale = 1.0
	quality = "High"
	subtitles = true
	hud_scale = 1.0
