defmodule TeamCowboyGraphQLWeb.Resolvers.Events do
  alias TeamCowboyGraphQL.Data.TeamCowboy.Event
  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Events
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Client.Team
  alias TeamCowboyGraphQL.Client.Event, as: EventClient

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

  @spec get(any, map(), map()) :: {:ok, Event.t()} | {:error, binary}
  def get(_parent, args, %{context: %{client: client}}) do
    fetch_event(client, args)
  end

  @spec save_rsvp(any, map(), map()) :: {:ok, boolean()} | {:error, binary}
  def save_rsvp(_parent, args, %{context: %{client: client}}) do
    case EventClient.save_rsvp(client, args) do
      {:ok, _} -> fetch_event(client, args)
      {:error, msg} -> {:error, msg}
      _ -> {:error, "Unknown error"}
    end
  end

  defp fetch_event(client, args) do
    case EventClient.get_event(client, args) do
      {:ok, raw_event} -> {:ok, Events.normalize_team_event(raw_event)}
      {:error, msg} -> {:error, msg}
      _ -> {:error, "Unknown error"}
    end
  end
end
