"""Download CC0 PBR plates for Hidden K. Poly Haven + ambientCG only.

Writes tools/content_factory/raw_harvest/<slug>/ and HARVEST_REPORT.md.
Does not convert; convert_harvest.py does that.
"""
from __future__ import annotations

import json
import sys
import time
import traceback
import urllib.error
import urllib.request
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import date
from io import BytesIO
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
RAW = Path(__file__).resolve().parent / "raw_harvest"
REPORT = Path(__file__).resolve().parent / "HARVEST_REPORT.md"
MANIFEST = Path(__file__).resolve().parent / "HARVEST_MANIFEST.json"
UA = "HiddenK-ContentFactory/1.0 (Abbott; boutique jumping school; legal CC0 harvest)"
TODAY = date.today().isoformat()

# Curated for late-summer Piedmont hunter barn. Skip snow, lava, marble palaces.
POLYHAVEN_IDS: list[tuple[str, str, list[str]]] = [
    # slug, polyhaven id, tags
    ("playground_sand", "playground_sand", ["ring", "sand"]),
    ("sand_01", "sand_01", ["ring", "sand"]),
    ("sand_02", "sand_02", ["ring", "sand"]),
    ("gravelly_sand", "gravelly_sand", ["ring", "sand", "apron"]),
    ("raked_dirt", "raked_dirt", ["ring", "sand", "rake"]),
    ("park_sand", "park_sand", ["ring", "sand"]),
    ("dirt", "dirt", ["ring", "apron"]),
    ("park_dirt", "park_dirt", ["ring", "apron"]),
    ("baseball_playground", "baseball_playground", ["ring", "sand"]),
    ("damp_sand", "damp_sand", ["ring", "sand", "wet"]),
    ("gravel", "gravel", ["drive", "gravel"]),
    ("gravel_floor", "gravel_floor", ["drive", "gravel"]),
    ("sandy_gravel", "sandy_gravel", ["drive", "gravel", "apron"]),
    ("bicolour_gravel", "bicolour_gravel", ["drive", "gravel"]),
    ("gravel_road", "gravel_road", ["drive", "gravel"]),
    ("aerial_grass_rock", "aerial_grass_rock", ["sod", "grass"]),
    ("grass_path_2", "grass_path_2", ["sod", "grass"]),
    ("grass_path_3", "grass_path_3", ["sod", "grass"]),
    ("leafy_grass", "leafy_grass", ["sod", "grass"]),
    ("sparse_grass", "sparse_grass", ["sod", "grass", "dry"]),
    ("withered_grass", "withered_grass", ["sod", "grass", "rust"]),
    ("farm_soil", "farm_soil", ["sod", "soil"]),
    ("dry_ground_01", "dry_ground_01", ["sod", "dry"]),
    ("pine_bark", "pine_bark", ["trees", "bark", "pine"]),
    ("knotted_pine_bark", "knotted_pine_bark", ["trees", "bark", "pine"]),
    ("jolcham_oak_bark", "jolcham_oak_bark_01", ["trees", "bark", "oak"]),
    ("bark_brown_01", "bark_brown_01", ["trees", "bark"]),
    ("forest_leaves_03", "forest_leaves_03", ["trees", "leaf", "duff"]),
    ("forest_leaves_04", "forest_leaves_04", ["trees", "leaf", "pine"]),
    ("forest_floor", "forest_floor", ["trees", "duff"]),
    ("forest_ground_05", "forest_ground_05", ["trees", "duff"]),
    ("leaves_forest_ground", "leaves_forest_ground", ["trees", "leaf"]),
    ("brown_mud_leaves", "brown_mud_leaves_01", ["trees", "duff"]),
    ("white_planks_clean", "white_planks_clean", ["wood", "boards", "white"]),
    ("weathered_planks", "weathered_planks", ["wood", "boards"]),
    ("dark_planks", "dark_planks", ["wood", "kick"]),
    ("oak_wood_planks", "oak_wood_planks", ["wood", "oak", "fourboard"]),
    ("worn_planks", "worn_planks", ["wood", "boards"]),
    ("wooden_gate", "wooden_gate", ["wood", "gate"]),
    ("wood_planks", "wood_planks", ["wood", "boards"]),
    ("distressed_painted_planks", "distressed_painted_planks", ["wood", "painted"]),
    ("raw_plank_wall", "raw_plank_wall", ["wood", "stall"]),
    ("brown_planks_03", "brown_planks_03", ["wood", "trunk"]),
    ("dark_wood", "dark_wood", ["wood", "kick"]),
    ("brown_leather", "brown_leather", ["tack", "leather"]),
    ("fabric_leather_01", "fabric_leather_01", ["tack", "leather"]),
    ("leather_red_02", "leather_red_02", ["tack", "leather"]),
    ("poly_wool_herringbone", "poly_wool_herringbone", ["tack", "wool", "coat"]),
    ("wool_boucle", "wool_boucle", ["tack", "wool"]),
    ("metal_plate", "metal_plate", ["metal", "stirrup"]),
    ("rusty_metal", "rusty_metal", ["metal", "hydrant"]),
    ("rusty_metal_03", "rusty_metal_03", ["metal", "cup"]),
    ("wood_chips", "wood_chips", ["misc", "hay"]),
    ("brown_mud", "brown_mud", ["ring", "apron"]),
    ("brown_mud_dry", "brown_mud_dry", ["ring", "apron"]),
    ("muddy_tracks", "muddy_tracks", ["ring", "hoof"]),
    ("coated_pine", "coated_pine", ["wood", "pine"]),
    ("chinese_cedar_bark", "chinese_cedar_bark", ["trees", "bark"]),
    ("metal_plate_02", "metal_plate_02", ["metal", "stirrup"]),
    ("rusty_metal_04", "rusty_metal_04", ["metal", "hydrant"]),
    ("leather_white", "leather_white", ["tack", "leather"]),
    ("fabric_leather_02", "fabric_leather_02", ["tack", "leather"]),
    ("brown_planks_04", "brown_planks_04", ["wood", "boards"]),
    ("rock_path", "rock_path", ["drive", "gravel"]),
    ("stony_dirt_path", "stony_dirt_path", ["apron", "dirt"]),
    ("flower_scattered_dirt", "flower_scattered_dirt", ["sod", "soil"]),
    ("pebbles", "pebbles", ["drive", "gravel"]),
    ("wood_floor_deck", "wood_floor_deck", ["wood"]),
    ("bark_willow", "bark_willow", ["trees", "bark"]),
    ("bark_willow_02", "bark_willow_02", ["trees", "bark"]),
    ("bark_bluegum", "bark_bluegum", ["trees", "bark"]),
    ("bark_platanus", "bark_platanus", ["trees", "bark"]),
    ("brown_mud_03", "brown_mud_03", ["ring", "apron"]),
    ("forest_leaves_02", "forest_leaves_02", ["trees", "leaf"]),
    ("forest_ground_01", "forest_ground_01", ["trees", "duff"]),
    ("forest_ground_04", "forest_ground_04", ["trees", "duff"]),
    ("hay_01", "hay", ["misc", "hay"]),
    ("wood_table", "wood_table", ["wood"]),
    ("worn_planks_02", "wooden_planks", ["wood", "boards"]),
    ("raw_planks", "raw_plank_wall", ["wood", "stall"]),
    ("denim_fabric_skip", "poly_wool_herringbone", ["tack", "wool"]),
    ("metal_plate_03", "rusty_metal_02", ["metal"]),
    ("rock_path_02", "rocky_trail", ["drive"]),
    ("dirt_floor", "dirt_floor", ["ring", "dirt"]),
    ("ground_grey", "ground_grey", ["ring", "dirt"]),
    ("packed_pebbles", "packed_pebbles", ["drive", "gravel"]),
    ("forest_floor_02", "forrest_ground_01", ["trees", "duff"]),
    ("grass_path", "grass_path", ["sod", "grass"]),
    ("leafy_grass_02", "grass_wild", ["sod", "grass"]),
    ("brown_leather_02", "leather_white_02", ["tack", "leather"]),
    ("fabric_pattern", "fabric_pattern_07", ["tack", "pad"]),
    ("wood_planks_grey", "grey_planks", ["wood"]),
    ("red_brick_skip", "brick_wall_01", ["misc"]),
]

AMBIENTCG_IDS: list[tuple[str, str, list[str]]] = [
    ("acg_grass001", "Grass001", ["sod", "grass"]),
    ("acg_grass002", "Grass002", ["sod", "grass"]),
    ("acg_ground032", "Ground032", ["ring", "sand"]),
    ("acg_ground037", "Ground037", ["ring", "dirt"]),
    ("acg_bark012", "Bark012", ["trees", "bark"]),
    ("acg_bark006", "Bark006", ["trees", "bark"]),
    ("acg_wood048", "Wood048", ["wood"]),
    ("acg_leather011", "Leather011", ["tack", "leather"]),
    ("acg_fabric004", "Fabric004", ["tack", "wool"]),
    ("acg_metal032", "Metal032", ["metal"]),
    ("acg_gravel020", "Gravel020", ["drive", "gravel"]),
    ("acg_soil001", "Ground048", ["misc", "flower", "soil"]),
    ("acg_planks012", "Planks012", ["wood", "boards"]),
    ("acg_pine_needles001", "PineNeedles001", ["trees", "pine", "duff"]),
    ("acg_straw001", "Straw001", ["misc", "straw"]),
    ("acg_fabric018", "Fabric018", ["tack", "pad"]),
    ("acg_leather021", "Leather021", ["tack", "leather"]),
    ("acg_ground003", "Ground003", ["ring", "dirt"]),
    ("acg_grass004", "Grass004", ["sod", "grass"]),
    ("acg_bark001", "Bark001", ["trees", "bark"]),
    ("acg_metal009", "Metal009", ["metal", "bit"]),
    ("acg_wood090", "Wood090", ["wood"]),
    ("acg_fabric046", "Fabric046", ["tack", "pad"]),
    ("acg_gravel015", "Gravel015", ["drive", "gravel"]),
    ("acg_ground033", "Ground033", ["ring", "dirt"]),
    ("acg_planks017", "Planks017", ["wood", "boards"]),
    ("acg_grass005", "Grass005", ["sod", "grass"]),
    ("acg_grass006", "Grass006", ["sod", "grass"]),
    ("acg_grass007", "Grass007", ["sod", "grass"]),
    ("acg_bark002", "Bark002", ["trees", "bark"]),
    ("acg_bark007", "Bark007", ["trees", "bark"]),
    ("acg_leather038", "Leather038", ["tack", "leather"]),
    ("acg_leather039", "Leather039", ["tack", "leather"]),
    ("acg_fabric001", "Fabric001", ["tack", "wool"]),
    ("acg_wood001", "Wood001", ["wood"]),
    ("acg_wood051", "Wood051", ["wood"]),
    ("acg_ground004", "Ground004", ["ring", "dirt"]),
    ("acg_ground023", "Ground023", ["drive", "gravel"]),
    ("acg_gravel023", "Gravel023", ["drive", "gravel"]),
    ("acg_metal001", "Metal001", ["metal"]),
    ("acg_planks013", "Planks013", ["wood", "boards"]),
    ("acg_soil003", "Ground049", ["misc", "soil"]),
    ("acg_leaves001", "Leaves001", ["trees", "leaf"]),
    ("acg_woodchips001", "WoodChips001", ["misc", "hay"]),
    ("acg_moss001", "Moss001", ["sod", "moss"]),
]

REJECTED_POLICY = [
    (
        "USEF course maps as images",
        "copyright; we build our own JSON tracks instead",
    ),
    (
        "Paid Unity/Unreal marketplace packs",
        "not CC0/CC-BY; would need a paid license in writing",
    ),
    (
        "Random itch.io assets without a written CC0/CC-BY",
        "license unclear",
    ),
    (
        "Textures marked personal-use-only or no-commercial",
        "cannot ship in a commercial-capable game",
    ),
    (
        "AI-training-only dumps",
        "not a ship license",
    ),
    (
        "Copyrighted barn/show photos scraped from the web",
        "Hidden K photos in photos_jpg/ are reference, not harvest plates",
    ),
    (
        "Snow, lava, marble, sci-fi metal, dungeon stone",
        "wrong climate / wrong barn",
    ),
    (
        "Entire ambientCG or Poly Haven packs",
        "take only the plates we need",
    ),
]


def http_get(url: str, timeout: int = 90) -> bytes:
    req = urllib.request.Request(url, headers={"User-Agent": UA})
    last = None
    for attempt in range(4):
        try:
            with urllib.request.urlopen(req, timeout=timeout) as r:
                return r.read()
        except (urllib.error.URLError, TimeoutError, ConnectionError) as e:
            last = e
            time.sleep(1.2 * (attempt + 1))
    raise last  # type: ignore[misc]


def http_json(url: str) -> dict:
    return json.loads(http_get(url, timeout=45).decode("utf-8"))


def pick_key(files: dict, names: tuple[str, ...]) -> str | None:
    lower = {k.lower(): k for k in files}
    for n in names:
        if n.lower() in lower:
            return lower[n.lower()]
    return None


def jpg_url(map_dict: dict) -> tuple[str, str] | None:
    for res in ("1k", "2k", "4k"):
        if res in map_dict and isinstance(map_dict[res], dict) and "jpg" in map_dict[res]:
            u = map_dict[res]["jpg"].get("url")
            if u:
                return u, res
    return None


def save_bytes(path: Path, data: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(data)


def harvest_polyhaven(slug: str, ph_id: str, tags: list[str]) -> dict:
    dest = RAW / slug
    dest.mkdir(parents=True, exist_ok=True)
    info = http_json(f"https://api.polyhaven.com/info/{ph_id}")
    files = http_json(f"https://api.polyhaven.com/files/{ph_id}")
    authors = info.get("authors") or {}
    author = ", ".join(authors.keys()) if authors else "Poly Haven contributors"
    page = f"https://polyhaven.com/a/{ph_id}"
    maps: dict[str, str] = {}
    wanted = {
        "albedo": ("Diffuse", "diff", "Color", "col", "albedo", "coll1", "coll2"),
        "normal": ("nor_gl", "Nor_gl", "Normal", "normal_gl"),
        "rough": ("Rough", "roughness", "rough"),
    }
    for kind, names in wanted.items():
        key = pick_key(files, names)
        if not key:
            continue
        got = jpg_url(files[key])
        if not got:
            continue
        url, res = got
        data = http_get(url)
        fname = f"{slug}_{kind}_{res}.jpg"
        save_bytes(dest / fname, data)
        maps[kind] = fname
        maps[f"{kind}_url"] = url
    if "albedo" not in maps:
        raise RuntimeError(f"no albedo for {ph_id} keys={list(files.keys())[:12]}")
    meta = {
        "slug": slug,
        "source": "polyhaven",
        "source_id": ph_id,
        "page": page,
        "author": author,
        "license": "CC0 1.0",
        "license_url": "https://polyhaven.com/license",
        "tags": tags,
        "maps": maps,
        "date_fetched": TODAY,
        "use_for": ", ".join(tags),
    }
    (dest / "source.json").write_text(json.dumps(meta, indent=2), encoding="utf-8")
    return meta


def harvest_ambientcg(slug: str, acg_id: str, tags: list[str]) -> dict:
    dest = RAW / slug
    dest.mkdir(parents=True, exist_ok=True)
    url = f"https://ambientcg.com/get?file={acg_id}_1K-JPG.zip"
    page = f"https://ambientcg.com/a/{acg_id}"
    data = http_get(url, timeout=120)
    if len(data) < 2000:
        raise RuntimeError(f"ambientCG {acg_id} tiny response ({len(data)} bytes)")
    if data[:2] != b"PK":
        raise RuntimeError(f"ambientCG {acg_id} not a zip (maybe 404 HTML)")
    zf = zipfile.ZipFile(BytesIO(data))
    maps: dict[str, str] = {}
    for name in zf.namelist():
        low = name.lower().replace("\\", "/")
        if low.endswith("/"):
            continue
        blob = zf.read(name)
        base = Path(name).name
        kind = None
        if "color" in low or "albedo" in low or "diff" in low:
            kind = "albedo"
        elif "normalgl" in low or "nor_gl" in low or ("normal" in low and "dx" not in low):
            kind = "normal"
        elif "rough" in low:
            kind = "rough"
        if kind is None:
            # keep a copy of extras but don't count
            save_bytes(dest / "zip_extra" / base, blob)
            continue
        ext = Path(base).suffix.lower() or ".jpg"
        fname = f"{slug}_{kind}{ext}"
        save_bytes(dest / fname, blob)
        maps[kind] = fname
        maps[f"{kind}_url"] = url
    if "albedo" not in maps:
        raise RuntimeError(f"no Color map in {acg_id} zip: {zf.namelist()[:20]}")
    meta = {
        "slug": slug,
        "source": "ambientcg",
        "source_id": acg_id,
        "page": page,
        "author": "Lennart Demes / ambientCG",
        "license": "CC0 1.0",
        "license_url": "https://docs.ambientcg.com/legal/license",
        "tags": tags,
        "maps": maps,
        "date_fetched": TODAY,
        "use_for": ", ".join(tags),
        "download": url,
    }
    (dest / "source.json").write_text(json.dumps(meta, indent=2), encoding="utf-8")
    return meta


def already_done(slug: str) -> dict | None:
    p = RAW / slug / "source.json"
    if not p.exists():
        return None
    try:
        meta = json.loads(p.read_text(encoding="utf-8"))
    except json.JSONDecodeError:
        return None
    albedo = meta.get("maps", {}).get("albedo")
    if albedo and (RAW / slug / albedo).exists():
        return meta
    return None


def write_report(ok: list[dict], failed: list[tuple[str, str]], skipped: list[str]) -> None:
    lines = [
        "# Hidden K texture harvest report",
        "",
        f"Date: {TODAY}",
        "",
        "Sources allowed: Poly Haven (CC0 1.0), ambientCG (CC0 1.0).",
        "No personal-use, no-commercial, AI-training-only, or unclear licenses.",
        "",
        "## Taken",
        "",
        f"{len(ok)} plates with an albedo map.",
        "",
        "| slug | source | id | author | license | tags | albedo | normal | rough |",
        "| --- | --- | --- | --- | --- | --- | --- | --- | --- |",
    ]
    for m in sorted(ok, key=lambda x: x["slug"]):
        maps = m.get("maps", {})
        lines.append(
            "| {slug} | {src} | {sid} | {auth} | {lic} | {tags} | {a} | {n} | {r} |".format(
                slug=m["slug"],
                src=m["source"],
                sid=m["source_id"],
                auth=m["author"].replace("|", "/"),
                lic=m["license"],
                tags=",".join(m.get("tags") or []),
                a="yes" if maps.get("albedo") else "no",
                n="yes" if maps.get("normal") else "no",
                r="yes" if maps.get("rough") else "no",
            )
        )
    lines += [
        "",
        "## Failed / missing (not shipped)",
        "",
    ]
    if not failed:
        lines.append("None.")
    else:
        for slug, why in failed:
            lines.append(f"- `{slug}`: {why}")
    lines += [
        "",
        "## Already on disk (reused, not re-downloaded)",
        "",
    ]
    if not skipped:
        lines.append("None.")
    else:
        for s in skipped:
            lines.append(f"- `{s}`")
    lines += [
        "",
        "## Rejected without downloading",
        "",
        "These were considered and refused on license or taste grounds:",
        "",
    ]
    for name, why in REJECTED_POLICY:
        lines.append(f"- **{name}** — {why}")
    lines += [
        "",
        "## Convert",
        "",
        "Run `python tools/content_factory/convert_harvest.py` to emit Godot-ready",
        "`game/assets/textures/harvest/*_{albedo,normal,rough}.jpg` and the attribution table.",
        "",
    ]
    REPORT.write_text("\n".join(lines), encoding="utf-8")


def main() -> int:
    RAW.mkdir(parents=True, exist_ok=True)
    jobs: list[tuple[str, str, str, list[str]]] = []
    for slug, ph_id, tags in POLYHAVEN_IDS:
        jobs.append(("polyhaven", slug, ph_id, tags))
    for slug, acg_id, tags in AMBIENTCG_IDS:
        jobs.append(("ambientcg", slug, acg_id, tags))

    ok: list[dict] = []
    failed: list[tuple[str, str]] = []
    skipped: list[str] = []

    todo: list[tuple[str, str, str, list[str]]] = []
    for src, slug, sid, tags in jobs:
        meta = already_done(slug)
        if meta:
            skipped.append(slug)
            ok.append(meta)
        else:
            todo.append((src, slug, sid, tags))

    print(f"harvest: {len(ok)} cached, {len(todo)} to fetch")

    def run(job: tuple[str, str, str, list[str]]) -> tuple[str, dict | None, str | None]:
        src, slug, sid, tags = job
        try:
            if src == "polyhaven":
                meta = harvest_polyhaven(slug, sid, tags)
            else:
                meta = harvest_ambientcg(slug, sid, tags)
            return slug, meta, None
        except Exception as e:
            return slug, None, f"{type(e).__name__}: {e}"

    if todo:
        with ThreadPoolExecutor(max_workers=6) as pool:
            futs = [pool.submit(run, j) for j in todo]
            for fut in as_completed(futs):
                slug, meta, err = fut.result()
                if meta:
                    print(f"  OK  {slug}")
                    ok.append(meta)
                else:
                    print(f"  FAIL {slug}: {err}")
                    failed.append((slug, err or "unknown"))

    MANIFEST.write_text(json.dumps({"ok": ok, "failed": failed}, indent=2), encoding="utf-8")
    write_report(ok, failed, skipped)
    n = len(ok)
    print(f"harvest done: {n} plates, {len(failed)} failed. report {REPORT}")
    # Harvest itself is allowed to be short of 40 if convert will still pass;
    # we still want a strong attempt.
    return 0 if n >= 40 else 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except Exception:
        traceback.print_exc()
        sys.exit(1)
