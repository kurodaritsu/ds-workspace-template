---
name: update-lint-type-check-rules-and-hooks
description: Workflow command scaffold for update-lint-type-check-rules-and-hooks in ds-workspace-template.
allowed_tools: ["Bash", "Read", "Write", "Grep", "Glob"]
---

# /update-lint-type-check-rules-and-hooks

Use this workflow when working on **update-lint-type-check-rules-and-hooks** in `ds-workspace-template`.

## Goal

Keeps linting, formatting, and type-checking rules and their corresponding automation hooks up to date for consistency and clarity.

## Common Files

- `.claude/rules/lint-and-format.md`
- `.claude/rules/type-checking.md`
- `.claude/hooks/ruff_lint.sh`
- `.claude/hooks/ty_check.sh`

## Suggested Sequence

1. Understand the current state and failure mode before editing.
2. Make the smallest coherent change that satisfies the workflow goal.
3. Run the most relevant verification for touched files.
4. Summarize what changed and what still needs review.

## Typical Commit Signals

- Modify or expand documentation in .claude/rules/ (e.g., lint-and-format.md, type-checking.md) to include new commands, flags, or guidance.
- Update corresponding automation hook scripts in .claude/hooks/ (e.g., ruff_lint.sh, ty_check.sh) to reflect new behaviors or formats.
- Ensure consistency in messaging and output between documentation and hooks.

## Notes

- Treat this as a scaffold, not a hard-coded script.
- Update the command if the workflow evolves materially.