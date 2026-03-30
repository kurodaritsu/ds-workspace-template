# Linting & Formatting

Ruff is the linter and formatter for this project. It is configured via `ruff.toml`.

Always run linting and formatting via `uv run ruff` — never invoke `ruff` directly. See `.claude/skills/ruff-lint` for the exact commands.

Do not disable or bypass ruff rules without explicit discussion. Auto-fix is intentionally disabled for some rules (e.g., `T201`/`T203` for `print()`).
