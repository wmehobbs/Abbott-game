extends SceneTree


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var script: GDScript = load("res://scripts/horse.gd")
	var h: Node = script.new()
	root.add_child(h)
	print("VERIFY anim=", h.get("anim") != null)
	print("VERIFY seat_bone=", h.get("seat_bone"))
	var rider = h.get("rider")
	if rider:
		var p: Node = rider.get_parent()
		print("VERIFY rider_parent=", p.name if p else "none")
		if p:
			var gp := p.get_parent()
			print("VERIFY seat_attach=", gp.name if gp else "none", " bone=", gp.bone_name if gp is BoneAttachment3D else "")
	var ap = h.get("anim")
	if ap:
		for n in ["Idle", "Walk", "Gallop", "Gallop_Jump", "Jump_toIdle"]:
			print("VERIFY has ", n, "=", ap.has_animation(n))
		h.set("gait", 1)
		h.call("_animate", 0.016, 1.45)
		print("VERIFY walk playing=", ap.is_playing(), " clip=", ap.current_animation)
		h.set("gait", 3)
		h.call("_animate", 0.016, 5.55)
		print("VERIFY gallop clip=", ap.current_animation)
		h.call("_begin_schooling_jump")
		print("VERIFY jump clip=", ap.current_animation, " jumping=", h.get("jumping"))
	var spring = h.get("spring")
	var cam = h.get("cam")
	print("VERIFY spring_present=", spring != null)
	if cam:
		h.call("_place_cam")
		print("VERIFY cam_near=", cam.near, " fov=", cam.fov, " cam_y=", cam.global_position.y)
		if cam.global_position.y < 2.0:
			push_error("VERIFY FAIL camera is in the sand y=%s" % cam.global_position.y)
			quit(1)
			return
	print("VERIFY taa=", ProjectSettings.get_setting("rendering/anti_aliasing/quality/use_taa"))
	print("VERIFY msaa3d=", ProjectSettings.get_setting("rendering/anti_aliasing/quality/msaa_3d"))
	print("VERIFY stretch=", ProjectSettings.get_setting("display/window/stretch/mode"), " aspect=", ProjectSettings.get_setting("display/window/stretch/aspect"))
	print("VERIFY win_mode=", ProjectSettings.get_setting("display/window/size/mode"), " resizable=", ProjectSettings.get_setting("display/window/size/resizable"))
	for p in ["res://assets/textures/abbott_shader_face.jpg", "res://assets/textures/abbott_shader_stall.jpg", "res://assets/textures/abbott_shader_coat.jpg", "res://shaders/abbott_whitehorse.gdshader", "res://assets/textures/rider_face_front.jpg", "res://assets/textures/rider_face_side.jpg", "res://shaders/madison_face.gdshader"]:
		print("VERIFY tex ", p, "=", ResourceLoader.exists(p))
	if not ResourceLoader.exists("res://assets/textures/rider_face_front.jpg"):
		push_error("VERIFY FAIL missing Madison face plate")
		quit(1)
		return
	_dump_horse_draw(h)
	_dump_mats(h)
	if not _dump_tack(h):
		quit(1)
		return
	var farm_script: GDScript = load("res://scripts/farm.gd")
	var farm: Node = farm_script.new()
	root.add_child(farm)
	farm.call("build")
	var env := _find_env(farm)
	if env:
		print("VERIFY sdfgi=", env.sdfgi_enabled, " ssao=", env.ssao_enabled, " ssil=", env.ssil_enabled, " glow=", env.glow_enabled, " fog=", env.fog_enabled, " tonemap=", env.tonemap_mode)
	print("VERIFY ok")
	quit(0)


func _dump_horse_draw(n: Node) -> void:
	if n is MeshInstance3D:
		var mi := n as MeshInstance3D
		if mi.mesh and mi.mesh.get_surface_count() >= 3:
			var ov: Material = mi.get_surface_override_material(0)
			print("VERIFY draw mesh=", mi.mesh.get_class(), " cull=", mi.extra_cull_margin, " sort=", mi.sorting_offset, " override=", ov != null, " shader=", ov is ShaderMaterial if ov else false)
			if mi.extra_cull_margin < 1.0:
				push_error("VERIFY FAIL extra_cull_margin too small")
	for c in n.get_children():
		_dump_horse_draw(c)


func _dump_mats(n: Node) -> void:
	if n is MeshInstance3D:
		var mi := n as MeshInstance3D
		if mi.mesh:
			for s in mi.mesh.get_surface_count():
				var arr := mi.mesh.surface_get_arrays(s)
				var cols = arr[Mesh.ARRAY_COLOR]
				var bones = arr[Mesh.ARRAY_BONES]
				var sample := Color.BLACK
				if cols is PackedColorArray and cols.size() > 0:
					sample = cols[0]
					var acc := Color(0, 0, 0, 0)
					var n_col: int = mini(cols.size(), 64)
					for i in n_col:
						acc += cols[i]
					sample = acc / float(n_col)
				var white_n := 0
				var dark_n := 0
				if cols is PackedColorArray:
					for i in cols.size():
						if cols[i].r > 0.85 and cols[i].g > 0.80:
							white_n += 1
						elif cols[i].r < 0.20:
							dark_n += 1
				print("VERIFY surf ", s, " verts=", arr[Mesh.ARRAY_VERTEX].size() if arr[Mesh.ARRAY_VERTEX] else 0, " colors=", cols.size() if cols is PackedColorArray else 0, " bones=", bones != null, " white=", white_n, " dark=", dark_n, " sample=", sample)
	for c in n.get_children():
		_dump_mats(c)


func _dump_tack(h: Node) -> bool:
	var bit_l := _find_named(h, "BitL")
	var bit_r := _find_named(h, "BitR")
	var glove_l := _find_named(h, "LGlove")
	var saddle := _find_named(h, "Saddle")
	var bridle := _find_named(h, "BridleAttach")
	print("VERIFY tack bitL=", bit_l != null, " bitR=", bit_r != null, " gloveL=", glove_l != null, " saddle=", saddle != null, " bridle=", bridle != null)
	if bit_l == null or bit_r == null or glove_l == null or saddle == null or bridle == null:
		push_error("VERIFY FAIL missing tack nodes")
		return false
	var skull := _find_named(h, "Skull")
	if skull is MeshInstance3D:
		var face_mat: Material = (skull as MeshInstance3D).material_override
		print("VERIFY face_shader=", face_mat is ShaderMaterial)
		if not (face_mat is ShaderMaterial):
			push_error("VERIFY FAIL Madison face is not photo-mapped")
			return false
	else:
		push_error("VERIFY FAIL missing Madison skull")
		return false
	var skel: Skeleton3D = h.get("skel")
	if skel and skel.find_bone("Head") >= 0:
		var head_xf := skel.global_transform * skel.get_bone_global_rest(skel.find_bone("Head"))
		var d: float = (bit_l as Node3D).global_position.distance_to(head_xf.origin)
		print("VERIFY bit_to_head=", d, " bit=", (bit_l as Node3D).global_position, " head=", head_xf.origin)
		if d > 0.55:
			push_error("VERIFY FAIL bit is off the head d=%s" % d)
			return false
	return true


func _find_named(n: Node, want: String) -> Node:
	if n.name == want:
		return n
	for c in n.get_children():
		var f := _find_named(c, want)
		if f:
			return f
	return null


func _find_env(n: Node) -> Environment:
	if n is WorldEnvironment:
		return (n as WorldEnvironment).environment
	for c in n.get_children():
		var e := _find_env(c)
		if e:
			return e
	return null
