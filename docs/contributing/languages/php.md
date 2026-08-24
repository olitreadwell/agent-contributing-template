# PHP notes

- **Dependencies**: Composer. `composer.json` + `composer.lock`; install with
  `composer install` (lockfile-respecting).
- **Formatting and lint**: the repo's configured tooling (php-cs-fixer or
  pint for style, PHPStan or Psalm for static analysis).
- **Tests**: PHPUnit under `tests/`; run the targeted test file first.
- **Naming**: PSR conventions; `camelCase` methods, `PascalCase` classes.
- **Modern practice**: strict types where the repo declares them, typed
  properties, no deprecated functions.

## Common traps for agents

- Uncommitted `vendor/` changes or a modified lockfile after install.
- Mixing two style tools.
- Adding `@var` annotations where real type hints should be added instead.
