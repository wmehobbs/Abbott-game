extends SceneTree

## Fails if the ride camera is in the sand (the "only his head" bug).


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var arena_script: GDScript = load("res://scripts/arena.gd")
	var arena: Node = arena_script.new()
	root.add_child(arena)
	for i in 12:
		await process_frame
	var horse: Node = arena.get_node_or_null("Abbott")
	if horse == null:
		push_error("VERIFY VIS fail: no horse")
		quit(1)
		return
	horse.call("_place_cam")
	await process_frame
	var cam: Camera3D = horse.get("cam")
	if cam == null:
		push_error("VERIFY VIS fail: no camera")
		quit(1)
		return
	var hp: Vector3 = horse.global_position
	var cp: Vector3 = cam.global_position
	var look := hp + Vector3(0, 1.12, 0)
	var to := look - cp
	var dist := to.length()
	var elev := rad_to_deg(asin(clampf(to.y / maxf(dist, 0.001), -1.0, 1.0)))
	print("VERIFY VIS horse=", hp, " rot_y=", horse.rotation.y)
	print("VERIFY VIS cam=", cp, " dist=", dist, " elev_deg=", elev)
	print("VERIFY VIS cam_y=", cp.y, " min_ok=2.20")
	var aabb := _horse_aabb(horse)
	print("VERIFY VIS horse_aabb=", aabb)
	var fail := false
	if aabb.size.z > 4.0 or aabb.size.y > 4.0:
		push_error("VERIFY VIS FAIL horse is building-sized aabb=%s" % aabb)
		fail = true
	if cp.y < 2.20:
		push_error("VERIFY VIS FAIL camera in the sand y=%s" % cp.y)
		fail = true
	if cp.y < hp.y + 2.0:
		push_error("VERIFY VIS FAIL camera not above the horse y=%s horse=%s" % [cp.y, hp.y])
		fail = true
	if dist < 3.5 or dist > 8.0:
		push_error("VERIFY VIS FAIL framing distance %s" % dist)
		fail = true
	# Sand top is y=0. Camera must not be inside the sand box (y -0.08 .. 0).
	if cp.y < 0.5:
		push_error("VERIFY VIS FAIL camera inside ground volume")
		fail = true
	if fail:
		quit(1)
		return
	print("VERIFY VIS ok")
	quit(0)


func _horse_aabb(n: Node) -> AABB:
	var acc := AABB()
	var first := true
	var stack: Array[Node] = [n]
	while not stack.is_empty():
		var cur: Node = stack.pop_back()
		if cur is MeshInstance3D:
			var mi := cur as MeshInstance3D
			if mi.mesh:
				var a := mi.global_transform * mi.mesh.get_aabb()
				if first:
					acc = a
					first = false
				else:
					acc = acc.merge(a)
		for c in cur.get_children():
			stack.append(c)
	return acc
