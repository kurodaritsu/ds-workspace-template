# Dependabot uv Sync Automation — Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add a GitHub Actions workflow that automatically updates `pyproject.toml`, `requirements.txt`, and `uv.lock` whenever Dependabot opens a pip PR, then commits the changes back to the branch.

**Architecture:** A single workflow file triggered on `pull_request` events from `dependabot[bot]`, filtered to pip ecosystem PRs. It uses `dependabot/fetch-metadata` to identify bumped packages, reads their new versions from the Dependabot-modified `requirements.txt`, runs `uv add` per package to update `pyproject.toml`, then regenerates both lockfiles and pushes a commit back using a PAT.

**Tech Stack:** GitHub Actions, `dependabot/fetch-metadata@v2`, `astral-sh/setup-uv@v5`, uv (`uv add`, `uv pip compile`, `uv sync`), bash.

---

## Prerequisites (manual, one-time)

Before running the workflow, create a `GH_PAT` repository secret:

1. Go to GitHub → your account → Settings → Developer Settings → Personal access tokens → Fine-grained tokens.
2. Create a token scoped to this repository with **Contents: Read and Write** permission.
3. Go to the repository → Settings → Secrets and variables → Actions → New repository secret.
4. Name: `GH_PAT`, Value: the token you just created.

---

### Task 1: Create the workflow file

**Files:**
- Create: `.github/workflows/dependabot-uv-sync.yml`

**Step 1: Write the workflow file**

Create `.github/workflows/dependabot-uv-sync.yml` with the following content exactly:

```yaml
name: Dependabot uv Sync

on:
  pull_request:
    types: [opened, synchronize]

permissions:
  contents: write

jobs:
  uv-sync:
    runs-on: ubuntu-latest
    if: github.actor == 'dependabot[bot]'

    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          ref: ${{ github.head_ref }}
          token: ${{ secrets.GH_PAT }}

      - name: Fetch Dependabot metadata
        id: metadata
        uses: dependabot/fetch-metadata@v2
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}

      - name: Install uv
        if: steps.metadata.outputs.package-ecosystem == 'pip'
        uses: astral-sh/setup-uv@v5
        with:
          python-version: "3.13"

      - name: Update pyproject.toml
        if: steps.metadata.outputs.package-ecosystem == 'pip'
        run: |
          DEPS="${{ steps.metadata.outputs.dependency-names }}"
          IFS=',' read -ra DEP_ARRAY <<< "$DEPS"
          for dep in "${DEP_ARRAY[@]}"; do
            dep=$(echo "$dep" | xargs)
            version=$(grep -i "^${dep}==" requirements.txt | head -1 | awk -F'==' '{print $2}')
            if [ -n "$version" ]; then
              uv add "${dep}==${version}"
            fi
          done

      - name: Regenerate lockfiles
        if: steps.metadata.outputs.package-ecosystem == 'pip'
        run: |
          uv pip compile pyproject.toml -o requirements.txt
          uv sync

      - name: Commit and push
        if: steps.metadata.outputs.package-ecosystem == 'pip'
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git add pyproject.toml requirements.txt uv.lock
          git diff --staged --quiet || git commit -m "chore: sync uv lockfiles for dependabot bump"
          git push
```

**Step 2: Verify the file is syntactically valid YAML**

Run:
```bash
python3 -c "import yaml; yaml.safe_load(open('.github/workflows/dependabot-uv-sync.yml'))" && echo "YAML valid"
```
Expected output: `YAML valid`

If it errors, check for indentation issues — YAML is whitespace-sensitive.

**Step 3: Commit**

```bash
git add .github/workflows/dependabot-uv-sync.yml
git commit -m "feat: automate uv lockfile sync on dependabot pip PRs"
```

---

### Task 2: Smoke test — verify workflow logic locally

This task validates the core shell logic (the `uv add` loop) without needing a real Dependabot PR.

**Files:**
- Read: `.github/workflows/dependabot-uv-sync.yml`
- Read: `requirements.txt`
- Read: `pyproject.toml`

**Step 1: Simulate the dependency-names input and version extraction**

Run this in the repo root (substitute a real package name from `pyproject.toml`):

```bash
DEPS="numpy"
IFS=',' read -ra DEP_ARRAY <<< "$DEPS"
for dep in "${DEP_ARRAY[@]}"; do
  dep=$(echo "$dep" | xargs)
  version=$(grep -i "^${dep}==" requirements.txt | head -1 | awk -F'==' '{print $2}')
  echo "Would run: uv add ${dep}==${version}"
done
```

Expected output (exact version will match your current `requirements.txt`):
```
Would run: uv add numpy==2.2.4
```

If `version` is empty, the package name casing in `requirements.txt` doesn't match. Check `requirements.txt` — it should be lowercase. The `grep -i` flag handles case insensitivity.

**Step 2: Simulate a grouped PR (multiple packages)**

```bash
DEPS="numpy, pandas"
IFS=',' read -ra DEP_ARRAY <<< "$DEPS"
for dep in "${DEP_ARRAY[@]}"; do
  dep=$(echo "$dep" | xargs)
  version=$(grep -i "^${dep}==" requirements.txt | head -1 | awk -F'==' '{print $2}')
  echo "Would run: uv add ${dep}==${version}"
done
```

Expected output:
```
Would run: uv add numpy==2.2.4
Would run: uv add pandas==2.2.3
```

Both packages should resolve. If any version is empty, check that the package appears directly in `requirements.txt` (e.g. `pandas==2.2.3`), not as a transitive dep comment only.

**Step 3: No commit needed** — this is a local validation only.

---

### Task 3: Integration test — trigger the workflow on a real PR

This can only be done once the workflow is pushed to `main` and Dependabot is configured to run.

**Step 1: Wait for the next Dependabot scheduled run, or trigger manually**

Dependabot runs monthly per `dependabot.yml`. To trigger immediately for testing:
- Go to the repository → Security → Dependabot → click "Check for updates" (if the button is available).
- Or wait for the next scheduled Saturday run.

**Step 2: Verify the workflow ran correctly on the Dependabot PR**

On the Dependabot pip PR, check:
1. The "Dependabot uv Sync" workflow appears in the PR's Checks tab.
2. The workflow completed successfully (green).
3. A commit authored by `github-actions[bot]` appears on the PR with message `chore: sync uv lockfiles for dependabot bump`.
4. The commit modifies `pyproject.toml`, `requirements.txt`, and `uv.lock`.
5. The versions in `pyproject.toml` match what Dependabot set in `requirements.txt`.

**Step 3: If the workflow fails**

Common failure modes:
- **`GH_PAT` secret not set** — the Checkout step will fail with a 401. Create the secret (see Prerequisites).
- **`uv add` fails** — a version Dependabot proposed doesn't exist on PyPI or conflicts with other deps. Check the workflow logs for the specific package and version.
- **`git push` rejected** — branch protection rules may block direct pushes from Actions. Check repo Settings → Branches → branch protection rules and ensure "Allow force pushes" or "Allow specified actors" includes `github-actions[bot]`.
- **`package-ecosystem` filter skips pip PRs** — verify that `steps.metadata.outputs.package-ecosystem` equals `pip` exactly (lowercase) by inspecting the workflow run logs.

---

## What Was NOT Changed

- `.github/dependabot.yml` — untouched.
- `.github/renovate.json` — untouched.
- `.github/workflows/renovate_security_fixes.yml` — untouched.
