"""Download legal mesh candidates into content/meshes/raw/<slug>/."""
from __future__ import annotations

import json
import ssl
import time
import urllib.request
from datetime import date
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
RAW = ROOT / "content" / "meshes" / "raw"
UA = "HiddenK-ContentFactory/1.0 (Abbott; legal CC0/CC-BY mesh hunt)"
TODAY = date.today().isoformat()
CTX = ssl.create_default_context()


def get(url: str, timeout: int = 120) -> bytes:
    req = urllib.request.Request(url, headers={"User-Agent": UA})
    last = None
    for i in range(4):
        try:
            with urllib.request.urlopen(req, timeout=timeout, context=CTX) as r:
                return r.read()
        except Exception as e:
            last = e
            time.sleep(1.0 * (i + 1))
    raise last  # type: ignore[misc]


def save(slug: str, filename: str, url: str, meta: dict) -> Path:
    dest = RAW / slug
    dest.mkdir(parents=True, exist_ok=True)
    data = get(url)
    path = dest / filename
    path.write_bytes(data)
    rec = {
        "slug": slug,
        "file": filename,
        "bytes": len(data),
        "url": url,
        "date_fetched": TODAY,
        **meta,
    }
    (dest / "source.json").write_text(json.dumps(rec, indent=2), encoding="utf-8")
    print(f"OK {slug} {len(data)} bytes {filename}")
    return path


def head_ok(url: str) -> bool:
    try:
        req = urllib.request.Request(url, headers={"User-Agent": UA}, method="HEAD")
        with urllib.request.urlopen(req, timeout=20, context=CTX) as r:
            return 200 <= r.status < 400
    except Exception:
        try:
            req = urllib.request.Request(url, headers={"User-Agent": UA})
            with urllib.request.urlopen(req, timeout=20, context=CTX) as r:
                return 200 <= r.status < 400
        except Exception as e:
            print("HEAD fail", url, e)
            return False


def main() -> None:
    RAW.mkdir(parents=True, exist_ok=True)

    # Keepers we will actually store.
    downloads = [
        {
            "slug": "quaternius_casual_female",
            "filename": "Casual_Female.glb",
            "url": "https://cdn.cinevva.com/assets/packs/quaternius/ultimate-animated-characters/Casual_Female.glb",
            "meta": {
                "author": "Quaternius",
                "license": "CC0 1.0",
                "page": "https://quaternius.com/packs/ultimateanimatedcharacters.html",
                "role": "rider",
                "via": "Cinevva CDN mirror of the official CC0 pack",
            },
        },
        {
            "slug": "quaternius_modular_casual",
            "filename": "Casual.glb",
            "url": "https://cdn.cinevva.com/assets/packs/quaternius/ultimate-modular-women/Casual.glb",
            "meta": {
                "author": "Quaternius",
                "license": "CC0 1.0",
                "page": "https://quaternius.com/packs/ultimatemodularwomen.html",
                "role": "rider",
                "via": "Cinevva CDN mirror of the official CC0 pack",
            },
        },
        {
            "slug": "kenney_female_a",
            "filename": "character-female-a.glb",
            "url": "https://cdn.cinevva.com/assets/packs/kenney/mini-characters/character-female-a.glb",
            "meta": {
                "author": "Kenney",
                "license": "CC0 1.0",
                "page": "https://kenney.nl/assets/mini-characters",
                "role": "rider",
                "via": "Cinevva CDN mirror of the official CC0 pack",
            },
        },
        {
            "slug": "oga_saddle_bedroll",
            "filename": "saddle_with_bedroll.zip",
            "url": "https://opengameart.org/sites/default/files/saddle%20with%20bedroll.zip",
            "meta": {
                "author": "Wolfgang Wozniak / Ouren",
                "license": "CC-BY 3.0",
                "page": "https://opengameart.org/content/saddle-with-bedroll",
                "role": "saddle",
                "note": "Inspected as Western bedroll saddle — not a keeper for Hidden K.",
            },
        },
        {
            "slug": "vroid_base_female",
            "filename": "base_female.zip",
            "url": "https://opengameart.org/sites/default/files/base_female.zip",
            "meta": {
                "author": "VRoid Project (submitted by hecko)",
                "license": "CC0 1.0",
                "page": "https://opengameart.org/content/vroid-studio-cc0-models",
                "role": "rider",
                "note": "Anime VRM sample. Legal, wrong look for hunt-seat.",
            },
        },
    ]

    # Probe extra saddle-ish URLs; download if they exist.
    extra_probes = [
        (
            "kenney_farm_saddle",
            "saddle.glb",
            "https://cdn.cinevva.com/assets/packs/kenney/farming-kit/saddle.glb",
            {"author": "Kenney", "license": "CC0 1.0", "role": "saddle"},
        ),
        (
            "quaternius_saddle",
            "Saddle.glb",
            "https://cdn.cinevva.com/assets/packs/quaternius/ultimate-farm/Saddle.glb",
            {"author": "Quaternius", "license": "CC0 1.0", "role": "saddle"},
        ),
        (
            "quaternius_horse_saddle",
            "Horse_Saddle.glb",
            "https://cdn.cinevva.com/assets/packs/quaternius/animated-animals/Horse_Saddle.glb",
            {"author": "Quaternius", "license": "CC0 1.0", "role": "saddle"},
        ),
        (
            "kenney_platformer_character",
            "character-female.glb",
            "https://cdn.cinevva.com/assets/packs/kenney/platformer-kit/character-female.glb",
            {"author": "Kenney", "license": "CC0 1.0", "role": "rider"},
        ),
    ]
    for slug, fn, url, meta in extra_probes:
        if head_ok(url):
            downloads.append({"slug": slug, "filename": fn, "url": url, "meta": meta})
            print("PROBE HIT", url)
        else:
            print("PROBE MISS", url)

    done = []
    failed = []
    for d in downloads:
        try:
            save(d["slug"], d["filename"], d["url"], d["meta"])
            done.append(d["slug"])
        except Exception as e:
            print("FAIL", d["slug"], e)
            failed.append((d["slug"], str(e)))

    (RAW.parent / "_download_log.json").write_text(
        json.dumps({"done": done, "failed": failed, "date": TODAY}, indent=2),
        encoding="utf-8",
    )
    print("done", done, "failed", failed)


if __name__ == "__main__":
    main()
