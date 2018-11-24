defmodule TeamCowboyGraphQLWeb.Resolvers.Teams do
  def list(_parent, %{dashboard_only: dashboard_only}, %{context: %{user_token: user_token}}) do
    # {:ok, teams} = TeamCowboyGraphQL.Client.Teams.list(user_token, dashboard_only) 
    # {:ok, teams}
    {:ok, TeamCowboyGraphQL.Client.Teams.list(user_token, dashboard_only)}
  end

  def list(_parent, _args, %{context: %{}}) do
    {:error, "No authorization header"}
  end
end
