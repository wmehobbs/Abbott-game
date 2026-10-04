import subprocess
from pathlib import Path

script = r"""
Get-CimInstance Win32_Process | Where-Object { $_.Name -like 'Godot*' -or $_.Name -like 'python*' } | ForEach-Object {
  Write-Output ('PID=' + $_.ProcessId + ' NAME=' + $_.Name)
  Write-Output ('CMD=' + $_.CommandLine)
  Write-Output '---'
}
"""
out = subprocess.run(
    ["powershell", "-NoProfile", "-Command", script],
    capture_output=True,
    text=True,
    errors="replace",
)
print(out.stdout)
print(out.stderr)
day = Path(r"E:\Workspace\Madison\dist\day9")
ids = [
    "hk_les_001", "hk_les_002", "hk_les_003", "hk_les_004",
    "hk_beg_035", "hk_beg_039", "hk_beg_004", "hk_beg_034", "hk_beg_007", "hk_beg_033",
    "hk_int_001", "hk_int_002", "hk_int_005", "hk_int_006", "hk_int_007", "hk_int_009",
    "hk_adv_001", "hk_adv_002", "hk_adv_003", "hk_adv_005",
    "hk_jo_beg_001", "hk_jo_int_001", "hk_jo_adv_001",
]
for tag in ("r2", "r3"):
    missing = []
    for course_id in ids:
        path = day / f"{course_id}.{tag}.log"
        if not path.exists() or "RIDECERT done" not in path.read_text(encoding="utf-8", errors="replace"):
            missing.append(course_id)
    print(tag, "missing", missing)
save = Path(r"C:\Users\ErnieHobbs\AppData\Roaming\Godot\app_userdata\Abbott\abbott_save.json")
snap = day / "save_snapshot.json"
print("save", save.stat().st_size, "snap", snap.stat().st_size, "match", save.read_bytes() == snap.read_bytes())
