defmodule CodieWeb.ProfileLiveTest do
  use CodieWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Codie.Curriculum
  alias Codie.Progress

  test "reset all clears local progress and restores defaults", %{conn: conn} do
    profile = Progress.get_or_create_profile()
    lesson = Curriculum.get_lesson!("wake_codie")

    {:ok, _} = Progress.save_draft(profile, lesson.slug, ~S|"coffee"|)

    {:ok, _} =
      Progress.record_submission(profile, lesson, %{
        result: "pass",
        compile_output: "Compiled cleanly.",
        test_output: "Every lesson check passed.",
        runtime_ms: 5,
        status: "completed",
        code: ~S|"coffee"|
      })

    {:ok, _updated_profile, _reward_result} =
      Progress.mark_lesson_passed(profile, lesson, ~S|"coffee"|)

    {:ok, view, html} = live(conn, ~p"/profile")
    assert html =~ "Reset All Progress"
    assert has_element?(view, ".attempt-row")

    render_click(view, "reset_all_progress")

    reloaded = Progress.get_or_create_profile()

    assert reloaded.xp == 0
    assert reloaded.level == 1
    assert reloaded.streak_days == 0
    assert reloaded.current_lesson_slug == "string-shelf"
    assert Progress.list_lesson_progress(reloaded) == []
    assert Enum.all?(Progress.list_track_progress(reloaded), &(&1.completion_percent == 0.0))

    assert render(view) =~ "All local lesson progress has been reset."
    assert render(view) =~ "No saved attempts yet."
  end
end
