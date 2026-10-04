class_name MeshKit
extends RefCounted


static func load_tex(path: String) -> Texture2D:
	if path != "" and ResourceLoader.exists(path):
		return load(path)
	return null


static func first_tex_path(paths: Array) -> String:
	for p in paths:
		var s := str(p)
		if s != "" and ResourceLoader.exists(s):
			return s
	return ""


static func harvest_tex(paths: Array, fallback: String) -> String:
	var hit := first_tex_path(paths)
	if hit != "":
		return hit
	if fallback != "" and ResourceLoader.exists(fallback):
		return fallback
	return fallback


static func mat_color(c: Color, rough: float = 0.55, metal: float = 0.0) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = c
	m.roughness = rough
	m.metallic = metal
	m.specular_mode = BaseMaterial3D.SPECULAR_SCHLICK_GGX
	m.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
	return m


static func mat_tex(albedo_path: String, rough: float = 0.6, color: Color = Color.WHITE) -> StandardMaterial3D:
	var m := mat_color(color, rough)
	var t := load_tex(albedo_path)
	if t:
		m.albedo_texture = t
	var npath := albedo_path.replace("_albedo.jpg", "_normal.jpg").replace("_albedo.png", "_normal.jpg")
	var n := load_tex(npath)
	if n:
		m.normal_enabled = true
		m.normal_texture = n
		m.normal_scale = 0.8
	return m


static func coat_material() -> ShaderMaterial:
	var sh: Shader = load("res://shaders/coat.gdshader")
	var m := ShaderMaterial.new()
	m.shader = sh
	var side := load_tex("res://assets/textures/abbott_side.png")
	var front := load_tex("res://assets/textures/abbott_front.png")
	var coat := load_tex("res://assets/textures/coat_albedo.jpg")
	if side:
		m.set_shader_parameter("side_tex", side)
	if front:
		m.set_shader_parameter("front_tex", front)
	if coat:
		m.set_shader_parameter("coat_tex", coat)
	return m


static func sand_material() -> ShaderMaterial:
	var m := ShaderMaterial.new()
	m.shader = load("res://shaders/sand.gdshader")
	var ap := harvest_tex([
		"res://assets/textures/harvest/proc/sand_worked_dry_albedo.jpg",
		"res://assets/textures/harvest/raked_dirt_albedo.jpg",
		"res://assets/textures/harvest/playground_sand_albedo.jpg",
	], "res://assets/textures/sand_albedo.jpg")
	var np := ap.replace("_albedo.jpg", "_normal.jpg")
	if not ResourceLoader.exists(np):
		np = "res://assets/textures/sand_normal.jpg"
	var a := load_tex(ap)
	var n := load_tex(np)
	if a:
		m.set_shader_parameter("albedo_tex", a)
	if n:
		m.set_shader_parameter("normal_tex", n)
	m.set_shader_parameter("arena_half", Vector2(15.24, 38.1))
	return m


static func grass_material() -> ShaderMaterial:
	var m := ShaderMaterial.new()
	m.shader = load("res://shaders/grass.gdshader")
	var ap := harvest_tex([
		"res://assets/textures/harvest/proc/grass_piedmont_albedo.jpg",
		"res://assets/textures/harvest/withered_grass_albedo.jpg",
		"res://assets/textures/harvest/leafy_grass_albedo.jpg",
	], "res://assets/textures/grass_albedo.jpg")
	var a := load_tex(ap)
	if a:
		m.set_shader_parameter("albedo_tex", a)
	m.set_shader_parameter("arena_half", Vector2(15.24, 38.1))
	m.set_shader_parameter("apron", 4.4)
	return m


static func pine_material() -> ShaderMaterial:
	var m := ShaderMaterial.new()
	m.shader = load("res://shaders/pine.gdshader")
	return m


static func hardwood_material(sun: bool = false) -> ShaderMaterial:
	var m := ShaderMaterial.new()
	m.shader = load("res://shaders/hardwood.gdshader")
	if sun:
		m.set_shader_parameter("leaf", Vector3(0.62, 0.28, 0.08))
		m.set_shader_parameter("sun_leaf", Vector3(0.86, 0.40, 0.10))
	return m


static func mesh_instance(mesh: Mesh, material: Material, name: String = "Mesh") -> MeshInstance3D:
	var mi := MeshInstance3D.new()
	mi.name = name
	mi.mesh = mesh
	mi.material_override = material
	mi.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	return mi


static func box(size: Vector3) -> BoxMesh:
	var b := BoxMesh.new()
	b.size = size
	return b


static func sphere(r: float, rings: int = 16, rad: int = 24) -> SphereMesh:
	var s := SphereMesh.new()
	s.radius = r
	s.height = r * 2.0
	s.radial_segments = rad
	s.rings = rings
	return s


static func cyl(r: float, h: float, top: float = -1.0, segs: int = 16) -> CylinderMesh:
	var c := CylinderMesh.new()
	c.bottom_radius = r
	c.top_radius = r if top < 0.0 else top
	c.height = h
	c.radial_segments = segs
	c.rings = 1
	return c


static func cap(r: float, h: float) -> CapsuleMesh:
	var c := CapsuleMesh.new()
	c.radius = r
	c.height = h
	c.radial_segments = 14
	return c


static func prism(size: Vector3) -> PrismMesh:
	var p := PrismMesh.new()
	p.size = size
	p.left_to_right = 0.5
	return p


static func loft(stations: Array, segs: int, colors: Array = []) -> ArrayMesh:
	# stations: array of Dictionaries {origin: Vector3, x: Vector3, y: Vector3, rx: float, ry: float}
	var st := SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	var rings: int = stations.size()
	var verts: Array[Vector3] = []
	var nrm: Array[Vector3] = []
	var uvs: Array[Vector2] = []
	var cols: Array[Color] = []
	for i in range(rings):
		var s: Dictionary = stations[i]
		var o: Vector3 = s.origin
		var ax: Vector3 = s.x
		var ay: Vector3 = s.y
		var rx: float = s.rx
		var ry: float = s.ry
		var col := Color(0, 0, 0, 1)
		if colors.size() > i:
			col = colors[i]
		elif s.has("color"):
			col = s.color
		for j in range(segs):
			var t: float = float(j) / float(segs) * TAU
			var p: Vector3 = o + ax * cos(t) * rx + ay * sin(t) * ry
			verts.append(p)
			nrm.append((ax * cos(t) * ry + ay * sin(t) * rx).normalized())
			uvs.append(Vector2(float(j) / float(segs), float(i) / float(max(rings - 1, 1))))
			cols.append(col)
	for i in range(rings - 1):
		for j in range(segs):
			var j2: int = (j + 1) % segs
			var a: int = i * segs + j
			var b: int = i * segs + j2
			var c: int = (i + 1) * segs + j
			var d: int = (i + 1) * segs + j2
			_tri(st, verts, nrm, uvs, cols, a, c, b)
			_tri(st, verts, nrm, uvs, cols, b, c, d)
	st.generate_normals()
	st.generate_tangents()
	return st.commit()


static func _tri(st: SurfaceTool, verts: Array, nrm: Array, uvs: Array, cols: Array, a: int, b: int, c: int) -> void:
	st.set_normal(nrm[a])
	st.set_uv(uvs[a])
	st.set_color(cols[a])
	st.add_vertex(verts[a])
	st.set_normal(nrm[b])
	st.set_uv(uvs[b])
	st.set_color(cols[b])
	st.add_vertex(verts[b])
	st.set_normal(nrm[c])
	st.set_uv(uvs[c])
	st.set_color(cols[c])
	st.add_vertex(verts[c])


static func station(origin: Vector3, rx: float, ry: float, tangent: Vector3 = Vector3(0, 0, 1), color: Color = Color(0, 0, 0, 1)) -> Dictionary:
	var t := tangent.normalized()
	var x := Vector3.UP.cross(t)
	if x.length() < 0.001:
		x = Vector3.RIGHT
	x = x.normalized()
	var y := t.cross(x).normalized()
	return {origin = origin, x = x, y = y, rx = rx, ry = ry, color = color}


static func add_child_mi(parent: Node3D, mesh: Mesh, mat: Material, n: String, pos: Vector3 = Vector3.ZERO, rot: Vector3 = Vector3.ZERO) -> MeshInstance3D:
	var mi := mesh_instance(mesh, mat, n)
	parent.add_child(mi)
	mi.position = pos
	mi.rotation = rot
	mi.extra_cull_margin = 0.8
	return mi


static func leather(tint: Color = Color(0.48, 0.28, 0.16), rough: float = 0.46) -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/brown_leather_albedo.jpg",
		"res://assets/textures/harvest/fabric_leather_02_albedo.jpg",
		"res://assets/textures/harvest/acg_leather021_albedo.jpg",
		"res://assets/textures/harvest/proc/leather_bridle_albedo.jpg",
	], "res://assets/textures/leather_albedo.jpg"), rough, tint)


static func steel() -> StandardMaterial3D:
	var p := harvest_tex([
		"res://assets/textures/harvest/metal_plate_albedo.jpg",
		"res://assets/textures/harvest/rusty_metal_03_albedo.jpg",
		"res://assets/textures/harvest/acg_metal032_albedo.jpg",
	], "")
	if p != "":
		var m := mat_tex(p, 0.28, Color(0.82, 0.80, 0.76))
		m.metallic = 0.72
		return m
	return mat_color(Color(0.62, 0.60, 0.56), 0.24, 0.78)


static func wood_white() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/board_white_albedo.jpg",
		"res://assets/textures/harvest/white_planks_clean_albedo.jpg",
		"res://assets/textures/harvest/distressed_painted_planks_albedo.jpg",
	], "res://assets/textures/wood_albedo.jpg"), 0.62, Color(0.93, 0.91, 0.84))


static func wood_kick() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/kick_dark_albedo.jpg",
		"res://assets/textures/harvest/dark_planks_albedo.jpg",
		"res://assets/textures/harvest/dark_wood_albedo.jpg",
	], "res://assets/textures/wood_albedo.jpg"), 0.78, Color(0.22, 0.16, 0.11))


static func wood_oak() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/oak_wood_planks_albedo.jpg",
		"res://assets/textures/harvest/worn_planks_albedo.jpg",
		"res://assets/textures/harvest/proc/rail_natural_albedo.jpg",
	], "res://assets/textures/wood_albedo.jpg"), 0.66, Color(0.78, 0.70, 0.52))


static func hunt_wool() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/wool_navy_coat_albedo.jpg",
		"res://assets/textures/harvest/poly_wool_herringbone_albedo.jpg",
		"res://assets/textures/harvest/wool_boucle_albedo.jpg",
	], ""), 0.88, Color(0.10, 0.12, 0.18))


static func pad_fabric() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/acg_fabric018_albedo.jpg",
		"res://assets/textures/harvest/acg_fabric004_albedo.jpg",
		"res://assets/textures/harvest/wool_boucle_albedo.jpg",
	], "res://assets/textures/leather_albedo.jpg"), 0.72, Color(0.92, 0.90, 0.84))


static func fieldstone() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/sandy_gravel_albedo.jpg",
		"res://assets/textures/harvest/gravel_albedo.jpg",
		"res://assets/textures/harvest/stony_dirt_path_albedo.jpg",
	], "res://assets/textures/sand_albedo.jpg"), 0.82, Color(0.44, 0.40, 0.34))


static func gravel() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/gravel_drive_albedo.jpg",
		"res://assets/textures/harvest/gravel_albedo.jpg",
		"res://assets/textures/harvest/sandy_gravel_albedo.jpg",
	], "res://assets/textures/sand_albedo.jpg"), 0.90, Color(0.50, 0.42, 0.30))


static func pine_bark() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/pine_bark_albedo.jpg",
		"res://assets/textures/harvest/knotted_pine_bark_albedo.jpg",
		"res://assets/textures/harvest/proc/oak_bark_albedo.jpg",
	], "res://assets/textures/wood_albedo.jpg"), 0.82, Color(0.32, 0.22, 0.14))


static func straw() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/straw_gold_albedo.jpg",
		"res://assets/textures/harvest/proc/hay_bale_albedo.jpg",
		"res://assets/textures/harvest/wood_chips_albedo.jpg",
	], "res://assets/textures/sand_albedo.jpg"), 0.86, Color(0.68, 0.52, 0.24))


static func hay() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/hay_bale_albedo.jpg",
		"res://assets/textures/harvest/proc/hay_dust_albedo.jpg",
		"res://assets/textures/harvest/wood_chips_albedo.jpg",
	], "res://assets/textures/sand_albedo.jpg"), 0.84, Color(0.62, 0.48, 0.22))


static func flower_soil() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/flower_soil_albedo.jpg",
		"res://assets/textures/harvest/proc/flower_box_soil_albedo.jpg",
		"res://assets/textures/harvest/farm_soil_albedo.jpg",
	], "res://assets/textures/sand_albedo.jpg"), 0.88, Color(0.28, 0.20, 0.12))


static func apron_dirt() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/apron_dirt_albedo.jpg",
		"res://assets/textures/harvest/raked_dirt_albedo.jpg",
		"res://assets/textures/harvest/park_dirt_albedo.jpg",
	], "res://assets/textures/sand_albedo.jpg"), 0.88, Color(0.48, 0.40, 0.28))


static func sand_lip() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/sand_lip_albedo.jpg",
		"res://assets/textures/harvest/proc/sand_worked_dry_albedo.jpg",
		"res://assets/textures/harvest/playground_sand_albedo.jpg",
	], "res://assets/textures/sand_albedo.jpg"), 0.86, Color(0.56, 0.48, 0.34))


static func boot_leather() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/boot_black_albedo.jpg",
		"res://assets/textures/harvest/brown_leather_albedo.jpg",
		"res://assets/textures/harvest/proc/leather_bridle_albedo.jpg",
	], "res://assets/textures/leather_albedo.jpg"), 0.32, Color(0.08, 0.06, 0.05))


static func cooler_wool() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/cooler_navy_albedo.jpg",
		"res://assets/textures/harvest/proc/wool_navy_coat_albedo.jpg",
		"res://assets/textures/harvest/wool_boucle_albedo.jpg",
	], ""), 0.58, Color(0.18, 0.22, 0.38))


static func pine_duff() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/pine_duff_wet_albedo.jpg",
		"res://assets/textures/harvest/proc/pine_needles_albedo.jpg",
		"res://assets/textures/harvest/forest_floor_albedo.jpg",
	], "res://assets/textures/wood_albedo.jpg"), 0.88, Color(0.28, 0.24, 0.12))


static func clover() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/clover_patch_albedo.jpg",
		"res://assets/textures/harvest/proc/grass_clover_albedo.jpg",
		"res://assets/textures/harvest/leafy_grass_albedo.jpg",
	], "res://assets/textures/grass_albedo.jpg"), 0.84, Color(0.22, 0.38, 0.16))


static func stall_steel() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/stall_bar_albedo.jpg",
		"res://assets/textures/harvest/metal_plate_albedo.jpg",
		"res://assets/textures/harvest/acg_metal001_albedo.jpg",
	], ""), 0.40, Color(0.35, 0.32, 0.30))


static func barn_roof() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/rusty_metal_03_albedo.jpg",
		"res://assets/textures/harvest/rusty_metal_albedo.jpg",
		"res://assets/textures/harvest/dark_planks_albedo.jpg",
	], "res://assets/textures/wood_albedo.jpg"), 0.58, Color(0.36, 0.20, 0.14))


static func house_roof() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/dark_planks_albedo.jpg",
		"res://assets/textures/harvest/dark_wood_albedo.jpg",
		"res://assets/textures/harvest/rusty_metal_albedo.jpg",
	], "res://assets/textures/wood_albedo.jpg"), 0.62, Color(0.26, 0.24, 0.22))


static func hydrant() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/hydrant_metal_albedo.jpg",
		"res://assets/textures/harvest/rusty_metal_albedo.jpg",
		"res://assets/textures/harvest/metal_plate_albedo.jpg",
	], ""), 0.42, Color(0.55, 0.22, 0.18))


static func velvet() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/velvet_cap_albedo.jpg",
		"res://assets/textures/harvest/proc/wool_navy_coat_albedo.jpg",
		"res://assets/textures/harvest/wool_boucle_albedo.jpg",
	], ""), 0.62, Color(0.08, 0.08, 0.10))


static func leather_sweat() -> StandardMaterial3D:
	return mat_tex(harvest_tex([
		"res://assets/textures/harvest/proc/leather_sweat_albedo.jpg",
		"res://assets/textures/harvest/proc/leather_bridle_albedo.jpg",
		"res://assets/textures/harvest/brown_leather_albedo.jpg",
	], "res://assets/textures/leather_albedo.jpg"), 0.48, Color(0.42, 0.22, 0.12))


static func torus(inner: float, outer: float, rings: int = 14, segs: int = 10) -> TorusMesh:
	var t := TorusMesh.new()
	t.inner_radius = inner
	t.outer_radius = outer
	t.rings = rings
	t.ring_segments = segs
	return t


static func add_rod(parent: Node3D, mat: Material, n: String, a: Vector3, b: Vector3, radius: float) -> MeshInstance3D:
	var d := b - a
	var len := d.length()
	if len < 0.004:
		return null
	var mi := mesh_instance(cyl(radius, len, -1.0, 8), mat, n)
	parent.add_child(mi)
	mi.extra_cull_margin = 0.8
	var y := d / len
	var x := y.cross(Vector3.FORWARD)
	if x.length() < 0.02:
		x = y.cross(Vector3.UP)
	x = x.normalized()
	var z := x.cross(y).normalized()
	mi.transform = Transform3D(Basis(x, y, z), (a + b) * 0.5)
	return mi


static func limb(a: Vector3, b: Vector3, r0: float, r1: float, segs: int = 10) -> ArrayMesh:
	var d := b - a
	var len := d.length()
	if len < 0.004:
		return loft([station(a, r0, r0), station(b, r1, r1)], segs)
	var t := d / len
	var mid := a.lerp(b, 0.52)
	var rm := (r0 + r1) * 0.52
	return loft([station(a, r0, r0 * 0.92, t), station(mid, rm, rm * 0.88, t), station(b, r1, r1 * 0.90, t)], segs)


static func add_limb(parent: Node3D, mat: Material, n: String, a: Vector3, b: Vector3, r0: float, r1: float) -> MeshInstance3D:
	return add_child_mi(parent, limb(a, b, r0, r1, 12), mat, n)


static func place_rod_global(mi: MeshInstance3D, a: Vector3, b: Vector3) -> void:
	var d := b - a
	var len := d.length()
	if len < 0.02:
		mi.visible = false
		return
	mi.visible = true
	var mesh := mi.mesh as CylinderMesh
	if mesh:
		mesh.height = len
	var y := d / len
	var x := y.cross(Vector3.UP)
	if x.length() < 0.02:
		x = y.cross(Vector3.RIGHT)
	x = x.normalized()
	var z := x.cross(y).normalized()
	mi.global_transform = Transform3D(Basis(x, y, z), (a + b) * 0.5)
