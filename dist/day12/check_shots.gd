extends SceneTree

func _init() -> void:
	var s = load("res://scripts/shots.gd")
	print("SHOTS_LOAD ", s != null)
	quit(0 if s != null else 1)
