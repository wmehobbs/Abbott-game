"""Rerun the Hidden K content factory. Does not touch live ride scripts."""
from __future__ import annotations

import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
PY = sys.executable
STEPS = [
    "harvest.py",
    "convert_harvest.py",
    "make_plates.py",
    "make_courses.py",
    "make_rail.py",
    "make_fences.py",
    "validate_content.py",
]


def main() -> int:
    for name in STEPS:
        print(f"\n=== {name} ===")
        r = subprocess.run([PY, str(HERE / name)], cwd=str(HERE.parents[1]))
        if r.returncode != 0 and name != "harvest.py":
            # harvest may return 1 if under 40 raw plates; convert is the gate
            print(f"{name} failed ({r.returncode})")
            if name == "validate_content.py":
                return r.returncode
            if name in ("convert_harvest.py", "make_plates.py", "make_courses.py", "make_rail.py"):
                return r.returncode
    return 0


if __name__ == "__main__":
    sys.exit(main())
