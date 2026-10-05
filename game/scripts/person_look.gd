class_name PersonLook
extends RefCounted

## Hunt-seat Madison from the three-view kit photos, and Michelle on the rail.
## Face is a tight crop of the front/side plates — not the whole studio frame.

const HEIGHT := 1.68
const RiderMeshScript := preload("res://scripts/rider_mesh.gd")
const TRAINER_H := 1.73
const SKIN := Color(0.86, 0.72, 0.60)
const SKIN_M := Color(0.80, 0.64, 0.52)
const NAVY := Color(0.07, 0.08, 0.12)
const BEIGE := Color(0.82, 0.74, 0.56)
const LEATHER := Color(0.22, 0.11, 0.07)
const BLACK := Color(0.05, 0.05, 0.06)
const HAIR := Color(0.62, 0.48, 0.32)
const HAIR_M := Color(0.22, 0.14, 0.10)


static func mounted_madison(host: Node3D, seat: Vector3) -> Node3D:
	var root := Node3D.new()
	root.name = "Rider"
	# On the saddle, not down in the back. The saddle stays where it was.
	var sit := seat + Vector3(0.0, -0.016, 0.030)
	root.position = sit
	host.add_child(root)
	_english_saddle(host, seat + Vector3(0.0, -0.048, -0.024))

	var navy := _part_mat(0.24, 0.51, NAVY, 3.3, 3.7, 0.0, 0.50, 0.32, 0.68, 0.42, 0.60)
	var beige := _part_mat(0.52, 0.76, BEIGE, 3.8, 4.0, -0.02, 0.34, 0.38, 0.64, 0.42, 0.60)
	var black := MeshKit.mat_color(BLACK, 0.28)
	var skin := MeshKit.mat_color(SKIN, 0.52)
	var face := _face_mat()
	var white := MeshKit.mat_color(Color(0.94, 0.94, 0.91), 0.62)
	var tan := MeshKit.leather(Color(0.70, 0.54, 0.34), 0.48)
	var gold := MeshKit.mat_color(Color(0.78, 0.62, 0.28), 0.32, 0.86)
	var boot_m := MeshKit.boot_leather()
	var shirt := MeshKit.mat_color(Color(0.93, 0.93, 0.90), 0.58)

	var body := Node3D.new()
	body.name = "Body"
	body.position = Vector3(0, 0.0, 0.008)
	body.rotation_degrees = Vector3(-13, 0, 0)
	root.add_child(body)

	if _mount_mesh(body):
		_pivot_tree(body)
		return root

	MeshKit.add_child_mi(body, _seated_torso(), navy, "Coat")
	MeshKit.add_child_mi(body, MeshKit.sphere(0.058, 10, 12), navy, "Hip", Vector3(0, 0.002, 0.022)).scale = Vector3(1.18, 0.58, 1.02)
	for sx in [-1.0, 1.0]:
		MeshKit.add_child_mi(body, MeshKit.sphere(0.044, 8, 10), navy, "Scapula", Vector3(sx * 0.074, 0.36, 0.048)).scale = Vector3(0.92, 0.78, 1.22)
	MeshKit.add_child_mi(body, MeshKit.cap(0.034, 0.092), skin, "Neck", Vector3(0, 0.505, 0.004))
	for sx in [-1.0, 1.0]:
		MeshKit.add_child_mi(body, MeshKit.sphere(0.022, 8, 10), navy, "Clavicle", Vector3(sx * 0.062, 0.468, -0.018)).scale = Vector3(1.35, 0.48, 0.72)
	MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.118, 0.038, 0.072)), navy, "Collar", Vector3(0, 0.498, 0.006))
	MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.018, 0.22, 0.008)), shirt, "ShirtPeek", Vector3(0, 0.28, -0.082))
	MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.014, 0.42, 0.008)), navy, "CoatVent", Vector3(0, -0.16, 0.148))
	MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.118, 0.22, 0.036)), navy, "BackPanel", Vector3(0, 0.22, 0.078))
	MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.128, 0.40, 0.072)), navy, "TailSkirt", Vector3(0, -0.18, 0.138), Vector3(0.58, 0.0, 0.0))
	for sx in [-1.0, 1.0]:
		MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.012, 0.11, 0.006)), navy, "Dart", Vector3(sx * 0.038, 0.145, -0.076), Vector3(0.08, 0.0, sx * 0.12))
		MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.008, 0.26, 0.010)), navy, "SideSeam", Vector3(sx * 0.108, 0.22, 0.002))
	MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.132, 0.128, 0.058)), white, "Stock", Vector3(0, 0.448, -0.072))
	MeshKit.add_child_mi(body, MeshKit.sphere(0.010, 6, 6), gold, "StockPin", Vector3(0, 0.418, -0.102))
	var canary := MeshKit.mat_color(Color(0.86, 0.72, 0.38), 0.62)
	MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.118, 0.210, 0.038)), canary, "Vest", Vector3(0, 0.298, -0.074))
	MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.248, 0.028, 0.168)), MeshKit.leather(Color(0.18, 0.10, 0.06), 0.40), "Belt", Vector3(0, 0.078, 0.012))
	MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.038, 0.022, 0.016)), gold, "BeltBuckle", Vector3(0, 0.080, -0.078))
	for sx in [-1.0, 1.0]:
		MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.052, 0.20, 0.022)), navy, "Lapel", Vector3(sx * 0.042, 0.40, -0.070), Vector3(0.10, 0.0, sx * 0.16))
		MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.070, 0.12, 0.032)), navy, "Skirt", Vector3(sx * 0.048, -0.02, 0.070), Vector3(0.22, 0.0, sx * 0.06))
		MeshKit.add_child_mi(body, _coat_tail(sx), navy, "Tail")
		MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.055, 0.062, 0.012)), navy, "Pocket", Vector3(sx * 0.072, 0.155, -0.072))
		MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.058, 0.008, 0.014)), navy, "PocketFlap", Vector3(sx * 0.072, 0.188, -0.074))

	MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.312, 0.048, 0.072)), navy, "Yoke", Vector3(0, 0.438, 0.006))
	for sx in [-1.0, 1.0]:
		MeshKit.add_child_mi(body, MeshKit.sphere(0.042, 10, 12), navy, "Shoulder", Vector3(sx * 0.168, 0.418, 0.004)).scale = Vector3(1.12, 0.78, 1.02)
		MeshKit.add_child_mi(body, MeshKit.sphere(0.022, 8, 10), navy, "Deltoid", Vector3(sx * 0.172, 0.382, -0.008)).scale = Vector3(1.00, 0.68, 0.90)
		# Hunt seat: elbow in at the rib, forearm to the withers — not a T-pose kit.
		MeshKit.add_limb(body, navy, "Arm", Vector3(sx * 0.168, 0.418, 0.004), Vector3(sx * 0.040, 0.302, -0.078), 0.030, 0.022)
		MeshKit.add_child_mi(body, MeshKit.sphere(0.020, 8, 10), navy, "Elbow", Vector3(sx * 0.040, 0.302, -0.078))
		MeshKit.add_limb(body, shirt, "Fore", Vector3(sx * 0.040, 0.302, -0.078), Vector3(sx * 0.000, 0.068, -0.282), 0.020, 0.016)
		MeshKit.add_child_mi(body, MeshKit.cyl(0.018, 0.028, 0.016, 8), navy, "Cuff", Vector3(sx * 0.006, 0.084, -0.268), Vector3(0.95, 0.0, sx * 0.10))
		MeshKit.add_child_mi(body, MeshKit.sphere(0.0032, 5, 6), gold, "CuffBtn", Vector3(sx * 0.016, 0.080, -0.254))
		MeshKit.add_child_mi(body, MeshKit.cyl(0.022, 0.030, 0.018, 8), black, "Gauntlet", Vector3(sx * 0.002, 0.070, -0.274))
		MeshKit.add_child_mi(body, MeshKit.sphere(0.016, 8, 8), black, "Wrist", Vector3(sx * 0.002, 0.068, -0.262))
		_glove(body, black, sx)
		# Closed hip: thigh on the flap, outside the barrel, knee on the roll.
		var hip := Vector3(sx * 0.122, -0.018, -0.012)
		var knee := Vector3(sx * 0.028, -0.148, -0.210)
		var leg := Node3D.new()
		leg.name = "LLeg" if sx < 0.0 else "RLeg"
		leg.position = hip
		body.add_child(leg)
		MeshKit.add_limb(leg, beige, "Thigh", Vector3.ZERO, knee, 0.064, 0.044)
		MeshKit.add_child_mi(leg, MeshKit.sphere(0.038, 8, 10), beige, "HipCap").scale = Vector3(1.48, 0.72, 1.28)
		MeshKit.add_child_mi(leg, MeshKit.sphere(0.046, 8, 10), beige, "ThighPad", Vector3(sx * 0.024, -0.062, -0.086)).scale = Vector3(1.72, 0.68, 1.38)
		MeshKit.add_child_mi(leg, MeshKit.sphere(0.028, 8, 10), beige, "KneeRoll", Vector3(sx * 0.018, -0.142, -0.168)).scale = Vector3(1.22, 0.85, 1.15)
		MeshKit.add_child_mi(leg, MeshKit.box(Vector3(0.048, 0.078, 0.036)), MeshKit.leather(Color(0.62, 0.52, 0.38), 0.55), "KneePatch", Vector3(sx * 0.030, -0.128, -0.048), Vector3(0.55, 0.0, sx * 0.08))
		var shin := Node3D.new()
		shin.name = "LShin" if sx < 0.0 else "RShin"
		shin.position = knee
		leg.add_child(shin)
		MeshKit.add_child_mi(shin, MeshKit.sphere(0.022, 8, 10), beige, "Knee")
		MeshKit.add_limb(shin, boot_m, "Boot", Vector3.ZERO, Vector3(sx * 0.004, -0.338, 0.150), 0.032, 0.024)
		MeshKit.add_child_mi(shin, MeshKit.cyl(0.040, 0.058, 0.032, 10), tan, "BootTop", Vector3(0.0, -0.006, 0.008))
		MeshKit.add_child_mi(shin, MeshKit.sphere(0.038, 8, 10), boot_m, "Calf", Vector3(sx * 0.004, -0.128, 0.068)).scale = Vector3(0.92, 1.58, 0.86)
		MeshKit.add_child_mi(shin, MeshKit.box(Vector3(0.004, 0.22, 0.006)), MeshKit.mat_color(Color(0.38, 0.34, 0.28), 0.36, 0.42), "Zip", Vector3(sx * 0.034, -0.148, 0.058))
		MeshKit.add_child_mi(shin, MeshKit.box(Vector3(0.048, 0.024, 0.122)), boot_m, "Foot", Vector3(sx * 0.004, -0.362, 0.186), Vector3(-1.32, 0.0, 0.0))
		MeshKit.add_child_mi(shin, MeshKit.box(Vector3(0.044, 0.022, 0.036)), boot_m, "Heel", Vector3(sx * 0.004, -0.378, 0.078))
		MeshKit.add_child_mi(shin, MeshKit.box(Vector3(0.028, 0.012, 0.028)), MeshKit.steel(), "Spur", Vector3(sx * 0.004, -0.368, 0.062))
		MeshKit.add_child_mi(shin, MeshKit.cyl(0.0022, 0.028, 0.0022, 6), MeshKit.steel(), "SpurNeck", Vector3(sx * 0.004, -0.368, 0.040), Vector3(1.15, 0.0, 0.0))
	var crop_m := MeshKit.mat_color(Color(0.12, 0.08, 0.05), 0.42)
	MeshKit.add_limb(body, crop_m, "Crop", Vector3(0.006, 0.070, -0.270), Vector3(0.012, -0.056, -0.352), 0.0055, 0.0038)
	MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.018, 0.010, 0.028)), crop_m, "CropKeep", Vector3(0.008, 0.068, -0.278))

	var head := Node3D.new()
	head.name = "Head"
	head.position = Vector3(0, 0.58, 0.010)
	head.rotation_degrees = Vector3(9, 0, 0)
	body.add_child(head)
	_girl_head(head, face, skin, HAIR, true, gold, true)
	return root


static func _pivot_tree(body: Node3D) -> void:
	# Empty pivots. _update_rider pitches these. The mesh reads the angles.
	var head := Node3D.new()
	head.name = "Head"
	head.position = Vector3(0, 0.58, 0.010)
	head.rotation_degrees = Vector3(9, 0, 0)
	body.add_child(head)
	for sx in [-1.0, 1.0]:
		var knee := Vector3(sx * 0.028, -0.148, -0.210)
		var leg := Node3D.new()
		leg.name = "LLeg" if sx < 0.0 else "RLeg"
		leg.position = Vector3(sx * 0.122, -0.018, -0.012)
		body.add_child(leg)
		var shin := Node3D.new()
		shin.name = "LShin" if sx < 0.0 else "RShin"
		shin.position = knee
		leg.add_child(shin)


static func _mount_mesh(body: Node3D) -> bool:
	if not ResourceLoader.exists(RiderMeshScript.GLB):
		return false
	var packed: PackedScene = load(RiderMeshScript.GLB)
	if packed == null:
		return false
	var vis := packed.instantiate()
	vis.name = "Casual"
	# The glb faces +Z. The horse and the seat face -Z, so an unturned
	# mesh looks at the tail. Yaw here, and rider_mesh flips its side
	# signs so her left stays her left.
	vis.rotation_degrees.y = 180.0
	var drv := RiderMeshScript.new()
	drv.name = "RiderMesh"
	drv.silence(vis)
	body.add_child(vis)
	body.add_child(drv)
	drv.setup(vis)
	return true


static func standing_madison() -> Node3D:
	if ResourceLoader.exists(RiderMeshScript.GLB):
		return RiderMeshScript.make_standing("hunt")
	var root := Node3D.new()
	root.name = "Madison"
	_standing_figure(root, HEIGHT, true)
	return root


static func standing_trainer() -> Node3D:
	if ResourceLoader.exists(RiderMeshScript.GLB):
		return RiderMeshScript.make_standing("trainer")
	var root := Node3D.new()
	root.name = "Michelle"
	_standing_figure(root, TRAINER_H, false)
	return root


static func _standing_figure(root: Node3D, height: float, madison: bool) -> void:
	var s := height / HEIGHT
	var navy := MeshKit.mat_color(NAVY if madison else Color(0.16, 0.20, 0.16), 0.55)
	var pants := MeshKit.mat_color(BEIGE if madison else Color(0.42, 0.36, 0.26), 0.7)
	var black := MeshKit.mat_color(BLACK, 0.32)
	var skin := MeshKit.mat_color(SKIN if madison else SKIN_M, 0.58)
	var white := MeshKit.mat_color(Color(0.92, 0.92, 0.90), 0.7)
	var vest := MeshKit.hunt_wool()
	vest.albedo_color = Color(0.22, 0.28, 0.18)
	var gold := MeshKit.mat_color(Color(0.72, 0.58, 0.28), 0.35, 0.85)
	var coat := navy
	if madison:
		coat = _part_mat(0.24, 0.51, NAVY, 3.3, 3.6, 0.0, 0.56, 0.32, 0.68, 0.42, 0.60)
		pants = _part_mat(0.52, 0.76, BEIGE, 3.6, 3.8, 0.0, 0.42, 0.38, 0.64, 0.42, 0.60)
	var face: Material = _face_mat() if madison else skin
	var boot_m := MeshKit.leather(Color(0.10, 0.07, 0.05), 0.34)
	var tan := MeshKit.leather(Color(0.70, 0.54, 0.34), 0.48)

	var torso := MeshKit.add_child_mi(root, _torso_mesh(), coat if madison else vest, "Torso", Vector3(0, 0.90 * s, 0.01))
	torso.scale = Vector3(s, s, s)
	MeshKit.add_child_mi(root, MeshKit.sphere(0.058 * s, 10, 12), coat if madison else vest, "Hip", Vector3(0, 0.92 * s, 0.03 * s)).scale = Vector3(1.55, 0.68, 1.12)
	for sx in [-1.0, 1.0]:
		MeshKit.add_child_mi(root, MeshKit.sphere(0.036 * s, 8, 10), coat if madison else vest, "Scapula", Vector3(sx * 0.072 * s, 1.26 * s, 0.042 * s)).scale = Vector3(0.85, 0.70, 1.15)
	MeshKit.add_child_mi(root, MeshKit.cap(0.034 * s, 0.10 * s), skin, "Neck", Vector3(0, 1.40 * s, 0.012))
	if madison:
		MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.13 * s, 0.042 * s, 0.08 * s)), coat, "Collar", Vector3(0, 1.39 * s, 0.01))
		MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.11 * s, 0.055 * s, 0.026 * s)), white, "Stock", Vector3(0, 1.355 * s, -0.068 * s))
		MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.26 * s, 0.018 * s, 0.18 * s)), MeshKit.leather(Color(0.18, 0.10, 0.06), 0.40), "Belt", Vector3(0, 0.96 * s, 0.01))
		for i in range(3):
			MeshKit.add_child_mi(root, MeshKit.sphere(0.0065 * s, 6, 8), gold, "Btn", Vector3(0, (1.08 + float(i) * 0.08) * s, -0.078 * s))
		for sx in [-1.0, 1.0]:
			MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.074 * s, 0.22 * s, 0.048 * s)), coat, "CoatTail", Vector3(sx * 0.05 * s, 0.78 * s, 0.09 * s), Vector3(0.28, 0.0, sx * 0.08))
	else:
		# Torso loft is the vest. Open the front; do not hang a crate on her.
		MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.14 * s, 0.085 * s, 0.028 * s)), white, "Shirt", Vector3(0, 1.34 * s, -0.074 * s))
		for sx in [-1.0, 1.0]:
			MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.046 * s, 0.30 * s, 0.012 * s)), vest, "VestEdge", Vector3(sx * 0.030 * s, 1.18 * s, -0.080 * s), Vector3(0.10, 0.0, sx * 0.20))
		for i in range(4):
			MeshKit.add_child_mi(root, MeshKit.sphere(0.0055 * s, 6, 8), gold, "VestBtn", Vector3(0, (1.06 + float(i) * 0.068) * s, -0.082 * s))
		MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.26 * s, 0.016 * s, 0.15 * s)), MeshKit.leather(Color(0.28, 0.18, 0.10), 0.48), "Belt", Vector3(0, 0.98 * s, 0.01))
		MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.032 * s, 0.016 * s, 0.014 * s)), gold, "BeltBuckle", Vector3(0, 0.98 * s, -0.072 * s))
		for sx in [-1.0, 1.0]:
			MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.058 * s, 0.062 * s, 0.012 * s)), vest, "VestPocket", Vector3(sx * 0.072 * s, 1.08 * s, -0.078 * s))
			MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.062 * s, 0.010 * s, 0.014 * s)), vest, "VestFlap", Vector3(sx * 0.072 * s, 1.12 * s, -0.080 * s))
		var clip := MeshKit.mat_color(Color(0.86, 0.82, 0.72), 0.55)
		MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.16 * s, 0.22 * s, 0.012 * s)), clip, "Board", Vector3(0.12 * s, 1.02 * s, 0.16 * s), Vector3(0.35, 0.15, -0.40))
		MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.14 * s, 0.18 * s, 0.004 * s)), MeshKit.mat_color(Color(0.94, 0.93, 0.88), 0.72), "Paper", Vector3(0.12 * s, 1.02 * s, 0.168 * s), Vector3(0.35, 0.15, -0.40))
		MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.018 * s, 0.012 * s, 0.028 * s)), MeshKit.steel(), "Clip", Vector3(0.12 * s, 1.12 * s, 0.16 * s), Vector3(0.35, 0.15, -0.40))
		MeshKit.add_child_mi(root, MeshKit.cyl(0.003 * s, 0.14 * s, 0.0025 * s, 6), MeshKit.mat_color(Color(0.72, 0.58, 0.22), 0.40), "Pencil", Vector3(0.18 * s, 1.04 * s, 0.18 * s), Vector3(0.55, 0.20, -0.35))

	for sx in [-1.0, 1.0]:
		MeshKit.add_child_mi(root, MeshKit.sphere(0.046 * s, 10, 12), coat if madison else vest, "Shoulder", Vector3(sx * 0.16 * s, 1.32 * s, 0.0))
		if madison:
			MeshKit.add_limb(root, coat, "Arm", Vector3(sx * 0.16 * s, 1.30 * s, 0.0), Vector3(sx * 0.18 * s, 1.04 * s, 0.02 * s), 0.034 * s, 0.026 * s)
			MeshKit.add_child_mi(root, MeshKit.sphere(0.022 * s, 8, 10), coat, "Elbow", Vector3(sx * 0.18 * s, 1.04 * s, 0.02 * s))
			MeshKit.add_limb(root, coat, "Fore", Vector3(sx * 0.18 * s, 1.04 * s, 0.02 * s), Vector3(sx * 0.16 * s, 0.80 * s, 0.01 * s), 0.024 * s, 0.020 * s)
			MeshKit.add_child_mi(root, MeshKit.sphere(0.026 * s, 8, 10), black, "Hand", Vector3(sx * 0.16 * s, 0.78 * s, 0.01 * s))
		else:
			MeshKit.add_limb(root, vest, "Arm", Vector3(sx * 0.16 * s, 1.30 * s, 0.0), Vector3(sx * 0.14 * s, 1.10 * s, 0.08 * s), 0.034 * s, 0.026 * s)
			MeshKit.add_child_mi(root, MeshKit.sphere(0.022 * s, 8, 10), vest, "Elbow", Vector3(sx * 0.14 * s, 1.10 * s, 0.08 * s))
			MeshKit.add_limb(root, MeshKit.mat_color(Color(0.90, 0.88, 0.82), 0.7), "Fore", Vector3(sx * 0.14 * s, 1.10 * s, 0.08 * s), Vector3(sx * 0.04 * s, 0.96 * s, 0.18 * s), 0.024 * s, 0.020 * s)
			MeshKit.add_child_mi(root, MeshKit.sphere(0.026 * s, 8, 10), skin, "Hand", Vector3(sx * 0.035 * s, 0.94 * s, 0.19 * s))
		MeshKit.add_limb(root, pants, "Thigh", Vector3(sx * 0.068 * s, 0.90 * s, 0.004), Vector3(sx * 0.070 * s, 0.50 * s, 0.012), 0.050 * s, 0.040 * s)
		if madison:
			MeshKit.add_limb(root, boot_m, "Shin", Vector3(sx * 0.070 * s, 0.50 * s, 0.012), Vector3(sx * 0.070 * s, 0.10 * s, 0.018), 0.034 * s, 0.028 * s)
			MeshKit.add_child_mi(root, MeshKit.cyl(0.036 * s, 0.048 * s, 0.032 * s, 10), tan, "BootTop", Vector3(sx * 0.070 * s, 0.48 * s, 0.012))
			MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.078 * s, 0.046 * s, 0.176 * s)), boot_m, "Foot", Vector3(sx * 0.070 * s, 0.038 * s, -0.028 * s))
		else:
			var boot_t := MeshKit.boot_leather()
			MeshKit.add_limb(root, boot_t, "Shin", Vector3(sx * 0.070 * s, 0.52 * s, 0.012), Vector3(sx * 0.070 * s, 0.08 * s, 0.020), 0.036 * s, 0.026 * s)
			MeshKit.add_child_mi(root, MeshKit.cyl(0.040 * s, 0.085 * s, 0.034 * s, 10), MeshKit.leather(Color(0.62, 0.48, 0.28), 0.50), "BootTop", Vector3(sx * 0.070 * s, 0.50 * s, 0.012))
			MeshKit.add_child_mi(root, MeshKit.sphere(0.032 * s, 8, 10), boot_t, "Calf", Vector3(sx * 0.070 * s, 0.32 * s, 0.028 * s)).scale = Vector3(0.88, 1.35, 0.80)
			MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.078 * s, 0.046 * s, 0.176 * s)), black, "Foot", Vector3(sx * 0.070 * s, 0.038 * s, -0.028 * s))
			MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.022 * s, 0.008 * s, 0.026 * s)), MeshKit.steel(), "Spur", Vector3(sx * 0.070 * s, 0.06 * s, 0.055 * s))

	var head := Node3D.new()
	head.position = Vector3(0, 1.50 * s, 0.01)
	head.scale = Vector3(s, s, s)
	root.add_child(head)
	_girl_head(head, face, skin, HAIR if madison else HAIR_M, madison, gold, madison)

	if not madison:
		MeshKit.add_limb(root, MeshKit.mat_color(Color(0.12, 0.08, 0.05), 0.45), "Crop", Vector3(-0.12 * s, 0.98 * s, 0.14 * s), Vector3(-0.16 * s, 0.52 * s, 0.26 * s), 0.007, 0.005)
		MeshKit.add_child_mi(root, MeshKit.cyl(0.014 * s, 0.012 * s, 0.014 * s, 8), MeshKit.mat_color(Color(0.18, 0.16, 0.12), 0.40, 0.35), "Watch", Vector3(0.14 * s, 1.10 * s, 0.08 * s))


static func _girl_head(head: Node3D, face_mat: Material, skin: Material, hair_c: Color, helmet: bool, gold: Material, photo_face: bool) -> void:
	var hair := MeshKit.mat_color(hair_c, 0.58)
	var black := MeshKit.mat_color(BLACK, 0.28)
	var white := MeshKit.mat_color(Color(0.94, 0.94, 0.92), 0.38)
	var iris := MeshKit.mat_color(Color(0.38, 0.48, 0.52), 0.28)
	var lip := MeshKit.mat_color(Color(0.70, 0.42, 0.40), 0.42)
	if photo_face:
		MeshKit.add_child_mi(head, _head_mesh(), face_mat, "Skull")
		# Plates carry eyes, brows, mouth. Only a soft nose and jaw for silhouette.
		MeshKit.add_child_mi(head, MeshKit.sphere(0.010, 8, 10), face_mat, "Nose", Vector3(0, -0.006, -0.090)).scale = Vector3(0.36, 1.12, 1.42)
		var jaw := MeshKit.add_child_mi(head, MeshKit.sphere(0.044, 10, 12), face_mat, "Jaw", Vector3(0, -0.052, 0.002))
		jaw.scale = Vector3(0.78, 0.56, 0.70)
		MeshKit.add_child_mi(head, MeshKit.sphere(0.010, 7, 8), face_mat, "Chin", Vector3(0, -0.070, -0.040)).scale = Vector3(1.08, 0.36, 0.70)
		for sx in [-1.0, 1.0]:
			MeshKit.add_child_mi(head, MeshKit.sphere(0.014, 8, 10), face_mat, "Cheek", Vector3(sx * 0.046, -0.010, -0.046)).scale = Vector3(0.82, 0.56, 0.84)
			MeshKit.add_child_mi(head, MeshKit.sphere(0.018, 8, 10), skin, "Ear", Vector3(sx * 0.082, -0.002, 0.008)).scale = Vector3(0.34, 1.08, 0.58)
			MeshKit.add_child_mi(head, MeshKit.sphere(0.020, 7, 8), hair, "Temple", Vector3(sx * 0.058, 0.022, 0.004)).scale = Vector3(0.78, 0.92, 1.12)
			MeshKit.add_child_mi(head, MeshKit.sphere(0.016, 6, 8), hair, "Lock", Vector3(sx * 0.054, 0.008, -0.022)).scale = Vector3(0.62, 0.95, 0.88)
	else:
		var skull := MeshKit.add_child_mi(head, MeshKit.sphere(0.088, 16, 20), face_mat, "Skull")
		skull.scale = Vector3(0.92, 1.08, 0.96)
		var jaw := MeshKit.add_child_mi(head, MeshKit.sphere(0.078, 12, 14), face_mat, "Jaw", Vector3(0, -0.038, 0.012))
		jaw.scale = Vector3(0.82, 0.70, 0.80)
		MeshKit.add_child_mi(head, MeshKit.sphere(0.016, 8, 10), skin, "Nose", Vector3(0, -0.008, -0.082)).scale = Vector3(0.65, 1.20, 1.35)
		MeshKit.add_child_mi(head, MeshKit.sphere(0.018, 8, 8), lip, "Mouth", Vector3(0, -0.040, -0.076)).scale = Vector3(1.35, 0.45, 0.70)
		for sx in [-1.0, 1.0]:
			MeshKit.add_child_mi(head, MeshKit.sphere(0.015, 8, 10), white, "Eye", Vector3(sx * 0.028, 0.014, -0.074))
			MeshKit.add_child_mi(head, MeshKit.sphere(0.008, 6, 8), iris, "Iris", Vector3(sx * 0.028, 0.014, -0.086))
			MeshKit.add_child_mi(head, MeshKit.sphere(0.0035, 5, 6), black, "Pupil", Vector3(sx * 0.028, 0.014, -0.091))
			MeshKit.add_child_mi(head, MeshKit.box(Vector3(0.026, 0.005, 0.007)), hair, "Brow", Vector3(sx * 0.028, 0.030, -0.080))
			MeshKit.add_child_mi(head, MeshKit.sphere(0.020, 8, 10), skin, "Ear", Vector3(sx * 0.086, 0.000, -0.006)).scale = Vector3(0.40, 1.05, 0.65)
	if helmet:
		var velvet := MeshKit.velvet()
		# Crown only — peak stays above the brows, not over the eyes.
		var helm := MeshKit.add_child_mi(head, MeshKit.sphere(0.090, 16, 20), velvet, "Helmet", Vector3(0, 0.114, 0.012))
		helm.scale = Vector3(1.00, 0.28, 1.04)
		MeshKit.add_child_mi(head, MeshKit.cyl(0.088, 0.020, 0.080, 16), velvet, "HelmBand", Vector3(0, 0.082, 0.010))
		MeshKit.add_child_mi(head, MeshKit.box(Vector3(0.076, 0.003, 0.016)), velvet, "Peak", Vector3(0, 0.094, -0.052))
		MeshKit.add_child_mi(head, MeshKit.sphere(0.006, 6, 6), gold if gold else velvet, "HelmBtn", Vector3(0, 0.084, 0.086))
		MeshKit.add_child_mi(head, MeshKit.box(Vector3(0.018, 0.028, 0.004)), MeshKit.mat_color(Color(0.72, 0.14, 0.16), 0.48), "HelmRibbon", Vector3(0, 0.066, 0.092))
		MeshKit.add_child_mi(head, MeshKit.cyl(0.048, 0.032, 0.042, 14), MeshKit.mat_color(Color(0.07, 0.06, 0.06, 0.82), 0.84), "Net", Vector3(0, 0.014, 0.054))
		MeshKit.add_child_mi(head, MeshKit.sphere(0.042, 8, 10), hair, "Bun", Vector3(0, 0.002, 0.092)).scale = Vector3(1.28, 0.78, 0.98)
		MeshKit.add_child_mi(head, MeshKit.box(Vector3(0.088, 0.005, 0.005)), velvet, "Harness", Vector3(0, -0.022, -0.004))
		if gold:
			MeshKit.add_child_mi(head, MeshKit.sphere(0.005, 6, 6), gold, "Buckle", Vector3(0, -0.054, -0.014))
		for sx in [-1.0, 1.0]:
			MeshKit.add_limb(head, velvet, "Chin", Vector3(sx * 0.048, 0.012, 0.008), Vector3(sx * 0.012, -0.056, -0.014), 0.0030, 0.0024)
			MeshKit.add_child_mi(head, MeshKit.sphere(0.022, 7, 8), hair, "Nape", Vector3(sx * 0.044, -0.012, 0.052)).scale = Vector3(0.78, 0.88, 1.12)
	else:
		# Hair sits behind the face. A wrapping sphere read as a brown blob from C.
		MeshKit.add_child_mi(head, MeshKit.sphere(0.068, 12, 14), hair, "Hair", Vector3(0, 0.028, 0.052)).scale = Vector3(1.08, 0.88, 1.12)
		MeshKit.add_child_mi(head, MeshKit.sphere(0.048, 8, 10), hair, "BobL", Vector3(-0.058, -0.012, 0.048)).scale = Vector3(0.70, 1.12, 0.92)
		MeshKit.add_child_mi(head, MeshKit.sphere(0.048, 8, 10), hair, "BobR", Vector3(0.058, -0.012, 0.048)).scale = Vector3(0.70, 1.12, 0.92)
		var cap := MeshKit.velvet()
		MeshKit.add_child_mi(head, MeshKit.cyl(0.078, 0.028, 0.068, 14), cap, "Cap", Vector3(0, 0.092, 0.016))
		MeshKit.add_child_mi(head, MeshKit.box(Vector3(0.10, 0.006, 0.042)), cap, "Peak", Vector3(0, 0.082, -0.048))


static func _head_mesh() -> ArrayMesh:
	var stations: Array = []
	stations.append(MeshKit.station(Vector3(0, 0.074, 0.008), 0.034, 0.038, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, 0.046, -0.004), 0.068, 0.060, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, 0.018, -0.018), 0.076, 0.070, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, -0.002, -0.026), 0.074, 0.080, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, -0.022, -0.016), 0.066, 0.074, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, -0.046, -0.006), 0.052, 0.062, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, -0.070, 0.008), 0.028, 0.036, Vector3.UP))
	return MeshKit.loft(stations, 24)


static func _torso_mesh() -> ArrayMesh:
	var stations: Array = []
	stations.append(MeshKit.station(Vector3(0, 0.00, 0.012), 0.145, 0.100, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, 0.10, 0.004), 0.118, 0.086, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, 0.22, 0.012), 0.138, 0.100, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, 0.36, 0.008), 0.148, 0.088, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, 0.48, 0.000), 0.160, 0.076, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, 0.56, 0.000), 0.058, 0.052, Vector3.UP))
	return MeshKit.loft(stations, 18)


static func _seated_torso() -> ArrayMesh:
	var stations: Array = []
	stations.append(MeshKit.station(Vector3(0, 0.00, 0.038), 0.094, 0.086, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, 0.055, 0.026), 0.070, 0.066, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, 0.125, 0.014), 0.074, 0.068, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, 0.24, 0.002), 0.118, 0.080, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, 0.35, -0.010), 0.152, 0.070, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, 0.45, -0.018), 0.178, 0.058, Vector3.UP))
	stations.append(MeshKit.station(Vector3(0, 0.51, -0.020), 0.048, 0.038, Vector3.UP))
	return MeshKit.loft(stations, 20)


static func _coat_tail(sx: float) -> ArrayMesh:
	# Hunt tails hang past the cantle from the saddle camera, split by the vent.
	var stations: Array = []
	stations.append(MeshKit.station(Vector3(sx * 0.022, 0.018, 0.088), 0.034, 0.018, Vector3(0, -0.28, 1)))
	stations.append(MeshKit.station(Vector3(sx * 0.024, -0.14, 0.142), 0.038, 0.016, Vector3(0, -0.55, 1)))
	stations.append(MeshKit.station(Vector3(sx * 0.022, -0.32, 0.198), 0.032, 0.014, Vector3(0, -0.78, 1)))
	stations.append(MeshKit.station(Vector3(sx * 0.020, -0.50, 0.248), 0.026, 0.010, Vector3(0, -0.95, 1)))
	return MeshKit.loft(stations, 12)


static func _saddle_flap(sx: float, thick: float, drop: float, chord: float) -> ArrayMesh:
	# Thin panel: loft along the shoulder, not a door box.
	var stations: Array = []
	stations.append(MeshKit.station(Vector3(sx * 0.30, 0.038, -0.018), thick, chord * 0.36, Vector3(0, -0.12, 1)))
	stations.append(MeshKit.station(Vector3(sx * 0.36, -0.028, -0.072), thick * 1.08, chord * 0.50, Vector3(0, -0.42, 1)))
	stations.append(MeshKit.station(Vector3(sx * 0.34, -drop * 0.52, -0.018), thick, chord * 0.46, Vector3(0, -0.68, 1)))
	stations.append(MeshKit.station(Vector3(sx * 0.32, -drop, 0.042), thick * 0.68, chord * 0.30, Vector3(0, -0.92, 1)))
	return MeshKit.loft(stations, 12)


static func _english_saddle(host: Node3D, seat: Vector3) -> void:
	if host.get_node_or_null("Saddle"):
		return
	var leather := MeshKit.leather(Color(0.38, 0.20, 0.11), 0.40)
	var dark := MeshKit.leather_sweat()
	var suede := MeshKit.leather(Color(0.62, 0.40, 0.22), 0.62)
	var pale := MeshKit.leather(Color(0.52, 0.32, 0.18), 0.55)
	var pad_m := MeshKit.pad_fabric()
	var steel := MeshKit.steel()
	var root := Node3D.new()
	root.name = "Saddle"
	# Sit her in the seat, not on a crate: tree sits just above the withers pad.
	root.position = seat + Vector3(0.0, -0.012, 0.006)
	host.add_child(root)
	# Two quilted panels, gullet open at the withers.
	for sx in [-1.0, 1.0]:
		MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.155, 0.020, 0.48)), pad_m, "Pad", Vector3(sx * 0.098, -0.038, 0.018))
	MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.36, 0.005, 0.50)), dark, "Piping", Vector3(0, -0.026, 0.018))
	var stitch := MeshKit.mat_color(Color(0.82, 0.78, 0.70), 0.55)
	for i in range(6):
		var qz := -0.18 + float(i) * 0.072
		for sx in [-1.0, 1.0]:
			MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.128, 0.003, 0.008)), stitch, "Quilt", Vector3(sx * 0.098, -0.026, qz))
	for i in range(3):
		MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.007, 0.003, 0.40)), stitch, "QuiltX", Vector3(-0.12 + float(i) * 0.12, -0.026, 0.018))
	# Close-contact tree: pinched waist, pommel up, cantle dish a hip can sit in.
	var stations: Array = []
	stations.append(MeshKit.station(Vector3(0, 0.138, -0.225), 0.028, 0.036, Vector3(0, 0.18, 1)))
	stations.append(MeshKit.station(Vector3(0, 0.078, -0.128), 0.046, 0.030, Vector3(0, 0.06, 1)))
	stations.append(MeshKit.station(Vector3(0, 0.026, -0.018), 0.058, 0.024, Vector3(0, 0, 1)))
	stations.append(MeshKit.station(Vector3(0, 0.022, 0.082), 0.100, 0.036, Vector3(0, 0.02, 1)))
	stations.append(MeshKit.station(Vector3(0, 0.096, 0.188), 0.074, 0.030, Vector3(0, 0.30, 1)))
	stations.append(MeshKit.station(Vector3(0, 0.172, 0.270), 0.040, 0.020, Vector3(0, 0.50, 1)))
	MeshKit.add_child_mi(root, MeshKit.loft(stations, 18), leather, "Seat")
	var suede_st: Array = []
	suede_st.append(MeshKit.station(Vector3(0, 0.088, -0.108), 0.034, 0.022, Vector3(0, 0.06, 1)))
	suede_st.append(MeshKit.station(Vector3(0, 0.034, -0.008), 0.046, 0.020, Vector3(0, 0, 1)))
	suede_st.append(MeshKit.station(Vector3(0, 0.030, 0.082), 0.082, 0.028, Vector3(0, 0.02, 1)))
	suede_st.append(MeshKit.station(Vector3(0, 0.090, 0.172), 0.054, 0.022, Vector3(0, 0.28, 1)))
	MeshKit.add_child_mi(root, MeshKit.loft(suede_st, 14), suede, "Suede")
	MeshKit.add_child_mi(root, MeshKit.sphere(0.048, 10, 12), leather, "Pommel", Vector3(0, 0.150, -0.230)).scale = Vector3(0.70, 0.88, 1.16)
	MeshKit.add_child_mi(root, MeshKit.sphere(0.056, 10, 12), leather, "Cantle", Vector3(0, 0.182, 0.268)).scale = Vector3(1.36, 0.40, 0.56)
	MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.026, 0.016, 0.14)), dark, "Gullet", Vector3(0, 0.010, -0.14))
	# English girth: a strap under the barrel. Tree sits on the back now.
	for sx in [-1.0, 1.0]:
		MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.010, 0.42, 0.046)), dark, "GirthSide", Vector3(sx * 0.33, -0.28, 0.042))
	MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.66, 0.012, 0.048)), dark, "GirthBelly", Vector3(0, -0.50, 0.042))
	MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.10, 0.010, 0.044)), MeshKit.mat_color(Color(0.12, 0.12, 0.12), 0.62), "GirthElastic", Vector3(0, -0.512, 0.042))
	var rubber := MeshKit.mat_color(Color(0.08, 0.08, 0.08), 0.72)
	for sx in [-1.0, 1.0]:
		MeshKit.add_child_mi(root, _saddle_flap(sx, 0.013, 0.22, 0.175), pale, "Sweat")
		MeshKit.add_child_mi(root, _saddle_flap(sx, 0.010, 0.195, 0.150), leather, "Flap")
		MeshKit.add_child_mi(root, MeshKit.sphere(0.036, 10, 12), leather, "Knee", Vector3(sx * 0.36, 0.010, -0.110)).scale = Vector3(0.70, 1.32, 1.52)
		MeshKit.add_child_mi(root, MeshKit.sphere(0.030, 8, 10), MeshKit.leather(Color(0.28, 0.14, 0.08), 0.62), "KneeSuede", Vector3(sx * 0.37, 0.014, -0.098)).scale = Vector3(0.62, 1.18, 1.32)
		MeshKit.add_rod(root, dark, "StirrupLeather", Vector3(sx * 0.34, -0.02, 0.02), Vector3(sx * 0.45, -0.37, 0.05), 0.0055)
		for i in range(3):
			var by := -0.08 - float(i) * 0.042
			MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.007, 0.10, 0.006)), dark, "Billet", Vector3(sx * 0.118, by, 0.055))
		# Iron under the ball of the boot, not a crate rung.
		MeshKit.add_child_mi(root, MeshKit.torus(0.026, 0.034), steel, "Iron", Vector3(sx * 0.45, -0.378, 0.055), Vector3(1.45, 0, sx * 0.08))
		MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.044, 0.008, 0.020)), rubber, "Tread", Vector3(sx * 0.45, -0.395, 0.055))
		MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.014, 0.010, 0.009)), steel, "Buckle", Vector3(sx * 0.118, -0.20, 0.05))
		MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.016, 0.048, 0.009)), leather, "Keeper", Vector3(sx * 0.150, -0.01, 0.05))
		MeshKit.add_child_mi(root, MeshKit.box(Vector3(0.016, 0.006, 0.012)), steel, "Bar", Vector3(sx * 0.108, 0.052, -0.018))


static func _part_mat(v0: float, v1: float, fallback: Color, width_scale: float, depth_scale: float, y0: float = 0.0, y1: float = 1.0, u0: float = 0.32, u1: float = 0.68, su0: float = 0.42, su1: float = 0.60) -> Material:
	if not ResourceLoader.exists("res://shaders/person.gdshader"):
		return _kit_fallback(fallback)
	if not ResourceLoader.exists("res://assets/textures/rider_front.jpg"):
		return _kit_fallback(fallback)
	var m := ShaderMaterial.new()
	m.shader = load("res://shaders/person.gdshader")
	m.set_shader_parameter("front_tex", load("res://assets/textures/rider_front.jpg"))
	m.set_shader_parameter("side_tex", load("res://assets/textures/rider_side.jpg"))
	m.set_shader_parameter("back_tex", load("res://assets/textures/rider_back.jpg"))
	m.set_shader_parameter("v_range", Vector2(v0, v1))
	m.set_shader_parameter("y_range", Vector2(y0, y1))
	m.set_shader_parameter("u_range", Vector2(u0, u1))
	m.set_shader_parameter("side_u_range", Vector2(su0, su1))
	m.set_shader_parameter("width_scale", width_scale)
	m.set_shader_parameter("depth_scale", depth_scale)
	m.set_shader_parameter("fallback_color", Vector3(fallback.r, fallback.g, fallback.b))
	return m


static func _kit_fallback(fallback: Color) -> Material:
	if fallback.b > fallback.r + 0.04:
		var w := MeshKit.hunt_wool()
		w.albedo_color = fallback
		return w
	if fallback.g > fallback.b:
		var p := MeshKit.pad_fabric()
		p.albedo_color = fallback
		return p
	return MeshKit.mat_color(fallback, 0.55)


static func _glove(body: Node3D, black: Material, sx: float) -> void:
	# Closed fist on the withers. Fingers curl under; crop stays in the right.
	var palm_p := Vector3(sx * 0.004, 0.064, -0.278)
	var palm := MeshKit.add_child_mi(body, MeshKit.box(Vector3(0.034, 0.024, 0.040)), black, "GloveL" if sx < 0.0 else "GloveR", palm_p, Vector3(0.42, 0.0, sx * 0.10))
	MeshKit.add_child_mi(body, MeshKit.sphere(0.016, 8, 8), black, "PalmHeel", palm_p + Vector3(0.0, -0.004, 0.012)).scale = Vector3(1.15, 0.78, 0.88)
	for i in range(4):
		var ox := sx * (0.0072 * (float(i) - 1.5))
		MeshKit.add_child_mi(body, MeshKit.sphere(0.0058, 6, 6), black, "Knuckle", palm_p + Vector3(ox, 0.012, -0.010))
		MeshKit.add_limb(
			body, black, "Finger",
			palm_p + Vector3(ox, 0.006, -0.016),
			palm_p + Vector3(ox, -0.012, -0.004),
			0.0042, 0.0034
		)
	MeshKit.add_limb(
		body, black, "Thumb",
		palm_p + Vector3(-sx * 0.014, 0.006, 0.004),
		palm_p + Vector3(-sx * 0.010, -0.010, -0.014),
		0.0050, 0.0038
	)
	var mark := Marker3D.new()
	mark.name = "LGlove" if sx < 0.0 else "RGlove"
	mark.position = palm_p
	body.add_child(mark)


static func _face_mat() -> Material:
	if not ResourceLoader.exists("res://shaders/madison_face.gdshader"):
		return MeshKit.mat_color(SKIN, 0.52)
	var front_p := "res://assets/textures/rider_face_front.jpg"
	var side_p := "res://assets/textures/rider_face_side.jpg"
	if not ResourceLoader.exists(front_p):
		front_p = "res://assets/textures/rider_front.jpg"
	if not ResourceLoader.exists(side_p):
		side_p = "res://assets/textures/rider_side.jpg"
	var m := ShaderMaterial.new()
	m.shader = load("res://shaders/madison_face.gdshader")
	m.set_shader_parameter("front_tex", load(front_p))
	m.set_shader_parameter("side_tex", load(side_p))
	# Skip visor. Keep brows through mouth. Same girl.
	m.set_shader_parameter("front_win", Vector4(0.18, 0.24, 0.64, 0.62))
	m.set_shader_parameter("side_win", Vector4(0.12, 0.18, 0.50, 0.68))
	m.set_shader_parameter("y_span", Vector2(-0.072, 0.036))
	m.set_shader_parameter("fallback_color", Vector3(SKIN.r, SKIN.g, SKIN.b))
	m.set_shader_parameter("hair_color", Vector3(HAIR.r, HAIR.g, HAIR.b))
	return m
