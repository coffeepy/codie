defmodule CodieWeb.DashboardLiveTest do
  use CodieWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Codie.Progress
  alias Codie.Progress.Profile
  alias Codie.Repo

  test "dashboard renders codie stats and next lesson without the lesson workspace mascot", %{
    conn: conn
  } do
    {:ok, view, html} = live(conn, ~p"/dashboard")

    assert html =~ "Learn Elixir like it&#39;s a character-building RPG."
    assert html =~ "String Shelf"
    assert html =~ "Campaign Progress"
    assert html =~ "Foundations: Pattern Matching"

    refute has_element?(view, "#lesson-workspace-companion")
  end

  test "dashboard still does not render the lesson workspace mascot for low stats", %{conn: conn} do
    profile = Progress.get_or_create_profile()

    profile
    |> Profile.changeset(%{energy: 18, focus: 62, mood: 61, caffeine: 12})
    |> Repo.update!()

    {:ok, view, _html} = live(conn, ~p"/dashboard")

    refute has_element?(view, "#lesson-workspace-companion")
  end
end
