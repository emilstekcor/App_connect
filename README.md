# App_connect

This project contains a minimal Python application with a tiny JSON-backed
database and accompanying tests.

## Project structure

- `src/` – application code.
  - `app.py` – prints a greeting and stores a persistent run count.
  - `database.py` – simple key-value store built on JSON files.
- `tests/` – unit tests using `pytest`.

## Running the application

```bash
python -m src.app
```

Each invocation stores how many times the application has run in a
`data.json` file within the current directory.

## Testing

```bash
pytest
```
