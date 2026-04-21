#!/usr/bin/env bash
# PreToolUse: enforce project tooling constraints before bash commands run.
# Exit 0 = allow, exit 2 = block (stderr shown to Claude).

input=$(cat)
command=$(echo "$input" | python3 -c "
import sys, json
d = json.load(sys.stdin)
print(d.get('tool_input', {}).get('command', ''))
" 2>/dev/null)

# Enforce uv over pip
if echo "$command" | grep -qE '(^|[;&|]\s*)(pip|pip3)\s'; then
    echo "Use 'uv run pip' or 'uv add' instead of pip directly (see .claude/rules/package-management.md)" >&2
    exit 2
fi

# Enforce podman over docker
if echo "$command" | grep -qE '(^|[;&|]\s*)docker\s'; then
    echo "Use 'podman' instead of 'docker' (project convention)" >&2
    exit 2
fi

exit 0
