from pathlib import Path

from .database import FileDatabase


def main(db_path: Path | str = "data.json") -> None:
    """Print a greeting and persist run count."""
    db = FileDatabase(db_path)
    count = db.get("count", 0) + 1
    db.set("count", count)
    print(f"Hello, world! Run #{count}")

if __name__ == "__main__":
    main()
