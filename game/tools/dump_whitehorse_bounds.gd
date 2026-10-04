extends SceneTree


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var packed: PackedScene = load("res://assets/meshes/quaternius-WhiteHorse.glb")
	var inst: Node3D = packed.instantiate()
	root.add_child(inst)
	_walk(inst, "")
	print("DUMP ok")
	quit(0)


func _walk(n: Node, prefix: String) -> void:
	if n is Node3D:
		var n3 := n as Node3D
		print("N3 ", prefix, n.name, " scale=", n3.scale, " pos=", n3.position, " rot=", n3.rotation_degrees)
	if n is Skeleton3D:
		var sk := n as Skeleton3D
		print("SKEL motion=", sk.motion_scale, " bones=", sk.get_bone_count())
	if n is MeshInstance3D:
		var mi := n as MeshInstance3D
		print("MI ", prefix, n.name, " skin=", mi.skin != null, " aabb=", mi.get_aabb(), " scale=", mi.scale)
		if mi.mesh:
			print("  surfaces=", mi.mesh.get_surface_count(), " type=", mi.mesh.get_class())
			for s in mi.mesh.get_surface_count():
				var arr := mi.mesh.surface_get_arrays(s)
				var verts: PackedVector3Array = arr[Mesh.ARRAY_VERTEX]
				var bones = arr[Mesh.ARRAY_BONES]
				var mn := Vector3(999, 999, 999)
				var mx := Vector3(-999, -999, -999)
				for v in verts:
					mn = mn.min(v)
					mx = mx.max(v)
				var mat := mi.mesh.surface_get_material(s)
				var mname := ""
				if mat:
					mname = mat.resource_name
				print("  surf ", s, " name=", mname, " verts=", verts.size(), " bones=", bones != null, " min=", mn, " max=", mx)
	for c in n.get_children():
		_walk(c, prefix + n.name + "/")
