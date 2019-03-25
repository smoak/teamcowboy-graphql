# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :teamcowboygraphql,
  namespace: TeamCowboyGraphQL

# Configures the endpoint
config :teamcowboygraphql, TeamCowboyGraphQLWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bJFHdHuy3T1DqehLMmJSdIKrXsZxJr9yAn291iGTbBOQvOs6mfEROcTsBD8cxZp0",
  render_errors: [view: TeamCowboyGraphQLWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: TeamCowboyGraphQL.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :teamcowboygraphql, :teamcowboy_config,
  host: "http://api.teamcowboy.com/v1/",
  public_api_key: System.get_env("TC_PUBLIC_API_KEY"),
  private_api_key: System.get_env("TC_PRIVATE_API_KEY")

config :cors_plug,
  origin: ["https://team-cowgirl.surge.sh"],
  max_age: 86400,
  methods: ["GET", "POST"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
