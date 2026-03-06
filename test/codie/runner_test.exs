defmodule Codie.RunnerTest do
  use ExUnit.Case, async: true

  alias Codie.Runner
  alias Codie.Runner.Submission

  test "passes a valid lesson submission" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "string-shelf",
        code: ~S|"coffee"|,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "rejects blocked APIs" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "string-shelf",
        code: ~S|System.cmd("echo", ["nope"])|,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :rejected_submission
  end

  test "fails when a lesson check does not pass" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "number-crunch",
        code: "41",
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :fail_test
  end

  test "returns the targeted failure message for a missed checkpoint" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "number-crunch",
        code: "42",
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :fail_test
    assert result.test_output =~ "use `*`"
  end

  test "source-based checks are whitespace tolerant" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "recursive-refill",
        code: """
        defmodule CodiePlayground.Counter do
          def total([]), do: 0
          def total([ head | tail ]), do: head + total(tail)
        end

        CodiePlayground.Counter.total([1, 2, 3, 4])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the new comparison operators lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "comparison-check",
        code: """
        cups = 3
        shots = 2
        cups > shots and shots == 2
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes a new foundations list prepend lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "list-front",
        code: """
        supplies = [:beans, :water]
        [:filter | supplies]
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the new foundations immutability lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "immutability-shelf",
        code: """
        base = "coffee"
        updated = base <> " beans"
        {base, updated}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the new foundations boss lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "data-roundup",
        code: """
        profile = %{name: "Nova", items: [:beans, :water]}
        {Map.get(profile, :name), length(Map.get(profile, :items))}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the new foundations if lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "if-door",
        code: """
        ready? = true
        if ready?, do: "brew", else: "wait"
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the new foundations case lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "case-signal-new",
        code: ~S"""
        result = {:ok, "latte"}

        case result do
          {:ok, drink} -> drink <> " ready"
          {:error, _reason} -> "stop"
        end
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the new foundations cond lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "cond-lane-new",
        code: """
        cups = 2

        cond do
          cups == 0 -> "empty"
          cups < 3 -> "low"
          true -> "ready"
        end
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the new foundations control-flow boss lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "decision-roundup",
        code: """
        ready? = true
        cups = 2

        result =
          if ready? do
            {:ok, cups}
          else
            {:error, :sleepy}
          end

        case result do
          {:ok, amount} ->
            cond do
              amount == 1 -> "light"
              true -> "strong"
            end

          {:error, _reason} ->
            "stop"
        end
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the new foundations function value lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "function-shelf-new",
        code: """
        formatter = fn drink -> drink <> " ready" end
        formatter.("latte")
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the new foundations function choice lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "function-choices-new",
        code: """
        chooser = fn ready? -> if ready?, do: "brew", else: "wait" end
        chooser.(true)
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the new foundations struct lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "struct-shelf-new",
        code: """
        defmodule CodiePlayground.Barista do
          defstruct name: "Nova", awake?: false
        end

        barista = struct(CodiePlayground.Barista, awake?: true)
        {barista.name, barista.awake?}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the new foundations charlist lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "charlist-lane-new",
        code: """
        text = "latte"
        letters = ~c"latte"
        {text, length(letters)}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the new foundations range lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "range-shelf-new",
        code: """
        steps = 1..3
        {steps.first, steps.last}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the new foundations value tools boss lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "value-tools-roundup",
        code: """
        defmodule CodiePlayground.Walk do
          defstruct label: "", span: 1..1
        end

        label = fn n -> "step " <> Integer.to_string(n) end
        letters = ~c"brew"
        walk = struct(CodiePlayground.Walk, label: label.(1), span: 1..3)
        {walk.label, walk.span.last, length(letters)}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the first pattern matching lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "match-assertion",
        code: """
        status = :ok
        :ok = status
        status
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the tuple pattern matching lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "match-tuples-track",
        code: """
        result = {:ok, "latte"}
        {:ok, drink} = result
        drink
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the list pattern matching lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "match-lists-track",
        code: """
        supplies = [:beans, :water, :filter]
        [first | rest] = supplies
        {first, length(rest)}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the case pattern matching lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "match-case-track",
        code: """
        result = {:error, :empty}

        case result do
          {:ok, drink} -> drink
          {:error, _reason} -> "stop"
        end
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the function head pattern matching lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "match-function-heads-track",
        code: """
        defmodule CodiePlayground.Matcher do
          def label({:ok, drink}), do: drink
          def label({:error, _reason}), do: "stop"
        end

        CodiePlayground.Matcher.label({:ok, "latte"})
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the pattern matching boss lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "pattern-roundup",
        code: ~S"""
        defmodule CodiePlayground.Patterns do
          def summary(status, items) do
            :ok = status
            [first | rest] = items
            status_result = {:ok, first}

            case status_result do
              {:ok, drink} -> "#{drink}:#{length(rest)}"
            end
          end
        end

        CodiePlayground.Patterns.summary(:ok, [:latte, :tea, :water])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the complex data structures list vs tuple lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "data-shapes-lists-tuples",
        code: """
        items = [:latte, :tea, :water]
        pair = {"latte", 2}
        {length(items), tuple_size(pair)}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the complex data structures map vs keyword lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "data-shapes-maps-keywords",
        code: """
        profile = %{name: "Nova", cups: 2}
        opts = [size: :large, iced: false]
        {Map.get(profile, :name), Keyword.get(opts, :size)}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the complex data structures struct vs map lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "data-shapes-structs-maps",
        code: """
        defmodule CodiePlayground.Order do
          defstruct drink: "", cups: 0
        end

        order = struct(CodiePlayground.Order, drink: "latte", cups: 2)
        meta = %{grind: "fine"}
        {order.drink, Map.get(meta, :grind)}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the complex data structures roundup lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "complex-data-structures-roundup",
        code: """
        defmodule CodiePlayground.Basket do
          defstruct first: :none, count: 0
        end

        items = [:latte, :tea, :water]
        pair = {:ok, hd(items)}
        profile = %{name: "Nova"}
        opts = [size: :large]
        {:ok, first} = pair
        basket = struct(CodiePlayground.Basket, first: first, count: length(items))
        {basket.first, basket.count, Map.get(profile, :name), Keyword.get(opts, :size)}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the function values lab lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "fn-values-lab",
        code: """
        shout = fn word -> String.upcase(word) end
        shout.("latte")
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the module functions lab lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "module-functions-lab",
        code: """
        defmodule CodiePlayground.Brew do
          def label(drink), do: "serve " <> drink
        end

        CodiePlayground.Brew.label("latte")
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the arity lab lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "arity-lab",
        code: """
        size = String.length("latte")
        {size, is_integer(size)}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the pipe flow lab lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "pipe-flow-lab",
        code: """
        " latte "
        |> String.trim()
        |> String.upcase()
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the functions/modules/pipe roundup lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "functions-modules-pipe-roundup",
        code: """
        defmodule CodiePlayground.Format do
          @suffix "!"
          def trimmed(text), do: String.trim(text)
          def loud(text), do: String.upcase(text)
          def suffix, do: @suffix
        end

        finish = fn text -> text <> CodiePlayground.Format.suffix() end

        " latte "
        |> CodiePlayground.Format.trimmed()
        |> CodiePlayground.Format.loud()
        |> finish.()
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the control-flow if/unless lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "control-flow-if-unless",
        code: """
        ready? = true
        sleepy? = false

        if_result = if ready?, do: "brew", else: "wait"
        unless_result = unless sleepy?, do: "awake", else: "sleepy"
        {if_result, unless_result}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the control-flow case lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "control-flow-case",
        code: """
        result = {:ok, "latte"}

        case result do
          {:ok, drink} -> drink <> " ready"
          {:error, _reason} -> "stop"
        end
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the control-flow cond lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "control-flow-cond",
        code: """
        cups = 3

        cond do
          cups == 0 -> "empty"
          cups < 4 -> "low"
          true -> "ready"
        end
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the control-flow with lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "control-flow-with",
        code: """
        raw = "4"

        with {count, ""} <- Integer.parse(raw),
             true <- count > 0 do
          {:ok, count}
        else
          _ -> {:error, :invalid}
        end
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the control-flow/with roundup lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "control-flow-with-roundup",
        code: """
        defmodule CodiePlayground.Decisions do
          def summary(raw, sleepy?) do
            with {count, ""} <- Integer.parse(raw),
                 true <- count > 0 do
              status =
                if sleepy? do
                  {:error, :sleepy}
                else
                  {:ok, count}
                end

              case status do
                {:ok, cups} ->
                  cond do
                    cups == 1 -> "light"
                    cups >= 2 -> "strong"
                  end

                {:error, :sleepy} ->
                  unless sleepy?, do: "awake", else: "sleepy"
              end
            else
              _ -> "invalid"
            end
          end
        end

        CodiePlayground.Decisions.summary("2", false)
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the enum map lab lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "enum-map-lab",
        code: """
        drinks = ["latte", "mocha"]
        Enum.map(drinks, &String.upcase/1)
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the enum reduce lab lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "enum-reduce-lab",
        code: """
        cups = [1, 2, 3, 4]
        Enum.reduce(cups, 0, fn n, acc -> acc + n end)
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the enum eager lab lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "enum-eager-lab",
        code: """
        squared = Enum.map(1..3, fn n -> n * n end)
        {is_list(squared), squared}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the stream lazy lab lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "stream-lazy-lab",
        code: """
        1..1_000
        |> Stream.map(fn n -> n * 2 end)
        |> Enum.take(3)
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the enumeration and streams roundup lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "enumeration-streams-roundup",
        code: """
        defmodule CodiePlayground.Enumerate do
          def summary(values) do
            eager_total =
              values
              |> Enum.map(fn n -> n * 2 end)
              |> Enum.reduce(0, fn n, acc -> acc + n end)

            lazy_preview =
              values
              |> Stream.map(fn n -> n * 3 end)
              |> Enum.take(2)

            {eager_total, lazy_preview}
          end
        end

        CodiePlayground.Enumerate.summary([1, 2, 3, 4])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the interpolation lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "friendly-interpolation",
        code: ~S"""
        name = "dev"
        "hello, #{name}"
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the IO.inspect debugging lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "peek-into-pour",
        code: """
        total = 3
        total = IO.inspect(total, label: "total")
        total
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the default argument lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "default-refill",
        code: """
        defmodule CodiePlayground.Defaults do
          def label(name \\\\ "brewer"), do: "hello, " <> name
        end

        CodiePlayground.Defaults.label()
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the struct lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "struct-shelf",
        code: """
        defmodule CodiePlayground.Barista do
          defstruct name: "Nova", awake?: false
        end

        barista = struct(CodiePlayground.Barista, awake?: true)
        {barista.name, barista.awake?}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the module directives lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "module-toolbelt",
        code: """
        require Integer
        alias String, as: BrewString
        import List, only: [duplicate: 2]

        cups = duplicate("latte", 2)
        {BrewString.upcase(hd(cups)), Integer.is_even(length(cups))}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the use lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "use-the-roaster",
        code: """
        defmodule CodiePlayground.Wakeable do
          defmacro __using__(_opts) do
            quote do
              def awake?, do: true
            end
          end
        end

        defmodule CodiePlayground.Helper do
          use CodiePlayground.Wakeable
        end

        CodiePlayground.Helper.awake?()
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the first real pattern matching lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "wake-routine",
        code: """
        result = {:ok, "latte"}
        {:ok, drink} = result
        drink <> " ready"
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the tuple lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "pattern-handshake",
        code: ~S|{"latte", 2}|,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the variable binding lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "tuple-signal",
        code: """
        learner = "Nova"
        cups = 2
        {learner, cups}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the rewritten basic list lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "list-supplies",
        code: """
        supplies = [:beans, :water, :filter]
        supplies
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the list prepend bridge lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "list-lineup",
        code: """
        supplies = [:beans, :water]
        [:filter | supplies]
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the decision checkpoint lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "decision-desk",
        code: """
        defmodule CodiePlayground.Decider do
          def classify({:ok, cups}) when is_integer(cups) and cups > 0 do
            cond do
              cups == 1 -> "light"
              true -> "strong"
            end
          end

          def classify({:error, _reason}), do: "stop"
        end

        CodiePlayground.Decider.classify({:ok, 2})
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the enum search lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "enum-search",
        code: """
        values = [1, 2, 3, 4]
        {Enum.find(values, fn n -> rem(n, 2) == 0 end), Enum.any?(values, fn n -> n > 3 end)}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the enum checklist lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "enum-checklist",
        code: """
        Enum.all?(["latte", "mocha"], fn drink -> String.length(drink) >= 5 end)
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the enum order lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "enum-order",
        code: """
        values = [4, 1, 3, 2]
        {Enum.count(values), Enum.sort(values)}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the string workbench lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "string-workbench",
        code: """
        clean = String.trim(" latte,mocha ")
        String.split(clean, ",")
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the string checks lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "string-checks",
        code: """
        drink = "latte-oat"
        {String.contains?(drink, "-"), String.starts_with?(drink, "latte")}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the map toolkit lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "map-toolkit",
        code: """
        order = %{shots: 2}
        updated = Map.put(order, :milk, :oat)
        shots = Map.get(updated, :shots, 0)
        {shots, updated[:milk]}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the map refresh lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "map-refresh",
        code: """
        order = %{shots: 2, milk: :oat}
        %{order | shots: 3}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the with lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "with-the-flow",
        code: """
        defmodule CodiePlayground.Flow do
          defp normalize("espresso"), do: {:ok, "espresso"}
          defp normalize(_input), do: {:error, :denied}

          defp cups_for("espresso"), do: {:ok, 2}

          def login(input) do
            with {:ok, token} <- normalize(input),
                 {:ok, cups} <- cups_for(token) do
              {:ok, cups}
            else
              {:error, reason} -> {:error, reason}
            end
          end
        end

        CodiePlayground.Flow.login("espresso")
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the stream lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "stream-flow",
        code: """
        1..3
        |> Stream.map(&(&1 * 2))
        |> Enum.to_list()
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the dbg lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "debug-tap",
        code: """
        total = 4
        total = dbg(total)
        total
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the try rescue lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "recovery-mode",
        code: """
        try do
          String.to_integer("oops")
        rescue
          ArgumentError -> :bad_input
        end
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the catch lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "catch-spill",
        code: """
        try do
          throw(:sleepy)
        catch
          :sleepy -> :caught
        end
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the sigil lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "sigil-shelf",
        code: "length(~w(latte mocha))",
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the file path lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "script-path",
        code: """
        cwd = File.cwd!()
        {is_binary(cwd), Path.extname("submission.exs")}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the late checkpoint lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "practice-report",
        code: ~S"""
        defmodule CodiePlayground.Practice do
          def summary(raw \\ " Nova , 4 ") do
            cleaned = String.trim(raw)
            parts = String.split(cleaned, ",")

            with [name, count_text] <- parts,
                 {count, ""} <- Integer.parse(String.trim(count_text)) do
              result = %{name: String.trim(name), cups: count}
              "#{Map.get(result, :name)}:#{Map.get(result, :cups)}"
            else
              _ -> "invalid"
            end
          end
        end

        CodiePlayground.Practice.summary()
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end
end
