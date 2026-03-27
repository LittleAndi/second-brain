---
name: troubleshoot
description: >
  Triage a problem and produce a conformant troubleshooting note. Use this skill when the
  user describes something that went wrong — an error, a failure, an unexpected outcome —
  and wants it captured in the knowledge base.
  USE FOR: "I'm getting error X", "why does Y fail", "something's not working", "document
  this bug", "save this issue", "capture this problem", "write up what went wrong".
  DO NOT USE FOR: updating an existing troubleshooting note (use update-note), creating other
  note types (use create-note), answering questions from existing notes (use summarize).
---

## Workflow

1. Read `schemas/note-schema.md` to load the current authoritative schema for type `troubleshooting`.
2. Collect the following from the user's input:
   - Exact error message or observable symptom
   - The setting, context, or environment where the problem occurs (app, appliance, activity, process, etc.)
   - Any known context: recent changes, events, or conditions surrounding the problem
   - Steps already attempted
   - Root cause if already known
3. Choose an appropriate topic folder based on what the problem is about (e.g. `cooking/`, `fitness/`, `work/`, `home/`). If a suitable folder already exists in the repository, use it. Announce the chosen folder to the user.
4. Produce the complete `troubleshooting` note. Mark any unknown sections as `TBD` rather than omitting them.
5. Derive a specific, descriptive `summary` from the problem and context — not a generic statement.
6. Suggest at least one `related` note in the frontmatter if a match is apparent from existing content.
7. Create the file at `<folder>/<kebab-case-name>.md`.

## Output Contract

The output MUST:

- Be a complete Markdown file with frontmatter and all required sections for type `troubleshooting`: `## Problem`, `## Context`, `## Cause`, `## Solution`, `## Prevention`, `## Related`
- Set `type: troubleshooting`
- Set `status: draft` unless the cause and solution are fully verified
- Set `last_updated` to today's date
- Use the exact error message or symptom verbatim in `## Problem`
- Mark unknown sections as `TBD`
- Be between 150 and 500 words (excluding frontmatter)

The output MUST NOT:

- Invent a cause or solution not supported by the input
- Use vague language in `## Solution` — each step must be actionable
- Omit `## Prevention`
