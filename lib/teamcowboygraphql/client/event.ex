defmodule TeamCowboyGraphQL.Client.Event do
  import TeamCowboyGraphQL
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Data.Api.RequestParameters
  alias TeamCowboyGraphQL.Data.Api.TeamCowboyResponse

  @spec get_event(Client.t(), %{team_id: String.t(), event_id: String.t()}) ::
          {:ok, Event.t()} | {:error, binary}
  def get_event(client, %{team_id: team_id, event_id: event_id}) do
    params = %{
      teamId: team_id,
      eventId: event_id,
      includeRSVPInfo: true,
      method: "Event_Get"
    }

    request_params = RequestParameters.create(client, "GET", params)

    client |> get([], request_params) |> TeamCowboyResponse.process()
  end
end
