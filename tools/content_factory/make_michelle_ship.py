"""400 live Michelle lines. Leaves content/rail/michelle.json alone."""
from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SRC = ROOT / "content" / "rail" / "michelle.json"
OUT = ROOT / "game" / "content" / "rail" / "michelle_ship.json"

LIVE_KEYS = (
    "early", "spot", "deep", "chip", "looked", "wrong", "rail", "refuse",
    "off_course", "three", "time", "lesson_start", "jump_off", "clear",
    "ribbon", "steady", "walk_out", "halt", "pat", "straight", "leave",
)
PER = 16
MAX_WORDS = 14


def grams5(text: str) -> list[str]:
    w = text.replace("—", " ").split()
    if len(w) < 5:
        return []
    return [" ".join(w[i : i + 5]).lower() for i in range(len(w) - 4)]


def junk(text: str) -> bool:
    t = text.strip()
    if not t:
        return True
    wc = len(t.replace("—", " ").split())
    if wc < 2 or wc > MAX_WORDS:
        return True
    if any(ch.isdigit() for ch in t):
        return True
    low = t.lower()
    if "think the" in low or "from the in-gate" in low:
        return True
    if "walk one" in low or "walk two" in low or "card " in low:
        return True
    if "don't early" in low or "don't spot" in low:
        return True
    return False


def main() -> int:
    data = json.loads(SRC.read_text(encoding="utf-8"))
    all_lines = data.get("lines") or []
    g5: set[str] = set()
    texts: set[str] = set()
    by_key: dict[str, list] = {k: [] for k in LIVE_KEYS}
    for row in all_lines:
        key = str(row.get("key", ""))
        if key not in by_key:
            continue
        if len(by_key[key]) >= PER:
            continue
        t = str(row.get("text", "")).strip()
        if junk(t) or t in texts:
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
        by_key[key].append({
            "id": f"{key}_{len(by_key[key])+1:02d}",
            "key": key,
            "text": t,
            "session": row.get("session") or ["lesson", "schooling", "show"],
            "class_id": row.get("class_id") or ["lesson", "beginner", "intermediate", "advanced"],
            "when": row.get("when") or "after_leave",
        })
    missing = [k for k, v in by_key.items() if len(v) < 12]
    if missing:
        print("short keys", {k: len(by_key[k]) for k in missing})
    lines = []
    for k in LIVE_KEYS:
        lines.extend(by_key[k])
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps({
        "voice": "Michelle, Hidden K. Short. True. The live board, not the 48k pile.",
        "lines": lines,
    }, indent=2) + "\n", encoding="utf-8")
    print("michelle_ship", len(lines), "per", {k: len(by_key[k]) for k in LIVE_KEYS})
    return 0 if len(lines) <= 400 and not missing else 1


if __name__ == "__main__":
    raise SystemExit(main())
