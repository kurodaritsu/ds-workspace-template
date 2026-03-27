# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`ds-container-workspace` is a data science Python workspace template using Python 3.13. It uses **uv** for package management, **ruff** for linting and formatting, **ty** for type checking, and **pytest** for testing.

## Package Management

Add and remove dependencies using `uv`, then resync the environment after any change to `pyproject.toml`.

```bash
# Add a runtime dependency
uv add <package>

# Add a dev dependency
uv add --group dev <package>

# Remove a dependency
uv remove <package>

# After any change to pyproject.toml, resync and recompile
uv sync
uv export --no-hashes -o requirements.txt
```

## Linting & Formatting

Ruff is configured via `ruff.toml`. Run it directly with `uv run`.

```bash
# Lint
uv run ruff check .

# Lint and auto-fix
uv run ruff check . --fix

# Format
uv run ruff format .
```

## Logging

Never use `print()` in `src/` or `scripts/`. Ruff will flag it as an error (`T201`/`T203`) and auto-fix is disabled — you must replace it with a logger call.

Use the shared `get_logger` utility:

```python
from src.utils import get_logger

logger = get_logger(__name__)

logger.debug("Detailed step: %s", value)
logger.info("Starting analysis for %s", dataset_name)
logger.warning("Missing values detected: %d rows affected", count)
logger.error("Failed to load file: %s", path)
```

The default level is `INFO`. To change it for a specific logger:

```python
import logging
logger = get_logger(__name__, level=logging.DEBUG)
```

`get_logger` works in both scripts and Jupyter notebooks — it auto-detects the kernel context and avoids duplicate output.

## Type Checking

ty is Astral's type checker, configured via `pyproject.toml`.

```bash
uv run ty check
```

## Testing

```bash
# Run all tests
uv run pytest

# Run a specific test file
uv run pytest tests/<file>

# Filter tests by name
uv run pytest -k <test_name>

# Verbose output
uv run pytest -v

# Run with coverage
uv run pytest --cov
```

## Project Structure

| Directory | Purpose |
|---|---|
| `data/` | Raw and processed datasets |
| `notebooks/` | Jupyter notebooks for exploration and analysis |
| `src/` | Application source code |
| `scripts/` | Utility and automation scripts |
| `tests/` | Pytest test files |

## Git Workflow

The `main` branch is protected. All commits must be made on a feature branch or in a separate worktree. Never commit directly to `main`.
