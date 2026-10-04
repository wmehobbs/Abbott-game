"""Count ship Michelle lines and mark ones that do not name the event."""
from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(r"E:\Workspace\Madison")
SRC = ROOT / "game" / "content" / "rail" / "michelle_ship.json"
OUT = ROOT / "dist" / "michelle_audit.md"
KEYS = ("early", "deep", "chip", "spot", "leave", "straight", "looked", "wrong", "halt")
# A line names the thing only if one of these stems is in the sentence.
NAMES = {
    "early": ("early", "soon"),
    "deep": ("deep",),
    "chip": ("chip",),
    "spot": ("spot",),
    "leave": ("leave",),
    "straight": ("straight",),
    "looked": ("look",),
    "wrong": ("wrong",),
    "halt": ("halt", "whoa"),
}


def words(text: str) -> int:
    return len([w for w in text.replace("—", " ").split() if w])


def main() -> None:
    raw = SRC.read_text(encoding="utf-8")
    nlines = raw.count("\n") + (0 if raw.endswith("\n") else 1)
    data = json.loads(raw)
    lines = data["lines"]
    by: dict[str, list[dict]] = {k: [] for k in KEYS}
    other: dict[str, int] = {}
    for row in lines:
        k = str(row.get("key", ""))
        if k in by:
            by[k].append(row)
        else:
            other[k] = other.get(k, 0) + 1
    out: list[str] = []
    out.append("# Michelle ship — keys that name the thing")
    out.append("")
    out.append(f"File `{SRC.relative_to(ROOT)}` is {nlines} lines, {len(lines)} speech rows. Prompt said 336 lines; this is the file on disk.")
    out.append("")
    out.append("| key | lines | weak |")
    out.append("| --- | ---: | ---: |")
    weak_all: list[str] = []
    hold_release: list[str] = []
    for k in KEYS:
        rows = by[k]
        weak = []
        for row in rows:
            text = str(row.get("text", ""))
            low = text.lower()
            if not any(stem in low for stem in NAMES[k]):
                weak.append(row)
            if k == "chip" and ("hold" in low and ("release" in low or "let go" in low or "then ask" in low)):
                hold_release.append(f"{row.get('id')}: {text}")
        out.append(f"| {k} | {len(rows)} | {len(weak)} |")
        for row in weak:
            weak_all.append(f"- `{row.get('id')}` ({k}, {words(str(row.get('text','')))} words): {row.get('text')}")
    out.append("")
    out.append("## Weak ids")
    out.append("")
    out.append("Weak means the sentence does not contain the stem for that key.")
    out.append("")
    if weak_all:
        out.extend(weak_all)
    else:
        out.append("None.")
    out.append("")
    out.append("## Chip lines that say hold then release")
    out.append("")
    if hold_release:
        out.extend(f"- {r}" for r in hold_release)
    else:
        out.append("None.")
    out.append("")
    out.append("## Other keys in the file (not audited)")
    out.append("")
    for k, n in sorted(other.items()):
        out.append(f"- {k}: {n}")
    OUT.write_text("\n".join(out) + "\n", encoding="utf-8", newline="\n")
    print(f"file_lines {nlines} rows {len(lines)} weak {len(weak_all)} wrote {OUT}")


if __name__ == "__main__":
    main()
