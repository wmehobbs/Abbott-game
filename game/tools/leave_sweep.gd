extends Node

## Headless. Release Space at 0.1 m steps on one lesson fence and one
## beginner vertical. Prints the feel. Does not retune the bands.

var horse: Horse
var course: Course
const CHARGE := 0.05


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	await get_tree().process_frame
	await get_tree().create_timer(0.4).timeout
	var arena := get_parent()
	horse = arena.get_node_or_null("Abbott")
	course = arena.get_node_or_null("Course")
	if horse == null or course == null:
		print("LEAVE FAIL missing horse or course")
		get_tree().quit(1)
		return
	seed(1)
	await _sweep("lesson", 0, "lesson")
	await _sweep("beginner", 5, "schooling")
	print("LEAVE done")
	get_tree().quit(0)


func _sweep(class_id: String, course_seed: int, session: String) -> void:
	GameState.indoor = false
	GameState.jump_off = false
	GameState.class_id = class_id
	GameState.course_seed = course_seed
	GameState.session_kind = session
	course.build(false, course_seed)
	GameState.reset_round()
	var fence = _first_vertical()
	if fence == null:
		print("LEAVE FAIL no vertical class=", class_id)
		return
	var id := str(course.loaded.get("id", ""))
	print(
		"LEAVE course=", id,
		" session=", session,
		" class=", class_id,
		" fence=", fence.number,
		" kind=", fence.kind,
		" window_scale=", snapped(GameState.window_scale(), 0.01),
		" balance_need=", snapped(GameState.balance_need(), 0.001),
		" charge_set=", CHARGE
	)
	var target := 0.4
	while target <= 5.601:
		await _sample(fence, target)
		target += 0.1


func _first_vertical():
	for f in course.fences:
		if f.kind == "vertical":
			return f
	if course.fences.size() > 0:
		return course.fences[0]
	return null


func _sample(fence: JumpFence, target: float) -> void:
	var dir := fence.takeoff_dir()
	dir.y = 0.0
	dir = dir.normalized()
	var pos := fence.global_position - dir * target
	pos.y = 0.05
	_park(horse, fence, pos)
	Input.action_release("jump")
	await get_tree().physics_frame
	_park(horse, fence, pos)
	Input.action_press("jump")
	await get_tree().physics_frame
	_park(horse, fence, pos)
	horse.charging = true
	horse.charge = CHARGE
	var ahead := _ahead(fence)
	Input.action_release("jump")
	await get_tree().physics_frame
	var key := GameState.last_leave
	if key == "":
		key = "none"
	print(
		"LEAVE target=", snapped(target, 0.01),
		" ahead=", snapped(ahead, 0.01),
		" charge=", snapped(CHARGE, 0.01),
		" key=", key,
		" rail=", horse.will_rail,
		" refused=", fence.refused
	)
	Input.action_release("jump")


func _park(horse_n: Horse, fence: JumpFence, pos: Vector3) -> void:
	horse_n.jumping = false
	horse_n.jump_fence = null
	horse_n.will_rail = false
	horse_n.global_position = pos
	horse_n.velocity = Vector3.ZERO
	var look := fence.global_position
	look.y = pos.y
	if look.distance_to(pos) > 0.2:
		horse_n.look_at(look, Vector3.UP)
	horse_n.rotation.x = 0.0
	horse_n.rotation.z = 0.0
	horse_n.gait = Horse.CANTER
	horse_n.speed = Horse.GAIT_SPEED[Horse.CANTER]
	horse_n.charge = 0.0
	horse_n.charging = false
	horse_n.collecting = false
	horse_n.collect_pulse = 0.0
	horse_n.refuse_cool = 0.0
	horse_n.land_recover = 0.0
	horse_n.controllable = true
	horse_n.set_mounted(true)
	GameState.set_mode("ride")
	GameState.next_fence = fence.number
	GameState.last_leave = ""
	fence.knocked = false
	fence.cleared = false
	fence.refused = false
	fence.pending_chip = false


func _ahead(fence: JumpFence) -> float:
	var to := fence.global_position - horse.global_position
	to.y = 0.0
	var approach := -horse.transform.basis.z
	approach.y = 0.0
	if approach.length() < 0.001:
		return 0.0
	return to.dot(approach.normalized())
