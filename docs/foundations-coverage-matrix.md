# Foundations Coverage Matrix (Legacy Track)

This document now describes the archived `foundations-old` track.

The active beginner-first track is `foundations`, which is being rebuilt around datatype mastery blocks.

We use only:
- Elixir official Getting Started guide: https://elixir-lang.org/getting-started/introduction.html
- Elixir HexDocs API reference: https://hexdocs.pm/elixir/
- Elixir School basics as a secondary sanity check: https://elixirschool.com/en/lessons/basics/basics

Principles:
- The official guide defines the beginner concept surface area.
- HexDocs validates function behavior, examples, and signatures.
- Codie keeps its own lesson prose, pacing, and gamified wrapper.
- `Foundations` should cover the core beginner language model, while processes/OTP stay in later tracks.

## Coverage

| Official guide chapter | Status in Codie | Current lesson coverage | Notes |
| --- | --- | --- | --- |
| Introduction | Covered | `wake_codie` | Teaches final-expression return model. |
| Basic types | Covered | `wake_codie`, `truthy-roast`, `comparison-check`, `friendly-interpolation`, `charlist-check`, `comprehension-lab` | Strings, atoms, booleans, `nil`, charlists, and ranges are all now introduced. |
| Basic operators | Covered | `number-crunch`, `comparison-check`, `sleepy-logic`, `cond-roast` | Arithmetic, comparison, and boolean branching operators are all in the learning path. |
| Lists and tuples | Covered | `pattern-handshake`, `list-supplies`, `list-lineup`, `tuple-contract` | Tuples are taught as plain data first. Lists now teach plain syntax before a dedicated prepend bridge lesson. |
| Pattern matching | Covered | `wake-routine`, `brew-status`, `recursive-refill`, `pin-the-order` | Pattern matching now starts only after tuples and variable binding are already familiar. |
| `case`, `cond`, and `if` | Covered | `sleepy-logic`, `case-by-case`, `cond-roast` | This is now an explicit chapter inside the track. |
| Anonymous functions | Covered | `double-shot`, `capture-shot` | Includes both `fn ... end` and `&` shorthand. |
| Binaries, strings, and charlists | Covered | `wake_codie`, `tuple-signal`, `friendly-interpolation`, `string-workbench`, `string-checks`, `charlist-check` | String basics, interpolation, cleanup, predicate checks, and the charlist/string distinction are all present. |
| Keyword lists and maps | Covered | `map-station`, `keyword-orders`, `map-toolkit`, `map-refresh` | Foundations now covers map creation, safe reads, bracket access, `Map.put/3`, and update syntax. |
| Modules and functions | Covered | `greeter-module`, `private-refill`, `brew-status`, `guard-duty`, `default-refill` | Public/private functions, multiple clauses, guards, and default args are covered. |
| `alias`, `require`, `import`, and `use` | Covered | `module-toolbelt`, `use-the-roaster` | All four directives are now introduced, with `use` taught through a prepared `__using__/1` macro. |
| Module attributes | Covered | `document-the-brew`, `module-notes` | `@doc`, `@moduledoc`, and custom attributes are all introduced. |
| Structs | Covered | `struct-shelf` | Struct creation, defaults, and field access are now in the track. |
| Recursion | Covered | `recursive-refill` | Good single-lesson intro. |
| Enumerables and Streams | Covered in core / Stream deferred | `enum-tour`, `capture-shot`, `filter-grind`, `enum-search`, `enum-checklist`, `enum-order` | Foundations now focuses on daily-use Enum work first, including `map`, `filter`, `reduce`, `find`, `any?`, `all?`, `count`, and `sort`. `stream-flow` remains available but is moved to `Functional Fluency`. |
| Comprehensions | Covered | `comprehension-lab` | Includes `for`, filtering, and a range input. |
| Protocols | Deferred | None | Belongs after `Foundations`. |
| Sigils | Covered | `sigil-shelf` | A lightweight `~w` lesson introduces sigils without overloading the track. |
| `try`, `catch`, and `rescue` | Partial in Foundations | `recovery-mode` | `try/rescue` stays in Foundations as an intro. `catch-spill` is moved to `Functional Fluency` so it stops crowding the core beginner path. |
| Processes | Deferred | None | Intentionally belongs to the next major track. |
| IO and the file system | Partial in Foundations | `peek-into-pour` | `IO.inspect/2` stays in Foundations because it is a practical beginner debugging tool. `script-path` is moved to `Mix, Testing, and Tooling`. |
| Writing documentation | Covered | `document-the-brew` | Intro to inline docs is present. |
| Optional syntax sheet | Reference only | N/A | Use for author notes, not a dedicated lesson. |
| Erlang libraries | Deferred | None | Belongs after core language fluency. |
| Debugging | Covered | `peek-into-pour`, `debug-tap` | Both `IO.inspect/2` and `dbg/1` are introduced. |

## Immediate Backlog

The highest-value remaining `Foundations` work is still quality-focused:

1. Keep rewriting the first chapter so every lesson teaches a mental model before the syntax check.
2. Broaden accepted solution shapes where a lesson still overfits one exact expression.
3. Decide whether `Enum.each/2` still needs an explicit slot in `Foundations`, or whether it belongs with a later side-effect-focused lesson.
4. Keep expanding Codex entries so they act like a real quick reference, not just unlocked labels.

## Lesson Authoring Standard

Every `Foundations` lesson should follow this structure:

1. `What`: define the concept in 1-2 sentences.
2. `Example`: show 1-3 lines of real Elixir.
3. `Why`: explain when the concept is used.
4. `Watch out`: call out the most common beginner mistake.
5. `Task`: ask the learner to apply the concept in a constrained problem.

Checks should prefer:
- validating the intended concept,
- accepting more than one idiomatic solution shape when possible,
- and avoiding brittle syntax-only forcing unless the syntax itself is the lesson target.
