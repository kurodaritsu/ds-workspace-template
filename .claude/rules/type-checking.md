# Type Checking

ty is the type checker for this project, configured via `pyproject.toml`.

Run type checks via `uv run ty check`. See `.claude/skills/ty-check` for the exact command.

Address type errors before committing. Do not use `# type: ignore` without a comment explaining why.

## Scope of ty vs ruff

`ty` checks for type *correctness* — it verifies that annotated types are used consistently. It does **not** enforce that functions are annotated in the first place.

Missing type annotations (e.g., unannotated function arguments or return types) are caught by **ruff** via the `ANN` rules (`ANN001`, `ANN201`, etc.). Use `uv run ruff check` to surface those — do not expect `ty` to flag them.
