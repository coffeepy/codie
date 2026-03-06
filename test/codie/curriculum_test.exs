defmodule Codie.CurriculumTest do
  use ExUnit.Case, async: true

  alias Codie.Curriculum

  test "track titles reflect the rebuilt foundations plan" do
    tracks = Curriculum.list_tracks()

    assert Enum.any?(tracks, &(&1.slug == "foundations" and &1.title == "Foundations: Data Types and Immutability"))

    assert Enum.any?(tracks, &(&1.slug == "foundations-pattern-matching" and &1.title == "Foundations: Pattern Matching"))

    assert Enum.any?(tracks, &(&1.slug == "foundations-complex-data-structures" and &1.title == "Foundations: Complex Data Structures"))

    assert Enum.any?(tracks, &(&1.slug == "foundations-functions-modules-pipe" and &1.title == "Foundations: Functions, Modules, and the Pipe Operator"))

    assert Enum.any?(tracks, &(&1.slug == "foundations-control-flow-with" and &1.title == "Foundations: Control Flow and the with Statement"))

    assert Enum.any?(tracks, &(&1.slug == "foundations-enum-and-streams" and &1.title == "Foundations: Enumeration and Streams"))
  end

  test "foundations lessons are ordered by prerequisites" do
    lessons = Curriculum.list_lessons("foundations")

    assert hd(lessons).slug == "string-shelf"
    assert List.last(lessons).slug == "value-tools-roundup"

    slugs = Enum.map(lessons, & &1.slug)

    Enum.each(lessons, fn lesson ->
      Enum.each(lesson.prerequisites, fn prerequisite ->
        assert Enum.find_index(slugs, &(&1 == prerequisite)) <
                 Enum.find_index(slugs, &(&1 == lesson.slug))
      end)
    end)
  end

  test "pattern matching lessons are ordered by prerequisites" do
    lessons = Curriculum.list_lessons("foundations-pattern-matching")

    assert hd(lessons).slug == "match-assertion"
    assert List.last(lessons).slug == "pattern-roundup"
    assert Enum.at(lessons, 0).prerequisites == ["value-tools-roundup"]

    slugs = Enum.map(lessons, & &1.slug)

    Enum.each(lessons, fn lesson ->
      Enum.each(lesson.prerequisites, fn prerequisite ->
        prerequisite_index = Enum.find_index(slugs, &(&1 == prerequisite))
        lesson_index = Enum.find_index(slugs, &(&1 == lesson.slug))

        if prerequisite_index do
          assert prerequisite_index < lesson_index
        end
      end)
    end)
  end

  test "complex data structure lessons are ordered by prerequisites" do
    lessons = Curriculum.list_lessons("foundations-complex-data-structures")

    assert hd(lessons).slug == "data-shapes-lists-tuples"
    assert List.last(lessons).slug == "complex-data-structures-roundup"
    assert Enum.at(lessons, 0).prerequisites == ["pattern-roundup"]

    slugs = Enum.map(lessons, & &1.slug)

    Enum.each(lessons, fn lesson ->
      Enum.each(lesson.prerequisites, fn prerequisite ->
        prerequisite_index = Enum.find_index(slugs, &(&1 == prerequisite))
        lesson_index = Enum.find_index(slugs, &(&1 == lesson.slug))

        if prerequisite_index do
          assert prerequisite_index < lesson_index
        end
      end)
    end)
  end

  test "functions/modules/pipe lessons are ordered by prerequisites" do
    lessons = Curriculum.list_lessons("foundations-functions-modules-pipe")

    assert hd(lessons).slug == "fn-values-lab"
    assert List.last(lessons).slug == "functions-modules-pipe-roundup"
    assert Enum.at(lessons, 0).prerequisites == ["complex-data-structures-roundup"]

    slugs = Enum.map(lessons, & &1.slug)

    Enum.each(lessons, fn lesson ->
      Enum.each(lesson.prerequisites, fn prerequisite ->
        prerequisite_index = Enum.find_index(slugs, &(&1 == prerequisite))
        lesson_index = Enum.find_index(slugs, &(&1 == lesson.slug))

        if prerequisite_index do
          assert prerequisite_index < lesson_index
        end
      end)
    end)
  end

  test "control-flow/with lessons are ordered by prerequisites" do
    lessons = Curriculum.list_lessons("foundations-control-flow-with")

    assert hd(lessons).slug == "control-flow-if-unless"
    assert List.last(lessons).slug == "control-flow-with-roundup"
    assert Enum.at(lessons, 0).prerequisites == ["functions-modules-pipe-roundup"]

    slugs = Enum.map(lessons, & &1.slug)

    Enum.each(lessons, fn lesson ->
      Enum.each(lesson.prerequisites, fn prerequisite ->
        prerequisite_index = Enum.find_index(slugs, &(&1 == prerequisite))
        lesson_index = Enum.find_index(slugs, &(&1 == lesson.slug))

        if prerequisite_index do
          assert prerequisite_index < lesson_index
        end
      end)
    end)
  end

  test "enum/stream lessons are ordered by prerequisites" do
    lessons = Curriculum.list_lessons("foundations-enum-and-streams")

    assert hd(lessons).slug == "enum-map-lab"
    assert List.last(lessons).slug == "enumeration-streams-roundup"
    assert Enum.at(lessons, 0).prerequisites == ["control-flow-with-roundup"]

    slugs = Enum.map(lessons, & &1.slug)

    Enum.each(lessons, fn lesson ->
      Enum.each(lesson.prerequisites, fn prerequisite ->
        prerequisite_index = Enum.find_index(slugs, &(&1 == prerequisite))
        lesson_index = Enum.find_index(slugs, &(&1 == lesson.slug))

        if prerequisite_index do
          assert prerequisite_index < lesson_index
        end
      end)
    end)
  end

  test "foundations keeps the practical daily-use lessons and moves low-value lessons out" do
    slugs = Curriculum.list_lessons("foundations") |> Enum.map(& &1.slug)

    assert "string-shelf" in slugs
    assert "string-cleanup" in slugs
    assert "immutability-shelf" in slugs
    assert "tuple-unpack" in slugs
    assert "list-front" in slugs
    assert "map-read-new" in slugs
    assert "keyword-shelf-new" in slugs
    assert "data-roundup" in slugs
    assert "truth-check-new" in slugs
    assert "if-door" in slugs
    assert "case-signal-new" in slugs
    assert "cond-lane-new" in slugs
    assert "decision-roundup" in slugs
    assert "function-shelf-new" in slugs
    assert "function-choices-new" in slugs
    assert "struct-shelf-new" in slugs
    assert "charlist-lane-new" in slugs
    assert "range-shelf-new" in slugs
    assert "value-tools-roundup" in slugs

    refute "stream-flow" in slugs
    refute "catch-spill" in slugs
    refute "script-path" in slugs
    refute "wake_codie" in slugs
  end

  test "legacy foundations track still keeps the old lessons for reference" do
    legacy_slugs = Curriculum.list_lessons("foundations-old") |> Enum.map(& &1.slug)

    assert "wake_codie" in legacy_slugs
    assert "brew-report-boss" in legacy_slugs
  end

  test "pattern matching track is seeded with the core beginner pattern lessons" do
    slugs = Curriculum.list_lessons("foundations-pattern-matching") |> Enum.map(& &1.slug)

    assert "match-assertion" in slugs
    assert "match-tuples-track" in slugs
    assert "match-lists-track" in slugs
    assert "match-case-track" in slugs
    assert "match-function-heads-track" in slugs
    assert "pattern-roundup" in slugs
  end

  test "complex data structures track is seeded with map/keyword/struct decisions" do
    slugs =
      Curriculum.list_lessons("foundations-complex-data-structures")
      |> Enum.map(& &1.slug)

    assert "data-shapes-lists-tuples" in slugs
    assert "data-shapes-maps-keywords" in slugs
    assert "data-shapes-structs-maps" in slugs
    assert "complex-data-structures-roundup" in slugs
  end

  test "functions/modules/pipe track is seeded with the core flow lessons" do
    slugs = Curriculum.list_lessons("foundations-functions-modules-pipe") |> Enum.map(& &1.slug)

    assert "fn-values-lab" in slugs
    assert "module-functions-lab" in slugs
    assert "arity-lab" in slugs
    assert "pipe-flow-lab" in slugs
    assert "functions-modules-pipe-roundup" in slugs
  end

  test "control-flow/with track is seeded with the core control-flow lessons" do
    slugs = Curriculum.list_lessons("foundations-control-flow-with") |> Enum.map(& &1.slug)

    assert "control-flow-if-unless" in slugs
    assert "control-flow-case" in slugs
    assert "control-flow-cond" in slugs
    assert "control-flow-with" in slugs
    assert "control-flow-with-roundup" in slugs
  end

  test "linked next lessons follow prerequisite links instead of global ordering" do
    linked =
      Curriculum.linked_next_lessons(["control-flow-with-roundup"], "control-flow-with-roundup")
      |> Enum.map(& &1.slug)

    assert linked == ["enum-map-lab"]
  end

  test "linked next lessons can include already-passed children for review navigation" do
    linked =
      Curriculum.linked_next_lessons(
        ["control-flow-with-roundup", "enum-map-lab"],
        "control-flow-with-roundup",
        include_passed: true
      )
      |> Enum.map(& &1.slug)

    assert linked == ["enum-map-lab"]
  end

  test "next_lesson_in_track returns the immediate track-local next lesson" do
    assert Curriculum.next_lesson_in_track("control-flow-if-unless").slug == "control-flow-case"
    assert Curriculum.next_lesson_in_track("control-flow-with-roundup") == nil
    assert Curriculum.next_lesson_in_track("enumeration-streams-roundup") == nil
  end

  test "enum/stream track is seeded with eager and lazy fundamentals" do
    slugs = Curriculum.list_lessons("foundations-enum-and-streams") |> Enum.map(& &1.slug)

    assert "enum-map-lab" in slugs
    assert "enum-reduce-lab" in slugs
    assert "enum-eager-lab" in slugs
    assert "stream-lazy-lab" in slugs
    assert "enumeration-streams-roundup" in slugs
  end

  test "codex entries are unique" do
    entries = Curriculum.all_codex_entries()

    assert length(entries) == entries |> Enum.map(& &1.key) |> Enum.uniq() |> length()
  end

  test "codex entries expose richer reference fields" do
    entry = Curriculum.all_codex_entries() |> hd()

    assert is_binary(entry.summary)
    assert String.trim(entry.summary) != ""
    assert is_binary(entry.example)
    assert String.trim(entry.example) != ""
    assert is_binary(entry.watch_out)
    assert String.trim(entry.watch_out) != ""
    assert is_binary(entry.when_to_use)
    assert String.trim(entry.when_to_use) != ""
  end

  test "early core-type lessons include real-world common cases in the teaching copy" do
    for slug <- [
          "string-shelf",
          "string-blend",
          "string-greeting",
          "string-cleanup",
          "string-pieces",
          "string-signals",
          "immutability-shelf",
          "number-shelf",
          "number-check",
          "tuple-pair",
          "tuple-unpack",
          "list-shelf-new",
          "list-front",
          "list-unpack",
          "map-shelf-new",
          "map-read-new",
          "map-refresh-new",
          "keyword-shelf-new",
          "state-signals-new",
          "data-roundup",
          "truth-check-new",
          "if-door",
          "tagged-signal-new",
          "case-signal-new",
          "cond-lane-new",
          "decision-roundup",
          "function-shelf-new",
          "function-choices-new",
          "struct-shelf-new",
          "charlist-lane-new",
          "range-shelf-new",
          "value-tools-roundup",
          "data-shapes-lists-tuples",
          "data-shapes-maps-keywords",
          "data-shapes-structs-maps",
          "complex-data-structures-roundup",
          "fn-values-lab",
          "module-functions-lab",
          "arity-lab",
          "pipe-flow-lab",
          "functions-modules-pipe-roundup",
          "control-flow-if-unless",
          "control-flow-case",
          "control-flow-cond",
          "control-flow-with",
          "control-flow-with-roundup",
          "enum-map-lab",
          "enum-reduce-lab",
          "enum-eager-lab",
          "stream-lazy-lab",
          "enumeration-streams-roundup"
        ] do
      lesson = Curriculum.get_lesson!(slug)
      assert lesson.teaching_markdown =~ "Common cases:"
    end
  end

  test "core-type lessons expose quick terms for in-page help" do
    for slug <- [
          "string-shelf",
          "immutability-shelf",
          "number-shelf",
          "tuple-pair",
          "list-shelf-new",
          "list-front",
          "map-shelf-new",
          "keyword-shelf-new",
          "state-signals-new",
          "data-roundup",
          "truth-check-new",
          "if-door",
          "case-signal-new",
          "cond-lane-new",
          "decision-roundup",
          "function-shelf-new",
          "function-choices-new",
          "struct-shelf-new",
          "charlist-lane-new",
          "range-shelf-new",
          "value-tools-roundup",
          "data-shapes-lists-tuples",
          "data-shapes-maps-keywords",
          "data-shapes-structs-maps",
          "complex-data-structures-roundup",
          "fn-values-lab",
          "module-functions-lab",
          "arity-lab",
          "pipe-flow-lab",
          "functions-modules-pipe-roundup",
          "control-flow-if-unless",
          "control-flow-case",
          "control-flow-cond",
          "control-flow-with",
          "control-flow-with-roundup",
          "enum-map-lab",
          "enum-reduce-lab",
          "enum-eager-lab",
          "stream-lazy-lab",
          "enumeration-streams-roundup"
        ] do
      lesson = Curriculum.get_lesson!(slug)
      assert length(lesson.quick_terms) > 0
    end
  end
end
