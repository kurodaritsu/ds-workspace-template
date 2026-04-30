```markdown
# ds-workspace-template Development Patterns

> Auto-generated skill from repository analysis

## Overview

This skill documents the core development patterns, coding conventions, and automation workflows used in the `ds-workspace-template` TypeScript codebase. It covers file organization, import/export styles, commit message patterns, and the processes for maintaining linting, formatting, and type-checking rules, as well as documentation consolidation.

## Coding Conventions

### File Naming

- Use **camelCase** for file names.
  - Example: `myUtility.ts`, `userProfile.test.ts`

### Imports

- Use **relative imports** for modules within the project.
  - Example:
    ```typescript
    import { myFunction } from './utils/myUtility';
    ```

### Exports

- Use **named exports** for all modules.
  - Example:
    ```typescript
    // utils/myUtility.ts
    export function myFunction() { /* ... */ }
    ```

### Commit Messages

- Freeform style, no strict prefixes.
- Average message length: ~58 characters.

## Workflows

### Update Lint, Type-Check Rules, and Hooks

**Trigger:** When updating or improving linting, formatting, or type-checking workflows, rules, or automation scripts.  
**Command:** `/update-lint-type-workflow`

1. Modify or expand documentation in `.claude/rules/` (e.g., `lint-and-format.md`, `type-checking.md`) to include new commands, flags, or guidance.
2. Update corresponding automation hook scripts in `.claude/hooks/` (e.g., `ruff_lint.sh`, `ty_check.sh`) to reflect new behaviors or formats.
3. Ensure consistency in messaging and output between documentation and hooks.

**Example:**
```bash
# Update linting script
vim .claude/hooks/ruff_lint.sh

# Edit documentation
vim .claude/rules/lint-and-format.md
```

### Deprecate and Absorb Skills into Rules

**Trigger:** When simplifying documentation by merging skill content into rule references and cleaning up old skill files.  
**Command:** `/absorb-skills-into-rules`

1. Expand rule files in `.claude/rules/` to absorb content from `.claude/skills/` (e.g., commands, examples, references).
2. Delete the now-redundant skill files from `.claude/skills/`.
3. Update any project documentation (e.g., `CLAUDE.md`) to reflect the new structure.

**Example:**
```bash
# Move content from skill to rule
cat .claude/skills/ruff-lint/SKILL.md >> .claude/rules/lint-and-format.md

# Remove old skill files
rm -rf .claude/skills/ruff-lint/
```

## Testing Patterns

- **Test files** follow the pattern `*.test.*` (e.g., `userProfile.test.ts`).
- **Testing framework** is not explicitly defined; check for framework usage in test files.
- Place tests alongside the modules they test or in a dedicated `tests/` directory.

**Example:**
```typescript
// userProfile.test.ts
import { getUserProfile } from './userProfile';

test('returns correct user profile', () => {
  // ...test implementation
});
```

## Commands

| Command                     | Purpose                                                                                   |
|-----------------------------|-------------------------------------------------------------------------------------------|
| /update-lint-type-workflow  | Update linting, formatting, and type-checking rules and their automation hooks            |
| /absorb-skills-into-rules   | Migrate skill documentation into rule files and remove redundant skill files              |
```
