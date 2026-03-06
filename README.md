# Codie

Codie is a local-first Phoenix app that teaches Elixir like a small RPG.

You keep a digital developer awake by completing real Elixir lessons. Each lesson gives you starter code, runs your submission through Codie's local checker, and rewards progress with coffee beans, XP, and restored stats.

## Current Build

- Phoenix 1.8 + LiveView app
- SQLite persistence
- Playable `Foundations` track with 19 guided lessons plus 1 boss lesson
- Real in-app Elixir code evaluation with lesson checks
- Dashboard, world map, lesson workspace, codex, and profile screens
- Local progression, streak, and stat tracking

## Local Setup

1. Install Elixir/Erlang (the app is currently running on Elixir `1.19.x` and OTP `28`).
2. Fetch dependencies and prepare the database:

   ```bash
   mix setup
   ```

3. Start the server:

   ```bash
   mix phx.server
   ```

4. Open `http://localhost:4000`.

## Tests

Run the suite with:

```bash
mix test
```

## Project Structure

- `lib/codie/curriculum.ex` and `lib/codie/curriculum/*`: lesson and track registry
- `lib/codie/progress.ex`: persistence, unlocks, and progression updates
- `lib/codie/game.ex`: XP, rewards, and stat math
- `lib/codie/runner.ex`: local submission checking
- `lib/codie_web/live/*`: LiveView UI
- `docs/architecture.md`: system overview
- `docs/curriculum-authoring.md`: how to add lessons
- `docs/runner-sandbox.md`: checker design and guardrails
- `docs/roadmap.md`: future curriculum expansion

## Important Notes

- This build is intentionally local-only and single-user.
- The runner is isolated from the main request flow, but it is designed for a trusted local user, not hostile internet traffic.
- The current vertical slice fully focuses on Elixir fundamentals; the rest of the expert roadmap is scaffolded and ready for additional authored content.
