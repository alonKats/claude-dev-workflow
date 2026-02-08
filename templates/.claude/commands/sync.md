---
description: "Check for conflicts with other developers and sync with main"
---

# Sync & Conflict Check

Check if other developers' work conflicts with yours and sync your branch with main.

## Steps

1. **Read `docs/dev-log.md`** — show current active tasks and file locks for all devs

2. **Check git state**:
   ```bash
   git fetch origin
   git status
   git log --oneline HEAD...origin/main
   ```

3. **Check for divergence from main**:
   - Run `git diff --name-only origin/main...HEAD` — list files changed on your branch
   - Compare with other devs' file locks from `docs/dev-log.md`
   - If overlap found, report which files conflict

4. **Show sync report**:
```
SYNC REPORT
============
Your branch: [branch-name]
Commits ahead of main: [count]
Commits behind main: [count]

Your changed files:
  - [file 1]
  - [file 2]

Other devs' locked files:
  - [file 1] ([dev name], task [ID])

Conflicts: [NONE / list of conflicting files]

Recommendation:
  [No action needed / Rebase from main / Coordinate with other dev on specific files]
```

5. **If behind main**, ask user if they want to rebase:
   - If yes: `git rebase origin/main`
   - If no: inform that they should rebase before creating PR
