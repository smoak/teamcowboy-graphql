use Mix.Config

config :teamcowboygraphql, TeamCowboyGraphQLWeb.Endpoint, server: true

config :cors_plug,
  origin: ["https://leaguewrangler.com"],
  max_age: 86_400,
  methods: ["GET", "POST"]

config :logger,
  level: :info,
  handle_sasl_reports: true,
  handle_otp_reports: true

config :phoenix, :logger, false

config :absinthe, Absinthe.Logger, filter_variables: ["token", "password", "secret"]
