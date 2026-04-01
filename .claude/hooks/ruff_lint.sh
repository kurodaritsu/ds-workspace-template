#!/usr/bin/env bash

# Cap diff output to avoid flooding Claude's context window on large files
DIFF_CAP=50

cap_diff() {
    local diff_output="$1"
    local line_count
    line_count=$(printf '%s' "$diff_output" | wc -l)
    if [[ "$line_count" -gt "$DIFF_CAP" ]]; then
        printf '%s' "$diff_output" | head -n "$DIFF_CAP"
        echo "... (truncated, $line_count lines total)"
    else
        printf '%s' "$diff_output"
    fi
}

if ! file=$(jq -r '.tool_input.file_path // ""' 2>/dev/null); then
    echo "ruff_lint: failed to parse stdin as JSON, skipping" >&2
    exit 0
fi

if [[ -z "$file" ]] || [[ "$file" != *.py ]]; then
    exit 0
fi

# Step 1: Show formatting diff
format_diff=$(uv run ruff format --diff "$file" 2>&1)
if [[ -n "$format_diff" ]]; then
    echo "--- ruff format: changes to apply ($file) ---"
    cap_diff "$format_diff"
fi

# Step 2: Apply formatting
uv run ruff format "$file" > /dev/null

# Step 3: Show lint fix diff
lint_diff=$(uv run ruff check --diff "$file" 2>&1)
if [[ -n "$lint_diff" ]]; then
    echo "--- ruff check: fixes to apply ($file) ---"
    cap_diff "$lint_diff"
fi

# Step 4: Apply lint fixes
uv run ruff check --fix "$file" > /dev/null

# Step 5: Final check
final_output=$(uv run ruff check "$file" 2>&1)
final_exit=$?
if [[ -n "$final_output" ]]; then
    echo "--- ruff check: final ($file) ---"
    echo "$final_output"
fi
exit $final_exit
