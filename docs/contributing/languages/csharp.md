# C# / .NET notes

- **Build**: `dotnet` CLI or the repo's solution (`*.sln`) and project files
  (`*.csproj`). Use `dotnet restore` with the committed lockfile where
  present.
- **Formatting and lint**: the repo's `.editorconfig` and analyzers; respect
  them, including `dotnet format` if configured.
- **Tests**: xUnit, NUnit, or MSTest per the repo; run the targeted project
  first.
- **Naming**: `PascalCase` types and methods, `camelCase` locals and
  parameters, `_camelCase` private fields where the repo does so.
- **Style**: nullable reference types where the repo enables them, no
  swallowed exceptions.

## Common traps for agents

- Restoring packages into a different SDK version than the repo pins.
- Generating new files with default namespaces instead of the repo's.
- Adding a NuGet package for a small helper.
