# Developer Coordination Log

> This file tracks active work to prevent conflicts between developers.
> **Always check this file before starting work. Always update it when claiming or completing a task.**

---

## Active Tasks

| Developer | Task ID | Description | Branch | Started |
|-----------|---------|-------------|--------|---------|
| — | — | No active tasks | — | — |

## File Locks

Files currently being modified by a developer. **Do not edit locked files without coordination.**

| File/Directory | Locked By | Task | Since |
|----------------|-----------|------|-------|
| — | — | — | — |

---

## Shared Files (Require Coordination)

These files are commonly touched by multiple developers. Extra care needed:

| File | Why Shared |
|------|------------|
| _TODO: Add shared files for your project_ | _reason_ |

**Rule**: If you need to edit a shared file, check the lock table first. If it's locked, coordinate with the other dev or wait.

---

## Completed Tasks

| Developer | Task ID | Description | Branch | Completed | PR |
|-----------|---------|-------------|--------|-----------|-----|

---

## Conflict Resolution Protocol

1. **Before starting**: Read this file, check Active Tasks and File Locks
2. **Claiming work**: Add your task to Active Tasks, add file locks
3. **Shared file needed**: Check if locked -> if yes, coordinate; if no, lock it
4. **Finishing work**: Move task to Completed, remove file locks
5. **Merge conflict**: The developer who merges second resolves conflicts
6. **Disagreement**: Both devs discuss before proceeding
