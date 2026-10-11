extends SceneTree
## Rides a list of classes with the computer rider and saves the screen.
## Args: --shots-day17-playthrough --out=<dir> [--rounds=lesson:lesson:0,...] [--every=2.0]
## The --shots- prefix keeps her save off. Quits itself.
##
## The arena clears demo_ride as it leaves. Arm the rider again once the new
## arena is in the tree, or only the first round is watched.

const DEFAULT_ROUNDS := "lesson:lesson:0,schooling:beginner:0,schooling:intermediate:0,schooling:advanced:0,show:beginner:0,show:beginner:1,show:intermediate:0,show:intermediate:1,show:advanced:0,show:advanced:1"
const ROUND_LIMIT_MS := 240000
const RESULT_DELAY_MS := 1500

var _out := ""
var _every_ms := 2000
var _rounds: Array = []


func _init() -> void:
	var spec := DEFAULT_ROUNDS
	for a in OS.get_cmdline_user_args():
		var s := str(a)
		if s.begins_with("--out="):
			_out = s.substr(6)
		elif s.begins_with("--rounds="):
			spec = s.substr(9)
		elif s.begins_with("--every="):
			_every_ms = int(float(s.substr(8)) * 1000.0)
	if _out == "":
		print("PLAYTHROUGH missing --out")
		quit(2)
		return
	if _every_ms < 200:
		_every_ms = 200
	_rounds = _parse_rounds(spec)
	if _rounds.is_empty():
		print("PLAYTHROUGH no rounds")
		quit(2)
		return
	DirAccess.make_dir_recursive_absolute(_out)
	call_deferred("_boot")


func _parse_rounds(spec: String) -> Array:
	var out: Array = []
	for part in spec.split(",", false):
		var bits: PackedStringArray = str(part).strip_edges().split(":")
		if bits.size() != 3:
			print("PLAYTHROUGH bad round ", part)
			continue
		out.append({
			"session": str(bits[0]),
			"class_id": str(bits[1]),
			"seed": int(bits[2]),
		})
	return out


func _boot() -> void:
	print("PLAYTHROUGH rounds=", _rounds.size(), " every_ms=", _every_ms)
	for spec in _rounds:
		await _ride(spec)
	print("PLAYTHROUGH done")
	quit(0)


func _ride(spec: Dictionary) -> void:
	var session := str(spec["session"])
	var class_id := str(spec["class_id"])
	var seed := int(spec["seed"])
	var folder := _out.path_join("%s_%s_s%d" % [session, class_id, seed])
	DirAccess.make_dir_recursive_absolute(folder)
	var gs: Node = root.get_node_or_null("GameState")
	if gs == null:
		print("ROUND session=%s class=%s seed=%d complete=false faults=0 t=0.00 reason=no_gamestate" % [session, class_id, seed])
		return
	gs.set("demo_ride", true)
	gs.call("start_session", session, class_id)
	gs.set("course_seed", seed)
	gs.set("jump_off", false)
	gs.call("set_mode", "ride")
	var old_id := current_scene.get_instance_id() if current_scene else 0
	change_scene_to_file("res://scenes/arena.tscn")
	var arena: Node = null
	for _i in 180:
		await process_frame
		if current_scene and current_scene.get_instance_id() != old_id and current_scene.get_node_or_null("Abbott") != null:
			arena = current_scene
			break
	if arena == null:
		print("ROUND session=%s class=%s seed=%d complete=false faults=0 t=0.00 reason=no_arena" % [session, class_id, seed])
		return
	# _ready already ran. The leaving arena turned demo_ride off, so arm here.
	gs.set("demo_ride", true)
	if arena.has_method("_arm_demo"):
		arena.call("_arm_demo")
	var rider := arena.get_node_or_null("DemoRider")
	print("ARMED session=%s class=%s seed=%d demo=%s rider=%s" % [session, class_id, seed, str(gs.get("demo_ride")), str(rider != null)])
	var t0 := Time.get_ticks_msec()
	var phase_t0 := t0
	var next_shot := t0
	var shot_i := 0
	var result_at := -1
	var result_saved := false
	var first_t := 0.0
	var first_f := 0
	var jo_phase := false
	var jo_result_at := -1
	var jo_saved := false
	var jo_t := 0.0
	var jo_f := 0
	var timed_out := false
	while true:
		await process_frame
		var now := Time.get_ticks_msec()
		if now >= next_shot:
			await _save(folder, "t%03d.png" % shot_i)
			shot_i += 1
			next_shot += _every_ms
		var complete := bool(gs.get("round_complete"))
		var jo := bool(gs.get("jump_off"))
		if complete and not jo and not result_saved:
			if result_at < 0:
				result_at = now + RESULT_DELAY_MS
			elif now >= result_at:
				await _save(folder, "results.png")
				result_saved = true
				first_t = float(gs.get("last_time"))
				first_f = int(gs.get("last_faults"))
				if not bool(gs.call("can_offer_jump_off")):
					break
		if jo and not jo_phase:
			jo_phase = true
			phase_t0 = now
		if jo_phase and complete and not jo_saved:
			if jo_result_at < 0:
				jo_result_at = now + RESULT_DELAY_MS
			elif now >= jo_result_at:
				await _save(folder, "results_jo.png")
				jo_saved = true
				jo_t = float(gs.get("last_time"))
				jo_f = int(gs.get("last_faults"))
				break
		if now - phase_t0 >= ROUND_LIMIT_MS:
			timed_out = true
			print("FINDING round never finished session=%s class=%s seed=%d jump_off=%s" % [session, class_id, seed, str(jo_phase)])
			break
	if not result_saved:
		first_t = float(gs.get("time_sec"))
		first_f = int(gs.get("faults"))
	var done := result_saved and not timed_out and (not jo_phase or jo_saved)
	print("ROUND session=%s class=%s seed=%d complete=%s faults=%d t=%.2f jump_off=%s jo_faults=%d jo_t=%.2f shots=%d" % [session, class_id, seed, str(done), first_f, first_t, str(jo_phase), jo_f, jo_t, shot_i])


func _save(folder: String, name: String) -> void:
	# process_frame is before the draw. Wait so the picture is this frame, not black.
	await RenderingServer.frame_post_draw
	var img := root.get_viewport().get_texture().get_image()
	if img == null:
		print("PLAYTHROUGH no image ", name)
		return
	var err := img.save_png(folder.path_join(name))
	if err != OK:
		print("PLAYTHROUGH save failed ", name, " ", err)
