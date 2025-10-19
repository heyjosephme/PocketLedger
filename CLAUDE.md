# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

PocketLedger is a Ruby on Rails 8.0 application using:
- Ruby 3.4.4
- SQLite database with Solid Cache, Solid Queue, and Solid Cable
- Hotwire (Turbo Rails + Stimulus) for frontend interactions
- Kamal for Docker deployment
- Standard Rails MVC architecture

## Development Commands

### Server and Development
- `bin/dev` - Start Rails development server
- `bin/rails server` - Alternative server start command
- `bin/rails console` - Rails console
- `bin/rails dbconsole` - Database console

### Testing and Quality
- `bin/rails test` - Run full test suite (uses parallel testing)
- `bin/rails test test/path/to/specific_test.rb` - Run specific test file
- `bin/rails test:system` - Run system tests only
- `bin/brakeman` - Security vulnerability scanning
- `bin/rubocop` - Code style linting (Rails Omakase rules)

## Development Workflow

### Test-Driven Development (TDD)
**IMPORTANT**: This project follows strict Test-Driven Development practices.

#### TDD Process (RED-GREEN-REFACTOR)
1. **RED**: Write failing tests first
   - Write unit tests for models/controllers
   - Write system tests for user-facing features
   - Run tests and confirm they fail: `bin/rails test`

2. **GREEN**: Write minimal code to make tests pass
   - Implement the feature
   - Run tests until all pass: `bin/rails test`

3. **REFACTOR**: Improve code quality
   - Clean up implementation
   - Run linter: `bin/rubocop`
   - Ensure tests still pass

#### Testing Guidelines
- **Always write tests before implementation**
- **Unit tests** for models, controllers, helpers
- **System tests** for end-to-end user flows (login, navigation, forms)
- **Run full test suite** before committing: `bin/rails test && bin/rubocop`
- **All tests must pass** before creating pull requests
- Target: Maintain high test coverage for all features

### Git Workflow
**IMPORTANT**: Always create a feature branch for each issue. Never commit directly to `main`.

#### Branch Naming Convention
- Format: `feature/[issue-number]-[short-description]`
- Examples:
  - `feature/21-authenticated-user-routing`
  - `feature/24-rate-limiting-security`
  - `feature/25-data-export-csv-pdf`

#### Development Process for Each Issue
1. **Create Feature Branch**
   ```bash
   git checkout -b feature/[issue-number]-[description]
   ```

2. **Develop Using TDD** (RED-GREEN-REFACTOR)
   - Write failing tests first
   - Implement feature to make tests pass
   - Refactor and clean up code
   - Run full test suite: `bin/rails test && bin/rubocop`

3. **Commit Changes**
   - Use descriptive commit messages
   - Reference issue number in commit message
   - Include test results and acceptance criteria
   - Always add Claude Code attribution:
     ```
     🤖 Generated with [Claude Code](https://claude.com/claude-code)

     Co-Authored-By: Claude <noreply@anthropic.com>
     ```

4. **Push and Create Pull Request**
   ```bash
   git push -u origin feature/[issue-number]-[description]
   gh pr create --title "feat: [Feature description] (#[issue-number])" --body "[PR description]"
   ```

5. **Merge Pull Request**
   ```bash
   gh pr merge [pr-number] --squash --delete-branch
   ```

6. **Update Main Branch Locally**
   ```bash
   git checkout main
   git pull origin main
   ```

7. **Close Issue**
   ```bash
   gh issue close [issue-number] --comment "[Completion message]"
   ```

#### Commit Message Format
```
feat|fix|docs|refactor|test: [Short description]

Implements Issue #[number] - [Issue title]

[Detailed description of changes]

Model/Controller/View Changes:
- [Specific changes listed]

Tests (TDD):
- [Test coverage details]
- ✅ All [X] tests passing
- ✅ RuboCop clean (0 offenses)

Acceptance Criteria Met:
✅ [Criteria 1]
✅ [Criteria 2]

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

### Database
- `bin/rails db:migrate` - Run migrations
- `bin/rails db:create` - Create database
- `bin/rails db:seed` - Seed database

### Deployment
- `bin/kamal deploy` - Deploy via Kamal
- `bin/kamal console` - Remote Rails console
- `bin/kamal shell` - Remote shell access
- `bin/kamal logs` - View application logs

## Design Philosophy

### UI/UX Style: Silicon Valley Startup Aesthetic
**IMPORTANT**: PocketLedger follows a **modern, startup-style design** inspired by companies like Linear, Vercel, and RemoteOK.

#### Target Audience
- **Primary**: Tech-savvy IT freelancers (developers, designers, consultants)
- **Market**: Japanese freelancers (個人事業主) who need expense tracking for tax filing (確定申告)
- **Positioning**: Simple, modern alternative to traditional Japanese accounting software (Freee, Money Forward)

#### Design Principles
1. **Bold Typography**
   - Use large, extrabold headings (text-5xl to text-7xl)
   - Clean, tight tracking (tracking-tight)
   - Clear hierarchy with font weights (extrabold, semibold, medium)

2. **Generous Whitespace**
   - Spacious padding (py-20, py-32 for sections)
   - Ample gaps between elements (gap-6, gap-8, gap-12)
   - Breathing room around all UI elements

3. **Large Rounded Corners**
   - Cards and buttons: rounded-xl (12px), rounded-2xl (16px)
   - Feature cards: rounded-3xl (24px)
   - Avoid small or sharp corners

4. **Vibrant Gradients**
   - Primary brand: blue-600 → cyan-500
   - Accent gradients: green-600 → emerald-500, purple-600 → fuchsia-500
   - Use gradients for visual interest, not everywhere

5. **Hover Effects and Transitions**
   - Scale on hover (hover:scale-105)
   - Shadow changes (hover:shadow-md, hover:shadow-lg)
   - Smooth transitions (transition-all duration-200)
   - Border color changes

6. **Color Palette**
   - **Primary**: Blue-600 (#2563eb)
   - **Backgrounds**: White, slate-50 (alternating sections)
   - **Text**: Gray-900 (headings), Gray-700 (body), Gray-500 (subtle)
   - **Accents**: Cyan-500, Green-600, Purple-600

7. **Copy Tone**
   - **Direct and punchy**: "Stop losing receipts. Start saving on taxes."
   - **No BS**: Avoid corporate jargon
   - **Relatable examples**: Reference AWS, GitHub, Netflix (familiar to IT freelancers)
   - **Action-oriented**: Use strong verbs

8. **Layout**
   - **Spacious sections**: py-20 to py-32 between major sections
   - **Alternating backgrounds**: white/slate-50 for visual rhythm
   - **Centered content**: max-w-7xl mx-auto
   - **Responsive grids**: grid-cols-1 md:grid-cols-2 lg:grid-cols-3

#### What to Avoid
- ❌ Small, cramped layouts
- ❌ Tiny fonts (nothing smaller than text-xs)
- ❌ Sharp corners (rounded-sm, rounded-md)
- ❌ Dull, flat colors
- ❌ Corporate/traditional Japanese design aesthetic
- ❌ Dense, cluttered UI

#### Reference Examples
- **Landing pages**: Linear, Vercel, RemoteOK
- **Forms**: Modern SaaS applications (Stripe, Notion)
- **Navigation**: Minimal, clean headers (not busy menus)

#### Tailwind CSS Usage
- **Always use Tailwind classes** (no custom CSS unless absolutely necessary)
- **Responsive design**: mobile-first, use md: and lg: breakpoints
- **Dark mode**: Not implemented yet (future consideration)

## Architecture

### Core Structure
- **Application Module**: `PocketLedger::Application` (config/application.rb:9)
- **Database**: SQLite with Solid adapters for caching, queuing, and cable
- **Frontend**: Uses Importmap for JS modules, Stimulus controllers in app/javascript/controllers/
- **Styling**: Tailwind CSS (via CDN in development, compiled for production)

### Key Rails Configuration
- Rails 8.0 with default configurations loaded
- Autoloads lib/ directory (excluding assets and tasks)
- Uses Solid Queue in Puma process for background jobs (`SOLID_QUEUE_IN_PUMA: true`)
- Test parallelization enabled using number of processors

### Testing Setup
- Minitest framework with parallel test execution
- System tests use Capybara with Selenium WebDriver
- Test helpers in test/test_helper.rb with fixtures support

### Deployment
- Dockerized application using Kamal
- Configured for single-server deployment with SSL via Let's Encrypt
- Persistent storage volume for SQLite and Active Storage files