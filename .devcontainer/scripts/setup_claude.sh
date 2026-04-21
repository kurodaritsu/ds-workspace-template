curl -fsSL https://claude.ai/install.sh | bash

if [ -d /tmp/.claude-host ]; then
    mkdir -p /home/vscode/.claude

    for dir in hooks rules skills; do
        [ -d "/tmp/.claude-host/$dir" ] && sudo cp -r "/tmp/.claude-host/$dir" "/home/vscode/.claude/"
    done

    for file in CLAUDE.md settings.json .credentials.json; do
        [ -f "/tmp/.claude-host/$file" ] && sudo cp "/tmp/.claude-host/$file" "/home/vscode/.claude/"
    done

    sudo chown -R vscode:vscode /home/vscode/.claude
fi
