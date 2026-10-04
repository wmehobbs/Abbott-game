"""Monitor a headless --ridecert log. Prints only DONE / FAILED."""
from __future__ import annotations

import os
import sys
import time

LOG = sys.argv[1] if len(sys.argv) > 1 else r"E:\Workspace\Madison\dist\ridecert_godot.log"
STALL_S = 420
POLL = 8.0


def read() -> str:
    if not os.path.isfile(LOG):
        return ""
    with open(LOG, "r", encoding="utf-8", errors="replace") as f:
        return f.read()


def fail_reason(text: str) -> str:
    keys = (
        "SCRIPT ERROR",
        "Parse Error",
        "Failed to load script",
        "Compile Error",
        "Assertion failed",
        "FATAL",
        "Crash",
    )
    for k in keys:
        if k in text:
            return k
    return ""


started = time.time()
last_len = 0
last_grow = time.time()
saw_begin = False

while True:
    text = read()
    n = len(text)
    if n > last_len:
        last_grow = time.time()
        last_len = n
    if "RIDECERT begin" in text:
        saw_begin = True
    why = fail_reason(text)
    if saw_begin and why and "RIDECERT done" not in text:
        print(f"FAILED: {why}")
        sys.exit(1)
    if saw_begin and "RIDECERT done" in text:
        print("DONE: ridecert finished")
        sys.exit(0)
    if saw_begin and time.time() - last_grow > STALL_S:
        print("FAILED: ridecert log stalled")
        sys.exit(1)
    if not saw_begin and time.time() - started > 180:
        print("FAILED: ridecert never began")
        sys.exit(1)
    time.sleep(POLL)
