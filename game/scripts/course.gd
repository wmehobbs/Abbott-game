extends Node3D
class_name Course

var fences: Array[JumpFence] = []
var start_pos: Vector3 = Vector3(0, 0, -28.0)
var start_yaw: float = PI
var finish_area: Area3D
var start_area: Area3D
var _ship_finish_z: float = -999.0
## The ship course this round was built from (empty on the built-in fallback).
var loaded: Dictionary = {}


func build(_indoor: bool, _seed: int) -> void:
	_wipe()
	_build_outdoor()
	_start_finish()


func reset_flags() -> void:
	for f in fences:
		if f == null or not is_instance_valid(f):
			continue
		f.knocked = false
		f.cleared = false
		f.refused = false
		f.pending_chip = false


func _wipe() -> void:
	if start_area and start_area.body_entered.is_connected(_on_start):
		start_area.body_entered.disconnect(_on_start)
	if finish_area and finish_area.body_entered.is_connected(_on_finish):
		finish_area.body_entered.disconnect(_on_finish)
	var kids: Array[Node] = []
	for c in get_children():
		kids.append(c)
	for c in kids:
		if c is JumpFence:
			var f: JumpFence = c
			f.remove_from_group("fences")
			for r in f.rails:
				if is_instance_valid(r):
					r.freeze = true
					r.linear_velocity = Vector3.ZERO
					r.angular_velocity = Vector3.ZERO
		remove_child(c)
		c.queue_free()
	fences.clear()
	start_area = null
	finish_area = null


func _build_outdoor() -> void:
	# Behind the start flags, facing up the ring. The old z=-28 start
	# sat past the clock, so a ride never opened unless you turned around.
	start_pos = Vector3(0, 0, -34.6)
	start_yaw = PI
	_ship_finish_z = -999.0
	var specs: Array = _specs_for(GameState.class_id)
	for i in range(specs.size()):
		var s: Dictionary = specs[i]
		_add_fence(i + 1, s.kind, s.h, s.sp, s.pos, s.yaw)


func _specs_for(cid: String) -> Array:
	var lib: Dictionary = ContentLibrary.ship_course(cid, GameState.jump_off, GameState.course_seed, GameState.indoor)
	loaded = lib
	if not lib.is_empty():
		var specs: Array = ContentLibrary.specs_from_course(lib)
		if specs.size() > 0:
			var sp: Variant = lib.get("start_pos", [0.0, 0.0, -34.6])
			if typeof(sp) == TYPE_ARRAY and sp.size() >= 3:
				start_pos = Vector3(float(sp[0]), float(sp[1]), float(sp[2]))
			start_yaw = float(lib.get("start_yaw", PI))
			_ship_finish_z = float(lib.get("finish_z", -36.2))
			return specs
	if GameState.jump_off:
		return _jump_off_specs(cid)
	match cid:
		"lesson":
			# Pole, a single fence, then a two-stride line. Real related distance.
			return [
				{"kind": "vertical", "h": 0.42, "sp": 0.0, "pos": Vector3(0.0, 0, -18.0), "yaw": 0.0},
				{"kind": "vertical", "h": 0.58, "sp": 0.0, "pos": Vector3(5.5, 0, -2.0), "yaw": -0.04},
				{"kind": "vertical", "h": 0.62, "sp": 0.0, "pos": Vector3(5.5, 0, 10.4), "yaw": -0.04},
			]
		"beginner":
			# Outside track, 2'0–2'3", eight fences. Room to find a canter.
			return [
				{"kind": "vertical", "h": 0.58, "sp": 0.0, "pos": Vector3(7.0, 0, -20.0), "yaw": 0.0},
				{"kind": "vertical", "h": 0.62, "sp": 0.0, "pos": Vector3(-7.2, 0, -10.0), "yaw": 0.06},
				{"kind": "flower", "h": 0.62, "sp": 0.0, "pos": Vector3(7.5, 0, 2.0), "yaw": -0.04},
				{"kind": "oxer", "h": 0.64, "sp": 0.40, "pos": Vector3(-6.5, 0, 12.0), "yaw": 0.10},
				{"kind": "vertical", "h": 0.68, "sp": 0.0, "pos": Vector3(6.8, 0, 22.0), "yaw": -0.06},
				{"kind": "oxer", "h": 0.68, "sp": 0.45, "pos": Vector3(0.0, 0, 28.0), "yaw": 0.0},
				{"kind": "vertical", "h": 0.64, "sp": 0.0, "pos": Vector3(-7.0, 0, 8.0), "yaw": PI + 0.05},
				{"kind": "vertical", "h": 0.60, "sp": 0.0, "pos": Vector3(5.5, 0, -8.0), "yaw": PI - 0.08},
			]
		"advanced":
			# Twelve fences, 2'9–3'0", a related distance and a rollback.
			return [
				{"kind": "vertical", "h": 0.84, "sp": 0.0, "pos": Vector3(7.2, 0, -24.0), "yaw": 0.0},
				{"kind": "oxer", "h": 0.88, "sp": 0.70, "pos": Vector3(-7.4, 0, -16.0), "yaw": 0.14},
				{"kind": "vertical", "h": 0.90, "sp": 0.0, "pos": Vector3(8.0, 0, -6.0), "yaw": -0.10},
				{"kind": "flower", "h": 0.88, "sp": 0.0, "pos": Vector3(-6.2, 0, 2.0), "yaw": 0.18},
				{"kind": "oxer", "h": 0.92, "sp": 0.80, "pos": Vector3(7.6, 0, 12.0), "yaw": -0.08},
				{"kind": "vertical", "h": 0.90, "sp": 0.0, "pos": Vector3(0.0, 0, 24.0), "yaw": 0.0},
				{"kind": "oxer", "h": 0.94, "sp": 0.75, "pos": Vector3(-8.0, 0, 16.0), "yaw": PI + 0.10},
				{"kind": "vertical", "h": 0.90, "sp": 0.0, "pos": Vector3(5.2, 0, 6.0), "yaw": PI - 0.14},
				{"kind": "flower", "h": 0.88, "sp": 0.0, "pos": Vector3(-7.8, 0, -4.0), "yaw": PI + 0.06},
				{"kind": "oxer", "h": 0.92, "sp": 0.70, "pos": Vector3(4.2, 0, -14.0), "yaw": PI - 0.18},
				{"kind": "vertical", "h": 0.86, "sp": 0.0, "pos": Vector3(-4.8, 0, -22.0), "yaw": 0.22},
				{"kind": "vertical", "h": 0.90, "sp": 0.0, "pos": Vector3(6.4, 0, 26.5), "yaw": 0.0},
			]
		_:
			# Schooling jumpers, 2'6", ten fences. The original Hidden K track.
			return [
				{"kind": "vertical", "h": 0.75, "sp": 0.0, "pos": Vector3(6.5, 0, -22.0), "yaw": 0.0},
				{"kind": "vertical", "h": 0.80, "sp": 0.0, "pos": Vector3(-7.0, 0, -14.0), "yaw": 0.12},
				{"kind": "flower", "h": 0.80, "sp": 0.0, "pos": Vector3(8.0, 0, -4.0), "yaw": -0.08},
				{"kind": "oxer", "h": 0.80, "sp": 0.55, "pos": Vector3(-6.0, 0, 6.0), "yaw": 0.18},
				{"kind": "vertical", "h": 0.85, "sp": 0.0, "pos": Vector3(7.5, 0, 16.0), "yaw": -0.10},
				{"kind": "oxer", "h": 0.85, "sp": 0.65, "pos": Vector3(0.0, 0, 26.0), "yaw": 0.0},
				{"kind": "flower", "h": 0.85, "sp": 0.0, "pos": Vector3(-8.5, 0, 18.0), "yaw": PI + 0.08},
				{"kind": "vertical", "h": 0.90, "sp": 0.0, "pos": Vector3(5.0, 0, 8.0), "yaw": PI - 0.12},
				{"kind": "oxer", "h": 0.90, "sp": 0.70, "pos": Vector3(-7.5, 0, -2.0), "yaw": PI + 0.05},
				{"kind": "vertical", "h": 0.78, "sp": 0.0, "pos": Vector3(4.0, 0, -12.0), "yaw": PI - 0.16},
			]


func _jump_off_specs(cid: String) -> Array:
	var h := 0.68
	var sp := 0.45
	match cid:
		"advanced":
			h = 0.90
			sp = 0.70
		"intermediate":
			h = 0.82
			sp = 0.58
		_:
			h = 0.64
			sp = 0.40
	return [
		{"kind": "vertical", "h": h, "sp": 0.0, "pos": Vector3(6.6, 0, -18.0), "yaw": 0.0},
		{"kind": "oxer", "h": h + 0.04, "sp": sp, "pos": Vector3(-6.4, 0, -2.0), "yaw": 0.12},
		{"kind": "vertical", "h": h, "sp": 0.0, "pos": Vector3(7.0, 0, 16.0), "yaw": -0.08},
		{"kind": "oxer", "h": h, "sp": sp, "pos": Vector3(-4.2, 0, -10.0), "yaw": PI - 0.06},
	]


func _add_fence(num: int, kind: String, h: float, spread: float, pos: Vector3, yaw: float, w: float = 3.05) -> void:
	var f := JumpFence.new()
	f.name = "Fence%d" % num
	add_child(f)
	f.setup(num, kind, h, spread, w)
	f.position = pos
	f.rotation.y = yaw
	fences.append(f)


func _process(_delta: float) -> void:
	for f in fences:
		if f and is_instance_valid(f):
			f.set_current(f.number == GameState.next_fence and GameState.mode == "ride" and not GameState.round_complete)


func _finish_z() -> float:
	if _ship_finish_z > -900.0:
		return _ship_finish_z
	if GameState.jump_off:
		return -36.2
	match GameState.class_id:
		"lesson":
			return 16.8
		"advanced":
			return 32.4
		_:
			return -36.2


func _start_finish() -> void:
	start_area = _gate_line(-32.0, "Start", Color(0.78, 0.14, 0.12))
	finish_area = _gate_line(_finish_z(), "Finish", Color(0.14, 0.32, 0.72))
	start_area.body_entered.connect(_on_start)
	finish_area.body_entered.connect(_on_finish)


func _gate_line(z: float, n: String, col: Color) -> Area3D:
	var a := Area3D.new()
	a.name = n
	a.collision_layer = 4
	a.collision_mask = 1
	var cs := CollisionShape3D.new()
	var b := BoxShape3D.new()
	b.size = Vector3(18.0, 2.0, 0.8)
	cs.shape = b
	a.add_child(cs)
	a.position = Vector3(0, 1.0, z)
	add_child(a)
	var white := MeshKit.wood_white()
	var cloth := MeshKit.mat_color(col, 0.58)
	var cream := MeshKit.mat_color(Color(0.96, 0.94, 0.88), 0.50)
	for sx in [-1.0, 1.0]:
		var x: float = 8.2 * float(sx)
		MeshKit.add_child_mi(a, MeshKit.box(Vector3(0.12, 2.85, 0.12)), white, "Std", Vector3(x, 0.42, 0))
		MeshKit.add_child_mi(a, MeshKit.box(Vector3(0.18, 0.06, 0.18)), white, "StdCap", Vector3(x, 1.86, 0))
		MeshKit.add_child_mi(a, MeshKit.box(Vector3(0.28, 0.06, 0.28)), white, "StdFoot", Vector3(x, -0.72, 0))
		MeshKit.add_child_mi(a, MeshKit.cyl(0.018, 0.92, 0.014, 6), white, "FlagPole", Vector3(x, 2.08, 0))
		MeshKit.add_child_mi(a, MeshKit.box(Vector3(0.58, 0.36, 0.03)), cloth, "Flag", Vector3(x + sx * 0.32, 2.38, 0))
		MeshKit.add_child_mi(a, MeshKit.box(Vector3(0.58, 0.07, 0.03)), cream, "FlagTip", Vector3(x + sx * 0.32, 2.60, 0))
		MeshKit.add_child_mi(a, MeshKit.box(Vector3(0.34, 0.26, 0.04)), cream, "InPlate", Vector3(x + sx * 0.22, 0.72, 0.08))
		for i in range(5):
			var by := -0.55 + float(i) * 0.22
			var bmat := cloth if i % 2 == 0 else cream
			MeshKit.add_child_mi(a, MeshKit.box(Vector3(0.42, 0.18, 0.03)), bmat, "Bunt", Vector3(x + sx * 0.22, by, 0.02))
		var dirt := MeshKit.mat_color(Color(0.26, 0.18, 0.11), 0.86)
		var leaf := MeshKit.mat_color(Color(0.20, 0.34, 0.14), 0.80)
		MeshKit.add_child_mi(a, MeshKit.box(Vector3(0.52, 0.22, 0.38)), white, "FlagBox", Vector3(x + sx * 0.58, -0.66, 0.12))
		MeshKit.add_child_mi(a, MeshKit.box(Vector3(0.44, 0.05, 0.30)), dirt, "FlagSoil", Vector3(x + sx * 0.58, -0.54, 0.12))
		MeshKit.add_child_mi(a, MeshKit.sphere(0.08, 6, 8), leaf, "FlagLeaf", Vector3(x + sx * 0.58, -0.46, 0.12))
		MeshKit.add_child_mi(a, MeshKit.sphere(0.04, 6, 8), cloth, "FlagBloom", Vector3(x + sx * 0.52, -0.40, 0.14))
	MeshKit.add_child_mi(a, MeshKit.box(Vector3(16.2, 0.03, 0.16)), cream, "Ground", Vector3(0, -0.96, 0))
	var lab := Label3D.new()
	lab.text = "IN" if n == "Start" else "OUT"
	lab.font_size = 68
	lab.position = Vector3(0, 1.72, 0)
	lab.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	lab.modulate = col
	lab.outline_modulate = Color(0.06, 0.05, 0.04, 0.85)
	lab.outline_size = 8
	a.add_child(lab)
	return a


func _on_start(body: Node) -> void:
	if body is Horse and GameState.mode == "ride":
		GameState.start_clock()


func _on_finish(body: Node) -> void:
	if body is Horse and GameState.mode == "ride" and not GameState.round_complete:
		if GameState.can_finish():
			GameState.finish_round()


func fence_at_position(pos: Vector3, max_d: float = 2.4) -> JumpFence:
	var best: JumpFence = null
	var bd := max_d
	for f in fences:
		var d := pos.distance_to(f.global_position)
		if d < bd:
			bd = d
			best = f
	return best
