#!/bin/sh
# Script di avvio sicuro ambiente DEV
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
COMPOSE_FILE="$SCRIPT_DIR/../../dev/docker-compose.dev.yml"

echo "[DEV] Build e avvio nuovi container..."
docker compose -f "$COMPOSE_FILE" up -d --build

echo "[DEV] Stato dei container:"
docker compose -f "$COMPOSE_FILE" ps

echo "[DEV] Log (ctrl+C per interrompere):"
docker compose -f "$COMPOSE_FILE" logs -f
