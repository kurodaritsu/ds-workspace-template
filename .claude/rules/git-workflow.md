# Git Workflow

The `main` branch is protected. Never commit directly to `main`.

All work must be done on a feature branch or in a separate worktree:

```bash
git checkout -b <branch-name>
```

Or use Claude Code's built-in worktree support via the `superpowers:using-git-worktrees` skill.
