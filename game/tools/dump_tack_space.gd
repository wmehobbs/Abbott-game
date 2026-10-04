extends SceneTree


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var script: GDScript = load("res://scripts/horse.gd")
	var h: Node = script.new()
	root.add_child(h)
	await process_frame
	await process_frame
	var skel: Skeleton3D = h.get("skel")
	var visual: Node = h.get("visual")
	if skel == null or visual == null:
		print("TACK missing skel/visual")
		quit(1)
		return
	for want in ["Head", "Torso", "Torso2", "Neck3", "Tail1"]:
		var i := skel.find_bone(want)
		if i < 0:
			print("TACK missing ", want)
			continue
		var rest := skel.get_bone_global_rest(i)
		var world := skel.global_transform * rest
		print("TACK bone ", want, " rest_o=", rest.origin, " world=", world.origin)
		print("TACK bone ", want, " basis_x=", world.basis.x, " y=", world.basis.y, " z=", world.basis.z)
	_dump_bone_box(skel, visual, "Head")
	_dump_bone_box(skel, visual, "Torso")
	_dump_muzzle(skel, visual)
	var bridle := _find(h, "BridleAttach")
	var saddle := _find(h, "Saddle")
	var bit := _find(h, "Bit")
	print("TACK bridle=", bridle != null, " saddle=", saddle != null, " bit=", bit != null)
	if bridle:
		print("TACK bridle kids=", bridle.get_child_count(), " pos=", (bridle as Node3D).global_position)
	if saddle:
		print("TACK saddle pos=", (saddle as Node3D).global_position)
	quit(0)


func _dump_bone_box(skel: Skeleton3D, root: Node, bone: String) -> void:
	var i := skel.find_bone(bone)
	if i < 0:
		return
	var xf_inv := (skel.global_transform * skel.get_bone_global_rest(i)).affine_inverse()
	var box := AABB()
	var first := true
	var n := 0
	var stack: Array[Node] = [root]
	while not stack.is_empty():
		var cur: Node = stack.pop_back()
		if cur is MeshInstance3D:
			var mi := cur as MeshInstance3D
			if mi.mesh:
				for s in mi.mesh.get_surface_count():
					var arr := mi.mesh.surface_get_arrays(s)
					var verts: PackedVector3Array = arr[Mesh.ARRAY_VERTEX]
					var bones = arr[Mesh.ARRAY_BONES]
					var weights = arr[Mesh.ARRAY_WEIGHTS]
					if bones == null:
						continue
					var stride := 4
					if bones.size() >= verts.size() * 8:
						stride = 8
					for vi in verts.size():
						var best_w := -1.0
						var best_b := -1
						for k in stride:
							var idx := vi * stride + k
							if idx >= bones.size():
								break
							var w := 0.0
							if weights != null and idx < weights.size():
								w = float(weights[idx])
							if w > best_w:
								best_w = w
								best_b = int(bones[idx])
						if best_b != i or best_w < 0.35:
							continue
						var local: Vector3 = xf_inv * (mi.global_transform * verts[vi])
						if first:
							box = AABB(local, Vector3.ZERO)
							first = false
						else:
							box = box.expand(local)
						n += 1
		for c in cur.get_children():
			stack.append(c)
	print("TACK box ", bone, " n=", n, " pos=", box.position, " size=", box.size, " end=", box.end)


func _dump_muzzle(skel: Skeleton3D, root: Node) -> void:
	var i := skel.find_bone("Head")
	if i < 0:
		return
	var xf_inv := (skel.global_transform * skel.get_bone_global_rest(i)).affine_inverse()
	var box := AABB()
	var first := true
	var n := 0
	var stack: Array[Node] = [root]
	while not stack.is_empty():
		var cur: Node = stack.pop_back()
		if cur is MeshInstance3D and cur.mesh and String(cur.name).findn("bridle") < 0:
			var mi := cur as MeshInstance3D
			if mi.mesh.get_surface_count() > 2:
				var arr := mi.mesh.surface_get_arrays(2)
				if not arr.is_empty():
					var verts: PackedVector3Array = arr[Mesh.ARRAY_VERTEX]
					for v in verts:
						var local: Vector3 = xf_inv * (mi.global_transform * v)
						if first:
							box = AABB(local, Vector3.ZERO)
							first = false
						else:
							box = box.expand(local)
						n += 1
		for c in cur.get_children():
			stack.append(c)
	print("TACK muzzle n=", n, " pos=", box.position, " size=", box.size, " end=", box.end)


func _find(n: Node, name: String) -> Node:
	if n.name == name:
		return n
	for c in n.get_children():
		var f := _find(c, name)
		if f:
			return f
	return null
