# GameRadar

A Ruby on Rails web application for discovering and discussing video games. GameRadar integrates with the [GiantBomb API](https://www.giantbomb.com/api/) to let users search a massive games database, save titles to their personal library, and post forum discussions on any game.

---

## Features

- **Game search** — search the GiantBomb database and automatically import results (name, description, platforms, release date, cover image)
- **Game library** — browse, add, edit and delete saved games
- **Forums** — authenticated users can create, edit and delete discussion threads tied to individual games
- **User authentication** — full sign-up / sign-in / password reset flow via Devise
- **Contact form** — sends an email to the site owner via Action Mailer

---

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Ruby 2.6.3 |
| Framework | Rails 5.2.4 |
| Database | SQLite3 |
| Templating | HAML |
| CSS | Bootstrap 3 (via `bootstrap-sass`) |
| JS | jQuery, CoffeeScript, Turbolinks |
| Auth | Devise |
| External API | GiantBomb (`giantbomb-api` gem) |
| Testing | Minitest, Capybara, Selenium |

---

## Prerequisites

> **Note on Ruby version:** This project requires **Ruby 2.6.3**, which is end-of-life. Your system Ruby is likely newer. The recommended approach is to install a version manager so you can run 2.6.3 in isolation without touching your system Ruby.

### Install Ruby 2.6.3

**Option A — rbenv (recommended)**

```bash
# Install rbenv (macOS with Homebrew)
brew install rbenv ruby-build
rbenv install 2.6.3
# rbenv will pick up the .ruby-version file automatically
```

**Option B — rvm**

```bash
rvm install 2.6.3
rvm use 2.6.3
```

**Option C — system Ruby**

If your system Ruby is already 2.6.x you can proceed, but be aware gem conflicts with other projects are likely.

### Other dependencies

- **Bundler** — `gem install bundler`
- **SQLite3** — usually pre-installed on macOS; on Linux: `sudo apt install sqlite3 libsqlite3-dev`
- **Node.js** — required by the `mini_racer` gem for asset compilation (`brew install node` or via [nvm](https://github.com/nvm-sh/nvm))
- **ChromeDriver** — required for system tests (`brew install chromedriver` or via the `chromedriver-helper` gem, which handles this automatically)

### GiantBomb API key

The app requires a free GiantBomb API key to search and import games.

1. Register at [giantbomb.com/api](https://www.giantbomb.com/api/) to get your key.
2. Create a `.env` file in the project root:

```
GIANTBOMB_API_KEY=your_api_key_here
```

The key is loaded via `dotenv-rails` and consumed in `config/initializers/giantbomb.rb`.

---

## Setup

```bash
# 1. Clone the repository
git clone <repo-url>
cd GameRadar

# 2. Install gems
bundle install

# 3. Configure your API key (see above)
cp .env.example .env   # if provided, otherwise create .env manually

# 4. Create and migrate the database
rails db:create db:migrate

# 5. (Optional) Seed the database with sample games from GiantBomb
#    Requires a valid GIANTBOMB_API_KEY in .env
rails db:seed
```

---

## Running the App

```bash
rails server
```

Visit [http://localhost:3000](http://localhost:3000).

> The search page (`/search`) requires a user account. Register at `/users/sign_up`.

---

## Application Structure

### Routes

| Method | Path | Description |
|---|---|---|
| `GET` | `/` | Home page |
| `GET` | `/search` | Search GiantBomb (auth required) |
| `GET` | `/contact` | Contact form |
| `POST` | `/request_contact` | Submit contact form |
| `GET` | `/games` | Browse saved games |
| `GET` | `/games/:id` | Game detail page |
| `GET` | `/forums` | All forum posts |
| `GET` | `/forums/:id` | Single forum post |
| Various | `/users/...` | Devise auth routes |

### Data Model

```
User
 └── has_many :forums

Game
 └── has_many :forums (dependent: destroy)

Forum
 ├── belongs_to :user
 └── belongs_to :game
```

**Games** are imported from GiantBomb and stored locally with: name, description (deck), platforms, original release date, expected release date, cover image URL, and GiantBomb ID.

**Forums** are user-authored discussion threads scoped to a specific game.

---

## Testing

Run the full test suite:

```bash
rails test
```

Run system tests (requires ChromeDriver and a running browser):

```bash
rails test:system
```

Run a specific test file:

```bash
rails test test/models/game_test.rb
```

---

## Known Issues & Compatibility Notes

- **Ruby 2.6.3 is EOL** — the bundled gems (`puma ~> 3.11`, `listen < 3.2`, `chromedriver-helper`) are pinned to versions compatible with this Ruby. Do not upgrade them without also upgrading Ruby and Rails.
- **`chromedriver-helper` is deprecated** — if you encounter ChromeDriver issues with newer versions of Chrome, replace it with `webdrivers` in the `Gemfile` (`gem 'webdrivers'` in the `:test` group).
- **GiantBomb API rate limits** — the free API tier has rate limits. Seeding the full `db/seeds.rb` file (15 games) may occasionally fail if requests are made too quickly.
- **Asset pipeline** — this project uses Sprockets (Rails 5.2 default), not Webpacker. JavaScript is served via `coffee-rails` and `jquery-rails`.

---

## Contact

Questions or feedback? Use the in-app contact form or open an issue on GitHub.

*Powered by the [GiantBomb API](https://www.giantbomb.com/api/)*
