# Architecture

## Stack

- Phoenix 1.8
- Phoenix LiveView
- SQLite via `ecto_sqlite3`
- Tailwind CSS 4
- Local, supervised Elixir runner for lesson validation

## Main Contexts

- `Codie.Curriculum`
  - Static track and lesson registry.
  - Encodes prerequisites, hints, rewards, and codex unlocks.
- `Codie.Progress`
  - Owns the single local profile.
  - Persists lesson attempts, submissions, unlocks, and track completion.
  - Applies streak and daily decay logic.
- `Codie.Game`
  - Converts lesson rewards into XP, coffee, and stat changes.
- `Codie.Runner`
  - Evaluates learner code.
  - Parses code, rejects blocked APIs, runs the submission, and checks lesson rules.

## UI

The UI is LiveView-first:

- `DashboardLive`: current state, next lesson, recent runs
- `TrackMapLive`: lesson graph for a track
- `LessonLive`: editor, hints, runner output, reward flow
- `CodexLive`: unlocked reference notes
- `ProfileLive`: stats and historical progress

The layout and styles are custom rather than default Phoenix scaffolding. The visual direction is a warm “coffee lab” interface intended to feel more like a game than a CRUD dashboard.

## Persistence Model

SQLite stores:

- one `profiles` row for the local player
- lesson and track progress
- historical submission runs
- codex unlocks
- daily state events

## Runtime Flow

1. The dashboard loads or creates the local profile.
2. Daily decay is applied once per calendar day if needed.
3. The user opens a lesson and edits starter code.
4. The lesson is submitted to `Codie.Runner`.
5. The runner returns a normalized result.
6. `Codie.Progress` records the attempt and, on success, grants rewards and unlocks the next lesson.
