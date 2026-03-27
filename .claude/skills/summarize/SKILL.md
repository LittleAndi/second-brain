---
name: summarize
description: >
  Produce a concise, structured summary of one or more knowledge base notes, or answer a
  question using the notes as source material.
  USE FOR: "summarise the notes on X", "what do we have on Y", "give me an overview of X",
  "answer this question using the knowledge base", "what does the X note say".
  DO NOT USE FOR: creating new notes (use create-note), updating notes (use update-note),
  validating notes (use validate-note).
---

## Workflow

1. Identify which notes are relevant to the request (by folder, tag, category, or explicit file reference).
2. Read each relevant note file.
3. Produce the appropriate output format based on the task type (single-note, multi-note, or Q&A).

## Output Contracts

### Single-note summary

- State the `type` and `title` of the note
- Restate the `summary` frontmatter field verbatim
- List the key point from each section in one sentence per section
- List all values from the `related` frontmatter field
- Total length: 100–200 words

### Multi-note summary

- One paragraph per note: title + 2–3 sentences
- Group notes by `type` if multiple types are present
- Identify themes or patterns across notes if asked
- No more than 50 words per note

### Question-answering from notes

- Answer the question using only information present in the provided notes
- Cite the source note by file name for each claim
- State explicitly if the answer is not found in the provided notes

The output MUST NOT:

- Introduce information not present in the source notes
- Omit the source note file name when answering questions
