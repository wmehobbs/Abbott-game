extends Node3D

## Her ribbon on his bridle. After a show round that wins one, the rosette
## is pinned where the browband meets the cheekpiece on his near side, in the
## colour she won, and it stays until the next round starts.

const COLORS := {
	"Blue": Color(0.12, 0.26, 0.66),
	"Red": Color(0.72, 0.10, 0.12),
	"Yellow": Color(0.92, 0.76, 0.16),
	"White": Color(0.94, 0.94, 0.92),
	"Pink": Color(0.92, 0.52, 0.66),
}

var horse: Node3D
var _petal: StandardMaterial3D
var _shown := ""
## His head bone as drawn. Read straight off the skeleton in _process it is
## the clip before the bascule, and a worried horse's lifted neck left the
## rosette down on his noseband.
var _poll_att: BoneAttachment3D


## Builds the palm-sized rosette and keeps it hidden until a round wins one.
func _ready() -> void:
	top_level = true
	visible = false
	_petal = StandardMaterial3D.new()
	_petal.roughness = 0.55
	var gold := StandardMaterial3D.new()
	gold.albedo_color = Color(0.86, 0.70, 0.30)
	gold.roughness = 0.35
	gold.metallic = 0.5
	# Pleated ring, a centre button and two tails, about the size of a palm.
	var ring := MeshInstance3D.new()
	var rm := CylinderMesh.new()
	rm.top_radius = 0.040
	rm.bottom_radius = 0.044
	rm.height = 0.008
	rm.radial_segments = 16
	ring.mesh = rm
	ring.material_override = _petal
	ring.rotation_degrees = Vector3(90, 0, 0)
	add_child(ring)
	var button := MeshInstance3D.new()
	var bm := CylinderMesh.new()
	bm.top_radius = 0.018
	bm.bottom_radius = 0.018
	bm.height = 0.012
	bm.radial_segments = 12
	button.mesh = bm
	button.material_override = gold
	button.rotation_degrees = Vector3(90, 0, 0)
	button.position = Vector3(0, 0, 0.004)
	add_child(button)
	for sx in [-1.0, 1.0]:
		var tail := MeshInstance3D.new()
		var tb := BoxMesh.new()
		tb.size = Vector3(0.020, 0.075, 0.003)
		tail.mesh = tb
		tail.material_override = _petal
		tail.position = Vector3(sx * 0.012, -0.060, -0.002)
		tail.rotation_degrees = Vector3(0, 0, sx * 12.0)
		add_child(tail)


## Pins it on the near cheekpiece after a ribbon, in that colour, until the next round.
func _process(_delta: float) -> void:
	var gs := get_node_or_null("/root/GameState")
	if gs == null or horse == null:
		return
	var sk := horse.get("skel") as Skeleton3D
	if sk != null and (_poll_att == null or not is_instance_valid(_poll_att)) and sk.find_bone("Head") >= 0:
		_poll_att = BoneAttachment3D.new()
		_poll_att.name = "RosettePoll"
		_poll_att.bone_name = "Head"
		sk.add_child(_poll_att)
	var ribbon := str(gs.get("last_ribbon"))
	var on := bool(gs.get("round_complete")) and COLORS.has(ribbon)
	visible = on
	if not on:
		_shown = ""
		return
	if ribbon != _shown:
		_shown = ribbon
		_petal.albedo_color = COLORS[ribbon]
	var bit := horse.get("bit_l") as Node3D
	if _poll_att == null or not is_instance_valid(_poll_att) or bit == null:
		return
	# The head bone sits at his poll; the bit ring at the corner of his mouth.
	# Both as drawn, after the bascule.
	var poll := _poll_att.global_position
	var mouth := bit.global_position
	var near := -horse.global_transform.basis.x.normalized()
	var down := (mouth - poll)
	var p := poll + down * 0.11 + near * 0.125
	var face := near
	var up := (-down).normalized()
	up = (up - face * up.dot(face)).normalized()
	var right := up.cross(face).normalized()
	global_transform = Transform3D(Basis(right, up, face), p)
