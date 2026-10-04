extends Node
class_name ArtShot

var cam: Camera3D
var horse: Horse


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	await get_tree().process_frame
	await get_tree().create_timer(0.8).timeout
	var arena := get_parent()
	horse = arena.get_node_or_null("Abbott")
	if horse == null:
		print("ARTSHOT missing horse")
		get_tree().quit(1)
		return
	horse.controllable = true
	horse.set_mounted(true)
	horse.global_position = Vector3(0, 0, -8)
	horse.rotation.y = PI
	if horse.rider:
		print("ARTSHOT rider_local=", horse.rider.position, " rider_parent=", horse.rider.get_parent().name, " seat_bone=", horse.seat_bone)
	if horse.cam:
		print("ARTSHOT play_cam=", horse.cam.global_position, " horse=", horse.global_position)
	var origin := horse.global_position
	var right := horse.global_transform.basis.x
	var fwd := -horse.global_transform.basis.z

	# What Dad sees: the real chase camera, walking.
	horse.gait = 1
	horse.speed = Horse.GAIT_SPEED[1]
	if horse.cam:
		horse.cam.current = true
	await get_tree().create_timer(0.45).timeout
	await _shot_play("play_cam")
	for c in arena.get_children():
		if c is CanvasLayer:
			c.visible = false

	cam = Camera3D.new()
	cam.fov = 48.0
	cam.far = 400.0
	cam.near = 0.12
	arena.add_child(cam)
	_use_cam()

	horse.set_physics_process(false)
	horse.gait = 0
	horse._play_named("Idle", 1.0, true, true)
	await _shot("halt_side", origin + right * 3.6 + Vector3(0, 1.22, 0) + fwd * 0.10, origin + Vector3(0, 1.15, 0))
	await _shot("seat_side", origin + right * 3.15 + Vector3(0, 1.28, 0) + fwd * 0.18, origin + Vector3(0, 1.28, 0.12))
	await _shot("halt_rear", origin - fwd * 4.2 + Vector3(0.4, 1.45, 0), origin + Vector3(0, 1.15, 0) + fwd * 0.15)

	_freeze_stride(0.12)
	await _shot("walk_a", origin + right * 3.7 + Vector3(0, 0.72, 0) + fwd * 0.35, origin + Vector3(0, 0.42, 0))
	_freeze_stride(0.38)
	await _shot("walk_b", origin + right * 3.7 + Vector3(0, 0.72, 0) + fwd * 0.35, origin + Vector3(0, 0.42, 0))
	_freeze_stride(0.62)
	await _shot("walk_c", origin + right * 3.7 + Vector3(0, 0.72, 0) + fwd * 0.35, origin + Vector3(0, 0.42, 0))
	_freeze_stride(0.12)
	await _shot("chase", origin + right * 3.4 + Vector3(0, 1.18, 0) + fwd * 0.10, origin + Vector3(0, 1.18, 0))
	await _shot("barn", Vector3(-22, 9.0, 6), Vector3(-78, 4.2, -48))
	await _shot("house", Vector3(22, 8.0, -10), Vector3(62, 4.0, -52))
	await _shot("trainer", Vector3(13.0, 1.55, -8.0), Vector3(16.2, 1.45, -8.0))
	print("ARTSHOT done")
	get_tree().quit(0)


func _freeze_stride(u: float) -> void:
	horse.gait = 1
	horse._play_named("Walk", 1.0, true, true)
	if horse.anim and horse.anim.has_animation("Walk"):
		horse.anim.seek(u * horse.anim.get_animation("Walk").length, true)


func _use_cam() -> void:
	if horse and horse.cam:
		horse.cam.current = false
	if cam:
		cam.make_current()


func _shot_play(name: String) -> void:
	if horse.cam:
		horse.cam.make_current()
	await get_tree().process_frame
	await get_tree().process_frame
	_save(name)


func _shot(name: String, from: Vector3, look: Vector3) -> void:
	_use_cam()
	cam.global_position = from
	if look.distance_to(from) > 0.08:
		cam.look_at(look, Vector3.UP)
	await get_tree().process_frame
	await get_tree().process_frame
	_save(name)


func _save(name: String) -> void:
	var vp := get_viewport()
	if vp == null or vp.get_texture() == null:
		print("ARTSHOT no viewport ", name)
		return
	var img := vp.get_texture().get_image()
	if img:
		var root := ProjectSettings.globalize_path("res://").path_join("..")
		var rider := "--artshot-rider" in OS.get_cmdline_user_args()
		var dir := root.path_join("tools").path_join("content_factory").path_join("artshots")
		if rider:
			dir = dir.path_join("rider")
		else:
			var dist := root.path_join("dist")
			DirAccess.make_dir_recursive_absolute(dist)
			img.save_png(dist.path_join("artshot_%s.png" % name))
		DirAccess.make_dir_recursive_absolute(dir)
		var path := dir.path_join("artshot_%s.png" % name)
		img.save_png(path)
		print("ARTSHOT ", path, " lum ", _lum(img), " ", img.get_width(), "x", img.get_height())
	else:
		print("ARTSHOT no image ", name)


func _lum(img: Image) -> float:
	var acc := 0.0
	var n := 0
	var step_x := maxi(1, img.get_width() / 24)
	var step_y := maxi(1, img.get_height() / 16)
	for y in range(0, img.get_height(), step_y):
		for x in range(0, img.get_width(), step_x):
			var c := img.get_pixel(x, y)
			acc += (c.r + c.g + c.b) / 3.0
			n += 1
	return acc / maxf(float(n), 1.0)
