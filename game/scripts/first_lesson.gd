extends RefCounted
class_name FirstLesson

## The first lesson for a fresh save. One step at a time. Skip ends it.


var active: bool = false
var step: int = 0
var _held: bool = false


func try_start() -> void:
	active = false
	step = 0
	_held = false
	if GameState.tutorial_done:
		return
	if GameState.demo_ride or GameState._skip_save_reason() != "":
		return
	if GameState.session_kind != "lesson":
		return
	active = true


func line() -> String:
	var pad := GameState.last_device == "pad"
	match step:
		0:
			return "Press D-pad up to walk." if pad else "Press W to walk."
		1:
			return "Press D-pad up to trot." if pad else "Press W again to trot."
		2:
			return "Press D-pad up to canter." if pad else "Press W again to canter."
		3:
			return "Hold the left stick to steer." if pad else "Hold A or D to steer."
		4:
			return "Press B to whoa." if pad else "Press Shift to whoa."
		5:
			return "Hold A, then let go to ask." if pad else "Hold Space, then let go to ask."
		6:
			return "Canter the first pole."
		_:
			return "Canter the next fence."


func tick(horse: Horse) -> void:
	if not active or horse == null:
		return
	match step:
		0:
			if horse.gait >= 1:
				_advance()
		1:
			if horse.gait >= 2:
				_advance()
		2:
			if horse.gait >= Horse.CANTER:
				_advance()
		3:
			if absf(horse.last_turn) > 0.2:
				_advance()
		4:
			if horse.gait == 0:
				_advance()
		5:
			if horse.collecting:
				_held = true
			elif _held:
				_advance()
		6:
			if GameState.fences_jumped >= 1:
				_advance()
		_:
			if GameState.fences_jumped >= 2:
				_finish()


func skip() -> void:
	_finish()


func _advance() -> void:
	step += 1
	_held = false
	if step > 7:
		_finish()


func _finish() -> void:
	active = false
	GameState.tutorial_done = true
	GameState.save()
