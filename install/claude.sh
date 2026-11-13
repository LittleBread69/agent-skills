#!/usr/bin/env bash
# Symlink every skill in this repo into ~/.claude/skills/
set -euo pipefail
repo="$(cd "$(dirname "$0")/.." && pwd)"
dest="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
mkdir -p "$dest"
for d in "$repo"/skills/*/; do
  [ -f "$d/SKILL.md" ] || continue
  ln -sfn "$d" "$dest/$(basename "$d")"
  echo "linked $(basename "$d")"
done
