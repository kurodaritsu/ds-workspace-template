---
name: ruff-lint
description: Run ruff linter and formatter via uv
---

# Ruff Lint & Format

## Lint (check only)

```bash
uv run ruff check .
```

## Lint and auto-fix

```bash
uv run ruff check . --fix
```

## Format

```bash
uv run ruff format .
```
