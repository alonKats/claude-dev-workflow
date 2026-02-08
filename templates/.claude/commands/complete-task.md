---
description: "Mark a task as complete — release file locks, update progress tracking"
argument-hint: "Task ID (e.g., 3-1)"
---

# Complete Task

Mark a claimed task as finished, release all file locks, and update documentation.

**Usage**: `/complete-task <task-id>`

**Arguments**: $ARGUMENTS

## Steps

1. **Parse arguments** — extract task ID
   - If missing, read `docs/dev-log.md` and show active tasks, ask which one to complete

2. **Read `docs/dev-log.md`** — find the task in Active Tasks table
   - If task not found in active tasks, inform user and stop

3. **Verify work is ready**:
   - Run `git status` — warn if there are uncommitted changes
   - Run `git log --oneline -5` — show recent commits for this branch

4. **Update `docs/progress.md`**:
   - Find the task checkbox and change `[ ]` to `[x]`

5. **Update `docs/dev-log.md`**:
   - Remove the task row from Active Tasks table
   - Remove all file lock rows for this task from File Locks table
   - Add row to Completed Tasks table with: Developer, Task ID, description, branch, today's date, PR link (if exists)

6. **Show summary**:
```
TASK COMPLETED
==============
Task: [ID] — [description]
Developer: [name]
Branch: feature/[branch-name]

Files Unlocked:
  - [file/dir 1]
  - [file/dir 2]

Progress Updated:
  [Epic/Phase]: [x/total] complete

Next steps:
  - Create PR if ready
  - Check available tasks: use /status
```
