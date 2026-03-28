---
name: validate-note
description: >
  Check a knowledge base note against the note schema and report all violations.
  Use this skill when the user wants to verify a note is conformant before marking it stable,
  after editing a note manually, or when reviewing contributed content.
  USE FOR: "is this note correct", "check this note", "does this follow the schema",
  "validate X", "review this note for compliance", "what's wrong with this note".
  DO NOT USE FOR: creating new notes (use create-note), updating notes (use update-note),
  summarising notes (use summarize).
---

## Workflow

1. Use the validation checklist defined in the `## Validation Checklist` section below.
2. Read the note file to be validated.
3. Check the note against each rule in the validation checklist.
4. Report the result.

## Validation Checklist

Check all of the following:

- [ ] File has YAML frontmatter delimited by `---`
- [ ] All required frontmatter fields are present: `title`, `type`, `tags`, `summary`, `status`, `last_updated`
- [ ] `type` is one of: `concept`, `procedure`, `troubleshooting`, `decision`, `reference`
- [ ] File is stored in exactly one topic subfolder (one level deep from root, not at the root itself)
- [ ] `tags` are lowercase and kebab-case
- [ ] `summary` is a single sentence and max 160 characters
- [ ] `status` is one of: `draft`, `stable`, `deprecated`
- [ ] `last_updated` is in `YYYY-MM-DD` format
- [ ] All section headings required by the declared type are present and match the schema exactly
- [ ] No section uses "see above", "as mentioned", or other relative references
- [ ] File name is kebab-case and reflects the content subject
- [ ] Word count is between 200 and 1000 words (excluding frontmatter)
- [ ] File covers only one topic

## Output Contract

The output MUST:

- State whether the note is **valid** or **invalid**
- If invalid, list each violation as a numbered item with the rule name and specific problem found
- If valid, confirm which type schema was applied and note the word count
- Be concise — do not re-print the note content

The output MUST NOT:

- Silently pass a note that has violations
- Suggest fixes beyond identifying the problem (fixes are handled by `update-note`)
