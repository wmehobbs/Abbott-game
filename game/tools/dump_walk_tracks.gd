extends SceneTree


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var packed: PackedScene = load("res://assets/meshes/quaternius-WhiteHorse.glb")
	var inst: Node = packed.instantiate()
	root.add_child(inst)
	var anim := _find_anim(inst)
	if anim == null:
		push_error("no anim")
		quit(1)
		return
	for clip_name in ["Walk", "Idle", "Gallop"]:
		if not anim.has_animation(clip_name):
			continue
		var a: Animation = anim.get_animation(clip_name)
		print("CLIP ", clip_name, " len=", a.length, " tracks=", a.get_track_count())
		for i in a.get_track_count():
			var path := String(a.track_get_path(i))
			var typ := a.track_get_type(i)
			var keys := a.track_get_key_count(i)
			if typ == Animation.TYPE_POSITION_3D or typ == Animation.TYPE_SCALE_3D:
				print("  MOVE ", typ, " ", path, " keys=", keys)
				if keys > 0:
					print("    first=", a.track_get_key_value(i, 0), " last=", a.track_get_key_value(i, keys - 1))
	print("DUMP TRACKS ok")
	quit(0)


func _find_anim(n: Node) -> AnimationPlayer:
	if n is AnimationPlayer:
		return n
	for c in n.get_children():
		var a := _find_anim(c)
		if a:
			return a
	return null
