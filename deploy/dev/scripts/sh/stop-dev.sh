#!/bin/sh
# Script di stop ambiente DEV
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
COMPOSE_FILE="$SCRIPT_DIR/../../dev/docker-compose.dev.yml"

if [ "$1" = "--volumes" ]; then
  echo "[DEV] Fermata e rimozione container e volumi..."
  docker compose -f "$COMPOSE_FILE" down -v
else
  echo "[DEV] Fermata e rimozione container (volumi conservati)..."
  docker compose -f "$COMPOSE_FILE" down
fi
