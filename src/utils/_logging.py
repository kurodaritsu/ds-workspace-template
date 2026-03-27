"""Internal logging helpers — use get_logger() instead of print()."""

import logging
import sys

try:
    import IPython
except ImportError:
    IPython = None  # type: ignore[assignment]

_FMT = "%(levelname)s [%(asctime)s.%(msecs)03d] %(name)s - %(message)s"
_DATEFMT = "%Y-%m-%d %H:%M:%S"


def get_logger(name: str, level: int = logging.INFO) -> logging.Logger:
    """Return a named logger with a stderr StreamHandler.

    Idempotent: returns the existing logger on repeat calls.
    """
    logger = logging.getLogger(name)

    if logger.handlers:
        return logger

    handler = logging.StreamHandler(sys.stderr)
    handler.setFormatter(logging.Formatter(fmt=_FMT, datefmt=_DATEFMT))
    logger.addHandler(handler)
    logger.setLevel(level)

    if IPython is not None and IPython.get_ipython() is not None:
        logger.propagate = False

    return logger
