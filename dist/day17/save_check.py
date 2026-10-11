"""Compare Madison's save and settings with the Day 17 snapshot.
usage: python dist/day17/save_check.py   (prints SAVE_MATCH or SAVE_CHANGED)"""
import importlib.util
import os
spec = importlib.util.spec_from_file_location("rw", os.path.join(os.path.dirname(__file__), "run_window.py"))
rw = importlib.util.module_from_spec(spec)
spec.loader.exec_module(rw)
rw.check()
