extends SceneTree
## Windowed: the title screen at 0.5 s and 8 s. Args: --shots-title --out=<dir>.

var _out := ""
var _t0 := 0


func _init() -> void:
	for a in OS.get_cmdline_user_args():
		if str(a).begins_with("--out="):
			_out = str(a).substr(6)
	DirAccess.make_dir_recursive_absolute(_out)
	call_deferred("_boot")


func _boot() -> void:
	change_scene_to_file("res://scenes/title.tscn")
	_t0 = Time.get_ticks_msec()
	process_frame.connect(_tick)


var _done := {}


func _tick() -> void:
	var t := Time.get_ticks_msec() - _t0
	for mark in [500, 8000]:
		if t >= mark and not _done.has(mark):
			_done[mark] = true
			root.get_viewport().get_texture().get_image().save_png(_out.path_join("title_%d.png" % mark))
	if t > 8200:
		quit(0)
