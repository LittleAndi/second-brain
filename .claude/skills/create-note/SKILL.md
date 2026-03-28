---
name: create-note
description: >
  Generate a new knowledge base note from raw input. Use this skill when the user provides
  a problem description, concept explanation, procedure outline, error message, reference
  material, or anything else they want to capture and remember.
  USE FOR: "add a note about X", "document this", "capture this concept", "create a note for
  this error", "save this procedure", "write a note about this decision", "note this down".
  DO NOT USE FOR: updating an existing note (use update-note), summarising existing notes
  (use summarize), validating a note (use validate-note).
---

## Workflow

1. Use the schema defined in the `## Schema` section below.
2. Determine the correct structural `type` from the input:
   - Problem / symptom / something that went wrong → `troubleshooting`
   - Definition / explanation / how something works → `concept`
   - Step-by-step instructions / recipe / process → `procedure`
   - A significant choice and the reasoning behind it → `decision`
   - External material, links, raw data, or reference text → `reference`
3. Choose an appropriate topic folder based on what the note is about. Examples:
   - Food, cooking, recipes → `cooking/`
   - Exercise, sport, health → `fitness/` or `health/`
   - Money, budgeting, investing → `finance/`
   - Trips, destinations → `travel/`
   - Work projects, professional tasks → `work/`
   - Software, technology → use a descriptive tech topic name
   - Personal life → `personal/` or a more specific name
     If a suitable folder already exists in the repository, use it. Otherwise propose a new one.
4. **Announce** the chosen type and folder to the user before writing:
   > "I'll create this as a **procedure** note in `cooking/`. Let me know if you'd like a different type or folder."
   > Proceed immediately — do not wait for confirmation unless the user responds to correct.
5. Derive a kebab-case file name from the subject, specific enough to identify the note without opening it.
6. Produce the complete Markdown file including frontmatter and all required sections for the chosen type.
7. Create the file at `<folder>/<file-name>.md`.

## Output Contract

The output MUST:

- Be a single, self-contained Markdown file
- Begin with valid YAML frontmatter containing all required fields: `title`, `type`, `tags`, `summary`, `status`, `last_updated`
- Use `status: draft` unless the content is explicitly confirmed as verified
- Set `last_updated` to today's date in `YYYY-MM-DD` format
- Include all section headings required for the declared type as defined in the `## Schema` section below
- Contain no section with fewer than one sentence of content
- Be between 200 and 500 words (excluding frontmatter)
- Use kebab-case for all tags
- End with a `## Related` section (may be empty if no relations are known)

The output MUST NOT:

- Cover more than one topic
- Use implicit references ("the above", "as mentioned")
- Omit any required section heading for the declared type
- Exceed 1000 words

## Schema

### Allowed Types

| Type              | Purpose                                          |
| ----------------- | ------------------------------------------------ |
| `concept`         | Definitions and explanations of a single idea    |
| `procedure`       | Step-by-step instructions to accomplish a goal   |
| `troubleshooting` | A specific problem and its resolution            |
| `decision`        | A significant choice and the reasoning behind it |
| `reference`       | External material or raw reference data          |

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

### File Naming Rules

- MUST use kebab-case
- MUST be descriptive and unambiguous
- MUST be specific enough to identify the note without opening it
- MUST NOT use generic names (`notes.md`, `todo.md`, `misc.md`)

### Content Constraints

- Target word count: 200–500 words
- Maximum word count: 1000 words
- Language: explicit and unambiguous; avoid pronouns without antecedents
- Standard Markdown only; no custom syntax; avoid tables unless necessary
