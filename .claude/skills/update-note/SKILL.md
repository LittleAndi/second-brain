---
name: update-note
description: >
  Amend, correct, or extend an existing knowledge base note while keeping it conformant with
  schemas/note-schema.md. Use this skill when the user wants to fix incorrect information,
  add steps or examples, link related notes, or promote a note from draft to stable.
  USE FOR: "fix the note on X", "add Y to the Z note", "update the steps in X", "mark X as
  stable", "link X to Y", "correct the cause in X".
  DO NOT USE FOR: creating a new note (use create-note), summarising notes (use summarize),
  validating a note (use validate-note).
---

## Workflow

1. Read `schemas/note-schema.md` to load the current authoritative schema.
2. Read the existing note file to understand its current content and structure.
3. Apply only the requested changes. Do not alter unrelated sections, tags, or frontmatter fields.
4. Update `last_updated` to today's date.
5. Write the complete updated file back (not a diff).

## Output Contract

The output MUST:

- Return the complete updated Markdown file
- Preserve all frontmatter fields that are not explicitly changing
- Update `last_updated` to today's date in `YYYY-MM-DD` format
- Retain the existing `type` unless a type change is explicitly requested
- Retain all section headings required by the schema; add optional sections only if content warrants them
- Preserve the file name unless the title fundamentally changes and a rename is explicitly requested
- Remain within the 200–1000 word limit

The output MUST NOT:

- Remove required sections
- Downgrade `status` without explicit instruction
- Change tags or category without explicit instruction
- Introduce new anti-patterns (implicit references, multi-topic content)
