# Second Brain

A personal knowledge base for anything worth remembering — organised your way.

## How it works

Notes are stored as Markdown files, each covering a single topic. You decide which topic folders to create. The note's structural type (`concept`, `procedure`, `troubleshooting`, `decision`, or `reference`) is tracked in the file itself, not in the folder name.

### Example folder layouts

There is no required folder structure. Some examples:

```text
second-brain/           second-brain/           second-brain/
│                       │                       │
├── cooking/            ├── work/               ├── health/
├── fitness/            ├── finance/            ├── reading/
├── travel/             ├── home/               ├── projects/
└── finance/            └── learning/           └── work/
```

What matters is that notes live in **exactly one topic subfolder** — not at the root.

## Schema

All notes MUST conform to [`schemas/note-schema.md`](schemas/note-schema.md). That file is the single source of truth for:

- The five structural note types and what they are for
- Required and optional frontmatter fields
- Exact section structures per type
- File naming rules
- Validation checklist

## AI Skills

Skills are stored in [`.claude/skills/`](.claude/skills/) and are auto-invoked by GitHub Copilot and Claude based on what you ask. No manual reference needed.

When you ask the AI to create a note, it will suggest a topic folder and structural type — you can correct either before the file is written.

| Skill                                                    | Triggers                                         | Purpose                                             |
| -------------------------------------------------------- | ------------------------------------------------ | --------------------------------------------------- |
| [`create-note`](.claude/skills/create-note/SKILL.md)     | "document this", "add a note about X"            | Generate a new note from raw input                  |
| [`update-note`](.claude/skills/update-note/SKILL.md)     | "fix the note on X", "add Y to Z"                | Amend or extend an existing note                    |
| [`summarize`](.claude/skills/summarize/SKILL.md)         | "what do we have on X", "summarise Y"            | Summarise notes or answer questions from them       |
| [`troubleshoot`](.claude/skills/troubleshoot/SKILL.md)   | "I have a problem with X", "why does Y not work" | Triage a problem and produce a troubleshooting note |
| [`validate-note`](.claude/skills/validate-note/SKILL.md) | "check this note", "validate X"                  | Verify a note conforms to the schema                |

## Commit Message Convention

```text
<type>: <short description>

Types: add | fix | update | deprecate | remove

Examples:
add: sourdough-starter-feeding-schedule procedure
fix: incorrect cause in knee-pain-after-long-run
update: home-budget-2026 reference
```

Each commit MUST be atomic — one note changed per commit.

## Anti-Patterns

Do not author notes that:

- Cover more than one topic
- Are missing frontmatter
- Use inconsistent or missing section headings
- Contain implicit assumptions
- Use "see above" or other relative references
- Exceed 1000 words
- Contain sensitive information (passwords, API keys, credentials, or personally identifiable information)
