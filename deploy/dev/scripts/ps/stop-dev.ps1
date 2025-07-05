# PowerShell script per stop ambiente DEV
param(
    [switch]$Volumes
)

$composeFile = Join-Path $PSScriptRoot "..\..\docker-compose.dev.yml"

if ($Volumes) {
    Write-Host "[DEV] Fermata e rimozione container e volumi..."
    docker compose -f $composeFile down -v
} else {
    Write-Host "[DEV] Fermata e rimozione container (volumi conservati)..."
    docker compose -f $composeFile down
}
