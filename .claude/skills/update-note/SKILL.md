---
name: update-note
description: >
  Amend, correct, or extend an existing knowledge base note while keeping it conformant with
  the note schema. Use this skill when the user wants to fix incorrect information,
  add steps or examples, link related notes, or promote a note from draft to stable.
  USE FOR: "fix the note on X", "add Y to the Z note", "update the steps in X", "mark X as
  stable", "link X to Y", "correct the cause in X".
  DO NOT USE FOR: creating a new note (use create-note), summarising notes (use summarize),
  validating a note (use validate-note).
---

## Workflow

1. Use the schema defined in the `## Schema` section below.
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

## Schema

### Required Frontmatter Fields

```yaml
---
title: <string>
type: <concept | procedure | troubleshooting | decision | reference>
tags: [<string>, ...]
summary: <string>
status: <draft | stable | deprecated>
last_updated: <YYYY-MM-DD>
---
```

Field rules:

- `title`: Human-readable, sentence-case, no trailing punctuation
- `type`: MUST be one of the five allowed values listed above
- `tags`: MUST be lowercase; MUST use kebab-case for multi-word tags; MUST include at least one descriptive tag
- `summary`: One sentence; MUST contain the key entity or error; max 160 characters
- `status`: `draft` while content is being developed; `stable` once verified; `deprecated` when superseded
- `last_updated`: ISO 8601 date of most recent meaningful content change

### Optional Frontmatter Fields

```yaml
related: [<file-name-without-extension>, ...]
aliases: [<alternative search terms>]
category: <cooking | fitness | finance | travel | work | personal | etc>
complexity: <low | medium | high>
```

### Section Schemas

#### concept

```markdown
## Summary
## Details
## Examples
## Gotchas
## Related
```

#### procedure

```markdown
## Goal
## Prerequisites
## Steps
## Verification
## Rollback
## Related
```

#### troubleshooting

```markdown
## Problem
## Context
## Cause
## Solution
## Prevention
## Related
```

#### decision

```markdown
## Context
## Decision
## Consequences
## Alternatives Considered
## Related
```

#### reference

```markdown
## Overview
## Content
## Notes
## Related
```

### Content Constraints

- Target word count: 200–500 words
- Maximum word count: 1000 words
- Language: explicit and unambiguous; avoid pronouns without antecedents
- Standard Markdown only; no custom syntax; avoid tables unless necessary
