# PowerShell script per avvio sicuro ambiente DEV
$composeFile = Join-Path $PSScriptRoot "..\..\docker-compose.dev.yml"
Write-Host "[DEV] Build e avvio nuovi container..."
docker compose -f $composeFile up -d --build

Write-Host "[DEV] Stato dei container:"
docker compose -f $composeFile ps

Write-Host "[DEV] Log (ctrl+C per interrompere):"
docker compose -f $composeFile logs -f
