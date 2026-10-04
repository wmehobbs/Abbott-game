"""Find direct GLB/ZIP URLs for legal rider/saddle candidates."""
from __future__ import annotations

import json
import re
import ssl
import urllib.request
from pathlib import Path

UA = {"User-Agent": "HiddenK-ContentFactory/1.0"}
CTX = ssl.create_default_context()
OUT = Path(__file__).resolve().parents[2] / "content" / "meshes" / "_hunt2.json"


def get(url: str, timeout: int = 40) -> bytes:
    req = urllib.request.Request(url, headers=UA)
    with urllib.request.urlopen(req, timeout=timeout, context=CTX) as r:
        print("OK", r.status, url[:90], "len", r.headers.get("Content-Length"), r.headers.get("Content-Type"))
        return r.read()


def try_urls(urls: list[str]) -> dict:
    out = {}
    for url in urls:
        print("TRY", url)
        try:
            data = get(url)
            out[url] = {
                "ok": True,
                "n": len(data),
                "head": data[:20].hex() if not data[:20].isascii() else data[:80].decode("latin1", "replace"),
            }
            # don't keep huge bodies in json
        except Exception as e:
            print("  FAIL", e)
            out[url] = {"ok": False, "err": str(e)}
    return out


def main() -> None:
    results: dict = {}
    # JS on quaternius for download
    for pack in ("animatedwoman", "animatedwomen", "ultimatemodularwomen", "universalbasecharacters"):
        url = f"https://quaternius.com/packs/{pack}.html"
        try:
            html = get(url).decode("utf-8", "replace")
            hits = re.findall(r"https?://[^\"'\\s]+", html)
            hits = [h for h in hits if any(k in h.lower() for k in ("drive", "dropbox", "zip", "mega", "mediafire", "itch", "github", "firebasestorage", "digitaloceanspaces"))]
            results[f"js_{pack}"] = hits
            print("HITS", pack, hits)
        except Exception as e:
            results[f"js_{pack}"] = [str(e)]

    # poly.pizza search
    for q in (
        "https://poly.pizza/search?q=saddle",
        "https://poly.pizza/search?q=woman",
        "https://api.poly.pizza/v1/search?query=saddle",
        "https://api.poly.pizza/v1/search?query=woman",
    ):
        try:
            b = get(q)
            text = b.decode("utf-8", "replace")
            results[q] = text[:1500]
            print("POLY", q, text[:200].replace("\n", " "))
        except Exception as e:
            results[q] = str(e)

    # cinevva
    try:
        html = get("https://app.cinevva.com/game-assets/free-3d-character-models").decode("utf-8", "replace")
        glbs = re.findall(r"https?://[^\"']+\.glb", html, flags=re.I)
        results["cinevva_glbs"] = glbs[:30]
        print("CINEVVA", glbs[:20])
    except Exception as e:
        results["cinevva"] = str(e)

    # kenney pages
    for slug in (
        "toon-characters-1",
        "mini-characters",
        "animated-character",
        "character-sprites",
        "platformer-kit",
        "mini-arena",
    ):
        url = f"https://kenney.nl/assets/{slug}"
        try:
            html = get(url).decode("utf-8", "replace")
            zips = re.findall(r"https?://[^\"']+\.zip", html, flags=re.I)
            zips += re.findall(r'href="([^"]+\.zip)"', html)
            results[slug] = zips
            print("KENNEY", slug, zips[:8], "title ok" if "<title>" in html else "empty")
        except Exception as e:
            results[slug] = str(e)

    OUT.write_text(json.dumps(results, indent=2)[:200000], encoding="utf-8")
    print("wrote", OUT)


if __name__ == "__main__":
    main()
