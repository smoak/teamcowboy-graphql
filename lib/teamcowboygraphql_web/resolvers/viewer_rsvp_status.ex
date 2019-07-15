defmodule TeamCowboyGraphQLWeb.Resolvers.ViewerRsvpStatus do
  alias TeamCowboyGraphQL.Data.TeamCowboy.Event
  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.RsvpStatuses
  alias TeamCowboyGraphQL.Client.Event, as: EventClient

  @type context :: %{context: %{client: TeamCowboyGraphQL.Client.t()}}

  @spec from_event(Event.t(), map(), context) :: {:ok, atom()} | {:error, binary}
  def from_event(%Event{} = event, _, %{context: %{client: client}}) do
    case EventClient.get_event(client, event) do
      {:ok, raw_event} -> {:ok, RsvpStatuses.normalize_from_event(raw_event)}
      {:error, msg} -> {:error, msg}
      _ -> {:error, "Unknown error"}
    end
  end
end
