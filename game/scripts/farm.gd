extends Node3D
class_name HiddenK

## Hidden K outdoor: 100' x 250' sand, 10' x 40' mirrors, pines, house, barn.

const People := preload("res://scripts/person_look.gd")

const RING_W := 30.48
const RING_D := 76.20
const MIRROR_W := 12.19
const MIRROR_H := 3.05


func build() -> void:
	_ground()
	_boards()
	_gate()
	_mirrors()
	_lights()
	_trees()
	_barn()
	_house()
	_people()
	_school_yard()
	_grounds()
	_ridges()
	_indoor()
	_sun()
	_walls()
	_sky()


func _ground() -> void:
	# Thick deck, top at y=0. A hairline plane at the camera near-clip
	# swallows the horse; the ring stays under his hooves.
	var sand := MeshInstance3D.new()
	sand.name = "Sand"
	var deck := BoxMesh.new()
	deck.size = Vector3(RING_W, 0.12, RING_D)
	sand.mesh = deck
	sand.position.y = -0.06
	sand.material_override = MeshKit.sand_material()
	add_child(sand)

	var floor_body := StaticBody3D.new()
	floor_body.collision_layer = 2
	floor_body.collision_mask = 0
	var col := CollisionShape3D.new()
	var box := BoxShape3D.new()
	box.size = Vector3(RING_W, 0.2, RING_D)
	col.shape = box
	col.position.y = -0.1
	floor_body.add_child(col)
	add_child(floor_body)

	_apron()

	var grass := MeshInstance3D.new()
	grass.name = "Grass"
	var sod := BoxMesh.new()
	sod.size = Vector3(280, 0.06, 320)
	grass.mesh = sod
	grass.position = Vector3(0, -0.32, 0)
	grass.material_override = MeshKit.grass_material()
	add_child(grass)


func _apron() -> void:
	# Dirt collar so grass never meets the sand. The grass shader also
	# discards inside this rectangle.
	var dirt := MeshKit.apron_dirt()
	var hw := RING_W * 0.5
	var hd := RING_D * 0.5
	var a := 4.4
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(RING_W + a * 2.0, 0.10, a)), dirt, "ApronN", Vector3(0, -0.14, -hd - a * 0.5))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(RING_W + a * 2.0, 0.10, a)), dirt, "ApronS", Vector3(0, -0.14, hd + a * 0.5))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(a, 0.10, RING_D)), dirt, "ApronW", Vector3(-hw - a * 0.5, -0.14, 0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(a, 0.10, RING_D)), dirt, "ApronE", Vector3(hw + a * 0.5, -0.14, 0))
	var lip := MeshKit.sand_lip()
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(RING_W + 0.35, 0.04, 0.28)), lip, "LipN", Vector3(0, -0.02, -hd - 0.08))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(RING_W + 0.35, 0.04, 0.28)), lip, "LipS", Vector3(0, -0.02, hd + 0.08))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.28, 0.04, RING_D + 0.35)), lip, "LipW", Vector3(-hw - 0.08, -0.02, 0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.28, 0.04, RING_D + 0.35)), lip, "LipE", Vector3(hw + 0.08, -0.02, 0))


func _boards() -> void:
	var white := MeshKit.wood_white()
	var kick := MeshKit.wood_kick()
	var cap := MeshKit.wood_oak()
	var hw := RING_W * 0.5
	var hd := RING_D * 0.5
	var gate := 1.85
	var segs := [
		[Vector3(-hw, 0, -hd), Vector3(-gate, 0, -hd)],
		[Vector3(gate, 0, -hd), Vector3(hw, 0, -hd)],
		[Vector3(-hw, 0, hd), Vector3(hw, 0, hd)],
		[Vector3(-hw, 0, -hd), Vector3(-hw, 0, hd)],
		[Vector3(hw, 0, -hd), Vector3(hw, 0, hd)],
	]
	for s in segs:
		var a: Vector3 = s[0]
		var b: Vector3 = s[1]
		var dir := b - a
		var len := dir.length()
		var mid := (a + b) * 0.5
		var yaw := atan2(dir.x, dir.z)
		MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.16, 0.68, len)), kick, "Kick", Vector3(mid.x, 0.34, mid.z), Vector3(0, yaw, 0))
		MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.20, 0.06, len)), cap, "KickCap", Vector3(mid.x, 0.70, mid.z), Vector3(0, yaw, 0))
		for y in [0.84, 1.12, 1.40]:
			MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.09, 0.08, len)), white, "Rail", Vector3(mid.x, y, mid.z), Vector3(0, yaw, 0))
		var posts := int(len / 2.6) + 1
		for i in range(posts + 1):
			var t := float(i) / float(posts)
			var p := a.lerp(b, t)
			MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.15, 1.52, 0.15)), white, "Post", Vector3(p.x, 0.76, p.z))
			MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.20, 0.06, 0.20)), cap, "PostCap", Vector3(p.x, 1.54, p.z))
			MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.28, 0.08, 0.28)), cap, "PostFoot", Vector3(p.x, 0.04, p.z))
	_rail_flowers()


func _rail_flowers() -> void:
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.66, Color(0.82, 0.76, 0.62))
	var dirt := MeshKit.flower_soil()
	var leaf := MeshKit.mat_color(Color(0.18, 0.32, 0.12), 0.82)
	var stem_m := MeshKit.mat_color(Color(0.18, 0.28, 0.10), 0.70)
	var blooms: Array[Color] = [
		Color(0.92, 0.90, 0.86),
		Color(0.84, 0.24, 0.28),
		Color(0.90, 0.70, 0.22),
	]
	var hw := RING_W * 0.5 + 0.55
	var hd := RING_D * 0.5
	for sx: float in [-1.0, 1.0]:
		for i in range(9):
			var z := -hd + 6.4 + float(i) * 8.0
			if absf(z) < 2.2:
				continue
			var p := Vector3(sx * hw, 0.0, z)
			MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.42, 0.24, 0.58)), wood, "RailBox", p + Vector3(0, 0.12, 0))
			MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.36, 0.06, 0.50)), dirt, "RailSoil", p + Vector3(0, 0.26, 0))
			for k in range(4):
				var ox := (float(k) - 1.5) * 0.09
				var hp := p + Vector3(ox * 0.35, 0.34, ox * 0.6)
				MeshKit.add_child_mi(self, MeshKit.cyl(0.005, 0.12, 0.0035, 5), stem_m, "RailStem", hp + Vector3(0, 0.06, 0), Vector3(ox * 0.4, 0, 0.12))
				MeshKit.add_child_mi(self, MeshKit.sphere(0.07, 6, 8), leaf, "RailLeaf", hp).scale = Vector3(1.18, 0.48, 1.05)
				var bloom := MeshKit.mat_color(blooms[k % blooms.size()], 0.48)
				var head := hp + Vector3(0, 0.12, 0)
				MeshKit.add_child_mi(self, MeshKit.cyl(0.028, 0.010, 0.026, 8), bloom, "RailHead", head, Vector3(0.45, ox * 0.3, 0.0))
				MeshKit.add_child_mi(self, MeshKit.cyl(0.010, 0.008, 0.010, 6), MeshKit.mat_color(Color(0.86, 0.70, 0.22), 0.48), "RailEye", head + Vector3(0, 0.008, 0), Vector3(0.45, ox * 0.3, 0.0))


func _gate() -> void:
	var white := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.62, Color(0.93, 0.91, 0.84))
	var sign := MeshKit.mat_tex(MeshKit.harvest_tex([
		"res://assets/textures/harvest/dark_planks_albedo.jpg",
		"res://assets/textures/harvest/proc/kick_dark_albedo.jpg",
		"res://assets/textures/harvest/dark_wood_albedo.jpg",
	], "res://assets/textures/wood_albedo.jpg"), 0.52, Color(0.22, 0.28, 0.48))
	var z := -RING_D * 0.5 + 0.2
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(3.4, 0.08, 0.08)), white, "GateTop", Vector3(0, 1.28, z))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(3.4, 0.08, 0.08)), white, "GateMid", Vector3(0, 0.78, z))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(2.25, 0.46, 0.06)), sign, "GateSign", Vector3(0, 1.70, z - 0.04))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(2.35, 0.05, 0.08)), MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.58, Color(0.78, 0.70, 0.52)), "GateSignCap", Vector3(0, 1.95, z - 0.04))
	var lab := Label3D.new()
	lab.text = "HIDDEN K"
	lab.font_size = 48
	lab.modulate = Color(0.96, 0.93, 0.86)
	lab.outline_modulate = Color(0.08, 0.06, 0.04)
	lab.outline_size = 8
	lab.position = Vector3(0, 1.70, z + 0.02)
	add_child(lab)
	_letters()
	_mounting_block()
	_lane()
	_in_gate()


func _in_gate() -> void:
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.66, Color(0.42, 0.30, 0.16))
	var dirt := MeshKit.flower_soil()
	var leaf := MeshKit.clover()
	var bloom := MeshKit.mat_color(Color(0.78, 0.22, 0.26), 0.48)
	var bloom2 := MeshKit.mat_color(Color(0.92, 0.88, 0.82), 0.50)
	var z := -RING_D * 0.5 - 1.15
	for sx: float in [-1.0, 1.0]:
		var x: float = sx * 3.15
		MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.72, 0.42, 0.52)), wood, "InBox", Vector3(x, 0.22, z))
		MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.64, 0.08, 0.44)), dirt, "InSoil", Vector3(x, 0.44, z))
		for i in range(5):
			var ox := (float(i) - 2.0) * 0.10
			MeshKit.add_child_mi(self, MeshKit.sphere(0.08, 6, 8), leaf, "InLeaf", Vector3(x + ox, 0.56, z + 0.02))
			var fl := bloom if i % 2 == 0 else bloom2
			MeshKit.add_child_mi(self, MeshKit.sphere(0.045, 6, 8), fl, "InBloom", Vector3(x + ox * 0.8, 0.66, z))
	var lab := Label3D.new()
	lab.text = "IN"
	lab.font_size = 28
	lab.modulate = Color(0.72, 0.14, 0.14)
	lab.outline_modulate = Color(0.96, 0.93, 0.86)
	lab.outline_size = 4
	lab.position = Vector3(-3.15, 0.92, z)
	lab.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	add_child(lab)
	var wait_z := z - 1.35
	MeshKit.add_child_mi(self, MeshKit.cyl(0.16, 0.42, 0.04, 8), MeshKit.mat_color(Color(0.86, 0.42, 0.10), 0.42), "WaitCone", Vector3(2.05, 0.22, wait_z))
	MeshKit.add_child_mi(self, MeshKit.cyl(0.18, 0.04, 0.18, 8), MeshKit.mat_color(Color(0.12, 0.12, 0.12), 0.55), "WaitBase", Vector3(2.05, 0.03, wait_z))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.48, 0.32, 0.38)), MeshKit.mat_color(Color(0.22, 0.16, 0.10), 0.55), "PinnyCrate", Vector3(-2.05, 0.18, wait_z))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.42, 0.04, 0.32)), MeshKit.mat_color(Color(0.18, 0.12, 0.08), 0.48), "PinnyLid", Vector3(-2.05, 0.36, wait_z), Vector3(0.0, 0.0, 0.35))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.28, 0.02, 0.22)), MeshKit.mat_color(Color(0.86, 0.18, 0.16), 0.52), "Pinny", Vector3(-1.92, 0.40, wait_z), Vector3(0.0, 0.45, 0.0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.62, 0.28, 0.04)), MeshKit.mat_color(Color(0.10, 0.12, 0.16), 0.42), "DeckBoard", Vector3(0.0, 1.05, wait_z + 0.22))
	var deck := Label3D.new()
	deck.text = "ON DECK"
	deck.font_size = 22
	deck.modulate = Color(0.96, 0.90, 0.42)
	deck.outline_modulate = Color(0.06, 0.05, 0.04)
	deck.outline_size = 4
	deck.position = Vector3(0.0, 1.05, wait_z + 0.26)
	deck.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	add_child(deck)


func _mirrors() -> void:
	var glass := MeshKit.mat_color(Color(0.42, 0.50, 0.56), 0.08, 0.82)
	glass.transparency = BaseMaterial3D.TRANSPARENCY_DISABLED
	var frame := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.5, Color(0.18, 0.14, 0.10))
	var z := -RING_D * 0.5 - 0.18
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(MIRROR_W, MIRROR_H, 0.06)), glass, "Mirror", Vector3(0, MIRROR_H * 0.5 + 0.15, z))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(MIRROR_W + 0.22, 0.08, 0.10)), frame, "MTop", Vector3(0, MIRROR_H + 0.19, z))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(MIRROR_W + 0.22, 0.08, 0.10)), frame, "MBot", Vector3(0, 0.15, z))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.08, MIRROR_H + 0.16, 0.10)), frame, "ML", Vector3(-MIRROR_W * 0.5 - 0.07, MIRROR_H * 0.5 + 0.15, z))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.08, MIRROR_H + 0.16, 0.10)), frame, "MR", Vector3(MIRROR_W * 0.5 + 0.07, MIRROR_H * 0.5 + 0.15, z))


func _lights() -> void:
	var metal := MeshKit.mat_color(Color(0.22, 0.22, 0.24), 0.38, 0.62)
	var head_m := MeshKit.mat_color(Color(0.85, 0.82, 0.72), 0.25, 0.4)
	var zs: Array[float] = [-32.0, -10.0, 12.0, 32.0]
	var xs: Array[float] = [-RING_W * 0.5 - 1.6, RING_W * 0.5 + 1.6]
	for z in zs:
		for x in xs:
			var xf: float = x
			MeshKit.add_child_mi(self, MeshKit.cyl(0.07, 8.2, 0.05, 10), metal, "Pole", Vector3(xf, 4.1, z))
			var hx: float = xf + signf(-xf) * 0.45
			MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.9, 0.10, 0.38)), metal, "Arm", Vector3(hx, 8.05, z))
			MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.55, 0.12, 0.28)), head_m, "Head", Vector3(hx, 7.92, z))
			var lamp := SpotLight3D.new()
			lamp.light_energy = 0.0
			lamp.spot_range = 28.0
			lamp.spot_angle = 48.0
			lamp.position = Vector3(hx, 7.85, z)
			lamp.rotation_degrees = Vector3(-70, 0.0 if xf < 0.0 else 180.0, 0)
			add_child(lamp)


func _in_keepout(x: float, z: float) -> bool:
	# Trunk plus canopy stay off the ring, apron, lane, school rail, barn, house.
	# The old +22 / +26 moat left a geometric grass void around the ring.
	if absf(x) < RING_W * 0.5 + 12.8 and absf(z) < RING_D * 0.5 + 14.6:
		return true
	if x > RING_W * 0.5 - 0.4 and x < RING_W * 0.5 + 10.0 and absf(z + 10.0) < 24.0:
		return true
	if absf(x) < 9.0 and z < -RING_D * 0.5 + 2.0 and z > -RING_D * 0.5 - 26.0:
		return true
	if absf(x + 78.0) < 24.0 and absf(z + 48.0) < 28.0:
		return true
	if absf(x - 62.0) < 20.0 and absf(z + 52.0) < 22.0:
		return true
	if absf(x + 78.0) < 22.0 and absf(z + 10.0) < 20.0:
		return true
	return false


func _trees() -> void:
	var bark := MeshKit.pine_bark()
	var pine := MeshKit.pine_material()
	var hardwood := MeshKit.hardwood_material(false)
	var hardwood2 := MeshKit.hardwood_material(true)
	var rng := RandomNumberGenerator.new()
	rng.seed = 21
	var placed := 0
	var tries := 0
	while placed < 110 and tries < 520:
		tries += 1
		var x := rng.randf_range(-110.0, 110.0)
		var z := rng.randf_range(-140.0, 140.0)
		if _in_keepout(x, z):
			continue
		var t := Node3D.new()
		t.position = Vector3(x, 0, z)
		t.rotation.y = rng.randf() * TAU
		add_child(t)
		var h := rng.randf_range(10.0, 20.0)
		var is_pine := placed % 5 != 2
		if is_pine:
			_pine_plant(t, h, bark, pine, rng)
		else:
			_oak_plant(t, h, bark, hardwood, hardwood2, rng)
		placed += 1


func _barn() -> void:
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.68, Color(0.72, 0.62, 0.46))
	var roof := MeshKit.barn_roof()
	var dark := MeshKit.mat_color(Color(0.10, 0.08, 0.06), 0.8)
	var b := Node3D.new()
	# Far outside the 100×250 ring. After 90° yaw the 28 m ridge runs in X.
	b.position = Vector3(-78, 0, -48)
	b.rotation_degrees = Vector3(0, 90, 0)
	add_child(b)
	var trim := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.58, Color(0.88, 0.82, 0.70))
	# Hollow shell — four walls + battens — so it reads as a barn, not a crate.
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.18, 4.2, 28.0)), wood, "WallL", Vector3(-7.16, 2.1, 0))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.18, 4.2, 28.0)), wood, "WallR", Vector3(7.16, 2.1, 0))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(14.5, 4.2, 0.18)), wood, "WallF", Vector3(0, 2.1, -13.91))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(14.5, 4.2, 0.18)), wood, "WallB", Vector3(0, 2.1, 13.91))
	for z in [-12.0, -6.0, 0.0, 6.0, 12.0]:
		MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.10, 4.05, 0.12)), trim, "BattenL", Vector3(-7.28, 2.05, z))
		MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.10, 4.05, 0.12)), trim, "BattenR", Vector3(7.28, 2.05, z))
	for x in [-5.5, -2.0, 2.0, 5.5]:
		MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.12, 4.05, 0.10)), trim, "BattenF", Vector3(x, 2.05, -14.02))
	MeshKit.add_child_mi(b, MeshKit.prism(Vector3(16.4, 3.8, 29.8)), roof, "Roof", Vector3(0, 6.15, 0))
	MeshKit.add_child_mi(b, MeshKit.prism(Vector3(14.6, 3.55, 0.20)), wood, "GableF", Vector3(0, 6.05, -13.91))
	MeshKit.add_child_mi(b, MeshKit.prism(Vector3(14.6, 3.55, 0.20)), wood, "GableB", Vector3(0, 6.05, 13.91))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.28, 0.22, 30.2)), MeshKit.mat_color(Color(0.22, 0.12, 0.09), 0.55), "Ridge", Vector3(0, 8.10, 0))
	var eave := MeshKit.mat_color(Color(0.30, 0.16, 0.12), 0.58)
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(16.8, 0.10, 0.28)), eave, "EaveF", Vector3(0, 4.28, -15.05))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(16.8, 0.10, 0.28)), eave, "EaveB", Vector3(0, 4.28, 15.05))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.16, 2.7, 10.0)), wood, "LeanL", Vector3(10.4, 1.35, 3))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.16, 2.7, 10.0)), wood, "LeanR", Vector3(14.2, 1.35, 3))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(4.0, 2.7, 0.16)), wood, "LeanF", Vector3(12.3, 1.35, -2.0))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(4.0, 2.7, 0.16)), wood, "LeanB", Vector3(12.3, 1.35, 8.0))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(8.6, 0.12, 10.8)), roof, "LeanRoof", Vector3(12.2, 3.15, 3), Vector3(0, 0, -0.18))
	var hook := MeshKit.steel()
	for z in [-0.6, 1.4, 3.4, 5.4]:
		MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.04, 0.16, 0.04)), hook, "Hook", Vector3(10.55, 2.15, z))
		MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.12, 0.03, 0.03)), hook, "HookArm", Vector3(10.62, 2.08, z))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.42, 0.08, 0.55)), MeshKit.leather(Color(0.42, 0.24, 0.13), 0.48), "RackPad", Vector3(10.85, 1.72, 1.4), Vector3(0.35, 0, 0))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.08, 0.55, 0.08)), MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.62, Color(0.72, 0.62, 0.46)), "Rack", Vector3(10.62, 1.55, 1.4))
	var stone := MeshKit.fieldstone()
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(14.9, 0.55, 28.4)), stone, "Footer", Vector3(0, 0.22, 0))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(3.2, 1.55, 0.10)), dark, "DoorTop", Vector3(0, 2.45, -14.06))
	# Bottom Dutch leaf stands open so the aisle reads, not a sealed crate.
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(1.58, 1.55, 0.10)), dark, "DoorBotL", Vector3(-1.55, 0.85, -13.55), Vector3(0, 0.92, 0))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(1.58, 1.55, 0.10)), dark, "DoorBotR", Vector3(1.52, 0.85, -13.72), Vector3(0, -0.55, 0))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(1.15, 0.22, 0.85)), MeshKit.mat_color(Color(0.62, 0.48, 0.22), 0.84), "AisleHay", Vector3(0.35, 0.14, -12.85))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.08, 3.15, 0.08)), trim, "DoorJambL", Vector3(-1.65, 1.65, -14.08))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.08, 3.15, 0.08)), trim, "DoorJambR", Vector3(1.65, 1.65, -14.08))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(3.05, 0.06, 0.06)), trim, "DoorX1", Vector3(0, 1.65, -14.12), Vector3(0, 0, 0.72))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(3.05, 0.06, 0.06)), trim, "DoorX2", Vector3(0, 1.65, -14.12), Vector3(0, 0, -0.72))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.08, 3.05, 0.06)), trim, "DoorMid", Vector3(0, 1.65, -14.11))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(1.4, 1.1, 0.08)), dark, "LoftDoor", Vector3(0, 3.55, -14.06))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(1.28, 0.05, 0.05)), trim, "LoftX1", Vector3(0, 3.55, -14.12), Vector3(0, 0, 0.55))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(1.28, 0.05, 0.05)), trim, "LoftX2", Vector3(0, 3.55, -14.12), Vector3(0, 0, -0.55))
	var win := MeshKit.mat_color(Color(0.22, 0.30, 0.34), 0.18, 0.4)
	win.transparency = BaseMaterial3D.TRANSPARENCY_DISABLED
	for i in range(6):
		var z := -11.0 + float(i) * 4.4
		MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.10, 2.2, 1.9)), dark, "Stall", Vector3(7.3, 1.15, z))
		for k in range(5):
			MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.04, 1.55, 0.04)), trim, "Bar", Vector3(7.36, 1.05, z - 0.72 + float(k) * 0.36))
		MeshKit.add_child_mi(b, MeshKit.box(Vector3(1.1, 0.9, 0.08)), win, "Win", Vector3(-7.28, 2.55, z))
		MeshKit.add_child_mi(b, MeshKit.box(Vector3(1.22, 0.08, 0.06)), trim, "WinSill", Vector3(-7.30, 2.08, z))
		MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.04, 0.86, 0.04)), trim, "WinMuntin", Vector3(-7.34, 2.55, z))
		MeshKit.add_child_mi(b, MeshKit.box(Vector3(1.02, 0.04, 0.04)), trim, "WinCross", Vector3(-7.34, 2.55, z))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(1.6, 1.4, 1.6)), wood, "Cupola", Vector3(0, 8.80, 0))
	MeshKit.add_child_mi(b, MeshKit.prism(Vector3(2.1, 0.85, 2.1)), roof, "CupolaRoof", Vector3(0, 9.70, 0))
	var steel := MeshKit.steel()
	MeshKit.add_child_mi(b, MeshKit.cyl(0.03, 0.85, 0.02, 6), steel, "VanePole", Vector3(0, 10.38, 0))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.42, 0.16, 0.10)), steel, "VaneHorse", Vector3(0.18, 10.78, 0))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.14, 0.10, 0.08)), steel, "VaneNeck", Vector3(0.38, 10.82, 0))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.12, 0.18, 0.06)), steel, "VaneTail", Vector3(-0.08, 10.84, 0))
	for z in [-10.0, -4.0, 4.0, 10.0]:
		MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.55, 0.22, 0.85)), MeshKit.mat_color(Color(0.28, 0.16, 0.12), 0.58), "Vent", Vector3(0, 8.22, z))
	var plate := MeshKit.mat_color(Color(0.92, 0.88, 0.78), 0.52)
	for i in range(6):
		var z := -11.0 + float(i) * 4.4
		MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.06, 0.16, 0.28)), plate, "StallPlate", Vector3(7.42, 2.38, z))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.08, 2.4, 0.08)), trim, "LadderL", Vector3(-1.95, 2.85, -14.16))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.08, 2.4, 0.08)), trim, "LadderR", Vector3(-1.35, 2.85, -14.16))
	for i in range(5):
		MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.62, 0.04, 0.05)), trim, "Rung", Vector3(-1.65, 1.85 + float(i) * 0.42, -14.18))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.55, 0.42, 0.08)), MeshKit.mat_color(Color(0.72, 0.18, 0.14), 0.42), "HayDoor", Vector3(0, 3.55, -14.18), Vector3(0, 0.55, 0))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.42, 0.10, 0.22)), MeshKit.mat_color(Color(0.22, 0.22, 0.24), 0.38, 0.55), "YardFlood", Vector3(0, 4.15, -14.55))
	var gravel := MeshKit.gravel()
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(5.4, 0.06, 4.2)), gravel, "DoorApron", Vector3(0, -0.02, -16.4))
	# Hitch outside the Dutch door — used, not a prop post.
	var hitch_w := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.72, Color(0.48, 0.34, 0.18))
	var hitch_l := MeshKit.leather(Color(0.28, 0.16, 0.08), 0.52)
	for sx in [-1.0, 1.0]:
		MeshKit.add_child_mi(b, MeshKit.cyl(0.065, 1.28, 0.055, 8), hitch_w, "HitchPost", Vector3(sx * 2.42, 0.64, -16.85))
		MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.18, 0.06, 0.18)), hitch_w, "HitchFoot", Vector3(sx * 2.42, 0.04, -16.85))
		MeshKit.add_child_mi(b, MeshKit.torus(0.022, 0.038, 8, 6), MeshKit.steel(), "HitchRing", Vector3(sx * 2.42, 1.12, -16.78), Vector3(0.0, 0.0, 1.57))
	MeshKit.add_rod(b, hitch_l, "HitchLead", Vector3(-2.42, 1.12, -16.78), Vector3(-1.72, 0.42, -16.35), 0.007)
	MeshKit.add_child_mi(b, MeshKit.torus(0.055, 0.078, 10, 8), hitch_l, "HitchHalter", Vector3(-1.68, 0.38, -16.32), Vector3(0.55, 0.2, 0.1))
	var mask := MeshKit.mat_color(Color(0.82, 0.78, 0.62), 0.58)
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.22, 0.16, 0.04)), mask, "FlyMask", Vector3(2.48, 0.92, -16.72), Vector3(0.15, 0.0, 0.2))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.18, 0.10, 0.03)), MeshKit.mat_color(Color(0.12, 0.12, 0.12, 0.55), 0.72), "FlyMesh", Vector3(2.48, 0.82, -16.70), Vector3(0.15, 0.0, 0.2))
	var worn_h := MeshKit.mat_tex("res://assets/textures/sand_albedo.jpg", 0.94, Color(0.34, 0.26, 0.16))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(1.15, 0.03, 1.05)), worn_h, "HitchWearL", Vector3(-2.35, 0.02, -16.55))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(1.05, 0.03, 0.92)), worn_h, "HitchWearR", Vector3(2.28, 0.02, -16.50))
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(0.85, 0.12, 0.55)), MeshKit.mat_color(Color(0.62, 0.48, 0.22), 0.84), "DoorHay", Vector3(1.15, 0.08, -15.6))
	var flood := SpotLight3D.new()
	flood.light_energy = 1.35
	flood.light_color = Color(1.0, 0.84, 0.58)
	flood.spot_range = 16.0
	flood.spot_angle = 42.0
	flood.position = Vector3(0, 4.05, -14.7)
	flood.rotation_degrees = Vector3(-55, 180, 0)
	b.add_child(flood)
	var spill := OmniLight3D.new()
	spill.light_energy = 1.45
	spill.light_color = Color(1.0, 0.78, 0.48)
	spill.omni_range = 8.5
	spill.position = Vector3(0, 1.35, -14.2)
	b.add_child(spill)
	var gold := MeshKit.mat_color(Color(0.92, 0.72, 0.38), 0.22, 0.12)
	gold.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	gold.albedo_color = Color(0.92, 0.72, 0.38, 0.22)
	MeshKit.add_child_mi(b, MeshKit.box(Vector3(2.8, 0.008, 3.2)), gold, "DoorSpill", Vector3(0, 0.06, -15.8))
	_aisle(b)
	_paddock(b)
	_wash(b)
	_yard_life(b)


func _aisle(barn: Node3D) -> void:
	# Look through the open Dutch door and see a working aisle, not a black slab.
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.72, Color(0.58, 0.44, 0.28))
	var dark := MeshKit.mat_color(Color(0.12, 0.09, 0.07), 0.82)
	var mat := MeshKit.mat_color(Color(0.18, 0.14, 0.11), 0.88)
	var straw := MeshKit.straw()
	var hay := MeshKit.hay()
	var steel := MeshKit.steel()
	var black := MeshKit.mat_color(Color(0.08, 0.07, 0.06), 0.55)
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(3.35, 0.07, 26.4)), mat, "AisleFloor", Vector3(0, 0.04, 0.2))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(3.2, 0.02, 26.0)), MeshKit.mat_color(Color(0.10, 0.08, 0.07), 0.78), "AisleMat", Vector3(0, 0.085, 0.2))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(3.4, 0.08, 26.6)), dark, "AisleCeil", Vector3(0, 3.95, 0.2))
	for i in range(6):
		var z := -11.0 + float(i) * 4.4
		for sx in [-1.0, 1.0]:
			MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.10, 2.35, 3.85)), wood, "StallFront", Vector3(sx * 1.72, 1.22, z))
			for k in range(4):
				MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.035, 1.15, 0.035)), MeshKit.stall_steel(), "StallBar", Vector3(sx * 1.78, 1.85, z - 1.2 + float(k) * 0.80))
			MeshKit.add_child_mi(barn, MeshKit.box(Vector3(3.4, 0.10, 3.6)), straw, "Bedding", Vector3(sx * 4.35, 0.08, z))
			MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.28, 0.22, 0.28)), black, "StallBucket", Vector3(sx * 2.15, 0.22, z + 1.15))
			MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.22, 0.02, 0.22)), MeshKit.mat_color(Color(0.28, 0.42, 0.40), 0.14, 0.16), "StallWater", Vector3(sx * 2.15, 0.34, z + 1.15))
		MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.42, 0.14, 0.08)), MeshKit.mat_color(Color(0.86, 0.80, 0.64), 0.48), "NamePlate", Vector3(1.68, 2.18, z))
		MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.22, 0.08, 0.06)), steel, "HalterHook", Vector3(-1.68, 1.72, z))
		var lamp := MeshKit.add_child_mi(barn, MeshKit.cyl(0.07, 0.16, 0.10, 8), MeshKit.mat_color(Color(0.92, 0.78, 0.48), 0.22, 0.55), "AisleLamp", Vector3(0, 3.72, z))
		lamp.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		var bulb := OmniLight3D.new()
		bulb.light_energy = 0.85
		bulb.light_color = Color(1.0, 0.86, 0.62)
		bulb.omni_range = 6.5
		bulb.position = Vector3(0, 3.55, z)
		barn.add_child(bulb)
	var names := ["ABBOTT", "OPEN", "OPEN"]
	for i in range(3):
		var lab := Label3D.new()
		lab.text = names[i]
		lab.font_size = 42 if i == 0 else 26
		lab.modulate = Color(0.18, 0.12, 0.08)
		lab.position = Vector3(1.74, 2.18, -11.0 + float(i) * 4.4)
		lab.rotation.y = PI * 0.5
		barn.add_child(lab)
	# His stall: a hung hay net, not an empty box.
	var net := MeshKit.mat_color(Color(0.68, 0.18, 0.14), 0.52)
	for i in range(6):
		MeshKit.add_child_mi(barn, MeshKit.torus(0.092, 0.122, 10, 8), net, "HayNet", Vector3(2.42, 1.62 - float(i) * 0.020, -10.85), Vector3(1.40, 0.22, 0.10))
	MeshKit.add_rod(barn, MeshKit.mat_color(Color(0.18, 0.12, 0.08), 0.55), "HayNetHang", Vector3(2.42, 1.92, -10.85), Vector3(2.42, 1.55, -10.85), 0.005)
	MeshKit.add_child_mi(barn, MeshKit.sphere(0.18, 7, 8), hay, "HayNetFill", Vector3(2.42, 1.48, -10.85)).scale = Vector3(1.22, 0.88, 1.10)
	for i in range(4):
		var hx := -0.55 + float(i % 2) * 1.05
		var hz := 11.2 + float(i / 2) * 0.85
		var hy := 0.28 + float(i % 2) * 0.42
		MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.85, 0.38, 0.55)), hay, "HayBale", Vector3(hx, hy, hz))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.72, 0.48, 0.42)), MeshKit.mat_color(Color(0.28, 0.16, 0.10), 0.52), "AisleTrunk", Vector3(-0.85, 0.28, -12.2))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.08, 1.15, 0.08)), MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.62, Color(0.42, 0.28, 0.14)), "ForkHandle", Vector3(1.05, 0.72, -12.4), Vector3(0.18, 0.0, 0.12))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.28, 0.04, 0.18)), steel, "ForkHead", Vector3(1.22, 1.22, -12.28), Vector3(0.18, 0.0, 0.12))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.85, 0.06, 1.55)), MeshKit.cooler_wool(), "CoolerRug", Vector3(0.05, 1.55, 10.4), Vector3(0.0, 0.0, 0.15))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(1.85, 0.03, 2.4)), straw, "AisleSpill", Vector3(0.12, 0.10, -12.2))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.55, 0.04, 0.72)), hay, "DoorFlake", Vector3(0.85, 0.12, -12.6))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.38, 0.03, 0.48)), hay, "DoorFlake2", Vector3(0.22, 0.11, -11.8), Vector3(0.0, 0.35, 0.0))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.28, 0.025, 0.36)), hay, "DoorFlake3", Vector3(-0.42, 0.11, -12.0), Vector3(0.0, -0.55, 0.0))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.72, 0.92, 0.04)), MeshKit.cooler_wool(), "StallCooler", Vector3(1.82, 1.08, -11.0), Vector3(0.10, 0.0, 0.0))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.36, 0.12, 0.018)), MeshKit.steel(), "BrassPlate", Vector3(1.78, 2.18, -11.0))
	var leather := MeshKit.leather(Color(0.28, 0.16, 0.08), 0.52)
	MeshKit.add_child_mi(barn, MeshKit.torus(0.018, 0.032, 8, 6), steel, "CrossL", Vector3(-1.62, 1.85, -6.6), Vector3(0, 0, 1.57))
	MeshKit.add_child_mi(barn, MeshKit.torus(0.018, 0.032, 8, 6), steel, "CrossR", Vector3(1.62, 1.85, -6.6), Vector3(0, 0, 1.57))
	MeshKit.add_rod(barn, leather, "CrossTieL", Vector3(-1.62, 1.85, -6.6), Vector3(-0.55, 1.42, -6.55), 0.006)
	MeshKit.add_rod(barn, leather, "CrossTieR", Vector3(1.62, 1.85, -6.6), Vector3(0.55, 1.42, -6.55), 0.006)
	MeshKit.add_child_mi(barn, MeshKit.torus(0.042, 0.058, 10, 8), leather, "Halter", Vector3(-1.68, 1.48, -11.0), Vector3(0.35, 0.0, 0.15))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.04, 0.12, 0.02)), steel, "HalterSnap", Vector3(-1.68, 1.38, -11.0))
	var oak := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.62, Color(0.42, 0.28, 0.14))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.72, 0.08, 0.42)), oak, "SaddleRack", Vector3(1.15, 1.28, 10.15))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.08, 1.05, 0.08)), oak, "SaddlePost", Vector3(1.15, 0.72, 10.15))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.48, 0.16, 0.36)), MeshKit.leather(Color(0.36, 0.18, 0.10), 0.42), "Saddle", Vector3(1.15, 1.42, 10.15), Vector3(0.18, 0.0, 0.0))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.22, 0.08, 0.28)), MeshKit.leather(Color(0.22, 0.12, 0.07), 0.48), "SaddleFlap", Vector3(1.02, 1.34, 10.15))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.56, 0.05, 0.40)), MeshKit.mat_color(Color(0.72, 0.22, 0.18), 0.62), "SaddlePad", Vector3(1.15, 1.36, 10.15), Vector3(0.18, 0.0, 0.0))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.04, 0.42, 0.03)), MeshKit.leather(Color(0.22, 0.12, 0.07), 0.48), "Girth", Vector3(1.42, 1.12, 10.15))
	MeshKit.add_child_mi(barn, MeshKit.torus(0.08, 0.11), leather, "LeadCoil", Vector3(-1.55, 1.22, -6.55), Vector3(1.57, 0.2, 0.0))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.68, 0.04, 0.38)), MeshKit.mat_color(Color(0.18, 0.12, 0.08), 0.48), "TrunkLid", Vector3(-0.85, 0.54, -12.2), Vector3(0.0, 0.0, -0.55))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.18, 0.12, 0.22)), MeshKit.mat_color(Color(0.16, 0.22, 0.38), 0.55), "Wraps", Vector3(-0.72, 0.42, -12.05))


func _house() -> void:
	var siding := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.7, Color(0.94, 0.93, 0.88))
	var roof := MeshKit.house_roof()
	var win := MeshKit.mat_color(Color(0.86, 0.70, 0.42), 0.28, 0.0)
	win.transparency = BaseMaterial3D.TRANSPARENCY_DISABLED
	win.emission_enabled = true
	win.emission = Color(1.0, 0.78, 0.40)
	win.emission_energy_multiplier = 1.55
	var h := Node3D.new()
	h.position = Vector3(62, 0, -52)
	h.rotation_degrees = Vector3(0, -12, 0)
	add_child(h)
	var trim := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.58, Color(0.88, 0.84, 0.74))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.16, 4.0, 8.5)), siding, "HWallL", Vector3(-5.17, 2.0, 0))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.16, 4.0, 8.5)), siding, "HWallR", Vector3(5.17, 2.0, 0))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(10.5, 4.0, 0.16)), siding, "HWallF", Vector3(0, 2.0, 4.17))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(10.5, 4.0, 0.16)), siding, "HWallB", Vector3(0, 2.0, -4.17))
	var stone := MeshKit.fieldstone()
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(10.8, 0.48, 8.8)), stone, "HFound", Vector3(0, 0.20, 0))
	MeshKit.add_child_mi(h, MeshKit.prism(Vector3(11.8, 2.6, 9.6)), roof, "HRoof", Vector3(0, 5.3, 0))
	MeshKit.add_child_mi(h, MeshKit.prism(Vector3(10.5, 2.45, 0.16)), siding, "HGableF", Vector3(0, 5.15, 4.17))
	MeshKit.add_child_mi(h, MeshKit.prism(Vector3(10.5, 2.45, 0.16)), siding, "HGableB", Vector3(0, 5.15, -4.17))
	for z in [-2.2, 2.2]:
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.08, 1.15, 1.05)), win, "SideWin", Vector3(-5.22, 2.25, z))
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.08, 1.15, 1.05)), win, "SideWinR", Vector3(5.22, 2.25, z))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.22, 0.16, 9.8)), MeshKit.mat_color(Color(0.16, 0.15, 0.14), 0.5), "HRidge", Vector3(0, 6.62, 0))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(5.2, 3.1, 0.14)), siding, "WingF", Vector3(7.4, 1.55, 1.4))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(5.2, 3.1, 0.14)), siding, "WingB", Vector3(7.4, 1.55, -1.4))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.14, 3.1, 2.9)), siding, "WingE", Vector3(10.0, 1.55, 0.0))
	MeshKit.add_child_mi(h, MeshKit.prism(Vector3(5.8, 1.6, 3.4)), roof, "WingRoof", Vector3(7.5, 3.95, 0.0))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.08, 4.05, 0.08)), trim, "CornerFL", Vector3(-5.28, 2.02, 4.28))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.08, 4.05, 0.08)), trim, "CornerFR", Vector3(5.28, 2.02, 4.28))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(1.2, 2.2, 0.12)), MeshKit.mat_color(Color(0.22, 0.16, 0.12), 0.6), "Door", Vector3(0, 1.1, 4.28))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.06, 2.05, 0.04)), trim, "DoorPanel", Vector3(0, 1.12, 4.36))
	var shut := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.62, Color(0.42, 0.28, 0.18))
	for x in [-2.8, 2.8]:
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(1.1, 1.2, 0.08)), win, "Win", Vector3(x, 2.3, 4.28))
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.04, 1.12, 0.04)), trim, "WinMuntin", Vector3(x, 2.3, 4.34))
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(1.02, 0.04, 0.04)), trim, "WinCross", Vector3(x, 2.3, 4.34))
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.16, 1.2, 0.06)), shut, "ShutL", Vector3(x - 0.62, 2.3, 4.30))
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.16, 1.2, 0.06)), shut, "ShutR", Vector3(x + 0.62, 2.3, 4.30))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(1.6, 1.15, 1.8)), siding, "Dormer", Vector3(0, 5.55, 2.6))
	MeshKit.add_child_mi(h, MeshKit.prism(Vector3(1.9, 0.85, 2.1)), roof, "DormerRoof", Vector3(0, 6.35, 2.6))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.72, 0.72, 0.08)), win, "DormerWin", Vector3(0, 5.55, 3.52))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.12, 0.72, 0.06)), shut, "DormerShutL", Vector3(-0.44, 5.55, 3.54))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.12, 0.72, 0.06)), shut, "DormerShutR", Vector3(0.44, 5.55, 3.54))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.04, 0.68, 0.04)), trim, "DormerMuntin", Vector3(0, 5.55, 3.58))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.68, 0.04, 0.04)), trim, "DormerCross", Vector3(0, 5.55, 3.58))
	var porch := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.7, Color(0.72, 0.62, 0.46))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(7.2, 0.14, 2.4)), porch, "Porch", Vector3(0, 0.10, 5.4))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(1.15, 0.14, 0.85)), porch, "Step1", Vector3(0, 0.07, 6.75))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(1.15, 0.14, 0.55)), porch, "Step2", Vector3(0, 0.20, 6.45))
	for x in [-3.2, -1.05, 1.05, 3.2]:
		MeshKit.add_child_mi(h, MeshKit.cyl(0.075, 2.4, 0.065, 8), porch, "PorchPost", Vector3(x, 1.28, 6.2))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(7.4, 0.06, 0.06)), porch, "PorchRail", Vector3(0, 1.05, 6.55))
	for i in range(11):
		var px := -3.1 + float(i) * 0.62
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.04, 0.72, 0.04)), porch, "Spindle", Vector3(px, 0.68, 6.52))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(7.6, 0.10, 2.6)), roof, "PorchRoof", Vector3(0, 2.55, 5.5), Vector3(0.12, 0, 0))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.9, 2.2, 0.7)), MeshKit.mat_color(Color(0.55, 0.42, 0.36), 0.7), "Chimney", Vector3(-3.6, 6.4, -1.2))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(1.05, 0.12, 0.85)), MeshKit.mat_color(Color(0.22, 0.18, 0.16), 0.55), "ChimCap", Vector3(-3.6, 7.52, -1.2))
	var dirt := MeshKit.mat_color(Color(0.28, 0.20, 0.12), 0.82)
	var bloom := MeshKit.mat_color(Color(0.78, 0.24, 0.28), 0.50)
	var leaf := MeshKit.mat_color(Color(0.18, 0.32, 0.12), 0.86)
	for x in [-2.8, 2.8]:
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(1.15, 0.12, 0.22)), dirt, "WinBox", Vector3(x, 1.62, 4.38))
		MeshKit.add_child_mi(h, MeshKit.sphere(0.08, 6, 8), leaf, "WinLeaf", Vector3(x, 1.74, 4.42))
		MeshKit.add_child_mi(h, MeshKit.sphere(0.05, 6, 8), bloom, "WinBloom", Vector3(x + 0.18, 1.78, 4.44))
		MeshKit.add_child_mi(h, MeshKit.sphere(0.05, 6, 8), bloom, "WinBloom2", Vector3(x - 0.16, 1.76, 4.44))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.55, 0.08, 7.4)), porch, "PorchBeam", Vector3(0, 2.42, 5.5))
	var gutter := MeshKit.mat_color(Color(0.38, 0.36, 0.32), 0.42)
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(11.6, 0.08, 0.12)), gutter, "GutterF", Vector3(0, 4.08, 4.85))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(11.6, 0.08, 0.12)), gutter, "GutterB", Vector3(0, 4.08, -4.85))
	MeshKit.add_child_mi(h, MeshKit.cyl(0.04, 3.95, 0.035, 6), gutter, "DownL", Vector3(-5.55, 2.05, 4.78))
	MeshKit.add_child_mi(h, MeshKit.cyl(0.04, 3.95, 0.035, 6), gutter, "DownR", Vector3(5.55, 2.05, 4.78))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.08, 4.05, 0.08)), trim, "CornerBL", Vector3(-5.28, 2.02, -4.28))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.08, 4.05, 0.08)), trim, "CornerBR", Vector3(5.28, 2.02, -4.28))
	var brass := MeshKit.mat_color(Color(0.62, 0.48, 0.22), 0.28, 0.55)
	MeshKit.add_child_mi(h, MeshKit.sphere(0.035, 6, 8), brass, "DoorKnob", Vector3(0.42, 1.18, 4.40))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.28, 0.10, 0.04)), brass, "MailSlot", Vector3(0, 0.72, 4.38))
	for z in [-2.2, 2.2]:
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.06, 1.15, 0.14)), shut, "SideShutL", Vector3(-5.26, 2.25, z - 0.62))
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.06, 1.15, 0.14)), shut, "SideShutR", Vector3(-5.26, 2.25, z + 0.62))
	var seat := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.62, Color(0.48, 0.32, 0.18))
	var cushion := MeshKit.mat_color(Color(0.42, 0.22, 0.16), 0.78)
	for x in [-2.15, 2.15]:
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.72, 0.06, 0.48)), seat, "ChairSeat", Vector3(x, 0.46, 5.55))
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.72, 0.42, 0.05)), seat, "ChairBack", Vector3(x, 0.68, 5.32))
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.06, 0.40, 0.06)), seat, "ChairLegL", Vector3(x - 0.28, 0.26, 5.68))
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.06, 0.40, 0.06)), seat, "ChairLegR", Vector3(x + 0.28, 0.26, 5.68))
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.64, 0.05, 0.40)), cushion, "Cushion", Vector3(x, 0.52, 5.56))
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.78, 0.04, 0.08)), seat, "RockerF", Vector3(x, 0.08, 5.72), Vector3(0.0, 0.0, 0.18))
		MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.78, 0.04, 0.08)), seat, "RockerB", Vector3(x, 0.08, 5.38), Vector3(0.0, 0.0, 0.18))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.22, 0.012, 0.28)), MeshKit.mat_color(Color(0.88, 0.86, 0.80), 0.72), "Paper", Vector3(-2.02, 0.56, 5.58), Vector3(0.0, 0.42, 0.10))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.38, 0.06, 0.38)), seat, "SideTable", Vector3(0.0, 0.42, 5.72))
	MeshKit.add_child_mi(h, MeshKit.cyl(0.05, 0.08, 0.05, 8), MeshKit.mat_color(Color(0.72, 0.78, 0.74), 0.12, 0.28), "Glass", Vector3(0.0, 0.50, 5.72))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.95, 0.03, 0.55)), MeshKit.mat_color(Color(0.28, 0.22, 0.16), 0.82), "DoorMat", Vector3(0, 0.185, 6.55))
	var boot := MeshKit.mat_color(Color(0.10, 0.08, 0.06), 0.48)
	MeshKit.add_child_mi(h, MeshKit.cyl(0.042, 0.28, 0.036, 8), boot, "BootL", Vector3(-0.62, 0.32, 5.95))
	MeshKit.add_child_mi(h, MeshKit.cyl(0.042, 0.28, 0.036, 8), boot, "BootR", Vector3(-0.50, 0.32, 5.98))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.055, 0.022, 0.10)), boot, "BootToeL", Vector3(-0.62, 0.20, 6.06), Vector3(-0.25, 0, 0))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.055, 0.022, 0.10)), boot, "BootToeR", Vector3(-0.50, 0.20, 6.08), Vector3(-0.25, 0, 0))
	var fern := MeshKit.mat_color(Color(0.18, 0.34, 0.12), 0.84)
	MeshKit.add_child_mi(h, MeshKit.cyl(0.04, 0.22, 0.05, 8), MeshKit.mat_color(Color(0.42, 0.22, 0.14), 0.55), "HangPot", Vector3(-1.05, 2.18, 6.15))
	MeshKit.add_child_mi(h, MeshKit.sphere(0.16, 7, 8), fern, "HangFern", Vector3(-1.05, 2.02, 6.15)).scale = Vector3(1.35, 0.72, 1.15)
	MeshKit.add_rod(h, MeshKit.mat_color(Color(0.12, 0.10, 0.08), 0.50), "HangWire", Vector3(-1.05, 2.48, 6.15), Vector3(-1.05, 2.28, 6.15), 0.004)
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.42, 0.28, 0.06)), MeshKit.mat_color(Color(0.92, 0.88, 0.78), 0.52), "HouseNum", Vector3(1.05, 2.55, 4.32))
	var num := Label3D.new()
	num.text = "4821"
	num.font_size = 22
	num.modulate = Color(0.22, 0.14, 0.10)
	num.position = Vector3(1.05, 2.55, 4.36)
	h.add_child(num)
	var bloom2 := MeshKit.mat_color(Color(0.86, 0.62, 0.18), 0.48)
	for x in [-2.8, 2.8]:
		MeshKit.add_child_mi(h, MeshKit.sphere(0.045, 6, 8), bloom2, "WinBloom3", Vector3(x + 0.06, 1.80, 4.46))
		MeshKit.add_child_mi(h, MeshKit.sphere(0.04, 6, 8), leaf, "WinLeaf2", Vector3(x - 0.22, 1.72, 4.42))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.22, 0.18, 0.55)), MeshKit.mat_color(Color(0.32, 0.28, 0.24), 0.72), "FoundVent", Vector3(2.8, 0.28, 4.22))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.22, 0.18, 0.55)), MeshKit.mat_color(Color(0.32, 0.28, 0.24), 0.72), "FoundVent2", Vector3(-2.8, 0.28, 4.22))
	var black := MeshKit.mat_color(Color(0.08, 0.08, 0.09), 0.48)
	MeshKit.add_child_mi(h, MeshKit.cyl(0.035, 1.15, 0.03, 8), black, "MailPost", Vector3(-6.4, 0.58, 7.2))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.42, 0.22, 0.18)), MeshKit.mat_color(Color(0.14, 0.22, 0.38), 0.42), "Mailbox", Vector3(-6.4, 1.22, 7.2))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.12, 0.04, 0.16)), MeshKit.mat_color(Color(0.72, 0.18, 0.14), 0.45), "MailFlag", Vector3(-6.18, 1.28, 7.2))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.18, 0.02, 0.12)), MeshKit.mat_color(Color(0.92, 0.90, 0.82), 0.55), "MailLetter", Vector3(-6.32, 1.34, 7.2))
	MeshKit.add_child_mi(h, MeshKit.cyl(0.10, 0.06, 0.10, 10), MeshKit.mat_color(Color(0.18, 0.16, 0.14), 0.48), "DogBowl", Vector3(-0.85, 0.06, 7.85))
	MeshKit.add_child_mi(h, MeshKit.cyl(0.07, 0.02, 0.07, 8), MeshKit.mat_color(Color(0.42, 0.52, 0.58), 0.18, 0.22), "DogWater", Vector3(-0.85, 0.09, 7.85))
	MeshKit.add_child_mi(h, MeshKit.cyl(0.08, 0.12, 0.10, 8), MeshKit.mat_color(Color(0.42, 0.22, 0.14), 0.55), "WalkPot", Vector3(0.72, 0.10, 7.15))
	MeshKit.add_child_mi(h, MeshKit.sphere(0.12, 7, 8), MeshKit.mat_color(Color(0.86, 0.42, 0.16), 0.48), "WalkMum", Vector3(0.72, 0.22, 7.15)).scale = Vector3(1.18, 0.72, 1.10)
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.42, 0.04, 0.28)), MeshKit.mat_color(Color(0.62, 0.18, 0.16), 0.62), "Quilt", Vector3(-2.05, 0.58, 5.62), Vector3(0.12, 0.35, 0.08))
	MeshKit.add_child_mi(h, MeshKit.cyl(0.035, 0.10, 0.028, 8), MeshKit.mat_color(Color(0.72, 0.78, 0.82), 0.18, 0.22), "TeaGlass", Vector3(-1.72, 0.58, 5.52))
	MeshKit.add_child_mi(h, MeshKit.cyl(0.022, 0.04, 0.022, 6), MeshKit.mat_color(Color(0.42, 0.22, 0.10), 0.35), "Tea", Vector3(-1.72, 0.56, 5.52))
	MeshKit.add_child_mi(h, MeshKit.sphere(0.12, 8, 10), MeshKit.mat_color(Color(0.12, 0.10, 0.08), 0.72), "PorchCat", Vector3(0.85, 0.18, 6.55)).scale = Vector3(1.35, 0.62, 0.95)
	MeshKit.add_child_mi(h, MeshKit.sphere(0.055, 7, 8), MeshKit.mat_color(Color(0.12, 0.10, 0.08), 0.72), "CatHead", Vector3(1.02, 0.22, 6.48))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.18, 0.025, 0.08)), MeshKit.mat_color(Color(0.12, 0.10, 0.08), 0.72), "CatTail", Vector3(0.68, 0.16, 6.62), Vector3(0.0, 0.45, 0.22))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.16, 1.35, 0.16)), porch, "GatePostL", Vector3(-8.2, 0.68, 8.4))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.16, 1.35, 0.16)), porch, "GatePostR", Vector3(-5.4, 0.68, 8.4))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(2.85, 0.08, 0.08)), porch, "GateRail", Vector3(-6.8, 1.15, 8.4))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(2.85, 0.08, 0.08)), porch, "GateRail2", Vector3(-6.8, 0.72, 8.4))
	MeshKit.add_child_mi(h, MeshKit.cyl(0.04, 0.22, 0.04, 8), MeshKit.mat_color(Color(0.18, 0.16, 0.12), 0.42), "PorchLantern", Vector3(0, 2.22, 6.35))
	MeshKit.add_child_mi(h, MeshKit.sphere(0.07, 6, 8), MeshKit.mat_color(Color(0.96, 0.82, 0.48), 0.22, 0.15), "PorchBulb", Vector3(0, 2.08, 6.35))
	var porch_l := OmniLight3D.new()
	porch_l.light_energy = 1.15
	porch_l.light_color = Color(1.0, 0.78, 0.48)
	porch_l.omni_range = 9.0
	porch_l.position = Vector3(0, 2.05, 6.2)
	h.add_child(porch_l)
	for x in [-2.8, 2.8]:
		var wl := OmniLight3D.new()
		wl.light_energy = 0.55
		wl.light_color = Color(1.0, 0.80, 0.50)
		wl.omni_range = 4.5
		wl.position = Vector3(x, 2.3, 4.6)
		h.add_child(wl)
	# Foundation plantings so the house sits in a yard, not on a green sheet.
	var shrub := MeshKit.mat_color(Color(0.16, 0.30, 0.12), 0.88)
	var shrub2 := MeshKit.mat_color(Color(0.22, 0.36, 0.14), 0.86)
	for i in range(7):
		var fx: float = -3.6 + float(i) * 1.2
		if absf(fx) < 0.70:
			continue
		var bush := MeshKit.add_child_mi(h, MeshKit.sphere(0.38, 8, 10), shrub if i % 2 == 0 else shrub2, "FoundShrub", Vector3(fx, 0.32, 4.55))
		bush.scale = Vector3(1.15, 0.85, 0.92)
	var flag := MeshKit.mat_tex("res://assets/textures/sand_albedo.jpg", 0.78, Color(0.58, 0.52, 0.42))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(1.35, 0.05, 3.2)), flag, "Walk", Vector3(0, 0.02, 8.2))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(1.55, 0.04, 1.15)), flag, "WalkPad", Vector3(0, 0.02, 6.95))
	for sx: float in [-1.0, 1.0]:
		var boxw := MeshKit.add_child_mi(h, MeshKit.sphere(0.48, 8, 10), shrub, "PorchBox", Vector3(sx * 3.55, 0.38, 6.05))
		boxw.scale = Vector3(1.05, 0.92, 0.88)
	var can := MeshKit.mat_color(Color(0.28, 0.42, 0.22), 0.48)
	MeshKit.add_child_mi(h, MeshKit.cyl(0.08, 0.16, 0.10, 8), can, "WaterCan", Vector3(3.05, 0.22, 6.35))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.12, 0.04, 0.04)), can, "WaterSpout", Vector3(3.18, 0.26, 6.35))
	MeshKit.add_child_mi(h, MeshKit.torus(0.04, 0.055, 8, 6), can, "WaterHandle", Vector3(3.05, 0.32, 6.35), Vector3(1.57, 0.0, 0.0))
	MeshKit.add_child_mi(h, MeshKit.cyl(0.012, 0.85, 0.012, 6), MeshKit.mat_color(Color(0.12, 0.12, 0.14), 0.62), "YardHose", Vector3(3.22, 0.08, 6.55), Vector3(0.0, 0.0, 1.20))
	var logm := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.72, Color(0.42, 0.28, 0.16))
	for i: int in range(8):
		var row: float = float(i / 4)
		var col: float = float(i % 4)
		MeshKit.add_child_mi(h, MeshKit.cyl(0.06, 0.42, 0.055, 8), logm, "Log", Vector3(-4.55 + col * 0.13, 0.08 + row * 0.12, 3.85), Vector3(0.0, 0.0, 1.57))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.04, 0.62, 0.04)), MeshKit.mat_color(Color(0.22, 0.14, 0.08), 0.55), "AxeHaft", Vector3(-4.15, 0.38, 3.55), Vector3(0.35, 0.0, 0.12))
	MeshKit.add_child_mi(h, MeshKit.box(Vector3(0.16, 0.04, 0.10)), MeshKit.steel(), "AxeHead", Vector3(-4.02, 0.68, 3.48), Vector3(0.35, 0.0, 0.12))
	# Oaks on the yard. Keepout around the house ate the shade-tree pass.
	_yard_oak(h, Vector3(-11.2, 0.0, 7.4), 14.2)
	_yard_oak(h, Vector3(13.5, 0.0, 5.8), 15.6)
	_yard_oak(h, Vector3(-4.8, 0.0, -10.5), 13.4)


func _yard_oak(parent: Node3D, p: Vector3, h: float) -> void:
	var t := Node3D.new()
	t.name = "YardOak"
	t.position = p
	parent.add_child(t)
	var rng := RandomNumberGenerator.new()
	rng.seed = int(absf(p.x * 13.0 + p.z * 29.0) * 80.0) + 11
	_oak_plant(t, h, MeshKit.pine_bark(), MeshKit.hardwood_material(true), MeshKit.hardwood_material(false), rng)


func _letters() -> void:
	var hw := RING_W * 0.5 + 1.15
	var hd := RING_D * 0.5 + 1.15
	var marks := [
		["A", Vector3(0, 0, -hd)],
		["C", Vector3(0, 0, hd)],
		["E", Vector3(-hw, 0, 0)],
		["B", Vector3(hw, 0, 0)],
		["K", Vector3(-hw, 0, -hd * 0.48)],
		["H", Vector3(-hw, 0, hd * 0.48)],
		["F", Vector3(hw, 0, -hd * 0.48)],
		["M", Vector3(hw, 0, hd * 0.48)],
	]
	var post := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.62, Color(0.93, 0.91, 0.84))
	var plate := MeshKit.mat_color(Color(0.96, 0.95, 0.90), 0.55)
	for m in marks:
		var n := Node3D.new()
		n.name = "Letter%s" % m[0]
		n.position = m[1] as Vector3
		add_child(n)
		MeshKit.add_child_mi(n, MeshKit.cyl(0.062, 1.38, 0.050, 8), post, "Post", Vector3(0, 0.69, 0))
		MeshKit.add_child_mi(n, MeshKit.box(Vector3(0.48, 0.48, 0.07)), plate, "Plate", Vector3(0, 1.48, 0))
		MeshKit.add_child_mi(n, MeshKit.box(Vector3(0.52, 0.05, 0.09)), MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.58, Color(0.78, 0.70, 0.52)), "PlateCap", Vector3(0, 1.74, 0))
		var dirt := MeshKit.mat_color(Color(0.28, 0.20, 0.12), 0.82)
		var leaf := MeshKit.mat_color(Color(0.18, 0.32, 0.12), 0.86)
		var bloom := MeshKit.mat_color(Color(0.78, 0.24, 0.28), 0.50)
		MeshKit.add_child_mi(n, MeshKit.box(Vector3(0.32, 0.10, 0.22)), dirt, "LetterBox", Vector3(0, 0.06, 0.18))
		MeshKit.add_child_mi(n, MeshKit.sphere(0.07, 6, 8), leaf, "LetterLeaf", Vector3(0, 0.16, 0.18))
		MeshKit.add_child_mi(n, MeshKit.sphere(0.045, 6, 8), bloom, "LetterBloom", Vector3(0.06, 0.20, 0.20))
		MeshKit.add_child_mi(n, MeshKit.sphere(0.038, 6, 8), MeshKit.mat_color(Color(0.92, 0.72, 0.22), 0.48), "LetterBloom2", Vector3(-0.06, 0.18, 0.20))
		MeshKit.add_child_mi(n, MeshKit.sphere(0.034, 6, 8), MeshKit.mat_color(Color(0.92, 0.92, 0.86), 0.50), "LetterBloom3", Vector3(0.02, 0.22, 0.16))
		var lab := Label3D.new()
		lab.text = String(m[0])
		lab.font_size = 78
		lab.modulate = Color(0.10, 0.08, 0.06)
		lab.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		lab.position = Vector3(0, 1.48, 0.05)
		n.add_child(lab)


func _lane() -> void:
	var dirt := MeshKit.mat_tex("res://assets/textures/sand_albedo.jpg", 0.86, Color(0.55, 0.46, 0.32))
	var z0 := -RING_D * 0.5 - 2.4
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(4.2, 0.05, 22.0)), dirt, "Lane", Vector3(-18.0, -0.22, z0 - 8.0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(18.0, 0.05, 4.0)), dirt, "LaneBend", Vector3(-28.0, -0.22, z0 - 18.0))
	var flower := MeshKit.mat_color(Color(0.72, 0.22, 0.28), 0.55)
	var leaf := MeshKit.mat_color(Color(0.22, 0.38, 0.16), 0.7)
	for x in [-2.4, 2.4]:
		MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.55, 0.22, 0.40)), leaf, "GateBox", Vector3(x, 0.12, -RING_D * 0.5 + 0.55))
		MeshKit.add_child_mi(self, MeshKit.sphere(0.10, 8, 10), flower, "GateBloom", Vector3(x, 0.30, -RING_D * 0.5 + 0.55))


func _mounting_block() -> void:
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.7, Color(0.62, 0.50, 0.34))
	var blk := Node3D.new()
	blk.name = "MountingBlock"
	blk.position = Vector3(3.4, 0, -RING_D * 0.5 + 2.4)
	add_child(blk)
	MeshKit.add_child_mi(blk, MeshKit.box(Vector3(0.85, 0.28, 0.55)), wood, "Step1", Vector3(0, 0.14, 0.12))
	MeshKit.add_child_mi(blk, MeshKit.box(Vector3(0.85, 0.50, 0.42)), wood, "Step2", Vector3(0, 0.25, -0.16))
	MeshKit.add_child_mi(blk, MeshKit.box(Vector3(0.85, 0.72, 0.28)), wood, "Step3", Vector3(0, 0.36, -0.40))
	var tread := MeshKit.mat_tex("res://assets/textures/sand_albedo.jpg", 0.94, Color(0.36, 0.28, 0.16))
	MeshKit.add_child_mi(blk, MeshKit.box(Vector3(0.72, 0.012, 0.36)), tread, "Tread1", Vector3(0, 0.286, 0.16))
	MeshKit.add_child_mi(blk, MeshKit.box(Vector3(0.72, 0.012, 0.28)), tread, "Tread2", Vector3(0, 0.506, -0.12))
	MeshKit.add_child_mi(blk, MeshKit.box(Vector3(0.72, 0.012, 0.18)), tread, "Tread3", Vector3(0, 0.726, -0.38))
	MeshKit.add_child_mi(blk, MeshKit.box(Vector3(0.24, 0.08, 0.32)), wood, "BootJack", Vector3(0.58, 0.04, 0.42))
	MeshKit.add_child_mi(blk, MeshKit.box(Vector3(0.32, 0.22, 0.32)), MeshKit.mat_color(Color(0.18, 0.16, 0.14), 0.55), "CropPail", Vector3(-0.62, 0.12, 0.22))
	MeshKit.add_child_mi(blk, MeshKit.cyl(0.006, 0.42, 0.004, 6), MeshKit.mat_color(Color(0.12, 0.08, 0.05), 0.42), "Crop", Vector3(-0.62, 0.38, 0.22), Vector3(0.35, 0.0, 0.20))
	MeshKit.add_child_mi(blk, MeshKit.box(Vector3(0.42, 0.04, 0.22)), MeshKit.mat_color(Color(0.16, 0.20, 0.38), 0.52), "Towel", Vector3(0.12, 0.75, -0.38), Vector3(0.0, 0.0, 0.22))
	MeshKit.add_child_mi(blk, MeshKit.box(Vector3(0.18, 0.08, 0.12)), MeshKit.mat_color(Color(0.86, 0.82, 0.74), 0.48), "Glove", Vector3(-0.28, 0.76, -0.36))
	MeshKit.add_child_mi(blk, MeshKit.box(Vector3(0.18, 0.08, 0.12)), MeshKit.mat_color(Color(0.08, 0.08, 0.10), 0.48), "Glove2", Vector3(-0.16, 0.76, -0.30))
	MeshKit.add_child_mi(blk, MeshKit.cyl(0.038, 0.22, 0.032, 8), MeshKit.mat_color(Color(0.10, 0.08, 0.06), 0.48), "BootBy", Vector3(0.72, 0.16, -0.18))
	var worn := MeshKit.mat_tex("res://assets/textures/sand_albedo.jpg", 0.94, Color(0.36, 0.28, 0.16))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(2.2, 0.03, 1.85)), worn, "BlockWear", Vector3(3.4, 0.015, -RING_D * 0.5 + 2.4))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.92, 0.02, 3.6)), worn, "BlockPath", Vector3(2.35, 0.012, -RING_D * 0.5 + 1.1))


func _paddock(barn: Node3D) -> void:
	var rail := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.7, Color(0.78, 0.70, 0.52))
	var dark := MeshKit.mat_color(Color(0.22, 0.16, 0.10), 0.7)
	var posts := [
		[Vector3(16.4, 0.62, 8.0), Vector3(16.4, 0.62, 24.0)],
		[Vector3(16.4, 0.62, 24.0), Vector3(28.0, 0.62, 24.0)],
		[Vector3(28.0, 0.62, 24.0), Vector3(28.0, 0.62, 8.0)],
		[Vector3(28.0, 0.62, 8.0), Vector3(16.4, 0.62, 8.0)],
	]
	for seg in posts:
		var a: Vector3 = seg[0]
		var b: Vector3 = seg[1]
		var dir := b - a
		var len := dir.length()
		var mid := (a + b) * 0.5
		var yaw := atan2(dir.x, dir.z)
		var npost := int(len / 3.2) + 1
		for i in range(npost + 1):
			var t := float(i) / float(npost)
			var p := a.lerp(b, t)
			MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.12, 1.25, 0.12)), rail, "PadPost", Vector3(p.x, 0.62, p.z))
		MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.06, 0.07, len)), rail, "PadRail", Vector3(mid.x, 0.95, mid.z), Vector3(0, yaw, 0))
		MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.06, 0.07, len)), rail, "PadRail2", Vector3(mid.x, 0.55, mid.z), Vector3(0, yaw, 0))
		MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.06, 0.07, len)), rail, "PadRail3", Vector3(mid.x, 0.28, mid.z), Vector3(0, yaw, 0))
	var pad_dirt := MeshKit.mat_tex("res://assets/textures/sand_albedo.jpg", 0.90, Color(0.42, 0.36, 0.24))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(12.0, 0.06, 16.4)), pad_dirt, "PadFloor", Vector3(22.2, -0.02, 16.0))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(1.15, 0.55, 0.72)), dark, "Trough", Vector3(12.6, 0.28, 14.5))
	var water := MeshKit.mat_color(Color(0.22, 0.38, 0.36), 0.08, 0.22)
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(1.02, 0.03, 0.60)), water, "Water", Vector3(12.6, 0.54, 14.5))
	MeshKit.add_child_mi(barn, MeshKit.cyl(0.04, 0.85, 0.04, 8), MeshKit.steel(), "Hydrant", Vector3(13.55, 0.42, 14.5))
	MeshKit.add_child_mi(barn, MeshKit.cyl(0.018, 0.22, 0.016, 6), MeshKit.steel(), "HydrantBib", Vector3(13.72, 0.72, 14.5), Vector3(0, 0, 1.57))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.22, 0.08, 0.22)), MeshKit.mat_color(Color(0.16, 0.16, 0.18), 0.48), "HydrantBase", Vector3(13.55, 0.04, 14.5))
	var worn := MeshKit.mat_tex("res://assets/textures/sand_albedo.jpg", 0.94, Color(0.34, 0.26, 0.16))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(2.6, 0.04, 2.2)), worn, "PadWear", Vector3(13.4, 0.02, 15.2))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(7.4, 0.03, 1.05)), worn, "PadTrack", Vector3(17.8, 0.015, 15.6))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(1.15, 0.03, 5.2)), worn, "PadTrack2", Vector3(22.4, 0.015, 18.4))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.30, 0.16, 0.22)), MeshKit.mat_color(Color(0.88, 0.84, 0.74), 0.50), "Salt", Vector3(13.15, 0.10, 15.35))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(1.35, 0.08, 0.08)), rail, "GateTop", Vector3(16.4, 1.05, 16.0), Vector3(0, 1.57, 0))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(1.35, 0.08, 0.08)), rail, "GateBot", Vector3(16.4, 0.52, 16.0), Vector3(0, 1.57, 0))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.08, 0.22, 0.04)), MeshKit.steel(), "Latch", Vector3(16.52, 0.82, 16.55))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.04, 0.10, 0.16)), MeshKit.steel(), "LatchBar", Vector3(16.52, 0.82, 16.48))
	var straw := MeshKit.mat_color(Color(0.72, 0.58, 0.28), 0.82)
	var straw2 := MeshKit.mat_color(Color(0.64, 0.50, 0.22), 0.84)
	# Stack, not three boxes on a diagonal.
	for i in range(3):
		MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.92, 0.38, 0.50)), straw if i % 2 == 0 else straw2, "Bale", Vector3(11.15 + float(i) * 0.96, 0.20, 16.85))
	for i in range(2):
		MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.92, 0.38, 0.50)), straw2 if i % 2 == 0 else straw, "Bale2", Vector3(11.62 + float(i) * 0.96, 0.59, 16.85))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.92, 0.38, 0.50)), straw, "Bale3", Vector3(12.10, 0.98, 16.85))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(1.85, 0.55, 1.35)), straw2, "Manure", Vector3(20.4, 0.26, 10.6))
	MeshKit.add_child_mi(barn, MeshKit.sphere(0.42, 8, 10), straw, "ManureHeap", Vector3(20.15, 0.62, 10.35)).scale = Vector3(1.55, 0.72, 1.25)
	MeshKit.add_child_mi(barn, MeshKit.sphere(0.32, 7, 8), straw2, "ManureHeap2", Vector3(20.75, 0.48, 10.85)).scale = Vector3(1.35, 0.58, 1.10)
	var shed_w := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.70, Color(0.62, 0.50, 0.34))
	var shed_r := MeshKit.mat_color(Color(0.32, 0.18, 0.12), 0.62)
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(4.4, 2.15, 0.12)), shed_w, "RunInB", Vector3(25.2, 1.08, 22.6))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.12, 2.15, 3.2)), shed_w, "RunInL", Vector3(23.05, 1.08, 21.05))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.12, 2.15, 3.2)), shed_w, "RunInR", Vector3(27.35, 1.08, 21.05))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(4.8, 0.10, 3.6)), shed_r, "RunInRoof", Vector3(25.2, 2.28, 21.0), Vector3(0.12, 0, 0))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(4.2, 0.08, 3.0)), straw, "RunInBed", Vector3(25.2, 0.05, 21.1))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.55, 0.42, 0.42)), dark, "RunInTub", Vector3(23.6, 0.22, 20.2))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.88, 0.06, 1.22)), MeshKit.mat_color(Color(0.16, 0.20, 0.38), 0.48), "RunInRug", Vector3(26.85, 1.58, 22.42), Vector3(0.0, 0.0, 0.22))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.26, 0.14, 0.18)), MeshKit.mat_color(Color(0.88, 0.84, 0.74), 0.50), "RunInSalt", Vector3(24.05, 0.10, 20.55))


func _wash(barn: Node3D) -> void:
	var conc := MeshKit.mat_tex("res://assets/textures/sand_albedo.jpg", 0.78, Color(0.62, 0.58, 0.52))
	var steel := MeshKit.steel()
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.68, Color(0.72, 0.62, 0.46))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(4.2, 0.08, 3.4)), conc, "WashPad", Vector3(12.4, 0.04, -8.2))
	for x in [10.6, 14.2]:
		MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.10, 1.55, 0.10)), wood, "WashPost", Vector3(x, 0.78, -8.2))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(3.7, 0.06, 0.06)), wood, "WashRail", Vector3(12.4, 1.48, -8.2))
	MeshKit.add_child_mi(barn, MeshKit.cyl(0.018, 1.85, 0.014, 8), steel, "Hose", Vector3(10.7, 0.92, -6.8), Vector3(0.35, 0.0, 0.4))
	MeshKit.add_child_mi(barn, MeshKit.torus(0.16, 0.22), MeshKit.mat_color(Color(0.12, 0.12, 0.14), 0.62), "HoseCoil", Vector3(10.55, 0.72, -6.55), Vector3(1.57, 0, 0.4))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.55, 0.42, 0.42)), MeshKit.mat_color(Color(0.18, 0.16, 0.14), 0.55), "Bucket", Vector3(14.0, 0.22, -6.9))
	MeshKit.add_child_mi(barn, MeshKit.cyl(0.018, 0.22, 0.016, 6), steel, "Bib", Vector3(10.55, 1.22, -8.2), Vector3(0, 0, 1.57))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.22, 0.18, 0.16)), MeshKit.mat_color(Color(0.88, 0.82, 0.72), 0.48), "Salt", Vector3(14.15, 1.05, -8.2))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.48, 0.04, 0.48)), MeshKit.mat_color(Color(0.22, 0.22, 0.20), 0.45), "Drain", Vector3(12.4, 0.09, -8.2))
	var wet := MeshKit.mat_color(Color(0.42, 0.48, 0.46), 0.12, 0.18)
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(1.85, 0.01, 1.15)), wet, "Wet", Vector3(12.4, 0.085, -8.05))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.72, 0.008, 0.48)), wet, "Wet2", Vector3(13.55, 0.086, -7.35))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.42, 0.006, 1.85)), wet, "WetTrail", Vector3(12.15, 0.084, -6.35))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.38, 0.22, 0.38)), MeshKit.mat_color(Color(0.16, 0.18, 0.22), 0.48), "SpongePail", Vector3(13.55, 0.14, -6.55))
	MeshKit.add_child_mi(barn, MeshKit.sphere(0.08, 7, 8), MeshKit.mat_color(Color(0.72, 0.28, 0.18), 0.42), "Sponge", Vector3(13.55, 0.32, -6.55)).scale = Vector3(1.22, 0.55, 1.05)
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.04, 0.12, 0.04)), wet, "Drip", Vector3(13.55, 0.08, -6.42))
	MeshKit.add_child_mi(barn, MeshKit.torus(0.14, 0.20), MeshKit.mat_color(Color(0.12, 0.12, 0.14), 0.62), "HoseCoil2", Vector3(10.58, 0.48, -6.48), Vector3(1.57, 0.12, 0.35))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.22, 0.012, 0.06)), MeshKit.mat_color(Color(0.72, 0.72, 0.74), 0.22, 0.45), "SweatScraper", Vector3(14.15, 1.22, -8.05), Vector3(0.0, 0.40, 0.0))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.42, 0.36, 0.04)), MeshKit.mat_color(Color(0.82, 0.78, 0.70), 0.55), "WashTowel", Vector3(14.18, 1.05, -7.95), Vector3(0.12, 0.0, 0.18))
	MeshKit.add_child_mi(barn, MeshKit.cyl(0.035, 0.16, 0.028, 8), MeshKit.mat_color(Color(0.18, 0.42, 0.22), 0.38), "FlySpray", Vector3(13.82, 0.42, -6.62))
	MeshKit.add_child_mi(barn, MeshKit.cyl(0.012, 0.06, 0.010, 6), MeshKit.steel(), "SprayCap", Vector3(13.82, 0.54, -6.62))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.95, 0.008, 0.62)), wet, "Wet3", Vector3(11.55, 0.086, -7.55))
	MeshKit.add_child_mi(barn, MeshKit.sphere(0.06, 7, 8), MeshKit.mat_color(Color(0.72, 0.42, 0.22), 0.48), "WashCurry", Vector3(13.38, 0.16, -6.48)).scale = Vector3(1.15, 0.42, 1.15)
	var rope := MeshKit.mat_color(Color(0.72, 0.62, 0.42), 0.58)
	MeshKit.add_rod(barn, rope, "TieL", Vector3(10.6, 1.42, -8.2), Vector3(11.4, 1.28, -7.4), 0.008)
	MeshKit.add_rod(barn, rope, "TieR", Vector3(14.2, 1.42, -8.2), Vector3(13.4, 1.28, -7.4), 0.008)
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.08, 0.16, 0.04)), MeshKit.mat_color(Color(0.18, 0.28, 0.42), 0.48), "Soap", Vector3(14.05, 0.52, -6.85))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.12, 0.04, 0.22)), MeshKit.mat_color(Color(0.55, 0.18, 0.14), 0.55), "Brush", Vector3(13.75, 0.48, -6.78))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.38, 0.08, 0.20)), MeshKit.mat_color(Color(0.22, 0.22, 0.24), 0.38, 0.55), "WashFlood", Vector3(12.4, 2.55, -8.2))
	var wash_l := SpotLight3D.new()
	wash_l.light_energy = 0.95
	wash_l.light_color = Color(0.95, 0.92, 0.85)
	wash_l.spot_range = 8.0
	wash_l.spot_angle = 50.0
	wash_l.position = Vector3(12.4, 2.45, -8.2)
	wash_l.rotation_degrees = Vector3(-80, 0, 0)
	barn.add_child(wash_l)


func _yard_life(barn: Node3D) -> void:
	# Two-horse gooseneck-look trailer on the gravel, not in the ring.
	var white := MeshKit.mat_color(Color(0.88, 0.88, 0.86), 0.42)
	var alum := MeshKit.mat_color(Color(0.62, 0.64, 0.66), 0.28, 0.55)
	var black := MeshKit.mat_color(Color(0.08, 0.08, 0.09), 0.55)
	var rubber := MeshKit.mat_color(Color(0.10, 0.10, 0.11), 0.78)
	var glass := MeshKit.mat_color(Color(0.18, 0.22, 0.26), 0.12, 0.35)
	var steel := MeshKit.steel()
	var t := Node3D.new()
	t.name = "Trailer"
	t.position = Vector3(18.4, 0.0, -12.6)
	t.rotation_degrees = Vector3(0, 18, 0)
	barn.add_child(t)
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(5.4, 0.16, 2.15)), black, "Frame", Vector3(0, 0.62, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(4.85, 2.05, 2.08)), white, "Box", Vector3(0.15, 1.72, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(4.95, 0.08, 2.18)), alum, "Roof", Vector3(0.15, 2.78, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(1.15, 1.05, 1.35)), white, "Nose", Vector3(-2.55, 1.28, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(1.55, 0.10, 0.10)), steel, "Hitch", Vector3(-3.55, 0.72, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.22, 0.16, 0.22)), steel, "Coupler", Vector3(-4.28, 0.72, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.08, 1.85, 1.95)), MeshKit.mat_color(Color(0.16, 0.14, 0.12), 0.62), "Ramp", Vector3(2.62, 1.05, 0), Vector3(0.22, 0, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.06, 1.55, 1.72)), MeshKit.mat_color(Color(0.42, 0.28, 0.16), 0.55), "Divider", Vector3(0.05, 1.48, 0))
	for sx in [-1.0, 1.0]:
		MeshKit.add_child_mi(t, MeshKit.box(Vector3(1.15, 0.42, 0.06)), glass, "Win", Vector3(0.35, 2.18, sx * 1.08))
		MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.55, 0.32, 0.06)), glass, "Win2", Vector3(1.55, 2.12, sx * 1.08))
		MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.08, 0.55, 0.08)), white, "FenderPost", Vector3(-1.35, 0.55, sx * 1.18))
		MeshKit.add_child_mi(t, MeshKit.box(Vector3(1.15, 0.08, 0.42)), black, "Fender", Vector3(-0.85, 0.78, sx * 1.22))
		for wz in [0.55, -0.55]:
			MeshKit.add_child_mi(t, MeshKit.cyl(0.32, 0.22, 0.32, 14), rubber, "Wheel", Vector3(wz, 0.32, sx * 1.18), Vector3(0, 0, 1.57))
			MeshKit.add_child_mi(t, MeshKit.cyl(0.12, 0.08, 0.12, 8), steel, "Hub", Vector3(wz, 0.32, sx * 1.28), Vector3(0, 0, 1.57))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.18, 0.10, 0.42)), MeshKit.mat_color(Color(0.72, 0.12, 0.10), 0.45), "TailL", Vector3(2.55, 0.82, 0.72))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.18, 0.10, 0.42)), MeshKit.mat_color(Color(0.72, 0.12, 0.10), 0.45), "TailR", Vector3(2.55, 0.82, -0.72))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.08, 0.06, 0.22)), MeshKit.mat_color(Color(0.92, 0.88, 0.78), 0.48), "Plate", Vector3(2.62, 0.58, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.12, 0.08, 1.85)), MeshKit.mat_color(Color(0.10, 0.10, 0.10), 0.55), "Bumper", Vector3(2.58, 0.48, 0))
	for sx in [-1.0, 1.0]:
		MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.06, 0.05, 0.08)), MeshKit.mat_color(Color(0.86, 0.62, 0.12), 0.32, 0.35), "Run", Vector3(2.58, 1.55, sx * 0.92))
		MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.28, 0.12, 0.08)), MeshKit.mat_color(Color(0.16, 0.16, 0.18), 0.55), "Vent", Vector3(0.85, 2.62, sx * 1.02))
	var hk := Label3D.new()
	hk.text = "HIDDEN K"
	hk.font_size = 36
	hk.modulate = Color(0.14, 0.22, 0.38)
	hk.outline_modulate = Color(0.92, 0.90, 0.84)
	hk.outline_size = 4
	hk.position = Vector3(0.15, 1.85, 1.06)
	t.add_child(hk)
	var chock := MeshKit.mat_color(Color(0.18, 0.12, 0.08), 0.62)
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.22, 0.10, 0.16)), chock, "ChockL", Vector3(0.72, 0.06, 1.28))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.22, 0.10, 0.16)), chock, "ChockR", Vector3(-0.72, 0.06, 1.28))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.85, 0.06, 0.42)), MeshKit.mat_color(Color(0.16, 0.20, 0.38), 0.52), "TrailerRug", Vector3(2.05, 0.85, 0.0), Vector3(0.0, 0.0, 0.22))

	var barrow := Node3D.new()
	barrow.name = "Barrow"
	barrow.position = Vector3(19.2, 0.0, 9.4)
	barrow.rotation_degrees = Vector3(0, -28, 0)
	barn.add_child(barrow)
	var green := MeshKit.mat_color(Color(0.18, 0.32, 0.16), 0.55)
	MeshKit.add_child_mi(barrow, MeshKit.box(Vector3(0.85, 0.28, 0.62)), green, "Tray", Vector3(0, 0.38, 0), Vector3(0.12, 0, 0))
	MeshKit.add_child_mi(barrow, MeshKit.cyl(0.16, 0.08, 0.16, 10), rubber, "BWheel", Vector3(0.42, 0.16, 0), Vector3(0, 0, 1.57))
	MeshKit.add_rod(barrow, MeshKit.mat_color(Color(0.22, 0.16, 0.10), 0.6), "HandleL", Vector3(-0.18, 0.42, 0.22), Vector3(-0.72, 0.58, 0.22), 0.012)
	MeshKit.add_rod(barrow, MeshKit.mat_color(Color(0.22, 0.16, 0.10), 0.6), "HandleR", Vector3(-0.18, 0.42, -0.22), Vector3(-0.72, 0.58, -0.22), 0.012)
	MeshKit.add_child_mi(barrow, MeshKit.box(Vector3(0.55, 0.22, 0.42)), MeshKit.mat_color(Color(0.64, 0.50, 0.22), 0.84), "Load", Vector3(0.04, 0.58, 0))
	var dung := MeshKit.mat_color(Color(0.28, 0.20, 0.10), 0.90)
	MeshKit.add_child_mi(barn, MeshKit.sphere(0.72, 8, 10), dung, "Manure", Vector3(21.4, 0.28, 8.2)).scale = Vector3(1.35, 0.55, 1.15)
	MeshKit.add_child_mi(barn, MeshKit.sphere(0.48, 7, 8), dung, "Manure2", Vector3(20.7, 0.22, 8.7)).scale = Vector3(1.20, 0.48, 1.05)
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(1.15, 0.08, 1.6)), MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.72, Color(0.42, 0.30, 0.16)), "DungBoard", Vector3(21.2, 0.08, 8.4))
	var feed := MeshKit.mat_color(Color(0.62, 0.18, 0.14), 0.62)
	var feed2 := MeshKit.mat_color(Color(0.22, 0.28, 0.18), 0.64)
	var feed3 := MeshKit.mat_color(Color(0.72, 0.58, 0.22), 0.60)
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.42, 0.58, 0.22)), feed, "FeedBag", Vector3(10.95, 0.30, 6.55), Vector3(0.08, 0.12, 0.05))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.42, 0.58, 0.22)), feed2, "FeedBag2", Vector3(11.14, 0.30, 6.64), Vector3(0.10, 0.22, 0.04))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.42, 0.58, 0.22)), feed3, "FeedBag3", Vector3(11.32, 0.30, 6.72), Vector3(0.06, 0.08, 0.06))
	MeshKit.add_child_mi(barn, MeshKit.cyl(0.22, 0.48, 0.20, 12), MeshKit.mat_color(Color(0.42, 0.40, 0.36), 0.38, 0.45), "FeedCan", Vector3(11.55, 0.26, 6.15))
	MeshKit.add_child_mi(barn, MeshKit.cyl(0.24, 0.04, 0.24, 12), MeshKit.steel(), "FeedLid", Vector3(11.55, 0.52, 6.15))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.04, 0.28, 0.08)), MeshKit.steel(), "Scoop", Vector3(11.72, 0.58, 6.22), Vector3(0.35, 0.20, 0.15))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.12, 0.06, 0.10)), MeshKit.steel(), "ScoopBowl", Vector3(11.82, 0.48, 6.28), Vector3(0.35, 0.20, 0.15))
	MeshKit.add_child_mi(barn, MeshKit.sphere(0.07, 6, 6), MeshKit.mat_color(Color(0.72, 0.52, 0.22), 0.82), "GrainSpill", Vector3(11.68, 0.06, 6.28)).scale = Vector3(1.85, 0.32, 1.42)
	var fl := Label3D.new()
	fl.text = "SWEET FEED"
	fl.font_size = 18
	fl.modulate = Color(0.92, 0.88, 0.72)
	fl.position = Vector3(10.96, 0.42, 6.67)
	fl.rotation = Vector3(0.08, 0.12, 0.05)
	barn.add_child(fl)
	# Line on the lean-to: cooler and pad drying. You photograph this.
	var line := MeshKit.mat_color(Color(0.18, 0.16, 0.14), 0.55)
	MeshKit.add_rod(barn, line, "DryLine", Vector3(10.62, 2.12, -0.6), Vector3(10.62, 2.12, 5.4), 0.005)
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.72, 0.92, 0.04)), MeshKit.cooler_wool(), "LineCooler", Vector3(10.78, 1.62, 1.35), Vector3(0.08, 0, 0))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.55, 0.62, 0.03)), MeshKit.pad_fabric(), "LinePad", Vector3(10.74, 1.72, 3.55), Vector3(0.12, 0, 0))
	MeshKit.add_child_mi(barn, MeshKit.box(Vector3(0.18, 0.32, 0.04)), MeshKit.mat_color(Color(0.16, 0.22, 0.38), 0.55), "LineWraps", Vector3(10.70, 1.82, 4.85))


func _school_yard() -> void:
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.68, Color(0.78, 0.70, 0.52))
	var white := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.62, Color(0.93, 0.91, 0.84))
	var x := RING_W * 0.5 + 3.6
	var pile := Node3D.new()
	pile.name = "SchoolYard"
	pile.position = Vector3(x + 2.2, 0, -14.0)
	add_child(pile)
	for i in range(3):
		MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.11, 1.42, 0.11)), white, "Std", Vector3(float(i) * 0.55, 0.71, 0.0))
		MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.055, 0.95, 0.55)), wood, "Wing", Vector3(float(i) * 0.55, 0.55, 0.22))
	var steel := MeshKit.steel()
	for i in range(3):
		MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.10, 0.05, 0.12)), steel, "Cup", Vector3(float(i) * 0.55, 0.92, 0.06))
	MeshKit.add_child_mi(pile, MeshKit.cyl(0.04, 3.0, 0.04, 10), white, "Poles", Vector3(0.9, 0.08, 0.55), Vector3(0, 0, 1.57))
	MeshKit.add_child_mi(pile, MeshKit.cyl(0.04, 3.0, 0.04, 10), MeshKit.mat_tex("res://assets/textures/pole_navy_albedo.jpg", 0.48), "Poles2", Vector3(0.9, 0.16, 0.62), Vector3(0, 0, 1.57))
	MeshKit.add_child_mi(pile, MeshKit.cyl(0.04, 3.0, 0.04, 10), MeshKit.mat_color(Color(0.72, 0.18, 0.16), 0.48), "Poles3", Vector3(0.9, 0.24, 0.70), Vector3(0, 0, 1.57))
	var cup_rust := MeshKit.mat_color(Color(0.52, 0.38, 0.22), 0.42)
	for i: int in range(5):
		MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.10, 0.05, 0.12)), cup_rust if i % 2 == 0 else steel, "LooseCup", Vector3(-0.85 + float(i) * 0.14, 0.03, 0.88), Vector3(0.0, float(i) * 0.4, 0.15))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.22, 0.28, 0.02)), MeshKit.mat_color(Color(0.92, 0.90, 0.82), 0.55), "NumCard", Vector3(1.55, 0.16, 0.42), Vector3(0.2, 0.35, 0.0))
	var nlab := Label3D.new()
	nlab.text = "4"
	nlab.font_size = 36
	nlab.modulate = Color(0.12, 0.10, 0.08)
	nlab.position = Vector3(1.56, 0.18, 0.44)
	nlab.rotation = Vector3(0.2, 0.35, 0.0)
	pile.add_child(nlab)
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(1.6, 0.08, 0.08)), wood, "Hitch", Vector3(-0.4, 1.05, 2.4))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.10, 1.12, 0.10)), wood, "HitchL", Vector3(-1.15, 0.56, 2.4))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.10, 1.12, 0.10)), wood, "HitchR", Vector3(0.35, 0.56, 2.4))
	var hitch_dirt := MeshKit.mat_tex("res://assets/textures/sand_albedo.jpg", 0.94, Color(0.34, 0.26, 0.16))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(2.35, 0.028, 1.55)), hitch_dirt, "HitchWear", Vector3(-0.40, 0.014, 2.40))
	var hitch_wet := MeshKit.mat_color(Color(0.32, 0.36, 0.30), 0.10, 0.20)
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.85, 0.010, 0.55)), hitch_wet, "HitchPuddle", Vector3(0.42, 0.022, 2.52))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.32, 0.22, 0.32)), MeshKit.mat_color(Color(0.18, 0.16, 0.14), 0.55), "HitchPail", Vector3(0.72, 0.14, 2.05))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.26, 0.02, 0.26)), MeshKit.mat_color(Color(0.22, 0.38, 0.36), 0.12, 0.18), "HitchPailW", Vector3(0.72, 0.26, 2.05))
	var lead := MeshKit.leather(Color(0.22, 0.14, 0.08), 0.58)
	for i in range(4):
		MeshKit.add_child_mi(pile, MeshKit.torus(0.055, 0.078, 10, 8), lead, "LeadCoil", Vector3(-1.02, 0.96 - float(i) * 0.018, 2.28), Vector3(1.42, 0.18, 0.12))
	MeshKit.add_rod(pile, lead, "LeadHang", Vector3(-1.02, 0.88, 2.28), Vector3(-1.02, 0.42, 2.18), 0.006)
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.028, 0.055, 0.016)), steel, "LeadSnap", Vector3(-1.02, 0.38, 2.16))
	for sx: float in [-1.15, 0.35]:
		MeshKit.add_child_mi(pile, MeshKit.torus(0.016, 0.028, 8, 6), steel, "TieRing", Vector3(sx, 0.98, 2.46), Vector3(1.57, 0.0, 0.0))
		MeshKit.add_rod(pile, MeshKit.leather(Color(0.18, 0.12, 0.08), 0.62), "Tie", Vector3(sx, 0.98, 2.46), Vector3(sx + 0.08, 0.52, 2.62), 0.005)
	for i in range(4):
		var cz := 3.6 + float(i) * 1.15
		MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.10, 0.42, 0.10)), wood, "CavL", Vector3(-0.85, 0.21, cz))
		MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.10, 0.42, 0.10)), wood, "CavR", Vector3(0.85, 0.21, cz))
		MeshKit.add_child_mi(pile, MeshKit.cyl(0.035, 1.85, 0.035, 8), white, "CavPole", Vector3(0.0, 0.38 + (0.08 if i % 2 == 0 else 0.0), cz), Vector3(0, 0, 1.57))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.72, 0.48, 0.42)), MeshKit.mat_color(Color(0.28, 0.18, 0.10), 0.55), "Trunk", Vector3(-1.85, 0.25, 1.6))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.68, 0.04, 0.38)), MeshKit.mat_color(Color(0.18, 0.12, 0.08), 0.48), "TrunkLid", Vector3(-1.85, 0.50, 1.6))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.42, 0.38, 0.42)), MeshKit.mat_color(Color(0.16, 0.22, 0.38), 0.42), "Cooler", Vector3(-1.85, 0.20, 2.35))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.38, 0.04, 0.38)), MeshKit.mat_color(Color(0.86, 0.86, 0.84), 0.48), "CoolerLid", Vector3(-1.85, 0.40, 2.35))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.32, 0.28, 0.32)), MeshKit.mat_color(Color(0.18, 0.16, 0.14), 0.55), "Bucket", Vector3(0.55, 0.15, 2.55))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.26, 0.02, 0.26)), MeshKit.mat_color(Color(0.22, 0.38, 0.36), 0.12, 0.18), "Water", Vector3(0.55, 0.28, 2.55))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(1.05, 0.06, 0.48)), MeshKit.mat_color(Color(0.18, 0.22, 0.42), 0.52), "Rug", Vector3(-0.40, 1.12, 2.40))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.22, 0.16, 0.48)), MeshKit.mat_color(Color(0.18, 0.22, 0.42), 0.52), "RugFold", Vector3(-0.88, 1.08, 2.40))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.28, 0.22, 0.22)), MeshKit.mat_color(Color(0.08, 0.08, 0.10), 0.55), "HelmBag", Vector3(0.22, 1.28, 2.40))
	MeshKit.add_child_mi(pile, MeshKit.sphere(0.10, 8, 10), MeshKit.mat_color(Color(0.04, 0.04, 0.05), 0.82), "CapOnBag", Vector3(0.22, 1.42, 2.40)).scale = Vector3(1.05, 0.42, 1.08)
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.28, 0.16, 0.22)), MeshKit.mat_color(Color(0.86, 0.84, 0.72), 0.72), "SaltBlock", Vector3(-1.12, 0.10, 2.72))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.32, 0.04, 0.26)), MeshKit.mat_color(Color(0.62, 0.48, 0.22), 0.88), "HayFlake", Vector3(-0.18, 0.04, 2.88), Vector3(0.0, 0.35, 0.0))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.38, 0.05, 0.22)), MeshKit.mat_color(Color(0.68, 0.52, 0.26), 0.88), "HayFlake2", Vector3(-0.12, 0.08, 2.95), Vector3(0.0, -0.22, 0.0))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.22, 0.18, 0.02)), MeshKit.mat_color(Color(0.22, 0.28, 0.18), 0.42), "FlyMask", Vector3(-0.62, 1.18, 2.52), Vector3(0.15, 0.0, 0.0))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.10, 0.04, 0.08)), MeshKit.mat_color(Color(0.72, 0.18, 0.14), 0.48), "FlyEarL", Vector3(-0.68, 1.28, 2.52))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.10, 0.04, 0.08)), MeshKit.mat_color(Color(0.72, 0.18, 0.14), 0.48), "FlyEarR", Vector3(-0.56, 1.28, 2.52))
	var lunge := MeshKit.mat_color(Color(0.72, 0.18, 0.14), 0.55)
	for i in range(5):
		MeshKit.add_child_mi(pile, MeshKit.torus(0.072, 0.098, 10, 8), lunge, "LungeCoil", Vector3(0.55, 1.08 - float(i) * 0.016, 2.28), Vector3(1.45, 0.12, 0.08))
	MeshKit.add_rod(pile, lunge, "LungeHang", Vector3(0.55, 1.00, 2.28), Vector3(0.55, 0.38, 2.18), 0.006)
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.018, 0.92, 0.018)), MeshKit.mat_color(Color(0.18, 0.12, 0.08), 0.55), "Whip", Vector3(0.72, 0.62, 2.35), Vector3(0.22, 0.0, 0.08))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.028, 0.08, 0.022)), MeshKit.mat_color(Color(0.12, 0.08, 0.06), 0.48), "WhipKeep", Vector3(0.68, 1.05, 2.38))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.22, 0.012, 0.06)), MeshKit.mat_color(Color(0.72, 0.72, 0.74), 0.22, 0.45), "Scraper", Vector3(-0.55, 1.08, 2.42), Vector3(0.0, 0.35, 0.0))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.08, 0.04, 0.016)), MeshKit.mat_color(Color(0.18, 0.12, 0.08), 0.55), "ScraperH", Vector3(-0.68, 1.08, 2.42))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.08, 0.05, 0.08)), MeshKit.mat_color(Color(0.18, 0.22, 0.38), 0.48), "Curry", Vector3(-1.42, 0.54, 1.72))
	var rust := MeshKit.mat_color(Color(0.42, 0.22, 0.12), 0.38)
	var barrow_steel := MeshKit.steel()
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.92, 0.12, 0.58)), rust, "BarrowTub", Vector3(1.35, 0.42, 2.85), Vector3(0.12, 0.22, 0.0))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.88, 0.08, 0.08)), rust, "BarrowLip", Vector3(1.35, 0.50, 2.85), Vector3(0.12, 0.22, 0.0))
	MeshKit.add_child_mi(pile, MeshKit.cyl(0.14, 0.06, 0.14, 10), MeshKit.mat_color(Color(0.12, 0.10, 0.08), 0.62), "BarrowWheel", Vector3(1.78, 0.18, 2.62), Vector3(0.0, 0.0, 1.57))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.04, 0.04, 0.72)), barrow_steel, "BarrowArmL", Vector3(0.98, 0.38, 3.12), Vector3(0.08, 0.35, 0.0))
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.04, 0.04, 0.72)), barrow_steel, "BarrowArmR", Vector3(1.22, 0.38, 3.12), Vector3(0.08, 0.35, 0.0))
	var dung := MeshKit.mat_color(Color(0.28, 0.20, 0.10), 0.88)
	MeshKit.add_child_mi(pile, MeshKit.sphere(0.22, 7, 8), dung, "Manure", Vector3(1.32, 0.22, 2.22)).scale = Vector3(1.35, 0.62, 1.18)
	MeshKit.add_child_mi(pile, MeshKit.sphere(0.14, 6, 8), dung, "Manure2", Vector3(1.48, 0.16, 2.08)).scale = Vector3(1.10, 0.55, 0.95)
	MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.018, 0.92, 0.018)), MeshKit.mat_color(Color(0.22, 0.14, 0.08), 0.55), "ForkHandle", Vector3(1.62, 0.58, 2.42), Vector3(0.35, 0.0, 0.12))
	for i: int in range(4):
		MeshKit.add_child_mi(pile, MeshKit.box(Vector3(0.008, 0.16, 0.008)), barrow_steel, "ForkTine", Vector3(1.78 + float(i) * 0.022, 0.18, 2.28), Vector3(0.85, 0.0, 0.10))
	var banner := Label3D.new()
	banner.text = "HIDDEN K  ·  SCHOOLING"
	banner.font_size = 42
	banner.modulate = Color(0.96, 0.93, 0.86)
	banner.outline_modulate = Color(0.08, 0.06, 0.04)
	banner.outline_size = 6
	banner.position = Vector3(RING_W * 0.5 + 0.22, 2.05, -8.0)
	banner.rotation.y = -PI * 0.5
	add_child(banner)


func _grounds() -> void:
	var gravel := MeshKit.gravel()
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(38.0, 0.05, 42.0)), gravel, "BarnYard", Vector3(-78.0, -0.24, -48.0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(22.0, 0.05, 16.0)), gravel, "HouseDrive", Vector3(54.0, -0.24, -44.0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(48.0, 0.05, 5.2)), gravel, "Drive", Vector3(-28.0, -0.24, -52.0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(54.0, 0.05, 4.6)), gravel, "Drive2", Vector3(22.0, -0.24, -50.0), Vector3(0, 0.08, 0))
	var worn := MeshKit.mat_tex("res://assets/textures/sand_albedo.jpg", 0.94, Color(0.40, 0.32, 0.20))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(8.5, 0.04, 3.2)), worn, "DriveWear", Vector3(-6.0, -0.23, -51.2))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(6.2, 0.04, 2.8)), worn, "DriveWear2", Vector3(36.0, -0.23, -49.4))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(11.0, 0.04, 2.4)), worn, "DriveWear3", Vector3(12.0, -0.23, -50.2))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(4.2, 0.03, 3.6)), worn, "YardWear", Vector3(-72.0, -0.22, -56.4))
	var puddle := MeshKit.mat_color(Color(0.32, 0.36, 0.30), 0.10, 0.22)
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(1.85, 0.012, 1.15)), puddle, "DrivePuddle", Vector3(-4.2, -0.205, -51.6))
	var track := MeshKit.mat_tex("res://assets/textures/sand_albedo.jpg", 0.92, Color(0.38, 0.32, 0.20))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(3.4, 0.04, 28.0)), track, "Track", Vector3(-16.0, -0.26, -28.0), Vector3(0, 0.18, 0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(2.6, 0.04, 18.0)), track, "Track2", Vector3(18.0, -0.26, -40.0), Vector3(0, -0.32, 0))
	var leaf := MeshKit.mat_color(Color(0.18, 0.32, 0.12), 0.86)
	var leaf2 := MeshKit.mat_color(Color(0.26, 0.40, 0.14), 0.84)
	var bloom := MeshKit.mat_color(Color(0.78, 0.24, 0.28), 0.50)
	var rng := RandomNumberGenerator.new()
	rng.seed = 44
	for i in range(18):
		var x := -22.0 - float(i) * 2.6 + rng.randf_range(-0.4, 0.4)
		var z := -54.0 + rng.randf_range(-1.2, 1.2)
		MeshKit.add_child_mi(self, MeshKit.sphere(rng.randf_range(0.55, 0.92), 8, 10), leaf if i % 2 == 0 else leaf2, "Hedge", Vector3(x, 0.55, z))
	for i in range(10):
		var hx := 48.0 + float(i) * 2.2 + rng.randf_range(-0.3, 0.3)
		var hz := -62.0 + rng.randf_range(-0.8, 0.8)
		MeshKit.add_child_mi(self, MeshKit.sphere(rng.randf_range(0.48, 0.78), 8, 10), leaf2 if i % 2 == 0 else leaf, "HouseHedge", Vector3(hx, 0.48, hz))
	var hw := RING_W * 0.5
	var hd := RING_D * 0.5
	for p in [Vector3(-hw + 1.2, 0, -hd + 1.2), Vector3(hw - 1.2, 0, -hd + 1.2), Vector3(-hw + 1.2, 0, hd - 1.2), Vector3(hw - 1.2, 0, hd - 1.2)]:
		MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.70, 0.24, 0.48)), leaf, "CornerBox", Vector3(p.x, 0.12, p.z))
		MeshKit.add_child_mi(self, MeshKit.sphere(0.11, 8, 10), bloom, "CornerBloom", Vector3(p.x, 0.32, p.z))
	_clock_booth()
	_farm_sign()
	_pickup()
	_ring_drag()
	_drive_gate()
	_property()


func _farm_sign() -> void:
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.64, Color(0.42, 0.28, 0.16))
	var white := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.58, Color(0.90, 0.86, 0.76))
	var s := Node3D.new()
	s.name = "FarmSign"
	s.position = Vector3(-22.0, 0.0, -58.5)
	s.rotation_degrees = Vector3(0, 12, 0)
	add_child(s)
	var stone := MeshKit.fieldstone()
	var leaf := MeshKit.mat_color(Color(0.18, 0.32, 0.12), 0.86)
	var bloom := MeshKit.mat_color(Color(0.78, 0.22, 0.26), 0.48)
	for x in [-1.15, 1.15]:
		MeshKit.add_child_mi(s, MeshKit.box(Vector3(0.12, 2.35, 0.12)), wood, "Post", Vector3(x, 1.18, 0))
		MeshKit.add_child_mi(s, MeshKit.box(Vector3(0.18, 0.06, 0.18)), wood, "PostCap", Vector3(x, 2.38, 0))
		MeshKit.add_child_mi(s, MeshKit.box(Vector3(0.38, 0.16, 0.38)), stone, "PostFoot", Vector3(x, 0.08, 0))
		for i in range(5):
			var vy := 0.28 + float(i) * 0.32
			MeshKit.add_child_mi(s, MeshKit.sphere(0.07, 6, 8), leaf, "Vine", Vector3(x + 0.08, vy, 0.08)).scale = Vector3(1.2, 0.7, 0.9)
			if i % 2 == 0:
				MeshKit.add_child_mi(s, MeshKit.sphere(0.038, 6, 8), bloom, "VineBloom", Vector3(x + 0.12, vy + 0.06, 0.10))
	MeshKit.add_child_mi(s, MeshKit.box(Vector3(2.55, 0.92, 0.08)), white, "Board", Vector3(0, 1.85, 0.02))
	MeshKit.add_child_mi(s, MeshKit.box(Vector3(2.62, 0.06, 0.10)), wood, "BoardCap", Vector3(0, 2.34, 0.02))
	MeshKit.add_child_mi(s, MeshKit.box(Vector3(0.42, 0.16, 0.10)), MeshKit.mat_color(Color(0.22, 0.16, 0.10), 0.48), "Horse", Vector3(0, 2.08, 0.08))
	MeshKit.add_child_mi(s, MeshKit.box(Vector3(0.14, 0.10, 0.08)), MeshKit.mat_color(Color(0.22, 0.16, 0.10), 0.48), "HorseHead", Vector3(0.26, 2.12, 0.08))
	MeshKit.add_child_mi(s, MeshKit.box(Vector3(1.15, 0.16, 0.28)), wood, "HangBox", Vector3(0, 1.22, 0.12))
	MeshKit.add_child_mi(s, MeshKit.box(Vector3(1.05, 0.05, 0.22)), MeshKit.mat_color(Color(0.26, 0.18, 0.11), 0.86), "HangSoil", Vector3(0, 1.32, 0.12))
	for i in range(5):
		var ox := (float(i) - 2.0) * 0.18
		MeshKit.add_child_mi(s, MeshKit.sphere(0.07, 6, 8), leaf, "HangLeaf", Vector3(ox, 1.40, 0.12))
		MeshKit.add_child_mi(s, MeshKit.sphere(0.038, 6, 8), bloom if i % 2 == 0 else MeshKit.mat_color(Color(0.92, 0.88, 0.82), 0.50), "HangBloom", Vector3(ox * 0.85, 1.48, 0.14))
	var lab := Label3D.new()
	lab.text = "HIDDEN K STABLES"
	lab.font_size = 40
	lab.modulate = Color(0.12, 0.08, 0.06)
	lab.position = Vector3(0, 1.78, 0.08)
	lab.billboard = BaseMaterial3D.BILLBOARD_DISABLED
	s.add_child(lab)
	var sub := Label3D.new()
	sub.text = "PFAFFTOWN  ·  NC"
	sub.font_size = 24
	sub.modulate = Color(0.22, 0.16, 0.10)
	sub.position = Vector3(0, 1.55, 0.08)
	s.add_child(sub)
	var worn := MeshKit.mat_tex("res://assets/textures/sand_albedo.jpg", 0.94, Color(0.36, 0.28, 0.16))
	MeshKit.add_child_mi(s, MeshKit.box(Vector3(3.4, 0.04, 1.85)), worn, "SignWear", Vector3(0, 0.02, 0.35))
	MeshKit.add_child_mi(s, MeshKit.box(Vector3(0.85, 0.03, 2.6)), worn, "SignPull", Vector3(0, 0.015, 1.4))
	for i in range(7):
		var vy := 0.22 + float(i) * 0.28
		MeshKit.add_child_mi(s, MeshKit.sphere(0.08, 6, 8), leaf, "Vine2", Vector3(-1.22, vy, 0.04)).scale = Vector3(1.35, 0.68, 1.05)
	MeshKit.add_child_mi(s, MeshKit.box(Vector3(0.72, 0.18, 0.06)), MeshKit.mat_color(Color(0.14, 0.20, 0.36), 0.48), "InArrow", Vector3(1.85, 1.22, 0.06))
	var inn := Label3D.new()
	inn.text = "IN"
	inn.font_size = 22
	inn.modulate = Color(0.96, 0.93, 0.86)
	inn.position = Vector3(1.85, 1.22, 0.10)
	s.add_child(inn)


func _drive_gate() -> void:
	# Open farm gate at the pull-in — you have arrived, not spawned on grass.
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.66, Color(0.70, 0.58, 0.38))
	var dark := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.70, Color(0.48, 0.36, 0.22))
	var steel := MeshKit.steel()
	var g := Node3D.new()
	g.name = "DriveGate"
	g.position = Vector3(-16.4, 0.0, -56.8)
	g.rotation_degrees = Vector3(0, 14, 0)
	add_child(g)
	MeshKit.add_child_mi(g, MeshKit.box(Vector3(0.16, 1.55, 0.16)), wood, "PostL", Vector3(-2.15, 0.78, 0))
	MeshKit.add_child_mi(g, MeshKit.box(Vector3(0.16, 1.55, 0.16)), wood, "PostR", Vector3(2.15, 0.78, 0))
	MeshKit.add_child_mi(g, MeshKit.box(Vector3(0.22, 0.06, 0.22)), wood, "CapL", Vector3(-2.15, 1.58, 0))
	MeshKit.add_child_mi(g, MeshKit.box(Vector3(0.22, 0.06, 0.22)), wood, "CapR", Vector3(2.15, 1.58, 0))
	var leaf := Node3D.new()
	leaf.name = "Leaf"
	leaf.position = Vector3(-2.05, 0.0, 0.0)
	leaf.rotation_degrees = Vector3(0, -38, 0)
	g.add_child(leaf)
	MeshKit.add_child_mi(leaf, MeshKit.box(Vector3(2.05, 0.08, 0.07)), wood, "RailT", Vector3(1.05, 1.22, 0))
	MeshKit.add_child_mi(leaf, MeshKit.box(Vector3(2.05, 0.08, 0.07)), wood, "RailM", Vector3(1.05, 0.78, 0))
	MeshKit.add_child_mi(leaf, MeshKit.box(Vector3(2.05, 0.08, 0.07)), wood, "RailB", Vector3(1.05, 0.36, 0))
	for i in range(5):
		MeshKit.add_child_mi(leaf, MeshKit.box(Vector3(0.06, 1.05, 0.05)), dark if i % 2 == 0 else wood, "Slat", Vector3(0.22 + float(i) * 0.42, 0.78, 0))
	MeshKit.add_child_mi(leaf, MeshKit.box(Vector3(0.08, 0.12, 0.06)), steel, "HingeT", Vector3(0.04, 1.18, 0.06))
	MeshKit.add_child_mi(leaf, MeshKit.box(Vector3(0.08, 0.12, 0.06)), steel, "HingeB", Vector3(0.04, 0.42, 0.06))
	MeshKit.add_child_mi(g, MeshKit.box(Vector3(0.10, 0.22, 0.06)), steel, "Latch", Vector3(2.08, 0.82, 0.08))
	var lab := Label3D.new()
	lab.text = "HIDDEN K"
	lab.font_size = 22
	lab.modulate = Color(0.16, 0.12, 0.08)
	lab.position = Vector3(-0.55, 1.05, 0.12)
	leaf.add_child(lab)
	var worn := MeshKit.mat_tex("res://assets/textures/sand_albedo.jpg", 0.94, Color(0.36, 0.28, 0.16))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(5.4, 0.03, 3.2)), worn, "GateWear", Vector3(-16.2, 0.015, -56.4))
	var box := Node3D.new()
	box.name = "RoadBox"
	box.position = Vector3(-19.6, 0.0, -57.8)
	box.rotation_degrees = Vector3(0, 18, 0)
	add_child(box)
	MeshKit.add_child_mi(box, MeshKit.box(Vector3(0.08, 1.12, 0.08)), wood, "BoxPost", Vector3(0, 0.56, 0))
	MeshKit.add_child_mi(box, MeshKit.box(Vector3(0.42, 0.22, 0.20)), MeshKit.mat_color(Color(0.14, 0.22, 0.38), 0.42), "Box", Vector3(0, 1.18, 0))
	MeshKit.add_child_mi(box, MeshKit.box(Vector3(0.44, 0.04, 0.22)), MeshKit.mat_color(Color(0.10, 0.16, 0.28), 0.48), "BoxLid", Vector3(0, 1.30, 0.02), Vector3(0.22, 0, 0))
	MeshKit.add_child_mi(box, MeshKit.box(Vector3(0.06, 0.16, 0.012)), MeshKit.mat_color(Color(0.78, 0.16, 0.12), 0.42), "BoxFlag", Vector3(0.22, 1.28, 0.0), Vector3(0, 0, 0.35))
	MeshKit.add_child_mi(box, MeshKit.box(Vector3(0.18, 0.012, 0.12)), MeshKit.mat_color(Color(0.88, 0.84, 0.74), 0.62), "Paper", Vector3(0.02, 1.22, 0.08), Vector3(0.15, 0.4, 0.08))
	MeshKit.add_child_mi(box, MeshKit.box(Vector3(0.14, 0.04, 0.18)), MeshKit.mat_color(Color(0.72, 0.18, 0.14), 0.55), "Catalog", Vector3(0.04, 1.21, 0.04), Vector3(0.25, 0.2, 0.12))
	MeshKit.add_child_mi(box, MeshKit.box(Vector3(0.22, 0.008, 0.16)), MeshKit.mat_color(Color(0.86, 0.82, 0.72), 0.68), "Paper2", Vector3(0.28, 0.012, 0.22), Vector3(0.0, 0.55, 0.0))
	var hk := Label3D.new()
	hk.text = "HIDDEN K"
	hk.font_size = 14
	hk.modulate = Color(0.92, 0.88, 0.78)
	hk.position = Vector3(0, 1.18, 0.11)
	box.add_child(hk)


func _ring_drag() -> void:
	# Parked outside the boards — someone raked this morning.
	var steel := MeshKit.steel()
	var rust := MeshKit.mat_color(Color(0.42, 0.28, 0.14), 0.55)
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.68, Color(0.42, 0.30, 0.16))
	var d := Node3D.new()
	d.name = "RingDrag"
	d.position = Vector3(RING_W * 0.5 + 4.8, 0.0, -22.4)
	d.rotation_degrees = Vector3(0, -18, 0)
	add_child(d)
	MeshKit.add_child_mi(d, MeshKit.box(Vector3(1.85, 0.08, 0.08)), rust, "FrameF", Vector3(0, 0.28, 0.55))
	MeshKit.add_child_mi(d, MeshKit.box(Vector3(1.85, 0.08, 0.08)), rust, "FrameB", Vector3(0, 0.28, -0.55))
	MeshKit.add_child_mi(d, MeshKit.box(Vector3(0.08, 0.08, 1.18)), rust, "FrameL", Vector3(-0.88, 0.28, 0))
	MeshKit.add_child_mi(d, MeshKit.box(Vector3(0.08, 0.08, 1.18)), rust, "FrameR", Vector3(0.88, 0.28, 0))
	for i in range(9):
		var x := -0.80 + float(i) * 0.20
		MeshKit.add_child_mi(d, MeshKit.box(Vector3(0.018, 0.22, 0.018)), steel, "Tine", Vector3(x, 0.12, 0.22))
		MeshKit.add_child_mi(d, MeshKit.box(Vector3(0.018, 0.22, 0.018)), steel, "Tine2", Vector3(x, 0.12, -0.22))
	MeshKit.add_child_mi(d, MeshKit.box(Vector3(0.06, 0.06, 1.35)), wood, "Tongue", Vector3(0, 0.42, 1.15), Vector3(0.18, 0, 0))
	MeshKit.add_child_mi(d, MeshKit.box(Vector3(0.42, 0.08, 0.08)), wood, "Hitch", Vector3(0, 0.62, 1.78))
	MeshKit.add_child_mi(d, MeshKit.cyl(0.14, 0.08, 0.14, 10), MeshKit.mat_color(Color(0.10, 0.10, 0.11), 0.80), "WheelL", Vector3(-0.95, 0.16, 0.0), Vector3(0, 0, 1.57))
	MeshKit.add_child_mi(d, MeshKit.cyl(0.14, 0.08, 0.14, 10), MeshKit.mat_color(Color(0.10, 0.10, 0.11), 0.80), "WheelR", Vector3(0.95, 0.16, 0.0), Vector3(0, 0, 1.57))
	var worn := MeshKit.mat_tex("res://assets/textures/sand_albedo.jpg", 0.94, Color(0.38, 0.30, 0.18))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(2.6, 0.03, 2.2)), worn, "DragWear", Vector3(RING_W * 0.5 + 4.8, 0.015, -22.4))


func _pickup() -> void:
	# Dusty farm truck on the house gravel — someone is here, not a vacant lot.
	var body := MeshKit.mat_color(Color(0.14, 0.22, 0.16), 0.42)
	var cab := MeshKit.mat_color(Color(0.12, 0.18, 0.14), 0.40)
	var glass := MeshKit.mat_color(Color(0.16, 0.20, 0.24), 0.10, 0.28)
	var black := MeshKit.mat_color(Color(0.08, 0.08, 0.09), 0.52)
	var chrome := MeshKit.mat_color(Color(0.62, 0.64, 0.66), 0.22, 0.55)
	var rubber := MeshKit.mat_color(Color(0.10, 0.10, 0.11), 0.80)
	var steel := MeshKit.steel()
	var t := Node3D.new()
	t.name = "Pickup"
	t.position = Vector3(50.8, 0.0, -46.2)
	t.rotation_degrees = Vector3(0, 22, 0)
	add_child(t)
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(5.15, 0.18, 1.85)), black, "Frame", Vector3(0, 0.42, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(2.05, 0.72, 1.78)), body, "Bed", Vector3(1.42, 0.92, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(1.92, 0.06, 1.68)), MeshKit.mat_color(Color(0.22, 0.18, 0.12), 0.72), "BedFloor", Vector3(1.42, 0.58, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.08, 0.42, 1.68)), body, "Tailgate", Vector3(2.42, 0.88, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(2.05, 1.05, 1.82)), cab, "Cab", Vector3(-1.35, 1.28, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(1.05, 0.42, 1.78)), body, "Hood", Vector3(-2.55, 0.92, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.88, 0.38, 1.68)), glass, "Wind", Vector3(-1.05, 1.58, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.72, 0.32, 0.06)), glass, "SideL", Vector3(-1.35, 1.42, 0.94))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.72, 0.32, 0.06)), glass, "SideR", Vector3(-1.35, 1.42, -0.94))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.18, 0.22, 1.72)), chrome, "Grill", Vector3(-3.10, 0.78, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.12, 0.10, 0.28)), MeshKit.mat_color(Color(0.92, 0.86, 0.62), 0.22, 0.55), "HeadL", Vector3(-3.12, 0.72, 0.62))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.12, 0.10, 0.28)), MeshKit.mat_color(Color(0.92, 0.86, 0.62), 0.22, 0.55), "HeadR", Vector3(-3.12, 0.72, -0.62))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.10, 0.08, 0.22)), MeshKit.mat_color(Color(0.72, 0.12, 0.10), 0.42), "TailL", Vector3(2.48, 0.82, 0.68))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.10, 0.08, 0.22)), MeshKit.mat_color(Color(0.72, 0.12, 0.10), 0.42), "TailR", Vector3(2.48, 0.82, -0.68))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.08, 0.06, 0.22)), MeshKit.mat_color(Color(0.88, 0.86, 0.78), 0.48), "Plate", Vector3(2.50, 0.52, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.85, 0.22, 0.38)), MeshKit.mat_color(Color(0.28, 0.26, 0.24), 0.55), "Toolbox", Vector3(0.55, 1.18, 0))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.72, 0.28, 0.48)), MeshKit.hay(), "BedHay", Vector3(1.72, 0.78, 0.18))
	MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.42, 0.18, 0.32)), MeshKit.mat_color(Color(0.18, 0.16, 0.14), 0.55), "BedBucket", Vector3(1.55, 0.72, -0.48))
	for sx: float in [-1.0, 1.0]:
		MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.85, 0.08, 0.28)), black, "FenderF", Vector3(-2.15, 0.58, sx * 0.98))
		MeshKit.add_child_mi(t, MeshKit.box(Vector3(0.85, 0.08, 0.28)), black, "FenderR", Vector3(1.15, 0.58, sx * 0.98))
		for wx: float in [-2.15, 1.15]:
			MeshKit.add_child_mi(t, MeshKit.cyl(0.32, 0.22, 0.32, 14), rubber, "Wheel", Vector3(wx, 0.32, sx * 0.95), Vector3(0, 0, 1.57))
			MeshKit.add_child_mi(t, MeshKit.cyl(0.12, 0.08, 0.12, 8), steel, "Hub", Vector3(wx, 0.32, sx * 1.04), Vector3(0, 0, 1.57))
	var plate := Label3D.new()
	plate.text = "HK-1"
	plate.font_size = 18
	plate.modulate = Color(0.14, 0.16, 0.22)
	plate.position = Vector3(2.52, 0.52, 0)
	plate.rotation.y = PI * 0.5
	t.add_child(plate)
	var worn := MeshKit.mat_tex("res://assets/textures/sand_albedo.jpg", 0.94, Color(0.36, 0.28, 0.16))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(6.2, 0.03, 3.4)), worn, "TruckWear", Vector3(50.6, -0.22, -46.0))


func _property() -> void:
	# Four-board oak around the ring and down the drive so barn, house, and
	# sand sit on one farm — not three objects on a green sheet.
	_board_run(Vector3(-23.4, 0, -40.5), Vector3(-23.4, 0, 40.5))
	_board_run(Vector3(27.2, 0, -40.5), Vector3(27.2, 0, 40.5))
	_board_run(Vector3(-23.4, 0, 40.5), Vector3(27.2, 0, 40.5))
	_board_run(Vector3(-23.4, 0, -40.5), Vector3(-23.4, 0, -56.0))
	_board_run(Vector3(-23.4, 0, -56.0), Vector3(-70.0, 0, -61.0))
	_board_run(Vector3(-18.0, 0, -61.5), Vector3(48.0, 0, -66.0))
	_board_run(Vector3(48.0, 0, -66.0), Vector3(58.0, 0, -56.0))
	_board_run(Vector3(-70.0, 0, -43.5), Vector3(-28.0, 0, -43.5))
	_swales()
	_shade_trees()
	_windbreak()


func _board_run(a: Vector3, b: Vector3) -> void:
	var rail := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.68, Color(0.76, 0.66, 0.48))
	var post := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.64, Color(0.70, 0.60, 0.42))
	var cap := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.58, Color(0.58, 0.46, 0.30))
	var dir := b - a
	var len := dir.length()
	if len < 0.6:
		return
	var mid := (a + b) * 0.5
	var yaw := atan2(dir.x, dir.z)
	for y in [0.26, 0.54, 0.82, 1.10]:
		MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.055, 0.065, len)), rail, "FarmRail", Vector3(mid.x, y, mid.z), Vector3(0, yaw, 0))
	var npost := int(len / 2.75) + 1
	for i in range(npost + 1):
		var t := float(i) / float(npost)
		var p := a.lerp(b, t)
		MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.12, 1.32, 0.12)), post, "FarmPost", Vector3(p.x, 0.66, p.z))
		MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.16, 0.05, 0.16)), cap, "FarmCap", Vector3(p.x, 1.34, p.z))


func _swales() -> void:
	var sod := MeshKit.grass_material()
	var specs := [
		[Vector3(-32.0, -0.10, -8.0), Vector3(4.2, 0.22, 2.8)],
		[Vector3(-34.0, -0.12, 14.0), Vector3(3.6, 0.18, 3.2)],
		[Vector3(34.0, -0.11, 6.0), Vector3(3.8, 0.20, 2.6)],
		[Vector3(36.0, -0.10, 22.0), Vector3(3.2, 0.16, 2.4)],
		[Vector3(-40.0, -0.12, -32.0), Vector3(4.8, 0.20, 2.2)],
		[Vector3(42.0, -0.11, -28.0), Vector3(3.4, 0.18, 2.0)],
		[Vector3(-28.0, -0.10, 32.0), Vector3(3.6, 0.17, 2.6)],
		[Vector3(12.0, -0.12, 48.0), Vector3(5.2, 0.16, 2.4)],
		[Vector3(-48.0, -0.11, -8.0), Vector3(3.0, 0.20, 3.4)],
		[Vector3(-12.0, -0.10, 52.0), Vector3(4.4, 0.15, 2.2)],
	]
	for s in specs:
		var mi := MeshKit.add_child_mi(self, MeshKit.sphere(1.0, 10, 14), sod, "Swale")
		mi.position = s[0]
		mi.scale = s[1]


func _shade_trees() -> void:
	var spots := [
		Vector3(-28.0, 0, -8.0),
		Vector3(-29.0, 0, 16.0),
		Vector3(-27.0, 0, 34.0),
		Vector3(32.0, 0, 8.0),
		Vector3(33.0, 0, 28.0),
		Vector3(31.0, 0, -36.0),
		Vector3(-42.0, 0, -36.0),
		Vector3(46.0, 0, -28.0),
		Vector3(-54.0, 0, -16.0),
		Vector3(8.0, 0, 56.0),
		Vector3(-10.0, 0, -58.0),
		Vector3(8.0, 0, -58.0),
		Vector3(24.0, 0, -58.0),
		Vector3(40.0, 0, -58.0),
	]
	var bark := MeshKit.pine_bark()
	var hardwood := MeshKit.hardwood_material(false)
	var hardwood2 := MeshKit.hardwood_material(true)
	for i in range(spots.size()):
		var p: Vector3 = spots[i]
		if _in_keepout(p.x, p.z):
			continue
		var t := Node3D.new()
		t.name = "Shade"
		t.position = p
		t.rotation.y = float(i) * 0.7
		add_child(t)
		var h := 13.0 + float(i % 3) * 1.6
		var rng := RandomNumberGenerator.new()
		rng.seed = 40 + i * 17
		_oak_plant(t, h, bark, hardwood, hardwood2, rng)


func _windbreak() -> void:
	var bark := MeshKit.pine_bark()
	var pine := MeshKit.pine_material()
	var xs: Array[float] = []
	var x := -96.0
	while x < 88.0:
		xs.append(x)
		x += 8.4
	for i in range(xs.size()):
		var px := xs[i] + (0.8 if i % 2 == 0 else -0.6)
		var pz := -80.0 + (1.2 if i % 3 == 0 else -0.4)
		if _in_keepout(px, pz):
			continue
		_pine_at(Vector3(px, 0, pz), bark, pine, 16.0 + float(i % 4) * 1.4)
	var z := -72.0
	while z < 28.0:
		if not _in_keepout(-104.0, z):
			_pine_at(Vector3(-104.0, 0, z), bark, pine, 17.5)
		z += 9.2


func _pine_at(p: Vector3, bark: Material, pine: Material, h: float) -> void:
	var t := Node3D.new()
	t.name = "Windbreak"
	t.position = p
	add_child(t)
	var rng := RandomNumberGenerator.new()
	rng.seed = int(absf(p.x * 17.3 + p.z * 41.1) * 100.0) + 7
	_pine_plant(t, h, bark, pine, rng)


func _leaf_clump(
	t: Node3D, mat: Material, p: Vector3, r: float, rng: RandomNumberGenerator, n: String
) -> void:
	# Flattened, tipped mass on a limb — not a cone, not a balloon on the trunk.
	var mi := MeshKit.add_child_mi(t, MeshKit.sphere(r, 8, 10), mat, n, p)
	mi.scale = Vector3(
		rng.randf_range(1.12, 1.55),
		rng.randf_range(0.30, 0.48),
		rng.randf_range(0.95, 1.32)
	)
	mi.rotation = Vector3(
		rng.randf_range(-0.28, 0.28),
		rng.randf_range(0.0, TAU),
		rng.randf_range(-0.22, 0.22)
	)


func _pine_plant(t: Node3D, h: float, bark: Material, pine: Material, rng: RandomNumberGenerator) -> void:
	# Branches make the taper. Needle masses sit on the boughs. No stacked cones.
	var bot := rng.randf_range(0.16, 0.22)
	var top := rng.randf_range(0.040, 0.065)
	MeshKit.add_child_mi(t, MeshKit.cyl(bot, h, top, 8), bark, "Trunk", Vector3(0, h * 0.5, 0))
	var flare := MeshKit.add_child_mi(t, MeshKit.sphere(bot * 1.9, 8, 10), bark, "Flare", Vector3(0, 0.12, 0))
	flare.scale = Vector3(1.35, 0.42, 1.35)
	MeshKit.add_child_mi(t, MeshKit.cyl(1.18, 0.06, 0.55, 10), MeshKit.pine_duff(), "Duff", Vector3(0, 0.03, 0))
	MeshKit.add_limb(
		t, bark, "Leader",
		Vector3(0, h * 0.86, 0),
		Vector3(rng.randf_range(-0.16, 0.16), h * 1.02, rng.randf_range(-0.16, 0.16)),
		top * 1.15, top * 0.50
	)
	_leaf_clump(t, pine, Vector3(0, h * 1.00, 0), 0.38, rng, "Tip")
	var boughs := 6
	for i in range(boughs):
		var u := 0.28 + float(i) / float(boughs - 1) * 0.56
		var yh := h * u
		var yaw := float(i) * 2.15 + rng.randf_range(-0.35, 0.35)
		var reach := lerpf(2.50, 0.48, u) * rng.randf_range(0.84, 1.10)
		var root := Vector3(0.0, yh, 0.0)
		var tip := root + Vector3(sin(yaw) * reach, reach * rng.randf_range(0.10, 0.28), cos(yaw) * reach)
		MeshKit.add_limb(t, bark, "Bough", root, tip, bot * lerpf(0.30, 0.12, u), 0.020)
		_leaf_clump(t, pine, tip + Vector3(0, 0.10, 0), lerpf(0.92, 0.32, u), rng, "Needles")
		if i % 2 == 0:
			var mid := root.lerp(tip, 0.55)
			var side := 1.0 if rng.randf() < 0.5 else -1.0
			var fyaw := yaw + rng.randf_range(0.70, 1.15) * side
			var ftip := mid + Vector3(sin(fyaw) * reach * 0.42, rng.randf_range(0.08, 0.22), cos(fyaw) * reach * 0.42)
			MeshKit.add_limb(t, bark, "Twig", mid, ftip, 0.026, 0.014)
			_leaf_clump(t, pine, ftip, lerpf(0.52, 0.22, u), rng, "Needles")


func _oak_plant(t: Node3D, h: float, bark: Material, hardwood: Material, hardwood2: Material, rng: RandomNumberGenerator) -> void:
	# Limbs first. Leaf on the limbs. Not three balloons on a pole.
	var bot := rng.randf_range(0.28, 0.40)
	MeshKit.add_child_mi(t, MeshKit.cyl(bot, h * 0.58, 0.12, 8), bark, "Trunk", Vector3(0, h * 0.29, 0))
	var flare := MeshKit.add_child_mi(t, MeshKit.sphere(bot * 1.7, 8, 10), bark, "Flare", Vector3(0, 0.14, 0))
	flare.scale = Vector3(1.42, 0.38, 1.42)
	MeshKit.add_child_mi(t, MeshKit.cyl(1.55, 0.07, 0.58, 10), MeshKit.pine_duff(), "Duff", Vector3(0, 0.03, 0))
	var crotch := Vector3(rng.randf_range(-0.14, 0.14), h * 0.56, rng.randf_range(-0.14, 0.14))
	MeshKit.add_limb(t, bark, "Crotch", Vector3(0, h * 0.48, 0), crotch, bot * 0.52, bot * 0.28)
	var limbs := 5
	for i in range(limbs):
		var yaw := float(i) * 1.35 + rng.randf_range(-0.22, 0.22)
		var yh := h * (0.46 + float(i % 2) * 0.08)
		var reach := rng.randf_range(2.15, 3.45)
		var lift := rng.randf_range(0.75, 2.05)
		var root := Vector3(0.0, yh, 0.0)
		var tip := root + Vector3(sin(yaw) * reach, lift, cos(yaw) * reach)
		MeshKit.add_limb(t, bark, "Limb", root, tip, bot * 0.26, 0.048)
		var leaf_m: Material = hardwood if i % 2 == 0 else hardwood2
		_leaf_clump(t, leaf_m, tip + Vector3(0, 0.32, 0), rng.randf_range(1.25, 1.85), rng, "Canopy")
		if i % 2 == 0:
			var mid := root.lerp(tip, 0.58)
			var side := 1.0 if i % 4 == 0 else -1.0
			var fyaw := yaw + rng.randf_range(0.60, 1.15) * side
			var ftip := mid + Vector3(sin(fyaw) * reach * 0.52, rng.randf_range(0.28, 0.85), cos(fyaw) * reach * 0.52)
			MeshKit.add_limb(t, bark, "Fork", mid, ftip, 0.068, 0.036)
			_leaf_clump(t, hardwood2, ftip + Vector3(0, 0.20, 0), rng.randf_range(0.90, 1.40), rng, "Canopy")
	var lyaw := rng.randf_range(-0.40, 0.40)
	var lroot := Vector3(0, h * 0.33, 0)
	var ltip := lroot + Vector3(sin(lyaw) * 2.7, -0.12, cos(lyaw) * 0.45)
	MeshKit.add_limb(t, bark, "LowLimb", lroot, ltip, 0.10, 0.042)
	_leaf_clump(t, hardwood2, ltip, 1.02, rng, "LimbCanopy")


func _clock_booth() -> void:
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.66, Color(0.70, 0.58, 0.40))
	var white := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.60, Color(0.93, 0.91, 0.84))
	var booth := Node3D.new()
	booth.name = "ClockBooth"
	booth.position = Vector3(RING_W * 0.5 + 2.8, 0.0, -RING_D * 0.5 + 6.4)
	add_child(booth)
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(1.85, 1.15, 1.35)), wood, "Desk", Vector3(0, 0.58, 0))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(1.78, 0.06, 1.28)), MeshKit.wood_kick(), "DeskTop", Vector3(0, 1.18, 0))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(2.05, 0.08, 1.55)), white, "Roof", Vector3(0, 2.28, 0))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(2.15, 0.06, 1.65)), MeshKit.mat_color(Color(0.28, 0.16, 0.12), 0.58), "RoofCap", Vector3(0, 2.36, 0))
	for x in [-0.82, 0.82]:
		MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.08, 2.20, 0.08)), white, "Post", Vector3(x, 1.10, -0.58))
		MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.08, 2.20, 0.08)), white, "PostB", Vector3(x, 1.10, 0.58))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(1.72, 0.72, 0.06)), MeshKit.wood_kick(), "Board", Vector3(0, 1.72, -0.62))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(1.85, 1.05, 0.06)), white, "BackWall", Vector3(0, 1.70, 0.68))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.06, 1.05, 1.28)), white, "SideL", Vector3(-0.92, 1.70, 0.05))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.06, 1.05, 1.28)), white, "SideR", Vector3(0.92, 1.70, 0.05))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(2.35, 0.06, 0.55)), MeshKit.mat_color(Color(0.28, 0.16, 0.12), 0.58), "Overhang", Vector3(0, 2.32, -0.95))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.36, 0.02, 0.26)), MeshKit.mat_color(Color(0.92, 0.90, 0.84), 0.72), "Paper", Vector3(-0.22, 1.22, -0.18))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.28, 0.04, 0.22)), MeshKit.mat_color(Color(0.88, 0.86, 0.78), 0.68), "Program", Vector3(-0.48, 1.24, 0.08))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.22, 0.02, 0.30)), MeshKit.mat_color(Color(0.86, 0.82, 0.72), 0.55), "Clipboard", Vector3(0.18, 1.22, -0.10), Vector3(0.0, 0.18, 0.0))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.18, 0.08, 0.12)), MeshKit.mat_color(Color(0.12, 0.12, 0.14), 0.40), "Radio", Vector3(0.48, 1.24, -0.22))
	MeshKit.add_child_mi(booth, MeshKit.cyl(0.035, 0.16, 0.03, 6), MeshKit.mat_color(Color(0.18, 0.28, 0.42), 0.35), "Bottle", Vector3(0.68, 1.30, 0.12))
	MeshKit.add_child_mi(booth, MeshKit.cyl(0.12, 0.42, 0.10, 8), MeshKit.mat_color(Color(0.72, 0.74, 0.76), 0.28, 0.35), "Cooler", Vector3(-0.72, 0.32, -0.28))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.10, 0.04, 0.08)), MeshKit.mat_color(Color(0.92, 0.92, 0.90), 0.55), "Cup", Vector3(-0.58, 0.56, -0.22))
	MeshKit.add_child_mi(booth, MeshKit.cyl(0.025, 2.15, 0.02, 6), MeshKit.steel(), "FlagPole", Vector3(1.12, 1.12, -0.62))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.38, 0.22, 0.02)), MeshKit.mat_color(Color(0.72, 0.14, 0.16), 0.48), "Flag", Vector3(1.32, 2.08, -0.62))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.42, 0.78, 0.42)), wood, "Stool", Vector3(0.42, 0.40, 0.18))
	var chair := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.62, Color(0.42, 0.28, 0.16))
	for i in range(3):
		var cz := 1.6 + float(i) * 0.85
		MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.42, 0.08, 0.42)), chair, "Seat", Vector3(-1.55, 0.46, cz))
		MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.42, 0.48, 0.06)), chair, "Back", Vector3(-1.72, 0.72, cz))
		for sx in [-0.16, 0.16]:
			MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.05, 0.42, 0.05)), chair, "Leg", Vector3(-1.55 + sx, 0.22, cz - 0.14))
			MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.05, 0.42, 0.05)), chair, "LegB", Vector3(-1.55 + sx, 0.22, cz + 0.14))
	var lab := Label3D.new()
	lab.name = "ClockFace"
	lab.text = "TIME"
	lab.font_size = 56
	lab.modulate = Color(0.96, 0.93, 0.86)
	lab.outline_modulate = Color(0.08, 0.06, 0.04)
	lab.outline_size = 8
	lab.position = Vector3(0, 1.72, -0.68)
	lab.billboard = BaseMaterial3D.BILLBOARD_DISABLED
	lab.rotation.y = PI
	lab.add_to_group("clock_face")
	booth.add_child(lab)
	var cls := Label3D.new()
	cls.text = "WELCOME STAKE"
	cls.font_size = 28
	cls.modulate = Color(0.98, 0.88, 0.42)
	cls.outline_modulate = Color(0.08, 0.06, 0.04)
	cls.outline_size = 6
	cls.position = Vector3(0, 1.46, -0.68)
	cls.rotation.y = PI
	booth.add_child(cls)
	var tbl := Label3D.new()
	tbl.text = "TABLE A"
	tbl.font_size = 18
	tbl.modulate = Color(0.92, 0.86, 0.72)
	tbl.outline_modulate = Color(0.08, 0.06, 0.04)
	tbl.outline_size = 4
	tbl.position = Vector3(0, 1.28, -0.68)
	tbl.rotation.y = PI
	booth.add_child(tbl)
	MeshKit.add_child_mi(booth, MeshKit.cyl(0.055, 0.08, 0.055, 10), MeshKit.mat_color(Color(0.72, 0.58, 0.22), 0.28, 0.45), "Bell", Vector3(-0.62, 2.08, -0.58))
	MeshKit.add_child_mi(booth, MeshKit.cyl(0.008, 0.12, 0.008, 6), MeshKit.steel(), "BellHang", Vector3(-0.62, 2.18, -0.58))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.22, 0.12, 0.16)), MeshKit.mat_color(Color(0.72, 0.14, 0.18), 0.48), "RibbonBox", Vector3(0.62, 1.26, 0.18))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.08, 0.18, 0.02)), MeshKit.mat_color(Color(0.18, 0.28, 0.62), 0.45), "Ribbon", Vector3(0.68, 1.38, 0.22))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.08, 0.22, 0.02)), MeshKit.mat_color(Color(0.92, 0.78, 0.22), 0.45), "RibbonY", Vector3(0.58, 1.42, 0.22))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.08, 0.16, 0.02)), MeshKit.mat_color(Color(0.72, 0.72, 0.74), 0.42), "RibbonS", Vector3(0.78, 1.36, 0.22))
	MeshKit.add_child_mi(booth, MeshKit.cyl(0.028, 0.012, 0.028, 8), MeshKit.mat_color(Color(0.12, 0.12, 0.14), 0.35), "Stopwatch", Vector3(-0.08, 1.23, -0.22))
	MeshKit.add_child_mi(booth, MeshKit.cyl(0.038, 0.10, 0.032, 8), MeshKit.mat_color(Color(0.88, 0.86, 0.80), 0.55), "Mug", Vector3(0.32, 1.28, 0.18))
	MeshKit.add_child_mi(booth, MeshKit.box(Vector3(0.32, 0.01, 0.22)), MeshKit.mat_color(Color(0.96, 0.94, 0.88), 0.62), "PrizeList", Vector3(-0.05, 1.225, 0.12), Vector3(0.0, -0.22, 0.0))


func _indoor() -> void:
	# Covered schooling ring by the barn — the missing Hidden K landmark.
	var inn := Node3D.new()
	inn.name = "Indoor"
	inn.position = Vector3(-78, 0, -10)
	inn.rotation_degrees = Vector3(0, 90, 0)
	add_child(inn)
	var wood := MeshKit.wood_oak()
	var kick := MeshKit.wood_kick()
	var roof := MeshKit.barn_roof()
	var sand := MeshKit.sand_material()
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(16.4, 0.10, 32.0)), sand, "InSand", Vector3(0, -0.04, 0))
	for z in [-14.5, -7.2, 0.0, 7.2, 14.5]:
		MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.22, 4.4, 0.22)), wood, "InPostL", Vector3(-7.8, 2.2, z))
		MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.22, 4.4, 0.22)), wood, "InPostR", Vector3(7.8, 2.2, z))
		MeshKit.add_rod(inn, wood, "InKneeL", Vector3(-7.8, 1.55, z), Vector3(-6.55, 3.35, z), 0.055)
		MeshKit.add_rod(inn, wood, "InKneeR", Vector3(7.8, 1.55, z), Vector3(6.55, 3.35, z), 0.055)
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(16.8, 0.18, 0.14)), wood, "InFasciaF", Vector3(0, 4.48, -16.05))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(16.8, 0.18, 0.14)), wood, "InFasciaB", Vector3(0, 4.48, 16.05))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.14, 0.18, 32.4)), wood, "InFasciaL", Vector3(-8.15, 4.48, 0))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.14, 0.18, 32.4)), wood, "InFasciaR", Vector3(8.15, 4.48, 0))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(16.2, 0.88, 0.16)), kick, "InKickF", Vector3(0, 0.44, -15.9))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(16.2, 0.88, 0.16)), kick, "InKickB", Vector3(0, 0.44, 15.9))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.16, 0.88, 31.6)), kick, "InKickL", Vector3(-7.9, 0.44, 0))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.16, 0.88, 31.6)), kick, "InKickR", Vector3(7.9, 0.44, 0))
	MeshKit.add_child_mi(inn, MeshKit.prism(Vector3(18.4, 3.2, 34.2)), roof, "InRoof", Vector3(0, 6.05, 0))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.22, 0.16, 34.6)), MeshKit.mat_color(Color(0.16, 0.16, 0.18), 0.45), "InRidge", Vector3(0, 7.68, 0))
	MeshKit.add_child_mi(inn, MeshKit.prism(Vector3(16.4, 2.9, 0.18)), wood, "InGableF", Vector3(0, 5.95, -15.9))
	MeshKit.add_child_mi(inn, MeshKit.prism(Vector3(16.4, 2.9, 0.18)), wood, "InGableB", Vector3(0, 5.95, 15.9))
	var cap := MeshKit.wood_oak()
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(16.4, 0.06, 0.20)), cap, "InCapF", Vector3(0, 0.90, -15.9))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(16.4, 0.06, 0.20)), cap, "InCapB", Vector3(0, 0.90, 15.9))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.20, 0.06, 31.8)), cap, "InCapL", Vector3(-7.9, 0.90, 0))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.20, 0.06, 31.8)), cap, "InCapR", Vector3(7.9, 0.90, 0))
	var in_white := MeshKit.wood_white()
	for y: float in [1.08, 1.36]:
		MeshKit.add_child_mi(inn, MeshKit.box(Vector3(16.2, 0.07, 0.08)), in_white, "InRailF", Vector3(0, y, -15.9))
		MeshKit.add_child_mi(inn, MeshKit.box(Vector3(16.2, 0.07, 0.08)), in_white, "InRailB", Vector3(0, y, 15.9))
		MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.08, 0.07, 31.6)), in_white, "InRailL", Vector3(-7.9, y, 0))
		MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.08, 0.07, 31.6)), in_white, "InRailR", Vector3(7.9, y, 0))
	for z in [-10.0, 0.0, 10.0]:
		var lamp := MeshKit.add_child_mi(inn, MeshKit.cyl(0.10, 0.22, 0.14, 8), MeshKit.mat_color(Color(0.92, 0.80, 0.52), 0.22, 0.50), "InLamp", Vector3(0, 5.35, z))
		lamp.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		var bulb := OmniLight3D.new()
		bulb.light_energy = 0.95
		bulb.light_color = Color(1.0, 0.80, 0.52)
		bulb.omni_range = 16.0
		bulb.position = Vector3(0, 5.15, z)
		inn.add_child(bulb)
		for sx: float in [-1.0, 1.0]:
			var side := OmniLight3D.new()
			side.light_energy = 0.42
			side.light_color = Color(1.0, 0.78, 0.48)
			side.omni_range = 10.0
			side.position = Vector3(sx * 5.4, 4.55, z)
			inn.add_child(side)
	var white := MeshKit.mat_color(Color(0.93, 0.91, 0.84), 0.55)
	for i in range(3):
		MeshKit.add_child_mi(inn, MeshKit.cyl(0.035, 2.4, 0.035, 8), white, "InCav", Vector3(-2.0 + float(i) * 0.15, 0.22 + float(i) * 0.08, 8.4), Vector3(0, 0, 1.57))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(2.6, 0.08, 0.08)), wood, "InDoorLintel", Vector3(0, 2.85, -16.02))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.10, 2.85, 0.10)), wood, "InJambL", Vector3(-1.35, 1.42, -16.02))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.10, 2.85, 0.10)), wood, "InJambR", Vector3(1.35, 1.42, -16.02))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(1.28, 2.55, 0.10)), wood, "InDoorL", Vector3(-2.08, 1.28, -15.48), Vector3(0, 0.92, 0))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(1.28, 2.55, 0.10)), wood, "InDoorR", Vector3(2.12, 1.28, -15.68), Vector3(0, -0.58, 0))
	var in_spill := OmniLight3D.new()
	in_spill.light_energy = 1.25
	in_spill.light_color = Color(1.0, 0.78, 0.48)
	in_spill.omni_range = 9.0
	in_spill.position = Vector3(0, 1.45, -15.2)
	inn.add_child(in_spill)
	var gold := MeshKit.mat_color(Color(0.92, 0.72, 0.38), 0.22, 0.12)
	gold.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	gold.albedo_color = Color(0.92, 0.72, 0.38, 0.20)
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(3.4, 0.008, 2.8)), gold, "InDoorSpill", Vector3(0, 0.06, -17.2))
	var straw := MeshKit.mat_color(Color(0.62, 0.48, 0.22), 0.84)
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(1.55, 0.22, 0.85)), straw, "InHay", Vector3(2.55, 0.14, -14.4))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.85, 0.38, 0.55)), straw, "InBale", Vector3(-2.65, 0.22, -14.6))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.72, 0.42, 0.48)), MeshKit.mat_color(Color(0.28, 0.16, 0.10), 0.52), "InTrunk", Vector3(-3.15, 0.24, 14.6))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.95, 0.38, 0.55)), wood, "InBlock", Vector3(3.4, 0.20, -13.8))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(0.95, 0.20, 0.38)), wood, "InBlockStep", Vector3(3.4, 0.48, -13.55))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(3.35, 0.58, 0.08)), MeshKit.mat_color(Color(0.14, 0.20, 0.36), 0.48), "InSign", Vector3(0, 4.55, -16.08))
	MeshKit.add_child_mi(inn, MeshKit.box(Vector3(3.45, 0.06, 0.10)), MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.58, Color(0.78, 0.70, 0.52)), "InSignCap", Vector3(0, 4.86, -16.08))
	var lab := Label3D.new()
	lab.text = "HIDDEN K"
	lab.font_size = 42
	lab.modulate = Color(0.96, 0.93, 0.86)
	lab.outline_modulate = Color(0.08, 0.06, 0.04)
	lab.outline_size = 6
	lab.position = Vector3(0, 4.55, -16.16)
	inn.add_child(lab)
	var a_mark := Label3D.new()
	a_mark.text = "A"
	a_mark.font_size = 48
	a_mark.modulate = Color(0.96, 0.93, 0.86)
	a_mark.outline_modulate = Color(0.08, 0.06, 0.04)
	a_mark.outline_size = 6
	a_mark.position = Vector3(0, 1.15, -15.55)
	a_mark.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	inn.add_child(a_mark)
	var c_mark := Label3D.new()
	c_mark.text = "C"
	c_mark.font_size = 48
	c_mark.modulate = Color(0.96, 0.93, 0.86)
	c_mark.outline_modulate = Color(0.08, 0.06, 0.04)
	c_mark.outline_size = 6
	c_mark.position = Vector3(0, 1.15, 15.55)
	c_mark.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	inn.add_child(c_mark)
	# Letters as scenery. This is not a class.
	for item in [
		["E", Vector3(-7.55, 1.12, 0.0)],
		["B", Vector3(7.55, 1.12, 0.0)],
		["K", Vector3(-7.55, 1.12, -10.2)],
		["F", Vector3(7.55, 1.12, -10.2)],
		["H", Vector3(-7.55, 1.12, 10.2)],
		["M", Vector3(7.55, 1.12, 10.2)],
	]:
		var lm := Label3D.new()
		lm.text = str(item[0])
		lm.font_size = 40
		lm.modulate = Color(0.96, 0.93, 0.86)
		lm.outline_modulate = Color(0.08, 0.06, 0.04)
		lm.outline_size = 5
		lm.position = item[1]
		lm.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		inn.add_child(lm)


func _ridges() -> void:
	# Low Piedmont hills so the grass does not meet a hard sky line.
	var far := MeshKit.mat_color(Color(0.52, 0.34, 0.16), 0.94)
	var far2 := MeshKit.mat_color(Color(0.36, 0.30, 0.14), 0.95)
	var far3 := MeshKit.mat_color(Color(0.44, 0.24, 0.12), 0.96)
	var specs := [
		[Vector3(-40, -22, -205), Vector3(3.4, 0.52, 1.35), 52.0],
		[Vector3(55, -20, -198), Vector3(2.8, 0.48, 1.22), 44.0],
		[Vector3(-110, -18, -160), Vector3(2.2, 0.46, 1.50), 38.0],
		[Vector3(130, -20, -150), Vector3(2.4, 0.50, 1.40), 40.0],
		[Vector3(-150, -16, 40), Vector3(1.8, 0.44, 2.20), 36.0],
		[Vector3(155, -18, 80), Vector3(2.0, 0.46, 1.90), 38.0],
		[Vector3(20, -24, 210), Vector3(3.6, 0.42, 1.30), 50.0],
		[Vector3(-80, -28, -230), Vector3(4.2, 0.38, 1.18), 62.0],
		[Vector3(90, -26, -220), Vector3(3.8, 0.36, 1.12), 56.0],
		[Vector3(-180, -20, -80), Vector3(2.6, 0.40, 1.80), 44.0],
		[Vector3(175, -22, -40), Vector3(2.4, 0.38, 1.70), 42.0],
		[Vector3(-20, -36, -280), Vector3(5.4, 0.28, 1.08), 78.0],
		[Vector3(70, -34, -270), Vector3(4.8, 0.26, 1.04), 72.0],
		[Vector3(-130, -32, -250), Vector3(4.2, 0.30, 1.16), 68.0],
	]
	for i in range(specs.size()):
		var s: Array = specs[i]
		var hill: Material = far if i % 3 == 0 else (far2 if i % 3 == 1 else far3)
		var mi := MeshKit.add_child_mi(self, MeshKit.sphere(float(s[2]), 10, 14), hill, "Ridge")
		mi.position = s[0]
		mi.scale = s[1]
		mi.extra_cull_margin = 80.0


func _people() -> void:
	var michelle := People.standing_trainer()
	michelle.position = Vector3(RING_W * 0.5 + 0.85, 0.12, -8.0)
	michelle.rotation.y = -PI * 0.5
	add_child(michelle)
	var wood := MeshKit.mat_tex("res://assets/textures/wood_albedo.jpg", 0.68, Color(0.62, 0.50, 0.34))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.85, 0.22, 0.55)), wood, "RailBlock", Vector3(RING_W * 0.5 + 0.85, 0.11, -8.0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.22, 1.15, 0.22)), wood, "RailPost", Vector3(RING_W * 0.5 + 1.25, 0.68, -8.0))
	MeshKit.add_child_mi(self, MeshKit.box(Vector3(0.08, 0.08, 0.85)), wood, "RailHold", Vector3(RING_W * 0.5 + 1.15, 1.18, -8.0))


func _sun() -> void:
	var sun := DirectionalLight3D.new()
	sun.light_energy = 1.22
	sun.light_color = Color(1.0, 0.93, 0.82)
	sun.shadow_enabled = true
	sun.directional_shadow_max_distance = 140.0
	sun.directional_shadow_blend_splits = true
	sun.directional_shadow_fade_start = 0.82
	sun.shadow_bias = 0.02
	sun.shadow_normal_bias = 1.15
	sun.light_angular_distance = 0.45
	sun.rotation_degrees = Vector3(-34, -42, 0)
	add_child(sun)
	var fill := DirectionalLight3D.new()
	fill.light_energy = 0.22
	fill.light_color = Color(0.64, 0.74, 0.88)
	fill.rotation_degrees = Vector3(-18, 150, 0)
	fill.shadow_enabled = false
	add_child(fill)


func _walls() -> void:
	var hx := RING_W * 0.5 + 0.15
	var hz := RING_D * 0.5 + 0.15
	var h := 2.0
	var specs := [
		[Vector3(0, h * 0.5, -hz), Vector3(hx * 2.0, h, 0.3)],
		[Vector3(0, h * 0.5, hz), Vector3(hx * 2.0, h, 0.3)],
		[Vector3(-hx, h * 0.5, 0), Vector3(0.3, h, hz * 2.0)],
		[Vector3(hx, h * 0.5, 0), Vector3(0.3, h, hz * 2.0)],
	]
	for s in specs:
		var b := StaticBody3D.new()
		b.collision_layer = 2
		var c := CollisionShape3D.new()
		var box := BoxShape3D.new()
		box.size = s[1]
		c.shape = box
		b.position = s[0]
		b.add_child(c)
		add_child(b)


func _sky() -> void:
	var env := WorldEnvironment.new()
	var we := Environment.new()
	we.background_mode = Environment.BG_SKY
	var sky := Sky.new()
	if ResourceLoader.exists("res://assets/textures/sky.jpg"):
		var pano := PanoramaSkyMaterial.new()
		pano.panorama = load("res://assets/textures/sky.jpg")
		pano.energy_multiplier = 0.72
		sky.sky_material = pano
	else:
		var psky := ProceduralSkyMaterial.new()
		psky.sky_top_color = Color(0.28, 0.46, 0.72)
		psky.sky_horizon_color = Color(0.86, 0.78, 0.68)
		psky.ground_bottom_color = Color(0.20, 0.26, 0.12)
		psky.ground_horizon_color = Color(0.52, 0.50, 0.36)
		psky.sun_angle_max = 28.0
		psky.sun_curve = 0.12
		sky.sky_material = psky
	we.sky = sky
	we.ambient_light_source = Environment.AMBIENT_SOURCE_SKY
	we.ambient_light_energy = 0.82
	we.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	we.tonemap_exposure = 1.02
	we.ssao_enabled = true
	we.ssao_radius = 1.05
	we.ssao_intensity = 0.72
	we.ssao_power = 1.35
	we.ssao_detail = 0.35
	we.ssao_horizon = 0.12
	we.ssil_enabled = false
	we.glow_enabled = true
	we.glow_intensity = 0.10
	we.glow_bloom = 0.04
	we.glow_hdr_threshold = 1.25
	we.fog_enabled = true
	we.fog_light_color = Color(0.80, 0.84, 0.88)
	we.fog_density = 0.0018
	we.fog_aerial_perspective = 0.38
	we.fog_sky_affect = 0.28
	we.adjustment_enabled = false
	we.sdfgi_enabled = false
	we.sdfgi_use_occlusion = false
	env.environment = we
	add_child(env)
	var amb := AudioStreamPlayer.new()
	if ResourceLoader.exists("res://assets/audio/ambient_outdoor.wav"):
		amb.stream = load("res://assets/audio/ambient_outdoor.wav")
		amb.autoplay = true
		if amb.stream is AudioStreamWAV:
			var wav: AudioStreamWAV = (amb.stream as AudioStreamWAV).duplicate()
			wav.loop_mode = AudioStreamWAV.LOOP_FORWARD
			amb.stream = wav
		amb.volume_db = -7.0
	add_child(amb)
