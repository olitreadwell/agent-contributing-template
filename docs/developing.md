# Developing this template

This guide is for people and agents editing the template itself, not for
repositories the template gets copied into. Read `AGENTS.md` first; the
generic contributing standard in `docs/contributing/` applies here too.

## What this repository is

A copyable contribution standard. Everything under `docs/contributing/`, plus
`AGENTS.md` and `CONTRIBUTING.md`, is designed to be copied verbatim into
another repository. `scripts/copy.sh` does the copying and may drop
template-only content.

## Layout

- `docs/contributing/00-index.md` through `09-tooling.md` — the generic core.
  Language-agnostic, agent-agnostic, no stack assumptions.
- `docs/contributing/languages/<language>.md` — optional per-stack pages.
  Copied only when detection matches the target repo's manifests.
- `docs/contributing/templates/` — PR, issue, and agent checklist templates.
  May contain the `{{REPO_NAME}}` placeholder, filled by `copy.sh`.
- `AGENTS.md` — copyable agent hook. Contains a `TEMPLATE-ONLY` block that
  `copy.sh` strips when copying.
- `CONTRIBUTING.md` — copyable human hook.
- `scripts/copy.sh` — the installer and the detection logic.

## Rules for content

- **Generic by default.** No language, framework, tool, or package manager is
  ever required in the core files. Stack specifics live only in
  `languages/`.
- **Checklist style.** Each section is something a contributor can run
  through, not an essay.
- **One concern per file.** If a section grows past its file's focus, split
  it and update the reading order in `00-index.md`.
- **Copy-safe.** Never reference files that only exist in the template repo
  (like this one) from copyable content. Template-only notes go between
  `<!-- TEMPLATE-ONLY-START -->` and `<!-- TEMPLATE-ONLY-END -->` markers so
  `copy.sh` can strip them.
- **Placeholders.** Repo-specific values in templates use `{{REPO_NAME}}`.
  Do not add new placeholders without updating `copy.sh`.

## Adding a language page

1. Create `docs/contributing/languages/<language>.md` following the shape of
   the existing pages: manifests, quality gates, tests, naming, common traps.
2. Add a row to the table in `docs/contributing/languages/README.md`.
3. Add the manifest checks to `detect_languages` in `scripts/copy.sh`.

## Adding or renaming a section

1. Create or edit the file under `docs/contributing/`.
2. Update the reading order in `docs/contributing/00-index.md`.
3. If a file is renamed, update `README.md`'s file list and `CONTRIBUTING.md`.

## Editing `scripts/copy.sh`

Keep it idempotent: running it twice on the same target produces the same
result. This means:

- Strip and regenerate the language notes section between the
  `<!-- LANGUAGE-NOTES-START -->` and `<!-- LANGUAGE-NOTES-END -->` markers.
- Strip the `TEMPLATE-ONLY` block from the copied `AGENTS.md`.
- Replace `{{REPO_NAME}}` everywhere, every run.

## Verifying a change

Test with a scratch repository:

```bash
mkdir -p /tmp/copy-test && echo '{"name":"scratch"}' > /tmp/copy-test/package.json
./scripts/copy.sh --detect /tmp/copy-test
ls /tmp/copy-test/docs/contributing/languages/   # expect typescript.md only
grep -c TEMPLATE-ONLY /tmp/copy-test/AGENTS.md   # expect 0
```

Run `copy.sh` twice and diff the output; the second run must not change
anything.
