use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :teamcowboygraphql, TeamCowboyGraphQLWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :teamcowboygraphql, :teamcowboy_config,
  private_api_key: "413abdc2120adb9a06eb13cf76483aa25d18dc5a",
  public_api_key: "foo"
