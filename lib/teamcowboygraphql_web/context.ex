defmodule TeamCowboyGraphQLWeb.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def build_context(conn) do
    with ["Bearer " <> auth_token] <- get_req_header(conn, "authorization") do
      %{user_token: auth_token}
    else
      _ -> %{}
    end
  end

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end
end
