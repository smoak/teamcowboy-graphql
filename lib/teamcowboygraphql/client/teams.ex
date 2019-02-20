defmodule TeamCowboyGraphQL.Client.Teams do
  alias TeamCowboyGraphQL.Data.Api.ApiRequest
  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Teams

  def list(user_token, dashboard_only) do
    {:ok, teams} =
      ApiRequest.execute(user_token, "User_GetTeams", %{dashboardTeamsOnly: dashboard_only})

    teams |> Teams.normalize_user_teams()
  end
end
