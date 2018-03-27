defmodule Kaiaulu.Repo do
  use Ecto.Repo, otp_app: :kaiaulu

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end
end
