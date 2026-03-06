defmodule CodieWeb.LessonLiveTest do
  use CodieWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Codie.Curriculum
  alias Codie.Progress

  test "autosave keeps the editor version stable and reset starter bumps it", %{conn: conn} do
    lesson = Curriculum.get_lesson!("wake_codie")

    {:ok, view, html} = live(conn, ~p"/lesson/#{lesson.slug}")

    assert html =~ ~s(data-editor-version="1")

    render_hook(view, "save_draft", %{code: ~S|"espresso"|})

    profile = Progress.get_or_create_profile()

    assert Progress.draft_for(profile, lesson.slug, "") == ~S|"espresso"|
    assert render(view) =~ ~s(data-editor-version="1")

    render_click(view, "reset_starter")

    assert render(view) =~ ~s(data-editor-version="2")
    assert Progress.draft_for(profile, lesson.slug, "") == lesson.starter_code
  end

  test "submitting a valid lesson shows progress while the runner works and then passes", %{
    conn: conn
  } do
    lesson = Curriculum.get_lesson!("wake_codie")

    {:ok, view, _html} = live(conn, ~p"/lesson/#{lesson.slug}")

    html =
      view
      |> form(".editor-shell", %{submission: %{code: ~S|"coffee"|}})
      |> render_submit()

    assert html =~ "Checking..."
    assert eventually(fn -> render(view) =~ "Lesson cleared" end)
    assert render(view) =~ "Every lesson check passed."
    assert has_element?(view, "#lesson-run-feedback")
    assert has_element?(view, "#lesson-result-card")
    assert has_element?(view, "#lesson-reward-banner")
    assert has_element?(view, "#lesson-result-card .runner-meta-card", "Passed")
    assert has_element?(view, "#lesson-reward-banner .reward-stat-grid")
    assert has_element?(view, "#lesson-reward-banner .reward-stat-card", "XP")
    assert has_element?(view, "#lesson-reward-banner .reward-actions .secondary-cta")
  end

  test "passing a lesson shows linked next lessons when available", %{conn: conn} do
    lesson = Curriculum.get_lesson!("string-shelf")

    {:ok, view, _html} = live(conn, ~p"/lesson/#{lesson.slug}")

    view
    |> form(".editor-shell", %{submission: %{code: ~S|"coffee"|}})
    |> render_submit()

    assert eventually(fn ->
             html = render(view)

             html =~ "Lesson cleared" and html =~ "Linked Next Lessons" and
               html =~ "Next: String Blend"
           end)
  end

  test "review mode keeps next navigation on linked lessons even when child is already passed", %{
    conn: conn
  } do
    profile = Progress.get_or_create_profile()
    string_shelf = Curriculum.get_lesson!("string-shelf")
    string_blend = Curriculum.get_lesson!("string-blend")

    {:ok, _} = Progress.save_draft(profile, string_shelf.slug, ~S|"coffee"|)

    {:ok, _} =
      Progress.record_submission(profile, string_shelf, %{
        result: "pass",
        compile_output: "Compiled cleanly.",
        test_output: "Every lesson check passed.",
        runtime_ms: 5,
        status: "completed",
        code: ~S|"coffee"|
      })

    {:ok, profile, _} = Progress.mark_lesson_passed(profile, string_shelf, ~S|"coffee"|)

    {:ok, _} = Progress.save_draft(profile, string_blend.slug, ~S|base = "coffee"
base <> " beans"|)

    {:ok, _} =
      Progress.record_submission(profile, string_blend, %{
        result: "pass",
        compile_output: "Compiled cleanly.",
        test_output: "Every lesson check passed.",
        runtime_ms: 5,
        status: "completed",
        code: ~S|base = "coffee"
base <> " beans"|
      })

    {:ok, _profile, _} =
      Progress.mark_lesson_passed(profile, string_blend, ~S|base = "coffee"
base <> " beans"|)

    {:ok, view, _html} = live(conn, ~p"/lesson/#{string_shelf.slug}")

    view
    |> form(".editor-shell", %{submission: %{code: ~S|"coffee"|}})
    |> render_submit()

    assert eventually(fn ->
             html = render(view)
             html =~ "Linked Next Lessons" and html =~ "Next: String Blend"
           end)
  end

  test "renders quick terms for lessons that define beginner context", %{conn: conn} do
    lesson = Curriculum.get_lesson!("list-supplies")

    {:ok, _view, html} = live(conn, ~p"/lesson/#{lesson.slug}")

    assert html =~ "Quick Terms"
    assert html =~ "List"
    assert html =~ "Linked list"
  end

  defp eventually(fun, attempts \\ 20)

  defp eventually(fun, attempts) when attempts > 0 do
    if fun.() do
      true
    else
      Process.sleep(25)
      eventually(fun, attempts - 1)
    end
  end

  defp eventually(_fun, 0), do: false
end
