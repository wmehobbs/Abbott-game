extends SceneTree


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var packed: PackedScene = load("res://assets/meshes/abbott.glb")
	if packed == null:
		print("INSPECT missing glb")
		quit(1)
		return
	var inst: Node = packed.instantiate()
	root.add_child(inst)
	print("INSPECT root=", inst.name, " class=", inst.get_class())
	_dump(inst, 0)
	var anim := _find_anim(inst)
	var skel := _find_skel(inst)
	print("INSPECT anim=", anim)
	if anim:
		print("INSPECT list=", anim.get_animation_list())
		print("INSPECT libs=", anim.get_animation_library_list())
		print("INSPECT root_node=", anim.root_node)
		print("INSPECT active=", anim.active)
	print("INSPECT skel=", skel)
	if skel:
		print("INSPECT bones=", skel.get_bone_count())
		for i in skel.get_bone_count():
			print("INSPECT bone ", i, " ", skel.get_bone_name(i))
	quit(0)


func _dump(n: Node, depth: int) -> void:
	var pad := ""
	for _i in range(depth):
		pad += "  "
	print("INSPECT ", pad, n.name, " [", n.get_class(), "]")
	for c in n.get_children():
		_dump(c, depth + 1)


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
