defmodule KaiauluWeb.RoomControllerTest do
  use KaiauluWeb.ConnCase

  alias Kaiaulu.Live

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:room) do
    {:ok, room} = Live.create_room(@create_attrs)
    room
  end

  describe "new room" do
    test "renders form", %{conn: conn} do
      conn = get(conn, room_path(conn, :new))
      assert html_response(conn, 200) =~ "New Room"
    end
  end

  describe "create room" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, room_path(conn, :create), room: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == room_path(conn, :show, id)

      conn = get(conn, room_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Room"
    end
  end

  defp create_room(_) do
    room = fixture(:room)
    {:ok, room: room}
  end
end
