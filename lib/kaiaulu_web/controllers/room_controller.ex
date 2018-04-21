defmodule KaiauluWeb.RoomController do
  use KaiauluWeb, :controller

  alias Kaiaulu.Live
  alias Kaiaulu.Live.Room

  def new(conn, _params) do
    changeset = Room.changeset(%Room{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"room" => room_params}) do
    room = Live.create_room(room_params)

    conn
    |> put_flash(:info, "Room created successfully.")
    |> redirect(to: room_path(conn, :show, room))
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", id: id)
  end
end
