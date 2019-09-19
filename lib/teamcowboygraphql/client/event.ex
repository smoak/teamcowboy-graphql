defmodule TeamCowboyGraphQL.Client.Event do
  import TeamCowboyGraphQL
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Data.Api.RequestParameters
  alias TeamCowboyGraphQL.Data.Api.TeamCowboyResponse
  alias TeamCowboyGraphQL.Client.Event.SaveRsvpParams

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

  def save_rsvp(client, %{
        team_id: team_id,
        event_id: event_id,
        rsvp_status: status,
        comments: comments
      }) do
    params =
      SaveRsvpParams.new()
      |> SaveRsvpParams.with_team_id(team_id)
      |> SaveRsvpParams.with_event_id(event_id)
      |> SaveRsvpParams.with_status(status)
      |> SaveRsvpParams.with_comments(comments)

    body = client |> RequestParameters.create("POST", params) |> URI.encode_query()

    client |> post(body) |> TeamCowboyResponse.process()
  end

  def save_rsvp(client, %{team_id: team_id, event_id: event_id, rsvp_status: status}) do
    save_rsvp(client, %{team_id: team_id, event_id: event_id, rsvp_status: status, comments: nil})
  end

  defmodule SaveRsvpParams do
    @client_rsvp_status_map %{
      :yes => "yes",
      :maybe => "maybe",
      :available => "available",
      :no => "no",
      :none => "noresponse"
    }

    def new() do
      %{method: "Event_SaveRSVP"}
    end

    def with_team_id(params, team_id) do
      params |> Map.merge(%{teamId: team_id})
    end

    def with_event_id(params, event_id) do
      params |> Map.merge(%{eventId: event_id})
    end

    def with_status(params, status) do
      params |> Map.merge(%{status: @client_rsvp_status_map |> Map.get(status)})
    end

    def with_comments(params, "") do
      params
    end

    def with_comments(params, nil) do
      params
    end

    def with_comments(params, comments) do
      params |> Map.merge(%{comments: comments})
    end
  end
end
