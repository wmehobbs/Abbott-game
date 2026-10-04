class_name ContentLibrary
extends RefCounted

## Content factory loader. Live game falls back to Course._specs_for / Trainer hardcoded
## if JSON is missing. Search order:
##   1. user://content/
##   2. res://../content  (dev checkout)
##   3. res://content     (exported copy under game/content/)

const USER_ROOT := "user://content"
const RES_ROOT := "res://content"


static func _try_text(path: String) -> String:
	if not FileAccess.file_exists(path):
		return ""
	var f := FileAccess.open(path, FileAccess.READ)
	if f == null:
		return ""
	var t := f.get_as_text()
	f.close()
	return t


static func _read_json(rel: String) -> Variant:
	var tried: Array[String] = [
		USER_ROOT + "/" + rel,
		"res://../content/" + rel,
		RES_ROOT + "/" + rel,
	]
	for p in tried:
		var raw := _try_text(p)
		if raw == "":
			continue
		var data: Variant = JSON.parse_string(raw)
		return data
	return null


static func load_ship() -> Dictionary:
	var data: Variant = _read_json("courses/SHIP.json")
	if typeof(data) == TYPE_DICTIONARY:
		return data
	return {}


static func _pick_id(v: Variant, seed: int) -> String:
	if typeof(v) == TYPE_STRING:
		return str(v)
	if typeof(v) == TYPE_ARRAY and (v as Array).size() > 0:
		var a: Array = v
		return str(a[abs(seed) % a.size()])
	return ""


## What she sees and hears on the walk: the course's own name, height, and
## the sentence a person would say about it. Nothing generated.
static func walk_line(c: Dictionary) -> String:
	var n := str(c.get("name", "")).strip_edges()
	var h := str(c.get("height_label", "")).strip_edges()
	var t := str(c.get("notes", "")).strip_edges()
	if n == "" or h == "" or t == "":
		return ""
	return "%s. %s. %s" % [n, h, t]


## The fence she is standing beside on the walk: the nearest one within 4 m of
## her (ground plane), its number and name, and its own related line if it has
## one. Empty when she is beside none.
##
## Between two fences that the file relates, she is walking that line: on the
## segment from the in-fence to the fence its related.to names (her closest
## point lies between the two ends, within a 2 m corridor), and the label is
## the in-fence's line. At a fence (within 1.5 m of its rail, standard to
## standard) the fence's own line still wins.
const NEAR_FENCE_M := 4.0
const AT_FENCE_M := 1.5
const LINE_CORRIDOR_M := 2.0
const FENCE_W := 3.05


static func _fence_line(f: Dictionary) -> String:
	var line := "Fence %d. %s." % [int(f.get("num", 0)), str(f.get("name", "")).strip_edges()]
	# This fence's own height, in metres, as its file stores it.
	if f.has("h"):
		line += " %s m." % str(f.get("h"))
	# And its own spread, only when there is one (a vertical stores 0).
	if f.has("sp") and float(f.get("sp")) > 0.0:
		line += " spread %s m." % str(f.get("sp"))
	var rel: Variant = f.get("related", null)
	if typeof(rel) == TYPE_DICTIONARY:
		var n := int((rel as Dictionary).get("strides", 0))
		var to := int((rel as Dictionary).get("to", 0))
		if n == 1:
			line += " 1 stride to fence %d." % to
		else:
			line += " %d strides to fence %d." % [n, to]
	return line


static func _xz(f: Dictionary) -> Variant:
	var p: Variant = f.get("pos", [])
	if typeof(p) != TYPE_ARRAY or (p as Array).size() < 3:
		return null
	return Vector2(float(p[0]), float(p[2]))


## facing: the way she is looking (her -basis.z). On a related line, facing
## back toward the in-fence, the line is said as "Walking back." first.
static func near_line(c: Dictionary, at: Vector3, facing: Vector3 = Vector3.ZERO) -> String:
	var fences: Variant = c.get("fences", [])
	if typeof(fences) != TYPE_ARRAY:
		return ""
	var her := Vector2(at.x, at.z)
	var by_num := {}
	var nearest: Dictionary = {}
	var nearest_d := NEAR_FENCE_M
	var at_fence: Dictionary = {}
	var at_d := AT_FENCE_M
	for f in fences:
		if typeof(f) != TYPE_DICTIONARY:
			continue
		var qv: Variant = _xz(f)
		if qv == null:
			continue
		var q: Vector2 = qv
		by_num[int(f.get("num", 0))] = f
		var d := her.distance_to(q)
		if d <= nearest_d:
			nearest_d = d
			nearest = f
		# Her distance to the fence itself: its rail between the standards.
		var yaw := float(f.get("yaw", 0.0))
		var along := Vector2(cos(yaw), -sin(yaw)) * (FENCE_W * 0.5)
		var ra: Vector2 = q - along
		var rb: Vector2 = q + along
		var rt := clampf((her - ra).dot(rb - ra) / maxf((rb - ra).length_squared(), 0.0001), 0.0, 1.0)
		var rd := her.distance_to(ra + (rb - ra) * rt)
		if rd <= at_d:
			at_d = rd
			at_fence = f
	var seg: Dictionary = {}
	var seg_d := LINE_CORRIDOR_M
	var seg_ab := Vector2.ZERO
	for f in fences:
		if typeof(f) != TYPE_DICTIONARY:
			continue
		var rel: Variant = f.get("related", null)
		if typeof(rel) != TYPE_DICTIONARY:
			continue
		var to: Variant = by_num.get(int((rel as Dictionary).get("to", -1)), null)
		if to == null:
			continue
		var av: Variant = _xz(f)
		var bv: Variant = _xz(to)
		if av == null or bv == null:
			continue
		var a: Vector2 = av
		var b: Vector2 = bv
		var ab: Vector2 = b - a
		var t := (her - a).dot(ab) / maxf(ab.length_squared(), 0.0001)
		if t <= 0.0 or t >= 1.0:
			continue
		var d := her.distance_to(a + ab * t)
		if d <= seg_d:
			seg_d = d
			seg = f
			seg_ab = ab
	# A rail and a related line can both claim her: the nearer wins, and a tie
	# keeps the line she is walking.
	if not at_fence.is_empty() and (seg.is_empty() or at_d < seg_d):
		return _fence_line(at_fence)
	if not seg.is_empty():
		var face := Vector2(facing.x, facing.z)
		if face.length_squared() > 0.0001 and face.dot(seg_ab) < 0.0:
			return "Walking back. " + _fence_line(seg)
		return _fence_line(seg)
	if nearest.is_empty():
		return ""
	return _fence_line(nearest)


static func ship_course(class_id: String, jump_off: bool, seed: int, indoor: bool = false) -> Dictionary:
	var ship: Dictionary = load_ship()
	if ship.is_empty():
		return {}
	var id := ""
	if jump_off:
		var jo: Variant = ship.get("jump_off", {})
		if typeof(jo) == TYPE_DICTIONARY:
			id = _pick_id((jo as Dictionary).get(class_id, ""), seed)
	elif indoor:
		var inn: Variant = ship.get("indoor", {})
		if typeof(inn) == TYPE_DICTIONARY:
			id = _pick_id((inn as Dictionary).get(class_id, []), seed)
	else:
		id = _pick_id(ship.get(class_id, []), seed)
	if id == "":
		return {}
	return load_course(id)


static func load_index() -> Dictionary:
	var data: Variant = _read_json("courses/INDEX.json")
	if typeof(data) == TYPE_ARRAY:
		return {"courses": data}
	if typeof(data) == TYPE_DICTIONARY:
		return data
	return {}


static func load_course(id: String) -> Dictionary:
	var idx: Dictionary = load_index()
	var rows: Variant = idx.get("courses", idx)
	if typeof(rows) == TYPE_ARRAY:
		for row in rows:
			if typeof(row) == TYPE_DICTIONARY and str(row.get("id", "")) == id:
				var rel := str(row.get("path", "")).replace("content/", "")
				var data: Variant = _read_json(rel)
				if typeof(data) == TYPE_DICTIONARY:
					return data
	# Guess a path if the index is missing.
	for folder in [
		"lesson", "beginner", "intermediate", "advanced",
		"jump_off/beginner", "jump_off/intermediate", "jump_off/advanced",
		"indoor/lesson", "indoor/beginner", "indoor/intermediate", "indoor/advanced",
		"indoor/jump_off/beginner", "indoor/jump_off/intermediate", "indoor/jump_off/advanced",
	]:
		var data: Variant = _read_json("courses/%s/%s.json" % [folder, id])
		if typeof(data) == TYPE_DICTIONARY:
			return data
	return {}


static func specs_from_course(course: Dictionary) -> Array:
	## Shape Course._specs_for can consume: kind, h, sp, pos, yaw.
	var out: Array = []
	var fences: Variant = course.get("fences", [])
	if typeof(fences) != TYPE_ARRAY:
		return out
	for f in fences:
		if typeof(f) != TYPE_DICTIONARY:
			continue
		var pos_a: Variant = f.get("pos", [0, 0, 0])
		var pos := Vector3(0, 0, 0)
		if typeof(pos_a) == TYPE_ARRAY and pos_a.size() >= 3:
			pos = Vector3(float(pos_a[0]), float(pos_a[1]), float(pos_a[2]))
		out.append({
			"kind": str(f.get("kind", "vertical")),
			"h": float(f.get("h", 0.6)),
			"sp": float(f.get("sp", 0.0)),
			"pos": pos,
			"yaw": float(f.get("yaw", 0.0)),
			"name": str(f.get("name", "")),
			"related": f.get("related", null),
		})
	return out


static func load_michelle_ship() -> Dictionary:
	var data: Variant = _read_json("rail/michelle_ship.json")
	if typeof(data) == TYPE_DICTIONARY:
		return data
	return {}


static func load_michelle() -> Dictionary:
	var data: Variant = _read_json("rail/michelle.json")
	if typeof(data) == TYPE_DICTIONARY:
		return data
	return {}


static func _phrase_from(data: Dictionary, key: String, session: String, class_id: String) -> String:
	var lines: Variant = data.get("lines", [])
	if typeof(lines) != TYPE_ARRAY:
		return ""
	var hits: Array = []
	for row in lines:
		if typeof(row) != TYPE_DICTIONARY:
			continue
		if str(row.get("key", "")) != key:
			continue
		if session != "":
			var sess: Variant = row.get("session", [])
			if typeof(sess) == TYPE_ARRAY and sess.size() > 0 and not sess.has(session):
				continue
		if class_id != "":
			var cls: Variant = row.get("class_id", [])
			if typeof(cls) == TYPE_ARRAY and cls.size() > 0 and not cls.has(class_id):
				continue
		hits.append(str(row.get("text", "")))
	if hits.is_empty():
		return ""
	return str(hits[randi() % hits.size()])


static func phrase(key: String, session: String = "", class_id: String = "") -> String:
	## Ship board first, then the factory pile, then Trainer hardcoded.
	var line := _phrase_from(load_michelle_ship(), key, session, class_id)
	if line != "":
		return line
	return _phrase_from(load_michelle(), key, session, class_id)


static func fence_name(kind: String, height: float, spread: float) -> String:
	var data: Variant = _read_json("fences/catalog.json")
	if typeof(data) != TYPE_DICTIONARY:
		return kind
	var recipes: Variant = data.get("recipes", [])
	if typeof(recipes) != TYPE_ARRAY:
		return kind
	for r in recipes:
		if typeof(r) != TYPE_DICTIONARY:
			continue
		if str(r.get("kind", "")) != kind:
			continue
		if height < float(r.get("h_min", 0.0)) - 0.02:
			continue
		if height > float(r.get("h_max", 9.0)) + 0.02:
			continue
		if kind == "oxer":
			if spread < float(r.get("sp_min", 0.0)) - 0.02:
				continue
			if spread > float(r.get("sp_max", 9.0)) + 0.02:
				continue
		return str(r.get("name", kind))
	return kind


static func barn_note(session: String, conf: float, ride: float, timing: float) -> String:
	var data: Variant = _read_json("rail/barn_notes.json")
	if typeof(data) != TYPE_DICTIONARY:
		return ""
	var notes: Variant = data.get("notes", [])
	if typeof(notes) != TYPE_ARRAY:
		return ""
	var hits: Array = []
	for row in notes:
		if typeof(row) != TYPE_DICTIONARY:
			continue
		var sess: Variant = row.get("session", [])
		if typeof(sess) == TYPE_ARRAY and sess.size() > 0 and not sess.has(session):
			continue
		var ac: Variant = row.get("abbott_confidence", [0, 100])
		var ar: Variant = row.get("abbott_rideability", [0, 100])
		var mt: Variant = row.get("madison_timing", [0, 100])
		if typeof(ac) == TYPE_ARRAY and ac.size() >= 2:
			if conf < float(ac[0]) or conf > float(ac[1]):
				continue
		if typeof(ar) == TYPE_ARRAY and ar.size() >= 2:
			if ride < float(ar[0]) or ride > float(ar[1]):
				continue
		if typeof(mt) == TYPE_ARRAY and mt.size() >= 2:
			if timing < float(mt[0]) or timing > float(mt[1]):
				continue
		hits.append(str(row.get("text", "")))
	if hits.is_empty():
		return ""
	return str(hits[randi() % hits.size()])
