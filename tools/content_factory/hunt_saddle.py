"""Probe more CC0/CC-BY saddle URLs."""
from __future__ import annotations

import ssl
import urllib.request

UA = {"User-Agent": "HiddenK-ContentFactory/1.0"}
CTX = ssl.create_default_context()

URLS = [
    "https://cdn.cinevva.com/assets/packs/kenney/farming-kit/saddle.glb",
    "https://cdn.cinevva.com/assets/packs/kenney/nature-kit/saddle.glb",
    "https://cdn.cinevva.com/assets/packs/quaternius/ultimate-farming/Saddle.glb",
    "https://cdn.cinevva.com/assets/packs/quaternius/farm-animals/Horse.glb",
    "https://cdn.cinevva.com/assets/packs/quaternius/animated-animals/Horse.glb",
    "https://cdn.cinevva.com/assets/packs/quaternius/ultimate-nature/Horse.glb",
    "https://app.cinevva.com/game-assets/free-3d-models?q=saddle",
    "https://app.cinevva.com/game-assets?q=saddle",
    "https://www.printables.com/model/411449-horse-saddle-accurate",
    "https://kenney.nl/assets/farming",
    "https://kenney.nl/assets/farm-kit",
    "https://kenney.nl/assets/nature-kit",
    "https://quaternius.com/packs/animatedanimals.html",
    "https://opengameart.org/content/low-poly-horse",
    "https://polyhaven.com/a/horse_statue_01",
]


def main() -> None:
    for url in URLS:
        try:
            req = urllib.request.Request(url, headers=UA)
            with urllib.request.urlopen(req, timeout=25, context=CTX) as r:
                n = r.headers.get("Content-Length")
                t = r.headers.get("Content-Type")
                body = r.read(200)
                print(f"OK {r.status} len={n} type={t} {url}")
                if b"saddle" in body.lower() or b".zip" in body.lower() or b"glb" in body.lower():
                    print("  snippet", body[:120])
        except Exception as e:
            print("FAIL", url, e)


if __name__ == "__main__":
    main()
