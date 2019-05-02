defmodule TeamCowboyGraphQLWeb.Resolvers.Teams do
  alias TeamCowboyGraphQL.Data.TeamCowboy.Team
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Teams
  alias TeamCowboyGraphQL.Client.User
  alias TeamCowboyGraphQL.Client.Team, as: TeamClient

  @spec list(any, map(), map()) :: {:ok, list(Team.t())} | {:error, binary}
  def list(_parent, _args, %{context: %{client: %Client{auth: nil}}}) do
    {:error, "No authorization header"}
  end

  def list(_parent, args, %{context: %{client: client}}) do
    case User.get_teams(client, args) do
      {:ok, raw_teams} -> {:ok, Teams.normalize_user_teams(raw_teams)}
      {:error, msg} -> {:error, msg}
      _ -> {:error, "Unknown error"}
    end
  end

  @spec by_id(any, %{id: integer}, map) :: {:ok, Team.t()} | {:error, binary}
  def by_id(_, _, %{context: %{client: %Client{auth: nil}}}),
    do: {:error, "No authorization header"}

  def by_id(_parent, %{id: id}, %{context: %{client: client}}) do
    case TeamClient.get(client, %{team_id: id}) do
      {:ok, raw_team} -> {:ok, Teams.normalize_user_team(raw_team)}
      {:error, msg} -> {:error, msg}
      _ -> {:error, "Unknown error"}
    end
  end
end
