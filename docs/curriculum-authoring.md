# Curriculum Authoring

Lessons are currently authored in code in `lib/codie/curriculum/catalog.ex`.

## Lesson Shape

Each lesson is a `%Codie.Curriculum.Lesson{}` with:

- `slug`
- `title`
- `track_slug`
- `tier`
- `summary`
- `teaching_markdown`
- `starter_code`
- `checks`
- `hints`
- `rewards`
- `prerequisites`
- `estimated_minutes`
- `codex_entries_unlocked`

## Supported Checks

- `:returns`
  - Asserts the final expression returns the expected value.
- `:binds`
  - Asserts a variable in the top-level binding has the expected value.
- `:ast_contains`
  - Checks for a required syntax snippet in the parsed AST source.
- `:module_function`
  - Loads the defined module and calls a function with fixed arguments.

## Adding a Lesson

1. Add a new `lesson(...)` entry in the appropriate order.
2. Set `prerequisites` to earlier lesson slugs.
3. Keep starter code runnable or close to runnable.
4. Add at least one clear success check.
5. Add staged hints that progress from conceptual guidance to syntax direction to near-solution guidance.
6. Add a codex entry if the lesson introduces a durable concept.

## Adding a New Track

1. Add the track metadata to `tracks/0`.
2. Add its lessons to `lessons/0`.
3. Ensure the previous track is completable so the new track can unlock.

The current implementation keeps curriculum data in one file for simplicity. If the content grows substantially, the next clean refactor is to split each track into its own module under `lib/codie/curriculum/`.
