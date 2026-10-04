extends SceneTree


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var host := Node3D.new()
	root.add_child(host)
	var farm: Node = (load("res://scripts/farm.gd") as GDScript).new()
	host.add_child(farm)
	farm.call("build")
	print("FARM children=", farm.get_child_count())
	var people: GDScript = load("res://scripts/person_look.gd")
	var rider: Node3D = people.mounted_madison(host, Vector3(0.0, 1.14, 0.06))
	print("RIDER ", rider.name, " pos=", rider.position, " kids=", rider.get_child_count())
	var skull := rider.find_child("Skull", true, false)
	if skull is MeshInstance3D:
		var mat: Material = (skull as MeshInstance3D).material_override
		print("FACE shader=", mat is ShaderMaterial, " body=", rider.get_node_or_null("Body") != null)
	var trainer: Node3D = people.standing_trainer()
	host.add_child(trainer)
	print("TRAINER kids=", trainer.get_child_count())
	print("COMPILE ok")
	quit(0)
