defmodule TeamCowboyGraphQLWeb.Resolvers.Events do
  alias TeamCowboyGraphQL.Client.Events

  def list(_parent, %{team_id: team_id}, %{context: %{user_token: user_token}}) do
    {:ok, Events.list(user_token, team_id)}
  end

  def list(_parent, _args, %{context: %{}}) do
    {:error, "No authorization header"}
  end
end
