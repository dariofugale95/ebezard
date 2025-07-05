#!/bin/sh
# Script di avvio sicuro ambiente PROD
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
COMPOSE_FILE="$SCRIPT_DIR/../../prod/docker-compose.prod.yml"

echo "[PROD] Build e avvio nuovi container..."
docker compose -f "$COMPOSE_FILE" up -d --build

echo "[PROD] Stato dei container:"
docker compose -f "$COMPOSE_FILE" ps

echo "[PROD] Log (ctrl+C per interrompere):"
docker compose -f "$COMPOSE_FILE" logs -f
