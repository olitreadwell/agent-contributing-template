# Ruby notes

- **Dependencies**: Bundler. `Gemfile` + `Gemfile.lock`; install with
  `bundle install`.
- **Formatting and lint**: the repo's tooling (RuboCop is common; match its
  config).
- **Tests**: RSpec or Minitest per the repo; run the targeted spec then the
  suite.
- **Naming**: `snake_case` methods and files, `PascalCase` classes/constants.
- **Style**: the repo's conventions rule. Common expectations: frozen string
  literals where configured, no `eval`/`send` magic unless deliberate.

## Common traps for agents

- `bundle exec` vs bare commands: use the repo's documented invocation.
- Editing `Gemfile.lock` by hand.
- Adding a gem when plain Ruby is enough.
