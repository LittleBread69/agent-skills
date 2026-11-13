# agent-skills: project memory

## Purpose
Central home for the user's custom agent skills, so the same skills work in
Claude Code, OpenHands and AllHands (not just on the NAS where they started).

## Where things come from
- The original custom skills were built for the user's TrueNAS setup and normally
  live in the claude.ai project **"TVRodinaTrueNAS projects"**. Cloud sessions
  cannot read that project. Ask the user to paste the files, or point to a repo.
- Migrating them into `skills/` is the main open task.

## Conventions
- One folder per skill: `skills/<skill-name>/SKILL.md` (YAML frontmatter with
  `name` and `description`, then instructions), plus optional `scripts/`.
- No secrets, NAS hostnames, IPs or passwords in skill files. Read them from
  environment variables instead, and document the variable names in the skill.
- `install/` holds one script per tool that links skills into that tool's
  skills folder. `install/claude.sh` exists (links into `~/.claude/skills/`,
  override with `CLAUDE_SKILLS_DIR`). It has not been run or tested yet.

## Open tasks
1. Import the NAS skills from "TVRodinaTrueNAS projects".
2. Write `install/openhands.sh` (also for AllHands). First confirm which skills
   folder the user's OpenHands version reads (older versions used "microagents").
3. Cloud environment for this repo: the user wants a setup script, network
   access, secrets and variables proposed. Always ask before saving any
   environment change.

## Working with this user
- Ask before outward-facing actions (creating repos, attaching other repos,
  saving environment settings). They stopped an unrequested repo attach once.
- Cloud sessions cannot create GitHub repos. The user creates them, then
  Claude attaches them.
