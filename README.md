# Claude Dev Workflow

A portable, multi-developer coordination workflow for [Claude Code](https://claude.ai/claude-code). Drop it into any project to get task management, file locking, and team sync — all driven by Claude slash commands.

## What You Get

### Slash Commands

| Command | What it does |
|---------|-------------|
| `/start` | Project briefing — branch, last activity, active tasks, progress, next steps |
| `/status` | Quick status — active tasks, file locks, progress per epic |
| `/claim-task` | Claim a task, lock files, create feature branch |
| `/complete-task` | Mark done, release locks, update progress |
| `/sync` | Check for conflicts with other devs, sync with main |

### Coordination Files

| File | Purpose |
|------|---------|
| `docs/dev-log.md` | Active tasks, file locks, completed work log |
| `docs/progress.md` | Task checklist with `[ ]` / `[x]` tracking |
| `CLAUDE.md` | Project rules Claude follows every conversation |
| `.claude/settings.local.json` | Pre-approved permissions for common operations |

### How It Works

1. Claude reads `docs/dev-log.md` at the start of every conversation
2. Before editing files, it checks if they're locked by another developer
3. `/claim-task` registers what you're working on and which files you'll touch
4. `/complete-task` releases locks and updates the progress checklist
5. `/sync` compares your branch against other devs' locked files to catch conflicts early

## Install

### Quick Install

```bash
git clone https://github.com/alonKats/claude-dev-workflow.git
cd claude-dev-workflow
./install.sh /path/to/your/project
```

The installer will prompt for:
- Project name and description
- Developer names
- Tech stack (optional)
- Code standards (optional)
- Key directories (optional)

### Manual Install

Copy these into your project:

```
templates/.claude/commands/*.md  →  .claude/commands/
templates/.claude/settings.local.json  →  .claude/settings.local.json
templates/docs/dev-log.md  →  docs/dev-log.md
templates/docs/progress.md  →  docs/progress.md
templates/CLAUDE.md  →  CLAUDE.md  (edit placeholders)
```

## After Installing

1. **Edit `CLAUDE.md`** — fill in `{{placeholders}}` if you did manual install, or review the generated file
2. **Edit `docs/progress.md`** — replace the example phases/tasks with your actual work breakdown
3. **Edit `docs/dev-log.md`** — add your shared files table
4. **Commit** — add the workflow files to your project repo

## Recommended Plugins

These global Claude Code plugins complement the workflow:

```bash
# 65+ specialized dev skills (React, TypeScript, DevOps, etc.)
claude plugins install fullstack-dev-skills@fullstack-dev-skills

# Up-to-date library documentation lookup
claude plugins install context7@claude-plugins-official
```

## Workflow Example

```
# Developer 1 starts their day
> /start
  Shows briefing: branch, progress, what's available

> /claim-task 3-1 Alice
  Locks files, creates feature/3-1-auth-api branch

  ... does work ...

> /complete-task 3-1
  Releases locks, marks task [x] in progress.md

# Developer 2 checks for conflicts before starting
> /sync
  Shows: no conflicts, 2 commits behind main, recommends rebase

> /claim-task 3-2 Bob
  ... continues working ...
```

## Customization

### Adding Commands

Drop any `.md` file into `.claude/commands/` in your project. Format:

```markdown
---
description: "Short description shown in /help"
argument-hint: "What args to pass"
---

# Command Name

Instructions for Claude to follow...
```

### Single Developer

Works fine solo — the coordination overhead is minimal and you still get progress tracking, file lock awareness (useful when switching between Claude sessions), and structured briefings.

## License

MIT
