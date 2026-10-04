"""Move a fence only when the horse is faster.

The geometry sweep converged and made the ride worse — `run >= 1.9*off + 6.5`
diagnoses a crossing well and optimises badly, because angling a fence to
shorten one correction lengthens the approach to the next and the rider pays
the turn to get square. That cost is invisible to the metric.

So the objective here is the clock. For one fence: take the ranked candidates
out of place_fence.search (which already has prove_ship's rules, seg_clear on
the path out, the leash and the cumulative yaw cap as hard constraints), write
each one, prove it, ride it in Godot, and keep a candidate only if it is
actually faster with no rail. Otherwise put the fence back exactly where it was.

Usage:
    python tools/content_factory/ride_place.py hk_adv_002 5 [--cands 4]
"""
from __future__ import annotations

import json
import math
import re
import subprocess
import sys
import pathlib

HERE = pathlib.Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import place_fence as pf  # noqa: E402

ROOT = HERE.parents[1]


def read_fence(cid: str, num: int) -> tuple[float, float, float]:
    path = pf.GAME / (pf.folder(cid) + "/%s.json" % cid)
    course = json.loads(path.read_text(encoding="utf-8"))
    for f in course["fences"]:
        if int(f["num"]) == num:
            return f["pos"][0], f["pos"][2], float(f["yaw"])
    raise SystemExit("no fence %d in %s" % (num, cid))


def prove() -> bool:
    r = subprocess.run([sys.executable, str(HERE / "prove_ship.py")],
                       capture_output=True, text=True, encoding="utf-8",
                       errors="replace", cwd=str(ROOT))
    return (r.stdout or "").startswith("PASS")


def ride(cid: str) -> tuple[float, int, int, bool]:
    """time, faults, rails, completed — straight out of the Godot log."""
    subprocess.run([sys.executable, str(HERE / "ride_ids.py"), cid],
                   capture_output=True, text=True, encoding="utf-8",
                   errors="replace", cwd=str(ROOT))
    log = (ROOT / "dist" / "ridecert_logs" / ("%s.log" % cid)).read_text(
        encoding="utf-8", errors="replace")
    m = re.search(r"RIDECERT %s style=clear success=(\w+) faults=(\d+) "
                  r"jumped=(\d+)/(\d+) t=([\d.]+) teleported=(\w+) complete=(\w+)"
                  % re.escape(cid), log)
    if not m:
        return (9999.0, 99, 99, False)
    rails = len(re.findall(r"FENCE knock", log))
    return (float(m.group(5)), int(m.group(2)), rails, m.group(7) == "true")


def wrap_pi(a: float) -> float:
    while a > math.pi:
        a -= 2.0 * math.pi
    while a < -math.pi:
        a += 2.0 * math.pi
    return a


GODOT = (
    r"C:\Users\ErnieHobbs\AppData\Local\Microsoft\WinGet\Packages"
    r"\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe"
    r"\Godot_v4.7.2-stable_win64_console.exe"
)


def _godot_running() -> bool:
    r = subprocess.run(
        ["tasklist", "/FO", "CSV", "/NH"],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
    )
    text = (r.stdout or "").lower()
    return "godot_v4" in text or "godot.exe" in text


def wait_no_godot() -> None:
    """Sit. Never taskkill. ride_ids.py is not used here because it kills
    every Godot on the machine."""
    import time
    while _godot_running():
        print("  godot still up — waiting", flush=True)
        time.sleep(3.0)


def ride_headless(cid: str, tag: str = "last") -> tuple[float, int, int, bool, bool]:
    """time, faults, rails, completed, teleported. One id, no taskkill.
    Writes a fresh log. Stale dist/ridecert_logs are not read."""
    import time
    wait_no_godot()
    log_path = ROOT / "dist" / "triple_logs"
    log_path.mkdir(parents=True, exist_ok=True)
    log_file = log_path / ("%s_%s.log" % (cid, tag))
    cmd = [GODOT, "--headless", "--path", "game", "--",
           "--ridecert", "--ridecert-id=" + cid]
    t0 = time.perf_counter()
    creation = getattr(subprocess, "CREATE_NO_WINDOW", 0)
    with log_file.open("w", encoding="utf-8", newline="\n") as f:
        proc = subprocess.Popen(
            cmd, cwd=str(ROOT), stdout=f, stderr=subprocess.STDOUT,
            creationflags=creation,
        )
        try:
            proc.wait(timeout=190)
        except subprocess.TimeoutExpired:
            proc.kill()
            proc.wait(timeout=20)
            print("  RIDE timeout — killed pid %s only" % proc.pid, flush=True)
            return (9999.0, 99, 99, False, True)
    wall = time.perf_counter() - t0
    log = log_file.read_text(encoding="utf-8", errors="replace")
    m = re.search(
        r"RIDECERT %s style=clear success=(\w+) faults=(\d+) "
        r"jumped=(\d+)/(\d+) t=([\d.]+) teleported=(\w+) complete=(\w+)"
        % re.escape(cid), log)
    print("  wall %.1fs" % wall, flush=True)
    if not m:
        return (9999.0, 99, 99, False, True)
    rails = len(re.findall(r"FENCE knock", log))
    agains = re.findall(r"RIDEAI come again n=(\d+)", log)
    segs = re.findall(r"RIDEAI fence (\d+) -> (\d+) t=([\d.]+)", log)
    prev = 0.0
    slow = []
    for a, b, t in segs:
        dt = float(t) - prev
        prev = float(t)
        slow.append((dt, int(a)))
    slow.sort(reverse=True)
    print("    come_again=%s  slow=%s"
          % (",".join(agains) or "-",
             " ".join("%d:%.1f" % (n, dt) for dt, n in slow[:4])),
          flush=True)
    return (float(m.group(5)), int(m.group(2)), rails,
            m.group(7) == "true", m.group(6) == "true")


def _course_paths(cid: str) -> tuple[pathlib.Path, pathlib.Path]:
    rel = pf.folder(cid) + "/%s.json" % cid
    return pf.GAME / rel, pf.PILE / rel


def _snapshot(cid: str) -> tuple[bytes, bytes]:
    g, p = _course_paths(cid)
    return g.read_bytes(), p.read_bytes()


def _restore(cid: str, gb: bytes, pb: bytes) -> None:
    g, p = _course_paths(cid)
    g.write_bytes(gb)
    p.write_bytes(pb)


def triple_main(cid: str, n1: int, n2: int, n3: int, n_cands: int) -> None:
    """Three ends of one labeled chain, one rigid body, scored by the clock.
    Keep only when the round is faster by >= 0.2 s, zero rails, complete,
    not teleported, and every labeled related is still inside its band.
    Otherwise the three fences go back byte-identical."""
    chains = pf.find_chains(cid)
    if (n1, n2, n3) not in chains:
        print("%s %d-%d-%d is not a labeled chain. Chains in the file: %s. Not riding."
              % (cid, n1, n2, n3, chains or "none"))
        return
    game_p, pile_p = _course_paths(cid)
    if game_p.read_bytes() != pile_p.read_bytes():
        print("%s course trees differ before the triple. Refusing to write." % cid)
        return

    # Search before any ride. A chain with no legal body does not need a clock.
    cands = pf.search_triple(cid, n1, n2, n3, max(n_cands * 3, 12))
    print("%s #%d+#%d+#%d search %s"
          % (cid, n1, n2, n3, pf.search_triple.last_stats), flush=True)
    if not cands:
        print("%s #%d+#%d+#%d — no rigid placement satisfies the constraints."
              % (cid, n1, n2, n3))
        return

    gb, pb = _snapshot(cid)
    base_t, base_f, base_r, base_done, base_tp = ride_headless(cid, "baseline")
    print("%s baseline  %.2f s  faults %d  rails %d  complete %s  teleported %s"
          % (cid, base_t, base_f, base_r, base_done, base_tp), flush=True)
    if not base_done or base_tp or base_r != 0 or base_t >= 9000:
        print("%s baseline is not a clean finished round. Not moving fences." % cid)
        return

    kept = False
    best = None
    ridden = 0
    try:
        for i, (sc, ax, az, ay, bx, bz, byw, cx, cz, cy, run_in, off_in, gap_ab, gap_bc) in enumerate(cands, 1):
            if ridden >= n_cands:
                break
            pf.write_fence(cid, n1, ax, az, wrap_pi(ay))
            pf.write_fence(cid, n2, bx, bz, wrap_pi(byw))
            pf.write_fence(cid, n3, cx, cz, wrap_pi(cy))
            course = json.loads(game_p.read_text(encoding="utf-8"))
            if not pf.labels_hold(course["fences"]):
                print("  cand %d — a labeled related left its band, skipped" % i, flush=True)
                continue
            if not prove():
                print("  cand %d — prove_ship red, skipped" % i, flush=True)
                continue
            t, f, r, done, tp = ride_headless(cid, "c%d" % i)
            ridden += 1
            ok = r == 0 and done and (not tp) and t < base_t - 0.2
            print("  cand %d  #%d(%6.2f,%6.2f) #%d(%6.2f,%6.2f) #%d(%6.2f,%6.2f)"
                  " gaps %.3f/%.3f run_in %+5.1f  ->  %.2f s  faults %d  rails %d  %s"
                  % (i, n1, ax, az, n2, bx, bz, n3, cx, cz, gap_ab, gap_bc, run_in,
                     t, f, r, "faster" if ok else "no"), flush=True)
            if ok and (best is None or t < best[0]):
                best = (t, ax, az, ay, bx, bz, byw, cx, cz, cy, f)
        if best is None:
            print("%s #%d+#%d+#%d — %d legal ride(s), nothing beat %.2f s by 0.2 with zero rails. Put back."
                  % (cid, n1, n2, n3, ridden, base_t))
            return
        t, ax, az, ay, bx, bz, byw, cx, cz, cy, f = best
        pf.write_fence(cid, n1, ax, az, wrap_pi(ay))
        pf.write_fence(cid, n2, bx, bz, wrap_pi(byw))
        pf.write_fence(cid, n3, cx, cz, wrap_pi(cy))
        course = json.loads(game_p.read_text(encoding="utf-8"))
        if not pf.labels_hold(course["fences"]) or not prove():
            print("%s KEEP rejected on the write-back check. Put back." % cid)
            return
        kept = True
        print("%s #%d+#%d+#%d KEEP  %.2f s (was %.2f)  faults %d"
              % (cid, n1, n2, n3, t, base_t, f))
    finally:
        if not kept:
            _restore(cid, gb, pb)
            g2, p2 = _snapshot(cid)
            same = g2 == gb and p2 == pb
            print("%s trees restored byte-identical: %s" % (cid, same), flush=True)


def pair_main(cid: str, na: int, nb: int, n_cands: int) -> None:
    """Both ends of a labeled related, moved as one rigid body, scored by the
    clock. place_fence.search refuses either end on its own because it is
    labeled — that is exactly why they travel together."""
    oa = read_fence(cid, na)
    ob = read_fence(cid, nb)
    base_t, base_f, base_r, base_done = ride(cid)
    print("%s baseline  %.2f s  faults %d  rails %d  complete %s"
          % (cid, base_t, base_f, base_r, base_done), flush=True)

    cands = pf.search_pair(cid, na, nb, n_cands)
    if not cands:
        print("%s #%d+#%d — no rigid placement satisfies the constraints."
              % (cid, na, nb))
        return

    def put(ax, az, ay, bx, bz, byw):
        pf.write_fence(cid, na, ax, az, wrap_pi(ay))
        pf.write_fence(cid, nb, bx, bz, wrap_pi(byw))

    best = None
    for i, (sc, ax, az, ay, bx, bz, byw, run_in, off_in) in enumerate(cands, 1):
        put(ax, az, ay, bx, bz, byw)
        gap = math.hypot(ax - bx, az - bz)
        if not (10.4 <= gap <= 11.2):
            print("  cand %d — gap %.2f left the band, skipped" % (i, gap))
            continue
        if not prove():
            print("  cand %d — prove_ship red, skipped" % i, flush=True)
            continue
        t, f, r, done = ride(cid)
        ok = r == 0 and done and t < base_t - 0.2
        print("  cand %d  #%d(%6.2f,%6.2f) #%d(%6.2f,%6.2f) gap %.2f run_in %+5.1f"
              "  ->  %.2f s  faults %d  rails %d  %s"
              % (i, na, ax, az, nb, bx, bz, gap, run_in, t, f, r,
                 "faster" if ok else "no"), flush=True)
        if ok and (best is None or t < best[0]):
            best = (t, ax, az, ay, bx, bz, byw, f)

    if best is None:
        pf.write_fence(cid, na, *oa)
        pf.write_fence(cid, nb, *ob)
        print("%s #%d+#%d — nothing beat %.2f s. Both put back where they were."
              % (cid, na, nb, base_t))
        return
    t, ax, az, ay, bx, bz, byw, f = best
    put(ax, az, ay, bx, bz, byw)
    print("%s #%d+#%d KEEP  %.2f s (was %.2f)  faults %d"
          % (cid, na, nb, t, base_t, f))


def main() -> None:
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    n_cands = 4
    for a in sys.argv[1:]:
        if a.startswith("--cands"):
            n_cands = int(a.split("=")[1]) if "=" in a else 4
    if "--pair" in sys.argv:
        if len(args) != 3:
            print("usage: ride_place.py --pair <id> <in> <out> [--cands=N]")
            raise SystemExit(2)
        pair_main(args[0], int(args[1]), int(args[2]), n_cands)
        return
    if "--triple" in sys.argv:
        if len(args) != 4:
            print("usage: ride_place.py --triple <id> <a> <b> <c> [--cands=N]")
            raise SystemExit(2)
        triple_main(args[0], int(args[1]), int(args[2]), int(args[3]), n_cands)
        return
    if len(args) != 2:
        print("usage: ride_place.py <id> <fence-num> [--cands=N]")
        raise SystemExit(2)
    cid, num = args[0], int(args[1])

    ox, oz, oyaw = read_fence(cid, num)
    base_t, base_f, base_r, base_done = ride(cid)
    print("%s baseline  %.2f s  faults %d  rails %d  complete %s"
          % (cid, base_t, base_f, base_r, base_done), flush=True)

    cands = pf.search(cid, num, None, n_cands)
    if not cands:
        print("%s #%d — pinned by a label, or no legal placement. Leaving it."
              % (cid, num))
        return

    best = None
    for i, (sc, x, z, yaw, run_in, off_in) in enumerate(cands, 1):
        pf.write_fence(cid, num, x, z, yaw)
        if not prove():
            print("  cand %d (%.2f,%.2f) yaw %+.3f — prove_ship red, skipped"
                  % (i, x, z, yaw), flush=True)
            continue
        t, f, r, done = ride(cid)
        verdict = "faster" if (r == 0 and done and t < base_t - 0.2) else "no"
        print("  cand %d (%6.2f,%6.2f) yaw %+.3f  run_in %+5.1f  ->  %.2f s  "
              "faults %d  rails %d  %s" % (i, x, z, yaw, run_in, t, f, r, verdict),
              flush=True)
        if r == 0 and done and t < base_t - 0.2 and (best is None or t < best[0]):
            best = (t, x, z, yaw, f)

    if best is None:
        pf.write_fence(cid, num, ox, oz, oyaw)
        print("%s #%d — nothing beat %.2f s. Put back where it was."
              % (cid, num, base_t))
        return
    t, x, z, yaw, f = best
    pf.write_fence(cid, num, x, z, yaw)
    print("%s #%d KEEP (%.2f,%.2f) yaw %+.3f  %.2f s (was %.2f)  faults %d"
          % (cid, num, x, z, yaw, t, base_t, f))


if __name__ == "__main__":
    main()
