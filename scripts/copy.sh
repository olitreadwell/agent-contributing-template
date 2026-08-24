#!/usr/bin/env bash
# Copies the agent contributing template into a target repository.
#
# Usage:
#   ./scripts/copy.sh /path/to/target-repo [repo-name]
#   ./scripts/copy.sh --detect /path/to/target-repo [repo-name]
#
# Copies docs/contributing/, AGENTS.md, CONTRIBUTING.md, and templates/ into
# the target. With --detect, only language pages matching the target's stack
# are copied and 00-index.md's language notes section is regenerated. The
# {{REPO_NAME}} placeholder in templates is filled with the target repo name.
set -euo pipefail

# Detects the stack of a repo from its manifest files and prints matching
# language page names, one per line.
detect_languages() {
  local dir="$1" found=""
  [[ -f "$dir/package.json" ]] && found="$found typescript"
  [[ -f "$dir/pyproject.toml" || -f "$dir/requirements.txt" || -f "$dir/setup.py" ]] && found="$found python"
  [[ -f "$dir/go.mod" ]] && found="$found go"
  [[ -f "$dir/Cargo.toml" ]] && found="$found rust"
  [[ -f "$dir/pom.xml" || -f "$dir/build.gradle" || -f "$dir/build.gradle.kts" ]] && found="$found java"
  [[ -f "$dir/composer.json" ]] && found="$found php"
  [[ -f "$dir/Gemfile" ]] && found="$found ruby"
  ls "$dir"/*.csproj >/dev/null 2>&1 && found="$found csharp"
  ls "$dir"/*.sln >/dev/null 2>&1 && found="$found csharp"
  ls "$dir"/*.tf >/dev/null 2>&1 && found="$found terraform"
  [[ -f "$dir/Dockerfile" || -f "$dir/docker-compose.yml" || -f "$dir/compose.yaml" || -f "$dir/compose.yml" ]] && found="$found docker"
  ls "$dir"/*.sh >/dev/null 2>&1 && found="$found shell"
  ls "$dir"/playbook*.yml >/dev/null 2>&1 || [[ -f "$dir/ansible.cfg" ]] && found="$found ansible"
  echo "$found"
}

DETECT=0
if [[ "${1:-}" == "--detect" ]]; then
  DETECT=1
  shift
fi

TARGET="${1:-}"
if [[ -z "$TARGET" || ! -d "$TARGET" ]]; then
  echo "usage: $0 [--detect] /path/to/target-repo [repo-name]" >&2
  exit 1
fi

HERE="$(cd "$(dirname "$0")/.." && pwd)"
REPO_NAME="${2:-$(basename "$TARGET")}"

mkdir -p "$TARGET/docs/contributing/templates" "$TARGET/docs/contributing/languages"

# Root hooks. The template-only block is stripped from AGENTS.md.
awk '
  /<!-- TEMPLATE-ONLY-START -->/ { skip = 1; next }
  /<!-- TEMPLATE-ONLY-END -->/   { skip = 0; next }
  !skip
' "$HERE/AGENTS.md" > "$TARGET/AGENTS.md"
cp "$HERE/CONTRIBUTING.md" "$TARGET/CONTRIBUTING.md"

# Core guide, always copied.
cp -R "$HERE/docs/contributing/"*.md "$TARGET/docs/contributing/"
cp -R "$HERE/docs/contributing/templates/." "$TARGET/docs/contributing/templates/"

# Language pages: all of them, or only the detected ones.
langs=""
if [[ "$DETECT" -eq 1 ]]; then
  langs=$(detect_languages "$TARGET")
  if [[ -n "$langs" ]]; then
    for lang in $langs; do
      cp "$HERE/docs/contributing/languages/$lang.md" "$TARGET/docs/contributing/languages/"
    done
  fi
else
  cp -R "$HERE/docs/contributing/languages/." "$TARGET/docs/contributing/languages/"
fi

# Regenerate the language notes section in 00-index.md (idempotent).
if [[ "$DETECT" -eq 1 && -n "$langs" ]]; then
  LANG_NOTES=""
  for lang in $langs; do
    LANG_NOTES+="- ${lang}: \`languages/${lang}.md\`"$'\n'
  done
else
  LANG_NOTES="- No language-specific notes were generated for this repository."$'\n'
fi
INDEX="$TARGET/docs/contributing/00-index.md"
NOTES_FILE="$(mktemp)"
printf '%s' "$LANG_NOTES" > "$NOTES_FILE"
awk '
  /<!-- LANGUAGE-NOTES-START -->/ {
    print
    while ((getline line < notes) > 0) print line
    close(notes)
    in_section = 1
    next
  }
  /<!-- LANGUAGE-NOTES-END -->/ { in_section = 0; print; next }
  !in_section
' notes="$NOTES_FILE" "$INDEX" > "$INDEX.tmp" && mv "$INDEX.tmp" "$INDEX"
rm -f "$NOTES_FILE"

# Fill the repo-name placeholder in templates.
for f in "$TARGET"/docs/contributing/templates/*.md; do
  [[ -e "$f" ]] || continue
  if sed -i '' "s/{{REPO_NAME}}/$REPO_NAME/g" "$f" 2>/dev/null; then
    :
  else
    sed -i "s/{{REPO_NAME}}/$REPO_NAME/g" "$f"
  fi
done

echo "Copied agent contributing template into $TARGET (repo name: $REPO_NAME)"
if [[ "$DETECT" -eq 1 ]]; then
  echo "Detected languages: ${langs:-none}"
fi
echo "Next: review $TARGET/AGENTS.md and $TARGET/docs/contributing/00-index.md"
