# agent-skills

Custom agent skills shared across Claude Code, OpenHands and AllHands.

## Layout

```
skills/<skill-name>/SKILL.md   # YAML frontmatter (name, description) + instructions
skills/<skill-name>/scripts/   # optional helper scripts
install/                       # scripts that link skills into each tool's skills folder
```

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
