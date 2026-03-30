# Logging

Never use `print()` in `src/` or `scripts/`. Ruff will flag it as an error (`T201`/`T203`) and auto-fix is disabled — you must replace it with a logger call.

Use the shared `get_logger` utility:

```python
from src.utils import get_logger

logger = get_logger(__name__)

logger.debug("Detailed step: %s", value)
logger.info("Starting analysis for %s", dataset_name)
logger.warning("Missing values detected: %d rows affected", count)
logger.error("Failed to load file: %s", path)
```

The default log level is `INFO`. To override for a specific logger:

```python
import logging
logger = get_logger(__name__, level=logging.DEBUG)
```

`get_logger` auto-detects the Jupyter kernel context and avoids duplicate output in notebooks.
