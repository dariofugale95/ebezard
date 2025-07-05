#!/bin/sh
# Script di stop ambiente PROD
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
COMPOSE_FILE="$SCRIPT_DIR/../../prod/docker-compose.prod.yml"

if [ "$1" = "--volumes" ]; then
  echo "[PROD] Fermata e rimozione container e volumi..."
  docker compose -f "$COMPOSE_FILE" down -v
else
  echo "[PROD] Fermata e rimozione container (volumi conservati)..."
  docker compose -f "$COMPOSE_FILE" down
fi
