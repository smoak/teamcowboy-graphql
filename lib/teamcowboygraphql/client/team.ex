defmodule TeamCowboyGraphQL.Client.Team do
  import TeamCowboyGraphQL
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Data.Api.RequestParameters
  alias TeamCowboyGraphQL.Data.Api.TeamCowboyResponse

  @spec get_events(Client.t(), %{team_id: integer}) :: {:ok, list(map())} | {:error, binary}
  def get_events(client \\ %Client{}, %{team_id: team_id}) do
    params = %{
      teamId: team_id |> Integer.to_string(),
      method: "Team_GetEvents"
    }

    request_params = RequestParameters.create(client, "GET", params)

    client |> get([], request_params) |> TeamCowboyResponse.process()
  end

  @spec get(Client.t(), %{team_id: integer}) :: {:ok, map()} | {:error, binary}
  def get(client \\ %Client{}, %{team_id: team_id}) do
    params = %{
      teamId: team_id |> Integer.to_string(),
      method: "Team_Get"
    }

    request_params = RequestParameters.create(client, "GET", params)

    client |> get([], request_params) |> TeamCowboyResponse.process()
  end
end
