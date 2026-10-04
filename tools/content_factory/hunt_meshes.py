"""Phase G: hunt legal rider/saddle meshes. Does not wire into the live ride."""
from __future__ import annotations

import json
import re
import ssl
import time
import urllib.error
import urllib.request
from datetime import date
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
RAW = ROOT / "content" / "meshes" / "raw"
DOCS = ROOT / "content" / "meshes"
UA = "HiddenK-ContentFactory/1.0 (Abbott; legal mesh hunt; CC0/CC-BY only)"
TODAY = date.today().isoformat()
CTX = ssl.create_default_context()


def fetch(url: str, timeout: int = 60) -> bytes:
    req = urllib.request.Request(url, headers={"User-Agent": UA, "Accept": "*/*"})
    last = None
    for i in range(4):
        try:
            with urllib.request.urlopen(req, timeout=timeout, context=CTX) as r:
                return r.read()
        except Exception as e:
            last = e
            time.sleep(0.8 * (i + 1))
    raise last  # type: ignore[misc]


def fetch_text(url: str) -> str:
    return fetch(url).decode("utf-8", "replace")


def hrefs(html: str) -> list[str]:
    return re.findall(r"""href=["']([^"']+)["']""", html, flags=re.I)


def interesting(url: str) -> bool:
    u = url.lower()
    keys = (
        "download",
        "dropbox",
        "drive.google",
        ".zip",
        ".glb",
        ".gltf",
        ".fbx",
        "itch.io",
        "github",
        "poly.pizza",
        "mediafire",
        "cloudflare",
        "patreon",
        "kenney",
    )
    return any(k in u for k in keys)


def main() -> None:
    pages = [
        "https://quaternius.com/packs/animatedwoman.html",
        "https://quaternius.com/packs/ultimatemodularwomen.html",
        "https://quaternius.com/packs/universalbasecharacters.html",
        "https://quaternius.com/packs/animatedwomen.html",
        "https://kenney.nl/assets/animated-characters",
        "https://kenney.nl/assets",
        "https://poly.pizza/bundle/Ultimate-Modular-Women-Pack-aCBDXDdTNN",
        "https://poly.pizza/m/Animated-Woman-Quaternius",
        "https://opengameart.org/content/saddle-with-bedroll",
        "https://opengameart.org/content/vroid-studio-cc0-models",
        "https://opengameart.org/content/horse",
    ]
    out: dict[str, list[str]] = {}
    for url in pages:
        print("FETCH", url)
        try:
            html = fetch_text(url)
        except Exception as e:
            print("  FAIL", e)
            out[url] = [f"ERROR {e}"]
            continue
        found = [h for h in hrefs(html) if interesting(h)]
        # also src= for zip buttons
        found += re.findall(r"""(?:src|data-url|data-download)=["']([^"']+)["']""", html, flags=re.I)
        # unique
        seen = []
        for h in found:
            if h not in seen:
                seen.append(h)
        out[url] = seen[:40]
        for h in seen[:20]:
            print(" ", h)
    DOCS.mkdir(parents=True, exist_ok=True)
    (DOCS / "_hunt_urls.json").write_text(json.dumps(out, indent=2), encoding="utf-8")
    print("wrote", DOCS / "_hunt_urls.json")


if __name__ == "__main__":
    main()
