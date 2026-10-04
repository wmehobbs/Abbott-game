from construct_courses import construct_outdoor, construct_indoor
from rules import validate_course
import random

rng = random.Random(42)
rec = construct_outdoor("beginner", 3001, rng, False, "outside_track")
print("outdoor rec", rec is not None, rec.get("id") if rec else None)
if rec:
    print("n", len(rec["fences"]))
    for f in rec["fences"]:
        print(f["num"], f["kind"], f["pos"], "yaw", round(f["yaw"],3), "rel", f.get("related"))
    print("ERRS", validate_course(rec))

rng = random.Random(42)
rec = construct_indoor("beginner", 3001, rng, False, "outside_track")
print("\nindoor rec", rec is not None)
if rec:
    print("n", len(rec["fences"]))
    for f in rec["fences"]:
        print(f["num"], f["kind"], f["pos"], "yaw", round(f["yaw"],3), "rel", f.get("related"))
else:
    rec = None
    from construct_courses import construct_indoor as ci
    # construct_indoor returns None if validate fails internally
    import construct_courses as cc
    # bypass validate
    print("indoor returned None (failed validate inside)")
