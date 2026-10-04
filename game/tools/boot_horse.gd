extends SceneTree


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	print("BOOT start")
	var h: Node = (load("res://scripts/horse.gd") as GDScript).new()
	root.add_child(h)
	print("BOOT horse in tree anim=", h.get("anim"), " rider=", h.get("rider"), " skel=", h.get("skel"), " seat=", h.get("seat_bone"))
	var ap = h.get("anim")
	if ap:
		print("BOOT playing=", ap.is_playing(), " name=", ap.current_animation, " list=", ap.get_animation_list())
		if ap.has_animation("Walk"):
			var walk: Animation = ap.get_animation("Walk")
			print("BOOT walk loop=", walk.loop_mode, " len=", walk.length)
	var rider = h.get("rider")
	if rider:
		var p: Node = rider.get_parent()
		print("BOOT rider_parent=", p.name if p else "none")
		if p and p.get_parent() is BoneAttachment3D:
			print("BOOT attach_bone=", (p.get_parent() as BoneAttachment3D).bone_name)
	print("BOOT ok")
	quit(0)
