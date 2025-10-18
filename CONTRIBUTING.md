# Contributing to PocketLedger

## Development Workflow

### 1. Pick an Issue
- Browse [open issues](https://github.com/heyjosephme/PocketLedger/issues)
- Look for issues tagged with `priority: high` for immediate impact
- Comment on the issue to claim it

### 2. Create a Feature Branch
```bash
# Update main branch
git checkout main
git pull origin main

# Create feature branch
git checkout -b feature/issue-number-brief-description
# Example: git checkout -b feature/11-receipt-attachments
```

### 3. Development
- Make small, focused commits
- Follow Rails conventions and style guide
- Write tests for new features
- Run tests before committing: `bin/rails test`

### 4. Commit Messages
Follow the conventional commit format:
```
type: brief description

Longer explanation if needed

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

Types:
- `feat:` - New feature
- `fix:` - Bug fix
- `chore:` - Maintenance tasks
- `docs:` - Documentation
- `test:` - Test changes
- `refactor:` - Code refactoring

### 5. Create Pull Request
```bash
# Push your branch
git push -u origin feature/issue-number-brief-description

# Create PR using gh CLI
gh pr create --title "feat: brief description" --body "Closes #issue-number

## Summary
- Change 1
- Change 2

## Test Plan
- [ ] Manual testing completed
- [ ] All tests passing
- [ ] No new warnings"
```

### 6. Code Review
- Address review feedback
- Keep PR conversations focused
- Update PR as needed

### 7. Merge
- Squash and merge when approved
- Delete feature branch after merge

## Branch Protection (Manual Setup)

To protect the `main` branch, configure these settings in GitHub:

1. Go to Settings → Branches → Add rule
2. Branch name pattern: `main`
3. Enable:
   - ✅ Require pull request before merging
   - ✅ Require approvals: 1 (if working with others)
   - ✅ Require status checks to pass (when CI is set up)
   - ✅ Do not allow bypassing the above settings

## Running Tests

```bash
# Run all tests
bin/rails test

# Run specific test file
bin/rails test test/models/expense_test.rb

# Run with coverage
COVERAGE=true bin/rails test
```

## Code Quality

```bash
# Run linter
bin/rubocop

# Auto-fix issues
bin/rubocop -A

# Security scan
bin/brakeman
```

## Local Development

```bash
# Start server
bin/dev

# Console
bin/rails console

# Database
bin/rails db:migrate
bin/rails db:seed
```

## Questions?

Open an issue or discussion on GitHub!
