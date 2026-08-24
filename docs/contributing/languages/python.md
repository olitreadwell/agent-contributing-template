# Python notes

Exact commands come from the repository's own config (`pyproject.toml`,
`requirements*.txt`, `setup.py`/`setup.cfg`). Match what is there.

- **Environment**: the repo pins its tooling (uv, Poetry, pip + venv, pipenv).
  Never install into a different environment than the one configured.
- **Quality gates**: run the repo's lint, format, type checker, and tests.
  Typical set: ruff or flake8, black or ruff format, mypy or pyright, pytest.
- **Tests**: `test_*.py` files, pytest fixtures, one test file per module.
  Run the targeted test first, then the suite.
- **Naming**: `snake_case` functions and variables, `UPPER_SNAKE_CASE`
  constants, `PascalCase` classes.
- **Type hints**: annotate public functions. No bare `except:`; catch
  specific exceptions.

## Common traps for agents

- Mutable default arguments, `datetime.now()` used where UTC is implied,
  silent `pass` on errors.
- Importing from `__init__.py` when the module path is the convention.
- Creating a new lockfile format when the repo has one already.
