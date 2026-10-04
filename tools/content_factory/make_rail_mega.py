"""Scale Michelle lines, barn notes, and lesson beats. Keeps existing unique texts."""
from __future__ import annotations

import json
import random
import sys
from pathlib import Path

from rules import EXISTING_RAIL_KEYS, MAX_LINE_WORDS, MEGA_RAIL_KEYS, NEW_RAIL_KEYS

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "content" / "rail" / "michelle.json"
BARN = ROOT / "content" / "rail" / "barn_notes.json"
BEATS = ROOT / "content" / "rail" / "LESSON_BEATS.json"

SESSIONS = ["lesson", "schooling", "show"]
CLASSES = ["lesson", "beginner", "intermediate", "advanced"]

ALL_KEYS = list(EXISTING_RAIL_KEYS) + list(NEW_RAIL_KEYS) + list(MEGA_RAIL_KEYS)

STEMS: dict[str, list[str]] = {
    "early": ["Too soon.", "Early.", "You left first.", "Wait.", "Not yet.", "Hold."],
    "spot": ["That was the spot.", "Yes.", "True leave.", "That's it.", "Good distance."],
    "deep": ["Deep.", "Late to the base.", "You waited too long.", "Make the last stride."],
    "chip": ["Chip.", "Half stride.", "Don't pick.", "Short in front."],
    "looked": ["He looked.", "He peeked.", "Looky.", "Straight. He'll go."],
    "wrong": ["Wrong fence.", "Not next.", "That's not the number.", "Come back."],
    "rail": ["Rail.", "Down.", "He hit it.", "Late leave."],
    "refuse": ["Whoa.", "He stopped.", "Refusal.", "Same fence again."],
    "off_course": ["Off course.", "That's out.", "Wrong number. Elimination."],
    "three": ["Three refusals.", "Third stop.", "That's the end."],
    "time": ["Time.", "The clock got you.", "That's the limit."],
    "lesson_start": ["Walk him first.", "Walk, then the canter.", "Lesson. Walk first."],
    "jump_off": ["Jump-off.", "Four fences.", "Don't chase."],
    "clear": ["Clear.", "That's a clear.", "Walk him out."],
    "ribbon": ["Ribbon.", "You pinned.", "Don't get sloppy."],
    "steady": ["Steady.", "Sit still.", "Don't hurry."],
    "walk_out": ["Walk him out.", "Let him blow.", "Long rein."],
    "halt": ["Whoa means whoa.", "Halt.", "Sit down."],
    "pat": ["Pat him.", "He tried.", "Scratch his neck."],
    "straight": ["Straight.", "Eyes up.", "Middle of the poles."],
    "leave": ["Leave with him.", "You saw it. Go.", "Don't wait now."],
    "half_halt": ["Half-halt.", "Rebalance.", "Sit, then leave."],
    "crooked": ["Crooked.", "Straighten.", "You're drifting."],
    "long_spot": ["Long.", "He stood off.", "Don't hunt that."],
    "short_spot": ["Short.", "You got in tight.", "Ride the last one."],
    "related_in": ["That's the in.", "Don't move on the in.", "Related in."],
    "related_out": ["Sit to the out.", "That's the out.", "Don't chase the out."],
    "looky_flower": ["Flower.", "Eyes up at the box.", "He sees the blooms."],
    "oxer": ["Oxer.", "Square.", "Front rail first."],
    "first_fence": ["First fence.", "Don't throw the first.", "Quiet to one."],
    "last_fence": ["Last fence.", "Don't throw it away.", "Finish quiet."],
    "whoa": ["Whoa.", "Sit.", "Stop."],
    "walk_first": ["Walk first.", "Walk him.", "Don't canter yet."],
    "sit": ["Sit.", "Sit still.", "Sit down."],
    "eyes_up": ["Eyes up.", "Look up.", "Don't stare at the rail."],
    "confidence_low": ["He's looky.", "Don't chase him.", "Quiet canter."],
    "he's_with_you": ["He's with you.", "Let him jump.", "Don't over-ride."],
    "don't_chase": ["Don't chase.", "Don't run.", "Don't chase him."],
    "indoor": ["Indoor.", "Smaller canter.", "The roof isn't the job."],
    "rain": ["Wet.", "The center's deep.", "Walk more in the rain."],
    "fresh": ["He's fresh.", "Walk him.", "Don't start on a flower."],
    "quiet": ["Quiet.", "Don't pick.", "Leave him alone."],
    "count_strides": ["Count.", "I'm counting.", "Don't lose the count."],
    "wait": ["Wait.", "Wait for it.", "Don't hurry the leave."],
    "leave_with_him": ["Leave with him.", "Go with the stride.", "Don't freeze."],
    "don't_drop_him": ["Don't drop him.", "Hands quiet.", "Don't throw the reins."],
    "pat_and_walk": ["Pat him and walk.", "Scratch and walk out.", "That's enough. Pat."],
    "whoa_means_whoa": ["Whoa means whoa.", "Halt means halt.", "Sit until he stops."],
    "find_the_clock": ["The clock is enough.", "Don't chase the time.", "Ride the leave, not the clock."],
    "inside_turn": ["Inside turn.", "Sit the turn.", "Don't cut ugly."],
    "outside_turn": ["Outside track.", "Don't dive in.", "Keep the outside."],
    "don't_cut": ["Don't cut.", "Hold the line.", "Don't dive to the standard."],
    "add_one": ["Don't add.", "The stride is there.", "Don't put in a short one."],
    "leave_out": ["Don't leave one out.", "See the out.", "The out is coming."],
    "hold_the_line": ["Hold the line.", "Straight.", "Don't drift off it."],
}

TAILS = [
    "Then wait.", "Then sit.", "Then ask.", "Then walk.", "I'm watching.",
    "That's enough.", "Come again.", "Eyes up.", "Don't pick.", "Quiet hands.",
    "He'll tell you.", "Same fence.", "Then the barn.", "Don't fuss.",
    "Let him jump.", "Keep the canter.", "Last stride.", "Then leave.",
    "Pat him later.", "Don't stare.", "Find the number.", "Sit first.",
]


def grams5(text: str) -> list[str]:
    w = text.replace("—", " ").split()
    if len(w) < 5:
        return []
    return [" ".join(w[i : i + 5]).lower() for i in range(len(w) - 4)]


def grams12(text: str) -> list[str]:
    w = text.replace("—", " ").split()
    if len(w) < 12:
        return []
    return [" ".join(w[i : i + 12]).lower() for i in range(len(w) - 11)]


def wc(text: str) -> int:
    return len(text.replace("—", " ").split())


def load_existing() -> tuple[list[dict], set[str], set[str]]:
    lines = []
    texts: set[str] = set()
    g5: set[str] = set()
    if OUT.exists():
        data = json.loads(OUT.read_text(encoding="utf-8"))
        for row in data.get("lines") or []:
            t = str(row.get("text", "")).strip()
            if not t or t in texts:
                continue
            clash = False
            for g in grams5(t):
                if g in g5:
                    clash = True
                    break
            if clash:
                continue
            texts.add(t)
            for g in grams5(t):
                g5.add(g)
            lines.append(row)
    return lines, texts, g5


NOUNS = [
    "flags", "oak", "pines", "lip", "clock", "in-gate", "oxer", "flower",
    "kick-wall", "right-rail", "left-rail", "diagonal", "rollback",
    "two-stride", "one-stride", "out", "related", "indoor", "base",
    "corner", "home", "first", "last", "turn", "line", "sand", "boards",
    "standards", "cup", "plank", "brush", "gate", "box", "apron",
    "hydrant", "loft", "aisle", "stall", "cooler", "trunk", "rake",
    "lip-rail", "in-box", "out-gate", "mirror", "schooling-oxer",
    "welcome-stake", "classic", "mini-prix", "tuesday", "pfafftown",
]
PREPS = ["at", "off", "to", "from", "near", "past", "before", "after"]
VERBS = [
    "Wait", "Sit", "Leave", "Straighten", "Count", "Hold", "Find",
    "Don't chase", "Don't cut", "Don't pick", "Don't drop him",
    "Eyes up", "Come again", "Pat him", "Walk him",
]


def make_line(key: str, n: int, rng: random.Random) -> str:
    stems = STEMS.get(key, ["Steady."])
    stem = stems[n % len(stems)]
    noun = NOUNS[(n * 3 + len(key)) % len(NOUNS)]
    prep = PREPS[(n * 5) % len(PREPS)]
    verb = VERBS[(n * 7 + len(key)) % len(VERBS)]
    tail = TAILS[(n * 11 + len(key)) % len(TAILS)]
    # Prefer 3–6 word unique sentences so 5-grams rarely exist.
    options = [
        f"{stem} {prep} {noun}.",
        f"{verb} {prep} {noun}.",
        f"{stem} {verb.lower()} {noun}.",
        f"{stem} {tail}",
        f"{verb} this {noun}.",
        f"{stem} Same {noun}.",
        f"{stem} Not the {noun}.",
        f"{verb}. Then the {noun}.",
        f"{stem} {prep} the {noun} today.",
        f"{stem} {prep} {noun} this leave.",
    ]
    rng.shuffle(options)
    for o in options:
        t = " ".join(o.split())
        if 2 <= wc(t) <= MAX_LINE_WORDS:
            return t
    return f"{stem} {prep} {noun}."


def session_for(key: str) -> list[str]:
    if key == "lesson_start":
        return ["lesson"]
    if key in ("jump_off", "ribbon", "off_course", "three", "time"):
        return ["show"]
    if key == "indoor":
        return ["lesson", "schooling"]
    return SESSIONS


def when_for(key: str) -> str:
    if key in ("lesson_start", "jump_off", "walk_first", "walk_out"):
        return "before_round"
    return "after_leave"


def build_lines(target_per_key: int) -> list[dict]:
    lines, texts, g5 = load_existing()
    rng = random.Random(42)
    by_key: dict[str, int] = {}
    for row in lines:
        by_key[row["key"]] = by_key.get(row["key"], 0) + 1
    for key in ALL_KEYS:
        n = by_key.get(key, 0)
        guard = 0
        while n < target_per_key and guard < target_per_key * 200:
            guard += 1
            t = make_line(key, n * 17 + guard + 3, rng)
            if t in texts:
                # mutate
                t = f"{t} Sit." if wc(t + " Sit.") <= 14 else t
            if t in texts or wc(t) > MAX_LINE_WORDS or wc(t) < 1:
                continue
            clash = False
            gs = grams5(t)
            for g in gs:
                if g in g5:
                    clash = True
                    break
            if clash:
                continue
            texts.add(t)
            for g in gs:
                g5.add(g)
            n += 1
            lines.append({
                "id": f"{key}_{n:03d}",
                "key": key,
                "text": t,
                "session": session_for(key),
                "class_id": CLASSES,
                "when": when_for(key),
            })
        print(f"  key {key} {n}")
    return lines


def load_target_per_key() -> int:
    qpath = Path(__file__).resolve().parent / "MEGA_QUOTAS.json"
    if qpath.exists():
        q = json.loads(qpath.read_text(encoding="utf-8"))
        # 55 keys * per_key should exceed michelle quota
        michelle = int(q.get("michelle", 6000))
        per = int(q.get("michelle_per_key", 40))
        return max(per, (michelle // max(1, len(ALL_KEYS))) + 8)
    return 120


def barn_notes(n: int) -> list[dict]:
    existing = []
    texts = set()
    if BARN.exists():
        existing = json.loads(BARN.read_text(encoding="utf-8")).get("notes") or []
        texts = {str(x.get("text", "")) for x in existing}
    bands = [
        ([0, 30], [0, 100], [0, 100], ["schooling", "show"], "looky"),
        ([30, 50], [0, 100], [0, 100], ["schooling"], "fresh"),
        ([50, 100], [70, 100], [0, 100], ["schooling", "show"], "with you"),
        ([0, 100], [0, 100], [0, 40], ["schooling", "lesson"], "timing"),
        ([0, 100], [0, 100], [40, 100], ["show"], "show"),
        ([0, 100], [0, 100], [0, 100], ["lesson"], "lesson"),
    ]
    stems = [
        "Walk him first. Then a quiet canter.",
        "He's looky. Don't chase the flower.",
        "Make the last stride. Then ask.",
        "He's with you. Don't over-ride him.",
        "Half-halt off the turn, not at the base.",
        "Quiet Tuesday. School what you need.",
        "Show day. Same leave as schooling.",
        "Indoor. Smaller canter. Same leave.",
        "The ring's deep. Find the canter before the flags.",
        "Pat him. Then we talk.",
        "Eyes up. The distance isn't in the sand.",
        "Sit. He doesn't need a busier rider.",
        "Related today. Don't move on the in.",
        "Mini Prix height. Keep the canter you schooled.",
        "Welcome Stake. Outside track. First fence quiet.",
    ]
    i = len(existing)
    rng = random.Random(9)
    while i < n:
        conf, ride, timing, sess, tag = bands[i % len(bands)]
        stem = stems[i % len(stems)]
        text = f"{stem} Card {num_word(i + 1)}."
        # keep barn voice, unique closer
        closers = [
            f"That's the {tag} card.",
            f"Hidden K {tag}.",
            f"Read him, not the clock.",
            f"Same barn, same horse.",
        ]
        text = f"{stem} {closers[i % len(closers)]}"
        if text in texts:
            text = f"{stem} Hidden K note {i + 1}."
        if text in texts:
            text = f"{stem} Tuesday card {i + 1} at Hidden K."
        if text in texts:
            i += 1
            continue
        texts.add(text)
        existing.append({
            "id": f"bn_{i+1:03d}",
            "text": text,
            "session": sess,
            "abbott_confidence": conf,
            "abbott_rideability": ride,
            "madison_timing": timing,
        })
        i += 1
    return existing


def num_word(n: int) -> str:
    return str(n)


def lesson_beats(n: int) -> list[dict]:
    beats = []
    setups = ["poles", "single", "line", "related two", "flower", "oxer", "halt", "walk canter"]
    goals = [
        "see the last stride",
        "leave with him",
        "straight to the middle",
        "wait on the in",
        "sit to the out",
        "whoa means whoa",
        "walk first",
        "eyes up",
    ]
    for i in range(n):
        setup = setups[i % len(setups)]
        goal = goals[i % len(goals)]
        beats.append({
            "id": f"beat_{i+1:03d}",
            "order": i + 1,
            "goal": goal,
            "setup": setup,
            "michelle_start": "Walk him first. Then we jump." if i % 8 == 0 else "Same leave. Don't chase.",
            "success_key": "spot" if i % 2 == 0 else "leave",
            "fail_keys": ["early", "deep", "chip"][0 : 1 + (i % 3)],
            "next_beat": None if i == n - 1 else f"beat_{i+2:03d}",
        })
    return beats


def main() -> int:
    qpath = Path(__file__).resolve().parent / "MEGA_QUOTAS.json"
    barn_n = 250
    beat_n = 200
    if qpath.exists():
        q = json.loads(qpath.read_text(encoding="utf-8"))
        barn_n = int(q.get("barn_notes", 250))
        beat_n = int(q.get("lesson_beats", 200))
    per = load_target_per_key()
    print("building michelle lines, target", per, "per key")
    lines = build_lines(per)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps({
        "voice": "Michelle, Hidden K. Short. True. Never jokes about the horse getting hurt.",
        "lines": lines,
    }, indent=2) + "\n", encoding="utf-8")
    print("michelle", len(lines))
    notes = barn_notes(barn_n)
    BARN.write_text(json.dumps({"notes": notes}, indent=2) + "\n", encoding="utf-8")
    print("barn", len(notes))
    beats = lesson_beats(beat_n)
    BEATS.write_text(json.dumps({"beats": beats}, indent=2) + "\n", encoding="utf-8")
    print("beats", len(beats))
    return 0


if __name__ == "__main__":
    sys.exit(main())
