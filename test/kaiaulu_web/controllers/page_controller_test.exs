defmodule KaiauluWeb.PageControllerTest do
  use KaiauluWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "New Room"
  end
end
