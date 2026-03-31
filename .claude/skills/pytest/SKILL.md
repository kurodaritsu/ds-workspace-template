---
name: pytest
description: Run pytest test suite via uv
---

# Pytest

## Run all tests

```bash
uv run pytest
```

## Run a specific test file

```bash
uv run pytest tests/<file>
```

## Filter tests by name

```bash
uv run pytest -k <test_name>
```

## Verbose output

```bash
uv run pytest -v
```

## Run with coverage

```bash
uv run pytest --cov
```
