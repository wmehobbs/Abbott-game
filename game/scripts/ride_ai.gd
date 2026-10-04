extends Node
class_name RideAI

## Finite rider. Same keys a person has. Never teleports.
## Sit. Get on the line. Wait for the last stride. Then ask.

const TAKEOFF := 2.55
const SETUP_BACK := 10.0
## The sand is 30.48 x 76.20. Ride it. The old 12 x 34 box turned every
## rollback at the top of the ring into a trip off the track.
const RING_X := 13.4
const RING_Z := 36.2
const ACT_GAIT_UP := "gait_up"
const ACT_GAIT_DOWN := "gait_down"
const ACT_LEFT := "turn_left"
const ACT_RIGHT := "turn_right"
const ACT_JUMP := "jump"
const ACT_HALT := "halt"

var enabled: bool = false
var style: String = "clear"
var style_fence: int = 0
var style_done: bool = false
var _early_asks: int = 0
var counts: Dictionary = {}
var released_jump_this_frame: bool = false
var max_speed: float = 0.0
var dbg: Dictionary = {}
var phase: String = "pickup"

var horse: Horse
var course: Course

var _held: Dictionary = {}
var _tap_left: Dictionary = {}
var _walk_age: float = 0.0
var _hold_age: float = 0.0
var _pickup_age: float = 0.0
var _last_next: int = -1
var _turn_hold: int = 0
var _dbg_t: float = 0.0
var _reapproach: float = 0.0
var _want_walk: bool = false
var _setup_age: float = 0.0
var _pre_start: float = 0.0
var _steady: bool = false
var _asking: bool = false
## Come again. 0 = not, 1 = turning away from the poles, 2 = riding back up
## the line for room. One rein, picked once; the exit is heading then distance.
var _cc: int = 0
var _cc_rein: int = 0
var _cc_age: float = 0.0


func _ready() -> void:
	process_physics_priority = -100
	process_mode = Node.PROCESS_MODE_ALWAYS


func bind(h: Horse, c: Course) -> void:
	horse = h
	course = c


func reset_brain() -> void:
	style_done = false
	_early_asks = 0
	_walk_age = 0.0
	_hold_age = 0.0
	_pickup_age = 0.0
	_last_next = -1
	_turn_hold = 0
	_dbg_t = 0.0
	_reapproach = 0.0
	_want_walk = false
	_setup_age = 0.0
	_pre_start = 0.0
	_steady = false
	_asking = false
	_cc = 0
	_cc_rein = 0
	_cc_age = 0.0
	phase = "pickup"
	released_jump_this_frame = false
	max_speed = 0.0
	dbg = {}
	counts = {
		"gait_up": 0, "gait_down": 0, "turn_left": 0,
		"turn_right": 0, "jump": 0, "halt": 0,
	}
	_release_all()


func _physics_process(delta: float) -> void:
	released_jump_this_frame = false
	_asking = false
	if not enabled or horse == null or not is_instance_valid(horse):
		_release_all()
		return
	if not horse.mounted or GameState.mode != "ride" or not horse.controllable:
		_release_all()
		return
	if GameState.round_complete or GameState.eliminated:
		_release_all()
		return

	max_speed = maxf(max_speed, horse.speed)
	if GameState.next_fence != _last_next:
		if _last_next > 0:
			print(
				"RIDEAI fence ", _last_next, " -> ", GameState.next_fence,
				" t=", snapped(GameState.time_sec, 0.01),
				" leave=", GameState.last_leave
			)
		if style != "clear" and _last_next == style_fence:
			style_done = true
		_last_next = GameState.next_fence
		_turn_hold = 0
		_reapproach = 0.0
		_setup_age = 0.0
		_cc = 0
		_cc_age = 0.0

	var tap_up := false
	var tap_down := false
	var want_left := false
	var want_right := false
	var want_jump := false

	if horse.jumping:
		phase = "jump"
		_apply(false, false, false, false, false)
		return

	# Canter the re-approach. Walking here ate 30s before fence 1.
	_want_walk = false
	if _want_walk:
		if horse.gait > 1:
			tap_down = true
		elif horse.gait == 0:
			tap_up = horse.refuse_cool <= 0.0
	else:
		tap_up = _want_pickup(delta)
		if horse.gait == 0:
			if horse.refuse_cool > 0.0:
				_apply(false, false, false, false, false)
				return
			_apply(false, false, false, tap_up, false)
			return

	if not GameState.start_crossed:
		# The clock starts at the flags, not on the mount. Trot onto fence one's
		# line behind the start, then come through straight. Crossing at x=0 and
		# then trying to find a fence on the rail is how fence one gets refused.
		phase = "in"
		_pre_start += delta
		var here := horse.global_position
		here.y = 0.0
		var aim := Vector3(0.0, 0.0, 1.0)
		var settle := false
		var f1 := _fence_num(1)
		if f1 != null and _pre_start < 22.0:
			var d1: Vector3 = f1.takeoff_dir()
			d1.y = 0.0
			d1 = d1.normalized() if d1.length() > 0.001 else Vector3(0.0, 0.0, 1.0)
			var fp1: Vector3 = f1.global_position
			fp1.y = 0.0
			if (
				_line_lat(here, fp1, d1) > 1.10
				or (fp1 - here).dot(d1) < 7.5
				or absf(_heading_err(d1)) > 0.40
			):
				var back1 := maxf(10.0, (fp1.z + 33.0) / maxf(d1.z, 0.30))
				var hold: Vector3 = fp1 - d1 * back1
				hold.y = 0.0
				hold.x = clampf(hold.x, -RING_X, RING_X)
				hold.z = clampf(hold.z, -RING_Z, RING_Z)
				settle = true
				aim = d1 if here.distance_to(hold) < 2.4 else _dir_to(here, hold)
			else:
				aim = d1
		_steer_from_err(_heading_err(aim), 0.10)
		if settle:
			# Trot the corner. He turns on a dime at 2.8 and the clock is off.
			tap_up = horse.gait < 2 and horse.refuse_cool <= 0.0
			tap_down = horse.gait > 2
		want_left = _turn_hold > 0
		want_right = _turn_hold < 0
		_apply(want_left, want_right, false, tap_up, tap_down)
		return

	if GameState.next_fence > GameState.fences_needed():
		phase = "out"
		var err_out := _steer_to_finish()
		_steer_from_err(err_out, 0.10)
		want_left = _turn_hold > 0
		want_right = _turn_hold < 0
		_apply(want_left, want_right, false, tap_up, tap_down)
		return

	var fence := _official()
	if fence == null:
		_apply(false, false, false, tap_up, tap_down)
		return

	var geom := _geom(fence)
	var ahead: float = geom.ahead
	var lateral: float = geom.lateral
	var ang: float = geom.ang
	var lined: bool = geom.lined
	var d: Vector3 = geom.dir
	var takeoff_pt: Vector3 = geom.takeoff
	var pos := horse.global_position
	pos.y = 0.0
	var fp: Vector3 = fence.global_position
	fp.y = 0.0
	var along: float = (fp - pos).dot(d)
	var setup := _setup_point(fp, d, fence)
	var on_line := _line_lat(pos, fp, d)
	var related := _on_related_line()
	var dist_setup := pos.distance_to(setup)
	var dist_f := pos.distance_to(fp)

	dbg = {
		"ahead": ahead, "lat": lateral, "ang": rad_to_deg(ang),
		"along": along, "on_line": on_line, "phase": phase,
		"charge": horse.charge, "leave": GameState.last_leave,
	}

	_dbg_t += delta
	if _dbg_t > 1.0:
		_dbg_t = 0.0
		print(
			"RIDEAI sit n=", GameState.next_fence,
			" phase=", phase,
			" pos=", snapped(pos.x, 0.1), ",", snapped(pos.z, 0.1),
			" ahead=", snapped(ahead, 0.01),
			" lat=", snapped(on_line, 0.02),
			" ang=", snapped(rad_to_deg(ang), 0.1),
			" along=", snapped(along, 0.1),
			" gait=", horse.gait,
			" v=", snapped(horse.speed, 0.01),
			" rein=", _turn_hold
		)

	# Ring: walk him back if he is off the sand.
	if absf(pos.x) > RING_X + 0.8 or absf(pos.z) > RING_Z + 0.8:
		phase = "sand"
		var home := Vector3(clampf(pos.x, -11.0, 11.0), 0.0, clampf(pos.z, -33.0, 33.0))
		var err_h := _heading_err((home - pos).normalized())
		_steer_from_err(err_h, 0.12)
		_apply(_turn_hold > 0, _turn_hold < 0, false, tap_up, tap_down)
		return

	# Sit for the corner and stay sat. A collected canter turns on 3.2 m; at
	# 5.55 the circle is 5.2 m and it does not fit between the rail and the
	# next standard. Hysteresis so he takes the rein once, not ten times —
	# every fresh press is another half-halt he has to ride out of.
	var corner_err := _heading_err(_dir_to(pos, _aim_setup(pos, setup, fence, along)))
	# Sit while there is still a turn to make onto the line. Reaching the
	# setup point is not arriving: he can be standing on the line pointing
	# ninety degrees across it, and the aim error goes quiet exactly then.
	# He gave the rein back, wound up to 5.1, turned on a 5.2 m circle and
	# met the fence 2.6 m out and 29 degrees crooked. That is the shoulder-rail.
	# Near the line AND near the fence. Twenty metres up a jump-off approach he
	# has all the room he needs to straighten, and sitting there is 40 s.
	var turn_err := absf(corner_err)
	if on_line < 4.5 and along < 15.0:
		turn_err = maxf(turn_err, absf(_heading_err(d)))

	# Sit the land unless this is a related — a one-stride does not wait.
	# Jump-off: don't sit. The clock is already running.
	var sit_land := (
		horse.land_recover > 0.42
		and not GameState.jump_off
		and not (related and on_line < 2.5 and along < 12.0)
		and not (along < 8.0 and on_line < 2.5)
	)
	if sit_land:
		phase = "land"
		_steer_from_err(corner_err, 0.20)
		_apply(_turn_hold > 0, _turn_hold < 0, _steady_for(turn_err), tap_up, tap_down)
		return

	# About to run into something straight ahead before the rein can bite.
	# Not a re-route — just don't hit it. Turn the other way and sit.
	var lead := clampf(horse.speed / maxf(Horse.GAIT_TURN[Horse.CANTER] * GameState.turn_scale(), 0.25), 1.2, 6.5)
	var lead_hit := _first_hit(pos, pos + _fwd() * lead, fence, 0.0)
	if lead_hit != null and _cc == 0:
		phase = "shy"
		var bp: Vector3 = lead_hit.global_position
		bp.y = 0.0
		_turn_hold = -1 if _heading_err(_dir_to(pos, bp)) > 0.0 else 1
		_apply(_turn_hold > 0, _turn_hold < 0, true, tap_up, tap_down)
		return

	# Come again. Not a timer and not a waypoint: a committed circle. Turn away
	# from the poles on one rein until he is pointing back down the ring, then
	# ride back up the line until there is room, then re-plan. Each phase has
	# one number that only moves one way — heading, then distance — so it
	# cannot orbit. The old `_reapproach = 2.2` locked steering at a setup point
	# for two seconds and every escape hatch fed it a target it could not reach.
	var too_close := along < 3.6 and on_line > 1.55
	var past := along < 0.45 and dist_f < 10.0
	var perp_close := along < 3.5 and on_line > 1.8 and absf(_heading_err(d)) > 1.0
	# On top of it and across it. The ask wants 18 degrees and he is at 40; he
	# cannot straighten in three metres, so driving on is a shoulder through
	# the plane. Refuse it and come again — that is what a person does.
	var crooked := (
		along < 4.4 and along > -1.0
		and rad_to_deg(ang) > 26.0
		and horse.gait == Horse.CANTER
	)
	if _cc == 0 and (past or too_close or perp_close or crooked):
		_cc_begin(pos, fp, d)
		_setup_age = 0.0
	if _cc != 0:
		_cc_age += delta
		if _cc == 1:
			# One rein, held. Sit so the circle is 3.2 m and not 5.2 m.
			phase = "away"
			_turn_hold = _cc_rein
			if absf(_heading_err(-d)) < 0.55 or _cc_age > 5.0:
				_cc = 2
			_apply(_turn_hold > 0, _turn_hold < 0, true, tap_up, tap_down)
			return
		phase = "again"
		var back_pt: Vector3 = fp - d * 16.0
		back_pt.x = clampf(back_pt.x, -RING_X, RING_X)
		back_pt.z = clampf(back_pt.z, -RING_Z, RING_Z)
		var cc_err := _heading_err(_dir_to(pos, _path_target(pos, back_pt, fence)))
		_steer_from_err(cc_err, 0.10)
		if (along >= 12.0 and on_line < 6.0) or _cc_age > 11.0:
			_cc = 0
			_cc_age = 0.0
			_want_walk = false
		_apply(_turn_hold > 0, _turn_hold < 0, _steady_for(cc_err), tap_up, tap_down)
		return

	# Off the line: curve down onto it, never across another standard.
	if (not related) and on_line > 2.0:
		_setup_age += delta
		if _setup_age > 7.0:
			# Hanging about in front of the fence. Come again properly.
			_cc_begin(pos, fp, d)
			_setup_age = 0.0
			phase = "away"
			_turn_hold = _cc_rein
			_apply(_turn_hold > 0, _turn_hold < 0, true, tap_up, tap_down)
			return
		phase = "setup"
		_steer_from_err(corner_err, 0.10)
		_apply(_turn_hold > 0, _turn_hold < 0, _steady_for(turn_err), tap_up, tap_down)
		return

	_setup_age = 0.0
	# On the line. Ride to the takeoff. Collect the last strides. Ask at 2.55.
	# First: is anything standing on the line home? On this board the home
	# fence and the away fence share a rail, so the run to fence seven can go
	# straight through fence five. Go by its shoulder and straighten after.
	phase = "approach"
	var desired: Vector3
	var blocker := _first_hit(pos, takeoff_pt, fence, 0.0)
	if blocker != null and along > 6.0:
		phase = "around"
		desired = _dir_to(pos, _path_target(pos, takeoff_pt, fence))
	else:
		desired = _approach_heading(pos, takeoff_pt, d, along, on_line)
	var herr := _heading_err(desired)
	_steer_from_err(herr, 0.10 if along < 8.0 else 0.14)

	var want_ask := _should_ask(ahead, lined, ang, lateral, on_line)
	var collect_out := 4.5 if GameState.jump_off else 9.5
	var collect := (
		ahead > 0.95 and ahead < collect_out
		and on_line < 1.70
		and along > 1.2
		and absf(rad_to_deg(ang)) < 28.0
	)
	var half := _steady_for(herr) and not want_ask

	if want_ask:
		_asking = true
		if style != "clear" and not style_done and GameState.next_fence == style_fence:
			if style == "refuse_twice" or style == "refuse_three":
				_early_asks += 1
				var need: int = 2
				if style == "refuse_three":
					need = 3
				if _early_asks >= need:
					style_done = true
			else:
				style_done = true
		print(
			"RIDEAI ASK n=", GameState.next_fence,
			" ahead=", snapped(ahead, 0.01),
			" lat=", snapped(lateral, 0.02),
			" ang=", snapped(rad_to_deg(ang), 0.1),
			" charge=", snapped(horse.charge, 0.02)
		)
		_apply(false, false, false, tap_up, tap_down)
		return

	want_jump = collect or half
	if not want_jump and _is_held(ACT_JUMP) and not _safe_release(ahead, lateral, lined):
		want_jump = true
	_apply(_turn_hold > 0, _turn_hold < 0, want_jump, tap_up, tap_down)


func _want_pickup(delta: float) -> bool:
	if horse.gait >= Horse.CANTER:
		_walk_age = 0.0
		_pickup_age = 0.0
		return false
	if horse.gait == 0:
		_walk_age = 0.0
		_pickup_age = 0.0
		return horse.refuse_cool <= 0.0
	if horse.gait == 1:
		_walk_age += delta
		if GameState.session_kind == "lesson" and not GameState.start_crossed:
			return _walk_age > 0.85
		return _walk_age > 0.40
	_pickup_age += delta
	return _pickup_age > 0.16


func _should_ask(ahead: float, lined: bool, ang: float, _lat: float, on_line: float) -> bool:
	if horse.gait != Horse.CANTER:
		return false
	if horse.refuse_cool > 0.0:
		return false
	if not lined:
		return false
	if not _is_held(ACT_JUMP):
		return false
	if _hold_age < 0.12:
		return false
	if _nearest_ahead() != _official():
		return false
	if on_line > 1.15:
		return false
	if rad_to_deg(ang) > 18.0:
		return false
	var target := _ask_ahead()
	var ws := GameState.window_scale()
	if style == "clear" or style_done:
		if ahead > TAKEOFF + 0.04:
			return false
		if ahead < TAKEOFF - 0.28 * ws:
			return false
		if horse.charge < 0.20 and ahead > TAKEOFF - 0.04:
			return false
		return true
	return ahead <= target + 0.12 and ahead >= target - 0.38


func _ask_ahead() -> float:
	if not style_done:
		if style == "refuse_early" and GameState.next_fence == style_fence:
			return 4.2
		if style == "rail_late" and GameState.next_fence == style_fence:
			return 1.3
		if (style == "refuse_twice" or style == "refuse_three") and GameState.next_fence == style_fence:
			return 4.2
	return TAKEOFF


func _safe_release(ahead: float, lateral: float, lined: bool) -> bool:
	if ahead > 6.0:
		return true
	if ahead < 0.35:
		return true
	if (not lined) and lateral >= 2.05:
		return true
	return false


func _setup_point(fp: Vector3, d: Vector3, official: JumpFence) -> Vector3:
	# 8–12 m before the fence, but never on another standard.
	# Jump-off takes the tighter 6–8 m.
	var backs: Array = [10.0, 8.0, 12.0, 7.0, 6.5, 9.0, 11.0, 5.8]
	if GameState.jump_off:
		backs = [7.0, 6.5, 8.0, 5.8, 9.0, 10.0]
	for back in backs:
		var s: Vector3 = fp - d * back
		s.y = 0.0
		s.x = clampf(s.x, -RING_X, RING_X)
		s.z = clampf(s.z, -RING_Z, RING_Z)
		if _spot_clear(s, official, 4.0):
			return s
	var fallback: Vector3 = fp - d * 8.0
	fallback.x = move_toward(fallback.x, 0.0, 4.6)
	fallback.y = 0.0
	fallback.x = clampf(fallback.x, -RING_X, RING_X)
	fallback.z = clampf(fallback.z, -RING_Z, RING_Z)
	return fallback


func _first_hit(a: Vector3, b: Vector3, official: JumpFence, _min_d: float) -> JumpFence:
	var ab: Vector3 = b - a
	ab.y = 0.0
	var lab := ab.length()
	if lab < 0.2:
		return null
	var nrm := ab / lab
	var best: JumpFence = null
	var best_t := lab + 1.0
	for n in get_tree().get_nodes_in_group("fences"):
		if not (n is JumpFence) or not is_instance_valid(n):
			continue
		if official != null and n == official:
			continue
		var f: JumpFence = n
		var fp := f.global_position
		fp.y = 0.0
		var t := clampf((fp - a).dot(nrm), 0.0, lab)
		if t < 0.6:
			continue
		var closest: Vector3 = a + nrm * t
		closest.y = 0.0
		if _would_knock(f, closest) and t < best_t:
			best_t = t
			best = f
	return best


func _beside(blocker: JumpFence, d: Vector3, pos: Vector3) -> Vector3:
	# Pass north or south of the blocker, never through it.
	var bp := blocker.global_position
	bp.y = 0.0
	var inward := -signf(bp.x) if absf(bp.x) > 0.8 else 1.0
	var dz := 4.2 if pos.z >= bp.z else -4.2
	var p := Vector3(
		clampf(bp.x + inward * 4.2, -RING_X, RING_X),
		0.0,
		clampf(bp.z + dz, -RING_Z, RING_Z)
	)
	if not _spot_clear(p, blocker, 2.9):
		p.x = clampf(bp.x + inward * 5.4, -RING_X, RING_X)
	return p


func _spot_clear(s: Vector3, official: JumpFence, min_d: float) -> bool:
	# Euclidean 4 m rejected a legal 10 m setup 2.5 m beside another fence,
	# then fallback sat him at x=0 and he orbited.
	for n in get_tree().get_nodes_in_group("fences"):
		if not (n is JumpFence) or n == official:
			continue
		var f: JumpFence = n
		if min_d >= 3.0:
			if _near_fence(f, s, 2.40, 1.15 + f.spread * 0.5):
				return false
		elif _would_knock(f, s):
			return false
	return true


func _near_fence(f: JumpFence, p: Vector3, rail_lim: float, thru_lim: float) -> bool:
	var fp: Vector3 = f.global_position
	fp.y = 0.0
	var d := f.takeoff_dir()
	d.y = 0.0
	d = d.normalized() if d.length() > 0.001 else Vector3(0.0, 0.0, 1.0)
	var rail := Vector3(-d.z, 0.0, d.x)
	var q: Vector3 = p
	q.y = 0.0
	return absf((q - fp).dot(rail)) < rail_lim and absf((q - fp).dot(d)) < thru_lim


func _aim_setup(pos: Vector3, setup: Vector3, official: JumpFence, _along: float) -> Vector3:
	# There used to be a "far from the fence, just go straight" shortcut here
	# that skipped the obstacle check entirely. That is how he cantered
	# through #2 on the way to #10 with seventeen metres still to run.
	# _path_target hands the setup straight back when the way is clear, so
	# the rollback home costs nothing.
	return _path_target(pos, setup, official)


func _path_target(pos: Vector3, setup: Vector3, official: JumpFence) -> Vector3:
	# Do not send him through x=0 — that is the top oxer. Go around the blocker.
	# The fence he is going to jump counts too: the setup sits on its approach
	# side, so any time he is on the landing side the straight line home goes
	# through its poles. That is where most of the remaining rails came from.
	var hit := _first_hit(pos, setup, null, 0.0)
	if hit == null:
		return setup
	var bp: Vector3 = hit.global_position
	bp.y = 0.0
	var hd := hit.takeoff_dir()
	hd.y = 0.0
	hd = hd.normalized() if hd.length() > 0.001 else Vector3(0.0, 0.0, 1.0)
	var rail := Vector3(-hd.z, 0.0, hd.x)
	var best: Vector3 = setup
	var best_sc := 1.0e9
	var found := false
	for s in [4.4, -4.4]:
		for p0 in [bp + rail * s, bp + hd * s]:
			var p: Vector3 = p0
			p.y = 0.0
			p.x = clampf(p.x, -RING_X, RING_X)
			p.z = clampf(p.z, -RING_Z, RING_Z)
			if not _spot_clear(p, official, 2.6):
				continue
			if _first_hit(pos, p, null, 0.0) != null:
				continue
			var sc := p.distance_to(setup)
			if sc < best_sc:
				best_sc = sc
				best = p
				found = true
	if found:
		return best
	# Turn away, get ten meters from the blocker, come again.
	var away_dir: Vector3 = pos - bp
	away_dir.y = 0.0
	var away: Vector3
	if away_dir.length() < 0.4:
		away = pos - hd * 8.0
	else:
		away = pos + away_dir.normalized() * 8.0
	away.y = 0.0
	away.x = clampf(away.x, -RING_X, RING_X)
	away.z = clampf(away.z, -RING_Z, RING_Z)
	return away


func _would_knock(f: JumpFence, p: Vector3) -> bool:
	# Match the real Knock area, which is width*0.9 by (0.35 + spread) deep and
	# sits half a spread back along the takeoff dir. The old model hard-coded
	# 1.10 m through and ignored spread, so an oxer read 0.4 m shallower than
	# it is — every detour candidate round hk_int_001 #9 scored clear and he
	# cantered the plane at 3.9 m/s. Horse box is 0.62 x 2.20.
	var fp: Vector3 = f.global_position
	fp.y = 0.0
	var d := f.takeoff_dir()
	d.y = 0.0
	d = d.normalized() if d.length() > 0.001 else Vector3(0.0, 0.0, 1.0)
	var rail := Vector3(-d.z, 0.0, d.x)
	var q: Vector3 = p
	q.y = 0.0
	var box: Vector3 = fp - d * (f.spread * 0.5)
	# Keep the proven 1.10 for a plain pole and add only what the spread is
	# really worth. Deepening every fence by 0.125 m moved him just enough to
	# arrive crooked at a flower in the jump-off — the oxer is the only thing
	# this was ever wrong about.
	var thru: float = 1.10 + f.spread * 0.5
	return absf((q - box).dot(rail)) < 2.35 and absf((q - box).dot(d)) < thru


func _segment_hits(a: Vector3, b: Vector3, official: JumpFence, _min_d: float) -> bool:
	return _first_hit(a, b, official, 0.0) != null


func _line_lat(pos: Vector3, fp: Vector3, d: Vector3) -> float:
	var perp := Vector3(-d.z, 0.0, d.x)
	return absf((pos - fp).dot(perp))


func _approach_heading(pos: Vector3, takeoff_pt: Vector3, d: Vector3, along: float, on_line: float) -> Vector3:
	var to := takeoff_pt - pos
	to.y = 0.0
	if to.length() < 0.25:
		return d
	var to_n := to.normalized()
	# Ride to the spot while he is still off the line; only lie parallel once
	# he is on it. Straightening early leaves him crabbing 1.5 m wide, which
	# is outside the ask and reads as a fence he cannot jump.
	var straighten := clampf((1.35 - on_line) / 0.90, 0.0, 1.0)
	if straighten <= 0.0:
		return to_n
	var k := clampf((7.0 - along) / 5.0, 0.0, 1.0)
	var blended: Vector3 = to_n.lerp(d, (0.35 + 0.65 * k) * straighten)
	if blended.length() > 0.001:
		return blended.normalized()
	return d


func _on_related_line() -> bool:
	var b := _official()
	var a := _fence_num(GameState.next_fence - 1)
	if a == null or b == null:
		return false
	var v: Vector3 = b.global_position - a.global_position
	v.y = 0.0
	var mag := v.length()
	if mag < 6.2 or mag > 16.5:
		return false
	var dyaw := absf(a.rotation.y - b.rotation.y)
	dyaw = minf(dyaw, absf(dyaw - TAU))
	if dyaw > 0.40:
		return false
	var d := b.takeoff_dir()
	d.y = 0.0
	if d.length() < 0.001:
		return false
	d = d.normalized()
	return absf(v.normalized().dot(d)) > 0.88


func _steer_to_finish() -> float:
	var z := -36.2
	if course and course.finish_area:
		z = course.finish_area.global_position.z
	var pos := horse.global_position
	# Down the middle — the right rail is fence 1 on the way to OUT.
	var target := Vector3(0.0, 0.0, z)
	if absf(pos.z - z) < 6.0:
		target.x = clampf(pos.x, -8.0, 8.0)
	return _heading_err(_dir_to(Vector3(pos.x, 0.0, pos.z), target))


func _steer_from_err(herr: float, dead: float) -> void:
	var hold := dead * 0.45
	if _turn_hold > 0 and herr > hold:
		return
	if _turn_hold < 0 and herr < -hold:
		return
	if herr > dead:
		_turn_hold = 1
	elif herr < -dead:
		_turn_hold = -1
	else:
		_turn_hold = 0


func _geom(fence: JumpFence) -> Dictionary:
	var pos := horse.global_position
	pos.y = 0.0
	var fp := fence.global_position
	fp.y = 0.0
	var to := fp - pos
	to.y = 0.0
	var approach := _fwd()
	var ahead := to.dot(approach)
	var lateral := absf(to.cross(Vector3.UP).dot(approach))
	var d := fence.takeoff_dir()
	d.y = 0.0
	d = d.normalized() if d.length() > 0.001 else Vector3(0, 0, 1)
	var ang := absf(approach.angle_to(d))
	var rs := GameState.refuse_scale()
	var lined := lateral < 1.20 * rs and ang < deg_to_rad(28.0 * rs)
	return {
		"ahead": ahead, "lateral": lateral, "ang": ang, "lined": lined,
		"dir": d, "takeoff": fp - d * TAKEOFF,
	}


func _nearest_ahead() -> JumpFence:
	var best: JumpFence = null
	var best_d := 7.5
	var approach := _fwd()
	for n in get_tree().get_nodes_in_group("fences"):
		if not (n is JumpFence) or not is_instance_valid(n):
			continue
		var f: JumpFence = n
		var to := f.global_position - horse.global_position
		to.y = 0.0
		if to.dot(approach) < 0.3:
			continue
		var dd := to.length()
		if dd < best_d:
			best_d = dd
			best = f
	return best


func _official() -> JumpFence:
	return _fence_num(GameState.next_fence)


func _fence_num(num: int) -> JumpFence:
	for n in get_tree().get_nodes_in_group("fences"):
		if n is JumpFence and (n as JumpFence).number == num:
			return n
	return null


func _fwd() -> Vector3:
	var f: Vector3 = -horse.transform.basis.z
	f.y = 0.0
	if f.length() < 0.001:
		return Vector3(0, 0, 1)
	return f.normalized()


func _dir_to(from: Vector3, to: Vector3) -> Vector3:
	var v := to - from
	v.y = 0.0
	if v.length() < 0.05:
		return _fwd()
	return v.normalized()


func _heading_err(desired: Vector3) -> float:
	var fwd := _fwd()
	var des := desired
	des.y = 0.0
	if des.length() < 0.001:
		return 0.0
	des = des.normalized()
	return atan2(fwd.z * des.x - fwd.x * des.z, fwd.dot(des))


func _cc_begin(pos: Vector3, fp: Vector3, d: Vector3) -> void:
	# Away from the poles: the first thing he does is put the fence behind his
	# shoulder. Head-on, turn toward the open side of the ring instead.
	var to_fence := _heading_err(_dir_to(pos, fp))
	if absf(to_fence) > 0.25:
		_cc_rein = -1 if to_fence > 0.0 else 1
	else:
		_cc_rein = 1 if pos.x > 0.0 else -1
	_cc = 1
	_cc_age = 0.0
	print(
		"RIDEAI come again n=", GameState.next_fence,
		" rein=", _cc_rein,
		" pos=", snapped(pos.x, 0.1), ",", snapped(pos.z, 0.1)
	)


func _steady_for(err: float) -> bool:
	# One rein, taken once. A twenty-degree correction does not need a sit;
	# a corner at a gallop does, because 5.2 m of turning circle does not fit.
	# 4.5 was too high a bar: at 4.34 m/s he still turns on 4.0 m, which does
	# not fit a nine-metre run onto the line, and he arrives crooked.
	if absf(err) > 0.60 and horse.speed > 3.9:
		_steady = true
	elif absf(err) < 0.25 or horse.speed < 3.0:
		_steady = false
	return _steady and horse.refuse_cool <= 0.0


func _release_ok() -> bool:
	# Dropping the rein inside somebody's takeoff window is a leave you did not
	# mean: a look, a chip, or a wrong-fence halt. Only the ask lets go there.
	var f := _nearest_ahead()
	if f == null:
		return true
	var to: Vector3 = f.global_position - horse.global_position
	to.y = 0.0
	var a := to.dot(_fwd())
	return a > 5.6 or a < 0.35


func _apply(left: bool, right: bool, jump: bool, tap_up: bool, tap_down: bool) -> void:
	if (
		not jump
		and not _asking
		and _is_held(ACT_JUMP)
		and horse != null
		and is_instance_valid(horse)
		and horse.gait == Horse.CANTER
		and not horse.jumping
		and not _release_ok()
	):
		jump = true
	if left and right:
		left = false
		right = false
	_hold(ACT_LEFT, left)
	_hold(ACT_RIGHT, right)
	_hold(ACT_HALT, false)
	_tap(ACT_GAIT_UP, tap_up)
	_tap(ACT_GAIT_DOWN, tap_down)
	var was_jump := _is_held(ACT_JUMP)
	if jump:
		_hold(ACT_JUMP, true)
		_hold_age += get_physics_process_delta_time()
	else:
		if was_jump:
			released_jump_this_frame = true
		_hold(ACT_JUMP, false)
		_hold_age = 0.0


func _tap(action: String, want: bool) -> void:
	var left_frames: int = int(_tap_left.get(action, 0))
	if left_frames > 0:
		_hold(action, true)
		_tap_left[action] = left_frames - 1
		return
	if want and not _is_held(action):
		_hold(action, true)
		_tap_left[action] = 1
		return
	_hold(action, false)


func _hold(action: String, on: bool) -> void:
	var cur := _is_held(action)
	if on and not cur:
		Input.action_press(action)
		_held[action] = true
		counts[action] = int(counts.get(action, 0)) + 1
	elif not on and cur:
		Input.action_release(action)
		_held[action] = false


func _is_held(action: String) -> bool:
	return bool(_held.get(action, false))


func _release_all() -> void:
	for a in [ACT_GAIT_UP, ACT_GAIT_DOWN, ACT_LEFT, ACT_RIGHT, ACT_JUMP, ACT_HALT]:
		if _is_held(a) or Input.is_action_pressed(a):
			Input.action_release(a)
		_held[a] = false
	_tap_left.clear()
	_hold_age = 0.0
