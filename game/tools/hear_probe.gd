extends Node

## Headless. Prints the count's hear flag and quits. Does not ride.


func _ready() -> void:
	var ok := true
	ok = _case("schooling", "beginner", 38.0, 0, 0, true) and ok
	ok = _case("schooling", "beginner", 60.0, 0, 0, true) and ok
	ok = _case("schooling", "beginner", 60.0, 2, 0, false) and ok
	ok = _case("schooling", "intermediate", 60.0, 2, 0, true) and ok
	print("HEAR done pass=", ok)
	get_tree().quit(0 if ok else 1)


func _hears() -> bool:
	# Same expression as horse.gd _lesson_count.
	return (
		GameState.session_kind == "lesson"
		or GameState.madison_timing < 55.0
		or int(GameState.clears.get(GameState.class_id, 0)) < 2
	)


func _case(session: String, klass: String, timing: float, beg: int, mid: int, expect: bool) -> bool:
	GameState.session_kind = session
	GameState.class_id = klass
	GameState.madison_timing = timing
	GameState.clears = {
		"lesson": 0,
		"beginner": beg,
		"intermediate": mid,
		"advanced": 0,
	}
	var hear: bool = _hears()
	var here: int = int(GameState.clears.get(klass, 0))
	print(
		"HEAR session=", session,
		" class=", klass,
		" timing=", timing,
		" clears_here=", here,
		" beginner_clears=", beg,
		" hear=", hear,
		" expect=", expect
	)
	return hear == expect
