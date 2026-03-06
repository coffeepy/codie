defmodule CodieWeb.PageController do
  use CodieWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
