# PowerShell script per stop ambiente PROD
param(
    [switch]$Volumes
)

$composeFile = Join-Path $PSScriptRoot "..\..\docker-compose.prod.yml"

if ($Volumes) {
    Write-Host "[PROD] Fermata e rimozione container e volumi..."
    docker compose -f $composeFile down -v
} else {
    Write-Host "[PROD] Fermata e rimozione container (volumi conservati)..."
    docker compose -f $composeFile down
}
