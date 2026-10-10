extends SceneTree
## Windowed stills of Abbott and Madison for the Day 15 visual loop.
## Args after --: --shots-probe --out=<dir> --plan=<json file>
## The --shots- prefix keeps GameState.save() off. Quits itself.
##
## Plan: {"poses": [{"name": "halt", "gait": 0, "phase": 0.0, "jump_u": -1,
##   "collect": false, "last_stride": 0.0, "cams": [{"name": "side",
##   "from": [3.2, 1.3, 0.1], "look": [0, 1.2, 0], "fov": 40, "world": false}]}]}
## Camera points are in the horse's frame unless "world" is true.

var _out := ""
var _plan: Dictionary = {}
var _frames := 0
var _cam: Camera3D
var _horse: Node3D
var _consts: Dictionary = {}
var _busy := false


func _init() -> void:
	for a in OS.get_cmdline_user_args():
		var s := str(a)
		if s.begins_with("--out="):
			_out = s.substr(6)
		elif s.begins_with("--plan="):
			var f := FileAccess.open(s.substr(7), FileAccess.READ)
			if f:
				_plan = JSON.parse_string(f.get_as_text())
	if _out == "" or _plan.is_empty():
		print("PROBE missing --out or --plan")
		quit(2)
		return
	DirAccess.make_dir_recursive_absolute(_out)
	call_deferred("_boot")


func _boot() -> void:
	var gs: Node = root.get_node_or_null("GameState")
	gs.call("start_session", str(_plan.get("session", "lesson")), str(_plan.get("class", "lesson")))
	gs.set("course_seed", int(_plan.get("seed", 0)))
	gs.set("jump_off", false)
	gs.call("set_mode", str(_plan.get("mode", "ride")))
	change_scene_to_file("res://scenes/arena.tscn")
	process_frame.connect(_tick)


func _tick() -> void:
	_frames += 1
	if _frames < 12 or _busy:
		return
	_busy = true
	_run()


func _run() -> void:
	var arena := current_scene
	_horse = arena.get_node_or_null("Abbott") as Node3D
	if _horse == null:
		print("PROBE no horse")
		quit(1)
		return
	var hud := arena.get_node_or_null("HUD") as CanvasLayer
	if hud:
		hud.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	_consts = _horse.get_script().get_script_constant_map()
	_horse.set("controllable", false)
	_horse.set_physics_process(false)
	_horse.global_position = Vector3(0.0, 0.0, -8.0)
	_horse.rotation = Vector3(0.0, PI, 0.0)
	_cam = Camera3D.new()
	_cam.near = 0.05
	_cam.far = 500.0
	arena.add_child(_cam)
	_cam.current = true
	if _plan.has("ssaa"):
		root.get_viewport().screen_space_aa = int(_plan["ssaa"]) as Viewport.ScreenSpaceAA
		print("PROBE ssaa=", root.get_viewport().screen_space_aa, " msaa=", root.get_viewport().msaa_3d, " max=", Viewport.SCREEN_SPACE_AA_MAX)
	var extra: Dictionary = _plan.get("report", {})
	if bool(extra.get("bones", false)):
		_report_bones()
	if bool(extra.get("rider", false)):
		_report_rider()
	if bool(extra.get("scene", false)):
		_report_scene()
	for pose in _plan.get("poses", []):
		if pose.has("strip"):
			await _strip(pose)
			continue
		await _pose(pose)
		for c in pose.get("cams", []):
			var basis := _horse.global_transform.basis
			var origin := _horse.global_position
			var fr: Array = c.get("from", [3, 1.3, 0])
			var lk: Array = c.get("look", [0, 1.2, 0])
			var from := Vector3(fr[0], fr[1], fr[2])
			var look := Vector3(lk[0], lk[1], lk[2])
			if str(c.get("rel", "")) == "walker":
				var wk := current_scene.get_node_or_null("Walker") as Node3D
				if wk:
					from = wk.global_transform * from
					look = wk.global_transform * look
			elif str(c.get("rel", "")).begins_with("fence"):
				var course := current_scene.get_node_or_null("Course")
				var fl: Array = course.get("fences") if course else []
				var fi := int(str(c.get("rel", "")).substr(5)) if str(c.get("rel", "")).length() > 5 else 0
				if fi < fl.size():
					var fn := fl[fi] as Node3D
					from = fn.global_transform * from
					look = fn.global_transform * look
			elif str(c.get("rel", "")) == "trainer":
				var tr := current_scene.find_child("Michelle", true, false) as Node3D
				if tr:
					from = tr.global_transform * from
					look = tr.global_transform * look
			elif not bool(c.get("world", false)):
				from = origin + basis * from
				look = origin + basis * look
			_cam.fov = float(c.get("fov", 40.0))
			_cam.global_position = from
			if from.distance_to(look) > 0.01:
				_cam.look_at(look, Vector3.UP if absf((look - from).normalized().y) < 0.99 else Vector3.FORWARD)
			_cam.current = true
			await process_frame
			await process_frame
			var img := root.get_viewport().get_texture().get_image()
			var path := _out.path_join("%s_%s.png" % [str(pose.get("name", "p")), str(c.get("name", "c"))])
			img.save_png(path)
			print("PROBE saved ", path)
	print("PROBE done")
	quit(0)


func _pose(p: Dictionary) -> void:
	var gait := int(p.get("gait", 0))
	var speeds: Array = _consts.get("GAIT_SPEED", [0.0, 1.6, 3.4, 5.6])
	_horse.set("gait", gait)
	_horse.set("speed", float(speeds[gait]) if gait > 0 else 0.0)
	_horse.set("collecting", bool(p.get("collect", false)))
	_horse.set("last_stride", float(p.get("last_stride", 0.0)))
	_horse.set("land_recover", float(p.get("land", 0.0)))
	var ju := float(p.get("jump_u", -1.0))
	_horse.set("jumping", ju >= 0.0)
	if ju >= 0.0:
		_horse.set("jump_dur", 0.8)
		_horse.set("jump_t", ju * 0.8)
	var phase := float(p.get("phase", 0.0))
	# Converge the rider's smoothing, then hold the clip at the phase.
	for i in 24:
		_horse.set("stride_u", phase)
		_horse.call("_animate", 0.0, float(_horse.get("speed")))
		_horse.call("_update_rider", 0.5)
		_hold(p, phase)
		await process_frame


func _hold(p: Dictionary, phase: float) -> void:
	var anim := _horse.get("anim") as AnimationPlayer
	if anim == null:
		return
	var clip := str(p.get("clip", ""))
	if clip == "" or not anim.has_animation(clip):
		return
	if anim.current_animation != clip:
		anim.play(clip, 0.0)
	anim.seek(phase * anim.get_animation(clip).length, true)
	anim.pause()


func _report_bones() -> void:
	var ap := _horse.get("anim") as AnimationPlayer
	if ap:
		print("PROBE anims ", ap.get_animation_list())
		for nm in ["Walk", "Trot", "Canter", "Gallop"]:
			if ap.has_animation(nm):
				var a := ap.get_animation(nm)
				print("PROBE anim ", nm, " length=", a.length, " tracks=", a.get_track_count(), " loop=", a.loop_mode)
				for ti in a.get_track_count():
					var path := str(a.track_get_path(ti))
					if path.ends_with(":FrontUpperLeg.L") and a.track_get_type(ti) == Animation.TYPE_ROTATION_3D:
						var vals := []
						for k in 6:
							var q: Quaternion = a.rotation_track_interpolate(ti, a.length * float(k) / 6.0)
							vals.append(snappedf(rad_to_deg(q.get_euler().x), 0.1))
						print("PROBE track ", nm, " FrontUpperLeg.L rot.x over stride: ", vals, " keys=", a.track_get_key_count(ti))
	var sk := _horse.get("skel") as Skeleton3D
	if sk == null:
		print("PROBE no horse skeleton")
		return
	for n in ["Body", "Torso", "Back", "Neck1", "Head", "Tail1", "FrontLowerLeg.L"]:
		var i := sk.find_bone(n)
		if i >= 0:
			print("PROBE bone ", n, " world=", (sk.global_transform * sk.get_bone_global_pose(i)).origin)
	print("PROBE skel global=", sk.global_transform)
	for mi in _horse.find_children("*", "MeshInstance3D", true, false):
		var m := mi as MeshInstance3D
		if m.skin == null or not (m.name == "Horse" or m.name == "Bridle"):
			continue
		print("PROBE mesh ", m.name, " parent=", m.get_parent().name, " xf=", m.global_transform, " aabb=", m.get_aabb(), " skin=", m.skin != null, " skel_path=", m.skeleton)


func _report_rider() -> void:
	var rm := _horse.find_child("RiderMesh", true, false)
	if rm == null:
		print("PROBE no RiderMesh")
		return
	var sk := rm.get("skel") as Skeleton3D
	for n in ["Hips", "Chest", "Neck", "Head", "UpperLegL", "FootL"]:
		var i := sk.find_bone(n)
		print("PROBE rider rest ", n, " ", sk.get_bone_global_rest(i).origin, " basis ", sk.get_bone_global_rest(i).basis.get_euler() * 57.3)
	var cap := sk.find_child("Cap", true, false) as Node3D
	if cap:
		print("PROBE cap world ", cap.global_position, " head pose world ", sk.to_global(sk.get_bone_global_pose(sk.find_bone("Head")).origin))
	print("PROBE skel xf ", sk.global_transform)
	var leg: Dictionary = rm.get("_leg")
	for tag in ["L", "R"]:
		if leg.has(tag):
			var d: Dictionary = leg[tag]
			print("PROBE leg ", tag, " knee=", d.get("knee"), " ankle=", d.get("ankle"))


func _report_scene() -> void:
	# Visible meshes by top-level owner, and how many cast shadows.
	var groups := {}
	var stack: Array = [current_scene]
	var procs := {}
	while not stack.is_empty():
		var n: Node = stack.pop_back()
		for c in n.get_children():
			stack.append(c)
		if n.is_processing() and n.get_script() != null:
			var sp := str((n.get_script() as Script).resource_path.get_file())
			procs[sp] = int(procs.get(sp, 0)) + 1
		if n is MeshInstance3D or n is MultiMeshInstance3D:
			var gi := n as GeometryInstance3D
			if not gi.is_visible_in_tree():
				continue
			var top := n
			while top.get_parent() != current_scene and top.get_parent() != null:
				top = top.get_parent()
			var key := str(top.name)
			if key.begins_with("@"):
				key = "(unnamed)"
			var row: Array = groups.get(key, [0, 0, 0])
			row[0] += 1
			if gi.cast_shadow != GeometryInstance3D.SHADOW_CASTING_SETTING_OFF:
				row[1] += 1
			if n is MeshInstance3D and (n as MeshInstance3D).mesh:
				row[2] += (n as MeshInstance3D).mesh.get_surface_count()
			groups[key] = row
	var buckets := [0.1, 0.25, 0.5, 1.0, 2.0, 5.0, 1.0e9]
	var hist := {}
	var stack2: Array = [current_scene]
	while not stack2.is_empty():
		var m: Node = stack2.pop_back()
		for c in m.get_children():
			stack2.append(c)
		if m is MeshInstance3D and (m as MeshInstance3D).is_visible_in_tree() and (m as MeshInstance3D).mesh:
			var mi := m as MeshInstance3D
			var ab := mi.global_transform * mi.get_aabb()
			var big := maxf(ab.size.x, maxf(ab.size.y, ab.size.z))
			var top := m
			while top.get_parent() != current_scene and top.get_parent() != null:
				top = top.get_parent()
			for b in buckets:
				if big < b:
					var key := "%s<%s" % [str(top.name), str(b)]
					hist[key] = int(hist.get(key, 0)) + 1
					break
	for k in hist:
		print("PROBE size ", k, " n=", hist[k])
	for k in groups:
		print("PROBE meshes ", k, " count=", groups[k][0], " shadow=", groups[k][1], " surfaces=", groups[k][2])
	for k in procs:
		print("PROBE processing ", k, " x", procs[k])


func _strip(p: Dictionary) -> void:
	# Play the gait forward the way the game does (_animate with a real step)
	# and take n frames over one stride from one camera.
	var gait := int(p.get("gait", 1))
	var speeds: Array = _consts.get("GAIT_SPEED", [0.0, 1.6, 3.4, 5.6])
	var hz_list: Array = _consts.get("STRIDE_HZ", [1.0, 1.0, 1.4, 1.6])
	_horse.set("gait", gait)
	_horse.set("speed", float(speeds[gait]))
	var n := int(p.get("strip", 8))
	var period := 1.0 / maxf(float(hz_list[gait]), 0.01)
	var step := period / float(n)
	# Settle into the gait first.
	for i in 90:
		_horse.call("_animate", 1.0 / 60.0, float(speeds[gait]))
		_horse.call("_update_rider", 1.0 / 60.0)
		await process_frame
	var c: Dictionary = p.get("cams", [{}])[0]
	var fr: Array = c.get("from", [3.4, 1.0, 0.0])
	var lk: Array = c.get("look", [0, 0.85, 0])
	for i in n:
		var sub := 4
		for k in sub:
			_horse.call("_animate", step / float(sub), float(speeds[gait]))
			_horse.call("_update_rider", step / float(sub))
		var basis := _horse.global_transform.basis
		var origin := _horse.global_position
		_cam.fov = float(c.get("fov", 42.0))
		_cam.global_position = origin + basis * Vector3(fr[0], fr[1], fr[2])
		_cam.look_at(origin + basis * Vector3(lk[0], lk[1], lk[2]), Vector3.UP)
		await process_frame
		await process_frame
		var img := root.get_viewport().get_texture().get_image()
		img.save_png(_out.path_join("%s_%02d.png" % [str(p.get("name", "strip")), i]))
	print("PROBE strip ", p.get("name"), " n=", n, " period=", period)
