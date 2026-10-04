extends Node3D
class_name JumpFence

@export var height: float = 0.85
@export var spread: float = 0.0
@export var number: int = 1
@export var kind: String = "vertical"
var knocked: bool = false
var refused: bool = false
var cleared: bool = false
var pending_chip: bool = false
var rails: Array[RigidBody3D] = []
var width: float = 3.05
var takeoff_mark: MeshInstance3D
var num_lab: Label3D
var num_plate: MeshInstance3D


func setup(p_number: int, p_kind: String, p_height: float, p_spread: float, p_width: float = 3.05) -> void:
	number = p_number
	kind = p_kind
	height = p_height
	spread = p_spread if p_kind == "oxer" else 0.0
	if p_kind == "flower":
		spread = 0.0
	width = p_width
	_build()


func takeoff_dir() -> Vector3:
	return global_transform.basis.z


func takeoff_point() -> Vector3:
	return global_position + takeoff_dir() * -2.55


func _build() -> void:
	add_to_group("fences")
	var wood := MeshKit.wood_oak()
	var white := MeshKit.mat_tex("res://assets/textures/pole_white_albedo.jpg", 0.72, Color(0.95, 0.94, 0.90))
	var navy_p := MeshKit.mat_tex("res://assets/textures/pole_navy_albedo.jpg", 0.72)
	var red_p := MeshKit.mat_tex("res://assets/textures/pole_red_albedo.jpg", 0.72)
	var pole_mat: Material = wood
	if GameState.session_kind == "show":
		pole_mat = navy_p if number % 3 == 0 else (red_p if number % 2 == 0 else white)
	elif GameState.session_kind == "schooling" and number % 5 == 0:
		pole_mat = navy_p
	if pole_mat == null or (pole_mat is StandardMaterial3D and (pole_mat as StandardMaterial3D).albedo_texture == null):
		pole_mat = MeshKit.mat_color(Color(0.78, 0.68, 0.48), 0.55)

	var half := width * 0.5
	var std_h := maxf(1.38, height + 0.48)
	_standard(Vector3(-half, 0, 0), std_h, wood, white)
	_standard(Vector3(half, 0, 0), std_h, wood, white)
	if spread > 0.05:
		_standard(Vector3(-half, 0, -spread), std_h, wood, white)
		_standard(Vector3(half, 0, -spread), std_h, wood, white)

	var n_poles := 2 if height < 0.8 else 3
	for i in range(n_poles):
		var y := 0.28 + i * (height / float(n_poles))
		_rail(Vector3(0, y, 0), pole_mat)
		if spread > 0.05:
			_rail(Vector3(0, y + (0.04 if i == n_poles - 1 else 0.0), -spread), pole_mat)
	if kind != "flower" and height >= 0.72:
		_plank_filler(0.22)

	if kind == "flower":
		_flower_box()
	elif kind == "oxer":
		_hunter_gate()
	else:
		_brush()
		if number % 2 == 0:
			_hunter_gate()

	_takeoff_mark()
	_flag(half, std_h, white)
	_wing_planter(Vector3(-half, 0, 0.72))
	_wing_planter(Vector3(half, 0, 0.72))

	var knock := Area3D.new()
	knock.name = "Knock"
	knock.collision_layer = 4
	knock.collision_mask = 1
	var ks := CollisionShape3D.new()
	var kb := BoxShape3D.new()
	kb.size = Vector3(width * 0.9, height + 0.15, 0.35 + spread)
	ks.shape = kb
	knock.position = Vector3(0, height * 0.5, -spread * 0.5)
	knock.add_child(ks)
	add_child(knock)
	knock.body_entered.connect(_on_knock_body)

	var plate := MeshKit.mat_color(Color(0.96, 0.95, 0.92), 0.55)
	num_plate = MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.50, 0.50, 0.055)), plate, "NumPlate", Vector3(-half - 0.22, std_h + 0.08, 0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.56, 0.06, 0.16)), MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.58, Color(0.78, 0.70, 0.52)), "NumHood", Vector3(-half - 0.22, std_h + 0.35, 0.04))
	num_lab = Label3D.new()
	num_lab.text = str(number)
	num_lab.font_size = 64
	num_lab.modulate = Color(0.08, 0.07, 0.06)
	num_lab.outline_modulate = Color(1, 1, 1, 0)
	num_lab.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	num_lab.position = Vector3(-half - 0.22, std_h + 0.08, 0.06)
	add_child(num_lab)
	_ground_line()


func set_current(on: bool) -> void:
	if num_lab:
		num_lab.modulate = Color(0.72, 0.10, 0.08) if on else Color(0.08, 0.07, 0.06)
		num_lab.font_size = 74 if on else 64
		num_lab.outline_modulate = Color(0.98, 0.94, 0.86, 0.9) if on else Color(1, 1, 1, 0)
		num_lab.outline_size = 10 if on else 0
	if num_plate and num_plate.material_override is StandardMaterial3D:
		(num_plate.material_override as StandardMaterial3D).albedo_color = Color(0.98, 0.86, 0.42) if on else Color(0.96, 0.95, 0.92)


func _ground_line() -> void:
	var white := MeshKit.mat_tex("res://assets/textures/pole_white_albedo.jpg", 0.48, Color(0.95, 0.94, 0.90))
	if white == null or (white is StandardMaterial3D and (white as StandardMaterial3D).albedo_texture == null):
		white = MeshKit.mat_color(Color(0.94, 0.93, 0.88), 0.5)
	var rail := MeshInstance3D.new()
	var cyl := CylinderMesh.new()
	cyl.top_radius = 0.056
	cyl.bottom_radius = 0.056
	cyl.height = width * 0.92
	cyl.radial_segments = 10
	rail.mesh = cyl
	rail.material_override = white
	rail.rotation_degrees = Vector3(0, 0, 90)
	rail.position = Vector3(0, 0.038, -0.34)
	rail.name = "GroundLine"
	add_child(rail)
	var rail2 := MeshInstance3D.new()
	var cyl2 := CylinderMesh.new()
	cyl2.top_radius = 0.056
	cyl2.bottom_radius = 0.056
	cyl2.height = width * 0.92
	cyl2.radial_segments = 10
	rail2.mesh = cyl2
	rail2.material_override = white
	rail2.rotation_degrees = Vector3(0, 0, 90)
	rail2.position = Vector3(0, 0.038, 0.28)
	rail2.name = "GroundLine2"
	add_child(rail2)


func _takeoff_mark() -> void:
	if GameState.session_kind != "lesson":
		return
	takeoff_mark = MeshInstance3D.new()
	takeoff_mark.name = "TakeoffMark"
	var box := BoxMesh.new()
	box.size = Vector3(2.35, 0.03, 0.42)
	takeoff_mark.mesh = box
	takeoff_mark.material_override = MeshKit.mat_color(Color(0.86, 0.72, 0.42), 0.88)
	takeoff_mark.position = Vector3(0, 0.016, -2.55)
	add_child(takeoff_mark)
	var mark2 := MeshInstance3D.new()
	var box2 := BoxMesh.new()
	box2.size = Vector3(1.65, 0.022, 0.22)
	mark2.mesh = box2
	mark2.material_override = MeshKit.mat_color(Color(0.92, 0.82, 0.52), 0.9)
	mark2.position = Vector3(0, 0.012, -2.12)
	add_child(mark2)
	var pole := MeshInstance3D.new()
	var cyl := CylinderMesh.new()
	cyl.top_radius = 0.04
	cyl.bottom_radius = 0.04
	cyl.height = 2.2
	cyl.radial_segments = 10
	pole.mesh = cyl
	pole.material_override = MeshKit.mat_color(Color(0.94, 0.93, 0.88), 0.5)
	pole.rotation_degrees = Vector3(0, 0, 90)
	pole.position = Vector3(0, 0.045, -2.55)
	add_child(pole)


func _standard(pos: Vector3, h: float, wood: Material, white: Material) -> void:
	# Two-post hunter wing with a lower panel. Jump post stays here so cups sit.
	# Used oak, square cap, no PVC ball. Knock box is not here.
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.11, h, 0.11)), wood, "Post", pos + Vector3(0, h * 0.5, 0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.11, h * 0.78, 0.11)), wood, "WingPost", pos + Vector3(0, h * 0.40, 0.58))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.08, 0.05, 0.62)), white, "WingCapRail", pos + Vector3(0, h * 0.78, 0.29))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.038, h * 0.36, 0.50)), wood, "WingPanel", pos + Vector3(0, h * 0.20, 0.29))
	for i in range(3):
		var wy := h * 0.42 + float(i) * (h * 0.11)
		MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.035, 0.038, 0.54)), white, "WingRail", pos + Vector3(0, wy, 0.29))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.16, 0.06, 0.16)), wood, "Cap", pos + Vector3(0, h + 0.02, 0))
	var navy_band := MeshKit.mat_color(Color(0.12, 0.16, 0.28), 0.45)
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.128, 0.08, 0.128)), navy_band, "PostNavy", pos + Vector3(0, h * 0.46, 0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.16, 0.05, 0.16)), wood, "WingCap", pos + Vector3(0, h * 0.80, 0.58))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.32, 0.07, 0.32)), wood, "Foot", pos + Vector3(0, 0.035, 0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.28, 0.06, 0.28)), wood, "WingFoot", pos + Vector3(0, 0.03, 0.58))
	var cup_m := MeshKit.mat_color(Color(0.36, 0.24, 0.12), 0.68, 0.10)
	var pin_m := MeshKit.steel()
	for i in range(7):
		var y := 0.24 + i * 0.18
		if y < h - 0.10:
			MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.16, 0.028, 0.062)), cup_m, "Cup", pos + Vector3(0, y, 0))
			MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.08, 0.016, 0.08)), cup_m, "CupHook", pos + Vector3(0.09, y, 0))
			MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.020, 0.062, 0.020)), cup_m, "CupLip", pos + Vector3(0.058, y + 0.032, 0))
			MeshKit.add_child_mi(self, MeshKit.cyl(0.004, 0.08, 0.004, 5), pin_m, "Pin", pos + Vector3(0.072, y + 0.012, 0), Vector3(0, 0, 1.2))
			MeshKit.add_child_mi(self, MeshKit.cyl(0.012, 0.018, 0.012, 6), pin_m, "PinHead", pos + Vector3(0.078, y + 0.030, 0))


func _rail(pos: Vector3, mat: Material) -> void:
	var body := RigidBody3D.new()
	body.mass = 6.0
	body.freeze = true
	body.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	body.collision_layer = 8
	body.collision_mask = 2
	body.position = pos
	var mesh := MeshInstance3D.new()
	var cyl := CylinderMesh.new()
	cyl.top_radius = 0.046
	cyl.bottom_radius = 0.056
	cyl.height = width
	cyl.radial_segments = 12
	mesh.mesh = cyl
	mesh.material_override = mat
	mesh.rotation_degrees = Vector3(0, 0, 90)
	body.add_child(mesh)
	var col := CollisionShape3D.new()
	var cap := CapsuleShape3D.new()
	cap.radius = 0.045
	cap.height = width
	col.shape = cap
	col.rotation_degrees = Vector3(0, 0, 90)
	body.add_child(col)
	add_child(body)
	rails.append(body)


func _plank_filler(y: float) -> void:
	var plank := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.62, Color(0.78, 0.68, 0.48))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.80, 0.12, 0.058)), plank, "Filler", Vector3(0, y, 0.06))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.80, 0.12, 0.058)), plank, "Filler2", Vector3(0, y + 0.15, 0.06))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.80, 0.12, 0.058)), plank, "Filler3", Vector3(0, y + 0.30, 0.06))
	# Sloped coop face toward the approach. Not a billboard.
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.78, 0.055, 0.46)), plank, "CoopSlope", Vector3(0, y + 0.16, -0.04), Vector3(-0.62, 0.0, 0.0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.78, 0.20, 0.045)), plank, "CoopBack", Vector3(0, y + 0.18, 0.16))


func _hunter_gate() -> void:
	var plank := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.60, Color(0.72, 0.60, 0.42))
	var dark := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.66, Color(0.48, 0.36, 0.22))
	var gw := width * 0.76
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.058, 0.50, 0.055)), plank, "StileL", Vector3(-gw * 0.48, 0.32, 0.07))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.058, 0.50, 0.055)), plank, "StileR", Vector3(gw * 0.48, 0.32, 0.07))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(gw, 0.052, 0.052)), plank, "GateTop", Vector3(0, 0.54, 0.07), Vector3(0, 0, 0.035))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(gw, 0.052, 0.052)), plank, "GateBot", Vector3(0, 0.12, 0.07), Vector3(0, 0, -0.028))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(gw * 0.96, 0.038, 0.046)), dark, "GateMid", Vector3(0, 0.31, 0.07), Vector3(0, 0, 0.05))
	var slats := 11
	for i in range(slats):
		var x := -gw * 0.42 + float(i) * (gw * 0.84 / float(slats - 1))
		var sag := 0.018 * sin(float(i) / float(slats - 1) * PI)
		MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.036, 0.40, 0.036)), dark if i % 2 == 0 else plank, "GateSlat", Vector3(x, 0.32 - sag, 0.07))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(gw * 0.88, 0.032, 0.032)), dark, "GateBrace", Vector3(0, 0.33, 0.10), Vector3(0, 0, 0.48))
	var steel := MeshKit.steel()
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.055, 0.09, 0.04)), steel, "Hinge", Vector3(-gw * 0.48, 0.48, 0.11))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.055, 0.09, 0.04)), steel, "Hinge2", Vector3(-gw * 0.48, 0.16, 0.11))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.16, 0.028, 0.028)), steel, "LatchBar", Vector3(gw * 0.40, 0.34, 0.12))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.04, 0.11, 0.04)), steel, "LatchCatch", Vector3(gw * 0.50, 0.34, 0.12))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.022, 0.08, 0.022)), steel, "LatchPin", Vector3(gw * 0.50, 0.40, 0.12))


func _brush() -> void:
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.70, Color(0.62, 0.50, 0.34))
	var twig := MeshKit.mat_color(Color(0.32, 0.22, 0.12), 0.70)
	var green := MeshKit.mat_color(Color(0.18, 0.30, 0.12), 0.86)
	var green2 := MeshKit.mat_color(Color(0.22, 0.36, 0.14), 0.84)
	var rust := MeshKit.mat_color(Color(0.52, 0.32, 0.12), 0.78)
	var rust2 := MeshKit.mat_color(Color(0.62, 0.38, 0.14), 0.80)
	var rng := RandomNumberGenerator.new()
	rng.seed = number * 31 + 9
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.82, 0.46, 0.50)), wood, "BrushBox", Vector3(0, 0.23, 0.02))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.84, 0.05, 0.08)), wood, "BrushRimF", Vector3(0, 0.48, 0.24))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.84, 0.05, 0.08)), wood, "BrushRimB", Vector3(0, 0.48, -0.20))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.78, 0.04, 0.42)), MeshKit.mat_color(Color(0.28, 0.20, 0.12), 0.86), "BrushSoil", Vector3(0, 0.47, 0.02))
	for i in range(22):
		var base := Vector3(rng.randf_range(-width * 0.36, width * 0.36), 0.48, rng.randf_range(-0.16, 0.16))
		var tip := base + Vector3(rng.randf_range(-0.16, 0.16), rng.randf_range(0.28, 0.52), rng.randf_range(-0.10, 0.10))
		MeshKit.add_rod(self, twig, "Stem", base, tip, rng.randf_range(0.007, 0.012))
		var spray_m: Material = rust if i % 4 == 0 else (rust2 if i % 5 == 0 else (green if i % 2 == 0 else green2))
		var spray := MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.12, 0.028, 0.18)), spray_m, "Spray", tip)
		spray.rotation = Vector3(rng.randf_range(-0.45, 0.45), rng.randf_range(-0.90, 0.90), rng.randf_range(-0.35, 0.35))
		if i % 2 == 0:
			var mid := base.lerp(tip, 0.48)
			var fork := mid + Vector3(rng.randf_range(-0.14, 0.14), rng.randf_range(0.10, 0.20), rng.randf_range(-0.08, 0.08))
			MeshKit.add_rod(self, twig, "Fork", mid, fork, 0.006)
			var fs := MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.08, 0.022, 0.12)), rust if i % 6 == 0 else green2, "Spray", fork)
			fs.rotation = Vector3(rng.randf_range(-0.40, 0.40), rng.randf_range(-0.80, 0.80), rng.randf_range(-0.30, 0.30))


func _flag(half: float, std_h: float, white: Material) -> void:
	MeshKit.add_child_mi(self, MeshKit.cyl(0.008, 0.62, 0.007, 6), white, "FlagPole", Vector3(half + 0.02, std_h + 0.32, 0))
	var red := MeshKit.mat_color(Color(0.72, 0.12, 0.14), 0.55)
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.30, 0.18, 0.008)), red, "Flag", Vector3(half + 0.18, std_h + 0.52, 0), Vector3(0.0, 0.0, 0.22))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.12, 0.10, 0.006)), red, "FlagTip", Vector3(half + 0.30, std_h + 0.46, 0), Vector3(0.0, 0.0, 0.48))


func _wing_planter(pos: Vector3) -> void:
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.64, Color(0.82, 0.76, 0.62))
	var dirt := MeshKit.mat_color(Color(0.26, 0.18, 0.11), 0.86)
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.48, 0.22, 0.36)), wood, "WingBox", pos + Vector3(0, 0.12, 0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.50, 0.03, 0.05)), wood, "WingRimF", pos + Vector3(0, 0.24, 0.16))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.50, 0.03, 0.05)), wood, "WingRimB", pos + Vector3(0, 0.24, -0.16))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.42, 0.05, 0.28)), dirt, "WingSoil", pos + Vector3(0, 0.24, 0))
	var leaf := MeshKit.mat_color(Color(0.22, 0.38, 0.16), 0.78)
	var stem_m := MeshKit.mat_color(Color(0.18, 0.28, 0.10), 0.70)
	var blooms: Array[Color] = [
		Color(0.92, 0.90, 0.86),
		Color(0.90, 0.70, 0.22),
		Color(0.78, 0.38, 0.12),
		Color(0.94, 0.92, 0.88),
	]
	var rng := RandomNumberGenerator.new()
	rng.seed = number * 41 + int(pos.x * 10.0) + 5
	for i in range(28):
		var p := pos + Vector3(rng.randf_range(-0.20, 0.20), 0.28 + rng.randf() * 0.14, rng.randf_range(-0.14, 0.14))
		MeshKit.add_child_mi(self, MeshKit.cyl(0.005, 0.11, 0.0035, 5), stem_m, "WingStem", p + Vector3(0, 0.04, 0), Vector3(rng.randf_range(-0.22, 0.22), 0, rng.randf_range(-0.18, 0.18)))
		MeshKit.add_child_mi(self, MeshKit.sphere(0.048, 6, 8), leaf, "WingLeaf", p).scale = Vector3(1.20, 0.52, 1.05)
		if i % 2 == 0:
			var tilt := Vector3(rng.randf_range(-0.30, 0.55), rng.randf_range(-0.40, 0.40), 0.0)
			_bloom_head(p + Vector3(0, 0.10, 0), blooms[i % blooms.size()], i % 3, tilt)


func _flower_box() -> void:
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.65, Color(0.85, 0.82, 0.75))
	var dirt := MeshKit.mat_color(Color(0.28, 0.20, 0.12), 0.86)
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.74, 0.30, 0.42)), wood, "Box", Vector3(0, 0.16, 0.02))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.76, 0.04, 0.06)), wood, "BoxRimF", Vector3(0, 0.32, 0.20))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.76, 0.04, 0.06)), wood, "BoxRimB", Vector3(0, 0.32, -0.16))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.70, 0.07, 0.34)), dirt, "Soil", Vector3(0, 0.33, 0.02))
	var leaf := MeshKit.mat_color(Color(0.22, 0.38, 0.18), 0.75)
	var leaf2 := MeshKit.mat_color(Color(0.16, 0.32, 0.12), 0.80)
	var stem_m := MeshKit.mat_color(Color(0.18, 0.28, 0.10), 0.70)
	var blooms: Array[Color] = [
		Color(0.92, 0.90, 0.84),
		Color(0.90, 0.70, 0.20),
		Color(0.78, 0.36, 0.10),
		Color(0.94, 0.92, 0.88),
		Color(0.82, 0.28, 0.16),
	]
	var rng := RandomNumberGenerator.new()
	rng.seed = number * 17 + 3
	for i in range(48):
		var p := Vector3(rng.randf_range(-width * 0.36, width * 0.36), 0.36 + rng.randf() * 0.16, rng.randf_range(-0.16, 0.16))
		MeshKit.add_child_mi(self, MeshKit.cyl(0.006, 0.14, 0.004, 5), stem_m, "Stem", p + Vector3(0, 0.04, 0), Vector3(rng.randf_range(-0.25, 0.25), 0, rng.randf_range(-0.20, 0.20)))
		MeshKit.add_child_mi(self, MeshKit.sphere(0.055, 6, 8), leaf if i % 2 == 0 else leaf2, "Leaf", p).scale = Vector3(1.22, 0.55, 1.05)
		if i % 2 == 0:
			var tilt := Vector3(rng.randf_range(-0.30, 0.55), rng.randf_range(-0.40, 0.40), 0.0)
			_bloom_head(p + Vector3(0, 0.12, 0), blooms[i % blooms.size()], i % 3, tilt)


func _bloom_head(pos: Vector3, color: Color, kind: int, tilt: Vector3) -> void:
	var petal := MeshKit.mat_color(color, 0.52)
	var eye := MeshKit.mat_color(Color(0.86, 0.70, 0.22), 0.48)
	if kind == 0:
		MeshKit.add_child_mi(self, MeshKit.cyl(0.030, 0.010, 0.028, 8), petal, "Head", pos, tilt)
		MeshKit.add_child_mi(self, MeshKit.cyl(0.010, 0.008, 0.010, 6), eye, "Eye", pos + Vector3(0, 0.008, 0), tilt)
	elif kind == 1:
		MeshKit.add_child_mi(self, MeshKit.cyl(0.026, 0.016, 0.022, 8), petal, "Head", pos, tilt)
		MeshKit.add_child_mi(self, MeshKit.cyl(0.018, 0.012, 0.016, 7), petal, "HeadIn", pos + Vector3(0, 0.008, 0), tilt)
	else:
		MeshKit.add_child_mi(self, MeshKit.cyl(0.028, 0.012, 0.026, 8), petal, "Head", pos, tilt)
		MeshKit.add_child_mi(self, MeshKit.cyl(0.012, 0.008, 0.012, 6), eye, "Eye", pos + Vector3(0, 0.008, 0), tilt)


func _on_knock_body(body: Node) -> void:
	if knocked:
		return
	if body is Horse:
		var h: Horse = body
		if h.jumping and not h.will_rail and h.jump_apex >= height + 0.12:
			return
		if GameState.mode == "ride":
			print(
				"FENCE knock ", number, " by horse at ",
				snapped(h.global_position.x, 0.1), ",", snapped(h.global_position.z, 0.1),
				" next=", GameState.next_fence, " jumping=", h.jumping
			)
		knock("hit")


func knock(_why: String = "") -> void:
	if knocked:
		return
	knocked = true
	pending_chip = false
	for r in rails:
		r.freeze = false
		r.linear_velocity = Vector3(randf_range(-0.4, 0.4), randf_range(0.2, 0.8), randf_range(0.6, 1.6))
		r.angular_velocity = Vector3(randf_range(-2, 2), randf_range(-1, 1), randf_range(-3, 3))
	if GameState.mode == "ride":
		GameState.note_rail(number)


func refuse() -> void:
	refused = true
	if GameState.mode == "ride":
		GameState.note_refuse()


func reset_fence() -> void:
	knocked = false
	refused = false
	cleared = false
	pending_chip = false
