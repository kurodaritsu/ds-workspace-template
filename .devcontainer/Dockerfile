ARG UV_VERSION=0.6.12
ARG DEBIAN_VERSION=bookworm


FROM ghcr.io/astral-sh/uv:$UV_VERSION AS uv
ENV UV_COMPILE_BYTECODE=1

FROM mcr.microsoft.com/vscode/devcontainers/base:$DEBIAN_VERSION


RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libgl1 libglib2.0-0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=uv --chown=vscode: /uv /uvx /bin/
