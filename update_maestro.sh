#!/usr/bin/env bash
# Start (or update) the maestro-bench Langfuse stack. .env.maestro is optional;
# see .env.maestro.example for what it can override.
set -euo pipefail
cd "$(dirname "$0")"

if [ -f .env.maestro ]; then
  set -a
  # shellcheck disable=SC1091
  source .env.maestro
  set +a
fi

docker compose -f docker-compose-maestro.yml up -d
