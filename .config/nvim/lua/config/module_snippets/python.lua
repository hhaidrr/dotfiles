local M = {}

M.logging_module = [[
import logging
import sys
from typing import ClassVar, Final
import os

__all__ = ["initialize_logger"]


_ENV_LOG_LEVEL_NAME: str | None = os.getenv("LOG_LEVEL")
_ENV_LOG_LEVEL: int | None = (
    logging.getLevelNamesMapping()[_ENV_LOG_LEVEL_NAME.upper()]
    if _ENV_LOG_LEVEL_NAME
    else None
)

_DEFAULT_LOG_LEVEL: Final[int] = logging.INFO
_DEFAULT_LOG_FORMAT: Final[str] = "%(levelname)-5s [%(name)s] %(message)s"

_LOG_LEVEL: Final[int] = _ENV_LOG_LEVEL or _DEFAULT_LOG_LEVEL


class _CustomFormatter(logging.Formatter):
    _SUBMODULE_PATH_DELIMITER: ClassVar[str] = "."
    _SUBMODULE_PATH_LIMIT: ClassVar[int] = 3

    @classmethod
    def _truncate_submodule_path(cls, path: str, limit: int) -> str:
        path = cls._SUBMODULE_PATH_DELIMITER.join(
            path.split(cls._SUBMODULE_PATH_DELIMITER)[-limit:]
        )
        return path

    def format(self, record):
        is_submodule: bool = self.__class__._SUBMODULE_PATH_DELIMITER in record.name
        if type(record.name) is str and is_submodule:
            record.name = self.__class__._truncate_submodule_path(
                record.name, self._SUBMODULE_PATH_LIMIT
            )
        return super().format(record)


def _clear_root_logger_handlers() -> None:
    root_logger = logging.getLogger()
    root_logger.handlers = []


def initialize_logger(root_module: str) -> None:
    """Initialize the application logger

    This should be called from the module you consider to be the root of your application for all other modules.

    e.g. src/project_name/__init__.py

    :param root_module: The name of your project root module.

    Invoke from the root module e.g.
    >>> initialize_logger(__name__)
    """

    _clear_root_logger_handlers()

    handler = logging.StreamHandler(sys.stderr)
    handler.setFormatter(_CustomFormatter(_DEFAULT_LOG_FORMAT))

    logger = logging.getLogger(root_module)
    logger.propagate = False
    logger.addHandler(handler)
    logger.setLevel(_LOG_LEVEL)
    logger.info(
        f"{{logger.name}} logger setup complete with level {{logging.getLevelName(_LOG_LEVEL)}}."
    )
        ]]

M.dump_service = [[
"""
Dumps/retrieves data into file system persistent format
"""

from dataclasses import dataclass
from datetime import datetime
from enum import StrEnum
from pathlib import Path
from typing import Final, Literal, Optional
import logging
import json



logger = logging.getLogger(__name__)

class _FileExtension(StrEnum):
    JSON = "json"
    TEXT = "txt"

@dataclass
class _PathElements:
    file_name: str
    folder_path: Path
    full_path: Path


class DumpService:
    _JSON_INDENT_LEVEL: Final[int] = 4
    _ROOT_FOLDER_NAME: Final[str] = "dumps" # The root folder name for the dump location.
    _ISO_FORMAT_TIME_SPEC: Final[str] = "seconds"

    def __init__(self, root_folder_path: Path, dump_file_prefix: str | None = "dump") -> None:
        self._root_folder_path = root_folder_path
        self._dump_file_prefix = dump_file_prefix

    def _resolve_file_name(
        self,
        file_type: Literal["json", "txt"],
        name_prefix: Optional[str] = None,
    ) -> str:
        if name_prefix is None:
            name_prefix = self._dump_file_prefix
        iso_timestamp: str = datetime.now().isoformat(
            timespec=self.__class__._ISO_FORMAT_TIME_SPEC
        )
        return f"{{name_prefix}}_{{iso_timestamp}}.{{file_type}}"

    def get_or_create_folder_path(self, sub_folder_name: str | None = None) -> Path:
        path: Path = self._root_folder_path / self._ROOT_FOLDER_NAME
        if sub_folder_name:
            path /= sub_folder_name
        path.mkdir(parents=True, exist_ok=True)
        logger.debug(f"Resolving folder path: {{path}}")
        return path

    def _get_or_create_path_elements(
        self,
        default_file_name: str,
        file_extension: str,
        file_name: str | None = None,
        folder_path: Path | None = None,
    ) -> _PathElements:
        file_name = file_name or default_file_name
        file_name = self._append_file_extension(file_name, file_extension)
        folder_path = folder_path or self.get_or_create_folder_path()
        full_path: Path = folder_path / file_name
        return _PathElements(file_name, folder_path, full_path)

    def _append_file_extension(self, file_name: str, file_extension: str) -> str:
        if not file_name.endswith(f".{{file_extension}}"):
            file_name += f".{{file_extension}}"
        return file_name

    def dump_to_json_file(
        self,
        content: dict,
        folder_path: Path | None = None,
        file_name: Optional[str] = None,
        name_prefix: Optional[str] = None,
    ) -> None:
        """
        Dumps the content of a model completion into a persistent dump store.
        """
        file_extension: str = _FileExtension.JSON
        default_file_name: str = self._resolve_file_name(file_extension, name_prefix)
        path_elements: _PathElements = self._get_or_create_path_elements(
            default_file_name, file_extension, file_name, folder_path
        )

        with open(path_elements.full_path, "w+", encoding="utf-8") as file:
            json.dump(content, file, indent=self._JSON_INDENT_LEVEL)
        logger.info(f"Dumping JSON into: {{path_elements.file_name}}")

    def dump_to_text_file(
        self,
        content: str,
        folder_path: Optional[Path] = None,
        file_name: Optional[str] = None,
        mode: Literal["w", "a"] = "w",
    ) -> None:
        """
        Dumps the content of a model completion into a persistent dump store.
        """
        file_extension: str = _FileExtension.TEXT
        default_file_name: str = self._resolve_file_name(file_extension)
        path_elements: _PathElements = self._get_or_create_path_elements(
            default_file_name, file_extension, file_name, folder_path
        )

        with open(path_elements.full_path, f"{{mode}}+") as file:
            file.write(content)
        logger.info(f"Dumped plaintext into: {{path_elements.file_name}}")

    def read_text_file(self, path: Path, as_binary: bool | None = False) -> str | bytes:
        """
        Reads the content of a file.
        """
        with open(path, f"r{{'b' if as_binary else ''}}") as file:
            return file.read()

    def read_json_file(self, path: Path) -> dict:
        """
        Reads the content of a file.
        """
        with open(path, "r") as file:
            return json.load(file)

    def clear_file_contents(self, path: Path) -> None:
        """
        Clears the contents of a file.
        """
        with open(path, "w") as file:
            file.write("")
]]


M.logging_local = [[
import logging

logger = logging.getLogger(__name__)
]]

M.frametrace = [[
class FrameTrace:
    """
    Captures an Exception object's traceback along with its stack frames.
    Can return this as string by calling str(FrameTrace(...))
    """

    def __init__(self, e: BaseException, message: Optional[str] = None):
        self._e = e
        self._message = message
        self._traceback = traceback.TracebackException.from_exception(self._e, capture_locals=True)

    def __str__(self) -> str:
        trace_string: str = "".join(self._traceback.format())
        if self._message:
            trace_string = f"{{self._message}}\n" + trace_string
        return trace_string
]]

M.argparse_add_argument = [[
parser.add_argument(
    "{}",
    "{}",
    type={},
    help="{}",
    required=True,
    default={},
)
]]

M.main_function = [[
def main():
    {}

if __name__ == '__main__':
    main()
]]

return M
