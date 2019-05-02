defmodule TeamCowboyGraphQLWeb.Resolvers.Events do
  alias TeamCowboyGraphQL.Data.TeamCowboy.Event
  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Events
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Client.Team

  @spec list(any, map(), map()) :: {:ok, list(Event.t())} | {:error, binary}
  def list(_parent, _args, %{context: %{client: %Client{auth: nil}}}) do
    {:error, "No authorization header"}
  end

  def list(_parent, args, %{context: %{client: client}}) do
    case Team.get_events(client, args) do
      {:ok, raw_events} -> {:ok, Events.normalize_team_events(raw_events)}
      {:error, msg} -> {:error, msg}
      _ -> {:error, "Unknown error"}
    end
  end
end
