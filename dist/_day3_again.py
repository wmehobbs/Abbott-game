"""Attribute each Come again to the COUNT fence still in front."""
import re
import sys
from pathlib import Path

count = re.compile(r"COUNT fence=(\d+)")
again = "MICHELLE soft | Come again."
result = re.compile(r"t=([0-9.]+) teleported=(true|false).*rail_fences=(\[[^\]]*\])")
for name in sys.argv[1:]:
    lines = Path(name).read_text(encoding="utf-8", errors="replace").splitlines()
    fence = "?"
    got = []
    for line in lines:
        hit = count.search(line)
        if hit:
            fence = hit.group(1)
        if line.strip() == again:
            got.append(fence)
    res = result.search("\n".join(lines))
    print(Path(name).name, "fences", " ".join(got), "t", res.group(1) if res else "?", "rails", res.group(3) if res else "?")
