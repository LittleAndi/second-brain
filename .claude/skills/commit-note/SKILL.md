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

**Description format:** `<short description of the change>`

The description should be concise and human-readable. For `add`, `update`, `deprecate`, and `remove`,
it is conventional to append the note's structural type for clarity. For `fix`, describe what was
corrected rather than just naming the file.

Examples:

```
add: sourdough-starter-feeding-schedule procedure
fix: incorrect cause in knee-pain-after-long-run
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
3. Compose the description:
   - For `fix`: write a short phrase describing what was corrected (e.g., `incorrect cause in <note-slug>`).
   - For all other types: use the kebab-case slug of the note title, optionally followed by the
     note's structural type (e.g., `sourdough-starter-feeding-schedule procedure`).
4. Output the suggested commit message as a plain code block.
5. Briefly explain the choice of `type` if it may not be obvious.

### Mode B — Validate a proposed commit message

Triggered when the user provides a commit message and asks if it is correct.

1. Parse the message into `<type>` and `<description>`.
2. Check each rule:
   - [ ] `type` is one of: `add`, `fix`, `update`, `deprecate`, `remove`
   - [ ] Format matches `<type>: <description>` (colon + space separator)
   - [ ] Description is lowercase
   - [ ] No scope in parentheses (this repo does not use scopes)
3. If all checks pass: confirm with **PASS** and a brief affirmation.
4. If any check fails: report **FAIL**, list each violated rule, and output a corrected
   message in a code block.

## Output Contract

The output MUST:

- Present the suggested or corrected message in a fenced code block
- Use only lowercase in the message
- Be concise — no more than a short paragraph of explanation alongside the code block

The output MUST NOT:

- Include a commit body or footer unless the user explicitly asks
- Use conventional-commits scopes like `feat(scope):`
- Suggest multiple commits when the user has only described one change
