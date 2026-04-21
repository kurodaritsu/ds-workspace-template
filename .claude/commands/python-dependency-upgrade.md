---
name: python-dependency-upgrade
description: Workflow command scaffold for python-dependency-upgrade in ds-workspace-template.
allowed_tools: ["Bash", "Read", "Write", "Grep", "Glob"]
---

# /python-dependency-upgrade

Use this workflow when working on **python-dependency-upgrade** in `ds-workspace-template`.

## Goal

Upgrade a Python package dependency and synchronize all dependency files.

## Common Files

- `pyproject.toml`
- `requirements.txt`
- `uv.lock`

## Suggested Sequence

1. Understand the current state and failure mode before editing.
2. Make the smallest coherent change that satisfies the workflow goal.
3. Run the most relevant verification for touched files.
4. Summarize what changed and what still needs review.

## Typical Commit Signals

- Update the package version in pyproject.toml (if applicable).
- Update requirements.txt to reflect the new version.
- Regenerate uv.lock to synchronize the lockfile with the new dependency versions.

## Notes

- Treat this as a scaffold, not a hard-coded script.
- Update the command if the workflow evolves materially.