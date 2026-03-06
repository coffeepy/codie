defmodule CodieWeb.DashboardLiveTest do
  use CodieWeb.ConnCase

  import Phoenix.LiveViewTest

  test "dashboard renders codie stats and next lesson", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/dashboard")

    assert html =~ "Learn Elixir like it&#39;s a character-building RPG."
    assert html =~ "String Shelf"
    assert html =~ "Campaign Progress"
    assert html =~ "Foundations: Pattern Matching"
  end
end
