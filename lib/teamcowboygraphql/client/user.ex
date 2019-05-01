defmodule TeamCowboyGraphQL.Client.User do
  import TeamCowboyGraphQL
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Data.Api.RequestParameters
  alias TeamCowboyGraphQL.Data.Api.TeamCowboyResponse

  @spec get_teams(Client.t(), %{dashboard_only: boolean}) :: list(map())
  def get_teams(client \\ %Client{}, %{dashboard_only: dashboard_only}) do
    params = %{
      dashboardTeamsOnly: dashboard_only
    }

    body = RequestParameters.create("GET", "User_GetTeams", params, client.auth)

    client |> get([], body) |> TeamCowboyResponse.process()
  end

  @spec get(Client.t()) :: map()
  def get(client \\ %Client{}) do
    body = RequestParameters.create("GET", "User_Get", %{}, client.auth)

    client |> get([], body) |> TeamCowboyResponse.process()
  end

  @spec get_team_events(Client.t(), %{dashboard_only: boolean}) :: list(map())
  def get_team_events(client \\ %Client{}, %{dashboard_only: dashboard_only}) do
    params = %{
      dashboardTeamsOnly: dashboard_only
    }

    body = RequestParameters.create("GET", "User_GetTeamEvents", params, client.auth)

    client |> get([], body) |> TeamCowboyResponse.process()
  end
end
