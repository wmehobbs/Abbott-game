"""Write the fresh-horse and style tables from cert JSON. Numbers come from the file."""
from __future__ import annotations

import json
import os
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
DIST = os.path.join(ROOT, "dist")


def _load(name: str) -> dict:
    path = os.path.join(DIST, name)
    with open(path, encoding="utf-8") as f:
        return json.load(f)


def fresh_table(name: str = "ridecert_fresh.json") -> str:
    data = _load(name)
    lines = [
        "| id | faults | rails | refusals | jumped | time | teleported | finished |",
        "| --- | ---: | ---: | --- | --- | ---: | --- | --- |",
    ]
    hangs = []
    for row in data.get("tracks", []):
        refused = row.get("refused") or []
        jumped = "%s/%s" % (row.get("fences_jumped"), row.get("fences_needed"))
        finished = bool(row.get("round_complete")) and not bool(row.get("teleported"))
        if not finished:
            hangs.append(str(row.get("id")))
        lines.append(
            "| %s | %s | %s | %s | %s | %s | %s | %s |"
            % (
                row.get("id"),
                row.get("faults"),
                row.get("rails"),
                ",".join(str(n) for n in refused) if refused else "—",
                jumped,
                row.get("time_sec"),
                row.get("teleported"),
                "yes" if finished else "NO",
            )
        )
    lines.append("")
    lines.append("finished %s/%s hangs %s" % (
        sum(1 for row in data.get("tracks", []) if bool(row.get("round_complete")) and not bool(row.get("teleported"))),
        len(data.get("tracks", [])),
        ",".join(hangs) if hangs else "none",
    ))
    text = "\n".join(lines) + "\n"
    out = os.path.join(DIST, "fresh_horse_table.md")
    with open(out, "w", encoding="utf-8", newline="\n") as f:
        f.write(text)
    print(text, end="")
    print("WROTE", out)
    return text


def _log_events(log_name: str) -> dict:
    """Fence numbers from the log. The horse signal misses a body knock."""
    path = os.path.join(DIST, log_name)
    events: dict[tuple[str, str], dict] = {}
    cur: tuple[str, str] | None = None
    if not os.path.exists(path):
        return events
    with open(path, encoding="utf-8", errors="replace") as f:
        for line in f:
            if "RIDECERT round " in line and " style=" in line:
                cid = line.split("RIDECERT round ", 1)[1].split(" ", 1)[0].strip()
                style = line.split(" style=", 1)[1].split()[0].strip()
                cur = (cid, style)
                events[cur] = {"refused": [], "knocks": []}
                continue
            if cur is None:
                continue
            if "RIDECERT refuse fence=" in line:
                num = line.split("fence=", 1)[1].split()[0].strip()
                events[cur]["refused"].append(int(num))
            elif "FENCE knock " in line:
                tail = line.split("FENCE knock ", 1)[1]
                num = int(tail.split()[0])
                air = "jumping=true" in line
                events[cur]["knocks"].append((num, air))
            elif "RIDECERT rail now=" in line and "next=" in line:
                num = int(line.split("next=", 1)[1].split()[0])
                air = "jumping=true" in line
                knocks = events[cur]["knocks"]
                if not any(n == num for n, _a in knocks):
                    knocks.append((num, air))
    return events


def style_table(name: str = "ridecert_style.json", log_name: str = "ridecert_style.log") -> str:
    data = _load(name)
    logged = _log_events(log_name)
    rows = data.get("style", [])
    by_id: dict[str, dict[str, dict]] = {}
    order: list[str] = []
    for row in rows:
        cid = str(row.get("id"))
        if cid not in by_id:
            by_id[cid] = {}
            order.append(cid)
        by_id[cid][str(row.get("style"))] = row
    lines = [
        "| id | B faults | B refused | B knocked | C faults | C rails | C fence | C air | C finished | keep |",
        "| --- | ---: | --- | --- | ---: | ---: | --- | --- | --- | --- |",
    ]
    for cid in order:
        b = by_id[cid].get("refuse_early", {})
        c = by_id[cid].get("rail_late", {})
        b_fence = int(b.get("style_fence", 1) or 1)
        c_fence = int(c.get("style_fence", 3) or 3)
        b_log = logged.get((cid, "refuse_early"), {})
        c_log = logged.get((cid, "rail_late"), {})
        b_ref = [int(n) for n in (b.get("refused") or b_log.get("refused") or [])]
        b_rails = [int(n) for n in (b.get("rail_fences") or [])]
        if not b_rails:
            b_rails = [n for n, _air in b_log.get("knocks", [])]
        c_rails = [int(n) for n in (c.get("rail_fences") or [])]
        c_air_flags = list(c.get("rail_in_air") or [])
        if not c_rails:
            c_rails = [n for n, _air in c_log.get("knocks", [])]
            c_air_flags = [air for _n, air in c_log.get("knocks", [])]
        air_at = False
        for i, n in enumerate(c_rails):
            if n == c_fence and i < len(c_air_flags) and bool(c_air_flags[i]):
                air_at = True
        b_done = bool(b.get("round_complete")) and not bool(b.get("teleported"))
        c_done = bool(c.get("round_complete")) and not bool(c.get("teleported"))
        b_ok = b_done and b_fence in b_ref and b_fence not in b_rails
        c_ok = c_done and c_fence in c_rails and air_at
        keep = "yes" if b_ok and c_ok else "no"
        lines.append(
            "| %s | %s | %s | %s | %s | %s | %s | %s | %s | %s |"
            % (
                cid,
                b.get("faults", ""),
                ",".join(str(n) for n in b_ref) if b_ref else "—",
                ",".join(str(n) for n in b_rails) if b_rails else "—",
                c.get("faults", ""),
                c.get("rails", ""),
                ",".join(str(n) for n in c_rails) if c_rails else "—",
                "yes" if air_at else "no",
                "yes" if c_done else "NO",
                keep,
            )
        )
    text = "\n".join(lines) + "\n"
    out = os.path.join(DIST, "style_table.md")
    with open(out, "w", encoding="utf-8", newline="\n") as f:
        f.write(text)
    print(text, end="")
    print("WROTE", out)
    return text


if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "fresh"
    if which == "fresh":
        fresh_table(sys.argv[2] if len(sys.argv) > 2 else "ridecert_fresh.json")
    elif which == "style":
        style_table(sys.argv[2] if len(sys.argv) > 2 else "ridecert_style.json")
    else:
        raise SystemExit("use fresh or style")
