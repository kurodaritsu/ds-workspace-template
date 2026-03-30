# Package Management

Use `uv` to manage all dependencies. Never manually edit the dependency lists in `pyproject.toml`.

## Adding and removing dependencies

```bash
# Add a runtime dependency
uv add <package>

# Add a dev dependency
uv add --group dev <package>

# Remove a dependency
uv remove <package>
```

## After any change to pyproject.toml

Always resync the environment and recompile the requirements file:

```bash
uv sync
uv export --no-hashes -o requirements.txt
```
