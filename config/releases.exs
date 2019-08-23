import Config

config :teamcowboygraphql, :teamcowboy_config,
  host: "http://api.teamcowboy.com/v1/",
  public_api_key: System.get_env("TC_PUBLIC_API_KEY"),
  private_api_key: System.get_env("TC_PRIVATE_API_KEY")

config :teamcowboygraphql, TeamCowboyGraphQLWeb.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY")

config :teamcowboygraphql, TeamCowboyGraphQLWeb.Endpoint,
  http: [:inet6, port: System.get_env("PORT") || 4000],
  url: [host: "localhost", port: System.get_env("PORT")]
