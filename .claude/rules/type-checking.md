# Type Checking

ty is the type checker for this project, configured via `pyproject.toml`.

Address type errors before committing. Do not use `# type: ignore` without specifying the rule and a reason explaining why:

```python
result = some_function()  # type: ignore[return-value]  # third-party stub is incomplete
```

Never use a bare `# type: ignore` without the rule name and explanation.

## Scope of ty vs ruff

`ty` checks for type *correctness* — it verifies that annotated types are used consistently. It does **not** enforce that functions are annotated in the first place.

Missing type annotations (e.g., unannotated function arguments or return types) are caught by **ruff** via the `ANN` rules (`ANN001`, `ANN201`, etc.). Use `uv run ruff check` to surface those — do not expect `ty` to flag them.

## Commands

### Check entire project

```bash
uv run ty check
```

### Check a specific directory

```bash
uv run ty check src/
```

### Check a specific file

```bash
uv run ty check src/utils.py
```

## Flags

### Scope

| Option | Description |
|---|---|
| `<path>` | Check a specific directory or file |
| `--watch`, `-W` | Watch files for changes and recheck on save |

### Output

| Flag | Description |
|---|---|
| `--output-format <fmt>` | Diagnostic format: `full`, `concise`, `github`, `gitlab`, `junit` |
| `--quiet`, `-q` | Suppress non-error output |
| `--verbose`, `-v` | Show additional diagnostic detail |

### Diagnostic severity

| Flag | Description |
|---|---|
| `--ignore <rule>` | Suppress a specific rule |
| `--error <rule>` | Treat a rule as an error |
| `--warn <rule>` | Treat a rule as a warning |

### Configuration overrides

| Flag | Description |
|---|---|
| `--python-version <version>` | Override the target Python version (e.g., `--python-version 3.13`) |

Prefer setting `python-version` in `[tool.ty]` in `pyproject.toml` over passing it on every invocation.

## Examples

### Watch mode during development

```bash
uv run ty check --watch
```

### Pre-commit check

```bash
uv run ty check
```