extends SceneTree


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var packed: PackedScene = load("res://assets/meshes/abbott.glb")
	var inst: Node = packed.instantiate()
	root.add_child(inst)
	var anim := _find_anim(inst)
	if anim == null:
		print("TRACKS no player")
		quit(1)
		return
	for name in anim.get_animation_list():
		var a: Animation = anim.get_animation(name)
		print("TRACKS clip=", name, " len=", a.length, " tracks=", a.get_track_count(), " loop=", a.loop_mode)
		var shown := 0
		for i in a.get_track_count():
			if shown >= 8:
				print("TRACKS  ...")
				break
			print("TRACKS  ", a.track_get_type(i), " ", a.track_get_path(i))
			shown += 1
	var skel := _find_skel(inst)
	if skel:
		print("TRACKS skel_path=", inst.get_path_to(skel))
		print("TRACKS rest0=", skel.get_bone_rest(0))
		print("TRACKS pose0=", skel.get_bone_pose(0))
	# Play walk one frame
	anim.play("Walk")
	anim.advance(0.3)
	if skel:
		print("TRACKS after walk pose0=", skel.get_bone_pose(0))
		print("TRACKS after walk pose4=", skel.get_bone_pose(4))
		print("TRACKS after walk rest4=", skel.get_bone_rest(4))
	quit(0)


func _find_skel(n: Node) -> Skeleton3D:
	if n is Skeleton3D:
		return n
	for c in n.get_children():
		var s := _find_skel(c)
		if s:
			return s
	return null


func _find_anim(n: Node) -> AnimationPlayer:
	if n is AnimationPlayer:
		return n
	for c in n.get_children():
		var a := _find_anim(c)
		if a:
			return a
	return null
