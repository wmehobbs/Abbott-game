extends CharacterBody3D
class_name Walker

var active: bool = false
var cam: Camera3D
var yaw: float = 0.0
var pitch: float = 0.0
var body: Node3D
var _was_active: bool = false
var _held: bool = false


func _ready() -> void:
	physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_ON
	collision_layer = 1
	collision_mask = 2
	var cap := CollisionShape3D.new()
	var sh := CapsuleShape3D.new()
	sh.radius = 0.22
	sh.height = 1.6
	cap.shape = sh
	cap.position.y = 0.8
	add_child(cap)
	# Same mesh as the saddle, standing. Hidden until C so the ring
	# does not show two of her. Enter still mounts. The clock stays
	# on the flags.
	body = _madison()
	body.visible = false
	add_child(body)
	cam = Camera3D.new()
	cam.fov = 58.0
	cam.position = Vector3(0.35, 1.85, 2.45)
	add_child(cam)
	floor_snap_length = 0.3


func _physics_process(delta: float) -> void:
	if active and not _was_active:
		if _held:
			_held = false
		else:
			_step_off()
		if body:
			body.visible = true
	if not active and _was_active:
		if GameState.ui_paused:
			_held = true
		elif body:
			body.visible = false
	_was_active = active
	if not active:
		velocity = Vector3.ZERO
		return
	var input := Vector3.ZERO
	if Input.is_action_pressed("gait_up"):
		input.z -= 1.0
	if Input.is_action_pressed("gait_down"):
		input.z += 1.0
	if Input.is_action_pressed("turn_left"):
		input.x -= 1.0
	if Input.is_action_pressed("turn_right"):
		input.x += 1.0
	input = input.normalized()
	var basis_yaw := Basis(Vector3.UP, yaw)
	var dir := basis_yaw * Vector3(input.x, 0, input.z)
	var speed := 2.4
	velocity.x = dir.x * speed
	velocity.z = dir.z * speed
	if not is_on_floor():
		velocity.y -= 18.0 * delta
	else:
		velocity.y = 0.0
	move_and_slide()
	rotation.y = yaw
	cam.rotation.x = pitch * 0.35


func _madison() -> Node3D:
	const MeshScript := preload("res://scripts/rider_mesh.gd")
	if ResourceLoader.exists(MeshScript.GLB):
		return MeshScript.make_standing("hunt")
	var n := Node3D.new()
	n.name = "Madison"
	return n


func _step_off() -> void:
	var n := get_tree().get_first_node_in_group("abbott")
	if not (n is Node3D):
		return
	var horse := n as Node3D
	var side := horse.global_transform.basis.x
	var p := horse.global_position + side * 1.35
	p.y = 0.0
	global_position = p
	yaw = horse.rotation.y


func _input(event: InputEvent) -> void:
	if not active:
		return
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		yaw -= event.relative.x * 0.0035
		pitch = clamp(pitch - event.relative.y * 0.0035, -1.1, 0.6)
