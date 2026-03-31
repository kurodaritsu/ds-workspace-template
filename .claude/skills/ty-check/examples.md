← [Back to SKILL.md](SKILL.md)

# ty Examples

## Full project check

```bash
uv run ty check
```

## Check only src/ directory

```bash
uv run ty check src/
```

## Watch mode during development

```bash
uv run ty check --watch
```

## Pre-commit check

Resolve all type errors before committing — do not leave errors unaddressed:

```bash
uv run ty check
```

## Check a specific file

```bash
uv run ty check src/utils.py
```

## Suppress a rule inline (with required explanation)

Per project rules, `# type: ignore` must always include the rule name and a reason:

```python
result = some_function()  # type: ignore[return-value]  # third-party stub is incomplete
```

Never use a bare `# type: ignore` without specifying the rule and explaining why.
