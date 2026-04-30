#!/usr/bin/env bash

if ! file=$(jq -r '.tool_input.file_path // ""' 2>/dev/null); then
    echo "ty: failed to parse stdin as JSON, skipping" >&2
    exit 0
fi

if [[ -z "$file" ]] || [[ "$file" != *.py ]]; then
    exit 0
fi

echo "--- ty check ($file) ---"
uv run ty check "$file"
