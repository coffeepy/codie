defmodule Codie.Curriculum do
  @moduledoc """
  Static curriculum registry, lookup helpers, and progression-aware lesson navigation.
  """

  alias Codie.Curriculum.{Catalog, Lesson}
  alias Codie.Progress
  alias Codie.Progress.Profile

  def list_tracks, do: Catalog.tracks()

  def get_track!(slug) do
    Enum.find(list_tracks(), &(&1.slug == slug)) ||
      raise ArgumentError, "unknown track #{inspect(slug)}"
  end

  def list_lessons(track_slug \\ nil)

  def list_lessons(nil), do: Catalog.lessons()
  def list_lessons(track_slug), do: Enum.filter(Catalog.lessons(), &(&1.track_slug == track_slug))

  def get_lesson!(slug) do
    Enum.find(list_lessons(), &(&1.slug == slug)) ||
      raise ArgumentError, "unknown lesson #{inspect(slug)}"
  end

  def all_codex_entries do
    list_lessons()
    |> Enum.flat_map(& &1.codex_entries_unlocked)
    |> Enum.uniq_by(& &1.key)
  end

  def archived_track_slugs, do: ["foundations-old"]

  def progression_lessons do
    list_lessons()
    |> Enum.reject(&(&1.track_slug in archived_track_slugs()))
  end

  def next_lesson_for_profile(%Profile{} = profile) do
    passed = Progress.passed_lesson_slugs(profile)

    Enum.find(progression_lessons(), fn lesson ->
      lesson.slug not in passed and lesson_available?(passed, lesson.slug)
    end) || List.last(progression_lessons())
  end

  def linked_next_lessons(source, lesson_slug, opts \\ [])

  def linked_next_lessons(%Profile{} = profile, lesson_slug, opts) when is_binary(lesson_slug) do
    profile
    |> Progress.passed_lesson_slugs()
    |> linked_next_lessons(lesson_slug, opts)
  end

  def linked_next_lessons(passed_slugs, lesson_slug, opts)
      when is_list(passed_slugs) and is_binary(lesson_slug) do
    include_passed? = Keyword.get(opts, :include_passed, false)

    progression_lessons()
    |> Enum.filter(fn candidate ->
      lesson_slug in candidate.prerequisites and
        (include_passed? || candidate.slug not in passed_slugs) and
        lesson_available?(passed_slugs, candidate.slug)
    end)
  end

  def next_lesson_in_track(lesson_slug) when is_binary(lesson_slug) do
    lesson = get_lesson!(lesson_slug)
    lessons = list_lessons(lesson.track_slug)
    index = Enum.find_index(lessons, &(&1.slug == lesson.slug))

    case index do
      nil -> nil
      i -> Enum.at(lessons, i + 1)
    end
  end

  def lesson_available?(%Profile{} = profile, lesson_slug) do
    profile
    |> Progress.passed_lesson_slugs()
    |> lesson_available?(lesson_slug)
  end

  def lesson_available?(passed_slugs, lesson_slug) when is_list(passed_slugs) do
    lesson = get_lesson!(lesson_slug)
    Enum.all?(lesson.prerequisites, &(&1 in passed_slugs))
  end

  def previous_lesson_slug(%Lesson{prerequisites: [prerequisite | _]}), do: prerequisite
  def previous_lesson_slug(_lesson), do: nil

  def track_index(track_slug) do
    list_tracks()
    |> Enum.find_index(&(&1.slug == track_slug))
    |> Kernel.||(0)
  end
end
