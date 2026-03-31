← [Back to SKILL.md](SKILL.md)

# Pytest Examples

## Pre-commit: run all tests

```bash
uv run pytest
```

## Debug a failure

Stop on first failure, show print output, full traceback:

```bash
uv run pytest -x -s --tb=long tests/test_utils.py
```

## Re-run only last failures

```bash
uv run pytest --lf
```

## Check coverage for src/

```bash
uv run pytest --cov src/ --cov-report=term-missing
```

## Run tests matching a pattern

```bash
uv run pytest -k "test_load or test_parse"
```
