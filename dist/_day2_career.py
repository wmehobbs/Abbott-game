"""Simulate _school_from_round for clear rounds. Does not touch the game."""

c, sc, r, t, f = 48.0, 40.0, 44.0, 38.0, 36.0
plan = (
    [("lesson", i) for i in range(1, 5)]
    + [("beginner", i) for i in range(1, 7)]
    + [("intermediate", i) for i in range(1, 7)]
    + [("advanced", i) for i in range(1, 5)]
)
print("| n | class | clear_in_class | timing | confidence | scope | rideability | feel | crossed |")
crossed = None
for n, (klass, k) in enumerate(plan, 1):
    before = t
    c += 6.0
    sc += 3.0
    r += 4.0
    t += 4.0
    f += 3.0
    sc += 1.5
    c = min(100.0, max(5.0, c))
    sc = min(100.0, max(5.0, sc))
    r = min(100.0, max(5.0, r))
    t = min(100.0, max(5.0, t))
    f = min(100.0, max(5.0, f))
    mark = ""
    if crossed is None and before < 55.0 <= t:
        crossed = n
        mark = "CROSSES 55"
    print(
        "| %d | %s | %d | %.0f | %.0f | %.1f | %.0f | %.0f | %s |"
        % (n, klass, k, t, c, sc, r, f, mark)
    )
print("crossed_on_clear", crossed)
