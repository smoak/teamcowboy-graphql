defmodule TeamCowboyGraphQL.Client.Team do
  import TeamCowboyGraphQL
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Data.Api.RequestSignature

  @spec get_events(Client.t(), %{team_id: integer}) :: list(map())
  def get_events(client \\ %Client{}, %{team_id: team_id}) do
    timestamp = :os.system_time(:second) |> Integer.to_string()
    nonce = :os.system_time(:nanosecond) |> Integer.to_string()

    params = %{
      method: "Team_GetEvents",
      api_key: client.api_key,
      teamId: team_id,
      userToken: client.auth,
      timestamp: timestamp,
      nonce: nonce
    }

    sig = RequestSignature.create("GET", "Team_GetEvents", params)
    request_params = params |> Map.merge(%{sig: sig})

    {200, data, _} = get(client, [], request_params)

    data |> Map.get("body")
  end
end
