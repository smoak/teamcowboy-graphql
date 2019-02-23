defmodule TeamCowboyGraphQLWeb.Context do
  @behaviour Plug

  alias TeamCowboyGraphQL.Client

  import Plug.Conn

  def init(opts), do: opts

  def build_context(conn) do
    with ["Bearer " <> auth_token] <- get_req_header(conn, "authorization") do
      %{client: build_client(auth_token)}
    else
      _ -> %{client: build_client(nil)}
    end
  end

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_client(auth_token) do
    public_api_key =
      Application.fetch_env!(:teamcowboygraphql, :teamcowboy_config)
      |> Keyword.fetch!(:public_api_key)

    Client.new(%{api_key: public_api_key, access_token: auth_token})
  end
end
