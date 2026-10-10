extends SceneTree
## Report-only check of every course file. Reads the ring and the class
## labels from the game, and the height bands from the factory rules.
## Does not edit a course, and does not touch the player save.

const REPORT := "E:/Workspace/Madison/dist/day16/content_report.md"
const RULES := "E:/Workspace/Madison/tools/content_factory/rules.py"

var _findings: PackedStringArray = []
var _clock_notes: PackedStringArray = []


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var class_info := _class_info()
	var heights := _heights_from_rules()
	var limits := _clock_limits()
	var ring := _ring()
	var half_w: float = ring.x * 0.5
	var half_d: float = ring.y * 0.5
	var kinds := _catalog_kinds()
	var ship: Dictionary = ContentLibrary.load_ship()
	var shipped := _ship_ids(ship)
	var index_rows := _index_rows()
	var files := _course_files("res://content/courses")

	var by_id := {}
	var file_of := {}
	for path in files:
		var base := path.get_file().get_basename()
		var text := FileAccess.get_file_as_string(path)
		var parsed: Variant = JSON.parse_string(text)
		if by_id.has(base):
			_note("%s: two files use this id (%s and %s)" % [base, str(file_of[base]), path])
		file_of[base] = path
		by_id[base] = parsed

	var index_of := {}
	var index_order: Array[String] = []
	for row in index_rows:
		if typeof(row) != TYPE_DICTIONARY:
			_note("index: a row is not an object")
			continue
		var id := str(row.get("id", "")).strip_edges()
		if id == "":
			_note("index: a row has no id")
			continue
		if index_of.has(id):
			_note("%s: index lists this id twice" % id)
		index_of[id] = row
		if not index_order.has(id):
			index_order.append(id)
		var rel := str(row.get("path", "")).replace("\\", "/")
		var res := "res://" + rel
		if not FileAccess.file_exists(res):
			_note("%s: index path is missing (%s)" % [id, rel])

	for id in file_of.keys():
		if not index_of.has(id):
			_note("%s: course file is not in INDEX.json" % id)
		if not index_order.has(id):
			index_order.append(id)

	var rows: Array[String] = []
	var gaps: Array = []
	var issue_ids: Array[String] = []
	for id in index_order:
		var built := _one(id, by_id.get(id, null), file_of.get(id, ""), index_of.get(id, {}), class_info, heights, kinds, ship, half_w, half_d, limits)
		rows.append(built["line"])
		if int(built["issues"]) > 0:
			issue_ids.append(id)
		for g in built["gaps"]:
			gaps.append(g)

	var floor := _gap_floor(gaps, shipped)
	_finish_clock()
	_write(rows, class_info, heights, half_w, half_d, floor, index_order.size(), issue_ids.size())
	print("VALIDATE courses=%d index=%d files=%d issues=%d" % [index_order.size(), index_of.size(), file_of.size(), issue_ids.size()])
	print("VALIDATE floor %s" % floor["text"])
	for line in _findings:
		print("FINDING ", line)
	print("VALIDATE ok")
	quit(0)


func _one(id: String, parsed: Variant, path: String, index_row: Dictionary, class_info: Dictionary, heights: Dictionary, kinds: Array, ship: Dictionary, half_w: float, half_d: float, limits: Dictionary) -> Dictionary:
	var issues: Array[String] = []
	var gaps: Array = []
	var fence_n := 0
	var gap_txt := "—"
	var ring_txt := "—"
	var text_txt := "—"
	var height_txt := "—"
	var class_txt := "—"
	var jo_txt := "no"
	if path == "":
		_bad(issues, id, "index entry has no course file")
	elif path.get_file().get_basename() != id:
		_bad(issues, id, "file name %s does not match the id" % path.get_file())
	if typeof(parsed) != TYPE_DICTIONARY:
		_bad(issues, id, "file does not parse")
		return _row(id, class_txt, jo_txt, fence_n, height_txt, gap_txt, ring_txt, text_txt, issues, gaps)

	var course: Dictionary = parsed
	var file_id := str(course.get("id", "")).strip_edges()
	if file_id != id:
		_bad(issues, id, "id inside the file is %s" % file_id)
	var cid := str(course.get("class_id", "")).strip_edges()
	class_txt = cid if cid != "" else "—"
	if not class_info.has(cid):
		_bad(issues, id, "class_id %s is not in CLASS_INFO" % cid)
	var info: Dictionary = class_info.get(cid, {})
	var label := str(course.get("height_label", "")).strip_edges()
	height_txt = label if label != "" else "—"
	if class_info.has(cid) and label != str(info.get("height", "")):
		_bad(issues, id, "height label %s is not the class label %s" % [label, str(info.get("height", ""))])

	var jo := bool(course.get("jump_off", false))
	var index_jo := bool(index_row.get("jump_off", false))
	var path_jo := path.contains("/jump_off/")
	if jo or index_jo or path_jo:
		jo_txt = "yes"
		if not (jo and index_jo and path_jo):
			_bad(issues, id, "jump-off flag, index, and folder disagree")
		_jump_off(issues, id, cid, course, index_row, ship, info, limits)
	else:
		if str(index_row.get("class", "")) != "" and str(index_row.get("class", "")) != cid:
			_bad(issues, id, "index class %s does not match the file" % str(index_row.get("class", "")))
		var expect := int(info.get("need", -1))
		if class_info.has(cid) and expect >= 0:
			var fences_v: Variant = course.get("fences", [])
			var got := -1
			if typeof(fences_v) == TYPE_ARRAY:
				got = (fences_v as Array).size()
			if got != expect:
				_bad(issues, id, "fence count %d is not the class need %d" % [got, expect])

	if not index_row.is_empty():
		var rel := str(index_row.get("path", "")).replace("\\", "/")
		var got := path.trim_prefix("res://")
		if rel != "" and got != "" and rel != got:
			_bad(issues, id, "index path %s is not the file" % rel)

	var fences: Variant = course.get("fences", [])
	if typeof(fences) != TYPE_ARRAY:
		_bad(issues, id, "fences is not a list")
	else:
		fence_n = fences.size()
		var numbered := _numbers(issues, id, fences)
		var band: Array = heights.get(cid, [])
		var outside := false
		var text_bad := false
		for f in fences:
			if typeof(f) != TYPE_DICTIONARY:
				_bad(issues, id, "a fence is not an object")
				text_bad = true
				continue
			var fd: Dictionary = f
			var num := int(fd.get("num", 0))
			var kind := str(fd.get("kind", ""))
			if not kinds.has(kind):
				_bad(issues, id, "fence %d kind %s is not in the catalog" % [num, kind])
			var h := float(fd.get("h", -1.0))
			if band.size() == 2 and (h < float(band[0]) - 0.000001 or h > float(band[1]) + 0.000001):
				_bad(issues, id, "fence %d height %s m is outside %s–%s for %s" % [num, str(fd.get("h")), str(band[0]), str(band[1]), cid])
			var pos: Variant = fd.get("pos", [])
			if typeof(pos) != TYPE_ARRAY or pos.size() < 3:
				_bad(issues, id, "fence %d has no position" % num)
				outside = true
			else:
				var yaw := float(fd.get("yaw", 0.0))
				if not _in_ring(pos, yaw, half_w, half_d):
					_bad(issues, id, "fence %d is outside the ring" % num)
					outside = true
			var fname := str(fd.get("name", "")).strip_edges()
			if fname == "":
				_bad(issues, id, "fence %d has no name" % num)
				text_bad = true
			var shown := ContentLibrary.fence_name(kind, h, float(fd.get("sp", 0.0)))
			if shown.strip_edges() == "":
				_bad(issues, id, "fence %d catalog name is empty" % num)
				text_bad = true
		if numbered and fence_n >= 2:
			var dmin := _consecutive(id, fences, gaps)
			gap_txt = "%0.2f" % dmin
		ring_txt = "no" if outside else "yes"
		var walk := ContentLibrary.walk_line(course)
		if walk == "":
			_bad(issues, id, "walk line is empty")
			text_bad = true
		if not _near_lines(issues, id, course, fences):
			text_bad = true
		text_txt = "no" if text_bad else "yes"
		if int(index_row.get("fence_count", fence_n)) != fence_n:
			_bad(issues, id, "index fence_count %s is not %d" % [str(index_row.get("fence_count", "")), fence_n])
		_clock(id, course, jo_txt == "yes", limits)

	return _row(id, class_txt, jo_txt, fence_n, height_txt, gap_txt, ring_txt, text_txt, issues, gaps)


func _jump_off(issues: Array[String], id: String, cid: String, course: Dictionary, index_row: Dictionary, ship: Dictionary, info: Dictionary, limits: Dictionary) -> void:
	if cid == "lesson" or cid == "":
		_bad(issues, id, "a jump-off has no parent class")
		return
	if str(index_row.get("class", "")) != cid:
		_bad(issues, id, "jump-off index class %s is not %s" % [str(index_row.get("class", "")), cid])
	var jo_map: Variant = ship.get("jump_off", {})
	var pointed := ""
	if typeof(jo_map) == TYPE_DICTIONARY:
		pointed = str((jo_map as Dictionary).get(cid, ""))
	if pointed != id:
		_bad(issues, id, "SHIP jump-off for %s is %s" % [cid, pointed])
	var need := int(limits.get(cid, {}).get("jo_n", 4))
	var fences: Variant = course.get("fences", [])
	var got := -1
	if typeof(fences) == TYPE_ARRAY:
		got = (fences as Array).size()
	if got != need:
		_bad(issues, id, "jump-off has %d fences, the class rides %d" % [got, need])
	var parent_need := int(info.get("need", -1))
	if parent_need == got:
		_bad(issues, id, "jump-off has the full class, not the short course")
	var sessions: Variant = course.get("session_kinds", [])
	if typeof(sessions) != TYPE_ARRAY or not (sessions as Array).has("show"):
		_bad(issues, id, "jump-off is not a show course")


func _numbers(issues: Array[String], id: String, fences: Array) -> bool:
	var seen := {}
	var ok := true
	for f in fences:
		if typeof(f) != TYPE_DICTIONARY:
			ok = false
			continue
		var n := int((f as Dictionary).get("num", 0))
		if seen.has(n):
			_bad(issues, id, "fence number %d is repeated" % n)
			ok = false
		seen[n] = true
	for n in range(1, fences.size() + 1):
		if not seen.has(n):
			_bad(issues, id, "fence numbers skip %d" % n)
			ok = false
	return ok


func _in_ring(pos: Array, yaw: float, half_w: float, half_d: float) -> bool:
	var x := float(pos[0])
	var z := float(pos[2])
	var along := Vector2(cos(yaw), -sin(yaw)) * (ContentLibrary.FENCE_W * 0.5)
	var points: Array[Vector2] = [Vector2(x, z), Vector2(x, z) - along, Vector2(x, z) + along]
	for p in points:
		if absf(p.x) > half_w + 0.001 or absf(p.y) > half_d + 0.001:
			return false
	return true


func _consecutive(id: String, fences: Array, gaps: Array) -> float:
	var order: Array = []
	for f in fences:
		if typeof(f) == TYPE_DICTIONARY:
			order.append(f)
	order.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
		return int(a.get("num", 0)) < int(b.get("num", 0))
	)
	var dmin := 9999.0
	for i in range(order.size() - 1):
		var a: Dictionary = order[i]
		var b: Dictionary = order[i + 1]
		var pa: Variant = a.get("pos", [])
		var pb: Variant = b.get("pos", [])
		if typeof(pa) != TYPE_ARRAY or typeof(pb) != TYPE_ARRAY or pa.size() < 3 or pb.size() < 3:
			continue
		var d := Vector2(float(pa[0]), float(pa[2])).distance_to(Vector2(float(pb[0]), float(pb[2])))
		gaps.append({"id": id, "a": int(a.get("num", 0)), "b": int(b.get("num", 0)), "d": d})
		if d < dmin:
			dmin = d
	return dmin


func _near_lines(issues: Array[String], id: String, course: Dictionary, fences: Array) -> bool:
	var ok := true
	for f in fences:
		if typeof(f) != TYPE_DICTIONARY:
			continue
		var fd: Dictionary = f
		var pos: Variant = fd.get("pos", [])
		if typeof(pos) != TYPE_ARRAY or pos.size() < 3:
			continue
		var at := Vector3(float(pos[0]), float(pos[1]), float(pos[2]))
		var line := ContentLibrary.near_line(course, at, Vector3.ZERO)
		if line.strip_edges() == "":
			_bad(issues, id, "near line at fence %d is empty" % int(fd.get("num", 0)))
			ok = false
	return ok


func _clock(id: String, course: Dictionary, jo: bool, limits: Dictionary) -> void:
	var cid := str(course.get("class_id", ""))
	var lim: Dictionary = limits.get(cid, {})
	if lim.is_empty():
		return
	var school := float(course.get("time_allowed_school", -1))
	var show := float(course.get("time_allowed_show", -1))
	var want_school := float(lim["jo_school"] if jo else lim["school_t"])
	var want_show := float(lim["jo_show"] if jo else lim["show_t"])
	if absf(school - want_school) > 0.05 or absf(show - want_show) > 0.05:
		_clock_notes.append("%s file %s/%s, game %0.2f/%0.2f" % [id, str(course.get("time_allowed_school", "")), str(course.get("time_allowed_show", "")), want_school, want_show])


func _finish_clock() -> void:
	if _clock_notes.is_empty():
		return
	_findings.append("The clock does not read the course file. time_allowed() uses CLASS_INFO, and on a jump-off the greater of 28 seconds and that time multiplied by 0.42. %d courses store other numbers. She rides the game clock." % _clock_notes.size())
	for line in _clock_notes:
		_findings.append(line)


func _gap_floor(gaps: Array, shipped: Dictionary) -> Dictionary:
	var floor_d := 9999.0
	var floor_at := ""
	var short: PackedStringArray = []
	for g in gaps:
		if not bool(shipped.get(str(g["id"]), false)):
			continue
		if float(g["d"]) < floor_d:
			floor_d = float(g["d"])
			floor_at = "%s fence %d to %d" % [str(g["id"]), int(g["a"]), int(g["b"])]
	if floor_at == "":
		var text := "No shipped course had two fences to measure."
		_findings.append(text)
		return {"text": text}
	for g in gaps:
		if float(g["d"]) < floor_d - 0.001:
			var line := "%s fence %d to %d is %0.2f m, shorter than the shipped minimum %0.2f m (%s)" % [str(g["id"]), int(g["a"]), int(g["b"]), float(g["d"]), floor_d, floor_at]
			short.append(line)
			_findings.append(line)
	var text := "Shortest consecutive distance on a shipped course is %0.2f m (%s)." % [floor_d, floor_at]
	if short.is_empty():
		text += " Nothing is shorter."
	else:
		text += " %d shorter pair(s) are listed under Findings, not as a failed course." % short.size()
	_findings.append(text)
	return {"text": text, "d": floor_d}


func _row(id: String, cid: String, jo: String, fence_n: int, height: String, gap: String, ring: String, text: String, issues: Array[String], gaps: Array) -> Dictionary:
	var note := "—"
	if not issues.is_empty():
		note = "; ".join(issues)
	var cells: PackedStringArray = [id, cid, jo, str(fence_n), height, gap, ring, text, note]
	var line := "| " + " | ".join(cells) + " |"
	return {"line": line, "issues": issues.size(), "gaps": gaps}


func _write(rows: Array[String], class_info: Dictionary, heights: Dictionary, half_w: float, half_d: float, floor: Dictionary, n: int, issue_n: int) -> void:
	var lines: PackedStringArray = []
	lines.append("# Course content")
	lines.append("")
	lines.append("Report only. No course file was edited. %d courses, %d with a failed check." % [n, issue_n])
	lines.append("")
	lines.append("Limits, read from the code:")
	lines.append("")
	lines.append("- Ring %0.2f m by %0.2f m, centred on the origin (`RING_W` and `RING_D` in `farm.gd`). A fence is inside when its centre and both standards are." % [half_w * 2.0, half_d * 2.0])
	lines.append("- Class labels and fence counts are `CLASS_INFO` in `game_state.gd`. A jump-off's fence count is what `fences_needed()` returns with `jump_off` set.")
	lines.append("- Height bands are `HEIGHTS` in `tools/content_factory/rules.py`, the bands the course builder checks for those same class ids.")
	for cid in ["lesson", "beginner", "intermediate", "advanced"]:
		var info: Dictionary = class_info.get(cid, {})
		var band: Array = heights.get(cid, [])
		var band_txt := "missing" if band.size() != 2 else "%s–%s m" % [str(band[0]), str(band[1])]
		lines.append("  - %s: label \"%s\", %s fences, heights %s" % [cid, str(info.get("height", "")), str(info.get("need", "")), band_txt])
	lines.append("- " + str(floor.get("text", "")))
	lines.append("")
	lines.append("| id | class | jump-off | fences | height | min gap m | in ring | text | notes |")
	lines.append("| --- | --- | --- | --- | --- | --- | --- | --- | --- |")
	for row in rows:
		lines.append(row)
	lines.append("")
	lines.append("## Findings")
	lines.append("")
	if _findings.is_empty():
		lines.append("None.")
	else:
		for line in _findings:
			lines.append("- " + line)
	lines.append("")
	var f := FileAccess.open(REPORT, FileAccess.WRITE)
	if f == null:
		print("VALIDATE report not written")
		quit(1)
		return
	f.store_string("\n".join(lines))
	f.close()


func _bad(issues: Array[String], id: String, msg: String) -> void:
	issues.append(msg)
	_findings.append("%s: %s" % [id, msg])


func _note(msg: String) -> void:
	_findings.append(msg)


func _ring() -> Vector2:
	# Read the consts. Do not load farm.gd: it names GameState, and a
	# headless --script run has not registered autoloads yet.
	var text := FileAccess.get_file_as_string("res://scripts/farm.gd")
	var w := _const_num(text, "RING_W")
	var d := _const_num(text, "RING_D")
	if w <= 0.0 or d <= 0.0:
		_note("RING_W or RING_D could not be read from farm.gd")
	return Vector2(w, d)


func _const_num(text: String, name: String) -> float:
	var re := RegEx.new()
	re.compile("const %s := ([0-9.]+)" % name)
	var m := re.search(text)
	if m == null:
		return -1.0
	return float(m.get_string(1))


func _class_info() -> Dictionary:
	var script := load("res://scripts/game_state.gd") as GDScript
	var cmap: Dictionary = script.get_script_constant_map()
	var info: Variant = cmap.get("CLASS_INFO", {})
	if typeof(info) != TYPE_DICTIONARY:
		_note("CLASS_INFO could not be read")
		return {}
	return info


func _heights_from_rules() -> Dictionary:
	var text := FileAccess.get_file_as_string(RULES)
	var start := text.find("HEIGHTS = {")
	var end := text.find("}", start)
	if start < 0 or end < 0:
		_note("HEIGHTS could not be read from rules.py")
		return {}
	var body := text.substr(start, end - start)
	var re := RegEx.new()
	re.compile("\"([a-z]+)\":\\s*\\(([0-9.]+),\\s*([0-9.]+)\\)")
	var out := {}
	for m in re.search_all(body):
		out[m.get_string(1)] = [float(m.get_string(2)), float(m.get_string(3))]
	if out.size() != 4:
		_note("HEIGHTS parsed %d classes, expected 4" % out.size())
	return out


func _clock_limits() -> Dictionary:
	var node: Node = (load("res://scripts/game_state.gd") as GDScript).new()
	var out := {}
	for cid in ["lesson", "beginner", "intermediate", "advanced"]:
		node.set("class_id", cid)
		node.set("jump_off", false)
		node.set("session_kind", "schooling")
		var school_t: float = node.call("time_allowed")
		var need: int = node.call("fences_needed")
		node.set("session_kind", "show")
		var show_t: float = node.call("time_allowed")
		node.set("jump_off", true)
		var jo_show: float = node.call("time_allowed")
		var jo_n: int = node.call("fences_needed")
		node.set("session_kind", "schooling")
		var jo_school: float = node.call("time_allowed")
		out[cid] = {
			"school_t": school_t,
			"show_t": show_t,
			"need": need,
			"jo_n": jo_n,
			"jo_school": jo_school,
			"jo_show": jo_show,
		}
	node.free()
	return out


func _catalog_kinds() -> Array:
	var data: Variant = ContentLibrary._read_json("fences/catalog.json")
	if typeof(data) != TYPE_DICTIONARY:
		_note("fence catalog did not parse")
		return []
	var kinds: Variant = (data as Dictionary).get("kinds", [])
	if typeof(kinds) != TYPE_ARRAY:
		_note("fence catalog has no kinds")
		return []
	return kinds


func _index_rows() -> Array:
	var idx: Dictionary = ContentLibrary.load_index()
	var rows: Variant = idx.get("courses", [])
	if typeof(rows) != TYPE_ARRAY:
		_note("INDEX.json has no course list")
		return []
	return rows


func _ship_ids(ship: Dictionary) -> Dictionary:
	var ids := {}
	_walk_ids(ship, ids)
	return ids


func _walk_ids(node: Variant, ids: Dictionary) -> void:
	if typeof(node) == TYPE_STRING:
		var s := str(node)
		if s.begins_with("hk_"):
			ids[s] = true
		return
	if typeof(node) == TYPE_ARRAY:
		for item in node:
			_walk_ids(item, ids)
		return
	if typeof(node) == TYPE_DICTIONARY:
		for k in (node as Dictionary).keys():
			_walk_ids((node as Dictionary)[k], ids)


func _course_files(dir_path: String) -> Array[String]:
	var out: Array[String] = []
	var dir := DirAccess.open(dir_path)
	if dir == null:
		_note("could not open " + dir_path)
		return out
	for raw in dir.get_files():
		var fn := str(raw)
		if fn == "INDEX.json" or fn == "SHIP.json" or not fn.ends_with(".json"):
			continue
		out.append(dir_path.path_join(fn))
	for raw_dir in dir.get_directories():
		out.append_array(_course_files(dir_path.path_join(str(raw_dir))))
	return out
