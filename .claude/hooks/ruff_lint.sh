#!/usr/bin/env bash

if ! file=$(jq -r '.tool_input.file_path // ""' 2>/dev/null); then
    echo "ruff: failed to parse stdin as JSON, skipping" >&2
    exit 0
fi

if [[ -z "$file" ]] || [[ "$file" != *.py ]]; then
    exit 0
fi

before=$(sha256sum "$file" 2>/dev/null)

uv run ruff format "$file" > /dev/null 2>&1
uv run ruff check --fix "$file" > /dev/null 2>&1

after=$(sha256sum "$file" 2>/dev/null)

if [[ "$before" != "$after" ]]; then
    echo "ruff: $file was formatted/linted. Re-read the file to see the changes."
fi

exit 0
