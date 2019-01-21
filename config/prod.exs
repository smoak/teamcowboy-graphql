use Mix.Config

config :teamcowboygraphql, TeamCowboyGraphQLWeb.Endpoint, server: true

config :logger,
  level: :info,
  handle_sasl_reports: true,
  handle_otp_reports: true
