extends SceneTree

## Farm vs ring, and Walk-cycle bone distances (tail/legs vs torso).


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var farm_s: GDScript = load("res://scripts/farm.gd")
	var farm: Node3D = farm_s.new()
	root.add_child(farm)
	farm.call("build")
	var ring := AABB(Vector3(-15.24, -0.5, -38.1), Vector3(30.48, 8.0, 76.2))
	var hits := 0
	hits += _scan_ring(farm, ring, "")
	print("DIAG ring_hits=", hits)

	var hs: GDScript = load("res://scripts/horse.gd")
	var horse: Node = hs.new()
	root.add_child(horse)
	await process_frame
	var skel: Skeleton3D = horse.get("skel")
	var anim: AnimationPlayer = horse.get("anim")
	if anim and anim.has_animation("Walk"):
		anim.play("Walk")
	for step in 8:
		await process_frame
		if skel:
			_bones(skel, step)
	var vis: Node3D = horse.get("visual")
	if vis:
		print("DIAG visual_scale=", vis.scale, " mesh_scale=", vis.get_child(0).scale if vis.get_child_count() else Vector3.ONE)
		_print_armature(vis)
	var aabb := _mesh_aabb(horse)
	print("DIAG horse_aabb=", aabb)
	var fail := hits != 0
	if aabb.size.z > 4.0 or aabb.size.y > 4.0:
		push_error("DIAG FAIL horse is building-sized aabb=%s" % aabb)
		fail = true
	if skel:
		var torso := _bone_pos(skel, "Torso")
		var head := _bone_pos(skel, "Head")
		var tail4 := _bone_pos(skel, "Tail4")
		var fl := _bone_pos(skel, "FrontLowerLeg.L")
		var hd := torso.distance_to(head)
		var td := torso.distance_to(tail4)
		var ld := torso.distance_to(fl)
		print("DIAG attach head=", hd, " tail4=", td, " front_leg=", ld)
		if hd < 0.7 or hd > 2.2:
			push_error("DIAG FAIL head detached d=%s" % hd)
			fail = true
		if td < 0.25 or td > 1.4:
			push_error("DIAG FAIL tail detached d=%s" % td)
			fail = true
		if ld < 0.4 or ld > 2.2:
			push_error("DIAG FAIL front leg detached d=%s" % ld)
			fail = true
	if fail:
		print("DIAG fail")
		quit(1)
		return
	print("DIAG ok")
	quit(0)


func _scan_ring(n: Node, ring: AABB, path: String) -> int:
	var hits := 0
	var here := path + n.name
	if n is MeshInstance3D:
		var mi := n as MeshInstance3D
		if mi.mesh and not (mi.name in ["Sand", "Grass"] or "sand" in mi.name.to_lower() or "sod" in mi.name.to_lower() or mi.name == "Mesh"):
			var a := mi.global_transform * mi.mesh.get_aabb()
			if a.intersects(ring) and a.size.y > 1.2 and a.size.x > 2.0:
				print("DIAG OVERLAP ", here, " aabb=", a)
				hits += 1
	for c in n.get_children():
		hits += _scan_ring(c, ring, here + "/")
	return hits


func _bone_pos(skel: Skeleton3D, name: String) -> Vector3:
	var i := skel.find_bone(name)
	if i < 0:
		return Vector3.ZERO
	return (skel.global_transform * skel.get_bone_global_pose(i)).origin


func _print_armature(n: Node) -> void:
	if n is Node3D and n.name == "AnimalArmature":
		print("DIAG armature_scale=", (n as Node3D).scale, " rot=", (n as Node3D).rotation_degrees)
		return
	for c in n.get_children():
		_print_armature(c)


func _mesh_aabb(n: Node) -> AABB:
	var acc := AABB()
	var first := true
	var stack: Array[Node] = [n]
	while not stack.is_empty():
		var cur: Node = stack.pop_back()
		if cur is MeshInstance3D:
			var mi := cur as MeshInstance3D
			if mi.mesh and mi.skin:
				var a := mi.global_transform * mi.mesh.get_aabb()
				if first:
					acc = a
					first = false
				else:
					acc = acc.merge(a)
		for c in cur.get_children():
			stack.append(c)
	return acc


func _bones(skel: Skeleton3D, step: int) -> void:
	var names: Array[String] = ["Torso", "Head", "Tail1", "Tail4", "Back", "FrontLowerLeg.L", "BackLowerLeg.L"]
	var line := "DIAG bones t=%d" % step
	var torso := Vector3.ZERO
	var ti := skel.find_bone("Torso")
	if ti >= 0:
		torso = (skel.global_transform * skel.get_bone_global_pose(ti)).origin
	for n in names:
		var i := skel.find_bone(n)
		if i < 0:
			continue
		var p := (skel.global_transform * skel.get_bone_global_pose(i)).origin
		line += " %s=(%.2f,%.2f,%.2f d=%.2f)" % [n, p.x, p.y, p.z, p.distance_to(torso)]
	print(line)
