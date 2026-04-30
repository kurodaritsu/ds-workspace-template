# Linting & Formatting

Ruff is the linter and formatter for this project, configured via `ruff.toml`.

Always run linting and formatting via `uv run ruff` — never invoke `ruff` directly.

Do not disable or bypass ruff rules without explicit discussion. Auto-fix is intentionally disabled for some rules (e.g., `T201`/`T203` for `print()`); violations must be fixed manually by replacing `print()` with a `get_logger()` call. See [`.claude/rules/logging.md`](./logging.md).

## Automatic hook

The `PostToolUse` hook [`.claude/hooks/ruff_lint.sh`](../hooks/ruff_lint.sh) runs automatically after every `Write`, `Edit`, or `MultiEdit` on a `.py` file. It silently applies `ruff format` and `ruff check --fix`, then notifies if the file changed:

```
ruff: <file> was formatted/linted. Re-read the file to see the changes.
```

When you see that message, re-read the file before continuing. The hook does not raise errors — unfixable violations (e.g., manual `print()` fixes) will surface the next time you run a manual check.

## Commands

### Check for lint violations (no changes applied)

```bash
uv run ruff check .
```

### Auto-fix lint violations

```bash
uv run ruff check . --fix
```

### Format

```bash
uv run ruff format .
```

### Check or fix a specific file

```bash
uv run ruff check src/utils.py
uv run ruff check src/utils.py --fix
```

## Common flags

### `ruff check`

| Flag | Description |
|---|---|
| `--fix` | Auto-fix fixable violations |
| `--diff` | Show fixes as a diff without applying |
| `--select <rules>` | Enable specific rules |
| `--ignore <rules>` | Ignore specific rules |
| `-n`, `--no-cache` | Disable cache reads (also: `RUFF_NO_CACHE=1`) |

Avoid using `--select` or `--ignore` ad hoc — rule selection is managed in `ruff.toml`.

### `ruff format`

| Flag | Description |
|---|---|
| `--check` | Exit non-zero if files would be reformatted (CI-safe) |
| `--diff` | Show formatting changes as a diff without applying |
| `-n`, `--no-cache` | Disable cache reads (also: `RUFF_NO_CACHE=1`) |

## Examples

### Pre-commit: format then lint

```bash
uv run ruff format . && uv run ruff check .
```

### Verify format compliance (CI-safe, no changes applied)

```bash
uv run ruff format . --check
```

### Preview lint fixes without applying

```bash
uv run ruff check . --diff
```
