```markdown
# ds-workspace-template Development Patterns

> Auto-generated skill from repository analysis

## Overview

This skill describes the key development patterns, coding conventions, and automation workflows used in the `ds-workspace-template` Python repository. It covers file organization, code style, dependency management, development environment configuration, CI/CD, and integration with Claude AI skills. Use this guide to contribute consistently and efficiently to the codebase.

## Coding Conventions

- **Language:** Python
- **Framework:** None detected (vanilla Python)
- **File Naming:** Use camelCase for Python files.
  - Example: `dataLoader.py`, `modelTrainer.py`
- **Import Style:** Prefer relative imports within the package.
  - Example:
    ```python
    from .utils import loadData
    ```
- **Export Style:** Use named exports (explicitly define what’s exported).
  - Example:
    ```python
    __all__ = ["loadData", "trainModel"]
    ```
- **Commit Messages:** Freeform, typically ~49 characters. No strict prefix required.
- **Configuration Files:** Use standard Python files (`pyproject.toml`, `requirements.txt`, etc.) and workspace settings.

## Workflows

### Python Dependency Upgrade
**Trigger:** When you need to update a Python package to a newer version (e.g., via Dependabot or manually).
**Command:** `/upgrade-dependency`

1. Update the package version in `pyproject.toml` (if applicable).
2. Update `requirements.txt` to reflect the new version.
3. Regenerate `uv.lock` to synchronize the lockfile with the new dependency versions.

**Example:**
```toml
# pyproject.toml
[tool.poetry.dependencies]
pandas = "^2.2.0"
```
```bash
uv pip compile
```

---

### Dependabot Single Requirements Update
**Trigger:** When a dependency tracked only in `requirements.txt` needs to be bumped.
**Command:** `/bump-dependency`

1. Update the package version directly in `requirements.txt`.

**Example:**
```
# requirements.txt
numpy==1.26.4
```

---

### Devcontainer Configuration Update
**Trigger:** When modifying the VSCode/Dev Containers setup.
**Command:** `/update-devcontainer`

1. Edit `.devcontainer/devcontainer.json` to change settings.
2. Optionally, edit `.devcontainer/Dockerfile` or `.devcontainer/docker-compose.yml` to update the base image or services.

**Example:**
```json
// .devcontainer/devcontainer.json
{
  "name": "Python Dev",
  "features": ["ghcr.io/devcontainers/features/python:3.11"]
}
```

---

### VSCode Settings Update
**Trigger:** When updating workspace settings or recommended extensions.
**Command:** `/update-vscode-settings`

1. Edit `.vscode/settings.json` to update workspace settings.
2. Optionally, edit `.vscode/extensions.json` to add/remove recommended extensions.

**Example:**
```json
// .vscode/settings.json
{
  "python.linting.enabled": true,
  "editor.formatOnSave": true
}
```

---

### Add or Update GitHub Actions Workflow
**Trigger:** When automating testing, dependency updates, or other CI tasks.
**Command:** `/update-github-actions`

1. Edit or add workflow files in `.github/workflows/` (e.g., `python-test.yml`).
2. Optionally, update `.github/dependabot.yml` or `.github/renovate.json`.

**Example:**
```yaml
# .github/workflows/python-test.yml
name: Python Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      - name: Install dependencies
        run: pip install -r requirements.txt
      - name: Run tests
        run: pytest
```

---

### Add or Update Claude Skills and Rules
**Trigger:** When improving or extending Claude AI integration, skills, or rules.
**Command:** `/update-claude-skills`

1. Add or update files in `.claude/skills/` (e.g., `SKILL.md`, `reference.md`).
2. Add or update files in `.claude/rules/` (e.g., `lint-and-format.md`).
3. Optionally, update `.claude/settings.json` or hooks in `.claude/hooks/`.

---

### Feature Implementation with Tests and Docs
**Trigger:** When adding a new feature, utility, or module.
**Command:** `/add-feature`

1. Implement the feature in `src/` (add new module or function).
2. Add or update tests in `tests/`.
3. Update configuration files as needed (`pyproject.toml`, `ruff.toml`).
4. Update documentation files (e.g., `CLAUDE.md`).

**Example:**
```python
# src/dataLoader.py
def loadData(path):
    # implementation
    pass
```
```python
# tests/dataLoader.test.py
from ..src.dataLoader import loadData

def test_loadData():
    assert loadData("sample.csv") is not None
```

## Testing Patterns

- **Framework:** Not explicitly detected; likely uses `pytest` or similar.
- **Test File Pattern:** Files named with `.test.` (e.g., `module.test.py`).
- **Test Location:** `tests/` directory.
- **Example:**
    ```python
    # tests/exampleModule.test.py
    from ..src.exampleModule import someFunction

    def test_someFunction():
        assert someFunction(2) == 4
    ```

## Commands

| Command                  | Purpose                                                      |
|--------------------------|--------------------------------------------------------------|
| /upgrade-dependency      | Upgrade a Python package and sync all dependency files       |
| /bump-dependency         | Update a single dependency in requirements.txt               |
| /update-devcontainer     | Update VSCode devcontainer configuration                     |
| /update-vscode-settings  | Update VSCode workspace settings or extensions               |
| /update-github-actions   | Add or update GitHub Actions workflow files                  |
| /update-claude-skills    | Add or update Claude AI skills, rules, or hooks             |
| /add-feature             | Implement a new feature with tests and documentation         |
```
