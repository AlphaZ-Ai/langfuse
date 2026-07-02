FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends git && rm -rf /var/lib/apt/lists/*

RUN --mount=type=secret,id=github_token,mode=0444 \
    GITHUB_TOKEN="$(cat /run/secrets/github_token)" && \
    git clone --branch release --depth 1 "https://x-access-token:${GITHUB_TOKEN}@github.com/AlphaZ-Ai/gadm_eval.git" . && \
    git clone "https://x-access-token:${GITHUB_TOKEN}@github.com/AlphaZ-Ai/gadm_models.git" && \
    pip install --no-cache-dir ./gadm_models && \
    rm -rf gadm_models

RUN pip install --no-cache-dir .

EXPOSE 80

CMD ["uvicorn", "gadm_eval.remote_experiment_service:app", "--host", "0.0.0.0", "--port", "80"]
