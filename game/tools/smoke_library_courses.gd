extends SceneTree
## Headless JSON smoke. Prints a table. Does not instance the live Course node.

func _init() -> void:
	var ok := 0
	var n := 0
	var ship: Variant = JSON.parse_string(FileAccess.get_file_as_string("res://content/courses/SHIP.json"))
	if typeof(ship) != TYPE_DICTIONARY:
		print("SMOKE fail: no SHIP")
		quit(1)
		return
	var ids: Array = []
	for k in (ship as Dictionary).keys():
		var v: Variant = (ship as Dictionary)[k]
		if typeof(v) == TYPE_ARRAY:
			ids.append_array(v)
		elif typeof(v) == TYPE_DICTIONARY:
			for ck in (v as Dictionary).keys():
				var item: Variant = (v as Dictionary)[ck]
				if typeof(item) == TYPE_ARRAY:
					ids.append_array(item)
				elif str(item) != "":
					ids.append(str(item))
	for id in ids:
		n += 1
		var rec: Dictionary = ContentLibrary.load_course(str(id))
		if rec.is_empty():
			print("FAIL missing ", id)
			continue
		var specs: Array = ContentLibrary.specs_from_course(rec)
		if specs.size() == 0:
			print("FAIL specs ", id)
			continue
		print("OK  ", id, "  n=", specs.size(), "  ", rec.get("class_id", ""))
		ok += 1
	print("SMOKE ", ok, "/", n)
	quit(0 if ok == n and n > 0 else 1)
