class_name Trainer
extends RefCounted

## Michelle on the rail. One true sentence after a leave.


static func phrase(kind: String) -> String:
	var session := ""
	var cid := ""
	if Engine.get_main_loop() != null:
		session = str(GameState.session_kind)
		cid = str(GameState.class_id)
	var lib := ContentLibrary.phrase(kind, session, cid)
	if lib != "":
		return lib
	match kind:
		"early":
			return "Too soon. Wait for the last stride, then ask."
		"spot":
			return "That was the spot."
		"deep":
			return "A little deep. Make the last stride."
		"chip":
			return "Chip. Don't get there on a half stride."
		"looked":
			return "He looked. Straight and quiet."
		"wrong":
			return "That's not the next fence."
		"rail":
			return "Rail. He left late."
		"refuse":
			return "Whoa. Come again to the same fence."
		"off_course":
			return "Off course. That's elimination."
		"three":
			return "Three refusals. That's the end of the round."
		"time":
			return "Time limit. That's the end of the round."
		"lesson_start":
			return "Walk him first. Pick up the canter before the flags. Wait for the last stride."
		"jump_off":
			return "Jump-off. Four fences. Don't chase him."
		"clear":
			return "That's a clear. Pat him and walk out."
		"ribbon":
			return "Ribbon. Don't get sloppy now."
		"steady":
			return "Steady. Sit. Let him find it."
		"walk_out":
			return "Walk him out. Let him blow."
		"halt":
			return "Whoa means whoa. Sit down."
		"pat":
			return "Pat him. He tried."
		"straight":
			return "Straight. Eyes up. Don't drop him."
		"leave":
			return "Leave with him. Don't wait after the stride."
		_:
			return ""
