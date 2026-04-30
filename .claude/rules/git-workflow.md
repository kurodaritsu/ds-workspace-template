# Git Workflow

The `main` branch is protected. Never commit directly to `main`.

## Working in Isolation

All work must be done on a feature branch or in a git worktree. Choose whichever fits the task:

**Feature branch** — simpler, works in the current directory:
```bash
git checkout -b <branch-name>
```

**Git worktree** — better for larger or parallel tasks; keeps work isolated from the current workspace. Worktrees live under `.worktrees/`:
```bash
# Create a new worktree on a new branch
git worktree add .worktrees/<branch-name> -b <branch-name>

# Or check out an existing branch into a new worktree
git worktree add .worktrees/<branch-name> <branch-name>

# List active worktrees
git worktree list

# Remove a worktree when done
git worktree remove .worktrees/<branch-name>
```

## Commit Signoffs

All commits must include a developer sign-off. Always use the `-s` flag:

```bash
git commit -s -m "your message"
```

This appends a `Signed-off-by` trailer to the commit, satisfying the repository's DCO requirement.

Do not write `Signed-off-by` manually in the commit message body when using `-s` — git adds it automatically from your git config, and a duplicate trailer is just noise.
