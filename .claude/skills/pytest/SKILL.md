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
uv run pytest tests/test_utils.py
```

## Filter tests by name

```bash
uv run pytest -k <test_name>
```

## Additional resources

- For common scenarios, see [examples.md](examples.md)
- For full flag reference, see [reference.md](reference.md)
