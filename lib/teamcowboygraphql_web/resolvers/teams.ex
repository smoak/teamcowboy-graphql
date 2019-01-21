defmodule TeamCowboyGraphQLWeb.Resolvers.Teams do
  alias TeamCowboyGraphQL.Client.Teams

  def list(_parent, %{dashboard_only: dashboard_only}, %{context: %{user_token: user_token}}) do
    {:ok, Teams.list(user_token, dashboard_only)}
  end

  def list(_parent, _args, %{context: %{}}) do
    {:error, "No authorization header"}
  end
end
