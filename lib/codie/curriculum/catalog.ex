defmodule Codie.Curriculum.Catalog do
  @moduledoc false

  alias Codie.Curriculum.{Check, Lesson, Reward, Track}

  def tracks do
    [
      %Track{
        slug: "foundations",
        title: "Foundations: Data Types and Immutability",
        summary:
          "A fresh beginner-first track that teaches core Elixir data types, basic value shapes, and immutability by staying on them until they feel normal.",
        theme: "Coffee Lab",
        estimated_lesson_count: 31,
        teaser: "Learn one core datatype at a time, then make immutability feel normal."
      },
      %Track{
        slug: "foundations-pattern-matching",
        title: "Foundations: Pattern Matching",
        summary:
          "Learn why `=` is an assertion, then use pattern matching in values, `case`, and function signatures.",
        theme: "Signal Lab",
        estimated_lesson_count: 6,
        teaser: "This is the beating heart of Elixir."
      },
      %Track{
        slug: "foundations-complex-data-structures",
        title: "Foundations: Complex Data Structures",
        summary:
          "Learn when to reach for lists, tuples, maps, keyword lists, and structs in idiomatic Elixir.",
        theme: "Data Lab",
        estimated_lesson_count: 4,
        teaser: "Knowing map vs keyword list tradeoffs is core Elixir fluency."
      },
      %Track{
        slug: "foundations-functions-modules-pipe",
        title: "Foundations: Functions, Modules, and the Pipe Operator",
        summary:
          "Learn anonymous functions, named functions, arity, and readable top-to-bottom pipelines.",
        theme: "Flow Lab",
        estimated_lesson_count: 5,
        teaser: "Use pipes so data flows clearly from step to step."
      },
      %Track{
        slug: "foundations-control-flow-with",
        title: "Foundations: Control Flow and the with Statement",
        summary:
          "Learn `if/unless`, `case`, `cond`, and `with` to write readable happy-path logic.",
        theme: "Decision Lab",
        estimated_lesson_count: 5,
        teaser: "`with` keeps success paths clear and avoids nested conditionals."
      },
      %Track{
        slug: "foundations-enum-and-streams",
        title: "Foundations: Enumeration and Streams",
        summary:
          "Learn eager `Enum` pipelines, lazy `Stream` pipelines, and when to choose each.",
        theme: "Sequence Lab",
        estimated_lesson_count: 5,
        teaser: "Use `Enum` daily, and use `Stream` when lazy processing matters."
      },
      %Track{
        slug: "working-with-data-collections",
        title: "Working with Data: Collection Workflows",
        summary:
          "Learn to filter, find, count, validate, and sort collections in small, practical Elixir workflows.",
        theme: "Prep Lab",
        estimated_lesson_count: 6,
        teaser: "Turn plain collections into useful, checked results."
      },
      %Track{
        slug: "working-with-data-shapes-results",
        title: "Working with Data: Shapes and Results",
        summary: "Learn to update maps, normalize messy input, and return clear tagged results.",
        theme: "Shape Lab",
        estimated_lesson_count: 6,
        teaser: "Turn messy values into stable shapes with explicit outcomes."
      },
      %Track{
        slug: "working-with-data-workflows",
        title: "Working with Data: Small Workflows",
        summary:
          "Build small module-based workflows that transform data and return readable final results.",
        theme: "Workflow Lab",
        estimated_lesson_count: 6,
        teaser: "Use modules, helpers, and `with` to build small real programs."
      },
      %Track{
        slug: "foundations-old",
        title: "Foundations (Legacy)",
        summary:
          "The earlier breadth-first curriculum, kept as an archive for reference and future reuse.",
        theme: "Archive Shelf",
        estimated_lesson_count: 50,
        teaser: "Legacy material kept for reference while the new foundations track is rebuilt."
      },
      placeholder_track(
        "processes-and-message-passing",
        "Processes and Message Passing",
        "Learn how the BEAM thinks about lightweight processes and inboxes."
      ),
      placeholder_track(
        "otp-and-supervision",
        "OTP and Supervision",
        "Move from scripts to resilient systems with GenServers and supervisors."
      ),
      placeholder_track(
        "concurrency-patterns",
        "Concurrency Patterns",
        "Build more coordinated worker patterns and structured asynchronous flows."
      ),
      placeholder_track(
        "fault-tolerance-and-distribution",
        "Fault Tolerance and Distribution",
        "Explore nodes, clustering, and failure recovery on the BEAM."
      ),
      placeholder_track(
        "mix-testing-tooling",
        "Mix, Testing, and Tooling",
        "Use Mix, ExUnit, docs, dialyzers, and observability tools effectively."
      ),
      placeholder_track(
        "ecto-and-data-modeling",
        "Ecto and Data Modeling",
        "Work with schemas, changesets, queries, and persistence."
      ),
      placeholder_track(
        "phoenix-and-liveview",
        "Phoenix and LiveView",
        "Build dynamic web apps in the same stack you'll learn with here."
      ),
      placeholder_track(
        "expert-elixir-patterns",
        "Expert Elixir Patterns",
        "Refine architecture, design APIs, and optimize hot code paths."
      ),
      placeholder_track(
        "erlang-interop-and-beam",
        "Erlang Interop and BEAM Internals",
        "Drop lower into OTP, ETS, tracing, and runtime internals."
      ),
      placeholder_track(
        "capstones",
        "Capstone Projects",
        "Ship complete applications that prove expert-level fluency."
      ),
      %Track{
        slug: "expert-functional-foundations",
        title: "Phase 1: Functional Foundations",
        summary: "Unlearn object-oriented habits and master immutable data transformation.",
        theme: "Expert Lab",
        estimated_lesson_count: 6,
        teaser: "The 'Thinking in Elixir' Stage."
      },
      %Track{
        slug: "expert-tooling-abstractions",
        title: "Phase 2: Tooling & Abstractions",
        summary: "Understand how Elixir code is organized and how polymorphism works.",
        theme: "Expert Lab",
        estimated_lesson_count: 3,
        teaser: "The 'Building Real Things' Stage."
      },
      %Track{
        slug: "expert-concurrency-otp",
        title: "Phase 3: Concurrency & OTP",
        summary: "Master the Actor Model and the Erlang VM (BEAM).",
        theme: "Expert Lab",
        estimated_lesson_count: 5,
        teaser: "The 'Superpowers' Stage."
      },
      %Track{
        slug: "expert-ecosystem",
        title: "Phase 4: The Ecosystem",
        summary: "Learn the industry-standard libraries used in almost every Elixir job.",
        theme: "Expert Lab",
        estimated_lesson_count: 4,
        teaser: "The 'Professional' Stage."
      },
      %Track{
        slug: "expert-level",
        title: "Phase 5: Expert Level",
        summary: "System design, performance tuning, and meta-programming.",
        theme: "Expert Lab",
        estimated_lesson_count: 4,
        teaser: "The 'Architect' Stage."
      }
    ]
  end

  def lessons do
    [
      lesson(
        track_slug: "foundations",
        slug: "string-shelf",
        title: "String Shelf",
        summary: "Start with the simplest thing in Elixir: a plain string value.",
        teaching_markdown: """
        What:
        A string is text. In Elixir, strings use double quotes.

        Example:
        `"coffee"`
        `"hello"`

        Why:
        Strings are one of the easiest values to understand, so they are the best place to begin.

        Common cases:
        A short label like `"coffee"`
        A small message like `"hello"`

        Watch out:
        Strings use double quotes, not single quotes.

        Task:
        Replace the placeholder so the final expression is exactly `"coffee"`.
        """,
        starter_code: """
        "tea"
        """,
        checks: [
          source_contains("\"coffee\"",
            checkpoint: "Use the exact string `\"coffee\"`",
            failure_message: "Replace the placeholder with the exact string `\"coffee\"`."
          ),
          returns("coffee",
            checkpoint: "Make the final expression return `\"coffee\"`",
            failure_message: "The final expression should evaluate to `\"coffee\"`."
          )
        ],
        hints: [
          "Use double quotes for the string.",
          "The whole file can be one string literal.",
          "The answer can be exactly `\"coffee\"`."
        ],
        quick_terms: [
          quick_term("String", "A string is text written with double quotes, like `\"coffee\"`.")
        ],
        rewards: reward(24, 1, 6, 5, 4, 1),
        codex_entries_unlocked: [
          codex("new-strings", "Strings", "Strings are text values written with double quotes.")
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "string-blend",
        title: "String Blend",
        summary: "Combine two string pieces into one new string.",
        teaching_markdown: """
        What:
        The `<>` operator joins two strings into one new string.

        Example:
        `"coffee" <> " beans"`
        `"hello, " <> name`

        Why:
        Combining text is one of the first useful things you do with strings.

        Common cases:
        Build a label like `"coffee beans"`
        Add a short prefix like `"hello, "`

        Watch out:
        `<>` joins strings. It does not add numbers.

        Task:
        Keep `base = "coffee"`, then add `" beans"` and return the combined string.
        """,
        starter_code: """
        base = "coffee"
        base
        """,
        prerequisites: ["string-shelf"],
        checks: [
          binds(:base, "coffee"),
          source_contains("<>",
            checkpoint: "Use the string join operator",
            failure_message: "Use `<>` to join the two string pieces."
          ),
          returns("coffee beans",
            checkpoint: "Return `\"coffee beans\"`",
            failure_message: "The final expression should evaluate to `\"coffee beans\"`."
          )
        ],
        hints: [
          "Keep `base` exactly as it is.",
          "Add the second piece with `<>`.",
          "A valid final line is `base <> \" beans\"`."
        ],
        quick_terms: [
          quick_term("Concatenate", "Concatenate means join text pieces into one larger string.")
        ],
        rewards: reward(24, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "string-concat",
            "Joining Strings",
            "Use `<>` when you want to combine two strings into one new string."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "string-greeting",
        title: "String Greeting",
        summary: "Insert a value into a string with interpolation.",
        teaching_markdown: """
        What:
        Interpolation places a value inside a string with `\#{...}`.

        Example:
        `"hello, \#{name}"`
        `"cups: \#{count}"`

        Why:
        This is the most common readable way to build strings with values in them.

        Common cases:
        Build a greeting like `"hello, Nova"`
        Build a label like `"cups: 2"`

        Watch out:
        Interpolation only works in double-quoted strings.

        Task:
        Keep `name = "Nova"` and return `"hello, \#{name}"`.
        """,
        starter_code: """
        name = "Nova"
        "hello"
        """,
        prerequisites: ["string-blend"],
        checks: [
          source_contains(~S|"hello, #{name}"|,
            checkpoint: "Use interpolation",
            failure_message: "Return the string with interpolation: `\"hello, \#{name}\"`."
          ),
          returns("hello, Nova",
            checkpoint: "Return `\"hello, Nova\"`",
            failure_message: "The final expression should evaluate to `\"hello, Nova\"`."
          )
        ],
        hints: [
          "Keep the result inside one string literal.",
          "Use `\#{name}` inside the string.",
          "The final line can be exactly `\"hello, \#{name}\"`."
        ],
        quick_terms: [
          quick_term(
            "Interpolation",
            "Interpolation means inserting a value into a string with `\#{...}`."
          )
        ],
        rewards: reward(24, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "string-interpolation-new",
            "String Interpolation",
            "Use `\#{...}` inside a string when you want to show a value as part of the text."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "string-cleanup",
        title: "String Cleanup",
        summary: "Clean extra spaces from the edges of a string.",
        teaching_markdown: """
        What:
        `String.trim/1` removes extra whitespace from the start and end of a string.

        Example:
        `String.trim(" latte ")`
        `String.trim("  Nova  ")`

        Why:
        Real input often has extra spaces, so cleanup is a basic string skill.

        Common cases:
        Clean text pasted by a user
        Remove extra spaces before storing or comparing text

        Watch out:
        `String.trim/1` returns a new string. It does not change the old one in place.

        Task:
        Trim `" latte "` and return `"latte"`.
        """,
        starter_code: """
        " latte "
        """,
        prerequisites: ["string-greeting"],
        checks: [
          source_contains("String.trim",
            checkpoint: "Use `String.trim/1`",
            failure_message: "Call `String.trim/1` on the string."
          ),
          returns("latte",
            checkpoint: "Return `\"latte\"`",
            failure_message: "The final expression should evaluate to `\"latte\"`."
          )
        ],
        hints: [
          "Wrap the string in `String.trim(...)`.",
          "Keep the inner text the same.",
          "A valid answer is `String.trim(\" latte \")`."
        ],
        quick_terms: [
          quick_term("Trim", "Trim means remove extra whitespace from the edges of a string."),
          quick_term(
            "Arity notation (`/1`)",
            "`/1` means the function takes 1 argument. For example, `String.trim/1` takes one input string."
          )
        ],
        rewards: reward(24, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "string-trim-new",
            "String.trim",
            "Use `String.trim/1` when you need to clean extra spaces from the edges of text."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "string-pieces",
        title: "String Pieces",
        summary: "Split one string into a list of smaller strings.",
        teaching_markdown: """
        What:
        `String.split/2` breaks one string into a list of smaller strings using a separator.

        Example:
        `String.split("latte,mocha", ",")`
        `String.split("a-b-c", "-")`

        Why:
        This is one of the first practical steps for turning text input into usable data.

        Common cases:
        Split comma-separated values
        Break a simple ID into parts

        Watch out:
        `String.split/2` returns a list, not another string.
        In Elixir, a function name that ends with `?` usually means it answers a yes-or-no question and returns `true` or `false`.
        `String.split/2` does not end with `?` because it gives you pieces back instead of a boolean.

        Task:
        Split `"latte,mocha"` on the comma and return `["latte", "mocha"]`.
        """,
        starter_code: """
        "latte,mocha"
        """,
        prerequisites: ["string-cleanup"],
        checks: [
          source_contains("String.split",
            checkpoint: "Use `String.split/2`",
            failure_message: "Call `String.split/2` on the string."
          ),
          returns(["latte", "mocha"],
            checkpoint: "Return `[\"latte\", \"mocha\"]`",
            failure_message: "The final expression should evaluate to `[\"latte\", \"mocha\"]`."
          )
        ],
        hints: [
          "Use a comma as the separator.",
          "The result should be a list of two strings.",
          "A valid answer is `String.split(\"latte,mocha\", \",\")`."
        ],
        quick_terms: [
          quick_term(
            "Split",
            "Split means break one string into smaller pieces using a separator."
          ),
          quick_term(
            "Question mark (`?`) in a function name",
            "When a function name ends with `?`, it usually means the function answers a yes-or-no question and returns `true` or `false`."
          ),
          quick_term(
            "Arity notation (`/2`)",
            "`/2` means the function takes 2 arguments. For example, `String.split/2` takes the text and a separator."
          )
        ],
        rewards: reward(24, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "string-split-new",
            "String.split",
            "Use `String.split/2` when you need to turn one piece of text into a list of parts."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "string-signals",
        title: "String Signals",
        summary: "Ask simple yes-or-no questions about a string.",
        teaching_markdown: """
        What:
        Functions that end with `?` are often predicate functions: they ask yes-or-no questions and return booleans. One useful example is `String.contains?/2`.

        Example:
        `String.contains?("latte-oat", "-")`
        `String.starts_with?("latte-oat", "latte")`

        Why:
        These are practical checks for validation and simple text rules.

        Common cases:
        Check whether a label contains a separator
        Check whether a value starts with a known prefix

        Watch out:
        The `?` is part of the function name, so include it when you call the function.
        These functions answer a question about the string, but they do not change the string.

        Task:
        Use `String.contains?/2` on `"latte-oat"` to check whether it contains `"-"`.
        Return the boolean result.
        """,
        starter_code: """
        "latte-oat"
        """,
        prerequisites: ["string-pieces"],
        checks: [
          source_contains("String.contains?",
            checkpoint: "Use `String.contains?/2`",
            failure_message: "Use `String.contains?/2` to check for the dash."
          ),
          returns(true,
            checkpoint: "Return `true`",
            failure_message: "The final expression should evaluate to `true`."
          )
        ],
        hints: [
          "Check for `\"-\"` in the string.",
          "The final line can be a direct call to `String.contains?/2`.",
          "This lesson only needs one yes-or-no answer."
        ],
        quick_terms: [
          quick_term("Predicate", "A predicate is a function that returns `true` or `false`."),
          quick_term(
            "Arity notation (`/2`)",
            "`/2` means the function takes 2 arguments. `String.contains?/2` and `String.starts_with?/2` each take two inputs."
          )
        ],
        rewards: reward(24, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "string-predicates-new",
            "String Predicates",
            "Use predicate functions when you want a yes-or-no answer about a string."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "immutability-shelf",
        title: "Immutability Shelf",
        summary:
          "See that making a changed version creates a new value instead of changing the old one.",
        teaching_markdown: """
        What:
        Elixir data is immutable. That means a value does not change in place after it exists.
        You can build a new value from it, but the original value stays the same.

        Example:
        `base = "coffee"`
        `updated = base <> " beans"`
        `"\#{base} -> \#{updated}"` becomes `"coffee -> coffee beans"`

        Why:
        This is one of Elixir's core ideas. Instead of changing existing data, you keep the old value and build a new one for the next step.
        Variables are just labels that point at values.

        Common cases:
        Keep the original value for one use
        Build a new version for the next step
        Compare the old value and the new value side by side

        Watch out:
        `base` does not become `"coffee beans"` here.
        If strings changed in place, both names would show the changed text.
        Instead, `base` stays `"coffee"` and `updated` is a separate new value.

        Task:
        Keep `base = "coffee"`.
        Create `updated = base <> " beans"`.
        Then return `"\#{base} -> \#{updated}"` so you can prove the original value stayed `"coffee"` while the new one became `"coffee beans"`.
        """,
        starter_code: """
        base = "coffee"
        ""
        """,
        prerequisites: ["string-signals"],
        checks: [
          binds(:base, "coffee"),
          binds(:updated, "coffee beans"),
          source_contains("<>",
            checkpoint: "Build a new string from the old one",
            failure_message: "Use `<>` to build `updated` from `base`."
          ),
          returns("coffee -> coffee beans",
            checkpoint: "Return `\"coffee -> coffee beans\"`",
            failure_message:
              "The final expression should evaluate to `\"coffee -> coffee beans\"`."
          )
        ],
        hints: [
          "`base` should still be `\"coffee\"` at the end.",
          "Create a new variable named `updated`.",
          "Return one string that shows `base` first and `updated` second so you can see both values."
        ],
        quick_terms: [
          quick_term(
            "Immutable",
            "Immutable means a value does not change in place. The old value stays the same, and you create a new value instead."
          ),
          quick_term(
            "Label",
            "A variable name is a label you use to refer to a value. Making a new label for a new value does not change the old one."
          )
        ],
        rewards: reward(26, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "immutability-new",
            "Immutability",
            "In Elixir, values do not change in place. New results are built as new values."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "number-shelf",
        title: "Number Shelf",
        summary: "Work with plain numbers and arithmetic before adding any other complexity.",
        teaching_markdown: """
        What:
        Numbers are plain values, and arithmetic combines them into new numbers.

        Example:
        `2 + 3`
        `6 * 2`

        Why:
        Numbers are another basic building block, and arithmetic is one of the simplest useful operations in code.

        Common cases:
        Count how many items you have
        Compute a simple total

        Watch out:
        This lesson is about building a result with operators, not hardcoding the answer.

        Task:
        Change the expression so it evaluates to `12`, and use `+` somewhere in the solution.
        """,
        starter_code: """
        6
        """,
        prerequisites: ["immutability-shelf"],
        checks: [
          source_contains("+",
            checkpoint: "Use addition",
            failure_message: "Use `+` somewhere in the expression."
          ),
          returns(12,
            checkpoint: "Return `12`",
            failure_message: "The final expression should evaluate to `12`."
          )
        ],
        hints: [
          "Build `12` with an expression, not a single literal.",
          "One valid answer is `6 + 6`.",
          "Keep it simple."
        ],
        quick_terms: [
          quick_term(
            "Arithmetic",
            "Arithmetic means using operators like `+`, `-`, `*`, and `/` with numbers."
          )
        ],
        rewards: reward(24, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex("numbers-new", "Numbers", "Numbers are values you can combine with arithmetic.")
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "number-check",
        title: "Number Check",
        summary: "Turn number comparisons into a simple boolean answer.",
        teaching_markdown: """
        What:
        Comparisons like `>` and `==` return booleans.

        Example:
        `3 > 2`
        `2 == 2`

        Why:
        Before you learn bigger control flow, you need to see that comparisons themselves already return useful true-or-false values.

        Common cases:
        Check whether one count is larger than another
        Check whether a value matches an expected amount

        Watch out:
        The boolean comes from the comparison. Do not hardcode `true`.

        Task:
        Keep `cups = 3` and `shots = 2`, then return `cups > shots`.
        """,
        starter_code: """
        cups = 3
        shots = 2
        false
        """,
        prerequisites: ["number-shelf"],
        checks: [
          source_contains(">",
            checkpoint: "Use `>` to compare the values",
            failure_message: "Use `>` to compare `cups` and `shots`."
          ),
          returns(true,
            checkpoint: "Return `true` from the comparison",
            failure_message: "The final expression should evaluate to `true`."
          )
        ],
        hints: [
          "Compare `cups` and `shots` directly.",
          "The final line can be `cups > shots`.",
          "Do not replace the line with a hardcoded boolean."
        ],
        quick_terms: [
          quick_term(
            "Comparison",
            "A comparison checks two values and returns `true` or `false`."
          )
        ],
        rewards: reward(24, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "comparisons-new",
            "Comparisons",
            "Comparisons return booleans you can use for simple decisions."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "tuple-pair",
        title: "Tuple Pair",
        summary: "Build a small ordered pair of related values.",
        teaching_markdown: """
        What:
        A tuple is a small ordered group of values written with curly braces.

        Example:
        `{"Nova", 1}`
        `{"latte", 2}`

        Why:
        Tuples are useful when you want to return or carry a few related values together.

        Common cases:
        Pair a label with a count
        Return a small two-part result

        Watch out:
        Position matters in a tuple. The first and second values are not interchangeable.
        In the next lesson, `=` will match this tuple shape, like `{drink, cups} = {"latte", 2}`.
        That does not change the tuple. It checks the shape and pulls the pieces into names.

        Task:
        Return the tuple `{"latte", 2}`.
        """,
        starter_code: """
        {"tea", 0}
        """,
        prerequisites: ["number-check"],
        checks: [
          returns({"latte", 2},
            checkpoint: "Return `{\"latte\", 2}`",
            failure_message: "The final expression should evaluate to `{\"latte\", 2}`."
          )
        ],
        hints: [
          "Keep the string first and the number second.",
          "Tuples use curly braces.",
          "The full answer can be `{\"latte\", 2}`."
        ],
        quick_terms: [
          quick_term(
            "Tuple",
            "A tuple is a small ordered group of values written with curly braces."
          ),
          quick_term(
            "Pattern matching (`=`)",
            "In Elixir, `=` tries to make the left side match the right side. When the shapes line up, values can be pulled into names."
          )
        ],
        rewards: reward(24, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex("tuples-new", "Tuples", "Tuples group a few related values in a fixed order.")
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "tuple-unpack",
        title: "Tuple Unpack",
        summary: "Read values back out of a tuple by unpacking it.",
        teaching_markdown: """
        What:
        In Elixir, `=` does pattern matching. With tuples, that lets you unpack one tuple into separate variables.

        Example:
        `{drink, cups} = {"latte", 2}`
        `drink`

        Why:
        Tuples become useful when you can both build them and unpack them again.

        Common cases:
        Pull a label and count back out of a pair
        Read two related values returned together

        Watch out:
        `{drink, cups} = order` does not change `order`.
        The shape on the left must match the shape on the right.

        Task:
        Keep `order = {"latte", 2}`, unpack it into `drink` and `cups`, then return `"\#{drink}:\#{cups}"`.
        """,
        starter_code: """
        order = {"latte", 2}
        "todo"
        """,
        prerequisites: ["tuple-pair"],
        checks: [
          source_contains("{drink, cups}",
            checkpoint: "Unpack the tuple into `drink` and `cups`",
            failure_message: "Unpack the tuple with `{drink, cups} = order`."
          ),
          returns("latte:2",
            checkpoint: "Return `\"latte:2\"`",
            failure_message: "The final expression should evaluate to `\"latte:2\"`."
          )
        ],
        hints: [
          "Match the tuple before the final line.",
          "Then build the final string with interpolation.",
          ~S|The final line can be `"#{drink}:#{cups}"`.|
        ],
        quick_terms: [
          quick_term(
            "Unpack",
            "Unpack means pull separate values back out of a tuple by matching its shape."
          ),
          quick_term(
            "Pattern matching (`=`)",
            "`=` is not just storing a value. It checks whether the left side matches the right side, and if it does, names can be filled in."
          )
        ],
        rewards: reward(26, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "tuple-unpack",
            "Unpacking Tuples",
            "Use pattern matching to pull separate variables out of a tuple."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "list-shelf-new",
        title: "List Shelf",
        summary: "Build a plain ordered list before doing anything more advanced with it.",
        teaching_markdown: """
        What:
        A list is an ordered sequence of values written with square brackets.

        Example:
        `[:coffee]`
        `[:beans, :water, :filter]`

        Why:
        Lists are one of Elixir's main collection types, so you need the simple shape first.

        Common cases:
        Store steps in order
        Store a short sequence of items

        Watch out:
        Lists use square brackets, not curly braces.

        Task:
        Build `supplies = [:beans, :water, :filter]` and return `supplies`.
        """,
        starter_code: """
        supplies = []
        supplies
        """,
        prerequisites: ["tuple-unpack"],
        checks: [
          binds(:supplies, [:beans, :water, :filter]),
          returns([:beans, :water, :filter])
        ],
        hints: [
          "Use square brackets.",
          "Separate the items with commas.",
          "Keep the final line as `supplies`."
        ],
        quick_terms: [
          quick_term(
            "List",
            "A list is an ordered sequence of values written with square brackets."
          )
        ],
        rewards: reward(24, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex("lists-new", "Lists", "Lists are ordered sequences of values.")
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "list-front",
        title: "List Front",
        summary: "Add one new item to the front of an existing list.",
        teaching_markdown: """
        What:
        `[item | list]` builds a new list by placing one new item in front of an existing list.

        Example:
        `[:filter | [:beans, :water]]`
        `["today" | ["tomorrow", "later"]]`

        Why:
        This is the most common small list-building operation in Elixir.

        Common cases:
        Put a newest item first
        Build a simple queue one item at a time

        Watch out:
        This returns a new list. It does not change the old list in place.

        Task:
        Keep `supplies = [:beans, :water]`, then replace the placeholder so the final expression adds `:filter` to the front.
        """,
        starter_code: """
        supplies = [:beans, :water]
        [:todo | supplies]
        """,
        prerequisites: ["list-shelf-new"],
        checks: [
          binds(:supplies, [:beans, :water]),
          source_contains("| supplies",
            checkpoint: "Keep the existing list on the right side",
            failure_message: "Keep `supplies` on the right side of the bar."
          ),
          returns([:filter, :beans, :water],
            checkpoint: "Return the new list",
            failure_message:
              "The final expression should evaluate to `[:filter, :beans, :water]`."
          )
        ],
        hints: [
          "Only replace the left-side placeholder.",
          "The right side should stay `supplies`.",
          "The final line should be `[:filter | supplies]`."
        ],
        quick_terms: [
          quick_term(
            "Prepend",
            "Prepend means add one new item to the front of an existing list."
          )
        ],
        rewards: reward(26, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "list-front",
            "Prepending to a List",
            "Use `[item | list]` when you want one new value at the front of an existing list."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "list-unpack",
        title: "List Unpack",
        summary: "Split a list into its first item and the rest of the list.",
        teaching_markdown: """
        What:
        `[first | rest]` can also unpack a list into the first item and the remaining list.

        Example:
        `[first | rest] = [:beans, :water]`
        `first`

        Why:
        Lists become much more useful once you can both build them and unpack them again.

        Common cases:
        Read the first item separately
        Pass the rest of the list forward for later work

        Watch out:
        `rest` is still a list, not a single value.

        Task:
        Keep `supplies = [:beans, :water]`, unpack it into `first` and `rest`, then return `{first, rest}`.
        """,
        starter_code: """
        supplies = [:beans, :water]
        {:todo, []}
        """,
        prerequisites: ["list-front"],
        checks: [
          source_contains("[first | rest]",
            checkpoint: "Use `[first | rest]` to unpack the list",
            failure_message: "Unpack the list with `[first | rest] = supplies`."
          ),
          returns({:beans, [:water]},
            checkpoint: "Return `{:beans, [:water]}`",
            failure_message: "The final expression should evaluate to `{:beans, [:water]}`."
          )
        ],
        hints: [
          "Match the list before the final line.",
          "The first item becomes `first`.",
          "The remaining list becomes `rest`."
        ],
        quick_terms: [
          quick_term("Rest", "The rest is the remaining list after the first item is removed.")
        ],
        rewards: reward(26, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "list-unpack",
            "Unpacking Lists",
            "Use `[first | rest]` when you want the first item and the remaining list separately."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "map-shelf-new",
        title: "Map Shelf",
        summary: "Build a plain map as a lookup table.",
        teaching_markdown: """
        What:
        A map stores key/value pairs.

        Example:
        `%{name: "Nova", cups: 2}`
        `%{drink: "latte", shots: 2}`

        Why:
        Maps are Elixir's main flexible structure for named data.

        Common cases:
        Store a small profile
        Store settings or labels

        Watch out:
        A map key points to a value. The key and the value are different jobs.

        Task:
        Build `order = %{drink: "latte", shots: 2}` and return `order`.
        """,
        starter_code: """
        order = %{}
        order
        """,
        prerequisites: ["list-unpack"],
        checks: [
          binds(:order, %{drink: "latte", shots: 2}),
          returns(%{drink: "latte", shots: 2})
        ],
        hints: [
          "Use `%{...}` for the map.",
          "Use atom keys `:drink` and `:shots`.",
          "Keep the final line as `order`."
        ],
        quick_terms: [
          quick_term("Map", "A map stores key/value pairs so a key can point to a value.")
        ],
        rewards: reward(24, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex("maps-new", "Maps", "Maps store named key/value data.")
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "map-read-new",
        title: "Map Read",
        summary: "Read values back out of a map in two practical ways.",
        teaching_markdown: """
        What:
        `Map.get/3` reads with a fallback, and bracket access reads an optional key.

        Example:
        `Map.get(order, :shots, 0)`
        `order[:drink]`

        Why:
        Building a map is only the first step. Real code also needs to read from it safely.

        Common cases:
        Read a known count with a fallback
        Read an optional value by key

        Watch out:
        Reading from a map does not change the map.

        Task:
        Keep `order = %{drink: "latte", shots: 2}` and return `{Map.get(order, :shots, 0), order[:drink]}`.
        """,
        starter_code: """
        order = %{drink: "latte", shots: 2}
        {0, ""}
        """,
        prerequisites: ["map-shelf-new"],
        checks: [
          source_contains("Map.get",
            checkpoint: "Use `Map.get/3`",
            failure_message: "Use `Map.get(order, :shots, 0)` for the first value."
          ),
          source_contains("order[:drink]",
            checkpoint: "Use bracket access",
            failure_message: "Use `order[:drink]` for the second value."
          ),
          returns({2, "latte"},
            checkpoint: "Return `{2, \"latte\"}`",
            failure_message: "The final expression should evaluate to `{2, \"latte\"}`."
          )
        ],
        hints: [
          "Use `Map.get` for the number.",
          "Use bracket access for the string.",
          "Return both values in a tuple."
        ],
        quick_terms: [
          quick_term("Fallback", "A fallback is the value you return if the key is missing.")
        ],
        rewards: reward(26, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "map-read",
            "Reading Maps",
            "Use `Map.get/3` and bracket access when you need to read values back out of a map."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "map-refresh-new",
        title: "Map Refresh",
        summary: "Add one new key to a map with a practical update.",
        teaching_markdown: """
        What:
        `Map.put/3` returns a new map with one key added or replaced.

        Example:
        `Map.put(order, :milk, :oat)`
        `Map.put(settings, :sound, true)`

        Why:
        This is the everyday way to add one piece of named data to an existing map.

        Common cases:
        Add one new setting
        Add one more field to a small data map

        Watch out:
        `Map.put/3` returns a new map. It does not modify the original in place.

        Task:
        Keep `order = %{drink: "latte", shots: 2}`, add `:milk` with `Map.put/3`, and return the updated map.
        """,
        starter_code: """
        order = %{drink: "latte", shots: 2}
        order
        """,
        prerequisites: ["map-read-new"],
        checks: [
          source_contains("Map.put",
            checkpoint: "Use `Map.put/3`",
            failure_message: "Use `Map.put(order, :milk, :oat)`."
          ),
          returns(%{drink: "latte", shots: 2, milk: :oat},
            checkpoint: "Return the updated map",
            failure_message:
              "The final expression should evaluate to `%{drink: \"latte\", shots: 2, milk: :oat}`."
          )
        ],
        hints: [
          "Add the new key to `order`.",
          "Use the atom `:milk` and the atom `:oat`.",
          "Return the result of `Map.put(...)`."
        ],
        quick_terms: [
          quick_term(
            "Update",
            "An update returns a new version of the data with one change applied."
          )
        ],
        rewards: reward(26, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "map-put",
            "Map.put",
            "Use `Map.put/3` when you want a new map with one key added or replaced."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "keyword-shelf-new",
        title: "Keyword Shelf",
        summary: "See keyword lists as a practical options format.",
        teaching_markdown: """
        What:
        A keyword list is a list of two-item pairs written in a short form like `[size: :large]`.

        Example:
        `[size: :large, iced: true]`
        `[timeout: 5_000, retries: 2]`

        Why:
        Keyword lists are common when passing options into functions.

        Common cases:
        Options for a helper
        Small configuration settings in order

        Watch out:
        Keyword lists look a little like maps, but they are still lists.

        Task:
        Build `opts = [size: :large, iced: true]` and return `Keyword.get(opts, :size)`.
        """,
        starter_code: """
        opts = []
        :unknown
        """,
        prerequisites: ["map-refresh-new"],
        checks: [
          binds(:opts, size: :large, iced: true),
          source_contains("Keyword.get",
            checkpoint: "Use `Keyword.get/3` or `Keyword.get/2`",
            failure_message: "Use `Keyword.get(opts, :size)`."
          ),
          returns(:large,
            checkpoint: "Return `:large`",
            failure_message: "The final expression should evaluate to `:large`."
          )
        ],
        hints: [
          "Build the keyword list first.",
          "Then read the `:size` option.",
          "The final line can be `Keyword.get(opts, :size)`."
        ],
        quick_terms: [
          quick_term(
            "Keyword list",
            "A keyword list is an options-style list written with `key: value` pairs."
          )
        ],
        rewards: reward(26, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "keyword-lists-new",
            "Keyword Lists",
            "Keyword lists are a common way to pass small ordered options into functions."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "state-signals-new",
        title: "State Signals",
        summary: "Use atoms, booleans, and nil as simple state values.",
        teaching_markdown: """
        What:
        Atoms are named constants, booleans are true-or-false values, and `nil` means “no value”.

        Example:
        `:awake`
        `true`
        `nil`

        Why:
        These values are the smallest building blocks for status and simple state.

        Common cases:
        `:ok` and `:error` as tags
        `true` and `false` as flags
        `nil` when a value is missing

        Watch out:
        `nil` is its own value. It is not the same thing as an atom.

        Task:
        Bind `status = :awake`, `ready? = true`, and `overdue = nil`, then return `%{status: status, ready?: ready?, overdue: overdue}`.
        """,
        starter_code: """
        status = nil
        ready? = false
        overdue = :later
        %{status: status, ready?: ready?, overdue: overdue}
        """,
        prerequisites: ["keyword-shelf-new"],
        checks: [
          binds(:status, :awake),
          binds(:ready?, true),
          binds(:overdue, nil),
          returns(%{status: :awake, ready?: true, overdue: nil})
        ],
        hints: [
          "Atoms start with a colon.",
          "Predicate-style names often end with `?`.",
          "Keep the final expression as the map."
        ],
        quick_terms: [
          quick_term("Atom", "An atom is a named constant like `:awake` or `:ok`."),
          quick_term("nil", "`nil` means no value is present.")
        ],
        rewards: reward(26, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "state-values",
            "Atoms, Booleans, and nil",
            "These values are the basic building blocks for tags, flags, and missing values."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "data-roundup",
        title: "Data Roundup",
        summary: "Use the core data types together in one small, readable summary.",
        teaching_markdown: """
        What:
        This checkpoint asks you to use several familiar data types together after learning them one at a time.

        Example:
        `%{name: "Nova", items: [:beans, :water]}`
        `{"Nova", 2}`

        Why:
        Once strings, numbers, tuples, lists, maps, and simple state values feel normal, combining them should feel much more reasonable.

        Common cases:
        Build a small summary from a map
        Return a compact pair like `{label, count}`

        Watch out:
        Keep the solution simple. Use the data types you already know instead of inventing new patterns.

        Task:
        Build `profile = %{name: "Nova", items: [:beans, :water]}`.
        Then return `{"Nova", 2}` by reading the name from the map and counting the list.
        """,
        starter_code: """
        profile = %{}
        {"", 0}
        """,
        prerequisites: ["state-signals-new"],
        checks: [
          binds(:profile, %{name: "Nova", items: [:beans, :water]}),
          source_contains("Map.get",
            checkpoint: "Read the name from the map",
            failure_message: "Use `Map.get(profile, :name)` to read the name."
          ),
          source_contains("length(",
            checkpoint: "Count the list with `length/1`",
            failure_message: "Use `length(...)` to count the items list."
          ),
          returns({"Nova", 2},
            checkpoint: "Return `{\"Nova\", 2}`",
            failure_message: "The final expression should evaluate to `{\"Nova\", 2}`."
          )
        ],
        hints: [
          "Build the profile map first.",
          "Read the name and items back out of the map.",
          "Return the final tuple with the name and the count."
        ],
        quick_terms: [
          quick_term("Count", "Count means how many items are in a collection.")
        ],
        rewards: reward(40, 2, 6, 6, 5, 2),
        codex_entries_unlocked: [
          codex(
            "data-roundup",
            "Data Roundup",
            "This checkpoint proves you can use the core Elixir data types together in one small piece of code."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "truth-check-new",
        title: "Truth Check",
        summary: "Combine a comparison with a boolean you already know.",
        teaching_markdown: """
        What:
        Boolean expressions combine true-or-false values into one final answer.

        Example:
        `ready? and cups == 2`
        `connected? and retries < 3`

        Why:
        Before bigger control flow, you need to be comfortable producing a boolean on purpose.

        Common cases:
        Check whether a flag is on and a value matches
        Require two simple conditions to both be true

        Watch out:
        The final `true` or `false` should come from the expression, not from a hardcoded literal.

        Task:
        Keep `ready? = true` and `cups = 2`, then return `ready? and cups == 2`.
        """,
        starter_code: """
        ready? = true
        cups = 2
        false
        """,
        prerequisites: ["data-roundup"],
        checks: [
          source_contains("and",
            checkpoint: "Use `and`",
            failure_message: "Use `and` to combine the two checks."
          ),
          source_contains("==",
            checkpoint: "Use `==`",
            failure_message: "Use `==` to compare `cups` with `2`."
          ),
          returns(true,
            checkpoint: "Return `true` from the expression",
            failure_message: "The final expression should evaluate to `true`."
          )
        ],
        hints: [
          "Keep both starting bindings exactly as they are.",
          "Compare `cups` with `2`.",
          "Then combine that with `ready?` using `and`."
        ],
        quick_terms: [
          quick_term("Boolean expression", "A boolean expression returns `true` or `false`.")
        ],
        rewards: reward(24, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "boolean-expressions",
            "Boolean Expressions",
            "Boolean expressions combine true-or-false values into one final answer."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "if-door",
        title: "If Door",
        summary: "Use `if` after you already understand booleans.",
        teaching_markdown: """
        What:
        `if` chooses between two branches based on whether a condition is truthy.

        Example:
        `if ready?, do: "brew", else: "wait"`
        `if overdue, do: "check in", else: "keep going"`

        Why:
        Once you can produce booleans on purpose, `if` becomes a simple next step.

        Common cases:
        Show one message when a flag is true
        Choose between two small labels

        Watch out:
        Only `false` and `nil` are falsy in Elixir.

        Task:
        Keep `ready? = true`, then use `if` to return `"brew"` when ready and `"wait"` otherwise.
        """,
        starter_code: """
        ready? = true
        "wait"
        """,
        prerequisites: ["truth-check-new"],
        checks: [
          ast_contains("if",
            checkpoint: "Use an `if` expression",
            failure_message: "This lesson expects an `if` expression."
          ),
          returns("brew",
            checkpoint: "Return `\"brew\"`",
            failure_message: "The final expression should evaluate to `\"brew\"`."
          )
        ],
        hints: [
          "Use `if condition, do: ..., else: ...`.",
          "The condition can be just `ready?`.",
          "The true branch should return `\"brew\"`."
        ],
        quick_terms: [
          quick_term("Truthy", "A truthy value acts like true in a condition.")
        ],
        rewards: reward(24, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex("if-new", "if", "Use `if` when you want one of two results based on a condition.")
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "tagged-signal-new",
        title: "Tagged Signal",
        summary: "Build a small tagged tuple before using it in control flow.",
        teaching_markdown: """
        What:
        A tagged tuple is a tuple whose first value is a small tag like `:ok` or `:error`.

        Example:
        `{:ok, "latte"}`
        `{:error, :empty}`

        Why:
        Tagged tuples are one of the most common Elixir shapes for success and error results.

        Common cases:
        `{:ok, value}` for success
        `{:error, reason}` for a simple failure

        Watch out:
        The first item is the tag that explains how to read the rest of the tuple.
        In the next lesson, `case` will check whether a value matches shapes like `{:ok, value}` or `{:error, reason}`.

        Task:
        Return `{:ok, "latte"}` as the final expression.
        """,
        starter_code: """
        {:pending, "tea"}
        """,
        prerequisites: ["if-door"],
        checks: [
          returns({:ok, "latte"},
            checkpoint: "Return `{:ok, \"latte\"}`",
            failure_message: "The final expression should evaluate to `{:ok, \"latte\"}`."
          )
        ],
        hints: [
          "Use the atom `:ok` as the tag.",
          "Keep the string value as `\"latte\"`.",
          "The whole answer can be exactly `{:ok, \"latte\"}`."
        ],
        quick_terms: [
          quick_term(
            "Tag",
            "A tag is the small first value that tells you what kind of result you have."
          )
        ],
        rewards: reward(24, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "tagged-tuples-new",
            "Tagged Tuples",
            "Tagged tuples use a small atom like `:ok` or `:error` to label what the rest of the tuple means."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "case-signal-new",
        title: "Case Signal",
        summary: "Use `case` to react to a tagged tuple you already understand.",
        teaching_markdown: """
        What:
        `case` checks one value against multiple patterns and runs the first matching branch.
        Each branch is asking, "Does the value match this shape?"

        Example:
        `case result do`
        `  {:ok, value} -> value`
        `  {:error, _reason} -> "stop"`
        `end`

        Why:
        `case` is the basic control-flow tool for tagged tuples.

        Common cases:
        Unpack a success tuple
        Return a fallback for an error tuple

        Watch out:
        A branch like `{:ok, value} -> ...` only runs when the value matches that tuple shape.
        Branches are checked from top to bottom, so put the specific matches first.

        Task:
        Keep `result = {:ok, "latte"}`.
        Use `case` to return `"latte ready"` for the success tuple and `"stop"` for the error tuple.
        """,
        starter_code: """
        result = {:ok, "latte"}

        case result do
          _value -> "stop"
        end
        """,
        prerequisites: ["tagged-signal-new"],
        checks: [
          ast_contains("case",
            checkpoint: "Use a `case` expression",
            failure_message: "This lesson expects a `case` expression."
          ),
          source_contains("{:error, _reason}",
            checkpoint: "Add an error branch",
            failure_message: "Add a fallback error branch like `{:error, _reason} -> \"stop\"`."
          ),
          returns("latte ready",
            checkpoint: "Return `\"latte ready\"`",
            failure_message: "The final expression should evaluate to `\"latte ready\"`."
          )
        ],
        hints: [
          "Match the success tuple in the first branch.",
          "Use interpolation or `<>` to build the success string.",
          "Keep the error branch returning `\"stop\"`."
        ],
        quick_terms: [
          quick_term(
            "Branch",
            "A branch is one possible path inside a control-flow expression like `case`."
          )
        ],
        rewards: reward(26, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "case-new",
            "case",
            "Use `case` when you want to match one value against several possible shapes."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "cond-lane-new",
        title: "Cond Lane",
        summary: "Use `cond` when you are checking several boolean conditions in order.",
        teaching_markdown: """
        What:
        `cond` runs the first branch whose condition is truthy.

        Example:
        `cond do`
        `  cups == 0 -> "empty"`
        `  cups < 3 -> "low"`
        `  true -> "ready"`
        `end`

        Why:
        `cond` is clearer than nesting many `if` expressions when you have more than two possibilities.

        Common cases:
        Classify a value into simple ranges
        Choose among several status labels

        Watch out:
        A final `true -> ...` branch acts like the default case.

        Task:
        Keep `cups = 2`, then use `cond` to return `"empty"` for `0`, `"low"` for values under `3`, and `"ready"` otherwise.
        """,
        starter_code: """
        cups = 2
        "ready"
        """,
        prerequisites: ["case-signal-new"],
        checks: [
          ast_contains("cond",
            checkpoint: "Use a `cond` expression",
            failure_message: "This lesson expects a `cond` expression."
          ),
          source_contains("cups == 0",
            checkpoint: "Check the empty case first",
            failure_message: "Add a first branch for `cups == 0`."
          ),
          source_contains("cups < 3",
            checkpoint: "Check the low case second",
            failure_message: "Add a second branch for `cups < 3`."
          ),
          source_contains("true ->",
            checkpoint: "Add a default branch",
            failure_message: "Add a fallback branch using `true ->`."
          ),
          returns("low",
            checkpoint: "Return `\"low\"`",
            failure_message: "With `cups = 2`, the final expression should evaluate to `\"low\"`."
          )
        ],
        hints: [
          "Start with `cond do` and end with `end`.",
          "Order the checks from most specific to fallback.",
          "Use `true -> \"ready\"` as the default."
        ],
        quick_terms: [
          quick_term(
            "Fallback",
            "A fallback is the branch that handles anything not matched earlier."
          )
        ],
        rewards: reward(26, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "cond-new",
            "cond",
            "Use `cond` when several boolean checks may be true and you want the first matching one."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "decision-roundup",
        title: "Decision Roundup",
        summary: "Use the first control-flow tools after learning them one at a time.",
        teaching_markdown: """
        What:
        This checkpoint combines booleans, `if`, tagged tuples, `case`, and `cond` after each one was introduced on its own.

        Example:
        `if ready?, do: {:ok, cups}, else: {:error, :sleepy}`
        `case result do`
        `  {:ok, value} -> ...`
        `  {:error, _reason} -> ...`
        `end`

        Why:
        Control flow becomes much easier once the individual tools are already familiar.

        Common cases:
        Turn a simple flag into a tagged result
        Classify a successful value into a label

        Watch out:
        Keep each step small. Build the boolean first, then the `if`, then the `case`, then the `cond`.

        Task:
        Define `ready? = true` and `cups = 2`.
        Build `result` with `if`: use `{:ok, cups}` when ready, otherwise `{:error, :sleepy}`.
        Then use `case` so:
        - `{:ok, amount}` runs a `cond`
        - the `cond` returns `"light"` when `amount == 1` and `"strong"` otherwise
        - `{:error, _reason}` returns `"stop"`

        The final expression should return `"strong"`.
        """,
        starter_code: """
        ready? = true
        cups = 2
        "todo"
        """,
        prerequisites: ["cond-lane-new"],
        checks: [
          ast_contains("if",
            checkpoint: "Use `if` to build the first result",
            failure_message: "Use an `if` expression to build `result`."
          ),
          ast_contains("case",
            checkpoint: "Use `case` to branch on the tagged tuple",
            failure_message: "Use a `case` expression on `result`."
          ),
          ast_contains("cond",
            checkpoint: "Use `cond` inside the success branch",
            failure_message: "Use `cond` inside the `{:ok, amount}` branch."
          ),
          returns("strong",
            checkpoint: "Return `\"strong\"`",
            failure_message: "The final expression should evaluate to `\"strong\"`."
          )
        ],
        hints: [
          "Build `result` first, then branch on it.",
          "Use `{:ok, amount}` in the success branch.",
          "Inside the `cond`, use a final `true -> \"strong\"` fallback."
        ],
        quick_terms: [
          quick_term(
            "Control flow",
            "Control flow means choosing which code path runs based on values and conditions."
          )
        ],
        rewards: reward(42, 2, 6, 6, 5, 2),
        codex_entries_unlocked: [
          codex(
            "decision-roundup",
            "Decision Roundup",
            "This checkpoint proves you can use the first control-flow tools together after learning them one at a time."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-pattern-matching",
        slug: "match-assertion",
        title: "Match Assertion",
        summary: "See that `=` can assert a shape or value, not just introduce a name.",
        teaching_markdown: """
        What:
        In Elixir, `=` performs pattern matching. It is not simple assignment in the usual sense.

        Example:
        `status = :ok`
        `:ok = status`

        Why:
        Pattern matching is the beating heart of Elixir. If you do not understand this, the language feels much more awkward.

        Common cases:
        Assert that a value is the one you expect
        Check that a result has the shape you planned for

        Watch out:
        `:ok = status` does not rename `status`. It checks whether `status` matches `:ok`.

        Task:
        Keep `status = :ok`.
        Add a second line that asserts the value with `:ok = status`.
        Then return `status`.
        """,
        starter_code: """
        status = :ok
        status
        """,
        prerequisites: ["value-tools-roundup"],
        checks: [
          binds(:status, :ok),
          source_contains(":ok = status",
            checkpoint: "Assert the value with pattern matching",
            failure_message: "Add a line that matches `:ok = status`."
          ),
          returns(:ok,
            checkpoint: "Return `:ok`",
            failure_message: "The final expression should evaluate to `:ok`."
          )
        ],
        hints: [
          "Keep the first line exactly as it is.",
          "Add a second line that matches the existing value.",
          "The final expression can still just be `status`."
        ],
        quick_terms: [
          quick_term(
            "Assertion",
            "An assertion here means checking that a value matches the shape or exact value you expect."
          )
        ],
        rewards: reward(28, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "pattern-assertion",
            "Pattern Matching with `=`",
            "In Elixir, `=` matches values and shapes instead of acting like simple reassignment."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-pattern-matching",
        slug: "match-tuples-track",
        title: "Match Tuples",
        summary: "Use pattern matching to pull the parts out of a tuple you already understand.",
        teaching_markdown: """
        What:
        Pattern matching can unpack a tuple by matching its shape.

        Example:
        `result = {:ok, "latte"}`
        `{:ok, drink} = result`

        Why:
        Pattern matching becomes much more useful once it can unpack structured data, not just check a single value.

        Common cases:
        Pull a value out of a success tuple
        Check the tag and unpack the payload at the same time

        Watch out:
        The left side must have the same shape as the right side.

        Task:
        Keep `result = {:ok, "latte"}`.
        Match it with a tuple pattern like `{:ok, value} = result`.
        Then return the matched value.
        """,
        starter_code: """
        result = {:ok, "latte"}
        "todo"
        """,
        prerequisites: ["match-assertion"],
        checks: [
          source_contains("} = result",
            checkpoint: "Unpack the tuple with a pattern",
            failure_message: "Match the tuple with a pattern like `{:ok, value} = result`."
          ),
          returns("latte",
            checkpoint: "Return `\"latte\"`",
            failure_message: "The final expression should evaluate to `\"latte\"`."
          )
        ],
        hints: [
          "Match both the `:ok` tag and the string at the same time.",
          "Bind the second part to a variable like `drink`.",
          "Return that variable on the last line."
        ],
        quick_terms: [
          quick_term(
            "Shape",
            "A shape is the structural form of a value, like a two-item tuple."
          )
        ],
        rewards: reward(30, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "pattern-tuples",
            "Tuple Pattern Matching",
            "Tuple patterns let you check a tuple’s shape and unpack its values at the same time."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-pattern-matching",
        slug: "match-lists-track",
        title: "Match Lists",
        summary: "Use pattern matching to split a list into its first item and the rest.",
        teaching_markdown: """
        What:
        Pattern matching can split a list into a first item and the remaining list.

        Example:
        `[first | rest] = [:beans, :water, :filter]`
        `first`

        Why:
        This is one of the most useful list patterns in Elixir, and it makes list-processing code feel much clearer.

        Common cases:
        Read the first item of a list
        Process one item now and keep the remaining items for later

        Watch out:
        The left side pattern means “first item and rest of list,” not “two separate normal values.”

        Task:
        Keep `supplies = [:beans, :water, :filter]`.
        Match it with a list pattern like `[head | tail] = supplies`.
        Then return a tuple with the first item and the number of remaining items.
        """,
        starter_code: """
        supplies = [:beans, :water, :filter]
        {:none, 0}
        """,
        prerequisites: ["match-tuples-track"],
        checks: [
          source_contains("= supplies",
            checkpoint: "Split the list with a pattern",
            failure_message: "Match the list with a pattern like `[head | tail] = supplies`."
          ),
          source_contains("|",
            checkpoint: "Use the head/tail list pattern",
            failure_message: "Use the `|` list pattern to split the first item from the rest."
          ),
          source_contains("length(",
            checkpoint: "Count the remaining items",
            failure_message: "Use `length(...)` when building the returned tuple."
          ),
          returns({:beans, 2},
            checkpoint: "Return `{:beans, 2}`",
            failure_message: "The final expression should evaluate to `{:beans, 2}`."
          )
        ],
        hints: [
          "Use the list pattern on a new line before the final expression.",
          "Bind the first item and the remaining list with any clear variable names.",
          "The returned tuple should use the first item and `length(...)` of the rest."
        ],
        quick_terms: [
          quick_term(
            "Head and tail",
            "Head and tail means the first item of a list and the rest of the list after it."
          )
        ],
        rewards: reward(32, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "pattern-lists",
            "List Pattern Matching",
            "List patterns can split one list into a first item and the remaining items."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-pattern-matching",
        slug: "match-case-track",
        title: "Match in Case",
        summary: "Use `case` when the shape of the value decides what should happen.",
        teaching_markdown: """
        What:
        `case` uses pattern matching to choose the first branch whose pattern matches the value.

        Example:
        `case result do`
        `  {:ok, drink} -> drink`
        `  {:error, _reason} -> "stop"`
        `end`

        Why:
        This is where pattern matching starts to drive control flow in a very Elixir-specific way.

        Common cases:
        Handle a success tuple one way and an error tuple another way
        Read a matched value directly inside the branch

        Watch out:
        The pattern belongs in the branch head, not in a separate `if`.

        Task:
        Keep `result = {:error, :empty}`.
        Use `case` to return `"latte"` for a success tuple like `{:ok, value}` and `"stop"` for `{:error, _reason}`.
        """,
        starter_code: """
        result = {:error, :empty}
        "todo"
        """,
        prerequisites: ["match-lists-track"],
        checks: [
          ast_contains("case",
            checkpoint: "Use a `case` expression",
            failure_message: "This lesson expects a `case` expression."
          ),
          source_contains("{:ok, ",
            checkpoint: "Add the success pattern",
            failure_message: "Add a branch that matches a success tuple like `{:ok, value}`."
          ),
          source_contains("{:error, _reason}",
            checkpoint: "Add the error pattern",
            failure_message: "Add a branch that matches `{:error, _reason}`."
          ),
          returns("stop",
            checkpoint: "Return `\"stop\"`",
            failure_message:
              "With `{:error, :empty}`, the final expression should evaluate to `\"stop\"`."
          )
        ],
        hints: [
          "Start with `case result do`.",
          "Give the success branch a variable name like `drink` or `value`.",
          "The error branch should return `\"stop\"`."
        ],
        quick_terms: [
          quick_term(
            "Branch head",
            "A branch head is the pattern before `->` that decides whether that branch runs."
          )
        ],
        rewards: reward(32, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "pattern-case",
            "Pattern Matching in case",
            "A `case` expression uses pattern matching to choose the first branch that fits the value."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-pattern-matching",
        slug: "match-function-heads-track",
        title: "Match in Function Heads",
        summary:
          "Use pattern matching in function signatures instead of matching later inside the body.",
        teaching_markdown: """
        What:
        Function clauses can pattern match in the argument list, so different shapes go to different function bodies.

        Example:
        `def label({:ok, drink}), do: drink`
        `def label({:error, _reason}), do: "stop"`

        Why:
        This is one of the most idiomatic Elixir patterns. It keeps matching close to the function entry point.

        Common cases:
        Give success and error tuples different function clauses
        Put the shape-specific logic directly in the function head

        Watch out:
        The different clauses must have the same function name and arity.

        Task:
        Define `CodiePlayground.Matcher.label/1` with two clauses:
        - `{:ok, drink}` returns `drink`
        - `{:error, _reason}` returns `"stop"`

        Make the final expression call `CodiePlayground.Matcher.label({:ok, "latte"})`.
        """,
        starter_code: """
        defmodule CodiePlayground.Matcher do
          def label(result), do: result
        end

        CodiePlayground.Matcher.label({:error, :empty})
        """,
        prerequisites: ["match-case-track"],
        checks: [
          source_contains("def label({:ok, drink})",
            checkpoint: "Match the success tuple in the function head",
            failure_message: "Add a clause like `def label({:ok, drink}), do: ...`."
          ),
          source_contains("def label({:error, _reason})",
            checkpoint: "Match the error tuple in the function head",
            failure_message: "Add a second clause for `{:error, _reason}`."
          ),
          module_function(CodiePlayground.Matcher, :label, [{:ok, "latte"}], "latte",
            checkpoint: "`label/1` should return `\"latte\"` for success",
            failure_message:
              "`CodiePlayground.Matcher.label({:ok, \"latte\"})` should return `\"latte\"`."
          ),
          module_function(CodiePlayground.Matcher, :label, [{:error, :empty}], "stop",
            checkpoint: "`label/1` should return `\"stop\"` for error",
            failure_message:
              "`CodiePlayground.Matcher.label({:error, :empty})` should return `\"stop\"`."
          ),
          returns("latte",
            checkpoint: "Return `\"latte\"` from the final call",
            failure_message: "The final expression should evaluate to `\"latte\"`."
          )
        ],
        hints: [
          "Use two `def label(...)` clauses with different patterns.",
          "The final line should call the function with `{:ok, \"latte\"}`.",
          "Return the `drink` variable directly in the success clause."
        ],
        quick_terms: [
          quick_term(
            "Function head",
            "The function head is the `def name(args)` part where Elixir can pattern match the arguments."
          )
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "pattern-function-heads",
            "Pattern Matching in Function Heads",
            "Elixir functions can match argument shapes directly in their function clauses."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-pattern-matching",
        slug: "match-guards-track",
        title: "Match Guards",
        summary: "Use `when` guards on function heads to add conditions beyond shape.",
        teaching_markdown: """
        What:
        A guard clause adds a condition after the function head using `when`. It lets you match by shape and test a value.

        Example:
        `def label(n) when n > 0, do: "positive"`
        `def label(_n), do: "zero or negative"`

        Why:
        Pattern matching checks shape but not value ranges. Guards fill that gap with a readable, declarative check.

        Common cases:
        Restrict a clause to positive numbers
        Handle different value ranges in separate clauses

        Watch out:
        Only a limited set of expressions are allowed in guards. Stick to comparisons, type checks, and arithmetic.

        Task:
        Define `CodiePlayground.Guard.label/1` with two clauses:
        - When `n > 0`, return `"hot"`
        - Otherwise, return `"cold"`

        Make the final expression call `CodiePlayground.Guard.label(3)`.
        """,
        starter_code: """
        defmodule CodiePlayground.Guard do
          def label(_n), do: "todo"
        end

        CodiePlayground.Guard.label(0)
        """,
        prerequisites: ["match-function-heads-track"],
        checks: [
          ast_contains("when",
            checkpoint: "Use a `when` guard",
            failure_message: "Add a `when` guard to one of the function clauses."
          ),
          module_function(CodiePlayground.Guard, :label, [3], "hot",
            checkpoint: "`label/1` should return `\"hot\"` for positive numbers",
            failure_message: "`CodiePlayground.Guard.label(3)` should return `\"hot\"`."
          ),
          module_function(CodiePlayground.Guard, :label, [0], "cold",
            checkpoint: "`label/1` should return `\"cold\"` for zero",
            failure_message: "`CodiePlayground.Guard.label(0)` should return `\"cold\"`."
          ),
          returns("hot",
            checkpoint: "Return `\"hot\"` from the final call",
            failure_message: "The final expression should evaluate to `\"hot\"`."
          )
        ],
        hints: [
          "Write `def label(n) when n > 0, do: \"hot\"` as the first clause.",
          "Add a catch-all clause `def label(_n), do: \"cold\"`.",
          "Call `label(3)` on the final line."
        ],
        quick_terms: [
          quick_term(
            "Guard",
            "A guard is a `when` condition on a function head that adds a value check beyond shape."
          )
        ],
        rewards: reward(36, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "match-guards",
            "Guards in Function Heads",
            "Use `when` guards to add value conditions on top of pattern matching."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-pattern-matching",
        slug: "match-pin-track",
        title: "Pin Operator",
        summary: "Use `^` to match against an existing variable's value instead of rebinding.",
        teaching_markdown: """
        What:
        The pin operator `^` forces Elixir to match the current value of a variable instead of rebinding it.

        Example:
        `drink = "latte"`
        `{^drink, size} = {"latte", :large}`

        Why:
        Without `^`, Elixir rebinds the variable to whatever is on the right side. The pin operator says "match this exact value."

        Common cases:
        Assert a known value in a pattern match
        Match a previously bound variable in a tuple or list

        Watch out:
        If the pinned value does not match, you get a `MatchError` at runtime.

        Task:
        Bind `expected = "latte"`.
        Then match `{^expected, size} = {"latte", :large}`.
        Return `size`.
        """,
        starter_code: """
        expected = "latte"
        {_, size} = {"latte", :large}
        size
        """,
        prerequisites: ["match-guards-track"],
        checks: [
          source_contains("^",
            checkpoint: "Use the pin operator",
            failure_message: "Use `^expected` in the pattern match."
          ),
          returns(:large,
            checkpoint: "Return `:large`",
            failure_message: "The final expression should evaluate to `:large`."
          )
        ],
        hints: [
          "Replace `_` with `^expected` in the tuple pattern.",
          "The pin operator is `^` placed before the variable name.",
          "The final expression should be `size`."
        ],
        quick_terms: [
          quick_term(
            "Pin operator",
            "The `^` operator matches against an existing variable's value instead of rebinding it."
          )
        ],
        rewards: reward(36, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "match-pin",
            "Pin Operator",
            "Use `^variable` to match the current value of a variable in a pattern."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-pattern-matching",
        slug: "pattern-roundup",
        title: "Pattern Roundup",
        tier: :boss,
        summary: "Combine the main beginner pattern-matching forms in one small module function.",
        teaching_markdown: """
        What:
        This checkpoint combines direct matching, tuple matching, list matching, and `case` inside one small module function.

        Example:
        `{:ok, drink} = result`
        `[first | rest] = items`

        Why:
        Pattern matching becomes natural only after you see the same idea work in several places.

        Common cases:
        Assert a known value
        Unpack a result tuple
        Route a matched tuple through a `case` branch

        Watch out:
        Keep the matching in the most natural place: direct match for simple unpacking, `case` for branching, function heads for reusable logic.

        Task:
        Define `CodiePlayground.Patterns.summary/2`.
        It should:
        - match `:ok = status`
        - match `[first | rest] = items`
        - use `case` on `status_result = {:ok, first}`
        - return `"\#{drink}:\#{length(rest)}"` in the success case
        - return `"stop"` in the error case

        Then call `CodiePlayground.Patterns.summary(:ok, [:latte, :tea, :water])`.
        The final expression should return `"latte:2"`.
        """,
        starter_code: """
        defmodule CodiePlayground.Patterns do
          def summary(_status, _items), do: "todo"
        end

        CodiePlayground.Patterns.summary(:ok, [])
        """,
        prerequisites: ["match-pin-track"],
        checks: [
          source_contains(":ok = status",
            checkpoint: "Assert the status first",
            failure_message: "Add a line that matches `:ok = status`."
          ),
          source_contains("[first | rest] = items",
            checkpoint: "Split the list with a pattern",
            failure_message: "Match the list as `[first | rest] = items`."
          ),
          ast_contains("case",
            checkpoint: "Use `case` for the result tuple",
            failure_message: "Use a `case` expression on the result tuple."
          ),
          module_function(
            CodiePlayground.Patterns,
            :summary,
            [:ok, [:latte, :tea, :water]],
            "latte:2",
            checkpoint: "`summary/2` should return `\"latte:2\"`",
            failure_message:
              "`CodiePlayground.Patterns.summary(:ok, [:latte, :tea, :water])` should return `\"latte:2\"`."
          ),
          returns("latte:2",
            checkpoint: "Return `\"latte:2\"` from the final call",
            failure_message: "The final expression should evaluate to `\"latte:2\"`."
          )
        ],
        hints: [
          "Start by matching `status` and `items` inside the function body.",
          "Build `status_result = {:ok, first}` before the `case`.",
          "Use interpolation for the success string."
        ],
        quick_terms: [
          quick_term(
            "Pattern matching",
            "Pattern matching means checking a value’s shape and binding parts of it in one step."
          )
        ],
        rewards: reward(48, 2, 6, 6, 5, 2),
        codex_entries_unlocked: [
          codex(
            "pattern-roundup",
            "Pattern Matching Roundup",
            "This checkpoint proves you can use pattern matching in the main beginner places Elixir relies on."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-complex-data-structures",
        slug: "data-shapes-lists-tuples",
        title: "Data Shapes: Lists vs Tuples",
        summary:
          "Compare lists and tuples directly by using their common operations side by side.",
        teaching_markdown: """
        What:
        Lists and tuples are both collections, but they are used differently in Elixir.

        Example:
        `items = [:latte, :tea, :water]`
        `pair = {"latte", 2}`

        Why:
        A list is for ordered sequences you process step-by-step. A tuple is for a fixed-size grouped shape.

        Common cases:
        Use a list for many items in order
        Use a tuple for a compact pair like `{name, count}`

        Watch out:
        These are not interchangeable. Pick the shape based on meaning, not just syntax.

        Task:
        Keep `items = [:latte, :tea, :water]` and `pair = {"latte", 2}`.
        Return `{length(items), tuple_size(pair)}`.
        """,
        starter_code: """
        items = [:latte, :tea, :water]
        pair = {"latte", 2}
        {0, 0}
        """,
        prerequisites: ["pattern-roundup"],
        checks: [
          source_contains("length(items)",
            checkpoint: "Use a list-focused operation",
            failure_message: "Use `length(items)` for the list value."
          ),
          source_contains("tuple_size(pair)",
            checkpoint: "Use a tuple-focused operation",
            failure_message: "Use `tuple_size(pair)` for the tuple value."
          ),
          returns({3, 2},
            checkpoint: "Return `{3, 2}`",
            failure_message: "The final expression should evaluate to `{3, 2}`."
          )
        ],
        hints: [
          "Keep both bindings as they are.",
          "Use `length/1` for the list.",
          "Use `tuple_size/1` for the tuple."
        ],
        quick_terms: [
          quick_term(
            "Fixed-size",
            "Fixed-size means the shape is expected to have a known number of items."
          )
        ],
        rewards: reward(30, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "lists-vs-tuples",
            "Lists vs Tuples",
            "Use lists for ordered sequences and tuples for compact fixed-size grouped values."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-complex-data-structures",
        slug: "data-shapes-maps-keywords",
        title: "Data Shapes: Maps vs Keyword Lists",
        summary: "Use maps for data records and keyword lists for options.",
        teaching_markdown: """
        What:
        Maps and keyword lists can look similar, but they serve different roles.

        Example:
        `profile = %{name: "Nova", cups: 2}`
        `opts = [size: :large, iced: false]`

        Why:
        Knowing map vs keyword-list usage is crucial for writing idiomatic Elixir.

        Common cases:
        Use a map for core record-like data
        Use a keyword list for optional settings

        Watch out:
        Keyword lists are lists of pairs and can be used as options; maps are key/value data structures.

        Task:
        Keep `profile` and `opts`.
        Return `{Map.get(profile, :name), Keyword.get(opts, :size)}`.
        """,
        starter_code: """
        profile = %{name: "Nova", cups: 2}
        opts = [size: :large, iced: false]
        {"", :small}
        """,
        prerequisites: ["data-shapes-lists-tuples"],
        checks: [
          source_contains("Map.get(profile, :name)",
            checkpoint: "Read record data from the map",
            failure_message: "Use `Map.get(profile, :name)` for the first value."
          ),
          source_contains("Keyword.get(opts, :size)",
            checkpoint: "Read an option from the keyword list",
            failure_message: "Use `Keyword.get(opts, :size)` for the second value."
          ),
          returns({"Nova", :large},
            checkpoint: "Return `{\"Nova\", :large}`",
            failure_message: "The final expression should evaluate to `{\"Nova\", :large}`."
          )
        ],
        hints: [
          "Use `Map.get` on `profile`.",
          "Use `Keyword.get` on `opts`.",
          "Return both in a tuple."
        ],
        quick_terms: [
          quick_term(
            "Options",
            "Options are optional settings often passed as keyword lists."
          )
        ],
        rewards: reward(32, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "maps-vs-keywords",
            "Maps vs Keyword Lists",
            "Use maps for record-like data and keyword lists for options and configuration."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-complex-data-structures",
        slug: "data-shapes-structs-maps",
        title: "Data Shapes: Structs vs Maps",
        summary: "Use a struct when the shape should be named and stable.",
        teaching_markdown: """
        What:
        A struct is a named, fixed-shape map-like value. A plain map is more flexible.

        Example:
        `%Order{drink: "latte", cups: 2}`
        `%{drink: "latte", cups: 2, note: "hot"}`

        Why:
        Use structs when the data shape represents a known domain entity.

        Common cases:
        Use structs for core domain objects
        Use plain maps for generic or ad-hoc data

        Watch out:
        Structs need a module with `defstruct`.

        Task:
        Define `CodiePlayground.Order` with `defstruct drink: "", cups: 0`.
        Build `order = struct(CodiePlayground.Order, drink: "latte", cups: 2)`.
        Keep `meta = %{grind: "fine"}`.
        Return `{order.drink, Map.get(meta, :grind)}`.
        """,
        starter_code: """
        defmodule CodiePlayground.Order do
          defstruct drink: "", cups: 0
        end

        order = struct(CodiePlayground.Order)
        meta = %{grind: "fine"}
        {"", ""}
        """,
        prerequisites: ["data-shapes-maps-keywords"],
        checks: [
          source_contains("defstruct",
            checkpoint: "Keep the struct definition",
            failure_message: "Keep `defstruct` in `CodiePlayground.Order`."
          ),
          source_contains("struct(CodiePlayground.Order",
            checkpoint: "Build the named struct value",
            failure_message: "Build `order` with `struct(CodiePlayground.Order, ...)`."
          ),
          source_contains("Map.get(meta, :grind)",
            checkpoint: "Read flexible metadata from the map",
            failure_message: "Use `Map.get(meta, :grind)` in the final tuple."
          ),
          returns({"latte", "fine"},
            checkpoint: "Return `{\"latte\", \"fine\"}`",
            failure_message: "The final expression should evaluate to `{\"latte\", \"fine\"}`."
          )
        ],
        hints: [
          "Set `drink: \"latte\"` and `cups: 2` when building the struct.",
          "Keep `meta` as a plain map.",
          "Return tuple values from the struct and map."
        ],
        quick_terms: [
          quick_term(
            "Domain shape",
            "A domain shape is a stable data model that represents a real thing in your app."
          )
        ],
        rewards: reward(34, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "structs-vs-maps",
            "Structs vs Maps",
            "Use structs for named stable domain data and maps for flexible generic data."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-complex-data-structures",
        slug: "complex-data-structures-roundup",
        title: "Complex Data Structures Roundup",
        tier: :boss,
        summary: "Pick the right shape for each job in one short practical flow.",
        teaching_markdown: """
        What:
        This checkpoint combines list, tuple, map, keyword list, and struct usage in one focused task.

        Example:
        `items = [:latte, :tea, :water]`
        `opts = [size: :large]`

        Why:
        The goal is not memorizing syntax. The goal is choosing the right data structure for each role.

        Common cases:
        Sequence in a list
        Pair in a tuple
        Record data in a map or struct
        Options in a keyword list

        Watch out:
        Keep each data shape in its role instead of forcing one shape to do every job.

        Task:
        Define `CodiePlayground.Basket` with `defstruct first: :none, count: 0`.
        Bind:
        - `items = [:latte, :tea, :water]`
        - `pair = {:ok, hd(items)}`
        - `profile = %{name: "Nova"}`
        - `opts = [size: :large]`

        Pattern-match `pair` as `{:ok, first}`.
        Build `basket = struct(CodiePlayground.Basket, first: first, count: length(items))`.
        Return `{basket.first, basket.count, Map.get(profile, :name), Keyword.get(opts, :size)}`.

        The final expression should return `{:latte, 3, "Nova", :large}`.
        """,
        starter_code: """
        defmodule CodiePlayground.Basket do
          defstruct first: :none, count: 0
        end

        items = [:latte, :tea, :water]
        pair = {:ok, hd(items)}
        profile = %{name: "Nova"}
        opts = [size: :large]
        {:none, 0, "", :small}
        """,
        prerequisites: ["data-shapes-structs-maps"],
        checks: [
          source_contains("{:ok, first} = pair",
            checkpoint: "Pattern match the tuple",
            failure_message: "Match the tuple as `{:ok, first} = pair`."
          ),
          source_contains("struct(CodiePlayground.Basket",
            checkpoint: "Build the struct for stable basket shape",
            failure_message: "Build `basket` with `struct(CodiePlayground.Basket, ...)`."
          ),
          source_contains("Map.get(profile, :name)",
            checkpoint: "Read record data from a map",
            failure_message: "Use `Map.get(profile, :name)` in the final tuple."
          ),
          source_contains("Keyword.get(opts, :size)",
            checkpoint: "Read options from a keyword list",
            failure_message: "Use `Keyword.get(opts, :size)` in the final tuple."
          ),
          returns({:latte, 3, "Nova", :large},
            checkpoint: "Return `{:latte, 3, \"Nova\", :large}`",
            failure_message:
              "The final expression should evaluate to `{:latte, 3, \"Nova\", :large}`."
          )
        ],
        hints: [
          "Pattern-match `pair` before building `basket`.",
          "Set `count` with `length(items)`.",
          "Read profile and options with `Map.get` and `Keyword.get`."
        ],
        quick_terms: [
          quick_term(
            "Idiomatic",
            "Idiomatic means using the data shape and pattern most natural for the language."
          )
        ],
        rewards: reward(52, 2, 6, 6, 5, 2),
        codex_entries_unlocked: [
          codex(
            "complex-data-roundup",
            "Complex Data Structures Roundup",
            "This checkpoint proves you can choose and use lists, tuples, maps, keyword lists, and structs appropriately."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-functions-modules-pipe",
        slug: "fn-values-lab",
        title: "Function Values Lab",
        summary: "Treat an anonymous function as a normal value and call it clearly.",
        teaching_markdown: """
        What:
        Anonymous functions are values. You can bind them to names and call them later.

        Example:
        `shout = fn word -> String.upcase(word) end`
        `shout.("latte")`

        Why:
        Function values are one of the core building blocks of Elixir style.

        Common cases:
        Keep a tiny formatter in a variable
        Reuse one operation without repeating the body

        Watch out:
        Call anonymous functions with `.()`, not plain parentheses.

        Task:
        Keep `shout = fn word -> String.upcase(word) end`.
        Then call it with `"latte"` and return the result.
        """,
        starter_code: """
        shout = fn word -> String.upcase(word) end
        "todo"
        """,
        prerequisites: ["complex-data-structures-roundup"],
        checks: [
          source_contains("fn",
            checkpoint: "Keep the anonymous function",
            failure_message: "Keep the `fn ... end` function value."
          ),
          source_contains(".(",
            checkpoint: "Call the function value with `.()`",
            failure_message: "Call the function value with `.()`."
          ),
          returns("LATTE",
            checkpoint: "Return `\"LATTE\"`",
            failure_message: "The final expression should evaluate to `\"LATTE\"`."
          )
        ],
        hints: [
          "Do not replace the function with a plain string.",
          "Call `shout` like `shout.(...)`.",
          "Pass in `\"latte\"`."
        ],
        quick_terms: [
          quick_term(
            "Anonymous function",
            "An anonymous function is a function value written with `fn ... end`."
          )
        ],
        rewards: reward(30, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "fn-values-lab",
            "Anonymous Function Values",
            "Anonymous functions can be stored in variables and called later like other values."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-functions-modules-pipe",
        slug: "module-functions-lab",
        title: "Module Functions Lab",
        summary: "Define named functions in a module and call them directly.",
        teaching_markdown: """
        What:
        Modules group named functions. This is the standard way to organize reusable Elixir code.

        Example:
        `defmodule Brew do`
        `  def label(drink), do: "serve " <> drink`
        `end`

        Why:
        Named module functions make code easier to read, test, and reuse.

        Common cases:
        Group related behavior in one module
        Call named functions from other parts of the app

        Watch out:
        `def` declares a named function inside `defmodule`.

        Task:
        Define `CodiePlayground.Brew.label/1` so it returns `"serve " <> drink`.
        Then call it with `"latte"` and return the result.
        """,
        starter_code: """
        defmodule CodiePlayground.Brew do
          def label(_drink), do: "todo"
        end

        CodiePlayground.Brew.label("tea")
        """,
        prerequisites: ["fn-values-lab"],
        checks: [
          source_contains("defmodule CodiePlayground.Brew",
            checkpoint: "Define the module",
            failure_message: "Keep `defmodule CodiePlayground.Brew do ... end`."
          ),
          source_contains("def label(",
            checkpoint: "Define the named function",
            failure_message: "Define `label/1` with `def label(...)`."
          ),
          module_function(CodiePlayground.Brew, :label, ["latte"], "serve latte",
            checkpoint: "`label/1` should return `\"serve latte\"`",
            failure_message:
              "`CodiePlayground.Brew.label(\"latte\")` should return `\"serve latte\"`."
          ),
          returns("serve latte",
            checkpoint: "Return `\"serve latte\"`",
            failure_message: "The final expression should evaluate to `\"serve latte\"`."
          )
        ],
        hints: [
          "Keep the module name exactly `CodiePlayground.Brew`.",
          "Use `\"serve \" <> drink` in `label/1`.",
          "Call `label/1` with `\"latte\"` on the last line."
        ],
        quick_terms: [
          quick_term(
            "Named function",
            "A named function is declared with `def` inside a module."
          )
        ],
        rewards: reward(32, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "module-functions-lab",
            "Named Module Functions",
            "Use modules and named functions to organize reusable Elixir behavior."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-functions-modules-pipe",
        slug: "arity-lab",
        title: "Arity Lab",
        summary: "Read and use function arity with a practical example.",
        teaching_markdown: """
        What:
        Arity means how many arguments a function takes, written like `String.length/1`.

        Example:
        `String.length("latte")`
        `Enum.count([:a, :b])`

        Why:
        Arity is part of how Elixir identifies functions and helps you read docs quickly.

        Common cases:
        Identify the right function in docs by name and arity
        Differentiate functions that share a name but take different arguments

        Watch out:
        `/1` is docs notation, not call syntax.

        Task:
        Bind `size = String.length("latte")`.
        Return `{size, is_integer(size)}`.
        """,
        starter_code: """
        size = 0
        {0, false}
        """,
        prerequisites: ["module-functions-lab"],
        checks: [
          source_contains("String.length(\"latte\")",
            checkpoint: "Use `String.length/1`",
            failure_message: "Set `size` using `String.length(\"latte\")`."
          ),
          source_contains("is_integer(size)",
            checkpoint: "Check the type of `size`",
            failure_message: "Use `is_integer(size)` in the returned tuple."
          ),
          returns({5, true},
            checkpoint: "Return `{5, true}`",
            failure_message: "The final expression should evaluate to `{5, true}`."
          )
        ],
        hints: [
          "Set `size` with `String.length(\"latte\")`.",
          "Return `size` as the first tuple value.",
          "Use `is_integer(size)` as the second tuple value."
        ],
        quick_terms: [
          quick_term(
            "Arity",
            "Arity is the number of arguments a function takes, like `/1` or `/2`."
          )
        ],
        rewards: reward(32, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "arity-lab",
            "Function Arity",
            "Arity tells you how many arguments a function accepts and is core to reading Elixir docs."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-functions-modules-pipe",
        slug: "pipe-flow-lab",
        title: "Pipe Flow Lab",
        summary: "Use `|>` so data reads top-to-bottom through each transformation.",
        teaching_markdown: """
        What:
        The pipe operator passes the value from the left into the first argument of the function on the right.

        Example:
        `" latte "`
        `|> String.trim()`
        `|> String.upcase()`

        Why:
        Pipes make multi-step transformations easier to read and maintain.

        Common cases:
        Clean input, then transform it
        Build a clear step-by-step data flow

        Watch out:
        Pipe chains are best when each step is small and focused.

        Task:
        Start from `" latte "`.
        Pipe through `String.trim/1`, then `String.upcase/1`.
        Return the final value.
        """,
        starter_code: """
        " latte "
        """,
        prerequisites: ["arity-lab"],
        checks: [
          ast_contains("|>",
            checkpoint: "Use a pipe chain",
            failure_message: "Use `|>` for this lesson."
          ),
          source_contains("String.trim",
            checkpoint: "Trim first",
            failure_message: "Include a `String.trim(...)` step."
          ),
          source_contains("String.upcase",
            checkpoint: "Upcase second",
            failure_message: "Include a `String.upcase(...)` step."
          ),
          returns("LATTE",
            checkpoint: "Return `\"LATTE\"`",
            failure_message: "The final expression should evaluate to `\"LATTE\"`."
          )
        ],
        hints: [
          "Start with the original string literal on the first line.",
          "Add `|> String.trim()` next.",
          "Then add `|> String.upcase()`."
        ],
        quick_terms: [
          quick_term(
            "Pipeline",
            "A pipeline is a chain of steps where each step receives the previous result."
          )
        ],
        rewards: reward(34, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "pipe-flow-lab",
            "Pipe Operator",
            "Use `|>` to build readable top-to-bottom data transformation flows."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-functions-modules-pipe",
        slug: "private-functions-lab",
        title: "Private Functions Lab",
        summary: "Use `defp` to define helper functions that stay inside the module.",
        teaching_markdown: """
        What:
        `defp` defines a private function. It can only be called from inside the same module.

        Example:
        `defp normalize(drink), do: String.downcase(drink)`
        `def label(drink), do: "serve " <> normalize(drink)`

        Why:
        Private functions keep internal logic hidden and the public API clean.

        Common cases:
        Extract a repeated transformation into a private helper
        Keep implementation details out of the public interface

        Watch out:
        You cannot call a `defp` function from outside the module. It will raise an `UndefinedFunctionError`.

        Task:
        Define `CodiePlayground.Menu` with:
        - a public `label/1` that returns `"serve " <> normalize(drink)`
        - a private `normalize/1` that returns `String.downcase(drink)`

        Call `CodiePlayground.Menu.label("LATTE")` as the final expression.
        """,
        starter_code: """
        defmodule CodiePlayground.Menu do
          def label(drink), do: drink
        end

        CodiePlayground.Menu.label("LATTE")
        """,
        prerequisites: ["module-functions-lab"],
        checks: [
          source_contains("defp",
            checkpoint: "Use a private function",
            failure_message: "Define a private helper with `defp`."
          ),
          module_function(CodiePlayground.Menu, :label, ["LATTE"], "serve latte",
            checkpoint: "`label/1` should return `\"serve latte\"`",
            failure_message:
              "`CodiePlayground.Menu.label(\"LATTE\")` should return `\"serve latte\"`."
          ),
          returns("serve latte",
            checkpoint: "Return `\"serve latte\"`",
            failure_message: "The final expression should evaluate to `\"serve latte\"`."
          )
        ],
        hints: [
          "Add `defp normalize(drink), do: String.downcase(drink)` inside the module.",
          "Call `normalize(drink)` from inside `label/1`.",
          "The final line should call `label(\"LATTE\")`."
        ],
        quick_terms: [
          quick_term(
            "Private function",
            "A `defp` function is only callable from within its own module."
          )
        ],
        rewards: reward(34, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "private-functions",
            "Private Functions",
            "Use `defp` to define helper functions visible only inside the module."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-functions-modules-pipe",
        slug: "module-directives-lab",
        title: "Import Lab",
        summary:
          "Practice the `import` module directive so selected functions can be called without a module prefix.",
        teaching_markdown: """
        What:
        This lesson focuses on `import`, one specific module directive. It pulls selected functions into scope so you can call them without the module prefix.

        Example:
        `import String, only: [upcase: 1]`

        Why:
        `import` reduces repetition when you want to use a specific function several times inside a module.

        Common cases:
        Import specific functions you use repeatedly

        Watch out:
        Import only the functions you need so it stays clear where names come from.

        Task:
        Define `CodiePlayground.Shorten` that:
        - uses `import String, only: [upcase: 1]`
        - defines `shout/1` that calls `upcase(drink)` directly (no `String.` prefix)

        Call `CodiePlayground.Shorten.shout("latte")` as the final expression.
        """,
        starter_code: """
        defmodule CodiePlayground.Shorten do
          def shout(drink), do: drink
        end

        CodiePlayground.Shorten.shout("latte")
        """,
        prerequisites: ["private-functions-lab"],
        checks: [
          ast_contains("import",
            checkpoint: "Use an `import` directive",
            failure_message: "Add `import String, only: [upcase: 1]` inside the module."
          ),
          module_function(CodiePlayground.Shorten, :shout, ["latte"], "LATTE",
            checkpoint: "`shout/1` should return `\"LATTE\"`",
            failure_message:
              "`CodiePlayground.Shorten.shout(\"latte\")` should return `\"LATTE\"`."
          ),
          returns("LATTE",
            checkpoint: "Return `\"LATTE\"`",
            failure_message: "The final expression should evaluate to `\"LATTE\"`."
          )
        ],
        hints: [
          "Add `import String, only: [upcase: 1]` at the top of the module body.",
          "Call `upcase(drink)` directly inside `shout/1`.",
          "The last line should call `shout(\"latte\")`."
        ],
        quick_terms: [
          quick_term(
            "Import",
            "`import` brings functions from another module into scope so you can call them without a prefix."
          )
        ],
        rewards: reward(34, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "imports",
            "import",
            "Use `import` to bring selected functions into scope without a module prefix."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-functions-modules-pipe",
        slug: "module-attributes-lab",
        title: "Module Attributes Lab",
        summary:
          "Use `@moduledoc`, `@doc`, and custom module attributes to store compile-time values.",
        teaching_markdown: """
        What:
        Module attributes like `@moduledoc`, `@doc`, and custom ones like `@default_drink` store values at compile time.

        Example:
        `@default_drink "latte"`
        `@doc "Returns the default drink."`
        `def default, do: @default_drink`

        Why:
        Module attributes keep magic values named and centralized, and `@doc` helps others understand your code.

        Common cases:
        Document a module and its functions
        Store a default or configuration value

        Watch out:
        Module attributes are set at compile time. They cannot change at runtime.

        Task:
        Define `CodiePlayground.Defaults` with:
        - `@default_drink "latte"`
        - a public `drink/0` that returns `@default_drink`

        Call `CodiePlayground.Defaults.drink()` as the final expression.
        """,
        starter_code: """
        defmodule CodiePlayground.Defaults do
          def drink, do: "todo"
        end

        CodiePlayground.Defaults.drink()
        """,
        prerequisites: ["module-directives-lab"],
        checks: [
          source_contains("@",
            checkpoint: "Use a module attribute",
            failure_message: "Define a module attribute like `@default_drink \"latte\"`."
          ),
          module_function(CodiePlayground.Defaults, :drink, [], "latte",
            checkpoint: "`drink/0` should return `\"latte\"`",
            failure_message: "`CodiePlayground.Defaults.drink()` should return `\"latte\"`."
          ),
          returns("latte",
            checkpoint: "Return `\"latte\"`",
            failure_message: "The final expression should evaluate to `\"latte\"`."
          )
        ],
        hints: [
          "Add `@default_drink \"latte\"` inside the module, before the function.",
          "Use `@default_drink` in the function body.",
          "The final line should call `drink()`."
        ],
        quick_terms: [
          quick_term(
            "Module attribute",
            "A module attribute like `@name` stores a compile-time value inside a module."
          )
        ],
        rewards: reward(34, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "module-attributes",
            "Module Attributes",
            "Use `@` attributes to document modules and store compile-time constants."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-functions-modules-pipe",
        slug: "recursion-lab",
        title: "Recursion Lab",
        summary: "Write a recursive function with a base case and a recursive case.",
        teaching_markdown: """
        What:
        Recursion means a function calls itself. You need a base case to stop and a recursive case to continue.

        Example:
        `def total([]), do: 0`
        `def total([head | tail]), do: head + total(tail)`

        Why:
        Recursion is a fundamental technique in Elixir for processing lists without mutable state.

        Common cases:
        Sum all items in a list
        Process each element one at a time

        Watch out:
        Always define the base case first. Without it, recursion runs forever.

        Task:
        Define `CodiePlayground.Recurse.total/1` that:
        - returns `0` for an empty list (base case)
        - returns `head + total(tail)` for `[head | tail]` (recursive case)

        Call `CodiePlayground.Recurse.total([1, 2, 3, 4])` as the final expression.
        """,
        starter_code: """
        defmodule CodiePlayground.Recurse do
          def total(_list), do: 0
        end

        CodiePlayground.Recurse.total([1, 2, 3, 4])
        """,
        prerequisites: ["module-attributes-lab"],
        checks: [
          module_function(CodiePlayground.Recurse, :total, [[1, 2, 3, 4]], 10,
            checkpoint: "`total/1` should return `10`",
            failure_message: "`CodiePlayground.Recurse.total([1, 2, 3, 4])` should return `10`."
          ),
          module_function(CodiePlayground.Recurse, :total, [[]], 0,
            checkpoint: "`total/1` should return `0` for empty list",
            failure_message: "`CodiePlayground.Recurse.total([])` should return `0`."
          ),
          returns(10,
            checkpoint: "Return `10`",
            failure_message: "The final expression should evaluate to `10`."
          )
        ],
        hints: [
          "Define `def total([]), do: 0` as the base case.",
          "Define `def total([head | tail]), do: head + total(tail)` as the recursive case.",
          "The final line should call `total([1, 2, 3, 4])`."
        ],
        quick_terms: [
          quick_term(
            "Recursion",
            "Recursion is when a function calls itself, combined with a base case to stop."
          )
        ],
        rewards: reward(38, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "recursion",
            "Recursion",
            "Recursive functions call themselves with a base case to stop and a recursive case to continue."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-functions-modules-pipe",
        slug: "functions-modules-pipe-roundup",
        title: "Functions, Modules, and Pipe Roundup",
        tier: :boss,
        summary:
          "Combine named functions, a small module attribute, arity awareness, an anonymous function, and a readable pipeline.",
        teaching_markdown: """
        What:
        This checkpoint combines named functions, a small module attribute, an anonymous finishing function, and a readable pipeline.

        Example:
        `input |> Brew.trimmed() |> Brew.loud()`
        `fn text -> text <> "!" end`

        Why:
        Elixir readability comes from small named steps and clear pipeline flow.

        Common cases:
        Build a module with tiny focused functions
        Keep a tiny constant in a module attribute
        Chain those functions with `|>`
        Finish with a one-off anonymous function

        Watch out:
        Keep the function boundaries clear. The module attribute should hold a tiny compile-time constant, named functions should handle reusable steps, and the anonymous function should handle the small local finishing logic.

        Task:
        Define `CodiePlayground.Format` with:
        - `@suffix "!"`
        - `trimmed/1` using `String.trim/1`
        - `loud/1` using `String.upcase/1`
        - `suffix/0` returning `@suffix`

        Bind `finish = fn text -> text <> CodiePlayground.Format.suffix() end`.
        Start from `" latte "` and pipe through:
        - `CodiePlayground.Format.trimmed/1`
        - `CodiePlayground.Format.loud/1`
        - `finish.(...)`

        Return the final value, which should be `"LATTE!"`.
        """,
        starter_code: """
        defmodule CodiePlayground.Format do
          @suffix "!"
          def trimmed(text), do: text
          def loud(text), do: text
          def suffix, do: @suffix
        end

        finish = fn text -> text end
        " latte "
        """,
        prerequisites: ["recursion-lab"],
        checks: [
          source_contains("defmodule CodiePlayground.Format",
            checkpoint: "Define the module",
            failure_message: "Keep `defmodule CodiePlayground.Format do ... end`."
          ),
          source_contains("def trimmed(",
            checkpoint: "Define `trimmed/1`",
            failure_message: "Define `trimmed/1` in the module."
          ),
          source_contains("def loud(",
            checkpoint: "Define `loud/1`",
            failure_message: "Define `loud/1` in the module."
          ),
          source_contains("@suffix",
            checkpoint: "Store the exclamation mark in a module attribute",
            failure_message: "Add a module attribute like `@suffix \"!\"` inside the module."
          ),
          module_function(CodiePlayground.Format, :suffix, [], "!",
            checkpoint: "`suffix/0` should return `\"!\"`",
            failure_message: "`CodiePlayground.Format.suffix()` should return `\"!\"`."
          ),
          source_contains("fn text ->",
            checkpoint: "Use an anonymous finishing function",
            failure_message: "Keep `finish` as an anonymous function."
          ),
          ast_contains("|>",
            checkpoint: "Use a readable pipeline",
            failure_message: "Use `|>` to chain the formatting steps."
          ),
          returns("LATTE!",
            checkpoint: "Return `\"LATTE!\"`",
            failure_message: "The final expression should evaluate to `\"LATTE!\"`."
          )
        ],
        hints: [
          "Set `@suffix \"!\"` near the top of the module and return it from `suffix/0`.",
          "Use `String.trim/1` and `String.upcase/1` in the module functions.",
          "Make `finish` append `CodiePlayground.Format.suffix()`.",
          "Pipe the input into both module functions before `finish.(...)`."
        ],
        quick_terms: [
          quick_term(
            "Flow",
            "Flow means the order data moves through each transformation step."
          )
        ],
        rewards: reward(54, 2, 6, 6, 5, 2),
        codex_entries_unlocked: [
          codex(
            "functions-modules-pipe-roundup",
            "Functions/Modules/Pipe Roundup",
            "This checkpoint proves you can write readable Elixir using functions, modules, arity awareness, and pipelines."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-control-flow-with",
        slug: "control-flow-if-unless",
        title: "Control Flow: if and unless",
        summary: "Use `if` and `unless` together for simple two-way branching.",
        teaching_markdown: """
        What:
        `if` runs a branch when a condition is truthy. `unless` runs a branch when a condition is falsy.

        Example:
        `if ready?, do: "brew", else: "wait"`
        `unless sleepy?, do: "awake", else: "sleepy"`

        Why:
        These are the simplest control-flow tools for yes/no decisions.

        Common cases:
        Use `if` for standard condition checks
        Use `unless` when the condition reads better as “not this”

        Watch out:
        Prefer simple conditions. If branching gets complex, move to `case`, `cond`, or `with`.

        Task:
        Keep `ready? = true` and `sleepy? = false`.
        Return `{if_result, unless_result}` where:
        - `if_result` is `"brew"` when ready
        - `unless_result` is `"awake"` when not sleepy
        """,
        starter_code: """
        ready? = true
        sleepy? = false
        {"wait", "sleepy"}
        """,
        prerequisites: ["functions-modules-pipe-roundup"],
        checks: [
          ast_contains("if",
            checkpoint: "Use an `if` expression",
            failure_message: "Use `if` for the first decision."
          ),
          source_contains("unless",
            checkpoint: "Use an `unless` expression",
            failure_message: "Use `unless` for the second decision."
          ),
          returns({"brew", "awake"},
            checkpoint: "Return `{\"brew\", \"awake\"}`",
            failure_message: "The final expression should evaluate to `{\"brew\", \"awake\"}`."
          )
        ],
        hints: [
          "Keep the two booleans as given.",
          "Build one value with `if`, one with `unless`.",
          "Return both values in a tuple."
        ],
        quick_terms: [
          quick_term(
            "Branching",
            "Branching means choosing one code path or another based on a condition."
          )
        ],
        rewards: reward(32, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "control-flow-if-unless",
            "if and unless",
            "Use `if` for direct checks and `unless` when expressing the negated condition reads cleaner."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-control-flow-with",
        slug: "control-flow-case",
        title: "Control Flow: case",
        summary: "Use `case` to branch by matching the shape of a value.",
        teaching_markdown: """
        What:
        `case` matches one value against multiple patterns and runs the first match.

        Example:
        `case result do`
        `  {:ok, drink} -> drink`
        `  {:error, _reason} -> "stop"`
        `end`

        Why:
        `case` is the core branching tool when decisions depend on value shape.

        Common cases:
        Handle `{:ok, value}` and `{:error, reason}` differently
        Match structured tuples directly without extra nested checks

        Watch out:
        Put specific patterns before generic fallbacks.

        Task:
        Keep `result = {:ok, "latte"}`.
        Use `case` to return `"latte ready"` for success and `"stop"` for error.
        """,
        starter_code: """
        result = {:ok, "latte"}
        "todo"
        """,
        prerequisites: ["control-flow-if-unless"],
        checks: [
          ast_contains("case",
            checkpoint: "Use a `case` expression",
            failure_message: "This lesson expects a `case` expression."
          ),
          source_contains("{:ok, drink}",
            checkpoint: "Match the success pattern",
            failure_message: "Add a branch for `{:ok, drink}`."
          ),
          source_contains("{:error, _reason}",
            checkpoint: "Match the error pattern",
            failure_message: "Add a branch for `{:error, _reason}`."
          ),
          returns("latte ready",
            checkpoint: "Return `\"latte ready\"`",
            failure_message: "The final expression should evaluate to `\"latte ready\"`."
          )
        ],
        hints: [
          "Start with `case result do`.",
          "Return the formatted string in the success branch.",
          "Use a simple error fallback string."
        ],
        quick_terms: [
          quick_term(
            "Pattern branch",
            "A pattern branch in `case` runs when the branch pattern matches the value."
          )
        ],
        rewards: reward(34, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "control-flow-case",
            "case",
            "Use `case` when your branch logic depends on matching value shapes."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-control-flow-with",
        slug: "control-flow-cond",
        title: "Control Flow: cond",
        summary: "Use `cond` when several boolean checks can apply.",
        teaching_markdown: """
        What:
        `cond` runs the first truthy condition branch.

        Example:
        `cond do`
        `  cups == 0 -> "empty"`
        `  cups < 3 -> "low"`
        `  true -> "ready"`
        `end`

        Why:
        `cond` is clearer than stacking many nested `if` expressions.

        Common cases:
        Classify a number into ranges
        Select one label from several boolean checks

        Watch out:
        Always include a final `true -> ...` fallback branch.

        Task:
        Keep `cups = 3`.
        Use `cond` to return:
        - `"empty"` when `cups == 0`
        - `"low"` when `cups < 4`
        - `"ready"` otherwise
        """,
        starter_code: """
        cups = 3
        "ready"
        """,
        prerequisites: ["control-flow-case"],
        checks: [
          ast_contains("cond",
            checkpoint: "Use a `cond` expression",
            failure_message: "This lesson expects a `cond` expression."
          ),
          source_contains("cups == 0",
            checkpoint: "Check the empty case first",
            failure_message: "Add a branch for `cups == 0`."
          ),
          source_contains("cups < 4",
            checkpoint: "Check the low case second",
            failure_message: "Add a branch for `cups < 4`."
          ),
          source_contains("true ->",
            checkpoint: "Include a fallback branch",
            failure_message: "Add a fallback branch with `true -> ...`."
          ),
          returns("low",
            checkpoint: "Return `\"low\"`",
            failure_message: "With `cups = 3`, the final expression should evaluate to `\"low\"`."
          )
        ],
        hints: [
          "Order branches from specific to fallback.",
          "Use `true -> \"ready\"` at the end.",
          "With `cups = 3`, it should hit the middle branch."
        ],
        quick_terms: [
          quick_term(
            "Fallback branch",
            "A fallback branch handles cases not matched by earlier conditions."
          )
        ],
        rewards: reward(34, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "control-flow-cond",
            "cond",
            "Use `cond` for multi-branch boolean decision flows."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-control-flow-with",
        slug: "control-flow-with",
        title: "Control Flow: with",
        summary: "Use `with` to keep happy-path tuple flows readable.",
        teaching_markdown: """
        What:
        `with` chains pattern matches and runs the success path top-to-bottom.

        Example:
        `with {:ok, drink} <- drink_result,`
        `     {:ok, cups} <- cups_result do`
        `  {:ok, "\#{drink}:\#{cups}"}`
        `else`
        `  _ -> {:error, :invalid}`
        `end`

        Why:
        `with` is the readable way to say, “do step one, then step two, and only keep going if each step matches.”

        Common cases:
        Chain multiple `{:ok, value}`-style checks
        Stop early and go to `else` when one step does not match

        Watch out:
        Keep the first `with` lessons simple.
        Each `<-` step checks whether the value matches the shape on the left.

        Task:
        Keep `drink_result = {:ok, "latte"}` and `cups_result = {:ok, 2}`.
        Use `with` to:
        - match `{:ok, drink}` from `drink_result`
        - match `{:ok, cups}` from `cups_result`
        Return `{:ok, "\#{drink}:\#{cups}"}` on success, otherwise `{:error, :invalid}`.
        """,
        starter_code: """
        drink_result = {:ok, "latte"}
        cups_result = {:ok, 2}
        {:error, :invalid}
        """,
        prerequisites: ["control-flow-cond"],
        checks: [
          source_contains("with",
            checkpoint: "Use a `with` expression",
            failure_message: "This lesson expects a `with` expression."
          ),
          source_contains("<-",
            checkpoint: "Chain at least one match step",
            failure_message: "Use `<-` steps inside `with`."
          ),
          source_contains("{:ok, drink} <- drink_result",
            checkpoint: "Match the drink step in the chain",
            failure_message: "Match the first step with `{:ok, drink} <- drink_result`."
          ),
          source_contains("{:ok, cups} <- cups_result",
            checkpoint: "Match the cups step in the chain",
            failure_message: "Match the second step with `{:ok, cups} <- cups_result`."
          ),
          source_contains("else",
            checkpoint: "Handle non-happy-path outcomes",
            failure_message: "Add an `else` branch for invalid input."
          ),
          returns({:ok, "latte:2"},
            checkpoint: "Return `{:ok, \"latte:2\"}`",
            failure_message:
              "With the provided inputs, the final expression should evaluate to `{:ok, \"latte:2\"}`."
          )
        ],
        hints: [
          "Start with `with ... do` and end with `else` + `end`.",
          "Match `{:ok, drink}` first, then `{:ok, cups}`.",
          "Return `{:ok, \"\#{drink}:\#{cups}\"}` in the do-block."
        ],
        quick_terms: [
          quick_term(
            "Happy path",
            "The happy path is the main successful flow when each step works."
          ),
          quick_term(
            "Match step (`<-`)",
            "A `with` match step keeps going only when the value on the right matches the pattern on the left."
          )
        ],
        rewards: reward(36, 1, 5, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "control-flow-with",
            "with",
            "Use `with` to express successful step-by-step matching flows clearly."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-control-flow-with",
        slug: "control-flow-with-roundup",
        title: "Control Flow and with Roundup",
        tier: :boss,
        summary: "Combine `if/unless`, `case`, `cond`, and `with` in one readable flow.",
        teaching_markdown: """
        What:
        This checkpoint combines the main control-flow tools into one coherent solution.

        Example:
        `with {count, ""} <- Integer.parse(raw), true <- count > 0 do`
        `  ...`
        `else`
        `  _ -> "invalid"`
        `end`

        Why:
        Control-flow fluency comes from choosing the right construct for each step, not forcing one tool everywhere.

        Common cases:
        Use `with` for the success chain
        Use `if/unless` for simple flags
        Use `case` and `cond` for shape/range decisions

        Watch out:
        Keep each construct doing one job. Avoid deep nesting when a cleaner construct exists.

        Task:
        Define `CodiePlayground.Decisions.summary/2` where `raw` is a count string and `sleepy?` is a boolean.

        Inside `summary/2`:
        - use `with` to parse `raw` and require count > 0
        - use `if` to produce `{:ok, count}` or `{:error, :sleepy}`
        - use `case` on that tagged tuple
        - in the success branch, use `cond` to return `"light"` for `1`, `"strong"` for `>= 2`
        - in the error branch, use `unless` to return `"awake"` when not sleepy, else `"sleepy"`
        - use `else` on `with` to return `"invalid"` for parse/validation failures

        Final expression should call `CodiePlayground.Decisions.summary("2", false)` and return `"strong"`.
        """,
        starter_code: """
        defmodule CodiePlayground.Decisions do
          def summary(_raw, _sleepy?), do: "todo"
        end

        CodiePlayground.Decisions.summary("0", true)
        """,
        prerequisites: ["control-flow-with"],
        checks: [
          source_contains("with",
            checkpoint: "Use `with` for the success chain",
            failure_message: "Use `with` to parse and validate the input."
          ),
          ast_contains("if",
            checkpoint: "Use `if` for the sleepy decision",
            failure_message: "Use `if` to build the tagged result."
          ),
          ast_contains("case",
            checkpoint: "Use `case` on the tagged tuple",
            failure_message: "Use a `case` expression on the tagged result."
          ),
          ast_contains("cond",
            checkpoint: "Use `cond` in the success branch",
            failure_message: "Use `cond` to classify the count."
          ),
          source_contains("unless",
            checkpoint: "Use `unless` in the sleepy fallback branch",
            failure_message: "Use `unless` in the error branch."
          ),
          module_function(CodiePlayground.Decisions, :summary, ["2", false], "strong",
            checkpoint: "`summary/2` should return `\"strong\"` for `(\"2\", false)`",
            failure_message:
              "`CodiePlayground.Decisions.summary(\"2\", false)` should return `\"strong\"`."
          ),
          module_function(CodiePlayground.Decisions, :summary, ["0", false], "invalid",
            checkpoint: "`summary/2` should return `\"invalid\"` for non-positive input",
            failure_message:
              "`CodiePlayground.Decisions.summary(\"0\", false)` should return `\"invalid\"`."
          ),
          module_function(CodiePlayground.Decisions, :summary, ["2", true], "sleepy",
            checkpoint: "`summary/2` should return `\"sleepy\"` when sleepy",
            failure_message:
              "`CodiePlayground.Decisions.summary(\"2\", true)` should return `\"sleepy\"`."
          ),
          returns("strong",
            checkpoint: "Return `\"strong\"` from the final call",
            failure_message: "The final expression should evaluate to `\"strong\"`."
          )
        ],
        hints: [
          "Build `summary/2` in clear stages: with -> if -> case -> cond/unless.",
          "Use `Integer.parse(raw)` in `with` and match `{count, \"\"}`.",
          "In the `{:error, :sleepy}` case branch, use `unless` with an else branch."
        ],
        quick_terms: [
          quick_term(
            "Control-flow composition",
            "Control-flow composition means combining multiple branching tools while keeping each step readable."
          )
        ],
        rewards: reward(56, 2, 6, 6, 5, 2),
        codex_entries_unlocked: [
          codex(
            "control-flow-with-roundup",
            "Control Flow and with Roundup",
            "This checkpoint proves you can choose and combine Elixir control-flow tools idiomatically."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-enum-and-streams",
        slug: "enum-map-lab",
        title: "Enum Map Lab",
        summary: "Use `Enum.map/2` for everyday list transformation.",
        teaching_markdown: """
        What:
        `Enum.map/2` transforms each item in a collection and returns a new collection.

        Example:
        `Enum.map(["latte", "mocha"], &String.upcase/1)`
        `Enum.map([1, 2, 3], fn n -> n * 2 end)`

        Why:
        `Enum.map` is one of the most common Elixir tools. You will use it constantly.

        Common cases:
        Transform strings into a normalized format
        Convert one list of values into another list with the same length

        Watch out:
        `Enum.map` returns a new list. It does not mutate the original one.

        Task:
        Keep `drinks = ["latte", "mocha"]`.
        Use `Enum.map/2` to uppercase each item.
        Return the transformed list.
        """,
        starter_code: """
        drinks = ["latte", "mocha"]
        drinks
        """,
        prerequisites: ["control-flow-with-roundup"],
        checks: [
          source_contains("Enum.map",
            checkpoint: "Use `Enum.map/2`",
            failure_message: "Use `Enum.map/2` for this transformation."
          ),
          returns(["LATTE", "MOCHA"],
            checkpoint: "Return `[\"LATTE\", \"MOCHA\"]`",
            failure_message: "The final expression should evaluate to `[\"LATTE\", \"MOCHA\"]`."
          )
        ],
        hints: [
          "Call `Enum.map` on `drinks`.",
          "Use `String.upcase/1` or an anonymous function.",
          "Return the mapped list as the final expression."
        ],
        quick_terms: [
          quick_term(
            "Eager",
            "Eager means the transformation runs immediately and returns concrete results right away."
          )
        ],
        rewards: reward(34, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "enum-map-lab",
            "Enum.map/2",
            "Use `Enum.map/2` to transform each item and produce a new list immediately."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-enum-and-streams",
        slug: "enum-reduce-lab",
        title: "Enum Reduce Lab",
        summary: "Use `Enum.reduce/3` to fold a collection into one value.",
        teaching_markdown: """
        What:
        `Enum.reduce/3` combines collection items into a single result by carrying an accumulator.

        Example:
        `Enum.reduce([1, 2, 3], 0, fn n, acc -> acc + n end)`
        `Enum.reduce(["a", "b"], "", fn s, acc -> acc <> s end)`

        Why:
        `Enum.reduce` is the core aggregation tool in Elixir and appears in real code daily.

        Common cases:
        Sum totals from a list of numbers
        Build one final summary value from many items

        Watch out:
        Keep accumulator order clear in the reducer function.

        Task:
        Keep `cups = [1, 2, 3, 4]`.
        Use `Enum.reduce/3` with starting accumulator `0` to return the total sum.
        """,
        starter_code: """
        cups = [1, 2, 3, 4]
        0
        """,
        prerequisites: ["enum-map-lab"],
        checks: [
          source_contains("Enum.reduce",
            checkpoint: "Use `Enum.reduce/3`",
            failure_message: "Use `Enum.reduce/3` with an accumulator."
          ),
          returns(10,
            checkpoint: "Return `10`",
            failure_message: "The final expression should evaluate to `10`."
          )
        ],
        hints: [
          "Start from accumulator `0`.",
          "Add each `n` to the accumulator.",
          "Return the reduce call as the final expression."
        ],
        quick_terms: [
          quick_term(
            "Accumulator",
            "An accumulator is the running value that `Enum.reduce/3` updates each step."
          )
        ],
        rewards: reward(36, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "enum-reduce-lab",
            "Enum.reduce/3",
            "Use `Enum.reduce/3` when you need one final result from many items."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-enum-and-streams",
        slug: "enum-eager-lab",
        title: "Enum Eager Lab",
        summary: "See concretely that `Enum` pipelines evaluate immediately.",
        teaching_markdown: """
        What:
        `Enum` functions are eager: they run now and return concrete values.

        Example:
        `squared = Enum.map(1..3, fn n -> n * n end)`
        `is_list(squared)`

        Why:
        Understanding eager evaluation helps you decide when `Enum` is enough and when to reach for `Stream`.

        Common cases:
        Process small-to-medium collections immediately
        Get concrete results right away for the next step

        Watch out:
        Eager processing does all work now, even if you only need part of the result later.

        Task:
        Bind `squared = Enum.map(1..3, fn n -> n * n end)`.
        Return `{is_list(squared), squared}`.
        """,
        starter_code: """
        squared = []
        {false, []}
        """,
        prerequisites: ["enum-reduce-lab"],
        checks: [
          source_contains("Enum.map",
            checkpoint: "Build the eager result with `Enum.map/2`",
            failure_message: "Set `squared` using `Enum.map/2`."
          ),
          source_contains("is_list(squared)",
            checkpoint: "Confirm the eager concrete list",
            failure_message: "Use `is_list(squared)` in the returned tuple."
          ),
          returns({true, [1, 4, 9]},
            checkpoint: "Return `{true, [1, 4, 9]}`",
            failure_message: "The final expression should evaluate to `{true, [1, 4, 9]}`."
          )
        ],
        hints: [
          "Map over `1..3` and square each number.",
          "Bind it to `squared` first.",
          "Return whether it is a list and the list itself."
        ],
        quick_terms: [
          quick_term(
            "Concrete result",
            "A concrete result is a fully realized value, like a full list already in memory."
          )
        ],
        rewards: reward(36, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "enum-eager-lab",
            "Eager Enumeration",
            "Enum operations are eager and return concrete values immediately."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-enum-and-streams",
        slug: "stream-lazy-lab",
        title: "Stream Lazy Lab",
        summary: "Use `Stream` to define work lazily and realize only what you consume.",
        teaching_markdown: """
        What:
        `Stream` builds lazy pipelines. Work happens when you consume the stream.

        Example:
        `1..1_000`
        `|> Stream.map(fn n -> n * 2 end)`
        `|> Enum.take(3)`

        Why:
        `Stream` is vital when processing huge or unbounded data without loading everything at once.

        Common cases:
        Handle very large files incrementally
        Process potentially infinite sequences safely

        Watch out:
        A stream by itself is just a lazy recipe; you need a consumer like `Enum.take/2`.

        Task:
        Start from `1..1_000`.
        Pipe through `Stream.map/2` to double values.
        Consume with `Enum.take(3)`.
        Return the resulting list.
        """,
        starter_code: """
        1..1_000
        """,
        prerequisites: ["enum-eager-lab"],
        checks: [
          source_contains("Stream.map",
            checkpoint: "Use a lazy stream transform",
            failure_message: "Include a `Stream.map/2` step."
          ),
          source_contains("Enum.take(3)",
            checkpoint: "Consume only what you need",
            failure_message: "Consume the stream with `Enum.take(3)`."
          ),
          returns([2, 4, 6],
            checkpoint: "Return `[2, 4, 6]`",
            failure_message: "The final expression should evaluate to `[2, 4, 6]`."
          )
        ],
        hints: [
          "Use a pipeline with `|>`.",
          "Double each number in `Stream.map`.",
          "Take only three values at the end."
        ],
        quick_terms: [
          quick_term(
            "Lazy",
            "Lazy means work is delayed until a consumer asks for results."
          )
        ],
        rewards: reward(38, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "stream-lazy-lab",
            "Lazy Streams",
            "Stream pipelines delay work until values are consumed by an Enum operation."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-enum-and-streams",
        slug: "enum-filter-lab",
        title: "Enum Filter Lab",
        summary: "Use `Enum.filter/2` and `Enum.reject/2` to select or exclude items.",
        teaching_markdown: """
        What:
        `Enum.filter/2` keeps items that pass a test. `Enum.reject/2` removes items that pass.

        Example:
        `Enum.filter([1, 2, 3, 4], fn n -> rem(n, 2) == 0 end)`
        `Enum.reject(["", "latte", ""], fn s -> s == "" end)`

        Why:
        Filtering is one of the most common collection operations. Almost every app needs to narrow down a list.

        Common cases:
        Keep only even numbers
        Remove blank strings from a list

        Watch out:
        `filter` keeps matches; `reject` removes matches. They are opposites.

        Task:
        Keep `drinks = ["latte", "", "mocha", "", "espresso"]`.
        Use `Enum.filter/2` to keep only non-empty strings.
        Then use `Enum.reject/2` on `[1, 2, 3, 4, 5]` to remove odd numbers.
        Return `{filtered_drinks, even_numbers}`.
        """,
        starter_code: """
        drinks = ["latte", "", "mocha", "", "espresso"]
        {drinks, []}
        """,
        prerequisites: ["enum-reduce-lab"],
        checks: [
          source_contains("Enum.filter",
            checkpoint: "Use `Enum.filter/2`",
            failure_message: "Use `Enum.filter/2` to keep non-empty drinks."
          ),
          source_contains("Enum.reject",
            checkpoint: "Use `Enum.reject/2`",
            failure_message: "Use `Enum.reject/2` to remove odd numbers."
          ),
          returns({["latte", "mocha", "espresso"], [2, 4]},
            checkpoint: "Return the correct filtered results",
            failure_message:
              "The final expression should evaluate to `{[\"latte\", \"mocha\", \"espresso\"], [2, 4]}`."
          )
        ],
        hints: [
          "Filter drinks with `fn s -> s != \"\" end`.",
          "Reject odd numbers with `fn n -> rem(n, 2) != 0 end`.",
          "Return both results as a tuple."
        ],
        quick_terms: [
          quick_term(
            "Filter",
            "`Enum.filter/2` keeps items where the function returns truthy."
          )
        ],
        rewards: reward(36, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "enum-filter",
            "Enum.filter and Enum.reject",
            "Use `Enum.filter/2` to keep matching items and `Enum.reject/2` to remove them."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-enum-and-streams",
        slug: "enum-search-lab",
        title: "Enum Search Lab",
        summary: "Use `Enum.find/2` and `Enum.any?/2` to search and test collections.",
        teaching_markdown: """
        What:
        `Enum.find/2` returns the first item matching a test. `Enum.any?/2` checks if at least one matches.

        Example:
        `Enum.find([3, 7, 2], fn n -> n > 5 end)`
        `Enum.any?([1, 2, 3], fn n -> n > 2 end)`

        Why:
        Searching and testing collections is a daily task. These functions avoid manual loops.

        Common cases:
        Find the first matching item in a list
        Check if any item meets a condition before proceeding

        Watch out:
        `Enum.find/2` returns `nil` if nothing matches — not an error.

        Task:
        Keep `numbers = [3, 7, 2, 9, 1]`.
        Bind `found = Enum.find(numbers, fn n -> n > 5 end)`.
        Bind `has_big = Enum.any?(numbers, fn n -> n > 8 end)`.
        Return `{found, has_big}`.
        """,
        starter_code: """
        numbers = [3, 7, 2, 9, 1]
        {nil, false}
        """,
        prerequisites: ["enum-filter-lab"],
        checks: [
          source_contains("Enum.find",
            checkpoint: "Use `Enum.find/2`",
            failure_message: "Use `Enum.find/2` to find the first match."
          ),
          source_contains("Enum.any?",
            checkpoint: "Use `Enum.any?/2`",
            failure_message: "Use `Enum.any?/2` to check if any number is greater than 8."
          ),
          returns({7, true},
            checkpoint: "Return `{7, true}`",
            failure_message: "The final expression should evaluate to `{7, true}`."
          )
        ],
        hints: [
          "Find the first number greater than 5.",
          "Check if any number is greater than 8.",
          "Return a tuple of both results."
        ],
        quick_terms: [
          quick_term(
            "Predicate",
            "A predicate is a function that returns true or false, used to test each item."
          )
        ],
        rewards: reward(36, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "enum-search",
            "Enum Search Functions",
            "Use `Enum.find/2` and `Enum.any?/2` to search and test collections."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-enum-and-streams",
        slug: "comprehensions-lab",
        title: "Comprehensions Lab",
        summary: "Use `for` comprehensions to generate and filter collections in one expression.",
        teaching_markdown: """
        What:
        A `for` comprehension generates values from one or more generators and optionally filters them.

        Example:
        `for n <- 1..4, do: n * 2`
        `for n <- 1..10, rem(n, 2) == 0, do: n`

        Why:
        Comprehensions combine generation and filtering into a single readable expression.

        Common cases:
        Generate a transformed list from a range
        Filter and transform in one step

        Watch out:
        A comprehension always returns a list by default. Use `:into` to change the collection type.

        Task:
        Use a `for` comprehension to generate squares of numbers 1 through 5, but only keep the ones greater than 5.
        Return the result.
        """,
        starter_code: """
        []
        """,
        prerequisites: ["enum-search-lab"],
        checks: [
          ast_contains("for",
            checkpoint: "Use a `for` comprehension",
            failure_message: "Use a `for` comprehension with a generator and filter."
          ),
          returns([9, 16, 25],
            checkpoint: "Return `[9, 16, 25]`",
            failure_message: "The final expression should evaluate to `[9, 16, 25]`."
          )
        ],
        hints: [
          "Start with `for n <- 1..5`.",
          "Add a filter: `n * n > 5`.",
          "Use `do: n * n` to return the squared value."
        ],
        quick_terms: [
          quick_term(
            "Comprehension",
            "A `for` comprehension generates values from generators and optionally filters them."
          )
        ],
        rewards: reward(38, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "comprehensions",
            "Comprehensions",
            "Use `for` comprehensions to generate, filter, and transform collections in one expression."
          )
        ]
      ),
      lesson(
        track_slug: "foundations-enum-and-streams",
        slug: "enumeration-streams-roundup",
        title: "Enumeration and Streams Roundup",
        tier: :boss,
        summary: "Combine eager and lazy pipelines in one practical module.",
        teaching_markdown: """
        What:
        This checkpoint combines `Enum.map`, `Enum.reduce`, `Stream.map`, and stream consumption.

        Example:
        `eager_total = values |> Enum.map(...) |> Enum.reduce(...)`
        `lazy_preview = values |> Stream.map(...) |> Enum.take(2)`

        Why:
        You need both eager and lazy tools to write idiomatic, scalable Elixir data pipelines.

        Common cases:
        Use eager pipelines for immediate full aggregation
        Use lazy pipelines when you only need a small slice from large input

        Watch out:
        Pick eager vs lazy intentionally based on result size and consumption needs.

        Task:
        Define `CodiePlayground.Enumerate.summary/1`.
        For input `values`:
        - build `eager_total` by doubling each value with `Enum.map/2` then summing with `Enum.reduce/3`
        - build `lazy_preview` by tripling each value with `Stream.map/2` then taking two with `Enum.take/2`
        - return `{eager_total, lazy_preview}`

        Final expression should call `summary([1, 2, 3, 4])` and return `{20, [3, 6]}`.
        """,
        starter_code: """
        defmodule CodiePlayground.Enumerate do
          def summary(_values), do: {0, []}
        end

        CodiePlayground.Enumerate.summary([])
        """,
        prerequisites: ["comprehensions-lab"],
        checks: [
          source_contains("Enum.map",
            checkpoint: "Use eager map for total pipeline",
            failure_message: "Use `Enum.map/2` for the eager total pipeline."
          ),
          source_contains("Enum.reduce",
            checkpoint: "Use eager reduce for total pipeline",
            failure_message: "Use `Enum.reduce/3` to aggregate the eager pipeline."
          ),
          source_contains("Stream.map",
            checkpoint: "Use lazy map for preview pipeline",
            failure_message: "Use `Stream.map/2` for the lazy preview pipeline."
          ),
          source_contains("Enum.take(2)",
            checkpoint: "Consume only two lazy values",
            failure_message: "Use `Enum.take(2)` for the lazy preview."
          ),
          module_function(CodiePlayground.Enumerate, :summary, [[1, 2, 3, 4]], {20, [3, 6]},
            checkpoint: "`summary/1` should return `{20, [3, 6]}`",
            failure_message:
              "`CodiePlayground.Enumerate.summary([1, 2, 3, 4])` should return `{20, [3, 6]}`."
          ),
          returns({20, [3, 6]},
            checkpoint: "Return `{20, [3, 6]}` from the final call",
            failure_message: "The final expression should evaluate to `{20, [3, 6]}`."
          )
        ],
        hints: [
          "Build the eager and lazy values in separate bindings inside `summary/1`.",
          "Double for eager total; triple for lazy preview.",
          "Use `Enum.take(2)` only on the lazy pipeline."
        ],
        quick_terms: [
          quick_term(
            "Pipeline choice",
            "Pipeline choice means deciding whether eager (`Enum`) or lazy (`Stream`) fits the workload."
          )
        ],
        rewards: reward(58, 2, 6, 6, 5, 2),
        codex_entries_unlocked: [
          codex(
            "enumeration-streams-roundup",
            "Enumeration and Streams Roundup",
            "This checkpoint proves you can combine daily Enum work and lazy Stream processing appropriately."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "function-shelf-new",
        title: "Function Shelf",
        summary: "Treat a function like a value you can store in a variable.",
        teaching_markdown: """
        What:
        In Elixir, a function can be a value. You can bind it to a name just like a string or a list.

        Example:
        `formatter = fn drink -> drink <> "!" end`
        `formatter.("latte")`

        Why:
        This is how Elixir treats functions as normal building blocks you can pass around and reuse.
        This starts a short final chapter of practical tools: function values, structured data, debugging, and ranges.

        Common cases:
        Keep a tiny formatter in a variable
        Reuse one small operation in more than one place

        Watch out:
        Anonymous functions are called with `.()`, not plain parentheses.

        Task:
        Keep `formatter = fn drink -> drink <> " ready" end`.
        Then call it with `"latte"` and return the result.
        """,
        starter_code: """
        formatter = fn drink -> drink <> " ready" end
        "todo"
        """,
        prerequisites: ["decision-roundup"],
        checks: [
          source_contains("fn",
            checkpoint: "Keep the anonymous function value",
            failure_message: "Keep the `fn ... end` function in the solution."
          ),
          source_contains(".(",
            checkpoint: "Call the function with `.()`",
            failure_message: "Call the function value with `.()`."
          ),
          returns("latte ready",
            checkpoint: "Return `\"latte ready\"`",
            failure_message: "The final expression should evaluate to `\"latte ready\"`."
          )
        ],
        hints: [
          "Do not replace the function with a plain string.",
          "Call the variable like `formatter.(...)`.",
          "Pass in `\"latte\"`."
        ],
        quick_terms: [
          quick_term(
            "Anonymous function",
            "An anonymous function is a function value written with `fn ... end`."
          )
        ],
        rewards: reward(26, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "function-values-new",
            "Functions as Values",
            "In Elixir, functions can be stored in variables and called later."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "function-choices-new",
        title: "Function Choices",
        summary: "Use a function value to make a small decision from an input.",
        teaching_markdown: """
        What:
        A function value can receive an argument and return a different answer depending on that argument.

        Example:
        `chooser = fn ready? -> if ready?, do: "brew", else: "wait" end`
        `chooser.(true)`

        Why:
        Once functions feel like values, they become a natural way to wrap one small behavior.

        Common cases:
        Turn a flag into a short label
        Keep a tiny reusable decision in one place

        Watch out:
        The function should make the decision. Do not hardcode the final answer after it.

        Task:
        Keep `chooser = fn ready? -> if ready?, do: "brew", else: "wait" end`.
        Then call it with `true` and return the result.
        """,
        starter_code: """
        chooser = fn ready? -> if ready?, do: "brew", else: "wait" end
        "todo"
        """,
        prerequisites: ["function-shelf-new"],
        checks: [
          source_contains("fn",
            checkpoint: "Keep the function value",
            failure_message: "Keep the `fn ... end` function in the solution."
          ),
          source_contains("if",
            checkpoint: "Keep the decision inside the function",
            failure_message: "Keep the `if` expression inside the function."
          ),
          source_contains(".(",
            checkpoint: "Call the function value",
            failure_message: "Call the function value with `.()`."
          ),
          returns("brew",
            checkpoint: "Return `\"brew\"`",
            failure_message: "The final expression should evaluate to `\"brew\"`."
          )
        ],
        hints: [
          "Keep the function exactly as the starter gives it to you.",
          "Call `chooser` with `true`.",
          "The function call should be the final expression."
        ],
        quick_terms: [
          quick_term(
            "Argument",
            "An argument is the value you pass into a function when you call it."
          )
        ],
        rewards: reward(26, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "function-inputs-new",
            "Function Inputs",
            "Function values can take input and produce a result based on that input."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "struct-shelf-new",
        title: "Struct Shelf",
        summary: "Learn a struct as a map with a fixed, named shape.",
        teaching_markdown: """
        What:
        A struct is a named data shape built from a module. It is like a map with a fixed set of keys.

        Example:
        `struct(Barista, awake?: true)`
        `defstruct name: "Nova", awake?: false`

        Why:
        Structs are how Elixir code gives domain data a stable, readable shape.

        Common cases:
        Represent one user, order, or barista
        Keep related fields together under one named type

        Watch out:
        You must define `defstruct` before you can build that struct.

        Task:
        Define `CodiePlayground.Barista` with `defstruct name: "Nova", awake?: false`.
        Then build `struct(CodiePlayground.Barista, awake?: true)` and return `{barista.name, barista.awake?}`.
        """,
        starter_code: """
        defmodule CodiePlayground.Barista do
          defstruct name: "Nova", awake?: false
        end

        barista = struct(CodiePlayground.Barista)
        {"", false}
        """,
        prerequisites: ["function-choices-new"],
        checks: [
          source_contains("defstruct",
            checkpoint: "Define the struct shape",
            failure_message: "Keep the `defstruct` definition in the module."
          ),
          source_contains("struct(CodiePlayground.Barista",
            checkpoint: "Build the struct value",
            failure_message: "Build the struct with `struct(CodiePlayground.Barista, ...)`."
          ),
          returns({"Nova", true},
            checkpoint: "Return `{\"Nova\", true}`",
            failure_message: "The final expression should evaluate to `{\"Nova\", true}`."
          )
        ],
        hints: [
          "Set `awake?: true` when you build the struct.",
          "Bind the struct to `barista`.",
          "Return the tuple by reading `barista.name` and `barista.awake?`."
        ],
        quick_terms: [
          quick_term(
            "Struct",
            "A struct is a named data shape with a fixed set of fields."
          )
        ],
        rewards: reward(28, 1, 5, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "structs-new",
            "Structs",
            "Structs are named, fixed-shape data values built from a module."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "inspect-sip-new",
        title: "Inspect Sip",
        summary: "Use `IO.inspect/2` to peek at a value without changing the result.",
        teaching_markdown: """
        What:
        `IO.inspect/2` prints a value and then returns that same value.

        Example:
        `drink = IO.inspect("latte", label: "drink")`

        Why:
        This is one of the highest-payoff beginner tools because it lets you see your data while keeping the code working.

        Common cases:
        Check what a value looks like while you are learning
        Confirm a value before the final step in a small flow

        Watch out:
        `IO.inspect/2` is for debugging. The value still keeps flowing through your code.

        Task:
        Keep `drink = "latte"`.
        Inspect it with the label `"drink"`.
        Then return `drink <> " ready"` so the final value is `"latte ready"`.
        """,
        starter_code: """
        drink = "latte"
        "todo"
        """,
        prerequisites: ["struct-shelf-new"],
        checks: [
          source_contains("IO.inspect",
            checkpoint: "Inspect the value with `IO.inspect/2`",
            failure_message: "Use `IO.inspect/2` to inspect `drink`."
          ),
          source_contains("label: \"drink\"",
            checkpoint: "Pass the label `\"drink\"`",
            failure_message: "Pass `label: \"drink\"` when inspecting the value."
          ),
          source_contains("<>",
            checkpoint: "Keep using the inspected value",
            failure_message: "Build the final answer from `drink` after inspecting it."
          ),
          returns("latte ready",
            checkpoint: "Return `\"latte ready\"`",
            failure_message: "The final expression should evaluate to `\"latte ready\"`."
          )
        ],
        hints: [
          "Inspect the same `drink` value instead of replacing it.",
          "Use `IO.inspect(drink, label: \"drink\")`.",
          "The final line can still build from `drink`."
        ],
        quick_terms: [
          quick_term(
            "Debugging",
            "Debugging means checking what your code is doing right now so you can understand the value you have."
          ),
          quick_term(
            "IO.inspect",
            "`IO.inspect/2` prints a value and returns that same value, which makes it useful for quick debugging."
          )
        ],
        rewards: reward(28, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "io-inspect-new",
            "IO.inspect",
            "Use `IO.inspect/2` to print a value while keeping it available for the next step."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "range-shelf-new",
        title: "Range Shelf",
        summary: "Learn a range as a compact way to represent a sequence of numbers.",
        teaching_markdown: """
        What:
        A range is a start and finish written with `..`. It represents a sequence of numbers.

        Example:
        `1..3`
        `5..8`

        Why:
        Ranges are a compact way to talk about ordered steps without writing each number by hand.

        Common cases:
        Represent a small span like `1..3`
        Use a range later anywhere code expects a sequence of numbers

        Watch out:
        `1..3` is not the same thing as `[1, 2, 3]`, even though both describe a sequence.

        Task:
        Bind `steps = 1..3`.
        Then return `{steps.first, steps.last}` so you can read the beginning and end of the range.
        """,
        starter_code: """
        steps = 0..0
        {0, 0}
        """,
        prerequisites: ["inspect-sip-new"],
        checks: [
          binds(:steps, 1..3),
          source_contains("steps.first",
            checkpoint: "Read the first value",
            failure_message: "Use `steps.first` to read the beginning of the range."
          ),
          source_contains("steps.last",
            checkpoint: "Read the last value",
            failure_message: "Use `steps.last` to read the end of the range."
          ),
          returns({1, 3},
            checkpoint: "Return `{1, 3}`",
            failure_message: "The final expression should evaluate to `{1, 3}`."
          )
        ],
        hints: [
          "Use `1..3` for the range.",
          "Keep it bound as `steps`.",
          "Return the tuple using `steps.first` and `steps.last`."
        ],
        quick_terms: [
          quick_term(
            "Range",
            "A range is a compact sequence of integers written like `1..3`."
          )
        ],
        rewards: reward(28, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "ranges-new",
            "Ranges",
            "Ranges represent a span of integers without listing each one by hand."
          )
        ]
      ),
      lesson(
        track_slug: "foundations",
        slug: "value-tools-roundup",
        title: "Value Tools Roundup",
        tier: :boss,
        summary: "Use the new value tools together after learning them one at a time.",
        teaching_markdown: """
        What:
        This checkpoint combines structs, debugging, and ranges after each one was introduced on its own.

        Example:
        `walk = struct(Walk, label: "step 1", span: 1..3)`
        `IO.inspect(walk, label: "walk")`

        Why:
        This final chapter should feel practical. You build a value, inspect it, and keep using it in one readable flow.

        Common cases:
        Keep structured data in a struct
        Inspect a value without changing the result
        Read a range clearly from the same struct

        Watch out:
        Keep the job of each piece small. Build the struct, inspect it, then return the final tuple.

        Task:
        Define `CodiePlayground.Walk` with `defstruct label: "", span: 1..1`.
        Build `walk = struct(CodiePlayground.Walk, label: "step 1", span: 1..3)`.
        Inspect it with `IO.inspect(walk, label: "walk")`.
        Then return `{walk.label, walk.span.last}`.

        The final expression should return `{"step 1", 3}`.
        """,
        starter_code: """
        defmodule CodiePlayground.Walk do
          defstruct label: "", span: 1..1
        end

        walk = struct(CodiePlayground.Walk, label: "", span: 0..0)
        {"", 0}
        """,
        prerequisites: ["range-shelf-new"],
        checks: [
          source_contains("defstruct",
            checkpoint: "Keep the struct definition",
            failure_message: "Keep the `defstruct` definition for `CodiePlayground.Walk`."
          ),
          source_contains("struct(CodiePlayground.Walk",
            checkpoint: "Build the struct value",
            failure_message: "Build the struct with `struct(CodiePlayground.Walk, ...)`."
          ),
          source_contains("IO.inspect",
            checkpoint: "Inspect the struct value",
            failure_message: "Use `IO.inspect/2` on `walk` before the final expression."
          ),
          source_contains("label: \"walk\"",
            checkpoint: "Pass the label `\"walk\"`",
            failure_message: "Pass `label: \"walk\"` when inspecting `walk`."
          ),
          returns({"step 1", 3},
            checkpoint: "Return `{\"step 1\", 3}`",
            failure_message: "The final expression should evaluate to `{\"step 1\", 3}`."
          )
        ],
        hints: [
          "Bind `walk` before the final expression.",
          "Set the struct label to `\"step 1\"` and the span to `1..3`.",
          "Inspect `walk` before reading from it in the final tuple."
        ],
        quick_terms: [
          quick_term(
            "Checkpoint",
            "A checkpoint combines several lessons to make sure they work together."
          )
        ],
        rewards: reward(44, 2, 6, 6, 5, 2),
        codex_entries_unlocked: [
          codex(
            "value-tools-roundup",
            "Value Tools Roundup",
            "This checkpoint proves you can use the next wave of Elixir value types together in one readable solution."
          )
        ]
      ),
      lesson(
        slug: "wake_codie",
        title: "Wake Codie",
        summary: "Learn that the last expression in an Elixir file is the value you get back.",
        teaching_markdown: """
        What:
        An Elixir file is just a sequence of expressions, and the final one becomes the result.

        Example:
        `1 + 1`
        `"coffee"`

        Why:
        In Elixir, you usually do not write `return`. You build the answer and leave it as the last line.

        Common cases:
        `"coffee"` as a simple text value
        `"hello"` as the final response from a tiny script

        Watch out:
        Earlier lines can prepare values, but only the final expression becomes the file result.

        Task:
        Replace the placeholder string so the final expression is exactly `"coffee"`.
        """,
        starter_code: """
        "tea"
        """,
        checks: [
          source_contains("\"coffee\"",
            checkpoint: "Use the exact string literal `\"coffee\"`",
            failure_message: "Replace the placeholder with the exact string `\"coffee\"`."
          ),
          returns("coffee",
            checkpoint: "Make the final expression evaluate to `\"coffee\"`",
            failure_message: "The final expression still is not returning `\"coffee\"`."
          )
        ],
        hints: [
          "Double quotes create strings in Elixir.",
          "The final expression is the return value.",
          "Your whole file can just be one line: \"coffee\""
        ],
        quick_terms: [
          quick_term(
            "String",
            "A string is text, written with double quotes in Elixir, like `\"coffee\"`."
          ),
          quick_term(
            "Expression",
            "An expression is a piece of code that produces a value. In Elixir, even a plain string literal is an expression."
          )
        ],
        rewards: reward(30, 2, 8, 6, 5, 2),
        codex_entries_unlocked: [
          codex(
            "strings",
            "Strings",
            "Strings use double quotes and the final expression returns its value."
          )
        ]
      ),
      lesson(
        slug: "number-crunch",
        title: "Number Crunch",
        summary: "Use arithmetic operators together instead of hardcoding the answer.",
        teaching_markdown: """
        What:
        Numbers are normal values in Elixir, and arithmetic expressions can combine several operators into one result.

        Example:
        `2 + 3`
        `6 * 6 + 6`

        Why:
        The point is not typing the answer by hand. The point is learning that Elixir code is often small expressions built from operators.

        Common cases:
        `price * quantity` for a total
        `cups + refill` for a simple count

        Watch out:
        This lesson is about building the result from operators, not replacing the whole line with a hardcoded number.

        Task:
        Change the expression so it evaluates to `42`, and use both `*` and `+`.
        """,
        starter_code: """
        6 * 6
        """,
        prerequisites: ["wake_codie"],
        checks: [
          source_contains("*",
            checkpoint: "Keep multiplication in the solution",
            failure_message: "This lesson expects you to use `*` somewhere in the expression."
          ),
          source_contains("+",
            checkpoint: "Use addition to reach the target",
            failure_message: "This lesson expects you to use `+` as part of the expression."
          ),
          returns(42,
            checkpoint: "Make the whole expression evaluate to `42`",
            failure_message: "Your expression still does not evaluate to `42`."
          )
        ],
        hints: [
          "Keep the multiplication and add the missing amount.",
          "You can add another number at the end of the expression.",
          "One valid answer is `6 * 6 + 6`."
        ],
        quick_terms: [
          quick_term(
            "Number",
            "A number is a numeric value like `2`, `42`, or `3.14`."
          ),
          quick_term(
            "Operator",
            "An operator is a symbol like `+` or `*` that combines values into a new result."
          )
        ],
        rewards: reward(25, 1, 4, 3, 2, 1),
        codex_entries_unlocked: [
          codex("numbers", "Numbers", "Elixir supports integers and floats as immutable values.")
        ]
      ),
      lesson(
        slug: "pattern-handshake",
        title: "Tuple Shelf",
        summary: "Build a tuple as plain data before you learn to unpack one.",
        teaching_markdown: """
        What:
        Tuples are small fixed-size containers. They group a few related values and keep them in a specific order.

        Example:
        `{"Nova", 1}`
        `{"latte", 2}`

        Why:
        Tuples are a common way to return “a few things that belong together” without creating a bigger data structure yet.

        Common cases:
        `{:ok, value}` when something succeeds
        `{"city", "state"}` for a short paired label

        Watch out:
        Position matters. The first and second values are not interchangeable.

        Task:
        Return the tuple `{"latte", 2}` as the final expression.
        """,
        starter_code: """
        {"tea", 0}
        """,
        prerequisites: ["number-crunch"],
        checks: [
          returns({"latte", 2},
            checkpoint: "Return the tuple `{\"latte\", 2}`",
            failure_message: "The final expression should evaluate to `{\"latte\", 2}`."
          )
        ],
        hints: [
          "Tuples use curly braces.",
          "Keep the string first and the number second.",
          "The whole answer can be exactly `{\"latte\", 2}`."
        ],
        quick_terms: [
          quick_term(
            "Tuple",
            "A tuple is a small ordered group of values. Order matters, so the first item and second item mean different things."
          ),
          quick_term(
            "Data structure",
            "A data structure is just a way a language organizes data. Tuples, lists, and maps are different structures for different jobs."
          )
        ],
        rewards: reward(30, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "tuples",
            "Tuples",
            "Tuples are ordered collections often used to group a few related values."
          )
        ]
      ),
      lesson(
        slug: "tuple-signal",
        title: "Variable Binding",
        summary: "Bind named values, then reuse them in a tuple you already understand.",
        teaching_markdown: """
        What:
        `=` gives a name to a value so later lines can reuse it. In Elixir, variables are labels for values, not little boxes that mutate in place.

        Example:
        `name = "Nova"`
        `cups = 2`
        `{name, 2}`

        Why:
        Naming values makes later code easier to read. You will do this in almost every Elixir file you write.

        Watch out:
        Bind the values first, then reuse the names. Do not skip straight to the final tuple.

        Task:
        Bind `learner = "Nova"` and `cups = 2`, then return `{learner, cups}`.
        """,
        starter_code: """
        learner = "TODO"
        cups = 0
        {learner, cups}
        """,
        prerequisites: ["pattern-handshake"],
        checks: [
          binds(:learner, "Nova",
            checkpoint: "Bind `learner` to `\"Nova\"`",
            failure_message: "Set `learner` to the exact string `\"Nova\"`."
          ),
          binds(:cups, 2,
            checkpoint: "Bind `cups` to `2`",
            failure_message: "Set `cups` to the integer `2`."
          ),
          returns({"Nova", 2},
            checkpoint: "Return `{learner, cups}` as the final value",
            failure_message: "The final expression should be `{learner, cups}`."
          )
        ],
        hints: [
          "Use `=` to bind both values before the final line.",
          "You already know tuple braces from the previous lesson.",
          "The final line should be `{learner, cups}`."
        ],
        rewards: reward(28, 1, 4, 4, 2, 1),
        codex_entries_unlocked: [
          codex(
            "variable-binding",
            "Variable Binding",
            "Use `=` to bind a value to a name so you can reuse it later in the file."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-collections",
        slug: "filter-tray",
        title: "Filter Tray",
        summary: "Keep only the values that match one rule.",
        teaching_markdown: """
        What:
        `Enum.filter/2` keeps only the items that pass a check.
        Its companion `Enum.reject/2` removes the items that pass a check.

        Example:
        `Enum.filter(["latte", "tea", "mocha"], fn drink -> String.length(drink) >= 5 end)`
        `Enum.reject(["", "latte", ""], fn drink -> drink == "" end)`

        Why:
        Filtering is one of the fastest ways to turn a noisy collection into a useful one.

        Common cases:
        Keep only long labels
        Keep only items that passed a check

        Watch out:
        `filter` keeps matches and `reject` removes matches. This task only needs `filter`.

        Task:
        Use `Enum.filter/2` on `["latte", "tea", "mocha"]` to keep only drink names with a length of at least `5`.
        """,
        starter_code: """
        ["latte", "tea", "mocha"]
        """,
        prerequisites: ["enumeration-streams-roundup"],
        checks: [
          ast_contains("Enum.filter",
            checkpoint: "Use `Enum.filter/2`",
            failure_message: "This lesson expects `Enum.filter/2`."
          ),
          source_contains("String.length",
            checkpoint: "Measure the drink names",
            failure_message: "Use `String.length/1` inside the filter."
          ),
          returns(["latte", "mocha"],
            checkpoint: "Return `[\"latte\", \"mocha\"]`",
            failure_message: "The final expression should evaluate to `[\"latte\", \"mocha\"]`."
          )
        ],
        hints: [
          "Use `Enum.filter(collection, fn item -> ... end)`.",
          "Keep only the drink names where `String.length(drink) >= 5`.",
          "If you ever need the opposite move, `Enum.reject/2` is the companion tool — but you do not need it here.",
          "A valid result is `[\"latte\", \"mocha\"]`."
        ],
        quick_terms: [
          quick_term("Filter", "`Enum.filter/2` keeps only the items that match your rule.")
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "working-with-data-filter",
            "Enum.filter",
            "Use `Enum.filter/2` when you want a smaller list that keeps only matching items."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-collections",
        slug: "find-cup",
        title: "Find Cup",
        summary: "Find the first matching value in a collection.",
        teaching_markdown: """
        What:
        `Enum.find/2` returns the first item that passes a check.
        If nothing matches, it returns `nil`.

        Example:
        `Enum.find(["tea", "latte", "mocha"], fn drink -> String.contains?(drink, "tt") end)`

        Why:
        Real code often needs the first matching item, not every matching item.

        Common cases:
        Find the first ready item
        Find the first label that matches a text rule

        Watch out:
        `Enum.find/2` returns the matching value itself, not `true`.
        A no-match result is `nil`.

        Task:
        Use `Enum.find/2` on `["tea", "latte", "mocha"]` to find the first drink that contains `"tt"`.
        """,
        starter_code: """
        ["tea", "latte", "mocha"]
        """,
        prerequisites: ["filter-tray"],
        checks: [
          ast_contains("Enum.find",
            checkpoint: "Use `Enum.find/2`",
            failure_message: "This lesson expects `Enum.find/2`."
          ),
          source_contains("String.contains?",
            checkpoint: "Use `String.contains?/2` in the match rule",
            failure_message: "Use `String.contains?/2` to check each drink."
          ),
          returns("latte",
            checkpoint: "Return `\"latte\"`",
            failure_message: "The final expression should evaluate to `\"latte\"`."
          )
        ],
        hints: [
          "Use `Enum.find(collection, fn item -> ... end)`.",
          "Check each drink with `String.contains?(drink, \"tt\")`.",
          "The first matching drink is `\"latte\"`."
        ],
        quick_terms: [
          quick_term(
            "First match",
            "`Enum.find/2` returns the first value that passes the check."
          )
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "working-with-data-find",
            "Enum.find",
            "Use `Enum.find/2` when you want the first value that matches a rule."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-collections",
        slug: "count-batch",
        title: "Count Batch",
        summary: "Count how many items made it through an earlier collection step.",
        teaching_markdown: """
        What:
        `Enum.count/1` returns how many items are in a collection.

        Example:
        `ready = Enum.filter([1, 2, 3, 4], fn cups -> cups >= 3 end)`
        `Enum.count(ready)`

        Why:
        After you filter or clean a list, counting tells you how much work is left.

        Common cases:
        Count how many items passed a filter
        Count how many items remain after cleanup

        Watch out:
        `Enum.count/1` returns an integer.

        Task:
        `large_cups` is already filtered for you.
        Use `Enum.count/1` to count `large_cups` and return the integer.
        """,
        starter_code: """
        large_cups = Enum.filter([1, 2, 3, 4, 5], fn cups -> cups >= 3 end)
        large_cups
        """,
        prerequisites: ["find-cup"],
        checks: [
          ast_contains("Enum.count",
            checkpoint: "Use `Enum.count/1`",
            failure_message: "This lesson expects `Enum.count/1`."
          ),
          returns(3,
            checkpoint: "Return `3`",
            failure_message: "The final expression should evaluate to `3`."
          )
        ],
        hints: [
          "Use `Enum.count(collection)`.",
          "Count `large_cups`, not the original list from the filter expression.",
          "The filtered list has three values left: `3`, `4`, and `5`."
        ],
        quick_terms: [
          quick_term("Count", "`Enum.count/1` tells you how many items are in a collection.")
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "working-with-data-count",
            "Enum.count",
            "Use `Enum.count/1` when you need the size of the list you already built."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-collections",
        slug: "all-ready",
        title: "All Ready?",
        summary: "Check whether every item passes one rule.",
        teaching_markdown: """
        What:
        `Enum.all?/2` checks whether every item in a collection passes the same test.

        Example:
        `Enum.all?([%{ready: true}, %{ready: true}], fn order -> order.ready end)`

        Why:
        This is a simple, practical way to answer “did every item pass?”

        Common cases:
        Check whether every order is ready
        Confirm every item passed the same validation rule

        Watch out:
        `Enum.all?/2` returns a boolean, not the original items.

        Task:
        Start with `orders = [%{label: "latte", ready: true}, %{label: "mocha", ready: true}]`.
        Use `Enum.all?/2` to check whether every order is ready.
        """,
        starter_code: """
        orders = [%{label: "latte", ready: true}, %{label: "mocha", ready: true}]
        orders
        """,
        prerequisites: ["count-batch"],
        checks: [
          ast_contains("Enum.all?",
            checkpoint: "Use `Enum.all?/2`",
            failure_message: "This lesson expects `Enum.all?/2`."
          ),
          source_contains(".ready",
            checkpoint: "Check the `:ready` field",
            failure_message: "Use the `:ready` field inside the `Enum.all?/2` check."
          ),
          returns(true,
            checkpoint: "Return `true`",
            failure_message: "The final expression should evaluate to `true`."
          )
        ],
        hints: [
          "Use `Enum.all?(orders, fn order -> ... end)`.",
          "Return the `ready` field from each order inside the function.",
          "Both orders in the starter list are ready, so the result should be `true`."
        ],
        quick_terms: [
          quick_term(
            "Validate all",
            "`Enum.all?/2` answers whether every item passes the same rule."
          )
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "working-with-data-all",
            "Enum.all?",
            "Use `Enum.all?/2` when every item in a collection must satisfy the same rule."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-collections",
        slug: "sort-board",
        title: "Sort Board",
        summary: "Put simple values and small maps into a stable order.",
        teaching_markdown: """
        What:
        `Enum.sort/1` orders simple values.
        `Enum.sort_by/2` orders richer data like maps by one field.

        Example:
        `Enum.sort([4, 1, 3, 2])`
        `Enum.sort_by([%{label: "mocha"}, %{label: "latte"}], & &1.label)`

        Why:
        A stable order makes collection results easier to read and easier to return.

        Common cases:
        Sort simple values first
        Sort small maps by one field before returning them

        Watch out:
        `Enum.sort/1` and `Enum.sort_by/2` both return new lists.

        Task:
        Start with:
        - `numbers = [4, 1, 3, 2]`
        - `orders = [%{label: "mocha"}, %{label: "latte"}, %{label: "americano"}]`

        Sort the numbers with `Enum.sort/1`.
        Then sort the orders by `:label` with `Enum.sort_by/2`.
        Return only the sorted labels from the orders.
        """,
        starter_code: """
        numbers = [4, 1, 3, 2]
        orders = [%{label: "mocha"}, %{label: "latte"}, %{label: "americano"}]
        orders
        """,
        prerequisites: ["all-ready"],
        checks: [
          ast_contains("Enum.sort",
            checkpoint: "Use `Enum.sort/1`",
            failure_message: "Use `Enum.sort/1` on the simple values first."
          ),
          ast_contains("Enum.sort_by",
            checkpoint: "Use `Enum.sort_by/2`",
            failure_message: "Use `Enum.sort_by/2` to sort the orders by label."
          ),
          returns(["americano", "latte", "mocha"],
            checkpoint: "Return the sorted labels",
            failure_message:
              "The final expression should evaluate to `[\"americano\", \"latte\", \"mocha\"]`."
          )
        ],
        hints: [
          "Bind the result of `Enum.sort(numbers)` even though the final line returns the order labels.",
          "Use `Enum.sort_by(orders, & &1.label)`.",
          "You can inspect intermediate values with `dbg/1` while you work, but it is optional in this lesson.",
          "Return the labels with `Enum.map(sorted, & &1.label)` on the final line."
        ],
        quick_terms: [
          quick_term(
            "Sort key",
            "`Enum.sort_by/2` sorts richer data by one field or computed value."
          )
        ],
        rewards: reward(38, 2, 5, 5, 3, 1),
        codex_entries_unlocked: [
          codex(
            "working-with-data-sort",
            "Enum.sort and Enum.sort_by",
            "Use `Enum.sort/1` for simple values and `Enum.sort_by/2` when you need one field to define the order."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-collections",
        slug: "collection-workflows-roundup",
        title: "Collection Workflows Roundup",
        tier: :boss,
        summary: "Clean, sort, count, and validate a small list in one practical workflow.",
        teaching_markdown: """
        What:
        This checkpoint combines the everyday collection moves from the track into one practical summary function.

        Example:
        `items |> Enum.filter(...) |> Enum.sort_by(...)`

        Why:
        Small programs often need to clean a collection, keep the useful items, and return a compact summary.

        Common cases:
        Remove blank or unusable rows before processing
        Return a stable summary of the useful items

        Watch out:
        Build the workflow step by step so each intermediate result has one clear job.

        Task:
        Define `CodiePlayground.Collections.summary/1`.
        For a list of item maps:
        - keep only items where `name != ""` and `ready` is `true`
        - sort the remaining items by `name`
        - count the remaining items
        - check whether every remaining item is ready
        - return `%{count: count, valid?: valid?, items: sorted}`

        Final expression should call `summary/1` with:
        `[%{name: "mocha", ready: true}, %{name: "", ready: true}, %{name: "latte", ready: true}, %{name: "tea", ready: false}]`
        and return `%{count: 2, valid?: true, items: [%{name: "latte", ready: true}, %{name: "mocha", ready: true}]}`.
        """,
        starter_code: """
        defmodule CodiePlayground.Collections do
          def summary(_items), do: %{count: 0, valid?: false, items: []}
        end

        CodiePlayground.Collections.summary([])
        """,
        prerequisites: ["sort-board"],
        checks: [
          ast_contains("Enum.filter",
            checkpoint: "Keep only the valid items",
            failure_message: "Use `Enum.filter/2` to keep only named ready items."
          ),
          ast_contains("Enum.sort_by",
            checkpoint: "Sort the remaining items by name",
            failure_message: "Use `Enum.sort_by/2` before building the summary."
          ),
          ast_contains("Enum.count",
            checkpoint: "Count the remaining orders",
            failure_message: "Use `Enum.count/1` for the summary count."
          ),
          ast_contains("Enum.all?",
            checkpoint: "Validate the remaining items with `Enum.all?/2`",
            failure_message: "Use `Enum.all?/2` for `valid?`."
          ),
          module_function(
            CodiePlayground.Collections,
            :summary,
            [
              [
                %{name: "mocha", ready: true},
                %{name: "", ready: true},
                %{name: "latte", ready: true},
                %{name: "tea", ready: false}
              ]
            ],
            %{
              count: 2,
              valid?: true,
              items: [%{name: "latte", ready: true}, %{name: "mocha", ready: true}]
            },
            checkpoint: "`summary/1` should return the collection report",
            failure_message:
              "`CodiePlayground.Collections.summary/1` should return `%{count: 2, valid?: true, items: [%{name: \"latte\", ready: true}, %{name: \"mocha\", ready: true}]}` for the sample data."
          ),
          returns(
            %{
              count: 2,
              valid?: true,
              items: [%{name: "latte", ready: true}, %{name: "mocha", ready: true}]
            },
            checkpoint: "Return the collection report from the final call",
            failure_message:
              "The final expression should evaluate to `%{count: 2, valid?: true, items: [%{name: \"latte\", ready: true}, %{name: \"mocha\", ready: true}]}`."
          )
        ],
        hints: [
          "Build a smaller list at each step instead of doing everything at once.",
          "A single `Enum.filter/2` can both remove blank names and keep only ready items.",
          "`Enum.reject/2` is also fine for cleanup if you want to split the steps, but it is optional.",
          "The summary should be a map with `:count`, `:valid?`, and `:items`."
        ],
        quick_terms: [
          quick_term(
            "Workflow summary",
            "A workflow summary is a compact final result that gathers the outputs a caller needs."
          )
        ],
        rewards: reward(56, 2, 6, 6, 5, 2),
        codex_entries_unlocked: [
          codex(
            "working-with-data-collections-roundup",
            "Collection Workflows Roundup",
            "A practical collection workflow usually means removing invalid items, keeping the useful ones, sorting them, and returning a compact summary."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-shapes-results",
        slug: "refresh-order",
        title: "Refresh Order",
        summary: "Update one known field on a map without rebuilding the whole thing.",
        teaching_markdown: """
        What:
        `%{map | key: value}` updates an existing key and returns a new map.

        Example:
        `order = %{drink: "latte", status: :draft}`
        `%{order | status: :ready}`

        Why:
        This is a compact, common way to update a known key on a map or struct.

        Common cases:
        Mark one order as ready
        Change one known field while keeping the rest of the map the same

        Watch out:
        Map update syntax expects the key to already exist.

        Task:
        Keep `order = %{drink: "latte", status: :draft}`,
        update `:status` to `:ready`, and return the updated map.
        """,
        starter_code: """
        order = %{drink: "latte", status: :draft}
        order
        """,
        prerequisites: ["collection-workflows-roundup"],
        checks: [
          binds(:order, %{drink: "latte", status: :draft},
            checkpoint: "Keep the starting map binding",
            failure_message: "Bind `order` as `%{drink: \"latte\", status: :draft}`."
          ),
          source_contains("| status: :ready",
            checkpoint: "Use map update syntax",
            failure_message: "Use `%{order | status: :ready}` to update the map."
          ),
          returns(%{drink: "latte", status: :ready},
            checkpoint: "Return the updated map",
            failure_message:
              "The final expression should evaluate to `%{drink: \"latte\", status: :ready}`."
          )
        ],
        hints: [
          "Keep the base map the same and update only `:status`.",
          "Use `%{order | status: :ready}` on the final line.",
          "The updated map should still keep `drink: \"latte\"`."
        ],
        quick_terms: [
          quick_term(
            "Map update syntax",
            "`%{map | key: value}` updates one existing key and returns a new map."
          )
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "working-with-data-refresh-order",
            "Map Update Syntax",
            "Use `%{map | key: value}` when the key already exists and you want a concise immutable update."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-shapes-results",
        slug: "update-tally",
        title: "Update Tally",
        summary: "Adjust one map field with `Map.update/4`.",
        teaching_markdown: """
        What:
        `Map.update/4` updates a key by running a function on the current value, or uses a default when the key is missing.

        Example:
        `Map.update(%{served: 2}, :served, 1, &(&1 + 1))`

        Why:
        This is a practical tool when the new value depends on the old value.

        Common cases:
        Increment a counter
        Adjust a tally while keeping the rest of the map the same

        Watch out:
        The update function runs on the current value, so write the new rule inside the function.

        Task:
        Start from `tally = %{served: 2, queued: 1}`,
        use `Map.update/4` to increase `:served` by `1`, and return the updated map.
        """,
        starter_code: """
        tally = %{served: 2, queued: 1}
        tally
        """,
        prerequisites: ["refresh-order"],
        checks: [
          ast_contains("Map.update",
            checkpoint: "Use `Map.update/4`",
            failure_message: "This lesson expects `Map.update/4`."
          ),
          returns(%{served: 3, queued: 1},
            checkpoint: "Return the updated map",
            failure_message: "The final expression should evaluate to `%{served: 3, queued: 1}`."
          )
        ],
        hints: [
          "Call `Map.update(tally, :served, 1, fn served -> ... end)`.",
          "Inside the update function, increase the current `served` value by `1`.",
          "The final map should still keep `queued: 1`."
        ],
        quick_terms: [
          quick_term(
            "Update function",
            "`Map.update/4` lets the next value depend on the current one."
          )
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "working-with-data-update-tally",
            "Map.update",
            "Use `Map.update/4` when the next value depends on the current one."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-shapes-results",
        slug: "normalize-ticket",
        title: "Normalize Ticket",
        summary: "Turn loose input into one predictable ticket map.",
        teaching_markdown: """
        What:
        A normalizer takes messy input and turns it into one predictable data shape.

        Example:
        `clean = String.trim(" latte , 2 ")`
        `parts = String.split(clean, ",")`

        Why:
        Small Elixir programs become easier to write when the input shape becomes stable early.

        Common cases:
        Clean user input before using it
        Build one predictable map from messy text

        Watch out:
        Trim the pieces after you split so each part is clean before you parse it.

        Task:
        Start from `" latte , 2 "`, trim it, split it on `","`, trim each piece, parse the cups, and return `%{drink: "latte", cups: 2}`.
        """,
        starter_code: """
        " latte , 2 "
        """,
        prerequisites: ["update-tally"],
        checks: [
          source_contains("String.trim",
            checkpoint: "Trim the input",
            failure_message: "Use `String.trim/1` while cleaning the input."
          ),
          source_contains("String.split",
            checkpoint: "Split the cleaned input",
            failure_message: "Use `String.split/2` to break the input into pieces."
          ),
          source_contains("Integer.parse",
            checkpoint: "Parse the cups value",
            failure_message: "Use `Integer.parse/1` for the cups text."
          ),
          returns(%{drink: "latte", cups: 2},
            checkpoint: "Return the normalized map",
            failure_message:
              "The final expression should evaluate to `%{drink: \"latte\", cups: 2}`."
          )
        ],
        hints: [
          "Trim the full string once, then split it into two pieces.",
          "Trim the `drink` text and the `cups` text separately after splitting.",
          "`Integer.parse/1` returns `{value, rest}` when parsing works."
        ],
        quick_terms: [
          quick_term(
            "Normalize",
            "Normalize means turning messy input into one predictable shape early."
          )
        ],
        rewards: reward(38, 2, 5, 5, 3, 1),
        codex_entries_unlocked: [
          codex(
            "working-with-data-normalize-ticket",
            "Normalization",
            "Normalize messy input early so the rest of the program can rely on one predictable shape."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-shapes-results",
        slug: "result-gate",
        title: "Result Gate",
        summary: "Return explicit success and failure shapes from one small check.",
        teaching_markdown: """
        What:
        Tagged results like `{:ok, value}` and `{:error, reason}` make success and failure explicit.

        Example:
        `{:ok, "latte"}`
        `{:error, :blank}`

        Why:
        Clear result shapes make later workflows easier to read and easier to combine.

        Common cases:
        Return a cleaned value when input is valid
        Return a clear reason when input is unusable

        Watch out:
        The first tuple item is the tag that tells the caller how to read the rest.

        Task:
        Define `CodiePlayground.ResultGate.check/1`.
        If the trimmed input is empty, return `{:error, :blank}`.
        Otherwise return `{:ok, trimmed_value}`.
        Make the final expression call `check("   ")`.
        """,
        starter_code: """
        defmodule CodiePlayground.ResultGate do
          def check(_raw), do: {:error, :todo}
        end

        CodiePlayground.ResultGate.check("")
        """,
        prerequisites: ["normalize-ticket"],
        checks: [
          source_contains("{:ok,",
            checkpoint: "Return a success tuple",
            failure_message: "Return `{:ok, value}` when the input is usable."
          ),
          source_contains("{:error, :blank}",
            checkpoint: "Return the blank error tuple",
            failure_message: "Return `{:error, :blank}` for blank input."
          ),
          module_function(CodiePlayground.ResultGate, :check, [" latte "], {:ok, "latte"},
            checkpoint: "`check/1` should return the cleaned success tuple",
            failure_message:
              "`CodiePlayground.ResultGate.check(\" latte \")` should return `{:ok, \"latte\"}`."
          ),
          module_function(CodiePlayground.ResultGate, :check, ["   "], {:error, :blank},
            checkpoint: "`check/1` should return the blank error tuple",
            failure_message:
              "`CodiePlayground.ResultGate.check(\"   \")` should return `{:error, :blank}`."
          ),
          returns({:error, :blank},
            checkpoint: "Return the error tuple from the final call",
            failure_message: "The final expression should evaluate to `{:error, :blank}`."
          )
        ],
        hints: [
          "Trim the input first and store the cleaned value in a variable.",
          "Use `if cleaned == \"\"` for the blank check.",
          "Return `{:ok, cleaned}` when the input is usable."
        ],
        quick_terms: [
          quick_term(
            "Tagged result",
            "A tagged result uses a leading tag like `:ok` or `:error` to explain the value."
          )
        ],
        rewards: reward(38, 2, 4, 5, 4, 1),
        codex_entries_unlocked: [
          codex(
            "working-with-data-result-gate",
            "Tagged Results",
            "Use `{:ok, value}` and `{:error, reason}` when you want explicit, readable result shapes."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-shapes-results",
        slug: "shape-guide",
        title: "Shape Guide",
        summary: "Use a short rule of thumb to choose between a map, keyword list, or struct.",
        teaching_markdown: """
        What:
        Maps, keyword lists, and structs solve different jobs, so a few clear rules of thumb go a long way.

        Example:
        `general data -> :map`
        `simple options -> :keyword`
        `known fixed fields -> :struct`

        Why:
        Beginners do not need deep architecture theory yet, but they do benefit from a simple starting guide.

        Common cases:
        Reach for a map for general data
        Reach for a keyword list for simple options
        Reach for a struct when the fields are known ahead of time

        Watch out:
        This lesson is about picking a shape, not building the full data structure yet.

        Task:
        Pick the best shape for these scenarios, in this order:
        - general order data -> `:map`
        - simple function options -> `:keyword`
        - known fixed user fields -> `:struct`

        Return the final tuple `{general_shape, options_shape, user_shape}`.
        """,
        starter_code: """
        general_shape = :todo
        options_shape = :todo
        user_shape = :todo
        {general_shape, options_shape, user_shape}
        """,
        prerequisites: ["result-gate"],
        checks: [
          binds(:general_shape, :map,
            checkpoint: "Choose `:map` for general order data",
            failure_message: "Set `general_shape` to `:map`."
          ),
          binds(:options_shape, :keyword,
            checkpoint: "Choose `:keyword` for simple options",
            failure_message: "Set `options_shape` to `:keyword`."
          ),
          binds(:user_shape, :struct,
            checkpoint: "Choose `:struct` for known fixed fields",
            failure_message: "Set `user_shape` to `:struct`."
          ),
          returns({:map, :keyword, :struct},
            checkpoint: "Return the shape tuple",
            failure_message:
              "The final expression should evaluate to `{:map, :keyword, :struct}`."
          )
        ],
        hints: [
          "Use one atom per scenario, not strings.",
          "Maps fit general data, keyword lists fit simple options, and structs fit known fixed fields.",
          "Return the final tuple in the same order as the task description."
        ],
        quick_terms: [
          quick_term(
            "Rule of thumb",
            "A rule of thumb is a simple guide you can use before you know every edge case."
          )
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "working-with-data-shape-guide",
            "Shape Guide",
            "A simple rule of thumb: general data fits maps, simple options fit keyword lists, and known fixed fields fit structs."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-shapes-results",
        slug: "shapes-results-roundup",
        title: "Shapes and Results Roundup",
        tier: :boss,
        summary: "Normalize messy input and return an honest tagged result.",
        teaching_markdown: """
        What:
        This checkpoint combines data shaping and tagged results in one small intake function.

        Example:
        `{:ok, %{drink: "latte", cups: 2, status: :ready}}`
        `{:error, :invalid}`

        Why:
        A lot of practical Elixir code takes messy input and turns it into a clean success or failure result.

        Common cases:
        Normalize one small line of input
        Return an explicit success or failure shape

        Watch out:
        Keep the output contract honest: return a clean map on success and a tagged error on failure.

        Task:
        Define `CodiePlayground.Intake.normalize/1`.
        - input like `" latte , 2 "` should become `{:ok, %{drink: "latte", cups: 2, status: :ready}}`
        - invalid input should become `{:error, :invalid}`
        - build one map, then update it before returning the success result

        Final expression should call `normalize(" latte , 2 ")`.
        """,
        starter_code: """
        defmodule CodiePlayground.Intake do
          def normalize(_raw), do: {:error, :todo}
        end

        CodiePlayground.Intake.normalize("")
        """,
        prerequisites: ["shape-guide"],
        checks: [
          source_contains("String.trim",
            checkpoint: "Trim the raw input",
            failure_message: "Use `String.trim/1` while cleaning the input."
          ),
          source_contains("String.split",
            checkpoint: "Split the cleaned input",
            failure_message: "Use `String.split/2` to separate the drink and cups text."
          ),
          source_contains("Integer.parse",
            checkpoint: "Parse the cups text",
            failure_message: "Use `Integer.parse/1` for the cups value."
          ),
          source_contains("{:ok,",
            checkpoint: "Return a tagged success tuple",
            failure_message: "Return `{:ok, map}` for valid input."
          ),
          source_contains("{:error, :invalid}",
            checkpoint: "Return the invalid error tuple",
            failure_message: "Return `{:error, :invalid}` for invalid input."
          ),
          source_contains("| status: :ready",
            checkpoint: "Update the normalized map before returning it",
            failure_message:
              "Use map update syntax to set `status: :ready` on the normalized map."
          ),
          module_function(
            CodiePlayground.Intake,
            :normalize,
            [" latte , 2 "],
            {:ok, %{drink: "latte", cups: 2, status: :ready}},
            checkpoint: "`normalize/1` should return the normalized success tuple",
            failure_message:
              "`CodiePlayground.Intake.normalize(\" latte , 2 \")` should return `{:ok, %{drink: \"latte\", cups: 2, status: :ready}}`."
          ),
          module_function(CodiePlayground.Intake, :normalize, [" latte "], {:error, :invalid},
            checkpoint: "`normalize/1` should return the invalid error tuple",
            failure_message:
              "`CodiePlayground.Intake.normalize(\" latte \")` should return `{:error, :invalid}`."
          ),
          returns({:ok, %{drink: "latte", cups: 2, status: :ready}},
            checkpoint: "Return the success tuple from the final call",
            failure_message:
              "The final expression should evaluate to `{:ok, %{drink: \"latte\", cups: 2, status: :ready}}`."
          )
        ],
        hints: [
          "Use a `case` on the split result so you can reject the wrong shape.",
          "Use a second `case` on `Integer.parse/1`.",
          "Build one ticket map, then use map update syntax to set `status: :ready` before returning `{:ok, ticket}`."
        ],
        quick_terms: [
          quick_term(
            "Intake",
            "An intake step turns raw input into a clean success value or an honest error."
          )
        ],
        rewards: reward(58, 2, 6, 6, 5, 2),
        codex_entries_unlocked: [
          codex(
            "working-with-data-shapes-roundup",
            "Shapes and Results Roundup",
            "A small intake function often needs to normalize text, build a clean map, and return an explicit tagged result."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-workflows",
        slug: "summary-module",
        title: "Summary Module",
        summary: "Wrap one practical summary workflow in a clean public module function.",
        teaching_markdown: """
        What:
        A small Elixir module often starts with one public function that wraps a useful workflow.

        Example:
        `def summary(orders), do: %{count: Enum.count(orders), items: orders}`

        Why:
        Naming the workflow behind one public function makes it easier to call, test, and read.

        Common cases:
        Put one collection workflow behind one public function
        Return one small summary map a caller can inspect

        Watch out:
        Keep the input already-shaped and keep the final report small and obvious.

        Task:
        Define `CodiePlayground.OrderSummary.summary/1`.
        It should take a list of order maps, keep only ready orders with nonblank drink names,
        sort the cleaned drink names, and return `%{count: count, items: items, valid?: true}`.
        Make the final expression call `summary/1` with:
        `[%{drink: " mocha ", ready: true}, %{drink: "tea", ready: false}, %{drink: "latte", ready: true}, %{drink: "", ready: true}]`.
        """,
        starter_code: """
        defmodule CodiePlayground.OrderSummary do
          def summary(_orders), do: %{count: 0, items: [], valid?: false}
        end

        CodiePlayground.OrderSummary.summary([])
        """,
        prerequisites: ["shapes-results-roundup"],
        checks: [
          source_contains("defmodule CodiePlayground.OrderSummary"),
          source_contains("def summary("),
          module_function(
            CodiePlayground.OrderSummary,
            :summary,
            [
              [
                %{drink: " mocha ", ready: true},
                %{drink: "tea", ready: false},
                %{drink: "latte", ready: true},
                %{drink: "", ready: true}
              ]
            ],
            %{count: 2, items: ["latte", "mocha"], valid?: true},
            checkpoint: "`summary/1` should return the summary map",
            failure_message:
              "`CodiePlayground.OrderSummary.summary([...])` should return `%{count: 2, items: [\"latte\", \"mocha\"], valid?: true}`."
          ),
          returns(%{count: 2, items: ["latte", "mocha"], valid?: true},
            checkpoint: "Return the summary map from the final call",
            failure_message:
              "The final expression should evaluate to `%{count: 2, items: [\"latte\", \"mocha\"], valid?: true}`."
          )
        ],
        hints: [
          "Filter the list down to ready orders first.",
          "Trim each drink name, then remove blank names before sorting.",
          "Return `%{count: ..., items: ..., valid?: true}` from `summary/1`."
        ],
        quick_terms: [
          quick_term(
            "Public function",
            "A public function is the named entry point other code calls to use your module."
          )
        ],
        rewards: reward(36, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "working-with-data-summary-module",
            "Summary Modules",
            "A small Elixir module often starts with one clear public function that wraps a practical workflow."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-workflows",
        slug: "helper-step",
        title: "Helper Step",
        summary: "Move one cleanup step into a helper while keeping the same summary story.",
        teaching_markdown: """
        What:
        A helper lets you name one repeated or noisy step without changing the main story of the module.

        Example:
        `def summary(orders), do: ... clean_drink(drink) ...`
        `defp clean_drink(drink), do: String.trim(drink)`

        Why:
        Pulling one cleanup step into a helper can make the public function easier to scan.

        Common cases:
        Name one cleanup step so the public function reads more clearly
        Keep the same result shape while reducing noise in the main function

        Watch out:
        Keep the helper focused on one job instead of moving the whole workflow out of `summary/1`.

        Task:
        Define `CodiePlayground.OrderSummary.summary/1` with the same summary-map result as the previous lesson,
        but add a private helper `clean_drink/1` for the drink-name cleanup step.
        Keep the final result shape `%{count: count, items: items, valid?: true}`.
        Make the final expression call `summary/1` with the same order list from the lesson story.
        """,
        starter_code: """
        defmodule CodiePlayground.OrderSummary do
          def summary(_orders), do: %{count: 0, items: [], valid?: false}
        end

        CodiePlayground.OrderSummary.summary([])
        """,
        prerequisites: ["summary-module"],
        checks: [
          source_contains("def summary("),
          source_contains("defp clean_drink("),
          module_function(
            CodiePlayground.OrderSummary,
            :summary,
            [
              [
                %{drink: " mocha ", ready: true},
                %{drink: "tea", ready: false},
                %{drink: "latte", ready: true},
                %{drink: "", ready: true}
              ]
            ],
            %{count: 2, items: ["latte", "mocha"], valid?: true},
            checkpoint: "`summary/1` should keep the same summary map",
            failure_message:
              "`CodiePlayground.OrderSummary.summary([...])` should still return `%{count: 2, items: [\"latte\", \"mocha\"], valid?: true}`."
          ),
          returns(%{count: 2, items: ["latte", "mocha"], valid?: true},
            checkpoint: "Return the summary map from the final call",
            failure_message:
              "The final expression should evaluate to `%{count: 2, items: [\"latte\", \"mocha\"], valid?: true}`."
          )
        ],
        hints: [
          "Keep `summary/1` as the public entry point.",
          "Use `clean_drink/1` only for trimming the drink name.",
          "Return the same `%{count: ..., items: ..., valid?: true}` shape as before."
        ],
        quick_terms: [
          quick_term(
            "Helper",
            "A helper is a small supporting function that keeps the main function easier to read."
          )
        ],
        rewards: reward(36, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "working-with-data-helper-step",
            "Helper Steps",
            "A small helper is useful when one cleanup step makes the public workflow noisy."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-workflows",
        slug: "pipe-line",
        title: "Pipe Line",
        summary: "Rewrite a multi-step transform into one readable pipeline.",
        teaching_markdown: """
        What:
        A pipeline shows a few one-argument transforms from top to bottom.

        Example:
        `raw |> Enum.map(&String.trim/1) |> Enum.reject(&(&1 == ""))`

        Why:
        Pipelines make small data transforms easier to read in order.

        Common cases:
        Clean text values in a few visible steps
        Keep the data flow readable from top to bottom

        Watch out:
        Pipes work best when each step accepts the previous value as its first argument.

        Task:
        Define `CodiePlayground.PipeLine.labels/1`.
        Use a pipeline to trim each drink name, remove blanks, upcase the remaining names,
        sort the final list, and return it.
        Make the final expression call `labels([" mocha ", " ", "latte "])`.
        """,
        starter_code: """
        defmodule CodiePlayground.PipeLine do
          def labels(_raw), do: []
        end

        CodiePlayground.PipeLine.labels([])
        """,
        prerequisites: ["helper-step"],
        checks: [
          ast_contains("|>",
            checkpoint: "Use a pipeline",
            failure_message: "This lesson expects a `|>` pipeline."
          ),
          source_contains("Enum.reject",
            checkpoint: "Remove blank values",
            failure_message: "Use `Enum.reject/2` to remove the blank values."
          ),
          module_function(
            CodiePlayground.PipeLine,
            :labels,
            [[" mocha ", " ", "latte "]],
            ["LATTE", "MOCHA"],
            checkpoint: "`labels/1` should return the cleaned list",
            failure_message:
              "`CodiePlayground.PipeLine.labels([\" mocha \", \" \", \"latte \"])` should return `[\"LATTE\", \"MOCHA\"]`."
          ),
          returns(["LATTE", "MOCHA"],
            checkpoint: "Return the cleaned list from the final call",
            failure_message: "The final expression should evaluate to `[\"LATTE\", \"MOCHA\"]`."
          )
        ],
        hints: [
          "Start by piping `raw` into `Enum.map(&String.trim/1)`.",
          "Reject blank strings before you upcase and sort the list.",
          "Return the final list directly from `labels/1`."
        ],
        quick_terms: [
          quick_term(
            "Pipeline",
            "A pipeline shows a small sequence of transforms in reading order."
          )
        ],
        rewards: reward(36, 2, 5, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "working-with-data-pipe-line",
            "Readable Pipelines",
            "Use a pipeline when a few cleanup steps read better from top to bottom."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-workflows",
        slug: "tagged-path",
        title: "Tagged Path",
        summary:
          "Use explicit tagged-result steps across a small workflow before reaching for `with`.",
        teaching_markdown: """
        What:
        Tagged results can travel through more than one step even when you write the branches out explicitly.

        Example:
        `case normalize_items(raw) do`
        `  {:ok, items} -> ...`
        `  {:error, reason} -> {:error, reason}`
        `end`

        Why:
        This makes multi-step success and failure paths feel normal before `with` shortens the code.

        Common cases:
        Run one tagged cleanup step, then another tagged validation step
        Pass an error tuple through unchanged when one step fails

        Watch out:
        Keep the success and error shapes consistent between the helpers and the public function.

        Task:
        Define `CodiePlayground.TaggedPath.summary/1`.
        Write `normalize_items/1` to return `{:ok, items}` or `{:error, :invalid}`.
        Write `require_batch/1` to return `{:ok, items}` when at least two items remain,
        otherwise `{:error, :too_small}`.
        In `summary/1`, use explicit `case` steps to return either
        `{:ok, %{count: count, items: items, valid?: true}}` or the error tuple unchanged.
        Make the final expression call `summary([" mocha ", " ", "latte "])`.
        """,
        starter_code: """
        defmodule CodiePlayground.TaggedPath do
          def summary(_raw), do: {:error, :todo}
        end

        CodiePlayground.TaggedPath.summary([])
        """,
        prerequisites: ["pipe-line"],
        checks: [
          ast_contains("case",
            checkpoint: "Use explicit `case` steps",
            failure_message: "This lesson expects explicit `case` branching instead of `with`."
          ),
          source_contains("{:ok,"),
          source_contains("{:error, :too_small}"),
          module_function(
            CodiePlayground.TaggedPath,
            :summary,
            [[" mocha ", " ", "latte "]],
            {:ok, %{count: 2, items: ["latte", "mocha"], valid?: true}},
            checkpoint: "`summary/1` should return the tagged summary",
            failure_message:
              "`CodiePlayground.TaggedPath.summary([\" mocha \", \" \", \"latte \"])` should return `{:ok, %{count: 2, items: [\"latte\", \"mocha\"], valid?: true}}`."
          ),
          module_function(
            CodiePlayground.TaggedPath,
            :summary,
            [[" latte "]],
            {:error, :too_small},
            checkpoint: "`summary/1` should return the small-batch error",
            failure_message:
              "`CodiePlayground.TaggedPath.summary([\" latte \"])` should return `{:error, :too_small}`."
          ),
          returns({:ok, %{count: 2, items: ["latte", "mocha"], valid?: true}},
            checkpoint: "Return the tagged summary from the final call",
            failure_message:
              "The final expression should evaluate to `{:ok, %{count: 2, items: [\"latte\", \"mocha\"], valid?: true}}`."
          )
        ],
        hints: [
          "Let `normalize_items/1` clean and sort the raw values before tagging success.",
          "Let `require_batch/1` check that at least two items remain.",
          "In `summary/1`, keep the error tuple unchanged when either step fails."
        ],
        quick_terms: [
          quick_term(
            "Tagged flow",
            "A tagged flow keeps returning `{:ok, value}` or `{:error, reason}` as the work moves through each step."
          )
        ],
        rewards: reward(38, 2, 5, 5, 4, 1),
        codex_entries_unlocked: [
          codex(
            "working-with-data-tagged-path",
            "Tagged Paths",
            "Before using `with`, it helps to get comfortable passing tagged results through multiple explicit steps."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-workflows",
        slug: "with-lane",
        title: "With Lane",
        summary:
          "Rewrite a tagged multi-step workflow with `with` once the result shapes feel familiar.",
        teaching_markdown: """
        What:
        `with` keeps the happy path readable when each helper returns the tagged shapes you already know.

        Example:
        `with {:ok, items} <- normalize_items(raw),`
        `     {:ok, items} <- require_batch(items) do`
        `  {:ok, items}`
        `end`

        Why:
        This is a cleaner version of the same tagged-result workflow you can already write with explicit `case` branches.

        Common cases:
        Keep a tagged happy path readable across multiple steps
        Return the same error tuple when one helper fails

        Watch out:
        Each `<-` expects a matching shape. A non-matching value jumps to `else`.

        Task:
        Define `CodiePlayground.WithLane.summary/1`.
        Keep the provided `normalize_items/1` and `require_batch/1` helpers.
        Rewrite `summary/1` with `with` so it returns either
        `{:ok, %{count: count, items: items, valid?: true}}` or the error tuple unchanged.
        Make the final expression call `summary([" mocha ", " ", "latte "])`.
        """,
        starter_code: """
        defmodule CodiePlayground.WithLane do
          defp normalize_items(raw) do
            items =
              raw
              |> Enum.map(&String.trim/1)
              |> Enum.reject(&(&1 == ""))
              |> Enum.sort()

            if items == [] do
              {:error, :invalid}
            else
              {:ok, items}
            end
          end

          defp require_batch(items) do
            if Enum.count(items) >= 2 do
              {:ok, items}
            else
              {:error, :too_small}
            end
          end

          def summary(_raw), do: {:error, :todo}
        end

        CodiePlayground.WithLane.summary([])
        """,
        prerequisites: ["tagged-path"],
        checks: [
          ast_contains("with",
            checkpoint: "Use a `with` expression",
            failure_message: "This lesson expects a `with` expression."
          ),
          source_contains("<-",
            checkpoint: "Chain helper results with `<-`",
            failure_message: "Use `<-` inside `with` to match each helper result."
          ),
          module_function(
            CodiePlayground.WithLane,
            :summary,
            [[" mocha ", " ", "latte "]],
            {:ok, %{count: 2, items: ["latte", "mocha"], valid?: true}},
            checkpoint: "`summary/1` should return the tagged summary",
            failure_message:
              "`CodiePlayground.WithLane.summary([\" mocha \", \" \", \"latte \"])` should return `{:ok, %{count: 2, items: [\"latte\", \"mocha\"], valid?: true}}`."
          ),
          module_function(CodiePlayground.WithLane, :summary, [[" latte "]], {:error, :too_small},
            checkpoint: "`summary/1` should return the small-batch error",
            failure_message:
              "`CodiePlayground.WithLane.summary([\" latte \"])` should return `{:error, :too_small}`."
          ),
          returns({:ok, %{count: 2, items: ["latte", "mocha"], valid?: true}},
            checkpoint: "Return the tagged summary from the final call",
            failure_message:
              "The final expression should evaluate to `{:ok, %{count: 2, items: [\"latte\", \"mocha\"], valid?: true}}`."
          )
        ],
        hints: [
          "Keep the helpers as they are and rewrite only `summary/1`.",
          "Match the `{:ok, items}` result from `normalize_items/1` first, then from `require_batch/1`.",
          "Use `else` to pass the error tuple through unchanged."
        ],
        quick_terms: [
          quick_term(
            "Happy path",
            "The happy path is the successful flow where each tagged step matches."
          )
        ],
        rewards: reward(40, 2, 5, 5, 4, 1),
        codex_entries_unlocked: [
          codex(
            "working-with-data-with-lane",
            "with Workflows",
            "Use `with` when the tagged result shapes already feel familiar and the happy path deserves a cleaner shape."
          )
        ]
      ),
      lesson(
        track_slug: "working-with-data-workflows",
        slug: "workflow-report-roundup",
        title: "Workflow Report Roundup",
        tier: :boss,
        summary:
          "Build one small module that normalizes input and returns a clear tagged report.",
        teaching_markdown: """
        What:
        This checkpoint combines one helper, a normalization pipeline, tagged results, and `with` into one small end-to-end module.

        Example:
        `with {:ok, items} <- normalize_orders(raw) do`
        `  {:ok, %{count: Enum.count(items), items: items, valid?: true}}`
        `end`

        Why:
        This is the kind of small real Elixir workflow the whole wave is building toward.

        Common cases:
        Normalize raw input into one clean report shape
        Stop early when the helper returns an error and pass it through cleanly

        Watch out:
        Keep the helper focused on normalization so the `with` block reads like the public workflow.

        Task:
        Define `CodiePlayground.WorkflowReport.summary/1`.
        Use one private helper `normalize_orders/1` that takes a raw list of order maps,
        keeps only ready orders with nonblank drink names, trims the names, sorts them, and returns
        either `{:ok, items}` or `{:error, :invalid}`.
        Then use `with` in `summary/1` to return either
        `{:ok, %{count: count, items: items, valid?: true}}` or `{:error, :invalid}`.
        Make the final expression call `summary/1` with:
        `[%{drink: " mocha ", ready: true}, %{drink: "", ready: true}, %{drink: "latte", ready: true}, %{drink: "tea", ready: false}]`.
        """,
        starter_code: """
        defmodule CodiePlayground.WorkflowReport do
          def summary(_raw), do: {:error, :todo}
        end

        CodiePlayground.WorkflowReport.summary([])
        """,
        prerequisites: ["with-lane"],
        checks: [
          ast_contains("with",
            checkpoint: "Use `with` for the main workflow",
            failure_message: "This checkpoint expects a `with` expression in `summary/1`."
          ),
          ast_contains("|>",
            checkpoint: "Use a pipeline in the helper",
            failure_message: "Use a small `|>` pipeline while normalizing the raw order list."
          ),
          source_contains("<-",
            checkpoint: "Chain helper results with `<-`",
            failure_message: "Use `<-` to chain the helper steps."
          ),
          source_contains("defp normalize_orders("),
          source_contains("{:ok, %{count:"),
          source_contains("{:error, :invalid}"),
          module_function(
            CodiePlayground.WorkflowReport,
            :summary,
            [
              [
                %{drink: " mocha ", ready: true},
                %{drink: "", ready: true},
                %{drink: "latte", ready: true},
                %{drink: "tea", ready: false}
              ]
            ],
            {:ok, %{count: 2, items: ["latte", "mocha"], valid?: true}},
            checkpoint: "`summary/1` should return the tagged report",
            failure_message:
              "`CodiePlayground.WorkflowReport.summary([...])` should return `{:ok, %{count: 2, items: [\"latte\", \"mocha\"], valid?: true}}`."
          ),
          module_function(
            CodiePlayground.WorkflowReport,
            :summary,
            [[%{drink: "", ready: true}, %{drink: "tea", ready: false}]],
            {:error, :invalid},
            checkpoint: "`summary/1` should return the invalid error tuple",
            failure_message:
              "`CodiePlayground.WorkflowReport.summary([%{drink: \"\", ready: true}, %{drink: \"tea\", ready: false}])` should return `{:error, :invalid}`."
          ),
          returns({:ok, %{count: 2, items: ["latte", "mocha"], valid?: true}},
            checkpoint: "Return the tagged report from the final call",
            failure_message:
              "The final expression should evaluate to `{:ok, %{count: 2, items: [\"latte\", \"mocha\"], valid?: true}}`."
          )
        ],
        hints: [
          "Let `normalize_orders/1` do the raw cleanup work and return a tagged result.",
          "Use a pipeline inside the helper so the cleanup steps read in order.",
          "Keep `summary/1` focused on the tagged happy path and build the final report map there."
        ],
        quick_terms: [
          quick_term(
            "End-to-end workflow",
            "An end-to-end workflow chains a few focused helpers into one clear final result."
          )
        ],
        rewards: reward(60, 2, 6, 6, 5, 2),
        codex_entries_unlocked: [
          codex(
            "working-with-data-workflow-roundup",
            "Workflow Report Roundup",
            "A small Elixir workflow often means normalizing raw input, passing one tagged result through `with`, and returning one clear final report."
          )
        ]
      ),
      lesson(
        slug: "list-supplies",
        title: "List Supplies",
        summary: "Learn plain list syntax first by building and returning a simple ordered list.",
        teaching_markdown: """
        What:
        Lists are ordered collections. You use square brackets and separate items with commas.

        Example:
        `[:coffee]`
        `[:beans, :water]`
        `[:beans, :water, :filter]`

        Why:
        Before you manipulate a list, you need the simple mental model first: a list is just a sequence of values in order.

        Common cases:
        `[:coffee, :tea, :water]` for menu items
        `["wake", "code", "rest"]` for steps in a small sequence

        Watch out:
        Lists use square brackets, not braces. The order of items is part of the value.

        Task:
        Build `supplies = [:beans, :water, :filter]` and return `supplies`.
        """,
        starter_code: """
        supplies = []
        supplies
        """,
        prerequisites: ["tuple-signal"],
        checks: [
          binds(:supplies, [:beans, :water, :filter],
            checkpoint: "Build `supplies` as `[:beans, :water, :filter]`",
            failure_message: "Set `supplies` to the list `[:beans, :water, :filter]`."
          ),
          returns([:beans, :water, :filter],
            checkpoint: "Return the list stored in `supplies`",
            failure_message: "The final expression should return the list stored in `supplies`."
          )
        ],
        hints: [
          "Lists use square brackets.",
          "Separate the items with commas inside the brackets.",
          "After you build the list, the final line can still just be `supplies`."
        ],
        quick_terms: [
          quick_term(
            "List",
            "A list is an ordered sequence of values. It is a good fit when you care about the order of many items."
          ),
          quick_term(
            "Linked list",
            "In Elixir, a list is built from one item pointing to the rest of the list. That matters later when you learn how to add items efficiently."
          ),
          quick_term(
            "Square brackets",
            "Square brackets are the list syntax in Elixir. You put the items inside them in order, like `[:beans, :water]`."
          )
        ],
        rewards: reward(28, 1, 4, 3, 2, 1),
        codex_entries_unlocked: [
          codex("lists", "Lists", "Elixir lists are linked lists and are efficient to prepend.")
        ]
      ),
      lesson(
        slug: "list-lineup",
        title: "List Lineup",
        summary:
          "Learn one real list operation: add a new item to the front of an existing list.",
        teaching_markdown: """
        What:
        `[item | list]` builds a new list by putting one new item in front of an existing list.

        Example:
        `[:filter | [:beans, :water]]`
        `["today" | ["tomorrow", "later"]]`

        Why:
        This is a common Elixir list operation because lists are efficient at the front.

        Common cases:
        `[:newest | events]` when you want the newest item first
        `[current | queue]` when building a simple work queue

        Watch out:
        This creates a new list. It does not change the old list in place.

        Task:
        Keep `supplies = [:beans, :water]`.
        Then replace the placeholder on the left side of the bar so the final expression adds `:filter` to the front.
        """,
        starter_code: """
        supplies = [:beans, :water]
        [:todo | supplies]
        """,
        prerequisites: ["list-supplies"],
        checks: [
          binds(:supplies, [:beans, :water],
            checkpoint: "Keep the base list as `[:beans, :water]`",
            failure_message: "Leave `supplies` as `[:beans, :water]`."
          ),
          source_contains("| supplies",
            checkpoint: "Use `[item | supplies]`",
            failure_message: "Build the new list with `[... | supplies]`."
          ),
          returns([:filter, :beans, :water],
            checkpoint: "Return the new front-loaded list",
            failure_message:
              "The final expression should evaluate to `[:filter, :beans, :water]`."
          )
        ],
        hints: [
          "Keep the right side of the bar exactly as `supplies`.",
          "Only replace the left-side placeholder.",
          "The final line should be `[:filter | supplies]`."
        ],
        quick_terms: [
          quick_term(
            "Prepend",
            "Prepend means add one new item to the front of an existing list."
          ),
          quick_term(
            "Head and tail",
            "In `[head | tail]`, the head is the new first item and the tail is the rest of the list."
          ),
          quick_term(
            "Vertical bar",
            "The `|` splits the new first item from the existing list you are keeping."
          )
        ],
        rewards: reward(30, 1, 4, 4, 2, 1),
        codex_entries_unlocked: [
          codex(
            "list-prepend",
            "Prepending to a List",
            "Use `[item | list]` when you want to put one new value at the front of an existing list."
          )
        ]
      ),
      lesson(
        slug: "map-station",
        title: "Map Station",
        summary: "Treat a map as a lookup table: build it first, then read from it.",
        teaching_markdown: """
        What:
        Maps hold key/value pairs and are Elixir's main flexible data structure.
        In this lesson, keys like `:shots` and `:milk` are atoms.

        Example:
        `%{name: "Nova", cups: 2}`
        `%{shots: 2, milk: :oat}`

        Why:
        A map is easiest to understand as a small lookup table: a key points to a value. Build the table correctly first, then read from it.

        Common cases:
        `%{name: "Nova", role: :learner}` for a small profile
        `%{theme: :light, sound: true}` for settings

        Watch out:
        Dot access works only when the atom key already exists on the map.
        The `:` prefix means the key is an atom, not a string.

        Task:
        Build `order = %{shots: 2, milk: :oat}` and return `{order.milk, order.shots}`.
        """,
        starter_code: """
        order = %{shots: 0, milk: :water}
        {:unknown, 0}
        """,
        prerequisites: ["list-lineup"],
        checks: [
          binds(:order, %{shots: 2, milk: :oat},
            checkpoint: "Build the map with the expected values",
            failure_message: "Set `order` to `%{shots: 2, milk: :oat}`."
          ),
          source_contains("order.milk",
            checkpoint: "Read `milk` with dot access",
            failure_message: "Use `order.milk` to read the `:milk` key."
          ),
          source_contains("order.shots",
            checkpoint: "Read `shots` with dot access",
            failure_message: "Use `order.shots` to read the `:shots` key."
          ),
          returns({:oat, 2},
            checkpoint: "Return `{order.milk, order.shots}`",
            failure_message: "The final value should be `{:oat, 2}`."
          )
        ],
        hints: [
          "First fix the map values, then read from it.",
          "Dot access works because the keys are atom literals already present.",
          "The final line should be `{order.milk, order.shots}`."
        ],
        quick_terms: [
          quick_term(
            "Map",
            "A map stores key/value pairs. Think of it like a lookup table where a key points to a value."
          ),
          quick_term(
            "Key/value pair",
            "A key/value pair is one label and the value stored under that label, like `shots: 2`."
          ),
          quick_term(
            "Atom key",
            "An atom is a named constant like `:shots`. In this lesson, the map keys are atoms."
          )
        ],
        rewards: reward(28, 1, 4, 3, 2, 1),
        codex_entries_unlocked: [
          codex(
            "maps",
            "Maps",
            "Maps store key/value pairs and are the go-to general-purpose collection."
          )
        ]
      ),
      lesson(
        slug: "keyword-orders",
        title: "Keyword Orders",
        summary: "Build a keyword list and see how it differs from a map.",
        teaching_markdown: """
        What:
        Keyword lists are ordered lists of two-element tuples.
        The names before the values are atom keys, just written in a shorter form.

        Example:
        `[{:size, :large}, {:iced, true}]`
        `[size: :large, iced: true]`

        Why:
        They are common for options and configuration, where order and repeated keys can matter.

        Common cases:
        `[timeout: 5_000, retries: 2]` for function options
        `[label: "total", limit: 3]` for simple configuration

        Watch out:
        Keyword lists preserve order and can repeat keys, unlike maps.
        `size: :large` is shorthand for `{:size, :large}` inside a list.

        Task:
        Build `opts = [size: :large, iced: true]` and return `opts`.
        """,
        starter_code: """
        opts = []
        opts
        """,
        prerequisites: ["map-station"],
        checks: [
          binds(:opts, [size: :large, iced: true],
            checkpoint: "Build the keyword list in `opts`",
            failure_message: "Set `opts` to `[size: :large, iced: true]`."
          ),
          source_contains("size: :large",
            checkpoint: "Include the `size` option",
            failure_message: "The keyword list should include `size: :large`."
          ),
          source_contains("iced: true",
            checkpoint: "Include the `iced` option",
            failure_message: "The keyword list should include `iced: true`."
          ),
          returns([size: :large, iced: true],
            checkpoint: "Return the keyword list itself",
            failure_message: "The final expression should evaluate to the keyword list in `opts`."
          )
        ],
        hints: [
          "Keyword lists use list syntax with `key: value` pairs.",
          "They preserve order and allow duplicate keys.",
          "Build the list, then return `opts`."
        ],
        quick_terms: [
          quick_term(
            "Keyword list",
            "A keyword list is a list of two-item pairs written in a short form like `[size: :large]`."
          ),
          quick_term(
            "Shorthand syntax",
            "Shorthand means a shorter way to write the same thing. `size: :large` is short for `{:size, :large}` inside a list."
          ),
          quick_term(
            "Map vs keyword list",
            "Maps are the default flexible lookup structure. Keyword lists are most common for options and can keep order or repeated keys."
          )
        ],
        rewards: reward(25, 1, 3, 3, 2, 1),
        codex_entries_unlocked: [
          codex(
            "keyword-lists",
            "Keyword Lists",
            "Keyword lists are lists of pairs often used for options."
          )
        ]
      ),
      lesson(
        slug: "truthy-roast",
        title: "State Flags",
        summary:
          "Learn atoms, booleans, and nil as plain values before using them in conditions.",
        teaching_markdown: """
        What:
        Atoms are named constants, booleans are truth values, and `nil` means “no value”.
        These values are the building blocks for status and decision-making in Elixir.

        Example:
        `:awake`
        `%{ready?: true, overdue: nil}`

        Why:
        These values show up constantly in status flags and small state snapshots, and they will drive the first conditionals you write next.

        Common cases:
        `:ok` and `:error` as small status tags
        `true` / `false` as feature flags
        `nil` when a value is missing

        Watch out:
        `nil` is a distinct value, not the same thing as an atom like `:later`.
        Only `false` and `nil` are falsy later in conditions; everything else counts as truthy.

        Task:
        Bind `status = :awake`, `ready? = true`, and `overdue = nil`.
        Return `%{status: status, ready?: ready?, overdue: overdue}`.
        """,
        starter_code: """
        status = nil
        ready? = false
        overdue = :later
        %{status: status, ready?: ready?, overdue: overdue}
        """,
        prerequisites: ["keyword-orders"],
        checks: [
          binds(:status, :awake,
            checkpoint: "Set `status` to the atom `:awake`",
            failure_message: "Set `status` to the atom `:awake`."
          ),
          binds(:ready?, true,
            checkpoint: "Set `ready?` to `true`",
            failure_message: "Set `ready?` to `true`."
          ),
          binds(:overdue, nil,
            checkpoint: "Set `overdue` to `nil`",
            failure_message: "Set `overdue` to `nil`."
          ),
          returns(%{status: :awake, ready?: true, overdue: nil},
            checkpoint: "Return the full status map",
            failure_message:
              "The final expression should return the status map with all three values."
          )
        ],
        hints: [
          "Atoms start with a colon.",
          "Predicate-style names often end with `?`.",
          "The final expression should be a map, not a tuple."
        ],
        quick_terms: [
          quick_term(
            "Atom",
            "An atom is a named constant, such as `:awake`. It is often used for states, tags, and labels."
          ),
          quick_term(
            "Truthiness",
            "In Elixir, only `false` and `nil` count as false in a condition. Everything else counts as true."
          )
        ],
        rewards: reward(26, 1, 3, 3, 2, 1),
        codex_entries_unlocked: [
          codex("atoms", "Atoms", "Atoms are constants whose value is their name.")
        ]
      ),
      lesson(
        slug: "comparison-check",
        title: "Comparison Check",
        summary: "Use comparison and boolean operators to compute a real answer.",
        teaching_markdown: """
        What:
        Comparison operators like `>`, `<`, and `==` return booleans, and boolean operators combine those results.

        Example:
        `3 > 2`
        `2 == 2 and 3 > 1`

        Why:
        Conditions are built from comparisons. First you compare values, then you combine those true/false results into one decision.

        Watch out:
        This lesson is about building the expression, not hardcoding `true`. The boolean comes from the comparisons.

        Task:
        Keep `cups = 3` and `shots = 2`.
        Return the result of `cups > shots and shots == 2`.
        """,
        starter_code: """
        cups = 3
        shots = 2
        false
        """,
        prerequisites: ["truthy-roast"],
        checks: [
          source_contains(">",
            checkpoint: "Compare `cups` and `shots` with `>`",
            failure_message: "Use `>` to compare the two values."
          ),
          source_contains("==",
            checkpoint: "Check that `shots` equals `2`",
            failure_message: "Use `==` to verify that `shots` is `2`."
          ),
          source_contains("and",
            checkpoint: "Combine both comparisons with `and`",
            failure_message: "Combine the two comparisons with `and`."
          ),
          returns(true,
            checkpoint: "Make the final expression evaluate to `true`",
            failure_message: "The final expression should evaluate to `true`."
          )
        ],
        hints: [
          "Write one comparison for `cups`, then one for `shots`.",
          "Use `and` to require both checks to be true.",
          "A valid final line is `cups > shots and shots == 2`."
        ],
        rewards: reward(28, 1, 4, 4, 2, 1),
        codex_entries_unlocked: [
          codex(
            "comparison-operators",
            "Comparison Operators",
            "Comparisons like `>`, `<`, and `==` return booleans you can combine."
          )
        ]
      ),
      lesson(
        slug: "sleepy-logic",
        title: "Sleepy Logic",
        summary: "Use `if` to branch on a boolean condition.",
        teaching_markdown: """
        What:
        `if` chooses between two branches based on a condition.

        Example:
        `if ready?, do: "brew", else: "wait"`
        `if overdue, do: "check in", else: "keep going"`

        Why:
        Beginners reach for `if` first when they need a simple yes-or-no decision.

        Watch out:
        Only `false` and `nil` are falsy in Elixir; everything else is truthy.

        Task:
        Keep `energy = 2`.
        Use `if` to return `"sleepy"` when `energy < 3`, otherwise return `"awake"`.
        """,
        starter_code: """
        energy = 2
        "awake"
        """,
        prerequisites: ["comparison-check"],
        checks: [
          ast_contains("if",
            checkpoint: "Use an `if` expression",
            failure_message: "This lesson expects an `if` expression."
          ),
          source_contains("energy < 3",
            checkpoint: "Check whether `energy` is less than `3`",
            failure_message: "Use the condition `energy < 3`."
          ),
          returns("sleepy",
            checkpoint: "Make the final expression return `\"sleepy\"`",
            failure_message: "The final expression should return `\"sleepy\"`."
          )
        ],
        hints: [
          "Use `if condition, do: ..., else: ...`.",
          "The true branch should return `\"sleepy\"`.",
          "Use `energy < 3` as the condition."
        ],
        rewards: reward(30, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex("if", "if", "`if` is the simplest way to branch on a boolean condition.")
        ]
      ),
      lesson(
        slug: "wake-routine",
        title: "Match the Signal",
        summary: "Use real pattern matching only after you know tuples and variable names.",
        teaching_markdown: """
        What:
        Pattern matching can check a value's shape and unpack part of it into a new variable.

        Example:
        `{:name, person} = {:name, "Nova"}`
        `{:ok, drink} = {:ok, "latte"}`
        `drink`

        Why:
        Elixir often sends results around as tuples like `{:ok, value}`, so unpacking them is one of the most important skills in the language.

        Watch out:
        The shape on the left must match the shape on the right. If the tags or positions do not line up, the match fails.

        Task:
        Keep `result = {:ok, "latte"}`.
        Pattern match it into `{:ok, drink}`, then return `drink <> " ready"`.
        """,
        starter_code: """
        result = {:ok, "latte"}
        drink = "tea"
        drink
        """,
        prerequisites: ["sleepy-logic"],
        checks: [
          source_contains("{:ok, drink}",
            checkpoint: "Pattern match the tuple into `{:ok, drink}`",
            failure_message: "Match the tuple with `{:ok, drink} = result` before using `drink`."
          ),
          binds(:drink, "latte",
            checkpoint: "Bind `drink` to `\"latte\"` from the tuple",
            failure_message: "After the match, `drink` should be bound to `\"latte\"`."
          ),
          source_contains("<>",
            checkpoint: "Build a new string from `drink`",
            failure_message: "Use `<>` to append `\" ready\"` to `drink`."
          ),
          returns("latte ready",
            checkpoint: "Make the final expression return `\"latte ready\"`",
            failure_message: "The final expression should evaluate to `\"latte ready\"`."
          )
        ],
        hints: [
          "Keep the atom `:ok` fixed in the pattern.",
          "Match the tuple before the final expression.",
          "After the match, build `drink <> \" ready\"`."
        ],
        rewards: reward(36, 2, 5, 5, 4, 1),
        codex_entries_unlocked: [
          codex(
            "pattern-matching",
            "Pattern Matching",
            "Pattern matching lets you unpack a value when the shapes on both sides match."
          )
        ]
      ),
      lesson(
        slug: "double-shot",
        title: "Double Shot",
        summary: "Use an anonymous function to transform a value, not just return it unchanged.",
        teaching_markdown: """
        What:
        Anonymous functions use `fn ... end` and are called with `.(...)`.

        Example:
        `double = fn n -> n * 2 end`
        `double.(3)`

        Why:
        Functions let you describe reusable transformations instead of rewriting the same logic each time you need it.

        Watch out:
        The body of the function should use the argument it receives, not ignore it.

        Task:
        Define `brew_label` so it turns `"latte"` into `"LATTE!"`, then call it.
        """,
        starter_code: """
        brew_label = fn drink -> drink end
        brew_label.("latte")
        """,
        prerequisites: ["wake-routine"],
        checks: [
          ast_contains("fn",
            checkpoint: "Use an anonymous function",
            failure_message: "Define the solution with `fn ... end`."
          ),
          source_contains("String.upcase",
            checkpoint: "Uppercase the incoming drink name",
            failure_message: "Use `String.upcase/1` inside the anonymous function."
          ),
          source_contains("<>",
            checkpoint: "Append an exclamation mark",
            failure_message: "Append `\"!\"` to the transformed string with `<>`."
          ),
          returns("LATTE!",
            checkpoint: "Calling the function should return `\"LATTE!\"`",
            failure_message: "Calling `brew_label.(\"latte\")` should return `\"LATTE!\"`."
          )
        ],
        hints: [
          "Inside the function, transform the `drink` argument instead of returning it unchanged.",
          "Try `String.upcase(drink)` first, then add `\"!\"`.",
          "A valid core body is `String.upcase(drink) <> \"!\"`."
        ],
        rewards: reward(30, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "anonymous-functions",
            "Anonymous Functions",
            "Anonymous functions are invoked with `.(...)`."
          )
        ]
      ),
      lesson(
        slug: "greeter-module",
        title: "Greeter Module",
        summary: "Define a module and a named function that actually uses its argument.",
        teaching_markdown: """
        What:
        Modules group named functions under a namespace.

        Example:
        `defmodule Math do`
        `  def sum(a, b), do: a + b`
        `end`

        Why:
        This is where Elixir starts feeling like application code instead of isolated expressions.

        Watch out:
        The function should use the argument it receives instead of returning a fixed placeholder.

        Task:
        Define `CodiePlayground.Greeter.greet/1` so it returns `"hello, " <> name`.
        Then call it with `"dev"` as the final expression.
        """,
        starter_code: """
        defmodule CodiePlayground.Greeter do
          def greet(name) do
            name
          end
        end

        CodiePlayground.Greeter.greet("")
        """,
        prerequisites: ["double-shot"],
        checks: [
          ast_contains("defmodule",
            checkpoint: "Define a module",
            failure_message: "Wrap the function in a `defmodule` block."
          ),
          source_contains("def greet(name)",
            checkpoint: "Define `greet/1` with a parameter",
            failure_message: "Define the named function as `def greet(name)`."
          ),
          source_contains("\"hello, \" <> name",
            checkpoint: "Concatenate the greeting with `name`",
            failure_message: "Return a greeting by concatenating `\"hello, \" <> name`."
          ),
          module_function(CodiePlayground.Greeter, :greet, ["dev"], "hello, dev",
            checkpoint: "`greet(\"dev\")` should return `\"hello, dev\"`",
            failure_message:
              "`CodiePlayground.Greeter.greet(\"dev\")` should return `\"hello, dev\"`."
          ),
          returns("hello, dev",
            checkpoint: "Make the final expression call the function with `\"dev\"`",
            failure_message:
              "The final expression should call `CodiePlayground.Greeter.greet(\"dev\")`."
          )
        ],
        hints: [
          "Use `defmodule ... do` to define a module.",
          "Use `def greet(name)` for the function.",
          "Concatenate strings with `<>`."
        ],
        rewards: reward(35, 2, 5, 4, 3, 1),
        codex_entries_unlocked: [
          codex("modules", "Modules", "Modules organize named functions and create namespaces.")
        ]
      ),
      lesson(
        slug: "friendly-interpolation",
        title: "Friendly Interpolation",
        summary: "Build strings with interpolation instead of manual concatenation.",
        teaching_markdown: """
        What:
        String interpolation inserts values directly into a double-quoted string.

        Example:
        `"hello, \#{name}"`

        Why:
        Interpolation is the most readable way to build strings in everyday Elixir code.

        Common cases:
        `"hello, \#{name}"` for messages
        `"cups: \#{count}"` for labels and small status text

        Watch out:
        Interpolation only works in double-quoted strings.

        Task:
        Bind `name = "dev"` and return `"hello, \#{name}"`.
        """,
        starter_code: """
        name = "dev"
        "hello"
        """,
        prerequisites: ["greeter-module"],
        checks: [
          source_contains(~S|"hello, #{name}"|,
            checkpoint: "Use interpolation inside the string literal",
            failure_message: "Return the string with interpolation: `\"hello, \#{name}\"`."
          ),
          returns("hello, dev",
            checkpoint: "Make the final expression return `\"hello, dev\"`",
            failure_message: "The final expression should return `\"hello, dev\"`."
          )
        ],
        hints: [
          "Keep the whole result in one string literal.",
          "Interpolation uses `\#{...}` inside double quotes.",
          "The final line can be exactly `\"hello, \#{name}\"`."
        ],
        quick_terms: [
          quick_term(
            "Interpolation",
            "Interpolation means placing a value inside a string with `\#{...}` instead of building the string in separate pieces."
          ),
          quick_term(
            "Template string",
            "A template string is just a string that includes one or more inserted values."
          )
        ],
        rewards: reward(30, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "string-interpolation",
            "String Interpolation",
            "Use `\#{...}` inside double quotes to embed values in a string."
          )
        ]
      ),
      lesson(
        slug: "private-refill",
        title: "Private Refill",
        summary: "Use `defp` to hide a helper behind a public function.",
        teaching_markdown: """
        What:
        `def` defines a public function, and `defp` defines a private helper.

        Example:
        `def serve(drink), do: normalize(drink)`
        `defp normalize(drink), do: String.upcase(drink)`

        Why:
        Private functions keep your module API small while letting you break work into steps.

        Watch out:
        Call the private helper from inside the module, not from the outside.

        Task:
        Define `serve/1` so it calls a private `normalize/1` helper.
        `normalize/1` should uppercase the drink name, and the final expression should return `"LATTE"`.
        """,
        starter_code: """
        defmodule CodiePlayground.Refill do
          def serve(drink), do: drink
        end

        CodiePlayground.Refill.serve("latte")
        """,
        prerequisites: ["friendly-interpolation"],
        checks: [
          source_contains("defp normalize",
            checkpoint: "Define a private helper named `normalize/1`",
            failure_message: "Add a private helper with `defp normalize(drink)`."
          ),
          source_contains("String.upcase",
            checkpoint: "Uppercase the drink inside `normalize/1`",
            failure_message: "Use `String.upcase/1` in the private helper."
          ),
          module_function(CodiePlayground.Refill, :serve, ["latte"], "LATTE",
            checkpoint: "`serve(\"latte\")` should return `\"LATTE\"`",
            failure_message:
              "`CodiePlayground.Refill.serve(\"latte\")` should return `\"LATTE\"`."
          ),
          returns("LATTE",
            checkpoint: "Make the final expression call `serve/1`",
            failure_message:
              "The final expression should call `CodiePlayground.Refill.serve(\"latte\")`."
          )
        ],
        hints: [
          "Keep `serve/1` public with `def`.",
          "Add a private helper with `defp` below it.",
          "Have `serve/1` call `normalize(drink)`."
        ],
        rewards: reward(34, 2, 5, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "defp",
            "Private Functions",
            "Use `defp` for helper functions internal to a module."
          )
        ]
      ),
      lesson(
        slug: "brew-status",
        title: "Brew Status",
        summary: "Use multiple clauses so the function responds differently to different inputs.",
        teaching_markdown: """
        What:
        Functions can have multiple clauses that match on different inputs.

        Example:
        `def state(:on), do: "running"`
        `def state(:off), do: "stopped"`

        Why:
        Pattern matching in function heads is one of Elixir's core design tools.

        Watch out:
        Each clause is tried in order, so specific patterns should come before generic ones.

        Task:
        Define `CodiePlayground.Brew.status/1` with:
        `:idle -> "waiting"`
        `:pouring -> "brewing"`

        Then make the final expression call `status(:pouring)`.
        """,
        starter_code: """
        defmodule CodiePlayground.Brew do
          def status(_state), do: "todo"
        end

        CodiePlayground.Brew.status(:pouring)
        """,
        prerequisites: ["private-refill"],
        checks: [
          source_contains("def status(:idle)",
            checkpoint: "Add a clause for `:idle`",
            failure_message: "Define a specific clause for `:idle`."
          ),
          source_contains("def status(:pouring)",
            checkpoint: "Add a clause for `:pouring`",
            failure_message: "Define a specific clause for `:pouring`."
          ),
          module_function(CodiePlayground.Brew, :status, [:idle], "waiting",
            checkpoint: "`status(:idle)` should return `\"waiting\"`",
            failure_message: "`status(:idle)` should return `\"waiting\"`."
          ),
          module_function(CodiePlayground.Brew, :status, [:pouring], "brewing",
            checkpoint: "`status(:pouring)` should return `\"brewing\"`",
            failure_message: "`status(:pouring)` should return `\"brewing\"`."
          ),
          returns("brewing",
            checkpoint: "Make the final expression call the `:pouring` clause",
            failure_message: "The final expression should evaluate to `\"brewing\"`."
          )
        ],
        hints: [
          "Write one `def status(...)` per pattern.",
          "Pattern matching in the parameter decides the clause.",
          "Use the two atoms `:idle` and `:pouring`."
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "multiple-clauses",
            "Multiple Clauses",
            "Pattern matching in parameters is a common Elixir style."
          )
        ]
      ),
      lesson(
        slug: "case-by-case",
        title: "Case by Case",
        summary: "Use `case` to branch on a tagged result.",
        teaching_markdown: """
        What:
        `case` compares one value against multiple patterns, top to bottom.

        Example:
        `case result do`
        `  {:ok, value} -> value`
        `  {:error, _reason} -> 0`
        `end`

        Why:
        `case` is the standard tool for unpacking tagged tuples like `{:ok, value}`.

        Watch out:
        Include a fallback branch so unmatched values do not crash the expression.

        Task:
        Match on `{:ok, 3}`.
        Return `cups * 2` in the success branch and `0` in the error branch.
        """,
        starter_code: """
        case {:ok, 3} do
          _value -> 0
        end
        """,
        prerequisites: ["brew-status"],
        checks: [
          ast_contains("case",
            checkpoint: "Use a `case` expression",
            failure_message: "This lesson expects a `case ... do ... end` expression."
          ),
          source_contains("{:ok, cups}",
            checkpoint: "Pattern match the success branch as `{:ok, cups}`",
            failure_message: "Add a success branch that matches `{:ok, cups}`."
          ),
          source_contains("{:error, _reason}",
            checkpoint: "Add a fallback error branch",
            failure_message: "Add an error branch like `{:error, _reason} -> 0`."
          ),
          returns(6,
            checkpoint: "Make the final expression evaluate to `6`",
            failure_message: "The `case` expression should evaluate to `6`."
          )
        ],
        hints: [
          "Use `case value do ... end`.",
          "Pattern match in each branch head.",
          "Multiply `cups * 2` in the success branch."
        ],
        rewards: reward(32, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex("case", "case", "`case` branches by pattern matching against values.")
        ]
      ),
      lesson(
        slug: "cond-roast",
        title: "Cond Roast",
        summary: "Use `cond` when several boolean checks can match.",
        teaching_markdown: """
        What:
        `cond` runs the first branch whose condition is truthy.

        Example:
        `cond do`
        `  cups == 0 -> "empty"`
        `  cups < 3 -> "low"`
        `  true -> "ready"`
        `end`

        Why:
        Use `cond` when you are testing a series of conditions instead of matching one value.

        Watch out:
        A final `true -> ...` branch acts like the default case.

        Task:
        Keep `cups = 2`.
        Use `cond` to return `"empty"` for `0`, `"low"` for values under `3`, and `"ready"` otherwise.
        """,
        starter_code: """
        cups = 2
        "ready"
        """,
        prerequisites: ["case-by-case"],
        checks: [
          ast_contains("cond",
            checkpoint: "Use a `cond` expression",
            failure_message: "This lesson expects a `cond do ... end` expression."
          ),
          source_contains("cups == 0",
            checkpoint: "Check for the empty case first",
            failure_message: "Add a first branch for `cups == 0`."
          ),
          source_contains("cups < 3",
            checkpoint: "Check for the low case second",
            failure_message: "Add a second branch for `cups < 3`."
          ),
          source_contains("true ->",
            checkpoint: "Add a default branch with `true ->`",
            failure_message: "Add a fallback branch using `true ->`."
          ),
          returns("low",
            checkpoint: "Make the final expression return `\"low\"`",
            failure_message: "With `cups = 2`, the `cond` should return `\"low\"`."
          )
        ],
        hints: [
          "Start with `cond do` and end with `end`.",
          "The first true branch wins, so order matters.",
          "Use `true -> \"ready\"` for the default branch."
        ],
        rewards: reward(32, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex("cond", "cond", "`cond` checks multiple boolean conditions in order.")
        ]
      ),
      lesson(
        slug: "guard-duty",
        title: "Guard Duty",
        summary: "Protect a clause with a guard.",
        teaching_markdown: """
        What:
        Guards add extra checks to a function clause after pattern matching succeeds.

        Example:
        `def label(cups) when is_integer(cups) and cups > 0, do: "hot"`

        Why:
        Guards let you keep invalid values out of a clause without nesting extra conditionals.

        Watch out:
        Keep a fallback clause so inputs like `0` still return a value.

        Task:
        Define `CodiePlayground.Pour.label/1` so positive integers return `"hot"` and everything else returns `"cold"`.
        """,
        starter_code: """
        defmodule CodiePlayground.Pour do
          def label(_cups), do: "cold"
        end

        CodiePlayground.Pour.label(2)
        """,
        prerequisites: ["cond-roast"],
        checks: [
          ast_contains("when",
            checkpoint: "Add a guard with `when`",
            failure_message: "This lesson expects a guard using `when`."
          ),
          source_contains("is_integer(cups)",
            checkpoint: "Check that `cups` is an integer",
            failure_message: "Use `is_integer(cups)` in the guard."
          ),
          source_contains("cups > 0",
            checkpoint: "Require `cups` to be positive",
            failure_message: "Use `cups > 0` in the guard."
          ),
          module_function(CodiePlayground.Pour, :label, [2], "hot",
            checkpoint: "`label(2)` should return `\"hot\"`",
            failure_message: "`CodiePlayground.Pour.label(2)` should return `\"hot\"`."
          ),
          module_function(CodiePlayground.Pour, :label, [0], "cold",
            checkpoint: "`label(0)` should return `\"cold\"`",
            failure_message: "`CodiePlayground.Pour.label(0)` should return `\"cold\"`."
          )
        ],
        hints: [
          "Add `when ...` after the parameter list.",
          "Use `is_integer(cups)` as part of the guard.",
          "A second catch-all clause can handle the fallback."
        ],
        rewards: reward(34, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex("guards", "Guards", "Guards add extra constraints to pattern-matched clauses.")
        ]
      ),
      lesson(
        slug: "decision-desk",
        title: "Decision Desk",
        summary: "Combine clauses, guards, tuples, and `cond` in one module.",
        teaching_markdown: """
        What:
        Elixir becomes powerful when you stack pattern matching, guards, and conditional branches together.

        Example:
        `def classify({:ok, cups}) when cups > 0 do`
        `  cond do`
        `    cups == 1 -> "light"`
        `    true -> "strong"`
        `  end`
        `end`

        Why:
        This checkpoint mirrors real application code more closely than single-concept drills.

        Watch out:
        Use a specific success clause and a separate fallback clause for the error tuple.

        Task:
        Define `CodiePlayground.Decider.classify/1`.
        For `{:ok, cups}` with a positive integer, return `"light"` when `cups == 1` and `"strong"` otherwise.
        For `{:error, _reason}`, return `"stop"`.
        Make the final expression call `classify({:ok, 2})`.
        """,
        starter_code: """
        defmodule CodiePlayground.Decider do
          def classify(_value), do: "todo"
        end

        CodiePlayground.Decider.classify({:ok, 2})
        """,
        prerequisites: ["guard-duty"],
        checks: [
          source_contains("def classify({:ok, cups}) when is_integer(cups) and cups > 0",
            checkpoint: "Match the success tuple with a guard",
            failure_message: "Define a guarded success clause for `{:ok, cups}`."
          ),
          ast_contains("cond",
            checkpoint: "Use `cond` inside the success clause",
            failure_message: "Use `cond` to decide between `\"light\"` and `\"strong\"`."
          ),
          source_contains("def classify({:error, _reason})",
            checkpoint: "Add an explicit error clause",
            failure_message: "Define a separate clause for `{:error, _reason}`."
          ),
          module_function(CodiePlayground.Decider, :classify, [{:ok, 1}], "light",
            checkpoint: "`classify({:ok, 1})` should return `\"light\"`",
            failure_message:
              "`CodiePlayground.Decider.classify({:ok, 1})` should return `\"light\"`."
          ),
          module_function(CodiePlayground.Decider, :classify, [{:ok, 2}], "strong",
            checkpoint: "`classify({:ok, 2})` should return `\"strong\"`",
            failure_message:
              "`CodiePlayground.Decider.classify({:ok, 2})` should return `\"strong\"`."
          ),
          module_function(CodiePlayground.Decider, :classify, [{:error, :empty}], "stop",
            checkpoint: "`classify({:error, :empty})` should return `\"stop\"`",
            failure_message:
              "`CodiePlayground.Decider.classify({:error, :empty})` should return `\"stop\"`."
          ),
          returns("strong",
            checkpoint: "Make the final expression call the strong path",
            failure_message: "The final expression should evaluate to `\"strong\"`."
          )
        ],
        hints: [
          "Write the success clause first and the error clause second.",
          "Use `cond do` inside the success clause body.",
          "A final `true -> \"strong\"` branch works well in the `cond`."
        ],
        rewards: reward(42, 2, 5, 5, 4, 1),
        codex_entries_unlocked: [
          codex(
            "decision-checkpoint",
            "Decision Checkpoint",
            "Mid-track checkpoints combine pattern matching, guards, and branching in one exercise."
          )
        ]
      ),
      lesson(
        slug: "pipe-dream",
        title: "Pipe Dream",
        summary: "Use the pipe operator to transform data.",
        teaching_markdown: """
        What:
        `|>` passes the result of one expression into the next function call.

        Example:
        `"latte" |> String.upcase()`

        Why:
        Piping makes transformation steps read left to right instead of inside out.

        Watch out:
        The pipe sends the left value into the first argument position of the next call.

        Task:
        Start from `"latte"`, uppercase it, then append `"!"`.
        """,
        starter_code: """
        # Use the pipe operator here
        "latte"
        """,
        prerequisites: ["decision-desk"],
        checks: [
          ast_contains("|>",
            checkpoint: "Use the pipe operator",
            failure_message: "This lesson expects `|>` in the solution."
          ),
          source_contains("String.upcase",
            checkpoint: "Uppercase the string as one of the pipe steps",
            failure_message: "Use `String.upcase/1` as part of the pipeline."
          ),
          source_contains("\"!\"",
            checkpoint: "Append an exclamation mark somewhere in the solution",
            failure_message: "Append `\"!\"` to the transformed string."
          ),
          returns("LATTE!",
            checkpoint: "Make the pipeline produce `\"LATTE!\"`",
            failure_message: "The final pipeline should evaluate to `\"LATTE!\"`."
          )
        ],
        hints: [
          "Each pipe sends the previous value into the next call.",
          "Try `String.upcase/1`.",
          "You can append `\"!\"` with `<>` in a final step."
        ],
        rewards: reward(34, 2, 5, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "pipe-operator",
            "Pipe Operator",
            "The pipe operator makes data flow left-to-right."
          )
        ]
      ),
      lesson(
        slug: "enum-tour",
        title: "Enum Tour",
        summary: "Map over a list.",
        teaching_markdown: """
        What:
        `Enum.map/2` runs a function once for each item and returns a new list.

        Example:
        `Enum.map([1, 2], fn n -> n * 2 end)`

        Why:
        Mapping is one of the most common ways to transform collection data in Elixir.

        Watch out:
        The function must return the transformed value for each item.

        Task:
        Double every number in `[1, 2, 3]`.
        """,
        starter_code: """
        [1, 2, 3]
        """,
        prerequisites: ["pipe-dream"],
        checks: [
          ast_contains("Enum.map",
            checkpoint: "Use `Enum.map/2`",
            failure_message: "This lesson expects `Enum.map/2`."
          ),
          source_contains("n * 2",
            checkpoint: "Double each item inside the mapping function",
            failure_message: "Return `n * 2` from the mapping function."
          ),
          returns([2, 4, 6],
            checkpoint: "Make the final expression return `[2, 4, 6]`",
            failure_message: "The final expression should return `[2, 4, 6]`."
          )
        ],
        hints: [
          "Use `Enum.map(collection, fn item -> ... end)`.",
          "The anonymous function should return `n * 2`.",
          "Piping the list into `Enum.map` is fine."
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex("enum-map", "Enum.map", "Enum provides traversal functions for enumerable data.")
        ]
      ),
      lesson(
        slug: "capture-shot",
        title: "Capture Shot",
        summary: "Use the `&` capture shorthand for a short anonymous function.",
        teaching_markdown: """
        What:
        The capture operator `&` creates a short anonymous function with placeholders like `&1`.

        Example:
        `Enum.map([1, 2, 3], &(&1 * 2))`

        Why:
        You will see this shorthand constantly in real Elixir code and docs.

        Watch out:
        `&1` means “the first argument”, not a variable that you defined elsewhere.

        Task:
        Use `Enum.map/2` with `&(&1 * 2)` to double `[1, 2, 3]`.
        """,
        starter_code: """
        Enum.map([1, 2, 3], fn n -> n end)
        """,
        prerequisites: ["enum-tour"],
        checks: [
          ast_contains("Enum.map",
            checkpoint: "Keep using `Enum.map/2`",
            failure_message: "Use `Enum.map/2` for this lesson."
          ),
          source_contains("&(&1 * 2)",
            checkpoint: "Use the capture shorthand `&(&1 * 2)`",
            failure_message: "Replace the long anonymous function with `&(&1 * 2)`."
          ),
          returns([2, 4, 6],
            checkpoint: "Make the final expression return `[2, 4, 6]`",
            failure_message: "The final expression should return `[2, 4, 6]`."
          )
        ],
        hints: [
          "Replace the `fn ... end` with a single capture expression.",
          "`&1` stands for the first argument passed into the function.",
          "The second argument to `Enum.map/2` can be exactly `&(&1 * 2)`."
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "capture-operator",
            "Capture Operator",
            "Use `&` and `&1` for short anonymous functions."
          )
        ]
      ),
      lesson(
        slug: "filter-grind",
        title: "Filter Grind",
        summary: "Filter and reduce a list.",
        teaching_markdown: """
        What:
        `Enum.filter/2` keeps matching items, and `Enum.reduce/3` folds many values into one.

        Example:
        `[1, 2, 3, 4] |> Enum.filter(...) |> Enum.reduce(0, ...)`

        Why:
        Real data work often means narrowing a collection and then summarizing it.

        Watch out:
        Filter first, then reduce the smaller list.

        Task:
        Sum only the even numbers in `[1, 2, 3, 4]`.
        """,
        starter_code: """
        [1, 2, 3, 4]
        """,
        prerequisites: ["capture-shot"],
        checks: [
          ast_contains("Enum.filter",
            checkpoint: "Use `Enum.filter/2` first",
            failure_message: "This lesson expects `Enum.filter/2`."
          ),
          ast_contains("Enum.reduce",
            checkpoint: "Use `Enum.reduce/3` to sum the filtered list",
            failure_message: "This lesson expects `Enum.reduce/3`."
          ),
          source_contains("rem(n, 2) == 0",
            checkpoint: "Keep only even numbers with `rem/2`",
            failure_message: "Filter for even numbers with `rem(n, 2) == 0`."
          ),
          returns(6,
            checkpoint: "Make the whole pipeline return `6`",
            failure_message: "The final expression should evaluate to `6`."
          )
        ],
        hints: [
          "Filter first, then reduce.",
          "Even numbers have `rem(n, 2) == 0`.",
          "Start the reduction with `0`."
        ],
        rewards: reward(38, 2, 5, 5, 3, 1),
        codex_entries_unlocked: [
          codex(
            "enum-reduce",
            "Enum.reduce",
            "Reduce combines a collection into a single accumulated value."
          )
        ]
      ),
      lesson(
        slug: "enum-search",
        title: "Enum Search",
        summary: "Find the first matching item and check whether any item passes a test.",
        teaching_markdown: """
        What:
        `Enum.find/2` returns the first matching item, and `Enum.any?/2` tells you whether any item passes a check.

        Example:
        `Enum.find([1, 2, 3, 4], fn n -> rem(n, 2) == 0 end)`
        `Enum.any?([1, 2, 3, 4], fn n -> n > 3 end)`

        Why:
        These are daily-use questions in real code: find the first useful item, and answer yes-or-no about a collection.

        Watch out:
        `Enum.find/2` returns the matching value, not `true`, while `Enum.any?/2` returns a boolean.

        Task:
        Use both functions on `[1, 2, 3, 4]` and return `{first_even, any_over_three?}`.
        """,
        starter_code: """
        [1, 2, 3, 4]
        """,
        prerequisites: ["filter-grind"],
        checks: [
          ast_contains("Enum.find",
            checkpoint: "Use `Enum.find/2`",
            failure_message: "This lesson expects `Enum.find/2`."
          ),
          ast_contains("Enum.any?",
            checkpoint: "Use `Enum.any?/2`",
            failure_message: "This lesson expects `Enum.any?/2`."
          ),
          returns({2, true},
            checkpoint: "Return `{2, true}`",
            failure_message: "The final expression should evaluate to `{2, true}`."
          )
        ],
        hints: [
          "Find the first even number for the first tuple item.",
          "Check whether any number is greater than `3` for the second tuple item.",
          "A valid result is `{2, true}`."
        ],
        rewards: reward(36, 2, 5, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "enum-find",
            "Enum.find and Enum.any?",
            "Use `Enum.find/2` to return the first matching item and `Enum.any?/2` to answer a yes-or-no question about a collection."
          )
        ]
      ),
      lesson(
        slug: "enum-checklist",
        title: "Enum Checklist",
        summary: "Use `Enum.all?/2` when every item must pass the same rule.",
        teaching_markdown: """
        What:
        `Enum.all?/2` checks whether every item in a collection passes the same test.

        Example:
        `Enum.all?([2, 4, 6], fn n -> rem(n, 2) == 0 end)`
        `Enum.all?(["latte", "mocha"], fn drink -> String.length(drink) >= 5 end)`

        Why:
        This is a practical validation tool. It answers questions like “did every item pass?” in one clear step.

        Watch out:
        `Enum.all?/2` returns a boolean, not the items themselves.

        Task:
        Use `Enum.all?/2` on `["latte", "mocha"]` to check that every drink name has a length of at least `5`.
        """,
        starter_code: """
        ["latte", "mocha"]
        """,
        prerequisites: ["enum-search"],
        checks: [
          ast_contains("Enum.all?",
            checkpoint: "Use `Enum.all?/2`",
            failure_message: "This lesson expects `Enum.all?/2`."
          ),
          source_contains("String.length",
            checkpoint: "Measure each string's length",
            failure_message: "Use `String.length/1` inside the check."
          ),
          returns(true,
            checkpoint: "Make the final expression evaluate to `true`",
            failure_message: "The final expression should evaluate to `true`."
          )
        ],
        hints: [
          "Use `Enum.all?(collection, fn item -> ... end)`.",
          "Check each `drink` with `String.length(drink) >= 5`.",
          "Both strings in the list are at least five characters long."
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "enum-all",
            "Enum.all?",
            "Use `Enum.all?/2` when every item in a collection must satisfy the same rule."
          )
        ]
      ),
      lesson(
        slug: "enum-order",
        title: "Enum Order",
        summary: "Count items and sort them into a predictable order.",
        teaching_markdown: """
        What:
        `Enum.count/1` returns how many items are present, and `Enum.sort/1` returns a sorted list.

        Example:
        `Enum.count([4, 1, 3, 2])`
        `Enum.sort([4, 1, 3, 2])`

        Why:
        Counting and sorting are some of the most common collection tasks in beginner and professional Elixir code.

        Watch out:
        `Enum.sort/1` returns a new list. It does not change the original list in place.

        Task:
        Use both functions on `[4, 1, 3, 2]` and return `{count, sorted}`.
        """,
        starter_code: """
        [4, 1, 3, 2]
        """,
        prerequisites: ["enum-checklist"],
        checks: [
          ast_contains("Enum.count",
            checkpoint: "Use `Enum.count/1`",
            failure_message: "This lesson expects `Enum.count/1`."
          ),
          ast_contains("Enum.sort",
            checkpoint: "Use `Enum.sort/1`",
            failure_message: "This lesson expects `Enum.sort/1`."
          ),
          returns({4, [1, 2, 3, 4]},
            checkpoint: "Return `{4, [1, 2, 3, 4]}`",
            failure_message: "The final expression should evaluate to `{4, [1, 2, 3, 4]}`."
          )
        ],
        hints: [
          "Count the list once, sort it once, then return both results.",
          "Put the count first and the sorted list second.",
          "A valid result is `{4, [1, 2, 3, 4]}`."
        ],
        rewards: reward(36, 2, 5, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "enum-count-sort",
            "Enum.count and Enum.sort",
            "Use `Enum.count/1` to measure a collection and `Enum.sort/1` to put it into a stable order."
          )
        ]
      ),
      lesson(
        slug: "string-workbench",
        title: "String Workbench",
        summary: "Trim messy input and split it into useful pieces.",
        teaching_markdown: """
        What:
        `String.trim/1` removes extra whitespace, and `String.split/2` breaks a string into parts.

        Example:
        `clean = String.trim(" latte,mocha ")`
        `String.split(clean, ",")`

        Why:
        Real input is messy. Trimming and splitting are core beginner tools for turning text into usable values.

        Common cases:
        Trim text pasted by a user
        Split comma-separated input into individual values

        Watch out:
        Trim first, then split. Otherwise the extra spaces stay inside the pieces.

        Task:
        Start from `" latte,mocha "`, trim it, split on `","`, and return the final list.
        """,
        starter_code: """
        " latte,mocha "
        """,
        prerequisites: ["enum-order"],
        checks: [
          source_contains("String.trim",
            checkpoint: "Use `String.trim/1`",
            failure_message: "Call `String.trim/1` before splitting."
          ),
          source_contains("String.split",
            checkpoint: "Use `String.split/2`",
            failure_message: "Call `String.split/2` to break the string into pieces."
          ),
          returns(["latte", "mocha"],
            checkpoint: "Return `[\"latte\", \"mocha\"]`",
            failure_message: "The final expression should evaluate to `[\"latte\", \"mocha\"]`."
          )
        ],
        hints: [
          "Trim the outer spaces first.",
          "Split on a comma, not a space.",
          "A valid result is `[\"latte\", \"mocha\"]`."
        ],
        quick_terms: [
          quick_term(
            "Trim",
            "Trim means remove extra whitespace from the start and end of a string."
          ),
          quick_term(
            "Split",
            "Split means break one string into a list of smaller strings using a separator."
          )
        ],
        rewards: reward(36, 2, 5, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "string-trim-split",
            "String.trim and String.split",
            "Use `String.trim/1` to clean text edges and `String.split/2` to turn a string into a list of pieces."
          )
        ]
      ),
      lesson(
        slug: "string-checks",
        title: "String Checks",
        summary: "Use string predicates when you want a clear yes-or-no answer about text.",
        teaching_markdown: """
        What:
        Functions like `String.contains?/2` and `String.starts_with?/2` answer simple questions about a string.

        Example:
        `String.contains?("latte-oat", "-")`
        `String.starts_with?("latte-oat", "latte")`

        Why:
        These checks show up constantly when validating input, parsing IDs, and recognizing simple string formats.

        Common cases:
        Check whether a tag contains a separator
        Check whether an ID starts with a known prefix

        Watch out:
        These functions return booleans. They check text, but they do not change it.

        Task:
        Use both functions on `"latte-oat"` and return `{has_dash?, starts_with_latte?}`.
        """,
        starter_code: """
        "latte-oat"
        """,
        prerequisites: ["string-workbench"],
        checks: [
          source_contains("String.contains?",
            checkpoint: "Use `String.contains?/2`",
            failure_message: "Use `String.contains?/2` to check for the dash."
          ),
          source_contains("String.starts_with?",
            checkpoint: "Use `String.starts_with?/2`",
            failure_message: "Use `String.starts_with?/2` to check the prefix."
          ),
          returns({true, true},
            checkpoint: "Return `{true, true}`",
            failure_message: "The final expression should evaluate to `{true, true}`."
          )
        ],
        hints: [
          "Check for `\"-\"` with `String.contains?/2`.",
          "Check the prefix `\"latte\"` with `String.starts_with?/2`.",
          "Return both booleans in a tuple."
        ],
        quick_terms: [
          quick_term(
            "Predicate function",
            "A predicate function answers a yes-or-no question and returns `true` or `false`."
          ),
          quick_term(
            "Prefix",
            "A prefix is the beginning part of a string."
          )
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "string-predicates",
            "String.contains? and String.starts_with?",
            "Use string predicate functions when you want a direct yes-or-no answer about whether text contains or starts with a specific value."
          )
        ]
      ),
      lesson(
        slug: "map-toolkit",
        title: "Map Toolkit",
        summary: "Read safely from a map, add a new key, and use bracket access.",
        teaching_markdown: """
        What:
        `Map.get/3` reads a key with a fallback, `Map.put/3` returns an updated map, and bracket access reads optional keys.

        Example:
        `shots = Map.get(order, :shots, 0)`
        `updated = Map.put(order, :milk, :oat)`
        `updated[:milk]`

        Why:
        This is the practical map toolbox beginners need for real application data.

        Common cases:
        Read a missing key with a fallback
        Add one new setting or field to a map

        Watch out:
        Map operations return new maps. They do not change the original one in place.

        Task:
        Start from `order = %{shots: 2}`, add `:milk`, read `:shots`, and return `{shots, updated[:milk]}`.
        """,
        starter_code: """
        order = %{shots: 2}
        {:unknown, :unknown}
        """,
        prerequisites: ["string-checks"],
        checks: [
          source_contains("Map.get",
            checkpoint: "Use `Map.get/3`",
            failure_message: "Use `Map.get/3` to read `:shots` with a fallback."
          ),
          source_contains("Map.put",
            checkpoint: "Use `Map.put/3`",
            failure_message: "Use `Map.put/3` to add the `:milk` key."
          ),
          source_contains("updated[:milk]",
            checkpoint: "Use bracket access for `:milk`",
            failure_message: "Read `:milk` with `updated[:milk]`."
          ),
          returns({2, :oat},
            checkpoint: "Return `{2, :oat}`",
            failure_message: "The final expression should evaluate to `{2, :oat}`."
          )
        ],
        hints: [
          "Create `updated` from `order` with `Map.put/3`.",
          "Read `shots` with `Map.get(updated, :shots, 0)`.",
          "Return `{shots, updated[:milk]}`."
        ],
        rewards: reward(38, 2, 5, 5, 3, 1),
        codex_entries_unlocked: [
          codex(
            "map-toolkit",
            "Map.get and Map.put",
            "Use `Map.get/3` for safe reads with fallbacks and `Map.put/3` when you need a new map with one key added or replaced."
          )
        ]
      ),
      lesson(
        slug: "map-refresh",
        title: "Map Refresh",
        summary: "Update an existing map key with the map update syntax.",
        teaching_markdown: """
        What:
        `%{map | key: value}` updates an existing key and returns a new map.

        Example:
        `order = %{shots: 2, milk: :oat}`
        `%{order | shots: 3}`

        Why:
        This is a compact, common way to update a known key on a map or struct.

        Watch out:
        Map update syntax expects the key to already exist.

        Task:
        Keep `order = %{shots: 2, milk: :oat}`, update `:shots` to `3`, and return the updated map.
        """,
        starter_code: """
        order = %{shots: 2, milk: :oat}
        order
        """,
        prerequisites: ["map-toolkit"],
        checks: [
          binds(:order, %{shots: 2, milk: :oat},
            checkpoint: "Keep the starting map binding",
            failure_message: "Bind `order` as `%{shots: 2, milk: :oat}`."
          ),
          source_contains("shots",
            checkpoint: "Update the `:shots` key",
            failure_message: "Update the map so the `:shots` key becomes `3`."
          ),
          returns(%{shots: 3, milk: :oat},
            checkpoint: "Return the updated map",
            failure_message: "The final expression should evaluate to `%{shots: 3, milk: :oat}`."
          )
        ],
        hints: [
          "Keep the base map the same and update only `:shots`.",
          "Use `%{order | shots: 3}` on the final line.",
          "The updated map should still keep `milk: :oat`."
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "map-update",
            "Map Update Syntax",
            "Use `%{map | key: value}` when the key already exists and you want a concise immutable update."
          )
        ]
      ),
      lesson(
        slug: "recursive-refill",
        title: "Recursive Refill",
        summary: "Write a recursive function over a list.",
        teaching_markdown: """
        What:
        Recursion is how Elixir often processes lists without mutable loop counters.

        Example:
        `def total([]), do: 0`
        `def total([head | tail]), do: head + total(tail)`

        Why:
        Recursion works naturally with pattern matching and immutable data.

        Watch out:
        You need both a base case and a recursive case or the function will never finish correctly.

        Task:
        Define `CodiePlayground.Counter.total/1` that sums a list recursively.
        """,
        starter_code: """
        defmodule CodiePlayground.Counter do
          def total(_values), do: 0
        end

        CodiePlayground.Counter.total([1, 2, 3, 4])
        """,
        prerequisites: ["map-refresh"],
        checks: [
          source_contains("def total([])"),
          source_contains("def total([head | tail])"),
          module_function(CodiePlayground.Counter, :total, [[1, 2, 3, 4]], 10),
          returns(10)
        ],
        hints: [
          "Use an empty list clause as the base case.",
          "Pattern match `[head | tail]` for the recursive case.",
          "Add `head + total(tail)`."
        ],
        rewards: reward(42, 2, 5, 5, 4, 1),
        codex_entries_unlocked: [
          codex(
            "recursion",
            "Recursion",
            "Recursion plus pattern matching is a standard way to process lists."
          )
        ]
      ),
      lesson(
        slug: "tuple-contract",
        title: "Tuple Contract",
        summary: "Return tagged success and error tuples.",
        teaching_markdown: """
        What:
        Tagged tuples make success and failure explicit in the return value.

        Example:
        `{:ok, value}`
        `{:error, reason}`

        Why:
        Elixir often uses tagged tuples instead of exceptions for normal control flow.

        Watch out:
        The first element is the tag that tells the caller how to interpret the rest.

        Task:
        Define `CodiePlayground.Auth.login/1` so `"espresso"` returns `{:ok, :welcome}` and anything else returns `{:error, :denied}`.
        """,
        starter_code: """
        defmodule CodiePlayground.Auth do
          def login(_token), do: {:error, :denied}
        end

        CodiePlayground.Auth.login("tea")
        """,
        prerequisites: ["recursive-refill"],
        checks: [
          source_contains("def login(\"espresso\")",
            checkpoint: "Add a success clause for the exact token",
            failure_message: "Match the exact success token with `def login(\"espresso\")`."
          ),
          source_contains("{:ok, :welcome}",
            checkpoint: "Return the success tuple `{:ok, :welcome}`",
            failure_message: "Return `{:ok, :welcome}` from the success clause."
          ),
          source_contains("{:error, :denied}",
            checkpoint: "Return the error tuple `{:error, :denied}`",
            failure_message: "Return `{:error, :denied}` from the fallback clause."
          ),
          module_function(CodiePlayground.Auth, :login, ["espresso"], {:ok, :welcome},
            checkpoint: "`login(\"espresso\")` should succeed",
            failure_message:
              "`CodiePlayground.Auth.login(\"espresso\")` should return `{:ok, :welcome}`."
          ),
          module_function(CodiePlayground.Auth, :login, ["tea"], {:error, :denied},
            checkpoint: "`login(\"tea\")` should fail explicitly",
            failure_message:
              "`CodiePlayground.Auth.login(\"tea\")` should return `{:error, :denied}`."
          ),
          returns({:error, :denied},
            checkpoint: "Keep the final expression as the failure example",
            failure_message: "The final expression should evaluate to `{:error, :denied}`."
          )
        ],
        hints: [
          "Pattern match the exact success token in the first clause.",
          "Use a catch-all variable in the fallback clause.",
          "Return tagged tuples like `{:ok, value}`."
        ],
        rewards: reward(38, 2, 4, 5, 4, 1),
        codex_entries_unlocked: [
          codex(
            "tagged-tuples",
            "Tagged Tuples",
            "Use tagged tuples for explicit success and error flows."
          )
        ]
      ),
      lesson(
        slug: "with-the-flow",
        title: "With The Flow",
        summary: "Use `with` to chain tagged-tuple steps without nested branching.",
        teaching_markdown: """
        What:
        `with` runs a sequence of matches and stops early when one step returns a non-matching value.

        Example:
        `with {:ok, token} <- normalize(input),`
        `     {:ok, cups} <- cups_for(token) do`
        `  {:ok, cups}`
        `end`

        Why:
        `with` is the readable way to keep a happy path clear when each step may return `{:ok, value}` or `{:error, reason}`.

        Watch out:
        Each `<-` expects a matching shape. If one step returns `{:error, reason}`, execution jumps to `else`.

        Task:
        Define `CodiePlayground.Flow.login/1` so `"espresso"` becomes `{:ok, 2}` and anything else becomes `{:error, :denied}` by chaining helper functions with `with`.
        """,
        starter_code: """
        defmodule CodiePlayground.Flow do
          defp normalize("espresso"), do: {:ok, "espresso"}
          defp normalize(_input), do: {:error, :denied}

          defp cups_for("espresso"), do: {:ok, 2}

          def login(_input), do: {:error, :todo}
        end

        CodiePlayground.Flow.login("espresso")
        """,
        prerequisites: ["tuple-contract"],
        checks: [
          ast_contains("with",
            checkpoint: "Use a `with` expression",
            failure_message: "This lesson expects a `with` expression."
          ),
          source_contains("<-",
            checkpoint: "Chain the helper results with `<-`",
            failure_message: "Use `<-` inside `with` to match each helper result."
          ),
          module_function(CodiePlayground.Flow, :login, ["espresso"], {:ok, 2},
            checkpoint: "`login(\"espresso\")` should return `{:ok, 2}`",
            failure_message:
              "`CodiePlayground.Flow.login(\"espresso\")` should return `{:ok, 2}`."
          ),
          module_function(CodiePlayground.Flow, :login, ["tea"], {:error, :denied},
            checkpoint: "`login(\"tea\")` should return `{:error, :denied}`",
            failure_message:
              "`CodiePlayground.Flow.login(\"tea\")` should return `{:error, :denied}`."
          ),
          returns({:ok, 2},
            checkpoint: "Make the final expression call the success path",
            failure_message: "The final expression should evaluate to `{:ok, 2}`."
          )
        ],
        hints: [
          "Keep the helpers and rewrite only `login/1`.",
          "Match the `{:ok, token}` result first, then the `{:ok, cups}` result.",
          "Use `else` to return the error tuple unchanged."
        ],
        rewards: reward(40, 2, 5, 5, 4, 1),
        codex_entries_unlocked: [
          codex(
            "with",
            "with",
            "Use `with` to keep a chain of tagged-tuple success steps readable without deeply nested `case` expressions."
          )
        ]
      ),
      lesson(
        slug: "peek-into-pour",
        title: "Peek Into Pour",
        summary: "Use `IO.inspect/2` to debug a value without changing the result.",
        teaching_markdown: """
        What:
        `IO.inspect/2` prints a value and then returns that same value.

        Example:
        `total = IO.inspect(3, label: "total")`

        Why:
        This is the fastest way to see what your data looks like while you are learning.

        Watch out:
        `IO.inspect/2` is for debugging, so keep the real value flowing through your code.

        Task:
        Bind `total = 3`, inspect it with the label `"total"`, and make the final expression return `3`.
        """,
        starter_code: """
        total = 3
        total
        """,
        prerequisites: ["with-the-flow"],
        checks: [
          source_contains("IO.inspect",
            checkpoint: "Call `IO.inspect/2`",
            failure_message: "Use `IO.inspect/2` to inspect the value."
          ),
          source_contains("label: \"total\"",
            checkpoint: "Pass the label `\"total\"`",
            failure_message: "Pass `label: \"total\"` as the second argument."
          ),
          returns(3,
            checkpoint: "Make the final expression still return `3`",
            failure_message: "The final expression should still evaluate to `3`."
          )
        ],
        hints: [
          "Bind the inspected result back into `total`.",
          "Use `IO.inspect(total, label: \"total\")`.",
          "The last line can simply be `total`."
        ],
        rewards: reward(32, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "io-inspect",
            "IO.inspect",
            "Use `IO.inspect/2` to print a value while returning it unchanged."
          )
        ]
      ),
      lesson(
        slug: "document-the-brew",
        title: "Document the Brew",
        summary: "Add a documented function to a module.",
        teaching_markdown: """
        What:
        Elixir keeps documentation close to the code with module attributes like `@doc`.

        Example:
        `@doc "Says hello"`
        `def hello, do: "warm hello"`

        Why:
        Good docs make it easier to learn from and maintain your own modules later.

        Watch out:
        Place the `@doc` line directly above the function it describes.

        Task:
        Define `CodiePlayground.Docs.hello/0` and add an `@doc` above it.
        """,
        starter_code: """
        defmodule CodiePlayground.Docs do
          def hello, do: "todo"
        end

        CodiePlayground.Docs.hello()
        """,
        prerequisites: ["peek-into-pour"],
        checks: [
          ast_contains("@doc"),
          source_contains("def hello"),
          module_function(CodiePlayground.Docs, :hello, [], "warm hello")
        ],
        hints: [
          "Module attributes can hold docs with `@doc`.",
          "Place the doc line right above the function definition.",
          "Return a plain string from `hello/0`."
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "docs",
            "Documentation",
            "Use `@doc` and `@moduledoc` to keep code self-explaining."
          )
        ]
      ),
      lesson(
        slug: "charlist-check",
        title: "Charlist Check",
        summary:
          "Learn the difference between an explicit `~c` charlist and a double-quoted string.",
        teaching_markdown: """
        What:
        Double quotes create binaries (strings), while `~c` creates an explicit charlist.

        Example:
        `"ok"`
        `~c"ok"`

        Why:
        This is one of the most common beginner traps in Elixir because the values look similar.

        Common cases:
        `"ok"` for ordinary Elixir string work
        `~c"ok"` when older Erlang-style APIs expect a charlist

        Watch out:
        `~c"ok"` and `"ok"` are different types in Elixir.

        Task:
        Return `{is_list(~c"ok"), is_binary("ok")}` so you prove which one is a list and which one is a binary.
        """,
        starter_code: """
        {false, false}
        """,
        prerequisites: ["document-the-brew"],
        checks: [
          source_contains(~S|~c"ok"|,
            checkpoint: "Use a `~c` charlist",
            failure_message: "Use `~c\"ok\"` somewhere in the solution."
          ),
          source_contains("\"ok\"",
            checkpoint: "Use a double-quoted string",
            failure_message: "Use `\"ok\"` somewhere in the solution."
          ),
          source_contains("is_list",
            checkpoint: "Check the charlist with `is_list/1`",
            failure_message: "Use `is_list/1` to test the charlist."
          ),
          source_contains("is_binary",
            checkpoint: "Check the string with `is_binary/1`",
            failure_message: "Use `is_binary/1` to test the string."
          ),
          returns({true, true},
            checkpoint: "Make the final expression return `{true, true}`",
            failure_message: "The final expression should evaluate to `{true, true}`."
          )
        ],
        hints: [
          "Use a tuple with two checks.",
          "A charlist is a list, and a string is a binary.",
          "The full answer can be `{is_list(~c\"ok\"), is_binary(\"ok\")}`."
        ],
        quick_terms: [
          quick_term(
            "Binary string",
            "A normal Elixir string is a binary value built for text operations."
          ),
          quick_term(
            "Charlist",
            "A charlist is a list of character codepoints. `~c\"...\"` is the clearest way to write one."
          )
        ],
        rewards: reward(32, 1, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "charlists",
            "Charlists",
            "A charlist like `~c\"ok\"` is a list of codepoints, not a binary string."
          )
        ]
      ),
      lesson(
        slug: "pin-the-order",
        title: "Pin The Order",
        summary: "Use the pin operator to match against an existing value.",
        teaching_markdown: """
        What:
        The pin operator `^` means “match the value already stored in this variable”.

        Example:
        `drink = "latte"`
        `{^drink, milk} = {"latte", :oat}`

        Why:
        Without the pin operator, Elixir would rebind the variable instead of comparing against it.

        Watch out:
        `drink` and `^drink` do different things in a pattern.

        Task:
        Keep `drink = "latte"`.
        Use `case` with `^drink` so `{"latte", :oat}` returns `{:match, :oat}`.
        """,
        starter_code: """
        drink = "latte"

        case {"latte", :oat} do
          _value -> :miss
        end
        """,
        prerequisites: ["charlist-check"],
        checks: [
          source_contains("^drink",
            checkpoint: "Use the pin operator on `drink`",
            failure_message: "Match against the existing value with `^drink`."
          ),
          ast_contains("case",
            checkpoint: "Keep the `case` expression",
            failure_message: "This lesson expects a `case` expression."
          ),
          returns({:match, :oat},
            checkpoint: "Make the final expression return `{:match, :oat}`",
            failure_message: "The `case` expression should evaluate to `{:match, :oat}`."
          )
        ],
        hints: [
          "Pattern match the tuple in the first branch.",
          "Pin the first element as `^drink`.",
          "Return `{:match, milk}` from the matching branch."
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "pin-operator",
            "Pin Operator",
            "Use `^` to match against an existing bound value."
          )
        ]
      ),
      lesson(
        slug: "default-refill",
        title: "Default Refill",
        summary: "Define a function with a default argument.",
        teaching_markdown: """
        What:
        Default arguments let one function handle both explicit and omitted values.

        Example:
        `def greet(name \\\\ "world"), do: "hello, " <> name`

        Why:
        Defaults make function calls easier when there is an obvious fallback value.

        Watch out:
        The backslashes belong in the function definition, not at the call site.

        Task:
        Define `CodiePlayground.Defaults.label/1` with a default name of `"brewer"`.
        `label()` should return `"hello, brewer"` and `label("Nova")` should return `"hello, Nova"`.
        """,
        starter_code: """
        defmodule CodiePlayground.Defaults do
          def label(name), do: "hello, " <> name
        end

        CodiePlayground.Defaults.label()
        """,
        prerequisites: ["pin-the-order"],
        checks: [
          source_contains("\\\\",
            checkpoint: "Add a default argument in the function definition",
            failure_message: "Use `\\\\` to define a default argument."
          ),
          module_function(CodiePlayground.Defaults, :label, [], "hello, brewer",
            checkpoint: "`label()` should return `\"hello, brewer\"`",
            failure_message:
              "`CodiePlayground.Defaults.label()` should return `\"hello, brewer\"`."
          ),
          module_function(CodiePlayground.Defaults, :label, ["Nova"], "hello, Nova",
            checkpoint: "`label(\"Nova\")` should return `\"hello, Nova\"`",
            failure_message:
              "`CodiePlayground.Defaults.label(\"Nova\")` should return `\"hello, Nova\"`."
          ),
          returns("hello, brewer",
            checkpoint: "Make the final expression call `label()`",
            failure_message:
              "The final expression should call `CodiePlayground.Defaults.label()`."
          )
        ],
        hints: [
          "Put the default in the parameter list.",
          "The parameter can be `name \\\\ \"brewer\"`.",
          "Keep the final line as `CodiePlayground.Defaults.label()`."
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "default-arguments",
            "Default Arguments",
            "Use `\\\\` in function parameters to provide a fallback value."
          )
        ]
      ),
      lesson(
        slug: "module-toolbelt",
        title: "Module Toolbelt",
        summary: "Use `alias`, `require`, and `import` to make module code easier to read.",
        teaching_markdown: """
        What:
        `alias` shortens module names, `import` brings selected functions into scope, and `require` enables macros.

        Example:
        `require Integer`
        `alias String, as: BrewString`
        `import List, only: [duplicate: 2]`

        Why:
        These directives are part of everyday Elixir code, especially in larger files.

        Watch out:
        Keep each directive for a clear reason. Do not pull in more than you need.

        Task:
        Use all three directives, duplicate `"latte"` twice, uppercase the first item with the alias,
        and check with `Integer.is_even/1` that the list length is even.
        Return `{"LATTE", true}`.
        """,
        starter_code: """
        {"latte", false}
        """,
        prerequisites: ["default-refill"],
        checks: [
          source_contains("require Integer",
            checkpoint: "Require the `Integer` module",
            failure_message: "Add `require Integer` before calling `Integer.is_even/1`."
          ),
          source_contains("alias String, as: BrewString",
            checkpoint: "Alias `String` as `BrewString`",
            failure_message: "Add `alias String, as: BrewString`."
          ),
          source_contains("import List",
            checkpoint: "Import from `List`",
            failure_message: "Import `List` so you can use one of its functions directly."
          ),
          source_contains("duplicate(\"latte\", 2)",
            checkpoint: "Use `duplicate/2` to build the list",
            failure_message: "Use `duplicate(\"latte\", 2)` in the solution."
          ),
          returns({"LATTE", true},
            checkpoint: "Make the final expression return `{\"LATTE\", true}`",
            failure_message: "The final expression should evaluate to `{\"LATTE\", true}`."
          )
        ],
        hints: [
          "Use the directives before the expression that returns the tuple.",
          "You can bind the duplicated list to a variable like `cups`.",
          "Use `hd(cups)` with `BrewString.upcase/1`, and `Integer.is_even(length(cups))`."
        ],
        rewards: reward(36, 2, 5, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "module-directives",
            "Module Directives",
            "Use `alias`, `import`, and `require` to manage names, functions, and macros."
          )
        ]
      ),
      lesson(
        slug: "use-the-roaster",
        title: "Use The Roaster",
        summary: "Apply a prepared `use` macro so a module gains behavior.",
        teaching_markdown: """
        What:
        `use` runs a module's `__using__/1` macro and injects code into the current module.

        Example:
        `defmodule Feature do`
        `  use SharedBehavior`
        `end`

        Why:
        You will see `use` constantly in Elixir frameworks, so it helps to understand that it brings code in.

        Watch out:
        The macro provider is already written for you here. Your job is just to apply it with `use`.

        Task:
        Add `use CodiePlayground.Wakeable` inside `CodiePlayground.Helper` so `awake?/0` becomes available.
        """,
        starter_code: """
        defmodule CodiePlayground.Wakeable do
          defmacro __using__(_opts) do
            quote do
              def awake?, do: true
            end
          end
        end

        defmodule CodiePlayground.Helper do
        end

        CodiePlayground.Helper.awake?()
        """,
        prerequisites: ["module-toolbelt"],
        checks: [
          source_contains("use CodiePlayground.Wakeable",
            checkpoint: "Use the prepared macro inside `CodiePlayground.Helper`",
            failure_message: "Add `use CodiePlayground.Wakeable` inside `CodiePlayground.Helper`."
          ),
          module_function(CodiePlayground.Helper, :awake?, [], true,
            checkpoint: "`awake?/0` should be injected by `use`",
            failure_message:
              "`CodiePlayground.Helper.awake?/0` should return `true` after you add `use`."
          ),
          returns(true,
            checkpoint: "Make the final expression return `true`",
            failure_message: "The final expression should evaluate to `true`."
          )
        ],
        hints: [
          "Do not change the `Wakeable` module.",
          "Add a single `use` line inside `CodiePlayground.Helper`.",
          "After that, `CodiePlayground.Helper.awake?()` should work."
        ],
        rewards: reward(38, 2, 5, 5, 4, 1),
        codex_entries_unlocked: [
          codex(
            "use",
            "use",
            "Use a module when it exposes a `__using__/1` macro that injects behavior."
          )
        ]
      ),
      lesson(
        slug: "struct-shelf",
        title: "Struct Shelf",
        summary: "Define and use a struct so your data has a stable shape.",
        teaching_markdown: """
        What:
        Structs are maps with a fixed set of known keys defined by a module.

        Example:
        `defstruct name: "Nova", awake?: false`
        `struct(Barista, awake?: true)`

        Why:
        Structs make data more predictable than free-form maps and are common in Elixir apps.

        Common cases:
        `%User{}` for user-shaped data
        `%Order{}` for a stable order record

        Watch out:
        In scripts like these lessons, `struct/2` is safer than `%Module{}` right after you define the module.

        Task:
        Define `CodiePlayground.Barista` with a struct.
        Use a default `name` of `"Nova"`, set `awake?` to `true`, and return `{"Nova", true}`.
        """,
        starter_code: """
        defmodule CodiePlayground.Barista do
        end

        {"Nova", false}
        """,
        prerequisites: ["use-the-roaster"],
        checks: [
          source_contains("defstruct",
            checkpoint: "Define the struct fields with `defstruct`",
            failure_message: "Add a `defstruct` definition to the module."
          ),
          source_contains("struct(CodiePlayground.Barista",
            checkpoint: "Create a struct instance with `struct/2`",
            failure_message: "Create the struct with `struct(CodiePlayground.Barista, ...)`."
          ),
          returns({"Nova", true},
            checkpoint: "Make the final expression return `{\"Nova\", true}`",
            failure_message: "The final expression should evaluate to `{\"Nova\", true}`."
          )
        ],
        hints: [
          "Give `name` a default in `defstruct`.",
          "Build the struct with `struct(CodiePlayground.Barista, awake?: true)`.",
          "Return `{barista.name, barista.awake?}`."
        ],
        quick_terms: [
          quick_term(
            "Struct",
            "A struct is a map with a fixed known shape defined by a module."
          ),
          quick_term(
            "Field",
            "A field is one named value stored inside a struct, like `name` or `awake?`."
          )
        ],
        rewards: reward(38, 2, 5, 5, 4, 1),
        codex_entries_unlocked: [
          codex(
            "structs",
            "Structs",
            "Structs give maps a fixed module-backed shape with known fields."
          )
        ]
      ),
      lesson(
        slug: "module-notes",
        title: "Module Notes",
        summary: "Use `@moduledoc` and a custom module attribute together.",
        teaching_markdown: """
        What:
        Module attributes can store docs and constants inside a module.

        Example:
        `@moduledoc "Short note"`
        `@default_drink "latte"`

        Why:
        They are useful both for documentation and for small values you want to reuse.

        Watch out:
        Module attributes live at compile time, so they are different from runtime variables.

        Task:
        Add `@moduledoc`, set `@default_drink` to `"latte"`, and have `drink/0` return that attribute.
        """,
        starter_code: """
        defmodule CodiePlayground.Notes do
          def drink, do: "tea"
        end

        CodiePlayground.Notes.drink()
        """,
        prerequisites: ["struct-shelf"],
        checks: [
          ast_contains("@moduledoc",
            checkpoint: "Add a `@moduledoc` attribute",
            failure_message: "This lesson expects a `@moduledoc` attribute."
          ),
          source_contains("@default_drink",
            checkpoint: "Define a custom `@default_drink` attribute",
            failure_message: "Add a `@default_drink` module attribute."
          ),
          module_function(CodiePlayground.Notes, :drink, [], "latte",
            checkpoint: "`drink/0` should return `\"latte\"`",
            failure_message: "`CodiePlayground.Notes.drink/0` should return `\"latte\"`."
          ),
          returns("latte",
            checkpoint: "Make the final expression call `drink/0`",
            failure_message: "The final expression should call `CodiePlayground.Notes.drink()`."
          )
        ],
        hints: [
          "Place `@moduledoc` inside the module near the top.",
          "Set `@default_drink \"latte\"` before the function.",
          "Return the attribute directly from `drink/0`."
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "module-attributes",
            "Module Attributes",
            "Use module attributes for docs and small compile-time constants."
          )
        ]
      ),
      lesson(
        slug: "debug-tap",
        title: "Debug Tap",
        summary: "Use `dbg/1` to inspect a value while keeping it in the pipeline.",
        teaching_markdown: """
        What:
        `dbg/1` prints the expression and its value, then returns that value.

        Example:
        `total = dbg(4)`

        Why:
        `dbg/1` is a modern built-in debugging tool that gives you more context than a plain print.

        Watch out:
        `dbg/1` is for debugging, so keep the real value flowing after it.

        Task:
        Bind `total = 4`, pass it through `dbg/1`, and make the final expression still return `4`.
        """,
        starter_code: """
        total = 4
        total
        """,
        prerequisites: ["module-notes"],
        checks: [
          source_contains("dbg(",
            checkpoint: "Call `dbg/1`",
            failure_message: "Use `dbg(total)` in the solution."
          ),
          returns(4,
            checkpoint: "Make the final expression still return `4`",
            failure_message: "The final expression should still evaluate to `4`."
          )
        ],
        hints: [
          "Rebind the result of `dbg(total)` back into `total`.",
          "`dbg/1` returns the same value it prints.",
          "The last line can still just be `total`."
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex("dbg", "dbg", "Use `dbg/1` to inspect expressions while preserving their value.")
        ]
      ),
      lesson(
        slug: "comprehension-lab",
        title: "Comprehension Lab",
        summary: "Use `for` with a range to filter and transform values.",
        teaching_markdown: """
        What:
        A comprehension builds a collection by looping over inputs and optionally filtering them.

        Example:
        `for n <- 1..4, rem(n, 2) == 0, do: n * 2`

        Why:
        Comprehensions are a concise way to express “take these items, keep some, transform them”.

        Common cases:
        Build a filtered list from a range like `1..10`
        Generate labels from a simple sequence of numbers

        Watch out:
        Ranges like `1..4` are values too, so they can feed directly into a comprehension.

        Task:
        Use `for` over `1..4`, keep only even numbers, double them, and return `[4, 8]`.
        """,
        starter_code: """
        1..4
        """,
        prerequisites: ["debug-tap"],
        checks: [
          ast_contains("for",
            checkpoint: "Use a `for` comprehension",
            failure_message: "This lesson expects a `for` comprehension."
          ),
          source_contains("1..4",
            checkpoint: "Iterate over the range `1..4`",
            failure_message: "Use the range `1..4` as the input."
          ),
          source_contains("rem(n, 2) == 0",
            checkpoint: "Filter for even numbers",
            failure_message: "Filter with `rem(n, 2) == 0`."
          ),
          returns([4, 8],
            checkpoint: "Make the final expression return `[4, 8]`",
            failure_message: "The comprehension should evaluate to `[4, 8]`."
          )
        ],
        hints: [
          "Start with `for n <- 1..4`.",
          "Add the even filter before `do:`.",
          "Use `do: n * 2` for the final expression."
        ],
        quick_terms: [
          quick_term(
            "Range",
            "A range is a sequence like `1..4` that represents numbers from the start to the end."
          ),
          quick_term(
            "Comprehension",
            "A comprehension builds a new collection by looping through input values and optionally filtering them."
          )
        ],
        rewards: reward(38, 2, 5, 5, 4, 1),
        codex_entries_unlocked: [
          codex(
            "comprehensions",
            "Comprehensions",
            "Use `for` to iterate, filter, and transform values into a new collection."
          )
        ]
      ),
      lesson(
        slug: "stream-flow",
        title: "Stream Flow",
        summary: "Use a `Stream` to define lazy work, then realize it with `Enum.to_list/1`.",
        teaching_markdown: """
        What:
        Streams build lazy transformations that do not run until you ask for the results.

        Example:
        `1..3 |> Stream.map(&(&1 * 2)) |> Enum.to_list()`

        Why:
        Streams let you describe work now and execute it later, which matters for larger pipelines.

        Watch out:
        A stream by itself is not the final list. You still need to realize it.

        Task:
        Start from `1..3`, double each number with `Stream.map/2`, then turn the stream into `[2, 4, 6]`.
        """,
        starter_code: """
        1..3
        """,
        track_slug: "functional-fluency",
        prerequisites: ["brew-report-boss"],
        checks: [
          ast_contains("Stream.map",
            checkpoint: "Use `Stream.map/2`",
            failure_message: "This lesson expects `Stream.map/2`."
          ),
          ast_contains("Enum.to_list",
            checkpoint: "Realize the stream with `Enum.to_list/1`",
            failure_message: "Finish the pipeline with `Enum.to_list/1`."
          ),
          returns([2, 4, 6],
            checkpoint: "Make the final expression return `[2, 4, 6]`",
            failure_message: "The final pipeline should evaluate to `[2, 4, 6]`."
          )
        ],
        hints: [
          "Pipe the range into `Stream.map/2` first.",
          "Use the same doubling logic you already know.",
          "End the pipeline with `Enum.to_list()`."
        ],
        rewards: reward(38, 2, 5, 5, 4, 1),
        codex_entries_unlocked: [
          codex(
            "streams",
            "Streams",
            "Streams are lazy transformations that run when you consume them."
          )
        ]
      ),
      lesson(
        slug: "recovery-mode",
        title: "Recovery Mode",
        summary: "Use `try` and `rescue` to recover from an exception.",
        teaching_markdown: """
        What:
        `try` runs code that may raise, and `rescue` handles matching exceptions.

        Example:
        `try do`
        `  String.to_integer("oops")`
        `rescue`
        `  ArgumentError -> :bad_input`
        `end`

        Why:
        You should not reach for exceptions first, but you do need to recognize and handle them.

        Watch out:
        `try/rescue` is different from tagged tuples like `{:ok, value}`.

        Task:
        Call `String.to_integer("oops")` inside `try`, rescue `ArgumentError`, and return `:bad_input`.
        """,
        starter_code: """
        :bad_input
        """,
        prerequisites: ["comprehension-lab"],
        checks: [
          ast_contains("try",
            checkpoint: "Use a `try` block",
            failure_message: "This lesson expects a `try` block."
          ),
          ast_contains("rescue",
            checkpoint: "Add a `rescue` clause",
            failure_message: "This lesson expects a `rescue` clause."
          ),
          source_contains("String.to_integer(\"oops\")",
            checkpoint: "Call the failing conversion inside the `try`",
            failure_message: "Call `String.to_integer(\"oops\")` inside the `try` block."
          ),
          source_contains("ArgumentError",
            checkpoint: "Rescue `ArgumentError`",
            failure_message: "Rescue `ArgumentError` explicitly."
          ),
          returns(:bad_input,
            checkpoint: "Make the final expression return `:bad_input`",
            failure_message: "The `try/rescue` expression should evaluate to `:bad_input`."
          )
        ],
        hints: [
          "Start with `try do` and end with `end`.",
          "Rescue `ArgumentError` in the `rescue` section.",
          "Return `:bad_input` from the rescue branch."
        ],
        rewards: reward(40, 2, 5, 5, 4, 1),
        codex_entries_unlocked: [
          codex(
            "try-rescue",
            "try/rescue",
            "Use `try` and `rescue` to recover from exceptions when tagged tuples are not available."
          )
        ]
      ),
      lesson(
        slug: "catch-spill",
        title: "Catch Spill",
        summary: "Use `catch` to handle a thrown value.",
        teaching_markdown: """
        What:
        `catch` handles values that were thrown with `throw/1`.

        Example:
        `try do`
        `  throw(:skip)`
        `catch`
        `  :skip -> :caught`
        `end`

        Why:
        `catch` is less common than tagged tuples or `rescue`, but you should still recognize what it does.

        Watch out:
        `throw/catch` is not the same thing as raising and rescuing an exception.

        Task:
        Throw `:sleepy` inside `try`, catch it, and return `:caught`.
        """,
        starter_code: """
        :caught
        """,
        track_slug: "functional-fluency",
        prerequisites: ["brew-report-boss"],
        checks: [
          ast_contains("try",
            checkpoint: "Use a `try` block",
            failure_message: "This lesson expects a `try` block."
          ),
          ast_contains("catch",
            checkpoint: "Add a `catch` clause",
            failure_message: "This lesson expects a `catch` clause."
          ),
          source_contains("throw(:sleepy)",
            checkpoint: "Throw the value `:sleepy`",
            failure_message: "Call `throw(:sleepy)` inside the `try` block."
          ),
          returns(:caught,
            checkpoint: "Make the final expression return `:caught`",
            failure_message: "The `try/catch` expression should evaluate to `:caught`."
          )
        ],
        hints: [
          "Use the same `try do ... end` shape as the rescue lesson.",
          "In `catch`, match the thrown atom directly.",
          "Return `:caught` from the catch branch."
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex("catch", "catch", "Use `catch` to handle values thrown with `throw/1`.")
        ]
      ),
      lesson(
        slug: "sigil-shelf",
        title: "Sigil Shelf",
        summary: "Use a sigil to create a list of strings quickly.",
        teaching_markdown: """
        What:
        Sigils are special literal forms that start with `~` and produce structured values.

        Example:
        `~w(latte mocha)`

        Why:
        Sigils give you compact syntax for common literal shapes, especially words and regexes.

        Watch out:
        The `~w` sigil produces strings by default unless you ask for another type.

        Task:
        Use `~w` to build two drink names and return the result of `length(...)` so the final value is `2`.
        """,
        starter_code: """
        0
        """,
        prerequisites: ["recovery-mode"],
        checks: [
          source_contains("~w",
            checkpoint: "Use the `~w` sigil",
            failure_message: "This lesson expects the `~w` sigil."
          ),
          source_contains("length(",
            checkpoint: "Count the generated list with `length/1`",
            failure_message: "Wrap the sigil in `length(...)`."
          ),
          returns(2,
            checkpoint: "Make the final expression return `2`",
            failure_message: "The final expression should evaluate to `2`."
          )
        ],
        hints: [
          "Use two words inside the sigil.",
          "One valid shape is `length(~w(latte mocha))`.",
          "You only need the count for this lesson."
        ],
        rewards: reward(34, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex("sigils", "Sigils", "Sigils are literal builders that start with `~`.")
        ]
      ),
      lesson(
        slug: "script-path",
        title: "Script Path",
        summary: "Touch a safe file API and path helper inside the lesson sandbox.",
        teaching_markdown: """
        What:
        Elixir includes `File` and `Path` modules for basic filesystem work.

        Example:
        `cwd = File.cwd!()`
        `Path.extname("submission.exs")`

        Why:
        You should at least recognize the basic tools for checking a path and its extension.

        Watch out:
        This lesson keeps file access safe by reading the current working directory instead of touching arbitrary files.

        Task:
        Bind `cwd = File.cwd!()`.
        Return `{is_binary(cwd), Path.extname("submission.exs")}`.
        """,
        starter_code: """
        cwd = ""
        {false, ""}
        """,
        track_slug: "mix-testing-tooling",
        prerequisites: ["brew-report-boss"],
        checks: [
          source_contains("File.cwd!()",
            checkpoint: "Read the current working directory with `File.cwd!/0`",
            failure_message: "Use `File.cwd!()` to read the current working directory."
          ),
          source_contains("Path.extname(\"submission.exs\")",
            checkpoint: "Read an extension with `Path.extname/1`",
            failure_message: "Use `Path.extname(\"submission.exs\")` in the final tuple."
          ),
          source_contains("is_binary(cwd)",
            checkpoint: "Check that the working directory is a binary string",
            failure_message: "Use `is_binary(cwd)` in the final tuple."
          ),
          returns({true, ".exs"},
            checkpoint: "Make the final expression return `{true, \".exs\"}`",
            failure_message: "The final expression should evaluate to `{true, \".exs\"}`."
          )
        ],
        hints: [
          "Set `cwd` by calling `File.cwd!()`.",
          "Use `is_binary(cwd)` for the first tuple value.",
          "Use `Path.extname(\"submission.exs\")` for the second tuple value."
        ],
        rewards: reward(36, 2, 4, 4, 3, 1),
        codex_entries_unlocked: [
          codex(
            "file-path",
            "File and Path",
            "Use `File` and `Path` for basic filesystem checks and path helpers."
          )
        ]
      ),
      lesson(
        slug: "practice-report",
        title: "Practice Report",
        summary:
          "Combine defaults, string cleanup, map access, and `with` in one reusable function.",
        teaching_markdown: """
        What:
        This late checkpoint asks you to combine several everyday Elixir tools in one solution.

        Example:
        `parts = " Nova , 4 " |> String.trim() |> String.split(",")`
        `with [name, count_text] <- parts, count <- String.to_integer(String.trim(count_text)) do`
        `  %{name: String.trim(name), cups: count}`
        `end`

        Why:
        Strong learning comes from transfer: using several practical fundamentals together without being told each tiny step.

        Watch out:
        Keep the steps separate: clean the string, split it, then chain the result with `with`.

        Task:
        Define `CodiePlayground.Practice.summary/1` with a default raw input of `" Nova , 4 "`.
        It should trim the input, split it on the comma, then use `with` to:
        - keep the two parts
        - trim the name
        - convert the second part into an integer
        - build `%{name: cleaned_name, cups: count}`

        Then return `"\#{Map.get(result, :name)}:\#{Map.get(result, :cups)}"` from the success path.
        If anything fails, return `"invalid"`.
        Make the final expression call `summary()` so it returns `"Nova:4"`.
        """,
        starter_code: """
        defmodule CodiePlayground.Practice do
          def summary(raw), do: raw
        end

        CodiePlayground.Practice.summary()
        """,
        prerequisites: ["sigil-shelf"],
        checks: [
          source_contains("\\\\",
            checkpoint: "Use a default argument for `raw`",
            failure_message:
              "Add a default argument so `summary/1` can be called with no arguments."
          ),
          source_contains("String.split",
            checkpoint: "Split the cleaned input with `String.split/2`",
            failure_message: "Use `String.split/2` after trimming the input."
          ),
          source_contains("with",
            checkpoint: "Use `with` to keep the success path readable",
            failure_message: "Use a `with` expression inside `summary/1`."
          ),
          source_contains("Map.get",
            checkpoint: "Use `Map.get/3` or `Map.get/2` to read the built map",
            failure_message: "Use `Map.get(...)` when building the final summary string."
          ),
          module_function(CodiePlayground.Practice, :summary, [], "Nova:4",
            checkpoint: "`summary()` should return `\"Nova:4\"`",
            failure_message: "`CodiePlayground.Practice.summary()` should return `\"Nova:4\"`."
          ),
          returns("Nova:4",
            checkpoint: "Make the final expression call `summary()`",
            failure_message: "The final expression should evaluate to `\"Nova:4\"`."
          )
        ],
        hints: [
          "Start by making `summary/1` accept `raw \\\\ \" Nova , 4 \"`.",
          "Trim, split, then use `with` to build the success result.",
          "Use `Map.get(result, :name)` and `Map.get(result, :cups)` in the final string."
        ],
        rewards: reward(48, 3, 6, 6, 5, 2),
        codex_entries_unlocked: [
          codex(
            "late-checkpoint",
            "Late Checkpoint",
            "Late checkpoints test whether you can combine several practical fundamentals into one coherent solution."
          )
        ]
      ),
      lesson(
        slug: "brew-report-boss",
        title: "Brew Report",
        tier: :boss,
        summary: "Combine everything into a small report module.",
        teaching_markdown: """
        What:
        Boss lessons ask you to compose multiple ideas into one small, realistic solution.

        Why:
        This is where syntax turns into problem solving. You are combining transforms, reduction, and explicit success values.

        Watch out:
        Keep the pipeline readable. Each step should do one job.

        Task:
        Define `CodiePlayground.Report.summary/1` that:
        - takes a list of numbers
        - doubles each number
        - sums the doubled list
        - returns `{:ok, total}`

        Then make the final expression call it with `[1, 2, 3]`.
        """,
        starter_code: """
        defmodule CodiePlayground.Report do
          def summary(values) do
            {:error, values}
          end
        end

        CodiePlayground.Report.summary([])
        """,
        prerequisites: ["practice-report"],
        checks: [
          ast_contains("|>"),
          source_contains("Enum.map"),
          source_contains("Enum.reduce"),
          source_contains("{:ok, total}"),
          module_function(CodiePlayground.Report, :summary, [[1, 2, 3]], {:ok, 12}),
          returns({:ok, 12})
        ],
        hints: [
          "Pipe the list through `Enum.map` and `Enum.reduce`.",
          "Double each element before summing.",
          "Wrap the result in `{:ok, total}`."
        ],
        rewards: reward(60, 4, 10, 8, 8, 3),
        codex_entries_unlocked: [
          codex(
            "boss-foundations",
            "Foundations Complete",
            "You can now combine Elixir fundamentals into small real programs."
          )
        ]
      ),
      lesson(
        track_slug: "expert-functional-foundations",
        slug: "expert-basics",
        title: "Basic Types & Immutability",
        summary: "Variables are just labels.",
        teaching_markdown: "Data never changes in place. Variables are just labels for values.",
        starter_code: "status = :ok",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-functional-foundations",
        slug: "expert-pattern-matching",
        title: "Pattern Matching",
        summary: "The most important lesson in Elixir.",
        teaching_markdown: "The `=` operator is not assignment; it's an assertion.",
        starter_code: "{:ok, result} = {:ok, 42}",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-functional-foundations",
        slug: "expert-complex-data",
        title: "Complex Data Structures",
        summary: "Lists vs Tuples, Maps vs Keyword Lists.",
        teaching_markdown: "Knowing when to use a Map vs a Keyword List is crucial.",
        starter_code: "user = %{name: \"Alice\"}",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-functional-foundations",
        slug: "expert-functions-pipes",
        title: "Functions, Modules, Pipes",
        summary: "Chaining functions with |>",
        teaching_markdown: "The pipe operator is how Elixir achieves readability.",
        starter_code: "\" hello \"\n|> String.trim()",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-functional-foundations",
        slug: "expert-control-flow",
        title: "Control Flow & with",
        summary: "Handling happy paths gracefully.",
        teaching_markdown: "The `with` statement avoids nested cases.",
        starter_code: "with {:ok, val} <- {:ok, 1} do\n  val\nend",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-functional-foundations",
        slug: "expert-enum-stream",
        title: "Enumeration and Streams",
        summary: "Eager vs Lazy evaluation.",
        teaching_markdown: "Enum for eager, Stream for infinite or large sets.",
        starter_code: "1..10\n|> Enum.map(&(&1 * 2))",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-tooling-abstractions",
        slug: "expert-mix-hex",
        title: "Mix, Hex, Project Structure",
        summary: "Creating and managing projects.",
        teaching_markdown: "Mix is your build tool, package manager, and task runner.",
        starter_code: "defmodule MyApp do\nend",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-tooling-abstractions",
        slug: "expert-protocols",
        title: "Protocols and Behaviours",
        summary: "Polymorphism in Elixir.",
        teaching_markdown: "Protocols for data types, Behaviours for module contracts.",
        starter_code: "defprotocol Blank do\n  def blank?(data)\nend",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-tooling-abstractions",
        slug: "expert-tooling",
        title: "Typespecs, Dialyzer, ExUnit",
        summary: "Tooling for robust code.",
        teaching_markdown: "Catch bugs before runtime and test quickly.",
        starter_code: "@spec add(integer(), integer()) :: integer()\ndef add(a, b), do: a + b",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-concurrency-otp",
        slug: "expert-processes",
        title: "Basic Processes and Messages",
        summary: "spawn, send, receive.",
        teaching_markdown: "The raw primitives of BEAM.",
        starter_code: "pid = spawn(fn ->\n  receive do\n    msg -> msg\n  end\nend)",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-concurrency-otp",
        slug: "expert-tasks-agents",
        title: "Tasks and Agents",
        summary: "Simple async and state.",
        teaching_markdown: "Tasks for async work, Agents for simple state.",
        starter_code: "Task.async(fn -> 1 + 1 end)",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-concurrency-otp",
        slug: "expert-genserver",
        title: "GenServer",
        summary: "The workhorse of Elixir.",
        teaching_markdown: "90% of your concurrent code will be here.",
        starter_code: "defmodule MyServer do\n  use GenServer\nend",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-concurrency-otp",
        slug: "expert-supervisors",
        title: "Supervisors and Fault Tolerance",
        summary: "Let it crash.",
        teaching_markdown: "Supervision trees and restart strategies.",
        starter_code: "Supervisor.start_link(children, strategy: :one_for_one)",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-concurrency-otp",
        slug: "expert-registries",
        title: "Registries and Dynamic Supervisors",
        summary: "Dynamic naming and starting.",
        teaching_markdown: "Essential for scalable systems like chat apps.",
        starter_code: "Registry.start_link(keys: :unique, name: MyRegistry)",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-ecosystem",
        slug: "expert-ecto-schemas",
        title: "Ecto: Schemas and Changesets",
        summary: "Data mapping and validation.",
        teaching_markdown: "Changesets handle validation without touching a database.",
        starter_code: "defmodule User do\n  use Ecto.Schema\nend",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-ecosystem",
        slug: "expert-ecto-queries",
        title: "Ecto: Queries, Repos, Multi",
        summary: "Transactions and composition.",
        teaching_markdown: "Ecto.Multi handles complex database transactions.",
        starter_code: "Ecto.Multi.new()",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-ecosystem",
        slug: "expert-phoenix-req",
        title: "Phoenix Request Lifecycle",
        summary: "Endpoint, Router, Controllers, Plugs.",
        teaching_markdown: "Understanding Plug is mandatory.",
        starter_code: "defmodule MyPlug do\n  import Plug.Conn\nend",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-ecosystem",
        slug: "expert-phoenix-liveview",
        title: "Phoenix LiveView and PubSub",
        summary: "Real-time UI over WebSockets.",
        teaching_markdown: "Modern way to build web apps without heavy JS.",
        starter_code: "defmodule MyLive do\n  use Phoenix.LiveView\nend",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-level",
        slug: "expert-macros",
        title: "Metaprogramming",
        summary: "Macros and AST.",
        teaching_markdown: "quote, unquote, and defmacro.",
        starter_code: "defmacro say_hi do\n  quote do\n    IO.puts(\"Hi\")\n  end\nend",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-level",
        slug: "expert-distributed",
        title: "Distributed Elixir",
        summary: "Nodes, globals, clustering.",
        teaching_markdown: "Connecting nodes directly without external queues.",
        starter_code: "Node.list()",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-level",
        slug: "expert-telemetry",
        title: "Telemetry and Profiling",
        summary: "Introspection of live nodes.",
        teaching_markdown: "Don't guess why an app is slow, trace it.",
        starter_code: ":telemetry.attach(...)",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      ),
      lesson(
        track_slug: "expert-level",
        slug: "expert-nifs",
        title: "Interoperability",
        summary: "NIFs and Ports.",
        teaching_markdown: "Offload heavy work safely.",
        starter_code: "use Rustler",
        checks: [],
        hints: [],
        rewards: reward(10, 1, 1, 1, 1, 1),
        codex_entries_unlocked: []
      )
    ]
  end

  defp lesson(attrs) do
    defaults = %{
      track_slug: "foundations-old",
      tier: :standard,
      solution_template: nil,
      prerequisites: [],
      estimated_minutes: 6,
      quick_terms: []
    }

    struct!(Lesson, Map.merge(defaults, Map.new(attrs)))
  end

  defp reward(xp, coffee, energy, focus, mood, caffeine) do
    %Reward{
      xp: xp,
      coffee: coffee,
      energy: energy,
      focus: focus,
      mood: mood,
      caffeine: caffeine
    }
  end

  defp returns(expected), do: returns(expected, [])

  defp returns(expected, opts) do
    build_check(
      :returns,
      "Returns #{inspect(expected)}",
      %{expected: expected},
      "The final expression should evaluate to #{inspect(expected)}.",
      opts
    )
  end

  defp binds(variable, expected), do: binds(variable, expected, [])

  defp binds(variable, expected, opts) do
    build_check(
      :binds,
      "Binds #{variable} to #{inspect(expected)}",
      %{variable: variable, expected: expected},
      "`#{variable}` should be bound to #{inspect(expected)}.",
      opts
    )
  end

  defp module_function(module, function_name, args, expected),
    do: module_function(module, function_name, args, expected, [])

  defp module_function(module, function_name, args, expected, opts) do
    build_check(
      :module_function,
      "#{inspect(module)}.#{function_name}/#{length(args)} returns #{inspect(expected)}",
      %{
        module: module,
        function: function_name,
        args: args,
        expected: expected
      },
      "#{inspect(module)}.#{function_name}/#{length(args)} should return #{inspect(expected)}.",
      opts
    )
  end

  defp source_contains(snippet), do: source_contains(snippet, [])

  defp source_contains(snippet, opts) do
    build_check(
      :source_contains,
      "Uses source snippet #{inspect(snippet)}",
      %{snippet: snippet},
      "The solution should include #{inspect(snippet)} somewhere in the source.",
      opts
    )
  end

  defp ast_contains(snippet), do: ast_contains(snippet, [])

  defp ast_contains(snippet, opts) do
    build_check(
      :ast_contains,
      "Uses #{snippet}",
      %{snippet: snippet},
      "The solution should use #{snippet}.",
      opts
    )
  end

  defp build_check(type, default_label, config, default_failure_message, opts) do
    label = Keyword.get(opts, :label, default_label)

    %Check{
      type: type,
      label: label,
      config: config,
      failure_message: Keyword.get(opts, :failure_message, default_failure_message),
      checkpoint: Keyword.get(opts, :checkpoint, label)
    }
  end

  defp quick_term(term, explanation), do: %{term: term, explanation: explanation}

  defp codex(key, title, summary) do
    codex(
      key,
      title,
      summary,
      codex_example(key),
      codex_watch_out(key),
      codex_when_to_use(title)
    )
  end

  defp codex(key, title, summary, example, watch_out, when_to_use) do
    %{
      key: key,
      title: title,
      summary: summary,
      example: example,
      watch_out: watch_out,
      when_to_use: when_to_use,
      body: summary
    }
  end

  defp codex_example("strings"), do: ~S|"coffee"|
  defp codex_example("numbers"), do: "6 * 6 + 6"
  defp codex_example("tuples"), do: ~S|{"latte", 2}|
  defp codex_example("variable-binding"), do: ~S|name = "Nova"|
  defp codex_example("lists"), do: "[:filter | supplies]"
  defp codex_example("maps"), do: "%{shots: 2, milk: :oat}"
  defp codex_example("keyword-lists"), do: "[size: :large, iced: true]"
  defp codex_example("atoms"), do: ":awake"
  defp codex_example("comparison-operators"), do: "cups > shots and shots == 2"
  defp codex_example("if"), do: ~S|if ready?, do: "brew", else: "wait"|
  defp codex_example("pattern-matching"), do: ~S|{:ok, drink} = {:ok, "latte"}|
  defp codex_example("anonymous-functions"), do: "double = fn n -> n * 2 end"
  defp codex_example("modules"), do: ~S|def hello(name), do: "hello, #{name}"|
  defp codex_example("string-interpolation"), do: ~S|"hello, #{name}"|
  defp codex_example("defp"), do: "defp normalize(drink), do: String.upcase(drink)"
  defp codex_example("multiple-clauses"), do: "def status(:idle), do: \"waiting\""
  defp codex_example("case"), do: "case result do ... end"
  defp codex_example("cond"), do: "cond do ... end"
  defp codex_example("guards"), do: "def label(cups) when cups > 0, do: \"hot\""

  defp codex_example("pipe-operator"), do: ~S'"latte" |> String.upcase()'
  defp codex_example("enum-map"), do: "Enum.map([1, 2, 3], &(&1 * 2))"
  defp codex_example("capture-operator"), do: "&(&1 * 2)"
  defp codex_example("enum-reduce"), do: "Enum.reduce([1, 2, 3], 0, &+/2)"
  defp codex_example("enum-find"), do: "Enum.find(values, fn n -> rem(n, 2) == 0 end)"

  defp codex_example("enum-all"),
    do: "Enum.all?(drinks, fn drink -> String.length(drink) >= 5 end)"

  defp codex_example("enum-count-sort"), do: "Enum.sort([4, 1, 3, 2])"
  defp codex_example("string-trim-split"), do: "String.trim(input) |> String.split(\",\")"
  defp codex_example("string-predicates"), do: "String.contains?(\"latte-oat\", \"-\")"
  defp codex_example("map-toolkit"), do: "Map.get(order, :shots, 0)"
  defp codex_example("map-update"), do: "%{order | shots: 3}"
  defp codex_example("recursion"), do: "def total([head | tail]), do: head + total(tail)"
  defp codex_example("tagged-tuples"), do: "{:ok, value}"
  defp codex_example("with"), do: "with {:ok, token} <- normalize(input) do ... end"
  defp codex_example("io-inspect"), do: ~S|IO.inspect(total, label: "total")|
  defp codex_example("docs"), do: ~S|@doc "Says hello"|
  defp codex_example("charlists"), do: ~S|~c"ok"|
  defp codex_example("pin-operator"), do: "{^drink, milk} = {\"latte\", :oat}"
  defp codex_example("default-arguments"), do: ~S|def greet(name \\ "world")|
  defp codex_example("imports"), do: "import String, only: [upcase: 1]"
  defp codex_example("module-directives"), do: "import String, only: [upcase: 1]"
  defp codex_example("use"), do: "use CodiePlayground.Wakeable"
  defp codex_example("structs"), do: "defstruct name: \"Nova\", awake?: false"
  defp codex_example("module-attributes"), do: ~S|@default_drink "latte"|
  defp codex_example("dbg"), do: "dbg(total)"
  defp codex_example("comprehensions"), do: "for n <- 1..4, do: n * 2"
  defp codex_example("streams"), do: "Stream.map(1..3, &(&1 * 2))"
  defp codex_example("try-rescue"), do: "try do ... rescue ArgumentError -> :bad_input end"
  defp codex_example("catch"), do: "try do ... catch :skip -> :caught end"
  defp codex_example("sigils"), do: "~w(latte mocha)"
  defp codex_example("file-path"), do: "Path.extname(\"submission.exs\")"
  defp codex_example("match-guards"), do: "def label(n) when n > 0, do: \"hot\""
  defp codex_example("match-pin"), do: "{^drink, size} = {\"latte\", :large}"
  defp codex_example("private-functions"), do: "defp normalize(drink), do: String.downcase(drink)"
  defp codex_example("enum-filter"), do: "Enum.filter([1, 2, 3], fn n -> rem(n, 2) == 0 end)"
  defp codex_example("enum-search"), do: "Enum.find([3, 7, 2], fn n -> n > 5 end)"
  defp codex_example(_key), do: "# Revisit the unlocked lesson for a focused example."

  defp codex_watch_out("pattern-matching"),
    do: "The left side must match the shape of the right side or the match will fail."

  defp codex_watch_out("if"),
    do: "Only `false` and `nil` are falsy in Elixir. Everything else counts as truthy."

  defp codex_watch_out("lists"),
    do: "Lists are linked lists, so prepending is cheap but random index access is not."

  defp codex_watch_out("maps"),
    do: "Dot access only works for existing atom keys."

  defp codex_watch_out("with"),
    do: "Each `<-` expects a matching shape. A non-matching value jumps to `else`."

  defp codex_watch_out("charlists"),
    do: "A charlist like `~c\"ok\"` is a list, while `\"ok\"` is a binary string."

  defp codex_watch_out("map-update"),
    do: "Map update syntax expects the key to already exist."

  defp codex_watch_out(_key),
    do:
      "Focus on the value being returned, not just the syntax shape, and prefer the simplest correct form first."

  defp codex_when_to_use(title),
    do:
      "Use #{title} when it makes the code clearer, more explicit, or easier to transform than a hardcoded one-off expression."

  defp placeholder_track(slug, title, summary) do
    %Track{
      slug: slug,
      title: title,
      summary: summary,
      theme: "Locked Sector",
      estimated_lesson_count: 0,
      teaser: "Planned for the next major content expansion."
    }
  end
end
