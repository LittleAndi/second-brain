#!/usr/bin/env bash
set -euo pipefail

SKILLS_SOURCE="$(cd "$(dirname "$0")/.claude/skills" && pwd)"
SKILLS_TARGET="$HOME/.claude/skills"

mkdir -p "$SKILLS_TARGET"

for skill in "$SKILLS_SOURCE"/*/; do
    name="$(basename "$skill")"
    target="$SKILLS_TARGET/$name"
    if [ -e "$target" ]; then
        echo "Skipping $name — already exists at $target"
    else
        ln -s "$skill" "$target"
        echo "Linked $name"
    fi
done
