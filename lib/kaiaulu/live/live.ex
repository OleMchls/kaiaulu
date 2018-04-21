defmodule Kaiaulu.Live do
  @moduledoc """
  The Live context.
  """

  alias Kaiaulu.Live.Room

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room(attrs \\ %{}) do
    %Room{
      id: Ecto.UUID.generate(),
      name: attrs["name"]
    }
  end
end
