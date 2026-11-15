# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

"Spendly" is a Flask + SQLite expense tracker built as a step-by-step teaching project. Much of it is intentionally unbuilt: placeholder code is labelled with the step number that implements it ("coming in Step 7", "Students will write this file in Step 1"). Keep those step labels when touching nearby code, and replace a placeholder only when implementing its step.

## Commands

```bash
source venv/bin/activate          # local virtualenv (git-ignored)
pip install -r requirements.txt
python app.py                     # dev server, debug mode, http://localhost:5001
pytest                            # no tests exist yet; pytest + pytest-flask are installed
pytest tests/test_x.py::test_name # run a single test
```

There is no linter, formatter, or build step. Port 5001 is set in `app.py` (not the Flask default 5000).

## Architecture

- **`app.py`** is the only Python module with logic: it creates the `app` object and defines every route. Implemented routes (`/`, `/login`, `/register`, `/terms`, `/privacy`) only call `render_template`; the login and register forms don't yet have POST handlers. The remaining routes (`/logout`, `/profile`, `/expenses/add`, `/expenses/<id>/edit`, `/expenses/<id>/delete`) return placeholder strings.
- **`database/db.py`** is a comment-only stub describing three functions to write: `get_db()` (SQLite connection with `row_factory` and foreign keys enabled), `init_db()` (`CREATE TABLE IF NOT EXISTS`), and `seed_db()` (sample data). Nothing imports it yet. The `.gitignore` already expects the DB file to be named `expense_tracker.db`.
- **`templates/`**: every page extends `base.html`, which provides the navbar, footer, Google Fonts, and `style.css`. Child templates fill these blocks: `title`, `head` (extra CSS), `content`, and `scripts` (extra JS before `</body>`). Link between pages with `url_for('<function name>')`, using the route function names from `app.py` (e.g. `landing`, `login`, `register`), not hard-coded paths.
- **`static/css/`**: `style.css` holds global styles and the CSS variables (e.g. `--accent`). `landing.css` is page-specific, loaded via the `head` block after `style.css`, and relies on that order to override it. Follow this pattern (a per-page stylesheet in `{% block head %}`) for new pages.
- **`static/js/main.js`** is an empty placeholder loaded on every page. Page-specific JS currently lives inline in `{% block scripts %}` (see the video modal in `landing.html`).

## Conventions

- Currency is rupees (₹); user-facing copy uses that framing.
- The navbar in `base.html` always shows "Sign in" and "Get started". It has no logged-in state yet. Auth (Steps 2-3) will need to change it.
- There is no `SECRET_KEY` and no session handling yet. Login, flash messages, and logout all need one.
