defmodule CodieWeb.CodexLiveTest do
  use CodieWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Codie.Curriculum
  alias Codie.Progress

  test "renders rich codex sections for unlocked entries", %{conn: conn} do
    profile = Progress.get_or_create_profile()
    lesson = Curriculum.get_lesson!("wake_codie")

    {:ok, _updated_profile, _reward_result} =
      Progress.mark_lesson_passed(profile, lesson, ~S|"coffee"|)

    {:ok, _view, html} = live(conn, ~p"/codex")

    assert html =~ "Strings"
    assert html =~ "Example"
    assert html =~ "Watch Out"
    assert html =~ "When To Use It"
  end
end
