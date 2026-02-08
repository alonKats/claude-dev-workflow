# Project Rules for Claude

## Startup Protocol

**IMPORTANT: At the start of EVERY new conversation, before doing anything else, you MUST:**

1. Read `docs/dev-log.md`, `docs/progress.md`, and run `git log --oneline -10`
2. Greet the user with a project status briefing (use the `/start` command format)
3. Then ask: "What would you like to work on?"

## Project Context

{{PROJECT_NAME}} — {{PROJECT_DESCRIPTION}}

**Read these files before starting any work:**
- `docs/progress.md` — task checklist
- `docs/dev-log.md` — active tasks, file locks, developer coordination

## Developers

{{DEVELOPERS_SECTION}}

### Coordination Protocol

The goal is to prevent two developers from editing the same files simultaneously. Before starting any task:
1. Read `docs/dev-log.md` to check what other developers are working on
2. Check if any files you need are locked
3. Register your task and file locks using `/claim-task`
4. When done, mark complete using `/complete-task`

**If a file conflict is detected — STOP and ask the user how to proceed.**

## Git Workflow

### Branching
- Main branch: `main`
- Feature branches: `feature/{task-id}-{description}` (e.g., `feature/3-1-design-system-api`)
- Each task from `docs/progress.md` = one feature branch

### Commits
- Use Conventional Commits: `type(scope): subject`
- Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`
- Scope = component name in kebab-case
- Keep subject under 50 chars, imperative mood, no period

## Available Commands

| Command | Purpose |
|---------|---------|
| `/start` | Project briefing — last activity, active tasks, next steps |
| `/status` | Show active tasks, file locks, and project progress |
| `/claim-task` | Claim a task from progress.md, register file locks |
| `/complete-task` | Mark task done, release file locks, update docs |
| `/sync` | Check for conflicts with other developer, sync with main |

## Code Standards

- All code comments in English
{{CODE_STANDARDS}}

## Tech Stack

{{TECH_STACK}}

## Key Directories

{{KEY_DIRECTORIES}}
