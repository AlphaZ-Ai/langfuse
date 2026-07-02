# Setup

start the docker compose project

```bash
docker compose -f docker-compose.yml up -d
```

then you need to add the following to langfuse

go to -> `Datasets` -> `Add Dataset` -> `gadm_evaluation` -> `Experiments` -> `Run experiment` -> `via Webhook` -> create new with url `http://gadm-eval/langfuse/remote-experiment`

then `Run experiment` -> `Run` -> `run`