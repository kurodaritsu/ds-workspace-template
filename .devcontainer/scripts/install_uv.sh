curl -LsSf https://astral.sh/uv/0.11.6/install.sh | bash

echo 'eval "$(uv generate-shell-completion bash)"' >> ~/.bashrc

uv sync
