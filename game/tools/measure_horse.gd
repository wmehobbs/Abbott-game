extends SceneTree


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var packed: PackedScene = load("res://assets/meshes/abbott.glb")
	if packed == null:
		print("MEASURE missing glb")
		quit(1)
		return
	var inst: Node = packed.instantiate()
	root.add_child(inst)
	if inst is Node3D:
		(inst as Node3D).scale = Vector3(0.90, 0.90, 0.90)
	var skel := _find_skel(inst)
	print("MEASURE skel=", skel)
	if skel:
		print("MEASURE bones=", skel.get_bone_count())
		for i in skel.get_bone_count():
			var rest := skel.get_bone_global_rest(i)
			var name := skel.get_bone_name(i)
			var p := rest.origin
			print("MEASURE bone ", i, " ", name, " parent=", skel.get_bone_parent(i), " pos=", p)
	var aabb := _aabb(inst)
	print("MEASURE aabb pos=", aabb.position, " size=", aabb.size, " end=", aabb.end)
	print("MEASURE saddle_guess y=", aabb.position.y + aabb.size.y * 0.72, " z_withers_to_croup")
	quit(0)


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


func _find_skel(n: Node) -> Skeleton3D:
	if n is Skeleton3D:
		return n
	for c in n.get_children():
		var s := _find_skel(c)
		if s:
			return s
	return null
