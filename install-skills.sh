#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SOURCE="$REPO_ROOT/.claude/skills"
SKILLS_TARGET="$HOME/.claude/skills"
SCHEMA_SOURCE="$REPO_ROOT/schemas"
SCHEMA_TARGET="$HOME/.claude/schemas"

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

if [ -e "$SCHEMA_TARGET" ] || [ -L "$SCHEMA_TARGET" ]; then
    if [ -L "$SCHEMA_TARGET" ] && [ ! -e "$SCHEMA_TARGET" ]; then
        echo "Fixing broken symlink for schemas at $SCHEMA_TARGET"
        rm "$SCHEMA_TARGET"
        ln -s "$SCHEMA_SOURCE" "$SCHEMA_TARGET"
        echo "Relinked schemas"
    else
        echo "Skipping schemas — already exists at $SCHEMA_TARGET"
    fi
else
    ln -s "$SCHEMA_SOURCE" "$SCHEMA_TARGET"
    echo "Linked schemas"
fi
