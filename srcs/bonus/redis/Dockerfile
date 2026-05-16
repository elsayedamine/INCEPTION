FROM debian:12

RUN apt-get update && apt-get install -y \
    redis-server \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 6379

CMD ["redis-server", "--protected-mode", "no", "--bind", "0.0.0.0", \
    "--maxmemory", "256mb", "--maxmemory-policy", "allkeys-lru"]