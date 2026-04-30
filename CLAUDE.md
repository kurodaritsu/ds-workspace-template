# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`ds-workspace-template` is a Python project workspace template that is used as its base contents for other Python projects. It uses **uv** for package management, **ruff** for linting and formatting, **ty** for type checking, and **pytest** for testing.

## Project Structure

| Hidden Directory | Purpose |
|---|---|
| `.claude/hooks/` | Shell hooks triggered by Claude Code events |
| `.claude/rules/` | Behavioral rules loaded automatically by Claude Code |
| `.devcontainer/` | Dev container configuration (Dockerfile, docker-compose) |
| `.github/` | GitHub Actions workflows, Dependabot, and CODEOWNERS |
| `.vscode/` | VS Code workspace settings and recommended extensions |
| `.worktrees/` | Git worktrees for isolated feature branches |

| Directory | Purpose |
|---|---|
| `app/` | Application entry points and runtime configuration |
| `data/` | Raw and processed datasets |
| `docs/` | Project documentation |
| `models/` | Trained model artifacts and serialized outputs |
| `notebooks/` | Jupyter notebooks for exploration and analysis |
| `scripts/` | Utility and automation scripts |
| `src/` | Application source code |
| `tests/` | Pytest test files |

## Rules & Skills

Behavioral guidance lives in `.claude/rules/`:

- [`package-management.md`](.claude/rules/package-management.md) — uv dependency management
- [`lint-and-format.md`](.claude/rules/lint-and-format.md) — ruff linting and formatting policy
- [`logging.md`](.claude/rules/logging.md) — use `get_logger`, never `print()`
- [`type-checking.md`](.claude/rules/type-checking.md) — ty type checker policy
- [`git-workflow.md`](.claude/rules/git-workflow.md) — feature branches, protected main
