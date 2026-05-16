FROM debian:12

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    && python3 -m venv /venv \
    && /venv/bin/pip install --no-cache-dir flask

WORKDIR /app

ENV PATH="/venv/bin:$PATH"
RUN python3 -m pip install --no-cache-dir flask

COPY tools/ /app/tools/

WORKDIR /app/tools

EXPOSE 8000

CMD ["python3", "app.py"]