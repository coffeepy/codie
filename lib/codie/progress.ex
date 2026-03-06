defmodule Codie.Progress do
  @moduledoc """
  Persistence and progression orchestration for the single local player profile.
  """

  import Ecto.Query

  alias Codie.Curriculum
  alias Codie.Game
  alias Codie.Game.RewardResult

  alias Codie.Progress.{
    DailyStateEvent,
    LessonProgress,
    Profile,
    SubmissionRun,
    TrackProgress,
    Unlock
  }

  alias Codie.Repo

  def get_or_create_profile do
    case Repo.one(from profile in Profile, order_by: [asc: profile.inserted_at], limit: 1) do
      nil ->
        {:ok, profile} =
          %Profile{}
          |> Profile.changeset(%{})
          |> Repo.insert()

        ensure_track_progress_rows(profile)
        profile

      profile ->
        ensure_track_progress_rows(profile)
        profile
    end
  end

  def dashboard_snapshot(%Profile{} = profile) do
    profile = apply_daily_decay_if_needed(profile)

    %{
      profile: profile,
      next_lesson: Curriculum.next_lesson_for_profile(profile),
      track_progress: list_track_progress(profile),
      recent_runs: recent_runs(profile),
      unlocked_entries: unlocked_codex_entries(profile)
    }
  end

  def save_draft(%Profile{} = profile, lesson_slug, code) when is_binary(code) do
    lesson = Curriculum.get_lesson!(lesson_slug)

    record =
      get_lesson_progress_record(profile, lesson_slug) ||
        %LessonProgress{
          profile_id: profile.id,
          lesson_slug: lesson.slug,
          track_slug: lesson.track_slug,
          status: "in_progress",
          attempt_count: 0
        }

    record
    |> LessonProgress.changeset(%{
      profile_id: profile.id,
      lesson_slug: lesson.slug,
      track_slug: lesson.track_slug,
      status: if(record.status == "passed", do: "passed", else: "in_progress"),
      last_submitted_code: code
    })
    |> Repo.insert_or_update()
  end

  def draft_for(%Profile{} = profile, lesson_slug, starter_code) do
    case get_lesson_progress_record(profile, lesson_slug) do
      %LessonProgress{last_submitted_code: code} when is_binary(code) and code != "" -> code
      _ -> starter_code
    end
  end

  def record_submission(%Profile{} = profile, lesson, attrs) do
    %SubmissionRun{}
    |> SubmissionRun.changeset(%{
      profile_id: profile.id,
      lesson_slug: lesson.slug,
      result: attrs.result,
      compile_output: attrs.compile_output,
      test_output: attrs.test_output,
      runtime_ms: attrs.runtime_ms,
      status: attrs.status
    })
    |> Repo.insert()

    record =
      get_lesson_progress_record(profile, lesson.slug) ||
        %LessonProgress{
          profile_id: profile.id,
          lesson_slug: lesson.slug,
          track_slug: lesson.track_slug,
          status: "in_progress",
          attempt_count: 0
        }

    best_result = best_result(record.best_result, attrs.result)

    record
    |> LessonProgress.changeset(%{
      profile_id: profile.id,
      lesson_slug: lesson.slug,
      track_slug: lesson.track_slug,
      status: if(record.status == "passed", do: "passed", else: "in_progress"),
      attempt_count: record.attempt_count + 1,
      best_result: best_result,
      last_submitted_code: attrs.code,
      last_attempted_at: DateTime.utc_now()
    })
    |> Repo.insert_or_update()
  end

  def mark_lesson_passed(%Profile{} = profile, lesson, code) do
    record =
      get_lesson_progress_record(profile, lesson.slug) ||
        %LessonProgress{
          profile_id: profile.id,
          lesson_slug: lesson.slug,
          track_slug: lesson.track_slug,
          status: "in_progress",
          attempt_count: 0
        }

    already_passed? = record.status == "passed"

    if already_passed? do
      zero_rewards = %RewardResult{
        xp_gained: 0,
        coffee_gained: 0,
        stat_changes: %{energy: 0, focus: 0, mood: 0, caffeine: 0},
        unlocks: []
      }

      {:ok, profile, zero_rewards}
    else
      reward_result = Game.grant_rewards(profile, lesson)
      today = Date.utc_today()
      simulated_passed = [lesson.slug | passed_lesson_slugs(profile)]

      linked_next =
        Curriculum.linked_next_lessons(simulated_passed, lesson.slug)
        |> List.first()

      fallback_next =
        Curriculum.progression_lessons()
        |> Enum.find(fn candidate ->
          candidate.slug not in simulated_passed and
            Curriculum.lesson_available?(simulated_passed, candidate.slug)
        end)

      next_lesson_slug =
        case linked_next || fallback_next do
          nil -> lesson.slug
          next_lesson -> next_lesson.slug
        end

      streak_days =
        case profile.last_practiced_on do
          ^today ->
            profile.streak_days

          nil ->
            1

          last_day ->
            if Date.diff(today, last_day) == 1, do: profile.streak_days + 1, else: 1
        end

      profile_attrs =
        profile
        |> Game.apply_stat_delta(reward_result.stat_changes, %{
          xp: reward_result.xp_gained,
          coffee_beans: reward_result.coffee_gained
        })
        |> Map.merge(%{
          current_track_slug: lesson.track_slug,
          current_lesson_slug: next_lesson_slug,
          streak_days: streak_days,
          last_practiced_on: today,
          last_decay_applied_on: today
        })

      {:ok, updated_profile} =
        profile
        |> Profile.changeset(profile_attrs)
        |> Repo.update()

      {:ok, _lesson_progress} =
        record
        |> LessonProgress.changeset(%{
          profile_id: profile.id,
          lesson_slug: lesson.slug,
          track_slug: lesson.track_slug,
          status: "passed",
          attempt_count: max(record.attempt_count || 0, 1),
          best_result: "pass",
          last_submitted_code: code,
          last_attempted_at: DateTime.utc_now(),
          first_passed_at: record.first_passed_at || DateTime.utc_now()
        })
        |> Repo.insert_or_update()

      maybe_unlock_lesson_entries(updated_profile, lesson)
      log_event(updated_profile, "practice_done", %{lesson_slug: lesson.slug})
      refresh_track_progress!(updated_profile)

      {:ok, updated_profile, reward_result}
    end
  end

  def apply_daily_decay_if_needed(%Profile{} = profile) do
    today = Date.utc_today()

    cond do
      profile.last_decay_applied_on == today ->
        profile

      true ->
        missed_days = missed_days(profile.last_practiced_on, today)

        if missed_days <= 0 do
          {:ok, updated_profile} =
            profile
            |> Profile.changeset(%{last_decay_applied_on: today})
            |> Repo.update()

          updated_profile
        else
          stat_changes = Game.apply_daily_decay(profile, missed_days)

          updated_profile =
            profile
            |> Profile.changeset(
              Game.apply_stat_delta(profile, stat_changes)
              |> Map.merge(%{
                streak_days: 0,
                last_decay_applied_on: today
              })
            )
            |> Repo.update!()

          log_event(updated_profile, "decay_applied", %{missed_days: missed_days})
          updated_profile
        end
    end
  end

  def list_track_progress(%Profile{} = profile) do
    refresh_track_progress!(profile)

    TrackProgress
    |> where([track_progress], track_progress.profile_id == ^profile.id)
    |> Repo.all()
    |> Enum.sort_by(&Curriculum.track_index(&1.track_slug))
  end

  def list_lesson_progress(%Profile{} = profile) do
    LessonProgress
    |> where([lesson_progress], lesson_progress.profile_id == ^profile.id)
    |> Repo.all()
  end

  def passed_lesson_slugs(%Profile{} = profile) do
    LessonProgress
    |> where([lesson_progress], lesson_progress.profile_id == ^profile.id)
    |> where([lesson_progress], lesson_progress.status == "passed")
    |> select([lesson_progress], lesson_progress.lesson_slug)
    |> Repo.all()
  end

  def unlocked_codex_entries(%Profile{} = profile) do
    keys =
      Unlock
      |> where([unlock], unlock.profile_id == ^profile.id and unlock.kind == "codex_entry")
      |> select([unlock], unlock.key)
      |> Repo.all()
      |> MapSet.new()

    Curriculum.all_codex_entries()
    |> Enum.filter(&MapSet.member?(keys, &1.key))
  end

  def spend_focus(%Profile{} = profile, amount) do
    new_focus = max(profile.focus - amount, 0)

    profile
    |> Profile.changeset(%{focus: new_focus})
    |> Repo.update()
  end

  def reset_all_progress(%Profile{} = profile) do
    Repo.transaction(fn ->
      profile_id = profile.id

      SubmissionRun
      |> where([submission_run], submission_run.profile_id == ^profile_id)
      |> Repo.delete_all()

      LessonProgress
      |> where([lesson_progress], lesson_progress.profile_id == ^profile_id)
      |> Repo.delete_all()

      Unlock
      |> where([unlock], unlock.profile_id == ^profile_id)
      |> Repo.delete_all()

      DailyStateEvent
      |> where([daily_state_event], daily_state_event.profile_id == ^profile_id)
      |> Repo.delete_all()

      TrackProgress
      |> where([track_progress], track_progress.profile_id == ^profile_id)
      |> Repo.delete_all()

      reset_profile =
        profile
        |> Profile.changeset(default_profile_attrs())
        |> Repo.update!()

      ensure_track_progress_rows(reset_profile)
      reset_profile
    end)
  end

  defp ensure_track_progress_rows(%Profile{} = profile) do
    if Repo.aggregate(
         from(track_progress in TrackProgress, where: track_progress.profile_id == ^profile.id),
         :count
       ) ==
         0 do
      now = DateTime.utc_now() |> DateTime.truncate(:second)

      rows =
        Curriculum.list_tracks()
        |> Enum.with_index()
        |> Enum.map(fn {track, index} ->
          %{
            profile_id: profile.id,
            track_slug: track.slug,
            status: if(index == 0, do: "available", else: "locked"),
            completion_percent: 0.0,
            inserted_at: now,
            updated_at: now
          }
        end)

      Repo.insert_all(TrackProgress, rows)
    end

    refresh_track_progress!(profile)
  end

  defp refresh_track_progress!(%Profile{} = profile) do
    passed = MapSet.new(passed_lesson_slugs(profile))
    completed_tracks = MapSet.new(completed_track_slugs(passed))

    existing_rows =
      TrackProgress
      |> where([track_progress], track_progress.profile_id == ^profile.id)
      |> Repo.all()
      |> Map.new(&{&1.track_slug, &1})

    tracks = Curriculum.list_tracks()

    tracks
    |> Enum.with_index()
    |> Enum.each(fn {track, index} ->
      lessons = Curriculum.list_lessons(track.slug)
      total = max(length(lessons), 1)
      passed_count = Enum.count(lessons, &MapSet.member?(passed, &1.slug))
      completion_percent = Float.round(passed_count / total * 100, 1)

      available? =
        index == 0 or
          MapSet.member?(completed_tracks, Enum.at(tracks, index - 1).slug)

      status =
        cond do
          lessons != [] and passed_count == length(lessons) -> "completed"
          available? -> "available"
          true -> "locked"
        end

      track_progress =
        Map.get(existing_rows, track.slug) ||
          %TrackProgress{profile_id: profile.id, track_slug: track.slug}

      track_progress
      |> TrackProgress.changeset(%{
        profile_id: profile.id,
        track_slug: track.slug,
        status: status,
        completion_percent: completion_percent
      })
      |> Repo.insert_or_update!()
    end)
  end

  defp completed_track_slugs(passed) do
    Enum.flat_map(Curriculum.list_tracks(), fn track ->
      lessons = Curriculum.list_lessons(track.slug)

      if lessons != [] and Enum.all?(lessons, &MapSet.member?(passed, &1.slug)) do
        [track.slug]
      else
        []
      end
    end)
  end

  defp maybe_unlock_lesson_entries(profile, lesson) do
    Enum.each(lesson.codex_entries_unlocked, fn entry ->
      %Unlock{}
      |> Unlock.changeset(%{
        profile_id: profile.id,
        kind: "codex_entry",
        key: entry.key,
        granted_at: DateTime.utc_now() |> DateTime.truncate(:second)
      })
      |> Repo.insert(
        on_conflict: :nothing,
        conflict_target: [:profile_id, :kind, :key]
      )
    end)
  end

  defp log_event(profile, event_type, payload) do
    %DailyStateEvent{}
    |> DailyStateEvent.changeset(%{
      profile_id: profile.id,
      event_type: event_type,
      payload: payload
    })
    |> Repo.insert()
  end

  defp recent_runs(%Profile{} = profile) do
    SubmissionRun
    |> where([submission_run], submission_run.profile_id == ^profile.id)
    |> order_by([submission_run], desc: submission_run.inserted_at)
    |> limit(5)
    |> Repo.all()
  end

  defp get_lesson_progress_record(profile, lesson_slug) do
    Repo.get_by(LessonProgress, profile_id: profile.id, lesson_slug: lesson_slug)
  end

  defp best_result(nil, latest), do: latest
  defp best_result("pass", _latest), do: "pass"
  defp best_result(_existing, "pass"), do: "pass"
  defp best_result(existing, _latest), do: existing

  defp default_profile_attrs do
    %{
      name: "Player One",
      avatar_seed: "bean",
      current_track_slug: "foundations",
      current_lesson_slug: "string-shelf",
      xp: 0,
      level: 1,
      coffee_beans: 0,
      energy: 72,
      focus: 68,
      mood: 64,
      caffeine: 0,
      streak_days: 0,
      last_practiced_on: nil,
      last_decay_applied_on: nil,
      timezone: "Etc/UTC"
    }
  end

  defp missed_days(nil, _today), do: 0

  defp missed_days(last_practiced_on, today) do
    today
    |> Date.diff(last_practiced_on)
    |> Kernel.-(1)
    |> max(0)
  end
end
