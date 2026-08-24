# Language-specific notes

Pages here are optional. `scripts/copy.sh --detect` copies only the pages that
match the target repository's stack, detected from manifest files. The generic
guide never assumes a language; these pages fill in the stack-specific detail.

## Supported languages

| Page | Detected from |
| --- | --- |
| `typescript.md` | `package.json` |
| `python.md` | `pyproject.toml`, `requirements*.txt`, `setup.py` |
| `go.md` | `go.mod` |
| `rust.md` | `Cargo.toml` |
| `java.md` | `pom.xml`, `build.gradle`, `build.gradle.kts` |
| `php.md` | `composer.json` |
| `ruby.md` | `Gemfile` |
| `csharp.md` | `*.csproj`, `*.sln` |

## Adding a language

1. Create `<language>.md` here with the same shape as the others: manifests,
   quality gates, tests, naming, common traps.
2. Add a row to the table above.
3. Add the manifest check to `scripts/copy.sh` in `detect_languages`.

Keep pages generic. Exact commands belong to the repo; the page names the
convention and tells the reader to check the repo's own config.
