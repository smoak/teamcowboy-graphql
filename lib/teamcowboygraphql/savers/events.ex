defmodule TeamCowboyGraphQL.Savers.Events do
  alias TeamCowboyGraphQL.Client.Event, as: EventsClient

  def event_save(client, args) do
    client |> EventsClient.save_rsvp(args)
  end
end
