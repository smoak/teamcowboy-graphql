defmodule TeamCowboyGraphQL.Data.Normalization.TeamCowboy.RsvpStatuses do
  @server_rsvp_status_map %{
    "yes" => :yes,
    "maybe" => :maybe,
    "available" => :available,
    "no" => :no,
    "noresponse" => :none
  }

  def normalize_from_event(event) do
    server_rsvp_status =
      event
      |> Map.get("rsvpInstances")
      |> List.first()
      |> Map.get("rsvpDetails")
      |> Map.get("status")

    @server_rsvp_status_map |> Map.get(server_rsvp_status)
  end
end
