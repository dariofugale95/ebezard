# PowerShell script per avvio sicuro ambiente PROD
$composeFile = Join-Path $PSScriptRoot "..\..\docker-compose.prod.yml"
Write-Host "[PROD] Build e avvio nuovi container..."
docker compose -f $composeFile up -d --build

Write-Host "[PROD] Stato dei container:"
docker compose -f $composeFile ps

Write-Host "[PROD] Log (ctrl+C per interrompere):"
docker compose -f $composeFile logs -f
