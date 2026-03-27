---
name: commit-note
description: >
  Suggest or validate a git commit message for a knowledge base change, enforcing the
  repository commit convention: `<type>: <short description>`.
  USE FOR: "what should my commit message be", "suggest a commit for this", "is this commit
  message correct", "validate my commit", "does this commit follow the convention",
  "what commit type should I use".
  DO NOT USE FOR: creating notes (use create-note), updating note content (use update-note),
  validating note schema (use validate-note).
---

## Convention

Format: `<type>: <short description>`

| Type        | When to use                                     |
| ----------- | ----------------------------------------------- |
| `add`       | A new note file was created                     |
| `fix`       | Incorrect content in an existing note was fixed |
| `update`    | An existing note was extended or amended        |
| `deprecate` | A note was marked as deprecated                 |
| `remove`    | A note file was deleted                         |

**Atomicity rule:** Every commit MUST touch exactly one note file. If multiple notes changed,
they require separate commits.

**Description format:** `<kebab-slug-of-note-title> <note-type>`

Examples:

```
add: sourdough-starter-feeding-schedule procedure
fix: knee-pain-after-long-run troubleshooting
update: home-budget-2026 reference
deprecate: old-deployment-process procedure
remove: outdated-api-keys reference
```

## Workflow

### Mode A — Suggest a commit message

Triggered when the user describes what they just did (e.g., "I added a note about X",
"I fixed the cause in the Y note").

1. Identify the changed file path and note title from context.
2. Determine the correct `type`:
   - New file created → `add`
   - Incorrect content corrected → `fix`
   - Extended, amended, or enriched → `update`
   - Marked `status: deprecated` → `deprecate`
   - File deleted → `remove`
3. Derive the kebab-case slug from the note's `title` frontmatter field.
4. Identify the note's structural `type` from its frontmatter (concept, procedure,
   troubleshooting, decision, reference).
5. Output the suggested commit message as a plain code block.
6. Briefly explain the choice of `type` if it may not be obvious.

### Mode B — Validate a proposed commit message

Triggered when the user provides a commit message and asks if it is correct.

1. Parse the message into `<type>` and `<description>`.
2. Check each rule:
   - [ ] `type` is one of: `add`, `fix`, `update`, `deprecate`, `remove`
   - [ ] Format matches `<type>: <description>` (colon + space separator)
   - [ ] Description is lowercase and uses kebab-case slug
   - [ ] Description ends with the note's structural type word
   - [ ] No scope in parentheses (this repo does not use scopes)
3. If all checks pass: confirm with **PASS** and a brief affirmation.
4. If any check fails: report **FAIL**, list each violated rule, and output a corrected
   message in a code block.

## Output Contract

The output MUST:

- Present the suggested or corrected message in a fenced code block
- Use only lowercase in the message
- End the description with the structural note type (concept, procedure, troubleshooting,
  decision, or reference)
- Be concise — no more than a short paragraph of explanation alongside the code block

The output MUST NOT:

- Include a commit body or footer unless the user explicitly asks
- Use conventional-commits scopes like `feat(scope):`
- Suggest multiple commits when the user has only described one change
