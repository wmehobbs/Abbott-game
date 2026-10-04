# Wake only if a Godot window appears, the ride never starts, or the pair exits.
$deadline = (Get-Date).AddSeconds(90)
$seen = $false
while ($true) {
    $procs = @(Get-Process -Name "Godot_v4.7.2-stable_win64", "Godot_v4.7.2-stable_win64_console" -ErrorAction SilentlyContinue)
    if ($procs.Count -gt 0) { $seen = $true }
    foreach ($p in $procs) {
        if ($p.MainWindowHandle -ne 0) {
            Write-Output "WINDOW $($p.ProcessName) pid=$($p.Id) hwnd=$($p.MainWindowHandle) title=$($p.MainWindowTitle)"
            exit 1
        }
    }
    if ($seen -and $procs.Count -eq 0) {
        Write-Output "DONE"
        exit 0
    }
    if (-not $seen -and (Get-Date) -gt $deadline) {
        Write-Output "FAILED never started"
        exit 1
    }
    Start-Sleep -Seconds 15
}
