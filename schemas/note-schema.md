---
title: Note Schema
type: reference
tags: [meta, schema, validation]
summary: Authoritative schema definition for all note types in this knowledge base. Single source of truth for humans, AI systems, and validation tooling.
status: stable
last_updated: 2026-03-27
---

## Purpose

This file is the **single source of truth** for all content authored in this repository. Every note MUST conform to the rules defined here regardless of authoring method (human, AI, or tool).

## Allowed Types

Notes are categorised by **structural type**, which determines the required sections and is recorded in frontmatter. There are five types:

| Type              | Purpose                                          |
| ----------------- | ------------------------------------------------ |
| `concept`         | Definitions and explanations of a single idea    |
| `procedure`       | Step-by-step instructions to accomplish a goal   |
| `troubleshooting` | A specific problem and its resolution            |
| `decision`        | A significant choice and the reasoning behind it |
| `reference`       | External material or raw reference data          |

Notes are stored in **topic folders that you define** — for example `cooking/`, `fitness/`, `work/`, or `travel/`. The folder name reflects what the note is _about_. There is no fixed mapping between types and folders.

## Frontmatter Specification

### Required Fields

All notes MUST include these fields:

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

### Optional Fields

```yaml
related: [<file-name-without-extension>, ...]
aliases: [<alternative search terms>]
category: <cooking | fitness | finance | travel | work | personal | etc>
complexity: <low | medium | high>
```

Field rules:

- `related`: file names only, no path, no `.md` extension, no titles
- `aliases`: alternative terms a reader might search for
- `category`: the topic area this note belongs to; use kebab-case for compound names
- `complexity`: expected reader effort to understand or apply the content

## Section Schemas

### concept

```markdown
## Summary

Short explanation (2–4 sentences). Must define the concept explicitly.

## Details

Expanded explanation. Include how it works, not just what it is.

## Examples

Concrete usage or scenarios. At least one example required.

## Gotchas

Common pitfalls or misunderstandings. Omit section only if none exist.

## Related

- <file-name-without-extension>
```

### procedure

```markdown
## Goal

One sentence: what the reader will have accomplished after following this procedure.

## Prerequisites

Required knowledge, tools, permissions, or configuration.

## Steps

1. Step one — include expected output or state where relevant
2. Step two

## Verification

How to confirm the procedure succeeded. Must be observable and deterministic.

## Rollback

How to undo the changes made by this procedure.

## Related

- <file-name-without-extension>
```

### troubleshooting

```markdown
## Problem

Exact error message or observable symptom. Quote error messages verbatim.

## Context

The environment, service, or workflow where the problem occurs.

## Cause

Root cause. Explain why the problem happens, not just what triggers it.

## Solution

Numbered steps to resolve the problem. Each step must be actionable.

## Prevention

How to avoid this problem in future. Reference configuration or process changes.

## Related

- <file-name-without-extension>
```

### decision

```markdown
## Context

Background information and the problem that required a decision.

## Decision

The chosen approach. State it as a single, unambiguous sentence first.

## Consequences

Trade-offs and implications. Include both positive and negative consequences.

## Alternatives Considered

Other options that were evaluated and why they were not chosen.

## Related

- <file-name-without-extension>
```

### reference

```markdown
## Overview

What this reference covers and how to use it.

## Content

The reference material itself (links, specs, tables, code snippets, etc.).

## Notes

Context, caveats, or expiry considerations for this reference material.

## Related

- <file-name-without-extension>
```

## File Naming Rules

- MUST use kebab-case
- MUST be descriptive and unambiguous
- MUST be specific enough to identify the note without opening it
- MUST NOT use generic names (`notes.md`, `todo.md`, `misc.md`)

Examples:

```text
sourdough-starter-feeding-schedule.md
knee-pain-after-long-run.md
switching-to-index-funds-2026.md
```

## Validation Checklist

A file is valid when ALL of the following are true:

- Has YAML frontmatter delimited by `---`
- Contains all required frontmatter fields with correct types
- File is stored in exactly one topic subfolder (one level deep from root, not at the root itself)
- Section headings match the schema for the declared type exactly
- File name is kebab-case and reflects the content subject
- Word count is between 200 and 1000 words
- No section contains "see above" or other relative references
- The `Related` section uses file names, not titles or URLs

## Content Constraints

- Target word count: 200–500 words
- Maximum word count: 1000 words
- Language: explicit and unambiguous; avoid pronouns without antecedents
- Repeat key entities rather than using pronouns
- Standard Markdown only; no custom syntax; avoid tables unless necessary

## Anti-Patterns

The following are MUST NOT violations:

- Multi-topic files (one concept/problem/procedure per file)
- Missing frontmatter
- Inconsistent or missing section headings
- Implicit assumptions (state all prerequisites explicitly)
- "See above" or "as mentioned" cross-references
- Long narrative prose without structure
- Tags that are not lowercase or use spaces
