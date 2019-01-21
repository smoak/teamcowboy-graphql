defmodule TeamCowboyGraphQLWeb.Resolvers.Events do
  def list(_parent, %{team_id: team_id}, %{context: %{user_token: user_token}}) do
    {:ok, TeamCowboyGraphQL.Client.Events.list(user_token, team_id)}
  end

  def list(_parent, _args, %{context: %{}}) do
    {:error, "No authorization header"}
  end
end
