# Elixir Curriculum Review

## Overview

This document provides a comprehensive review of the Elixir curriculum codebase, analyzing its structure, pedagogical approach, and implementation patterns.

## Curriculum Architecture

### Track Structure

The curriculum is organized into **15 tracks** spanning beginner to expert levels:

#### Foundations Tracks (Beginner)
1. **Foundations: Data Types and Immutability** - Core data types, basic value shapes
2. **Foundations: Pattern Matching** - The `=` operator as assertion, pattern matching fundamentals
3. **Foundations: Complex Data Structures** - Lists, tuples, maps, keyword lists, structs
4. **Foundations: Functions, Modules, and the Pipe Operator** - Anonymous/named functions, arity, pipelines
5. **Foundations: Control Flow and the with Statement** - `if/unless`, `case`, `cond`, `with`
6. **Foundations: Enumeration and Streams** - Eager `Enum` vs lazy `Stream` pipelines

#### Advanced Tracks (Intermediate)
7. **Functional Fluency** - Data transforms, recursion, comprehensions
8. **Processes and Message Passing** - BEAM lightweight processes
9. **OTP and Supervision** - GenServers, supervisors, resilient systems
10. **Concurrency Patterns** - Worker patterns, async flows
11. **Fault Tolerance and Distribution** - Nodes, clustering, failure recovery

#### Professional Tracks (Advanced)
12. **Mix, Testing, and Tooling** - Mix, ExUnit, docs, dialyzers
13. **Ecto and Data Modeling** - Schemas, changesets, queries
14. **Phoenix and LiveView** - Dynamic web apps

#### Expert Tracks
15. **Expert Elixir Patterns** - Architecture, API design, optimization
16. **Erlang Interop and BEAM Internals** - OTP, ETS, tracing
17. **Capstone Projects** - Complete applications

### Lesson Structure

Each lesson follows a consistent schema defined in `Codie.Curriculum.Lesson`:

```elixir
%Lesson{
  slug: "unique-identifier",
  title: "Display Title",
  track_slug: "parent-track",
  tier: :normal | :boss,  # Boss lessons are capstone challenges
  summary: "One-line description",
  teaching_markdown: "Multi-section teaching content",
  starter_code: "Initial code template",
  checks: [list of validation checks],
  hints: [progressive hint system],
  rewards: %Reward{},
  prerequisites: ["earlier-lesson-slugs"],
  codex_entries_unlocked: [conceptual unlocks]
}
```

## Pedagogical Approach

### 1. **Depth-First Learning**
The curriculum explicitly rejects breadth-first approaches. Each track focuses deeply on one concept before moving to the next:

> "A fresh beginner-first track that teaches core Elixir data types, basic value shapes, and immutability by staying on them until they feel normal."

### 2. **Progressive Complexity**
Lessons build incrementally:
- **String Shelf** → **String Blend** → **String Greeting** → **String Cleanup** → **String Pieces**
- Each lesson adds one new concept while reinforcing previous ones

### 3. **Structured Teaching Format**
Every lesson's `teaching_markdown` follows a consistent pattern:

```markdown
What: [Concept definition]
Example: [Code examples]
Why: [Practical motivation]
Common cases: [Real-world usage]
Watch out: [Common pitfalls]
Task: [Specific exercise]
```

### 4. **Multi-Layered Hint System**
Hints progress from conceptual to specific:
1. Conceptual guidance ("Keep the function exactly as the starter gives it to you")
2. Syntax direction ("Use `if condition, do: ..., else: ...`")
3. Near-solution guidance ("A valid final line is `base <> \" beans\"`")




### 5. **Boss Checkpoints**
Boss lessons (marked with `tier: :boss`) combine multiple concepts:
- **Decision Roundup** - Combines booleans, `if`, tagged tuples, `case`, and `cond`
- **Pattern Roundup** - Combines direct matching, tuple/list matching, `case`, function heads
- **Complex Data Structures Roundup** - Combines lists, tuples, maps, keyword lists, structs
- Higher rewards (48-60 points vs 24-38 for normal lessons)

## Validation System

### Check Types

The curriculum uses five primary check types:

1. **`returns/2`** - Validates final expression value
2. **`binds/3`** - Validates variable bindings
3. **`source_contains/2`** - Validates presence of specific syntax
4. **`ast_contains/2`** - Validates AST structure
5. **`module_function/5`** - Tests defined module functions

### Check Philosophy

Checks balance **concept validation** vs **syntax forcing**:

> "Checks should prefer: validating the intended concept, accepting more than one idiomatic solution shape when possible, and avoiding brittle syntax-only forcing unless the syntax itself is the lesson target."

## Strengths

### 1. **Excellent Sequencing**
The new foundations tracks show thoughtful progression:
- Strings → Numbers → Tuples → Lists → Maps → Keywords → Atoms/Booleans/Nil
- Each data type is introduced in isolation before combinations
- Pattern matching comes AFTER learners understand tuples and variables

### 2. **Immutability Emphasis**
Multiple lessons reinforce immutability:
- "String.trim/1 returns a new string. It does not change the old one in place."
- "Enum.sort/1 returns a new list. It does not change the original list in place."
- Consistent messaging across all transformation operations

### 3. **Practical Mental Models**
Teaching content focuses on mental models over syntax:
- "Variables are just labels for values, not little boxes that mutate in place"
- "Pattern matching is the beating heart of Elixir"
- "Functions are values you can pass around"

### 4. **Real-World Context**
Lessons explain WHY concepts matter:
- "Real input is messy. Trimming and splitting are core beginner tools"
- "Pipes make multi-step transformations easier to read and maintain"
- "Streams let you describe work now and execute it later, which matters for larger pipelines"

### 5. **Comprehensive Coverage**
The foundations tracks cover all essential Elixir Getting Started topics:
- Basic types ✓
- Pattern matching ✓
- Control flow ✓
- Functions and modules ✓
- Enumeration ✓
- Structs ✓
- Error handling (try/rescue) ✓


## Issues and Gaps

### 1. **Missing Core Concepts from Foundations**

The following concepts from the official Elixir Getting Started guide are NOT in the new foundations tracks:

#### **Guards** (Partially covered in Legacy)
- Present in legacy track (`guard-duty` lesson)
- NOT in new foundations tracks
- **Impact**: Guards are fundamental to idiomatic pattern matching
- **Recommendation**: Add to "Foundations: Pattern Matching" track

#### **Recursion** (In Legacy only)
- Present in legacy track (`recursive-refill` lesson)
- NOT in new foundations tracks
- **Impact**: Recursion is essential for list processing
- **Recommendation**: Add to "Foundations: Functions, Modules, and Pipe" or create dedicated recursion mini-track

#### **Comprehensions** (In Legacy only)
- Present in legacy track (`comprehension-lab` lesson)
- NOT in new foundations tracks
- **Impact**: Comprehensions are common in real Elixir code
- **Recommendation**: Add to "Foundations: Enumeration and Streams"

#### **Pin Operator** (In Legacy only)
- Present in legacy track (`pin-the-order` lesson)
- NOT in new foundations tracks
- **Impact**: Pin operator is crucial for advanced pattern matching
- **Recommendation**: Add to "Foundations: Pattern Matching"

#### **Private Functions** (In Legacy only)
- Present in legacy track (`private-refill` lesson)
- NOT in new foundations tracks
- **Impact**: `defp` is essential for module organization
- **Recommendation**: Add to "Foundations: Functions, Modules, and Pipe"

#### **Module Attributes** (In Legacy only)
- Present in legacy track (`module-notes`, `document-the-brew` lessons)
- NOT in new foundations tracks
- **Impact**: Module attributes are used in every real Elixir project
- **Recommendation**: Add to "Foundations: Functions, Modules, and Pipe"

#### **Sigils** (In Legacy only)
- Present in legacy track (`sigil-shelf` lesson)
- NOT in new foundations tracks
- **Impact**: `~w`, `~s`, `~r` are common in real code
- **Recommendation**: Add lightweight sigil intro to foundations

### 2. **Lesson Quality Issues**

#### **String Signals Lesson** (slug: `string-signals`)
**Issue**: Incomplete checks array
```elixir
checks: [
  source_contains("String.contains?",
    checkpoint: "Use `String.contains?/2`",
```
The checks array is truncated in the file at line 500. This lesson is incomplete.

#### **Charlist Confusion**
Multiple lessons use different charlist syntax:
- `charlist-lane-new` uses `~c"latte"` (modern sigil syntax)
- `charlist-check` uses `'ok'` (single quotes)

**Recommendation**: Standardize on `~c` sigil syntax throughout, as it's more explicit and less confusing for beginners.

### 3. **Pedagogical Concerns**

#### **Too Many "New" Suffixes**
Many lesson slugs end with `-new`:
- `string-shelf-new`, `number-shelf-new`, `tuple-signal-new`, `case-signal-new`, etc.

This suggests curriculum churn. Consider:
- Removing `-new` suffixes once lessons are stable
- Using version numbers if multiple versions need to coexist

#### **Inconsistent Terminology**
The curriculum uses multiple terms for similar concepts:
- "Shelf" vs "Lab" vs "Station" vs "Lane" in lesson titles
- While thematic, this may confuse learners about lesson types

**Recommendation**: Establish clear naming conventions:
- "Shelf" = Introduction to a concept
- "Lab" = Practice/application
- "Roundup" = Checkpoint/combination



### 4. **Check Brittleness**

Some lessons over-specify syntax when concept validation would suffice:

#### **Example: `case-signal-new`**
```elixir
source_contains("{:ok, drink}",
  checkpoint: "Match the success branch as `{:ok, drink}`",
  failure_message: "Add a success branch that matches `{:ok, drink}`."
)
```

**Issue**: Forces exact variable name `drink`. Learner using `value` or `result` would fail.

**Better approach**: Use `ast_contains` to verify pattern structure without forcing variable names.

#### **Example: `cond-lane-new`**
```elixir
source_contains("cups == 0", ...),
source_contains("cups < 3", ...),
source_contains("true ->", ...)
```

**Issue**: Forces exact condition order and syntax.

**Better approach**: Verify `cond` usage and correct return value, allow flexible condition ordering.

### 5. **Missing Enum Functions**

The "Foundations: Enumeration and Streams" track covers:
- `Enum.map/2` ✓
- `Enum.reduce/3` ✓
- `Enum.filter/2` ✓
- `Enum.find/2` ✓
- `Enum.any?/2` ✓
- `Enum.all?/2` ✓
- `Enum.count/1` ✓
- `Enum.sort/1` ✓

**Missing from foundations**:
- `Enum.each/2` - Side effects (mentioned in coverage matrix as uncertain)
- `Enum.reject/2` - Inverse of filter
- `Enum.take/2` - Common for limiting results
- `Enum.drop/2` - Common for skipping items
- `Enum.zip/2` - Combining lists
- `Enum.uniq/1` - Removing duplicates
- `Enum.join/2` - Converting to string

**Recommendation**: Add `Enum.take/2`, `Enum.reject/2`, and `Enum.uniq/1` to foundations. Others can wait for intermediate tracks.

### 6. **Expert Tracks Are Stubs**

All five "Expert" tracks (Phases 1-5) contain only placeholder lessons:

```elixir
lesson(
  track_slug: "expert-functional-foundations",
  slug: "expert-basics",
  title: "Basic Types & Immutability",
  summary: "Variables are just labels.",
  teaching_markdown: "Data never changes in place. Variables are just labels for values.",
  starter_code: "status = :ok",
  checks: [],  # Empty!
  hints: [],   # Empty!
  rewards: reward(10, 1, 1, 1, 1, 1),
  codex_entries_unlocked: []
)
```

**Impact**: The expert learning path is not yet functional.

**Recommendation**: Either remove these tracks until ready, or clearly mark them as "Coming Soon" in the UI.

## Comparison to Official Elixir Getting Started Guide

### Coverage Matrix

| Official Guide Chapter | New Foundations | Legacy Track | Status |
|------------------------|-----------------|--------------|--------|
| Introduction | ✓ | ✓ | Complete |
| Basic types | ✓ | ✓ | Complete |
| Basic operators | ✓ | ✓ | Complete |
| Pattern matching | ✓ | ✓ | Complete |
| case, cond, if | ✓ | ✓ | Complete |
| Anonymous functions | ✓ | ✓ | Complete |
| Binaries, strings, charlists | ✓ | ✓ | Complete |
| Keyword lists and maps | ✓ | ✓ | Complete |
| Modules and functions | ✓ | ✓ | Complete |
| Recursion | ✗ | ✓ | **Missing from new foundations** |
| Enumerables and Streams | ✓ | ✓ | Complete |
| Processes | ✗ | ✗ | Deferred (correct) |
| IO and file system | Partial | ✓ | `IO.inspect` in foundations, `File` in legacy |
| alias, require, import | ✗ | ✓ | **Missing from new foundations** |
| Module attributes | ✗ | ✓ | **Missing from new foundations** |
| Structs | ✓ | ✓ | Complete |
| Protocols | ✗ | ✗ | Deferred (correct) |
| Comprehensions | ✗ | ✓ | **Missing from new foundations** |
| Sigils | ✗ | ✓ | **Missing from new foundations** |
| try, catch, rescue | Partial | ✓ | `try/rescue` in foundations, `catch` in legacy |
| Optional syntax sheet | N/A | N/A | Reference only |
| Erlang libraries | ✗ | ✗ | Deferred (correct) |
| Debugging | Partial | ✓ | `IO.inspect` and `dbg` in foundations |

### Key Gaps

The new foundations tracks are **missing 7 core concepts** that are in the official guide:
1. Recursion
2. alias/require/import/use
3. Module attributes
4. Comprehensions
5. Sigils
6. Guards (implicit in pattern matching chapter)
7. Pin operator (implicit in pattern matching chapter)

All of these exist in the legacy track but haven't been migrated to the new curriculum.



## Track-by-Track Detailed Review

### Track 1: Foundations: Data Types and Immutability (32 lessons)

**Lesson sequence**:
`string-shelf` → `string-blend` → `string-greeting` → `string-cleanup` → `string-pieces` → `string-signals` → `immutability-shelf` → `number-shelf` → `number-check` → `tuple-pair` → `tuple-unpack` → `list-shelf-new` → `list-front` → `list-unpack` → `map-shelf-new` → `map-read-new` → `map-refresh-new` → `keyword-shelf-new` → `state-signals-new` → `data-roundup` → `truth-check-new` → `if-door` → `tagged-signal-new` → `case-signal-new` → `cond-lane-new` → `decision-roundup` → `function-shelf-new` → `function-choices-new` → `struct-shelf-new` → `charlist-lane-new` → `range-shelf-new` → `value-tools-roundup`

**Strengths**:
- Strings taught first (6 lessons!) gives immediate gratification — learners produce visible output quickly
- Immutability introduced early (lesson 7) as a mental model before it gets complicated
- Data types introduced one at a time with clear isolation
- Boss checkpoints (`data-roundup`, `decision-roundup`, `value-tools-roundup`) provide synthesis

**Issues**:
1. **Track is overloaded** — 32 lessons mixing data types, control flow, functions, AND structs. The track title says "Data Types and Immutability" but includes `case`, `cond`, `if`, anonymous functions, and structs. These belong in later tracks.
2. **`case-signal-new` check** (line 1576): `source_contains("{:ok, drink}")` forces exact variable name
3. **`map-refresh-new` check** (line 1148): `source_contains("%{order | shots: 3}")` forces exact update syntax — learners using `Map.put/3` would fail despite producing the correct result
4. **`cond-lane-new` check** (line 1645-1660): Three `source_contains` checks force exact conditions and order

**Recommendations**:
- Split track: Keep lessons 1-20 as "Data Types and Immutability", move 21-26 to "Control Flow", move 27-28 to "Functions", move 29-32 to a separate track
- Replace `source_contains` checks with `returns` checks where the concept (not exact syntax) is being tested

### Track 2: Foundations: Pattern Matching (6 lessons)

**Lesson sequence**:
`match-assertion` → `match-tuples-track` → `match-lists-track` → `match-case-track` → `match-function-heads-track` → `pattern-roundup`

**Strengths**:
- Excellent pacing — starts with the `=` operator as assertion, builds to function heads
- `match-assertion` (line 1769) correctly frames `=` as "not assignment" from the start
- Boss `pattern-roundup` combines all four matching contexts

**Issues**:
1. **Missing pin operator** — The `^` operator is essential for pattern matching but absent here
2. **Missing guards** — `when` clauses are the natural companion to function head matching
3. **No `_` wildcard lesson** — Underscore matching is introduced implicitly but deserves its own focused lesson
4. **`match-function-heads-track`** jumps to `defmodule` without prior module-writing experience in the new tracks

**Recommendations**:
- Add `match-pin-operator` lesson after `match-assertion`
- Add `match-guards` lesson after `match-function-heads-track`
- Add explicit `_` wildcard lesson between `match-tuples-track` and `match-lists-track`

### Track 3: Foundations: Complex Data Structures (4 lessons)

**Lesson sequence**:
`data-shapes-lists-tuples` → `data-shapes-maps-keywords` → `data-shapes-structs-maps` → `complex-data-structures-roundup`

**Strengths**:
- Focused comparison-based approach — each lesson contrasts two similar structures
- Teaching focuses on "when to use which" rather than just syntax

**Issues**:
1. **Only 4 lessons feels thin** — learners may not get enough practice with tradeoff decisions
2. **Missing nested data structure lesson** — Real Elixir code heavily uses nested maps/structs
3. **No `Access` module** — `get_in/2`, `put_in/3`, `update_in/3` are important for nested data

**Recommendations**:
- Add a lesson on nested data structures and `get_in`/`put_in`
- Add a lesson on `Map.merge/2` and `Map.take/2` as practical tools

### Track 4: Foundations: Functions, Modules, and Pipe (5 lessons)

**Lesson sequence**:
`fn-values-lab` → `module-functions-lab` → `arity-lab` → `pipe-flow-lab` → `functions-modules-pipe-roundup`

**Strengths**:
- Clean progression from anonymous → named → arity awareness → pipes
- Boss roundup combines all concepts effectively
- Arity lesson (line 2652) explicitly teaches `/1` vs `/2` notation

**Issues**:
1. **Missing `defp`** — Private functions are essential for module organization
2. **Missing `alias/import/require/use`** — These are needed as soon as you write multi-module code
3. **Missing module attributes** — `@moduledoc`, `@doc`, `@spec` belong here
4. **Missing default arguments** — `\\` syntax for defaults is in legacy but not here
5. **Missing function capture** — `&Module.function/arity` is in legacy (`capture-shot`) but not here

**Recommendations**:
- Add `defp` lesson after `module-functions-lab`
- Add `alias-import-require` lesson
- Add `capture-operator` lesson to teach `&` syntax

### Track 5: Foundations: Control Flow and with (5 lessons)

**Lesson sequence**:
`control-flow-if-unless` → `control-flow-case` → `control-flow-cond` → `control-flow-with` → `control-flow-with-roundup`

**Strengths**:
- Good sequencing: simple branching → pattern-based → condition-based → multi-step
- `with` teaching (line 3104) correctly frames it as "happy path chaining"
- Boss roundup covers a realistic multi-step scenario

**Issues**:
1. **Overlap with Track 1** — `if`, `case`, and `cond` are already taught in the "Data Types" track (lessons `if-door`, `case-signal-new`, `cond-lane-new`). This creates confusion about whether learners should do Track 1 or Track 5 first.
2. **`unless` should be deprioritized** — The Elixir community increasingly discourages `unless` for readability. The lesson should note this convention.

**Recommendations**:
- Remove `if`/`case`/`cond` from Track 1 entirely — they don't belong in "Data Types and Immutability"
- Add a note in `control-flow-if-unless` that `unless` is less common in practice

### Track 6: Foundations: Enumeration and Streams (5 lessons)

**Lesson sequence**:
`enum-map-lab` → `enum-reduce-lab` → `enum-eager-lab` → `stream-lazy-lab` → `enumeration-streams-roundup`

**Strengths**:
- `Enum.map` → `Enum.reduce` progression is pedagogically sound
- Eager vs lazy distinction made explicit
- Stream lesson correctly emphasizes "describe now, execute later"

**Issues**:
1. **Only 5 lessons is too few** — `Enum` is the most-used module in Elixir
2. **Missing `Enum.filter/2`** — Not in the new track (it's in legacy `filter-grind`)
3. **Missing `Enum.each/2`** — Needed for side effects
4. **Missing `Enum.into/2`** — Important for type conversion
5. **Missing comprehensions** — `for` is common enough to belong in foundations

**Recommendations**:
- Add 3-4 more lessons covering `filter`, `reject`, `find`, `any?`/`all?`
- Add a comprehension lesson as the final pre-boss lesson


### Legacy Track (~50 lessons)

The legacy `foundations-old` track contains important lessons that haven't been migrated:

**High-priority lessons to migrate**:
- `guard-duty` — Guards with `when` clauses
- `recursive-refill` — Basic recursion
- `pin-the-order` — Pin operator `^`
- `private-refill` — `defp` private functions
- `capture-shot` — Function capture `&`
- `default-refill` — Default arguments `\\`
- `module-toolbelt` — `alias`, `import`, `require`
- `use-the-roaster` — `use` macro
- `module-notes` — Module attributes `@`
- `comprehension-lab` — `for` comprehensions

**Lower-priority (can stay in intermediate tracks)**:
- `sigil-shelf` — Sigils
- `stream-flow` — Advanced streams
- `debug-tap` — `dbg/1`
- `document-the-brew` — Documentation

### Expert Tracks (Phases 1-5)

All 20 expert lessons are placeholder stubs with empty checks, minimal teaching text, and reward(10, 1, 1, 1, 1, 1). These tracks serve as structural placeholders for future content. They are not functional lessons.

**Recommendation**: Either hide these from the UI or clearly label them "Coming Soon" to avoid learner disappointment.

## Non-Idiomatic Patterns Being Taught

### 1. Correct patterns (well done)
- Immutability messaging is consistent and accurate
- Pattern matching framed correctly as assertions
- Pipe operator usage is idiomatic
- Tagged tuple conventions are standard

### 2. Minor concerns
- **`unless` given equal weight to `if`** — In modern Elixir, `unless` is discouraged for complex conditions. The lesson (`control-flow-if-unless`) should note this.
- **No mention of `Kernel` module** — Many "built-in" functions are actually `Kernel` functions. This context helps learners understand the standard library.
- **String concatenation taught with `<>`** but **interpolation not consistently preferred** — Elixir style guides prefer `"Hello, #{name}"` over `"Hello, " <> name`. The curriculum teaches both without noting the preference.

## Priority Recommendations

### Immediate (before launching to more users)
1. **Fix brittle checks** — Replace `source_contains` with `returns` or `ast_contains` checks in: `case-signal-new`, `map-refresh-new`, `cond-lane-new`, `map-refresh` (legacy)
2. **Add pin operator lesson** to Pattern Matching track
3. **Add guards lesson** to Pattern Matching track
4. **Resolve Track 1 / Track 5 overlap** — Remove `if`/`case`/`cond` from Track 1

### Short-term (next sprint)
5. **Migrate high-priority legacy lessons** — `guard-duty`, `recursive-refill`, `pin-the-order`, `private-refill`, `capture-shot`, `module-toolbelt`
6. **Expand Enumeration track** — Add `filter`, `reject`, `find`, comprehensions
7. **Add `alias/import/require/use` lesson** to Functions track
8. **Standardize charlist syntax** on `~c` sigil

### Medium-term (next quarter)
9. **Split Track 1** into focused subtracks
10. **Add nested data structures** lesson to Complex Data track
11. **Remove `-new` suffixes** from stable lesson slugs
12. **Add module attributes** lesson
13. **Hide or label expert stub tracks**

## Summary

The Codie curriculum has a strong pedagogical foundation with excellent sequencing, clear mental-model-first teaching, and thoughtful progressive disclosure. The main weakness is that the new foundations tracks are incomplete — they cover ~70% of the official Elixir Getting Started guide, with 7 core concepts still only in the legacy track. The most impactful improvements are: fixing brittle checks that reject valid solutions, migrating the 10 high-priority legacy lessons, and resolving the content overlap between Track 1 and Track 5.
