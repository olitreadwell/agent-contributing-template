# Go notes

- **Modules**: `go.mod` at the repo root defines the module path. Respect it.
- **Formatting**: `gofmt` (or `go fmt`) is mandatory; `goimports` where the
  repo uses it.
- **Vet and lint**: `go vet` plus the repo's linter (staticcheck or similar).
- **Tests**: `_test.go` files next to source, `go test ./...`; table-driven
  tests preferred. Name helper cases descriptively.
- **Naming**: exported identifiers are `PascalCase`, unexported `camelCase`,
  files `snake_case`.
- **Errors**: explicit `error` returns; no panics for recoverable failures.
- **Dependencies**: `go.sum` committed; `go get` with a pinned version only.

## Common traps for agents

- Formatting drift: run `gofmt` before committing.
- Adding global state to a package that is otherwise pure.
- `go mod tidy` changes the whole graph; do it deliberately, not as a reflex.
