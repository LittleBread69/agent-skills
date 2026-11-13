# agent-skills

Custom agent skills shared across Claude Code, OpenHands and AllHands.

## Layout

```
skills/<skill-name>/SKILL.md   # YAML frontmatter (name, description) + instructions
skills/<skill-name>/scripts/   # optional helper scripts
install/                       # scripts that link skills into each tool's skills folder
```

## Skills

Written for local models in Open WebUI on the NAS (Workspace -> Skills) and also usable in Claude Code, OpenHands and AllHands.

| Skill | Use it for |
|---|---|
| `web-research` | Current or changing facts: search, read pages, cite sources |
| `deep-research` | Broad questions needing several searches and a sourced report |
| `honest-answers` | Say "I don't know" instead of inventing facts, sources or versions |
| `read-documentation` | Answering only from a pasted document, manual or changelog |
| `document-analysis` | Reading, summarizing and questioning attached documents |
| `document-writing` | Reports, emails, essays and READMEs with clear structure |
| `data-analysis` | Tables, CSV and numbers: inspect, compute with code, sanity-check |
| `frontend-design` | Single-file HTML/CSS/JS pages with real design choices |
| `code-review` | Spec, correctness, security and standards review with severity labels |
| `compact-conversation` | The `/compact` equivalent: a lossless handoff summary for a new chat |

Note: Claude Code ships a built-in `/code-review` command, so the `code-review` skill name may collide with it there. Rename the folder and the `name:` line if it does.

## Adding a skill

1. Create `skills/<skill-name>/SKILL.md`:

   ```markdown
   ---
   name: skill-name
   description: One or two sentences on what it does and when to use it.
   ---

   Instructions...
   ```

2. Keep secrets, hostnames and passwords out of skill files. Read them from
   environment variables instead.

## Installing

- Claude Code: `install/claude.sh` (links skills into `~/.claude/skills/`)
- OpenHands / AllHands: still to do. Check which skills folder your installed version reads.
