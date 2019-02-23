defmodule TeamCowboyGraphQLWeb.Resolvers.Events do
  alias TeamCowboyGraphQL.Data.TeamCowboy.Event
  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Events
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Client.Team

  @spec list(any, map(), map()) :: {:ok, list(Event.t())} | {:error, binary}
  def list(_parent, _args, %{context: %{client: %Client{auth: nil}}}) do
    {:error, "No authorization header"}
  end

  def list(_parent, %{team_id: team_id}, %{context: %{client: client}}) do
    events = Team.get_events(client, %{team_id: team_id})

    normalized_events = Events.normalize_team_events(events)

    {:ok, normalized_events}
  end
end
