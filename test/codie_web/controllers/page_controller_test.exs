defmodule CodieWeb.PageControllerTest do
  use CodieWeb.ConnCase

  test "GET / renders the dashboard shell", %{conn: conn} do
    conn = get(conn, ~p"/")

    assert html_response(conn, 200) =~ "Learn Elixir like it's a character-building RPG."
    assert html_response(conn, 200) =~ "Continue: String Shelf"
  end
end
