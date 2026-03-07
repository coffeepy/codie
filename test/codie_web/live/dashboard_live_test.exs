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

    assert has_element?(
             view,
             "#dashboard-current-companion[data-codie-state='low_caffeine'][data-codie-tone='violet'][data-codie-emotion='sleepy_yawning'][data-codie-sprite='sleepy_yawning']"
           )

    assert has_element?(view, "#dashboard-current-companion-caption", "Sleepy yawning")

    assert has_element?(
             view,
             "#dashboard-current-companion .codie-avatar-board-sprite[style*='--codie-loop-tired:'][style*='--codie-loop-sleepy-yawning:'][style*='--codie-loop-sad:']"
           )

    refute has_element?(view, "#lesson-workspace-companion")
  end

  test "dashboard still does not render the lesson workspace mascot for low stats", %{conn: conn} do
    profile = Progress.get_or_create_profile()

    profile
    |> Profile.changeset(%{energy: 18, focus: 62, mood: 61, caffeine: 12})
    |> Repo.update!()

    {:ok, view, _html} = live(conn, ~p"/dashboard")

    assert has_element?(
             view,
             "#dashboard-current-companion[data-codie-state='low_energy_or_low_mood'][data-codie-tone='rose'][data-codie-emotion='tired'][data-codie-sprite='tired']"
           )

    assert has_element?(
             view,
             "#dashboard-current-companion .codie-avatar-board-sprite[style*='--codie-loop-deep-tired:'][style*='--codie-loop-deep-sad:'][style*='--codie-loop-deep-yawn:']"
           )

    refute has_element?(view, "#lesson-workspace-companion")
  end

  test "dashboard uses the intermediate fatigue loop before Codie reaches exhausted states", %{
    conn: conn
  } do
    profile = Progress.get_or_create_profile()

    profile
    |> Profile.changeset(%{energy: 40, focus: 70, mood: 72, caffeine: 26})
    |> Repo.update!()

    {:ok, view, _html} = live(conn, ~p"/dashboard")

    assert has_element?(
             view,
             "#dashboard-current-companion[data-codie-state='fatigue_building'][data-codie-tone='violet'][data-codie-emotion='bored'][data-codie-sprite='bored']"
           )

    assert has_element?(
             view,
             "#dashboard-current-companion .codie-avatar-board-sprite[style*='--codie-loop-fatigue-bored:'][style*='--codie-loop-fatigue-sad:'][style*='--codie-loop-fatigue-tired:']"
           )
  end

  test "dashboard shows happy idle caption and loop for a healthy Codie state", %{conn: conn} do
    profile = Progress.get_or_create_profile()

    profile
    |> Profile.changeset(%{energy: 82, focus: 78, mood: 80, caffeine: 76})
    |> Repo.update!()

    {:ok, view, _html} = live(conn, ~p"/dashboard")

    assert has_element?(
             view,
             "#dashboard-current-companion[data-codie-state='default'][data-codie-tone='warm'][data-codie-emotion='slight_smile'][data-codie-sprite='slight_smile']"
           )

    assert has_element?(view, "#dashboard-current-companion-caption", "Slight smile")

    assert has_element?(
             view,
             "#dashboard-current-companion .codie-avatar-board-sprite[style*='--codie-loop-happy-smile:'][style*='--codie-loop-happy-hold:'][style*='--codie-loop-happy-sip:'][style*='--codie-loop-happy-satisfied:']"
           )
  end
end
