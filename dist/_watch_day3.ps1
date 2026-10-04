# Wake only for a Godot window, a ride that never prints a round, or the pair exiting.
$log = Join-Path (Get-Location) "dist\ridecert_godot.log"
$deadline = (Get-Date).AddSeconds(120)
$startBy = (Get-Date).AddSeconds(90)
$seen = $false
$round = $false
while ($true) {
    $procs = @(Get-Process -Name "Godot_v4.7.2-stable_win64", "Godot_v4.7.2-stable_win64_console" -ErrorAction SilentlyContinue)
    if ($procs.Count -gt 0) { $seen = $true }
    foreach ($p in $procs) {
        if ($p.MainWindowHandle -ne 0) {
            Write-Output "WINDOW $($p.ProcessName) pid=$($p.Id) hwnd=$($p.MainWindowHandle) title=$($p.MainWindowTitle)"
            exit 1
        }
    }
    if (-not $round -and (Test-Path $log)) {
        $hit = Select-String -Path $log -Pattern "RIDECERT round" -SimpleMatch -Quiet -ErrorAction SilentlyContinue
        if ($hit) { $round = $true }
    }
    if ($seen -and -not $round -and (Get-Date) -gt $deadline) {
        Write-Output "FAILED no RIDECERT round"
        exit 1
    }
    if ($seen -and $procs.Count -eq 0) {
        Write-Output "DONE"
        exit 0
    }
    if (-not $seen -and (Get-Date) -gt $startBy) {
        Write-Output "FAILED never started"
        exit 1
    }
    Start-Sleep -Seconds 10
}
