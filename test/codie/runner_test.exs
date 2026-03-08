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
    assert result.returned_value == ~S|"coffee"|
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
    assert result.returned_value == nil
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
    assert result.returned_value == "41"
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
        base <> " -> " <> updated
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

  test "passes the new foundations inspect lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "inspect-sip-new",
        code: """
        drink = "latte"
        IO.inspect(drink, label: "drink")
        drink <> " ready"
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

        walk = struct(CodiePlayground.Walk, label: "step 1", span: 1..3)
        IO.inspect(walk, label: "walk")
        {walk.label, walk.span.last}
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
        drink_result = {:ok, "latte"}
        cups_result = {:ok, 2}

        with {:ok, drink} <- drink_result,
             {:ok, cups} <- cups_result do
          {:ok, drink <> ":" <> Integer.to_string(cups)}
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

  test "passes the working with data filter lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "filter-tray",
        code: """
        drinks = ["latte", "tea", "mocha"]
        Enum.filter(drinks, fn drink -> String.length(drink) >= 5 end)
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data find lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "find-cup",
        code: """
        drinks = ["tea", "latte", "mocha"]
        Enum.find(drinks, fn drink -> String.contains?(drink, "tt") end)
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data count lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "count-batch",
        code: """
        large_cups = Enum.filter([1, 2, 3, 4, 5], fn cups -> cups >= 3 end)
        Enum.count(large_cups)
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data all-ready lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "all-ready",
        code: """
        orders = [%{label: "latte", ready: true}, %{label: "mocha", ready: true}]
        Enum.all?(orders, fn order -> order.ready end)
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data sort lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "sort-board",
        code: """
        numbers = [4, 1, 3, 2]
        orders = [%{label: "mocha"}, %{label: "latte"}, %{label: "americano"}]
        sorted_numbers = Enum.sort(numbers)
        sorted = Enum.sort_by(orders, & &1.label)
        Enum.map(sorted, & &1.label)
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data collection roundup lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "collection-workflows-roundup",
        code: """
        defmodule CodiePlayground.Collections do
          def summary(items) do
            filtered = Enum.filter(items, fn item -> item.name != "" and item.ready end)
            sorted = Enum.sort_by(filtered, & &1.name)
            count = Enum.count(sorted)
            valid? = Enum.all?(sorted, fn item -> item.ready end)
            %{count: count, valid?: valid?, items: sorted}
          end
        end

        CodiePlayground.Collections.summary([
          %{name: "mocha", ready: true},
          %{name: "", ready: true},
          %{name: "latte", ready: true},
          %{name: "tea", ready: false}
        ])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data refresh order lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "refresh-order",
        code: """
        order = %{drink: "latte", status: :draft}
        %{order | status: :ready}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data update tally lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "update-tally",
        code: """
        tally = %{served: 2, queued: 1}
        Map.update(tally, :served, 1, fn served -> served + 1 end)
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data normalize ticket lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "normalize-ticket",
        code: """
        cleaned = String.trim(" latte , 2 ")
        [drink_text, cups_text] = String.split(cleaned, ",")
        drink = String.trim(drink_text)
        {cups, ""} = Integer.parse(String.trim(cups_text))
        %{drink: drink, cups: cups}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data result gate lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "result-gate",
        code: """
        defmodule CodiePlayground.ResultGate do
          def check(raw) do
            cleaned = String.trim(raw)

            if cleaned == "" do
              {:error, :blank}
            else
              {:ok, cleaned}
            end
          end
        end

        CodiePlayground.ResultGate.check("   ")
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data shape guide lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "shape-guide",
        code: """
        general_shape = :map
        options_shape = :keyword
        user_shape = :struct
        {general_shape, options_shape, user_shape}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data shapes and results roundup lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "shapes-results-roundup",
        code: """
        defmodule CodiePlayground.Intake do
          def normalize(raw) do
            cleaned = String.trim(raw)

            case String.split(cleaned, ",") do
              [drink_text, cups_text] ->
                drink = String.trim(drink_text)

                case Integer.parse(String.trim(cups_text)) do
                  {cups, ""} when drink != "" ->
                    ticket = %{drink: drink, cups: cups, status: :draft}
                    {:ok, %{ticket | status: :ready}}

                  _ -> {:error, :invalid}
                end

              _ ->
                {:error, :invalid}
            end
          end
        end

        CodiePlayground.Intake.normalize(" latte , 2 ")
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data summary module lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "summary-module",
        code: """
        defmodule CodiePlayground.OrderSummary do
          def summary(orders) do
            items =
              orders
              |> Enum.filter(fn order -> order.ready end)
              |> Enum.map(fn order -> String.trim(order.drink) end)
              |> Enum.reject(fn drink -> drink == "" end)
              |> Enum.sort()

            %{count: Enum.count(items), items: items, valid?: true}
          end
        end

        CodiePlayground.OrderSummary.summary([
          %{drink: " mocha ", ready: true},
          %{drink: "tea", ready: false},
          %{drink: "latte", ready: true},
          %{drink: "", ready: true}
        ])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data helper step lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "helper-step",
        code: """
        defmodule CodiePlayground.OrderSummary do
          def summary(orders) do
            items =
              orders
              |> Enum.filter(fn order -> order.ready end)
              |> Enum.map(fn order -> clean_drink(order.drink) end)
              |> Enum.reject(fn drink -> drink == "" end)
              |> Enum.sort()

            %{count: Enum.count(items), items: items, valid?: true}
          end

          defp clean_drink(drink), do: String.trim(drink)
        end

        CodiePlayground.OrderSummary.summary([
          %{drink: " mocha ", ready: true},
          %{drink: "tea", ready: false},
          %{drink: "latte", ready: true},
          %{drink: "", ready: true}
        ])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data pipe line lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "pipe-line",
        code: """
        defmodule CodiePlayground.PipeLine do
          def labels(raw) do
            raw
            |> Enum.map(&String.trim/1)
            |> Enum.reject(&(&1 == ""))
            |> Enum.map(&String.upcase/1)
            |> Enum.sort()
          end
        end

        CodiePlayground.PipeLine.labels([" mocha ", " ", "latte "])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data tagged path lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "tagged-path",
        code: """
        defmodule CodiePlayground.TaggedPath do
          def summary(raw) do
            case normalize_items(raw) do
              {:ok, items} ->
                case require_batch(items) do
                  {:ok, batch} ->
                    {:ok, %{count: Enum.count(batch), items: batch, valid?: true}}

                  {:error, reason} ->
                    {:error, reason}
                end

              {:error, reason} ->
                {:error, reason}
            end
          end

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
        end

        CodiePlayground.TaggedPath.summary([" mocha ", " ", "latte "])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data with lane lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "with-lane",
        code: """
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

          def summary(raw) do
            with {:ok, items} <- normalize_items(raw),
                 {:ok, items} <- require_batch(items) do
              {:ok, %{count: Enum.count(items), items: items, valid?: true}}
            else
              {:error, reason} -> {:error, reason}
            end
          end
        end

        CodiePlayground.WithLane.summary([" mocha ", " ", "latte "])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the working with data workflow report roundup lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "workflow-report-roundup",
        code: """
        defmodule CodiePlayground.WorkflowReport do
          def summary(raw) do
            with {:ok, items} <- normalize_orders(raw) do
              {:ok, %{count: Enum.count(items), items: items, valid?: true}}
            else
              {:error, :invalid} -> {:error, :invalid}
            end
          end

          defp normalize_orders(raw) do
            items =
              raw
              |> Enum.filter(fn order -> order.ready end)
              |> Enum.map(fn order -> String.trim(order.drink) end)
              |> Enum.reject(&(&1 == ""))
              |> Enum.sort()

            if items == [] do
              {:error, :invalid}
            else
              {:ok, items}
            end
          end
        end

        CodiePlayground.WorkflowReport.summary([
          %{drink: " mocha ", ready: true},
          %{drink: "", ready: true},
          %{drink: "latte", ready: true},
          %{drink: "tea", ready: false}
        ])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow project map lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "project-map",
        code: """
        repo_map = %{project_file: "mix.exs", app_dir: "lib", test_dir: "test"}
        repo_map
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow run the suite lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "run-the-suite",
        code: """
        suite_command = "mix test"
        {:full_suite, suite_command}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow target one failure lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "target-one-failure",
        code: """
        failing_file = "test/codie/runner_test.exs"
        targeted_command = "mix test " <> failing_file
        targeted_command
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow compile first lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "compile-first",
        code: """
        next_step = {:compile_error, "mix compile"}
        next_step
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow ask mix for help lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "ask-mix-for-help",
        code: """
        help_command = "mix help test"
        {:need_task_help, help_command}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow first day in the repo boss lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "first-day-in-the-repo",
        code: """
        defmodule CodiePlayground.FirstDay do
          def plan(failing_file) do
            %{
              project_file: "mix.exs",
              app_dir: "lib",
              test_dir: "test",
              suite_command: "mix test",
              targeted_command: "mix test " <> failing_file,
              compile_command: "mix compile",
              help_command: "mix help test"
            }
          end
        end

        CodiePlayground.FirstDay.plan("test/codie/runner_test.exs")
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow read the assertion lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "read-the-assertion",
        code: """
        expected = ["LATTE", "MOCHA"]
        actual = ["", "LATTE", "MOCHA"]
        clue = :blank_label

        %{expected: expected, actual: actual, clue: clue}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow write the missing test lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "write-the-missing-test",
        code: """
        test_name = "filters blank labels"
        new_case = %{input: [" mocha ", " ", "latte "], expected: ["LATTE", "MOCHA"]}

        {test_name, new_case}
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow debug with purpose lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "debug-with-purpose",
        code: """
        defmodule CodiePlayground.DebugLabel do
          def labels(raw) do
            cleaned =
              raw
              |> Enum.map(&String.trim/1)
              |> Enum.reject(&(&1 == ""))
              |> IO.inspect(label: "cleaned")

            cleaned
            |> Enum.map(&String.upcase/1)
            |> Enum.sort()
          end
        end

        CodiePlayground.DebugLabel.labels([" mocha ", " ", "latte "])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow document the module lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "document-the-module",
        code: """
        defmodule CodiePlayground.LabelDocs do
          @moduledoc "Builds cleaned labels for a small report."

          def labels(raw) do
            raw
            |> Enum.map(&String.trim/1)
            |> Enum.reject(&(&1 == ""))
            |> Enum.map(&String.upcase/1)
            |> Enum.sort()
          end
        end

        CodiePlayground.LabelDocs.labels([" mocha ", " ", "latte "])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow docs that prove it lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "docs-that-prove-it",
        code: """
        defmodule CodiePlayground.ProofDocs do
          @moduledoc "Formats labels for a tiny report."
          @doc "Drops blank labels and returns sorted uppercase labels."
          def labels(raw) do
            raw
            |> Enum.map(&String.trim/1)
            |> Enum.reject(&(&1 == ""))
            |> Enum.map(&String.upcase/1)
            |> Enum.sort()
          end
        end

        CodiePlayground.ProofDocs.labels([" mocha ", " ", "latte "])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow fix explain prove boss lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "fix-explain-prove",
        code: """
        defmodule CodiePlayground.LabelTicket do
          @moduledoc "Handles the blank-label fix for a tiny report."
          @doc "Drops blank labels and returns sorted uppercase labels."
          def labels(raw) do
            raw
            |> Enum.map(&String.trim/1)
            |> Enum.reject(&(&1 == ""))
            |> Enum.map(&String.upcase/1)
            |> Enum.sort()
          end

          def proof do
            %{
              test_name: "filters blank labels",
              input: [" mocha ", " ", "latte "],
              expected: ["LATTE", "MOCHA"]
            }
          end
        end

        %{
          fixed: CodiePlayground.LabelTicket.labels([" mocha ", " ", "latte "]),
          proof: CodiePlayground.LabelTicket.proof()
        }
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow one module one job lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "one-module-one-job",
        code: """
        defmodule CodiePlayground.LabelCleaner do
          def clean(raw) do
            raw
            |> Enum.map(&String.trim/1)
            |> Enum.reject(&(&1 == ""))
            |> Enum.map(&String.upcase/1)
            |> Enum.sort()
          end
        end

        CodiePlayground.LabelCleaner.clean([" mocha ", " ", "latte "])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow extract helper module lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "extract-helper-module",
        code: """
        defmodule CodiePlayground.LabelCleaner do
          def clean(raw) do
            raw
            |> Enum.map(&String.trim/1)
            |> Enum.reject(&(&1 == ""))
            |> Enum.map(&String.upcase/1)
            |> Enum.sort()
          end
        end

        defmodule CodiePlayground.LabelReport do
          def summary(raw) do
            items = CodiePlayground.LabelCleaner.clean(raw)
            %{count: Enum.count(items), items: items, valid?: items != []}
          end
        end

        CodiePlayground.LabelReport.summary([" mocha ", " ", "latte "])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow name the boundary lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "name-the-boundary",
        code: """
        defmodule CodiePlayground.LabelCleaner do
          def clean(raw) do
            raw
            |> Enum.map(&String.trim/1)
            |> Enum.reject(&(&1 == ""))
            |> Enum.map(&String.upcase/1)
            |> Enum.sort()
          end
        end

        defmodule CodiePlayground.LabelSummary do
          def build(items) do
            %{count: Enum.count(items), items: items, valid?: items != []}
          end
        end

        raw = [" mocha ", " ", "latte "]
        items = CodiePlayground.LabelCleaner.clean(raw)

        CodiePlayground.LabelSummary.build(items)
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow wire the files together lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "wire-the-files-together",
        code: """
        defmodule CodiePlayground.LabelCleaner do
          def clean(raw) do
            raw
            |> Enum.map(&String.trim/1)
            |> Enum.reject(&(&1 == ""))
            |> Enum.map(&String.upcase/1)
            |> Enum.sort()
          end
        end

        defmodule CodiePlayground.LabelSummary do
          def build(items) do
            %{count: Enum.count(items), items: items, valid?: items != []}
          end
        end

        defmodule CodiePlayground.LabelFeature do
          alias CodiePlayground.LabelCleaner
          alias CodiePlayground.LabelSummary

          def build(raw) do
            raw
            |> LabelCleaner.clean()
            |> LabelSummary.build()
          end
        end

        CodiePlayground.LabelFeature.build([" mocha ", " ", "latte "])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow refactor without changing behavior lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "refactor-without-changing-behavior",
        code: """
        defmodule CodiePlayground.LabelCleaner do
          def clean(raw) do
            raw
            |> Enum.map(&String.trim/1)
            |> Enum.reject(&(&1 == ""))
            |> Enum.map(&String.upcase/1)
            |> Enum.sort()
          end
        end

        defmodule CodiePlayground.LabelSummary do
          def build(items) do
            %{count: Enum.count(items), items: items, valid?: items != []}
          end
        end

        defmodule CodiePlayground.LabelFeature do
          alias CodiePlayground.LabelCleaner
          alias CodiePlayground.LabelSummary

          def build(raw) do
            raw
            |> LabelCleaner.clean()
            |> LabelSummary.build()
          end
        end

        CodiePlayground.LabelFeature.build([" mocha ", " ", "latte "])
        """,
        profile_id: 1,
        attempt_number: 1
      })

    assert result.status == :pass
  end

  test "passes the real project workflow small feature capstone boss lesson" do
    result =
      Runner.submit(%Submission{
        lesson_slug: "small-feature-capstone",
        code: """
        defmodule CodiePlayground.OrderCleaner do
          def clean(orders) do
            orders
            |> Enum.filter(fn order -> order.ready end)
            |> Enum.map(fn order -> String.trim(order.drink) end)
            |> Enum.reject(&(&1 == ""))
            |> Enum.map(&String.upcase/1)
            |> Enum.sort()
          end
        end

        defmodule CodiePlayground.OrderSummary do
          def build(items) do
            %{count: Enum.count(items), items: items, valid?: items != []}
          end
        end

        defmodule CodiePlayground.SmallFeature do
          alias CodiePlayground.OrderCleaner
          alias CodiePlayground.OrderSummary

          def report(orders) do
            orders
            |> OrderCleaner.clean()
            |> OrderSummary.build()
          end
        end

        CodiePlayground.SmallFeature.report([
          %{drink: " mocha ", ready: true},
          %{drink: "", ready: true},
          %{drink: "latte", ready: true},
          %{drink: "tea", ready: false}
        ])
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
