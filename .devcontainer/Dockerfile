ARG UV_VERSION
ARG BASE_OS_VERSION

FROM ghcr.io/astral-sh/uv:$UV_VERSION as uv
FROM mcr.microsoft.com/vscode/devcontainers/base:$BASE_OS_VERSION

COPY --from=uv --chown=vscode: /uv /uvx /bin/
