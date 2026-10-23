# Build and run the Policy Code Trainer with wslc (WSL 2.9.3 or later).
# Usage:  .\start.ps1            build + run on http://localhost:8080
#         .\start.ps1 -Port 9090 use another port
#         .\start.ps1 -Stop      stop the container
param(
  [int]$Port = 8080,
  [switch]$Stop
)

$name  = "policy-trainer"
$image = "policy-code-trainer"

if ($Stop) {
  wslc container stop $name
  return
}

Set-Location $PSScriptRoot

# Stop an older copy if one is still running (ignore errors if not)
wslc container stop $name 2>$null | Out-Null

wslc build -t $image .
if ($LASTEXITCODE -ne 0) { Write-Error "Build failed."; exit 1 }

wslc run -d --rm -p "${Port}:80" --name $name $image
if ($LASTEXITCODE -ne 0) { Write-Error "Run failed. Is port $Port already in use?"; exit 1 }

Write-Host "Policy Code Trainer is running at http://localhost:$Port"
Start-Process "http://localhost:$Port"
