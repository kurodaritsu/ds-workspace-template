← [Back to SKILL.md](SKILL.md)

# Ruff Examples

## Pre-commit: lint and format

```bash
uv run ruff format . && uv run ruff check .
```

## Preview fixes without applying

```bash
uv run ruff check . --diff
```

## Fix a specific file

```bash
uv run ruff check src/utils.py --fix
```

## Verify format compliance (CI-safe)

```bash
uv run ruff format . --check
```
