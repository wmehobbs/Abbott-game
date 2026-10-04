"""Double every numeric quota. Append QUOTA_RAISE.md."""
from __future__ import annotations

import json
from datetime import datetime, timezone
from pathlib import Path

HERE = Path(__file__).resolve().parent
Q = HERE / "MEGA_QUOTAS.json"
LOG = HERE / "QUOTA_RAISE.md"


def main() -> int:
    q = json.loads(Q.read_text(encoding="utf-8"))
    old = dict(q)
    skip = {"raise"}
    for k, v in list(q.items()):
        if k in skip:
            continue
        if isinstance(v, (int, float)) and not isinstance(v, bool):
            nv = int(v * 2) if isinstance(v, int) else float(v * 2)
            if k == "mean_score":
                nv = min(90, nv)  # score is 0–100
            if k == "material_binds":
                nv = min(24, nv)  # live MeshKit binds, not infinite
            q[k] = nv
    q["raise"] = int(q.get("raise", 0)) + 1
    Q.write_text(json.dumps(q, indent=2) + "\n", encoding="utf-8")
    now = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%SZ")
    lines = []
    if LOG.exists():
        lines = LOG.read_text(encoding="utf-8").splitlines()
    else:
        lines = ["# Mega quota raises", ""]
    lines += [f"## Raise {q['raise']} — {now}", ""]
    for k in sorted(q.keys()):
        if k == "raise":
            continue
        lines.append(f"- `{k}`: {old.get(k)} → {q[k]}")
    lines.append("")
    LOG.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print("raise", q["raise"])
    for k in ("outdoor", "michelle", "indoor", "jump_off", "harvest_plates", "proc_plates"):
        print(f"  {k} {old.get(k)} -> {q.get(k)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
