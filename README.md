# Debt Wanchor

Debt Wanchor compares WaniKani lesson and review workloads for two or more users and can publish the result to Discord.

## Requirements

- Ruby 3.1.2
- Bundler 2.4.18
- MySQL
- Redis when running Sidekiq

The examples below use `rbenv` on macOS. Equivalent Ruby and service managers are fine.

## Local Setup

Install and select the expected Ruby version:

```bash
rbenv install 3.1.2
rbenv local 3.1.2
gem install bundler -v 2.4.18
```

Install the project gems:

```bash
bundle install
```

Start MySQL and confirm it is available through the socket configured in `config/database.yml`:

```bash
brew services start mysql
mysqladmin --socket=/tmp/mysql.sock --user=root ping
```

Prepare the development and test databases:

```bash
bundle exec rails db:prepare
RAILS_ENV=test bundle exec rails db:prepare
```

The default database configuration expects a local MySQL `root` user with no password. Use `DATABASE_URL` if your local setup differs.

## Credentials

Edit Rails credentials:

```bash
EDITOR="code --wait" bundle exec rails credentials:edit
```

Add one WaniKani API key for each application user. The credential name must match the user's name:

```yaml
robert_wanikani_api_key: your_wanikani_api_key
peer_wanikani_api_key: their_wanikani_api_key
wanikani_discord_webhook_url: your_discord_webhook_url
```

The Discord webhook can instead be provided through the environment:

```bash
export WANIKANI_DISCORD_WEBHOOK_URL="your_discord_webhook_url"
```

Never commit API keys, webhook URLs, `config/master.key`, or decrypted credentials.

## Running Tests

The model and service tests stub WaniKani and Discord, so they do not make real network calls or require real API credentials.

Run the full Rails test suite:

```bash
rbenv exec bundle exec rails test
```

Run a focused test file:

```bash
rbenv exec bundle exec rails test test/models/home_test.rb
rbenv exec bundle exec rails test test/services/base_discord_service_test.rb
```

Run a specific test by line number:

```bash
rbenv exec bundle exec rails test test/models/home_test.rb:43
```

If Rails reports pending test migrations, run:

```bash
RAILS_ENV=test rbenv exec bundle exec rails db:migrate
```

## Running the App

Start Rails:

```bash
rbenv exec bundle exec rails server
```

Open `http://localhost:3000`.

## Running Background Jobs

Start Redis, then Sidekiq:

```bash
brew services start redis
rbenv exec bundle exec sidekiq
```

The recurring job schedule is defined in `config/schedule.yml`.
