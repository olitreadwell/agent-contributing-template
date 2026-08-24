# Agent Contributing Template

A drop-in `docs/contributing/` guide for repositories that want AI coding agents
to contribute the same way a careful human would. Language-agnostic,
agent-agnostic, and written as plain Markdown so Claude Code, Codex, Cursor,
Gemini CLI, Windsurf, and anything else that reads `AGENTS.md` can follow it.

## What you get

- `AGENTS.md` — root hook that agents read first. Points into `docs/contributing/`.
- `CONTRIBUTING.md` — the same entry point for humans.
- `docs/contributing/` — the full guide, split into focused files:
  - `00-index.md` — reading order and per-tool wiring
  - `01-principles.md` — non-negotiable rules
  - `02-workflow.md` — the agent working loop
  - `03-code-quality.md` — naming, style, dead code
  - `04-testing.md` — test layers, coverage, naming
  - `05-git-workflow.md` — branches, commits, pull requests
  - `06-security.md` — secrets, audits, input validation
  - `07-documentation.md` — docs that match code
  - `08-verification.md` — how to prove a change works
  - `09-tooling.md` — package manager, CI, environment
  - `templates/` — PR, issue, and agent checklist templates
- `scripts/copy.sh` — copies the whole tree into a target repository.

## Install into a repository

```bash
git clone https://github.com/olitreadwell/agent-contributing-template
cd agent-contributing-template
./scripts/copy.sh /path/to/target-repo
```

Or copy manually: `docs/contributing/`, `AGENTS.md`, `CONTRIBUTING.md`, and
`templates/`. The guide is self-contained: no external dependencies, no build
step, no tool-specific syntax.

`scripts/copy.sh` also replaces the `{{REPO_NAME}}` placeholder in templates
with the target repo's name.

## Design rules

- **Language-agnostic**: no stack assumptions. Rules are phrased generically
  and apply to any codebase.
- **Agent-agnostic**: plain Markdown, no tool-specific directives. Per-tool
  wiring (which file each agent reads) is documented in `00-index.md`, never
  baked into the content.
- **Exhaustive but copyable**: every section is a checklist a contributor can
  run through, not a philosophy essay.
- **Source of truth**: `docs/contributing/` is the authority. Tool-specific
  files (`AGENTS.md`, `CLAUDE.md`, `.cursor/rules`) only point at it.

## License

MIT. See `LICENSE`.

## Language-specific notes

The generic guide never assumes a stack. Optional per-language pages live in
`docs/contributing/languages/` and are copied only when they match the target
repository:

```bash
./scripts/copy.sh --detect /path/to/target-repo
```

Detection reads manifest files (`package.json`, `pyproject.toml`, `go.mod`,
`Cargo.toml`, and so on) and copies only the matching pages. Run without
`--detect` to copy every language page. See
`docs/contributing/languages/README.md` for the full detection table.

## Contributing to this template

The template is also a repository you can contribute to. If you are editing
it (not copying it into another repo), read `docs/developing.md` first. It
covers the layout, content rules, how to add a language or section, and how
to verify changes to `scripts/copy.sh`.

`AGENTS.md` at the root contains a template-only block for this repo; it is
stripped automatically when the template is copied elsewhere.
