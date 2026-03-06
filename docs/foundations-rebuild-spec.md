# Foundations Rebuild Spec

This document is the working curriculum spec for rebuilding `Foundations` into a true beginner-first Elixir track.

For the product-level path beyond `Foundations`, also see [Elixir Learning Roadmap](expert-learning-roadmap.md).

## Goal

Take a learner who:
- knows almost no Elixir
- knows only a little programming
- needs syntax and mental models together

and teach them the practical Elixir core deeply enough that they can solve real small problems before moving into OTP, Phoenix, and the larger BEAM ecosystem.

## Reference Standard

Use these as the curriculum source of truth:
- Elixir Getting Started guide: https://hexdocs.pm/elixir/introduction.html
- Elixir modules/functions docs: https://hexdocs.pm/elixir/modules-and-functions.html
- Elixir Enum docs: https://hexdocs.pm/elixir/Enum.html
- Elixir String docs: https://hexdocs.pm/elixir/String.html
- Elixir Map docs: https://hexdocs.pm/elixir/Map.html
- Elixir try/catch/rescue docs: https://hexdocs.pm/elixir/try-catch-and-rescue.html
- Elixir debugging docs: https://hexdocs.pm/elixir/debugging.html
- Elixir School basics as a secondary sanity check: https://elixirschool.com/en/lessons/basics/basics

Do not use Exercism.

## Core Principle

Teach the minimum syntax needed for the next mental model, then reuse it immediately.

Do not:
- front-load niche syntax
- pack too many unrelated concepts together
- force one exact solution shape when the concept is broader than a single syntax pattern

## Curriculum Direction

The strongest rebuild direction is:
- cut low-value Foundations topics
- teach the practical Elixir core more deeply
- give learners more daily-use `Enum`, `String`, `Map`, and `with`
- make Codex entries useful enough to act as an in-app quick reference

This spec is intentionally narrower than the full product roadmap. Use it for the active beginner track. Use [Elixir Learning Roadmap](expert-learning-roadmap.md) for the larger beginner-to-expert sequencing model.

## Chapter Shape

`Foundations` should be organized around five internal chapters:

1. Reading and Building Values
2. Naming, Decisions, and Matching
3. Functions and Modules
4. Working with Data Every Day
5. Result Flows, Structures, and Developer Tools

## Keep in Foundations

Keep and deepen:
- values and final-expression returns
- strings, numbers, tuples, lists, maps, keyword lists
- atoms, booleans, `nil`, and truthiness
- variable binding
- comparisons
- `if`, `cond`, `case`
- pattern matching
- anonymous functions, named functions, `defp`, default args
- interpolation
- guards
- pipe operator
- `Enum` daily-use tools
- string and map helpers
- tagged tuples
- `with`
- structs
- `IO.inspect`
- `dbg`
- docs and basic module attributes
- one or more checkpoints plus a boss

## Move Out of Foundations

These topics should not consume core beginner pacing:
- `Stream` -> `Functional Fluency`
- `catch` / `throw` -> `Functional Fluency`
- `File` / `Path` helpers -> `Mix, Testing, and Tooling`

## Add or Promote in Foundations

These are practical daily-use beginner tools and should be explicit lessons:
- `Enum.find/2`
- `Enum.any?/2`
- `Enum.all?/2`
- `Enum.count/1`
- `Enum.sort/1`
- `String.split/2`
- `String.trim/1`
- `Map.get/3`
- `Map.put/3`
- map update syntax `%{map | key: value}`
- `with`

## Lesson Standard

Every lesson should include:

1. Mental model
   - 2-3 sentences on what this is and why it exists
2. Core syntax
   - at least two examples, simplest first
3. One focused exercise
   - uses only current + prior concepts
4. Common patterns
   - brief real-world style snippets
5. Gotchas
   - one or two critical beginner mistakes
6. Practice challenge or checkpoint cadence
   - periodically combine concepts instead of one-and-done drills

## Codex Standard

Each Codex entry should include:
- a one-line purpose
- a short summary
- a quick example
- one beginner watch-out
- a short when-to-use note

The Codex should be the first in-app reference a learner checks, not just a tooltip list.
