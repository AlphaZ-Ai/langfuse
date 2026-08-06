# check if .env.alphaz exists if not fail

if [ ! -f .env.alphaz ]; then
  echo ".env.alphaz file not found. Please create a .env.alphaz file based on .env.alphaz.example."
  exit 1
fi

source .env.alphaz
docker compose -f docker-compose.yml up -d langfuse-web
# langfuse-web recreates land it a new network namespace; the tailscale
# sidecar's `network_mode: service:langfuse-web` binds to that namespace at
# creation time, so it must always be recreated after langfuse-web to
# reattach (cheap: its Tailscale identity persists in ./tailscale/langfuse-prod-state).
docker compose -f docker-compose.yml up -d --force-recreate tailscale-langfuse-prod
docker compose -f docker-compose.yml build gadm-eval --no-cache
docker compose -f docker-compose.yml up gadm-eval