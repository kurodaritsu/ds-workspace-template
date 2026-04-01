#!/usr/bin/env bash

if ! cmd=$(jq -r '.tool_input.command // ""' 2>/dev/null); then
    echo "block_commands_hook: failed to parse stdin as JSON, allowing tool call" >&2
    exit 0
fi

if [[ "$cmd" == "git config"* ]]; then
    echo "Blocked: 'git config' is not permitted." >&2
    exit 2
fi

exit 0
