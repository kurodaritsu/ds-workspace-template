import logging
import sys
from collections.abc import Generator
from unittest.mock import MagicMock

import pytest

from src.utils import get_logger


@pytest.fixture(autouse=True)
def clean_loggers() -> Generator[None]:
    """Prevent handler accumulation — loggers are global singletons."""
    yield
    for name in list(logging.Logger.manager.loggerDict.keys()):
        if name.startswith("test."):
            logger = logging.getLogger(name)
            logger.handlers.clear()
            logger.propagate = True
            del logging.Logger.manager.loggerDict[name]


def test_get_logger_returns_logger_instance() -> None:
    logger = get_logger("test.basic")
    assert isinstance(logger, logging.Logger)


def test_get_logger_default_level_is_info() -> None:
    logger = get_logger("test.level")
    assert logger.level == logging.INFO


def test_get_logger_custom_level_is_respected() -> None:
    logger = get_logger("test.custom", level=logging.DEBUG)
    assert logger.level == logging.DEBUG


def test_get_logger_attaches_exactly_one_handler() -> None:
    logger = get_logger("test.handler_count")
    assert len(logger.handlers) == 1


def test_get_logger_handler_is_stream_handler() -> None:
    logger = get_logger("test.handler_type")
    assert isinstance(logger.handlers[0], logging.StreamHandler)


def test_get_logger_handler_writes_to_stderr() -> None:
    logger = get_logger("test.stderr")
    assert logger.handlers[0].stream is sys.stderr


def test_get_logger_no_duplicate_handlers_on_second_call() -> None:
    get_logger("test.dedup")
    logger = get_logger("test.dedup")
    assert len(logger.handlers) == 1


def test_get_logger_output_contains_level_name_and_logger_name(
    capsys: pytest.CaptureFixture[str],
) -> None:
    logger = get_logger("test.format")
    logger.info("hello from test")
    captured = capsys.readouterr()
    assert "INFO" in captured.err
    assert "test.format" in captured.err
    assert "hello from test" in captured.err


def test_get_logger_output_not_on_stdout(
    capsys: pytest.CaptureFixture[str],
) -> None:
    logger = get_logger("test.stdout_check")
    logger.info("should not appear on stdout")
    captured = capsys.readouterr()
    assert captured.out == ""


def test_get_logger_outside_notebook_propagates(
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    mock_ipython = MagicMock()
    mock_ipython.get_ipython.return_value = None
    monkeypatch.setattr("src.utils._logging.IPython", mock_ipython)
    logger = get_logger("test.propagate_on")
    assert logger.propagate is True


def test_get_logger_inside_notebook_disables_propagation(
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    mock_ipython = MagicMock()
    mock_ipython.get_ipython.return_value = MagicMock()  # active kernel
    monkeypatch.setattr("src.utils._logging.IPython", mock_ipython)
    logger = get_logger("test.propagate_notebook")
    assert logger.propagate is False
