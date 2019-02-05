use Mix.Config

port = String.to_integer(System.get_env("PORT"))
app_name = System.get_env("APP_NAME")

config :teamcowboygraphql, TeamCowboyGraphQLWeb.Endpoint,
  http: [:inet6, port: port],
  url: [host: System.get_env("HOSTNAME"), port: port],
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# https: [
#   :inet6,
#   port: System.get_env("PORT") || 443,
#   cipher_suite: :strong,
#   keyfile: System.get_env("HTTP_SSL_KEY_PATH"),
#   certfile: System.get_env("HTTP_SSL_CERT_PATH")
# ],
# force_ssl: [rewrite_on: [:x_forwarded_proto], hsts: true],
