extends SceneTree

func _init() -> void:
	var packed: PackedScene = load("res://assets/meshes/madison_casual.glb")
	if packed == null:
		print("DUMP load failed")
		quit(1)
		return
	var root := packed.instantiate()
	var skel := _find_skel(root)
	if skel == null:
		print("DUMP no skeleton")
		_walk(root, 0)
		quit(1)
		return
	print("DUMP skel ", skel.name, " bones ", skel.get_bone_count())
	for i in skel.get_bone_count():
		var name := skel.get_bone_name(i)
		var g: Transform3D = skel.get_bone_global_rest(i)
		var o := g.origin
		if name in ["Root", "Hips", "Torso", "Chest", "Neck", "Head", "UpperLegL", "LowerLegL", "UpperLegR", "LowerLegR", "FootL", "FootR", "WristL", "WristR", "UpperArmL", "LowerArmL", "UpperArmR", "LowerArmR"]:
			print("BONE %s origin %.3f %.3f %.3f" % [name, o.x, o.y, o.z])
	var anim := _find_anim(root)
	print("DUMP anim ", anim)
	if anim:
		print("DUMP clips ", anim.get_animation_list())
		anim.active = false
	_aabb(root)
	_walk(root, 0)
	quit(0)


func _aabb(n: Node) -> void:
	if n is MeshInstance3D:
		var mi := n as MeshInstance3D
		if mi.mesh:
			var a := mi.mesh.get_aabb()
			print("MESH %s aabb pos %s size %s mat %s" % [mi.name, a.position, a.size, mi.get_surface_override_material(0)])
	for c in n.get_children():
		_aabb(c)


func _walk(n: Node, d: int) -> void:
	print("%s%s" % ["  ".repeat(d), n.name])
	for c in n.get_children():
		_walk(c, d + 1)


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
