extends Node

## The arena's score board shows the round as it runs: the clock and the
## faults, like the board at a real show. Ten times a second is plenty.

var time_lab: Label3D
var faults_lab: Label3D
var _acc := 0.0


## Copies the clock and the faults onto the board. Ten times a second is enough to read.
func _process(delta: float) -> void:
	_acc += delta
	if _acc < 0.1:
		return
	_acc = 0.0
	var gs := get_node_or_null("/root/GameState")
	if gs == null or time_lab == null or faults_lab == null:
		return
	var t := "--.--"
	var f := "0"
	if bool(gs.get("round_complete")):
		t = "%0.2f" % float(gs.get("last_time"))
		f = str(int(gs.get("last_faults")))
	elif bool(gs.get("start_crossed")):
		t = "%0.2f" % float(gs.get("time_sec"))
		f = str(int(gs.get("faults")))
	if time_lab.text != t:
		time_lab.text = t
	if faults_lab.text != f:
		faults_lab.text = f
