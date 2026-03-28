#!/usr/bin/env bash
set -euo pipefail

SKILLS_SOURCE="$(cd "$(dirname "$0")/.claude/skills" && pwd)"
SKILLS_TARGET="$HOME/.claude/skills"

mkdir -p "$SKILLS_TARGET"

shopt -s nullglob
for skill in "$SKILLS_SOURCE"/*/; do
    name="$(basename "$skill")"
    target="$SKILLS_TARGET/$name"
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -L "$target" ] && [ ! -e "$target" ]; then
            echo "Fixing broken symlink for $name at $target"
            rm "$target"
            ln -s "$skill" "$target"
            echo "Relinked $name"
        else
            echo "Skipping $name — already exists at $target"
        fi
    else
        ln -s "$skill" "$target"
        echo "Linked $name"
    fi
done
