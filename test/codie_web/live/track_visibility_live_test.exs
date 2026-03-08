defmodule CodieWeb.TrackVisibilityLiveTest do
  use CodieWeb.ConnCase

  import Phoenix.LiveViewTest

  test "dashboard and profile do not surface the archived foundations track", %{conn: conn} do
    {:ok, _dashboard_view, dashboard_html} = live(conn, ~p"/dashboard")
    {:ok, _profile_view, profile_html} = live(conn, ~p"/profile")

    refute dashboard_html =~ "Foundations (Legacy)"
    refute profile_html =~ "Foundations (Legacy)"
  end

  test "archived foundations track map redirects back to the active foundations track", %{
    conn: conn
  } do
    assert {:error, {:live_redirect, %{to: "/learn/foundations"}}} =
             live(conn, ~p"/learn/foundations-old")
  end
end
