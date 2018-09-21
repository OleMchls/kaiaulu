# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
# config :kaiaulu,
#   ecto_repos: []

# Configures the endpoint
config :kaiaulu, KaiauluWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dQCvXdzpjjvkmDMWjeLO0Aw4UcsYAbCFZW/Sf8ooV2K0HElnP7BpP6C1pv7lE0qh",
  render_errors: [view: KaiauluWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Kaiaulu.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
