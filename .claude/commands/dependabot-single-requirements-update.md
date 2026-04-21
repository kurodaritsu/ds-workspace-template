---
name: dependabot-single-requirements-update
description: Workflow command scaffold for dependabot-single-requirements-update in ds-workspace-template.
allowed_tools: ["Bash", "Read", "Write", "Grep", "Glob"]
---

# /dependabot-single-requirements-update

Use this workflow when working on **dependabot-single-requirements-update** in `ds-workspace-template`.

## Goal

Update a single Python dependency directly in requirements.txt (sometimes as a partial step in a larger upgrade).

## Common Files

- `requirements.txt`

## Suggested Sequence

1. Understand the current state and failure mode before editing.
2. Make the smallest coherent change that satisfies the workflow goal.
3. Run the most relevant verification for touched files.
4. Summarize what changed and what still needs review.

## Typical Commit Signals

- Update the package version in requirements.txt.

## Notes

- Treat this as a scaffold, not a hard-coded script.
- Update the command if the workflow evolves materially.