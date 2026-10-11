extends Control
class_name CourseMap

## Overhead of the ring. The gold fence is the one the corner line calls next.

# Same metres as farm.gd RING_W and RING_D. The long side runs up the screen,
# so the in-gate (negative Z) sits at the bottom.
const RING_W := 30.48
const RING_D := 76.20
const _STEP := 1.0 / 12.0

## Fence number drawn in gold. 0 when none is the next one.
var marked_next: int = 0

var _hud_scale := 1.0
var _acc := 0.0
var _primed := false
var _font: Font
var _bars: Array = []
var _have_horse := false
var _horse_at := Vector3.ZERO
var _horse_fwd := Vector3(0, 0, 1)


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	clip_contents = true
	_font = load("res://assets/fonts/SourceSans3-Regular.ttf")
	apply_scale(1.0)


## Pixel size follows the HUD scale. 260px tall at scale 1, which is 900p's size.
func apply_scale(hud_scale: float) -> void:
	_hud_scale = clampf(hud_scale, 0.8, 1.6)
	var s := _hud_scale
	var h := 260.0 * s
	var pad_y := 16.0 * s
	var pad_x := 22.0 * s
	var inner_h := h - pad_y * 2.0
	var inner_w := inner_h * (RING_W / RING_D)
	var w := inner_w + pad_x * 2.0
	set_anchors_preset(Control.PRESET_TOP_RIGHT)
	offset_left = -(16.0 + w)
	offset_right = -16.0
	offset_top = 16.0
	offset_bottom = 16.0 + h
	size = Vector2(w, h)
	queue_redraw()


func _process(delta: float) -> void:
	if not visible:
		_primed = false
		return
	# First frame after it appears, then about 12 times a second. Not every frame.
	if not _primed:
		_primed = true
		_acc = 0.0
		refresh()
		return
	_acc += delta
	if _acc < _STEP:
		return
	_acc = 0.0
	refresh()


## Reads the arena's course and Abbott. Safe when the title is up and neither exists.
func refresh() -> void:
	_bars.clear()
	marked_next = 0
	_have_horse = false
	var want := 0
	if not GameState.round_complete:
		want = GameState.next_fence
	var course := _course()
	if course:
		for f in course.fences:
			if f == null or not is_instance_valid(f):
				continue
			var axis := f.global_transform.basis.x
			if axis.length_squared() < 0.0001:
				continue
			axis = axis.normalized()
			var half := maxf(f.width, 0.4) * 0.5
			var jumped := f.cleared or (want > 0 and f.number < want)
			if f.number == want:
				marked_next = want
			_bars.append({
				"a": f.global_position - axis * half,
				"b": f.global_position + axis * half,
				"n": f.number,
				"jumped": jumped,
			})
	var horse := _abbott()
	if horse:
		_have_horse = true
		_horse_at = horse.global_position
		_horse_fwd = -horse.global_transform.basis.z
	queue_redraw()


func _course() -> Course:
	var scene := get_tree().current_scene
	if scene == null:
		return null
	var prop: Variant = scene.get("course")
	if prop is Course and is_instance_valid(prop):
		return prop
	var named := scene.get_node_or_null("Course")
	if named is Course and is_instance_valid(named):
		return named
	return null


func _abbott() -> Node3D:
	var scene := get_tree().current_scene
	if scene == null:
		return null
	var prop: Variant = scene.get("horse")
	if prop is Node3D and is_instance_valid(prop):
		return prop
	var named := scene.get_node_or_null("Abbott")
	if named is Node3D and is_instance_valid(named):
		return named
	return null


func _inner() -> Rect2:
	var s := _hud_scale
	var pad_y := 16.0 * s
	var pad_x := 22.0 * s
	return Rect2(Vector2(pad_x, pad_y), Vector2(size.x - pad_x * 2.0, size.y - pad_y * 2.0))


func _to_map(world: Vector3) -> Vector2:
	var inner := _inner()
	var u := (world.x + RING_W * 0.5) / RING_W
	var v := (RING_D * 0.5 - world.z) / RING_D
	return Vector2(inner.position.x + u * inner.size.x, inner.position.y + v * inner.size.y)


func _draw() -> void:
	var panel := Rect2(Vector2.ZERO, size)
	draw_rect(panel, Color(0.04, 0.03, 0.02, 0.72))
	draw_rect(panel, Color(0.72, 0.58, 0.32, 0.85), false, 1.0)
	var inner := _inner()
	draw_rect(inner, Color(0.93, 0.88, 0.76, 0.55), false, 1.0)
	var cream := Color(0.93, 0.88, 0.76, 0.95)
	var gold := Color(0.93, 0.72, 0.32, 1.0)
	var dim := Color(0.55, 0.48, 0.38, 0.45)
	var fs := int(round(13.0 * _hud_scale))
	for bar in _bars:
		var n := int(bar["n"])
		var col := cream
		var width := 2.0 * _hud_scale
		if n == marked_next and marked_next > 0:
			col = gold
			width = 3.5 * _hud_scale
		elif bool(bar["jumped"]):
			col = dim
		var a := _to_map(bar["a"])
		var b := _to_map(bar["b"])
		draw_line(a, b, col, width, true)
		_draw_num(n, (a + b) * 0.5, inner.get_center(), fs, col)
	if _have_horse:
		_draw_arrow()


func _draw_num(n: int, mid: Vector2, center: Vector2, fs: int, col: Color) -> void:
	if _font == null:
		return
	var label := str(n)
	var tw := _font.get_string_size(label, HORIZONTAL_ALIGNMENT_LEFT, -1, fs).x
	var nudge := center - mid
	if nudge.length_squared() < 1.0:
		nudge = Vector2(0, -1)
	else:
		nudge = nudge.normalized()
	var pos := mid + nudge * (11.0 * _hud_scale)
	pos.x -= tw * 0.5
	pos.y += float(fs) * 0.35
	pos.x = clampf(pos.x, 3.0, size.x - tw - 3.0)
	pos.y = clampf(pos.y, float(fs), size.y - 3.0)
	var shadow := Color(0.05, 0.04, 0.03, 0.85)
	draw_string(_font, pos + Vector2(1, 1), label, HORIZONTAL_ALIGNMENT_LEFT, -1, fs, shadow)
	draw_string(_font, pos, label, HORIZONTAL_ALIGNMENT_LEFT, -1, fs, col)


func _draw_arrow() -> void:
	var dir := Vector2(_horse_fwd.x, -_horse_fwd.z)
	if dir.length_squared() < 0.0001:
		dir = Vector2(0, -1)
	dir = dir.normalized()
	var side := Vector2(-dir.y, dir.x)
	var tip := _to_map(_horse_at)
	var length := 9.0 * _hud_scale
	var back := tip - dir * length
	var w := 4.2 * _hud_scale
	var pts := PackedVector2Array([tip, back + side * w, back - side * w])
	draw_colored_polygon(pts, Color(0.96, 0.93, 0.86, 0.95))
