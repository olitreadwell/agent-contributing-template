# Rust notes

- **Build**: `cargo` owns everything: build, test, fmt, clippy, docs.
- **Formatting**: `cargo fmt`; lint with `cargo clippy` (warnings treated
  seriously).
- **Tests**: `#[cfg(test)]` modules or `tests/` integration dir; `cargo test`.
- **Naming**: `snake_case` functions and variables, `PascalCase` types,
  `SCREAMING_SNAKE_CASE` constants.
- **Errors**: `Result` for recoverable failure, not `panic`/`unwrap` in
  library code.
- **Dependencies**: `Cargo.lock` committed for binaries; check the repo's
  policy for libraries.

## Common traps for agents

- `unwrap()`/`expect()` left in error paths.
- Lifetime or borrow changes that alter the public API when a smaller fix
  exists.
- Adding a dependency where a small local function is enough.
