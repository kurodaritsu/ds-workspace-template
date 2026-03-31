← [Back to SKILL.md](SKILL.md)

# Pytest Reference

## Filtering

| Flag | Description |
|---|---|
| `-k <expr>` | Run tests matching a keyword expression (e.g., `-k "load or parse"`) |
| `-m <marker>` | Run tests with a specific marker (e.g., `-m "slow"`) |
| `--collect-only` | List tests without running them |

## Output

| Flag | Description |
|---|---|
| `-v` | Verbose — show each test name |
| `-q` | Quiet — minimal output |
| `-s` | Disable output capture — useful for logger output or third-party libraries (avoid `print()` per project logging rules) |
| `--tb=short\|long\|no` | Traceback style on failure |

## Failure Behavior

| Flag | Description |
|---|---|
| `-x` | Stop after first failure |
| `--lf` | Re-run only tests that failed last time |
| `--ff` | Run failed tests first, then the rest |

## Coverage

> Requires `pytest-cov` — install with `uv add --group dev pytest-cov`.

| Flag | Description |
|---|---|
| `--cov <path>` | Measure coverage for the given path (e.g., `--cov src/`) |
| `--cov-report=term-missing` | Show which lines are not covered |
| `--cov-fail-under=N` | Fail if coverage drops below N% |

## Project Configuration

Test settings are configured in `pyproject.toml` under `[tool.pytest.ini_options]`.

## See Also

- [pytest docs](https://docs.pytest.org/en/stable/reference/reference.html)
- [pytest-cov docs](https://pytest-cov.readthedocs.io/en/latest/)
