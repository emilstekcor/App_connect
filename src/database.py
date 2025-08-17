from __future__ import annotations

import json
from pathlib import Path
from typing import Any, Dict

class FileDatabase:
    """A tiny JSON-backed key-value store."""

    def __init__(self, path: Path | str) -> None:
        self.path = Path(path)
        if self.path.exists():
            with self.path.open('r', encoding='utf-8') as fh:
                self._data: Dict[str, Any] = json.load(fh)
        else:
            self._data = {}

    def get(self, key: str, default: Any = None) -> Any:
        """Return a value for *key* or *default* if missing."""
        return self._data.get(key, default)

    def set(self, key: str, value: Any) -> None:
        """Persist *value* under *key*."""
        self._data[key] = value
        self._write()

    def _write(self) -> None:
        self.path.parent.mkdir(parents=True, exist_ok=True)
        with self.path.open('w', encoding='utf-8') as fh:
            json.dump(self._data, fh)
