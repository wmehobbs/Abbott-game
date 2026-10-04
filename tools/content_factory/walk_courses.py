"""Walk the live board the way the rider has to.

Rideability by the rider's own rule: from the landing point, is there enough
run left on the next fence's line to curve onto it and be straight?
   need  along > 1.9 * off_line + 6.5
Plus: labeled lines must be a real band, unlabeled lines must not be a line."""
import json, math, pathlib, glob, sys
GAME = pathlib.Path(r"E:\Workspace\Madison\game\content\courses")
BANDS = {1: (7.0, 7.8), 2: (10.4, 11.2), 3: (14.0, 15.2)}
LAND, TAKE, RING_X, RING_Z = 3.5, 2.55, 13.4, 36.2

def d_of(y): return (math.sin(y), math.cos(y))

def check(cid):
    path = glob.glob(str(GAME) + "/**/%s.json" % cid, recursive=True)[0]
    c = json.loads(pathlib.Path(path).read_text())
    fs = c["fences"]; by = {int(f["num"]): f for f in fs}
    msgs = []
    px, pz = c["start_pos"][0], c["start_pos"][2]
    pdx, pdz = d_of(float(c["start_yaw"]))
    pn = "start"
    for n in range(1, len(fs) + 1):
        b = by[n]; bx, bz = b["pos"][0], b["pos"][2]; dbx, dbz = d_of(float(b["yaw"]))
        lx, lz = (px, pz) if pn == "start" else (px + pdx * LAND, pz + pdz * LAND)
        gap = math.hypot(bx - px, bz - pz)
        head = pdx * dbx + pdz * dbz
        rel = by[n - 1].get("related") if n > 1 else None
        lab = int(rel["strides"]) if isinstance(rel, dict) and int(rel.get("to", 0)) == n else None
        along = (bx - lx) * dbx + (bz - lz) * dbz
        off = abs((lx - bx) * (-dbz) + (lz - bz) * dbx)
        if lab:
            lo, hi = BANDS[lab]
            if not (lo <= gap <= hi):
                msgs.append("  REL %s->%d labeled %d is %.2f m (band %.1f-%.1f)" % (pn, n, lab, gap, lo, hi))
            if head < 0.90:
                msgs.append("  REL %s->%d labeled but %.0f deg apart" % (pn, n, lab, math.degrees(math.acos(max(-1, min(1, head))))))
            latl = abs((bx - px) * (-pdz) + (bz - pz) * pdx)
            if latl > 0.62 * gap:
                msgs.append("  REL %s->%d labeled %d but bends %.1f m off %.1f m" % (pn, n, lab, latl, gap))
            if abs(float(rel.get("distance_m", 0)) - gap) > 0.06:
                msgs.append("  REL %s->%d distance_m %s != %.2f" % (pn, n, rel.get("distance_m"), gap))
        else:
            fwd = (bx - px) * pdx + (bz - pz) * pdz
            latl = abs((bx - px) * (-pdz) + (bz - pz) * pdx)
            if head > 0.90 and latl < 3.0 and fwd > 2.0 and gap < 16.0:
                msgs.append("  LINE %s->%d %.2f m, unlabeled and no band fits" % (pn, n, gap))
            elif along < 1.9 * off + 6.5:
                msgs.append("  ROOM %s->%d land %.1f off the line with %.1f m of run (need %.1f)"
                            % (pn, n, off, along, 1.9 * off + 6.5))
        nlx, nlz = bx + dbx * LAND, bz + dbz * LAND
        if abs(nlx) > RING_X or abs(nlz) > RING_Z:
            msgs.append("  SAND #%d lands at (%.1f,%.1f)" % (n, nlx, nlz))
        for o in fs:
            if o["num"] == b["num"]:
                continue
            al = (o["pos"][0] - bx) * -dbx + (o["pos"][2] - bz) * -dbz
            lt = abs((o["pos"][0] - bx) * (-dbz) + (o["pos"][2] - bz) * dbx)
            if 0.9 < al < 11.0 and lt < 2.3:
                msgs.append("  BLOCK #%d stands %.1f m out on the approach to #%d" % (o["num"], al, n))
        px, pz, pdx, pdz, pn = bx, bz, dbx, dbz, str(n)
    if msgs:
        print("==", cid, c["name"])
        for m in msgs: print(m)
    return msgs

ship = json.loads((GAME / "SHIP.json").read_text())
ids = []
for k in ("lesson", "beginner", "intermediate", "advanced"): ids += ship[k]
ids += list(ship["jump_off"].values())
if len(sys.argv) > 1: ids = sys.argv[1:]
bad = [i for i in ids if check(i)]
print("\n%d/%d tracks with findings: %s" % (len(bad), len(ids), " ".join(bad)))
