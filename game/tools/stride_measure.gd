extends Node

## Headless. Canter straight on the sand for 8 seconds and print the stride.
## Started from arena when the user arg --stride is set. Does not save.

var horse: Horse
var course: Course


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	await get_tree().process_frame
	await get_tree().create_timer(0.4).timeout
	var arena := get_parent()
	horse = arena.get_node_or_null("Abbott")
	course = arena.get_node_or_null("Course")
	if horse == null or course == null:
		print("STRIDE FAIL missing horse or course")
		get_tree().quit(1)
		return
	horse.set_mounted(true)
	horse.controllable = true
	horse.jumping = false
	horse.charging = false
	horse.collecting = false
	horse.collect_pulse = 0.0
	GameState.set_mode("ride")
	var lane := _lane()
	var start := Vector3(lane["x"], 0.05, -30.0)
	horse.global_position = start
	horse.velocity = Vector3.ZERO
	horse.rotation = Vector3(0.0, PI, 0.0)
	horse.gait = Horse.CANTER
	horse.speed = Horse.GAIT_SPEED[Horse.CANTER]
	print("STRIDE lane_x=", snapped(lane["x"], 0.01), " clearance=", snapped(lane["clear"], 0.01))
	var warm := 0.0
	while warm < 2.0 and horse.speed < Horse.GAIT_SPEED[Horse.CANTER] - 0.08:
		await get_tree().physics_frame
		warm += get_physics_process_delta_time()
		if absf(horse.rotation.y - PI) > 0.02:
			horse.rotation = Vector3(0.0, PI, 0.0)
	var origin := horse.global_position
	var dist := 0.0
	var prev := origin
	var t := 0.0
	var speed_sum := 0.0
	var speed_n := 0
	var speed_min := horse.speed
	var speed_max := horse.speed
	var foot := 0
	var cycles := 0
	var prev_beat := horse.last_beat
	var prev_u := horse.stride_u
	var u0 := horse.stride_u
	while t < 8.0:
		await get_tree().physics_frame
		var dt := get_physics_process_delta_time()
		t += dt
		var p := horse.global_position
		dist += Vector2(p.x - prev.x, p.z - prev.z).length()
		prev = p
		speed_sum += horse.speed
		speed_n += 1
		speed_min = minf(speed_min, horse.speed)
		speed_max = maxf(speed_max, horse.speed)
		if horse.last_beat != prev_beat:
			foot += 1
			prev_beat = horse.last_beat
		if prev_u - horse.stride_u > 0.5:
			cycles += 1
		prev_u = horse.stride_u
		if absf(horse.rotation.y - PI) > 0.05:
			horse.rotation = Vector3(0.0, PI, 0.0)
	var per := 0.0
	if cycles > 0:
		per = dist / float(cycles)
	elif foot > 0:
		per = dist / (float(foot) / 3.0)
	var exact := float(cycles) + (horse.stride_u - u0)
	var per_exact := dist / exact if absf(exact) > 0.01 else 0.0
	var per_foot := dist / (float(foot) / 3.0) if foot > 0 else 0.0
	var mean := speed_sum / maxf(float(speed_n), 1.0)
	print("STRIDE speed_mean=", snapped(mean, 0.001), " speed_min=", snapped(speed_min, 0.001), " speed_max=", snapped(speed_max, 0.001))
	print("STRIDE footfalls=", foot, " stride_cycles=", cycles, " distance_m=", snapped(dist, 0.001))
	print("STRIDE meters_per_stride=", snapped(per, 0.001), " vs_3_35=", snapped(per - 3.35, 0.001), " warm_s=", snapped(warm, 0.01))
	print("STRIDE exact_cycles=", snapped(exact, 0.001), " meters_exact=", snapped(per_exact, 0.001), " vs_exact=", snapped(per_exact - 3.35, 0.001))
	print("STRIDE meters_from_footfalls=", snapped(per_foot, 0.001), " vs_foot=", snapped(per_foot - 3.35, 0.001))
	print("STRIDE end=", snapped(horse.global_position.x, 0.01), ",", snapped(horse.global_position.z, 0.01), " gait=", horse.gait)
	get_tree().quit(0)


func _lane() -> Dictionary:
	var best_x := 0.0
	var best_clear := -1.0
	var x := -8.0
	while x <= 8.0:
		var clear := 99.0
		for f in course.fences:
			var fz: float = f.global_position.z
			if fz < -32.0 or fz > 16.0:
				continue
			clear = minf(clear, absf(f.global_position.x - x))
		if clear > best_clear:
			best_clear = clear
			best_x = x
		x += 1.0
	return {"x": best_x, "clear": best_clear}
