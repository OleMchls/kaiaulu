defmodule KaiauluWeb.Router do
  use KaiauluWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", KaiauluWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/rooms", RoomController, only: [:show, :new, :create])
  end

  # Other scopes may use custom stacks.
  # scope "/api", KaiauluWeb do
  #   pipe_through :api
  # end
end
