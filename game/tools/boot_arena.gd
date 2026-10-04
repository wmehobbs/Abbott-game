extends SceneTree


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	print("A1 load")
	var packed: PackedScene = load("res://scenes/arena.tscn")
	print("A2 packed=", packed)
	var inst: Node = packed.instantiate()
	print("A3 inst=", inst)
	root.add_child(inst)
	await process_frame
	await process_frame
	print("A4 kids=", inst.get_child_count(), " names=")
	for c in inst.get_children():
		print("  ", c.name)
	print("A5 ok")
	quit(0)
