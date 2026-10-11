"""Compare Madison's save (and settings, if any) with the Day 18 snapshot.
usage: python dist/day18/save_check.py   (prints SAVE_MATCH or SAVE_CHANGED)"""
import hashlib
import os

USERDATA = r"C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott"
SNAPDIR = os.path.dirname(os.path.abspath(__file__))


def sha(p):
    return hashlib.sha256(open(p, "rb").read()).hexdigest() if os.path.exists(p) else "missing"


ok = True
for name in ["abbott_save.json", "settings.cfg"]:
    live = os.path.join(USERDATA, name)
    snap = os.path.join(SNAPDIR, "snapshot_" + name)
    # Her save must have a snapshot. Settings may never have been saved; then
    # they must still be absent ("missing" on both sides).
    if name == "abbott_save.json" and not os.path.exists(snap):
        print("NO_SNAPSHOT", snap)
        ok = False
        break
    if sha(live) != sha(snap):
        print("CHANGED", name)
        ok = False
print("SAVE_MATCH" if ok else "SAVE_CHANGED")
