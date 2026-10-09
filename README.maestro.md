# Langfuse for the MAESTRO benchmark

`docker-compose-maestro.yml` runs the Langfuse instance that
maestro_bench records its
scores and traces in. It is core Langfuse only (web, worker, postgres, redis,
clickhouse, minio), with images pinned for reproducibility.

## Start

```bash
./update_maestro.sh
```

This runs `docker compose -f docker-compose-maestro.yml up -d` under the
project name `maestro-bench`. Rerun it to pick up changes.

| What | Where |
|---|---|
| Langfuse UI / API | http://localhost:3100 |
| UI login | `maestro@example.com` / `maestro-bench` |
| Project API keys | public `pk-lf-maestro-bench`, secret `sk-lf-maestro-bench` |
| minio (browser-facing, used for trace exports) | http://localhost:9094 |
| minio console | http://127.0.0.1:9095 |

The org, project, keys and login are seeded on the first start of an empty
database (`LANGFUSE_INIT_*`); nothing has to be created in the UI. Put the
keys and `LANGFUSE_BASE_URL=http://localhost:3100` in maestro_bench's `.env`.

Postgres, redis and clickhouse are not published on the host, and the worker
is bound to `127.0.0.1:3130`, so this stack can run next to another Langfuse
on the same machine.

## Overrides

Copy `.env.maestro.example` to `.env.maestro` and set what you need; every
value has a default in the compose file. Change `NEXTAUTH_URL` and
`LANGFUSE_S3_BATCH_EXPORT_EXTERNAL_ENDPOINT` if the UI is opened from a
different host than the one running Docker.

## Reset

```bash
docker compose -f docker-compose-maestro.yml down -v
```

Removes the containers and the `maestro-bench_*` volumes. The next
`./update_maestro.sh` seeds a fresh project again.

## Internal dev stack

`docker-compose-debug.yml` / `update_debug.sh` is the team's development
stack and is not needed to reproduce the benchmark.
