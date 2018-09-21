defmodule KaiauluWeb.PageController do
  use KaiauluWeb, :controller

  alias Kaiaulu.Live.Room

  plug :put_layout, "landing.html"

  def index(conn, _params) do
    changeset = Room.changeset(%Room{}, %{})
    render conn, "index.html", changeset: changeset
  end
end
