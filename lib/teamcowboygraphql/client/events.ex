defmodule TeamCowboyGraphQL.Client.Events do
  alias TeamCowboyGraphQL.Data.Api.ApiRequest
  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Events

  def list(user_token, team_id) do
    {:ok, events} = ApiRequest.execute(user_token, "Team_GetEvents", %{teamId: team_id})

    events |> Events.normalize_team_events()
  end
end
