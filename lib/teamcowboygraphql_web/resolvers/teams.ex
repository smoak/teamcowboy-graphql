defmodule TeamCowboyGraphQLWeb.Resolvers.Teams do
  alias TeamCowboyGraphQL.Data.TeamCowboy.Team
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Teams
  alias TeamCowboyGraphQL.Client.User

  @spec list(any, map(), map()) :: {:ok, list(Team.t())} | {:error, binary}
  def list(_parent, _args, %{context: %{client: %Client{auth: nil}}}) do
    {:error, "No authorization header"}
  end

  def list(_parent, %{dashboard_only: dashboard_only}, %{context: %{client: client}}) do
    teams = User.get_teams(client, %{dashboard_only: dashboard_only})

    normalized_teams = Teams.normalize_user_teams(teams)

    {:ok, normalized_teams}
  end
end
