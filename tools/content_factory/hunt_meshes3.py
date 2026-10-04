"""Extract all Cinevva GLB URLs and Kenney zip URLs; probe saddle search."""
from __future__ import annotations

import json
import re
import ssl
import urllib.request
from pathlib import Path

UA = {"User-Agent": "HiddenK-ContentFactory/1.0"}
CTX = ssl.create_default_context()
OUT = Path(__file__).resolve().parents[2] / "content" / "meshes" / "_hunt3.json"


def get(url: str) -> bytes:
    req = urllib.request.Request(url, headers=UA)
    with urllib.request.urlopen(req, timeout=40, context=CTX) as r:
        return r.read()


def main() -> None:
    html = get("https://app.cinevva.com/game-assets/free-3d-character-models").decode("utf-8", "replace")
    glbs = sorted(set(re.findall(r"https?://[^\"']+\.glb", html, flags=re.I)))
    print("glb count", len(glbs))
    want = []
    for u in glbs:
        lu = u.lower()
        if any(k in lu for k in ("woman", "female", "girl", "casual", "character", "human", "rider", "saddle", "adventurer", "lis")):
            want.append(u)
            print("WANT", u)
    # also list unique pack folders
    packs = sorted({"/".join(u.split("/")[4:6]) for u in glbs})
    print("PACKS", packs)

    # probe likely woman GLBs
    probes = [
        "https://cdn.cinevva.com/assets/packs/quaternius/ultimate-modular-women/Woman.glb",
        "https://cdn.cinevva.com/assets/packs/quaternius/ultimate-modular-women/Casual.glb",
        "https://cdn.cinevva.com/assets/packs/quaternius/animated-woman/Woman.glb",
        "https://cdn.cinevva.com/assets/packs/quaternius/animated-women/Woman_1.glb",
        "https://cdn.cinevva.com/assets/packs/kenney/animated-characters-3/character-female.glb",
        "https://cdn.cinevva.com/assets/packs/kenney/animated-characters-3/CharacterFemale.glb",
        "https://app.cinevva.com/game-assets?q=saddle",
        "https://app.cinevva.com/search?q=saddle",
        "https://cdn.cinevva.com/assets/packs/quaternius/ultimate-modular-women/Adventurer.glb",
        "https://cdn.cinevva.com/assets/packs/quaternius/zombie-apocalypse-kit/Characters_Lis.glb",
    ]
    probe_res = {}
    for u in probes:
        try:
            req = urllib.request.Request(u, headers=UA, method="HEAD")
            with urllib.request.urlopen(req, timeout=20, context=CTX) as r:
                probe_res[u] = {"status": r.status, "len": r.headers.get("Content-Length"), "type": r.headers.get("Content-Type")}
                print("HEAD OK", r.status, r.headers.get("Content-Length"), u)
        except Exception as e:
            probe_res[u] = {"err": str(e)}
            print("HEAD FAIL", u, e)

    OUT.write_text(json.dumps({"want": want, "all": glbs, "packs": packs, "probes": probe_res}, indent=2), encoding="utf-8")


if __name__ == "__main__":
    main()
