← [Back to SKILL.md](SKILL.md)

# Ruff Reference

## Check Flags

| Flag | Description |
|---|---|
| `--fix` | Auto-fix fixable violations |
| `--diff` | Show fixes as a diff without applying them |
| `--select <rules>` | Enable specific rules (e.g., `--select E,W`) |
| `--ignore <rules>` | Ignore specific rules (e.g., `--ignore E501`) |

> Avoid using `--select` or `--ignore` ad hoc — rule selection is managed in `ruff.toml`. See `.claude/rules/lint-and-format.md`.

## Format Flags

| Flag | Description |
|---|---|
| `--check` | Exit with a non-zero code if files would be reformatted (CI-safe) |
| `--diff` | Show formatting changes as a diff without applying them |

## Project Configuration

Config lives in `ruff.toml`. Notable project setting: `T201`/`T203` (`print()`) are flagged as errors with **auto-fix disabled** — violations must be fixed manually by replacing `print()` with a `get_logger()` call. See `.claude/rules/logging.md`.

## See Also

- [ruff docs](https://docs.astral.sh/ruff/)
