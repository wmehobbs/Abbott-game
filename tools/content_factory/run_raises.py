"""Raise mega quotas three times and refill. Headless. No Godot window."""
from __future__ import annotations

import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
PY = sys.executable


def run(name: str) -> int:
    print(f"\n=== {name} ===", flush=True)
    r = subprocess.run([PY, str(HERE / name)], cwd=str(ROOT))
    print(f"=== {name} exit {r.returncode} ===", flush=True)
    return r.returncode


def main() -> int:
    for i in range(3):
        print(f"\n######## RAISE {i+1} ########", flush=True)
        if run("raise_quotas.py") != 0:
            return 1
        for step in (
            "make_courses_mega.py",
            "fix_unique_text.py",
            "make_rail_mega.py",
            "make_copy_mega.py",
            "make_harvest_fill.py",
            "make_proc_extra.py",
            "make_artshots_archive.py",
            "score_courses.py",
            "smoke_courses.py",
            "validate_content.py",
            "validate_mega.py",
        ):
            rc = run(step)
            if rc != 0 and step in ("make_courses_mega.py", "validate_mega.py", "validate_content.py"):
                # unique text / related: try fix once more
                if step == "validate_mega.py":
                    run("fix_unique_text.py")
                    run("score_courses.py")
                    run("smoke_courses.py")
                    rc = run("validate_mega.py")
                if rc != 0:
                    print("STOP at", step, "raise", i + 1)
                    return rc
    print("THREE RAISES DONE")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
