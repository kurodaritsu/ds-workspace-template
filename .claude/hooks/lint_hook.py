import json
import subprocess
import sys

from src.utils import get_logger


def main() -> None:

    logger = get_logger(__name__)

    data = json.load(sys.stdin)
    file = data.get("tool_input", {}).get("file_path", "")

    if not file.endswith(".py"):
        sys.exit(0)

    logger.info("\n--- ruff (%s) ---", file)
    ruff_result = subprocess.run(  # noqa: S603
        ["uv", "run", "ruff", "check", file], check=False  # noqa: S607
    )

    logger.info("\n--- ty (%s) ---", file)
    ty_result = subprocess.run(  # noqa: S603
        ["uv", "run", "ty", "check", file], check=False  # noqa: S607
    )

    sys.exit(1 if ruff_result.returncode or ty_result.returncode else 0)


if __name__ == "__main__":
    main()
