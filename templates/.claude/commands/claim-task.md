---
description: "Claim a task from progress.md — register active work and file locks"
argument-hint: "Task ID (e.g., 3-1) and developer name"
---

# Claim Task

Register a task as actively being worked on. This prevents other developers from editing the same files.

**Usage**: `/claim-task <task-id> <developer-name>`

**Arguments**: $ARGUMENTS

## Steps

1. **Parse arguments** — extract task ID and developer name
   - If missing, ask the user for task ID and which developer they are

2. **Read `docs/progress.md`** — find the task, confirm it exists and is unclaimed (`[ ]`)

3. **Read `docs/dev-log.md`** — check Active Tasks table:
   - If this developer already has an active task, warn the user
   - If the task is already claimed by another dev, STOP and inform

4. **Determine files to lock** based on the task:
   - Analyze which files/directories will likely be modified
   - Check for conflicts with existing locks — if conflict found, STOP and warn

5. **Update `docs/dev-log.md`**:
   - Add row to Active Tasks table with: Developer name, Task ID, description, branch name, today's date
   - Add rows to File Locks table for each locked file/directory

6. **Create git branch**:
   - Branch name format: `feature/{task-id}-{short-description}`
   - Run: `git checkout -b feature/{branch-name}`

7. **Confirm** — show the user what was claimed and locked:
```
TASK CLAIMED
============
Task: [ID] — [description]
Developer: [name]
Branch: feature/[branch-name]

Files Locked:
  - [file/dir 1]
  - [file/dir 2]

Next: Start implementing. When done, use /complete-task [task-id]
```
