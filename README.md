# PocketLedger

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL_v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

Expense tracking application for freelancers and small businesses.

## Features

- 💰 Track business and personal expenses
- 📊 Categorize expenses by type and vendor
- 🔐 Secure authentication with Devise
- 📱 Responsive UI with Tailwind CSS

## Planned Features

See our [roadmap issues](https://github.com/heyjosephme/PocketLedger/issues) for upcoming features:
- 📎 Receipt/invoice attachments
- 💳 Subscription plans with Stripe
- 🔄 Recurring expenses
- 🤖 OCR for automatic data extraction
- 📈 Data visualization and analytics

## Tech Stack

- Ruby 3.4.4
- Rails 8.0
- SQLite with Solid adapters (Cache, Queue, Cable)
- Hotwire (Turbo + Stimulus)
- Tailwind CSS
- Kamal for deployment

## Getting Started

```bash
# Install dependencies
bundle install

# Setup database
bin/rails db:create db:migrate db:seed

# Start development server
bin/dev

# Run tests
bin/rails test
```

Visit `http://localhost:3000`

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development workflow and guidelines.

## License

This project is licensed under the AGPL-3.0 License - see the [LICENSE](LICENSE) file for details.
