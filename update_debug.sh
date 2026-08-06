# check if .env.debug exists if not fail

if [ ! -f .env.debug ]; then
  echo ".env.debug file not found. Please create a .env.debug file based on .env.debug.example."
  exit 1
fi

source .env.debug
docker compose -f docker-compose-debug.yml up -d langfuse-web
docker compose -f docker-compose-debug.yml up --build -d gadm-eval