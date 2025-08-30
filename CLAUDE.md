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
- `bin/brakeman` - Security vulnerability scanning
- `bin/rubocop` - Code style linting (Rails Omakase rules)

### Database
- `bin/rails db:migrate` - Run migrations
- `bin/rails db:create` - Create database
- `bin/rails db:seed` - Seed database

### Deployment
- `bin/kamal deploy` - Deploy via Kamal
- `bin/kamal console` - Remote Rails console
- `bin/kamal shell` - Remote shell access
- `bin/kamal logs` - View application logs

## Architecture

### Core Structure
- **Application Module**: `PocketLedger::Application` (config/application.rb:9)
- **Database**: SQLite with Solid adapters for caching, queuing, and cable
- **Frontend**: Uses Importmap for JS modules, Stimulus controllers in app/javascript/controllers/
- **Styling**: CSS in app/assets/stylesheets/application.css

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