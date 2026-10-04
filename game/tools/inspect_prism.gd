extends SceneTree


func _init() -> void:
	var p := PrismMesh.new()
	p.size = Vector3(2, 2, 2)
	p.left_to_right = 0.5
	var arr := p.get_mesh_arrays()
	var verts: PackedVector3Array = arr[Mesh.ARRAY_VERTEX]
	var ymin := 999.0
	var ymax := -999.0
	for v in verts:
		ymin = minf(ymin, v.y)
		ymax = maxf(ymax, v.y)
	print("PRISM verts=", verts.size(), " y=", ymin, "..", ymax)
	var tops: Array[Vector3] = []
	for v in verts:
		if v.y > ymax - 0.05:
			tops.append(v)
	print("PRISM top samples=", tops.slice(0, 6))
	quit(0)
