extends SceneTree


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var hs: GDScript = load("res://scripts/horse.gd")
	var horse: Node = hs.new()
	root.add_child(horse)
	await process_frame
	var skel: Skeleton3D = horse.get("skel")
	_dump_mesh(horse)
	if skel:
		var anim: AnimationPlayer = horse.get("anim")
		if anim and anim.has_animation("Walk"):
			anim.play("Walk")
			anim.seek(0.2, true)
		await process_frame
		_tail_vs_hair(horse, skel)
	print("DUMP UV/TAIL ok")
	quit(0)


func _dump_mesh(n: Node) -> void:
	if n is MeshInstance3D:
		var mi := n as MeshInstance3D
		if mi.mesh and mi.skin:
			for s in mi.mesh.get_surface_count():
				var arr := mi.mesh.surface_get_arrays(s)
				var verts: PackedVector3Array = arr[Mesh.ARRAY_VERTEX]
				var uvs = arr[Mesh.ARRAY_TEX_UV]
				var uv2 = arr[Mesh.ARRAY_TEX_UV2]
				var nrm = arr[Mesh.ARRAY_NORMAL]
				print("UV surf ", s, " verts=", verts.size(), " uv=", uvs.size() if uvs is PackedVector2Array else 0, " uv2=", uv2.size() if uv2 is PackedVector2Array else 0, " nrm=", nrm.size() if nrm is PackedVector3Array else 0)
				if uvs is PackedVector2Array and uvs.size() > 0:
					var mn := Vector2(999, 999)
					var mx := Vector2(-999, -999)
					for uv in uvs:
						mn = mn.min(uv)
						mx = mx.max(uv)
					print("  uv range ", mn, " .. ", mx)
	for c in n.get_children():
		_dump_mesh(c)


func _tail_vs_hair(n: Node, skel: Skeleton3D) -> void:
	var t1 := _bone(skel, "Tail1")
	var t4 := _bone(skel, "Tail4")
	var back := _bone(skel, "Back")
	print("BONE Tail1=", t1, " Tail4=", t4, " Back=", back)
	if n is MeshInstance3D:
		var mi := n as MeshInstance3D
		if mi.mesh and mi.skin:
			var arr := mi.mesh.surface_get_arrays(1)
			if arr.size() > 0:
				var verts: PackedVector3Array = arr[Mesh.ARRAY_VERTEX]
				var bones = arr[Mesh.ARRAY_BONES]
				var weights = arr[Mesh.ARRAY_WEIGHTS]
				var acc := Vector3.ZERO
				var cnt := 0
				var tail_acc := Vector3.ZERO
				var tail_n := 0
				for vi in verts.size():
					var w := mi.global_transform * verts[vi]
					acc += w
					cnt += 1
					var bname := _dom(skel, bones, weights, vi, 4)
					if bname.begins_with("Tail"):
						tail_acc += w
						tail_n += 1
				if cnt > 0:
					print("HAIR centroid=", acc / float(cnt), " n=", cnt)
				if tail_n > 0:
					var tc := tail_acc / float(tail_n)
					print("TAILHAIR centroid=", tc, " n=", tail_n, " vs Tail1 d=", tc.distance_to(t1), " vs Tail4 d=", tc.distance_to(t4))
	for c in n.get_children():
		_tail_vs_hair(c, skel)


func _dom(skel: Skeleton3D, bones, weights, vi: int, stride: int) -> String:
	if bones == null:
		return ""
	var best_i := 0
	var best_w := -1.0
	for k in stride:
		var idx := vi * stride + k
		if idx >= bones.size():
			break
		var w := 0.0
		if weights != null and idx < weights.size():
			w = float(weights[idx])
		if w > best_w:
			best_w = w
			best_i = int(bones[idx])
	if best_i < 0 or best_i >= skel.get_bone_count():
		return ""
	return skel.get_bone_name(best_i)


func _bone(skel: Skeleton3D, name: String) -> Vector3:
	var i := skel.find_bone(name)
	if i < 0:
		return Vector3.ZERO
	return (skel.global_transform * skel.get_bone_global_pose(i)).origin
