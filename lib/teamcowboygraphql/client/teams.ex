defmodule TeamCowboyGraphQL.Client.Teams do
  alias TeamCowboyGraphQL.Data.Api.ApiRequest

  def list(user_token, dashboard_only) do
    {:ok, teams} =
      ApiRequest.execute(user_token, "User_GetTeams", %{dashboardTeamsOnly: dashboard_only})

    teams |> Enum.map(fn t -> 
      %{
        team_id: t |> Map.get("teamId"),
        name: t |> Map.get("name"),
        short_name: t |> Map.get("shortName")
      }
    end)
  end
end
