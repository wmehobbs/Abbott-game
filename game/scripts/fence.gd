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
var current_ring: MeshInstance3D


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
	_current_ring()


func set_current(on: bool) -> void:
	if num_lab:
		num_lab.modulate = Color(0.72, 0.10, 0.08) if on else Color(0.08, 0.07, 0.06)
		num_lab.font_size = 74 if on else 64
		num_lab.outline_modulate = Color(0.98, 0.94, 0.86, 0.9) if on else Color(1, 1, 1, 0)
		num_lab.outline_size = 10 if on else 0
	if num_plate and num_plate.material_override is StandardMaterial3D:
		var plate := num_plate.material_override as StandardMaterial3D
		plate.albedo_color = Color(0.90, 0.84, 0.70) if on else Color(0.93, 0.90, 0.84)
		plate.emission_enabled = false
		plate.emission_energy_multiplier = 0.0
	if current_ring:
		var aid := GameState.session_kind == "lesson" and GameState.settings != null and GameState.settings.riding_aid
		current_ring.visible = on and aid


func _ground_line() -> void:
	# Quieter than the jump rails, so the ground poles do not glare.
	var white := MeshKit.mat_tex("res://assets/textures/pole_white_albedo.jpg", 0.72, Color(0.70, 0.66, 0.58))
	if white == null or (white is StandardMaterial3D and (white as StandardMaterial3D).albedo_texture == null):
		white = MeshKit.mat_color(Color(0.70, 0.66, 0.58), 0.72)
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


func _current_ring() -> void:
	# A quiet halo on the current lesson fence. Shows stay clear of it.
	current_ring = MeshInstance3D.new()
	current_ring.name = "CurrentRing"
	var tor := TorusMesh.new()
	tor.inner_radius = 1.45
	tor.outer_radius = 1.68
	current_ring.mesh = tor
	var mat := StandardMaterial3D.new()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.albedo_color = Color(0.93, 0.84, 0.46, 0.42)
	current_ring.material_override = mat
	current_ring.position = Vector3(0.0, 0.035, 0.0)
	current_ring.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	current_ring.visible = false
	add_child(current_ring)


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
	_rail_band(body, -0.78, Color(0.93, 0.91, 0.84))
	_rail_band(body, 0.78, Color(0.16, 0.32, 0.22))
	add_child(body)
	rails.append(body)


func _rail_band(body: Node3D, along: float, color: Color) -> void:
	# A painted sleeve. The pole radius and the knock box stay as they are.
	var band := MeshInstance3D.new()
	var cyl := CylinderMesh.new()
	cyl.top_radius = 0.064
	cyl.bottom_radius = 0.064
	cyl.height = 0.14
	cyl.radial_segments = 10
	band.mesh = cyl
	band.material_override = MeshKit.mat_color(color, 0.48)
	band.rotation_degrees = Vector3(0, 0, 90)
	band.position = Vector3(along, 0.0, 0.0)
	band.name = "RailBand"
	body.add_child(band)


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
	var rng := RandomNumberGenerator.new()
	rng.seed = number * 31 + 9
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.82, 0.46, 0.50)), wood, "BrushBox", Vector3(0, 0.23, 0.02))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.84, 0.05, 0.08)), wood, "BrushRimF", Vector3(0, 0.48, 0.24))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.84, 0.05, 0.08)), wood, "BrushRimB", Vector3(0, 0.48, -0.20))
	# A packed hedge of fir and birch brush with a ragged top, not sticks with
	# balls on them. One mesh, its colour in the clumps.
	var greens: Array[Color] = [Color(0.15, 0.25, 0.10), Color(0.19, 0.30, 0.12), Color(0.23, 0.33, 0.14), Color(0.27, 0.30, 0.14), Color(0.36, 0.28, 0.14)]
	var list: Array = []
	var half := width * 0.39
	# Three rows of small clumps: a fine hedge, not a row of cabbages.
	for row in 3:
		var n := int(width * (18.0 - float(row) * 4.0))
		var y0: float = [0.52, 0.64, 0.75][row]
		var z0: float = [0.10, -0.06, 0.02][row]
		for i in n:
			var x := lerpf(-half, half, (float(i) + rng.randf()) / float(n))
			var r := rng.randf_range(0.075, 0.12) * (1.0 - 0.15 * float(row))
			var c: Color = greens[rng.randi() % greens.size()] * rng.randf_range(0.85, 1.12)
			var p := Vector3(x, y0 + rng.randf_range(-0.03, 0.04), z0 + rng.randf_range(-0.07, 0.07))
			list.append([p, Vector3(r * 1.2, r * 1.05, r * 0.95), c])
	MeshKit.add_child_mi(self, MeshKit.clumps(list), MeshKit.clump_material(0.92), "Brush")


func _flag(half: float, std_h: float, white: Material) -> void:
	MeshKit.add_child_mi(self, MeshKit.cyl(0.008, 0.62, 0.007, 6), white, "FlagPole", Vector3(half + 0.02, std_h + 0.32, 0))
	var red := MeshKit.mat_color(Color(0.72, 0.12, 0.14), 0.55)
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.30, 0.18, 0.008)), red, "Flag", Vector3(half + 0.18, std_h + 0.52, 0), Vector3(0.0, 0.0, 0.22))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.12, 0.10, 0.006)), red, "FlagTip", Vector3(half + 0.30, std_h + 0.46, 0), Vector3(0.0, 0.0, 0.48))


func _wing_planter(pos: Vector3) -> void:
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.64, Color(0.82, 0.76, 0.62))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.48, 0.22, 0.36)), wood, "WingBox", pos + Vector3(0, 0.12, 0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.50, 0.03, 0.05)), wood, "WingRimF", pos + Vector3(0, 0.24, 0.16))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.50, 0.03, 0.05)), wood, "WingRimB", pos + Vector3(0, 0.24, -0.16))
	var rng := RandomNumberGenerator.new()
	rng.seed = number * 41 + int(pos.x * 10.0) + 5
	MeshKit.add_child_mi(self, MeshKit.clumps(_bed(pos + Vector3(0, 0.25, 0), 0.20, 0.13, 16, 14, rng)), MeshKit.clump_material(0.8), "WingBed")


## Leaves packed over the soil and blooms on top: a planter bed in one mesh.
func _bed(top: Vector3, hx: float, hz: float, leaves: int, blooms: int, rng: RandomNumberGenerator) -> Array:
	var list: Array = []
	var greens: Array[Color] = [Color(0.18, 0.34, 0.13), Color(0.22, 0.38, 0.16), Color(0.15, 0.30, 0.11)]
	var flowers: Array[Color] = [
		Color(0.95, 0.93, 0.88), Color(0.93, 0.76, 0.22), Color(0.86, 0.42, 0.12),
		Color(0.80, 0.16, 0.14), Color(0.92, 0.55, 0.62), Color(0.96, 0.94, 0.90),
	]
	for i in leaves:
		var r := rng.randf_range(0.055, 0.085)
		var p := top + Vector3(rng.randf_range(-hx, hx), rng.randf_range(0.0, 0.04), rng.randf_range(-hz, hz))
		list.append([p, Vector3(r * 1.25, r * 0.75, r * 1.1), greens[rng.randi() % greens.size()] * rng.randf_range(0.9, 1.1)])
	for i in blooms:
		var b := rng.randf_range(0.024, 0.036)
		var q := top + Vector3(rng.randf_range(-hx * 0.95, hx * 0.95), rng.randf_range(0.05, 0.09), rng.randf_range(-hz * 0.9, hz * 0.9))
		list.append([q, Vector3(b, b * 0.7, b), flowers[rng.randi() % flowers.size()]])
	return list


func _flower_box() -> void:
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.65, Color(0.85, 0.82, 0.75))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.74, 0.30, 0.42)), wood, "Box", Vector3(0, 0.16, 0.02))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.76, 0.04, 0.06)), wood, "BoxRimF", Vector3(0, 0.32, 0.20))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(width * 0.76, 0.04, 0.06)), wood, "BoxRimB", Vector3(0, 0.32, -0.16))
	var rng := RandomNumberGenerator.new()
	rng.seed = number * 17 + 3
	# A full bed of leaves and blooms, like a show's flower boxes.
	var bed := _bed(Vector3(0, 0.35, 0.02), width * 0.35, 0.15, int(width * 22.0), int(width * 26.0), rng)
	MeshKit.add_child_mi(self, MeshKit.clumps(bed), MeshKit.clump_material(0.8), "Bed")


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
