# check if .env.debug exists if not fail

if [ ! -f .env.debug ]; then
  echo ".env.debug file not found. Please create a .env.debug file based on .env.debug.example."
  exit 1
fi

source .env.debug
docker compose -f docker-compose-debug.yml up -d langfuse-web
# langfuse-web recreates land it a new network namespace; the tailscale
# sidecar's `network_mode: service:langfuse-web` binds to that namespace at
# creation time, so it must always be recreated after langfuse-web to
# reattach (cheap: its Tailscale identity persists in ./tailscale/langfuse-debug-state).
docker compose -f docker-compose-debug.yml up -d --force-recreate tailscale-langfuse-debug
docker compose -f docker-compose-debug.yml up --build -d gadm-eval
docker compose -f docker-compose-debug.yml up --build -d gadm-webui