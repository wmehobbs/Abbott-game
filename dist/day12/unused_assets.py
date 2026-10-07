"""List every file under game/assets. Delete nothing."""
from __future__ import annotations

import csv
import fnmatch
import os
import re

ROOT = r"E:\Workspace\Madison"
ASSETS = os.path.join(ROOT, "game", "assets")
PRESET = os.path.join(ROOT, "game", "export_presets.cfg")
OUT = os.path.join(ROOT, "dist", "day12", "unused_assets.csv")
TEXT_EXT = {".gd", ".tscn", ".tres", ".gdshader", ".shader", ".json", ".cfg", ".import", ".md"}
SCAN_ROOTS = [
    os.path.join(ROOT, "game"),
    os.path.join(ROOT, "content"),
]
RES = re.compile(r"res://[A-Za-z0-9_./+-]+")
NAME = re.compile(r"(?<![A-Za-z0-9_])([A-Za-z0-9_.+-]+\.[A-Za-z0-9]{1,8})")


def exclude_patterns() -> list[str]:
    if not os.path.isfile(PRESET):
        return []
    text = open(PRESET, encoding="utf-8", errors="replace").read()
    for line in text.splitlines():
        if line.startswith("exclude_filter="):
            raw = line.split("=", 1)[1].strip().strip('"')
            return [p.strip().replace("\\", "/") for p in raw.split(",") if p.strip()]
    return []


def excluded(rel: str, patterns: list[str]) -> bool:
    rel = rel.replace("\\", "/")
    for pat in patterns:
        if fnmatch.fnmatch(rel, pat):
            return True
    return False


def _add(bucket: dict[str, list[str]], key: str, src: str) -> None:
    hits = bucket.get(key)
    if hits is None:
        bucket[key] = [src]
        return
    if len(hits) >= 8 or src in hits:
        return
    hits.append(src)


def index_texts() -> tuple[dict[str, list[str]], dict[str, list[str]]]:
    by_res: dict[str, list[str]] = {}
    by_name: dict[str, list[str]] = {}
    for base in SCAN_ROOTS:
        for dirpath, dirnames, filenames in os.walk(base):
            dirnames[:] = [d for d in dirnames if d not in (".godot", ".git")]
            for name in filenames:
                ext = os.path.splitext(name)[1].lower()
                if ext not in TEXT_EXT and not name.endswith(".import"):
                    continue
                path = os.path.join(dirpath, name)
                rel = os.path.relpath(path, os.path.join(ROOT, "game")).replace("\\", "/")
                if rel.startswith("assets/") and not name.endswith(".import"):
                    continue
                src = os.path.relpath(path, ROOT).replace("\\", "/")
                try:
                    text = open(path, encoding="utf-8", errors="replace").read()
                except OSError:
                    continue
                for match in RES.finditer(text):
                    _add(by_res, match.group(0), src)
                for match in NAME.finditer(text):
                    _add(by_name, match.group(1), src)
    return by_res, by_name


def main() -> None:
    patterns = exclude_patterns()
    by_res, by_name = index_texts()
    rows = []
    unused_bytes = 0
    packed_unused_bytes = 0
    unused_n = 0
    packed_n = 0
    total_n = 0
    total_bytes = 0
    for dirpath, _dirnames, filenames in os.walk(ASSETS):
        for name in filenames:
            if name.endswith(".import") or name.endswith(".uid"):
                continue
            path = os.path.join(dirpath, name)
            rel_game = os.path.relpath(path, os.path.join(ROOT, "game")).replace("\\", "/")
            res = "res://" + rel_game
            size = os.path.getsize(path)
            total_n += 1
            total_bytes += size
            own = {
                os.path.relpath(path, ROOT).replace("\\", "/"),
                os.path.relpath(path, ROOT).replace("\\", "/") + ".import",
            }
            hits: list[str] = []
            for src in by_res.get(res, []) + by_name.get(name, []):
                if src in own or src in hits:
                    continue
                hits.append(src)
                if len(hits) >= 8:
                    break
            used = bool(hits)
            pack = (not used) and (not excluded(rel_game, patterns))
            if not used:
                unused_n += 1
                unused_bytes += size
            if pack:
                packed_n += 1
                packed_unused_bytes += size
            rows.append({
                "path": rel_game,
                "bytes": size,
                "referenced": "yes" if used else "no",
                "references": "; ".join(hits),
                "unused_but_export_packs": "yes" if pack else "no",
            })
    rows.sort(key=lambda r: (r["referenced"], r["path"]))
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=["path", "bytes", "referenced", "references", "unused_but_export_packs"],
        )
        writer.writeheader()
        writer.writerows(rows)
    print(f"files={total_n} bytes={total_bytes}")
    print(f"unused={unused_n} unused_bytes={unused_bytes}")
    print(f"unused_still_packed={packed_n} packed_bytes={packed_unused_bytes}")
    print("WROTE", OUT)


if __name__ == "__main__":
    main()
