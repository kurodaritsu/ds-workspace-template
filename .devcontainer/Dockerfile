ARG UV_VERSION=0.6.12
ARG BASE_OS_VERSION=bookworm

FROM ghcr.io/astral-sh/uv:$UV_VERSION as uv
FROM mcr.microsoft.com/vscode/devcontainers/base:$BASE_OS_VERSION

COPY --from=uv --chown=vscode: /uv /uvx /bin/
