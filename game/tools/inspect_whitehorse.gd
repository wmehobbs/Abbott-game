extends SceneTree


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var path := "res://assets/meshes/quaternius-WhiteHorse.glb"
	if not ResourceLoader.exists(path):
		print("WH missing ", path)
		quit(1)
		return
	var packed: PackedScene = load(path)
	var inst: Node = packed.instantiate()
	root.add_child(inst)
	print("WH root=", inst.name, " class=", inst.get_class())
	_dump(inst, 0)
	var anim := _find_anim(inst)
	var skel := _find_skel(inst)
	print("WH anim=", anim)
	if anim:
		print("WH list=", anim.get_animation_list())
		print("WH libs=", anim.get_animation_library_list())
		print("WH root_node=", anim.root_node)
		for n in anim.get_animation_list():
			var a: Animation = anim.get_animation(n)
			if a:
				print("WH clip ", n, " len=", a.length, " loop=", a.loop_mode, " tracks=", a.get_track_count())
	print("WH skel=", skel)
	if skel:
		print("WH bones=", skel.get_bone_count())
		for i in skel.get_bone_count():
			var rest := skel.get_bone_global_rest(i)
			print("WH bone ", i, " ", skel.get_bone_name(i), " parent=", skel.get_bone_parent(i), " pos=", rest.origin)
	var aabb := _aabb(inst)
	print("WH aabb pos=", aabb.position, " size=", aabb.size, " end=", aabb.end)
	if skel and inst is Node3D:
		for want in ["Torso", "Torso2", "Torso3", "Back", "Body", "Neck1", "Head", "Tail1"]:
			var i := skel.find_bone(want)
			if i < 0:
				print("WH missing bone ", want)
				continue
			var xf := (inst as Node3D).global_transform * skel.global_transform.affine_inverse()
			# bone rest is in skeleton space
			var world := skel.global_transform * skel.get_bone_global_rest(i)
			print("WH world ", want, " ", world.origin)
			var back_y := _back_y_near(inst, world.origin, 0.28)
			print("WH back_y_near ", want, " ", back_y, " lift=", back_y - world.origin.y)
	quit(0)


func _dump(n: Node, depth: int) -> void:
	var pad := ""
	for _i in range(depth):
		pad += "  "
	var extra := ""
	if n is Node3D:
		var n3 := n as Node3D
		extra = " pos=%s rot=%s scale=%s" % [n3.position, n3.rotation_degrees, n3.scale]
	print("WH ", pad, n.name, " [", n.get_class(), "]", extra)
	for c in n.get_children():
		_dump(c, depth + 1)


func _aabb(n: Node) -> AABB:
	var box := AABB()
	var first := true
	if n is VisualInstance3D:
		var vi := n as VisualInstance3D
		var local := vi.get_aabb()
		var xf := vi.global_transform
		for i in 8:
			var c := local.position + local.size * Vector3(float(i & 1), float((i >> 1) & 1), float((i >> 2) & 1))
			var w := xf * c
			if first:
				box = AABB(w, Vector3.ZERO)
				first = false
			else:
				box = box.expand(w)
	for c in n.get_children():
		var child := _aabb(c)
		if child.size != Vector3.ZERO:
			if first:
				box = child
				first = false
			else:
				box = box.merge(child)
	return box


func _back_y_near(n: Node, around: Vector3, radius: float) -> float:
	var best := around.y
	if n is MeshInstance3D:
		var mi := n as MeshInstance3D
		if mi.mesh:
			for s in mi.mesh.get_surface_count():
				var arr := mi.mesh.surface_get_arrays(s)
				var verts: PackedVector3Array = arr[Mesh.ARRAY_VERTEX]
				for v in verts:
					var w := mi.global_transform * v
					if Vector2(w.x - around.x, w.z - around.z).length() <= radius:
						best = maxf(best, w.y)
	for c in n.get_children():
		best = maxf(best, _back_y_near(c, around, radius))
	return best


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
