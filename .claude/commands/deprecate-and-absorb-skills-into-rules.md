---
name: deprecate-and-absorb-skills-into-rules
description: Workflow command scaffold for deprecate-and-absorb-skills-into-rules in ds-workspace-template.
allowed_tools: ["Bash", "Read", "Write", "Grep", "Glob"]
---

# /deprecate-and-absorb-skills-into-rules

Use this workflow when working on **deprecate-and-absorb-skills-into-rules** in `ds-workspace-template`.

## Goal

Migrates skill documentation into consolidated rule files, then removes the now-redundant skill files.

## Common Files

- `.claude/rules/lint-and-format.md`
- `.claude/rules/type-checking.md`
- `.claude/skills/ruff-lint/SKILL.md`
- `.claude/skills/ruff-lint/examples.md`
- `.claude/skills/ruff-lint/reference.md`
- `.claude/skills/ty-check/SKILL.md`

## Suggested Sequence

1. Understand the current state and failure mode before editing.
2. Make the smallest coherent change that satisfies the workflow goal.
3. Run the most relevant verification for touched files.
4. Summarize what changed and what still needs review.

## Typical Commit Signals

- Expand rule files in .claude/rules/ to absorb content from .claude/skills/ (e.g., commands, examples, references).
- Delete the now-redundant skill files from .claude/skills/.
- Update any project documentation (e.g., CLAUDE.md) to reflect the new structure.

## Notes

- Treat this as a scaffold, not a hard-coded script.
- Update the command if the workflow evolves materially.