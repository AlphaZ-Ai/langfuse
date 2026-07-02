# check if .env.alphaz exists if not fail

if [ ! -f .env.alphaz ]; then
  echo ".env.alphaz file not found. Please create a .env.alphaz file based on .env.alphaz.example."
  exit 1
fi

source .env.alphaz
docker compose -f docker-compose.yml build gadm-eval --no-cache
docker compose -f docker-compose.yml up gadm-eval