# Dependabot uv Sync Automation — Design

Date: 2026-03-03

## Problem

Dependabot's `pip` ecosystem only understands `requirements.txt`. When it bumps a dependency it edits `requirements.txt` but leaves `pyproject.toml` and `uv.lock` untouched. Because this project uses uv as its package manager, `pyproject.toml` is the source of truth for pinned versions. This forces a manual cycle on every Dependabot PR:

1. Update the version in `pyproject.toml` to match what Dependabot set in `requirements.txt`.
2. Run `uv pip compile pyproject.toml -o requirements.txt` and `uv sync` to regenerate `requirements.txt` and `uv.lock`.
3. Commit the changes back to the Dependabot branch.

## Goal

Automate that cycle entirely with a GitHub Actions workflow so Dependabot PRs are self-contained and ready to review without manual intervention.

## Approach

Keep Dependabot as-is and add a GitHub Actions workflow (`dependabot-uv-sync.yml`) that triggers on Dependabot pip PRs, updates `pyproject.toml` via `uv add`, regenerates the lockfiles, and commits the result back to the branch using a PAT.

Alternatives considered and rejected:
- **Full switch to Renovate** — Renovate has native uv support but would require significant renovate.json expansion and loss of the current Dependabot grouping behaviour.
- **Diff parsing + GITHUB_TOKEN** — fragile for grouped PRs and depends on a repo-level permissions toggle that can silently break.
- **`workflow_run` chaining** — unnecessary complexity; no advantage over Approach A for this use case.

## Workflow Design

**File:** `.github/workflows/dependabot-uv-sync.yml`

**Trigger:** `pull_request` (types: `opened`, `synchronize`)

**Conditions:**
- `github.actor == 'dependabot[bot]'` — skip all non-Dependabot PRs.
- `steps.metadata.outputs.package-ecosystem == 'pip'` — skip devcontainer Dependabot PRs.

**Permissions:** `contents: write`

**Steps:**

1. **Checkout** — `actions/checkout@v4` with `ref: github.head_ref` and the PAT (`secrets.GH_PAT`) for write access to the branch.
2. **Fetch Dependabot metadata** — `dependabot/fetch-metadata@v2` extracts `dependency-names` (newline-separated list) and `new-version`.
3. **Install uv** — `astral-sh/setup-uv@v5`.
4. **Update pyproject.toml** — Shell loop over `dependency-names`; runs `uv add <package>==<new-version>` for each. Edits `pyproject.toml` in-place and validates the version.
5. **Regenerate lockfiles** — `uv pip compile pyproject.toml -o requirements.txt` then `uv sync`.
6. **Commit and push** — Configures a bot git identity, stages `pyproject.toml`, `requirements.txt`, `uv.lock`, and commits only if there are staged changes (`git diff --staged --quiet` guard). Commit message: `chore: sync uv lockfiles for dependabot bump`.

## Impact on Existing Setup

| File | Change |
|------|--------|
| `.github/dependabot.yml` | None — Dependabot config unchanged |
| `.github/renovate.json` | None — Renovate security scanning unchanged |
| `.github/workflows/renovate_security_fixes.yml` | None |
| `.github/workflows/dependabot-uv-sync.yml` | **New file** |

**One-time manual step:** Create a `GH_PAT` repository secret — a fine-grained PAT scoped to this repo with Contents: Read and Write permission.

## Edge Cases

- **Grouped PRs** — `dependency-names` is iterated in a loop; all packages in a single Dependabot PR are handled.
- **No-op runs** — if files are unchanged after `uv add`, the commit step is skipped.
- **Devcontainer PRs** — filtered out by the `package-ecosystem` check.
- **Auto-merge** — out of scope; PRs still require manual review and merge.
- **Renovate security PRs** — unaffected; handled by the existing Renovate workflow.
