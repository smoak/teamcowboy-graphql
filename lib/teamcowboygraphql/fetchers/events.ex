defmodule TeamCowboyGraphQL.Fetchers.Events do
  alias TeamCowboyGraphQL.Client.Event, as: EventsClient

  def event_get(client, args) do
    EventsClient.get_event(client, args)
  end
end