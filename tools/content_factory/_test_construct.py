from construct_courses import try_construct
import random
from rules import validate_course

def main():
    ok = 0
    bad = 0
    for cid in ("lesson", "beginner", "intermediate", "advanced"):
        for indoor in (False, True):
            for jo in (False, True):
                if cid == "lesson" and jo:
                    continue
                for i in range(8):
                    rng = random.Random(1000 + i * 17 + hash(cid) % 99)
                    rec = try_construct(cid, 3000 + i, rng, jo, indoor, "outside_track")
                    if rec is None:
                        bad += 1
                        print("FAIL", cid, "in", indoor, "jo", jo, i)
                    else:
                        ok += 1
    print("ok", ok, "bad", bad)
    return 0 if bad == 0 else 1

if __name__ == "__main__":
    raise SystemExit(main())
