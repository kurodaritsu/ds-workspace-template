# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`ds-workspace-template` is a data science Python workspace template using Python 3.13. It uses **uv** for package management, **ruff** for linting and formatting, **ty** for type checking, and **pytest** for testing.

## Project Structure

| Directory | Purpose |
|---|---|
| `data/` | Raw and processed datasets |
| `notebooks/` | Jupyter notebooks for exploration and analysis |
| `src/` | Application source code |
| `scripts/` | Utility and automation scripts |
| `tests/` | Pytest test files |
| `.claude/rules/` | Behavioral rules loaded automatically by Claude Code |
| `.claude/skills/` | Invokable command skills (ruff-lint, ty-check, pytest) |

## Rules & Skills

Behavioral guidance lives in `.claude/rules/`:

- [`package-management.md`](.claude/rules/package-management.md) — uv dependency management
- [`lint-and-format.md`](.claude/rules/lint-and-format.md) — ruff linting and formatting policy
- [`logging.md`](.claude/rules/logging.md) — use `get_logger`, never `print()`
- [`type-checking.md`](.claude/rules/type-checking.md) — ty type checker policy
- [`git-workflow.md`](.claude/rules/git-workflow.md) — feature branches, protected main

Runnable command skills live in `.claude/skills/`:

- [`ruff-lint/`](.claude/skills/ruff-lint/SKILL.md) — ruff check and format commands
- [`ty-check/`](.claude/skills/ty-check.SKILL.md) — ty check command
- [`pytest/`](.claude/skills/pytest/SKILL.md) — pytest invocation patterns
