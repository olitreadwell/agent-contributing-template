# Shell / Bash notes

Exact commands come from the repository's own scripts and config. Match what
is there.

- **Shebang**: every executable script declares its interpreter
  (`#!/usr/bin/env bash`) and is executable.
- **Strict mode**: the repo's scripts set `set -euo pipefail` where they do;
  match that style rather than introducing a different error-handling model.
- **Lint**: run `shellcheck` on changed scripts when the repo uses it.
- **Tests**: use the repo's test harness (`bats` or similar) when one exists;
  otherwise keep functions testable by keeping them small and pure.
- **Naming**: `snake_case` functions and variables, constants
  `UPPER_SNAKE_CASE`, scripts named for their purpose.
- **Quoting**: quote all expansions; unquoted `$VAR` is a bug unless
  deliberate. Prefer `"$@"` for arguments.
- **Portability**: stay within the declared shell; no bashisms in `sh`
  scripts. Prefer `${VAR:-default}` over `VAR=... || true` tricks.

## Common traps for agents

- Pipefail surprises: a pipeline that ignores a failing upstream command.
- `rm -rf` with variables that can be empty; guard every destructive
  command.
- Editing a script's behavior without updating its `--help` or docs.
- Inheriting the caller's `IFS`/glob state; set what the script needs.
