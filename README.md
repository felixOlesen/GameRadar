# GameRadar

![Ruby](https://img.shields.io/badge/Ruby-2.7.5-CC342D?logo=ruby&logoColor=white)
![Rails](https://img.shields.io/badge/Rails-5.2.4-CC0000?logo=rubyonrails&logoColor=white)
![SQLite](https://img.shields.io/badge/Database-SQLite3-003B57?logo=sqlite&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-ready-2496ED?logo=docker&logoColor=white)

A Ruby on Rails web application for discovering and discussing video games. GameRadar integrates with the [GiantBomb API](https://www.giantbomb.com/api/) to let users search a massive games database, save titles to their personal library, and post forum discussions on any game.

<!-- Add a screenshot or GIF of the app here. Example:
![GameRadar screenshot](docs/screenshot.png)
-->

---

## Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
  - [GiantBomb API Key](#giantbomb-api-key)
  - [Running with Docker](#running-with-docker-recommended)
  - [Manual Setup](#manual-setup)
- [Application Structure](#application-structure)
- [Testing](#testing)
- [Known Issues & Compatibility Notes](#known-issues--compatibility-notes)
- [Contact](#contact)

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
| Language | Ruby 2.7.5 |
| Framework | Rails 5.2.4 |
| Database | SQLite3 |
| Templating | HAML |
| CSS | Bootstrap 3 (via `bootstrap-sass`) |
| JS | jQuery, CoffeeScript, Turbolinks |
| Auth | Devise |
| External API | GiantBomb (`giantbomb-api` gem) |
| Testing | Minitest, Capybara, Selenium |

---

## Getting Started

### GiantBomb API Key

The app requires a free GiantBomb API key to search and import games.

1. Register at [giantbomb.com/api](https://www.giantbomb.com/api/) to get your key.
2. Create a `.env` file in the project root:

   ```
   GIANTBOMB_API_KEY=your_api_key_here
   ```

The key is loaded via `dotenv-rails` and consumed in `config/initializers/giantbomb.rb`.

---

### Running with Docker (Recommended)

Docker is the easiest way to run GameRadar — it handles Ruby 2.7.5, all system dependencies, and database setup automatically.

**Prerequisite:** [Docker Desktop](https://www.docker.com/products/docker-desktop/) (includes Docker Compose)

1. Create your `.env` file with your GiantBomb API key (see above).

2. Build and start the app:

   ```bash
   docker-compose up --build
   ```

   The first run installs all gems and builds the image — subsequent starts are much faster. The container automatically runs `db:create` and `db:migrate` before starting the server.

3. Visit [http://localhost:3000](http://localhost:3000).

To stop the app press `Ctrl+C`, or run `docker-compose down` to remove the containers entirely.

> [!TIP]
> Code changes are reflected immediately — the project directory is mounted into the container, so you don't need to rebuild after editing files.

---

### Manual Setup

> [!WARNING]
> This project requires **Ruby 2.7.5**, which is end-of-life. The recommended approach is Docker (above). If you need to run without Docker, use a version manager to install 2.7.5 in isolation.

<details>
<summary><strong>Expand manual setup instructions</strong></summary>

#### Install Ruby 2.7.5

**Option A — rbenv (recommended)**

```bash
brew install rbenv ruby-build
rbenv install 2.7.5
# rbenv will pick up the .ruby-version file automatically
```

**Option B — rvm**

```bash
rvm install 2.7.5
rvm use 2.7.5
```

**Option C — system Ruby**

If your system Ruby is already 2.7.x you can proceed, but gem conflicts with other projects are likely.

#### Other dependencies

- **Bundler** — `gem install bundler`
- **SQLite3** — usually pre-installed on macOS; on Linux: `sudo apt install sqlite3 libsqlite3-dev`
- **Node.js** — required by the `mini_racer` gem for asset compilation (`brew install node` or via [nvm](https://github.com/nvm-sh/nvm))
- **ChromeDriver** — required for system tests (`brew install chromedriver` or via the `chromedriver-helper` gem)

#### Setup

```bash
# 1. Clone the repository
git clone <repo-url>
cd GameRadar

# 2. Install gems
bundle install

# 3. Configure your API key (see above)
cp .env.example .env   # or create .env manually

# 4. Create and migrate the database
rails db:create db:migrate

# 5. (Optional) Seed with sample games from GiantBomb
rails db:seed
```

#### Run

```bash
rails server
```

Visit [http://localhost:3000](http://localhost:3000).

> [!NOTE]
> The search page (`/search`) requires a user account. Register at `/users/sign_up`.

</details>

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

```bash
# Full test suite
rails test

# System tests (requires ChromeDriver and a running browser)
rails test:system

# Single file
rails test test/models/game_test.rb
```

---

## Known Issues & Compatibility Notes

> [!WARNING]
> **Ruby 2.7.5 is EOL** — several gems (`puma`, `sqlite3`, `nokogiri`, `nio4r`, `ffi`, `mini_racer`) are pinned to versions compatible with Ruby 2.7 and Apple Silicon. Do not loosen these constraints without also upgrading Ruby.

> [!NOTE]
> **`chromedriver-helper` is deprecated** — if you encounter ChromeDriver issues with newer Chrome versions, replace it with `webdrivers` in the `Gemfile` (`gem 'webdrivers'` in the `:test` group).

> [!NOTE]
> **GiantBomb API rate limits** — the free tier has rate limits. Seeding the full `db/seeds.rb` file (15 games) may occasionally fail if requests are made too quickly.

> [!NOTE]
> **Asset pipeline** — this project uses Sprockets (Rails 5.2 default), not Webpacker. JavaScript is served via `coffee-rails` and `jquery-rails`.

---

## Contact

Questions or feedback? Use the in-app contact form or open an issue on GitHub.

*Powered by the [GiantBomb API](https://www.giantbomb.com/api/)*
