# check if .env exists if not fail

if [ ! -f .env ]; then
  echo ".env file not found. Please create a .env file based on .env.example."
  exit 1
fi

source .env
docker compose -f docker-compose.yml build gadm-eval --no-cache
docker compose -f docker-compose.yml up gadm-eval