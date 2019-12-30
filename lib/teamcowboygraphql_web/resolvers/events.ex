defmodule TeamCowboyGraphQLWeb.Resolvers.Events do
  alias TeamCowboyGraphQL.Data.TeamCowboy.Event
  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Events
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Client.Team
  alias TeamCowboyGraphQL.Repos.Events, as: EventsRepo

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

  def get(_parent, args, %{context: %{client: client}}) do
    EventsRepo.find(client, args)
  end

  @spec save_rsvp(any, map(), map()) :: {:ok, Event.t()} | {:error, binary}
  def save_rsvp(_parent, args, %{context: %{client: client}}) do
    case EventsRepo.update(client, args) do
      {:ok, _} -> EventsRepo.find(client, args)
      {:error, msg} -> {:error, msg}
      _ -> {:error, "Unknown error"}
    end
  end
end
