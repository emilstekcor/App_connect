import sys
from pathlib import Path

sys.path.append(str(Path(__file__).resolve().parents[1]))

from src.app import main


def test_main_persists_run_count(capsys, tmp_path):
    db_file = tmp_path / "db.json"

    main(db_file)
    assert capsys.readouterr().out.strip() == "Hello, world! Run #1"

    main(db_file)
    assert capsys.readouterr().out.strip() == "Hello, world! Run #2"
