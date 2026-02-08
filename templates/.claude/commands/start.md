---
description: "Show project briefing — last activity, active tasks, next steps"
---

# Project Briefing

Generate a comprehensive project status briefing. Read all sources and present a clear summary.

## Steps

1. **Read `docs/dev-log.md`** — get active tasks, file locks, completed tasks

2. **Read `docs/progress.md`** — count completed vs total tasks per epic

3. **Check git history**:
   - Run `git log --oneline -10` for recent commits
   - Run `git log --oneline -1 --format="%ar by %an: %s"` for last activity
   - Run `git branch --list` for active branches
   - Run `git rev-parse --abbrev-ref HEAD` for current branch

4. **Determine next recommended tasks**:
   - Find the current wave/phase (first epic with uncompleted tasks)
   - List unclaimed tasks that are not blocked by dependencies
   - Prioritize lower-numbered tasks (they may unblock later ones)

5. **Present the briefing**:

```
[Project Name] — Project Briefing
===========================
Branch: [current branch]
Last activity: [relative time] — [commit message]
  [list last 3-5 meaningful commits]

Active tasks:
  [Dev 1 name]: [task ID — description, or "no active task"]
  [Dev 2 name]: [task ID — description, or "no active task"]

File locks: [count]
  [list locked files with who locked them]

Progress: [completed]/[total] tasks
  [Show each epic/phase with x/total count]

Current phase: [phase/wave description]

Next recommended tasks:
  [list available task IDs with descriptions]

Commands:
  /claim-task [id] [dev-name] — claim a task
  /complete-task [id] — finish a task
  /sync — check for conflicts
  /status — quick status check
```

6. **Ask**: "What would you like to work on?"
