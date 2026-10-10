extends SceneTree
## Print the tail tracks of the horse clips: length and Tail bone rotation over time.

func _init() -> void:
	var ps: PackedScene = load("res://assets/meshes/abbott_v2d.glb")
	var inst := ps.instantiate()
	var ap: AnimationPlayer = inst.find_children("*", "AnimationPlayer", true, false)[0]
	var sk: Skeleton3D = inst.find_children("*", "Skeleton3D", true, false)[0]
	for nm in ["Idle", "Walk", "Trot", "Canter", "Gallop", "Gallop_Jump"]:
		if not ap.has_animation(nm):
			continue
		var a := ap.get_animation(nm)
		var line := "%s len=%.2f" % [nm, a.length]
		print(line)
		for ti in a.get_track_count():
			var path := str(a.track_get_path(ti))
			if not (":Tail1" in path or ":Tail3" in path or ":Tail5" in path):
				continue
			if a.track_get_type(ti) != Animation.TYPE_ROTATION_3D:
				continue
			var bone := path.get_slice(":", 1)
			var rest := sk.get_bone_rest(sk.find_bone(bone)).basis.get_rotation_quaternion()
			var vals := []
			for k in 12:
				var q: Quaternion = a.rotation_track_interpolate(ti, a.length * float(k) / 12.0)
				var d := rest.inverse() * q
				var e := d.get_euler() * (180.0 / PI)
				vals.append("(%d,%d,%d)" % [roundi(e.x), roundi(e.y), roundi(e.z)])
			print("  ", bone, " keys=", a.track_get_key_count(ti), " vs rest: ", " ".join(vals))
	inst.free()
	quit(0)
