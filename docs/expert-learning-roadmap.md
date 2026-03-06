# Elixir Learning Roadmap

This document captures the long-range curriculum shape for taking a learner from complete beginner to advanced Elixir and BEAM topics.

It is not the same thing as the active `Foundations` lesson plan. `Foundations` stays focused on beginner-first concept mastery. This roadmap is the larger sequencing model that helps decide what comes after `Foundations`.

## Core Idea

Elixir requires a mindset shift:
- first, learn to think functionally
- then, learn to think concurrently
- then, learn to think in distributed, fault-tolerant systems

That means the overall product should teach Elixir in phases, not as a flat feature list.

## Phase 1: Functional Foundations

Goal: unlearn object-oriented habits and build comfort with immutable data transformation.

Core themes:
- basic types and immutability
- pattern matching
- core data structures
- functions, modules, and the pipe operator
- control flow and `with`
- enumeration

Notes for Codie:
- this phase maps directly to the active `Foundations` track
- the active `Foundations` track should stay more granular than this outline
- each of these themes should expand into many smaller beginner-first lessons

Suggested concept order:
1. Basic types and immutability
2. Pattern matching
3. Core data structures
4. Functions, modules, and the pipe operator
5. Control flow and `with`
6. Enumeration

## Phase 2: Tooling and Abstractions

Goal: understand how real Elixir projects are organized and how Elixir models polymorphism.

Core themes:
- Mix, Hex, and project structure
- protocols and behaviours
- typespecs, Dialyzer, and ExUnit

Notes for Codie:
- this phase should become a post-Foundations track
- it should be practical and project-oriented, not purely conceptual

Suggested concept order:
1. Mix, Hex, and project structure
2. Protocols and behaviours
3. Typespecs, Dialyzer, and ExUnit

## Phase 3: Concurrency and OTP

Goal: teach the actor model and the core OTP abstractions that make the BEAM distinct.

Core themes:
- raw processes and messages
- Tasks and Agents
- GenServer
- Supervisors and fault tolerance
- Registries and DynamicSupervisors

Notes for Codie:
- this is the point where the learner crosses from “Elixir syntax” into “BEAM programming”
- this phase should be a major milestone in the app, not a quick follow-up track

Suggested concept order:
1. Basic processes and messages
2. Tasks and Agents
3. GenServer
4. Supervisors and fault tolerance
5. Registries and DynamicSupervisors

## Phase 4: Ecosystem

Goal: teach the libraries and application patterns used in real Elixir jobs.

Core themes:
- Ecto schemas and changesets
- Ecto queries, repos, and transactions
- Phoenix request lifecycle
- Phoenix LiveView and PubSub

Notes for Codie:
- this phase should come only after the learner is already comfortable with modules, processes, and testing
- these tracks should feel like “build real apps” rather than isolated syntax drills

Suggested concept order:
1. Ecto schemas and changesets
2. Ecto queries, repos, and `Ecto.Multi`
3. Phoenix request lifecycle
4. Phoenix LiveView and PubSub

## Phase 5: Expert Level

Goal: move from framework competence into system design, performance, and BEAM internals.

Core themes:
- macros and metaprogramming
- distributed nodes and clustering
- telemetry and profiling
- interoperability with native code and external systems

Notes for Codie:
- this phase should stay explicitly advanced
- it should assume the learner already understands OTP and Phoenix-level application structure

Suggested concept order:
1. Metaprogramming
2. Distributed Elixir and clustering
3. Telemetry and system profiling
4. Interoperability with Ports and NIFs

## How This Should Influence Codie

Use this roadmap as:
- the long-range track architecture
- the sequencing guardrail for future curriculum expansions
- the place to decide what belongs in `Foundations` versus later tracks

Do not use this roadmap as:
- the direct lesson outline for beginners
- a reason to compress too many concepts into `Foundations`

`Foundations` should remain:
- smaller in scope
- slower in pacing
- more repetitive
- more focused on building comfort with a few core ideas at a time

## Relationship to Official References

This roadmap is a product-level teaching strategy. The actual lesson content should still be validated against the project’s approved references:
- Elixir Getting Started guide: https://hexdocs.pm/elixir/introduction.html
- Elixir modules/functions docs: https://hexdocs.pm/elixir/modules-and-functions.html
- Elixir Enum docs: https://hexdocs.pm/elixir/Enum.html
- Elixir String docs: https://hexdocs.pm/elixir/String.html
- Elixir Map docs: https://hexdocs.pm/elixir/Map.html
- Elixir try/catch/rescue docs: https://hexdocs.pm/elixir/try-catch-and-rescue.html
- Elixir debugging docs: https://hexdocs.pm/elixir/debugging.html
- Elixir School basics as a secondary sanity check: https://elixirschool.com/en/lessons/basics/basics

## Current Product Translation

Today:
- `Foundations` is being rebuilt as a datatype-first, mastery-first beginner track
- `Foundations (Legacy)` is preserved as a reference archive

Next:
- keep strengthening the new `Foundations` track until the early learning path is genuinely beginner-safe
- then build the next tracks to follow the five-phase structure in this document
