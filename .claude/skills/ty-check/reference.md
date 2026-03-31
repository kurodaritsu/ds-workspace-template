← [Back to SKILL.md](SKILL.md)

# ty Reference

## Scope

| Option | Description |
|---|---|
| `<path>` | Check a specific directory or file (e.g., `uv run ty check src/`) |
| `--watch`, `-W` | Watch files for changes and recheck on save |

## Configuration Overrides

| Flag | Description |
|---|---|
| `--python-version <version>` | Override the target Python version (e.g., `--python-version 3.13`). Prefer setting `python-version` in `[tool.ty]` in `pyproject.toml` instead. |

## Output

| Flag | Description |
|---|---|
| `--output-format <fmt>` | Diagnostic format: `full`, `concise`, `github`, `gitlab`, `junit` |
| `--quiet`, `-q` | Suppress non-error output |
| `--verbose`, `-v` | Show additional diagnostic detail |

## Diagnostic Severity

| Flag | Description |
|---|---|
| `--ignore <rule>` | Suppress a specific rule |
| `--error <rule>` | Treat a rule as an error |
| `--warn <rule>` | Treat a rule as a warning |

## Project Configuration

Set `python-version` in `[tool.ty]` in `pyproject.toml` rather than passing `--python-version` on every invocation.

## See Also

- [ty docs](https://docs.astral.sh/ty/)
