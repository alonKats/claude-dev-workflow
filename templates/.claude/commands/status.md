---
description: Show project status — active tasks, file locks, and overall progress
---

# Project Status Check

Read and display the current project status by analyzing these files:

## Steps

1. **Read `docs/dev-log.md`** and show:
   - Active Tasks table (who is working on what)
   - File Locks table (which files are locked)
   - Any potential conflicts

2. **Read `docs/progress.md`** and show:
   - Count of completed vs total tasks per epic/phase
   - Next available tasks (unclaimed, not blocked)
   - Current phase focus

3. **Check git state**:
   - Run `git branch -a` to show active branches
   - Run `git status` to check for uncommitted work
   - Run `git log --oneline -5` for recent commits

4. **Show summary** in this format:

```
PROJECT STATUS
==============
Active Tasks: [count]
  [Dev 1]: [task or "idle"]
  [Dev 2]: [task or "idle"]

File Locks: [count]
  [list locked files]

Progress: [completed]/[total] tasks
  [each epic/phase with x/total and name]

Next Available Tasks:
  [task IDs with descriptions]

Git: branch [name], [clean/dirty]
```
