defmodule TeamCowboyGraphQL.Client.User do
  import TeamCowboyGraphQL
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Data.Api.RequestParameters
  alias TeamCowboyGraphQL.Data.Api.TeamCowboyResponse

  @spec get_teams(Client.t(), %{dashboard_only: boolean}) :: list(map())
  def get_teams(client \\ %Client{}, %{dashboard_only: dashboard_only}) do
    params = %{
      dashboardTeamsOnly: dashboard_only,
      method: "User_GetTeams"
    }

    body = RequestParameters.create(client, "GET", params)

    client |> get([], body) |> TeamCowboyResponse.process()
  end

  @spec get(Client.t()) :: map()
  def get(client \\ %Client{}) do
    params = %{
      method: "User_Get"
    }

    body = RequestParameters.create(client, "GET", params)

    client |> get([], body) |> TeamCowboyResponse.process()
  end

  @spec get_team_events(Client.t(), %{dashboard_only: boolean, include_rsvp_info: boolean}) ::
          list(map())
  def get_team_events(client \\ %Client{}, %{
        dashboard_only: dashboard_only,
        include_rsvp_info: include_rsvp_info
      }) do
    params = %{
      dashboardTeamsOnly: dashboard_only,
      includeRSVPInfo: include_rsvp_info,
      method: "User_GetTeamEvents"
    }

    body = RequestParameters.create(client, "GET", params)

    client |> get([], body) |> TeamCowboyResponse.process()
  end
end
